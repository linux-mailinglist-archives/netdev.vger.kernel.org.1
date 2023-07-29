Return-Path: <netdev+bounces-22558-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7184768053
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 17:15:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32E0828239E
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 15:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C742168D3;
	Sat, 29 Jul 2023 15:15:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312173D60
	for <netdev@vger.kernel.org>; Sat, 29 Jul 2023 15:15:49 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C739C1BE5
	for <netdev@vger.kernel.org>; Sat, 29 Jul 2023 08:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690643748;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EOm3XXeQH/VnjIfi+1wNPzalu9P/P8SBxT9b035Ot8s=;
	b=A0J6lWb+6fMRz5FpOpYwzrFJ9NTIZRDgwYBAvXlGihGHxfssT5TSCeLtCa9iiaZxgxXLct
	dlcCHMjUuMxz0NWcapkY+f6RZDrh6A3eF+AQBeReCzXCTy2nDx8YU9IvRC1TgyeChRmAkb
	Hycs/iFC3aV5VlmqLZt+0m3vmRHtrHk=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-378-av-JrdHYNveMTYi5l4Hkfw-1; Sat, 29 Jul 2023 11:15:39 -0400
X-MC-Unique: av-JrdHYNveMTYi5l4Hkfw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7FAC61C0432A;
	Sat, 29 Jul 2023 15:15:38 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.45.224.50])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8D2B940C2063;
	Sat, 29 Jul 2023 15:15:36 +0000 (UTC)
From: Michal Schmidt <mschmidt@redhat.com>
To: netdev@vger.kernel.org
Cc: Abhijit Ayarekar <aayarekar@marvell.com>,
	Veerasenareddy Burru <vburru@marvell.com>,
	Vimlesh Kumar <vimleshk@marvell.com>,
	Shinas Rasheed <srasheed@marvell.com>,
	Sathesh Edara <sedara@marvell.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH net] octeon_ep: initialize mbox mutexes
Date: Sat, 29 Jul 2023 17:15:16 +0200
Message-ID: <20230729151516.24153-1-mschmidt@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The two mbox-related mutexes are destroyed in octep_ctrl_mbox_uninit(),
but the corresponding mutex_init calls were missing.
A "DEBUG_LOCKS_WARN_ON(lock->magic != lock)" warning was emitted with
CONFIG_DEBUG_MUTEXES on.

Initialize the two mutexes in octep_ctrl_mbox_init().

Fixes: 577f0d1b1c5f ("octeon_ep: add separate mailbox command and response queues")
Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
---
 drivers/net/ethernet/marvell/octeon_ep/octep_ctrl_mbox.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_ctrl_mbox.c b/drivers/net/ethernet/marvell/octeon_ep/octep_ctrl_mbox.c
index 035ead7935c7..dab61cc1acb5 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_ctrl_mbox.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_ctrl_mbox.c
@@ -98,6 +98,9 @@ int octep_ctrl_mbox_init(struct octep_ctrl_mbox *mbox)
 	writeq(OCTEP_CTRL_MBOX_STATUS_INIT,
 	       OCTEP_CTRL_MBOX_INFO_HOST_STATUS(mbox->barmem));
 
+	mutex_init(&mbox->h2fq_lock);
+	mutex_init(&mbox->f2hq_lock);
+
 	mbox->h2fq.sz = readl(OCTEP_CTRL_MBOX_H2FQ_SZ(mbox->barmem));
 	mbox->h2fq.hw_prod = OCTEP_CTRL_MBOX_H2FQ_PROD(mbox->barmem);
 	mbox->h2fq.hw_cons = OCTEP_CTRL_MBOX_H2FQ_CONS(mbox->barmem);
-- 
2.41.0


