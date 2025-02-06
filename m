Return-Path: <netdev+bounces-163618-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACF02A2AF47
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 18:47:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA068167DA8
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 17:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E316919CC1F;
	Thu,  6 Feb 2025 17:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1EOONuJV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Pvwf6yhh"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5863C1925B8;
	Thu,  6 Feb 2025 17:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738863972; cv=none; b=gg+3EfaYPdsndO+ISrXPHYszUByvCL52tLlpAAt7CwEUaPLeRB5ufp32MeE8oKEX2PurfLmeVzsxUjSsPtYmQeDAZnhulqr2dKIdCTCu/KgsxdAZPYfzpp1mc1fOPA4+XT/tuPxs55KlqmfmySC0WsnSxcVPGO2zKn2ghj2ytJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738863972; c=relaxed/simple;
	bh=gTovkeAuc1k45/RNg29XG45qZ+duoj9ctG+BqWvkfwc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YqVAwjySwKH74FAjAuALLcTCigk0bQwPDwoCr3xvmcPPJxrvVnbP4tgqsMqWYdKP4CteMmdgABCzQl2OSs2UmXqUjvQnJmK54OyAxMnQbRKbr6NraGdoNxWmEtMHMskU0fUaF7dsONTUcljsYRqG5m60as1odTlxhAMlNk3Bdt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1EOONuJV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Pvwf6yhh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738863968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yJACVaUgR6f3bBOq37IygZM3AouaTCTmenYGHYfPeqc=;
	b=1EOONuJVDPGCFyBYF2NZeH9JaYOE7y7LyiIvz6xYYYs61mbwB+y0nMljnVlc7XESjX08YA
	HUjCOBHLkkcdQNPRhFM04van1tQFzoxDmPUUvncFdH2EhMjp1R6wkkNxQSKEfT+dmqgj8p
	/KpkV+um9gqXQV2NPbNLM5iGzcEpeehH+s3VBrvcgSGh9I7qFr59iGMlSP0IjiupSDtHiz
	b2i36GhNVz4t6biD8L9F/MqUH/cRdNprH5+diRhAPqY05eHrG+yfNi0dti3dy1G/vafDQa
	G+CAbUU3COiGWv7IskYOUo9d2EYOKCZmZWPJx45jOgOhIug6eDNEmk/+vbvPdA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738863968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yJACVaUgR6f3bBOq37IygZM3AouaTCTmenYGHYfPeqc=;
	b=Pvwf6yhhQnraLNiaPBbtfufGUknGLJXLMoqn6jmoVoBh76zpUs6XO3aiWSbMUymG9E1KJL
	Orvae3YOpLQZ+QAg==
Date: Thu, 06 Feb 2025 18:45:04 +0100
Subject: [PATCH net-next 4/4] ptp: vmclock: Remove goto-based cleanup logic
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250206-vmclock-probe-v1-4-17a3ea07be34@linutronix.de>
References: <20250206-vmclock-probe-v1-0-17a3ea07be34@linutronix.de>
In-Reply-To: <20250206-vmclock-probe-v1-0-17a3ea07be34@linutronix.de>
To: David Woodhouse <dwmw2@infradead.org>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: David Woodhouse <dwmw@amazon.co.uk>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738863961; l=3397;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=gTovkeAuc1k45/RNg29XG45qZ+duoj9ctG+BqWvkfwc=;
 b=NJNbIqLK38DrSxmfOjF4hQ86H2W9H1exnGRxc8J42x7mQUxfZ75hkqgOZAIHVtiK0qdAbw44m
 xD9YlZVTee4AXsyKycYQP4mz3brzoLiRh8gssFwv9OLaomj13uY4q2W
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

vmclock_probe() uses an "out:" label to return from the function on
error. This indicates that some cleanup operation is necessary.
However the label does not do anything as all resources are managed
through devres, making the code slightly harder to read.

Remove the label and just return directly.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 drivers/ptp/ptp_vmclock.c | 32 +++++++++++++-------------------
 1 file changed, 13 insertions(+), 19 deletions(-)

diff --git a/drivers/ptp/ptp_vmclock.c b/drivers/ptp/ptp_vmclock.c
index b7fa196975229cec6d27b34f7bb235c53b5b5732..26fcc1185ee72999a43842a59164498657799b1f 100644
--- a/drivers/ptp/ptp_vmclock.c
+++ b/drivers/ptp/ptp_vmclock.c
@@ -505,14 +505,13 @@ static int vmclock_probe(struct platform_device *pdev)
 
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
@@ -520,37 +519,34 @@ static int vmclock_probe(struct platform_device *pdev)
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
@@ -564,7 +560,7 @@ static int vmclock_probe(struct platform_device *pdev)
 
 		ret = misc_register(&st->miscdev);
 		if (ret)
-			goto out;
+			return ret;
 	}
 
 	/* If there is valid clock information, register a PTP clock */
@@ -574,15 +570,14 @@ static int vmclock_probe(struct platform_device *pdev)
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
@@ -590,8 +585,7 @@ static int vmclock_probe(struct platform_device *pdev)
 		 (st->miscdev.minor && st->ptp_clock) ? ", " : "",
 		 st->ptp_clock ? "PTP" : "");
 
- out:
-	return ret;
+	return 0;
 }
 
 static const struct acpi_device_id vmclock_acpi_ids[] = {

-- 
2.48.1


