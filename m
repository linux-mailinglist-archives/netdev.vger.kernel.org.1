Return-Path: <netdev+bounces-222892-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B12B56D2C
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 02:11:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 601D7165306
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 00:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B1CC1CA84;
	Mon, 15 Sep 2025 00:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RZD90E4A"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456FF23AD;
	Mon, 15 Sep 2025 00:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757895091; cv=none; b=gMvHWVxYaK6NobHo+8os9oy5RV0eFgWTzdfK0V9udBu6HAUN6tXMw5QeGj2csfNMhw1jzEQH4rGmVOKWaVhLzRz3dYa50/KeFf/P8MBuphsalGiPTVvCvUlBhQ2jZczKqS7SwaqrQ0P9tKcU1nn8SAQHSKKBZYiHEQVernDy2gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757895091; c=relaxed/simple;
	bh=J3AJunPYZjvT3fBNOBIckknDBrGE+MfaU9bXgPby/a0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lTc4hWeHNKf8ZoWSX9Kzn8JETLLBeH8W+dc7ciZ+h8MKqND8OtEGiICZFExAUDGB+CsyNZtF11PQ4HWTOOpBRg/C+ftsFeyxZe7kejsLryWGniaW9ABVh9sFqYDrNwho51cBqCeGZUCaXHfyEvU5VFy8V8T83YiDjqCWPHDVgU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RZD90E4A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACCE8C4CEF0;
	Mon, 15 Sep 2025 00:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757895090;
	bh=J3AJunPYZjvT3fBNOBIckknDBrGE+MfaU9bXgPby/a0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RZD90E4AiDIV43hBZmJzBk9jr9saqUD9qMC+wCdrnqi4iZCE/wAhYj95gJ0t47+lb
	 MfOI3mMEZhmZg7ys9rkuJa0gRSLUdmmvVYzZTLCcVSkcrNtNzrxBjwtGvDkmd+1YgS
	 BHLEC0aoy5mkzRlGwW4wQobbGOwiXKEfa3VIzgiuRcxilucittQg2AL1boynqY1Kxz
	 F02scaSH6Vc7ADt+gRQzRpt5zOumCi80E0GijXxY1h15qAqXDtxw4tehrvWElJisHv
	 MfsSB733yqaGUX3/kYoiP9gBWdAE8OU6BziFW4merg26OYkOyUmk0DWDqSABuGHIS3
	 QBrVsR0AGMnCg==
Date: Sun, 14 Sep 2025 19:11:29 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Jonas Rebmann <jre@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	Conor Dooley <conor+dt@kernel.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>, devicetree@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Shengjiu Wang <shengjiu.wang@nxp.com>, linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sascha Hauer <s.hauer@pengutronix.de>, imx@lists.linux.dev,
	Andrew Lunn <andrew@lunn.ch>, linux-arm-kernel@lists.infradead.org,
	Shawn Guo <shawnguo@kernel.org>, linux-sound@vger.kernel.org
Subject: Re: [PATCH 2/4] ASoC: dt-bindings: asahi-kasei,ak4458: Reference
 common DAI properties
Message-ID: <175789508944.2293375.7905961656761093444.robh@kernel.org>
References: <20250910-imx8mp-prt8ml-v1-0-fd04aed15670@pengutronix.de>
 <20250910-imx8mp-prt8ml-v1-2-fd04aed15670@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910-imx8mp-prt8ml-v1-2-fd04aed15670@pengutronix.de>


On Wed, 10 Sep 2025 14:35:22 +0200, Jonas Rebmann wrote:
> Reference the dai-common.yaml schema to allow '#sound-dai-cells' and
> "sound-name-prefix' to be used.
> 
> Signed-off-by: Jonas Rebmann <jre@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/sound/asahi-kasei,ak4458.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


