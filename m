Return-Path: <netdev+bounces-248241-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 026D2D0597A
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 19:36:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 63BD1301EF26
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 18:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D35A31A044;
	Thu,  8 Jan 2026 18:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ddtu73kT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f98.google.com (mail-ot1-f98.google.com [209.85.210.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FD931D362
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 18:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767897372; cv=none; b=Wm8tHRlvEHE/iuRZHG53o/o6tsLK1FI0USmNoTQxiLr980TMyXgPN9x7LL2Y+zoPmWYn1U+ngtYkrTXrkgBBpO0dn6w08SdT2qWUKLF/7Y1o2Lb8AomDy5D4ycBX3KQAArKB21WufAMxmvgrOlxCd8Rq8l/+EF8IPyuAUQo5Pmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767897372; c=relaxed/simple;
	bh=J3zCQT9KRfR6Phew64Xd6TkllgZgHPeNbAmKrWxCo1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DJxwYkRUGmV00gPwB1u+YXH02r6l/L1ESJ+xmEpQw9rjVsmRrLf3ztokGRIHlEjIX5qNchzRR1meC4BEOm0jM861IniP258AenY0rbhBsYKzEULMVplPP3AigjJ3kH411KuQsMtK3V6j+GWMm1W87yGmcGQ5IJIZNBXSDMxB9qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ddtu73kT; arc=none smtp.client-ip=209.85.210.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f98.google.com with SMTP id 46e09a7af769-7c701097a75so2014187a34.3
        for <netdev@vger.kernel.org>; Thu, 08 Jan 2026 10:36:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767897369; x=1768502169;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DwzT9JMMB7mK6wX1rUx4UrG4jivBz1ByRguCNkGrzbw=;
        b=jfRqQdrKJ4kkrzkyWGNkxT7GgbGTTY0ww1+PfHdVZKgROynFiBziLBOuzYr5E2mXrl
         jFDDeWiYA8WEDgZS+VLjSd0eZXBmJxya/r9kMeIu/88uCwT5Ph97Ao1ynB/wB/7Y93ZQ
         FS1NAU+jJKPMFIKtw+BJeWaxtvgUTffAWp2OPHn/IDakRKdncGNKoH2txAgeEGjyPycC
         UfbUp2tQ9A0vJlVM2UcvZRX9XPR7D6VIWok77/h9t7gPjhDrPeXbewbatEXsi9HjYh0S
         l1XWi+HbewspCptbIKWPnoseasmS3giPTTPrQ6ssrjSNECJOJHKLF8uUEmehGlSRhNst
         oKnQ==
X-Gm-Message-State: AOJu0YxuITR/JNRaZRswdAY9EphYR+zygoig0iJ8hvLKaRF/xZ0UXeyN
	3zk5NuQ86PwNQplJGFsVdQOdzYmweL1DM/BBshvRNoWyR4D16+N6NoQcvgHfHEW4TlFcyU8+/0M
	/Z0Tf/Ct3EpYTKsihw7mdZFSlQkhKmnENaOkBIQ3Tpyz7F5qoTE1Y8R/IRWiQHyFc8jWyXzfGtD
	zVyRwqQQBYj9b4i1nAizlUnhJXA0GK3M/IiQ+J5wVuGJLEMVrXFVzcVL/LtCENuYPU0iRZm2K2z
	kibt73CBIA=
X-Gm-Gg: AY/fxX4GMeRmbSgZ0TS6ehoi/006XwVmKI+g2rTYXQ4hsPyt64lVT21eJ9QjcZnmh1i
	FZF2j3AXMsaZ8kPCtMWNlnBGiI7hVCE7mT1EA3tnlIvK+Q4MzFCkpkpWOrAsJbDWhvuUujVkqJv
	PYzY99WR8me4sl1Pd8z+tbbxPhzIRJP3jLEAMK1V/X88ub3M34GWo475528pbptp4Rlfxu+ZyZi
	/SFf136VOufsPhKsnV3bMQIPIUNAYHabsKK4eXzRhUtCH/GJ/neVTUANRDu/qP7f++tBoDE7Y0U
	lADjlBX3JDTTxx1Mg0jnA/XOZjtDmXaysPzYaH9ItNjY2nAgL5/OANjW67Iz588DZ8uUlbkgi33
	etro5sw084i7Ir97/IiMHurjy9dRuSN7ERwuORgqls5cS9vMFpRP6OaYkErtAHeGfcZ57yZN2tU
	zTLN+d9rclRybKZi2bKqhEcU7HmoNSxonjxrHXM+gV/nj8KYI=
X-Google-Smtp-Source: AGHT+IGbAhY6RD0rCH8zNwN/7an4RnJ2a2OPegyxLqse6js/YkJoloDtDPlzLSvDEXs8XBOrOwQDqcO3aW9a
X-Received: by 2002:a05:6830:3c1:b0:7b2:aba7:f4e with SMTP id 46e09a7af769-7ce508cea6emr3614875a34.10.1767897369442;
        Thu, 08 Jan 2026 10:36:09 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-116.dlp.protect.broadcom.com. [144.49.247.116])
        by smtp-relay.gmail.com with ESMTPS id 46e09a7af769-7ce47802f1bsm1139467a34.2.2026.01.08.10.36.09
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Jan 2026 10:36:09 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4ed7591799eso80503161cf.0
        for <netdev@vger.kernel.org>; Thu, 08 Jan 2026 10:36:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1767897368; x=1768502168; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DwzT9JMMB7mK6wX1rUx4UrG4jivBz1ByRguCNkGrzbw=;
        b=ddtu73kTu2Nx6zYSSULObx3meb3HVqykcKcBan8RIExU1Oex8nZfN+fIgURgXQtVSc
         Ni6h47se/FDgByZjwsyi9tsRF+Aji+tIEA8DV4Z0jhCyELQR9UQUsprCiLE+FkoY5Dsr
         WJZKa6N7ari+QE6/T5GTCZuTyf+ILeZzSZmwM=
X-Received: by 2002:a05:622a:40cc:b0:4ee:4709:4c38 with SMTP id d75a77b69052e-4ffb4b5b232mr94464171cf.80.1767897367706;
        Thu, 08 Jan 2026 10:36:07 -0800 (PST)
X-Received: by 2002:a05:622a:40cc:b0:4ee:4709:4c38 with SMTP id d75a77b69052e-4ffb4b5b232mr94463721cf.80.1767897367164;
        Thu, 08 Jan 2026 10:36:07 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ffc17c2897sm15973721cf.32.2026.01.08.10.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 10:36:06 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	Hongguang Gao <hongguang.gao@broadcom.com>,
	Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Subject: [PATCH net-next v2 3/6] bnxt_en: Add support for FEC bin histograms
Date: Thu,  8 Jan 2026 10:35:18 -0800
Message-ID: <20260108183521.215610-4-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.45.4
In-Reply-To: <20260108183521.215610-1-michael.chan@broadcom.com>
References: <20260108183521.215610-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Fill in the struct ethtool_fec_hist passed to the bnxt_get_fec_stats()
callback if the FW supports the feature.  Bins 0 to 15 inclusive are
available when the feature is supported.

Reviewed-by: Hongguang Gao <hongguang.gao@broadcom.com>
Reviewed-by: Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  1 +
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 51 +++++++++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 08d9adf52ec6..2a2d172fa6ed 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2704,6 +2704,7 @@ struct bnxt {
 #define BNXT_PHY_FL_NO_PFC		(PORT_PHY_QCAPS_RESP_FLAGS2_PFC_UNSUPPORTED << 8)
 #define BNXT_PHY_FL_BANK_SEL		(PORT_PHY_QCAPS_RESP_FLAGS2_BANK_ADDR_SUPPORTED << 8)
 #define BNXT_PHY_FL_SPEEDS2		(PORT_PHY_QCAPS_RESP_FLAGS2_SPEEDS2_SUPPORTED << 8)
+#define BNXT_PHY_FL_FDRSTATS		(PORT_PHY_QCAPS_RESP_FLAGS2_FDRSTAT_CMD_SUPPORTED << 8)
 
 	/* copied from flags in hwrm_port_mac_qcaps_output */
 	u8			mac_flags;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 068e191ede19..af4ceb6d2158 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -3216,6 +3216,56 @@ static int bnxt_get_fecparam(struct net_device *dev,
 	return 0;
 }
 
+static const struct ethtool_fec_hist_range bnxt_fec_ranges[] = {
+	{ 0, 0},
+	{ 1, 1},
+	{ 2, 2},
+	{ 3, 3},
+	{ 4, 4},
+	{ 5, 5},
+	{ 6, 6},
+	{ 7, 7},
+	{ 8, 8},
+	{ 9, 9},
+	{ 10, 10},
+	{ 11, 11},
+	{ 12, 12},
+	{ 13, 13},
+	{ 14, 14},
+	{ 15, 15},
+	{ 0, 0},
+};
+
+static void bnxt_hwrm_port_phy_fdrstat(struct bnxt *bp,
+				       struct ethtool_fec_hist *hist)
+{
+	struct ethtool_fec_hist_value *values = hist->values;
+	struct hwrm_port_phy_fdrstat_output *resp;
+	struct hwrm_port_phy_fdrstat_input *req;
+	int rc, i;
+
+	if (!(bp->phy_flags & BNXT_PHY_FL_FDRSTATS))
+		return;
+
+	rc = hwrm_req_init(bp, req, HWRM_PORT_PHY_FDRSTAT);
+	if (rc)
+		return;
+
+	req->port_id = cpu_to_le16(bp->pf.port_id);
+	req->ops = cpu_to_le16(PORT_PHY_FDRSTAT_REQ_OPS_COUNTER);
+	resp = hwrm_req_hold(bp, req);
+	rc = hwrm_req_send(bp, req);
+	if (!rc) {
+		hist->ranges = bnxt_fec_ranges;
+		for (i = 0; i <= 15; i++) {
+			__le64 sum = resp->accumulated_codewords_err_s[i];
+
+			values[i].sum = le64_to_cpu(sum);
+		}
+	}
+	hwrm_req_drop(bp, req);
+}
+
 static void bnxt_get_fec_stats(struct net_device *dev,
 			       struct ethtool_fec_stats *fec_stats,
 			       struct ethtool_fec_hist *hist)
@@ -3237,6 +3287,7 @@ static void bnxt_get_fec_stats(struct net_device *dev,
 		*(rx + BNXT_RX_STATS_EXT_OFFSET(rx_fec_corrected_blocks));
 	fec_stats->uncorrectable_blocks.total =
 		*(rx + BNXT_RX_STATS_EXT_OFFSET(rx_fec_uncorrectable_blocks));
+	bnxt_hwrm_port_phy_fdrstat(bp, hist);
 }
 
 static u32 bnxt_ethtool_forced_fec_to_fw(struct bnxt_link_info *link_info,
-- 
2.51.0


