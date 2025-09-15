Return-Path: <netdev+bounces-222896-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E48CB56DF3
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 03:36:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 872C37AD2FD
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 01:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5129C1EEA5D;
	Mon, 15 Sep 2025 01:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H52uPVwx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF811E51EE
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 01:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757900165; cv=none; b=rEuE3cEI1hvipF4+tV0LGRLRhckIj8hMJ/Bj2We8dfbENd1MmtNZfotBzqU1z4YbN2ifJsuh8U7mZpAPzdqVZnndNJaMR2nWUF6FHCOXt1/n5EFtTFGlByCiE8LqaU2S7LBTQ3/PIha2OXlcAk97KNJ171Q0SKttUTpRNjnPjfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757900165; c=relaxed/simple;
	bh=yb9WE9HIAyoUaW+mI/ekeAWzSZvV44iengjA1skUwN0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=nd+awqWgwdsBulxHcQvFKqgNcvaSctuP1EjP7QZXT9E4S7ZQRvuiWvDoTsQo8l7nTe8nMqu45Y+sdA6oCWQQWn/hX+y/bYxG79ncW0CNTnQKUB8JqhPfTaaI24rKo9l5rzP1BI9n4RLYsmzfKyqi/YPKU95uh8IopOzYW3+tISQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H52uPVwx; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-772843b6057so3045269b3a.3
        for <netdev@vger.kernel.org>; Sun, 14 Sep 2025 18:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757900163; x=1758504963; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=I50PR1sb6c+Kf5/fqciK4isgrfq54NRzC8HjVn10y7I=;
        b=H52uPVwxGaoix0kNnTwzQd5vxIRxQyaHKAKeEgnbIMUy0LPFhOvaLMIjZqnWfbHRuy
         dGijkM33QX6eBCYApjNQcpuqShShqnBcMozcsCv1X2yB5dshOwRhW2WVFwfyTy9K31r6
         q7QyS52/JbWuB59Xx5+4Q7/YVAZRagIrp5GWPDZ2o5vgezUC6XSfIletBCNmR/js4Jj9
         xBvE02HrWfYuW2MUpTs1Bow/F54o+CwOVdxrNer/BRNGVZazStPwD7HT+I3jJ0W2jq5r
         C69o9dh3IjHsblyEd/L86ZxXDhDyM3+yrqKRscEcI5xgpbQW5ZKRSjZDOYJN5eTCgalk
         kntw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757900163; x=1758504963;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I50PR1sb6c+Kf5/fqciK4isgrfq54NRzC8HjVn10y7I=;
        b=hpHehUboFOSh0o6LxI9MjGItxiAS/QYfbKCU+6f0v9WW9UBgsgFRMKfkRLu+dTSuEK
         ldzh4GMxXGT8+AGiMAK0vliUH0VOYfLm8tt+B4QsBUfzCsk2hi/6FdmfiwLuG5IjDJwR
         ZsBwmU/lHmmuMmcYcr7WxDb9G05csE9QC2BhbsbNTA3GfC8bnScV/qs8eekh+MlR2Mg+
         Vkk4Lm5BQUbyhoeOO+7W2ECJh/OKabC2v5Wuzcu26k4O+8UuLzaqFD+PHA3+vzXj3S4q
         LSU0kX3wT5rNY/1g0HnjoZkR1cdBh3CVsuPg48qWO/ztipfKu1sI4MZ4vMwIlDLwTpP5
         LDew==
X-Forwarded-Encrypted: i=1; AJvYcCUzXgTr/qBTOceyuwUCOg/sxML+5Y4KkiDI77O1VF/2ysiY/jyXuUU6rLF4DWt3vUG66OiNg1k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUHFRKyGeFiClk4LCYWzBWT0lDDhrTMkG/MlEQVfrEaFXCZNUD
	s8tsU4iPqGE+QQ7Lx6oe8MRw/Yy5nd8goSaC46yco7kndOHRMB+jugah
X-Gm-Gg: ASbGncu0Wt+I6S7OVkODBk6w/WKjt7bMEXmhSmUub0yo/omCMcZ8WYVMBP6rgKsxBa6
	f0+pKAbE4EdaJEIYCT305Y68h/RCBbHFSc8JuyQ7kpS/n0u2mOYvCkqX05ifGPJAH3i6bWBDnZo
	vqhTr+tdrFdSPwsNCnMWIOXzXUiLeSrYDm2+vVRMZ8Vn7KiYR6WaflISdYGJfC7JEwyGzYbq+zo
	hEP0y9l6efUwL1xDvoSAcbgKu0jttuw2Yp/lzYWQv5yBKEraMrt0ZS3va46BdWmiiZTdTLCZtGF
	3xDLLbMoeiiSrHXmqfz1CLjdqK573bTg62JY5/+uz/LR75xXm07U6Qzd+gzJp3+3tViLTe64N/R
	dP0oJiA==
X-Google-Smtp-Source: AGHT+IGFMVb/wFefQlJrGcNvzhdhqfuAfoI4o9Hf9+Fsprsa+2vUekNuvrmiPLJD2F1qsCnnfwMSwg==
X-Received: by 2002:a05:6a20:2586:b0:243:b190:d132 with SMTP id adf61e73a8af0-2602c71ab5cmr12045312637.59.1757900162628;
        Sun, 14 Sep 2025 18:36:02 -0700 (PDT)
Received: from localhost ([2001:67c:1562:8007::aac:4468])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54b169f2edsm7048640a12.19.2025.09.14.18.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 18:36:01 -0700 (PDT)
Sender: AceLan Kao <acelan@gmail.com>
From: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>
To: Heiner Kallweit <hkallweit1@gmail.com>,
	nic_swsd@realtek.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Wang, Crag" <Crag.Wang@dell.com>,
	"Chen, Alan" <Alan.Chen6@dell.com>,
	"Alex Shen@Dell" <Yijun.Shen@dell.com>
Subject: [PATCH v2] r8169: enable ASPM on Dell platforms
Date: Mon, 15 Sep 2025 09:35:55 +0800
Message-ID: <20250915013555.365230-1-acelan.kao@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable PCIe ASPM for RTL8169 NICs on Dell platforms that have been
verified to work reliably with this power management feature. The
r8169 driver traditionally disables ASPM to prevent random link
failures and system hangs on problematic hardware.

Dell has validated these product families to work correctly with
RTL NIC ASPM and commits to addressing any ASPM-related issues
with RTL hardware in collaboration with Realtek.

This change enables ASPM for the following Dell product families:
- Alienware
- Dell Laptops/Pro Laptops/Pro Max Laptops
- Dell Desktops/Pro Desktops/Pro Max Desktops
- Dell Pro Rugged Laptops

v2. Add missing linux/dmi.h header file

Signed-off-by: Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>
---
 drivers/net/ethernet/realtek/r8169_main.c | 30 +++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 9c601f271c02..1692c38cc739 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -15,6 +15,7 @@
 #include <linux/etherdevice.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
+#include <linux/dmi.h>
 #include <linux/ethtool.h>
 #include <linux/phy.h>
 #include <linux/if_vlan.h>
@@ -5366,6 +5367,32 @@ static void rtl_init_mac_address(struct rtl8169_private *tp)
 	rtl_rar_set(tp, mac_addr);
 }
 
+bool rtl_aspm_new_dell_platforms(void)
+{
+	const char *family = dmi_get_system_info(DMI_PRODUCT_FAMILY);
+	static const char * const dell_product_families[] = {
+		"Alienware",
+		"Dell Laptops",
+		"Dell Pro Laptops",
+		"Dell Pro Max Laptops",
+		"Dell Desktops",
+		"Dell Pro Desktops",
+		"Dell Pro Max Desktops",
+		"Dell Pro Rugged Laptops"
+	};
+	int i;
+
+	if (!family)
+		return false;
+
+	for (i = 0; i < ARRAY_SIZE(dell_product_families); i++) {
+		if (str_has_prefix(family, dell_product_families[i]))
+			return true;
+	}
+
+	return false;
+}
+
 /* register is set if system vendor successfully tested ASPM 1.2 */
 static bool rtl_aspm_is_safe(struct rtl8169_private *tp)
 {
@@ -5373,6 +5400,9 @@ static bool rtl_aspm_is_safe(struct rtl8169_private *tp)
 	    r8168_mac_ocp_read(tp, 0xc0b2) & 0xf)
 		return true;
 
+	if (rtl_aspm_new_dell_platforms())
+		return true;
+
 	return false;
 }
 
-- 
2.43.0


