Return-Path: <netdev+bounces-19524-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C9FE75B16D
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 16:42:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3DDF281ED6
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 14:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D919A182B5;
	Thu, 20 Jul 2023 14:42:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9DC1801D
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 14:42:36 +0000 (UTC)
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.198])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id C9489C6
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 07:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=oj3Z/kiD7CFcINgw1p
	oMg6liKsRfSDr1aJY73Q7JK5A=; b=ahFlSlz1RZJ9QnAQ+mDLmE1szsWHglDo9w
	Kn4WVo1drOSOdlgZ7r/X765ayx7idpiA44C/RK6OjgXlic5IoeyT7kcGkfdh8G9D
	R8KeEuoyXK15soTBmeqoGV4/EroN0s96u75OULfJITXMsRZ8U6vCZ0CB3BotgSnE
	4q3hSFV0s=
Received: from localhost.localdomain (unknown [202.112.113.212])
	by zwqz-smtp-mta-g5-1 (Coremail) with SMTP id _____wD3_5e1R7lkrdBSAw--.56741S4;
	Thu, 20 Jul 2023 22:42:03 +0800 (CST)
From: Yuanjun Gong <ruc_gongyuanjun@163.com>
To: Chris Snook <chris.snook@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org
Cc: Yuanjun Gong <ruc_gongyuanjun@163.com>
Subject: [PATCH 1/1] ethernet: atheros: fix return value check in atl1_tso()
Date: Thu, 20 Jul 2023 22:41:54 +0800
Message-Id: <20230720144154.38922-1-ruc_gongyuanjun@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:_____wD3_5e1R7lkrdBSAw--.56741S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrtw1fWw1UGw4kKw1DKr1fCrg_yoWDGwbEg3
	4Ig3Z3Ja1jgw15tr4UGr4UurWj9ws7uFykZFW8KFZxGrZrGry8Zr1kuFZ7AryDGrWUJr9x
	GwnxuayUAa45KjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRNF4iUUUUUU==
X-Originating-IP: [202.112.113.212]
X-CM-SenderInfo: 5uxfsw5rqj53pdqm30i6rwjhhfrp/xtbBSRiy5VaEH7aMIgAAsT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L4,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

in atl1_tso, it should check the return value of pskb_trim(),
and return an error code if an unexpected value is returned
by pskb_trim().

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


