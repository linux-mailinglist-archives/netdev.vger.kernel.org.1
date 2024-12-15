Return-Path: <netdev+bounces-152017-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C2A9F2626
	for <lists+netdev@lfdr.de>; Sun, 15 Dec 2024 22:01:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E302518862C7
	for <lists+netdev@lfdr.de>; Sun, 15 Dec 2024 21:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A77E1C3F1B;
	Sun, 15 Dec 2024 21:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="PXfJH3Vg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAEFC1C3C10
	for <netdev@vger.kernel.org>; Sun, 15 Dec 2024 21:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734296432; cv=none; b=KvkBfet2HAhBJA5fqJ4ee5yBtF1VEYgaWw6454TPGci0zirnoZ6L7MI7YTHaVj87kjJ4GChnCw84c9DkWkL/4ohvscFuqaUeKo9jTj4bIKkNIIpFq/2rSD2kY5JtBuDZfisK9NZqWMMyDCvgmm/MpWmnfh8/X6ik9lDDTU4XLsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734296432; c=relaxed/simple;
	bh=Q6P3hZzUdtMPg+519saphRIYwJgp/bV9oLP9tzaD9Lk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NMb4NoO+3G4IVM25s7jZ4CZS4kq9aULGJUTtLUKWnfxDfiIJXkNvGfOfydw5jtYI3Kn8g2snE7oZwhaxJPRyIcck0iS8lKZyiyTbt/jBDZydzHo9K/wT62Qc6wNzDQJreVRHalWCNHjSwm76y8aKccZ5qBM1axU9rklDBvj3jt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=PXfJH3Vg; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7292a83264eso375294b3a.0
        for <netdev@vger.kernel.org>; Sun, 15 Dec 2024 13:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1734296430; x=1734901230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mphCMawTYfO67se8KmonuD9NPoFtYUgxMw8Jw9VErus=;
        b=PXfJH3VgGhJvVkii/ILpjAvfFq848ImkvZUh2b74F9Bk0IpbEoLBJro0LgZzlvWTyf
         qycLJzW9LGixouAOsBs5pPxFq1CkXgiiEu6HXpjfPUanlPMMg3vHdhU6+limm3cL2mIa
         A3G4QGXBa7t3lEpSeexOpGOC2dmd9CHpKs68c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734296430; x=1734901230;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mphCMawTYfO67se8KmonuD9NPoFtYUgxMw8Jw9VErus=;
        b=ewcOG2Xrza2+FSbsTzNuWxOOIN9WH2K7QrGSU7EZ47yaPH7Gfa40PS6afuAqMNvJvH
         kctro5nZIue9m21ZJGr0gIIn+sLMTlwhiX0+OOr3VsS6Ty15hS5ylNorlhfpHdsmp63F
         fHodq/pEE6jwquDKVIKuIug1ZRtB2b5OXWQj/+ByQlvIrWQ6kkIWagNE9i0yQKWocMfZ
         kKhWZVEM2XJIq4cmRxPoSEBF6AbyZZy2ELWAlAy1E1SQjEfvo3Z6yAeoLVNbDfZA0qHJ
         RZWn5OM5Hyi9/1s0sI+Gbl1VoPvL5kQYVv1Im6Hg8FxngLW38C5ZayOnSQis+CvX/yjn
         4bsw==
X-Gm-Message-State: AOJu0Yx1pcfTO6t6CgC29lxqwJVgcNJMpOtlyQe5gALoj+eghSvRaZBK
	AIxfXSPtJO/vQfurTLWAlaMiViWck7S2NHGkXEZRrENmtYk9tHg1VpLRubeVMA==
X-Gm-Gg: ASbGncvc4igiQMIy/GElzwDd3Jpwjt2EzNS7QCr3Fa3984OVnqfpiAzauk4rNPmoT8J
	7l7kBwN15sz+Re9l3DloZuDYJkPV3lmc+IDAAXwmCKbBKggovADMDQFCx3D1ZYVJfok/bSeUGHd
	MxanYgmISn6Q3BQazp/eWfMuRV5HVnSruvTUJd1MfAf4cc37XEMPrSd/+um7fzsgQj67Be1ggyV
	bclcOkTHGYGfRf0M80rPRYM80j+hAU3EIycq1kO0VfMiEhiScQ4q59dENh8efoTGBbI9AoO1xGo
	0YfAekQ26V4u60yc/qCxpliM/K2DySLK
X-Google-Smtp-Source: AGHT+IFoBWQjnOFYsWbuzD27rlpIPKUAYei++TOoeBD5Q+M1dxupo+S1Zwd8PWo4F1QUYWGpyXRaGw==
X-Received: by 2002:a17:90b:4a09:b0:2ee:edae:780 with SMTP id 98e67ed59e1d1-2f28fb63e67mr16313904a91.15.1734296430247;
        Sun, 15 Dec 2024 13:00:30 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f142fc308csm6682717a91.50.2024.12.15.13.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 13:00:28 -0800 (PST)
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
Subject: [PATCH net-next 4/6] bnxt_en: Skip MAC loopback selftest if it is unsupported by FW
Date: Sun, 15 Dec 2024 12:59:41 -0800
Message-ID: <20241215205943.2341612-5-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
In-Reply-To: <20241215205943.2341612-1-michael.chan@broadcom.com>
References: <20241215205943.2341612-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Call the new HWRM_PORT_MAC_QCAPS to check if mac loopback is
supported.  Skip the MAC loopback ethtool self test if it is
not supported.

Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 29 +++++++++++++++++++
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  5 ++++
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 11 ++++---
 3 files changed, 41 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 631dbda725ab..5a19146d6902 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -11551,6 +11551,31 @@ static int bnxt_hwrm_phy_qcaps(struct bnxt *bp)
 	return rc;
 }
 
+static int bnxt_hwrm_mac_qcaps(struct bnxt *bp)
+{
+	struct hwrm_port_mac_qcaps_output *resp;
+	struct hwrm_port_mac_qcaps_input *req;
+	int rc;
+
+	if (bp->hwrm_spec_code < 0x10a03)
+		return 0;
+
+	rc = hwrm_req_init(bp, req, HWRM_PORT_MAC_QCAPS);
+	if (rc)
+		return rc;
+
+	resp = hwrm_req_hold(bp, req);
+	rc = hwrm_req_send_silent(bp, req);
+	if (rc)
+		goto hwrm_mac_qcaps_exit;
+
+	bp->mac_flags = resp->flags;
+
+hwrm_mac_qcaps_exit:
+	hwrm_req_drop(bp, req);
+	return rc;
+}
+
 static bool bnxt_support_dropped(u16 advertising, u16 supported)
 {
 	u16 diff = advertising ^ supported;
@@ -15679,6 +15704,10 @@ static int bnxt_probe_phy(struct bnxt *bp, bool fw_dflt)
 		bp->dev->priv_flags |= IFF_SUPP_NOFCS;
 	else
 		bp->dev->priv_flags &= ~IFF_SUPP_NOFCS;
+
+	bp->mac_flags = 0;
+	bnxt_hwrm_mac_qcaps(bp);
+
 	if (!fw_dflt)
 		return 0;
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index d5e81e008ab5..094c9e95b463 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2668,6 +2668,11 @@ struct bnxt {
 #define BNXT_PHY_FL_BANK_SEL		(PORT_PHY_QCAPS_RESP_FLAGS2_BANK_ADDR_SUPPORTED << 8)
 #define BNXT_PHY_FL_SPEEDS2		(PORT_PHY_QCAPS_RESP_FLAGS2_SPEEDS2_SUPPORTED << 8)
 
+	/* copied from flags in hwrm_port_mac_qcaps_output */
+	u8			mac_flags;
+#define BNXT_MAC_FL_NO_MAC_LPBK		\
+	PORT_MAC_QCAPS_RESP_FLAGS_LOCAL_LPBK_NOT_SUPPORTED
+
 	u8			num_tests;
 	struct bnxt_test_info	*test_info;
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index e5904f2d56df..3bc2bd732021 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -4896,21 +4896,24 @@ static void bnxt_self_test(struct net_device *dev, struct ethtool_test *etest,
 		bnxt_close_nic(bp, true, false);
 		bnxt_run_fw_tests(bp, test_mask, &test_results);
 
-		buf[BNXT_MACLPBK_TEST_IDX] = 1;
-		bnxt_hwrm_mac_loopback(bp, true);
-		msleep(250);
 		rc = bnxt_half_open_nic(bp);
 		if (rc) {
-			bnxt_hwrm_mac_loopback(bp, false);
 			etest->flags |= ETH_TEST_FL_FAILED;
 			return;
 		}
+		buf[BNXT_MACLPBK_TEST_IDX] = 1;
+		if (bp->mac_flags & BNXT_MAC_FL_NO_MAC_LPBK)
+			goto skip_mac_loopback;
+
+		bnxt_hwrm_mac_loopback(bp, true);
+		msleep(250);
 		if (bnxt_run_loopback(bp))
 			etest->flags |= ETH_TEST_FL_FAILED;
 		else
 			buf[BNXT_MACLPBK_TEST_IDX] = 0;
 
 		bnxt_hwrm_mac_loopback(bp, false);
+skip_mac_loopback:
 		buf[BNXT_PHYLPBK_TEST_IDX] = 1;
 		if (bp->phy_flags & BNXT_PHY_FL_NO_PHY_LPBK)
 			goto skip_phy_loopback;
-- 
2.30.1


