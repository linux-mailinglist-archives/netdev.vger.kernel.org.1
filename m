Return-Path: <netdev+bounces-40618-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A28B7C7E56
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 09:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 175E8B2085C
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 07:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E9C4D279;
	Fri, 13 Oct 2023 07:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="bgcKwGfH"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9BE5692
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 07:05:27 +0000 (UTC)
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.199])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id C5FC5B7;
	Fri, 13 Oct 2023 00:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=frMwB
	+yQcrqfw7+mUC1RLpFWBfRdjTmzx1BGRb9nPkY=; b=bgcKwGfHHQLttJDR/zMLu
	yNDKelR5y7v871iubA92RBIKiOGPXIx2bs5JZcWRTJLe1NANMVqZXPh7HiFJ7AQo
	CNTJHEsYpvnCmyWhHsIaaeGFw7oBGh8BFTH5/bqD95iE+A4nm/b3/imnEO9W2WmK
	sZeR1GX1E1p6kIW6BZiqvs=
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by zwqz-smtp-mta-g4-4 (Coremail) with SMTP id _____wD3_9Dr6yhlQ_y2AQ--.20479S4;
	Fri, 13 Oct 2023 15:04:20 +0800 (CST)
From: Ma Ke <make_ruc2021@163.com>
To: jmaloy@redhat.com,
	ying.xue@windriver.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Ma Ke <make_ruc2021@163.com>
Subject: [PATCH] tipc: Fix uninit-value access in tipc_nl_node_get_link()
Date: Fri, 13 Oct 2023 15:04:08 +0800
Message-Id: <20231013070408.1979343-1-make_ruc2021@163.com>
X-Mailer: git-send-email 2.37.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3_9Dr6yhlQ_y2AQ--.20479S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7Wr4rCw4ktrW5WFyxJFW8WFg_yoWfJFX_Z3
	92g3yfAry8J39Yyr4DXa95JrZ3Jan8G3Z5uw1akryUK34DCrWrZan5JFn8CrW3urZ7u3sr
	Ga40vF1fXF12qjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRMg4SUUUUUU==
X-Originating-IP: [183.174.60.14]
X-CM-SenderInfo: 5pdnvshuxfjiisr6il2tof0z/1tbivggIC1ZcjGryowAAsI
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Names must be null-terminated strings. If a name which is not 
null-terminated is passed through netlink, strstr() and similar 
functions can cause buffer overrun. This patch fixes this issue 
by returning -EINVAL if a non-null-terminated name is passed.

Signed-off-by: Ma Ke <make_ruc2021@163.com>
---
 net/tipc/node.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/tipc/node.c b/net/tipc/node.c
index 3105abe97bb9..a02bcd7e07d3 100644
--- a/net/tipc/node.c
+++ b/net/tipc/node.c
@@ -2519,6 +2519,9 @@ int tipc_nl_node_get_link(struct sk_buff *skb, struct genl_info *info)
 		return -EINVAL;
 
 	name = nla_data(attrs[TIPC_NLA_LINK_NAME]);
+	if (name[strnlen(name,
+			 nla_len(attrs[TIPC_NLA_LINK_NAME]))] != '\0')
+		return -EINVAL;
 
 	msg.skb = nlmsg_new(NLMSG_GOODSIZE, GFP_KERNEL);
 	if (!msg.skb)
-- 
2.37.2


