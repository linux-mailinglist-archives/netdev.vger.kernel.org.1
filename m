Return-Path: <netdev+bounces-38554-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C277BB6B5
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 13:42:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 434E81C209AE
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 11:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE061C6AC;
	Fri,  6 Oct 2023 11:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="aHWPsWrH"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7206A1C6A4
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 11:42:36 +0000 (UTC)
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.219])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 856AACA;
	Fri,  6 Oct 2023 04:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=skzg0
	FxcauA9cDyPuWsiRc28EhNtwMYJk3uNIp52Two=; b=aHWPsWrHQ2Qv9sbpwKOeu
	NoZaMn16SRIIk9xtQ2XYGVbhoR5nUzcE7xR1ou/H+k4mA9rSfZdCKadf+xqvBGzs
	nLM4k3oIxCsWOa/a//ldZbNWJEqJluk5hjmd6ushrDmJbBDeg8Iky0LAbT0gGPUX
	J6mF6vodU/rILF+MhgTol4=
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by zwqz-smtp-mta-g0-4 (Coremail) with SMTP id _____wAHKPRU8h9lnBHVCA--.49032S4;
	Fri, 06 Oct 2023 19:41:10 +0800 (CST)
From: Ma Ke <make_ruc2021@163.com>
To: steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ma Ke <make_ruc2021@163.com>
Subject: [PATCH] net: xfrm: fix return value check in ipcomp_compress
Date: Fri,  6 Oct 2023 19:41:06 +0800
Message-Id: <20231006114106.3982925-1-make_ruc2021@163.com>
X-Mailer: git-send-email 2.37.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAHKPRU8h9lnBHVCA--.49032S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrtw1fWw4rWFW7CFW3Kr43Awb_yoW3CFX_CF
	WIqrsrur90vrn3Aw4kArZxtr9rXan8ur1vqr92qFWDZ34kAas5u3s7XrZxua15GFyDGFy7
	Can0gFZ7AwnxWjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRKSoXUUUUUU==
X-Originating-IP: [183.174.60.14]
X-CM-SenderInfo: 5pdnvshuxfjiisr6il2tof0z/1tbiyBgBC1p7MBefHAAAsf
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

In ipcomp_compress, to avoid an unexpected result returned by
pskb_trim, we should check the return value of pskb_trim().

Signed-off-by: Ma Ke <make_ruc2021@163.com>
---
 net/xfrm/xfrm_ipcomp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_ipcomp.c b/net/xfrm/xfrm_ipcomp.c
index 9c0fa0e1786a..5f2e6edadf48 100644
--- a/net/xfrm/xfrm_ipcomp.c
+++ b/net/xfrm/xfrm_ipcomp.c
@@ -144,7 +144,9 @@ static int ipcomp_compress(struct xfrm_state *x, struct sk_buff *skb)
 	memcpy(start + sizeof(struct ip_comp_hdr), scratch, dlen);
 	local_bh_enable();
 
-	pskb_trim(skb, dlen + sizeof(struct ip_comp_hdr));
+	err = pskb_trim(skb, dlen + sizeof(struct ip_comp_hdr));
+	if (unlikely(err))
+		goto out;
 	return 0;
 
 out:
-- 
2.37.2


