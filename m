Return-Path: <netdev+bounces-38931-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C94107BD1BD
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 03:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CCF228145C
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 01:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D4A5A5B;
	Mon,  9 Oct 2023 01:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ULOEteny"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B04ECC
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 01:15:04 +0000 (UTC)
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.220])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 81678B9;
	Sun,  8 Oct 2023 18:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=965mj
	5bVJjuRzIOLXKTTNC1mfCFD/qdXMo0Guhu3pSw=; b=ULOEtenyqgcNc2uzC7/Af
	wWGepiCUOuDbuuk8mDbLeFn6Vb76+yt+pEFLHTdxUUAIG72lfN5GDSKZb/5yG6Cy
	pK5892XrSyYYhma3g8U+RgWjPrSAhd3t9/8KsA6UX0mrbGeCCPwXhdWHh4FM6dhO
	QPfgQH0ho1IWSUsmFywoVE=
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by zwqz-smtp-mta-g2-3 (Coremail) with SMTP id _____wD3nxzCUyNl60QnAA--.26088S4;
	Mon, 09 Oct 2023 09:13:47 +0800 (CST)
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
Subject: [PATCH] net: ipv4: fix return value check in esp_remove_trailer
Date: Mon,  9 Oct 2023 09:13:37 +0800
Message-Id: <20231009011337.4037007-1-make_ruc2021@163.com>
X-Mailer: git-send-email 2.37.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3nxzCUyNl60QnAA--.26088S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrZFyUXr4rXr48Xr1DAFW8JFb_yoWxtFg_Ga
	9rXr4kW3W8uFn7ZF43Zr47tFy5t348XFWFvF1ftayavwnrAw1rJws7CrZ8u3sxGa9rCr13
	AFnxCrWIyas0vjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRKJ5rDUUUUU==
X-Originating-IP: [183.174.60.14]
X-CM-SenderInfo: 5pdnvshuxfjiisr6il2tof0z/xtbBFRsEC2B9obSsEQAAs0
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
 net/ipv4/esp4.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/esp4.c b/net/ipv4/esp4.c
index 2be2d4922557..d18f0f092fe7 100644
--- a/net/ipv4/esp4.c
+++ b/net/ipv4/esp4.c
@@ -732,7 +732,9 @@ static inline int esp_remove_trailer(struct sk_buff *skb)
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


