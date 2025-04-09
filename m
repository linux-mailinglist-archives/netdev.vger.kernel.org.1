Return-Path: <netdev+bounces-180926-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81130A82FFA
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 21:04:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FA2C17D57D
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 19:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CA0A253B46;
	Wed,  9 Apr 2025 19:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EFfetcDU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFC326FA7D
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 19:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744225494; cv=none; b=nNetP9Vfd3hYCFokKjwP6M0tEXgmhiVFtvE6zkntGaS2A7vRKvmxrpFdwYw146Tc6Knlo1yeNT0YuJ3k4BRz65iie3PjBE2FO+v9k9Ro5SiwV9cXQH5mQQw3UDL4srgs7zoYHpPEAngKiX5BbumZkh3Z3WFXEXVYYqSRPWmsDFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744225494; c=relaxed/simple;
	bh=//q1LS5WEdOilDT6wEnyL33+dds4nyrqCEah+xpaSOs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=hcz/h4A5cMfBdf0FGS2AtVhZ3i1KxQ7Oc/Tx47iXwEGzHoTGjTL0SwJ11YMnPOY1KTbXpNmElulxu64BLqANTifUEv50gqSFsFKbcYR+CG2zfMyNxA7piD2WvpP67pyWyHSZzIgGxkQdjtaCv23oCPXM749iXho+RvTHbB1b0zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EFfetcDU; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-39c2688619bso4499785f8f.1
        for <netdev@vger.kernel.org>; Wed, 09 Apr 2025 12:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744225491; x=1744830291; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:content-language:cc:to:subject
         :from:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=luu8YWj9y19iF4SSN+1kuvaQmQlQs97ej6hpEWaXKPk=;
        b=EFfetcDUmM4it1UBrDnTJlUPk6EzJmyHhweqzFoq0O3xOQIUGNV/50b1LoIA8IbF57
         mvLIAoa9oP3K9ctX80QJxJV93wtGHgcXVkAVELOzHdHKRT2Zed9pKjdMPxcDi+3zSG4X
         smNPIxIKdUxNYID+6hA9kAotTApoOyRf0447gUL2CjG4ChGuLvcbEJb7XmwvLXB7uC5z
         XWfJWTXDwWFkzqGPqTToyybvrOt8GyTeOmyW1pVrK4xMtEAT574N2kC6XHOTidK1/6h0
         D2tS5eTFRLf7Cc3KRBZBXUdWHCsNOPBq6otagxGx0KxmwhdaFcF59Wk5T6irqOCr0ZJA
         g1xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744225491; x=1744830291;
        h=content-transfer-encoding:autocrypt:content-language:cc:to:subject
         :from:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=luu8YWj9y19iF4SSN+1kuvaQmQlQs97ej6hpEWaXKPk=;
        b=F794OUQGpjY39ZpIZm24wdTTCYj06prnxsko5TyA2jA8bHWAh1crZYSiJMnD2vG6M/
         305ovBgK4bTtuS5rP2XhQ+q/mxITQ1gmtsavWeL9tw1iFHY4fgUIhubIdACRANO979K7
         1oKOxgXMRxdjaKRTO8NrYbovro4g00bJq5ioPruZyucrMMQIa6dj6OC5jUTw6thnv546
         S+JAga8GqhPbiKXZx7+msSsUQ5zB7a5JZa5q44XQSBS7DhTeVhVoAxEY70BaKlhOpB1b
         v2WD1gnZGBJ1XjGSD6nkHSm9sHM1w2HkgzXdig8a206W7JvTUyhQupzMU0Y+BRzohTJu
         L3Ng==
X-Gm-Message-State: AOJu0YxSfAa4RR1Fl1pk2V0mv3IszVo6l3Iu2uuMl4Biwm+L+pY2jvF9
	jjPbHViZ93/VyS3cDfuYzuGctEecC0+UDrDhxv8wdzKbi3NsdjTt
X-Gm-Gg: ASbGncu8RN7CU3fP14iFxhIvRCB4IVaLgQA1YCdsS+wn8d7o9nUwJRK1HV0AtdQ4pEf
	5efCJAFWVpWkgQ36ik5r+Wmf/EaKynZbfdYyLTRZ96PzRNmK3tRwUCFWgNRpTZ0lfyE3tsGVZiR
	f/aV0njyp6c+9aIW8q95ROxxoIzbHmWwQgV6lB0oEsdZRvNazVdH1rCQptzEuw8mgfsQcfPYkoW
	R2EiGcsOCimNfB/Yd8K/LLwGV+4lQ0n5mG2hREo5Ic7g6NaUMpUkaxqhFlJdeC5HEH6/DiTTarJ
	XIR7TsfEGhlDX7eEBma37szxBzOmap//EoyxKB5K3OHCnZ8AK/nm3QfSLr7PoXakml5jy2DxF5b
	7TJT40eMiqG+pRU20kTsaTZoVL2MUx1ZakEeZNwZomwLKdJx144+N0BiBp6cExv/WN6M/b6G4Rm
	2sOTHFs8nTtQQfT+43bfWSFSOT120tzKY7
X-Google-Smtp-Source: AGHT+IEnTo3YuhHbREU/S6fYVgQ0R1TH9bkOu7znU0c7NHYqfqn/wG0zkG0mJ18zJy07X09SZz9SEw==
X-Received: by 2002:a05:6000:400b:b0:39c:2688:72a0 with SMTP id ffacd0b85a97d-39d87aa89afmr3805697f8f.6.1744225490668;
        Wed, 09 Apr 2025 12:04:50 -0700 (PDT)
Received: from ?IPV6:2a02:3100:9c75:6000:2d50:87f4:9992:caad? (dynamic-2a02-3100-9c75-6000-2d50-87f4-9992-caad.310.pool.telefonica.de. [2a02:3100:9c75:6000:2d50:87f4:9992:caad])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43f233c817dsm24612045e9.23.2025.04.09.12.04.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Apr 2025 12:04:50 -0700 (PDT)
Message-ID: <b368fd91-57d7-4cb5-9342-98b4d8fe9aea@gmail.com>
Date: Wed, 9 Apr 2025 21:05:37 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next] r8169: add helper rtl_csi_mod for accessing extended
 config space
To: Realtek linux nic maintainers <nic_swsd@realtek.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Add a helper for the Realtek-specific mechanism for accessing extended
config space if native access isn't possible.
This avoids code duplication.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/ethernet/realtek/r8169_main.c | 26 ++++++++++++++---------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 4eebd9cb4..8e62b1095 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -2852,10 +2852,23 @@ static u32 rtl_csi_read(struct rtl8169_private *tp, int addr)
 		RTL_R32(tp, CSIDR) : ~0;
 }
 
+static void rtl_csi_mod(struct rtl8169_private *tp, int addr,
+			u32 mask, u32 set)
+{
+	u32 val;
+
+	WARN(addr % 4, "Invalid CSI address %#x\n", addr);
+
+	netdev_notice_once(tp->dev,
+		"No native access to PCI extended config space, falling back to CSI\n");
+
+	val = rtl_csi_read(tp, addr);
+	rtl_csi_write(tp, addr, (val & ~mask) | set);
+}
+
 static void rtl_disable_zrxdc_timeout(struct rtl8169_private *tp)
 {
 	struct pci_dev *pdev = tp->pci_dev;
-	u32 csi;
 	int rc;
 	u8 val;
 
@@ -2872,16 +2885,12 @@ static void rtl_disable_zrxdc_timeout(struct rtl8169_private *tp)
 		}
 	}
 
-	netdev_notice_once(tp->dev,
-		"No native access to PCI extended config space, falling back to CSI\n");
-	csi = rtl_csi_read(tp, RTL_GEN3_RELATED_OFF);
-	rtl_csi_write(tp, RTL_GEN3_RELATED_OFF, csi & ~RTL_GEN3_ZRXDC_NONCOMPL);
+	rtl_csi_mod(tp, RTL_GEN3_RELATED_OFF, RTL_GEN3_ZRXDC_NONCOMPL, 0);
 }
 
 static void rtl_set_aspm_entry_latency(struct rtl8169_private *tp, u8 val)
 {
 	struct pci_dev *pdev = tp->pci_dev;
-	u32 csi;
 
 	/* According to Realtek the value at config space address 0x070f
 	 * controls the L0s/L1 entrance latency. We try standard ECAM access
@@ -2893,10 +2902,7 @@ static void rtl_set_aspm_entry_latency(struct rtl8169_private *tp, u8 val)
 	    pci_write_config_byte(pdev, 0x070f, val) == PCIBIOS_SUCCESSFUL)
 		return;
 
-	netdev_notice_once(tp->dev,
-		"No native access to PCI extended config space, falling back to CSI\n");
-	csi = rtl_csi_read(tp, 0x070c) & 0x00ffffff;
-	rtl_csi_write(tp, 0x070c, csi | val << 24);
+	rtl_csi_mod(tp, 0x070c, 0xff000000, val << 24);
 }
 
 static void rtl_set_def_aspm_entry_latency(struct rtl8169_private *tp)
-- 
2.49.0




