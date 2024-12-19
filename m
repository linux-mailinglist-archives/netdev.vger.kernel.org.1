Return-Path: <netdev+bounces-153157-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E709F7176
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 01:42:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8558B7A4070
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 00:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A80F1805E;
	Thu, 19 Dec 2024 00:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HWT0ap6p"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65BFB676;
	Thu, 19 Dec 2024 00:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734568928; cv=none; b=XXdvrFPKJ/wHAoyH3HmBn1/8MhYHvN1RjmWsaRomhaUNHMTL3bWbc6VRR3gVe3BmjKuc0zaMZm/n+gWLVOYVjMyhrHXRGJDb7EqWFop300jkopBN3NpXFTdjM2V0bMZrmWCPZpYhIWZTKrsleThyvRjQ6XhG8O7CjP8y0yZf7Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734568928; c=relaxed/simple;
	bh=ETOdpjMOcIfpgrnZ8m3rcLo9Y44+EC3i/OGlHZ4PawE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XqddvhrHzhzBA2FjgqeBMqR5aqTf/nGmyoU628DL/tcn9ldzHNKnSazMePR1JdOO9GyB0/K2KKlrM0RqT94xOuGfNP6cefApx3ePmxhi2eZQ1YqwIa7a8OU2SApSglcF2drV51tgeY9au6ueNQZ6d8DGgQgWRV/BmzkF66XRwNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HWT0ap6p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA7C6C4CECD;
	Thu, 19 Dec 2024 00:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734568928;
	bh=ETOdpjMOcIfpgrnZ8m3rcLo9Y44+EC3i/OGlHZ4PawE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HWT0ap6pyizLpwwjBoNr1Yr8mFmNZZZQQSoqoKIFOy7TEMmR71Nl8EqtWPIAKUchQ
	 MpotDbqhht18A7Je6NT6D5zGZwpLFe2J9/yIiRq9a5611Xdl8IMO8xQkIJF8Y2vWFb
	 HFDu5dR7NpHGdOWURBAFavSEhkddjfp9fR0SfqWaUiv0y5KvUflQZpru1q6do4GSRl
	 jvZl49pfQpvS53dnm3wg00Xhi6O1/hCEV/3G4Vzc17BVB/vqWq2ouUW2rASfsIaFdG
	 q/D3yzIOw4O0Ks96lWlwUH69vfJhiW01Xe+P+xv2lSq17eb/ZWbRftM/mvHniyb600
	 T89VQeH6ODj5A==
Date: Wed, 18 Dec 2024 16:42:06 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Furong Xu <0x1207@gmail.com>, <netdev@vger.kernel.org>,
 <linux-stm32@st-md-mailman.stormreply.com>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 "Simon Horman" <horms@kernel.org>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "Maxime
 Coquelin" <mcoquelin.stm32@gmail.com>, <xfr@outlook.com>
Subject: Re: [PATCH net-next v1] net: stmmac: Drop useless code related to
 ethtool rx-copybreak
Message-ID: <20241218164206.437fcedc@kernel.org>
In-Reply-To: <b2ae6b80-83e3-4b22-8301-c91569c89494@intel.com>
References: <20241218083407.390509-1-0x1207@gmail.com>
	<b2ae6b80-83e3-4b22-8301-c91569c89494@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 18 Dec 2024 16:48:38 +0100 Alexander Lobakin wrote:
> If sizeof(dma_addr_t) == 8, you're clearly introducing a 4-byte hole
> here. Perhaps you could reshuffle the struct a bit to avoid this.
> 
> It's always good to inspect the .kos with pahole after modifying
> structures to make sure there are no regressions.

Pretty off topic but I have a dumb question - how do you dump a struct
with pahole using debug info or BTF from a random .ko?
Ever since pahole got converted to BTF modules stopped working for me :S
I never cared enough to check as most interesting stuff is built-in
in Meta's kernels but it annoys me every now and then..

