Return-Path: <netdev+bounces-26019-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE937776744
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 20:29:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A6771C2135D
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 18:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E549B1E529;
	Wed,  9 Aug 2023 18:27:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942A21E513
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 18:27:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFDEBC4339A;
	Wed,  9 Aug 2023 18:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691605620;
	bh=xlIKWx3ZeWqZpJ8Wm+l2aDQ570l1/6d15LNaYmc42iU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ye+v5BLW+BMmHJ1JjztMjC52m20clEEBc3gk6UTdwAt8efH17HMkxv23tMUrEQDAD
	 DJnDlCQWMef1BNlYd9/oRxaZyoRYSMI56wvFrgfkmBchbwgWe/lDa0sP3ADBaCzPXl
	 2vgDJQRPRw+ipamQkyS80o2r6WittFKA1jDjzkWrVkwXjLYLplZSQPUZZZdDw18xgl
	 M51mQflr2qoHm8i1VHM7UOUOeE0bpZs10nBQzFkWLklUTDy8u3qqDJBEYTHlTIFDKJ
	 sKl8l0I+nvTjBrfnMJQ/RAP7/jtMT+Gzi6Fqyc5MRBWm3nKTKCOv7Wimsr4hq1pfFv
	 /KsoeJrzOIv4Q==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	jiri@resnulli.us,
	johannes@sipsolutions.net,
	Jakub Kicinski <kuba@kernel.org>,
	mkubecek@suse.cz
Subject: [PATCH net-next 09/10] ethtool: netlink: simplify arguments to ethnl_default_parse()
Date: Wed,  9 Aug 2023 11:26:47 -0700
Message-ID: <20230809182648.1816537-10-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809182648.1816537-1-kuba@kernel.org>
References: <20230809182648.1816537-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Pass struct genl_info directly instead of its members.

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


