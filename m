Return-Path: <netdev+bounces-141691-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE439BC0B1
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 23:16:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 945BC1F22A03
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 22:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 133031AC88B;
	Mon,  4 Nov 2024 22:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W+c3jdQl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32EF02AF12
	for <netdev@vger.kernel.org>; Mon,  4 Nov 2024 22:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730758586; cv=none; b=Rh08t29DCiOqh2y9aERoqtGvfT4pItmPp1G4WtFnWxF292b93cp2GfBeT96d+9wKfikMVDoqt4JYyx2bU8/pC3RwBiQ7mcuICzEq9BOHS32wVbHgZyCaufIlAZrKtJlB05uEYML5ddu6WU6yuWhTa+uPEk7I/UCp+5kxk7/7oLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730758586; c=relaxed/simple;
	bh=DOQ8t+u++QPyemm0dictW/KuwxGw7ikrABaSLnyXsyg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=pFb7b+FZn7nqCbc0w7bUw0QRnZ+X4tNjKX6eHMGsoBrxkIPAqwuAnkHPSRiSVcd8P5RmAWPSEvOKj+XT+I3Hcw4L6CJIy4NsvrkAx/0i/gbDTQuyJqcL91i8I4PXSk9s1cQ+HWiVrTVdpEkEepIN0IYzatX23zHys7xeWNGxxZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W+c3jdQl; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a9aa8895facso843549666b.2
        for <netdev@vger.kernel.org>; Mon, 04 Nov 2024 14:16:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730758582; x=1731363382; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:content-language:cc:to:subject
         :from:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FCQ05NtUydYRD/bHMmdwSiV8wQGOMQp/+KzDWkE6j2g=;
        b=W+c3jdQly04E6pd+xWnhdZpE29CCdIfpk/Spk8eQ1jvfePfZ+x7g3wyBl8yKyt1Kii
         pg8irJLETLmRdBaQbU6J/FijeavmvD4s2iJyFmYze+vXUxuy0qyrzz0n4/KzuLztZ1nn
         QUDyaAKJMfreKruBdykr4JEq6zRzjMBPGEMFp0Q7x5pGsEFfw634cV7ZEyx0rhyPl6UR
         v+fhS8LiuNInA0pCwVlANVlmV+7qpLRCn4a2UDGW65am3wrEMFa/y7AJUspofWxgBrrr
         1IocVcDagnUAWu5L3z7P//eSS21lXjqXHwJoYluJ+pHXZJAbd3K7zdXY6Jljyn6BEC+n
         ZwSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730758582; x=1731363382;
        h=content-transfer-encoding:autocrypt:content-language:cc:to:subject
         :from:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FCQ05NtUydYRD/bHMmdwSiV8wQGOMQp/+KzDWkE6j2g=;
        b=JpIYbAPwfNKUL1nuoUe4jBEDUTZDE4OTJhF1w4NOEuH9WG/AiE90z/0iXINpWa6fTz
         F8lr8Q0J/qtWbc4ch/lq8vpuC6LiJsZjRxINNADaL9MrMjXyY3PlgsnSaB5KFSshw9wg
         wwfesLC8lT7F2420rc3ZasSJzDedaSlpGCxrL3pQm1xu2QuquK1sbz0uy3z3UYS3NzfX
         gon9BfOoQGT4lmrB+UslEvfFZ7Y0tYTuR1Ihc+fedkP2vDEUYfKL9CCT1yuWFmfRDJC3
         xzt9Z/yLywrxM3HA6WSmvqIk6E1MMynegUjeDV7EgSP8WX5tqkFQxATBJs3I8dyiPIVd
         eUcA==
X-Gm-Message-State: AOJu0Yy0jci94utzcxl9YO7JBTQpeoyFHTZeFeIVIAsf30a9eXJ5rC9G
	W9DiB06Pn0UTgmlit6w+6bUzuD9C9H+RUMPPOo00MS1SaxZmB7VI
X-Google-Smtp-Source: AGHT+IFYc2VWMXB8zrmbl8m1YM5SX1Ib3mVzpJVN46y7OUs4/wILSYOTWuXe0DKnr67gXPbKa4aB/w==
X-Received: by 2002:a17:907:9446:b0:a99:f619:d365 with SMTP id a640c23a62f3a-a9de5f6e257mr2809354766b.30.1730758582082;
        Mon, 04 Nov 2024 14:16:22 -0800 (PST)
Received: from ?IPV6:2a02:3100:9c2b:eb00:5887:d6c2:d681:2735? (dynamic-2a02-3100-9c2b-eb00-5887-d6c2-d681-2735.310.pool.telefonica.de. [2a02:3100:9c2b:eb00:5887:d6c2:d681:2735])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a9eb16a3b6esm38063966b.18.2024.11.04.14.16.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Nov 2024 14:16:20 -0800 (PST)
Message-ID: <680f2606-ac7d-4ced-8694-e5033855da9b@gmail.com>
Date: Mon, 4 Nov 2024 23:16:20 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next] r8169: remove leftover locks after reverted change
To: Realtek linux nic maintainers <nic_swsd@realtek.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

After e31a9fedc7d8 ("Revert "r8169: disable ASPM during NAPI poll"")
these locks aren't needed any longer.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/ethernet/realtek/r8169_main.c | 29 ++---------------------
 1 file changed, 2 insertions(+), 27 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 4f37d25e0..ce08969f5 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -662,13 +662,9 @@ struct rtl8169_private {
 		struct work_struct work;
 	} wk;
 
-	raw_spinlock_t config25_lock;
 	raw_spinlock_t mac_ocp_lock;
 	struct mutex led_lock;	/* serialize LED ctrl RMW access */
 
-	raw_spinlock_t cfg9346_usage_lock;
-	int cfg9346_usage_count;
-
 	unsigned supports_gmii:1;
 	unsigned aspm_manageable:1;
 	unsigned dash_enabled:1;
@@ -722,22 +718,12 @@ static inline struct device *tp_to_dev(struct rtl8169_private *tp)
 
 static void rtl_lock_config_regs(struct rtl8169_private *tp)
 {
-	unsigned long flags;
-
-	raw_spin_lock_irqsave(&tp->cfg9346_usage_lock, flags);
-	if (!--tp->cfg9346_usage_count)
-		RTL_W8(tp, Cfg9346, Cfg9346_Lock);
-	raw_spin_unlock_irqrestore(&tp->cfg9346_usage_lock, flags);
+	RTL_W8(tp, Cfg9346, Cfg9346_Lock);
 }
 
 static void rtl_unlock_config_regs(struct rtl8169_private *tp)
 {
-	unsigned long flags;
-
-	raw_spin_lock_irqsave(&tp->cfg9346_usage_lock, flags);
-	if (!tp->cfg9346_usage_count++)
-		RTL_W8(tp, Cfg9346, Cfg9346_Unlock);
-	raw_spin_unlock_irqrestore(&tp->cfg9346_usage_lock, flags);
+	RTL_W8(tp, Cfg9346, Cfg9346_Unlock);
 }
 
 static void rtl_pci_commit(struct rtl8169_private *tp)
@@ -748,24 +734,18 @@ static void rtl_pci_commit(struct rtl8169_private *tp)
 
 static void rtl_mod_config2(struct rtl8169_private *tp, u8 clear, u8 set)
 {
-	unsigned long flags;
 	u8 val;
 
-	raw_spin_lock_irqsave(&tp->config25_lock, flags);
 	val = RTL_R8(tp, Config2);
 	RTL_W8(tp, Config2, (val & ~clear) | set);
-	raw_spin_unlock_irqrestore(&tp->config25_lock, flags);
 }
 
 static void rtl_mod_config5(struct rtl8169_private *tp, u8 clear, u8 set)
 {
-	unsigned long flags;
 	u8 val;
 
-	raw_spin_lock_irqsave(&tp->config25_lock, flags);
 	val = RTL_R8(tp, Config5);
 	RTL_W8(tp, Config5, (val & ~clear) | set);
-	raw_spin_unlock_irqrestore(&tp->config25_lock, flags);
 }
 
 static bool rtl_is_8125(struct rtl8169_private *tp)
@@ -1571,7 +1551,6 @@ static void __rtl8169_set_wol(struct rtl8169_private *tp, u32 wolopts)
 		{ WAKE_MAGIC, Config3, MagicPacket }
 	};
 	unsigned int i, tmp = ARRAY_SIZE(cfg);
-	unsigned long flags;
 	u8 options;
 
 	rtl_unlock_config_regs(tp);
@@ -1590,14 +1569,12 @@ static void __rtl8169_set_wol(struct rtl8169_private *tp, u32 wolopts)
 			r8168_mac_ocp_modify(tp, 0xc0b6, BIT(0), 0);
 	}
 
-	raw_spin_lock_irqsave(&tp->config25_lock, flags);
 	for (i = 0; i < tmp; i++) {
 		options = RTL_R8(tp, cfg[i].reg) & ~cfg[i].mask;
 		if (wolopts & cfg[i].opt)
 			options |= cfg[i].mask;
 		RTL_W8(tp, cfg[i].reg, options);
 	}
-	raw_spin_unlock_irqrestore(&tp->config25_lock, flags);
 
 	switch (tp->mac_version) {
 	case RTL_GIGA_MAC_VER_02 ... RTL_GIGA_MAC_VER_06:
@@ -5496,8 +5473,6 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	tp->supports_gmii = ent->driver_data == RTL_CFG_NO_GBIT ? 0 : 1;
 	tp->ocp_base = OCP_STD_PHY_BASE;
 
-	raw_spin_lock_init(&tp->cfg9346_usage_lock);
-	raw_spin_lock_init(&tp->config25_lock);
 	raw_spin_lock_init(&tp->mac_ocp_lock);
 	mutex_init(&tp->led_lock);
 
-- 
2.47.0



