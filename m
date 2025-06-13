Return-Path: <netdev+bounces-197667-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF43AD9894
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 01:19:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 513381BC1827
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 23:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87FB128ECC9;
	Fri, 13 Jun 2025 23:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="JRSfucEd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5FB2E11D4
	for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 23:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749856789; cv=none; b=mRlj6k2yr2010FhqG8Ww8cuJIgxYIqfjem4ylkGD7INELtjdWfLzsvruwZh0AyzeUn95Xku0hQ+AODj+F48jhK9Crr84Zc1/F5GDyZJuyh7R5EMdzuORvYZG9xJRz831wWsvmIxR4rTucE26Q+h59mttwGKNdfDine2USZYXZzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749856789; c=relaxed/simple;
	bh=gzIYsCo+yFQ0lo04rJJxVzfmCRy6nZkaFYMvigFCgPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gWyaCPTh00jaP+KkIEcjh2v1OFormqBE/OXp30r1NN8I2eeyW/Ql37dpZnTmNwbIIQFSfuOr0YGV4Bq/FqHtjtZ5lFnRM66XIrT/lFJU4Q9Ev7LOxYsD0ouushSnlzZmMFYTzJJpjldhnPIKLQLtIANrjShURN/4LbWDiU0Vowc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=JRSfucEd; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-234bfe37cccso35145595ad.0
        for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 16:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1749856787; x=1750461587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cf4E1Lm9Ubv4tJ6fUorg8K9HJB7l7AUHLdbN87eS0xw=;
        b=JRSfucEdBDTo9NAZ8g8aaaTV9OLlGGTJVHm2FqB+xEX3f8gVVJ3FiMmZZB1vM1BMwE
         DuYc+nP0eD2FS1FIZaBEUJlTcHh/9Sx4gfAFDZbY0LnKwsCnqjtG78h0m0jZrJZAEoPT
         O+IBEmOpdNa33lEWXKrZ51Mzb5rQAF5YuKBbY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749856787; x=1750461587;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cf4E1Lm9Ubv4tJ6fUorg8K9HJB7l7AUHLdbN87eS0xw=;
        b=kTD5a9H5/ynTaW2xzZZRqJe4wyYkLF/OZWsgOYZCfmXt3HuDmrKwYEof+iHRZwpHrJ
         OD21yEprZZR3kinkuqBZJdIKXnRBRSUek3WP0rFUsRxpSgrvt2A0hdoy0bufua+2zzrG
         penU1zUJ18CgsvnZD0s+1FsxdaLTkO1dyNy5/2Kj8Lz/f3Famnflh05kJ3xaIzbRDgBz
         1ikzZdxVnxT9OEFSrql5cV687IaFjnWWAWIe1jnxLtbnI013i58zgBUWzvw4R/g2njtj
         jDJATJGKmVaKdG1mkZY0/8G3tnsQOtnB5x5ubernpobeq7FNlfGkKmuv/MDM9UMV0Ax0
         ssZQ==
X-Gm-Message-State: AOJu0YzfG0mN831R6GAH2P0dG5nmJjUBbhtSm+NSuJEplELh9lOcjWy8
	+1DpG4aBGnRWCkhgGFRV8j5J/BMNqth4tK/whqrUFZ27xLhxm7AhdnByQL8yn/Ajlg==
X-Gm-Gg: ASbGnctcqmI/3BtY9CAaBDaiiDDw2Xd2BcXAXDKrA16CDQQTJdTzWXnBEP3wiMeGCK3
	pD3BjqaTFhQ42rCdO/ItJggzcleXofnCrMA4tGC72GlOAwqy5qQsefSWGeHrneqho+rE5dY95lg
	krVH/iMfoRrQaHgwikaRRGelWUfuS488M07qIGHRPO63O4BUYSP7Lc3h2VxQy5PB3PyyWNBARmo
	bZrAbINGc9FmUQnzLgHfnGg5kC1WylHgRJ2klGV6J23LgGTr4tsVMXCNjNzJx4Jbd0tqiR3UKCY
	IJ5ZvrJ4tqIfjQD0HIkQUEx8YqTxIYLHzrb2VtsDEWD9o+li7LUy76Hc4qLL5yI4cwhm++kyHDU
	JJNRM4cHFZGs5SgXD7yDtvIjKPcmxgzSdJF7ngA==
X-Google-Smtp-Source: AGHT+IFt/xx8jrak5dq/nVHVzfSIU7UCNHKYUbNojjYpBWrZRtaX0+s9uaoECiW3Nsz08LkECvNloA==
X-Received: by 2002:a17:902:ce8d:b0:235:f3df:bbff with SMTP id d9443c01a7336-2366b00163dmr19022295ad.4.1749856787153;
        Fri, 13 Jun 2025 16:19:47 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365de7832asm20165105ad.140.2025.06.13.16.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 16:19:46 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH net 1/3] bnxt_en: Fix double invocation of bnxt_ulp_stop()/bnxt_ulp_start()
Date: Fri, 13 Jun 2025 16:18:39 -0700
Message-ID: <20250613231841.377988-2-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250613231841.377988-1-michael.chan@broadcom.com>
References: <20250613231841.377988-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>

Before the commit under the Fixes tag below, bnxt_ulp_stop() and
bnxt_ulp_start() were always invoked in pairs.  After that commit,
the new bnxt_ulp_restart() can be invoked after bnxt_ulp_stop()
has been called.  This may result in the RoCE driver's aux driver
.suspend() method being invoked twice.  The 2nd bnxt_re_suspend()
call will crash when it dereferences a NULL pointer:

(NULL ib_device): Handle device suspend call
BUG: kernel NULL pointer dereference, address: 0000000000000b78
PGD 0 P4D 0
Oops: Oops: 0000 [#1] SMP PTI
CPU: 20 UID: 0 PID: 181 Comm: kworker/u96:5 Tainted: G S                  6.15.0-rc1 #4 PREEMPT(voluntary)
Tainted: [S]=CPU_OUT_OF_SPEC
Hardware name: Dell Inc. PowerEdge R730/072T6D, BIOS 2.4.3 01/17/2017
Workqueue: bnxt_pf_wq bnxt_sp_task [bnxt_en]
RIP: 0010:bnxt_re_suspend+0x45/0x1f0 [bnxt_re]
Code: 8b 05 a7 3c 5b f5 48 89 44 24 18 31 c0 49 8b 5c 24 08 4d 8b 2c 24 e8 ea 06 0a f4 48 c7 c6 04 60 52 c0 48 89 df e8 1b ce f9 ff <48> 8b 83 78 0b 00 00 48 8b 80 38 03 00 00 a8 40 0f 85 b5 00 00 00
RSP: 0018:ffffa2e84084fd88 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000001
RDX: 0000000000000000 RSI: ffffffffb4b6b934 RDI: 00000000ffffffff
RBP: ffffa1760954c9c0 R08: 0000000000000000 R09: c0000000ffffdfff
R10: 0000000000000001 R11: ffffa2e84084fb50 R12: ffffa176031ef070
R13: ffffa17609775000 R14: ffffa17603adc180 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffffa17daa397000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000b78 CR3: 00000004aaa30003 CR4: 00000000003706f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
<TASK>
bnxt_ulp_stop+0x69/0x90 [bnxt_en]
bnxt_sp_task+0x678/0x920 [bnxt_en]
? __schedule+0x514/0xf50
process_scheduled_works+0x9d/0x400
worker_thread+0x11c/0x260
? __pfx_worker_thread+0x10/0x10
kthread+0xfe/0x1e0
? __pfx_kthread+0x10/0x10
ret_from_fork+0x2b/0x40
? __pfx_kthread+0x10/0x10
ret_from_fork_asm+0x1a/0x30

Check the BNXT_EN_FLAG_ULP_STOPPED flag and do not proceed if the flag
is already set.  This will preserve the original symmetrical
bnxt_ulp_stop() and bnxt_ulp_start().

Also, inside bnxt_ulp_start(), clear the BNXT_EN_FLAG_ULP_STOPPED
flag after taking the mutex to avoid any race condition.  And for
symmetry, only proceed in bnxt_ulp_start() if the
BNXT_EN_FLAG_ULP_STOPPED is set.

Fixes: 3c163f35bd50 ("bnxt_en: Optimize recovery path ULP locking in the driver")
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Co-developed-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c | 24 ++++++++-----------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
index 84c4812414fd..2450a369b792 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
@@ -231,10 +231,9 @@ void bnxt_ulp_stop(struct bnxt *bp)
 		return;
 
 	mutex_lock(&edev->en_dev_lock);
-	if (!bnxt_ulp_registered(edev)) {
-		mutex_unlock(&edev->en_dev_lock);
-		return;
-	}
+	if (!bnxt_ulp_registered(edev) ||
+	    (edev->flags & BNXT_EN_FLAG_ULP_STOPPED))
+		goto ulp_stop_exit;
 
 	edev->flags |= BNXT_EN_FLAG_ULP_STOPPED;
 	if (aux_priv) {
@@ -250,6 +249,7 @@ void bnxt_ulp_stop(struct bnxt *bp)
 			adrv->suspend(adev, pm);
 		}
 	}
+ulp_stop_exit:
 	mutex_unlock(&edev->en_dev_lock);
 }
 
@@ -258,19 +258,13 @@ void bnxt_ulp_start(struct bnxt *bp, int err)
 	struct bnxt_aux_priv *aux_priv = bp->aux_priv;
 	struct bnxt_en_dev *edev = bp->edev;
 
-	if (!edev)
-		return;
-
-	edev->flags &= ~BNXT_EN_FLAG_ULP_STOPPED;
-
-	if (err)
+	if (!edev || err)
 		return;
 
 	mutex_lock(&edev->en_dev_lock);
-	if (!bnxt_ulp_registered(edev)) {
-		mutex_unlock(&edev->en_dev_lock);
-		return;
-	}
+	if (!bnxt_ulp_registered(edev) ||
+	    !(edev->flags & BNXT_EN_FLAG_ULP_STOPPED))
+		goto ulp_start_exit;
 
 	if (edev->ulp_tbl->msix_requested)
 		bnxt_fill_msix_vecs(bp, edev->msix_entries);
@@ -287,6 +281,8 @@ void bnxt_ulp_start(struct bnxt *bp, int err)
 			adrv->resume(adev);
 		}
 	}
+ulp_start_exit:
+	edev->flags &= ~BNXT_EN_FLAG_ULP_STOPPED;
 	mutex_unlock(&edev->en_dev_lock);
 }
 
-- 
2.30.1


