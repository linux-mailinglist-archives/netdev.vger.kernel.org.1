Return-Path: <netdev+bounces-21933-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73184765533
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 15:36:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3E6E1C2166D
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 13:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C34D171D4;
	Thu, 27 Jul 2023 13:36:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22095174D6
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 13:36:22 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1972272C;
	Thu, 27 Jul 2023 06:36:20 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1qP1A4-0003De-Kf; Thu, 27 Jul 2023 15:36:12 +0200
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	<netfilter-devel@vger.kernel.org>,
	Zhu Wang <wangzhu9@huawei.com>,
	Simon Horman <simon.horman@corigine.com>
Subject: [PATCH net-next 1/5] nf_conntrack: fix -Wunused-const-variable=
Date: Thu, 27 Jul 2023 15:35:56 +0200
Message-ID: <20230727133604.8275-2-fw@strlen.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230727133604.8275-1-fw@strlen.de>
References: <20230727133604.8275-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Zhu Wang <wangzhu9@huawei.com>

When building with W=1, the following warning occurs.

net/netfilter/nf_conntrack_proto_dccp.c:72:27: warning: ‘dccp_state_names’ defined but not used [-Wunused-const-variable=]
 static const char * const dccp_state_names[] = {

We include dccp_state_names in the macro
CONFIG_NF_CONNTRACK_PROCFS, since it is only used in the place
which is included in the macro CONFIG_NF_CONNTRACK_PROCFS.

Fixes: 2bc780499aa3 ("[NETFILTER]: nf_conntrack: add DCCP protocol support")
Signed-off-by: Zhu Wang <wangzhu9@huawei.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: Florian Westphal <fw@strlen.de>
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
2.41.0


