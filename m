Return-Path: <netdev+bounces-283235-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QNO8L0fQ9GkYFQIAu9opvQ
	(envelope-from <netdev+bounces-283235-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 18:09:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2629B4ADF27
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 18:09:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C3CE5300276E
	for <lists+netdev@lfdr.de>; Fri,  1 May 2026 16:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3F943F54C4;
	Fri,  1 May 2026 16:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bppzZu+A"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA7F1FE471
	for <netdev@vger.kernel.org>; Fri,  1 May 2026 16:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777651761; cv=none; b=KqIljdrpIbXynjS7EQfFJ6tx0H0XsS5bVQ8jtueS4jZX9Axcw6r+CtXkm9a34EvLt52ZoVYt9Cc/rBHaJhhDSGFdkWtTeiLynUWB2YxpIt+JecoItDElWwtvp1py/7fqzw+m61W7iBU+4PhjyXf90aR5N9lw5L1oG1Bu+s3kbAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777651761; c=relaxed/simple;
	bh=H9vy1cQC/HXlqztXuZ9OEMMIXA5/uAtvI5lbbPAhQiI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sBEVG1/dsV2rU4sRFJeI3UGMeseVNbM5gIduWa+X+svG0ImcuR613oRQzZXnIrnKb1JTWI7Y0+7tfUFame8ZU2OaI3iByrBC6AWOLF31rX51i2z/zaBV5NYh+7Bzac7JiR41+yXtaorRTbu9r0htTGgg+ROuOVY50Y0bFZfrQ/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bppzZu+A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BA82C2BCB4;
	Fri,  1 May 2026 16:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777651757;
	bh=H9vy1cQC/HXlqztXuZ9OEMMIXA5/uAtvI5lbbPAhQiI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bppzZu+Ak1L388bnWMHsRyi0iyGLlinM4hLe4WPouxBNPlRTgyX4J9R57m2YeRXA6
	 F4vqBZI8Vxuqu+8Ukl9iDU9THq53ofGKNfSy3X/Zqa5rlM5ISqRSR8nIQ92xi3rbu0
	 AwxQeLgOmO6ZF51I4ardQ6lOASZZXTH8zzNsT+dwlVAeviuOY/bQNDiMko5KwNw7N9
	 3PiYbtYYuyRk7b0vFp/Xzeo0M17fZ8kZfgOpxR9sn1EtiDkGYO4+92BnVsCn+7k/ib
	 MtXflYbm6R7T5jCGjc8GnwSpTYCYdFdxhhb289BzDQIaVw6AoJdfAZ2kTCdUnVl7Ma
	 sztwadvzZinog==
From: Simon Horman <horms@kernel.org>
To: imv4bel@gmail.com
Cc: 'Simon Horman' <horms@kernel.org>,
	steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	ilant@mellanox.com,
	sowmini.varadhan@oracle.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH ipsec] esp: Force skb_cow_data() on RX when the skb is non-linear
Date: Fri,  1 May 2026 17:09:10 +0100
Message-ID: <20260501160910.234735-1-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <afLDKSvAvMwGh7Fy@v4bel>
References: <afLDKSvAvMwGh7Fy@v4bel>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2629B4ADF27
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283235-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url]

From: 'Simon Horman' <horms@kernel.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
esp: Force skb_cow_data() on RX when the skb is non-linear

This commit modifies esp_input() and esp6_input() to unconditionally call
skb_cow_data() for all non-linear skbs. This removes the fast path that
previously allowed in-place AEAD decryption for skbs carrying paged
fragments without a frag_list.

> diff --git a/net/ipv4/esp4.c b/net/ipv4/esp4.c
> index 6dfc0bcdef65..a6fbdec139dc 100644
> --- a/net/ipv4/esp4.c
> +++ b/net/ipv4/esp4.c
> @@ -868,17 +868,10 @@ static int esp_input(struct xfrm_state *x, struct sk_buff *skb)
>  		assoclen += seqhilen;
>  	}
>  
> -	if (!skb_cloned(skb)) {
> -		if (!skb_is_nonlinear(skb)) {
> -			nfrags = 1;
> -
> -			goto skip_cow;
> -		} else if (!skb_has_frag_list(skb)) {
> -			nfrags = skb_shinfo(skb)->nr_frags;
> -			nfrags++;
> +	if (!skb_cloned(skb) && !skb_is_nonlinear(skb)) {
> +		nfrags = 1;
>  
> -			goto skip_cow;
> -		}
> +		goto skip_cow;
>  	}

By removing this fast path and forcing all non-linear skbs to fall through
to skb_cow_data(), does this break the IPsec GRO/GSO fast path?

Looking at skb_cow_data() in net/core/skbuff.c:

int skb_cow_data(struct sk_buff *skb, int tailbits, struct sk_buff **trailer)
{
	...
	if ((skb_cloned(skb) || skb_shinfo(skb)->nr_frags) &&
	    !__pskb_pull_tail(skb, __skb_pagelen(skb)))
		return -ENOMEM;
	...

For a large GRO or GSO packet (which can be up to 64KB) with paged fragments,
this attempts to pull the entire paged payload into the linear data area
via __pskb_pull_tail().

Since this runs in the RX softirq path, pulling the entire payload requires
a high-order contiguous memory allocation using GFP_ATOMIC. 

Could this lead to widespread packet drops when memory is fragmented and
these high-order atomic allocations fail?

Additionally, even when the allocations succeed, does unconditionally copying
up to 64KB of data per packet introduce a severe performance regression by
entirely negating the software crypto fast path?

[ ... ]

