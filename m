Return-Path: <netdev+bounces-117376-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4020894DAF5
	for <lists+netdev@lfdr.de>; Sat, 10 Aug 2024 07:42:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C675E28284A
	for <lists+netdev@lfdr.de>; Sat, 10 Aug 2024 05:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD08913D251;
	Sat, 10 Aug 2024 05:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vsb4ki70"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A9713D240
	for <netdev@vger.kernel.org>; Sat, 10 Aug 2024 05:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723268491; cv=none; b=EFaoraFkB8MjPvqkUWSLL3jYloJyctk2QY1bF+BnAdZ5cxPDdVz98DYh+cNoijuoBLbPEBkzEo9UjR7dCmjA4TG3bFprAb0F+FCNpwpLG+rG3ZzGYKA4+6jja489kZhGe5iRoYOLXZCKMzf1lWuoaoTZy0NE+Na7Kbg6vfbMQ8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723268491; c=relaxed/simple;
	bh=KZwwQbfypZM7en4HuZQB6/5ollICWQL/7o7f7k1O1XY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MOLUxjbqyWzHhuw3sD2wx1My8ju/U9HyQ65c5AyBVLD5Wc1eE1BqdSJC8fKSn2XExoieLc/A45RPzOfwDcEZTYWWQzly1pgdNIyiPLdsM+Ey6/DYSK2GT9UQfYecwQIcZ5U0AyTGuqRPTMz5EfVwhy8ThkS5GLkAVcvFNsqH9DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vsb4ki70; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0F1EC4AF49;
	Sat, 10 Aug 2024 05:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723268490;
	bh=KZwwQbfypZM7en4HuZQB6/5ollICWQL/7o7f7k1O1XY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Vsb4ki70gutmzPn48kYkTZWFef63EOrBYNEEozADBUj9SrxIWMnu67GCEcL/6YRhg
	 zHnzhN0s2WyBFuOR4IvW2kafKCheCIJhJ0SOCGO75v5esOfgyJTND9JMBXjKuUt7ox
	 FOMLCiFYgNngE6XclHSV758cnJEgdyu3xpeBfg8IyxK2NtUgIESBT07HIU7oZn1o6P
	 zDqEqkuOkSWpoDVukyyYtJVEJziUE4LFPE5FHbbswdpBJd+0Hw+Mc1rKp4stN0Mfus
	 1hT8dgkftt6gb/qVUqZnqvFrqqdqU9efD9VWUmiZtpkEKqnz9kjGG+G5j14mSLaC66
	 CbYclbtWCBRjA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	michael.chan@broadcom.com,
	shuah@kernel.org,
	ecree.xilinx@gmail.com,
	przemyslaw.kitszel@intel.com,
	ahmed.zaki@intel.com,
	andrew@lunn.ch,
	willemb@google.com,
	pavan.chebbi@broadcom.com,
	petrm@nvidia.com,
	gal@nvidia.com,
	jdamato@fastly.com,
	donald.hunter@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v5 08/12] ethtool: rss: report info about additional contexts from XArray
Date: Fri,  9 Aug 2024 22:37:24 -0700
Message-ID: <20240810053728.2757709-9-kuba@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240810053728.2757709-1-kuba@kernel.org>
References: <20240810053728.2757709-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

IOCTL already uses the XArray when reporting info about additional
contexts. Do the same thing in netlink code.

Reviewed-by: Edward Cree <ecree.xilinx@gmail.com>
Reviewed-by: Joe Damato <jdamato@fastly.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/ethtool/rss.c | 37 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/net/ethtool/rss.c b/net/ethtool/rss.c
index 5c477cc36251..023782ca1230 100644
--- a/net/ethtool/rss.c
+++ b/net/ethtool/rss.c
@@ -82,7 +82,6 @@ rss_prepare_get(const struct rss_req_info *request, struct net_device *dev,
 	rxfh.indir = data->indir_table;
 	rxfh.key_size = data->hkey_size;
 	rxfh.key = data->hkey;
-	rxfh.rss_context = request->rss_context;
 
 	ret = ops->get_rxfh(dev, &rxfh);
 	if (ret)
@@ -95,6 +94,41 @@ rss_prepare_get(const struct rss_req_info *request, struct net_device *dev,
 	return ret;
 }
 
+static int
+rss_prepare_ctx(const struct rss_req_info *request, struct net_device *dev,
+		struct rss_reply_data *data, const struct genl_info *info)
+{
+	struct ethtool_rxfh_context *ctx;
+	u32 total_size, indir_bytes;
+	u8 *rss_config;
+
+	ctx = xa_load(&dev->ethtool->rss_ctx, request->rss_context);
+	if (!ctx)
+		return -ENOENT;
+
+	data->indir_size = ctx->indir_size;
+	data->hkey_size = ctx->key_size;
+	data->hfunc = ctx->hfunc;
+	data->input_xfrm = ctx->input_xfrm;
+
+	indir_bytes = data->indir_size * sizeof(u32);
+	total_size = indir_bytes + data->hkey_size;
+	rss_config = kzalloc(total_size, GFP_KERNEL);
+	if (!rss_config)
+		return -ENOMEM;
+
+	data->indir_table = (u32 *)rss_config;
+	memcpy(data->indir_table, ethtool_rxfh_context_indir(ctx), indir_bytes);
+
+	if (data->hkey_size) {
+		data->hkey = rss_config + indir_bytes;
+		memcpy(data->hkey, ethtool_rxfh_context_key(ctx),
+		       data->hkey_size);
+	}
+
+	return 0;
+}
+
 static int
 rss_prepare_data(const struct ethnl_req_info *req_base,
 		 struct ethnl_reply_data *reply_base,
@@ -115,6 +149,7 @@ rss_prepare_data(const struct ethnl_req_info *req_base,
 			return -EOPNOTSUPP;
 
 		data->no_key_fields = !ops->rxfh_per_ctx_key;
+		return rss_prepare_ctx(request, dev, data, info);
 	}
 
 	return rss_prepare_get(request, dev, data, info);
-- 
2.46.0


