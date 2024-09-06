Return-Path: <netdev+bounces-126048-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6ED96FC26
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 21:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7E2BB233D0
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 19:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70DE11B85F0;
	Fri,  6 Sep 2024 19:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qy2A6ah3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CCB61B85C3
	for <netdev@vger.kernel.org>; Fri,  6 Sep 2024 19:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725650970; cv=none; b=fZ3zY6L0L6ftXKP91eQkrNySL3JoJzsMhYoswXOxGNKYQsthdct0ymN/s3pW4ZVQk9N84ZWmzEwdhMxQZKX6TpNiCxNlzdKfMD133JYEtVnGfWXehHr1f/BGuSj6iWMu3YAcyT0OLiyszkm6lDbJouwYC6Ss8MWCEOr6DIrk75o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725650970; c=relaxed/simple;
	bh=uu5xLNN6xCXFbUVLHE/6qtTGXX+JRZeFM5j3Iap9m7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jeimYHI6H2tWPlhwFcHUmGfCirscQ8dxCZu6TM8SHdSd9Xda2h0IIj3wCMFAQ4Xwe1gfrjcSAlJoFuPUTIpbL4BeFU87I3ZY1cra/0x6PznK9jB1zJWZ9qhTFVlTJH7kyvws1p+0e30AdRVK7ESPs/6JKhAOkFL7ZNmpuz2VDIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qy2A6ah3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18F17C4CEC4;
	Fri,  6 Sep 2024 19:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725650969;
	bh=uu5xLNN6xCXFbUVLHE/6qtTGXX+JRZeFM5j3Iap9m7w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qy2A6ah3luAe9K3JbprgRADXJzNNu7nEFgQXnIwqDQgp/zSS8ZE3ciSoNlyv2UC7M
	 JF8jKejvG/8yK9TXAgwqbQb9gMZccqBrFnYvV+/KZeNHzQ4Vh5d2ljTitVMDVptXYo
	 yXMyOL4rUOgjfTsf4SOn82hyb3kRZ7Sf3JtdScW4LimEAaUPYKwaWzfJNJNntLygqT
	 6ghz6IQDoMZKFrj2LK3Kk+2Ks3aaKdSIxsqhBqMOrnVRog2nlo3vcttJjsG7ZAthRH
	 suRqwb95468TnC/6j/89VlG7fRrOS8PpDUtaaG9UUPD5Dvs/+iwUtVwW/YZDVE2CD0
	 NrbKlBMhKnlRg==
Date: Fri, 6 Sep 2024 20:29:26 +0100
From: Simon Horman <horms@kernel.org>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
	ryazanov.s.a@gmail.com, edumazet@google.com, andrew@lunn.ch,
	sd@queasysnail.net
Subject: Re: [PATCH net-next v6 12/25] ovpn: implement packet processing
Message-ID: <20240906192926.GO2097826@kernel.org>
References: <20240827120805.13681-1-antonio@openvpn.net>
 <20240827120805.13681-13-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827120805.13681-13-antonio@openvpn.net>

On Tue, Aug 27, 2024 at 02:07:52PM +0200, Antonio Quartulli wrote:
> This change implements encryption/decryption and
> encapsulation/decapsulation of OpenVPN packets.
> 
> Support for generic crypto state is added along with
> a wrapper for the AEAD crypto kernel API.
> 
> Signed-off-by: Antonio Quartulli <antonio@openvpn.net>

...

> diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c

...

> @@ -54,39 +56,122 @@ static void ovpn_netdev_write(struct ovpn_peer *peer, struct sk_buff *skb)
>  		dev_sw_netstats_rx_add(peer->ovpn->dev, skb->len);
>  }
>  
> -static void ovpn_decrypt_post(struct sk_buff *skb, int ret)
> +void ovpn_decrypt_post(struct sk_buff *skb, int ret)
>  {
> -	struct ovpn_peer *peer = ovpn_skb_cb(skb)->peer;
> +	struct ovpn_crypto_key_slot *ks = ovpn_skb_cb(skb)->ctx->ks;
> +	struct ovpn_peer *peer = ovpn_skb_cb(skb)->ctx->peer;
> +	__be16 proto;
> +	__be32 *pid;
>  
> -	if (unlikely(ret < 0))
> +	/* crypto is happening asyncronously. this function will be called

nit: asynchronously

     Flagged by checkpatch.pl --codespell

> +	 * again later by the crypto callback with a proper return code
> +	 */
> +	if (unlikely(ret == -EINPROGRESS))
> +		return;

...

