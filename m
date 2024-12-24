Return-Path: <netdev+bounces-154129-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 353E89FB8AF
	for <lists+netdev@lfdr.de>; Tue, 24 Dec 2024 03:28:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 092E818848FB
	for <lists+netdev@lfdr.de>; Tue, 24 Dec 2024 02:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A069913D297;
	Tue, 24 Dec 2024 02:27:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.nfschina.com (unknown [42.101.60.213])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 5C7BB1802B;
	Tue, 24 Dec 2024 02:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735007278; cv=none; b=trNFrA/5YewrKZoSrhONVT127s1/2WA8NcsmaNTvbQmDg4AS44mJydFVvKj+lmU2I7XPvlB/uzGiu+gaiyqqWLQFgPaMESAIXQmCo1C330hQAhq3YEao78r1meGpWL1+KyubBKwXuDcuTx0kJBl1I7BIUhnfIm8SpIs11M3uyVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735007278; c=relaxed/simple;
	bh=bszwTxvSG8MHCB+u/eo2cVvN+KizSiYeQWcaFcIuKzg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AGYveCCJ+meqxa716XVLyBnS3wRZ6ZF5Ich7TUqFAJI4a04LuE3X7++uuoG32w6Nia8Gtr38TnKYC/5naRzN46ht08QTNEBDYgjjqJN+d6brsLZMDrACtRZ8Hz3e0FaP3+XH31t32kwVrjxeiCcopXF0YUgNwHVxwD842I6tA3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from localhost.localdomain (unknown [180.167.10.98])
	by mail.nfschina.com (MailData Gateway V2.8.8) with ESMTPSA id 634B26018B978;
	Tue, 24 Dec 2024 10:27:36 +0800 (CST)
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: Su Hui <suhui@nfschina.com>
To: alexanderduyck@fb.com,
	kuba@kernel.org,
	kernel-team@meta.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com
Cc: Su Hui <suhui@nfschina.com>,
	sanmanpradhan@meta.com,
	mohsin.bashr@gmail.com,
	kalesh-anakkur.purayil@broadcom.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] eth: fbnic: Avoid garbage value in fbnic_mac_get_sensor_asic()
Date: Tue, 24 Dec 2024 10:27:29 +0800
Message-Id: <20241224022728.675609-1-suhui@nfschina.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'fw_cmpl' is uninitialized which makes 'sensor' and '*val' to be stored
garbage value. Initialize 'fw_cmpl' with 'fdb->cmpl_data' to fix this
problem.

Fixes: d85ebade02e8 ("eth: fbnic: Add hardware monitoring support via HWMON interface")
Signed-off-by: Su Hui <suhui@nfschina.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic_mac.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_mac.c b/drivers/net/ethernet/meta/fbnic/fbnic_mac.c
index 80b82ff12c4d..ab1d1864d7a8 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_mac.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_mac.c
@@ -688,15 +688,18 @@ fbnic_mac_get_eth_mac_stats(struct fbnic_dev *fbd, bool reset,
 
 static int fbnic_mac_get_sensor_asic(struct fbnic_dev *fbd, int id, long *val)
 {
-	struct fbnic_fw_completion fw_cmpl;
+	struct fbnic_fw_completion *fw_cmpl = fbd->cmpl_data;
 	s32 *sensor;
 
+	if (!fw_cmpl)
+		return -EINVAL;
+
 	switch (id) {
 	case FBNIC_SENSOR_TEMP:
-		sensor = &fw_cmpl.tsene.millidegrees;
+		sensor = &fw_cmpl->tsene.millidegrees;
 		break;
 	case FBNIC_SENSOR_VOLTAGE:
-		sensor = &fw_cmpl.tsene.millivolts;
+		sensor = &fw_cmpl->tsene.millivolts;
 		break;
 	default:
 		return -EINVAL;
-- 
2.30.2


