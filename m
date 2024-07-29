Return-Path: <netdev+bounces-113799-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E119693FFDB
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 22:55:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D40301C222E3
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 20:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 636E018A929;
	Mon, 29 Jul 2024 20:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="g1kX8jsp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5995187340
	for <netdev@vger.kernel.org>; Mon, 29 Jul 2024 20:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722286505; cv=none; b=Nkcy5IVPukyQD7xfsoms7Euow8hU3mtWR13haongskz74FYGQ+MEWpXh6kQy205unlVHovaU5noMYK6IcjvJ6xlCXxEmhM3u7YgIyUqYGs40UVGdJR0gC6E4h8W3krJhtlQc572Ef8kEEXlM+RfXx+n/VZFRyWaOyMt6ntZqyLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722286505; c=relaxed/simple;
	bh=njAFNXJsfUYFaB+VBT6wnCyzH3fTeOuq1UsainPA5kY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jRXYCnCJK0zvuKEMWYf3ns7u1qyaGYP85xkuodNXPX8jy+NkwH19kzFwMyTHiym6TL6gjfpgAMGyDxsDKoXIVlRoRqbokBl5u+qhXPpQYMd6FXd5xcsmI78r4KzTq43FixXMT+tsKlHTgczaQckUoYeiUfcLRZ3fcHUADpe0XSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=g1kX8jsp; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1fc66fc35f2so22340535ad.0
        for <netdev@vger.kernel.org>; Mon, 29 Jul 2024 13:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1722286503; x=1722891303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jnk+SMTSXQ40ifu0bfZWKBaTUwAwdWcatWhxD6djG3I=;
        b=g1kX8jspV1+lT4/y2su1gFwAeNzhqijyCmAypX2IvDITq2z3SV7j6S+bDTs7v6W3tb
         E+1g9SKo1ZzS7xI2egpRTG497tmFbGN+vynrJLw96ewliqwdzf2sMLSDOFzql4UsjCAg
         k012hl3LbIRpM5PXtbbExMGNpXZQo2E8I3HC/YTyaKqV8mbqNNhgCjTkBwR3wab+bSjZ
         SZIfBOrb1qSelkqg7MecCBLGToPhvECplKtodE928BmAqqQu5rLNWdbqWBv87VHOrH17
         HmkIb5X9kek75cVKtNdid9daWarNZfUEbK158Mg2BzshHjUqbqt+VdQ95lQekkOjwQ6M
         IAYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722286503; x=1722891303;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jnk+SMTSXQ40ifu0bfZWKBaTUwAwdWcatWhxD6djG3I=;
        b=EK+GbMHlw6M1lChngLh0oLN68rMFtgg/uHl4SSVgdXtc8ZYlCuP3AoVYhehwT35Quf
         ghrZ3tJsuRSwwg9XdLgIkU5+ZlhE2BQ451abTa3eMBiKj8zkHhccvdO6ZPogAFd0N7FE
         7QLm+6fBuTWN10qS+N95f0by8Y2GQcuZW7WGHM9vA6tWIKxJEBxQMeOqhrOYVjIyztIV
         0y8PpaaXfHPUp2rwsrh61Wt9fRz46ErH6Uh64KzSf1KC0clr0KKjRdaRTkPdsKhQDM0g
         jBjItcwyvSIcAU24p5R1dGLwOWUOZ9mrs+Z13OpuVFh4hHc6satVRcrbGWjSr3TicioY
         pMvQ==
X-Gm-Message-State: AOJu0YxuA8Qlv04KWdI/OkbAMENh669Es9huO5KIOPxd/tScMIaq0x2C
	4cPSPcbuL5yLswyAYFszwEh6VuMnmX19aEUYdkPJcA3Qp4YJ/gGk3KdmQfkeC75kOQIcF99Oh13
	fLkM=
X-Google-Smtp-Source: AGHT+IF/tcZZp2PiooKEWoOlP5vRAmeTMY/bL0gv3+F4cSrQtJixxJbZ9QT+hZrD9au4tvOqXKjNZg==
X-Received: by 2002:a17:903:2441:b0:1fd:70a6:ffbf with SMTP id d9443c01a7336-1ff04a23875mr141649295ad.2.1722286502753;
        Mon, 29 Jul 2024 13:55:02 -0700 (PDT)
Received: from localhost (fwdproxy-prn-000.fbsv.net. [2a03:2880:ff::face:b00c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7ee82bdsm87688195ad.141.2024.07.29.13.55.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 13:55:02 -0700 (PDT)
From: David Wei <dw@davidwei.uk>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Michael Chan <michael.chan@broadcom.com>
Subject: [PATCH net-next v1 1/3] bnxt_en: Add support to call FW to update a VNIC
Date: Mon, 29 Jul 2024 13:54:57 -0700
Message-ID: <20240729205459.2583533-2-dw@davidwei.uk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240729205459.2583533-1-dw@davidwei.uk>
References: <20240729205459.2583533-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Chan <michael.chan@broadcom.com>

Add the HWRM_VNIC_UPDATE message structures and the function to
send the message to firmware.  This message can be used when
disabling and enabling a receive ring within a VNIC.  The mru
which is the maximum receive size of packets received by the
VNIC can be updated.

Signed-off-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: David Wei <dw@davidwei.uk>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 23 +++++++++++-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  3 ++
 drivers/net/ethernet/broadcom/bnxt/bnxt_hsi.h | 37 +++++++++++++++++++
 3 files changed, 62 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index ffa74c26ee53..8822d7a17fbf 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -6579,7 +6579,8 @@ int bnxt_hwrm_vnic_cfg(struct bnxt *bp, struct bnxt_vnic_info *vnic)
 	req->dflt_ring_grp = cpu_to_le16(bp->grp_info[grp_idx].fw_grp_id);
 	req->lb_rule = cpu_to_le16(0xffff);
 vnic_mru:
-	req->mru = cpu_to_le16(bp->dev->mtu + ETH_HLEN + VLAN_HLEN);
+	vnic->mru = bp->dev->mtu + ETH_HLEN + VLAN_HLEN;
+	req->mru = cpu_to_le16(vnic->mru);
 
 	req->vnic_id = cpu_to_le16(vnic->fw_vnic_id);
 #ifdef CONFIG_BNXT_SRIOV
@@ -10086,6 +10087,26 @@ static int __bnxt_setup_vnic(struct bnxt *bp, struct bnxt_vnic_info *vnic)
 	return rc;
 }
 
+int bnxt_hwrm_vnic_update(struct bnxt *bp, struct bnxt_vnic_info *vnic,
+			  u8 valid)
+{
+	struct hwrm_vnic_update_input *req;
+	int rc;
+
+	rc = hwrm_req_init(bp, req, HWRM_VNIC_UPDATE);
+	if (rc)
+		return rc;
+
+	req->vnic_id = cpu_to_le32(vnic->fw_vnic_id);
+
+	if (valid & VNIC_UPDATE_REQ_ENABLES_MRU_VALID)
+		req->mru = cpu_to_le16(vnic->mru);
+
+	req->enables = cpu_to_le32(valid);
+
+	return hwrm_req_send(bp, req);
+}
+
 int bnxt_hwrm_vnic_rss_cfg_p5(struct bnxt *bp, struct bnxt_vnic_info *vnic)
 {
 	int rc;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 6bbdc718c3a7..5de67f718993 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -1250,6 +1250,7 @@ struct bnxt_vnic_info {
 #define BNXT_MAX_CTX_PER_VNIC	8
 	u16		fw_rss_cos_lb_ctx[BNXT_MAX_CTX_PER_VNIC];
 	u16		fw_l2_ctx_id;
+	u16		mru;
 #define BNXT_MAX_UC_ADDRS	4
 	struct bnxt_l2_filter *l2_filters[BNXT_MAX_UC_ADDRS];
 				/* index 0 always dev_addr */
@@ -2838,6 +2839,8 @@ int bnxt_hwrm_free_wol_fltr(struct bnxt *bp);
 int bnxt_hwrm_func_resc_qcaps(struct bnxt *bp, bool all);
 int bnxt_hwrm_func_qcaps(struct bnxt *bp);
 int bnxt_hwrm_fw_set_time(struct bnxt *);
+int bnxt_hwrm_vnic_update(struct bnxt *bp, struct bnxt_vnic_info *vnic,
+			  u8 valid);
 int bnxt_hwrm_vnic_rss_cfg_p5(struct bnxt *bp, struct bnxt_vnic_info *vnic);
 int __bnxt_setup_vnic_p5(struct bnxt *bp, struct bnxt_vnic_info *vnic);
 void bnxt_del_one_rss_ctx(struct bnxt *bp, struct bnxt_rss_ctx *rss_ctx,
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_hsi.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_hsi.h
index f219709f9563..933f48a62586 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_hsi.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_hsi.h
@@ -6510,6 +6510,43 @@ struct hwrm_vnic_alloc_output {
 	u8	valid;
 };
 
+/* hwrm_vnic_update_input (size:256b/32B) */
+struct hwrm_vnic_update_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le32	vnic_id;
+	__le32	enables;
+	#define VNIC_UPDATE_REQ_ENABLES_VNIC_STATE_VALID               0x1UL
+	#define VNIC_UPDATE_REQ_ENABLES_MRU_VALID                      0x2UL
+	#define VNIC_UPDATE_REQ_ENABLES_METADATA_FORMAT_TYPE_VALID     0x4UL
+	u8	vnic_state;
+	#define VNIC_UPDATE_REQ_VNIC_STATE_NORMAL 0x0UL
+	#define VNIC_UPDATE_REQ_VNIC_STATE_DROP   0x1UL
+	#define VNIC_UPDATE_REQ_VNIC_STATE_LAST  VNIC_UPDATE_REQ_VNIC_STATE_DROP
+	u8	metadata_format_type;
+	#define VNIC_UPDATE_REQ_METADATA_FORMAT_TYPE_0 0x0UL
+	#define VNIC_UPDATE_REQ_METADATA_FORMAT_TYPE_1 0x1UL
+	#define VNIC_UPDATE_REQ_METADATA_FORMAT_TYPE_2 0x2UL
+	#define VNIC_UPDATE_REQ_METADATA_FORMAT_TYPE_3 0x3UL
+	#define VNIC_UPDATE_REQ_METADATA_FORMAT_TYPE_4 0x4UL
+	#define VNIC_UPDATE_REQ_METADATA_FORMAT_TYPE_LAST VNIC_UPDATE_REQ_METADATA_FORMAT_TYPE_4
+	__le16	mru;
+	u8	unused_1[4];
+};
+
+/* hwrm_vnic_update_output (size:128b/16B) */
+struct hwrm_vnic_update_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	u8	unused_0[7];
+	u8	valid;
+};
+
 /* hwrm_vnic_free_input (size:192b/24B) */
 struct hwrm_vnic_free_input {
 	__le16	req_type;
-- 
2.43.0


