Return-Path: <netdev+bounces-152076-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 666049F296B
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 06:14:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D5FC7A2373
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 05:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6711946CC;
	Mon, 16 Dec 2024 05:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kUPDIYYC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585EA10F4;
	Mon, 16 Dec 2024 05:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734326078; cv=none; b=CuuBfIapG0sBoGKE8h8C4WoTaSzSDn/dl78N3hdqWTl1ltEu5XwFZXnP2kWQOtilXqAsa8kJYxVvF2lOKLspfZHXdM1lkh/7Q1h6zSCur2Mk2NZjs5601nrwkFmt/KXd/SOJbN2ufmghMWOxUwvPXfJdAWT0OjNWYqxSGS7rjPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734326078; c=relaxed/simple;
	bh=FR3e8Djp9ihbO9X2uAmNOL4/KKIFoYlrwUJ2ZbLRzI0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=jHqb4wJrWS5qEM/Boa4hq9KKX8TisulnZm/aZj2rIF4bvM/R5OA+jypINeWXqSZmQQLwa+m0XpbKYMcalUbkqnQBr2ybLSh9CibdfdWxS++Cf2tSv91WU4mH5wy8Gk2eBBMnQoridVUHbNS2+vunTS9WQIINIEad5iXafmxs2bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kUPDIYYC; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7b6e4d38185so289204885a.0;
        Sun, 15 Dec 2024 21:14:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734326075; x=1734930875; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=IlwmzSwpYOXs672PYvNQq898z2PTS+fEUh9xaAh2uWU=;
        b=kUPDIYYC+PnmRXYtnAKW92UhT+qGxCJRULQl9OOyjFNak1+erpnEyyqHVLykTpFDrr
         OdiWqIlXV39603fF8xKE/B1+ab0rzbezHpqvb9AsC6tMe7+WT8+cx+/x/QuyVgRDdFmo
         DRbP891mYGpzNo78X9/Ru5r/fVK08nfSnPdprmi64xYFEdc+zXp2bpONB2cO3NhSDKl2
         x4B/N64XCJA3Y/1I4c93XefiViX03VEtFLhCDENrEfoajU8Oc/8TklMP5CjUUqBTRmMw
         RPNYiNxbElti3vWZcNTRz9bzxI2Of0nhsaf4Od1k4n12AURaEJr6sMeETRuJY7a3wH92
         H2WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734326075; x=1734930875;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IlwmzSwpYOXs672PYvNQq898z2PTS+fEUh9xaAh2uWU=;
        b=HdFBm9qLmL2wC1IKP/L1teANd2YTUbPNuHA4VtxKhwRdzY3EyA9jiirylNLAA5uZzC
         Hd//1Njv8xPjAD0sQLcxrt1KJzdl6J31zYWan4Rxlhw/CZOMFeYzMWCwY0g66b+rkG9a
         NobwNTfe/MyZCpj8/5mmYSRa/Jjrh+trepyWC+EV+pl9+B0vvWKvpKatRVZrXPCy89EJ
         bS3Ni7DRKEF8Drn46QlJDS+GdNxMYdwp1VbifqWvC/KhipFxO9RCROFq16tqaVMmqZWP
         1r/h4AMrvT61dqjbfsYzLv4+2ZZODuS6WVj8v6uOsQFUKgadILI5dEnO5R7attxs6tUG
         D8fA==
X-Forwarded-Encrypted: i=1; AJvYcCV8QNWRMLMQdVL+y2KimSh497jagGGEI6+aANYRqmGFXGGd2wzgYt0OUic9kRz0e+RLEwPFq0l6@vger.kernel.org, AJvYcCWZKY91DbOxO66NebmWwSTVR+zbDpp/8tLUHinnQigWItp5VB8ZWRcGQUgjW8cxK6W/nZMamN0Z/sGEXmo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz27qcrg27wVTKsTfXdDPey8k9WOEJsFMajL9Qjm40m/X8zVtQn
	UYwj1PeaI9qCNC/4KtHnR3p7OFeZRjXjesSl4QMfKebOxDf6NuFj
X-Gm-Gg: ASbGncsRgPtcaKT4JL+GkbbDXISpHyd8gwZrDje3QoxqOiUifTkjykxb8VrJ52Exv2M
	KgesSZPuPEKOkcl7CoH0LXGisXsdbI0VNRqTCPYDQikJeO1/O8UAsry0+k22Jy6+PWAvAP9j3w5
	yNna1VkogiyySL2cegv2p8ySu8oAsw0VL+KnB15Xt263IVCYr52nRqdPV0QQi+djXsSsnD8xjvp
	DUIfXGLhDtnpZe4j5iBeSQJsZ0GUIeOVVxY+nbkhmq/5IM/qTDgFX8TK1eCv7alyX6mWaAB98SI
	jlq0PnMB4g==
X-Google-Smtp-Source: AGHT+IFrk0f2ovHsJQJa25YqTu5jT2h5uGeHFj8CZDR9cllMrtrBbmGNGvQJFp+emRqRP4Eg07Vk3A==
X-Received: by 2002:a05:620a:1aa3:b0:7b6:f219:a7a8 with SMTP id af79cd13be357-7b6fbf3c37dmr1526783785a.49.1734326075230;
        Sun, 15 Dec 2024 21:14:35 -0800 (PST)
Received: from localhost (211-75-139-220.hinet-ip.hinet.net. [211.75.139.220])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b7048bd619sm192112785a.78.2024.12.15.21.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 21:14:34 -0800 (PST)
Sender: AceLan Kao <acelan@gmail.com>
From: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] igc: Return early when failing to read EECD register
Date: Mon, 16 Dec 2024 13:14:30 +0800
Message-ID: <20241216051430.1606770-1-acelan.kao@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When booting with a dock connected, the igc driver can get stuck for ~40
seconds if PCIe link is lost during initialization.

This happens because the driver access device after EECD register reads
return all F's, indicating failed reads. Consequently, hw->hw_addr is set
to NULL, which impacts subsequent rd32() reads. This leads to the driver
hanging in igc_get_hw_semaphore_i225(), as the invalid hw->hw_addr
prevents retrieving the expected value.

To address this, a validation check is added for the EECD register read
result. If all F's are returned, indicating PCIe link loss, the driver
will return -ENXIO immediately. This avoids the 40-second hang and
significantly improves boot time when using a dock with an igc NIC.

[    0.911913] igc 0000:70:00.0: enabling device (0000 -> 0002)
[    0.912386] igc 0000:70:00.0: PTM enabled, 4ns granularity
[    1.571098] igc 0000:70:00.0 (unnamed net_device) (uninitialized): PCIe link lost, device now detached
[   43.449095] igc_get_hw_semaphore_i225: igc 0000:70:00.0 (unnamed net_device) (uninitialized): Driver can't access device - SMBI bit is set.
[   43.449186] igc 0000:70:00.0: probe with driver igc failed with error -13
[   46.345701] igc 0000:70:00.0: enabling device (0000 -> 0002)
[   46.345777] igc 0000:70:00.0: PTM enabled, 4ns granularity

Signed-off-by: Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>
---
 drivers/net/ethernet/intel/igc/igc_base.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/intel/igc/igc_base.c b/drivers/net/ethernet/intel/igc/igc_base.c
index 9fae8bdec2a7..54ce60280765 100644
--- a/drivers/net/ethernet/intel/igc/igc_base.c
+++ b/drivers/net/ethernet/intel/igc/igc_base.c
@@ -68,6 +68,10 @@ static s32 igc_init_nvm_params_base(struct igc_hw *hw)
 	u32 eecd = rd32(IGC_EECD);
 	u16 size;
 
+	/* failed to read reg and got all F's */
+	if (!(~eecd))
+		return -ENODEV;
+
 	size = FIELD_GET(IGC_EECD_SIZE_EX_MASK, eecd);
 
 	/* Added to a constant, "size" becomes the left-shift value
-- 
2.43.0


