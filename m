Return-Path: <netdev+bounces-211325-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2905DB18002
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 12:14:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D67E1C24196
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 10:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1FF4233733;
	Fri,  1 Aug 2025 10:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZOJmA9P/"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969C913A3ED
	for <netdev@vger.kernel.org>; Fri,  1 Aug 2025 10:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754043237; cv=none; b=V5N8oqUybESko6jHiSjcmxttgeHJf6akPkdVszsuZBE9Urg39MjhxjpItbB9u0Qa0vfwPEwH8B0qHI+K1M+2Lef068NrjbaAS1uiOXSn4YYF0NT/kqv9zLWIRIgPcwn52EKYhQ9oXA21sULtS6nViw1eQn2EfjB4deV6WcJ/NzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754043237; c=relaxed/simple;
	bh=RxTq86rHJNrOa+BmajMZGiX1rV8aJVIqJ8sAET9PRL8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RIrMDvufrUjH9zvqTH8Lx0oB7faekHtlbwlM/PCGn57uQJlx7syWHnwjuFt4gYdwT3ce9730uvGCNdHHZEqhCybow0t+omZFKyWHe7vKK+KE6G0Gi2Bz5186N+WIHi3s3iPNjNOqMy6hpkBsB+7CxZywhu4AUZR+5W1OFdz8Pcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZOJmA9P/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754043234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3eQ5sa84X5wOi+N7HjGs5mDcZ+fhrm6LLTF2HzJMk3w=;
	b=ZOJmA9P/xqQrmYRDCgoq3XtE1ObjSpNikleT5bTcOLk7x0KH0XrxkYeMsjdoB7IoII3ZFv
	CHTqReUnw1XzaffvnUq3aCx+eotX1F1S6n3LyGhI2JaRzX4ZSnTgZOueF/eEbKD59uTVjC
	DeIOT1kZzN0RDuj0FIOZMNoSz/1ISsY=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-604-HB9WZrOcMmKUW7-qz7w7Xw-1; Fri,
 01 Aug 2025 06:13:52 -0400
X-MC-Unique: HB9WZrOcMmKUW7-qz7w7Xw-1
X-Mimecast-MFC-AGG-ID: HB9WZrOcMmKUW7-qz7w7Xw_1754043231
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 979CE19373E5;
	Fri,  1 Aug 2025 10:13:50 +0000 (UTC)
Received: from rhel-developer-toolbox.redhat.com (unknown [10.44.32.151])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7A53B180035E;
	Fri,  1 Aug 2025 10:13:46 +0000 (UTC)
From: Michal Schmidt <mschmidt@redhat.com>
To: Ajit Khaparde <ajit.khaparde@broadcom.com>,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] benet: fix BUG when creating VFs
Date: Fri,  1 Aug 2025 12:13:37 +0200
Message-ID: <20250801101338.72502-1-mschmidt@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

benet crashes as soon as SRIOV VFs are created:

 kernel BUG at mm/vmalloc.c:3457!
 Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
 CPU: 4 UID: 0 PID: 7408 Comm: test.sh Kdump: loaded Not tainted 6.16.0+ #1 PREEMPT(voluntary)
 [...]
 RIP: 0010:vunmap+0x5f/0x70
 [...]
 Call Trace:
  <TASK>
  __iommu_dma_free+0xe8/0x1c0
  be_cmd_set_mac_list+0x3fe/0x640 [be2net]
  be_cmd_set_mac+0xaf/0x110 [be2net]
  be_vf_eth_addr_config+0x19f/0x330 [be2net]
  be_vf_setup+0x4f7/0x990 [be2net]
  be_pci_sriov_configure+0x3a1/0x470 [be2net]
  sriov_numvfs_store+0x20b/0x380
  kernfs_fop_write_iter+0x354/0x530
  vfs_write+0x9b9/0xf60
  ksys_write+0xf3/0x1d0
  do_syscall_64+0x8c/0x3d0

be_cmd_set_mac_list() calls dma_free_coherent() under a spin_lock_bh.
Fix it by freeing only after the lock has been released.

Fixes: 1a82d19ca2d6 ("be2net: fix sleeping while atomic bugs in be_ndo_bridge_getlink")
Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
---
 drivers/net/ethernet/emulex/benet/be_cmds.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/emulex/benet/be_cmds.c b/drivers/net/ethernet/emulex/benet/be_cmds.c
index d730af4a50c7..bb5d2fa15736 100644
--- a/drivers/net/ethernet/emulex/benet/be_cmds.c
+++ b/drivers/net/ethernet/emulex/benet/be_cmds.c
@@ -3856,8 +3856,8 @@ int be_cmd_set_mac_list(struct be_adapter *adapter, u8 *mac_array,
 	status = be_mcc_notify_wait(adapter);
 
 err:
-	dma_free_coherent(&adapter->pdev->dev, cmd.size, cmd.va, cmd.dma);
 	spin_unlock_bh(&adapter->mcc_lock);
+	dma_free_coherent(&adapter->pdev->dev, cmd.size, cmd.va, cmd.dma);
 	return status;
 }
 
-- 
2.49.0


