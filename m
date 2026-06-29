Return-Path: <netdev+bounces-302679-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qeYtNT+BQmr68gkAu9opvQ
	(envelope-from <netdev+bounces-302679-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 16:29:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D76A66DC0CB
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 16:29:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=dqUXewsM;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302679-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-302679-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9CA63303E7D5
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 14:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38861423A94;
	Mon, 29 Jun 2026 14:17:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B968C40B364
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 14:17:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782742632; cv=none; b=dVR6XwIxVweRm3PQSMmLIA97xB+WEcQf8vzqcM/aokXKyYzMd/iLwo7QNMardIuRfkXAOQ803BKKEOVCiYUoOtqUU5d3kl9DBMVun8YspKNco3CnRNNQnZy5vNrlQq+HgepX70q+mAOYHx03dxQPtgThio2heoepWV+ap0Do9qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782742632; c=relaxed/simple;
	bh=A7dfX+vNqB8tGdyYV/BojgDBGmuRClxRMuJSfPWHnDg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OpAS7ksAEiPb/qqIMpyaz1nzb4G3Hi9OdwyWQYalBqcCp27PVHKM0Dv+lK+euZuODScy5Izl1oCrPiTyW3zfpDHV688ddjukCCXruH+scFaGBOw2MXgdYfyo0RW0t6FXqiiKGfvcOnUthGvWxBHaQvh6YfkpB2VW/mroJECcTKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dqUXewsM; arc=none smtp.client-ip=209.85.161.43
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-69d7aa0ac14so2335570eaf.3
        for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 07:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782742630; x=1783347430; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RnLUCD2cfxxWhTfLsTUO4oXPegvOa3BjYaXWIEOfKbA=;
        b=dqUXewsMTUxMeU7hcHWSZ/DI6URWljhaK6AfDa0lwdDuq40gD7OVGiwetm1ZPYBNst
         a2Vf5nGVt8TlBhMyzaYr1L68bs2DRuXhB9l10XID5+DyB/Jd4+ZloHYCkvt+N5orrhm2
         K8vNBSnwHPGE3c5U50MJ6CoWVIvx35f6iV8HhSMC3EYnJg8rl1wuSojPgTnqb4JAQ+U8
         jbwoZmnp+4f5hI/wkweEiEr9L5xpgS4qeuIWmTl42Ac5xlWv1P7ECk4F/LtkpH0fQFhN
         KBwbThkyc9aXWdt19QYoavAiV1OGVfqO8AaVUymzUJNKop3fjUPoCI9p+g0E/PWopOTa
         Kbkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782742630; x=1783347430;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RnLUCD2cfxxWhTfLsTUO4oXPegvOa3BjYaXWIEOfKbA=;
        b=f1RG79WLAdffH/gf19Dx09J9fowM5i6LXX6X8mST/P/hr8Ba2I1BAdPzdINal/eIQJ
         4bBcW9ji4xeM+fU4R3UNbxCHXEsZt6668kPaBtWmmDVFsqLAGJtu3168+QTs9+GCBe7W
         0y1zefcOdMTpvqkTQEo/MN6zx2DLf6UZSKSBg4VibIB9BO2xSKrh28KmV3GHPz8ET/Uq
         ijvqq2ua1XgqIW4B3klYIEFIqI9azWd565kQ9xLWTesl67l8AjAVq/eslJ9cCefSWnd3
         ZWth0kTYdYTT5d0MpGZSAAd3PQCYlcgoxLoSzHCCN2eRAd7dSsOm8zeA5a9yRXHZK4Bz
         rN9g==
X-Gm-Message-State: AOJu0Yz5boABVmyGlxtIjfwPKvslyBrfFmaLgS1dXPZIp4FkyDQGfkBv
	PLJ2aagwI/WA+LJrrceboffiuty0c0fsa/3culdX7/IL8vxmsh0NAndF
X-Gm-Gg: AfdE7cn+johmol1Sd9Urtc+FfvCQbV2K8/TNe++LFEYdrs1P0SOf7GZ2r4ezYQhkv2d
	QlODzrHEl/cgxaRvTsr4S24bPAyGJvaHZv0kqKz6Dnb85nwF0f2ec+gyMMMNWM6FXrmXoA/Axy3
	L4nFQEghjqiSv7K1xcSV1Ekg0YJUgGLpnTDI+Ya1JrTBFTMhNXzVc1uGNl2dfyzwishMxxtjSPZ
	qb/M6IMplcl8jUzbQFLbfIvWyCRgftnqJ/N+y77QcGX7fg2DCL/yswqeRfPfMHsws1bM7JhPTkO
	8Vd6967PzEIPYTGIl1BDTl3IrTM52KefLOvQtso/oz+vEm5SgaTwLstLLJVPOKX5B7bkfCmLahg
	reM53O5jTG1S0ehpMayvDEDFzEk1SkJ5eMMQp5HB4AJAzT/7b+/afKgZxRY6mmXeZGpaet6bn3Q
	LizehaeCNQxjf9bmRUl/Zry362Llxz5Q==
X-Received: by 2002:a05:6820:3389:20b0:6a1:50e9:d586 with SMTP id 006d021491bc7-6a150e9d657mr4912535eaf.67.1782742629478;
        Mon, 29 Jun 2026 07:17:09 -0700 (PDT)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ea52af6006sm91287136d6.11.2026.06.29.07.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 07:17:09 -0700 (PDT)
From: Yuho Choi <dbgh9129@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Zilin Guan <zilin@seu.edu.cn>,
	Uwe Kleine-Koenig <u.kleine-koenig@baylibre.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Marco Crivellari <marco.crivellari@suse.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yuho Choi <dbgh9129@gmail.com>
Subject: [PATCH net v2] net/liquidio: drop cached VF pci_dev LUT and resolve VF for FLR on request
Date: Mon, 29 Jun 2026 10:16:56 -0400
Message-ID: <20260629141656.1769227-1-dbgh9129@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-302679-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[dbgh9129@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:kory.maincent@bootlin.com,m:zilin@seu.edu.cn,m:u.kleine-koenig@baylibre.com,m:vadim.fedorenko@linux.dev,m:marco.crivellari@suse.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:dbgh9129@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dbgh9129@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D76A66DC0CB

The PF SR-IOV enable path caches VF pci_dev pointers in
dpiring_to_vfpcidev_lut[] by iterating with pci_get_device(). Those
entries do not own a reference, because the iterator drops the previous
device reference on each step. The cached pointer is then dereferenced
later when handling OCTEON_VF_FLR_REQUEST.

Replace cached VF mapping with runtime lookup on mailbox DPI ring:
derive VF index from q_no, resolve the VF via exported PCI IOV helpers,
validate with PF pointer + VF ID, then pcie_flr() and pci_dev_put().
Also, remove unused dpiring_to_vfpcidev_lut init/cleanup and simplify
Xgene PCI probe by using port->dev->of_node directly.

Fixes: ca6139ffc67ee ("liquidio CN23XX: sysfs VF config support")
Fixes: 8c978d059224 ("liquidio CN23XX: Mailbox support")
Signed-off-by: Yuho Choi <dbgh9129@gmail.com>
---
Changes in v2:
- Replace use of pci_iov_virtfn_bus() with runtime VF lookup using exported helpers.
 .../net/ethernet/cavium/liquidio/lio_main.c   | 27 ---------------
 .../ethernet/cavium/liquidio/octeon_device.h  |  3 --
 .../ethernet/cavium/liquidio/octeon_mailbox.c | 33 ++++++++++++++++++-
 3 files changed, 32 insertions(+), 31 deletions(-)

diff --git a/drivers/net/ethernet/cavium/liquidio/lio_main.c b/drivers/net/ethernet/cavium/liquidio/lio_main.c
index 0db08ac3d098..e303956b4bf1 100644
--- a/drivers/net/ethernet/cavium/liquidio/lio_main.c
+++ b/drivers/net/ethernet/cavium/liquidio/lio_main.c
@@ -3779,9 +3779,7 @@ static int setup_nic_devices(struct octeon_device *octeon_dev)
 static int octeon_enable_sriov(struct octeon_device *oct)
 {
 	unsigned int num_vfs_alloced = oct->sriov_info.num_vfs_alloced;
-	struct pci_dev *vfdev;
 	int err;
-	u32 u;
 
 	if (OCTEON_CN23XX_PF(oct) && num_vfs_alloced) {
 		err = pci_enable_sriov(oct->pci_dev,
@@ -3794,23 +3792,6 @@ static int octeon_enable_sriov(struct octeon_device *oct)
 			return err;
 		}
 		oct->sriov_info.sriov_enabled = 1;
-
-		/* init lookup table that maps DPI ring number to VF pci_dev
-		 * struct pointer
-		 */
-		u = 0;
-		vfdev = pci_get_device(PCI_VENDOR_ID_CAVIUM,
-				       OCTEON_CN23XX_VF_VID, NULL);
-		while (vfdev) {
-			if (vfdev->is_virtfn &&
-			    (vfdev->physfn == oct->pci_dev)) {
-				oct->sriov_info.dpiring_to_vfpcidev_lut[u] =
-					vfdev;
-				u += oct->sriov_info.rings_per_vf;
-			}
-			vfdev = pci_get_device(PCI_VENDOR_ID_CAVIUM,
-					       OCTEON_CN23XX_VF_VID, vfdev);
-		}
 	}
 
 	return num_vfs_alloced;
@@ -3818,8 +3799,6 @@ static int octeon_enable_sriov(struct octeon_device *oct)
 
 static int lio_pci_sriov_disable(struct octeon_device *oct)
 {
-	int u;
-
 	if (pci_vfs_assigned(oct->pci_dev)) {
 		dev_err(&oct->pci_dev->dev, "VFs are still assigned to VMs.\n");
 		return -EPERM;
@@ -3827,12 +3806,6 @@ static int lio_pci_sriov_disable(struct octeon_device *oct)
 
 	pci_disable_sriov(oct->pci_dev);
 
-	u = 0;
-	while (u < MAX_POSSIBLE_VFS) {
-		oct->sriov_info.dpiring_to_vfpcidev_lut[u] = NULL;
-		u += oct->sriov_info.rings_per_vf;
-	}
-
 	oct->sriov_info.num_vfs_alloced = 0;
 	dev_info(&oct->pci_dev->dev, "oct->pf_num:%d disabled VFs\n",
 		 oct->pf_num);
diff --git a/drivers/net/ethernet/cavium/liquidio/octeon_device.h b/drivers/net/ethernet/cavium/liquidio/octeon_device.h
index 19344b21f8fb..858a0fff2cc0 100644
--- a/drivers/net/ethernet/cavium/liquidio/octeon_device.h
+++ b/drivers/net/ethernet/cavium/liquidio/octeon_device.h
@@ -390,9 +390,6 @@ struct octeon_sriov_info {
 
 	struct lio_trusted_vf	trusted_vf;
 
-	/*lookup table that maps DPI ring number to VF pci_dev struct pointer*/
-	struct pci_dev *dpiring_to_vfpcidev_lut[MAX_POSSIBLE_VFS];
-
 	u64	vf_macaddr[MAX_POSSIBLE_VFS];
 
 	u16	vf_vlantci[MAX_POSSIBLE_VFS];
diff --git a/drivers/net/ethernet/cavium/liquidio/octeon_mailbox.c b/drivers/net/ethernet/cavium/liquidio/octeon_mailbox.c
index ad685f5d0a13..697fcdc41e3c 100644
--- a/drivers/net/ethernet/cavium/liquidio/octeon_mailbox.c
+++ b/drivers/net/ethernet/cavium/liquidio/octeon_mailbox.c
@@ -26,6 +26,31 @@
 #include "octeon_mailbox.h"
 #include "cn23xx_pf_device.h"
 
+static struct pci_dev *lio_vf_pci_dev_by_qno(struct octeon_device *oct, u32 q_no)
+{
+	struct pci_dev *vfdev = NULL;
+	int vfidx;
+
+	if (!oct->sriov_info.rings_per_vf)
+		return NULL;
+
+	if (q_no % oct->sriov_info.rings_per_vf)
+		return NULL;
+
+	vfidx = q_no / oct->sriov_info.rings_per_vf;
+	if (vfidx >= oct->sriov_info.num_vfs_alloced)
+		return NULL;
+
+	while ((vfdev = pci_get_device(PCI_VENDOR_ID_CAVIUM,
+				       OCTEON_CN23XX_VF_VID, vfdev))) {
+		if (pci_physfn(vfdev) && pci_physfn(vfdev) == oct->pci_dev &&
+		    pci_iov_vf_id(vfdev) == vfidx)
+			return vfdev;
+	}
+
+	return NULL;
+}
+
 /**
  * octeon_mbox_read:
  * @mbox: Pointer mailbox
@@ -237,6 +262,7 @@ static int octeon_mbox_process_cmd(struct octeon_mbox *mbox,
 				   struct octeon_mbox_cmd *mbox_cmd)
 {
 	struct octeon_device *oct = mbox->oct_dev;
+	struct pci_dev *vfdev;
 
 	switch (mbox_cmd->msg.s.cmd) {
 	case OCTEON_VF_ACTIVE:
@@ -260,7 +286,12 @@ static int octeon_mbox_process_cmd(struct octeon_mbox *mbox,
 		dev_info(&oct->pci_dev->dev,
 			 "got a request for FLR from VF that owns DPI ring %u\n",
 			 mbox->q_no);
-		pcie_flr(oct->sriov_info.dpiring_to_vfpcidev_lut[mbox->q_no]);
+		vfdev = lio_vf_pci_dev_by_qno(oct, mbox->q_no);
+		if (!vfdev)
+			break;
+
+		pcie_flr(vfdev);
+		pci_dev_put(vfdev);
 		break;
 
 	case OCTEON_PF_CHANGED_VF_MACADDR:
-- 
2.43.0


