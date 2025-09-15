Return-Path: <netdev+bounces-222908-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E88B56EAF
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 05:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB199173E1D
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 03:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6225233136;
	Mon, 15 Sep 2025 03:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="UlvN8Zit"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f227.google.com (mail-pg1-f227.google.com [209.85.215.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F4722F75B
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 03:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757905563; cv=none; b=d171pXkSMr1AMQ3Pci7rCSQjdMGVA9jj2lVqjM26r/ypQfc2j2WOapibwjZNOT5lcKAklbl1eArDodKjIUWHVo3yoyXN48qrPOf9FwdjGuJLlZcCABtwLzpn7AM4uK/78ptmIQNipe4HbeD0THXb9OnWQYMSClszy04spMEg1/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757905563; c=relaxed/simple;
	bh=T0rWBk2/cst3C//lEBm1PyEGk2YPR0qlZhfOvfQSvTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gqhRIA4zcl346AEaQIMC4r+3XMvi+Un8HqS+mdILVljV2TYVTUd411tNmQxBIQVF7iGVo8rPpOTBDVUrm7qIhbXfpUaUFxj8PoCIaxoxiBYq4w+OaD4LooUuTPVuXoRfrE1Tvj1C47xYNyoqfYgmCLrF9asVioFxCLPFwiMW8bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=UlvN8Zit; arc=none smtp.client-ip=209.85.215.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f227.google.com with SMTP id 41be03b00d2f7-b52047b3f19so2606934a12.2
        for <netdev@vger.kernel.org>; Sun, 14 Sep 2025 20:06:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757905561; x=1758510361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EkgzcGpggyz8+m3UB5aMFLhbNRjFNPjtiTscZDda+bA=;
        b=j8RzOt59mYjdLfWmp7jbeKN6gEhIhHecfEPZ7m7GH2iy4BX82geBJAgDaqktp1gtWh
         CLxrX1YM4BSU4ivzUY9PoZUxqRG/UT3PjutMtX3lpqKAoRYHFLIZNI0HGYPxg6G5uV02
         jC+q6oPdoCFZIbUfDi0pv6ruW41Q7M/1paST0184VZGki5T54D3u+ZNxj6QNiqCAjICu
         evqjY+NHfLJcIq2XuKFGB/XW/jpjkQwncbhKkMXrX34ov8dS+O6aAwIVnWmUst2Nx7xd
         JYzc5tRdwodWBC2otrRzl2ub8QgkhtB1JkJ34RSjuyynHAXAU+WB6Q5BD0ur4xYVbTtt
         ZHFQ==
X-Gm-Message-State: AOJu0YyoubygLJmi4L5UHfH1OyrR3cAh5aliorCkrbPYjEQFoZy2GGMI
	+JmKNmh1iKX+q8fFxxrGriDng26I2QgiOVvhP+FyEL0Se1nZJI4Ux/BiQx15WN7dtHm/kYqZ6uj
	yGCKxfEIsrHlVJTVBkT8a4KJCDvKuFpWLtuJezIKhP1jsWdKtvDwJRfCXtnW/mvPkCbTF9qx7k2
	bwPsb6CTO3drdsXnhiURSj6sxkeLfUpevBGuWjXzqYxgaFASdQ9OQjXeKDxlHS0ClOqaAt4ozjR
	KvJPI0lRqs=
X-Gm-Gg: ASbGnctJKX/IAVCDWXz/PxfB3sqy7AmRoOIDAHcLRb1SuDHwSSb7CsO8fJd0aU6ENYZ
	7zpU+LQGdRfk7BT4gsW6Mv/set+C9oQpZlfyoJZDXm3IfITmLqqoi6ZuYrq+q63gTHd5+mRp4ls
	ZJ7ahAvhOE0lxaBogwe0GiHyLe5TAGFZYzqQsGWxd6uWy0S8ehyBvao4OF3VEm5j1lEIvpBEedh
	gqX9ub5MyT+r7L3kPlVulbvm9UWJo9GwljwQFLmPmD/C0ASU+n9ygSqC0tzPFWT7UVQurIWxdDX
	mcE6gTdc3T9LWL2udZrq3inqm3ovVJRSSraGiATQdO5aW4HapJLzL9MYSfvPjAOW6tGt7rKX33W
	6AG+iZfaPBYQHUZYd5H+zBmoH84+6be4h97cjM8ZBjU1xqhgwFiUyfRCr8aAN6UNuHLIz3kzizV
	pi6w==
X-Google-Smtp-Source: AGHT+IFeqhiHYIMpzi7FUeXFNhEesswmrm215LO3vrnxp6MT7saT8zFd30UMMpGMqXzaX2UfgygRB99Khp/q
X-Received: by 2002:a17:902:f549:b0:24c:caab:dfd2 with SMTP id d9443c01a7336-25d2810636cmr115400895ad.61.1757905561453;
        Sun, 14 Sep 2025 20:06:01 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2679e2e61a1sm163145ad.12.2025.09.14.20.06.01
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Sep 2025 20:06:01 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2621fab9befso12401315ad.2
        for <netdev@vger.kernel.org>; Sun, 14 Sep 2025 20:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1757905559; x=1758510359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EkgzcGpggyz8+m3UB5aMFLhbNRjFNPjtiTscZDda+bA=;
        b=UlvN8ZitNns0Mln7kJla+sUiD+BcK3xmm/jcFulMRWZgl5m5OUX55wtlrB1Pk9i9Yj
         7pTeyuz0LbHZfp+xl680Ps3Z2yWtfT7DBJAvJM00rJYk4nWm0SrqDSCFVCWqnMufm9H4
         tPqRiUa/hYSitubscZdB+L60YlujVc8utbhoI=
X-Received: by 2002:a17:902:fc4b:b0:24f:fb79:e25f with SMTP id d9443c01a7336-25d27624323mr138149685ad.46.1757905559577;
        Sun, 14 Sep 2025 20:05:59 -0700 (PDT)
X-Received: by 2002:a17:902:fc4b:b0:24f:fb79:e25f with SMTP id d9443c01a7336-25d27624323mr138149485ad.46.1757905559255;
        Sun, 14 Sep 2025 20:05:59 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c3b0219f9sm112723575ad.123.2025.09.14.20.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 20:05:58 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	Anantha Prabhu <anantha.prabhu@broadcom.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH net-next 08/11] bnxt_en: Support for RoCE resources dynamically shared within VFs.
Date: Sun, 14 Sep 2025 20:05:02 -0700
Message-ID: <20250915030505.1803478-9-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.45.4
In-Reply-To: <20250915030505.1803478-1-michael.chan@broadcom.com>
References: <20250915030505.1803478-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: Anantha Prabhu <anantha.prabhu@broadcom.com>

Add support for dynamic RoCE SRIOV resource configuration.  Instead of
statically dividing the RoCE resources by the number of VFs, provide
the maximum resources and let the FW dynamically dsitribute to the VFs
on the fly.

Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Anantha Prabhu <anantha.prabhu@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c       | 8 ++++++--
 drivers/net/ethernet/broadcom/bnxt/bnxt.h       | 3 +++
 drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c | 7 +++++++
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index dba3966c1ebd..207a74450e38 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -9632,10 +9632,10 @@ static int __bnxt_hwrm_ptp_qcfg(struct bnxt *bp)
 
 static int __bnxt_hwrm_func_qcaps(struct bnxt *bp)
 {
+	u32 flags, flags_ext, flags_ext2, flags_ext3;
+	struct bnxt_hw_resc *hw_resc = &bp->hw_resc;
 	struct hwrm_func_qcaps_output *resp;
 	struct hwrm_func_qcaps_input *req;
-	struct bnxt_hw_resc *hw_resc = &bp->hw_resc;
-	u32 flags, flags_ext, flags_ext2;
 	int rc;
 
 	rc = hwrm_req_init(bp, req, HWRM_FUNC_QCAPS);
@@ -9702,6 +9702,10 @@ static int __bnxt_hwrm_func_qcaps(struct bnxt *bp)
 	    (flags_ext2 & FUNC_QCAPS_RESP_FLAGS_EXT2_ROCE_VF_RESOURCE_MGMT_SUPPORTED))
 		bp->fw_cap |= BNXT_FW_CAP_ROCE_VF_RESC_MGMT_SUPPORTED;
 
+	flags_ext3 = le32_to_cpu(resp->flags_ext3);
+	if (flags_ext3 & FUNC_QCAPS_RESP_FLAGS_EXT3_ROCE_VF_DYN_ALLOC_SUPPORT)
+		bp->fw_cap |= BNXT_FW_CAP_ROCE_VF_DYN_ALLOC_SUPPORT;
+
 	bp->tx_push_thresh = 0;
 	if ((flags & FUNC_QCAPS_RESP_FLAGS_PUSH_MODE_SUPPORTED) &&
 	    BNXT_FW_MAJ(bp) > 217)
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 57a1af40cc19..c0f46eaf91c0 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2479,6 +2479,7 @@ struct bnxt {
 	#define BNXT_FW_CAP_ENABLE_RDMA_SRIOV           BIT_ULL(5)
 	#define BNXT_FW_CAP_ROCE_VF_RESC_MGMT_SUPPORTED	BIT_ULL(6)
 	#define BNXT_FW_CAP_KONG_MB_CHNL		BIT_ULL(7)
+	#define BNXT_FW_CAP_ROCE_VF_DYN_ALLOC_SUPPORT	BIT_ULL(8)
 	#define BNXT_FW_CAP_OVS_64BIT_HANDLE		BIT_ULL(10)
 	#define BNXT_FW_CAP_TRUSTED_VF			BIT_ULL(11)
 	#define BNXT_FW_CAP_ERROR_RECOVERY		BIT_ULL(13)
@@ -2523,6 +2524,8 @@ struct bnxt {
 #define BNXT_SUPPORTS_MULTI_RSS_CTX(bp)				\
 	(BNXT_PF(bp) && BNXT_SUPPORTS_NTUPLE_VNIC(bp) &&	\
 	 ((bp)->rss_cap & BNXT_RSS_CAP_MULTI_RSS_CTX))
+#define BNXT_ROCE_VF_DYN_ALLOC_CAP(bp)				\
+	((bp)->fw_cap & BNXT_FW_CAP_ROCE_VF_DYN_ALLOC_SUPPORT)
 #define BNXT_SUPPORTS_QUEUE_API(bp)				\
 	(BNXT_PF(bp) && BNXT_SUPPORTS_NTUPLE_VNIC(bp) &&	\
 	 ((bp)->fw_cap & BNXT_FW_CAP_VNIC_RE_FLUSH))
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c
index e7fbfeb1a387..1d8df44c3f9e 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c
@@ -541,6 +541,13 @@ static void bnxt_hwrm_roce_sriov_cfg(struct bnxt *bp, int num_vfs)
 	if (rc)
 		goto err;
 
+	/* In case of VF Dynamic resource allocation, driver will provision
+	 * maximum resources to all the VFs. FW will dynamically allocate
+	 * resources to VFs on the fly, so always divide the resources by 1.
+	 */
+	if (BNXT_ROCE_VF_DYN_ALLOC_CAP(bp))
+		num_vfs = 1;
+
 	cfg_req->fid = cpu_to_le16(0xffff);
 	cfg_req->enables2 =
 		cpu_to_le32(FUNC_CFG_REQ_ENABLES2_ROCE_MAX_AV_PER_VF |
-- 
2.51.0


