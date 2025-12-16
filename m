Return-Path: <netdev+bounces-244971-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2011DCC44CB
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 17:30:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 21E533033C82
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 16:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D20E327A465;
	Tue, 16 Dec 2025 16:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SDotlHVh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0828925BF13
	for <netdev@vger.kernel.org>; Tue, 16 Dec 2025 16:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765902359; cv=none; b=uEinshV/nSQc2/Ttu7gLeY9S0y5l70614XGRT8+tRdwXzEnaTTOKA4dTEisT3Q+Ui6vF5F/6xtgG8cpQ9CymjNQ5PfndS6brKrdbU6wm3LNyaU8tWlv/6IKAAZpSLFJMzzrXz/hpJIr84jlrjPVtZcVAhvvesqYWxs44ttrgcgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765902359; c=relaxed/simple;
	bh=yhJUbCINpxh/auc5U5F4nsB73Bffl6eilqOnpz5DwFg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k57Z4AHzrv1LIquoqyJGfJoYOYZcuqUBTrfcG4AigiNSGgtVsRgAbGRi48fsv9eT+bkayDLtRk1BfG/RssSII+tyTXUCmqxzCOFzyLthmQO0Sg0x5YK7gEu880KPL+foNoAY5TComk5v9o20McGDFH1b7+YUtw7uqpAvN+UymcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SDotlHVh; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-42fb0fc5aa9so1909563f8f.1
        for <netdev@vger.kernel.org>; Tue, 16 Dec 2025 08:25:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765902356; x=1766507156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PX+3JbKQd1Ma8RRu1V0Qq95QByN2KfQrm38mIFaCTAg=;
        b=SDotlHVh0j58/ANy0ESCUsp7qYddroPe7TO/2GLtkZCUsD0CviZ+egZyThQ9XkIPu9
         thQ4DwtmdA/fntiqp9J5eHhCVrllp2gamVxIYjUlNyjOguKZ9/3XOB+0fzgH+M7UDL2z
         CejHRjYV7Zghu8wznjMPZ3wmouxu9UZo7FaCcdGYLDRJhwzbqEs+SqsmGBY336PB0GOg
         xTGz3jy/U4FuOdMugzxUsFQmHR+ZnjY8h2HZBmDyJ4z8E2izBFgSMED6NK8Lm3PQnuuk
         bEhFqAIcv0hFD+JRMEpc0F2YAXNGs3LGLS2PkelorpVweHPEW9cYZYPvacdSVWdk10XR
         0X6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765902356; x=1766507156;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PX+3JbKQd1Ma8RRu1V0Qq95QByN2KfQrm38mIFaCTAg=;
        b=cZE8DsHmWWhembP6P1TQUh4GGbtbfG8E88gpvwUciMIs3UxwHtFKy/Ch7NORxRgAfl
         fUw+Ui3yQwZS41+ctQyicWVYuCf6yQKFsy5pfREKIQUqLD/TF8umdHRkk4Fo3zA4UUih
         xSwOcHPVUqFQVZBkwyF7qnVscVx++MzfU0vds2tY9p3U8MtRcZ3+PSbMwkNfs4MEHxZf
         1qHj9yuTZHPzBYGI8kgesZikvkFIcx5WLE959mi/0bWTShf7SPg3UTktT9EiYVe93o6z
         AC1Nw6s4TmmJEG8+FPqLNFKSt0wfLYt35uzZf09bACGIC+lNZZI2ip9sb6+t308OjKU3
         +D1Q==
X-Gm-Message-State: AOJu0YzGfojsj63R78qehz/Kkqi1pd5rrtexN9cPTJ1LoKkTIqvDw2Ka
	pw8vOhO0M/gyR7RhERqEENxI/X18dtCjYLZ5Gq+rJ24IuI2/uO/8yzAXGnuUMhOi
X-Gm-Gg: AY/fxX6rKljs6MFaN81pI+xeTDGK7ayKbUDld5Ac9giQHQJz3N66JusGeFHccTyYXQ7
	n+ZyaifRCXl91ayXIEaVU3VWFLjF27uKfZh2hnB7zX3gGafqDR+uPwPDOEJs5eWNodD0sw4d9Nk
	ZSoi7ZopNlAG2y76WaA+uQLrLreoRAGOu5POaQMWQOof8g1eNQQhph92r6EfNIAEuJWRfOyXQtI
	KiQxJtT+IUNQWd8Gif/DqQmToEii+KHFHvGBR+vw+9nm1BSwbLf1xS5MPfDsil70JqBsWRZX8uc
	bkPHbxFFsF5/EiyYDv0KPjk3hMCt2GHUL1Q9w1DbslfjzDo1z10poy1d1bgiSzInTr5OgWBl9D2
	D7IeDGFI2fgYiH29Aq5JJs2KmzMDX7T0UPQ6wnxlORA8jdSzs3bdE9FGFL1+DkfAMxuw/Iv6fOl
	69CXAi+HeegkNS0CCrRt7q0ll2YgImxQu0Mm5SQxuyG/XnayYVwXZVdQ2Ea402sojQiENeqVqXh
	Cdz/4938YhrVgY=
X-Google-Smtp-Source: AGHT+IGXRD6HFpyqQVc/wf8iqGFKyIb05ivxCNYXQ4rHj0cs+H834YP88+rvw+KorrLC+jI05vadpA==
X-Received: by 2002:a05:6000:2892:b0:430:fafd:f1d2 with SMTP id ffacd0b85a97d-430fafdf3bfmr9773877f8f.11.1765902356018;
        Tue, 16 Dec 2025 08:25:56 -0800 (PST)
Received: from Lord-Beerus.station (net-5-94-28-5.cust.vodafonedsl.it. [5.94.28.5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-430f7475895sm17750190f8f.33.2025.12.16.08.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 08:25:55 -0800 (PST)
From: Stefano Radaelli <stefano.radaelli21@gmail.com>
X-Google-Original-From: Stefano Radaelli <stefano.r@variscite.com>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Stefano Radaelli <stefano.r@variscite.com>,
	Xu Liang <lxu@maxlinear.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Stefano Radaelli <stefano.radaelli21@gmail.com>
Subject: [PATCH net v1] net: phy: mxl-86110: Add power management and soft reset support
Date: Tue, 16 Dec 2025 17:25:34 +0100
Message-ID: <20251216162534.141825-1-stefano.r@variscite.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement soft_reset, suspend, and resume callbacks using
genphy_soft_reset(), genphy_suspend(), and genphy_resume()
to fix PHY initialization and power management issues.

The soft_reset callback is needed to properly recover the PHY after an
ifconfig down/up cycle. Without it, the PHY can remain in power-down
state, causing MDIO register access failures during config_init().
The soft reset ensures the PHY is operational before configuration.

The suspend/resume callbacks enable proper power management during
system suspend/resume cycles.

Fixes: b2908a989c59 ("net: phy: add driver for MaxLinear MxL86110 PHY")
Signed-off-by: Stefano Radaelli <stefano.r@variscite.com>
---
 drivers/net/phy/mxl-86110.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/phy/mxl-86110.c b/drivers/net/phy/mxl-86110.c
index e5d137a37a1d..42a5fe3f115f 100644
--- a/drivers/net/phy/mxl-86110.c
+++ b/drivers/net/phy/mxl-86110.c
@@ -938,6 +938,9 @@ static struct phy_driver mxl_phy_drvs[] = {
 		PHY_ID_MATCH_EXACT(PHY_ID_MXL86110),
 		.name			= "MXL86110 Gigabit Ethernet",
 		.config_init		= mxl86110_config_init,
+		.suspend		= genphy_suspend,
+		.resume			= genphy_resume,
+		.soft_reset		= genphy_soft_reset,
 		.get_wol		= mxl86110_get_wol,
 		.set_wol		= mxl86110_set_wol,
 		.led_brightness_set	= mxl86110_led_brightness_set,
-- 
2.47.3


