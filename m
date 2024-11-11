Return-Path: <netdev+bounces-143837-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63DC49C4647
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 21:00:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1ADD71F22AF1
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 20:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9B741AB6CD;
	Mon, 11 Nov 2024 20:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TbMlQjix"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E2E156C5E
	for <netdev@vger.kernel.org>; Mon, 11 Nov 2024 20:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731355229; cv=none; b=C8ip7qswBNEyWh03nABgS6KzxG7QkkpUvXv5r/vdUO1Yv0nXrekYpImLb30aUiWGgaInrlIvmYswpUC9aFueH/190ZEErjoOMSbp0qLrB5Tg9jrRZQCO4zkcFHyDSPOTXqIIhCJzPaFYUEtqtI0lu3KL+zh3ZX61MjRsyvdn7iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731355229; c=relaxed/simple;
	bh=SKUurYuXIvuh21oiMyWm3t00ihHZNphF3RPuuJRcsGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Achu9sdwntehFiY5r3bEp2bLhf7+IGfS6PELnBNET9pXG9pwGfKwJWXm07Lmzy1/VHPGaa/eTaSFGCytqf6HOSP+S5IIm0Hu/igXeiCeSphG4Q76HxhG2GyCTdeMVSFZkgfC3McSx77OOTyk6yZ/iGuoadxBWVPY+FyaEzyf/CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TbMlQjix; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 871DEC4CECF;
	Mon, 11 Nov 2024 20:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731355229;
	bh=SKUurYuXIvuh21oiMyWm3t00ihHZNphF3RPuuJRcsGc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TbMlQjix1slQ8s00nP3Vl3mU3KG5CM1tXxM95x27O/PKfHeCvQKzhv9975GPnn6Jn
	 MRTVu8HpGEt60+x+YVZo4YUsSuR2AUWEZtMxezf38IYlMtV2/0gDA8oMzb1zoWRUxz
	 AOCLJNjLMW/lPQaH3gO8/SnubYlCrI/OKnWHFgsyHRfkCPv/NeraGCVhF/V9cYiE4n
	 SVkHJvpVwmg0gzTOos/XV2zG6jOcIocH5mmhN9P2Zk3PmEPUVy73iHezKVIMpB3xKX
	 dX/Bgwcu1iPwWBF4yZ2WCQgr3wv6wc3CZ6+X4l7KWxcDs9fXW+wBfRYRUhoKleNbwi
	 zE+zq/gvha6+A==
Date: Mon, 11 Nov 2024 20:00:25 +0000
From: Simon Horman <horms@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Realtek linux nic maintainers <nic_swsd@realtek.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] r8169: use helper r8169_mod_reg8_cond to
 simplify rtl_jumbo_config
Message-ID: <20241111200025.GL4507@kernel.org>
References: <3df1d484-a02e-46e7-8f75-db5b428e422e@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3df1d484-a02e-46e7-8f75-db5b428e422e@gmail.com>

On Sat, Nov 09, 2024 at 11:12:12PM +0100, Heiner Kallweit wrote:
> Use recently added helper r8169_mod_reg8_cond() to simplify jumbo
> mode configuration.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>


