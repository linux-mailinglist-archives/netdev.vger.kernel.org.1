Return-Path: <netdev+bounces-177071-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 32FDCA6DA8C
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 13:57:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D9787A6313
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 12:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02C1C25F7AF;
	Mon, 24 Mar 2025 12:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hnGdIw95"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FC625E47C;
	Mon, 24 Mar 2025 12:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742820991; cv=none; b=KFssJdKOhi3HUkwIxNszVRBamSW/vMzRaOqso1WECHW/3XjLLIXx+ZhugHW9G6Ete2Mx4vEIrDO2FVzr2hGkGBcigr5JP9KHBiB1jOeJQhHqcS6MWGZRKIagnFQ+g2jkDTrSZxNMmkFuO4j3jf65qGjEb018PDMhp0nrn17qE8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742820991; c=relaxed/simple;
	bh=ezGvbO1wqUoNHwv+PN6VCungnRScJm/t4mGyq5mDsTE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aMlPdksYyy21972xDZ1u6bF0bZTs+5nKE5GI2azvJtfqyr8u6w2cgyq9ilITIcNYeeekD0pSTgABUV4iitSaOX9IQwY0w3heMwc87qD81EWpyrJ71xMsv3OKDnRXIYtjMH8lJwkI/eGcCb2MemYyJZTFGi5UpVMxgto4Vt5ogJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hnGdIw95; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2240d930f13so7846015ad.3;
        Mon, 24 Mar 2025 05:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742820989; x=1743425789; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zxh53Yydk3txbsGDbkvLklPCWbXYfybueW5aMTdDXaw=;
        b=hnGdIw95IZgqiH/s4AcEJvoPUUlzx7Xmxgq1wetjzxivoqFQSjHCL4AjWqcDbqJob/
         nILRTbKyYN6Mlc95VBFXdw9mvTGuM0tIzk1EcHhbaRed1z1ERCvoyfQ/iPd+Ubnzj4CN
         D39oqjyMck9WYbQpnqTp08699xQzcqjFQ0oGOyHPVJqPyRz5X7QVXh1+DNaA0rkLUvjV
         NkpAZQsPDxABnsMxQguon9C6loIBDyAuQIEvFxiNtu9ciYqQJMKg/7IjJ9D3nMGdIbGa
         Qr1SiVCXeYHpGsSzxiEWACnU3AcEbotJsVIXWOKZv9dDDPXJTYbcoS9o5YpwImBK0OH4
         84QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742820989; x=1743425789;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zxh53Yydk3txbsGDbkvLklPCWbXYfybueW5aMTdDXaw=;
        b=HXlHAxkIYTeYRVCM0ipa5vQnU0d9knFFj4U0STsDrnwDabrbmghDe5umgFZo3zD70V
         rm2k1g3gY7juxCtTR2Kq/yYivAYJMAMBEGWHvnC09i8lo8McZhzxBR/6W2aOOxtIIJq5
         y287HwKerJbyWmffHh9PzdG5YglcnJgaFWPY0Anoiklq5Dwp4z8PnETNcY+YrwiPJ8E4
         ZFpykqG2Rst1FV/6Pe/nWXZy3zo2N68YhqFSjgaqk/2cDgov2cFCJEE1f5CVHoFJx5VC
         MqtYD6pAJh8uhodFoPGKXN9PU4mTmK6FDv1ptIoHpbPsJlcmQ7R/eYTVGkIplqNJPztO
         Bv3w==
X-Forwarded-Encrypted: i=1; AJvYcCWN/1ntPsARgJ8GVIZf1tp3/ZEmkzGLeW+gprB1ETN6JdLA2scu/sdhx8vZOh3vC6LnvpVj/1KH@vger.kernel.org, AJvYcCXom/unPKpLgZo7Mn2GhX+XIumcXtzF8H2gy6UBKXcq6iNSb5+mtFim5Cwl+Qs2OI8NFNMVihZT+ioRDvE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnLefX4bC0FD4rkoWpf8TNs8SCJ72YNFYL8PXMeiUbvJRM3eOy
	esCuAOVWVly6v90EMHMy1rn4NIca4db1xlWICKNIAVIPh11Sg75AzDJIuRUo
X-Gm-Gg: ASbGnctojP7KKjs4aF+R+vkQtKIXvX2PMAJpEIg3+5rsJePcST9bz4LGm1VR2OYAkyp
	yyEcRtJL4Yf64wGFvBddIXvLEBczOL+6OGtdzkedfBkNEdDYp5a9KrWsBhNnOB/CxloIXbdUn8y
	G0gJPqF7XG3vFq8VbVjqGL9bMu/4wE8rz/0PKCkzm387X8t5tdr6dnwThPXaEzoovtYbIzWYzZ0
	F9wMLZJeW8fWy3TbUCHFkM+WF28JPxR1YKpGcMLVx+o0+SPXuvVQ6DRmS04cKq8XSH7NhkDvdVV
	tYTKrLSgUnQcil5SFb/DNosdsl4MAl2R88HcXKJ/e3I8nACAPJ5PmfwqtyDC/XQZdbJXe1cBWTC
	0D9juSwNZ
X-Google-Smtp-Source: AGHT+IELD3OXpCg41ArCduhKMvNWj039uDftBpiIIy4uFbX+0C/gGjBEXV3FiTVRks/a2rOSsAVzJg==
X-Received: by 2002:a17:903:2306:b0:223:49ce:67a2 with SMTP id d9443c01a7336-22780def8e7mr75066035ad.9.1742820989397;
        Mon, 24 Mar 2025 05:56:29 -0700 (PDT)
Received: from crabo-Latitude-7350.. (1-34-73-169.hinet-ip.hinet.net. [1.34.73.169])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-227811bafabsm69308745ad.139.2025.03.24.05.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 05:56:29 -0700 (PDT)
From: Crag Wang <crag0715@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>,
	nic_swsd@realtek.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: crag.wang@dell.com,
	dell.client.kernel@dell.com,
	Crag Wang <crag0715@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] r8169: add module parameter aspm_en_force
Date: Mon, 24 Mar 2025 20:55:19 +0800
Message-ID: <20250324125543.6723-1-crag0715@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ASPM is disabled by default and is enabled if the chip register is
pre-configured, as explained in #c217ab7.

A module parameter is being added to the driver to allow users to
override the default setting. This allows users to opt in and forcefully
enable or disable ASPM power-saving mode.

-1: default unset
 0: ASPM disabled forcefully
 1: ASPM enabled forcefully

Signed-off-by: Crag Wang <crag0715@gmail.com>
---
 drivers/net/ethernet/realtek/r8169_main.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 53e541ddb439..161b2f2edf52 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -35,6 +35,10 @@
 #include "r8169.h"
 #include "r8169_firmware.h"
 
+static int aspm_en_force = -1;
+module_param(aspm_en_force, int, 0444);
+MODULE_PARM_DESC(aspm_en_force, "r8169: An integer, set 1 to force enable link ASPM");
+
 #define FIRMWARE_8168D_1	"rtl_nic/rtl8168d-1.fw"
 #define FIRMWARE_8168D_2	"rtl_nic/rtl8168d-2.fw"
 #define FIRMWARE_8168E_1	"rtl_nic/rtl8168e-1.fw"
@@ -5398,6 +5402,14 @@ static void rtl_init_mac_address(struct rtl8169_private *tp)
 /* register is set if system vendor successfully tested ASPM 1.2 */
 static bool rtl_aspm_is_safe(struct rtl8169_private *tp)
 {
+	if (aspm_en_force == 0) {
+		dev_info(tp_to_dev(tp), "ASPM disabled forcefully");
+		return false;
+	} else if (aspm_en_force > 0) {
+		dev_info(tp_to_dev(tp), "ASPM enabled forcefully");
+		return true;
+	}
+
 	if (tp->mac_version >= RTL_GIGA_MAC_VER_61 &&
 	    r8168_mac_ocp_read(tp, 0xc0b2) & 0xf)
 		return true;
-- 
2.43.0


