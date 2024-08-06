Return-Path: <netdev+bounces-116226-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ABCF94985C
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 21:34:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 412511F22AFD
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 19:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A4D157487;
	Tue,  6 Aug 2024 19:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b+nQTlN0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040EA156993
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 19:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722972824; cv=none; b=GHm9EpknhRBdanBTDYqCrx0oDOmaNAejicfv26xYrRX1QI68xWx7v0YFovZoY9N8Ea7+O3xxZImqYlA1ECgXCYwHEc+GSjSu6akyFZtEejrkVkkAf7MKQzLXtnZoWQVd4hTJJGXNS5Vo0IqZws26kPVsD5t+N1kjDyL4uEas6iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722972824; c=relaxed/simple;
	bh=bnfTCYzUhpzmWELdNE82oxRe3hAgG2+lrD0ewcA4yOY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cAGp67wTsOzwVKbNqyAF+4s8ClpYKnzZzTfIkhJ8m1Tdpsmfsj/LwKwVGURV0mUTs1ICZMZbLnxmigl3lQkNKyw+JLobustU9ttdfIHu96c5Yo8QjFrW22ZLHvOkBmRMnXEMFi8y5IweUpSIMDnXi4C/jRpM+DNSkftTxY0x5aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b+nQTlN0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4F3BC4AF11;
	Tue,  6 Aug 2024 19:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722972823;
	bh=bnfTCYzUhpzmWELdNE82oxRe3hAgG2+lrD0ewcA4yOY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b+nQTlN0jW5VSHRU2Iaq42zg/pJ1PzCES3cT11gFVGsC/NYTUf9nj0IghCe2gDHE6
	 hZlCcUr2wefuWg7SJmh7U4pIWbY0j833tDaLhgO7Q/7ls6akvHu5i3TyY/FQm5GuO3
	 xbjDSA53Gh8OGWH8HOtt+sRT+QFBh9WVvvNrwtYTxGVjFVxMimlsvklh5MSkfCugUf
	 4VraMgGKBGDW8X+8zcj7rQWQyViwB4mPWA41NrFihCbXOGGfN9C4y2BGr1lb1Xb/04
	 PZHOfXNvaS/l8YjkGhzT/PhGS4rSn5NqD3jPhnW1QfoJSXhgqLFM1ntdggDe5ludJh
	 xPbvQ4jKaLhrw==
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
Subject: [PATCH net-next v3 08/12] ethtool: rss: report info about additional contexts from XArray
Date: Tue,  6 Aug 2024 12:33:13 -0700
Message-ID: <20240806193317.1491822-9-kuba@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240806193317.1491822-1-kuba@kernel.org>
References: <20240806193317.1491822-1-kuba@kernel.org>
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
2.45.2


