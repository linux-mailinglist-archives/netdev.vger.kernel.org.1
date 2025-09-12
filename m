Return-Path: <netdev+bounces-222443-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0820B543E0
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 09:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1A8C6849FF
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 07:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 979B22C2369;
	Fri, 12 Sep 2025 07:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L/BjyCPo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7754D2C21E7
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 07:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757662189; cv=none; b=SeH8aSgGu4ed3dH95DLHwdHxQoSAobQQ4Q0cTyQLaIopqAMs8RLKtVpCqUYjeey9im8Wu3E0SUX5/RIerJ++oL+oHoZKgqdoP/QfBRv6xsvxmMShPrnH7pJGl68qk4SGJc592iQ6NT07XB6ukqwjQsfQ/pl4+qeWwg9Wcy2TWGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757662189; c=relaxed/simple;
	bh=24gKbmpZi/9Rh7t7JIuJkgy+kYSzfVfk0Br6AQTuA4s=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Lb2GsCSk7X2G0mpfIaK9hQOyQACA0RzJ1Ke0n6TKurzVUY/FQXz0Tkl5NQ1Yr59ye/TWuRuMKqlj8y7iR1oDAq02k1HGIGUFe4AnVg1jbS4CJnGNO7pRUMBbcMWQHttYYLf9veQM1zBNY3Lox2aPzcn33LH7H9xSUmzudUePtqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L/BjyCPo; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-80cc99fe980so150325885a.2
        for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 00:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757662185; x=1758266985; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=I8szgG/sO6WMFzNe8UNeKbJn6avdSRrf05268GJd8/Q=;
        b=L/BjyCPoCUcpMSZOyz4ycOrRn+ZF4QrIfKxhRROvhbVvcWdqhzWf0U4rJx6rSwLjja
         1gc2PR1xMQjHFDvCt2nipuBKhEzRVfFbhUDwGTU2AO68pXuVrLJggWJV8PKtnc0Sd/Wq
         tAsUmcfqqMfYIZ5+b8GKhsigSPJDsM6p+SZQGWH/1F6iZ6uxC7XrsKcoCMl/l204XG17
         CI40JZOkL6AW+u0YuNm596J3bqSiaVJrySki7jEhp/k40SZo/8fycnI6sXVp0AXViaKz
         g0yTQX0tDpSMLF19JAuAZAfD7zFDlVLbcuDLn9n8+UsAFxEo+bf06MueVOquyk+azx0q
         NY9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757662185; x=1758266985;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I8szgG/sO6WMFzNe8UNeKbJn6avdSRrf05268GJd8/Q=;
        b=VP+ScYwQg//kIiQ7zl071JfaRlTirYhbOxXDfIR/otExis2PZAjb/HRljcwUtIohRE
         8CL8ROsACLiJWaThzFBlzNeYYfZmEg8pqfXref5DrI/mbWNCP3fKe1vw+hMJ6TMFQpRm
         AAaI7065l/X6MjkSA1iPsz2a1Kqa18j1H+goreCGHJ16r4dywXlE32m//aqSr0Xb71Mb
         Os8WvKAAhkv4NLC2Qt0Q5VaPixt+oyXl9E0sOtc/SwZy2gIvLnvtw7zX+IIPjLJ2HqIX
         a4GKCtE8ezwVkSXLpEJCl8R5OYzcOwd+3btP9c/yBcILkLElTKjPIXOiHoIEpXiUEsV8
         szeQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZ1MUjUHKeaZwzlP/1SD5hW5wFdXppoBh1zJBbQjOQkluOD8DfCd7ItxTCyxqdcXyFZMDVmEA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJh9XE014gKXz52kO1n9fplSHupAiLq3bhX2G+RFiorr2NkMSi
	/IWkn+alwvIp2kcY45vuiMDIvTrVpT8/CmlSlL5L3P/qxNHPptHFcch9
X-Gm-Gg: ASbGncvoyjLo9Aa4BvvInSFBxUY3NtdvEEHacCpGilEoNAuBEMCtJR4VK/20BP4MRJo
	3LYocOg7LWGxhJ7p9lTnWemEDjO/CpuJCVF6jOawKCQdkl/ZNikdrtSAU3j7Bl77msum1YXyPVJ
	j9fnMhyfMLQbftti1vKz7Aux30VzhP2fPPazW+U0oEPR4Epvtl0bjUN5URIp0Uv02IpYj1ZoSdu
	P6/88Y8bj5pW8zjmuim29cUsYUMlhRTmdhX7XI8XoCqFPXwf5aRchzELaqSeUaLvxayZby2+49U
	AK+WIzrMj5OeB4RvMDIq1mQtuhYunVR63rj3ZY+iOWAMC5aVF3CsniX0aQ9TvuH+MlZP3onGwIn
	8v8TGmquo5vQyonh09TnUkZmeaNeq1WmQTjEXdLyzS6c9d5AfSys6FtCRmvyBzq4=
X-Google-Smtp-Source: AGHT+IFYnmneqniwknQ76UBKqo2PVhyjtQdkT2E4yuv0BYQEOJJbrJdzPVSzVNSCK5I9g6ZPYhPGuw==
X-Received: by 2002:a05:620a:4689:b0:811:f4e7:c7f6 with SMTP id af79cd13be357-823ff6d68bdmr250731885a.48.1757662185273;
        Fri, 12 Sep 2025 00:29:45 -0700 (PDT)
Received: from localhost (211-75-139-220.hinet-ip.hinet.net. [211.75.139.220])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-820cd704508sm226655285a.45.2025.09.12.00.29.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 00:29:43 -0700 (PDT)
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
Subject: [PATCH] r8169: enable ASPM on Dell platforms
Date: Fri, 12 Sep 2025 15:29:39 +0800
Message-ID: <20250912072939.2553835-1-acelan.kao@canonical.com>
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

Signed-off-by: Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>
---
 drivers/net/ethernet/realtek/r8169_main.c | 29 +++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 9c601f271c02..63e83cf071de 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -5366,6 +5366,32 @@ static void rtl_init_mac_address(struct rtl8169_private *tp)
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
@@ -5373,6 +5399,9 @@ static bool rtl_aspm_is_safe(struct rtl8169_private *tp)
 	    r8168_mac_ocp_read(tp, 0xc0b2) & 0xf)
 		return true;
 
+	if (rtl_aspm_new_dell_platforms())
+		return true;
+
 	return false;
 }
 
-- 
2.43.0


