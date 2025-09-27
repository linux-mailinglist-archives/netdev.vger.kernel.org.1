Return-Path: <netdev+bounces-226928-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC5FBA6375
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 22:56:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFF82189D715
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 20:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA68231A30;
	Sat, 27 Sep 2025 20:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DRZgM9jU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7735E35950
	for <netdev@vger.kernel.org>; Sat, 27 Sep 2025 20:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759006556; cv=none; b=R0sJ+6brUlc/S/IqjrY23JAxCdZPp8w9Mp6UrXEmtpI078Qg65k/zslKw5LZt9IN0Uajlb2iRc3Zzf1+WInCqOV4AADoYLFgDi7g8HYT8bKRo4UDd3/Xs9OZmzROm9aij8wkoCcLvJMHIrmwvjK4Rk+dDWeJzREBPJISriW+/wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759006556; c=relaxed/simple;
	bh=WhvCEHR71JlepeZAgEOKFLslIS3HckCTEyON7ene1Vw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MopGDdHxC6SddZh6di9T+MGxkfElG8mpyqvBh+mnJp/2ufRUCx1z68bDfsAeKVDKyC5bNNHWm7SjD2Y9hOkvUuzUV/LbXX2IPyQYOjKjGVPS+jGlcOekOyNoygEmv6rcOH5yvCx7HDVAVvHdBQVF0zbOcfnjgjF4JIxUuvCVG9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DRZgM9jU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A04EC4CEE7;
	Sat, 27 Sep 2025 20:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759006555;
	bh=WhvCEHR71JlepeZAgEOKFLslIS3HckCTEyON7ene1Vw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DRZgM9jUhtMTEydD42j7Nbtxg+JhtWb+Z249XgUWhuKN089P67pck7c/3ueE3mfNx
	 eX660JzdA4nIrDnLpbt3uFexE6YeMaJpO8rJbRlm8ZJp1OPKCsnTlUhqmhhGrcjn7g
	 a8uU8698JcEObJ2+EMJyUrQNSe8hlXL6QRq0KQfep1fTaaqu2XWCj8qczQs36NG9Qq
	 AsNNLqSGZsQQ2TySKM6WAgC/2T+6Xzg2yS1H1Tc/ellHXa49Km514naXvDOcjJujV1
	 +4IAbbwC1hklKbx2YEp8nmneRrcmVOZLmRMAdKNgqp8wISGB755bgyqqc86WRxPedJ
	 O8R/zKuKRcBQg==
Date: Sat, 27 Sep 2025 13:55:52 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Simon Wunderlich <sw@simonwunderlich.de>
Cc: kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH net-next 3/4] batman-adv: keep skb crc32 helper local in
 BLA
Message-ID: <20250927205552.GD9798@quark>
References: <20250916122441.89246-1-sw@simonwunderlich.de>
 <20250916122441.89246-4-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916122441.89246-4-sw@simonwunderlich.de>

Hi,

On Tue, Sep 16, 2025 at 02:24:40PM +0200, Simon Wunderlich wrote:
> +static __be32 batadv_skb_crc32(struct sk_buff *skb, u8 *payload_ptr)
> +{
> +	unsigned int to = skb->len;
> +	unsigned int consumed = 0;
> +	struct skb_seq_state st;
> +	unsigned int from;
> +	unsigned int len;
> +	const u8 *data;
> +	u32 crc = 0;
> +
> +	from = (unsigned int)(payload_ptr - skb->data);
> +
> +	skb_prepare_seq_read(skb, from, to, &st);
> +	while ((len = skb_seq_read(consumed, &data, &st)) != 0) {
> +		crc = crc32c(crc, data, len);
> +		consumed += len;
> +	}
> +
> +	return htonl(crc);
> +}

Has using skb_crc32c() been considered here?

- Eric

