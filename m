Return-Path: <netdev+bounces-154487-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CA299FE1A2
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 02:43:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B38721618FB
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 01:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF08A17555;
	Mon, 30 Dec 2024 01:43:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.nfschina.com (unknown [42.101.60.213])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 14670173;
	Mon, 30 Dec 2024 01:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735522997; cv=none; b=dsZr+emAaF7ftHgTJilKt2AnijuBbnmOm+NXQ6kmBVhDMdjt3IEMFxmdEkmTbMtuMRspCp7abpvJIlIYb6pPSlJ5Qz8G+XtgENgguBmKdzF2to1pC/pLECYdaLf3uNtbhWxI6J4LMnZf0BTiizYTw8nv0qsxuadUp+yazZmMOdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735522997; c=relaxed/simple;
	bh=EyCmjyFwMCAuCg2VXOeyXn2RvsJsGNPqJulCqMvnv98=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kUvMBwJy/JvPR5ocLrIdnQz6PxpOJez+a2/9cDSvXOuMb4GocIpvpSwK3HOFMaIxED/WwGGnF19IMMY0rrfqND9CGmS9U0129RiO/o+SF5TWLfaXhskM26NdPy2HsZ9zUQ/77elNOA4ZnLpOAfCGBm3O4kuefDLyUT6jRUucsX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from localhost.localdomain (unknown [180.167.10.98])
	by mail.nfschina.com (MailData Gateway V2.8.8) with ESMTPSA id 018BD60284280;
	Mon, 30 Dec 2024 09:42:56 +0800 (CST)
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
	horms@kernel.org,
	mohsin.bashr@gmail.com,
	sanmanpradhan@meta.com,
	kalesh-anakkur.purayil@broadcom.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH v2] eth: fbnic: Avoid garbage value in fbnic_mac_get_sensor_asic()
Date: Mon, 30 Dec 2024 09:42:43 +0800
Message-Id: <20241230014242.14562-1-suhui@nfschina.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'fw_cmpl' is uninitialized which makes 'sensor' and '*val' to be stored
garbage value. Remove the whole body of fbnic_mac_get_sensor_asic() and
return -EOPNOTSUPP to fix this problem.

Fixes: d85ebade02e8 ("eth: fbnic: Add hardware monitoring support via HWMON interface")
Signed-off-by: Su Hui <suhui@nfschina.com>
Suggested-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/meta/fbnic/fbnic_mac.c | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_mac.c b/drivers/net/ethernet/meta/fbnic/fbnic_mac.c
index 80b82ff12c4d..dd28c0f4c4b0 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_mac.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_mac.c
@@ -688,23 +688,7 @@ fbnic_mac_get_eth_mac_stats(struct fbnic_dev *fbd, bool reset,
 
 static int fbnic_mac_get_sensor_asic(struct fbnic_dev *fbd, int id, long *val)
 {
-	struct fbnic_fw_completion fw_cmpl;
-	s32 *sensor;
-
-	switch (id) {
-	case FBNIC_SENSOR_TEMP:
-		sensor = &fw_cmpl.tsene.millidegrees;
-		break;
-	case FBNIC_SENSOR_VOLTAGE:
-		sensor = &fw_cmpl.tsene.millivolts;
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	*val = *sensor;
-
-	return 0;
+	return -EOPNOTSUPP;
 }
 
 static const struct fbnic_mac fbnic_mac_asic = {
-- 
2.30.2


