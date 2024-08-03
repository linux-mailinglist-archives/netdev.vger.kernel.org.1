Return-Path: <netdev+bounces-115475-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E99946767
	for <lists+netdev@lfdr.de>; Sat,  3 Aug 2024 06:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71B421C20C3C
	for <lists+netdev@lfdr.de>; Sat,  3 Aug 2024 04:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F04F13A41A;
	Sat,  3 Aug 2024 04:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nVTU+OI2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6CC13A40D
	for <netdev@vger.kernel.org>; Sat,  3 Aug 2024 04:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722659216; cv=none; b=hMJaEDV0YgPBsOthyjYEvMJ8q92KJaTJ0nVpXMXe1t2XhFzxPUCoxGnQkbqlZKJJrPhZqQpMVQBC3mz7VDUgE5GKyCb5IrRUmSx1m0NJ3A4t9bgHZGfv2JubZXoO3KiJKQ1xin+1flRpn7qPOu3XplPKrjjLMx3utx65cHB9+4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722659216; c=relaxed/simple;
	bh=GibBjpY/o+oprt8Xjb2We0hOv2ayFYDQhCxpFJZvF4U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UCN9cguBJhVDGEYuc/+20sLKNbygss5IF5n6SPAn/7h4m/zm4CSvUfLeOwxllg6Prmtv6dtHJZYzYEVDGkt/ztRvIsqeDAnylLTbFM65ZKb3iHWNZJtkGCq4p57VzHxcBBDaQSx4et/968qvceVpyhMlG1JkOjeEl4Rk54k9tEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nVTU+OI2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AED95C4AF13;
	Sat,  3 Aug 2024 04:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722659216;
	bh=GibBjpY/o+oprt8Xjb2We0hOv2ayFYDQhCxpFJZvF4U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nVTU+OI2YgnoasKWQFIkPBhMeAQYfSBwVNUzCdcylnH5/bD/aZjzESSPKCFaz/eej
	 CeJRioTKLXq2MrrsrHHgJwlMVrs8bI11arNOrQYa1JLFxfFS1K1Tz8MBc9QrdQb53F
	 d9AxC1CG6EakQVIw9VEIYFTOw6CwG97q0ofNkPQcC8eKged6FNjVRWlCz3CbbGaItv
	 Fytf9t1j2DeCjKrQSTUDdNckSap2UxiRV2SzS8kxSNkAICqUMbsMAOh2oMeOy0FQUP
	 6g/OKlgpEH0JBtYdVUnJRyabEuIl8atv7bvp3tet4wA433aJOVvRTX96hsBgl+z6S+
	 2p2OZH++Ylg5w==
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
	jdamato@fastly.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 08/12] ethtool: rss: report info about additional contexts from XArray
Date: Fri,  2 Aug 2024 21:26:20 -0700
Message-ID: <20240803042624.970352-9-kuba@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240803042624.970352-1-kuba@kernel.org>
References: <20240803042624.970352-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

IOCTL already uses the XArray when reporting info about additional
contexts. Do the same thing in netlink code.

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


