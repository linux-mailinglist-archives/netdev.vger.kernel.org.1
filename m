Return-Path: <netdev+bounces-30559-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03E8E788030
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 08:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBAA31C20F30
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 06:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618B417F4;
	Fri, 25 Aug 2023 06:47:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5263917EA
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 06:47:10 +0000 (UTC)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CF68CE;
	Thu, 24 Aug 2023 23:47:07 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R571e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0VqW2QpI_1692946019;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VqW2QpI_1692946019)
          by smtp.aliyun-inc.com;
          Fri, 25 Aug 2023 14:47:05 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: socketcan@hartkopp.net
Cc: mkl@pengutronix.de,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] can: raw: Remove NULL check before dev_{put, hold}
Date: Fri, 25 Aug 2023 14:46:56 +0800
Message-Id: <20230825064656.87751-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The call netdev_{put, hold} of dev_{put, hold} will check NULL, so there
is no need to check before using dev_{put, hold}, remove it to silence
the warning:

./net/can/raw.c:497:2-9: WARNING: NULL check before dev_{put, hold} functions is not needed.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=6231
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 net/can/raw.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/can/raw.c b/net/can/raw.c
index d50c3f3d892f..ff7797c37018 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -493,8 +493,7 @@ static int raw_bind(struct socket *sock, struct sockaddr *uaddr, int len)
 
 out_put_dev:
 	/* remove potential reference from dev_get_by_index() */
-	if (dev)
-		dev_put(dev);
+	dev_put(dev);
 out:
 	release_sock(sk);
 	rtnl_unlock();
-- 
2.20.1.7.g153144c


