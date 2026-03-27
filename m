Return-Path: <netdev+bounces-272446-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oL5LADpDxmmgIAUAu9opvQ
	(envelope-from <netdev+bounces-272446-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 09:43:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 689AB3412D8
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 09:43:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 957DE301A288
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 08:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E49CA34BA42;
	Fri, 27 Mar 2026 08:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b="knLLKjgb"
X-Original-To: netdev@vger.kernel.org
Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456D03D0924;
	Fri, 27 Mar 2026 08:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.37.255.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774600573; cv=none; b=RrAc5l49MHucobpiBtKS0FiYM4JXfImqzqzahPxNN6GzTNHe07nQ9I+Ar6wqTqyQNlW4Rxgp1llQVCqF2tTfrZB1qSNcb7UpvjecJfYnAYETOHBXTMOScQefvNnMZIBZfd94cn9YBo2MZmu6/pCpzDuABUlN28VH5gIedUXGpME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774600573; c=relaxed/simple;
	bh=2KWjZ/2iGjbmuz/g4gBSiBOHXeHByW4AdB4snk19mgI=;
	h=MIME-Version:Content-Type:Date:From:To:Cc:Subject:In-Reply-To:
	 References:Message-ID; b=GSJd2nTS/BLISbev+buJ4ADRhLSG99whsnRrkAbdgtg6v8G+J7soyI3UjN6bQ4o48vT6shD/nJoEKUmxNrHDGrod2av8hp35mxTSAzkQ6xJ0JL2sf3gOXWCXMV/m7v04f3wR2Tbqwk7AMMFthQueaNmRDzH+vQHsD/HSTO9wMpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b=knLLKjgb; arc=none smtp.client-ip=194.37.255.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Received: from [194.37.255.9] (helo=mxout.expurgate.net)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=6560504b2e=ms@dev.tdt.de>)
	id 1w62fi-00Cro2-Jt; Fri, 27 Mar 2026 09:36:02 +0100
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ms@dev.tdt.de>)
	id 1w62fh-00GVvM-Kn; Fri, 27 Mar 2026 09:36:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dev.tdt.de;
	s=z1-selector1; t=1774600561;
	bh=aGMbQa8+Oe2AlyUT09xJbB5ceL0DEpkVThvDJdWD/Jc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=knLLKjgbB8tX3GN0UXW3EV5oOu7u3Wv67trY/Du+3m5VC8szkkZjcRuXomlLQKs+I
	 T1OIopXc0r8i2nK62mKD0kZ+SYXy+D0iP3cxl71jtcMpjdRZ1xkw+1ftaY+wllBp/0
	 A1iPUQI0zuc5KHMAzCtWNA8i7ngiNdGD5ESiBbGvvtY32ggGaCHYiiVWWm0Py/jeNA
	 FW+zlagF8UHkxnPl666tUfBCACFjFPwKjnoBkV3zUW+fda+ly/QwmBX+v2E8Y5U4x7
	 PZrzV4eeHTAxJtDQJjXGE7VMHwQoeQsMigiWPcUEO8RGcq6GT84ctqDYI/3AssBCvZ
	 fPZxTjyyNjsCQ==
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id 10C4E240040;
	Fri, 27 Mar 2026 09:36:01 +0100 (CET)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id 08FD0240036;
	Fri, 27 Mar 2026 09:36:01 +0100 (CET)
Received: from mail.dev.tdt.de (localhost [IPv6:::1])
	by mail.dev.tdt.de (Postfix) with ESMTP id ADB2023B24;
	Fri, 27 Mar 2026 09:36:00 +0100 (CET)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Fri, 27 Mar 2026 09:36:00 +0100
From: Martin Schiller <ms@dev.tdt.de>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Yiming Qian <yimingqian591@gmail.com>, linux-x25@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	security@kernel.org
Subject: Re: [PATCH net] net/x25: Fix overflow when accumulating packets
Organization: TDT AG
In-Reply-To: <20260327-x25_fraglen-v1-1-9fc751d4f754@dev.tdt.de>
References: <20260327-x25_fraglen-v1-1-9fc751d4f754@dev.tdt.de>
Message-ID: <b2099069e5dce49a0bc068a8d318f3a2@dev.tdt.de>
X-Sender: ms@dev.tdt.de
User-Agent: Roundcube Webmail/1.3.17
X-purgate-type: clean
X-purgate-ID: 151534::1774600562-43474BD0-942CBC77/0/0
X-purgate: clean
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[tdt.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[dev.tdt.de:s=z1-selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,kernel.org];
	TAGGED_FROM(0.00)[bounces-272446-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[dev.tdt.de:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,tdt.de:email,dev.tdt.de:dkim,dev.tdt.de:mid];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ms@dev.tdt.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 689AB3412D8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-03-27 09:30, Martin Schiller wrote:
> Add a check to ensure that `x25_sock.fraglen` does not overflow.
> 
> The `fraglen` also needs to be resetted when purging `fragment_queue` 
> in
> `x25_clear_queues()`.
> 
> Reported-by: Yiming Qian <yimingqian591@gmail.com>
> Signed-off-by: Martin Schiller <ms@dev.tdt.de>
> ---
>  net/x25/x25_in.c   | 6 ++++++
>  net/x25/x25_subr.c | 1 +
>  2 files changed, 7 insertions(+)
> 
> diff --git a/net/x25/x25_in.c b/net/x25/x25_in.c
> index
> b981a4828d08c2e6676749a06035910eab01e6cd..1603238d6fff73090ef10b5fd11387b3e7f017a2
> 100644
> --- a/net/x25/x25_in.c
> +++ b/net/x25/x25_in.c
> @@ -34,6 +34,12 @@ static int x25_queue_rx_frame(struct sock *sk,
> struct sk_buff *skb, int more)
>  	struct sk_buff *skbo, *skbn = skb;
>  	struct x25_sock *x25 = x25_sk(sk);
> 
> +	/* make sure we don't overflow */
> +	if (x25->fraglen + skb->len > sizeof(x25->fraglen)) {

Please ignore this patch. I'll send a V2 without that
"sizeof()" nonsense in a moment.

> +		kfree_skb(skb);
> +		return 1;
> +	}
> +
>  	if (more) {
>  		x25->fraglen += skb->len;
>  		skb_queue_tail(&x25->fragment_queue, skb);
> diff --git a/net/x25/x25_subr.c b/net/x25/x25_subr.c
> index
> 0285aaa1e93c17233748d38eef6d8b5c6059b67a..159708d9ad20cb2e6db24ead67daf1e9d6258f64
> 100644
> --- a/net/x25/x25_subr.c
> +++ b/net/x25/x25_subr.c
> @@ -40,6 +40,7 @@ void x25_clear_queues(struct sock *sk)
>  	skb_queue_purge(&x25->interrupt_in_queue);
>  	skb_queue_purge(&x25->interrupt_out_queue);
>  	skb_queue_purge(&x25->fragment_queue);
> +	x25->fraglen = 0;
>  }
> 
> 
> 
> ---
> base-commit: 4ae97cae07e15d41e5c0ebabba64c6eefdeb0bbe
> change-id: 20260325-x25_fraglen-8fc240d1edd3
> 
> Best regards,

