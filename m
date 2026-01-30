Return-Path: <netdev+bounces-255204-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SG4yF1TtfGmdPQIAu9opvQ
	(envelope-from <netdev+bounces-255204-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 18:41:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B346BD626
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 18:41:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 65C0B3031135
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 17:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F68C37C0F5;
	Fri, 30 Jan 2026 17:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="myLIVi35"
X-Original-To: netdev@vger.kernel.org
Received: from pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.34.181.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD8D37D104;
	Fri, 30 Jan 2026 17:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.34.181.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769794649; cv=none; b=K1WhR2cAaf75khtURzHKxdtCtnkJesXpkY5pXZyMtdQz3hscCftmjnROP88YzM58mgp8+xlB3JiL+Jj/oPcZrkSib+QT3bc/cOGnAbdxZRjUW8dvD7Sx9uwQbfwxC25urBMUg9M5aaW+ty8a2+d6lOeYE3no/w/lYunhRIquu7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769794649; c=relaxed/simple;
	bh=qd7OuSMeyfx2vbahH2DvVR71ZMlZ2ZkNC6n9Ks9VfpY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Svs/360mcjrCSP3eWtYOsb4NGjQaRqkCFtgQmoMvB5J8bDPlugJhgSpDrQr8XS1glodmVJf9wwA8XWRpbIwTJTqTlGhZ3g9+gidKZHC6FdG0mcUVd4P0odrVNGYqRhBcadwqcNJbvwqGIEHpTJb4Zc7iNYB0DBLhSO3S/IEIwFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=myLIVi35; arc=none smtp.client-ip=52.34.181.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1769794648; x=1801330648;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pGq67HxLwPOMeoy7DWGTj0PKuwBUDlWYUTExVg0WhLg=;
  b=myLIVi35T9KEgDGVPFFfpIx3zNqMe0Mn3d11JNYLazKwAVrJzQu0blhj
   H1czErC7Yiav5VJckXqVQuJ2h9z4bmbDzxT7dTSN21VktowmL1WWnBapw
   DkGDvZT8zwqehTaG7ZsIdNGceV+AJOBPhBn2ojKPWCYi2TzFI/i7Ip2Lx
   /hXk0DcJKXRTDrCQ+cVZbJQHsv0I2sqvb6yI3K2hMv9bIiMmzJqHNr3ZH
   dmpILJim/0h9geGP51J3iAG0Q39O/22DLPY587fR4bl/uLJuzsx5jjCOS
   q6QNLyHoIlSP70XweCCVRtL9aFsEBXVhT5DebJ65lNXcehBvdJHbRB/SF
   w==;
X-CSE-ConnectionGUID: A5f1qz+dQeeHrzL9NZoWnA==
X-CSE-MsgGUID: 6/YGN6fgTTK1DK2N3OBbgg==
X-IronPort-AV: E=Sophos;i="6.21,263,1763424000"; 
   d="scan'208";a="11942245"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2026 17:37:25 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.111:11861]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.0.123:2525] with esmtp (Farcaster)
 id 51784996-2e85-43ff-9784-38e16fd4490a; Fri, 30 Jan 2026 17:37:24 +0000 (UTC)
X-Farcaster-Flow-ID: 51784996-2e85-43ff-9784-38e16fd4490a
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Fri, 30 Jan 2026 17:37:24 +0000
Received: from dev-dsk-itazur-1b-11e7fc0f.eu-west-1.amazon.com (172.19.66.53)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Fri, 30 Jan 2026 17:37:21 +0000
From: Takahiro Itazuri <itazur@amazon.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <devicetree@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Babis Chalios <mail@bchalios.io>, "Alexander
 Graf" <graf@amazon.de>, <mzxreary@0pointer.de>, Marco Cali
	<xmarcalx@amazon.co.uk>, David Woodhouse <dwmw@amazon.co.uk>, "Takahiro
 Itazuri" <itazur@amazon.com>
Subject: [PATCH v7 2/7] ptp: vmclock: support device notifications
Date: Fri, 30 Jan 2026 17:36:01 +0000
Message-ID: <20260130173704.12575-3-itazur@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260130173704.12575-1-itazur@amazon.com>
References: <20260130173704.12575-1-itazur@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D031UWC004.ant.amazon.com (10.13.139.246) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-6.66 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-255204-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amazon.co.uk:email,amazon.es:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[itazur@amazon.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amazon.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 9B346BD626
X-Rspamd-Action: no action

From: Babis Chalios <bchalios@amazon.es>

Add optional support for device notifications in VMClock. When
supported, the hypervisor will send a device notification every time it
updates the seq_count to a new even value.

Moreover, add support for poll() in VMClock as a means to propagate this
notification to user space. poll() will return a POLLIN event to
listeners every time seq_count changes to a value different than the one
last seen (since open() or last read()/pread()). This means that when
poll() returns a POLLIN event, listeners need to use read() to observe
what has changed and update the reader's view of seq_count. In other
words, after a poll() returned, all subsequent calls to poll() will
immediately return with a POLLIN event until the listener calls read().

The device advertises support for the notification mechanism by setting
flag VMCLOCK_FLAG_NOTIFICATION_PRESENT in vmclock_abi flags field. If
the flag is not present the driver won't setup the ACPI notification
handler and poll() will always immediately return POLLHUP.

Signed-off-by: Babis Chalios <bchalios@amazon.es>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Takahiro Itazuri <itazur@amazon.com>
Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Tested-by: Takahiro Itazuri <itazur@amazon.com>
---
 drivers/ptp/ptp_vmclock.c        | 162 +++++++++++++++++++++++++++----
 include/uapi/linux/vmclock-abi.h |   5 +
 2 files changed, 148 insertions(+), 19 deletions(-)

diff --git a/drivers/ptp/ptp_vmclock.c b/drivers/ptp/ptp_vmclock.c
index b3a83b03d..f8b24f9e8 100644
--- a/drivers/ptp/ptp_vmclock.c
+++ b/drivers/ptp/ptp_vmclock.c
@@ -5,6 +5,9 @@
  * Copyright © 2024 Amazon.com, Inc. or its affiliates.
  */
 
+#include "linux/poll.h"
+#include "linux/types.h"
+#include "linux/wait.h"
 #include <linux/acpi.h>
 #include <linux/device.h>
 #include <linux/err.h>
@@ -39,6 +42,7 @@ struct vmclock_state {
 	struct resource res;
 	struct vmclock_abi *clk;
 	struct miscdevice miscdev;
+	wait_queue_head_t disrupt_wait;
 	struct ptp_clock_info ptp_clock_info;
 	struct ptp_clock *ptp_clock;
 	enum clocksource_ids cs_id, sys_cs_id;
@@ -357,10 +361,15 @@ static struct ptp_clock *vmclock_ptp_register(struct device *dev,
 	return ptp_clock_register(&st->ptp_clock_info, dev);
 }
 
+struct vmclock_file_state {
+	struct vmclock_state *st;
+	atomic_t seq;
+};
+
 static int vmclock_miscdev_mmap(struct file *fp, struct vm_area_struct *vma)
 {
-	struct vmclock_state *st = container_of(fp->private_data,
-						struct vmclock_state, miscdev);
+	struct vmclock_file_state *fst = fp->private_data;
+	struct vmclock_state *st = fst->st;
 
 	if ((vma->vm_flags & (VM_READ|VM_WRITE)) != VM_READ)
 		return -EROFS;
@@ -379,11 +388,11 @@ static int vmclock_miscdev_mmap(struct file *fp, struct vm_area_struct *vma)
 static ssize_t vmclock_miscdev_read(struct file *fp, char __user *buf,
 				    size_t count, loff_t *ppos)
 {
-	struct vmclock_state *st = container_of(fp->private_data,
-						struct vmclock_state, miscdev);
 	ktime_t deadline = ktime_add(ktime_get(), VMCLOCK_MAX_WAIT);
+	struct vmclock_file_state *fst = fp->private_data;
+	struct vmclock_state *st = fst->st;
+	uint32_t seq, old_seq;
 	size_t max_count;
-	uint32_t seq;
 
 	if (*ppos >= PAGE_SIZE)
 		return 0;
@@ -392,6 +401,7 @@ static ssize_t vmclock_miscdev_read(struct file *fp, char __user *buf,
 	if (count > max_count)
 		count = max_count;
 
+	old_seq = atomic_read(&fst->seq);
 	while (1) {
 		seq = le32_to_cpu(st->clk->seq_count) & ~1U;
 		/* Pairs with hypervisor wmb */
@@ -402,8 +412,16 @@ static ssize_t vmclock_miscdev_read(struct file *fp, char __user *buf,
 
 		/* Pairs with hypervisor wmb */
 		virt_rmb();
-		if (seq == le32_to_cpu(st->clk->seq_count))
-			break;
+		if (seq == le32_to_cpu(st->clk->seq_count)) {
+			/*
+			 * Either we updated fst->seq to seq (the latest version we observed)
+			 * or someone else did (old_seq == seq), so we can break.
+			 */
+			if (atomic_try_cmpxchg(&fst->seq, &old_seq, seq) ||
+			    old_seq == seq) {
+				break;
+			}
+		}
 
 		if (ktime_after(ktime_get(), deadline))
 			return -ETIMEDOUT;
@@ -413,25 +431,62 @@ static ssize_t vmclock_miscdev_read(struct file *fp, char __user *buf,
 	return count;
 }
 
+static __poll_t vmclock_miscdev_poll(struct file *fp, poll_table *wait)
+{
+	struct vmclock_file_state *fst = fp->private_data;
+	struct vmclock_state *st = fst->st;
+	uint32_t seq;
+
+	/*
+	 * Hypervisor will not send us any notifications, so fail immediately
+	 * to avoid having caller sleeping for ever.
+	 */
+	if (!(le64_to_cpu(st->clk->flags) & VMCLOCK_FLAG_NOTIFICATION_PRESENT))
+		return POLLHUP;
+
+	poll_wait(fp, &st->disrupt_wait, wait);
+
+	seq = le32_to_cpu(st->clk->seq_count);
+	if (atomic_read(&fst->seq) != seq)
+		return POLLIN | POLLRDNORM;
+
+	return 0;
+}
+
+static int vmclock_miscdev_open(struct inode *inode, struct file *fp)
+{
+	struct vmclock_state *st = container_of(fp->private_data,
+						struct vmclock_state, miscdev);
+	struct vmclock_file_state *fst = kzalloc(sizeof(*fst), GFP_KERNEL);
+
+	if (!fst)
+		return -ENOMEM;
+
+	fst->st = st;
+	atomic_set(&fst->seq, 0);
+
+	fp->private_data = fst;
+
+	return 0;
+}
+
+static int vmclock_miscdev_release(struct inode *inode, struct file *fp)
+{
+	kfree(fp->private_data);
+	return 0;
+}
+
 static const struct file_operations vmclock_miscdev_fops = {
 	.owner = THIS_MODULE,
+	.open = vmclock_miscdev_open,
+	.release = vmclock_miscdev_release,
 	.mmap = vmclock_miscdev_mmap,
 	.read = vmclock_miscdev_read,
+	.poll = vmclock_miscdev_poll,
 };
 
 /* module operations */
 
-static void vmclock_remove(void *data)
-{
-	struct vmclock_state *st = data;
-
-	if (st->ptp_clock)
-		ptp_clock_unregister(st->ptp_clock);
-
-	if (st->miscdev.minor != MISC_DYNAMIC_MINOR)
-		misc_deregister(&st->miscdev);
-}
-
 static acpi_status vmclock_acpi_resources(struct acpi_resource *ares, void *data)
 {
 	struct vmclock_state *st = data;
@@ -459,6 +514,44 @@ static acpi_status vmclock_acpi_resources(struct acpi_resource *ares, void *data
 	return AE_ERROR;
 }
 
+static void
+vmclock_acpi_notification_handler(acpi_handle __always_unused handle,
+				  u32 __always_unused event, void *dev)
+{
+	struct device *device = dev;
+	struct vmclock_state *st = device->driver_data;
+
+	wake_up_interruptible(&st->disrupt_wait);
+}
+
+static int vmclock_setup_notification(struct device *dev, struct vmclock_state *st)
+{
+	struct acpi_device *adev = ACPI_COMPANION(dev);
+	acpi_status status;
+
+	/*
+	 * This should never happen as this function is only called when
+	 * has_acpi_companion(dev) is true, but the logic is sufficiently
+	 * complex that Coverity can't see the tautology.
+	 */
+	if (!adev)
+		return -ENODEV;
+
+	/* The device does not support notifications. Nothing else to do */
+	if (!(le64_to_cpu(st->clk->flags) & VMCLOCK_FLAG_NOTIFICATION_PRESENT))
+		return 0;
+
+	status = acpi_install_notify_handler(adev->handle, ACPI_DEVICE_NOTIFY,
+					     vmclock_acpi_notification_handler,
+					     dev);
+	if (ACPI_FAILURE(status)) {
+		dev_err(dev, "failed to install notification handler");
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
 static int vmclock_probe_acpi(struct device *dev, struct vmclock_state *st)
 {
 	struct acpi_device *adev = ACPI_COMPANION(dev);
@@ -482,6 +575,30 @@ static int vmclock_probe_acpi(struct device *dev, struct vmclock_state *st)
 	return 0;
 }
 
+static void vmclock_remove(void *data)
+{
+	struct device *dev = data;
+	struct vmclock_state *st = dev->driver_data;
+
+	if (!st) {
+		dev_err(dev, "%s called with NULL driver_data", __func__);
+		return;
+	}
+
+	if (has_acpi_companion(dev))
+		acpi_remove_notify_handler(ACPI_COMPANION(dev)->handle,
+					   ACPI_DEVICE_NOTIFY,
+					   vmclock_acpi_notification_handler);
+
+	if (st->ptp_clock)
+		ptp_clock_unregister(st->ptp_clock);
+
+	if (st->miscdev.minor != MISC_DYNAMIC_MINOR)
+		misc_deregister(&st->miscdev);
+
+	dev->driver_data = NULL;
+}
+
 static void vmclock_put_idx(void *data)
 {
 	struct vmclock_state *st = data;
@@ -545,7 +662,14 @@ static int vmclock_probe(struct platform_device *pdev)
 
 	st->miscdev.minor = MISC_DYNAMIC_MINOR;
 
-	ret = devm_add_action_or_reset(&pdev->dev, vmclock_remove, st);
+	init_waitqueue_head(&st->disrupt_wait);
+	dev->driver_data = st;
+
+	ret = devm_add_action_or_reset(&pdev->dev, vmclock_remove, dev);
+	if (ret)
+		return ret;
+
+	ret = vmclock_setup_notification(dev, st);
 	if (ret)
 		return ret;
 
diff --git a/include/uapi/linux/vmclock-abi.h b/include/uapi/linux/vmclock-abi.h
index 937fe00e4..d320623b0 100644
--- a/include/uapi/linux/vmclock-abi.h
+++ b/include/uapi/linux/vmclock-abi.h
@@ -121,6 +121,11 @@ struct vmclock_abi {
 	 * loaded from some save state (restored from a snapshot).
 	 */
 #define VMCLOCK_FLAG_VM_GEN_COUNTER_PRESENT     (1 << 8)
+	/*
+	 * If the NOTIFICATION_PRESENT flag is set, the hypervisor will send
+	 * a notification every time it updates seq_count to a new even number.
+	 */
+#define VMCLOCK_FLAG_NOTIFICATION_PRESENT       (1 << 9)
 
 	__u8 pad[2];
 	__u8 clock_status;
-- 
2.50.1


