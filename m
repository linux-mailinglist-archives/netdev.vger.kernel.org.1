Return-Path: <netdev+bounces-232124-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B5AC8C016E9
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 15:33:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 76DA750034D
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 13:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC24A33C517;
	Thu, 23 Oct 2025 13:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="GoPbJ9ti"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com [209.85.214.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC3E320CBA
	for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 13:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761226035; cv=none; b=rd7q/hoflRKae8ySAXuapNPCRajGKL01j6B/2H/nxsxZgAu/jExnCesdOw/tHRjY82x+QoOyaaMVjPJsaFP215GBSRt8U2nAM6tqDPkwvAw0H4FBU6RmCcFbwvpnbhyq2RiS+uiwari13ceiX3DEiffxQUnlTyZwlG2yfeKA0WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761226035; c=relaxed/simple;
	bh=AXr+tzfOn3Q/HLQ3wexAh6fBD+j+XCPeTmgXNdkLmqQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p1g8u39/n6FhS+dvanGjxjhvlp6YF63AD87uU4xCJqahhTOmugikvb6ZdVTqBxlDpVCTRFD/273aB93aEa2/InO7+M+5sy+MACwZaWMpemBkTK2CfoPLl+Zsh66mBYyuoRgAn//ycdCuyyj9FnEk70Kh7eYI9624XCM1dc+DHbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=GoPbJ9ti; arc=none smtp.client-ip=209.85.214.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f228.google.com with SMTP id d9443c01a7336-27c369f898fso12457135ad.3
        for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 06:27:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761226033; x=1761830833;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tbV5rahZ/BOf/pG+Df+z4Hvsda1kZ/x4HpNILftqJqA=;
        b=GKTXVoO/TH+lR/eOyc2E4GnITXUlEhbz7pP5D7kfgFzFPUUdIXY63ECMiJMG3cCvWH
         9CItlq0yYf3MMKtK8XuoWYfNQ+LCwUUhpvKBfzjq+aXoai+jcxP6NNnoUT5KSxDXmKX4
         2CBxkPIQ4YkzWAfmhKrRWQrIr66kxLROmdq1s0nsVKw/tywSJMcMT5E6lG9pYfJ1rQAu
         L6VX+D4lYw1uzHBNOnxB8dTeJ+0rh3YPX8ft/jJUDUVW8jOtCunEe3aAlgPdinXzDAsa
         4NOFd4H7rla9ByqWZ//zc0w9RKYtPXhTUi/AIl6QxDKeR0cyFYWhwGp3xFZm1qcM/PNw
         GiUw==
X-Gm-Message-State: AOJu0YzbdtKhpF4SCWIROTzfLosf2iroGkRg7/SAw3WQMmoJuaOxDb9r
	/HsRanJDgqghHiBUAIX7w2N08Z6HJ9m+iJtzM4K+MN5a8U2pvhKIrNavMbmnzoZSEiykWAgWZVN
	yhl1D0Zaculc2DumHQnCh2WLQeTpw8oDhYXlHv8ONLpCo/aF9sBBI50Ng8sEdLwzHwxXILml8aM
	0x6sfzrKl2GdrNqdH+Av7VoMYMBO400szBqh2XApN3CBsLekVrdoVo320kqITdYOEFs4GrPb5nt
	Q5RPaEg
X-Gm-Gg: ASbGnctj2gfz7chTBmKkYYuepfxt8B+t2bJ1wDL3kTMdbpVbhGZkYw8IJcuGzN5pSLj
	NXjSJBvcSh5N7CAnUUWgQfeuNUYer9+S9l6/uYeS3L3OKkAyAywhZFKKvbPDRi3WSDkD/xcf5nN
	934ZUEOk1EPaY2GNDADYX5PiA6k1v2CfeWpZoVqORe7ptya3O2S/VftBVib4LlsJx4z8Aj8VN5R
	aLMVv3cBvM39F8cLN5d9PXxf7PWi4WUI9SEIX9S+y/uE42FFBi6FS43Ztq750l/sYsgPBDL/WVf
	OEKsL2a42X0xIbukTv67I5vG5Sqz/gKekG11AHbOCe2p5SzOhZzyw+kd0rnLxTdXKlf/4K15Wgb
	dV+VOD+34Pb7YBev2XvgqM88PjgCp1fNiwMTDW1yWpDLYMoyy5xBNR28+EzuxzlaXbTqV/cxEfq
	+owk4GXRs+oZRyiJgz6hT3ofpOHfQP2BYGxw==
X-Google-Smtp-Source: AGHT+IGdlB6rdrxWr/85absw8ps6FSDqoFQ79rQPO+bSKTxdlgl51Q8ver0x5qr5l631TZIX1YPxRZgcyJwa
X-Received: by 2002:a17:902:ec87:b0:269:82a5:fa19 with SMTP id d9443c01a7336-290cb07cbbbmr282742305ad.45.1761226033288;
        Thu, 23 Oct 2025 06:27:13 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-124.dlp.protect.broadcom.com. [144.49.247.124])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2946de173ddsm2208715ad.20.2025.10.23.06.27.12
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Oct 2025 06:27:13 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2697410e7f9so20709935ad.2
        for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 06:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1761226032; x=1761830832; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tbV5rahZ/BOf/pG+Df+z4Hvsda1kZ/x4HpNILftqJqA=;
        b=GoPbJ9tiqGuFZw4Gxh8twUCh7/IWU6ZXdXcfcnUzhsxHASIbsdvog+4IEkoEned/d/
         ly/HCigb8UnL4gCgPQhadO15TX/k3GwpPGoubQEtT2dLr8GoTiqoGxz2e1mOQRisttDk
         Y5fsj5f8u5MT2pX8dw1Rgubm0YVYRtfNVM7xg=
X-Received: by 2002:a17:903:1746:b0:28e:7ea4:2023 with SMTP id d9443c01a7336-290cb07d430mr296051905ad.46.1761226031583;
        Thu, 23 Oct 2025 06:27:11 -0700 (PDT)
X-Received: by 2002:a17:903:1746:b0:28e:7ea4:2023 with SMTP id d9443c01a7336-290cb07d430mr296051525ad.46.1761226031051;
        Thu, 23 Oct 2025 06:27:11 -0700 (PDT)
Received: from photon-dev-haas.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946dfc204fsm23739785ad.60.2025.10.23.06.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 06:27:10 -0700 (PDT)
From: Ajay Kaher <ajay.kaher@broadcom.com>
To: vadim.fedorenko@linux.dev,
	kuba@kernel.org,
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
Subject: [PATCH v3 2/2] ptp/ptp_vmw: load ptp_vmw driver by directly probing the device
Date: Thu, 23 Oct 2025 13:10:48 +0000
Message-Id: <20251023131048.3718441-3-ajay.kaher@broadcom.com>
X-Mailer: git-send-email 2.40.4
In-Reply-To: <20251023131048.3718441-1-ajay.kaher@broadcom.com>
References: <20251023131048.3718441-1-ajay.kaher@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

For scenerios when ACPI is disabled, allow ptp_vmw driver to be
loaded by directly probing for the device using VMware hypercalls.

VMware precision clock virtual device is exposed as a platform ACPI
device in its virtual chipset hardware. Its driver - ptp_vmw - is
registered with the ACPI bus for discovery and binding. On systems
where ACPI is disabled, such as virtual machines optimized for fast
boot times, this means that the device is not discoverable and cannot
be loaded. Since the device operations are performed via VMware
hypercalls, the ACPI sub-system can be by-passed and manually loaded.

Cc: Shubham Gupta <shubham-sg.gupta@broadcom.com>
Cc: Nick Shi <nick.shi@broadcom.com>
Tested-by: Karen Wang <karen.wang@broadcom.com>
Tested-by: Hari Krishna Ginka <hari-krishna.ginka@broadcom.com>
Signed-off-by: Ajay Kaher <ajay.kaher@broadcom.com>
---
 drivers/ptp/ptp_vmw.c | 70 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 58 insertions(+), 12 deletions(-)

diff --git a/drivers/ptp/ptp_vmw.c b/drivers/ptp/ptp_vmw.c
index ea1cbdf34..93d33e5cd 100644
--- a/drivers/ptp/ptp_vmw.c
+++ b/drivers/ptp/ptp_vmw.c
@@ -98,25 +98,41 @@ static struct ptp_clock_info ptp_vmw_clock_info = {
 	.enable		= ptp_vmw_enable,
 };
 
+static int ptp_vmw_clock_register(void)
+{
+	ptp_vmw_clock = ptp_clock_register(&ptp_vmw_clock_info, NULL);
+	if (IS_ERR(ptp_vmw_clock)) {
+		pr_err("ptp_vmw: Failed to register ptp clock\n");
+		return PTR_ERR(ptp_vmw_clock);
+	}
+	pr_debug("ptp_vmw: ptp clock registered\n");
+	return 0;
+}
+
+static void ptp_vmw_clock_unregister(void)
+{
+	ptp_clock_unregister(ptp_vmw_clock);
+	ptp_vmw_clock = NULL;
+	pr_debug("ptp_vmw: ptp clock unregistered\n");
+}
+
 /*
  * ACPI driver ops for VMware "precision clock" virtual device.
  */
 
 static int ptp_vmw_acpi_add(struct acpi_device *device)
 {
-	ptp_vmw_clock = ptp_clock_register(&ptp_vmw_clock_info, NULL);
-	if (IS_ERR(ptp_vmw_clock)) {
-		pr_err("failed to register ptp clock\n");
-		return PTR_ERR(ptp_vmw_clock);
-	}
+	int ret = ptp_vmw_clock_register();
 
-	ptp_vmw_acpi_device = device;
-	return 0;
+	if (ret == 0)
+		ptp_vmw_acpi_device = device;
+	return ret;
 }
 
 static void ptp_vmw_acpi_remove(struct acpi_device *device)
 {
-	ptp_clock_unregister(ptp_vmw_clock);
+	ptp_vmw_clock_unregister();
+	ptp_vmw_acpi_device = NULL;
 }
 
 static const struct acpi_device_id ptp_vmw_acpi_device_ids[] = {
@@ -135,16 +151,46 @@ static struct acpi_driver ptp_vmw_acpi_driver = {
 	},
 };
 
+/*
+ * Probe existence of device by poking at a command. If successful,
+ * register as a PTP clock. This is a fallback option for when ACPI
+ * is not available.
+ */
+static int ptp_vmw_probe(void)
+{
+	u64 ns;
+
+	return ptp_vmw_pclk_read(&ns);
+}
+
 static int __init ptp_vmw_init(void)
 {
-	if (x86_hyper_type != X86_HYPER_VMWARE)
-		return -1;
-	return acpi_bus_register_driver(&ptp_vmw_acpi_driver);
+	int error = -ENODEV;
+
+	if (x86_hyper_type != X86_HYPER_VMWARE) {
+		error = -EINVAL;
+		goto out;
+	}
+
+	if (!acpi_disabled) {
+		error = acpi_bus_register_driver(&ptp_vmw_acpi_driver);
+		if (!error)
+			goto out;
+	}
+
+	if (!ptp_vmw_probe())
+		error = ptp_vmw_clock_register();
+
+out:
+	return error;
 }
 
 static void __exit ptp_vmw_exit(void)
 {
-	acpi_bus_unregister_driver(&ptp_vmw_acpi_driver);
+	if (!acpi_disabled && ptp_vmw_acpi_device)
+		acpi_bus_unregister_driver(&ptp_vmw_acpi_driver);
+	else if (ptp_vmw_clock)
+		ptp_vmw_clock_unregister();
 }
 
 module_init(ptp_vmw_init);
-- 
2.40.4


