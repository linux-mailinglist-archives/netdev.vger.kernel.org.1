Return-Path: <netdev+bounces-143589-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C14369C3230
	for <lists+netdev@lfdr.de>; Sun, 10 Nov 2024 14:35:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 736441F21390
	for <lists+netdev@lfdr.de>; Sun, 10 Nov 2024 13:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12BA719BBC;
	Sun, 10 Nov 2024 13:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BgCRP6kr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEDA41798C;
	Sun, 10 Nov 2024 13:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731245747; cv=none; b=F3X856OoayEDwxeIdpZsCiw7KxqYqkS6hd8V33OV7xKVV6Prxm67dxZCbLuPcnzyIajFZTlYiqdTLtHRnuVVYh+h7BFk4xfi7WNJ0zbH+RqAyaiPbrzKvDl2ZmlMIZgNAmU+0m8pW6GbTzBNo0J7lAp+633n/O3oLmxEn886/ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731245747; c=relaxed/simple;
	bh=/Jzva/lnUCOfdvqz4t7Og5xoYDHm+1gt3wfXfs0Sr7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cwI55usKFmDN0FyNiFlLwf8zBAman2NCKECmhRI3M+9p4TiTTVCqN1DXtQjXpCUAzqEQLkRChfdz/q1ValGKz75R/LM+IPJrCTB+Ihu0MQXbsA6NbHDrTiSNW8QXP1GsD7zD4J5Th/+pSRR7R1mmx3soSoz5fizKbLu0ongJ0AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BgCRP6kr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E7FBC4CECD;
	Sun, 10 Nov 2024 13:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731245746;
	bh=/Jzva/lnUCOfdvqz4t7Og5xoYDHm+1gt3wfXfs0Sr7Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BgCRP6kreVpFhy+lQT4TBD1fmiDazlrZiRMTe+UBlJ3EpIaiWGjLkSZ+0CjF+1GJF
	 urnTqcnW3LPRAtnx40v/JVw8DANTMJ8blZO3Empp+4HEheBplcGchYdn0DCTyaWCIw
	 4BvKwazdIG7KXCtknQ1fmNKAny+pX9mb2Bz/DjA6njntGc5aaNSojuud7aJUTGfugQ
	 DKcW5YVyWp0H/QJacUBCFnUAoO0ngUoeyeKO/1NIEk0iFzAiGViApAMB9ft2764eyS
	 NO5+ZiQaYWcB/GF/RIgWT26HJc4xvcZbHWe2cXwzdiR3oGSRmK8MigWkUC9PhtiUu1
	 E7nR0Rw1OrQgQ==
Date: Sun, 10 Nov 2024 13:35:40 +0000
From: Simon Horman <horms@kernel.org>
To: Ley Foon Tan <leyfoon.tan@starfivetech.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	lftan.linux@gmail.com
Subject: Re: [PATCH net-next v3 2/3] net: stmmac: dwmac4: Fix the
 MTL_OP_MODE_*_MASK operation
Message-ID: <20241110133540.GP4507@kernel.org>
References: <20241107063637.2122726-1-leyfoon.tan@starfivetech.com>
 <20241107063637.2122726-3-leyfoon.tan@starfivetech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241107063637.2122726-3-leyfoon.tan@starfivetech.com>

On Thu, Nov 07, 2024 at 02:36:35PM +0800, Ley Foon Tan wrote:
> In order to mask off the bits, we need to use the '~' operator to invert
> all the bits of _MASK and clear them.
> 
> Signed-off-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>

Reviewed-by: Simon Horman <horms@kernel.org>


