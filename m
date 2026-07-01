Return-Path: <netdev+bounces-303459-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uy1uO9+SRGq7xAoAu9opvQ
	(envelope-from <netdev+bounces-303459-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 06:09:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D4176E9A2B
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 06:09:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=NMT6BH8o;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303459-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303459-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 06775300680E
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 04:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC383390237;
	Wed,  1 Jul 2026 04:09:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E1F38F957
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 04:08:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782878940; cv=none; b=M6dpzSqkfhpxDF6CBzTJ+MykxjlAmcFiEvIQ4Yw2Ii9C9pUhziaqbF7y0lE9RLv5tVHFEZ7uIB0+mN3tBp9PEhY4EbsQ3bkfpD4KGxOlAnBq4+5C/AxeVzBTxWHPlMMUYqy3lYnYSnHttcXnl3Jf4PVVE4POmj6UPNRT2e3L1Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782878940; c=relaxed/simple;
	bh=hvT7JLBtMKlW8UeJ63Gs978aQAyA8oK61EamMUG8cLM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=plNKngfHrfWaerHYksjC5efp9nIxTSqeqAGxDKTz2cQ5At3yFisoHx+N7oivN0bmSo/TRsNqa7yHoH1Z2RfDiYEVmrNsAaG1E7Ow0QwCuht9nbavyVzz587fSl6Tv0JwCwJggeBgEBGlkMwDzkiL3pxXF1RrafqqOHi9uzTLamk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NMT6BH8o; arc=none smtp.client-ip=209.85.160.180
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-51bf11ba4f6so1728761cf.1
        for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 21:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782878931; x=1783483731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hQC+Zuo8/BXFOdZBqV/xbASkSWVoxyYlD7997dQNoBQ=;
        b=NMT6BH8on4fNWzFFuFM5onnQxm/gd3HvGtch3fHeS2gRh2CYXliGL2IO/kDdwI1a57
         FB/gyUU9zoVHf1X4dBeXD8R1tbXny5ZMS0vYHHQuu+spdisVdUmJwDzahRKk9F9AXFUX
         H+RTfHoRDzwXuBFHkAzMKYhv0BximG1yrkmgfq3Er1xGvz+1YBuRKAxuVMKPfHTUYNAb
         l+7kQLTSYfU/nVp3JGcA/nAH0aID3hqTS08pONi0Sh/3Zi67udR36zuOW8ATlny0IGQs
         kT+daACIcLwhPblQr/hX7t8yUIzeis+IG+2gnOBwLfY6wATaHTHt1zvAadd8SaWmq4de
         W2iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782878931; x=1783483731;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hQC+Zuo8/BXFOdZBqV/xbASkSWVoxyYlD7997dQNoBQ=;
        b=TGBw70fgLnCSHiedao5s3u7PJ4wITnc1wyVGI0haMuL5p4C3FWeJmgf7srIRAAuw/i
         J3+VlXeT4WgDActin1qQRE5PoHUi7evvg0YocPVGKS/nMTf2D0Ipj3p1iLlADd4xItq7
         S5QxmSUH+CwUTDR6xjAyx72fmiXOJKRWG0T471L+ZPzF6pyzMEr5pxiYW/zhD1Pjsrw4
         l7q/cEg+MZGT4TSAJHMUXusBvOSymrf8zozToxVESKMzqKfbmn5zfQZEGRSV6LSfazFC
         F081A7GKzrXQmNYAXyjF/l+y00Lq3Psq1z00fSfpaEU3a1K0r6VoSMp/ESaDavgixjbF
         dZQQ==
X-Forwarded-Encrypted: i=1; AFNElJ9z3S+bdNxBgV1h55m8bJ1AQUgiLpL9q/Tj48DKfwa6/K87jR+pUiDXObWVXzJEKe/pryr8N+M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXyK8IF2kYwkwdskmwOxPrA5+OGO4llGWcIrR9IbPT0al4x0v9
	DNQZP6tz/IwKAerHKnGF4Lrh+CrbTJWdn7P31vDXp5kWv3dEfLGKLG04
X-Gm-Gg: AfdE7cm691IMY+0f17CgEFkykwLlBbTFC0nFoVhWocNkxCA+xRTA5ufzfe+ywpvX4sz
	k2dxcNDNPuvkeMjQPmdqM4gBhY2PCWUNYMiLqAPBK0wyRvqAtt3e5dQJF6q4P5uhNrDv1fg+Y3t
	7zyP98FShkcScHs7E01eOE4dO6ahBSHSj6mvd27L9DQmMmDABUV2w+YxmWpA1JXlG6oxpQY4uRM
	zgoYgekzSRlWGusJnpQJKsxQpJgd0004qLf6Z3Daip8rU9NMfbIecZh50C1YzlpUc8eth5uvivo
	pY0OGm80F74+FSn008U38bUABtGRSv+AxCFjxgvyBi8Gabbl/YoJvkgE4fvbUsFna9eXxd+C0/R
	dilnqHXNMjIl2DXADX6tGJs5d59USw/lLt6AjLFKifr4reEeDtpDVzZPHUbu+jzk70H+VIEcYiQ
	OqKnoE+/CyCNXCv1PFI7OVba2yjsy0MQ==
X-Received: by 2002:ac8:7f4c:0:b0:517:9570:c1bd with SMTP id d75a77b69052e-51c26a4aa41mr1185021cf.25.1782878931399;
        Tue, 30 Jun 2026 21:08:51 -0700 (PDT)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51c10a3307csm33402791cf.29.2026.06.30.21.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 21:08:50 -0700 (PDT)
From: Yuho Choi <dbgh9129@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: Kory Maincent <kory.maincent@bootlin.com>,
	Zilin Guan <zilin@seu.edu.cn>,
	Arend van Spriel <arend.vanspriel@broadcom.com>,
	Marco Crivellari <marco.crivellari@suse.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	linux-kernel@vger.kernel.org,
	Yuho Choi <dbgh9129@gmail.com>
Subject: [PATCH v3] net/liquidio: drop cached VF pci_dev LUT
Date: Wed,  1 Jul 2026 00:08:47 -0400
Message-ID: <20260701040847.1897845-1-dbgh9129@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303459-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[dbgh9129@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[bootlin.com,seu.edu.cn,broadcom.com,suse.com,baylibre.com,linux.dev,vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:kory.maincent@bootlin.com,m:zilin@seu.edu.cn,m:arend.vanspriel@broadcom.com,m:marco.crivellari@suse.com,m:u.kleine-koenig@baylibre.com,m:vadim.fedorenko@linux.dev,m:linux-kernel@vger.kernel.org,m:dbgh9129@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8D4176E9A2B

The PF SR-IOV enable path caches VF pci_dev pointers in
dpiring_to_vfpcidev_lut[] by iterating with pci_get_device(). Those
entries do not own a reference, because the iterator drops the previous
device reference on each step. The cached pointer is then dereferenced
later when handling OCTEON_VF_FLR_REQUEST.

Replace the cached VF mapping with runtime lookup on the mailbox DPI
ring: derive the VF index from q_no, resolve the VF via exported PCI
IOV helpers, validate it with the PF pointer and VF ID, then issue
pcie_flr() and drop the reference with pci_dev_put(). Remove the
unused VF lookup table initialization and cleanup.

Fixes: ca6139ffc67ee ("liquidio CN23XX: sysfs VF config support")
Fixes: 8c978d059224 ("liquidio CN23XX: Mailbox support")
Signed-off-by: Yuho Choi <dbgh9129@gmail.com>
---
Changes in v3:
- Drop unrelated Xgene PCI probe note from the commit message.
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


