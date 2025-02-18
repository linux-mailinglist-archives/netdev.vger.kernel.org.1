Return-Path: <netdev+bounces-167227-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E8C5A393CC
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 08:33:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 813EB188B823
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 07:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EC201B85DF;
	Tue, 18 Feb 2025 07:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e5SWn9Pj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40E91A9B48;
	Tue, 18 Feb 2025 07:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739863990; cv=none; b=WcbFP0bVSc4f3mxQj2/TN/e3wosxtm3LPAg8R/FxQpAu+XZN/pZ77PoDyZpInB9X5i7AOym6dUI3HC7FuN/JmtvpGCQRR8DuB2oNwZ1hVnMyRpqY+pEx0snrnWaBRGFBVRzHpIaH4PWIYwFFz3x1bFmVPElZ3tpxZkYXmqR2eXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739863990; c=relaxed/simple;
	bh=Vxpxyoo+gayyKDoSphHgctMmS+J63KBuLw57khoFSgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L9imgCgRO+mrhk1xFlO3Akat6T62ytLXnisuJKDrQTOZC0L4MUFnOEdZTK7ATgjPyaf+gtl/21st5/lHeV/T1j8JNrbPYm8yd7BNyMSfmgqsRIGHreDJaHhGsA26DOKuHNNcV8+5iG3gPD+arFmRCh2eyT4Jqp01kPpFigOOUqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e5SWn9Pj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5B6BC4CEE2;
	Tue, 18 Feb 2025 07:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739863989;
	bh=Vxpxyoo+gayyKDoSphHgctMmS+J63KBuLw57khoFSgY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e5SWn9Pj8j0EfofPCKt/FLG+H5FLB6atyFO+tVIDzk61XWJQqrwDGTjPaYcRj3WBW
	 pdWpPm/tkJBV1DNnwvn8VfCuix3fOJvBesj+1yLss/SlEXbledCCorteF8Sz6/q3tk
	 14dSfpUj49CkfvHVe/Pe/7VKKfnQgI3I/F2c08s+yd893UPmTfpJHdqydY538C478E
	 AglXuBTkMFE2+Frny0m/+Oxk9eV1Nplwm24xSrg2Px9EHQUYm4FfZfMlTDR+eIS3eB
	 NGqFovk1HQke6akSzCr4ZJSj9FrzTo7mO7R/8bRjgXh4VTOeaTkpUQzlX3gEnUc0LN
	 IyNUuIieuhNvA==
Date: Tue, 18 Feb 2025 08:33:06 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Kyle Hendry <kylehendrydev@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, =?utf-8?Q?Fern=C3=A1ndez?= Rojas <noltari@gmail.com>, 
	Jonas Gorski <jonas.gorski@gmail.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v2 4/5] dt-bindings: mfd: brcm: add
 brcm,bcm63268-gphy-ctrl compatible
Message-ID: <20250218-eager-quantum-gaur-7cbac4@krzk-bin>
References: <20250218013653.229234-1-kylehendrydev@gmail.com>
 <20250218013653.229234-5-kylehendrydev@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250218013653.229234-5-kylehendrydev@gmail.com>

On Mon, Feb 17, 2025 at 05:36:43PM -0800, Kyle Hendry wrote:
> Add BCM63268 GPHY control register compatible.
> 
> Signed-off-by: Kyle Hendry <kylehendrydev@gmail.com>
> ---
>  Documentation/devicetree/bindings/mfd/syscon.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
> index 4d67ff26d445..1d4c66014340 100644
> --- a/Documentation/devicetree/bindings/mfd/syscon.yaml
> +++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
> @@ -54,6 +54,7 @@ select:
>            - atmel,sama5d4-sfrbu
>            - axis,artpec6-syscon
>            - brcm,cru-clkset
> +          - brcm,bcm63268-gphy-ctrl

Why random order? No, keep exiting, alphabetical order.

Best regards,
Krzysztof


