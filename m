Return-Path: <netdev+bounces-189645-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CED65AB2FC2
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 08:38:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CC401895355
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 06:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B5BD255F50;
	Mon, 12 May 2025 06:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="CkB7exOw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08E8255F3C
	for <netdev@vger.kernel.org>; Mon, 12 May 2025 06:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747031909; cv=none; b=iaR7hLr0I/Tzui59tZH9QOIxrfGq0dwylajUNWPv4hvAr0ZlMkOFbuuynHCbVC5swaX+wxAV7TGUJt60/5RHronufJv8+v7XomoT+ByhXoTzut/tiH0hmVToqlZAEwPQmPt2Av/f7O/Ht7Et+RiFWaNQ/ba4o4N6mqiBw4VRxkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747031909; c=relaxed/simple;
	bh=tRhIkgMLWYG+LMJNlOB7Gb0H7krSf+xg+4culmibJm8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G1UbtJjKEurQMv2U+d0fRVDXEU0g819a9BcKwNI1PPizN1EzTE6YKg2L2crGSIMq3WMrfqkMMBS+8xhM4FwwDUZq7NVFyzRc+XO8OdHqSfuSCCgE5EqNuZBzzMR2a9T9kI/c9sNvYcgoWKphJNTx0H9c0n3hhc+15G7tKF4zV+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=CkB7exOw; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-736c277331eso4392745b3a.1
        for <netdev@vger.kernel.org>; Sun, 11 May 2025 23:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1747031907; x=1747636707; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i3uanFJBpnmE3H1Ao+z+VjTytzBfh7hJ2LLapPiOyhU=;
        b=CkB7exOwhOK8zShHwATIurDlBcOGSyT3fE/HVuwpqbg8SRiwexfZ84gqNiuVYcZZ09
         wCl2djM5ROPknTvZlipziFPQytc4niJsGNLpGWtlf7u4j4wDjDGI+35wxoU7iOYAuviD
         W4S7cCdLJXrw7R8gArbbRTmlq9LSK2Ybto5o4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747031907; x=1747636707;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i3uanFJBpnmE3H1Ao+z+VjTytzBfh7hJ2LLapPiOyhU=;
        b=kR8ayyZeQlSEXgT4ym7nbPPh7fnnYc4XYi80kBL9tNKNNaHgSKhaUvWt4Klg8tA234
         oqTfec5aBo1t9ty8EE9FiUdM1Jsf3+QmbS3eRnSHintKM0grTNhE8kLXUp+ahe7vowJj
         pF6W76RsZWWrlKBx/pR/96u0CYGyZqtP7EWQDVvfL2l+nX4riVDRD2bM78bRZMXLxhcU
         rooOrq4snLogGmf7wt/fuzkzfyLD8F3GMvM7P599BvaOVL2Qepw3gmeV+MbYaSy0CDi+
         ybfd/rXG3yRxhjwpe7XrBq344wsMBd7NfZtThLqCpELP4vRuqZPgPUrkc1AVz318Qn95
         8oWA==
X-Gm-Message-State: AOJu0YwsQTfuDcc9C6H8qBnYW9DpS4jP/Ep9SgwonENYT0IUcDn/KsGT
	KspcYtOEU4ZsVdTdKmiVwFhmkS/dQFjWteE5IivROTPF9X+OAeJJ/TRWZF13UCI0MzTCkyjrGZo
	=
X-Gm-Gg: ASbGncvqHoSFS5LDHW/PGaLIn/J02RBEEUWIAitxAfZw+xrkTJEZvFXViEk4Mir6O6Z
	jK6K2os6xvc0qiVTQWjpdxx+PbtdYPGf8+4RYkUTLRQIOyb1iTl4HLnXlViWlDgdaQNjUHsyasL
	YK23dD3UD8O9EVCTB4qteKYR56Je46k54BjARbNOMuDhalDB9UthIknTHzo2yvXGAagfYCFZg8R
	/3FXfmGkCSba6fWr2vOZr1x0i70y6+FAUzK0WkPS8WziDwOGB6FTggBcd43VO0NgREOIifJulD0
	k8TWPwMwxhQFdyE9cMGb5Sl1bfRZNL3mOciPPJYGzWPLcSvJsvqK9el3SMkNf8yTXot/Br7URvC
	1h5HoTfiSe71/4NNEMPvFz708/Eg=
X-Google-Smtp-Source: AGHT+IGnoXD/8k0QBumjvZUexFnwz/KQKBi66l7KeL9UcO7ZRzVZqS9xclsYLZtNholt9ZBqPZDlbQ==
X-Received: by 2002:a05:6a21:3384:b0:1ee:b5f4:b1d7 with SMTP id adf61e73a8af0-215ab51e3e0mr18506080637.7.1747031907001;
        Sun, 11 May 2025 23:38:27 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74237736e38sm5479741b3a.60.2025.05.11.23.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 May 2025 23:38:26 -0700 (PDT)
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
Subject: [PATCH net] bnxt_en: bring back rtnl_lock() in bnxt_fw_reset_task()
Date: Sun, 11 May 2025 23:37:55 -0700
Message-ID: <20250512063755.2649126-1-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RTNL assertion failed in netif_set_real_num_tx_queues() in the
error recovery path:

RTNL: assertion failed at net/core/dev.c (3178)
WARNING: CPU: 3 PID: 3392 at net/core/dev.c:3178 netif_set_real_num_tx_queues+0x1fd/0x210

Call Trace:
 <TASK>
 ? __pfx_bnxt_msix+0x10/0x10 [bnxt_en]
 __bnxt_open_nic+0x1ef/0xb20 [bnxt_en]
 bnxt_open+0xda/0x130 [bnxt_en]
 bnxt_fw_reset_task+0x21f/0x780 [bnxt_en]
 process_scheduled_works+0x9d/0x400

Bring back the rtnl_lock() for now in bnxt_fw_reset_task().

Fixes: 004b5008016a ("eth: bnxt: remove most dependencies on RTNL")
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 86a5de44b6f3..8df602663e0d 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -14960,15 +14960,17 @@ static void bnxt_fw_reset_task(struct work_struct *work)
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
 
@@ -14988,6 +14990,7 @@ static void bnxt_fw_reset_task(struct work_struct *work)
 			bnxt_dl_health_fw_status_update(bp, true);
 		}
 		netdev_unlock(bp->dev);
+		rtnl_unlock();
 		bnxt_ulp_start(bp, 0);
 		bnxt_reenable_sriov(bp);
 		netdev_lock(bp->dev);
-- 
2.30.1


