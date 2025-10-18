Return-Path: <netdev+bounces-230703-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88C87BEDD05
	for <lists+netdev@lfdr.de>; Sun, 19 Oct 2025 01:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34DF03AEDC1
	for <lists+netdev@lfdr.de>; Sat, 18 Oct 2025 23:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4581C2580F9;
	Sat, 18 Oct 2025 23:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U1Ll/2Ns"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6B121B185;
	Sat, 18 Oct 2025 23:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760831457; cv=none; b=TBHpFagod6QHHM2QfUDGDJPQrSzDo4RApdIOSoiryAijjAEyMirnjSdlLYj8LZwsi5VS8USaPV5JEua9x++DExDtnSxK13h0bZjttYDWHr82OjnWjHLOZcCywqE6awGssTbrQBNYra0w4tRQH4YlJ4no4WQwnZb5cxd3JLeqZxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760831457; c=relaxed/simple;
	bh=SA+E3sVxRvSOjvIWlF9yPgUikJG0kp9ubF4dG1sYfrc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZOY5M6g0QALZwE4fjw5FyXLeTRiAu3OPHIYBALDs9VpRbiVSCZm8TMyAYm/rPntk7f07CBipxI+UfECmOOXHcoKhw/iIfig+gmg8gLcx7COCoKv1AdofT8Nu83/Pfqhe6C1ASBQLyMpkIKpsGJ7tWvDZ8UOS94wjqwE8eBS2iBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U1Ll/2Ns; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB8B3C4CEF8;
	Sat, 18 Oct 2025 23:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760831456;
	bh=SA+E3sVxRvSOjvIWlF9yPgUikJG0kp9ubF4dG1sYfrc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=U1Ll/2NsJhQ3DYaOeQue0P0okR8fopdF4mlitTEP4pylN0EjSCvPj1GqHLJJJP1Af
	 /EaiegK/SG9nVr2qIn7KgBMXEpahxZhuI3jDBuoZ7+Jeb0npzGLYa/oSvT+6obPi+i
	 tgXSkbyp1AB+aI+GfuLPZcMjf4eUo1l/fE7kgxbrNDXeNBd9WM+Po1bl7siyJyjbtu
	 LBAIo353pOZ6uSzH+WydS4rXhAYKMP7Zsa9BoICC3phEogj/Qg7Xq4nnJCeRwWKV8D
	 7OrZDMh2tBlYt+F+K8ya5NNm2m0poVHbmCfmYe183FZus7bRkl7wNtnS0F5nHV7BMg
	 qDQnf7h/BoP+Q==
Date: Sat, 18 Oct 2025 16:50:54 -0700
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
Subject: Re: [PATCH net-next v6 2/5] ethtool: netlink: add
 ETHTOOL_MSG_MSE_GET and wire up PHY MSE access
Message-ID: <20251018165054.067ab347@kernel.org>
In-Reply-To: <20251017104732.3575484-3-o.rempel@pengutronix.de>
References: <20251017104732.3575484-1-o.rempel@pengutronix.de>
	<20251017104732.3575484-3-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 17 Oct 2025 12:47:29 +0200 Oleksij Rempel wrote:
> +  ===========================================    ======  =========================
> +  ``ETHTOOL_A_MSE_CAPABILITIES_MAX_AVERAGE_MSE`` uint    max avg_mse scale
> +  ``ETHTOOL_A_MSE_CAPABILITIES_MAX_PEAK_MSE``    uint    max peak_mse scale
> +  ``ETHTOOL_A_MSE_CAPABILITIES_REFRESH_RATE_PS`` uint    sample rate (picoseconds)
> +  ``ETHTOOL_A_MSE_CAPABILITIES_NUM_SYMBOLS``     uint    symbols per HW sample
> +  ``ETHTOOL_A_MSE_CAPABILITIES_SUPPORTED_CAPS``  bitset  bitmask of
> +                                                         phy_mse_capability
> +  ===========================================    ======  =========================

make htmldocs says:

Documentation/networking/kapi:125: ./include/linux/phy.h:910: ERROR: Unexpected indentation.
Documentation/networking/kapi:125: ./include/linux/phy.h:913: WARNING: Block quote ends without a blank line; unexpected unindent.
Documentation/networking/ethtool-netlink.rst:2514: ERROR: Malformed table.

