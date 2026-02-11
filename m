Return-Path: <netdev+bounces-258347-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oO6aMPTUjGm+tgAAu9opvQ
	(envelope-from <netdev+bounces-258347-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 20:13:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B943127171
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 20:13:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 79E5E30182B5
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 19:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D488352F92;
	Wed, 11 Feb 2026 19:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QGt3uRdS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D389334575A
	for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 19:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770837223; cv=none; b=mzhPxLhKqDr3JP+TIWIeNQW1qitthEu3oP70zQZQYxixQbx48e+im2PnZwJ2HxsVHA2JvucXybO3M74tK2BY70nVksyKZUdNRFTCkXEahC448exN+A9xSQcb7vtbpdegboTNcx+xeuEfOYrGi4g/OdawcfscKvf8TiGHzThaQkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770837223; c=relaxed/simple;
	bh=GYDyxIlHoWs9Je5hGJ6w/SSpXIt90vVnZ4o8f3x2WQQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nZTPhVknSE3KO/7ahxfUA908YbGvFadiz4CnXMfCbPxVhpK05dvA1WyVUjv9zOAWXx+HmJtpKLE/E5r064juSbjYkjcv6q8VjkKCBpR1hj8SJKoHnLA/k730TGY/vDClBzoseI/xDT0KTR1sfhLYPBQtQYO99XgxFytLgyfkxSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QGt3uRdS; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2a7a9b06eabso4259175ad.1
        for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 11:13:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770837220; x=1771442020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cR8ZQZG0WQpkht8tdaVvbicaEp+riLn3a/JDXFSqLZg=;
        b=QGt3uRdSbDCK3HfE8//003TccqNfZvUPI9w5gxFi4+DbPz+13Lfsx3ueVvD2HfFvCQ
         St0IeAj9eMSye9EdM+vww4bj+ZmTBDdGiNASgbpwelRlQQjGKezAivHrVOKeCCMI+6TW
         k3HiMSmZlJxhibtWu5zn3ENtRqi0Y2SZXHsRX+VRHhg6McKyl+1lYJ/wYDZ0etMFBy+8
         0crQiatr+fE/A1rcWMRu5DH4JFQnuqfFvu9hlQgWGDUe5Dj5pNDMkTe8Vtq9k7bxG6Ek
         bcRLsAjEA45DMK5BnR3wz2TO64WyC1coCTc8Zag6wV/V775KxkYzdpBEPZPFLzD4ausy
         1VFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770837220; x=1771442020;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cR8ZQZG0WQpkht8tdaVvbicaEp+riLn3a/JDXFSqLZg=;
        b=jER4ZTvhIhBuySwDAsk5ak1OdG0iJXS+ylc6LuYKDQ3I5RgDWEQcKUHmzdB9ESiYcO
         SBSR86BibRZ7wAj/fJ9YDTfHPIffa3u5L6OohZSoUFjbf1x2+1aHV0C884dD+bru5jz5
         IAGViMG/YNWWZWdrHrQAHMj05bJqOgT6/TUEuPFOQc6K13gOcqlR7nkwLwXaAw3XkYRA
         t8ngExnOJ7KsBon5g5b8VHwDK8v/ibg3uKIPav+ipQbDvlqtAwDzQpHQBeHqLQqK5/Y/
         NHEWdYmvQGo9AuFQOKINcwL6jVr0HGisEaCK48IE/FSkikeG1gYQpTQaq+2dL5/BC2TA
         NUAQ==
X-Gm-Message-State: AOJu0YzuINJ+3OwvkUz+oku5Ry+Qv1Fw3O8/9l7YK6+0nbNlVN1U8IsB
	v2ZpdZfuLL9e50trH760xA4BTGuR8ymhsGLsbayrQZv9CqzoasbSRYby
X-Gm-Gg: AZuq6aIXOEEnvcqB8qSVGu5yWwtju6yqSLkSeIFN6EpPwiVd72FJB4iZUvUo9Hi5gaW
	QHggQUAdxKk1QjYoscRWE7BhbcO+y2cyKxqRn+otASaM0gl/fEwz5N6FX2Y1mfjsFroVcbJK4/y
	vIdrWsl7UWVxs+Xu0bT4rIkRk5cdfUnRbf4bu3QAXmxulDpZbEstmIAiI3w3QBryWxBV/JHBY0f
	ZctK1b+mQBGYocCx0M+XYxLJEBTr/t7U+aBrZFPH/IKgUlVMq2zfCevGkmtsIIqjsbmr0uYSsix
	d0+zfRZ+fXYIxf8eB8c2ECDDsy+ma22kx9BMlitxmUhwvLUXs1FsDpGtEtgrYtjpXHubhkV1RxC
	U5IlaO3rXVqYMd/0GUdQK3K/OyvJKh2wpURtOjBNAdbpzMcaVpLkSRycnVpAf+m40YgFZj7Yz9a
	KnWFSD7eGmV1LbV/w/zEZfFqXK+HDG+LAWgtWgiusBB+TWQWbBXWcGWH4voUODFHfkS5hupro=
X-Received: by 2002:a17:903:2c0f:b0:2aa:d1ed:c475 with SMTP id d9443c01a7336-2ab39cfb586mr574285ad.9.1770837219992;
        Wed, 11 Feb 2026 11:13:39 -0800 (PST)
Received: from 3ce1e5d2d1b2.cse.ust.hk (191host009.mobilenet.cse.ust.hk. [143.89.191.9])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ab2984c0a7sm29444395ad.19.2026.02.11.11.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 11:13:39 -0800 (PST)
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
Subject: [PATCH v3] fbnic: close fw_log race between users and teardown
Date: Wed, 11 Feb 2026 19:13:29 +0000
Message-Id: <20260211191329.530886-1-dg573847474@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[meta.com,gmail.com,trager.us,davemloft.net,google.com,redhat.com,intel.com,kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-258347-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dg573847474@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5B943127171
X-Rspamd-Action: no action

Fixes a theoretical race on fw_log between the teardown path and fw_log
write functions.

fw_log is written inside fbnic_fw_log_write() and can be reached from
the mailbox handler fbnic_fw_msix_intr(), but fw_log is freed before
IRQ/MBX teardown during cleanup, resulting in a potential data race of
dereferencing a freed/null variable.

Possible Interleaving Scenario:
  CPU0: fbnic_fw_msix_intr() // Entry
          fbnic_fw_log_write()
            if (fbnic_fw_log_ready())   // true
            ... preempt ...
  CPU1: fbnic_remove() // Entry
          fbnic_fw_log_free()
            vfree(log->data_start);
            log->data_start = NULL;
  CPU0: continues, walks log->entries or writes to log->data_start

The initialization also has an incorrect order problem, as the fw_log
is currently allocated after MBX setup during initialization.
Fix the problems by adjusting the synchronization order to put
initialization in place before the mailbox is enabled, and not cleared
until after the mailbox has been disabled.

Fixes: ecc53b1b46c89 ("eth: fbnic: Enable firmware logging")
Signed-off-by: Chengfeng Ye <dg573847474@gmail.com>
___
Changes in v3:
  - Add fixes tag
  - Include entry functions in Interleaving Scenario

Changes in v2:
  - Adjust synchronization instead of using lock protection
  - Also fix problem in initialization
---
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


