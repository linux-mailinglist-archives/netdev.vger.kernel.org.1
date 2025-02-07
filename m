Return-Path: <netdev+bounces-163899-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B60FA2BFA1
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 10:40:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E978C3A4C43
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 09:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC6FE23771A;
	Fri,  7 Feb 2025 09:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fx4WmK07";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="a3Yl0EH7"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D990A235BE6;
	Fri,  7 Feb 2025 09:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738921154; cv=none; b=azPwYr7+slFVFhaE6GetLTql6X6K+V6kO1XiIFDsYmROaGY6mHYnD//lA85TCO4vkCu194J10wkMp32YcU+3QWENc8+ADqNA5ZaGJTQzaXfMHckF2IlBKxK9Gz+VJESAeV/3f/Im+Xtct/yHKbgeAlSlXIRN2RK9afDRS0Fh3OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738921154; c=relaxed/simple;
	bh=PJ6dyjO0wMBUzryRHvH4B41hJgFPEjxdpjXQ/XTqvWU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fd7lrtbopy5qkNBRo5pckE5+PYa5Y8DmH1/5cnqZM9vlKHVCGlWJe3X0GNqA6zbrGnGqTNRA0G23smOoFCaIAxKLs/cRdPvTaF1J/ZisHWXSWtXnDgyuJXIKm+iRfwowDFSflEAloqfidwDgli5TfN4aCE6U9tZJPP697zZ0Qho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fx4WmK07; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=a3Yl0EH7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738921150;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hhjHAzmbkaYnqcm3IHFcgDwG15AFP/Njjh4ZX0H9Olg=;
	b=fx4WmK074PHazK/ChkQrvakNhx//tQce39oX2maPhu55UejGiuWX1nm6XqjxEb399pDo0a
	TBAmqJjIA9gQ2xu1djoO7RlbYwJrh6O27lmZd6F0cKepCc0WFFYR74569Cb2dVerA673xD
	n29SZE6SWNDsaT+68+s6ZmljxyaL8WAfo+fKaQZ7rkUZIkwf1ibjmku23OeAiK/SEYoaSh
	12aA5d2iIwDxT4vgDYbzz7rP+DAP8ECDy63pXK2G8kDfJIktUse36edyRKTf72VZbLhVYe
	vqNL/gDGS56oBAGtADrH2oxkF2dvFLAKBGhYwSv6ZoizfKIVvMunU0ct9TZgHQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738921150;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hhjHAzmbkaYnqcm3IHFcgDwG15AFP/Njjh4ZX0H9Olg=;
	b=a3Yl0EH7a5YtE5adkLh/9jkArp+3DOYNpwtKcQe6zk5Vml0Q8MLB/GkEY8qNa878zKkZeZ
	6YqitbjFwKcGfGAw==
Date: Fri, 07 Feb 2025 10:39:06 +0100
Subject: [PATCH net v2 5/5] ptp: vmclock: Remove goto-based cleanup logic
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250207-vmclock-probe-v2-5-bc2fce0bdf07@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738921146; l=3501;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=PJ6dyjO0wMBUzryRHvH4B41hJgFPEjxdpjXQ/XTqvWU=;
 b=4xFo8mAbUISvcDSNEowlGCBY90Hka4uuu5U+RKQz9mrzm14PjAuKipplOwuXOvw5YSvTpARM1
 06uxENtxhvSDQzPzvMvvS07b0ufzJZxa8DSuzU40ym3K0kYPCB95/AW
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

vmclock_probe() uses an "out:" label to return from the function on
error. This indicates that some cleanup operation is necessary.
However the label does not do anything as all resources are managed
through devres, making the code slightly harder to read.

Remove the label and just return directly.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Acked-by: Richard Cochran <richardcochran@gmail.com>
Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
---
 drivers/ptp/ptp_vmclock.c | 32 +++++++++++++-------------------
 1 file changed, 13 insertions(+), 19 deletions(-)

diff --git a/drivers/ptp/ptp_vmclock.c b/drivers/ptp/ptp_vmclock.c
index 09c023fb94b7e97137433bf18c3a065e26a36c6c..b3a83b03d9c14e10213c6cb94e6a42b38c59546f 100644
--- a/drivers/ptp/ptp_vmclock.c
+++ b/drivers/ptp/ptp_vmclock.c
@@ -506,14 +506,13 @@ static int vmclock_probe(struct platform_device *pdev)
 
 	if (ret) {
 		dev_info(dev, "Failed to obtain physical address: %d\n", ret);
-		goto out;
+		return ret;
 	}
 
 	if (resource_size(&st->res) < VMCLOCK_MIN_SIZE) {
 		dev_info(dev, "Region too small (0x%llx)\n",
 			 resource_size(&st->res));
-		ret = -EINVAL;
-		goto out;
+		return -EINVAL;
 	}
 	st->clk = devm_memremap(dev, st->res.start, resource_size(&st->res),
 				MEMREMAP_WB | MEMREMAP_DEC);
@@ -521,37 +520,34 @@ static int vmclock_probe(struct platform_device *pdev)
 		ret = PTR_ERR(st->clk);
 		dev_info(dev, "failed to map shared memory\n");
 		st->clk = NULL;
-		goto out;
+		return ret;
 	}
 
 	if (le32_to_cpu(st->clk->magic) != VMCLOCK_MAGIC ||
 	    le32_to_cpu(st->clk->size) > resource_size(&st->res) ||
 	    le16_to_cpu(st->clk->version) != 1) {
 		dev_info(dev, "vmclock magic fields invalid\n");
-		ret = -EINVAL;
-		goto out;
+		return -EINVAL;
 	}
 
 	ret = ida_alloc(&vmclock_ida, GFP_KERNEL);
 	if (ret < 0)
-		goto out;
+		return ret;
 
 	st->index = ret;
 	ret = devm_add_action_or_reset(&pdev->dev, vmclock_put_idx, st);
 	if (ret)
-		goto out;
+		return ret;
 
 	st->name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "vmclock%d", st->index);
-	if (!st->name) {
-		ret = -ENOMEM;
-		goto out;
-	}
+	if (!st->name)
+		return -ENOMEM;
 
 	st->miscdev.minor = MISC_DYNAMIC_MINOR;
 
 	ret = devm_add_action_or_reset(&pdev->dev, vmclock_remove, st);
 	if (ret)
-		goto out;
+		return ret;
 
 	/*
 	 * If the structure is big enough, it can be mapped to userspace.
@@ -565,7 +561,7 @@ static int vmclock_probe(struct platform_device *pdev)
 
 		ret = misc_register(&st->miscdev);
 		if (ret)
-			goto out;
+			return ret;
 	}
 
 	/* If there is valid clock information, register a PTP clock */
@@ -575,15 +571,14 @@ static int vmclock_probe(struct platform_device *pdev)
 		if (IS_ERR(st->ptp_clock)) {
 			ret = PTR_ERR(st->ptp_clock);
 			st->ptp_clock = NULL;
-			goto out;
+			return ret;
 		}
 	}
 
 	if (!st->miscdev.minor && !st->ptp_clock) {
 		/* Neither miscdev nor PTP registered */
 		dev_info(dev, "vmclock: Neither miscdev nor PTP available; not registering\n");
-		ret = -ENODEV;
-		goto out;
+		return -ENODEV;
 	}
 
 	dev_info(dev, "%s: registered %s%s%s\n", st->name,
@@ -591,8 +586,7 @@ static int vmclock_probe(struct platform_device *pdev)
 		 (st->miscdev.minor && st->ptp_clock) ? ", " : "",
 		 st->ptp_clock ? "PTP" : "");
 
- out:
-	return ret;
+	return 0;
 }
 
 static const struct acpi_device_id vmclock_acpi_ids[] = {

-- 
2.48.1


