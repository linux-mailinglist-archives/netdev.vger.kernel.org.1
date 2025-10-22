Return-Path: <netdev+bounces-231615-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 184D0BFB8C3
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 13:08:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DEAE3B8861
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 11:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A48E432B983;
	Wed, 22 Oct 2025 11:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="aizQs/xl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f228.google.com (mail-il1-f228.google.com [209.85.166.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36AC329C51
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 11:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761131238; cv=none; b=ZWBV++m/FEfh4y99dMksnAXdr6WfphPjZYQtixxc/aYp0Ux2ZK06ncwD6d5bgyFIsXt2/KfHejdpuEw4f43TDQZcDD2Fp6nZr64D/ctm3pk3sw6dBMglB8dM+oB4wSQoOdjA6bNxQA3mS2gT/nKdqzRcelbzP2mDSHtP3riG5Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761131238; c=relaxed/simple;
	bh=FwmuKze520gii68OMa9zuCrP0na+LNpw1uC7/S6jaX0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cwIpAIpYo6vyw7hFMxpoo11A+YyCxuNrk9e1oPnMGMTvL5DDsbETjeiMx5pAmnB5RuWo26X4azmH57tsx5zrFyaijWbD5PIdjkAuaqd8OzmaEsaWRzw9WKIfGKwMIivfEN7dA7UpV/nmN3eMQg+3eWgo4aGnzUumhnBvHi/AEz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=aizQs/xl; arc=none smtp.client-ip=209.85.166.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-il1-f228.google.com with SMTP id e9e14a558f8ab-430da72d67bso4179745ab.1
        for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 04:07:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761131236; x=1761736036;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7fB5PRpKOjT2mJVqyOTvbhIcOjE9XXiUVHYGkgGRTqY=;
        b=loYxFpWST5Up+mblbpg9HhCTPjNV5w8e854e+OmiacW2NbHn2Vs4Qg2uO60SkgWMuH
         Q0ulXrsLzWI+pPDwcw8y/Q4TfTKpbVULxMs8ilJWn8k4jApht1SjeHHDrlMod+s9iDRr
         HKVaSFFDoj4EyBeBCXdJoXuAsVuBwMq5XkasOW+Ii79etxpPhUunqfd/wDsNvvUTOSJT
         K94m9knSH4u74H4AcQpFbZU/dBIFcFBaIsCeMCPESkcSWFA0Xo/TcJm6yL1LQvPZaID6
         2y7Qxnp7LeXDl1iAVyGQMKVwoh7IXDviPsZg8yRxYez3xXxpjYrgi6WEJS61vI0R4uIm
         Sn6w==
X-Gm-Message-State: AOJu0YxRfA3PkO4dvRKH9XLwrKpzeIt8G47dlBp31wgFf9GX98Yu3MPW
	DG8xFjmO3Rz6aHaF0lkyipdTGx7MjIRXJGeJGZUA2JPgfTTaSGYtAnisWMasYdOgCkf0h8A6L7q
	IQSkoK4L//yk8colBjt1ETWTBfhLhD55DMxBgM7mszBNesi+LpJ/ErW3yCX7g37xh4Hecd8E1Py
	sEJGVWJNmav2e/1pHuuqUIX4YRIzr6lSKZC4NPKhj9cwM6tt9RmzLrOucjkZlQrQwn83Vf9L3Ut
	5x5vcvu1JY=
X-Gm-Gg: ASbGncvZjw6kNbQTzPMLSxu6lCg5CeAi1RE9M2dz1VeyG/tYzwJ4qw+x3exzMrAEu2+
	uZ2L7J1uXEZ9BYWO2RSlU6QWrZtKZyeH8B6cldzY6MML3tywFODply+n2Wst8s//MKnG36NDHr+
	Z4CEizDziW3s2eCde1fJF2pFq/7rad3jrEYZ4fIrb6Mh2MsGRpY0t7YoVl6SPHN+yJp8ryBzWcU
	X1A+ISnCqy18Q56H6fG4qeeA9Ys0J4UgHVa8L6iggdCQHWCIl3+EPw4uJl9hPkHgHiYlBZwzimm
	HravMD81oQEtSStWgX0gEGY7RMrFCFA2nywjKCbinrtcOvxjbF8wqeA0FNNf6b6S2xJrOCLn+yU
	Ad13YJIBOI2FnheBO/Ebp3SUNXOotArGo+jZvLuhSz1s0OzGKVSEc6ghCcVYIqxMwS/g6nloogT
	4pKqExlP2rSqHoLJaNK1oRE+CgE5mtcRI=
X-Google-Smtp-Source: AGHT+IGASjCimGriyi+Q2pjqMUnl6uFYLgXHXVXUWiMD3t7Ylp0kETCLAn3BSgyEQcjecxT2EahCxb2lcZkW
X-Received: by 2002:a05:6e02:2189:b0:430:e5a4:6f26 with SMTP id e9e14a558f8ab-431d72cb3c8mr10547065ab.6.1761131235900;
        Wed, 22 Oct 2025 04:07:15 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-19.dlp.protect.broadcom.com. [144.49.247.19])
        by smtp-relay.gmail.com with ESMTPS id e9e14a558f8ab-431d85aa207sm298875ab.22.2025.10.22.04.07.15
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Oct 2025 04:07:15 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2909daa65f2so10627705ad.0
        for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 04:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1761131234; x=1761736034; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7fB5PRpKOjT2mJVqyOTvbhIcOjE9XXiUVHYGkgGRTqY=;
        b=aizQs/xl1mUCkYcHScPFtQ7m6Xo42IEhSXoVn1079raFotWqloKvt13J4bHOCksUzb
         gdzZyeKpbkjSMGuytQ4A2X60bUX/59GitketaHL/ueN++ZAU/RR7S5ZTWk37c2r+W8uH
         mY6ELD3BEHGQlWKjjzPUg41NxEAvwoZ3lO5Ag=
X-Received: by 2002:a17:902:d509:b0:269:8eba:e9b2 with SMTP id d9443c01a7336-292ffc97bfamr41948405ad.29.1761131234185;
        Wed, 22 Oct 2025 04:07:14 -0700 (PDT)
X-Received: by 2002:a17:902:d509:b0:269:8eba:e9b2 with SMTP id d9443c01a7336-292ffc97bfamr41948175ad.29.1761131233780;
        Wed, 22 Oct 2025 04:07:13 -0700 (PDT)
Received: from photon-dev-haas.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29246ffeec3sm135964955ad.52.2025.10.22.04.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 04:07:13 -0700 (PDT)
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
Subject: [PATCH v2 2/2] ptp/ptp_vmw: load ptp_vmw driver by directly probing the device
Date: Wed, 22 Oct 2025 10:51:28 +0000
Message-Id: <20251022105128.3679902-3-ajay.kaher@broadcom.com>
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
index 7d117eee4..a3978501a 100644
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
+	return ptp_vmw_pclk_read(VMWARE_CMD_PCLK_GETTIME, &ns);
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


