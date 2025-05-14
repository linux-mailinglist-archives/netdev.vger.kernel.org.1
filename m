Return-Path: <netdev+bounces-190317-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2CC1AB631D
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 08:29:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 526043AC384
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 06:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D991FDA89;
	Wed, 14 May 2025 06:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="O2mHaFxu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7F117BD9
	for <netdev@vger.kernel.org>; Wed, 14 May 2025 06:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747204187; cv=none; b=FkpOjeFWhU/FvAiuK5PUQkk1faywxI6LOy4Dm4msjFfIVQ04Nt+PywpMGR2z5ircKkLj8jfmjOiqPFnZzw3GtNIvUOF5NWyK3tOBIfnaNasWQB3LE5u1e6kawZ6IXkWgGfBTe4MM5NfIBE7mL63VrXC+lZcUNpKBT5NhrYXZ4UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747204187; c=relaxed/simple;
	bh=ZlbACqOGDQmR94yWclvEkyDAGlu8b+8r7EbSsxkGoUk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nkq37Lo+mhRAHH+xReQJXkHmjMOWqm++Yj1RH09Fd1mMWNOZgnJZxHsreDztPLoUsBo66uTFe7QmX1J6ilPWDxwIEs9dwntiVrkKS4Vvz7Vp0aQSwQ3x0YeFmvWZUcqHv+WkhD6S4ZEK9vr5lC3r73D0cT89Z+C4ZgabIAysWEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=O2mHaFxu; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-22e730c05ddso59502125ad.2
        for <netdev@vger.kernel.org>; Tue, 13 May 2025 23:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1747204183; x=1747808983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L/g6FeELrTlPYAQJgJb1KMMX3FFmWj5K1DgWpOIL6WU=;
        b=O2mHaFxusT/+CcaaSPPiErrI0LnvW+UeMZp8X8d9SDwQqwna/Pw7PWoNtnz9XsRS7F
         YorASNTFU2ftsUrnl7wU38i5i/w5rLZdbKyAgPk9exI2MzoiwNTmJO9TRfcsI7VTN1nC
         i0yOfwphoLNeVtXv2xrsR89V85NG1nKOi6FXw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747204183; x=1747808983;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L/g6FeELrTlPYAQJgJb1KMMX3FFmWj5K1DgWpOIL6WU=;
        b=N7UEdpJP1MI5B3+l/LqAjOuTX6lSdkQvMSRhzT+o7xHd/jzApti05YiEFjrSnaP+oy
         Zr7pMPtHCmS7Udvf3aQrlcWtJXPsA4fxctIKEn+yCNYNkqTWOLCiphyRl9Y9wcqh7dIM
         9u2Z0gVcRQtA0SE9I++QYWnbk9Fr+HOplz6W87bL6HjJ3ZsIcvrHA71SURr+skQAsQTx
         TznitMpwmvlRWWF8bzIjr4KzOWUQx+MS/ma2hdmuUSdjbhglrdE2U0gMjSmNDaks7ulR
         9fcRCXV3V9H22eWuNdW+Yd3gRKqn/ZP/QuB5snm1ZiQbQ95q+p4XBbdYIGlJokb/mrXg
         LRtA==
X-Gm-Message-State: AOJu0YzSCDoS/syN/di+XrIkFg3K8hNqOrkPyed+If0+kQ4cVAs4o6oH
	w7iMDoCQOGR4M5CUuOzZrBKdKyC34cftzC228qhn8Ry3ydZ5Sz7IlISFzOOzUPT455cAjghtUXc
	=
X-Gm-Gg: ASbGnctE7AMdB2xhd6O4+K2wxJE/Gh7Xa/Y7EujWjtX7uKQATYDt9YZNngsY2TdUhYF
	bMI2YozK5m7jcQ1VIbc0joyzEIoai57qLte+u2/Ew0T37aBbKxxf/wp8f6MU9f20G16k5MAl6WH
	qQXt7YsNHYxwAavhHBX2UXdLZjqT9WYCi4ibeFuSVbZSqu9T1cUgpVJG9wmhI5/zMhN07M0QJWH
	Ckg2QfCrPNMrJ3yyy38FGsGeYWrIvSMmOQLhpp9uqRhhfOaiZDE9pPaAr0MQCpNlcYTravTIZEO
	2MgQ9bAwxb7UVoc8omMOaJWuOp/pIPVSEe6xOgw1YZaaS28gU6EMTVxN2acKUoLTGclpU2Y043a
	tFg8r/RxiICbuUsP+hTQ9N+C/w6s=
X-Google-Smtp-Source: AGHT+IHZzhx1IVQhStpUGHZ7Y+3yhXvuiCCYw8fCJqDiOIc8QOGvRwLWog5DmzxNVF2FkOa7PAru6A==
X-Received: by 2002:a17:902:ea06:b0:223:2aab:462c with SMTP id d9443c01a7336-231981353b1mr29350965ad.15.1747204183522;
        Tue, 13 May 2025 23:29:43 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc754685bsm91321395ad.50.2025.05.13.23.29.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 23:29:43 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	sdf@fomichev.me,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH net v2] bnxt_en: bring back rtnl_lock() in the bnxt_open() path
Date: Tue, 13 May 2025 23:29:08 -0700
Message-ID: <20250514062908.2766677-1-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Error recovery, PCIe AER, resume, and TX timeout will invoke bnxt_open()
with netdev_lock only.  This will cause RTNL assert failure in
netif_set_real_num_tx_queues(), netif_set_real_num_tx_queues(),
and netif_set_real_num_tx_queues().

Example error recovery assert:

RTNL: assertion failed at net/core/dev.c (3178)
WARNING: CPU: 3 PID: 3392 at net/core/dev.c:3178 netif_set_real_num_tx_queues+0x1fd/0x210

Call Trace:
 <TASK>
 ? __pfx_bnxt_msix+0x10/0x10 [bnxt_en]
 __bnxt_open_nic+0x1ef/0xb20 [bnxt_en]
 bnxt_open+0xda/0x130 [bnxt_en]
 bnxt_fw_reset_task+0x21f/0x780 [bnxt_en]
 process_scheduled_works+0x9d/0x400

For now, bring back rtnl_lock() in all these code paths that can invoke
bnxt_open().  In the bnxt_queue_start() error path, we don't have
rtnl_lock held so we just change it to call netif_close() instead of
bnxt_reset_task() for simplicity.  This error path is unlikely so it
should be fine.

Fixes: 004b5008016a ("eth: bnxt: remove most dependencies on RTNL")
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
v2: Expand the fix to include resume, AER, TX timeout reset.

v1: https://lore.kernel.org/netdev/20250512063755.2649126-1-michael.chan@broadcom.com/
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 36 ++++++++++++++++++-----
 1 file changed, 29 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 86a5de44b6f3..6afc2ab6fad2 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -14013,13 +14013,28 @@ static void bnxt_unlock_sp(struct bnxt *bp)
 	netdev_unlock(bp->dev);
 }
 
+/* Same as bnxt_lock_sp() with additional rtnl_lock */
+static void bnxt_rtnl_lock_sp(struct bnxt *bp)
+{
+	clear_bit(BNXT_STATE_IN_SP_TASK, &bp->state);
+	rtnl_lock();
+	netdev_lock(bp->dev);
+}
+
+static void bnxt_rtnl_unlock_sp(struct bnxt *bp)
+{
+	set_bit(BNXT_STATE_IN_SP_TASK, &bp->state);
+	netdev_unlock(bp->dev);
+	rtnl_unlock();
+}
+
 /* Only called from bnxt_sp_task() */
 static void bnxt_reset(struct bnxt *bp, bool silent)
 {
-	bnxt_lock_sp(bp);
+	bnxt_rtnl_lock_sp(bp);
 	if (test_bit(BNXT_STATE_OPEN, &bp->state))
 		bnxt_reset_task(bp, silent);
-	bnxt_unlock_sp(bp);
+	bnxt_rtnl_unlock_sp(bp);
 }
 
 /* Only called from bnxt_sp_task() */
@@ -14027,9 +14042,9 @@ static void bnxt_rx_ring_reset(struct bnxt *bp)
 {
 	int i;
 
-	bnxt_lock_sp(bp);
+	bnxt_rtnl_lock_sp(bp);
 	if (!test_bit(BNXT_STATE_OPEN, &bp->state)) {
-		bnxt_unlock_sp(bp);
+		bnxt_rtnl_unlock_sp(bp);
 		return;
 	}
 	/* Disable and flush TPA before resetting the RX ring */
@@ -14068,7 +14083,7 @@ static void bnxt_rx_ring_reset(struct bnxt *bp)
 	}
 	if (bp->flags & BNXT_FLAG_TPA)
 		bnxt_set_tpa(bp, true);
-	bnxt_unlock_sp(bp);
+	bnxt_rtnl_unlock_sp(bp);
 }
 
 static void bnxt_fw_fatal_close(struct bnxt *bp)
@@ -14960,15 +14975,17 @@ static void bnxt_fw_reset_task(struct work_struct *work)
 		bp->fw_reset_state = BNXT_FW_RESET_STATE_OPENING;
 		fallthrough;
 	case BNXT_FW_RESET_STATE_OPENING:
-		while (!netdev_trylock(bp->dev)) {
+		while (!rtnl_trylock()) {
 			bnxt_queue_fw_reset_work(bp, HZ / 10);
 			return;
 		}
+		netdev_lock(bp->dev);
 		rc = bnxt_open(bp->dev);
 		if (rc) {
 			netdev_err(bp->dev, "bnxt_open() failed during FW reset\n");
 			bnxt_fw_reset_abort(bp, rc);
 			netdev_unlock(bp->dev);
+			rtnl_unlock();
 			goto ulp_start;
 		}
 
@@ -14988,6 +15005,7 @@ static void bnxt_fw_reset_task(struct work_struct *work)
 			bnxt_dl_health_fw_status_update(bp, true);
 		}
 		netdev_unlock(bp->dev);
+		rtnl_unlock();
 		bnxt_ulp_start(bp, 0);
 		bnxt_reenable_sriov(bp);
 		netdev_lock(bp->dev);
@@ -15936,7 +15954,7 @@ static int bnxt_queue_start(struct net_device *dev, void *qmem, int idx)
 		   rc);
 	napi_enable_locked(&bnapi->napi);
 	bnxt_db_nq_arm(bp, &cpr->cp_db, cpr->cp_raw_cons);
-	bnxt_reset_task(bp, true);
+	netif_close(dev);
 	return rc;
 }
 
@@ -16752,6 +16770,7 @@ static int bnxt_resume(struct device *device)
 	struct bnxt *bp = netdev_priv(dev);
 	int rc = 0;
 
+	rtnl_lock();
 	netdev_lock(dev);
 	rc = pci_enable_device(bp->pdev);
 	if (rc) {
@@ -16796,6 +16815,7 @@ static int bnxt_resume(struct device *device)
 
 resume_exit:
 	netdev_unlock(bp->dev);
+	rtnl_unlock();
 	bnxt_ulp_start(bp, rc);
 	if (!rc)
 		bnxt_reenable_sriov(bp);
@@ -16961,6 +16981,7 @@ static void bnxt_io_resume(struct pci_dev *pdev)
 	int err;
 
 	netdev_info(bp->dev, "PCI Slot Resume\n");
+	rtnl_lock();
 	netdev_lock(netdev);
 
 	err = bnxt_hwrm_func_qcaps(bp);
@@ -16978,6 +16999,7 @@ static void bnxt_io_resume(struct pci_dev *pdev)
 		netif_device_attach(netdev);
 
 	netdev_unlock(netdev);
+	rtnl_unlock();
 	bnxt_ulp_start(bp, err);
 	if (!err)
 		bnxt_reenable_sriov(bp);
-- 
2.30.1


