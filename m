Return-Path: <netdev+bounces-117070-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3378A94C8CE
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 05:19:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0C6A28662A
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 03:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF1A28DCB;
	Fri,  9 Aug 2024 03:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hbCRSCOe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5749818044
	for <netdev@vger.kernel.org>; Fri,  9 Aug 2024 03:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723173518; cv=none; b=twek8e8RrD5ItEBEEzqcSYHj8+DLnzaFe+kk4uXlEmyLmddzukW1URmZ1JOaWc0UTdnefD+WyJM8xtwm7KpTA15QIjgDsz3Tq+ewx52rpyNS/xkGzp/kh7XnMjNg2LtWUk8Hg9UuLXs3OZdI2khPqvUWEtq3qO0dldnaZsSUPE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723173518; c=relaxed/simple;
	bh=KZwwQbfypZM7en4HuZQB6/5ollICWQL/7o7f7k1O1XY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XC5IreBcmFLv62b7gqdqon+NCWjCFjk74ZKeL4nobeMr502/U3vSh+HjzzGJnRCnMvRmPQafTao6xf0c7UF5wBYznk8bXPtKP/k/edbDJr7b23x0DRDl1MPuVydAI7EHjxlEycW6nsmvbeBi5N3kJQpQB6YMJcxL64NmEfVFq8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hbCRSCOe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73396C4AF0C;
	Fri,  9 Aug 2024 03:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723173518;
	bh=KZwwQbfypZM7en4HuZQB6/5ollICWQL/7o7f7k1O1XY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hbCRSCOeOn6puuu+t8/dn2+aDLqw6PKJthITO5JAD/laJNCRCwXm826euqjqH/Scl
	 Z43ltlnzNWTQmNJ2e93rEg57Wigi8dsNNA1p1bIuuW9SqgQkyjIHHN7u6zcH/HuKMu
	 WhjmpYlN+6njxjy52j1+AXP5jysm4V/4ghcVxnit6d0KQG0IAP0yOL0PUat3bQEgqw
	 vgfBa1a+RIqavd/sY8xtDyIe0ZZjJpIFi68Lp9O4qSjTuPGguIm0H18Cwr3VqhHm59
	 4rXGIZudNpDH48CUAHstAJfMeHMJlhnLdL8TJlyE5mifZgNoq0w+/E+dvt+4h8Mpqn
	 Yjoeuy7I2s+pw==
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
Subject: [PATCH net-next v4 08/12] ethtool: rss: report info about additional contexts from XArray
Date: Thu,  8 Aug 2024 20:18:23 -0700
Message-ID: <20240809031827.2373341-9-kuba@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240809031827.2373341-1-kuba@kernel.org>
References: <20240809031827.2373341-1-kuba@kernel.org>
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


