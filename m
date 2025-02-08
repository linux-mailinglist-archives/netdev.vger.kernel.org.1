Return-Path: <netdev+bounces-164366-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BFA5A2D899
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 21:30:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4E971888A56
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 20:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 688101B415B;
	Sat,  8 Feb 2025 20:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="CyCFTUw4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F3419DF6A
	for <netdev@vger.kernel.org>; Sat,  8 Feb 2025 20:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739046599; cv=none; b=flXUvRMZoffp/r00hbee746dOOjuk7e4KFtGy+MyD8/GPJXWNZCVUa2CiWR4E/gPcFnaDwT2y7XXGgiCTml99skPwelNVqOoB5byneC+0CXvqAKvdLFOJ5rdvznqxyt9HDOaLfaAzFQ7Mdm9KE3aO/QhyXrEk0RSrVuWmEc+38s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739046599; c=relaxed/simple;
	bh=IkC5DrSpwBzYVtxuuXtzRppK51yx82yjGQY9KwH7jcs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mWXVqj3YQfw+A4f1W5ZagLN2Le+MORfbP2t1empu4B8E2XwVSO1qPyTn2kdDVLd30Fi1t+x1iDhtcR+1MBKw/14NatxUkdXJkAwMxKSOUIiPm16vSvU0aNPfvQc7LLIxeaD1f2uSJRh0avVdh3648ktq6fiup23aa4cLFJXST1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=CyCFTUw4; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-726d2529db4so95910a34.2
        for <netdev@vger.kernel.org>; Sat, 08 Feb 2025 12:29:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1739046597; x=1739651397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xs0HqGMlTz4yprx8RCINcEsYohiRoMzfTFTjyXVzrPs=;
        b=CyCFTUw4pWqsY/rrTt73mocd9CFoDkaKbkBcACUZG4OeaUvPwkBmzn8jQq/1jGwqEH
         XoCcVG9D9NFtU0ZZFfcbJ+ZgFH3aJG+wb6gChHl1pV0BiZRR7L7SK4aWqFTcODdK2Hod
         kt6IzTigsD3pkHuJinSc9tE+m9q5m5V1kMm6g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739046597; x=1739651397;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xs0HqGMlTz4yprx8RCINcEsYohiRoMzfTFTjyXVzrPs=;
        b=fUJDBWUJJU6MvVbEJIz9PB5uKrF6ZYQlimD4gydqc/KBUapbnNuEwnv329Arq9Hwta
         C98OwEKm9ELnbJoY9EX10dyVCyjbfi5zvbdFdZrcZ1uwyZhPb2HJPspf6IuTbe3K28Zp
         HYAePRzqoMoypRnkxZH1kD1Nur1T5niApvnsSPx35I9mDrecgd16Fc0uigFNqwjSBsrv
         wXy8bn/aAym0kTWinwYUTNBtxI8HKuOn8EMoUzPPK8u+QQMhTGpAxtTwBgEkC0JXJem6
         70zO8hDOncH8NfxORyxiuo4YFwSaQvgVs5SzCP8FzwXz1JyMD8l5nR8Ka2QmUnMhLFx4
         mH1w==
X-Gm-Message-State: AOJu0YzQW95olMnh6G9MnDFRrxO6CMN2iOnHONwXtIDSJUdnbAulo5ti
	J1AEJ6ofdEgehWl8wNS8vl8v8Z1TYcrqq6Ojgkqo/BZkI4nFkiUqD6NrnI4Gkw==
X-Gm-Gg: ASbGncutVTwoes4LPr5QqdIepYr+6Ouwd3D15RiNCaFubb9MuJiIwK1y50AvsvZYD+4
	/Z95dGVeKm9ASlX+8f8/z2g3FNVcCZHJo7ZKyMeq2fwdZ/EOWHZXsYdOlbruof9035+SDoSyiz1
	M2VLmNQT++E26SjR+NslKusd2DppLl/pEUjJy5dFc3sgEK5p9GfPJ8dBGMatIoptCcdUmENgLi8
	fH/E4UV9VbmnH+Aa5xssY00blrftNe3n9jHmWyILNLGhuMVhSiO8XdnsKkLUqLWttVfoi6rMPG5
	z4ftbZkuqRH/vM7axLkTPD0mq9BVnEDJCUVfA+nf6cDRp4Lxu1mq1qKIE4Nx69ORzfk=
X-Google-Smtp-Source: AGHT+IG2sNlgC4BsPKPUfKriHNFQU5OLYQQIWLQnxHPCEmYFj5QkkThr/4aldq4t1yOQPnYDYpSj6A==
X-Received: by 2002:a05:6830:6990:b0:71e:1ca5:fc93 with SMTP id 46e09a7af769-726b87ffe2amr5350716a34.16.1739046596729;
        Sat, 08 Feb 2025 12:29:56 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-726af932f78sm1564130a34.18.2025.02.08.12.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Feb 2025 12:29:55 -0800 (PST)
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
	Somnath Kotur <somnath.kotur@broadcom.com>
Subject: [PATCH net-next v4 01/10] bnxt_en: Set NPAR 1.2 support when registering with firmware
Date: Sat,  8 Feb 2025 12:29:07 -0800
Message-ID: <20250208202916.1391614-2-michael.chan@broadcom.com>
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

NPAR (Network interface card partitioning)[1] 1.2 adds a transparent
VLAN tag for all packets between the NIC and the switch.  Because of
that, RX VLAN acceleration cannot be supported for any additional
host configured VLANs.  The driver has to acknowledge that it can
support no RX VLAN acceleration and set the NPAR 1.2 supported flag
when registering with the FW.  Otherwise, the FW call will fail and
the driver will abort on these NPAR 1.2 NICs with this error:

bnxt_en 0000:26:00.0 (unnamed net_device) (uninitialized): hwrm req_type 0x1d seq id 0xb error 0x2

[1] https://techdocs.broadcom.com/us/en/storage-and-ethernet-connectivity/ethernet-nic-controllers/bcm957xxx/adapters/introduction/features/network-partitioning-npar.html

Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
v4: Fix typo in NPAR and improve the description of NPAR
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 5 +++++
 drivers/net/ethernet/broadcom/bnxt/bnxt.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 7b8b5b39c7bb..fc870c104c56 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -5565,6 +5565,8 @@ int bnxt_hwrm_func_drv_rgtr(struct bnxt *bp, unsigned long *bmap, int bmap_size,
 	if (bp->fw_cap & BNXT_FW_CAP_ERROR_RECOVERY)
 		flags |= FUNC_DRV_RGTR_REQ_FLAGS_ERROR_RECOVERY_SUPPORT |
 			 FUNC_DRV_RGTR_REQ_FLAGS_MASTER_SUPPORT;
+	if (bp->fw_cap & BNXT_FW_CAP_NPAR_1_2)
+		flags |= FUNC_DRV_RGTR_REQ_FLAGS_NPAR_1_2_SUPPORT;
 	req->flags = cpu_to_le32(flags);
 	req->ver_maj_8b = DRV_VER_MAJ;
 	req->ver_min_8b = DRV_VER_MIN;
@@ -8365,6 +8367,7 @@ static int bnxt_hwrm_func_qcfg(struct bnxt *bp)
 
 	switch (resp->port_partition_type) {
 	case FUNC_QCFG_RESP_PORT_PARTITION_TYPE_NPAR1_0:
+	case FUNC_QCFG_RESP_PORT_PARTITION_TYPE_NPAR1_2:
 	case FUNC_QCFG_RESP_PORT_PARTITION_TYPE_NPAR1_5:
 	case FUNC_QCFG_RESP_PORT_PARTITION_TYPE_NPAR2_0:
 		bp->port_partition_type = resp->port_partition_type;
@@ -9529,6 +9532,8 @@ static int __bnxt_hwrm_func_qcaps(struct bnxt *bp)
 		bp->fw_cap |= BNXT_FW_CAP_HOT_RESET_IF;
 	if (BNXT_PF(bp) && (flags_ext & FUNC_QCAPS_RESP_FLAGS_EXT_FW_LIVEPATCH_SUPPORTED))
 		bp->fw_cap |= BNXT_FW_CAP_LIVEPATCH;
+	if (flags_ext & FUNC_QCAPS_RESP_FLAGS_EXT_NPAR_1_2_SUPPORTED)
+		bp->fw_cap |= BNXT_FW_CAP_NPAR_1_2;
 	if (BNXT_PF(bp) && (flags_ext & FUNC_QCAPS_RESP_FLAGS_EXT_DFLT_VLAN_TPID_PCP_SUPPORTED))
 		bp->fw_cap |= BNXT_FW_CAP_DFLT_VLAN_TPID_PCP;
 	if (flags_ext & FUNC_QCAPS_RESP_FLAGS_EXT_BS_V2_SUPPORTED)
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 2373f423a523..db0be469a3db 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2492,6 +2492,7 @@ struct bnxt {
 	#define BNXT_FW_CAP_CFA_RFS_RING_TBL_IDX_V3	BIT_ULL(39)
 	#define BNXT_FW_CAP_VNIC_RE_FLUSH		BIT_ULL(40)
 	#define BNXT_FW_CAP_SW_MAX_RESOURCE_LIMITS	BIT_ULL(41)
+	#define BNXT_FW_CAP_NPAR_1_2			BIT_ULL(42)
 
 	u32			fw_dbg_cap;
 
-- 
2.30.1


