Return-Path: <netdev+bounces-135874-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D314699F792
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 21:56:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E39D28404C
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 19:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B391F5826;
	Tue, 15 Oct 2024 19:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QFEp9czm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1C81B6CFE;
	Tue, 15 Oct 2024 19:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729022165; cv=none; b=d9fuo4ZECcv16vnvpwB4Jx3DhG5YcWr/mQGFGmn+s0mFaP8cRwuNdTxOBxaj10axkRcH8HTXBYgsfh0n3RvktJ/oBuz4AE30kmPEPFyU8ku0034tXwtUoAsR0issFCY4DjBMDbiWuwcIsp7qkrT2FUvoTPZOCDZL3NyQtZ4v0fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729022165; c=relaxed/simple;
	bh=24Qo5440XbqBnAPn+ZUTLKr7arStgE2pwtDtrrn5gwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pOQD6VbPxlANgSTsPHyoQIMyUzH+Y4ZfTNIujt+I6L7UmqyGa6ywWBl5uJNUNAZuzeYGuRAKP4tV50nNSLDXFdEo8sklRY9NffDzGo1ubXR4ntwRiZratU97WtC3U+PuOhGNoUv5UjoxaaRhiILrFaVI/T0S+30lzzfZlt0PMk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QFEp9czm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E718C4CEC6;
	Tue, 15 Oct 2024 19:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729022164;
	bh=24Qo5440XbqBnAPn+ZUTLKr7arStgE2pwtDtrrn5gwU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QFEp9czm1UtS3b0vPOSpxeqlTodLr4+KzOvgeLWwPUX6W4QbaVTgN3y+mjacWFznD
	 FJA5wM66aBxNclxZmp9BoPRfIkx92+YrELEyHTjF65kUymCLKeisBYWOrKiGG7ZCSH
	 4+2KuWBiL63yc1HPoJxcr6zYEOph+LKyfWDmVFyd27LNg5DnQllNhY1AvgX1b+/bVK
	 jZUy0SXFtimsPxLlJpXuWhhsnA1antkoaORH2BHpFcBh16Lqjuxniyo93NKUKKVGsi
	 QkXdMmVIY9oc9iQmqO6aqrys8habylZqntska++AZIn8byXOjSVJ+aDwJoLaI7QTEO
	 hIU2/hriQFzWg==
Date: Tue, 15 Oct 2024 14:56:03 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>, Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>, devicetree@vger.kernel.org,
	Doug Berger <opendmb@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: net: brcm,unimac-mdio: Add bcm6846-mdio
Message-ID: <172902216369.1697908.10274382706034745512.robh@kernel.org>
References: <20241012-bcm6846-mdio-v1-0-c703ca83e962@linaro.org>
 <20241012-bcm6846-mdio-v1-1-c703ca83e962@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241012-bcm6846-mdio-v1-1-c703ca83e962@linaro.org>


On Sat, 12 Oct 2024 22:35:22 +0200, Linus Walleij wrote:
> The MDIO block in the BCM6846 is not identical to any of the
> previous versions, but has extended registers not present in
> the other variants. For this reason we need to use a new
> compatible especially for this SoC.
> 
> Suggested-by: Florian Fainelli <florian.fainelli@broadcom.com>
> Link: https://lore.kernel.org/linux-devicetree/b542b2e8-115c-4234-a464-e73aa6bece5c@broadcom.com/
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  Documentation/devicetree/bindings/net/brcm,unimac-mdio.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


