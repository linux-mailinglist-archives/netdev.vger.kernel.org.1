Return-Path: <netdev+bounces-154325-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B5879FCFEA
	for <lists+netdev@lfdr.de>; Fri, 27 Dec 2024 04:55:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92EF17A0FD1
	for <lists+netdev@lfdr.de>; Fri, 27 Dec 2024 03:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB15E481B6;
	Fri, 27 Dec 2024 03:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="Vfy9pvqz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BFB446A1
	for <netdev@vger.kernel.org>; Fri, 27 Dec 2024 03:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735271717; cv=none; b=tT7wRQB4WUeM1HrKeJE6K0kU8l5UjyqTWoVYCeKuGhM5tKfa4RjMY4hw5v6Cggi1gxaDFkT7SYDRO5MkulLaU9Dz7Kb9ebsYJiGIYmE6t1nMvILxj8UDu6cZIruLeqtaphXQWNZpOlVM7YDUCU05fWeYBP00/nsOFIQmskxLd8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735271717; c=relaxed/simple;
	bh=AfxkzgX8I5HKu23HcWsjSGM5w2pZbV7sDnJSpf4GaHE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WNAWlB0/KSgDJn1s/ntxWmP1nfxyi1bkh2tPJUL0LfPAK+K0yG9xRpgC9gY5Vsgq6QZDNq/VCdl8tOVe0ozxzOlMTCWXblZTthDLUqlZI/ap1JxhPT0iTVObBaYEwYJWdRRvnPJI2R+jw6l8oabMGrW93BMqwgS8CIQmsWQR32k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=Vfy9pvqz; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-216395e151bso59914015ad.0
        for <netdev@vger.kernel.org>; Thu, 26 Dec 2024 19:55:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1735271715; x=1735876515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cWwGlGKRBHUWO/a7dKvlUTDhtDD+VetBHtkfDGNAz2Y=;
        b=Vfy9pvqz25Wt1bUlUeOo+GPymj9rs/bjsMsu+twtR4j73MrZ8QlCEyIRD3OFyCwBiK
         YNMU5V4M05WdqGdqW9Fq7MZsir3uaCKxfWIT/8XW3B0T5+za+J0HZiuTlsU0V6br7ZVp
         6a1LCFGBErYmoYIklK1z+qaCo8TEZCHmPIfvLrL9j6A6s+77ApHY94G1ZKdxZGDU6LjB
         UMuMsmP+GqekLF0kmCRwM3i0o9QHaV3nXiEOiHSVMUlCEu+b8ZfCFsjhQWGdv48a4YYr
         vtiR8s12GoR4vwO/+IL6Z3i3hKczivtLwDR0vVz0+LKSnurJns0Zo8hkjwqbVCoU4ndh
         6IQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735271715; x=1735876515;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cWwGlGKRBHUWO/a7dKvlUTDhtDD+VetBHtkfDGNAz2Y=;
        b=CDh1/fDfuuIMeDnjMpY6vi2teYediIzZxqa/U3oqZIMsGa/Zss20ldzocSL6Rh/uSp
         A0aZrL4CSIjuoukXiPVaHbt61JrrEl+obkPpC4FstLbUvx4I7rsLSgyDCZ3G9qljwmG0
         +6WjKJHcHb7e0D6tcL1CTH6Gcsrk9mu0HI+Jc1oUIGSbP79wQlqqJRnp4LEoBdv0v38B
         QNtg/40Lk1yosbFprzDPrTH9my+soyxo3Bfu19Z25DO6jkQ+1IthWCVUh4XzhmdCQp+1
         tS0xmmpIpVUF8VwJNm1OeBU0Yct49TbIXg35ttxd5Wctehbqv4hnxTiFejC10V+A/QeZ
         h6wQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0Wtd3WNkWa2L3escgWxnwQ3L5Ad/D2v5RPIL4jYQrxaQyFpZhClI1c76WkGCQLIBECstzxvI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNapBfvjJxSe0Bz5tBSmwuxlE0+c0JRVqCFTMp6KjkC4ykmBWq
	8FGwammBajoHxj9cx3x/RT99ERuJqOTW3QXGfKkp8F+bXb0XoJvQ+ArVMfj3UT0=
X-Gm-Gg: ASbGncs8YVh0gHvbuScM5XQIn8D6v+wwxUsY9eq1+bzozd/1i6oVVVHWznV5wQa2dA3
	6hNmJlFSApTvQ+JgNzqkk7wfQbLiLWli69kPmba2bRe9HWyUPFBADOYR5kgeESjnGeQVNseZzDW
	n/mPRsr9JWsAsbgIHYJHAExz25XinCiXypGbXowFbOU09TbKoKCvwpYIeORLrGxibV2JJrmkQP1
	YReQGvugRD2IA9TLEIYzwJ+DauFP5D/Jvq2kg/8MBVwxuAB33VjMFtYeANBtOcd9Q660Lzc7Ly+
	G1jYw8JkRv875Lw=
X-Google-Smtp-Source: AGHT+IHDuLIcbu0hPHGa/G2uQ8mI4bKwiPV1xjD49qtnVtNbj/ofNv3MK+JAbrl4vueOmhZWxI6HCw==
X-Received: by 2002:a17:903:2a87:b0:216:3f6e:fabd with SMTP id d9443c01a7336-219da5cc2d0mr445657615ad.7.1735271715370;
        Thu, 26 Dec 2024 19:55:15 -0800 (PST)
Received: from R4NDHT277M.cn.corp.seagroup.com ([143.92.118.3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-842b229c48fsm10606252a12.26.2024.12.26.19.55.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 26 Dec 2024 19:55:14 -0800 (PST)
From: Yue Zhao <yue.zhao@shopee.com>
To: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: chunguang.xu@shopee.com,
	haifeng.xu@shopee.com,
	Yue Zhao <yue.zhao@shopee.com>
Subject: [PATCH] i40e: Disable i40e PCIe AER on system reboot
Date: Fri, 27 Dec 2024 11:54:59 +0800
Message-Id: <20241227035459.90602-1-yue.zhao@shopee.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Disable PCIe AER on the i40e device on system reboot on a limited
list of Dell PowerEdge systems. This prevents a fatal PCIe AER event
on the i40e device during the ACPI _PTS (prepare to sleep) method for
S5 on those systems. The _PTS is invoked by acpi_enter_sleep_state_prep()
as part of the kernel's reboot sequence as a result of commit
38f34dba806a ("PM: ACPI: reboot: Reinstate S5 for reboot").

We first noticed this abnormal reboot issue in tg3 device, and there
is a similar patch about disable PCIe AER to fix hardware error during
reboot. The hardware error in tg3 device has gone after we apply this
patch below.

https://lore.kernel.org/lkml/20241129203640.54492-1-lszubowi@redhat.com/T/

So we try to disable PCIe AER on the i40e device in the similar way.

hardware crash dmesg log:

ACPI: PM: Preparing to enter system sleep state S5
{1}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 5
{1}[Hardware Error]: event severity: fatal
{1}[Hardware Error]:  Error 0, type: fatal
{1}[Hardware Error]:   section_type: PCIe error
{1}[Hardware Error]:   port_type: 0, PCIe end point
{1}[Hardware Error]:   version: 3.0
{1}[Hardware Error]:   command: 0x0006, status: 0x0010
{1}[Hardware Error]:   device_id: 0000:05:00.1
{1}[Hardware Error]:   slot: 0
{1}[Hardware Error]:   secondary_bus: 0x00
{1}[Hardware Error]:   vendor_id: 0x8086, device_id: 0x1572
{1}[Hardware Error]:   class_code: 020000
{1}[Hardware Error]:   aer_uncor_status: 0x00100000, aer_uncor_mask: 0x00018000
{1}[Hardware Error]:   aer_uncor_severity: 0x000ef030
{1}[Hardware Error]:   TLP Header: 40000001 0000000f 90028090 00000000
Kernel panic - not syncing: Fatal hardware error!
Hardware name: Dell Inc. PowerEdge C4140/08Y2GR, BIOS 2.21.1 12/12/2023
Call Trace:
 <NMI>
 dump_stack_lvl+0x48/0x70
 dump_stack+0x10/0x20
 panic+0x1b4/0x3a0
 __ghes_panic+0x6c/0x70
 ghes_in_nmi_queue_one_entry.constprop.0+0x1ee/0x2c0
 ghes_notify_nmi+0x5e/0xe0
 nmi_handle+0x62/0x160
 default_do_nmi+0x4c/0x150
 exc_nmi+0x140/0x1f0
 end_repeat_nmi+0x16/0x67
RIP: 0010:intel_idle_irq+0x70/0xf0
 </NMI>
 <TASK>
 cpuidle_enter_state+0x91/0x6f0
 cpuidle_enter+0x2e/0x50
 call_cpuidle+0x23/0x60
 cpuidle_idle_call+0x11d/0x190
 do_idle+0x82/0xf0
 cpu_startup_entry+0x2a/0x30
 rest_init+0xc2/0xf0
 arch_call_rest_init+0xe/0x30
 start_kernel+0x34f/0x440
 x86_64_start_reservations+0x18/0x30
 x86_64_start_kernel+0xbf/0x110
 secondary_startup_64_no_verify+0x18f/0x19b
 </TASK>

Fixes: 38f34dba806a ("PM: ACPI: reboot: Reinstate S5 for reboot")
Signed-off-by: Yue Zhao <yue.zhao@shopee.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 64 +++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 0e1d9e2fbf38..80e66e4e90f7 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -8,6 +8,7 @@
 #include <linux/module.h>
 #include <net/pkt_cls.h>
 #include <net/xdp_sock_drv.h>
+#include <linux/dmi.h>
 
 /* Local includes */
 #include "i40e.h"
@@ -16608,6 +16609,56 @@ static void i40e_pci_error_resume(struct pci_dev *pdev)
 	i40e_io_resume(pf);
 }
 
+/* Systems where ACPI _PTS (Prepare To Sleep) S5 will result in a fatal
+ * PCIe AER event on the i40e device if the i40e device is not, or cannot
+ * be, powered down.
+ */
+static const struct dmi_system_id i40e_restart_aer_quirk_table[] = {
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "PowerEdge C4140"),
+		},
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "PowerEdge R440"),
+		},
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "PowerEdge R540"),
+		},
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "PowerEdge R640"),
+		},
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "PowerEdge R650"),
+		},
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "PowerEdge R740"),
+		},
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "PowerEdge R750"),
+		},
+	},
+	{}
+};
+
 /**
  * i40e_shutdown - PCI callback for shutting down
  * @pdev: PCI device information struct
@@ -16654,6 +16705,19 @@ static void i40e_shutdown(struct pci_dev *pdev)
 	i40e_clear_interrupt_scheme(pf);
 	rtnl_unlock();
 
+	if (system_state == SYSTEM_RESTART &&
+		dmi_first_match(i40e_restart_aer_quirk_table) &&
+		pdev->current_state <= PCI_D3hot) {
+		/* Disable PCIe AER on the i40e to avoid a fatal
+		 * error during this system restart.
+		 */
+		pcie_capability_clear_word(pdev, PCI_EXP_DEVCTL,
+					   PCI_EXP_DEVCTL_CERE |
+					   PCI_EXP_DEVCTL_NFERE |
+					   PCI_EXP_DEVCTL_FERE |
+					   PCI_EXP_DEVCTL_URRE);
+	}
+
 	if (system_state == SYSTEM_POWER_OFF) {
 		pci_wake_from_d3(pdev, pf->wol_en);
 		pci_set_power_state(pdev, PCI_D3hot);
-- 
2.39.5 (Apple Git-154)


