Return-Path: <netdev+bounces-41450-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 263567CB032
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 18:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB178B20F5D
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 16:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD9A30D06;
	Mon, 16 Oct 2023 16:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EDcDlvM7"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB3F30D1E
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 16:49:20 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8957D7D
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 09:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697474957;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WxgT4ChEwfrDs1ogyZ0o9n+nDWStVYTy5SaXPfocvs8=;
	b=EDcDlvM79nCcIqaa8WvhMxZbz9evEbBDtnS9HJ963FeYW5wwwbXvU22mkfAwzK9pI1Rul9
	9RLt/kBDEqzIkO03BHJlEBubwY6imoT+dv1c0iIWU/0t1G2ncbpKn4DYQ+OkOZ5dfcIqVd
	QHZREq7ZOKCC3rwj8NZtKY3sEZvN658=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-423-cRBapmiwP3qLcN52jGjL-A-1; Mon, 16 Oct 2023 12:49:05 -0400
X-MC-Unique: cRBapmiwP3qLcN52jGjL-A-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3ADCD185A790;
	Mon, 16 Oct 2023 16:49:05 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.45.224.24])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0EAD9492BEF;
	Mon, 16 Oct 2023 16:49:03 +0000 (UTC)
From: Michal Schmidt <mschmidt@redhat.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	netdev@vger.kernel.org
Subject: [PATCH iwl-next 2/4] iavf: use unregister_netdev
Date: Mon, 16 Oct 2023 18:48:47 +0200
Message-ID: <20231016164849.45691-3-mschmidt@redhat.com>
In-Reply-To: <20231016164849.45691-1-mschmidt@redhat.com>
References: <20231016164849.45691-1-mschmidt@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Use unregister_netdev, which takes rtnl_lock for us. We don't have to
check the reg_state under rtnl_lock. There's nothing to race with. We
have just cancelled the finish_config work.

Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index d2f4648a6156..6036a4582196 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -5171,10 +5171,8 @@ static void iavf_remove(struct pci_dev *pdev)
 	cancel_delayed_work_sync(&adapter->watchdog_task);
 	cancel_work_sync(&adapter->finish_config);
 
-	rtnl_lock();
 	if (netdev->reg_state == NETREG_REGISTERED)
-		unregister_netdevice(netdev);
-	rtnl_unlock();
+		unregister_netdev(netdev);
 
 	if (CLIENT_ALLOWED(adapter)) {
 		err = iavf_lan_del_device(adapter);
-- 
2.41.0


