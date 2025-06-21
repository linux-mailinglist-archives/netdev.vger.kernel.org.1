Return-Path: <netdev+bounces-199993-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3BBEAE2A90
	for <lists+netdev@lfdr.de>; Sat, 21 Jun 2025 19:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40B99189C2A5
	for <lists+netdev@lfdr.de>; Sat, 21 Jun 2025 17:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A851A222561;
	Sat, 21 Jun 2025 17:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qOFhp/9z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854DB2222CE
	for <netdev@vger.kernel.org>; Sat, 21 Jun 2025 17:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750526393; cv=none; b=WHio2X9EhQgwYjg17x2lFW95qOk2fca49SnrkJPIa3I5oQGyRrq6WEELS6iyJi6WHPBC7XcL453n8bXTjCikuyFnUg4wgZ0K95mcfg8PRfRusVzi2kStEgvhTbKwpXv6tgzO3izvfD1kctplyXNIPPWOMG/xGSS2ZuyVf9YmTno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750526393; c=relaxed/simple;
	bh=6ggaaT8JFdw3f2qH1RxFtbe8iEeG2CFJ4qbI/n/gdko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Skly+Q9ygiivociMleefuFsHsO/Ack8OB2jfL5wpphIMP5NfutunZKj+nWhcfm3wydC2BCNUKaa2GR1HPZMd6S7vkhX1P5pr66Ht4SV1yAyOCXWbAjqh2cyRvTZLNCUpg0KDBhhJoNmKM/5u28ExMqxZM7/7bafMkudc0KJnNFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qOFhp/9z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1AD5C4CEEE;
	Sat, 21 Jun 2025 17:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750526393;
	bh=6ggaaT8JFdw3f2qH1RxFtbe8iEeG2CFJ4qbI/n/gdko=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qOFhp/9zALs6oNiakBUTH55YItlxGZ7BAc7aSTn4WD+NP2N5I9DdSoNwxTYhmc8yu
	 VeGzz2NInwWlCIpFUJjfGCzM621g+IeCF5EdXGVU3j/NdfgBVShrEJFGpEDu/q2f6q
	 ZSlzJwbWUahtsDu8Obbp7PfX/kp8m7ACqYkAlOi5PVJyP4dKkRJrPtgywCgmtr+h8c
	 ddBDQlHEhHnFxdymZ1claxQ3P/yH0ErY4DOT+LGvRJPfiNg2trn/QXigWDe1zXbTF0
	 cqzEY/tajA/LQ+tm8xBbzdcfEA5GEIF9siEjU7yEZ0XjVdZPs/ZuBuKQpR+VdhBW5K
	 8eEzrFBSvh13w==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	maxime.chevallier@bootlin.com,
	sdf@fomichev.me,
	jdamato@fastly.com,
	ecree.xilinx@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 2/9] net: ethtool: dynamically allocate full req size req
Date: Sat, 21 Jun 2025 10:19:37 -0700
Message-ID: <20250621171944.2619249-3-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250621171944.2619249-1-kuba@kernel.org>
References: <20250621171944.2619249-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for using req_info to carry parameters between
SET and NTF allocate a full request into struct. Since the size
depends on the subcommand we need to allocate it on the heap.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/ethtool/netlink.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
index 9de828df46cd..a9467b96f00c 100644
--- a/net/ethtool/netlink.c
+++ b/net/ethtool/netlink.c
@@ -863,8 +863,8 @@ static int ethnl_default_done(struct netlink_callback *cb)
 static int ethnl_default_set_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	const struct ethnl_request_ops *ops;
-	struct ethnl_req_info req_info = {};
 	const u8 cmd = info->genlhdr->cmd;
+	struct ethnl_req_info *req_info;
 	struct net_device *dev;
 	int ret;
 
@@ -874,20 +874,24 @@ static int ethnl_default_set_doit(struct sk_buff *skb, struct genl_info *info)
 	if (GENL_REQ_ATTR_CHECK(info, ops->hdr_attr))
 		return -EINVAL;
 
-	ret = ethnl_parse_header_dev_get(&req_info, info->attrs[ops->hdr_attr],
+	req_info = kzalloc(ops->req_info_size, GFP_KERNEL);
+	if (!req_info)
+		return -ENOMEM;
+
+	ret = ethnl_parse_header_dev_get(req_info, info->attrs[ops->hdr_attr],
 					 genl_info_net(info), info->extack,
 					 true);
 	if (ret < 0)
-		return ret;
+		goto out_free_req;
 
 	if (ops->set_validate) {
-		ret = ops->set_validate(&req_info, info);
+		ret = ops->set_validate(req_info, info);
 		/* 0 means nothing to do */
 		if (ret <= 0)
 			goto out_dev;
 	}
 
-	dev = req_info.dev;
+	dev = req_info->dev;
 
 	rtnl_lock();
 	netdev_lock_ops(dev);
@@ -902,7 +906,7 @@ static int ethnl_default_set_doit(struct sk_buff *skb, struct genl_info *info)
 	if (ret < 0)
 		goto out_free_cfg;
 
-	ret = ops->set(&req_info, info);
+	ret = ops->set(req_info, info);
 	if (ret < 0)
 		goto out_ops;
 
@@ -921,7 +925,9 @@ static int ethnl_default_set_doit(struct sk_buff *skb, struct genl_info *info)
 	netdev_unlock_ops(dev);
 	rtnl_unlock();
 out_dev:
-	ethnl_parse_header_dev_put(&req_info);
+	ethnl_parse_header_dev_put(req_info);
+out_free_req:
+	kfree(req_info);
 	return ret;
 }
 
-- 
2.49.0


