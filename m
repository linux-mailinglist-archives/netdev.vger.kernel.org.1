Return-Path: <netdev+bounces-26409-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B6A3777B83
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 17:02:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C8A01C216A2
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 15:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F40FE20C90;
	Thu, 10 Aug 2023 15:02:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99C01E1A2
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 15:02:04 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E8A626A0
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 08:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1691679723;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3/393wVI5/GqRQQmOEXqSiJXKHeXR9FBuoEp+UQjMWA=;
	b=PjCoa7B4slJBSyX+ETRUue9nHQE7DxbRX+XfjRBILqKIVrhofbklORluq3NyLd9VBMvM3J
	mMyDZOE17XCJQv6gvUxAHwq4VHFby90QxLAYxT9CT5RjAoO6rWoHpjYbaZCXt4k3dlY2Sv
	5k6zGLTby6s47dFPPduFdmt8/TXMJbE=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-379-7siDwGVTOX6l4y1ffdxdTg-1; Thu, 10 Aug 2023 11:01:58 -0400
X-MC-Unique: 7siDwGVTOX6l4y1ffdxdTg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 50DC33C0DDC2;
	Thu, 10 Aug 2023 15:01:57 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.45.226.68])
	by smtp.corp.redhat.com (Postfix) with ESMTP id DA1B340C125C;
	Thu, 10 Aug 2023 15:01:55 +0000 (UTC)
From: Michal Schmidt <mschmidt@redhat.com>
To: netdev@vger.kernel.org
Cc: Veerasenareddy Burru <vburru@marvell.com>,
	Sathesh Edara <sedara@marvell.com>,
	"David S. Miller" <davem@davemloft.net>,
	Abhijit Ayarekar <aayarekar@marvell.com>,
	Satananda Burla <sburla@marvell.com>,
	Vimlesh Kumar <vimleshk@marvell.com>
Subject: [PATCH net 2/4] octeon_ep: cancel tx_timeout_task later in remove sequence
Date: Thu, 10 Aug 2023 17:01:12 +0200
Message-ID: <20230810150114.107765-3-mschmidt@redhat.com>
In-Reply-To: <20230810150114.107765-1-mschmidt@redhat.com>
References: <20230810150114.107765-1-mschmidt@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

tx_timeout_task is canceled too early when removing the driver. Nothing
prevents .ndo_tx_timeout from triggering and queuing the work again.

Better cancel it after the netdev is unregistered.
It's harmless for octep_tx_timeout_task to run in the window between the
unregistration and cancelation, because it checks netif_running.

Fixes: 862cd659a6fb ("octeon_ep: Add driver framework and device initialization")
Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
---
 drivers/net/ethernet/marvell/octeon_ep/octep_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
index 43eb6e871351..d8066bff5f7b 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
@@ -1200,12 +1200,12 @@ static void octep_remove(struct pci_dev *pdev)
 	if (!oct)
 		return;
 
-	cancel_work_sync(&oct->tx_timeout_task);
 	cancel_work_sync(&oct->ctrl_mbox_task);
 	netdev = oct->netdev;
 	if (netdev->reg_state == NETREG_REGISTERED)
 		unregister_netdev(netdev);
 
+	cancel_work_sync(&oct->tx_timeout_task);
 	oct->poll_non_ioq_intr = false;
 	cancel_delayed_work_sync(&oct->intr_poll_task);
 	octep_device_cleanup(oct);
-- 
2.41.0


