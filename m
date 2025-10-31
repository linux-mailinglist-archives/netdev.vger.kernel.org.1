Return-Path: <netdev+bounces-234552-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F01C22DF9
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 02:25:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3F2A14ECD2B
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 01:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD27267B15;
	Fri, 31 Oct 2025 01:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UEJlVjwG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5282225A651
	for <netdev@vger.kernel.org>; Fri, 31 Oct 2025 01:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761873905; cv=none; b=e5DpIbNTLlQrXLn3ZMjcuTjFxI90O2owoy+PRDdird73/S3tI4Dv+QXbrHK2KdEBgzHDgf0VbMAfUZCW0ESApxC6sMofpaqyGH5WmnuS2pK3VD4SK6eEYOisMXXnXIYeEeSbQT1Z3aPmM22XGLDJ4QoHOxLgbfFjasSWz7TrRq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761873905; c=relaxed/simple;
	bh=0Gc5dl3tKjIa0cqiPh9kEaz9Vhp5pPIGlpBYanSqi3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BsPNfJJvWmJcrShf1f2UG7X3PShGs4oas0mo0JVxlBap8Ul/qv5Y4Ak1mXLMN/OeBSYLevlqu41I15ZbC2UWF9pPPmyuCzHviOw8MC/3MuEiQ7FPd0MzMoZaqgmKtjIMVdI4I0HzwEXRtRWpZHRrWwpPAWQi3MRI2zJmba6DdxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UEJlVjwG; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b4755f37c3eso1442603a12.3
        for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 18:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761873903; x=1762478703; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=41C7JOVgrQjYgPjIau43ZnUjOEp2Qu+RhNpr65HbzYc=;
        b=UEJlVjwGhnOf5TnHclv/NXqsUUZEjX4xL55Y4GmFZkiHCluVDlksjxcGVqbjMchU9n
         GEBRdF1RHFk6ogz2n6NDzwrqmqNd+oH0M/wnJSGeJvL7MP0giWTylUbvD5+upWcV/6Yj
         353+jj4LL+nVMajbH7wBxa4GkG8K8ndVabO+C1rSL4Yqt1ehH8ejUBoCclRI8sqeGJwk
         axvqqMOkrlg+EcHPPYl9iNWkMO1+zbnEsGYjBqyBQqeIrVuBuKOpFm2kJ1OWWhwRXesq
         Mzjq9SQ14STKmwRBeeZIYHPhLLCNBgNmjULBIiKI592N/l/66J0rm90bk4KmZP/Fc9tA
         4//w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761873903; x=1762478703;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=41C7JOVgrQjYgPjIau43ZnUjOEp2Qu+RhNpr65HbzYc=;
        b=GsswMyfcZe1A0p1aXsCOhA9bft6hcQElFbrwBhA+faA/shRM5vk6O1ybsW5JSN6TnG
         Zgnir85SdzfPkJ0RmPDCfsdBFJLZjyr0Lu9NEbMBnhcayxSMFi1OUqgJjUWHJfZ+46S7
         alAErxADbGvwwa4+4y9Jo5c2cLj58Hnn4UdjkWwg9SvlkD+5zo4+F5XaGwS0X2cMZ2Cd
         mPezyfIVbqF/CGE0yiDv5LaizhSGIOSwyOBRG4selEdjhQQrbkb8gx3HOJf+ffcRp+Tw
         nJdP81Wq3HwvyUsIkguNW3PtQH0sXDUSP1aiHgPsEWM7hrKzjRgp9S6hUvf2r38ikBfd
         IBEg==
X-Gm-Message-State: AOJu0YwfKk1xH0qUMYdzhgTbtllkESnaRePZXCwK4vIYvyzqlghWS7qr
	9Fzds0Vnv9G31OXJiXHvRia5LSmjJqnJg75JH3hT+M9xK6zHhsEn2JVG
X-Gm-Gg: ASbGncv0b8N3lspMBkvJsaW/8j3yguXq68vBCZLkFMad7J0jmUMODym5Gy9jnlF/ptN
	AFFMDF233jQt20fW5s7PxV8sSk2k+qoetPcz7W3INSjGI3fBNeb8Q8SHrdz5sGpfF9WMtbNTyj3
	ylBNbaawoCUd9p58AdZSHnxicpEjig9PluJ1aw7wmdEs16w6+c5DkhKQO/IYbhKNO7xbIpsINrj
	brwKOuOVTNJaESt+bHvO9bcV/jFwfIWGxA3Cmzry8vLxmYHuMG3WGDHamdfRDfkLDBXtjQ0n4iK
	QHarFC+twpW27fZSZPdLmy9zwyqFga3QvlhRG1aVpqpspMx5cyX86a5+HKo0aPsg3P85GeS/2JH
	TyxusQFDHNMdJ7HHDCeWBrU0TBBQCrsdT+BnE7rquXty5zZjEqpG89hQmiREcgeKy407dDqwziy
	M=
X-Google-Smtp-Source: AGHT+IHwNetbUfw9P+CF7flRnUxbKMyy0u3v4NGRme8B70TIIYaaZvAcpehaNR0ztwmyhfdRon+uhQ==
X-Received: by 2002:a17:902:c94d:b0:295:164d:cebb with SMTP id d9443c01a7336-2951a539003mr21231175ad.47.1761873902502;
        Thu, 30 Oct 2025 18:25:02 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29526871836sm3248465ad.18.2025.10.30.18.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 18:25:02 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Han Gao <rabenda.cn@gmail.com>,
	Icenowy Zheng <uwu@icenowy.me>,
	Vivian Wang <wangruikang@iscas.ac.cn>,
	Yao Zi <ziyao@disroot.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH v5 3/3] net: stmmac: dwmac-sophgo: Add phy interface filter
Date: Fri, 31 Oct 2025 09:24:28 +0800
Message-ID: <20251031012428.488184-4-inochiama@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251031012428.488184-1-inochiama@gmail.com>
References: <20251031012428.488184-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As the SG2042 has an internal rx delay, the delay should be removed
when initializing the mac, otherwise the phy will be misconfigurated.

Fixes: 543009e2d4cd ("net: stmmac: dwmac-sophgo: Add support for Sophgo SG2042 SoC")
Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
Tested-by: Han Gao <rabenda.cn@gmail.com>
---
 .../ethernet/stmicro/stmmac/dwmac-sophgo.c    | 20 ++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sophgo.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sophgo.c
index 3b7947a7a7ba..fcdda2401968 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sophgo.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sophgo.c
@@ -7,11 +7,16 @@
 
 #include <linux/clk.h>
 #include <linux/module.h>
+#include <linux/property.h>
 #include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 
 #include "stmmac_platform.h"
 
+struct sophgo_dwmac_data {
+	bool has_internal_rx_delay;
+};
+
 static int sophgo_sg2044_dwmac_init(struct platform_device *pdev,
 				    struct plat_stmmacenet_data *plat_dat,
 				    struct stmmac_resources *stmmac_res)
@@ -32,6 +37,7 @@ static int sophgo_sg2044_dwmac_init(struct platform_device *pdev,
 static int sophgo_dwmac_probe(struct platform_device *pdev)
 {
 	struct plat_stmmacenet_data *plat_dat;
+	const struct sophgo_dwmac_data *data;
 	struct stmmac_resources stmmac_res;
 	struct device *dev = &pdev->dev;
 	int ret;
@@ -50,11 +56,23 @@ static int sophgo_dwmac_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	data = device_get_match_data(&pdev->dev);
+	if (data && data->has_internal_rx_delay) {
+		plat_dat->phy_interface = phy_fix_phy_mode_for_mac_delays(plat_dat->phy_interface,
+									  false, true);
+		if (plat_dat->phy_interface == PHY_INTERFACE_MODE_NA)
+			return -EINVAL;
+	}
+
 	return stmmac_dvr_probe(dev, plat_dat, &stmmac_res);
 }
 
+static const struct sophgo_dwmac_data sg2042_dwmac_data = {
+	.has_internal_rx_delay = true,
+};
+
 static const struct of_device_id sophgo_dwmac_match[] = {
-	{ .compatible = "sophgo,sg2042-dwmac" },
+	{ .compatible = "sophgo,sg2042-dwmac", .data = &sg2042_dwmac_data },
 	{ .compatible = "sophgo,sg2044-dwmac" },
 	{ /* sentinel */ }
 };
-- 
2.51.2


