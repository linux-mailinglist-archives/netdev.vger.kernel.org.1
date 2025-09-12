Return-Path: <netdev+bounces-222386-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A4BB5404D
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 04:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7731216F29D
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 02:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F7751D54E3;
	Fri, 12 Sep 2025 02:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h1Y7cY4w"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408A418A6A5;
	Fri, 12 Sep 2025 02:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757643802; cv=none; b=WNQNuycGWGnue5Vj8Tb85tuFrjEzNcga3q0PgrEFoOHFRpTN+891MAhCq2nNk1qDQaCmV+lyWxBd6bOmCRz/az9lALHn1Mec7BRegVsK9BOFKUZZk0V6S6jEi9gy/TetqOfU4IDqYv6rDmtZ0neWchGeNCRXYT4suKkLQzN1Od4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757643802; c=relaxed/simple;
	bh=tUqTvYvIU9uIKFNgMQ8Bedpbon7O8hJPf6CcTzXeOjU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pl6LU2XvCJoBTubLalBaBnt3BJnvbPRA/Y5+q+Hibcq3jY+d5hFNhSb3yIFOQSHTYUBK8hBEzdigZ/P6VSyJ4+Ca+Np2Rj3ViT8gDqdSScWf8n1jE8P6PV4ljeT6TQ4eFHSt3vGr34NVCZWmlADcghzEAbFt4M7uGq8ZR2V3J3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h1Y7cY4w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2393C4CEF0;
	Fri, 12 Sep 2025 02:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757643799;
	bh=tUqTvYvIU9uIKFNgMQ8Bedpbon7O8hJPf6CcTzXeOjU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=h1Y7cY4wcyCxRlQNLffXlIE/Xpz4DHqLk6SYraoiZ9YzCKEXVZpQ3eQjrCaxiP7OH
	 uv4wyuL1vzenbpaXFnFr4rdXKbTk8UwLHPiUElO3dmnsUQ67jJHevXYWbCCBxah0rH
	 WOynvtg47zOLpyU7qWKErEHJOEHkhrkNUi8GX2WLwCEhyO6Xkxoc4OELYV+odCyBZq
	 pXC+iPvnTjiFS5FbKfsHFmllK5LNok8xJZjxPTLpESZN8oqx+ih4Kk8oCvpO3ylGtC
	 OivTCl3o6zqyQ2ETXYUYWIarblD8sERDVEYKm1+EpDVr8jr3Umf2sPUKuZmMVE1d8V
	 569Zp1zCIsvtg==
Date: Thu, 11 Sep 2025 19:23:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Kory Maincent
 <kory.maincent@bootlin.com>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Nishanth Menon <nm@ti.com>,
 kernel@pengutronix.de, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, UNGLinuxDriver@microchip.com,
 linux-doc@vger.kernel.org, Michal Kubecek <mkubecek@suse.cz>, Roan van Dijk
 <roan@protonic.nl>
Subject: Re: [PATCH net-next v5 1/5] ethtool: introduce core UAPI and driver
 API for PHY MSE diagnostics
Message-ID: <20250911192318.0628831f@kernel.org>
In-Reply-To: <20250908124610.2937939-2-o.rempel@pengutronix.de>
References: <20250908124610.2937939-1-o.rempel@pengutronix.de>
	<20250908124610.2937939-2-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  8 Sep 2025 14:46:06 +0200 Oleksij Rempel wrote:
> Add the base infrastructure for Mean Square Error (MSE) diagnostics,
> as proposed by the OPEN Alliance "Advanced diagnostic features for
> 100BASE-T1 automotive Ethernet PHYs" [1] specification.
> 
> The OPEN Alliance spec defines only average MSE and average peak MSE
> over a fixed number of symbols. However, other PHYs, such as the
> KSZ9131, additionally expose a worst-peak MSE value latched since the
> last channel capture. This API accounts for such vendor extensions by
> adding a distinct capability bit and snapshot field.
> 
> Channel-to-pair mapping is normally straightforward, but in some cases
> (e.g. 100BASE-TX with MDI-X resolution unknown) the mapping is ambiguous.
> If hardware does not expose MDI-X status, the exact pair cannot be
> determined. To avoid returning misleading per-channel data in this case,
> a LINK selector is defined for aggregate MSE measurements.
> 
> All investigated devices differ in MSE configuration parameters, such
> as sample rate, number of analyzed symbols, and scaling factors.
> For example, the KSZ9131 uses different scaling for MSE and pMSE.
> To make this visible to userspace, scale limits and timing information
> are returned via get_mse_config().

But the parameter set is set by the standard? If not we should annotate
which one is and which isn't.

> +  -
> +    name: phy-mse-capability
> +    doc: |
> +      Bitmask flags for MSE capabilities.
> +
> +      These flags are used in the 'supported_caps' field of struct
> +      phy_mse_config to indicate which measurement capabilities are supported
> +      by the PHY hardware.
> +    type: flags
> +    name-prefix: phy-mse-cap-
> +    entries:
> +      -
> +        name: avg
> +        doc: Average MSE value is supported.
> +      -
> +        name: peak
> +        doc: Current peak MSE value is supported.
> +      -
> +        name: worst-peak
> +        doc: Worst-case peak MSE (latched high-water mark) is supported.
> +      -
> +        name: channel-a
> +        doc: Diagnostics for Channel A are supported.
> +      -
> +        name: channel-b
> +        doc: Diagnostics for Channel B are supported.
> +      -
> +        name: channel-c
> +        doc: Diagnostics for Channel C are supported.
> +      -
> +        name: channel-d
> +        doc: Diagnostics for Channel D are supported.
> +      -
> +        name: worst-channel
> +        doc: |
> +          Hardware or drivers can identify the single worst-performing channel
> +          without needing to query each one individually.
> +      -
> +        name: link
> +        doc: |
> +          Hardware provides only a link-wide aggregate MSE or cannot map
> +          the measurement to a specific channel/pair. Typical for media where
> +          the MDI/MDI-X resolution or pair mapping is unknown (e.g. 100BASE-TX).

Should we invert the order here? I think it's more likely we'd
encounter new statistical measures rather than new channels.
So channels should go first, and then the measures?

> +  -
> +    name: phy-mse-channel
> +    doc: |
> +      Identifiers for the 'channel' parameter used to select which diagnostic
> +      data to retrieve.
> +    type: enum
> +    name-prefix: phy-mse-channel-
> +    entries:
> +      -
> +        name: a
> +        value: 0

Don't enums default to starting from 0?  I think setting value is unnecessary

> +        doc: Request data for channel A.

