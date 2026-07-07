Return-Path: <netdev+bounces-305574-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ExkjM6tOTWouyAEAu9opvQ
	(envelope-from <netdev+bounces-305574-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 21:08:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B06F71EEBD
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 21:08:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b=VWrd41qR;
	dmarc=pass (policy=none) header.from=lunn.ch;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305574-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-305574-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6530F3033D07
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 19:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC0E33A3812;
	Tue,  7 Jul 2026 19:04:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA742F12A5;
	Tue,  7 Jul 2026 19:04:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783451052; cv=none; b=Av2hn8XpY0AWvz3sXYz4K+2f6dhlXgqkY6NMgM2IfjoMayUHK0mBJp6h89QXExhzH0skf0TKXDQkwEQ1qIilX6Gsc6mQ1arj0/CwKyi2niXj0gwMVeHUTbp3TCxHkVUKooXBOHbiBuLKZzMSDPlTrNdmzB309aWf3EOUhE0DpHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783451052; c=relaxed/simple;
	bh=6bbEwg9cHivlDdMKiwEt9gzMXBhcZhTNsBXne4l4+lI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h/GKh3I9uCbQ8nGMbPx9ygYE168sWBk9SXwOBzpsX5vj4kLHjAlyxw6Mi3MAdjkzpDV9owfj79561gsTYAmFzTiznaScc3NUGHDIurWnBXcD/t0TTpuhPjhmpbArHzbbHFTCexfqgs2ortr9W/LGpU5CPhvyRvXy+ClF6IMBBFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=VWrd41qR; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=avVeJSV3sTgrfABYepnBzlTH2P7OWGaspJVsPup+ruw=; b=VWrd41qRXyYyhzMWp+gqpuvhbS
	6B85dG3uLp6arQ3/pkhJsCYGOR87TGtYdSF/I8ogvfumgVQ+vAm6bt5SSlqyIbW5lG6tfBBjIVX5y
	UOGorZW+Dpd8xlk1kNS3h4bBcNBO9GNoOUkvUW+Rvcix7+8IviZrKFkh3/um8eIUf8sc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1whB5M-00BDMh-PC; Tue, 07 Jul 2026 21:04:00 +0200
Date: Tue, 7 Jul 2026 21:04:00 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jakub Raczynski <j.raczynski@samsung.com>
Cc: netdev@vger.kernel.org, k.tegowski@samsung.com,
	k.domagalski@samsung.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 2/2] net/stmmac: Verify provided DTS AXI setup
Message-ID: <ee504cab-b1da-4584-8693-70ed5cd943c7@lunn.ch>
References: <20260707174431.1264520-1-j.raczynski@samsung.com>
 <CGME20260707174439eucas1p153ea592df5c1c7a50e947022a80a1056@eucas1p1.samsung.com>
 <20260707174431.1264520-3-j.raczynski@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260707174431.1264520-3-j.raczynski@samsung.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-305574-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_RECIPIENTS(0.00)[m:j.raczynski@samsung.com,m:netdev@vger.kernel.org,m:k.tegowski@samsung.com,m:k.domagalski@samsung.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:mcoquelin.stm32@gmail.com,m:alexandre.torgue@foss.st.com,m:linux-stm32@st-md-mailman.stormreply.com,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,m:mcoquelinstm32@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,samsung.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,st-md-mailman.stormreply.com,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,lunn.ch:from_mime,lunn.ch:dkim,lunn.ch:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2B06F71EEBD

On Tue, Jul 07, 2026 at 07:44:31PM +0200, Jakub Raczynski wrote:
> During parsing of AXI setup, there are few issues:
> - 'axi_blen' array is uninitialized value on stack without zero-init stack
>   configured. This can result in random AXI burst length config if
>   DTS config provides shorter array than AXI_BLEN.

What does the DT blinding say about the length? Is it allowed to be
short?

Are we talking about:

      snps,blen:
        $ref: /schemas/types.yaml#/definitions/uint32-array
        description:
          this is a vector of supported burst length.
        minItems: 7
        maxItems: 7

So it should be 7. Are there any in kernel DT blobs which don't pass
7? Can we just error out when it is not 7?

> - In case of failed memory allocation for AXI and error, there is no handling
>   of that. Fix it by checking if AXI config is error and return if so,
>   as this can only lack of memory. No AXI config, although is probably
>   wrong in most cases, is not treated as error, as generic config is mostly
>   provided in drivers.

This seems like a different fix. Maybe put it into a patch of its own.

> Fixes: afea03656add ("stmmac: rework DMA bus setting and introduce new platform AXI structure")

Again, does this bother anybody? At least axi_blen issue seems to be
that the DT blob is broken, so i doubt it actually does. Are there
reports of memory allocation error and resulting Opps.


    Andrew

---
pw-bot: cr

