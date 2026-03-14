Return-Path: <netdev+bounces-267873-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id x7xJGkHmtWmu6gAAu9opvQ
	(envelope-from <netdev+bounces-267873-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 23:50:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A812028F627
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 23:50:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2780D3019BA1
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 22:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23AAA2BDC1B;
	Sat, 14 Mar 2026 22:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="1nFApjyX";
	dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="KY7pqByN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.uniroma2.it (smtp.uniroma2.it [160.80.4.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505E526AF4;
	Sat, 14 Mar 2026 22:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.80.4.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773528638; cv=none; b=G0oRyxdkmV/XkNbjpvGc/WDtOWBsqsjvwN05pjerVdnaE5Zqnt4BFbJYN4OFMMQsHm4kQFiVLWyK3AMtRKYjEnFjEbPS+MKWG0rIPHUg7E4/utEGxnPRnqwlUllSdD1uNvcK7pa3Cr8C8m54DGpEViBbskVMo5kz/Zvzp9BO5Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773528638; c=relaxed/simple;
	bh=6EyydFPsyH1ISmFBbWN/w/tsShrpyxuDQ7w2ztxMe7A=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ttoQPGfAjGq9APVNU0HgLsXNelL9BfHqfXCEBo78MCRAT4sZs0XjD7vsuDtDgIS50lNHgteNRNNlbvjgQ0Y3Wlp9P04rwI5buoR8s9iqz1OsBT1yqI5rbS0MHbq6SzmLJAjFb3UGedyM1v+m0uiUfT4QayK6evcK7/tKN8a3F/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it; spf=pass smtp.mailfrom=uniroma2.it; dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=1nFApjyX; dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=KY7pqByN; arc=none smtp.client-ip=160.80.4.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniroma2.it
Received: from smtpauth-2019-1.uniroma2.it (smtpauth-2019-1.uniroma2.it [160.80.5.46])
	by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 62EMnjsw007100;
	Sat, 14 Mar 2026 23:49:50 +0100
Received: from lubuntu-18.04 (unknown [160.80.103.126])
	by smtpauth-2019-1.uniroma2.it (Postfix) with ESMTPSA id DD35912092C;
	Sat, 14 Mar 2026 23:49:40 +0100 (CET)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=uniroma2.it;
	s=ed201904; t=1773528581; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T/2pdgsqG958Qca9XpmH2JKqIajppVZlp8GpPu96sYw=;
	b=1nFApjyXvqQFtFI0ikHBrW6Z88uCWAXgf21wdwNTNW+9hWU3322d8XnnFFV17B28e5p4SE
	ixjjn2g2ZqN8NLCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniroma2.it; s=rsa201904;
	t=1773528581; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T/2pdgsqG958Qca9XpmH2JKqIajppVZlp8GpPu96sYw=;
	b=KY7pqByNchj8dio90HIXIYU9VvlszXszzbbrJNWahaJvGhU8igi1BdJIc6PJlhJShVVq7A
	J+g3woDPSYHyo22dyqN91+8OWod8nbmFPQBtmDIzNqlnOOd7ikcrvFJlsWrsyFM1PlYMJq
	zFvPm+HGEUjFqFonfsPY3HWidnXmgBFPIlZLYAgQQ/vnrutsCgQz9JCV9v/TO8n7rCqJnR
	0ua5dWhJq+Q9xsPkmXrhNW+VQqD9tt+KfOQPyJ+MhjWd63mqfR78s83kIy97jRJyU4C8tR
	iEXQjOEioebbrLtCXFXn/jU69AlM+wEZlDrmi8WDWEnqTVvfNfKMfQYMclNCVQ==
Date: Sat, 14 Mar 2026 23:49:40 +0100
From: Andrea Mayer <andrea.mayer@uniroma2.it>
To: Minhong He <heminhong@kylinos.cn>
Cc: edumazet@google.com, davem@davemloft.net, david.lebrun@uclouvain.be,
        dsahern@kernel.org, horms@kernel.org, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com, stefano.salsano@uniroma2.it,
        Andrea Mayer <andrea.mayer@uniroma2.it>
Subject: Re: [PATCH net v2] ipv6: sr: Add NULL check for idev in
 seg6_hmac_validate_skb
Message-Id: <20260314234940.5dd74e5e508bc915eb0b4cb8@uniroma2.it>
In-Reply-To: <20260313022634.51885-1-heminhong@kylinos.cn>
References: <CANn89iLBN-fxUQ11Txtn73XQ6M9mrpaWEfjK=EfMU8UO1yOdBw@mail.gmail.com>
	<20260313022634.51885-1-heminhong@kylinos.cn>
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
	DMARC_POLICY_ALLOW(-0.50)[uniroma2.it,none];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[uniroma2.it:s=ed201904,uniroma2.it:s=rsa201904];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267873-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[uniroma2.it:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrea.mayer@uniroma2.it,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,uniroma2.it:dkim,uniroma2.it:mid,kylinos.cn:email]
X-Rspamd-Queue-Id: A812028F627
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 13 Mar 2026 10:26:34 +0800
Minhong He <heminhong@kylinos.cn> wrote:

> In seg6_hmac_validate_skb(), the pointer returned by __in6_dev_get()
> can be NULL if the network device lacks proper IPv6 initialization
> or is being torn down. Add a NULL check to avoid potential NULL pointer
> dereference in subsequent code.
> 
> Fixes: bf355b8d2c30 ("ipv6: sr: add core files for SR HMAC support")
> Signed-off-by: Minhong He <heminhong@kylinos.cn>
> ---
>  net/ipv6/seg6_hmac.c | 2 ++
>  1 file changed, 2 insertions(+)
> 

Hi Minhong,
Do you have a crash log or a way to reproduce this?

Thanks,
Andrea


> diff --git a/net/ipv6/seg6_hmac.c b/net/ipv6/seg6_hmac.c
> index ee6bac0160ac..e6964c6b0d38 100644
> --- a/net/ipv6/seg6_hmac.c
> +++ b/net/ipv6/seg6_hmac.c
> @@ -184,6 +184,8 @@ bool seg6_hmac_validate_skb(struct sk_buff *skb)
>  	int require_hmac;
>  
>  	idev = __in6_dev_get(skb->dev);
> +	if (!idev)
> +		return false;
>  
>  	srh = (struct ipv6_sr_hdr *)skb_transport_header(skb);
>  
> -- 
> 2.25.1
>

