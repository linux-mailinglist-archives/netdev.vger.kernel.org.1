Return-Path: <netdev+bounces-216805-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07305B3545B
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 08:22:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3F74175C63
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 06:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D38312F83C4;
	Tue, 26 Aug 2025 06:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ZjeAq672"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f228.google.com (mail-qk1-f228.google.com [209.85.222.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD9C2F549B
	for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 06:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756189258; cv=none; b=GweSpYZJu61r0doK1K9FHIHUKKV/2Ud7YS6vtyEYHa5lsJSse9AclAAZ4O5yE7S6Yaz2xW5H+AmRPjQ339QLA/m39wkOPDeBTEgbt43PQvt/8PGxGrhuyWh5Tsc7lbSKMUnfaA3500aQq1heUPYbLrFpAlMzi0tGvf0oMJHM3To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756189258; c=relaxed/simple;
	bh=QeTeAJHCFEm5UTJkIDJ+Ggdpr1gcHI2zuVaOgJNljnY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WMOAsmSjCQ8wkSfNJRY/9e4qp1q8kp2zC62QfHczroHcU9lcyzjnJLEga01/sKHAyXWZys9ryKQkBmEATatkgfhafWBdjLjQGP6P4w2oJMsrAECzDL99Ul7AHiLVrtS1XWmBJTDyogKftGIZxwo2rqF5PbRC6eil55+dbEiIfUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ZjeAq672; arc=none smtp.client-ip=209.85.222.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f228.google.com with SMTP id af79cd13be357-7e8706764d2so714398685a.2
        for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 23:20:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756189256; x=1756794056;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mkme5IBl5KRWoBojbGS0RT/QRiWYZpAh+2JnOlGPjUk=;
        b=Bw5bLeq9N8WnGsDjfYMPWZ8lsi2cFO7vt80B3W3KpG8J+xeK0zkKGorhDJ4K5+YdGl
         1cazCUrPYbrLyIiPBeF4ExO84B1hj0intrzqeYR1S9ehVmHsf1J2yV/37UopzfnU5YsN
         eNUm/U08U1pQwbFyZVD1zraZTeuBN7J5gVEkTT0hErkkT658z6vuR1XJ52eJWK1u7GkV
         DbUb1qc+mR38F6LrhZ+aaMrIIt9HHyhg3OswWcV3GDpBSsPttBky1Di/a8SpdX4ZYpIZ
         t2tM50tF76yigkeNCIV412hDA4/HU4UTCOijfU3sQZN3KYBGAeiT/rzedUjpXrRZCirT
         +a9A==
X-Forwarded-Encrypted: i=1; AJvYcCXl1Kw323uhC74iXbimpIUNfGUmzXrdgnSOfJuUDqKDKx4tC1hiCN+BQexpcg/LA2Dx2EMK6LA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkqJofOGnaBvEBWk6/y3XAze3iLOxLFw3DpUJUIf0pKO5a63df
	sGnJUTALw5eUUTrzNgaf0l6EPGq3HhUW++yTRGg7p/Q5Eqhe89VhRoRau+HJrU4Fg5fRvfcG5dM
	vdP494dQA5JhufvfxCy1IdUbNbGkvmsstMhIHvWzO7EpjxJXmlY0m55CbP/xFbvcP7fi0HJjIUV
	CLF5CE7x1cSaBWgd6OwS2q25TNsyvtRq+LdDANpx+RhTD0xcNnZBSrcxXI7zHe8EICn3GJm6a/3
	G+24t4L+da4Rtw6u4cRa3ji
X-Gm-Gg: ASbGncuVJ1Q2ZS6jsdUb3Ip9yquWQ0PeC+4r/07M09yiCfOHKZTgUPKgXXJOfA3jzHM
	e/FwIv/AcwTGMAgb7KImjYc3CjLKdjVRHWLEBPZJZVtevzt8ivf9+coIHU2dAyKVLx3YzXsn9Dz
	4KgGD8CNP3slouCJbCAFy2FitSW7AWBqWh6AMaPn5C4cW/Z5FDpEJFINx7D/1lEf0A7PAiRt9cw
	1yDTIayh/Bx+fF8M4ula42ASoy+9g3pFFYHPwVJT2LDp886ZO9YDg2KeurCbzDsbpFgvjyBi6/A
	u0o8hy1DFkT5CBzPWCd0/+DldNWpFUybDHQE2Mn8eauk0J1+5PugDOQcgmEdUxQYirMCIzX/YZo
	SoqYsiBtw0kj9jP20aIrowWv4Wi/zf6Bc+F1noWBZ5V6i4NHiaS1XNGpZwuAul7VsXh2YKiJcFw
	0ZOuNeHaEwwUJX
X-Google-Smtp-Source: AGHT+IGHh0csi8CR54JDTcBNpUD6obc49XnQFsVkKbt6CnHTePDVSeCtom9bo+qAYJ1pVzGse8YxqGW8oukp
X-Received: by 2002:a05:620a:7011:b0:7e9:fb3c:572d with SMTP id af79cd13be357-7ea1104aef3mr1410970685a.62.1756189253414;
        Mon, 25 Aug 2025 23:20:53 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-16.dlp.protect.broadcom.com. [144.49.247.16])
        by smtp-relay.gmail.com with ESMTPS id af79cd13be357-7f4ee3c6165sm4338485a.2.2025.08.25.23.20.53
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Aug 2025 23:20:53 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-325017f25aaso6910443a91.2
        for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 23:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1756189252; x=1756794052; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mkme5IBl5KRWoBojbGS0RT/QRiWYZpAh+2JnOlGPjUk=;
        b=ZjeAq672hUMHbCJQCtj1j0DzGEdcg0akZLSWRo9ePpRCVlVGx8FPUexj2ZsUxCvwuk
         D6ggwNzB/xCpV05YQVyMxV2enudWewJpMc7dLfsihm/0Pz0vEVgv/NOZPzSwcrWYWNGy
         jaJxegNRvDLAfXWjueuj+pkTveyn5F4ZLOjCc=
X-Forwarded-Encrypted: i=1; AJvYcCUGjBsm9oBzvk3N7YSCE9cyDc6chRzTcJBPBT1jCwqMN5DeBKnEvauMjOSJ+l4580ynZKvYHlY=@vger.kernel.org
X-Received: by 2002:a17:90b:538b:b0:325:cce7:f65b with SMTP id 98e67ed59e1d1-325cce7f86emr5603672a91.29.1756189252045;
        Mon, 25 Aug 2025 23:20:52 -0700 (PDT)
X-Received: by 2002:a17:90b:538b:b0:325:cce7:f65b with SMTP id 98e67ed59e1d1-325cce7f86emr5603594a91.29.1756189250915;
        Mon, 25 Aug 2025 23:20:50 -0700 (PDT)
Received: from dhcp-10-123-157-228.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4c04c7522fsm4392543a12.5.2025.08.25.23.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 23:20:50 -0700 (PDT)
From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	michael.chan@broadcom.com,
	Saravanan Vajravel <saravanan.vajravel@broadcom.com>,
	Kashyap Desai <kashyap.desai@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH V2 rdma-next 06/10] RDMA/bnxt_re: Add support for mirror vnic
Date: Tue, 26 Aug 2025 11:55:18 +0530
Message-ID: <20250826062522.1036432-7-kalesh-anakkur.purayil@broadcom.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250826062522.1036432-1-kalesh-anakkur.purayil@broadcom.com>
References: <20250826062522.1036432-1-kalesh-anakkur.purayil@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: Saravanan Vajravel <saravanan.vajravel@broadcom.com>

Added below support:
- Querying the pre-reserved mirror_vnic_id
- Allocating/freeing mirror_vnic
- Configuring mirror vnic to associate it with raw qp

These functions will be used in the subsequent patch in this series.

Signed-off-by: Saravanan Vajravel <saravanan.vajravel@broadcom.com>
Reviewed-by: Kashyap Desai <kashyap.desai@broadcom.com>
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/bnxt_re.h |  4 ++
 drivers/infiniband/hw/bnxt_re/main.c    | 67 +++++++++++++++++++++++++
 2 files changed, 71 insertions(+)

diff --git a/drivers/infiniband/hw/bnxt_re/bnxt_re.h b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
index 1cb57c8246cc..3f7f6cefe771 100644
--- a/drivers/infiniband/hw/bnxt_re/bnxt_re.h
+++ b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
@@ -250,6 +250,10 @@ int bnxt_re_assign_pma_port_counters(struct bnxt_re_dev *rdev, struct ib_mad *ou
 int bnxt_re_assign_pma_port_ext_counters(struct bnxt_re_dev *rdev,
 					 struct ib_mad *out_mad);
 
+void bnxt_re_hwrm_free_vnic(struct bnxt_re_dev *rdev);
+int bnxt_re_hwrm_alloc_vnic(struct bnxt_re_dev *rdev);
+int bnxt_re_hwrm_cfg_vnic(struct bnxt_re_dev *rdev, u32 qp_id);
+
 static inline struct device *rdev_to_dev(struct bnxt_re_dev *rdev)
 {
 	if (rdev)
diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 479c2a390885..07d25deffabe 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -540,6 +540,72 @@ static void bnxt_re_fill_fw_msg(struct bnxt_fw_msg *fw_msg, void *msg,
 	fw_msg->timeout = timeout;
 }
 
+void bnxt_re_hwrm_free_vnic(struct bnxt_re_dev *rdev)
+{
+	struct bnxt_en_dev *en_dev = rdev->en_dev;
+	struct hwrm_vnic_free_input req = {};
+	struct bnxt_fw_msg fw_msg = {};
+	int rc;
+
+	bnxt_re_init_hwrm_hdr((void *)&req, HWRM_VNIC_FREE);
+
+	req.vnic_id = cpu_to_le32(rdev->mirror_vnic_id);
+	bnxt_re_fill_fw_msg(&fw_msg, (void *)&req, sizeof(req), NULL,
+			    0, DFLT_HWRM_CMD_TIMEOUT);
+	rc = bnxt_send_msg(en_dev, &fw_msg);
+	if (rc)
+		ibdev_dbg(&rdev->ibdev,
+			  "Failed to free vnic, rc = %d\n", rc);
+}
+
+int bnxt_re_hwrm_alloc_vnic(struct bnxt_re_dev *rdev)
+{
+	struct bnxt_en_dev *en_dev = rdev->en_dev;
+	struct hwrm_vnic_alloc_output resp = {};
+	struct hwrm_vnic_alloc_input req = {};
+	struct bnxt_fw_msg fw_msg = {};
+	int rc;
+
+	bnxt_re_init_hwrm_hdr((void *)&req, HWRM_VNIC_ALLOC);
+
+	req.vnic_id = cpu_to_le16(rdev->mirror_vnic_id);
+	req.flags = cpu_to_le32(VNIC_ALLOC_REQ_FLAGS_VNIC_ID_VALID);
+	bnxt_re_fill_fw_msg(&fw_msg, (void *)&req, sizeof(req), (void *)&resp,
+			    sizeof(resp), DFLT_HWRM_CMD_TIMEOUT);
+	rc = bnxt_send_msg(en_dev, &fw_msg);
+	if (rc)
+		ibdev_dbg(&rdev->ibdev,
+			  "Failed to alloc vnic, rc = %d\n", rc);
+
+	return rc;
+}
+
+int bnxt_re_hwrm_cfg_vnic(struct bnxt_re_dev *rdev, u32 qp_id)
+{
+	struct bnxt_en_dev *en_dev = rdev->en_dev;
+	struct hwrm_vnic_cfg_input req = {};
+	struct bnxt_fw_msg fw_msg = {};
+	int rc;
+
+	bnxt_re_init_hwrm_hdr((void *)&req, HWRM_VNIC_CFG);
+
+	req.flags = cpu_to_le32(VNIC_CFG_REQ_FLAGS_ROCE_ONLY_VNIC_MODE);
+	req.enables = cpu_to_le32(VNIC_CFG_REQ_ENABLES_RAW_QP_ID |
+				  VNIC_CFG_REQ_ENABLES_MRU);
+	req.vnic_id = cpu_to_le16(rdev->mirror_vnic_id);
+	req.raw_qp_id = cpu_to_le32(qp_id);
+	req.mru = cpu_to_le16(rdev->netdev->mtu + VLAN_ETH_HLEN);
+
+	bnxt_re_fill_fw_msg(&fw_msg, (void *)&req, sizeof(req), NULL,
+			    0, DFLT_HWRM_CMD_TIMEOUT);
+	rc = bnxt_send_msg(en_dev, &fw_msg);
+	if (rc)
+		ibdev_dbg(&rdev->ibdev,
+			  "Failed to cfg vnic, rc = %d\n", rc);
+
+	return rc;
+}
+
 /* Query device config using common hwrm */
 static int bnxt_re_hwrm_qcfg(struct bnxt_re_dev *rdev, u32 *db_len,
 			     u32 *offset)
@@ -558,6 +624,7 @@ static int bnxt_re_hwrm_qcfg(struct bnxt_re_dev *rdev, u32 *db_len,
 	if (!rc) {
 		*db_len = PAGE_ALIGN(le16_to_cpu(resp.l2_doorbell_bar_size_kb) * 1024);
 		*offset = PAGE_ALIGN(le16_to_cpu(resp.legacy_l2_db_size_kb) * 1024);
+		rdev->mirror_vnic_id = le16_to_cpu(resp.mirror_vnic_id);
 	}
 	return rc;
 }
-- 
2.43.5


