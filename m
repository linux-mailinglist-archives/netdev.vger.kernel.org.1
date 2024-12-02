Return-Path: <netdev+bounces-148062-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 635069E0631
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 16:04:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79EE6B42038
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 13:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C4E204F79;
	Mon,  2 Dec 2024 13:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b="1FOEisxi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA42233F6
	for <netdev@vger.kernel.org>; Mon,  2 Dec 2024 13:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733147375; cv=none; b=CojF8E4xa9Z58lxNKXLFjZYP31ilKgnIfxhfsGH0k+YgEpG8X/h66NtcbkQ/3Yr8I+4kPqdebew6wfKqoIcbX/5paxhsVUeexUyCKU1Ape94Q1dRsrrxH+k/dV3pvS65/jk2xiaCEehQV6nmIbLQK1EyE0Fq+mUFMoqRs26P1mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733147375; c=relaxed/simple;
	bh=4aBJjV9AGG6v/ueyNuXxKCEwqM57vbdIvUBj15x4HvQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JqIZ6gqkcK5SdYmQgDnanLsGK8TQcdE7yHFhEfI8jz77AnnW1BFo0Opqt2R33BdWN6Mwyr+ihZr5cNmMnwPztREGx29xxpCXQic/9azsW7tREXeWlgZk27iuuCF0/CpR4siNZAveYCNwN7aY7gsFYqcG+zkJumCIDueFhvBuIqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com; spf=pass smtp.mailfrom=cogentembedded.com; dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b=1FOEisxi; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cogentembedded.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2ffc80318c9so44187191fa.2
        for <netdev@vger.kernel.org>; Mon, 02 Dec 2024 05:49:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20230601.gappssmtp.com; s=20230601; t=1733147372; x=1733752172; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=utmDOcX/I6M6gZgQOmT31f/v0I8skcbfVHDvau0Ra4U=;
        b=1FOEisxi8IeZv5FtSncX0miSxtfjQCXPiV6a4To0epk0J6OBPluPKE6FJzKwaAJMsG
         sebG4bzW+1pWdJMOIxMqDJGs23DzOebc+Yjf8UG4zmfch/F0br82YIJAeTSM16pmCLxY
         g4C89tJm1kYelawNphTjRms5tJuvfPOOM19acK89J3rfeNltTxq4FdubQatpMwn4O3it
         J4F/7uBkodCrQyxwG7W3F10IKaTpG1QwSBvTpfemKvAVCxAV57fKHXrK5XviSDv1eUL9
         x3UEJ1hJunUYtVCA1UXoW4Cwdfq7s/ln9Ah79Q+mofoPwRlm7CeNFMrG/3X9jS1xvVY0
         74vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733147372; x=1733752172;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=utmDOcX/I6M6gZgQOmT31f/v0I8skcbfVHDvau0Ra4U=;
        b=AsD+PH+dkiAHlMbYmi1BUpJlRWNniqKSfjsjtU9tKWeIbevYVZckCY8beuxgysuuYv
         kMFAsnQN76qIb+WPltv9q453SRBSj2MAMGCIIbShLMI8uc+5bDZ8OCytfTZRtxxneONz
         YtHxctOLKAcf8ivVoYbBnjbyQsoxkwgsd4EmXA7O1GclhAL+YHQ4UcAI9DkCZvtlbUkw
         CEYhd0DLUwKNk/YhdtLgLMEuwnObs8z6QvZcZ4MM8cgqyiILcBWmlMtRSXp3dorM5vZU
         vXOnnc0J0X771wJibIxZ0gGnatdjlnb6HrScXEmN5uweWRhTWCiYq9UWfuv3OsMr/hQt
         M5GA==
X-Gm-Message-State: AOJu0Yz8xMDjdsht+pG7ihu6oxV63STUg3brOq9/MQSdV9icfe9+ns3i
	YX4o+04mOPDb4vmb8nHKeypSF6jPNdQaTpE0lviyuups+JIc5+oYYsqwD/y9TZE=
X-Gm-Gg: ASbGncvRws3MBpovgI+NachkW6OF5GkxabcEAY8LpKmHomjgffIxyy8H1oq1GSqpkiL
	9Mhtm0fC+aavHuvPTQBSOlvrY4te+4HOSjE3NyYtF7pnaoTksNURmFAQamLWcvdj95NQ640faon
	AZVinLMx0RY7KHCKKqfl3ar9Vs1//3jabLwvxMwMGdWuOTD8Gll1dyUVAKdENu/pK0W1O839A1/
	KE6FEd7jW5ggOY4vQEBFW7/ErkksaSglqjxasBaGDGyy9fSONzh+uZ7zAZEIuRL
X-Google-Smtp-Source: AGHT+IEumbL0xz4LEy0IxGz1T5wriVQbKuAxxhzOUJEXRi0z23STaQZgb5byEvsRsYGGQEBKO7tgYg==
X-Received: by 2002:a05:651c:211a:b0:2fb:5688:55a4 with SMTP id 38308e7fff4ca-2ffd6099734mr102259291fa.17.1733147372085;
        Mon, 02 Dec 2024 05:49:32 -0800 (PST)
Received: from cobook.home ([91.198.101.25])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ffdfbb8f2csm12972661fa.15.2024.12.02.05.49.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 05:49:31 -0800 (PST)
From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Dege <michael.dege@renesas.com>,
	Christian Mardmoeller <christian.mardmoeller@renesas.com>,
	Dennis Ostermann <dennis.ostermann@renesas.com>,
	Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Subject: [PATCH 4/5] net: renesas: rswitch: do not deinit disabled ports
Date: Mon,  2 Dec 2024 18:49:03 +0500
Message-Id: <20241202134904.3882317-5-nikita.yoush@cogentembedded.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241202134904.3882317-1-nikita.yoush@cogentembedded.com>
References: <20241202134904.3882317-1-nikita.yoush@cogentembedded.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In rswitch_ether_port_init_all(), only enabled ports are initialized.
Then, rswitch_ether_port_deinit_all() shall also only deinitialize
enabled ports.

Fixes: 3590918b5d07 ("net: ethernet: renesas: Add support for "Ethernet Switch"")
Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
---
 drivers/net/ethernet/renesas/rswitch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/renesas/rswitch.c b/drivers/net/ethernet/renesas/rswitch.c
index 779c05b8e05f..5980084d9211 100644
--- a/drivers/net/ethernet/renesas/rswitch.c
+++ b/drivers/net/ethernet/renesas/rswitch.c
@@ -1527,7 +1527,7 @@ static void rswitch_ether_port_deinit_all(struct rswitch_private *priv)
 {
 	unsigned int i;
 
-	for (i = 0; i < RSWITCH_NUM_PORTS; i++) {
+	rswitch_for_each_enabled_port(priv, i) {
 		phy_exit(priv->rdev[i]->serdes);
 		rswitch_ether_port_deinit_one(priv->rdev[i]);
 	}
-- 
2.39.5


