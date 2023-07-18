Return-Path: <netdev+bounces-18455-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 367C775721C
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 05:17:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D7C6281274
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 03:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B30C17F5;
	Tue, 18 Jul 2023 03:17:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302A317CE
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 03:17:30 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73309E76;
	Mon, 17 Jul 2023 20:17:29 -0700 (PDT)
Received: from dggpeml500019.china.huawei.com (unknown [172.30.72.56])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4R4kd81C3DzrRnm;
	Tue, 18 Jul 2023 11:16:44 +0800 (CST)
Received: from localhost.localdomain (10.90.76.33) by
 dggpeml500019.china.huawei.com (7.185.36.137) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 18 Jul 2023 11:17:26 +0800
From: Chenyuan Mi <michenyuan@huawei.com>
To: <isdn@linux-pingi.de>
CC: <marcel@holtmann.org>, <johan.hedberg@gmail.com>, <luiz.dentz@gmail.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] bluetooth: unregister correct BTPROTO for CMTP
Date: Tue, 18 Jul 2023 03:38:04 +0000
Message-ID: <20230718033804.2601559-1-michenyuan@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.90.76.33]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500019.china.huawei.com (7.185.36.137)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On error unregister BTPROTO_CMTP to match the registration 
earlier in the same code-path. Without this change BTPROTO_HIDP 
is incorrectly unregistered.

This bug does not appear to cause serious security problem.

The function 'bt_sock_unregister' takes its parameter as an index 
and NULLs the corresponding element of 'bt_proto' which is an 
array of pointers. When 'bt_proto' dereferences each element, 
it would check whether the element is empty or not. Therefore, 
the problem of null pointer deference does not occur.

Found by inspection.

Fixes: 8c8de589cedd ("Bluetooth: Added /proc/net/cmtp via bt_procfs_init()")
Signed-off-by: Chenyuan Mi <michenyuan@huawei.com>
---
 net/bluetooth/cmtp/sock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/cmtp/sock.c b/net/bluetooth/cmtp/sock.c
index 96d49d9fae96..cf4370055ce2 100644
--- a/net/bluetooth/cmtp/sock.c
+++ b/net/bluetooth/cmtp/sock.c
@@ -250,7 +250,7 @@ int cmtp_init_sockets(void)
 	err = bt_procfs_init(&init_net, "cmtp", &cmtp_sk_list, NULL);
 	if (err < 0) {
 		BT_ERR("Failed to create CMTP proc file");
-		bt_sock_unregister(BTPROTO_HIDP);
+		bt_sock_unregister(BTPROTO_CMTP);
 		goto error;
 	}
 
-- 
2.25.1


