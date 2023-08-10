Return-Path: <netdev+bounces-26585-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86C15778439
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 01:41:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B187280BE3
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 23:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8DC225170;
	Thu, 10 Aug 2023 23:38:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4146B25141
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 23:38:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6522DC433CC;
	Thu, 10 Aug 2023 23:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691710734;
	bh=UzaJ4cO+mxqeOTQwrEm+NY4MFg7Y3jT3I9vq+XpgU1w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WkXtxbnj38OStcfEtDkhjA9NyEKwUoB5fa6mSwq4qRi93CccZc3k3wwYq9XK3nVvH
	 eB5v2xKUmvfM15naoW3qrNg6LKndOoBA/xSBcx9wYKQX6dvHNvKRZ5JhAoQZ4OeTiG
	 QsP7Azq5Q0NkaSYbZu+e/VhW27unQmnyS38Hrql8e8sgzSvemQfJW7CbxnCPUcuAM7
	 7+nOdaFcfcdUAZTwNKoutMhAmZd8uJeDWrJyPX/4UYzQzjeUXQJApYkrPlku4xPZ7G
	 WDKU4lOj6uirE4viJnHDycQKucHv6cAk4+6ZBK/YmgjflFXTUJA2ZXwhlkHdkOPz7+
	 R91QsYqeeG1uQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	jiri@resnulli.us,
	johannes@sipsolutions.net,
	Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@nvidia.com>,
	mkubecek@suse.cz
Subject: [PATCH net-next v2 09/10] ethtool: netlink: simplify arguments to ethnl_default_parse()
Date: Thu, 10 Aug 2023 16:38:44 -0700
Message-ID: <20230810233845.2318049-10-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230810233845.2318049-1-kuba@kernel.org>
References: <20230810233845.2318049-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Pass struct genl_info directly instead of its members.

Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: mkubecek@suse.cz
---
 net/ethtool/netlink.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
index 9fc7c41f4786..f7b3171a0aad 100644
--- a/net/ethtool/netlink.c
+++ b/net/ethtool/netlink.c
@@ -316,10 +316,8 @@ static struct ethnl_dump_ctx *ethnl_dump_context(struct netlink_callback *cb)
 /**
  * ethnl_default_parse() - Parse request message
  * @req_info:    pointer to structure to put data into
- * @tb:		 parsed attributes
- * @net:         request netns
+ * @info:	 genl_info from the request
  * @request_ops: struct request_ops for request type
- * @extack:      netlink extack for error reporting
  * @require_dev: fail if no device identified in header
  *
  * Parse universal request header and call request specific ->parse_request()
@@ -328,19 +326,21 @@ static struct ethnl_dump_ctx *ethnl_dump_context(struct netlink_callback *cb)
  * Return: 0 on success or negative error code
  */
 static int ethnl_default_parse(struct ethnl_req_info *req_info,
-			       struct nlattr **tb, struct net *net,
+			       const struct genl_info *info,
 			       const struct ethnl_request_ops *request_ops,
-			       struct netlink_ext_ack *extack, bool require_dev)
+			       bool require_dev)
 {
+	struct nlattr **tb = info->attrs;
 	int ret;
 
 	ret = ethnl_parse_header_dev_get(req_info, tb[request_ops->hdr_attr],
-					 net, extack, require_dev);
+					 genl_info_net(info), info->extack,
+					 require_dev);
 	if (ret < 0)
 		return ret;
 
 	if (request_ops->parse_request) {
-		ret = request_ops->parse_request(req_info, tb, extack);
+		ret = request_ops->parse_request(req_info, tb, info->extack);
 		if (ret < 0)
 			return ret;
 	}
@@ -393,8 +393,7 @@ static int ethnl_default_doit(struct sk_buff *skb, struct genl_info *info)
 		return -ENOMEM;
 	}
 
-	ret = ethnl_default_parse(req_info, info->attrs, genl_info_net(info),
-				  ops, info->extack, !ops->allow_nodev_do);
+	ret = ethnl_default_parse(req_info, info, ops, !ops->allow_nodev_do);
 	if (ret < 0)
 		goto err_dev;
 	ethnl_init_reply_data(reply_data, ops, req_info->dev);
@@ -538,9 +537,7 @@ static int ethnl_default_start(struct netlink_callback *cb)
 		goto free_req_info;
 	}
 
-	ret = ethnl_default_parse(req_info, info->info.attrs,
-				  sock_net(cb->skb->sk),
-				  ops, cb->extack, false);
+	ret = ethnl_default_parse(req_info, &info->info, ops, false);
 	if (req_info->dev) {
 		/* We ignore device specification in dump requests but as the
 		 * same parser as for non-dump (doit) requests is used, it
-- 
2.41.0


