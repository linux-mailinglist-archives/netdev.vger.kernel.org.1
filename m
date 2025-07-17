Return-Path: <netdev+bounces-208041-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63AE6B09868
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 01:44:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D04A817FB28
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 23:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50629252906;
	Thu, 17 Jul 2025 23:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MG3ICdNQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C832250BF2
	for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 23:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752795854; cv=none; b=TxEWzZVogZ/odX4SbYst5dijAYIk7WeObBmi01KyMu5hbGA+S2HN/FBVPyc2a+vZw2o35t8SXFkIXS702Pmsa7W13fQ5xXs3AtgSZF0Fl1MwSgWCL+JNK3sddMWE6Jkebo7sMOSdbglvnH7oiNyO0sTpMxGZwt98MsifVv1izyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752795854; c=relaxed/simple;
	bh=66Jqz6E/KHud29yEu43XdlTEeRd9r5ON0heSEmeCeDs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PovdjLQlNCo9q1QWD4kcgNX3eJqWUOhPemDxzlqsHtyJIisbaceW4mu28rrPMSKe4dVQqNn0aZg2E8/ZnLrm75h+W7HRlroSMRYSOqyL3ul8b+TKXSN0oGcovYl3DXct4ZeU1Ms7sIQt84ybB0eIRqUiB/OumQmlXuJjYbrWU/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MG3ICdNQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76023C4CEF4;
	Thu, 17 Jul 2025 23:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752795854;
	bh=66Jqz6E/KHud29yEu43XdlTEeRd9r5ON0heSEmeCeDs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MG3ICdNQJD8Srt/vcC8xp0IptYM2o5MmTBy7XHuxxVYl+3Pz5t13rxI8iRmFaNV6n
	 7MGfhH7rHOUZ2CHSaxFnbqX6ONFJWi5im9SjcXTvjIDAxg9wmgzZJy5Vw+mpfY8RpM
	 Oi+oMsoV40qPm0RPBpUMwv/iL7yWMInUwDJEwModX+KpzxjIMKmZr8maXvPdiTHH9R
	 F23LEAsKWzjx21qSBaDDI0KDTyREFu120EptC05pv7/xUydiQRIw5hk5i9x8Q6Dl4U
	 jbC34DOYm6X1g0RLjahmKb9yd4jN1MJ3WY1B/hgsL0mQsXwylf2bliutqBjEz1+9bU
	 i+gihLSPvY9Mw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	andrew@lunn.ch,
	donald.hunter@gmail.com,
	shuah@kernel.org,
	kory.maincent@bootlin.com,
	gal@nvidia.com,
	ecree.xilinx@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 4/8] ethtool: rss: factor out populating response from context
Date: Thu, 17 Jul 2025 16:43:39 -0700
Message-ID: <20250717234343.2328602-5-kuba@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250717234343.2328602-1-kuba@kernel.org>
References: <20250717234343.2328602-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Similarly to previous change, factor out populating the response.
We will use this after the context was allocated to send a notification
so this time factor out from the additional context handling, rather
than context 0 handling (for request context didn't exist, for response
it does).

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/ethtool/rss.c | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/net/ethtool/rss.c b/net/ethtool/rss.c
index 07a9d89e1c6b..e5516e529b4a 100644
--- a/net/ethtool/rss.c
+++ b/net/ethtool/rss.c
@@ -179,6 +179,25 @@ rss_prepare_get(const struct rss_req_info *request, struct net_device *dev,
 	return ret;
 }
 
+static void
+__rss_prepare_ctx(struct net_device *dev, struct rss_reply_data *data,
+		  struct ethtool_rxfh_context *ctx)
+{
+	if (WARN_ON_ONCE(data->indir_size != ctx->indir_size ||
+			 data->hkey_size != ctx->key_size))
+		return;
+
+	data->no_key_fields = !dev->ethtool_ops->rxfh_per_ctx_key;
+
+	data->hfunc = ctx->hfunc;
+	data->input_xfrm = ctx->input_xfrm;
+	memcpy(data->indir_table, ethtool_rxfh_context_indir(ctx),
+	       data->indir_size * sizeof(u32));
+	if (data->hkey_size)
+		memcpy(data->hkey, ethtool_rxfh_context_key(ctx),
+		       data->hkey_size);
+}
+
 static int
 rss_prepare_ctx(const struct rss_req_info *request, struct net_device *dev,
 		struct rss_reply_data *data, const struct genl_info *info)
@@ -188,8 +207,6 @@ rss_prepare_ctx(const struct rss_req_info *request, struct net_device *dev,
 	u8 *rss_config;
 	int ret;
 
-	data->no_key_fields = !dev->ethtool_ops->rxfh_per_ctx_key;
-
 	mutex_lock(&dev->ethtool->rss_lock);
 	ctx = xa_load(&dev->ethtool->rss_ctx, request->rss_context);
 	if (!ctx) {
@@ -199,8 +216,6 @@ rss_prepare_ctx(const struct rss_req_info *request, struct net_device *dev,
 
 	data->indir_size = ctx->indir_size;
 	data->hkey_size = ctx->key_size;
-	data->hfunc = ctx->hfunc;
-	data->input_xfrm = ctx->input_xfrm;
 
 	indir_bytes = data->indir_size * sizeof(u32);
 	total_size = indir_bytes + data->hkey_size;
@@ -211,13 +226,10 @@ rss_prepare_ctx(const struct rss_req_info *request, struct net_device *dev,
 	}
 
 	data->indir_table = (u32 *)rss_config;
-	memcpy(data->indir_table, ethtool_rxfh_context_indir(ctx), indir_bytes);
-
-	if (data->hkey_size) {
+	if (data->hkey_size)
 		data->hkey = rss_config + indir_bytes;
-		memcpy(data->hkey, ethtool_rxfh_context_key(ctx),
-		       data->hkey_size);
-	}
+
+	__rss_prepare_ctx(dev, data, ctx);
 
 	ret = 0;
 out_unlock:
-- 
2.50.1


