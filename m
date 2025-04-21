Return-Path: <netdev+bounces-184389-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D08C8A952D6
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 16:32:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA66B18940D1
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 14:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C08F19AD90;
	Mon, 21 Apr 2025 14:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r/fHD/ct"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6041519B8;
	Mon, 21 Apr 2025 14:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745245970; cv=none; b=hQkuhsXJrk5pM/WIDKZk1rpxmqoK6g7E/IPXHKryr4/93n/uzF/rWUoNu3iRp8rOVGCmc4UjmsS3lgFpcpD/2rB+zYnCbPj0mdCguygSjsE4NXE72Ye9xf0IibNLlv7aieOc+skkFMcPCSphQtgXjhZvloUxNV4F940y8b2Pi0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745245970; c=relaxed/simple;
	bh=np3UkjIawcr9pyJaI8s3ldqbWJ63gVp/HiIhsW3WyeA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FiNL87ha9Vz3QNHHapRp634mcQdHOWLk07+AFjCpwfdRTq0jUIXQYxE7Y+zJbTwkB3yGHGoazrUo7Kxqg64xaqL+LhmT8nw34tTIHYd2A02PKAw0RXc+4SeoSOfDSshN7+FPA3TR975HYAlEBf93AixL6kTT1RiptFgQfuLyLcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r/fHD/ct; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2055FC4CEE4;
	Mon, 21 Apr 2025 14:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745245969;
	bh=np3UkjIawcr9pyJaI8s3ldqbWJ63gVp/HiIhsW3WyeA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r/fHD/ctZWuodJU3ZgdkPlnjSNmKoXOEwaAaSfkjs1RLDTqnyrxZlp8KXxhJosOY3
	 L91ZewpSnryMwc4Fhl3NdOMl7iJyrwZa/Yk+ojrqMT8syh15YGL0ZSw+k4kZiibMTc
	 J5MjZ4TAeBvYTJFAcA91aNEShSq+bXI+srbru2I1TE4Gw0f2gYGbAieFCplswXL9gp
	 JvnuvLTETXdczsHYJ5QixzNLHaETjBvuD1D4Rwyob7iPF3bW4S0MxMoNcIhb3c2iop
	 K1E9sb4HKZg/zW519d7Eae8Scbs9EdhtxAXS8hpXGWyI+FKbhFeCvphZb5do5RpQfP
	 fRwkR9NsUWCkw==
Date: Mon, 21 Apr 2025 15:32:46 +0100
From: Simon Horman <horms@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v1 3/4] net: selftest: add checksum mode support
 and SW checksum handling
Message-ID: <20250421143246.GK2789685@horms.kernel.org>
References: <20250416161439.2922994-1-o.rempel@pengutronix.de>
 <20250416161439.2922994-4-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250416161439.2922994-4-o.rempel@pengutronix.de>

On Wed, Apr 16, 2025 at 06:14:38PM +0200, Oleksij Rempel wrote:
> Introduce `enum net_test_checksum_mode` to support both CHECKSUM_COMPLETE
> and CHECKSUM_PARTIAL modes in selftest packet generation.
> 
> Add helpers to calculate and apply software checksums for TCP/UDP in
> CHECKSUM_COMPLETE mode, and refactor checksum handling into a dedicated
> function `net_test_set_checksum()`.
> 
> Update PHY loopback tests to use CHECKSUM_COMPLETE by default to avoid
> hardware offload dependencies and improve reliability.
> 
> Also rename loopback test names to clarify checksum type and transport.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Unfortunately this patch does not apply against net-next
(or at any rate, the series did not at the time it was submitted).
Please rebase and repost.

> ---
>  net/core/selftests.c | 218 ++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 206 insertions(+), 12 deletions(-)
> 
> diff --git a/net/core/selftests.c b/net/core/selftests.c

...

> +/**
> + * net_test_setup_sw_csum - Compute and apply software checksum
> + *                          (CHECKSUM_COMPLETE)
> + * @skb: Socket buffer with transport header set
> + * @iph: Pointer to IPv4 header inside skb
> + *
> + * This function computes and fills the transport layer checksum (TCP or UDP),
> + * and sets skb->ip_summed = CHECKSUM_COMPLETE.
> + *
> + * Returns 0 on success, or negative error code on failure.
> + */
> +static int net_test_setup_sw_csum(struct sk_buff *skb,
> +				  struct iphdr *iph)
> +{
> +	int transport_offset = skb_transport_offset(skb);
> +	int transport_len = skb->len - transport_offset;
> +	__be16 final_csum;
> +	__wsum csum;
> +
> +	switch (iph->protocol) {
> +	case IPPROTO_TCP:
> +		if (!pskb_may_pull(skb,
> +				   transport_offset + sizeof(struct tcphdr)))
> +			return -EFAULT;
> +
> +		tcp_hdr(skb)->check = 0;
> +		break;
> +	case IPPROTO_UDP:
> +		if (!pskb_may_pull(skb,
> +				   transport_offset + sizeof(struct udphdr)))
> +			return -EFAULT;
> +
> +		udp_hdr(skb)->check = 0;
> +		break;
> +	default:
> +		pr_err("net_selftest: unsupported proto for sw csum: %u\n",
> +		       iph->protocol);
> +		return -EINVAL;
> +	}
> +
> +	csum = skb_checksum(skb, transport_offset, transport_len, 0);
> +	final_csum = csum_tcpudp_magic(iph->saddr, iph->daddr, transport_len,
> +				       iph->protocol, csum);

Sparse is unhappy about integer type annotations around here.
The 'final_csum =' line above is line number 101.

  .../selftests.c:101:20: warning: incorrect type in assignment (different base types)
  .../selftests.c:101:20:    expected restricted __be16 [usertype] final_csum
  .../selftests.c:101:20:    got restricted __sum16
  .../selftests.c:105:28: warning: incorrect type in assignment (different base types)
  .../selftests.c:105:28:    expected restricted __be16 [usertype] final_csum
  .../selftests.c:105:28:    got restricted __sum16 [usertype]
  .../selftests.c:108:37: warning: incorrect type in assignment (different base types)
  .../selftests.c:108:37:    expected restricted __sum16 [usertype] check
  .../selftests.c:108:37:    got restricted __be16 [usertype] final_csum
  .../selftests.c:110:37: warning: incorrect type in assignment (different base types)
  .../selftests.c:110:37:    expected restricted __sum16 [usertype] check
  .../selftests.c:110:37:    got restricted __be16 [usertype] final_csum

> +
> +	if (iph->protocol == IPPROTO_UDP && final_csum == 0)
> +		final_csum = CSUM_MANGLED_0;
> +
> +	if (iph->protocol == IPPROTO_TCP)
> +		tcp_hdr(skb)->check = final_csum;
> +	else
> +		udp_hdr(skb)->check = final_csum;
> +
> +	skb->ip_summed = CHECKSUM_COMPLETE;
> +
> +	return 0;
> +}

...

-- 
pw-bot: changes-requested

