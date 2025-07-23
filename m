Return-Path: <netdev+bounces-209267-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B30B0EDB5
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 10:54:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47E21965296
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 08:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C120E27FB1F;
	Wed, 23 Jul 2025 08:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jacekk.info header.i=@jacekk.info header.b="fD33qQtF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B201828312F
	for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 08:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753260857; cv=none; b=r8HgAcLvKKUNv8DhBpueFH0zCUOfF/ZW6n0NHsu5amTI+6Jal/4sF4rzeftWnuA4S7wlDDrBQQSy0MhnKfXW5nXP31we5mlgGCXthLeXF1VKYB3/L8O1PI+tpHmDV6BqUC6RwD3b/0dZBxRF0THXAkf0UInUHKxfyVkvep5X6iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753260857; c=relaxed/simple;
	bh=F18LZ7L+Yb5gCRyHmDQ0T2OjZ1ufO7ZGJZHvykvNH3Y=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=rgR8tfdo0bco4sKcwEbflq1DZP5NlggXuV4vcn4zbboMgoJ8RJsD8+kAnMtZCG9/pCkYFge9xlnIvqR/L1z++d8C0Cz0GmdcpvCj5lYxVgmj3g7YwsEEkOyZSUTX0+b6lAxwCH8dtb7oiWdNn15z2jN3oKVGwDCrWU+stAihj0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jacekk.info; spf=pass smtp.mailfrom=jacekk.info; dkim=pass (2048-bit key) header.d=jacekk.info header.i=@jacekk.info header.b=fD33qQtF; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jacekk.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jacekk.info
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6077dea37easo9948460a12.3
        for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 01:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jacekk.info; s=g2024; t=1753260854; x=1753865654; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YwFhinLP1Fsp+cB7676+3LQ6AV0wismQsbpAI8a2BLo=;
        b=fD33qQtF3uDosid8TXNUSZsd0Acj3TtIaYY3SawlUlLn82f7+C2ld2ZWKt+3X/LNDj
         372zg5aJ/tI0WT9fjT8Ig5OSQZsgGt4ltpI/THdicuFLMykOYCthmDxFDmXedrzj1jit
         2193YhJ29I2XMiaCpgHItmJkCkxNVVCuyEgFzeswOTVMBklSqxUBDl1IzSASkEv/w72O
         2vgLMzHLHwZNngzr6g+er+LR+IHGM5Bb+wQu70+zIiSCzZOa0tvlLMCVec8RIdHrJXXy
         iQR/DTnkIO4ycfm91ZJhYS/yHEV+dcufUc4sxGrQPZW/6bNyPoXL722e2/jDG3D1uKtW
         LgAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753260854; x=1753865654;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YwFhinLP1Fsp+cB7676+3LQ6AV0wismQsbpAI8a2BLo=;
        b=SXstvE2H0CUCI3eXn7PFt2G9wVu0Pha9DQcg+4IEFDy3P7bwWD3LqQ5D4I/gKyw7BT
         MXaHdQrmMfJkAHKaH++FSNk2jmFeZat3wlmNs82d2YVh32uul2GYbLpdb0QiQt5jBWxS
         fsNq2/Eix1yRFjYNMVLjOgBIO1dSNxwz43EcG3QaMdETrAL+6uX5TjDPF5uMkUx/Idfb
         /4qsHTKqnY3kyCrWcWaWN3qX96OV8KDxbXQURUOFMh+g8S0x5cF+wfH3rhk4aKiU/RUA
         8gEfpsvc5gDqSteZ6C1A65s1PiPvyKtGXi3MHCe76cFaI28qGs8OnPEeG2LreEI/o9wQ
         bXeA==
X-Forwarded-Encrypted: i=1; AJvYcCVFEZA864ychdpTI5XoFylzVC8L395F5Bl8ggXiaeeTy240foyBZacQAEIX+Top81G8cF7pIQQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHfqMGu7ZAjzIwYWdGogReQx0/S8Pytz67shlcGbFmUIMrf9Qy
	EBxw4MEGHVbTMHG7lNprM7rog4fv3uzm9vNstKOlFemW2cEYMytmfqDjZDkZ+wcygg==
X-Gm-Gg: ASbGncuQnd9uLbsSt/vC3iYwObLKuB7e4Z6KaFI/RdF0OkoCKMgWzIlyeLTmGjfTaKH
	Vf8Xf/Hx8O4i1g0wMJRTD1V/Sd4NTkY72aoUq5zBPRtUWCpP+RytuA5xjSrcCiYdkb3VYa7NVyO
	kDaMOaymIGeJ+941JSdIKc5wczrPqPI4uShFHXQEGRaxOsF5XPulI+d/b02Kl04foxS/DuhPPGK
	/3cgXZc5wHMQivHdGn4PmHPGgDpCDPrgwS20slco9hvVqu0ubUWcYzjOne9/8AXdiLS+l0ZTBNM
	PsD/OtZbKbRzH/H0EBvlse3ivj5wW48uC64T7xh06wMrCxJECVmkpio5hm4VvAzQjkvR4Wo1cM4
	posjC3xGu1za65u+Mm4nT/qzV
X-Google-Smtp-Source: AGHT+IEOfAQFG4XfDLR1ZHY1+R3DV8DpDsiIuZ1b48cLRDUnrFY8OtpIByBn69HwDiml2biFfyRhAg==
X-Received: by 2002:a05:6402:3716:b0:602:e46:638 with SMTP id 4fb4d7f45d1cf-6149b5c412fmr2018190a12.26.1753260853543;
        Wed, 23 Jul 2025 01:54:13 -0700 (PDT)
Received: from [192.168.0.114] ([91.196.212.106])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-612c903f9basm8265087a12.47.2025.07.23.01.54.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jul 2025 01:54:13 -0700 (PDT)
From: Jacek Kowalski <jacek@jacekk.info>
X-Google-Original-From: Jacek Kowalski <Jacek@jacekk.info>
Message-ID: <6abd035f-c568-424c-bdbc-6b9cbcb45e1e@jacekk.info>
Date: Wed, 23 Jul 2025 10:54:11 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH iwl-next v3 1/5] e1000: drop unnecessary constant casts to u16
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
References: <2f87d6e9-9eb6-4532-8a1d-c88e91aac563@jacekk.info>
Content-Language: en-US
In-Reply-To: <2f87d6e9-9eb6-4532-8a1d-c88e91aac563@jacekk.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Remove unnecessary casts of constant values to u16.
C's integer promotion rules make them ints no matter what.

Additionally replace E1000_MNG_VLAN_NONE with resulting value
rather than casting -1 to u16.

Signed-off-by: Jacek Kowalski <jacek@jacekk.info>
Suggested-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/intel/e1000/e1000.h         | 2 +-
 drivers/net/ethernet/intel/e1000/e1000_ethtool.c | 2 +-
 drivers/net/ethernet/intel/e1000/e1000_hw.c      | 4 ++--
 drivers/net/ethernet/intel/e1000/e1000_main.c    | 3 +--
 4 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000/e1000.h b/drivers/net/ethernet/intel/e1000/e1000.h
index 75f3fd1d8d6e..ea6ccf4b728b 100644
--- a/drivers/net/ethernet/intel/e1000/e1000.h
+++ b/drivers/net/ethernet/intel/e1000/e1000.h
@@ -116,7 +116,7 @@ struct e1000_adapter;
 #define E1000_MASTER_SLAVE	e1000_ms_hw_default
 #endif
 
-#define E1000_MNG_VLAN_NONE	(-1)
+#define E1000_MNG_VLAN_NONE	0xFFFF
 
 /* wrapper around a pointer to a socket buffer,
  * so a DMA handle can be stored along with the buffer
diff --git a/drivers/net/ethernet/intel/e1000/e1000_ethtool.c b/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
index d06d29c6c037..726365c567ef 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
@@ -806,7 +806,7 @@ static int e1000_eeprom_test(struct e1000_adapter *adapter, u64 *data)
 	}
 
 	/* If Checksum is not Correct return error else test passed */
-	if ((checksum != (u16)EEPROM_SUM) && !(*data))
+	if (checksum != EEPROM_SUM && !(*data))
 		*data = 2;
 
 	return *data;
diff --git a/drivers/net/ethernet/intel/e1000/e1000_hw.c b/drivers/net/ethernet/intel/e1000/e1000_hw.c
index f9328f2e669f..0e5de52b1067 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_hw.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_hw.c
@@ -3970,7 +3970,7 @@ s32 e1000_validate_eeprom_checksum(struct e1000_hw *hw)
 		return E1000_SUCCESS;
 
 #endif
-	if (checksum == (u16)EEPROM_SUM)
+	if (checksum == EEPROM_SUM)
 		return E1000_SUCCESS;
 	else {
 		e_dbg("EEPROM Checksum Invalid\n");
@@ -3997,7 +3997,7 @@ s32 e1000_update_eeprom_checksum(struct e1000_hw *hw)
 		}
 		checksum += eeprom_data;
 	}
-	checksum = (u16)EEPROM_SUM - checksum;
+	checksum = EEPROM_SUM - checksum;
 	if (e1000_write_eeprom(hw, EEPROM_CHECKSUM_REG, 1, &checksum) < 0) {
 		e_dbg("EEPROM Write Error\n");
 		return -E1000_ERR_EEPROM;
diff --git a/drivers/net/ethernet/intel/e1000/e1000_main.c b/drivers/net/ethernet/intel/e1000/e1000_main.c
index d8595e84326d..292389aceb2d 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_main.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_main.c
@@ -313,8 +313,7 @@ static void e1000_update_mng_vlan(struct e1000_adapter *adapter)
 		} else {
 			adapter->mng_vlan_id = E1000_MNG_VLAN_NONE;
 		}
-		if ((old_vid != (u16)E1000_MNG_VLAN_NONE) &&
-		    (vid != old_vid) &&
+		if (old_vid != E1000_MNG_VLAN_NONE && vid != old_vid &&
 		    !test_bit(old_vid, adapter->active_vlans))
 			e1000_vlan_rx_kill_vid(netdev, htons(ETH_P_8021Q),
 					       old_vid);
-- 
2.47.2


