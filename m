Return-Path: <netdev+bounces-162319-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A58A268D4
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 01:47:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDDEA1653F8
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 00:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C987A44C7C;
	Tue,  4 Feb 2025 00:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="aKZGXPKM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A553595F
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 00:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738630016; cv=none; b=MC6UalCpnyP9LOfZZMjKPD0iI6NSpWbEd1cN99XOptU9mN05yym/13035D5RPu+qeKZSUn4ZFZuHuILd2uEnqmR+b8zof1bAFdxEYY5u1slw3/mm1T6TknIPBm+0CiwKPMOs4g8ooIUQuVBDHuh+dv+cCUwORujke01WQhcUP4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738630016; c=relaxed/simple;
	bh=2TzJv3NPlu6glGKQXYjge74s/OPrekfgxoNp7rPp0NI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U4LXKopYDajz3DQEmflt3gbs6VtLI9HUpZdBOazpqv9LR25d4N1i4k2MIN+jh6u95jXnj0wWSewQjREkwUd+ZL87T0vGliq19hsQE76pvKI3M0xQb409zEX1cU9+IfD8pfvTqFkGwG++tYp72DiyYtY7nvTT/P3+RlyWwVshmww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=aKZGXPKM; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3eba347aa6fso3176991b6e.3
        for <netdev@vger.kernel.org>; Mon, 03 Feb 2025 16:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1738630014; x=1739234814; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VmgR7XT9VFi5hUoCLKVmytsTHVEL8AAwrRwMK9vaEzo=;
        b=aKZGXPKMTIrr/XsUueydug46JFiDQ2XsaLXcywli98LJZZko85bnmAgym2trmkvBqp
         v/glRZTmgwGoJrfJeJTDbOltARjscrLYRArJHknvHzGEVDt5y1I3+T+Qrhalg/xp/uSe
         +n83X/YuKV2kuhyLss7dfcM9r0ZFLN9j3d+m0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738630014; x=1739234814;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VmgR7XT9VFi5hUoCLKVmytsTHVEL8AAwrRwMK9vaEzo=;
        b=qHQ2Y7V6eimvWABkcflhwKvYpKh4Tui5YAGuxQCq4fP4sl5vDuNf2BNld06JVfm00q
         9d6Lmwdu73ox6Q0zh5cx+bUvO/LI4JKkLLnsTOwHGwIygUPAwEiZiW6dbyCbMpw+sQDG
         zAS27qfAFnk8f7zzJ8LuiUkZ99VNdw6Jd1kDOMlLjx04BkspLeSpdKg0oftPNH23fdMj
         NcldHVb2tgG8Dim9N828soqBg5mlB7rsvIJuMwtjOC1KgghVx7Lfm5wC7YoTR24A/g3m
         sKcfM5Z2VozWsk+coa2TkDRY7JMREVTPydTaCB1g1/A4UIZP+jQhWdSohIrr/10VzTU3
         t16w==
X-Gm-Message-State: AOJu0YwYZPo54hId7CyKUpven1Lry9k8X0G7FDV4uyOs5H6yjsB+iy+j
	9kYvrXARttvP3IxjXZ2JE9rzg+IopsIF+JqgIkN1BPK/GnbqFyEHHO/GXiI67w==
X-Gm-Gg: ASbGncsZmJr8nENnN/ejp2QR0SkPZQoLXVAH9U3SyoWFl1YmXVreVtK7Y4Y52mvIdsJ
	uj/3/yjhIPz4cJs0X/gj46uO92+axWxfSeE1xcy6OieTzoo5GojJ2nSbiNxBZ6EGajCs4+yX709
	3NOc7To3nA4pmQeA6hYpS3jp1MfqhctmMCuCj/9wmqBNBTCjUMfzVdhUOHk1EiX1p68G58hgL4X
	eBptvBtJL7YF/CotOTGluuQBVyvR4GyX82QnAIB9inG5Vr3l1SDHg3ztvsPsqEJqcboZAifvCyr
	3MKHMnWt3wQqyhFFDE3y62mk7HBIWrsPLHdXklUS2NaEW3+6VnQtN++d6gY77oizdkw=
X-Google-Smtp-Source: AGHT+IHrUWmXnuLbqaJddmBEbgubCahdp4RBYjqUgYNey7oN/tvkPwNOiC135cPGi8krdAGh4u6zsg==
X-Received: by 2002:a05:6871:809:b0:29e:65ed:5c70 with SMTP id 586e51a60fabf-2b32f3706c9mr15899158fac.30.1738630013968;
        Mon, 03 Feb 2025 16:46:53 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2b356658291sm3680495fac.46.2025.02.03.16.46.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 16:46:53 -0800 (PST)
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
Subject: [PATCH net-next v3 01/10] bnxt_en: Set NAPR 1.2 support when registering with firmware
Date: Mon,  3 Feb 2025 16:46:00 -0800
Message-ID: <20250204004609.1107078-2-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
In-Reply-To: <20250204004609.1107078-1-michael.chan@broadcom.com>
References: <20250204004609.1107078-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

NPAR 1.2 adds a transparent VLAN tag for all packets between the NIC
and the switch.  Because of that, RX VLAN acceleration cannot be
supported for any additional host configured VLANs.  The driver has
to acknowledge that it can support no RX VLAN acceleration and
set the NPAR 1.2 supported flag when registering with the FW.
Otherwise, the FW call will fail and the driver will abort on these
NPAR 1.2 NICs with this error:

bnxt_en 0000:26:00.0 (unnamed net_device) (uninitialized): hwrm req_type 0x1d seq id 0xb error 0x2

Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
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


