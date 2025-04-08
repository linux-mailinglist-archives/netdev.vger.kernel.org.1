Return-Path: <netdev+bounces-180361-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E64EA810ED
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 17:58:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4C1E1897841
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 15:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C06422D4FF;
	Tue,  8 Apr 2025 15:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YS6B6cbG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841C022B8C4;
	Tue,  8 Apr 2025 15:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744127640; cv=none; b=FiAEnvF6CPgMcLYUYsP2vX8go2AbyYtDpKoDk6gM+E5HqYCstSWGnxonQDhjyTgesjUTtnI9AWQdcO/rakYlwRUwrUms4aGh7+r0qv1rfkg8+TLHhHRZXBpGxvf3tSnr5B1MzFiLfF7p7nyNsTYmu3lK/z1/Dd6ypzzfSs+NOrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744127640; c=relaxed/simple;
	bh=p9TzXg3rdx+RjmSTTMtwjqUSJADlzfbHZWlouvRiOKo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=oa/v990qSNwSn4TUQ4xLWwMyrkwtYGnljnM17m+NUzzgAeZ667KJUx8nh3t60uGcBInwJZxhEqBmqJh8LVgHEiYKd+cm45xo+dWHWnwDsW0DmjMaYZ/IIxd5CDVfmyKLIZ4+xSTgiWXedrSC6njKC1aEQgUDh4v3unVl4167bkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YS6B6cbG; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43d0c18e84eso29927015e9.3;
        Tue, 08 Apr 2025 08:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744127637; x=1744732437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=8+Px3MNovGCNZt8UsunlJcPOCLx0kxZ54+UZR9AeRcs=;
        b=YS6B6cbGdNzlWFs+GNxkAonwKCSp5GGHJZYorQfu7jgV7Op/B1YlQHHmlqCxMgM70u
         fSfygdmPG1OniVeu8s03newmiwc4HRXbbgGHi8wHnFjFAwk17k5ScsRzBCooU7AcH1a1
         Ji+QAEkTbl9Xzwo0k7yiPJ5xO8eoShqQ/otLQyEtIXQbw8bnUtkgsNUzrj86Mk+U1+BD
         t7bltxezlBxhNfxkmVBrFHDCKQFLiqSeJnq0PaEN1kyX2vSiFqj8V5g/H4VlLlInoexb
         ot/99spO6XcKG2e6y+Zn5JuPv9vNw0XMAJGPExgQRNvx9hK+/G6P5gNIkmGU3+k0Zclw
         zFfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744127637; x=1744732437;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8+Px3MNovGCNZt8UsunlJcPOCLx0kxZ54+UZR9AeRcs=;
        b=kVZsuQo7rGMzhxqjGYIVN3ShaWI1SIBmmV8ZxbC7GF7sJId5Xl1pV9Ec7Dlft6fiGp
         YIvjf71sORQipKSaop5T4LRnnZJiXQ1B8vg+oDyE2YR2epNUw7XVOhsjCdsKVsKUZ68J
         FtAd27obAQgcG8j6JcHP6YaxQkphc0+eIEb+3LK5dCimpgtT9J4qvkQWqt/viK/w09kG
         Sf5v3nwjD7HUsOyJPsCMOUGJ9bA8DJgWcg0nU57vipphqW91GA5bp2NrhCSC6uq3651V
         Q4MMha5q5V0150lM5oqzB8koIf7tgzSQ+WRZzBwrkCTjCF51p5VALI9JYv8HPamfWs6D
         Nfzg==
X-Forwarded-Encrypted: i=1; AJvYcCVt+h0S+qx7pAwAPPhFR5JBREb+z8ax4Jbgw+nYWk3P56aFyZgyRyGlXeHqnA27Ip3erzHBjbzU7boThtA=@vger.kernel.org, AJvYcCXSVfPMcnxvZudtO728ttvPwREcVRqR7TnW+5xPCu36grQ9RON8RaIQ81yoqoSybZhz6lFsUSEl@vger.kernel.org
X-Gm-Message-State: AOJu0YxKJTLc+Ju6VBPQhMM7hyXChCx07lav//q6tvoycp4TB9VhQD3b
	v4GR3qJbLXfseGtjRpgQx7QFQTiXFVn236/1VARWDj1n1CGAEYLt
X-Gm-Gg: ASbGncvrU26STfihzYbgw4PlrSgZj3JWujidfFwFDSPny+BbQ+XJrPLLdKH6oj0RFyy
	ktJP2oqqTiJkBRD/DDnb4N2cs/vYzBIkDlXQE8HncJeABJEDepzUMT65ZZRC5VvQiMhObHVosq/
	73tKXuXN5qNekmxP/I5l20taTQaU++wlDGlUmJW4NwWNXh1WXCwHsjNEck4Xz5ioX1CYwaupgAx
	/LgE+6/KAgK0BlXk68NjCu1TgaWQ5sdqlGc5C+e1+d2AYnoO50ZLK3IMFDq66dW1wjg4dhKlj9e
	OfHooTWMyGZ43yK2cMe2UwSlGlAWqZmvrsIz8NlUVVft4Bym32myhvOwmsPJe91oibfWol/8ip9
	MaK8wtKiP1jzIhw==
X-Google-Smtp-Source: AGHT+IGKgT1wYnX4U27JAJ8wEuYOxEWRsG9K0AGJer0F6skTSfmVGfZxG8NgmVPLMd/il1PUjm2D+Q==
X-Received: by 2002:a5d:64ec:0:b0:39c:1efb:ec9a with SMTP id ffacd0b85a97d-39d07ad8ab2mr14241395f8f.6.1744127636536;
        Tue, 08 Apr 2025 08:53:56 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-39c30226ee4sm15716615f8f.93.2025.04.08.08.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 08:53:56 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Qingfang Deng <dqfext@gmail.com>,
	SkyLake Huang <SkyLake.Huang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Simon Horman <horms@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.or
Subject: [net-next PATCH 1/2] net: phy: mediatek: permit to compile test GE SOC PHY driver
Date: Tue,  8 Apr 2025 17:53:13 +0200
Message-ID: <20250408155321.613868-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When commit 462a3daad679 ("net: phy: mediatek: fix compile-test
dependencies") fixed the dependency, it should have also introduced
an or on COMPILE_TEST to permit this driver to be compile-tested even if
NVMEM_MTK_EFUSE wasn't selected. The driver makes use of NVMEM API that
are always compiled (return error) so the driver can actually be
compiled even without that config.

Fixes: 462a3daad679 ("net: phy: mediatek: fix compile-test dependencies")
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/mediatek/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/mediatek/Kconfig b/drivers/net/phy/mediatek/Kconfig
index 2a8ac5aed0f8..c80b4c5b7b66 100644
--- a/drivers/net/phy/mediatek/Kconfig
+++ b/drivers/net/phy/mediatek/Kconfig
@@ -16,7 +16,7 @@ config MEDIATEK_GE_PHY
 config MEDIATEK_GE_SOC_PHY
 	tristate "MediaTek SoC Ethernet PHYs"
 	depends on (ARM64 && ARCH_MEDIATEK) || COMPILE_TEST
-	depends on NVMEM_MTK_EFUSE
+	depends on NVMEM_MTK_EFUSE || COMPILE_TEST
 	select MTK_NET_PHYLIB
 	help
 	  Supports MediaTek SoC built-in Gigabit Ethernet PHYs.
-- 
2.48.1


