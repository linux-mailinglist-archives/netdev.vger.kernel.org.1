Return-Path: <netdev+bounces-21303-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A2E763340
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 12:16:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAC3F1C211FB
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 10:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5559FBE62;
	Wed, 26 Jul 2023 10:16:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452FCBE60
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 10:16:11 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF1C1FEC;
	Wed, 26 Jul 2023 03:16:09 -0700 (PDT)
Received: from dggpeml500025.china.huawei.com (unknown [172.30.72.56])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4R9qXJ2rgLzrRqr;
	Wed, 26 Jul 2023 18:15:12 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.202) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 26 Jul 2023 18:16:05 +0800
From: Zhu Wang <wangzhu9@huawei.com>
To: <pablo@netfilter.org>, <kadlec@netfilter.org>, <fw@strlen.de>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <kaber@trash.net>, <netfilter-devel@vger.kernel.org>,
	<coreteam@netfilter.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <wangzhu9@huawei.com>
Subject: [PATCH -next] nf_conntrack: fix -Wunused-const-variable=
Date: Wed, 26 Jul 2023 18:15:31 +0800
Message-ID: <20230726101531.169376-1-wangzhu9@huawei.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.174.202]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500025.china.huawei.com (7.185.36.35)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

When building with W=1, the following warning occurs.

net/netfilter/nf_conntrack_proto_dccp.c:72:27: warning: ‘dccp_state_names’ defined but not used [-Wunused-const-variable=]
 static const char * const dccp_state_names[] = {

We include dccp_state_names in the macro
CONFIG_NF_CONNTRACK_PROCFS, since it is only used in the place
which is included in the macro CONFIG_NF_CONNTRACK_PROCFS.

Fixes: 2bc780499aa3 ("[NETFILTER]: nf_conntrack: add DCCP protocol support")
Signed-off-by: Zhu Wang <wangzhu9@huawei.com>
---
 net/netfilter/nf_conntrack_proto_dccp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/netfilter/nf_conntrack_proto_dccp.c b/net/netfilter/nf_conntrack_proto_dccp.c
index d4fd626d2b8c..e2db1f4ec2df 100644
--- a/net/netfilter/nf_conntrack_proto_dccp.c
+++ b/net/netfilter/nf_conntrack_proto_dccp.c
@@ -69,6 +69,7 @@
 
 #define DCCP_MSL (2 * 60 * HZ)
 
+#ifdef CONFIG_NF_CONNTRACK_PROCFS
 static const char * const dccp_state_names[] = {
 	[CT_DCCP_NONE]		= "NONE",
 	[CT_DCCP_REQUEST]	= "REQUEST",
@@ -81,6 +82,7 @@ static const char * const dccp_state_names[] = {
 	[CT_DCCP_IGNORE]	= "IGNORE",
 	[CT_DCCP_INVALID]	= "INVALID",
 };
+#endif
 
 #define sNO	CT_DCCP_NONE
 #define sRQ	CT_DCCP_REQUEST
-- 
2.17.1


