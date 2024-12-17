Return-Path: <netdev+bounces-152597-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F13369F4C27
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 14:28:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 127AD173BCC
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 13:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 570281F7088;
	Tue, 17 Dec 2024 13:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IWEmcPew"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299761F7081;
	Tue, 17 Dec 2024 13:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734441496; cv=none; b=hH2fVmh8sZ11NZ0u6CELE7S6opT3LrDfL6SEWI3DLI+Js9GmMQInsYuJjjA07+bUtr9ZTiGEnPi9t2ST1PeTTGR2QzFV203v0ZTJj6FJkMWn3OtGvsskNUFhIugPuGWUwatrKvjd+G9X9kKWLfRwImJk6wsi8voxCOVOxLrM3Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734441496; c=relaxed/simple;
	bh=LgYSlCVhxva3zcs7YV247UvMnT+OkZcHDucG48hT898=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kFqIAL06VF+X2eHNb6Dul0SALJxd/BXRmmQtnQKNRVDWO6kOR87pw4R/RNFqTdbknKrUNfFmGHECSfVYk35ttDjVX9uG0RKTFTSKXeWgaNjI1846q7J7kyTP8ctQbk4qsmouBJUsKyDUJ5vTJ5gxPx/a/azE/bPsphA/Ta7aOCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IWEmcPew; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C2C0C4CED4;
	Tue, 17 Dec 2024 13:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734441495;
	bh=LgYSlCVhxva3zcs7YV247UvMnT+OkZcHDucG48hT898=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IWEmcPewXktwLgiuhox8ozlQsK/lIgxiVOtV807N931COsH5Lq9S3PcN28jLvTtVW
	 RCNJfFqw+IiDt7NFzOM1ewhDwAwi+S6rD8g2mz1xw58FG4h/FCic+TSvlaZrxqZly6
	 f1OniB/T5YSWbnaaJGaTNhV2TJArmrqN2pYE4mj+M5UPo20Ce45LH+s7KHoj68msog
	 ZSK2g/ic+yoKlkMA6kQxPvtCuq/SLG8B4MT/KS0919fVbGx2W9hVHa4enD8dCeZtWn
	 nK5G+EkJkQj3SgxKmvTmIMtzDyB2DNMIQ1n2iIOXOMdgA+AqRsADm9SjJw0Q3nrp/q
	 L1pBQa4IlX7ng==
Date: Tue, 17 Dec 2024 07:18:13 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, Lee Jones <lee@kernel.org>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	linux-mediatek@lists.infradead.org,
	Eric Dumazet <edumazet@google.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	linux-arm-kernel@lists.infradead.org, upstream@airoha.com,
	Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [net-next PATCH v11 1/9] dt-bindings: nvmem: Document support
 for Airoha AN8855 Switch EFUSE
Message-ID: <173444149293.1330948.15339441958855664724.robh@kernel.org>
References: <20241209134459.27110-1-ansuelsmth@gmail.com>
 <20241209134459.27110-2-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209134459.27110-2-ansuelsmth@gmail.com>


On Mon, 09 Dec 2024 14:44:18 +0100, Christian Marangi wrote:
> Document support for Airoha AN8855 Switch EFUSE used to calibrate
> internal PHYs and store additional configuration info.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  .../bindings/nvmem/airoha,an8855-efuse.yaml   | 123 ++++++++++++++++++
>  MAINTAINERS                                   |   8 ++
>  2 files changed, 131 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/nvmem/airoha,an8855-efuse.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


