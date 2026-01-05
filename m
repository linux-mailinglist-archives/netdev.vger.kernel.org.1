Return-Path: <netdev+bounces-247206-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D986CF5BF1
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 22:59:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 688BB300FBCB
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 21:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB9E3126B5;
	Mon,  5 Jan 2026 21:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ZdXeEylK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f100.google.com (mail-qv1-f100.google.com [209.85.219.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FFA3126A8
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 21:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767650357; cv=none; b=ctySRhBeeqGZLykQN17t0+6DlZGjKWHK9rKG+aKV09rvCGqGd5aBv6oEw01xDFyLsx26nnjFplx8Pf1aT2y4k9tWocbVnrcaVooduXrKelCc4JFI15oBDUKhsbr/OCjOT6nxoIOJtZDG9at2/CmUmM91Y5b0pBy6BThV1iUHPCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767650357; c=relaxed/simple;
	bh=7mJbrjJrIGi9dCwwkKZEXCkJLClPBLEA3fFQDKH7NVw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZHJWK3oGX6JspaJH0lHfBE1uwJe9RE+/kFeVt0MH6w5eq/2CK0dYumBWWHF6sQfUjbT1+JyPih4NtnBWOmJd4ql18DHFhtxAsEp0E2/V6eFNHcjcf7rqvyhiYIkgXRVCJgIJWdq73kbrXemOVxDxrlB2fYMN5U1Up8p1hD8V4Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ZdXeEylK; arc=none smtp.client-ip=209.85.219.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f100.google.com with SMTP id 6a1803df08f44-8887f43b224so4253596d6.1
        for <netdev@vger.kernel.org>; Mon, 05 Jan 2026 13:59:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767650355; x=1768255155;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YzTDq34sWASbOQaBXvUd5PON96DD9XpF9N4AqYeQJAI=;
        b=AuaXYK/Uf1MwaJXBb8z1DNnvurgl8LORpIXVv1O5CiFAIRZ7MnWNpVG2rTcJBD1u4K
         Er8dz7k3xweDRdBu9rurb9wXrk+OrXl/cXG64XpCFP9Zqqr2PB27Z9NsO27tOX9x82qw
         lTKDdv9GCiLnrx1lcBQMiY8by8uhCZAEQ/GL4hXu3miU9Ya6oTO2qUC/6OFS0XIHD5e3
         rt7cO5pCRWZpfxKiQRQp9QdErSGR+aBahP4+TD1nRledIRPqBpBqubAc2Ob6uka7N6Hp
         Lv6poQrcpGg8APYDCUdU30UVHRpupbetDqd3hcdlO/hgrciMNm1EAYAa+Xy7tVTEHolR
         q+iw==
X-Gm-Message-State: AOJu0Yxl/CIHt+Hum2y/3irXx1O+a+VWJv2rl5rAoH/CqWllfaMEN3BP
	ea/3HmJMXGoUQmrdVNZ9IkefkZOCkNUrbzle6uQ52zlpDwLAZAjgEhWi8MzINaSm3xfcPV/b1Ww
	/Rjyno2t1Z2ATHXVGe++vl2vymWExQ0z9QPzZ06QBPPpeLHvEuReQ22rpEEDwDYHj4LmcS2lhzH
	zBEyXUG0W/dp+83OmxLUcoxiguL8FuV+EEqJsUNZjE4o3QDmGbDNuy5QT/z4Uw/sKmDtoSwH7ag
	GLrxiCgVjk=
X-Gm-Gg: AY/fxX6GfUU9+4E2+iWL7tcDf/6vNxnujmHTnFrP9f5bd/kR8RT96v7U+kpfjUjTq81
	nkAIRF44oASfp4qF6wEXIAzsJ+bFwnJcNcDWcekfl/F/UTQSEZXxiHBeYszbErnuw1NMS7OrUYa
	wWEuydL+r2eSBTbHjJpG/DN6KOqR/I9ScXP8ZKKb4kSRefvqXD0D5kwuv5LfBhfk8dC42ndGEXz
	+m3u31Bt7qFnkQ9QL7c57Z/MIs8drwOqpeiSUxzXMERdsBzh+NKhOTYxoWcgQz2ZDKIBnkca9mE
	fo+1pzDp1n/BGItfLNypRdyogiYZfDBVqKtIGidDpomfobVlIGWuSysCzu7XysKJa96srUk9xKp
	lKO4fKltHWfYQ6hQyVpSQAEQAVYRbBfjaz4dsSPalgknRi0iHqKCxDJNNvw9aF7QSAQJ0/TWkDC
	J8M1gQRFhxwrQ6aBchHEBPZjwumQFrJyW0Z04+5Aw4BQ==
X-Google-Smtp-Source: AGHT+IH5vEe6Pc6miHYns52xdO/Uspg8mlPlKZUzI9KFfe+cK+LVFY0Kh3vEdyDtWVxuZ8mpYdjj0hDs8Igi
X-Received: by 2002:ad4:5d6a:0:b0:88f:9670:d107 with SMTP id 6a1803df08f44-89075ec67d4mr13284826d6.66.1767650355249;
        Mon, 05 Jan 2026 13:59:15 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-1.dlp.protect.broadcom.com. [144.49.247.1])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-8907710ed42sm341666d6.19.2026.01.05.13.59.14
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Jan 2026 13:59:15 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4ee04f4c632so6044351cf.3
        for <netdev@vger.kernel.org>; Mon, 05 Jan 2026 13:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1767650354; x=1768255154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YzTDq34sWASbOQaBXvUd5PON96DD9XpF9N4AqYeQJAI=;
        b=ZdXeEylKzo5gycZcIBk+QSjSYbID5c4lIbjrv5UeNVzUQ3t7DOoODNNqOUue+deGUb
         Fc7bPEPSnp9T7MdSA8Gjm0pzLp34H1kR59HZxORWoLvT+JfDdtxZu1TACOINh6Kawmkx
         CTXK069kmSYI3Th/ZRx+/yLOXXUQIbk1bhrQs=
X-Received: by 2002:a05:622a:1a91:b0:4ee:4168:b3b3 with SMTP id d75a77b69052e-4ffa769a54fmr18590761cf.5.1767650353816;
        Mon, 05 Jan 2026 13:59:13 -0800 (PST)
X-Received: by 2002:a05:622a:1a91:b0:4ee:4168:b3b3 with SMTP id d75a77b69052e-4ffa769a54fmr18590561cf.5.1767650353419;
        Mon, 05 Jan 2026 13:59:13 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ffa8d38e12sm1882051cf.3.2026.01.05.13.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 13:59:12 -0800 (PST)
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
	Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>
Subject: [PATCH net-next 3/6] bnxt_en: Add support for FEC bin histograms
Date: Mon,  5 Jan 2026 13:58:30 -0800
Message-ID: <20260105215833.46125-4-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.45.4
In-Reply-To: <20260105215833.46125-1-michael.chan@broadcom.com>
References: <20260105215833.46125-1-michael.chan@broadcom.com>
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


