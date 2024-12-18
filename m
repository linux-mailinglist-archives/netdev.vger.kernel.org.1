Return-Path: <netdev+bounces-152798-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1F539F5CEE
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 03:38:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EEC616F35A
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 02:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52EA85336D;
	Wed, 18 Dec 2024 02:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="j8PQZyJN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA506481AF
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 02:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734489481; cv=none; b=c8H3HkwaWnOBUmqN/0Umypnhci8qxkVGNxuZUdxFVQc0KjmFSq7BDB0fJr5ubfWm+WHygooME3gZ+zgSGTi8UrGY7o9KFNpN1+rI9PPmIq2XyCpkk8LOouAOhP1vaRZoCvQnWuZRfkm7Bcc6SFMxl5YKW6XUeh+UD79wZH5ipcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734489481; c=relaxed/simple;
	bh=iMPPzW/fOg1yXbJy86HU8s3UQaJRbFNDDtnOn7pMfMo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TSOsWKyyhYl8k4oQDAW7UFUjVMZbcySNQwhcTM8sdI1Luh/8GdtA5hju/cgESnqVEly25MdV1T2MvWszpSs8Yp42HRXCqwbNa0pyNz9GyJHkUSIP6+/RBxd+Yysz/MgujbNeuV4KfhJY9wkUjlNLe/Dwdx+wdUn/iLw8P9JLT2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=j8PQZyJN; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id B680E3F5AE
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 02:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1734489469;
	bh=TFaVEYsO+0RIB0bo3fMP3mzQbKddwngJ+5DgQ8I1mWg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=j8PQZyJNhXEjGZZkDf9K2vbJoChZzguE7g+7c0J4+X1HA14VO9RJgoMS8ubgw17vw
	 8dpiWVGZffinEcCej3XRxEf2j2nedv/rCePo9CqnjavRaTi6XOWuTa1AGJAhwrTAES
	 ZF/78Fk33p2nmy5P8GevMeJNEl1TeC5CclrBAx0lZ46N5es2YBJnjlqC4X+2twJiZ2
	 rQ5LH0TT1XEt/UZi6nIynxiizT6COKcVoXd7o4R4uTBdo/oi6PsBfiwaIqeno0DVZ9
	 lmubwft8pGVvVyHTDn9rYpj2TeeNOV5X5NvM4rSOwc6uGbBj+/bOjyHAl71BSyz0wc
	 eCLRPI1z8M/TA==
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2163dc0f689so90198305ad.1
        for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 18:37:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734489466; x=1735094266;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TFaVEYsO+0RIB0bo3fMP3mzQbKddwngJ+5DgQ8I1mWg=;
        b=gZ/UsiWsw4ccTMJeKOi8KVxXQ9JFAmd5NUt+tR8IYyTqmLBzgsllw5rdDe4JXaoewp
         dYd/Owaw/qGUGJsat/dZccqPN+mp6pkkqD09UxaDuj9jbkWmCnUs5/6AWN/twZ7P0kab
         NZGARsKFx//H6advZLKhc5w8gimVz2/BXNw8IYSfhxqSWYLUbEE5iV4Y2CksRt6PcZfI
         Lr7wAtb2O+rZXxhw5LwdnixGaiNeykPUqkH9I7zEAoIOxaqeOxS2dGI+xo5UlJYY7ddN
         e490MVDDcTv3EpmDm8Lq/P3br4D9z0s12f4ypY8tTOV82eIMcwp5qon9KCm52QTBMMAX
         Lviw==
X-Forwarded-Encrypted: i=1; AJvYcCUkOldchsZoJokPjnYuFtBgT1spF7c4Lzq9ucajwvoHACXpOKUaDEaV06zuameZBQgE+p0Zsus=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXjb+lU211mhf0Pwk2T0ZpXXU5pyrzdP+LiZjOJcm8BZqlQUS3
	BUnFDzvhtWlvDMpBtypUFJVkgOGzOCVgvc4mshR3kWV8Skjq3RZ29dExO/ciwrVEtZR474SC4xd
	+dLZlkqrBh2x/r+piyVy5ug2j2zggjllSgUVcQS6x5BQfJKzdsZbxKjad3RgyxoVkutUBWQ==
X-Gm-Gg: ASbGncul9w2GtherwyEoWIzFmMBMHB7eZtasTbUa2N8ALx7WbGEJNmo3fPnSaEXcgbm
	u+RUHDM0zpilQnjGVaWGbncrrnipYTDigtHezSHyrKuHNtGIRwjvvVANkD2cXx//hiJ3Ws39ACe
	LISnxKHsvL+Nvwa0lyPYD15VUeTHPogm42KC7YZ6yoXZaplNSznY4UWyvnEeEhjrQ12YnpfqEsJ
	k/muRZy6RlTREB+c8VuFyLG7Vp7wEBiCZ6vzdc+Xd51J8PKMimwEwPCRJvapuSl9JhkiRvdignF
	uNteqLUfkA2WTmccgeeumblsyc/RGrF/YQKlvWwIajpRcVNlF6dX/dh/oLs=
X-Received: by 2002:a17:903:234d:b0:216:4064:53ad with SMTP id d9443c01a7336-218d7258781mr20456585ad.48.1734489466667;
        Tue, 17 Dec 2024 18:37:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFGnjXVQbSCPpcLEMs1vNBYJeTiWQaRdGDFeNo4OX7+T80FP/PD94tyzBKNkLNro+8IXcQ2nA==
X-Received: by 2002:a17:903:234d:b0:216:4064:53ad with SMTP id d9443c01a7336-218d7258781mr20456265ad.48.1734489466357;
        Tue, 17 Dec 2024 18:37:46 -0800 (PST)
Received: from rickywu0421-ThinkPad-X1-Carbon-Gen-11.. (118-163-61-247.hinet-ip.hinet.net. [118.163.61.247])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219ce1b347fsm212475ad.78.2024.12.17.18.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 18:37:46 -0800 (PST)
From: En-Wei Wu <en-wei.wu@canonical.com>
To: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: vitaly.lifshits@intel.com,
	Chia-Lin Kao <acelan.kao@canonical.com>
Subject: [PATCH iwl-net v2] igc: return early when failing to read EECD register
Date: Wed, 18 Dec 2024 10:37:42 +0800
Message-ID: <20241218023742.882811-1-en-wei.wu@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When booting with a dock connected, the igc driver may get stuck for ~40
seconds if PCIe link is lost during initialization.

This happens because the driver access device after EECD register reads
return all F's, indicating failed reads. Consequently, hw->hw_addr is set
to NULL, which impacts subsequent rd32() reads. This leads to the driver
hanging in igc_get_hw_semaphore_i225(), as the invalid hw->hw_addr
prevents retrieving the expected value.

To address this, a validation check and a corresponding return value
catch is added for the EECD register read result. If all F's are
returned, indicating PCIe link loss, the driver will return -ENXIO
immediately. This avoids the 40-second hang and significantly improves
boot time when using a dock with an igc NIC.

Log before the patch:
[    0.911913] igc 0000:70:00.0: enabling device (0000 -> 0002)
[    0.912386] igc 0000:70:00.0: PTM enabled, 4ns granularity
[    1.571098] igc 0000:70:00.0 (unnamed net_device) (uninitialized): PCIe link lost, device now detached
[   43.449095] igc_get_hw_semaphore_i225: igc 0000:70:00.0 (unnamed net_device) (uninitialized): Driver can't access device - SMBI bit is set.
[   43.449186] igc 0000:70:00.0: probe with driver igc failed with error -13
[   46.345701] igc 0000:70:00.0: enabling device (0000 -> 0002)
[   46.345777] igc 0000:70:00.0: PTM enabled, 4ns granularity

Log after the patch:
[    1.031000] igc 0000:70:00.0: enabling device (0000 -> 0002)
[    1.032097] igc 0000:70:00.0: PTM enabled, 4ns granularity
[    1.642291] igc 0000:70:00.0 (unnamed net_device) (uninitialized): PCIe link lost, device now detached
[    5.480490] igc 0000:70:00.0: enabling device (0000 -> 0002)
[    5.480516] igc 0000:70:00.0: PTM enabled, 4ns granularity

Fixes: ab4056126813 ("igc: Add NVM support")
Cc: Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>
Signed-off-by: En-Wei Wu <en-wei.wu@canonical.com>
---
Changes in v2:
- Added "after" logs showing improved boot time
- Fixed error code (use -ENXIO instead of -ENODEV)
- Added error propagation in igc_get_invariants_base()
- Added Fixes tag
- Added [PATCH iwl-net] prefix
- Changed original author from AceLan to En-Wei

 drivers/net/ethernet/intel/igc/igc_base.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/intel/igc/igc_base.c b/drivers/net/ethernet/intel/igc/igc_base.c
index 9fae8bdec2a7..1613b562d17c 100644
--- a/drivers/net/ethernet/intel/igc/igc_base.c
+++ b/drivers/net/ethernet/intel/igc/igc_base.c
@@ -68,6 +68,10 @@ static s32 igc_init_nvm_params_base(struct igc_hw *hw)
 	u32 eecd = rd32(IGC_EECD);
 	u16 size;
 
+	/* failed to read reg and got all F's */
+	if (!(~eecd))
+		return -ENXIO;
+
 	size = FIELD_GET(IGC_EECD_SIZE_EX_MASK, eecd);
 
 	/* Added to a constant, "size" becomes the left-shift value
@@ -221,6 +225,8 @@ static s32 igc_get_invariants_base(struct igc_hw *hw)
 
 	/* NVM initialization */
 	ret_val = igc_init_nvm_params_base(hw);
+	if (ret_val)
+		goto out;
 	switch (hw->mac.type) {
 	case igc_i225:
 		ret_val = igc_init_nvm_params_i225(hw);
-- 
2.43.0


