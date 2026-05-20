Return-Path: <netdev+bounces-290111-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EFrKEa0yDmrj7wUAu9opvQ
	(envelope-from <netdev+bounces-290111-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 00:16:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ADB459BDBA
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 00:16:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B07283065E5B
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 21:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB710382367;
	Wed, 20 May 2026 21:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oATaWhoz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455EC3793B0
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 21:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779313114; cv=none; b=luPJ0jS/EfvRmCS/s9PiG6YHI3zGV0RcXQy3B5RYRy267q1R7kigdlOaEPoawVM3/uUGI93IFt3FnUI/uyBXd0N4GA9s0SYasSC5ZEQ/acEU/LZle5oB4CksGuc1hlLPYCto8xvQYOFxyGMhGS4InklL7pLIexRvWb8PgrbSDlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779313114; c=relaxed/simple;
	bh=m8Spt57/uFuz8wjsUieWfes589nQuJjHFzkyLWJK41E=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=lVukWRi0YST+SgVUq9s94NHP1QBaQwODOCm55BPd285CT/zrJA4KRvsJvNnai6PyUE5MmXRjeqPoS1Dfp95EaSq3y8pEGvlFuf1BHHxc2ZGULgpMi4UUrRmmLGFubPdJncK68nTM9KhOmLW8RfcFDESZtWpCK/aM2vuqeWqGjUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oATaWhoz; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-65c5361142fso5371764d50.0
        for <netdev@vger.kernel.org>; Wed, 20 May 2026 14:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779313112; x=1779917912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vEn5SJLrmk2tWKtgT2AI7BtGuIzpEIJPRNDHMeuM90o=;
        b=oATaWhozEzsE80/wrL6bLnANKLunnAib2l1jQEHFJlWqGDV3u6z1FRoaV4yYPub2xh
         eVfEwZp7hAVaKK78qysiX9aea+t//jLcHEQNnBqn2meVBdmNfHkuGsNrbFgb8f/dPave
         tvF29mkUTonhdrRKMyHQT4qOYhuZ2EzGAya8w94SPKcb5YFfYuCNZgT2PtPQQmtDmV3z
         +ULBVCZMHI1jpmc4JHB5G/sQP4K2NiZQYRo5euKyxTlxFDknuWs31iKmafCsevhS75dp
         INfbGXVN8/f0aKb0IQBizJBCxl0m3Tscl3nSeymhwhj6yUvL5XYgE/iY6/Hgp+BDFRs3
         9fqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779313112; x=1779917912;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vEn5SJLrmk2tWKtgT2AI7BtGuIzpEIJPRNDHMeuM90o=;
        b=Ef4SLFmnEsVYJoMteBa4E3MVj+5qQC8c+sJy/E6yngcT90TuX8sEV/VC3SDMZpQLGt
         KuDKCX0JRaOvK22xqlA5oeU370UoitZT9tBfkeSeg0R7faVrpsbej8RX+/k05lXblQ8D
         7bPL3eBpKOQSsRzdXuGn6Vxeww5RDbwQfoOShXEL06F2Et8k447R8U479j0gZIwfcW1K
         ihGCK5Xc7N25v0VGXoS6mfJKOnW32MI3hAf9cvfFhyj/AWd1TnLec9UNkCv9AugYA5DL
         SXACYoNNJVKXaVCq78OspLhscvsuN3LCshiCwfOM/b1I4Nx2e+24anUql6sf6FiB3u4P
         d3cA==
X-Forwarded-Encrypted: i=1; AFNElJ8Q8HdUhYCtkyV2QLogMNmzIWOc0hlSflQdbmAlUmdwfELW9AEa3JigRzCEEIe5pHe+mre9BSc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi1BEBCJumjylo5zApxQTOTvQ9IOnMpo4ubMVXm1+qWQobc1/r
	sBEbA9kbFiNBhQt8XXRVlhLW3pIem/Qc8ACLKKXsJroJryf6AhnlQuSo
X-Gm-Gg: Acq92OFcxNwzn+GxiIU7jqoevkgYVMGtfbNMazyVMg0Ki2iPZjgNN+zRBOkV3TaTZE9
	rv9XOPNZW7a1dsR17/219p8tH6Nhu6qS6tTzptDRiPnc+hionouT8ysFfubMOpCRqIx3tCVdErM
	gmkdRnYFver1QcE3alBaI3UITYt/KiY7PkpbLEsFSMk86bf7KeBkFq8jVdsycV2KQ8tWxPumHhq
	zpby5G39xP9awdxD6sFNL12ECbd56/YEbskvPWtz9WwK8WMOQuD8ujxRLvnG7Hip7UbZK9G1wB8
	5w7R4X+ce1nqe046T3crCzK9nxErkbWQtsoXxhHozLW5pYP7TO1XAfrnn0mbU0MfUItPGHwgBpz
	Rrqtg3Wc3+a5VdT35LQzC8cLqKVAT74XcIitoPQXNNp9gTY3oNLdNX62afo1D/i2IXJ86QQOgJS
	94x3phUTvVI0/4CtAaKqCSQRvlomglFnBvtdw6IUEhJKqku5wCaqbZJkCI1EJtiPbBfnUGaMMo6
	I9f
X-Received: by 2002:a05:690e:4082:b0:65e:412e:681b with SMTP id 956f58d0204a3-65e412e68a9mr19150907d50.55.1779313112336;
        Wed, 20 May 2026 14:38:32 -0700 (PDT)
Received: from gmail.com (172.235.85.34.bc.googleusercontent.com. [34.85.235.172])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65e0dbd1031sm9850856d50.20.2026.05.20.14.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 14:38:31 -0700 (PDT)
Date: Wed, 20 May 2026 17:38:31 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Sabrina Dubroca <sd@queasysnail.net>, 
 netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>, 
 Huzaifa Sidhpurwala <huzaifas@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Pavel Begunkov <asml.silence@gmail.com>
Message-ID: <willemdebruijn.kernel.8bb6e9bd9a42@gmail.com>
In-Reply-To: <c3b7f906bbfcbdfd7b4fa9d6c18a438870df85be.1779307748.git.sd@queasysnail.net>
References: <c3b7f906bbfcbdfd7b4fa9d6c18a438870df85be.1779307748.git.sd@queasysnail.net>
Subject: Re: [PATCH net v3] net: gro: don't merge zcopy skbs
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290111-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[queasysnail.net,redhat.com,davemloft.net,google.com,kernel.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 4ADB459BDBA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Sabrina Dubroca wrote:
> skb_gro_receive() can currently copy frags between the source and GRO
> skb, without checking the zerocopy status, and in particular the
> SKBFL_MANAGED_FRAG_REFS flag.
> 
> When SKBFL_MANAGED_FRAG_REFS is set, the skb doesn't hold a reference
> on the pages in shinfo->frags. Appending those frags to another skb's
> frags without fixing up the page refcount can lead to UAF.
> 
> When either the last skb in the GRO chain (the one we would append
> frags to) or the source skb is zerocopy, don't merge the skbs.
> 
> Fixes: 753f1ca4e1e5 ("net: introduce managed frags infrastructure")
> Reported-by: Huzaifa Sidhpurwala <huzaifas@redhat.com>
> Assisted-by: Claude:claude-mythos-preview
> Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
> ---
>  net/core/gro.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> Huzaifa has found this to be exploitable to overwrite the page cache
> 
> v3: maybe no stupid mistake this time. sorry again.
> v2: as Eric suggested, don't merge those skbs
>     https://lore.kernel.org/netdev/9f5afc14ea4ecd22c70d6eaf279a94d10fe29448.1779289597.git.sd@queasysnail.net/
> v1: https://lore.kernel.org/netdev/4d583fc5401298453d0a2f1b4719a15be30c8e49.1779194090.git.sd@queasysnail.net/
> 
> diff --git a/net/core/gro.c b/net/core/gro.c
> index 31d21de5b15a..bae89062a053 100644
> --- a/net/core/gro.c
> +++ b/net/core/gro.c
> @@ -109,6 +109,9 @@ int skb_gro_receive(struct sk_buff *p, struct sk_buff *skb)
>  	if (p->pp_recycle != skb->pp_recycle)
>  		return -ETOOMANYREFS;
>  
> +	if (skb_zcopy(p) || skb_zcopy(skb))
> +		return -ETOOMANYREFS;
> +

As Pavel pointed out in a previous version, MSG_ZEROCOPY skbs are not
looped onto the receive path. From that PoV it's fine to add this
check as it will not match them.

What is the path that leads to managed frag skbs in the receive path?
I can believe that it exists, e.g., a page pool. But since Pavel also
brought up this question and knows the managed frag use much better
than I do.

>  	if (unlikely(p->len + len >= netif_get_gro_max_size(p->dev, p) ||
>  		     NAPI_GRO_CB(skb)->flush))
>  		return -E2BIG;
> -- 
> 2.54.0
>

