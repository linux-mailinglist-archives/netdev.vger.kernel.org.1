Return-Path: <netdev+bounces-250781-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 96198D39232
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 03:29:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 38D5B300D178
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 02:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 349781EA7CC;
	Sun, 18 Jan 2026 02:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UdPsAoto"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B1A1E572F;
	Sun, 18 Jan 2026 02:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768703350; cv=none; b=Y6M5EdovdV6otLZz590l5p5gwxH29RaVGYgyzjv6ZitfDzqo66bQ0DlXb4V+q3bJIb5Jvp0raMciyPMqeIioTUtQpMeOHtZrRBaUypzvDpuTkj/BosZjFNrDvHdU4RSulkJHXp4ocDCMwNpuN7qUb/IqZfyU5vJ7amKxrMPFxyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768703350; c=relaxed/simple;
	bh=YPFSllxCxgpgaZsfsv3qb75j4hY1WE5lvoq7M4Hpan0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RfgfkNA16SQj76YIVccpxdWohqLj8A7JsZ8PXJ9qbfXvnOMPcFh5CR/rF3q6tqhuna6tYZ2J4RAwarCvYTXN1VBkhiMfe8wllEubmsF8zhCjsTY4sMBGXldMlrfj/PagV+6TgAJeXAB7o4brAaDfFiqZ7jjvTfLanUhsBk5YXLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UdPsAoto; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E9B2C4CEF7;
	Sun, 18 Jan 2026 02:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768703349;
	bh=YPFSllxCxgpgaZsfsv3qb75j4hY1WE5lvoq7M4Hpan0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UdPsAotomS1W/AyqEM4wv9TtB1PxDs5IV4X/qHA+KxeG9U4x18ODjL0veivL8lppd
	 /0FWnvbz21qdfDFBxLO3g+txYuF7ZxiRSSovwMSSiBJDAaZ41lfPQha9HdqkL1CZbi
	 3UeYOrTRr/1YXIpZNTpT4OZAuaq6PpMARyf0Fzdte8NtO7UlQDBoplAPca1fyWG9Q6
	 LA5UyxjNWf5otaK5jhvYQMW+MBuKUSZOKaOOpZf0mfJcEXpG6eBva55bveBvzyvXqK
	 +nnmilQuClFdIG9qsWwlB94a39u7Ko6DBtYazIQOk+B+PetLaNXKYwbfWYNO2OgldZ
	 xzVKVqTz32G+g==
From: Jakub Kicinski <kuba@kernel.org>
To: daniel@makrotopia.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	fchan@maxlinear.com,
	hkallweit1@gmail.com,
	jpovazanec@maxlinear.com,
	yweng@maxlinear.com,
	davem@davemloft.net,
	andrew@lunn.ch,
	linux@armlinux.org.uk,
	edumazet@google.com,
	ajayaraman@maxlinear.com,
	john@phrozen.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	lrosu@maxlinear.com,
	bxu@maxlinear.com,
	pabeni@redhat.com
Subject: Re: [net-next] net: phy: intel-xway: workaround stale LEDs before link-up
Date: Sat, 17 Jan 2026 18:29:07 -0800
Message-ID: <20260118022907.1106701-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <d70a1fa9b92c7b3e7ea09b5c3216d77a8fd35265.1768432653.git.daniel@makrotopia.org>
References: <d70a1fa9b92c7b3e7ea09b5c3216d77a8fd35265.1768432653.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: phy: intel-xway: workaround stale LEDs before link-up

This patch works around a PHY firmware bug where LED manual control and
polarity configuration have no effect until a link is detected. The fix
temporarily clears BMCR_ANENABLE for 100ms to force the LED thread to start.

> diff --git a/drivers/net/phy/intel-xway.c b/drivers/net/phy/intel-xway.c
> index 9766dd99afaa..e06ed7ab0ff3 100644
> --- a/drivers/net/phy/intel-xway.c
> +++ b/drivers/net/phy/intel-xway.c

[ ... ]

> @@ -286,8 +287,33 @@ static int xway_gphy_config_init(struct phy_device *phydev)
>  		return err;
>
>  	/* Use default LED configuration if 'leds' node isn't defined */
> -	if (!of_get_child_by_name(np, "leds"))
> +	if (!of_get_child_by_name(np, "leds")) {
>  		xway_gphy_init_leds(phydev);
> +	} else {

Does this leak the device_node reference returned by of_get_child_by_name()?

The API documentation states that of_get_child_by_name() returns a node
pointer with refcount incremented, requiring of_node_put() when done.
When the "leds" node exists, the returned pointer is never captured and
of_node_put() is never called.

Other PHY drivers handle this correctly, for example vsc85xx_probe_common()
in drivers/net/phy/mscc/mscc_main.c:

    np = of_get_child_by_name(phydev->mdio.dev.of_node, "leds");
    if (np) {
        of_node_put(np);
        ...
    }

And of_phy_leds() in drivers/net/phy/phy_device.c also properly calls
of_node_put(leds) on all exit paths.

Note that this leak also existed in the original code before this patch,
but since this patch is touching this exact code path, it would be a good
opportunity to fix it.
-- 
pw-bot: cr

