Return-Path: <netdev+bounces-223844-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 147D2B7D5C4
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:26:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CD2D527CA6
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 04:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC39302146;
	Wed, 17 Sep 2025 04:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ZrzCp9wI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f228.google.com (mail-il1-f228.google.com [209.85.166.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A779A3016F5
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 04:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758082166; cv=none; b=pC7mgxfPCr81G1AO61m2+hhvI+Zf2lF1wlMkR4ps6+swn/THHNF4rcVrWxjiZFAOdqnBIiFEIz71av8J/5jTHd5AChRstXZBpcbp5mahBiDs69zGmgk5JWvB8oF7dwubFqiR2Mnd1x3LZ5kdFApItLmL12s6wkvjsNOI0sMF5N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758082166; c=relaxed/simple;
	bh=1nbW0v70adXEjK5v131fvPPmXdBie4xXZtI9Su8JQQI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tgtojT0MQSOybhxQXHvEcYc4RhVp1sw2V8riYCAXBUhei33VeAfaRj+xsMuzExPtzEE+R+RURE5Gn+WGrh56dfnVDbAKq8zmPldMOobG3rvopRqkkEpI7MxxBAVrTLWnuY9pgO2X+KR+naoQZ9li73joQ0jO9VyiYagiZ01a5z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ZrzCp9wI; arc=none smtp.client-ip=209.85.166.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-il1-f228.google.com with SMTP id e9e14a558f8ab-4240a63c68dso24145685ab.2
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 21:09:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758082164; x=1758686964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u3ps0+Kop2I5dzyjN0cMSVErMJv5b2g2qWh5qR/XUKU=;
        b=oIZq3HrgiHgXtpfGpc8lTgATuszmjl2gqxVMiOcukHB+AXXQL3BqCyb04h6ey3jky+
         j7wP3wtQCTWDwcmtqhkpqOIJh1GJa5vACdtKCB+6XZe7HKv1pgcgFx8RaeKR1lIVHO8f
         wSwHyaGTOd4UwzZ8sB/sKK5LImWmRwGH1yPYsETUErlIiZ8ewF3HLQQEjvyGKByexM3D
         PgX191mRdkWpZY4cIoT8OCPN0HuVb3En+c1vuolqvOlXmIHHiaJED/TIK4QFZFVQtmB6
         aBKTvHP0qxJOcLU3WvynHw41A9X5HapfmfMxmZsQYXV5eq3nA6y3SpEQ1a35J4P3lD0a
         ZXmg==
X-Gm-Message-State: AOJu0YzElAE+Aq9NHK2CQ8tD3GKrkHLdbRte8N/hnAGWcwkwvAjveb5d
	6nUvM9lM0zed8+1pLZbZMCyGstjLpw08DKlMcSC7jxlAdKRTuoT6bwhqOkSXg4cK6aWCaV3IurD
	15cB6OOT7HTSj98E9FaMZaNM1/k8wtCuhKzfl17S1s53RZKT8RqMHpnP1C8bmFVEWI7im1/VTSH
	EE8u7x1GvOqK0Azh5EK8xud6S5l83qbnjY0uTb4Y+YHHVmv5ya52t9QlZGy/DJMMZRnk7yXO8A2
	JoWOGWOKpo=
X-Gm-Gg: ASbGncuAxlQ2gHpkZfNFFjYUm8Oa3X0tLyChtUnRX2w1YJXl8X7wobC+PVn7ePyAn7J
	KjGHsurKH7ZCGeqvN1VsCnLXmXbxCRrnW6fgJoU1bhpMFiK4i6217XwsXEoXyp8xk1PgKa1mBam
	AcoWK0EJdxYPPrT9Qd2sCKTdL7gopjbUnDlPi0a5ZFE9yEGw8xo3s9rQQ6xMXN1bLqwRmA+hH+Q
	exOjenPJDQMC7Hj4gvTpd88aBugOMSuHHHuJ9dnhoHQozMhVBEQom0rU9zbfpO1Y0DMDFA7BEGh
	/a/ZOQtgi/+xJlFK+10u/yVtEni5WhDiCtqS/lJZnUlTB/glP/78KUf7jmMS2Dvj8ygSvtOcvQv
	UNNK/uEO0DMVdrWR8zZFxXFWnyQfn4Z1jO5ycR9/DVSrCqAkdO/uheoSiCgM1SwMs1A+SGU+I1g
	8=
X-Google-Smtp-Source: AGHT+IF+zv0vVhB54reHXO1Sg7GS7yKo1Lu4VSnQnxkV/wNruZbM15cjJ/u+sTruZLbl4ZE5W+0zutk0iLeQ
X-Received: by 2002:a05:6e02:1c2e:b0:424:40c:2426 with SMTP id e9e14a558f8ab-4241a5321e7mr10452845ab.16.1758082163774;
        Tue, 16 Sep 2025 21:09:23 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
        by smtp-relay.gmail.com with ESMTPS id 8926c6da1cb9f-511f308b40bsm1317258173.49.2025.09.16.21.09.23
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Sep 2025 21:09:23 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-32eaa47c7c8so1237769a91.3
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 21:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1758082162; x=1758686962; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u3ps0+Kop2I5dzyjN0cMSVErMJv5b2g2qWh5qR/XUKU=;
        b=ZrzCp9wIDHCdjFJcIdMact0zCoOtyvHfUwHk87kwqWx1oe3+RXZ53l4BmlxucjeHcR
         +VobPEVCi9Ml0dcbUNVTCjZYHhgpPCzqY7ip9IQoG+DIBisxoLrKqpiNL7jt7CZ+Lvni
         h7t2auDl2dRjOcenBDiuA30PqYSBHY1757EqY=
X-Received: by 2002:a17:90b:1a88:b0:329:e9da:35dd with SMTP id 98e67ed59e1d1-32ee3f77188mr844091a91.27.1758082161928;
        Tue, 16 Sep 2025 21:09:21 -0700 (PDT)
X-Received: by 2002:a17:90b:1a88:b0:329:e9da:35dd with SMTP id 98e67ed59e1d1-32ee3f77188mr844068a91.27.1758082161435;
        Tue, 16 Sep 2025 21:09:21 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32ee223f2ecsm558562a91.18.2025.09.16.21.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 21:09:20 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>
Subject: [PATCH net-next v2 03/10] bnxt_en: Optimize bnxt_sriov_disable()
Date: Tue, 16 Sep 2025 21:08:32 -0700
Message-ID: <20250917040839.1924698-4-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.45.4
In-Reply-To: <20250917040839.1924698-1-michael.chan@broadcom.com>
References: <20250917040839.1924698-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>

bnxt_sriov_disable() is invoked from 2 places:

1. When the user deletes the VFs.
2. During the unload of the PF driver instance.

Inside bnxt_sriov_disable(), driver invokes
bnxt_restore_pf_fw_resources() which in turn causes a close/open_nic().
There is no harm doing this in the unload path, although it is inefficient
and unnecessary.

Optimize the function to make it more efficient.

Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c       |  2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c | 12 ++++++++++--
 drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.h |  2 +-
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 5f4f4d99f1e7..a74b50130cc0 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -16156,7 +16156,7 @@ static void bnxt_remove_one(struct pci_dev *pdev)
 	struct bnxt *bp = netdev_priv(dev);
 
 	if (BNXT_PF(bp))
-		bnxt_sriov_disable(bp);
+		__bnxt_sriov_disable(bp);
 
 	bnxt_rdma_aux_device_del(bp);
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c
index 480e18a32caa..e7fbfeb1a387 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c
@@ -919,7 +919,7 @@ static int bnxt_sriov_enable(struct bnxt *bp, int *num_vfs)
 	return rc;
 }
 
-void bnxt_sriov_disable(struct bnxt *bp)
+void __bnxt_sriov_disable(struct bnxt *bp)
 {
 	u16 num_vfs = pci_num_vf(bp->pdev);
 
@@ -943,6 +943,14 @@ void bnxt_sriov_disable(struct bnxt *bp)
 	devl_unlock(bp->dl);
 
 	bnxt_free_vf_resources(bp);
+}
+
+static void bnxt_sriov_disable(struct bnxt *bp)
+{
+	if (!pci_num_vf(bp->pdev))
+		return;
+
+	__bnxt_sriov_disable(bp);
 
 	/* Reclaim all resources for the PF. */
 	rtnl_lock();
@@ -1321,7 +1329,7 @@ int bnxt_cfg_hw_sriov(struct bnxt *bp, int *num_vfs, bool reset)
 	return 0;
 }
 
-void bnxt_sriov_disable(struct bnxt *bp)
+void __bnxt_sriov_disable(struct bnxt *bp)
 {
 }
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.h
index 9a4bacba477b..e4979d729312 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.h
@@ -38,7 +38,7 @@ bool bnxt_is_trusted_vf(struct bnxt *bp, struct bnxt_vf_info *vf);
 int bnxt_set_vf_trust(struct net_device *dev, int vf_id, bool trust);
 int bnxt_sriov_configure(struct pci_dev *pdev, int num_vfs);
 int bnxt_cfg_hw_sriov(struct bnxt *bp, int *num_vfs, bool reset);
-void bnxt_sriov_disable(struct bnxt *);
+void __bnxt_sriov_disable(struct bnxt *bp);
 void bnxt_hwrm_exec_fwd_req(struct bnxt *);
 void bnxt_update_vf_mac(struct bnxt *);
 int bnxt_approve_mac(struct bnxt *, const u8 *, bool);
-- 
2.51.0


