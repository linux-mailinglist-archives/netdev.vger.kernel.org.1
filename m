Return-Path: <netdev+bounces-226213-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACCA0B9E1FB
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 10:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 746623818E9
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 08:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C35C3277CB1;
	Thu, 25 Sep 2025 08:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="asUGWyxO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854E9277CA4;
	Thu, 25 Sep 2025 08:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758790280; cv=none; b=ICsFGpeSyT/5oNZUw97Dv7Frw12O5KiGaTdiJIEnYcbLf8quOSlXSZM3O9cKcbNUzlkYVgGaXMkX2BjxSjkXAWuF1C1EvSCs1nQNtfa/ujoRBGaS5RlfRnHaC5Lav9cVXYiUcQgfSZn/4a2FALnDmMySmJKrohycpWdYGpirJnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758790280; c=relaxed/simple;
	bh=SLMBihPQk3ZvzgAs17Tcc+eFnMcP7YcSUZ9pmHMXyms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Trnmxk3ReaG01+03pZ70H2KIR/dGRgYmDWAGYyqmUHtfAdpEdSPGrAjBPpbtkAjhqmsnzmdk2fRnBQmYf2ka8XTw+qZ21oelbHrCGNufYz5KhRi27DxO55zQIzNFbAE4Pi+IoaMWMmerCD8XC0LDnU2muY+20rkFHwZdpk79sp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=asUGWyxO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B5C8C4CEF0;
	Thu, 25 Sep 2025 08:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758790279;
	bh=SLMBihPQk3ZvzgAs17Tcc+eFnMcP7YcSUZ9pmHMXyms=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=asUGWyxO+/1aAHdoSZw9225n5yaUp6+dO8Ws0+7LpqxdAWYR41jOXculN1Q48QXwd
	 LBLA/jYYFe1cSrLjKP3RrxE6qQQWKKTE610xgCqWXMLLhSJVU5ZxtRE5MdjYj/d/4D
	 2yY32Mu11YNl0GmmZfTED85mZb+vsORxjWDhh/DxQ1hRdKj3pvwQhVd2puFINr8WEF
	 L7FCbhojEGnEXbQarGwA/A9hnrUzWMPRNhJPqzta1Ayo2bvclKmuE0koxjRE0eoDD2
	 CBcMVAMOTT+sYEF/E3KGQ8GA2JWhwvfclV3qWVG2sX3Nz0WipjyDp+E0cggUcqSfDm
	 DG9HSf6SkI6lA==
Date: Thu, 25 Sep 2025 09:51:13 +0100
From: Simon Horman <horms@kernel.org>
To: =?utf-8?B?VGjDqW8=?= Lebrun <theo.lebrun@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Harini Katakam <harini.katakam@xilinx.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Tawfik Bayouk <tawfik.bayouk@mobileye.com>
Subject: Re: [PATCH net v6 3/5] net: macb: move ring size computation to
 functions
Message-ID: <20250925085113.GV836419@horms.kernel.org>
References: <20250923-macb-fixes-v6-0-772d655cdeb6@bootlin.com>
 <20250923-macb-fixes-v6-3-772d655cdeb6@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250923-macb-fixes-v6-3-772d655cdeb6@bootlin.com>

On Tue, Sep 23, 2025 at 06:00:25PM +0200, Théo Lebrun wrote:
> The tx/rx ring size calculation is somewhat complex and partially hidden
> behind a macro. Move that out of the {RX,TX}_RING_BYTES() macros and
> macb_{alloc,free}_consistent() functions into neat separate functions.
> 
> In macb_free_consistent(), we drop the size variable and directly call
> the size helpers in the arguments list. In macb_alloc_consistent(), we
> keep the size variable that is used by netdev_dbg() calls.
> 
> Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>

Reviewed-by: Simon Horman <horms@kernel.org>

If you need to re-spin for some reason, please consider looking
at checkpatch warnings regarding lines greater than 80 columns wide
(checkpatch --max-line-length=80). Likewise for the next patch in the
series.

