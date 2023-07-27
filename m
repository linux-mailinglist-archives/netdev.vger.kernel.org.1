Return-Path: <netdev+bounces-21936-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 345B276553A
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 15:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 124501C2163D
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 13:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FBD9174C6;
	Thu, 27 Jul 2023 13:36:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946011640A
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 13:36:32 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF7C272C;
	Thu, 27 Jul 2023 06:36:31 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1qP1AG-0003Ep-S0; Thu, 27 Jul 2023 15:36:24 +0200
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	<netfilter-devel@vger.kernel.org>,
	Lin Ma <linma@zju.edu.cn>,
	Simon Horman <simon.horman@corigine.com>
Subject: [PATCH net-next 4/5] netfilter: conntrack: validate cta_ip via parsing
Date: Thu, 27 Jul 2023 15:35:59 +0200
Message-ID: <20230727133604.8275-5-fw@strlen.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230727133604.8275-1-fw@strlen.de>
References: <20230727133604.8275-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Lin Ma <linma@zju.edu.cn>

In current ctnetlink_parse_tuple_ip() function, nested parsing and
validation is splitting as two parts,  which could be cleanup to a
simplified form. As the nla_parse_nested_deprecated function
supports validation in the fly. These two finially reach same place
__nla_validate_parse with same validate flag.

nla_parse_nested_deprecated
  __nla_parse(.., NL_VALIDATE_LIBERAL, ..)
    __nla_validate_parse

nla_validate_nested_deprecated
  __nla_validate_nested(.., NL_VALIDATE_LIBERAL, ..)
    __nla_validate
      __nla_validate_parse

This commit removes the call to nla_validate_nested_deprecated and pass
cta_ip_nla_policy when do parsing.

Signed-off-by: Lin Ma <linma@zju.edu.cn>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/netfilter/nf_conntrack_netlink.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/net/netfilter/nf_conntrack_netlink.c b/net/netfilter/nf_conntrack_netlink.c
index 69c8c8c7e9b8..334db22199c1 100644
--- a/net/netfilter/nf_conntrack_netlink.c
+++ b/net/netfilter/nf_conntrack_netlink.c
@@ -1321,15 +1321,11 @@ static int ctnetlink_parse_tuple_ip(struct nlattr *attr,
 	struct nlattr *tb[CTA_IP_MAX+1];
 	int ret = 0;
 
-	ret = nla_parse_nested_deprecated(tb, CTA_IP_MAX, attr, NULL, NULL);
+	ret = nla_parse_nested_deprecated(tb, CTA_IP_MAX, attr,
+					  cta_ip_nla_policy, NULL);
 	if (ret < 0)
 		return ret;
 
-	ret = nla_validate_nested_deprecated(attr, CTA_IP_MAX,
-					     cta_ip_nla_policy, NULL);
-	if (ret)
-		return ret;
-
 	switch (tuple->src.l3num) {
 	case NFPROTO_IPV4:
 		ret = ipv4_nlattr_to_tuple(tb, tuple, flags);
-- 
2.41.0


