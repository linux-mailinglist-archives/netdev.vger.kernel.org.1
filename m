Return-Path: <netdev+bounces-35950-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CDE47AC214
	for <lists+netdev@lfdr.de>; Sat, 23 Sep 2023 14:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 71CEF28209F
	for <lists+netdev@lfdr.de>; Sat, 23 Sep 2023 12:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6244DF68;
	Sat, 23 Sep 2023 12:42:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE252C9A
	for <netdev@vger.kernel.org>; Sat, 23 Sep 2023 12:42:20 +0000 (UTC)
X-Greylist: delayed 914 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 23 Sep 2023 05:42:17 PDT
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.220])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id CA483127
	for <netdev@vger.kernel.org>; Sat, 23 Sep 2023 05:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=1tGQol1OkNCpX873Rs
	xyCKr8og6+XnUFuMEy5C62rF0=; b=pmDMQS6IMb6BKRHDn6OXof/qEDis55beFK
	pOgLoCWfNHJsdyK2aZopLbZJSjFPkEFMd/11k0bPhLlSjtjBeSR/1K7dQ7UVChe3
	v2PjAqYLp89hrLnyvzYC0LUO5WbPfchhfKyn90Rh6iSzaoeA+QoU1tHBAwC2fW9d
	oMNmh4jYU=
Received: from localhost.localdomain (unknown [223.104.131.178])
	by zwqz-smtp-mta-g1-2 (Coremail) with SMTP id _____wD3RB7u2A5lISShCw--.51491S2;
	Sat, 23 Sep 2023 20:24:16 +0800 (CST)
From: liuhaoran <liuhaoran14@163.com>
To: davem@davemloft.net
Cc: edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	liuhaoran <liuhaoran14@163.com>
Subject: [PATCH] net: hsr: Add error handling in hsr_portdev_setup()
Date: Sat, 23 Sep 2023 20:24:02 +0800
Message-Id: <20230923122402.33851-1-liuhaoran14@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:_____wD3RB7u2A5lISShCw--.51491S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Gw4xtF4xKFWDJF43Cry7trb_yoWxAFg_tw
	4kAFyrXr4UGFZrGw4xCr4fJF93J3WFgF1rWFW3tFW8Wa4UA39rWw18ZwnxGr1IgF43uryU
	Zws3W3yFvwnYkjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUjS_MDUUUUU==
X-Originating-IP: [223.104.131.178]
X-CM-SenderInfo: xolxxtxrud0iqu6rljoofrz/1tbiThLzgmNh-P4ABAAAsp
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

This patch adds error-handling for the hsr_port_get_hsr()
inside the hsr_portdev_setup().

Signed-off-by: liuhaoran <liuhaoran14@163.com>
---
 net/hsr/hsr_slave.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/hsr/hsr_slave.c b/net/hsr/hsr_slave.c
index e5742f2a2d52..ac7d6bdef47e 100644
--- a/net/hsr/hsr_slave.c
+++ b/net/hsr/hsr_slave.c
@@ -141,6 +141,10 @@ static int hsr_portdev_setup(struct hsr_priv *hsr, struct net_device *dev,
 	}
 
 	master = hsr_port_get_hsr(hsr, HSR_PT_MASTER);
+
+	if (!master)
+		return -ENODEV;
+
 	hsr_dev = master->dev;
 
 	res = netdev_upper_dev_link(dev, hsr_dev, extack);
-- 
2.17.1


