Return-Path: <netdev+bounces-231614-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC6BBFB8B1
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 13:07:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 27B124F2B0E
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 11:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A8232AAA4;
	Wed, 22 Oct 2025 11:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Zgka9XoA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f99.google.com (mail-io1-f99.google.com [209.85.166.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16863328630
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 11:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761131237; cv=none; b=R0UYWxYF/C7YvU7W1G0vztLyxPOU61o/BjRd+ECpgXwjHQIvgJREQQlc5O0tRbgEXEep4pKJUXwoJ8jou30tZ7kOt/aH8UkXRaaiQPNi4zAkQarbuMGW/LSdJqy2TNMQT/yuwp1TKaXRRavtoKtpIMbnf2bYWw6yzvaDP4JCmJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761131237; c=relaxed/simple;
	bh=tphZkRN4cfZYFVTFehKBYnLpVKDqMthpMvjmWlBcnCk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tVUGDS+6ZHCc96zneT4ZOAcVObK5VezgBjwwHAtAwlL8fUrm+4qws3/yJ0Zic3WP5YuoXZNMVNz+fnwZeYSibSHmtTZ/2sQu1R8JrVuwG8I10URApBQOju9gAjd3y/y4q1azVe8nTEnGUB2e6DvtKErhZADKhl1BOxkVpIvLmEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Zgka9XoA; arc=none smtp.client-ip=209.85.166.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-io1-f99.google.com with SMTP id ca18e2360f4ac-93e7ece3025so41961639f.1
        for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 04:07:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761131234; x=1761736034;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kA9Oy21XPeXmPlSwKvLYBk2PQ/Fy4Lvp8jR4DRUe+f8=;
        b=jePee5+LzUFdpLen4lE/2MZPPLxXrIAts62vEZwkwJ6/CWNMi9oxJfukN6b9CFlkOa
         NRowEA08GGpE2YLF0/KQZQU9CRxoI9T4n8se2mjpeqinSqIQ6dHfx0lwEbo3iDsqSNP8
         3i1pV/xaIdRZuyxzO7/5Rnrty5zi6iHmpamwMUpgajK9xpQg0zFP1i6RQuz96bs/PFyY
         5GtfeHCsHeFAdODwGxongDjzjtoES0o24TnxEp+c7tTa8lYYe1vHs8kttdhCGNPkPCw2
         XJcayJFrl39jBJd8WJe+GJypbLIUPzWob/To8QZ36gX7n325MMlJj/g+fFab7/1ROm7P
         2UcQ==
X-Gm-Message-State: AOJu0YxFdy7ZMauVAFcvGoWfrMAuJ1JhqHRLWrK4nB255ibchVHOyktk
	R00S7ImjemP2QknoVJEjCnC/5EvPd+ZlmXFMdq7JXDMltr94v/AwWbzr3sc0Sei4ov4bMv/qQrx
	6zKu9MdrtEx7Mt7N6WeBEwNo88DbB0HdOOrU9ws5jI7rBM32ypNlAk3MPpWOUYc6faFVtXy83PQ
	JOZpNqvhv3klXCQW48rpCBO+Jjhkrv0RSe9AP9p+B2pLLC5QjWleyHQSFPY+CisKDh53Uo7kXQf
	TGE/H9l/uk=
X-Gm-Gg: ASbGncufjXzSMHrDu3iYWMGJicPCUulCxDTK+s/yOliyrcofr1Iofu/ew9awtDhwtnC
	LvWrs+C6MD+vfmmdmAjdzRl/fsd/m+f1BivHbB8xneZ+n/kwSUo0u5PJkiclUFkJCj9ylSGAk4o
	TznEv+3VWMXvPhL145JjGrVErXIjtnZY4FSRSFP39Alu8cLW44qZjlnU2qDbWamBftRc2Rv5sp2
	8XOVACt43M+Af6SujA32hsPqqLLe5jaEZ44f1LpXZKXXWcdTH9brvWmeyRuBFWvghxf2Rl6chnM
	7/C5TFTAzSRL2fgZxYDBDkQ7qZF344NmWaP0JJQrqH3nnFkQiW3wV9FKJ0E4sDCgdYyPIv3tB1W
	gcuu8EnSuLTKmZVPPsNFpQZtrD9sWu5a0RzfJk7QzFt5C/fXWwzZXMzr8+uGqWqaj5PsjX9SSFm
	S1+XDtqXRcGld/3gtrlFy2DfDV+Qm/nik=
X-Google-Smtp-Source: AGHT+IEjxmrvnr2TOTruifT/p5nQDXBOCZfaibCan4HPf9oeFWGEMvVcMe1Ytv081/8KLC4jqBLphEiNftUF
X-Received: by 2002:a05:6602:341a:b0:940:d833:a83d with SMTP id ca18e2360f4ac-940f44127a4mr478369839f.1.1761131234084;
        Wed, 22 Oct 2025 04:07:14 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-72.dlp.protect.broadcom.com. [144.49.247.72])
        by smtp-relay.gmail.com with ESMTPS id ca18e2360f4ac-93e8663b577sm103782339f.6.2025.10.22.04.07.13
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Oct 2025 04:07:14 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2909daa65f2so10627575ad.0
        for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 04:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1761131232; x=1761736032; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kA9Oy21XPeXmPlSwKvLYBk2PQ/Fy4Lvp8jR4DRUe+f8=;
        b=Zgka9XoA3l7OIOI4OLkeZJH/Na1b5BVlHCBcQKLDnck1NIcLbIgzmR4MS5Zsj+0dh4
         819h9Cndr3YHJXCOM+934lRz0i7Ii2UVHfAPWcPSSGwax/PJisvYJDxCIcfvosSEdnyP
         oLEstaS+13AgAX1EL4M+QDJcuvm8PNY9+8uWQ=
X-Received: by 2002:a17:902:f690:b0:28e:873d:8a with SMTP id d9443c01a7336-292ffc0ab76mr41333935ad.15.1761131232524;
        Wed, 22 Oct 2025 04:07:12 -0700 (PDT)
X-Received: by 2002:a17:902:f690:b0:28e:873d:8a with SMTP id d9443c01a7336-292ffc0ab76mr41333645ad.15.1761131232122;
        Wed, 22 Oct 2025 04:07:12 -0700 (PDT)
Received: from photon-dev-haas.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29246ffeec3sm135964955ad.52.2025.10.22.04.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 04:07:11 -0700 (PDT)
From: Ajay Kaher <ajay.kaher@broadcom.com>
To: kuba@kernel.org,
	davem@davemloft.net,
	richardcochran@gmail.com,
	nick.shi@broadcom.com,
	alexey.makhalov@broadcom.com,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	pabeni@redhat.com,
	jiashengjiangcool@gmail.com,
	andrew@lunn.ch,
	viswanathiyyappan@gmail.com,
	vadim.fedorenko@linux.dev,
	wei.fang@nxp.com,
	rmk+kernel@armlinux.org.uk,
	vladimir.oltean@nxp.com,
	cjubran@nvidia.com,
	dtatulea@nvidia.com,
	tariqt@nvidia.com
Cc: netdev@vger.kernel.org,
	bcm-kernel-feedback-list@broadcom.com,
	linux-kernel@vger.kernel.org,
	florian.fainelli@broadcom.com,
	vamsi-krishna.brahmajosyula@broadcom.com,
	tapas.kundu@broadcom.com,
	shubham-sg.gupta@broadcom.com,
	karen.wang@broadcom.com,
	hari-krishna.ginka@broadcom.com,
	ajay.kaher@broadcom.com
Subject: [PATCH v2 1/2] ptp/ptp_vmw: Implement PTP clock adjustments ops
Date: Wed, 22 Oct 2025 10:51:27 +0000
Message-Id: <20251022105128.3679902-2-ajay.kaher@broadcom.com>
X-Mailer: git-send-email 2.40.4
In-Reply-To: <20251022105128.3679902-1-ajay.kaher@broadcom.com>
References: <20251022105128.3679902-1-ajay.kaher@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Implement PTP clock ops that set time and frequency of the underlying
clock. On supported versions of VMware precision clock virtual device,
new commands can adjust its time and frequency, allowing time transfer
from a virtual machine to the underlying hypervisor.

In case of error, vmware_hypercall doesn't return Linux defined errno,
converting it to -EIO.

Cc: Shubham Gupta <shubham-sg.gupta@broadcom.com>
Cc: Nick Shi <nick.shi@broadcom.com>
Tested-by: Karen Wang <karen.wang@broadcom.com>
Tested-by: Hari Krishna Ginka <hari-krishna.ginka@broadcom.com>
Signed-off-by: Ajay Kaher <ajay.kaher@broadcom.com>
---
 drivers/ptp/ptp_vmw.c | 39 +++++++++++++++++++++++++++++----------
 1 file changed, 29 insertions(+), 10 deletions(-)

diff --git a/drivers/ptp/ptp_vmw.c b/drivers/ptp/ptp_vmw.c
index 20ab05c4d..7d117eee4 100644
--- a/drivers/ptp/ptp_vmw.c
+++ b/drivers/ptp/ptp_vmw.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
 /*
- * Copyright (C) 2020 VMware, Inc., Palo Alto, CA., USA
+ * Copyright (C) 2020-2023 VMware, Inc., Palo Alto, CA., USA
+ * Copyright (C) 2024-2025 Broadcom Ltd.
  *
  * PTP clock driver for VMware precision clock virtual device.
  */
@@ -16,20 +17,36 @@
 
 #define VMWARE_CMD_PCLK(nr) ((nr << 16) | 97)
 #define VMWARE_CMD_PCLK_GETTIME VMWARE_CMD_PCLK(0)
+#define VMWARE_CMD_PCLK_SETTIME VMWARE_CMD_PCLK(1)
+#define VMWARE_CMD_PCLK_ADJTIME VMWARE_CMD_PCLK(2)
+#define VMWARE_CMD_PCLK_ADJFREQ VMWARE_CMD_PCLK(3)
 
 static struct acpi_device *ptp_vmw_acpi_device;
 static struct ptp_clock *ptp_vmw_clock;
 
+/*
+ * Helpers for reading and writing to precision clock device.
+ */
 
-static int ptp_vmw_pclk_read(u64 *ns)
+static int ptp_vmw_pclk_read(int cmd, u64 *ns)
 {
 	u32 ret, nsec_hi, nsec_lo;
 
-	ret = vmware_hypercall3(VMWARE_CMD_PCLK_GETTIME, 0,
-				&nsec_hi, &nsec_lo);
+	ret = vmware_hypercall3(cmd, 0, &nsec_hi, &nsec_lo);
 	if (ret == 0)
 		*ns = ((u64)nsec_hi << 32) | nsec_lo;
-	return ret;
+
+	return ret != 0 ? -EIO : 0;
+}
+
+static int ptp_vmw_pclk_write(int cmd, u64 in)
+{
+	u32 ret, unused;
+
+	ret = vmware_hypercall5(cmd, 0, 0, in >> 32, in & 0xffffffff,
+				&unused);
+
+	return ret != 0 ? -EIO : 0;
 }
 
 /*
@@ -38,19 +55,19 @@ static int ptp_vmw_pclk_read(u64 *ns)
 
 static int ptp_vmw_adjtime(struct ptp_clock_info *info, s64 delta)
 {
-	return -EOPNOTSUPP;
+	return ptp_vmw_pclk_write(VMWARE_CMD_PCLK_ADJTIME, (u64)delta);
 }
 
 static int ptp_vmw_adjfine(struct ptp_clock_info *info, long delta)
 {
-	return -EOPNOTSUPP;
+	return ptp_vmw_pclk_write(VMWARE_CMD_PCLK_ADJFREQ, (u64)delta);
 }
 
 static int ptp_vmw_gettime(struct ptp_clock_info *info, struct timespec64 *ts)
 {
 	u64 ns;
 
-	if (ptp_vmw_pclk_read(&ns) != 0)
+	if (ptp_vmw_pclk_read(VMWARE_CMD_PCLK_GETTIME, &ns) != 0)
 		return -EIO;
 	*ts = ns_to_timespec64(ns);
 	return 0;
@@ -59,7 +76,9 @@ static int ptp_vmw_gettime(struct ptp_clock_info *info, struct timespec64 *ts)
 static int ptp_vmw_settime(struct ptp_clock_info *info,
 			  const struct timespec64 *ts)
 {
-	return -EOPNOTSUPP;
+	u64 ns = timespec64_to_ns(ts);
+
+	return ptp_vmw_pclk_write(VMWARE_CMD_PCLK_SETTIME, ns);
 }
 
 static int ptp_vmw_enable(struct ptp_clock_info *info,
@@ -71,7 +90,7 @@ static int ptp_vmw_enable(struct ptp_clock_info *info,
 static struct ptp_clock_info ptp_vmw_clock_info = {
 	.owner		= THIS_MODULE,
 	.name		= "ptp_vmw",
-	.max_adj	= 0,
+	.max_adj	= 999999999,
 	.adjtime	= ptp_vmw_adjtime,
 	.adjfine	= ptp_vmw_adjfine,
 	.gettime64	= ptp_vmw_gettime,
-- 
2.40.4


