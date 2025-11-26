Return-Path: <netdev+bounces-242086-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD002C8C224
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 22:58:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74FAB3B749B
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 21:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 246A2342CA9;
	Wed, 26 Nov 2025 21:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="eYQS27gn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D23C3191DE
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 21:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764194273; cv=none; b=O10dQJZCJ+WYUK1dDTydmem7e5dc/k7nykAUjrJQ0QW3xcaO8A2MxDz3Bq4GCc6aAMMil6ArYw8FoDzEqJGdC0xf/qHwZHeonWjbGDMVFeU3RLCWXsQtBAuLS65FCArMZRYhX/lxLgVbmMiyiga/BcuC+M8dn5aRbbAbmJ2+Tcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764194273; c=relaxed/simple;
	bh=GPH03bIeHYSzWCELXbJhbrdJksAjIMUxZ1bY5y5gsP0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JCK0Vl3lYcth0qwrQn0S87FAtAP6MRjIDoTUiDnIUktrMUMMXFYXLWUX8zrQFWEQqUo4Nz9kvcD6wNgl9uOJNgF9Tt9mV6SDZcjhCMkp2B/rhKdEa3I+vxoJVsvID2knsxsDUfLrE04z2bNCzdASo15tdFTW0GClKeaFzjruw6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=eYQS27gn; arc=none smtp.client-ip=209.85.214.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-2955623e6faso2548185ad.1
        for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 13:57:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764194271; x=1764799071;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q/9SV1d4eUYlA865MGpAeeL132A5YjzbKHccEQAg4H4=;
        b=vnbDBX8T2D1eMvAlBui+tbJvOIbB+fbA0EPX4PD3F/1LDg8HQpYcyjsCjsofovmV2h
         QPO7IAUqpu6txZnTjP8N2gtPoz+Zs02q8dB1PGGboJ5DoPeR8EayLJErwH7hqvoS2AXS
         P3draxb4VxDe5nsgrOibbG4oj951Xyo+S63GGsN110bwAmQu0rMn+oQWR9Z7pEnz4O6x
         XuRozJwmQTHbE/W3u7aCbJMXqPHVk4Pv2UySjK512i+i6n0gCVMXjqsdbWf8dQI7L5LO
         q6IwJ2lDNK9b6yO2gn/oeJlHS/tGqQSMSt2PZfwR9D3yExoXZ1RXFS9TTu0G2aoZPyVg
         900A==
X-Gm-Message-State: AOJu0YxYLVCuxsU3IhuVeLzLpOrMW3uaRZJjY6OoHpuPdSpTefsKDlfa
	c4YAkugYTgLZ69mLjJx3xwSUAjwOOHsPMXLLctSnrRA44+8RF+WvTotbfmfO2mZ7/7G33PVOA/S
	qGfqclTANS9CLTJ+94l83eDaeFgbEzEq2P6lsulOFdfjPurdjfUOsPEPW/PgArHAKhmXP6j3vGh
	eve/bOcjcZJ41uVRIV0mERNyI+VIrEs8/vycgXFdSl79Kg40b7RwjV788eKKrK3fsWRt/wTo3XQ
	PTCVCO88/s=
X-Gm-Gg: ASbGncsnm4uVb04bTbZDzry/Q3VwiADjqIveCFzwM+eu7CNJXaJ0ENb8j6o46hmNJKL
	9UYmsBUvQBLwkNXwJBnz+9mMJqw5O4dTuLUnt3z0SAbMhg7SNh+epwT/4U/3uJnT6+xirAuQtPv
	FnLkpBm4LXaQtvWXpF50IwZ6ZFgRZYrFsNOc6Xv5cY2FFaSDepfUyg9tN2MLdxj/EgeL/LYn2+x
	Kdt2e8J8i5PSTE4ZZ/o2+D8WUQC7UrHxisufJCLo+pVVZc+j2KPFAvG1Mhni6af5N8rRTizYD80
	oVJMCn0LULYZI24tM6rwiDw5dIP3TXi6aO+I9zKJnni44zJ1UGAdFt/JNaji6RHVVSF43MMu61p
	Hqu7tYXsDyN5HqPfaJnPDB68WC1KHo5twNlD7df9wGycuuglWyDz0E7cHoaZRkl7PYCH7DVRFWc
	uKqargLSqsmxCdQY3hP8w8FPAwJrgZHmFk42kTRexiTjNf
X-Google-Smtp-Source: AGHT+IFMrpYJpfklWyh6BhB2mZMGtdw7YAA5hGffAgQvfH3bKqspp/BBWA5d4c6rsD1UM4zA8GR/eEDEb2Ke
X-Received: by 2002:a17:902:f645:b0:298:4f73:d872 with SMTP id d9443c01a7336-29baaf9b077mr89630525ad.21.1764194270763;
        Wed, 26 Nov 2025 13:57:50 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-11.dlp.protect.broadcom.com. [144.49.247.11])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-29b5b219fdfsm24560595ad.45.2025.11.26.13.57.50
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Nov 2025 13:57:50 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8a1c15daa69so57928885a.1
        for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 13:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1764194269; x=1764799069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q/9SV1d4eUYlA865MGpAeeL132A5YjzbKHccEQAg4H4=;
        b=eYQS27gnDyrcWQuKr/1ndi+/VBXcqjeNOz1Pb9VfzpBHVnlbAlLTel5ynillsjjiXk
         vOkNkSU6QJhVZ7TAsNWIPsEcqkZX6zF0w4vjx8AdmGJRFdb4CNqEIfEeOeaUIIZMo0yU
         Ws1p/Dg+h1NQWXGvOr3HoyDA6beFbFngiopcs=
X-Received: by 2002:a05:620a:4116:b0:8b2:f182:6941 with SMTP id af79cd13be357-8b4ebdae82cmr1090557785a.57.1764194269401;
        Wed, 26 Nov 2025 13:57:49 -0800 (PST)
X-Received: by 2002:a05:620a:4116:b0:8b2:f182:6941 with SMTP id af79cd13be357-8b4ebdae82cmr1090555585a.57.1764194268986;
        Wed, 26 Nov 2025 13:57:48 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b3295db58fsm1473933185a.37.2025.11.26.13.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 13:57:48 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	Rob Miller <rmiller@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Subject: [PATCH net-next 6/7] bnxt_en: Add Virtual Admin Link State Support for VFs
Date: Wed, 26 Nov 2025 13:56:47 -0800
Message-ID: <20251126215648.1885936-7-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.45.4
In-Reply-To: <20251126215648.1885936-1-michael.chan@broadcom.com>
References: <20251126215648.1885936-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: Rob Miller <rmiller@broadcom.com>

The firmware can now cache the virtual link admin state (auto/on/off) of
all VFs and as such, the PF driver no longer has to intercept the VF
driver's port_phy_qcfg() call and then provide the link admin state.

If the FW does not have this capability, fall back to the existing
interception method.

The initial default link admin state (auto) is also set initially when
the VFs are created.

Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Reviewed-by: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Signed-off-by: Rob Miller <rmiller@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  6 ++
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  1 +
 .../net/ethernet/broadcom/bnxt/bnxt_sriov.c   | 55 +++++++++++++++++--
 3 files changed, 57 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 4222e1bd172a..1dddd388d2d6 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -5695,6 +5695,10 @@ int bnxt_hwrm_func_drv_rgtr(struct bnxt *bp, unsigned long *bmap, int bmap_size,
 			u16 cmd = bnxt_vf_req_snif[i];
 			unsigned int bit, idx;
 
+			if ((bp->fw_cap & BNXT_FW_CAP_LINK_ADMIN) &&
+			    cmd == HWRM_PORT_PHY_QCFG)
+				continue;
+
 			idx = cmd / 32;
 			bit = cmd % 32;
 			data[idx] |= 1 << bit;
@@ -9665,6 +9669,8 @@ static int __bnxt_hwrm_func_qcaps(struct bnxt *bp)
 		bp->flags |= BNXT_FLAG_ROCEV1_CAP;
 	if (flags & FUNC_QCAPS_RESP_FLAGS_ROCE_V2_SUPPORTED)
 		bp->flags |= BNXT_FLAG_ROCEV2_CAP;
+	if (flags & FUNC_QCAPS_RESP_FLAGS_LINK_ADMIN_STATUS_SUPPORTED)
+		bp->fw_cap |= BNXT_FW_CAP_LINK_ADMIN;
 	if (flags & FUNC_QCAPS_RESP_FLAGS_PCIE_STATS_SUPPORTED)
 		bp->fw_cap |= BNXT_FW_CAP_PCIE_STATS_SUPPORTED;
 	if (flags & FUNC_QCAPS_RESP_FLAGS_HOT_RESET_CAPABLE)
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index bb12cebd40e1..f5f07a7e6b29 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2484,6 +2484,7 @@ struct bnxt {
 	#define BNXT_FW_CAP_ROCE_VF_RESC_MGMT_SUPPORTED	BIT_ULL(6)
 	#define BNXT_FW_CAP_KONG_MB_CHNL		BIT_ULL(7)
 	#define BNXT_FW_CAP_ROCE_VF_DYN_ALLOC_SUPPORT	BIT_ULL(8)
+	#define BNXT_FW_CAP_LINK_ADMIN			BIT_ULL(9)
 	#define BNXT_FW_CAP_OVS_64BIT_HANDLE		BIT_ULL(10)
 	#define BNXT_FW_CAP_TRUSTED_VF			BIT_ULL(11)
 	#define BNXT_FW_CAP_ERROR_RECOVERY		BIT_ULL(13)
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c
index 80fed2c07b9e..be7deb9cc410 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c
@@ -332,6 +332,38 @@ int bnxt_set_vf_bw(struct net_device *dev, int vf_id, int min_tx_rate,
 	return rc;
 }
 
+static int bnxt_set_vf_link_admin_state(struct bnxt *bp, int vf_id)
+{
+	struct hwrm_func_cfg_input *req;
+	struct bnxt_vf_info *vf;
+	int rc;
+
+	if (!(bp->fw_cap & BNXT_FW_CAP_LINK_ADMIN))
+		return 0;
+
+	vf = &bp->pf.vf[vf_id];
+
+	rc = bnxt_hwrm_func_cfg_short_req_init(bp, &req);
+	if (rc)
+		return rc;
+
+	req->fid = cpu_to_le16(vf->fw_fid);
+	switch (vf->flags & (BNXT_VF_LINK_FORCED | BNXT_VF_LINK_UP)) {
+	case BNXT_VF_LINK_FORCED:
+		req->options =
+			FUNC_CFG_REQ_OPTIONS_LINK_ADMIN_STATE_FORCED_DOWN;
+		break;
+	case (BNXT_VF_LINK_FORCED | BNXT_VF_LINK_UP):
+		req->options = FUNC_CFG_REQ_OPTIONS_LINK_ADMIN_STATE_FORCED_UP;
+		break;
+	default:
+		req->options = FUNC_CFG_REQ_OPTIONS_LINK_ADMIN_STATE_AUTO;
+		break;
+	}
+	req->enables = cpu_to_le32(FUNC_CFG_REQ_ENABLES_ADMIN_LINK_STATE);
+	return hwrm_req_send(bp, req);
+}
+
 int bnxt_set_vf_link_state(struct net_device *dev, int vf_id, int link)
 {
 	struct bnxt *bp = netdev_priv(dev);
@@ -357,10 +389,11 @@ int bnxt_set_vf_link_state(struct net_device *dev, int vf_id, int link)
 		break;
 	default:
 		netdev_err(bp->dev, "Invalid link option\n");
-		rc = -EINVAL;
-		break;
+		return -EINVAL;
 	}
-	if (vf->flags & (BNXT_VF_LINK_UP | BNXT_VF_LINK_FORCED))
+	if (bp->fw_cap & BNXT_FW_CAP_LINK_ADMIN)
+		rc = bnxt_set_vf_link_admin_state(bp, vf_id);
+	else if (vf->flags & (BNXT_VF_LINK_UP | BNXT_VF_LINK_FORCED))
 		rc = bnxt_hwrm_fwd_async_event_cmpl(bp, vf,
 			ASYNC_EVENT_CMPL_EVENT_ID_LINK_STATUS_CHANGE);
 	return rc;
@@ -666,15 +699,21 @@ static int bnxt_hwrm_func_vf_resc_cfg(struct bnxt *bp, int num_vfs, bool reset)
 
 	hwrm_req_hold(bp, req);
 	for (i = 0; i < num_vfs; i++) {
+		struct bnxt_vf_info *vf = &pf->vf[i];
+
+		vf->fw_fid = pf->first_vf_id + i;
+		rc = bnxt_set_vf_link_admin_state(bp, i);
+		if (rc)
+			break;
+
 		if (reset)
 			__bnxt_set_vf_params(bp, i);
 
-		req->vf_id = cpu_to_le16(pf->first_vf_id + i);
+		req->vf_id = cpu_to_le16(vf->fw_fid);
 		rc = hwrm_req_send(bp, req);
 		if (rc)
 			break;
 		pf->active_vfs = i + 1;
-		pf->vf[i].fw_fid = pf->first_vf_id + i;
 	}
 
 	if (pf->active_vfs) {
@@ -741,6 +780,12 @@ static int bnxt_hwrm_func_cfg(struct bnxt *bp, int num_vfs)
 				   FUNC_CFG_REQ_ENABLES_NUM_VNICS |
 				   FUNC_CFG_REQ_ENABLES_NUM_HW_RING_GRPS);
 
+	if (bp->fw_cap & BNXT_FW_CAP_LINK_ADMIN) {
+		req->options = FUNC_CFG_REQ_OPTIONS_LINK_ADMIN_STATE_AUTO;
+		req->enables |=
+			cpu_to_le32(FUNC_CFG_REQ_ENABLES_ADMIN_LINK_STATE);
+	}
+
 	mtu = bp->dev->mtu + VLAN_ETH_HLEN;
 	req->mru = cpu_to_le16(mtu);
 	req->admin_mtu = cpu_to_le16(mtu);
-- 
2.51.0


