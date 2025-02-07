Return-Path: <netdev+bounces-163898-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 71233A2BF9F
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 10:40:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A59D97A2642
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 09:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13576235C05;
	Fri,  7 Feb 2025 09:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kNoc2Jm9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AkBuFU6r"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601811DE2CB;
	Fri,  7 Feb 2025 09:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738921153; cv=none; b=MBKrWEWSwH9FMKOkzijtrSmtqPV/RcWBbr5B48hF3NL0hrTi8v1L2158JHMhTA4lxevBIm8mqm55obncBeeCfhZ6ngyAAknmV4c3hu5S6efQxytuAI3J4sw9w4E/GET56EJ94qupNuVzGhAkgnjpAyiNjsu2BC+t/VE5flkvDN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738921153; c=relaxed/simple;
	bh=9BdvaiGN4CMxY+MnMBf0Cl2uZSErRtKmf5nqWW9+l0M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=upR9Ik2IggF0M5OfcLRVDRTNl+uTkWIyRMHtJusMvGrp/m/k/VzbGaFSPCRrEVLoCeGgA30i8sEZMVOvSihSrBedb0cgEikHaDvS+gpVolJclRg+XW6tXOd48TuAbrVX0wpIxV3TcB21nhvHBd++1sHgCe4A7LxZ3MldtfHelVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kNoc2Jm9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AkBuFU6r; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738921149;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xGJfNVDGEZeCvHFsDxfQUXeGfHj0drDjlIthEqDcl+I=;
	b=kNoc2Jm9E1gADtuhLA8J3ck2ovBnXt8U3uV5u1VVu29K0gSSip+2wKbzlAgJEoer49xfXR
	viqtk6Smc28HqYTpj+mpho5a664Y9GnqA55B27SO8gSyhmXyGt/WGLgeKpQQdMg+k6VCUz
	0+9XBLksnIkWQYYlrRyoO6zIRegwN1aFy2LbTkuakJmpx3qH0B8eUtMc2C4YIsvDJTeNhK
	SXwa7bWpiPDUrNEToSahzeJnLXgYOakKMp09ZRy4jl6/V6G8anaqCijKT9leeYnuHzwl8B
	vfwlvFE+baKj4e9WoJNmE7SUUfYUGVBzSr0KZ1+sYWZxyd6fIT+TrbMf3aWu+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738921149;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xGJfNVDGEZeCvHFsDxfQUXeGfHj0drDjlIthEqDcl+I=;
	b=AkBuFU6ruUA5HN4AW0OW/YeuVRTW67HBKSoA7zN5ksdVMYzyzEOwijBHgJgVk4SAk5WdsZ
	ta++eFdfDdhWoADQ==
Date: Fri, 07 Feb 2025 10:39:05 +0100
Subject: [PATCH net v2 4/5] ptp: vmclock: Clean up miscdev and ptp clock
 through devres
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250207-vmclock-probe-v2-4-bc2fce0bdf07@linutronix.de>
References: <20250207-vmclock-probe-v2-0-bc2fce0bdf07@linutronix.de>
In-Reply-To: <20250207-vmclock-probe-v2-0-bc2fce0bdf07@linutronix.de>
To: David Woodhouse <dwmw2@infradead.org>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Mateusz Polchlopek <mateusz.polchlopek@intel.com>, 
 David Woodhouse <dwmw@amazon.co.uk>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738921146; l=2344;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=9BdvaiGN4CMxY+MnMBf0Cl2uZSErRtKmf5nqWW9+l0M=;
 b=0Hzf+ZarC+DPPnvuDCnyzYST6bYn3wVRliTirntTqz8xenrI2gJu+ypKLUItwUQM4oMdJpg1H
 HgYDZlA9jdHDj4I7YHpITEMkzhutNhk4u8M2V15elQQLfzXkvmf2a22
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Most resources owned by the vmclock device are managed through devres.
Only the miscdev and ptp clock are managed manually.
This makes the code slightly harder to understand than necessary.

Switch them over to devres and remove the now unnecessary drvdata.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Acked-by: Richard Cochran <richardcochran@gmail.com>
Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
---
 drivers/ptp/ptp_vmclock.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/ptp/ptp_vmclock.c b/drivers/ptp/ptp_vmclock.c
index 9b8bd626a397313433908fcc838edf8ffc3ecc98..09c023fb94b7e97137433bf18c3a065e26a36c6c 100644
--- a/drivers/ptp/ptp_vmclock.c
+++ b/drivers/ptp/ptp_vmclock.c
@@ -421,10 +421,9 @@ static const struct file_operations vmclock_miscdev_fops = {
 
 /* module operations */
 
-static void vmclock_remove(struct platform_device *pdev)
+static void vmclock_remove(void *data)
 {
-	struct device *dev = &pdev->dev;
-	struct vmclock_state *st = dev_get_drvdata(dev);
+	struct vmclock_state *st = data;
 
 	if (st->ptp_clock)
 		ptp_clock_unregister(st->ptp_clock);
@@ -525,8 +524,6 @@ static int vmclock_probe(struct platform_device *pdev)
 		goto out;
 	}
 
-	dev_set_drvdata(dev, st);
-
 	if (le32_to_cpu(st->clk->magic) != VMCLOCK_MAGIC ||
 	    le32_to_cpu(st->clk->size) > resource_size(&st->res) ||
 	    le16_to_cpu(st->clk->version) != 1) {
@@ -552,6 +549,10 @@ static int vmclock_probe(struct platform_device *pdev)
 
 	st->miscdev.minor = MISC_DYNAMIC_MINOR;
 
+	ret = devm_add_action_or_reset(&pdev->dev, vmclock_remove, st);
+	if (ret)
+		goto out;
+
 	/*
 	 * If the structure is big enough, it can be mapped to userspace.
 	 * Theoretically a guest OS even using larger pages could still
@@ -574,7 +575,6 @@ static int vmclock_probe(struct platform_device *pdev)
 		if (IS_ERR(st->ptp_clock)) {
 			ret = PTR_ERR(st->ptp_clock);
 			st->ptp_clock = NULL;
-			vmclock_remove(pdev);
 			goto out;
 		}
 	}
@@ -603,7 +603,6 @@ MODULE_DEVICE_TABLE(acpi, vmclock_acpi_ids);
 
 static struct platform_driver vmclock_platform_driver = {
 	.probe		= vmclock_probe,
-	.remove		= vmclock_remove,
 	.driver	= {
 		.name	= "vmclock",
 		.acpi_match_table = vmclock_acpi_ids,

-- 
2.48.1


