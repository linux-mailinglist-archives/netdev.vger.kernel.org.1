Return-Path: <netdev+bounces-20139-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2560C75DCE9
	for <lists+netdev@lfdr.de>; Sat, 22 Jul 2023 16:26:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 585E9282014
	for <lists+netdev@lfdr.de>; Sat, 22 Jul 2023 14:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 274991DDFB;
	Sat, 22 Jul 2023 14:26:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DE44431
	for <netdev@vger.kernel.org>; Sat, 22 Jul 2023 14:26:11 +0000 (UTC)
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.196])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 461ED2727
	for <netdev@vger.kernel.org>; Sat, 22 Jul 2023 07:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=uY0o/yYycp9/jc2nXJ
	Kgr8NSJVhRM/y4Mb9iUJRnOck=; b=EBxTk8Ocl9Yyb1eWJSKwn2YoyA2MJUTRQ5
	iti+mxGUxczmAIwlRKaHaAovZoTBeUOykPz98WrEz6JZTYTTKDIvGOJSejvBLyFO
	mIgQSQT1+R7ohJvP31QS3SjYhULGx1Re/jXadxL4tutUelRbTWm2LbjsNgVIIeZx
	tgCgeqhHE=
Received: from localhost.localdomain (unknown [202.112.113.212])
	by zwqz-smtp-mta-g4-2 (Coremail) with SMTP id _____wAnZ4nI5rtkpTQZBA--.54732S4;
	Sat, 22 Jul 2023 22:25:18 +0800 (CST)
From: Yuanjun Gong <ruc_gongyuanjun@163.com>
To: kuniyu@amazon.com
Cc: chris.snook@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	ruc_gongyuanjun@163.com
Subject: [PATCH net v2 1/1] atheros: fix return value check in atl1_tso()
Date: Sat, 22 Jul 2023 22:25:11 +0800
Message-Id: <20230722142511.12448-1-ruc_gongyuanjun@163.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230720220820.40712-1-kuniyu@amazon.com>
References: <20230720220820.40712-1-kuniyu@amazon.com>
X-CM-TRANSID:_____wAnZ4nI5rtkpTQZBA--.54732S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrZFy5ZFykur1xXw4kXFWkWFg_yoWDurXEg3
	4Ig3Z7JF4UWw15tr4UGr4UurWj9ws7WFykZFW8KFZxGrZxGry8Zw1v9FZ7AryDGr4UJr9x
	Gw13uayUA345KjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRNF4iUUUUUU==
X-Originating-IP: [202.112.113.212]
X-CM-SenderInfo: 5uxfsw5rqj53pdqm30i6rwjhhfrp/xtbBiA+05VaEF4OtXwAAsi
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

in atl1_tso(), it should check the return value of pskb_trim(),
and return an error code if an unexpected value is returned
by pskb_trim().

Fixes: 401c0aabec4b ("atl1: simplify tx packet descriptor")
Signed-off-by: Yuanjun Gong <ruc_gongyuanjun@163.com>
---
 drivers/net/ethernet/atheros/atlx/atl1.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/atheros/atlx/atl1.c b/drivers/net/ethernet/atheros/atlx/atl1.c
index c8444bcdf527..02aa6fd8ebc2 100644
--- a/drivers/net/ethernet/atheros/atlx/atl1.c
+++ b/drivers/net/ethernet/atheros/atlx/atl1.c
@@ -2113,8 +2113,11 @@ static int atl1_tso(struct atl1_adapter *adapter, struct sk_buff *skb,
 
 			real_len = (((unsigned char *)iph - skb->data) +
 				ntohs(iph->tot_len));
-			if (real_len < skb->len)
-				pskb_trim(skb, real_len);
+			if (real_len < skb->len) {
+				err = pskb_trim(skb, real_len);
+				if (err)
+					return err;
+			}
 			hdr_len = skb_tcp_all_headers(skb);
 			if (skb->len == hdr_len) {
 				iph->check = 0;
-- 
2.17.1


