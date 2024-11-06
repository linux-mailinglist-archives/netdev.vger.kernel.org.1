Return-Path: <netdev+bounces-142309-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D079BE2E7
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 10:43:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AC3A1C20A6D
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 09:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 644721DA618;
	Wed,  6 Nov 2024 09:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eQP/8p1w"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C77F1D7E37;
	Wed,  6 Nov 2024 09:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730886182; cv=none; b=RIfX2RWxoxsB3KWjgvUNgman8AIbOtZcJZb1H7o6abWkKBEJSPOPSDPH64Chfh87l88I/E3+uKfHvtkLSZlhRttb02HWrVgoZb5kugQ5QQgQ4ckZo9+WK9OtE/Eg8bJMsNyI3c0PdV+wDoyQMFstbvbvO9wNU+9yxywvWGZsJ7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730886182; c=relaxed/simple;
	bh=ejHS7C/7ZbSIztex4f4UJCgT1blclG9gOy/DpK24OVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XTAQaZOiilyQ544Hw4LsENK9Zo1fv/DySsI5jhwyCNyx+1SlHGdZEI1RxsJG5iGgM06YUaZrw2PVTACxztPPqxOTJ+g3dmj5RGsgQfvKCm3V2MCkXYioLboLEQXSniFtmeuIPYHcjfsUUVcQyrywlX4k8rhx4DV8nqa+muDY6uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eQP/8p1w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DB9DC4CECD;
	Wed,  6 Nov 2024 09:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730886181;
	bh=ejHS7C/7ZbSIztex4f4UJCgT1blclG9gOy/DpK24OVs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eQP/8p1wgZwWzJ45BgjroCbaVs+5YbOb5IzDHn03FJpvbP6n01CO8AbbhcdXmaGLO
	 hY0rL3z96Qi1B5gDGU0Rj190REZTEne/+z6Ki5PlzH6Ye95VbcX/8lrrWpLolzmYtK
	 DV1624pYY6hvD2OI9IYbAsCkpcHJO96r4owwoInUrTIFj6fHkKeZbKlUBHcL6hD5ri
	 pXEn3TdXFHsaNiIxhHHEOt8fmJyqg8ATnGGDP3IZ1D5L+G2S8Yw1xyO+K33XJE00XV
	 76EVGPoaNre7RohP+kFi1TfX0kqOnBIc3WydIOuW7q49TvnmgAfflRkSNmu2zLPkfR
	 EUTjWvqKJh0NA==
Date: Wed, 6 Nov 2024 09:42:56 +0000
From: Simon Horman <horms@kernel.org>
To: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Qiang Ma <maqianga@uniontech.com>, kernel@collabora.com,
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH] net: stmmac: Fix unbalanced IRQ wake disable warning on
 single irq case
Message-ID: <20241106094256.GI4507@kernel.org>
References: <20241101-stmmac-unbalanced-wake-single-fix-v1-1-5952524c97f0@collabora.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241101-stmmac-unbalanced-wake-single-fix-v1-1-5952524c97f0@collabora.com>

On Fri, Nov 01, 2024 at 05:17:29PM -0400, Nícolas F. R. A. Prado wrote:
> Commit a23aa0404218 ("net: stmmac: ethtool: Fixed calltrace caused by
> unbalanced disable_irq_wake calls") introduced checks to prevent
> unbalanced enable and disable IRQ wake calls. However it only
> initialized the auxiliary variable on one of the paths,
> stmmac_request_irq_multi_msi(), missing the other,
> stmmac_request_irq_single().
> 
> Add the same initialization on stmmac_request_irq_single() to prevent
> "Unbalanced IRQ <x> wake disable" warnings from being printed the first
> time disable_irq_wake() is called on platforms that run on that code
> path.
> 
> Fixes: a23aa0404218 ("net: stmmac: ethtool: Fixed calltrace caused by unbalanced disable_irq_wake calls")
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Reviewed-by: Simon Horman <horms@kernel.org>


