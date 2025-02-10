Return-Path: <netdev+bounces-164571-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B510A2E4BF
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 07:55:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81BE318893EE
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 06:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0A9A1AA1DC;
	Mon, 10 Feb 2025 06:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bafjmJG+"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A9A1A8F74;
	Mon, 10 Feb 2025 06:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739170312; cv=none; b=JCvTC84X/TRKPg7/USKvIS2tP0v8m4yFNeTlcwNpAnHXuT7NN3+my9Zw/CtOR28IgZVM0NTGd5kYlPHw6Bx7kTxGE1W/c9CIdmmBZgvVk3X24xGroqoYm3a7CHHq9bkN2dIoxUDYRa9/0jdSr5pQsxy9YE3xkcGfAHiSHY1gyvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739170312; c=relaxed/simple;
	bh=/yiNYw2w1QP43if0EbApxxlUXZtJpdnCU0y+oXqKeS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J3LKLiktXMvj4I1GzuEtvtL1lqikOPpkzJBVsHXwwBxri8TbBeCItb2XTgkhQSEbaBYEFR269duEen2F5Sp3egAGh8rYSSDGzQni93QD1/mGJWp0CcrwK8geAdPAXW9t5tfdsCcjbPeIZDdOpYJ4wc4OlkTGbmq/HD9Ib1GPxdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bafjmJG+; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8F66F1140113;
	Mon, 10 Feb 2025 01:51:49 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Mon, 10 Feb 2025 01:51:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739170309; x=1739256709; bh=Xa+u6TSXdvpnsdktnh6Ldx8knq/jErF9o1m
	KCq6c5Eo=; b=bafjmJG+wuzoGYnXZs3OWuN0rYfKlg+z2CCIwrfj/QfDpdFjR/y
	2cOacgCL54YyWCBNjoZjaFeXcEV8V7Vo3hGDBXfeBAwgBDj7XG8lbNfhpvqcM8Lq
	MD7c6SkqSX0+jdD6DxGDhrPToD93coyrVvPRy+JS80LK5TLdD/tJ9mex2c9TXBV2
	RDi4k71i5JRRXQXGmFRFwv5x5icJjaWE4KnCK2t9wVzlmvzzp37kdp+eOYbgzEF8
	JO8yt50GMwHe0B24pDZCPQRzA3eKNhglAP28MRwvf/dteVtwIGq7wpK2m4JDES9R
	eLhGfH3PxL1+oxB1V0XXxUmbsv/nfiqzaqg==
X-ME-Sender: <xms:BKKpZyEkbPGdJbINekmZfUB-gH5gCVVDb3gdjKHA72CSOPSz_7kAkA>
    <xme:BKKpZzUk4ydXVK9ZjUS9wqvx2FVO73_J9By-pDgU08zri40YosGqHiMTatzrZnw00
    ZLfe2v0vI2btqY>
X-ME-Received: <xmr:BKKpZ8JgelyjxShIgIdKuTBZRJX7HdCtE23GhFzNUZ-5_xaMQxJoWT1i9rff>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefjeefkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefkughoucfutghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrd
    horhhgqeenucggtffrrghtthgvrhhnpeehhfdtjedviefffeduuddvffegteeiieeguefg
    udffvdfftdefheeijedthfejkeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepihguohhstghh
    sehiughoshgthhdrohhrghdpnhgspghrtghpthhtohepudehpdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopedtgiduvddtjeesghhmrghilhdrtghomhdprhgtphhtthhopehn
    vghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqd
    hsthhmfedvsehsthdqmhguqdhmrghilhhmrghnrdhsthhorhhmrhgvphhlhidrtghomhdp
    rhgtphhtthhopehlihhnuhigqdgrrhhmqdhkvghrnhgvlheslhhishhtshdrihhnfhhrrg
    guvggrugdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopegrnhgurhgvfidonhgvthguvghvsehluhhnnh
    drtghhpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphht
    thhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhusggrse
    hkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:BKKpZ8HqxAaKpTyiU7gG7xc6MjskSyqqHjmp5EoTbdhh23xWP8oc8A>
    <xmx:BKKpZ4Ue8dCAHoq82cA_LJFEULIs1ZFVQkIxheG1OC16r3dv9aIuzQ>
    <xmx:BKKpZ_MYmJG1HtVP8iAw3V0SX2rTdKIuOKCtCPrfT69AS_SZX5GifQ>
    <xmx:BKKpZ_2CztCc2frUAkqVwVttjA0EA46oQmThzHKTpt6tyFT0gsB3Gw>
    <xmx:BaKpZ5vNx_rkiYc-31LJg39M5YTGKhVW8TNvfHujyxmwpu4E297FVaNz>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Feb 2025 01:51:48 -0500 (EST)
Date: Mon, 10 Feb 2025 08:51:45 +0200
From: Ido Schimmel <idosch@idosch.org>
To: Furong Xu <0x1207@gmail.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>, xfr@outlook.com,
	Jon Hunter <jonathanh@nvidia.com>,
	Brad Griffis <bgriffis@nvidia.com>
Subject: Re: [PATCH net v1] net: stmmac: Apply new page pool parameters when
 SPH is enabled
Message-ID: <Z6miASgDGKfGH9qO@shredder>
References: <20250207085639.13580-1-0x1207@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207085639.13580-1-0x1207@gmail.com>

On Fri, Feb 07, 2025 at 04:56:39PM +0800, Furong Xu wrote:
> Commit df542f669307 ("net: stmmac: Switch to zero-copy in
> non-XDP RX path") makes DMA write received frame into buffer at offset
> of NET_SKB_PAD and sets page pool parameters to sync from offset of
> NET_SKB_PAD. But when Header Payload Split is enabled, the header is
> written at offset of NET_SKB_PAD, while the payload is written at
> offset of zero. Uncorrect offset parameter for the payload breaks dma
> coherence [1] since both CPU and DMA touch the page buffer from offset
> of zero which is not handled by the page pool sync parameter.
> 
> And in case the DMA cannot split the received frame, for example,
> a large L2 frame, pp_params.max_len should grow to match the tail
> of entire frame.
> 
> [1] https://lore.kernel.org/netdev/d465f277-bac7-439f-be1d-9a47dfe2d951@nvidia.com/
> 
> Reported-by: Jon Hunter <jonathanh@nvidia.com>
> Reported-by: Brad Griffis <bgriffis@nvidia.com>
> Suggested-by: Ido Schimmel <idosch@idosch.org>
> Fixes: df542f669307 ("net: stmmac: Switch to zero-copy in non-XDP RX path")
> Signed-off-by: Furong Xu <0x1207@gmail.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

