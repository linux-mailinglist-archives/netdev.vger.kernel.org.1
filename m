Return-Path: <netdev+bounces-38721-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA34C7BC374
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 03:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BD2F2814F1
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 01:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 942ED7E2;
	Sat,  7 Oct 2023 01:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="gWy5TQoj"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077AE1119
	for <netdev@vger.kernel.org>; Sat,  7 Oct 2023 01:01:36 +0000 (UTC)
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.199])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 83C52B6;
	Fri,  6 Oct 2023 18:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=C1iUt
	QXJHDHL2bLy/guQSpAx1+CMVbpIrJoept/H6sM=; b=gWy5TQojfPdZcHwTYEjpK
	3mmV/t0FcLRVPemluFhFeoY5rDQBhgRIxXk4qfCsfs2fiov4+wZe/Xf6tFy1k8xX
	lLdB08TFbSijxcU3fYF9dUulDdueMy9uCrakOrJnzDT8hkGZQl1xlqKFsIPanRZy
	2VReAZ2ybmfiDu4/LKpils=
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by zwqz-smtp-mta-g4-1 (Coremail) with SMTP id _____wDn+46KrSBl6sNMEA--.49925S4;
	Sat, 07 Oct 2023 09:00:04 +0800 (CST)
From: Ma Ke <make_ruc2021@163.com>
To: steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ma Ke <make_ruc2021@163.com>
Subject: [PATCH] net: ipv6: fix return value check in esp_remove_trailer
Date: Sat,  7 Oct 2023 08:59:53 +0800
Message-Id: <20231007005953.3994960-1-make_ruc2021@163.com>
X-Mailer: git-send-email 2.37.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDn+46KrSBl6sNMEA--.49925S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrZFyUXr4rXr18Zw18Zw45GFg_yoWxtFg_Ga
	9rXrWkWr18uF4kAw4Svr42vFy5trW8ZFWfZFyft3yfZw17Aw1rJrs7urZ8ZrZxGas7Cry3
	CFsxCrW7t34SqjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRKfHUJUUUUU==
X-Originating-IP: [183.174.60.14]
X-CM-SenderInfo: 5pdnvshuxfjiisr6il2tof0z/1tbivhcCC1ZcjAANoQAAsK
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

In esp_remove_trailer(), to avoid an unexpected result returned by
pskb_trim, we should check the return value of pskb_trim().

Signed-off-by: Ma Ke <make_ruc2021@163.com>
---
 net/ipv6/esp6.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/esp6.c b/net/ipv6/esp6.c
index fddd0cbdede1..e023d29e919c 100644
--- a/net/ipv6/esp6.c
+++ b/net/ipv6/esp6.c
@@ -770,7 +770,9 @@ static inline int esp_remove_trailer(struct sk_buff *skb)
 		skb->csum = csum_block_sub(skb->csum, csumdiff,
 					   skb->len - trimlen);
 	}
-	pskb_trim(skb, skb->len - trimlen);
+	ret = pskb_trim(skb, skb->len - trimlen);
+	if (unlikely(ret))
+		return ret;
 
 	ret = nexthdr[1];
 
-- 
2.37.2


