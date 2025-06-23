Return-Path: <netdev+bounces-200423-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AACC4AE57DA
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 01:19:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60B0A4C32C0
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 23:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F38F248895;
	Mon, 23 Jun 2025 23:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uOqiyUhy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3D72472A0
	for <netdev@vger.kernel.org>; Mon, 23 Jun 2025 23:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750720646; cv=none; b=WrHOs+ScTPgHBnozdb7wb4RRNrJxjmkEsyrASam57fuSg/FsiqmQ1lZ9qMKztwzbPgrjdq7mFYvZD5X1B4kVmp7PkPWVa3hZb+T+i/7/KyyvTx/4sZYs/IkDIh+0dgoSnlmwOW2Mus4d+ygabMuQWbLea2ZdQN/5ptqGRi5cHG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750720646; c=relaxed/simple;
	bh=gPwvKz+R2GLo3MDSwTi0kYMrKy9t1SEbsIMBJxUo/gE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S+GcR+xfzAIM88ybVYv8vARJ6kqxByJWnu3lvCObOxVVxc/bIbs3sLv2XLt3rGy+iyAx/xEG0VeEoVzXA2IgUOnfQznQeZOpvd62B39SbfAbYWDdEbUJ/WkE2A0U+MwyS0XH4SSJhbgXnrgLSimmgmaeFB2cWJsW9zTAks3HGxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uOqiyUhy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B213EC4CEEF;
	Mon, 23 Jun 2025 23:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750720646;
	bh=gPwvKz+R2GLo3MDSwTi0kYMrKy9t1SEbsIMBJxUo/gE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uOqiyUhyry6xl6pkCYSJW2v7GKmBcucBjmUF2//32PYvMZKqbOjlHWhhZ5XA+usx/
	 FOINuPOzLEnBcIiKibhzM8TBJCpqkNs0X0nRnRIxi6Evmf2yEmnNFyX3X2zGtEfwWT
	 gRxBiKuju3jDt4+/aYj53kavO44mVWPH52p7BWVXrm0C+gLhPJU79BZLs7JDfJoKpQ
	 6gtcTa8KJaUOoPorQdCC9XkCVORjIc3if22XRbLeFz0Fuj/k+BrBPpYxyZyrYELsf4
	 hSip7xoaB2UEfAyHs3IfjR2W3LgvfiLPGruVD4mwZUPHqdVTQuuNQDlIp+S7mDQ7A7
	 c1XhqcX1lZdqw==
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
Subject: [PATCH net-next v2 3/8] net: ethtool: call .parse_request for SET handlers
Date: Mon, 23 Jun 2025 16:17:15 -0700
Message-ID: <20250623231720.3124717-4-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250623231720.3124717-1-kuba@kernel.org>
References: <20250623231720.3124717-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for using req_info to carry parameters between SET
and NTF - call .parse_request during ethnl_default_set_doit().

The main question here is whether .parse_request is intended to be
GET-specific. Originally the SET handling was delegated to each subcommand
directly - ethnl_default_set_doit() and .set callbacks in ethnl_request_ops
did not exist. Looking at existing users does not shed much light, all
of the following subcommands use .parse_request but have no SET handler
(and no NTF):

  net/ethtool/eeprom.c
  net/ethtool/rss.c
  net/ethtool/stats.c
  net/ethtool/strset.c
  net/ethtool/tsinfo.c

There's only one which does have a SET:

  net/ethtool/pause.c

where .parse_request handling is used to select which statistics to query.
Not relevant for SET but also harmless.

Going back to RSS (which doesn't have SET today) .parse_request parses
the rss_context ID. Using the req_info struct to pass the context ID
from SET to NTF will be very useful.

Switch to ethnl_default_parse(), effectively adding the .parse_request
for SET handlers.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/ethtool/netlink.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
index a9467b96f00c..c5ec3c82ab2e 100644
--- a/net/ethtool/netlink.c
+++ b/net/ethtool/netlink.c
@@ -878,9 +878,7 @@ static int ethnl_default_set_doit(struct sk_buff *skb, struct genl_info *info)
 	if (!req_info)
 		return -ENOMEM;
 
-	ret = ethnl_parse_header_dev_get(req_info, info->attrs[ops->hdr_attr],
-					 genl_info_net(info), info->extack,
-					 true);
+	ret = ethnl_default_parse(req_info, info,  ops, true);
 	if (ret < 0)
 		goto out_free_req;
 
-- 
2.49.0


