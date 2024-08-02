Return-Path: <netdev+bounces-115161-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77658945536
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 02:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1DBE28655A
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 00:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C1EA134B1;
	Fri,  2 Aug 2024 00:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Omtp/Ffu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA48517BA4
	for <netdev@vger.kernel.org>; Fri,  2 Aug 2024 00:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722557893; cv=none; b=Zki03vW9xK9FbFAZ4u+sIulJ90KdFNyeXdj91vPMyEZeNVHYwv6jKmu3+ZDR6o24sEHx5TokvvPL32DXqCJ3jppWxvbuj93iTZRFctbImThwL2fbWUBVqU6bKz+8Aab6Vr4HEdgzv9SZ8gEh9nXrK1Si5vMsdfdXv4B0YcMJOsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722557893; c=relaxed/simple;
	bh=KRKB9Ys71uHjRH5eNayUyIisRFobsi8Z/AmWTs8wJcM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IgCBkMgviCDNfaZ8Xlh/x2H6UUHZbyO+uWcUUca14o5If5QbWy/+XiRnmUQvcsCU5eCFU1n8R+IlsX/elE9h1KgraBenHMHfnjnxFOTuKJfqDV4hYHE28Jz0QAuaKG4gjZx3n0Utgwy88jZjniavPpECCbsWYyokadKBRrTUQH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Omtp/Ffu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B7F1C4AF0D;
	Fri,  2 Aug 2024 00:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722557892;
	bh=KRKB9Ys71uHjRH5eNayUyIisRFobsi8Z/AmWTs8wJcM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Omtp/Ffu269DysgFrqQQCGfLGmGAjG4z1adiaKNXJG/Zd7XivQVMjIAgfjkU2YeAV
	 iIs/2+j+6G8EmKlAAyg1Pn90N0ms2tChaHmX7bZY7BCdkS9xb00xH6kAGWh5tEUOe6
	 A8OjvUQqmLBrbJLG+ozwQ0JTOVBcWRyQfB9Nut3UrpXN0X/QL1n8P8rS6i8mBUpbM3
	 b53i+jme1r3hmf1avJs9tCrzvPAnQusNCUgLL3/B2OUlyhUQaxPYhQ4CUz8PDVVOmX
	 EApJMR9qrDC+BAn2P1ysmGAWRE2D6MtB09fPjrP7tlZ3rVALziIyZx8l5VeBatIrhR
	 6j4l6sod9W5Ag==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	dxu@dxuuu.xyz,
	ecree.xilinx@gmail.com,
	przemyslaw.kitszel@intel.com,
	donald.hunter@gmail.com,
	gal.pressman@linux.dev,
	tariqt@nvidia.com,
	willemdebruijn.kernel@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 08/12] ethtool: rss: report info about additional contexts from XArray
Date: Thu,  1 Aug 2024 17:17:57 -0700
Message-ID: <20240802001801.565176-9-kuba@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240802001801.565176-1-kuba@kernel.org>
References: <20240802001801.565176-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

IOCTL already uses the XArray when reporting info about additional
contexts. Do the same thing in netlink code.

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


