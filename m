Return-Path: <netdev+bounces-35945-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 617307AC195
	for <lists+netdev@lfdr.de>; Sat, 23 Sep 2023 13:59:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 5D5EA2821A4
	for <lists+netdev@lfdr.de>; Sat, 23 Sep 2023 11:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41ACA168B2;
	Sat, 23 Sep 2023 11:59:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B9E15EA8
	for <netdev@vger.kernel.org>; Sat, 23 Sep 2023 11:59:38 +0000 (UTC)
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.197])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id AEDCB136
	for <netdev@vger.kernel.org>; Sat, 23 Sep 2023 04:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=oEIOUKOx6SL1dkWenR
	Tn6sYop3/SUjiVN8yafWn0imE=; b=lClsnUCsRFP5LLxzx2wu/AuyaW2WFDmYhQ
	ZPsW2aDaJ0RDY8lYQatmdlLt8xG7x8XANGOuiNoK80fab7k/e8Bj5rQePM3rHWZg
	KTklyKBVsdoTTnl1JcA6azJxleT8Fsp4B0RYiBAH3Xg3WwBK+SBW5uG4PljU5+K6
	oVzCoZ0uQ=
Received: from localhost.localdomain (unknown [223.104.131.178])
	by zwqz-smtp-mta-g4-0 (Coremail) with SMTP id _____wBn9UUE0w5lAxxfCw--.52009S2;
	Sat, 23 Sep 2023 19:59:02 +0800 (CST)
From: liuhaoran <liuhaoran14@163.com>
To: davem@davemloft.net
Cc: edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	liuhaoran <liuhaoran14@163.com>
Subject: [PATCH] net: phonet: Add error handling in phonet_device_init
Date: Sat, 23 Sep 2023 19:58:47 +0800
Message-Id: <20230923115847.32740-1-liuhaoran14@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:_____wBn9UUE0w5lAxxfCw--.52009S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Gr15tr4rXrWrGw48XrWkZwb_yoWDurX_ZF
	WI9348Zr40gF18G3y5Ar43Zry3JF4kKr4fWFn8Xas3GaykGrWUur4DZr1xAFW3WFWYvry5
	X3W7CryfX3W7ujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUjS_MDUUUUU==
X-Originating-IP: [223.104.131.178]
X-CM-SenderInfo: xolxxtxrud0iqu6rljoofrz/1tbibAfzgmNfuLIHSAAAsj
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_BL,
	RCVD_IN_MSPIKE_L4,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

This patch adds error-handling for the proc_create_net() and
register_netdevice_notifier() inside the phonet_device_init.

Signed-off-by: liuhaoran <liuhaoran14@163.com>
---
 net/phonet/pn_dev.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/net/phonet/pn_dev.c b/net/phonet/pn_dev.c
index cde671d29d5d..c974b64d52b9 100644
--- a/net/phonet/pn_dev.c
+++ b/net/phonet/pn_dev.c
@@ -336,10 +336,19 @@ int __init phonet_device_init(void)
 	if (err)
 		return err;
 
-	proc_create_net("pnresource", 0, init_net.proc_net, &pn_res_seq_ops,
-			sizeof(struct seq_net_private));
-	register_netdevice_notifier(&phonet_device_notifier);
+	err = proc_create_net("pnresource", 0, init_net.proc_net, &pn_res_seq_ops,
+			      sizeof(struct seq_net_private));
+
+	if (!err)
+		return err;
+
+	err = register_netdevice_notifier(&phonet_device_notifier);
+
+	if (!err)
+		return err;
+
 	err = phonet_netlink_register();
+
 	if (err)
 		phonet_device_exit();
 	return err;
-- 
2.17.1


