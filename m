Return-Path: <netdev+bounces-258295-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oEeFCwGajGkhrgAAu9opvQ
	(envelope-from <netdev+bounces-258295-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 16:02:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8146E12565A
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 16:02:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E6CCD301E9A8
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 15:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E57727B359;
	Wed, 11 Feb 2026 15:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m03h/aqM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044B421B191
	for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 15:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770822048; cv=none; b=HT8yIKCVRkRdqx6LNEZunOmbsoJlTpNpJarKgLcbblYg1ZTPYy9o5tWQ7Z1dFp2puBYUj6/Iqfkm8nq30600YglgAa6HFz5PFwUUojGhltH7FPq1wWTzZdAt9p8xunLzhgcO2/H8ATxUoX0XF/dm0szHy/e1x7vOhxpoLPZTQME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770822048; c=relaxed/simple;
	bh=wYUR00Nza6J+sUIZluFr59NOD6UNQPdTYKj9nWWZfFI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=P89V7ZUFfMiCDffUMoodpMslAI2xNDHv6/C9ak90tq7kASNFacbl5vNiapNhcBNeVrYvXmqvmYbLRY+lJvaT3GVXf8jBjMU5NLM2EsLsWAyQXQhaA3iy8m0nFfpQq8ll6QH4uZgz/gwHbZbXHZC5+qNjK1jf9CNKOw4KNXPrjrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m03h/aqM; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-824a16c1d2aso35429b3a.2
        for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 07:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770822046; x=1771426846; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6UvkuPKINAtCyF/ggWjkLz6su0VX75e5/NucynTwhnE=;
        b=m03h/aqMa0B8PjCQPNGErXqNTxqvAtFxoJIsOyICivLfobpQIEvraUhEdcdamt1a4L
         WFFl1E4rBESgVoZtHgRbp5H8MortIrbU7MTChcIQuIFEyaaZTry3SUqdC8nyK1BNdsD4
         XO9QpPzkktUHob6IoQ4Rc/LEHS5HuKE05XxT5tF6ivSMl/F7hZrkhnactYZ9PdQeKYgv
         G5pnTWeZWYumPeAgjdGzBUHt9SUtECy+hrf7PiqNL0ZRVLL3zYv/aq8kkyFh0UAUFnrx
         1PaHgCNbBnNMfjdE/XL/h3K8PgepUFh8aGRTZfjmna9w8rG0HX4ldDOI9xSu9hVQf+DA
         UcKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770822046; x=1771426846;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6UvkuPKINAtCyF/ggWjkLz6su0VX75e5/NucynTwhnE=;
        b=gT/9mgFPD6ZGMuf8LlfC0ol7l5+bJ7AdMschoPjFJ0jt8JvB89w+17CSAgmtF0nmci
         WksoxSnwJvjSr9v5ko79WDNr8Dhatb2Qi7+bGEE65n7ZubQtq8CaTYb9cxEuaqRxrCTH
         fO/w16w+STakeqn4nVwMpJaYJ0lro5XLJZnhMXTbGZCIgAMKMxyfe585E7OVgylRrhhl
         OW2pZ1qdo3/5MwCJLYNTZ2Qy87EvUJwLGVa6m+UDjsAN/MxlH7Mm0i+vE6fo2CnSTSkv
         tRCEjSlgEU5uX8YdK5gThD7btR3TnvVjommI28rN/efbigyggakqyIunsjuW0ctOcTE+
         dKvA==
X-Gm-Message-State: AOJu0YxGGYotN597AmVDqzTxPl2thXzznxPcXkqDG87Tiy4YOdJam50M
	BZ88Qn+mh+E/+dpISadXIXQoK/nbrzTD+XF8zN04guhii6lUTiAD0Duj9iclig==
X-Gm-Gg: AZuq6aKJ3w4VdStEryEpMIYiUb1PBmxO/i15fWzl+QYH6GrqnKv8gGc+dy50ujShmb9
	IOLTOWv35aaMTUA/Wvce1EcXCGwkJNrOfZjoqqHHAyWSYQSa380iyPMeai/ryHuOEZ5EYhyT6/B
	2rPzKcR3196pU1EYsKPSZ5BXeelpg22TMJyZhXMOj4kZjZUf01oKncNu3rsLaByf/Go+ga6XsK8
	RpRA5kZA7eVfjW9Ed6PN7PTaw5XQfhZgeutoQvdScIbeTrdnnbX36BuPb/iNOyXp3VJNIzoiO+N
	q9HLhicEgExNyVe56XL2K5418DoZJydCvCmGB77xnxz1L2L39KEsBLHAM6vLma5/2yWjHwL+LzE
	FO1qTx8byx60ZpchLCIsycMFzjSqXh9F4CgxAoNY5X47ZMX7sBn4mTyjY5TgX8jj7LbyyXjCg/V
	oiBc14RPrxaM1sjyba6jtFDnZ5EKEXj9uvLcyjkbqFtI1krcMA0+kVkfbK/tv/BIxIQihF9Y0=
X-Received: by 2002:a05:6a20:4310:b0:389:7889:7b7a with SMTP id adf61e73a8af0-394326087e2mr1751764637.8.1770822045604;
        Wed, 11 Feb 2026 07:00:45 -0800 (PST)
Received: from 3ce1e5d2d1b2.cse.ust.hk (191host009.mobilenet.cse.ust.hk. [143.89.191.9])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8249e3bd627sm3164445b3a.25.2026.02.11.07.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 07:00:45 -0800 (PST)
From: Chengfeng Ye <dg573847474@gmail.com>
To: kernel-team@meta.com,
	alexander.duyck@gmail.com,
	lee@trager.us,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	jacob.e.keller@intel.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chengfeng Ye <dg573847474@gmail.com>
Subject: [PATCH v2] fbnic: close fw_log race between users and teardown
Date: Wed, 11 Feb 2026 15:00:22 +0000
Message-Id: <20260211150022.527956-1-dg573847474@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[meta.com,gmail.com,trager.us,davemloft.net,google.com,redhat.com,intel.com,kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-258295-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dg573847474@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8146E12565A
X-Rspamd-Action: no action

Fixes a theoretical race on fw_log between the teardown path and fw_log
write functions.

fw_log is written inside fbnic_fw_log_write() and can be reached from
the mailbox handler fbnic_fw_msix_intr(), but fw_log is freed before
IRQ/MBX teardown during cleanup, resulting in a potential data race of
dereferencing a freed/null variable.

Possible Interleaving scenario:
  CPU0: fbnic_fw_log_write()
          if (fbnic_fw_log_ready())   // true
          ... preempt ...
  CPU1: fbnic_fw_log_free()
          vfree(log->data_start);
          log->data_start = NULL;
  CPU0: continues, walks log->entries or writes to log->data_start

The initialization also has an incorrect order problem, as the fw_log
is currently allocated after MBX setup during initialization.
Fix the problems by adjusting the synchronization order to put
initialization in place before the mailbox is enabled, and not cleared
until after the mailbox has been disabled.

Signed-off-by: Chengfeng Ye <dg573847474@gmail.com>
---
Changes in v2:
  - Adjust synchronization instead of using lock protection
  - Also fix problem in initialization
--
 .../net/ethernet/meta/fbnic/fbnic_fw_log.c    |  3 ---
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c   | 19 ++++++++++++-------
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw_log.c b/drivers/net/ethernet/meta/fbnic/fbnic_fw_log.c
index 85a883dba385..d8a9a7d7c237 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_fw_log.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw_log.c
@@ -51,8 +51,6 @@ int fbnic_fw_log_init(struct fbnic_dev *fbd)
 	log->data_start = data;
 	log->data_end = data + FBNIC_FW_LOG_SIZE;
 
-	fbnic_fw_log_enable(fbd, true);
-
 	return 0;
 }
 
@@ -63,7 +61,6 @@ void fbnic_fw_log_free(struct fbnic_dev *fbd)
 	if (!fbnic_fw_log_ready(fbd))
 		return;
 
-	fbnic_fw_log_disable(fbd);
 	INIT_LIST_HEAD(&log->entries);
 	log->size = 0;
 	vfree(log->data_start);
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
index 9240673c7533..e92187bc1c0f 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
@@ -307,11 +307,17 @@ static int fbnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto free_irqs;
 	}
 
+	err = fbnic_fw_log_init(fbd);
+	if (err)
+		dev_warn(fbd->dev,
+			 "Unable to initialize firmware log buffer: %d\n",
+			 err);
+
 	err = fbnic_fw_request_mbx(fbd);
 	if (err) {
 		dev_err(&pdev->dev,
 			"Firmware mailbox initialization failure\n");
-		goto free_irqs;
+		goto free_fw_log;
 	}
 
 	/* Send the request to enable the FW logging to host. Note if this
@@ -319,11 +325,7 @@ static int fbnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	 * possible the FW is just too old to support the logging and needs
 	 * to be updated.
 	 */
-	err = fbnic_fw_log_init(fbd);
-	if (err)
-		dev_warn(fbd->dev,
-			 "Unable to initialize firmware log buffer: %d\n",
-			 err);
+	fbnic_fw_log_enable(fbd, true);
 
 	fbnic_devlink_register(fbd);
 	fbnic_devlink_otp_check(fbd, "error detected during probe");
@@ -370,6 +372,8 @@ static int fbnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	  * firmware updates for fixes.
 	  */
 	return 0;
+free_fw_log:
+	fbnic_fw_log_free(fbd);
 free_irqs:
 	fbnic_free_irqs(fbd);
 err_destroy_health:
@@ -404,8 +408,9 @@ static void fbnic_remove(struct pci_dev *pdev)
 	fbnic_hwmon_unregister(fbd);
 	fbnic_dbg_fbd_exit(fbd);
 	fbnic_devlink_unregister(fbd);
-	fbnic_fw_log_free(fbd);
+	fbnic_fw_log_disable(fbd);
 	fbnic_fw_free_mbx(fbd);
+	fbnic_fw_log_free(fbd);
 	fbnic_free_irqs(fbd);
 
 	fbnic_devlink_health_destroy(fbd);
-- 
2.25.1


