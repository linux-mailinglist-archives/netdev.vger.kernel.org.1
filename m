Return-Path: <netdev+bounces-158370-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B05A6A11800
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 04:41:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9799167C75
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 03:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F76F156644;
	Wed, 15 Jan 2025 03:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AHkPGLvQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8C94C98;
	Wed, 15 Jan 2025 03:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736912508; cv=none; b=enlPBTqj70OkrGmQEeLYJsUzG1j4UWEcdc+lLy5LCtC4d080lTWPK+SYGiw3arBmsvKLzAsuwoPGIO7wN/Bbmk5N/7ITMw3yCsi8ezxaIQxxL+kzHR3uu2T915NwDPLLQaeYgIkxFMJ7LRMlPzuFBXE1n45+6AKA3ZCFqjxSsRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736912508; c=relaxed/simple;
	bh=mF395oh0tVtZ0nQP01E0uDaCUrAm5f1mTBgQ8AIXq+M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hwtLM27kjgjre4ED5ilnjAoK0JC1MFh38xo+JuxKhzfmT5dMtWz7LhLDsAtQIEciwdvp0z+TY93tGDfe0yPa2jDJAbq2jJnxnM3OiwqmOk3ROonYBKdRdAhLvakaDqYYGWxN7JDVUyRrTluV78xniIA/4AhTeDAU+SLOOnHXS/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AHkPGLvQ; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2ef72924e53so10317609a91.3;
        Tue, 14 Jan 2025 19:41:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736912506; x=1737517306; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w79G0sAdFORxpLEmin5NUYiYaNJ/dpjL2Qm4mGDbE+g=;
        b=AHkPGLvQjkWvBE4XrpxLWFLXgZs/N5pDRqGv8VN3mq6tZaK3uG4ILI2dxeifghYXNZ
         qtenHm43kIbMG7bGf3ZBwwJTsGaboG1GMB2PuwGOhAHbYdmpNJyEuc/1hxIViOMLgwX7
         7+sbrVKnwCAZWc0WSojbbnXxKCMARgS+tLqyd2QFahcmbH4/rRz9IrFt3Js7b1qfh+FO
         IOJVrZdpiOhW9B2j78vWanNAQNUKAGUwVF4M4nmF9V3TLkl20Gnj0YjZj5GpVA3EjAdM
         Maww44VfpOpWV5lrsFD8TY9Ttk5qPavNVZBeIDQpP+qHSyElJRESXRztZTXS0fvxyBew
         DRqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736912506; x=1737517306;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w79G0sAdFORxpLEmin5NUYiYaNJ/dpjL2Qm4mGDbE+g=;
        b=M7T5HkY0p31y5O+SU+/Hu3hCQyowqhQxh7hm320dzxfcF2AwIDPzFvTj+W4ie6xj/B
         SpZUE+grprUmTVpiqn2pXimnFsnyJILnl0R6e/VdpmkVCG3SCZc82FWnVxB4kLPZNCyw
         /CiBspZCMeLdcd0fcPfLdUyTmWNfcazHZ43ghCTsEUsyjTHsYNRbEGbniOkDJ1WWS0ER
         WR2jyQ4FKhYOaDdyE2fVn11d+oOskxLPeDvYhIMl3rc6wJ7SwCSFGostfG6Hjk/CRsGf
         GUeJ1hVJsv5zmW2gQJv9Y1CTDLO/6hVs7V393tcRAV3UHCM16+PkYxeZQv7JEGsHVq7V
         NcVA==
X-Forwarded-Encrypted: i=1; AJvYcCUEgH5zw9sVB9QcieQEIfiK8ppMibq+9s4KxBTm1d+6FaSxD/IkCH1LmDo5UvTF/LYt9ZWBzlMO2DxVehU=@vger.kernel.org, AJvYcCUnhNepmD8pNRVnaXgf6v7s3Q3QkNHpvxf399peaXCLaFNScnggzuS1CPSj+6BeFOy5CeyN22pM@vger.kernel.org
X-Gm-Message-State: AOJu0YyOlvLruVdgp+XiyPFhYAqFjvWXaYoE+Pkdtecoe/ybv/rTLmG6
	CrbwrU2GyM30U3ILKLmAymm7aRs14MzuV5Dkqxyxpr4NHP7qaZK6
X-Gm-Gg: ASbGnct+Zci1YALjcGzjbJ6j/E3EigOw6MagBSI7w+X3Az/6moz0zTrhVvPB8S7Lhdc
	dZe6lHk1D6HRGZ0fNyQzh2WsW2Y/bE8g1lpUt1eBv/jJo/XCHzzOZoLlthKd3ccJqofZV/w9gRW
	aRaRemEgUJOX8WJNLsZkifc/Ylwb0e3D5dOIiF6hFw380nwDpzxyhq2ceAUokJF3oPulrY96L/A
	+wORtltAhAL19DSrAF5TtU2+H1Zv+zvZBgDjwIiyOtzcU5ClLG8e2lAN5SV
X-Google-Smtp-Source: AGHT+IFUsVIMLNo7dsDWNM7Y7j/R+wYJTfLLRH9xMmGx3hdnhEDN5EwruBttORubiH3a0y9p2WRBIg==
X-Received: by 2002:a17:90b:274b:b0:2ee:8427:4b02 with SMTP id 98e67ed59e1d1-2f548f5f941mr38369822a91.28.1736912506496;
        Tue, 14 Jan 2025 19:41:46 -0800 (PST)
Received: from HOME-PC ([223.185.133.12])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f72c04b157sm325868a91.0.2025.01.14.19.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 19:41:46 -0800 (PST)
From: Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>
To: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	piotr.kwapulinski@intel.com
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	michal.swiatkowski@linux.intel.com,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>
Subject: [PATCH v2 net-next] ixgbe: Fix endian handling for ACI descriptor registers
Date: Wed, 15 Jan 2025 09:11:17 +0530
Message-Id: <20250115034117.172999-1-dheeraj.linuxdev@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ixgbe driver was missing proper endian conversion for ACI descriptor
register operations. Add the necessary conversions when reading and
writing to the registers.

Fixes: 46761fd52a88 ("ixgbe: Add support for E610 FW Admin Command Interface")
Closes: https://scan7.scan.coverity.com/#/project-view/52337/11354?selectedIssue=1602757
Signed-off-by: Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>
---
Changelog

v2:
	- Updated the patch to include suggested fix
	- Updated the commit message to describe the issue

 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
index 683c668672d6..3b9017e72d0e 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
@@ -113,7 +113,7 @@ static int ixgbe_aci_send_cmd_execute(struct ixgbe_hw *hw,
 
 	/* Descriptor is written to specific registers */
 	for (i = 0; i < IXGBE_ACI_DESC_SIZE_IN_DWORDS; i++)
-		IXGBE_WRITE_REG(hw, IXGBE_PF_HIDA(i), raw_desc[i]);
+		IXGBE_WRITE_REG(hw, IXGBE_PF_HIDA(i), cpu_to_le32(raw_desc[i]));
 
 	/* SW has to set PF_HICR.C bit and clear PF_HICR.SV and
 	 * PF_HICR_EV
@@ -145,7 +145,7 @@ static int ixgbe_aci_send_cmd_execute(struct ixgbe_hw *hw,
 	if ((hicr & IXGBE_PF_HICR_SV)) {
 		for (i = 0; i < IXGBE_ACI_DESC_SIZE_IN_DWORDS; i++) {
 			raw_desc[i] = IXGBE_READ_REG(hw, IXGBE_PF_HIDA(i));
-			raw_desc[i] = raw_desc[i];
+			raw_desc[i] = le32_to_cpu(raw_desc[i]);
 		}
 	}
 
@@ -153,7 +153,7 @@ static int ixgbe_aci_send_cmd_execute(struct ixgbe_hw *hw,
 	if ((hicr & IXGBE_PF_HICR_EV) && !(hicr & IXGBE_PF_HICR_C)) {
 		for (i = 0; i < IXGBE_ACI_DESC_SIZE_IN_DWORDS; i++) {
 			raw_desc[i] = IXGBE_READ_REG(hw, IXGBE_PF_HIDA_2(i));
-			raw_desc[i] = raw_desc[i];
+			raw_desc[i] = le32_to_cpu(raw_desc[i]);
 		}
 	}
 
-- 
2.34.1


