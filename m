Return-Path: <netdev+bounces-164372-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28F7DA2D8A0
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 21:30:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B4F83A7623
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 20:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86DE919DF8D;
	Sat,  8 Feb 2025 20:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="aiIIXVlJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63091F3B8B
	for <netdev@vger.kernel.org>; Sat,  8 Feb 2025 20:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739046614; cv=none; b=ib8mRcIwwmt+9gAawdyn3iMP+9S3eX5KWOI4uFGWnqtIQLhJn84O9UpD3eieHfJ/fzCO5vzQpswNhe6bHXPqA1gwXYr2l2HDkHuETgy0ZujFacNk0Q0Ftm8bbEh2Z+A7aLD0QnvbSNMp1cq3ZsrhtX1H1t4FE5agXdiTZ8+diLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739046614; c=relaxed/simple;
	bh=/Z40j/J42ZiQ048j2vF3aU41dOC1PM7eOBd+ElrAFQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S4RPDpoWcvPO7JnujuDaG/Wm+14o5XgD43E+0dOGewIX7BkeNe6jDlzUoLYfd/eaEICPO7wiwfY+Yi1exeqwELWM2qBbMrM1P9al0ufV+Ok9yqfgyolS7Xh2WmLm2ctg2IVd/xGHNsYrMYLeNMEvkEVKFHt/nOCW6kTcyl/ibQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=aiIIXVlJ; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-71e2aa8d5e3so1903093a34.2
        for <netdev@vger.kernel.org>; Sat, 08 Feb 2025 12:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1739046612; x=1739651412; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I4ASapAG1egWbtPE1ui+0PISpvbEH/BCpm+FdWZFb9A=;
        b=aiIIXVlJyf5QgWWjP9lftelrmBYW68x3dUY8Oevsn0nMkcZ4/7H+c/3OKHfRNSQWtj
         zXEo6JvAvXVq9ceqmzBEMu1y7TbvyrnIkPFG4w0eq8s4896AkGe67WTFMjpkLHm8QaoG
         6N6Q/i7EzfQE3A5HNviyG6+6Wwtj5rQwKbUeM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739046612; x=1739651412;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I4ASapAG1egWbtPE1ui+0PISpvbEH/BCpm+FdWZFb9A=;
        b=euu3xPF6zv1+Mf+UB5YbKN4tYZEd+9ZTObWKhkEY8lH0Mm7oTXyHfwK/IftRUirdoU
         kjCS9KWCIrcOrsbKXMzMDqmh7K2QSUE+d90FbEXi2X+Tcadzfu/KuQGXHU9qVYGmx4Ok
         3Nh7gAmiwb3WEYu7HsjXRiEuxLjTzYN3mOCwrivrcW+wfCMf8kbmT81j8AJ5ykMLPDB5
         Up5uVG/nsl+X30j69m/hi2tCnL87TUr26LrZVPhYnWYOtfifRLTUqCzhXVZPBr2NvwNt
         LfDQkqcU3ZtEjRdvxYBwsDcf8OeonE/AOJ08IZfBWGkOa+umwPuqV6MqTd+ZBCIgiFnL
         VoDg==
X-Gm-Message-State: AOJu0Yx8Zavggt5Yvcea9OacouK1FIhUuiDtQ8jLcHEnt2VeL6lqZft0
	NghHKm1TNjgDR1Ep7tljWdESQr1otPSdJ/k+s3uSxGPATp+wXQJ1moJ0U3y+OIjNiR9tqry2rck
	=
X-Gm-Gg: ASbGncshlZ0YwyJObkFsb+JlepZSA41S0nWScp9bXveI1smRpXtB2vscglzYOCnUH6V
	OWOwc3+n5X+TidmrMIjAPOPFhCB6a06yqnsflwcogNvx7LEUAMG1IuIv5FMOfF6WNtQxtMBFLG0
	zaZFO1arQCfWv3KF7TG7dDI4e5KojKaTQePAqiL0NiPKwZWfbcQjjbgOgOmDOaNN+RCudsXgI36
	YUJuvuWiO8yX+L5NMt1HS9RhYhmGndwRsBFDhJO9PbZ8MxX4zTN87AIm3skk9z6UQiOAPl67P77
	2Svoh6RAFTqU6OxmgSd48akkgff9BfCuWpsqkYD8noQ3jn9I4zYISv7Xkq6FQusaVog=
X-Google-Smtp-Source: AGHT+IGLKkXBTUax34oJ356eyMZjzss1dRy+MtVJSoqDRKUsYcxt85j559M7a+bkWoLx13IQWj/kMQ==
X-Received: by 2002:a05:6830:3508:b0:71d:fe93:2579 with SMTP id 46e09a7af769-726b86a45d4mr6056595a34.0.1739046611857;
        Sat, 08 Feb 2025 12:30:11 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-726af932f78sm1564130a34.18.2025.02.08.12.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Feb 2025 12:30:11 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	michal.swiatkowski@linux.intel.com,
	helgaas@kernel.org,
	horms@kernel.org,
	Hongguang Gao <hongguang.gao@broadcom.com>,
	Ajit Khaparde <ajit.khaparde@broadcom.com>
Subject: [PATCH net-next v4 07/10] bnxt_en: Pass NQ ID to the FW when allocating RX/RX AGG rings
Date: Sat,  8 Feb 2025 12:29:13 -0800
Message-ID: <20250208202916.1391614-8-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
In-Reply-To: <20250208202916.1391614-1-michael.chan@broadcom.com>
References: <20250208202916.1391614-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Newer firmware can use the NQ ring ID associated with each RX/RX AGG
ring to enable PCIe Steering Tags on P5_PLUS chips.  When allocating
RX/RX AGG rings, pass along NQ ring ID for the firmware to use.  This
information helps optimize DMA writes by directing them to the cache
closer to the CPU consuming the data, potentially improving the
processing speed.  This change is backward-compatible with older
firmware, which will simply disregard the information.

Reviewed-by: Hongguang Gao <hongguang.gao@broadcom.com>
Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Signed-off-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index ac63d3feaa1d..c6cf575af53f 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -6949,7 +6949,8 @@ static void bnxt_set_rx_ring_params_p5(struct bnxt *bp, u32 ring_type,
 				       struct bnxt_ring_struct *ring)
 {
 	struct bnxt_ring_grp_info *grp_info = &bp->grp_info[ring->grp_idx];
-	u32 enables = RING_ALLOC_REQ_ENABLES_RX_BUF_SIZE_VALID;
+	u32 enables = RING_ALLOC_REQ_ENABLES_RX_BUF_SIZE_VALID |
+		      RING_ALLOC_REQ_ENABLES_NQ_RING_ID_VALID;
 
 	if (ring_type == HWRM_RING_ALLOC_AGG) {
 		req->ring_type = RING_ALLOC_REQ_RING_TYPE_RX_AGG;
@@ -6963,6 +6964,7 @@ static void bnxt_set_rx_ring_params_p5(struct bnxt *bp, u32 ring_type,
 				cpu_to_le16(RING_ALLOC_REQ_FLAGS_RX_SOP_PAD);
 	}
 	req->stat_ctx_id = cpu_to_le32(grp_info->fw_stats_ctx);
+	req->nq_ring_id = cpu_to_le16(grp_info->cp_fw_ring_id);
 	req->enables |= cpu_to_le32(enables);
 }
 
-- 
2.30.1


