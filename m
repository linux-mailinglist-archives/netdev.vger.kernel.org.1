Return-Path: <netdev+bounces-90437-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 834BB8AE209
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 12:25:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBE491C2154A
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 10:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 359FA60ED3;
	Tue, 23 Apr 2024 10:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DOeRooee"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00C760EC3
	for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 10:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713867903; cv=none; b=Tb88sGxiJ1AIVo9LAOHPM/1Amjpr3iKOibHestfuU6hUMpYAIt5Agc1OW9ieH++rQr3eyqBVlgp7PxY81pnfWnzZ/eId3fvfVrBb+rb38u0P2pwwCdbnli+UaurCXRX/3pKbTUZa5e70r/CqSaosXBGMBSBwpMyPcpdi+y9XGaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713867903; c=relaxed/simple;
	bh=UBDCME3HI3A/94oLpbDgzueXtBRi1gLLxVmdd4sm1vs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=SGVhn0JeyJXvEuNMygYYliGfdV/WE2Agxow7hcAfQ98VF6HwBWmC1AA/OtDlOSwardbPHWLimaaxd4BnElOeurb1JRVDutxCimD3VXTrlMbB3bUIO2RH94Kv+BNCU5+0lutzgDNS7m7nKrhWvtodlGcoBktI886Sl0Cel57BWaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DOeRooee; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713867900;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=U2lce3/QNW+fiWXInJhryu4GzC+S2O+/i+htA/jwGrw=;
	b=DOeRooee8ENS8sJoGc9ynxFwgkYnwnLsUOn94Sm8XIFeJuXWv1lvRWSKEPthyejN0+L3be
	bkx4XIxziTKSZ9U9nQKWJAYwB4HHU+alXxVboB07aMQ75TlGXgS/D9pVNXlFLLJsaXSFK9
	rJhpe9iIDWMjtpfihnA6YwAfs0t4ZbQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-361-GX6gB2GwN92ENdTWo_SQYg-1; Tue,
 23 Apr 2024 06:24:56 -0400
X-MC-Unique: GX6gB2GwN92ENdTWo_SQYg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2F76E3C02745;
	Tue, 23 Apr 2024 10:24:56 +0000 (UTC)
Received: from calimero.vinschen.de (unknown [10.39.194.197])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 0BB653543A;
	Tue, 23 Apr 2024 10:24:56 +0000 (UTC)
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 0D45DA80BA0; Tue, 23 Apr 2024 12:24:55 +0200 (CEST)
From: Corinna Vinschen <vinschen@redhat.com>
To: netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org
Subject: [PATCH] igc: fix a log entry using uninitialized netdev
Date: Tue, 23 Apr 2024 12:24:54 +0200
Message-ID: <20240423102455.901469-1-vinschen@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

During successful probe, igc logs this:

[    5.133667] igc 0000:01:00.0 (unnamed net_device) (uninitialized): PHC added
                                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
The reason is that igc_ptp_init() is called very early, even before
register_netdev() has been called. So the netdev_info() call works
on a partially uninitialized netdev.

Fix this by calling igc_ptp_init() after register_netdev(), right
after the media autosense check, just as in igb.  Add a comment,
just as in igb.

Now the log message is fine:

[    5.200987] igc 0000:01:00.0 eth0: PHC added

Signed-off-by: Corinna Vinschen <vinschen@redhat.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index d9bd001af7ba..e5900d004071 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -6927,8 +6927,6 @@ static int igc_probe(struct pci_dev *pdev,
 	device_set_wakeup_enable(&adapter->pdev->dev,
 				 adapter->flags & IGC_FLAG_WOL_SUPPORTED);
 
-	igc_ptp_init(adapter);
-
 	igc_tsn_clear_schedule(adapter);
 
 	/* reset the hardware with the new settings */
@@ -6950,6 +6948,9 @@ static int igc_probe(struct pci_dev *pdev,
 	/* Check if Media Autosense is enabled */
 	adapter->ei = *ei;
 
+	/* do hw tstamp init after resetting */
+	igc_ptp_init(adapter);
+
 	/* print pcie link status and MAC address */
 	pcie_print_link_status(pdev);
 	netdev_info(netdev, "MAC: %pM\n", netdev->dev_addr);
-- 
2.44.0


