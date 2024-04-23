Return-Path: <netdev+bounces-90333-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E74A98ADC73
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 05:53:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 964841F21E17
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 03:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80DB81C2AF;
	Tue, 23 Apr 2024 03:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="d6toMom/"
X-Original-To: netdev@vger.kernel.org
Received: from alln-iport-7.cisco.com (alln-iport-7.cisco.com [173.37.142.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6EBB15E89
	for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 03:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.142.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713844411; cv=none; b=FHuBy38j/P4czr6SPtaMwtZjD1a0CG57OwUadgUj9yX474T5mT9FZTCcTd2mlHZwLu5LxWy5hbcIIy7Q4W0hNUs4R46BE718gqpBKXP3wR21mko0svn1K3JzQ/Zkdx8maZRO7BCsXHqfrUIecGK/Vj3g3kNuvFRIZ/zx8DOKul4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713844411; c=relaxed/simple;
	bh=aTS8orGWpOYSSeaf/d02zfH4FuaKR6rb7el393EKxR4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lInk4OSN5NcOD5eeDSYZhUwVWU0IaBOgxEdQmZX087FtIVMg/OTLkq0P2yKJLmesDNTw8vUGHlJEMI8bcXMDUK0d0b5mZh9Ya5Vn2tj9WWCLt+dLBG7rq34+QciGcZPaFG12j9mjpKIcc1Y0wiG/Q705bOXaXVdQzNbC9KzaHyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=d6toMom/; arc=none smtp.client-ip=173.37.142.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=1411; q=dns/txt; s=iport;
  t=1713844409; x=1715054009;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XIAxKVuI9wZz3Lt8fVF4erOVxtUkFSkj9MRKYVbvsqI=;
  b=d6toMom/ynI6cCWrGd+kodv9z0rNYdxLIb4yZsNy4Fr70WDgJM61tLcE
   +iaYbJAklMLwpmK4pgM1YzKKF96cunwTKpnPRyGL9ime30t+IDWe/G5FQ
   vGb3UpG43Mx4DJm+ThwuCYfdo2jULqyTeHaV9sCnKsvAnpGeP2TOIRiev
   Q=;
X-CSE-ConnectionGUID: 6byrcBorTpaYRd4yRUOvIQ==
X-CSE-MsgGUID: bUFgwcHeRcK2QgVh7b+ByQ==
X-IronPort-AV: E=Sophos;i="6.07,222,1708387200"; 
   d="scan'208";a="258456824"
Received: from rcdn-core-4.cisco.com ([173.37.93.155])
  by alln-iport-7.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 03:52:22 +0000
Received: from satish-f17-ru1.cisco.com (satish-f17-ru1.cisco.com [10.193.163.97])
	(authenticated bits=0)
	by rcdn-core-4.cisco.com (8.15.2/8.15.2) with ESMTPSA id 43N3qETE019190
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 23 Apr 2024 03:52:21 GMT
From: Satish Kharat <satishkh@cisco.com>
To: netdev@vger.kernel.org
Cc: Satish Kharat <satishkh@cisco.com>
Subject: [PATCH net-next] enic: initialize 'a1' argument to vnic_dev_cmd
Date: Mon, 22 Apr 2024 20:51:54 -0700
Message-ID: <20240423035154.6819-1-satishkh@cisco.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-User: satishkh@cisco.com
X-Outbound-SMTP-Client: 10.193.163.97, satish-f17-ru1.cisco.com
X-Outbound-Node: rcdn-core-4.cisco.com

Always initialize the 'a1' argument passed to
vnic_dev_cmd, keep it consistent.

Signed-off-by: Satish Kharat <satishkh@cisco.com>
---
 drivers/net/ethernet/cisco/enic/vnic_dev.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/cisco/enic/vnic_dev.c b/drivers/net/ethernet/cisco/enic/vnic_dev.c
index 12a83fa1302d..288cbc3fa4fc 100644
--- a/drivers/net/ethernet/cisco/enic/vnic_dev.c
+++ b/drivers/net/ethernet/cisco/enic/vnic_dev.c
@@ -718,14 +718,14 @@ int vnic_dev_hang_reset_done(struct vnic_dev *vdev, int *done)
 
 int vnic_dev_hang_notify(struct vnic_dev *vdev)
 {
-	u64 a0, a1;
+	u64 a0 = 0, a1 = 0;
 	int wait = 1000;
 	return vnic_dev_cmd(vdev, CMD_HANG_NOTIFY, &a0, &a1, wait);
 }
 
 int vnic_dev_get_mac_addr(struct vnic_dev *vdev, u8 *mac_addr)
 {
-	u64 a0, a1;
+	u64 a0 = 0, a1 = 0;
 	int wait = 1000;
 	int err, i;
 
@@ -1164,7 +1164,7 @@ int vnic_dev_deinit_done(struct vnic_dev *vdev, int *status)
 
 int vnic_dev_set_mac_addr(struct vnic_dev *vdev, u8 *mac_addr)
 {
-	u64 a0, a1;
+	u64 a0, a1 = 0;
 	int wait = 1000;
 	int i;
 
@@ -1230,6 +1230,7 @@ int vnic_dev_classifier(struct vnic_dev *vdev, u8 cmd, u16 *entry,
 		dma_free_coherent(&vdev->pdev->dev, tlv_size, tlv_va, tlv_pa);
 	} else if (cmd == CLSF_DEL) {
 		a0 = *entry;
+		a1 = 0;
 		ret = vnic_dev_cmd(vdev, CMD_DEL_FILTER, &a0, &a1, wait);
 	}
 
-- 
2.44.0


