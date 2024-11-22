Return-Path: <netdev+bounces-146872-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 914919D65E4
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 23:47:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F7A6B220D9
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 22:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22FBC1A4F22;
	Fri, 22 Nov 2024 22:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="hMuQo6Wy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807971C82E2
	for <netdev@vger.kernel.org>; Fri, 22 Nov 2024 22:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732315607; cv=none; b=vGu3qXYCA1ptUhjAEj5s6DhuY71FzsbukmCovKDp2cUtha3Y4t5y0u+Pdi0MJU22a9S+8cZx4eto7hUhn3PthOcdy4x/kdyCUGDgThVyJVtuLSiuIBujLlbqQ7CALsF12PTbuj6WqsAnhcyn2V1tF1yKabGIaDKQb8PeX4x2nOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732315607; c=relaxed/simple;
	bh=1q5zLrnZJW56EyQTUXvvpBXyQYjs2OSOzVe5FaV/f2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G83I3+CbXchEmp8Q9PNuLgSV3ISrR5fhwXC2o798ihRm+e2arYgaGxZUyEoA9LhpaqtMf9QEhs7P2zPRN6VORh/0A/XVLxWp/9ZeheBB5joUzrqu6T4a4QWNxa5JTzge6doWmspJW+W2FQKgv9RHPNuRNmfwBkgOjEQyx3PDl5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=hMuQo6Wy; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7b15eadee87so161194385a.2
        for <netdev@vger.kernel.org>; Fri, 22 Nov 2024 14:46:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1732315604; x=1732920404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qiui2rhF5hwfw95QrNuMUjSYZHJH7nfqV7xul9WK8TE=;
        b=hMuQo6Wyzlm5doscM4SUb/Xd8OTWDbZbZdHFxQ34cmBuaqBcAaw4yUiSWvwm7snIA6
         8DObx26WFn7hygO7hz3rQP5afexpAcsos6y7WVa9Bexq3VvoUG+WWJ9CbeEPp8o4/gtL
         3gcYJgl4Bq+q3uwFURfKobl8fhfd9+jz6HQxE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732315604; x=1732920404;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qiui2rhF5hwfw95QrNuMUjSYZHJH7nfqV7xul9WK8TE=;
        b=q23NdFP+oypvBkeYkM1we5T4lkGULwOm2zhT9Rs1cfoQmTZaANd/hAkI9zWtP16udy
         yMEYnCy8Rf+BBD8WO7+G0zot3An3CSamL805hqFfLrkLZgtrR4Yu40XTULbagmk8gEU7
         nxwHjBE3Y9FlI2NCManGjUDItLjVDk85Ceo3nz/WFVntcndu9j4SlCoxdnUj73JNw+JX
         /le89/Lsl8jem+eebsRL9js7uAsC4mwmubEnDK/E6OhrIBpOmxPjG76E36so//HisZ6y
         yHvtj4QDTla3H6JkxtmN/nhxdhOyWUSHM4VLTHEi7lNbk9iFuX1HCGFGe/awGMeep69G
         txjg==
X-Gm-Message-State: AOJu0YxngOWZl4s0nUWXHknAJtA4I/9wdRCA9rDppzThb0Vmb46XNcsk
	WDr0ns5a0uuwWGJIFEK8vAc0rVKYfLgtkCPl1NiELV3gJKMlV5yMxZ6B3RmF1g==
X-Gm-Gg: ASbGnctiJZ4DazujYMi8Gdnt8dFB+D39jWEaAhHvXsekMXoTZtyyvpGif+kgXp8zhI1
	SS7XFXIqW0ygg4uiPyYtHK7L/4TNvKDt2h1InidmdtMcNcUgoOvZ5KwemFVCo9Lcq7u9Px7O11Q
	bdT3yYA42lIb/W0PSDgBlsMEu8hs6SWG5dFcmzslKrC9nkl10ior33xqmRW3BoUwJJ4uU2PvFTd
	JxRl9F79oPufSdFfzgQxdzZ+1nxu3YILhkhtsUIeW6RLPLVQGCBbrniQTXcWpHGDq8m5xRTx+rf
	3KrHlL9m72y15y/d9xKOIE/FpQ==
X-Google-Smtp-Source: AGHT+IHhaGFFLD32oZ7w3xXSJEIU1ksA4ISgD6HIjDnEB6L2mqYvtJBQue7UdF6fGy/M+2G/rEd8Fg==
X-Received: by 2002:a05:620a:2416:b0:7b1:11ac:627a with SMTP id af79cd13be357-7b514513d9dmr728992885a.25.1732315604211;
        Fri, 22 Nov 2024 14:46:44 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b51415286esm131270485a.101.2024.11.22.14.46.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 14:46:43 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	Richard Cochran <richardcochran@gmail.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH net 6/6] bnxt_en: Unregister PTP during PCI shutdown and suspend
Date: Fri, 22 Nov 2024 14:45:46 -0800
Message-ID: <20241122224547.984808-7-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
In-Reply-To: <20241122224547.984808-1-michael.chan@broadcom.com>
References: <20241122224547.984808-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If we go through the PCI shutdown or suspend path, we shutdown the
NIC but PTP remains registered.  If the kernel continues to run for
a little bit, the periodic PTP .do_aux_work() function may be called
and it will read the PHC from the BAR register.  Since the device
has already been disabled, it will cause a PCIe completion timeout.
Fix it by calling bnxt_ptp_clear() in the PCI shutdown/suspend
handlers.  bnxt_ptp_clear() will unregister from PTP and
.do_aux_work() will be canceled.

In bnxt_resume(), we need to re-initialize PTP.

Fixes: a521c8a01d26 ("bnxt_en: Move bnxt_ptp_init() from bnxt_open() back to bnxt_init_one()")
Cc: Richard Cochran <richardcochran@gmail.com>
Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 9c4b8ea22bf9..57e69c0552ab 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -16245,6 +16245,7 @@ static void bnxt_shutdown(struct pci_dev *pdev)
 	if (netif_running(dev))
 		dev_close(dev);
 
+	bnxt_ptp_clear(bp);
 	bnxt_clear_int_mode(bp);
 	pci_disable_device(pdev);
 
@@ -16272,6 +16273,7 @@ static int bnxt_suspend(struct device *device)
 		rc = bnxt_close(dev);
 	}
 	bnxt_hwrm_func_drv_unrgtr(bp);
+	bnxt_ptp_clear(bp);
 	pci_disable_device(bp->pdev);
 	bnxt_free_ctx_mem(bp, false);
 	rtnl_unlock();
@@ -16315,6 +16317,10 @@ static int bnxt_resume(struct device *device)
 	if (bp->fw_crash_mem)
 		bnxt_hwrm_crash_dump_mem_cfg(bp);
 
+	if (bnxt_ptp_init(bp)) {
+		kfree(bp->ptp_cfg);
+		bp->ptp_cfg = NULL;
+	}
 	bnxt_get_wol_settings(bp);
 	if (netif_running(dev)) {
 		rc = bnxt_open(dev);
-- 
2.30.1


