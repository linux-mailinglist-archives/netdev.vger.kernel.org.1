Return-Path: <netdev+bounces-276764-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cMenAmj71mkPKggAu9opvQ
	(envelope-from <netdev+bounces-276764-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 03:05:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A00903C5275
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 03:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 96B75301227E
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 01:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF7A245005;
	Thu,  9 Apr 2026 01:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="vDhhOoRJ";
	dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="SvlkauuV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.uniroma2.it (smtp.uniroma2.it [160.80.4.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1010C244684;
	Thu,  9 Apr 2026 01:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.80.4.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775696733; cv=none; b=mdqlb4XNhIZUCa9AAaDT/uOeNE/178z4v+VqnOF5FP7eh9RTYVPsSlhKDk6bYstd2HDnsDnpKEcBVFg1gzYz1u7vYX9YLySR21FDfrT1oxWePagN0Yx72gcK3HCKmeV/YH/MWtp7bJZm87i+5wYv5kHrwslgU0IxzpHQE6/AUZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775696733; c=relaxed/simple;
	bh=k1e80WLEIMZeQALBTIpzpMPH/HfGFZJ7DL8pjX+ONdE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=XGcygNBuWSoXOVweToqpHOw55NGV82pQP/E1QH/Rn9lJkFgXsB8NLgOHolKHw8vCPFFb7kym8XUZVwf8IMT/iA8TrVo82Ad3xdUXN14hXP2ESo3UFcv6aJbOxP/rXh7fljGD40Wi/UFTNrXjs9/vzba6H1PCYYY5NK173BAy5lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it; spf=pass smtp.mailfrom=uniroma2.it; dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=vDhhOoRJ; dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=SvlkauuV; arc=none smtp.client-ip=160.80.4.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniroma2.it
Received: from smtpauth-2019-1.uniroma2.it (smtpauth-2019-1.uniroma2.it [160.80.5.46])
	by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 6391534o028424;
	Thu, 9 Apr 2026 03:05:09 +0200
Received: from lubuntu-18.04 (unknown [160.80.103.126])
	by smtpauth-2019-1.uniroma2.it (Postfix) with ESMTPSA id 639121228CC;
	Thu,  9 Apr 2026 03:04:58 +0200 (CEST)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=uniroma2.it;
	s=ed201904; t=1775696699; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QmHCsqc7WegKUOgUHHPM9TqWAh8MTHZ2YLN5cXh+lwE=;
	b=vDhhOoRJZn9dDUj8GdadWCYlz8rNbR376DyrWnbM6iW8S8/s2HA8xDhPBauChAwjpMzoja
	Fn8gyRecwZu+6hBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniroma2.it; s=rsa201904;
	t=1775696699; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QmHCsqc7WegKUOgUHHPM9TqWAh8MTHZ2YLN5cXh+lwE=;
	b=SvlkauuVYE//Yd/gAp51jA+lQpN9S6h+0Sst0z4fvvM5SXhJ2AHmYICMQ3SvCsGVWWiLch
	2hfAcXZW88ccaJYTkQTuNgppJ9gKdJZpVnu8Eh7KZkS8F98YLnhYXDcpx6FgXYl3rt5d3V
	MAGZI1cSK1owbx4bfGEQPXC39vWpKjhPfqqQLndNX/XeS3DUYhNEMlqRxhXb8v35C34Ib7
	rbBp4CQ2oZ3i5RRC8ZxFUYZ/P6FE1gh0oTojFWLC8HmDtLpMkQ0bWQPXvL1mk8GWyaT2Kx
	+PyqxQ/CyAgtpDoAymlmD7pLps4cY3xxdlZCq1B+oTqsrR9fsusUmdQ8f9daFQ==
Date: Thu, 9 Apr 2026 03:04:57 +0200
From: Andrea Mayer <andrea.mayer@uniroma2.it>
To: Mark Brown <broonie@kernel.org>, Matthieu Baerts <matttbe@kernel.org>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Networking <netdev@vger.kernel.org>,
        Justin Iurman <justin.iurman@6wind.com>,
        Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List
 <linux-next@vger.kernel.org>,
        Andrea Mayer <andrea.mayer@uniroma2.it>
Subject: Re: linux-next: manual merge of the net-next tree with the
 netfilter tree
Message-Id: <20260409030457.a37c01254eb615b9b410e183@uniroma2.it>
In-Reply-To: <d9d4e328-6668-4c24-bace-77a0f93bbed6@sirena.org.uk>
References: <adZhwtOYfo-0ImSa@sirena.org.uk>
	<729b748b-e00b-475e-81e0-a666eab24fc6@sirena.org.uk>
	<8d216893-1e0b-4e3c-8609-eb3de5da02cf@kernel.org>
	<d9d4e328-6668-4c24-bace-77a0f93bbed6@sirena.org.uk>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.100.0 at smtp-2015
X-Virus-Status: Clean
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[uniroma2.it,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[uniroma2.it:s=ed201904,uniroma2.it:s=rsa201904];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[uniroma2.it:+];
	TAGGED_FROM(0.00)[bounces-276764-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_ALL(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrea.mayer@uniroma2.it,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A00903C5275
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 8 Apr 2026 18:00:50 +0100
Mark Brown <broonie@kernel.org> wrote:

> On Wed, Apr 08, 2026 at 06:43:36PM +0200, Matthieu Baerts wrote:
> > On 08/04/2026 17:08, Mark Brown wrote:
> 
> > > This also needs a fixup for a new jump to the error handling paths that
> > > was added in seg6_build_state().
> 
> > I also had this other conflict there, and I did this when resolving it
> > in MPTCP tree:
> 
> >  +	if (tb[SEG6_IPTUNNEL_SRC]) {
> >  +		slwt->tunsrc = nla_get_in6_addr(tb[SEG6_IPTUNNEL_SRC]);
> >  +
> >  +		if (ipv6_addr_any(&slwt->tunsrc) ||
> >  +		    ipv6_addr_is_multicast(&slwt->tunsrc) ||
> >  +		    ipv6_addr_loopback(&slwt->tunsrc)) {
> >  +			NL_SET_ERR_MSG(extack, "invalid tunsrc address");
> >  +			err = -EINVAL;
> > - 			goto free_dst_cache;
> > ++			goto err_destroy_output;
> >  +		}
> >  +	}
> >  +
> 
> Yes, that's the additional fixup I mentioned above - it didn't conflict
> for me (well, the exit path did).

Thanks Mark and Matthieu for taking care of this.

I went through both commits and the rerere.
The resolution looks correct from the seg6 side. Build-tested.

Happy to help if anything else comes up.

Cheers,
Andrea

