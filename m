Return-Path: <netdev+bounces-181184-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EB86A8403C
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 12:12:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45B769E8236
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 10:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D70027703A;
	Thu, 10 Apr 2025 10:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KtOVvpn4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3003C27C154;
	Thu, 10 Apr 2025 10:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744279481; cv=none; b=fdjd7wDWMoH4g8nCCLWTWNs2WxRzrck3emceZFxXn4abVBGWCp1I+EX9aOrogIqhaXfUfvc6ndjHPQtQrTchZYW/gI6DTY/QdWr0KqPxM+sVzea1SayccIVJ1E52CuzFRmxFSjdEIchKzgj06uepsbLUvnVr7BRnNHYVbcJR78U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744279481; c=relaxed/simple;
	bh=53aga9KLw7CyaLcjpeYJsQ9Pcd736QUc9PfvgXuscs4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=XGw50gyZJmeLb+jOaRuljfXy4cn7Lgs3SJy+ZEofTCbp+jJoFILLbU21qdVb/ZVtANil6y3h9JSWEoTQS+9mfr4PeZB/QHf8PYwtTLrHc+cOv2T2EsllCPoMi3lkoGo4qUjd5kdjVQei9QnMxrlMjKSRNYgarHMOaNmXfCvIcAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KtOVvpn4; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43ed8d32a95so5518435e9.3;
        Thu, 10 Apr 2025 03:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744279478; x=1744884278; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=OSjX1b+D+//GtnfnALVS0VRTFNxvnCOVfJgFbEnwUWA=;
        b=KtOVvpn4T+oO7sopHK1KZ1352//Bibg/YBmvGycFA5GR31zp4gSqCVB4Us381Jh0qo
         BkdFb42U6jgFQcAJl5WLalmOVVrMtMwvWQtR2yKZgY3wAKVbvGU+PpD1jmHI+A4wc6l2
         qTNRyhI/JSdffNaLbec5GaA7r3iizPGUhncT1mq/H04PYX+1aLu1RYCVjXm6+8xuEnJU
         KO8yNdn3Vrj+vf/eiGt6V6U0tiuColrI8lHiLU8iM2IxE32UuzbSoHyHa2OLJ6DxAxYf
         yz76dE16G8vWT00PknPDx6aYKCO3pUN1VvyGtmM9MJsX31Feqk8qDnZmSOcpGlswe1SV
         vFbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744279478; x=1744884278;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OSjX1b+D+//GtnfnALVS0VRTFNxvnCOVfJgFbEnwUWA=;
        b=FJIavrGAgUm0YRyns9y1i3ZChkmckRKGVcLN2sEqZF84Ulz662gmwMd2HIVQ4ESX15
         N+4zpjsaOWrnUZX7nUzxNpa3o/ha7I/SNtB+Q28UL6Vym9B79LBdkiG45CD2p5aOv+RE
         pkD370J5FiewlstIQTfNa6tpulDYyEj/tTE1O8Tjiq4n0vG8lR+w39d1DuS5kn739+gB
         2ZFyEi4dAYIkUF+duhxJVS4Mvkx1acTJ9HqWFKyhctolOtOd8xaLspH4qA1VtVJuE1LO
         /K74m5OdlGABqeIZDvvAN2s6+61jOPnYH++0UMlVzTawF4lPy8nEVxuR/WFYRUkwXkKq
         FVKw==
X-Forwarded-Encrypted: i=1; AJvYcCURy0Xz5CZRIJH8zPLBR5XPiiH0SrK6ONWxH7nOJ1hzz1yAN/87dcVoeV2WwMmYQ6iTL9fQgHldPe8mspE=@vger.kernel.org, AJvYcCVtOPikzZb9BCh/REI7a3yCFKnLxsNtVaBunQA/+aNKVlEF+w5bE4TvGk+DGJonxtPgvrQ0J59J@vger.kernel.org
X-Gm-Message-State: AOJu0YwtLMpVaizN8OoasiPprYcdIF0oQHmKXR7NHf/DsitgPqSfs5Hi
	Acb+YUEqN65l9EQEt9TKeiwDP9rmq0+/DoaQr+Y73v78Laaje0iV
X-Gm-Gg: ASbGncvXIr2Xes4nZcikQUv9XgaY4AOco9N++QajfFX0qgBPqNd5eayyMWcJRMEuoH0
	SMGUNm/eAjTqLKC54ouGxcnZsoR4anONTpslLLkFbdNlGcyfnZKaAK84ehixxFAENewE3K8mJD1
	anjwUoqvb6FpZV0YzGr/Ereo2y2zYPmCtUdTBdrKZ7jIo3xKbIAZE7jTeaKjOCEHMjNWX4IEBUI
	B+uoO3EnW3BG6gIhFEkooX6DFPRzO/oOGAZltrWPgaRLokrDR1ZXN9UlqBRaX2mN41R4PC4OW8q
	UiWU6EUflfFJZnG1dd+eJ6c9xJZ4e9YA9o2kObrS3QfNuLJJIrq8a6YmDy8HKDsPWJ6WR7Zigx2
	ZoPch1TkfGg==
X-Google-Smtp-Source: AGHT+IE9rkx7s3lGoXoLv/0fYUbWZ4s7nji/vh3GglXy7KHxv51ZdIrScMmpN4ZbQ9rN1ZnOv01rZg==
X-Received: by 2002:a05:600c:4ed0:b0:43d:7588:66a5 with SMTP id 5b1f17b1804b1-43f2d9a12bcmr24466125e9.31.1744279478201;
        Thu, 10 Apr 2025 03:04:38 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43f2066d109sm50193065e9.20.2025.04.10.03.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 03:04:37 -0700 (PDT)
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
	linux-mediatek@lists.infradead.org
Subject: [net-next PATCH v2 1/2] net: phy: mediatek: permit to compile test GE SOC PHY driver
Date: Thu, 10 Apr 2025 12:04:03 +0200
Message-ID: <20250410100410.348-1-ansuelsmth@gmail.com>
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

Fix and simplify the dependency condition of this kernel config.

Fixes: 462a3daad679 ("net: phy: mediatek: fix compile-test dependencies")
Acked-by: Daniel Golle <daniel@makrotopia.org>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
Changes v2:
- Add Ack and Reviewed-by tag
- Address suggested dependency from Russell

 drivers/net/phy/mediatek/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/phy/mediatek/Kconfig b/drivers/net/phy/mediatek/Kconfig
index 2a8ac5aed0f8..6a4c2b328c41 100644
--- a/drivers/net/phy/mediatek/Kconfig
+++ b/drivers/net/phy/mediatek/Kconfig
@@ -15,8 +15,7 @@ config MEDIATEK_GE_PHY
 
 config MEDIATEK_GE_SOC_PHY
 	tristate "MediaTek SoC Ethernet PHYs"
-	depends on (ARM64 && ARCH_MEDIATEK) || COMPILE_TEST
-	depends on NVMEM_MTK_EFUSE
+	depends on (ARM64 && ARCH_MEDIATEK && NVMEM_MTK_EFUSE) || COMPILE_TEST
 	select MTK_NET_PHYLIB
 	help
 	  Supports MediaTek SoC built-in Gigabit Ethernet PHYs.
-- 
2.48.1


