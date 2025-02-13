Return-Path: <netdev+bounces-165755-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE18A33474
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 02:14:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 013611667A1
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 01:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E72146585;
	Thu, 13 Feb 2025 01:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="RW4JOfEQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E991142E77
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 01:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739409218; cv=none; b=PE0HThCGh4YbRGz0LcfQaBr7R4V1cjMNux5DubQekJTEFjrFOwCYL/x+evL0w1CyGh+Ph+QfWSij3u4BhutgszV09ufQxQHt9xygLLg2npx2VTQAAZc84w7HdFYmuKM+G306VGcrtUWQ2wswdHkkbSyR+47+PBG44vs+PlIR3Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739409218; c=relaxed/simple;
	bh=/Z40j/J42ZiQ048j2vF3aU41dOC1PM7eOBd+ElrAFQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FD5+vliWvQP6c3grciepRnc7IWT1WIaquj5I/kJ9ynS1UBoil3uqqCdMZOZ2nAFjHOd2Q5754rwbq/8CUQFcwg2Dd7QHgSbjmsBlx+mqaXnrU5WwjXEPdbIXEz8bq3j56+M3ybwV6SEJEhG7umeG8W6o0s7f9p26xUBJ25aP5l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=RW4JOfEQ; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-726ef4cba96so111664a34.2
        for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 17:13:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1739409216; x=1740014016; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I4ASapAG1egWbtPE1ui+0PISpvbEH/BCpm+FdWZFb9A=;
        b=RW4JOfEQjZyiMb7+IqnyzZaBnbEMpAwoLNOJnnp2VyVHiq928kELstTfYFMCC96WaU
         QDh1tuNLIDF4W64ZJs1CcGMbyoLJdpHN6/HVie4ZjGSrv1GvSra55573ZeBkkxmRkMtw
         CTaoe6HgxECiyVoNolTBhjjsNgcy4FmsrRTmo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739409216; x=1740014016;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I4ASapAG1egWbtPE1ui+0PISpvbEH/BCpm+FdWZFb9A=;
        b=pAHc9oHy8DnSGBDy/2pMgXZqbVp9mS4SPOa9GXTtlnv+HT97kMVB0VoAWFxMdegrDu
         PhkE/7jfdpbZ6/+f7Bd9f33+X6/DLz6OJd+4sMSnT0uwlnxODsPSTKfBwrWB5RveUZ0C
         tfDst2TuO6w1WDGgVH67TgelnEYaFGL8mxFR6uryIHzebsB22UIK48A3+AKkQowyYC87
         LSzFBkIGn59296sDin3VYJ4YVhfjSgZ/pzhqV81Ia6OitN7bSufXxF3PQF+G2zfU/7lN
         IiLrndb6TsYwGH0yYbdqBxPqAMbIAVOSPwSeXq8wsI2rdaaabF1rPLdK8GaCS0PoMZjN
         70vA==
X-Gm-Message-State: AOJu0YxTYWgYpE3d5Qmbnz0nwMim/f/ZWG9AIewJZ6svNYil7X/CIbtD
	kYA0diCB8WU5WYkijC+YrbzxQRWus0sTC5m9RdtbhTyge6OQLJCvNUf65/UWiA==
X-Gm-Gg: ASbGncvdi2D4BXAxMcEDFEAPXXPuc0k0FzH7An6zYmgOzMVk6YoOnJ5kZjnYwWf7fBo
	yokcO7LnDd+y+jrxSGRxPPtTK3Qolg1Oq6upQOLgVu5xmJNmLmBiPrM31BPbvadEs+i7b4ULXZ1
	d/RQ1mb/xH6CmzQt/Igi24qgruRdORg730nZ5JKwVgwHzA8JdcPSQ575+ZSx15Jx2K/Sz7Rjr1d
	N6Xt2ZK5ILTEPZjmcFROJ5mkWGV1XGzjL6GBHhitfE9XsiyKyIK1hFWdIfU3j76c7MFHbc82otx
	rEu0vnFAo+qPCHfbpisj3bMch3HoT+xNmeDo2qskfKXNOlLi6whiID0+hY4yuEjg/xQ=
X-Google-Smtp-Source: AGHT+IEeZ6LN6Abwgwk4biXUtOiHDFSPWdweHEAJnI4CDPzSMTmxS4K9vFtnpMUpTcHwgGI1COGBJQ==
X-Received: by 2002:a05:6830:6487:b0:718:8dc:a5e with SMTP id 46e09a7af769-726f1c67cbcmr3737408a34.9.1739409216275;
        Wed, 12 Feb 2025 17:13:36 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-727001cdb70sm195967a34.13.2025.02.12.17.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 17:13:35 -0800 (PST)
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
Subject: [PATCH net-next v5 07/11] bnxt_en: Pass NQ ID to the FW when allocating RX/RX AGG rings
Date: Wed, 12 Feb 2025 17:12:35 -0800
Message-ID: <20250213011240.1640031-8-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
In-Reply-To: <20250213011240.1640031-1-michael.chan@broadcom.com>
References: <20250213011240.1640031-1-michael.chan@broadcom.com>
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


