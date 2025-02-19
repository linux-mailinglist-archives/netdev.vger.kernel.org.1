Return-Path: <netdev+bounces-167638-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93EFCA3B2AC
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 08:42:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 800DB189025C
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 07:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05EF01C3C17;
	Wed, 19 Feb 2025 07:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ozKgWneJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3CA1C3C00;
	Wed, 19 Feb 2025 07:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739950911; cv=none; b=elrKdRI6onuZeb0SRdeOopQqc+P4iDvJ9HzIL7DSQ+p8ZwWS5tWt0FFrkbmDNnX9oLt9kAJiu7HvgJfxQ2T3h6AcQi8ntzCxQcwQOcsOx6BxRwUz59HRw/LY4+DIE0RnSd4kEatQS+clXQ5GSVi0qFQDE1pTmSqGYHNUinmfx0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739950911; c=relaxed/simple;
	bh=TaIwcgsldoQh8EmmPf99LXHyWT7cdPFnrk5xLU56css=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s70iLbWmZaRFH48LqVzgxcWJh/91Fs/vZJXGXYIgMflBks8wcZ4wxzFseZHZgpbKe4Nb9taO79TyuButQQYB1jJb9xircsURQ0nGmM4yNHx9iOqdR9hkn4aJSIDFe0Id4Y1c/3oCLCvsJIqPvK7ivoIvwecpRjjJB/2sgqJjJL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ozKgWneJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C74CFC4CED1;
	Wed, 19 Feb 2025 07:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739950911;
	bh=TaIwcgsldoQh8EmmPf99LXHyWT7cdPFnrk5xLU56css=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ozKgWneJ0cP9Xwm8Xs0FohK0omI8oqGptNV3R/mrl2LTn6fMXlj90cGkuKHjO2Ao3
	 mUJ0YzegISISCTqGY2egFGb/6mCHlg+GP4f9LyFu/dfSOVfccgB9e/n+Dvj5D3Zfe7
	 0biojVwGddQn47QredR/YK/1dl8fHQB1nBBDxmpwq5zcif/K7DKSxOtmJYB3DrwdNQ
	 2ZgO/6i3tuM8J2AFISQgM6P6V2D+ew+fZ/Ywy22Zw9WHzHRXfdFsBsiGOkWG1Mct9l
	 /JoVocghiii3f7WWSHx5NY2zyCxJYEuBFGrvGYRdZNvvBrc1E8xYx/OR8QZRDJIdiP
	 GmSgo9b9o/HjA==
Date: Wed, 19 Feb 2025 08:41:48 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Oleksij Rempel <o.rempel@pengutronix.de>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Donald Hunter <donald.hunter@gmail.com>, 
	Rob Herring <robh@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Simon Horman <horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	netdev@vger.kernel.org, linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, 
	Dent Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 12/12] dt-bindings: net: pse-pd: ti,tps23881:
 Add interrupt description
Message-ID: <20250219-judicious-grumpy-snake-1cef08@krzk-bin>
References: <20250218-feature_poe_port_prio-v5-0-3da486e5fd64@bootlin.com>
 <20250218-feature_poe_port_prio-v5-12-3da486e5fd64@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250218-feature_poe_port_prio-v5-12-3da486e5fd64@bootlin.com>

On Tue, Feb 18, 2025 at 05:19:16PM +0100, Kory Maincent wrote:
> From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
> 
> Add an interrupt property to the device tree bindings for the TI TPS23881
> PSE controller. The interrupt is primarily used to detect classification
> and disconnection events, which are essential for managing the PSE
> controller in compliance with the PoE standard.
> 
> Interrupt support is essential for the proper functioning of the TPS23881
> controller. Without it, after a power-on (PWON), the controller will
> no longer perform detection and classification. This could lead to
> potential hazards, such as connecting a non-PoE device after a PoE device,
> which might result in magic smoke.
> 
> Signed-off-by: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
> ---
> 
> Change in v5:
> - Use standard interrupt flag in the example.
> 
> Change in v3:
> - New patch

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


