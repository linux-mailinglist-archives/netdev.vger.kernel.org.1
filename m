Return-Path: <netdev+bounces-250761-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 54056D391E8
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 01:36:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ABF8D301C3C6
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 00:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A84514EC73;
	Sun, 18 Jan 2026 00:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r3Y/Tl6G"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68449139D
	for <netdev@vger.kernel.org>; Sun, 18 Jan 2026 00:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768696573; cv=none; b=OuoJcv8UxDh5pkBlJcyv1+XY6o7VpQ1hr0EKqdOHqmo9rGPgEzuKs0KLX2Dj4uU8IJhtVsH+DSuqTBaWPCTrOs8SPX70aNN6cmLRY+D7JYkJPOfImdJtQvEtaNRBROZocMSx+gKDcYy5g9teCxmVc7KpcjiUaxsFeNAvqUcwVHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768696573; c=relaxed/simple;
	bh=CLKu3m8z6aOLWWATQV2G8cWhZRi4EFBc+t6pPrrgSSw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VrZTn0QEDNVCkBreZZFu6F2KncTo/FcnmTv17z11WNicwxhcD5ZlVb1wnwJucZohct+WkUVHGFKiyQTAqVhKK5iagJ9uN3xwQYfVvHB9E6imnEIE9TicdwNRf3eD0tsRiu8gxUrs8oEwyShYarfKHOgYGvFKfxOmG014dnS82Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r3Y/Tl6G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1319C4CEF7;
	Sun, 18 Jan 2026 00:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768696573;
	bh=CLKu3m8z6aOLWWATQV2G8cWhZRi4EFBc+t6pPrrgSSw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r3Y/Tl6G1BgCrTFIK/GTqbGOpJi5fAQZeTpvxLr1lkJspQKv3QKNzIXxxivh68IxP
	 LogzOk0YADcxP3xGsoNsQaIK0bzpCXz0xF868EoxrTp3CFY9oKFgtccfR3ZPh+OQ0V
	 d9FP7mpoYJaCtL/F89NNJqjL24DmjpfapIfKprmfXD5aPvxqcuwZLPEmnhTIXrVseH
	 QbJtUYE9n8Ak4E6eg8i0VNzkbpNDyeimCYEwbgeMUXACTjEwuPyosKdzPCvdkdY1pN
	 Dby+2y/zCUt507Sz3f/1iyV2m+n8KtGVzPoTQxQ3EjOef+eyUCf0JwQ7QIR8047PEI
	 Q4ICwKK1aHVmw==
From: Jakub Kicinski <kuba@kernel.org>
To: mmietus97@yahoo.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	sd@queasysnail.net,
	Jason@zx2c4.com
Subject: Re: [net-next,v5,09/11] net: sctp: convert sctp_v{4,6}_xmit to use a noref dst when possible
Date: Sat, 17 Jan 2026 16:36:11 -0800
Message-ID: <20260118003611.1042386-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260113163614.6212-1-mmietus97@yahoo.com>
References: <20260113163614.6212-1-mmietus97@yahoo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: sctp: convert sctp_v{4,6}_xmit to use a noref dst when possible

This patch removes the dst_clone() at function entry and dst_release() in
the encap path, aiming to reduce refcount overhead when sending SCTP packets
via UDP encapsulation. The non-encap path now clones dst inside skb_dst_set.

> diff --git a/net/sctp/ipv6.c b/net/sctp/ipv6.c
> index 38fd1cf3148f..8c28441009fa 100644
> --- a/net/sctp/ipv6.c
> +++ b/net/sctp/ipv6.c

[ ... ]

> @@ -264,7 +264,6 @@ static int sctp_v6_xmit(struct sk_buff *skb, struct sctp_transport *t)
>  	udp_tunnel6_xmit_skb(dst, sk, skb, NULL, &fl6->saddr, &fl6->daddr,
>  			     tclass, ip6_dst_hoplimit(dst), label,
>  			     sctp_sk(sk)->udp_port, t->encap_port, false, 0);
> -	dst_release(dst);
>  	return 0;
>  }

The encap path passes dst to udp_tunnel6_xmit_skb() which internally calls
skb_dst_set_noref(). This function has:

    WARN_ON(!rcu_read_lock_held() && !rcu_read_lock_bh_held());

Looking at the callers, sctp_outq_flush_transports() does:

    rcu_read_unlock();
    error = sctp_packet_transmit(packet, ctx->gfp);

The RCU read lock is explicitly dropped before calling into the transmit
path. Will this trigger the WARN_ON in skb_dst_set_noref() for every
SCTP-over-UDP packet?

> diff --git a/net/sctp/protocol.c b/net/sctp/protocol.c
> index ff18ed0a65ff..8a00bb0a8ae5 100644

[ ... ]

> @@ -1074,7 +1074,6 @@ static inline int sctp_v4_xmit(struct sk_buff *skb, struct sctp_transport *t)
>  			    fl4->daddr, dscp, ip4_dst_hoplimit(dst), df,
>  			    sctp_sk(sk)->udp_port, t->encap_port, false, false,
>  			    0);
> -	dst_release(dst);
>  	return 0;
>  }

Same question for the IPv4 path - udp_tunnel_xmit_skb() calls iptunnel_xmit()
which also uses skb_dst_set_noref(). Without RCU read lock held by the caller,
does this path also trigger the WARN_ON?

