Return-Path: <netdev+bounces-279633-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sOdyMdWR5WlNlgEAu9opvQ
	(envelope-from <netdev+bounces-279633-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 04:39:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A84A4265CB
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 04:39:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0B2E3300AC0A
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 02:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 632D23019D6;
	Mon, 20 Apr 2026 02:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FEnT0h/V"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC33192B75
	for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 02:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776652390; cv=none; b=Jt7+buUEEbZxpHbxiyTKB9Z6+kAPBh1UNZ7Za5ZfLXmIj0BJ8pLpNwdBBeld3YRfrTlx2tES8cZB0RGF61kgjpibh9MKqmwIsapPlTuI+1bVk0IjmGCwPUDxDpUrYuZlf6/xlU1WEDQ7Y8GKm8kuH79WO+RJSRCKjG6IxhSQxcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776652390; c=relaxed/simple;
	bh=Bml+l/xoQu3lspBeiQRtAwS1uMa70Ja2oGVf758iAyA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=itwTIF8QWEdf+cioh0sgoFjTHzQEwg/h750i2KWBip3RE9Z/gOjvFTYG8Vlbi5i9qoKQL/9gogHSiG1Noh8U9tpjWTdICWdRsJ4nHUdsJV4Mo4ZogtUOK5TOxezXMBmxo0epYC3Ib3TNpU5GOndSc/Oan0Uqto2ZvTP3wq0oxOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FEnT0h/V; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8dfb9139008so161834185a.1
        for <netdev@vger.kernel.org>; Sun, 19 Apr 2026 19:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776652388; x=1777257188; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RAIoe3m+p1YbUQs2TCR3bXdrCIGBFMyCnL0B01QqK1g=;
        b=FEnT0h/VF4s6Nkqz6M70x8CVAqUDbs5nVOTgi1hFPp1lKL855V3REhQEssWDQiB4bQ
         Nx0Rgg/xJMc/6qzTHVysJMzFBGkR2yQDlQEQbBy5LBT1DJDm7r6AJx58XEUMJAvHfWP0
         AD1atmRUSY6DASo2YQytuk+UYqPKk5RW356/AwVpT/BciSqPq7YTH9Swr5/GNYYGprel
         FlbWrjPJiDW/o2RHn0LiRJWsAo/r8msPSiF/sz84/4fi+k2jlyEFFw4hfMC2ZZUgFpma
         zM6tow8TxdzE9eX1AhgYwYr+q92HQceaWGT6gkQ35JgZrdOzS28Do4q7XC/oX8KjbAys
         ZsKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776652388; x=1777257188;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RAIoe3m+p1YbUQs2TCR3bXdrCIGBFMyCnL0B01QqK1g=;
        b=EexMFYO/D5mzccOpB2sRTBC5Gt+4ujMplGaE7kWHCceoPD9X0gpT7QBSRTeqjIfURH
         oAGPAtO7/xnmS+Ye5jBtAxTQu+LpT8q9bm4vevWzgCgcweJwmps3ICQ5n9JZ7NhEXVNo
         su62yYTOIjdpG4R5nAo5J4d5VcZY2XXVqTvV7Y2RIWzfPMh4KvM6AQMZE0X364QahsK1
         oPP5MCUyxxMGdoLetlSgZwySoMb2/0VP7SwD0AYGQJQeGT/bceVwnon20vS6kj9VFPQj
         sGPsBCiEwFB5iMpI70K69SuFeptsFTsPqnakD5y/PnbLRXgTJqmV3QyxhuPnGJaG4axI
         WoMw==
X-Forwarded-Encrypted: i=1; AFNElJ+d+GajYV0wBoDN0qVfazt9HNmwdftUxK/rQ8N2AwTt8L7b/sspW0f/1WKFreNoJDiJoUz25Wk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0YrxDZVOT0Q965mjnw84+jxPS1agZHt4CUkXrKH3jMb9U2rIV
	OrK4PzQLOp4/JAE9Q9M4jLbXICGQR61qqIdfFEddI2VwZqMwkOB8tTr/zIinBGJwGC6gNw==
X-Gm-Gg: AeBDieuGijsj/YV5NWO5gsoXZYDMyB+0YBEDeMplB0eeKmnsmTl0P3oaUTSuX8tRwZL
	0mI/CNrfNw1y4d6hV9B3GpmVL1OV0cQab+A661wOZjvTCg8S4dCkmzqVkQE9bQdvKDMkJHRoUaq
	nmgDSdRoJkbZFPmYUge+1LziQEu149q/zNVuU6zhUXWgwcxb3e6/kKq5nMS+ITs3Yv89p0e1EUf
	Yb4ylfhqTqiUq4lJw6NoLoNukOckvAuvrWXXLOZS+tlUdNKIjaMkYHeFWKdoJfDr7z/C4Z62AW5
	fMScP77aRd9hUqF291xfqur6cInv0mgNLDKwZ8OtA3syND59jUzR8uMCoWugvw6PhKdLoRL5JIN
	TzR/36O5vTVQBjzqpxuK4AgoHhngso3wg5ZCzNrYCxSVMD/WJAVlVde4tBVcAnUi6nsH2f1lQiB
	PuEC0ORDCCwNp62FdTtc85L40cQBlJXPPqxzWwdrH01w+ESOWnJMU88P48xjo=
X-Received: by 2002:a05:620a:4044:b0:8cd:949e:5e31 with SMTP id af79cd13be357-8e792b5c9a4mr1812089585a.57.1776652387844;
        Sun, 19 Apr 2026 19:33:07 -0700 (PDT)
Received: from localhost.localdomain ([165.85.38.136])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e7d94d2efcsm690175785a.38.2026.04.19.19.33.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 19 Apr 2026 19:33:07 -0700 (PDT)
From: Yuho Choi <dbgh9129@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Marco Crivellari <marco.crivellari@suse.com>,
	linux-kernel@vger.kernel.org,
	Myeonghun Pak <mhun512@gmail.com>,
	Ijae Kim <ae878000@gmail.com>,
	Taegyu Kim <tmk5904@psu.edu>,
	Yuho Choi <dbgh9129@gmail.com>
Subject: [PATCH v1] net: liquidio: resolve VF pci_dev on demand for FLR requests
Date: Sun, 19 Apr 2026 22:33:04 -0400
Message-ID: <20260420023304.57105-1-dbgh9129@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [6.34 / 15.00];
	SEM_URIBL(3.50)[psu.edu:email];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,google.com,bootlin.com,linux.dev,suse.com,vger.kernel.org,gmail.com,psu.edu];
	TAGGED_FROM(0.00)[bounces-279633-lists,netdev=lfdr.de];
	GREYLIST(0.00)[pass,body];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	R_DKIM_ALLOW(0.00)[gmail.com:s=20251104];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[dbgh9129@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_SPAM(0.00)[0.956];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c04:e001:36c::/64:c];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,psu.edu:email]
X-Rspamd-Queue-Id: 5A84A4265CB
X-Rspamd-Action: add header
X-Rspamd-Server: lfdr
X-Spam: Yes

The PF SR-IOV enable path caches VF pci_dev pointers in
dpiring_to_vfpcidev_lut[] by iterating with pci_get_device(). Those
entries do not own a reference, because the iterator drops the previous
device reference on each step. The cached pointer is then dereferenced
later when handling OCTEON_VF_FLR_REQUEST.

This can leave stale VF pci_dev pointers in the lookup table and makes
the FLR path rely on a PCI device object whose lifetime is not pinned.

Drop the long-lived lookup table and resolve the VF pci_dev only when an
FLR request arrives. Use the PF's SR-IOV metadata to derive the VF's
bus/devfn, get a referenced pci_dev for immediate use, issue the FLR,
and then drop the reference.

Fixes: ca6139ffc67ee ("liquidio CN23XX: sysfs VF config support")
Fixes: 8c978d059224 ("liquidio CN23XX: Mailbox support")
Co-developed-by: Myeonghun Pak <mhun512@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Co-developed-by: Taegyu Kim <tmk5904@psu.edu>
Signed-off-by: Taegyu Kim <tmk5904@psu.edu>
Signed-off-by: Yuho Choi <dbgh9129@gmail.com>
---
 .../net/ethernet/cavium/liquidio/lio_main.c   | 27 ----------------
 .../ethernet/cavium/liquidio/octeon_device.h  |  3 --
 .../ethernet/cavium/liquidio/octeon_mailbox.c | 31 ++++++++++++++++++-
 3 files changed, 30 insertions(+), 31 deletions(-)

diff --git a/drivers/net/ethernet/cavium/liquidio/lio_main.c b/drivers/net/ethernet/cavium/liquidio/lio_main.c
index c1a3df2252549..32dd9b25760e3 100644
--- a/drivers/net/ethernet/cavium/liquidio/lio_main.c
+++ b/drivers/net/ethernet/cavium/liquidio/lio_main.c
@@ -3781,9 +3781,7 @@ static int setup_nic_devices(struct octeon_device *octeon_dev)
 static int octeon_enable_sriov(struct octeon_device *oct)
 {
 	unsigned int num_vfs_alloced = oct->sriov_info.num_vfs_alloced;
-	struct pci_dev *vfdev;
 	int err;
-	u32 u;
 
 	if (OCTEON_CN23XX_PF(oct) && num_vfs_alloced) {
 		err = pci_enable_sriov(oct->pci_dev,
@@ -3796,23 +3794,6 @@ static int octeon_enable_sriov(struct octeon_device *oct)
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
@@ -3820,8 +3801,6 @@ static int octeon_enable_sriov(struct octeon_device *oct)
 
 static int lio_pci_sriov_disable(struct octeon_device *oct)
 {
-	int u;
-
 	if (pci_vfs_assigned(oct->pci_dev)) {
 		dev_err(&oct->pci_dev->dev, "VFs are still assigned to VMs.\n");
 		return -EPERM;
@@ -3829,12 +3808,6 @@ static int lio_pci_sriov_disable(struct octeon_device *oct)
 
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
index 19344b21f8fb9..858a0fff2cc0b 100644
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
index ad685f5d0a136..b967c7928b4a7 100644
--- a/drivers/net/ethernet/cavium/liquidio/octeon_mailbox.c
+++ b/drivers/net/ethernet/cavium/liquidio/octeon_mailbox.c
@@ -26,6 +26,29 @@
 #include "octeon_mailbox.h"
 #include "cn23xx_pf_device.h"
 
+static struct pci_dev *lio_vf_pci_dev_by_qno(struct octeon_device *oct, u32 q_no)
+{
+	int vfidx, bus, devfn;
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
+	bus = pci_iov_virtfn_bus(oct->pci_dev, vfidx);
+	devfn = pci_iov_virtfn_devfn(oct->pci_dev, vfidx);
+	if (bus < 0 || devfn < 0)
+		return NULL;
+
+	return pci_get_domain_bus_and_slot(pci_domain_nr(oct->pci_dev->bus),
+					   bus, devfn);
+}
+
 /**
  * octeon_mbox_read:
  * @mbox: Pointer mailbox
@@ -237,6 +260,7 @@ static int octeon_mbox_process_cmd(struct octeon_mbox *mbox,
 				   struct octeon_mbox_cmd *mbox_cmd)
 {
 	struct octeon_device *oct = mbox->oct_dev;
+	struct pci_dev *vfdev;
 
 	switch (mbox_cmd->msg.s.cmd) {
 	case OCTEON_VF_ACTIVE:
@@ -260,7 +284,12 @@ static int octeon_mbox_process_cmd(struct octeon_mbox *mbox,
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
2.50.1 (Apple Git-155)


