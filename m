Return-Path: <netdev+bounces-113116-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53E5893CAD4
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 00:24:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CB621C21920
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 22:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40BB51448EF;
	Thu, 25 Jul 2024 22:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LnNlsDAH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5C0143C4B
	for <netdev@vger.kernel.org>; Thu, 25 Jul 2024 22:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721946245; cv=none; b=FfESLVrTKuYAlv23gt+qzsppoglqGevyNW5exXjrHmVw7WzqQuPV2eyM/spgAbqMzdu7N+uwG/sZwe2iDNYL/C/fyTKmq5KpQ/icJiIRe/84RypPIAwgiD9LEfF8xcKbgJQiFWyeZl0OgiI5Sr1Ap4vsnZZWoUESwsilyJI0tj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721946245; c=relaxed/simple;
	bh=24rI0zBxjyY2Lqd98zxx0B/rISB/OYL2ybM6TpEh5xY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fj46OyHPJRc3l4EdEm0Ys8eH3cBYEMNiEGrF8zy1IAN2W7dN4SMKjmKZIPhfXFDldRocdAKNuampq+pXmLBGrkTiJgWlPl5XAFbca6ATNNUXQpsSs8G6qNlq4sMo2Pix0Iuj8/XiFR2+DdPqjkdi4SgADKhmMgPnwkX73/RZNV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LnNlsDAH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02AFEC4AF07;
	Thu, 25 Jul 2024 22:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721946244;
	bh=24rI0zBxjyY2Lqd98zxx0B/rISB/OYL2ybM6TpEh5xY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LnNlsDAHbV1M2/V3mw0ZgiswVLQadeP6Bz9ZWoLAU6ICFv/469+rHBY7OeNrLgwoB
	 EG2nMKCTHtS8nmTjvw6CXN16eXsHjsBGn4bhLAz7k1TnnKzwMIz5ZIQ/Sd6x4iAssT
	 ea1pY3OuAGm2y41AUrWqmoCeGcd3acpf6H3dE7xwJJ1ani22soFpNbhFGMIxEXLiTC
	 haW9UtRynSIOyyrbhN/hGKHLcOTdkwBJf18NG9kFkTvxqKrO/SA12tvEcsy0bAad8Y
	 jn3NPt14e/v509TzKAiO7HB52q0A1XJwolnyZSot3Z2nuf2yMVNs9eowbyrQ1KPGkW
	 AILRBD5UOLJAg==
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
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net 1/5] eth: bnxt: reject unsupported hash functions
Date: Thu, 25 Jul 2024 15:23:49 -0700
Message-ID: <20240725222353.2993687-2-kuba@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725222353.2993687-1-kuba@kernel.org>
References: <20240725222353.2993687-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In commit under Fixes I split the bnxt_set_rxfh_context() function,
and attached the appropriate chunks to new ops. I missed that
bnxt_set_rxfh_context() gets called after some initial checks
in bnxt_set_rxfh(), namely that the hash function is Toeplitz.

Fixes: 5c466b4d4e75 ("eth: bnxt: move from .set_rxfh to .create_rxfh_context and friends")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index d00ef0063820..0425a54eca98 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -1863,8 +1863,14 @@ static void bnxt_modify_rss(struct bnxt *bp, struct ethtool_rxfh_context *ctx,
 }
 
 static int bnxt_rxfh_context_check(struct bnxt *bp,
+				   const struct ethtool_rxfh_param *rxfh,
 				   struct netlink_ext_ack *extack)
 {
+	if (rxfh->hfunc && rxfh->hfunc != ETH_RSS_HASH_TOP) {
+		NL_SET_ERR_MSG_MOD(extack, "RSS hash function not supported");
+		return -EOPNOTSUPP;
+	}
+
 	if (!BNXT_SUPPORTS_MULTI_RSS_CTX(bp)) {
 		NL_SET_ERR_MSG_MOD(extack, "RSS contexts not supported");
 		return -EOPNOTSUPP;
@@ -1888,7 +1894,7 @@ static int bnxt_create_rxfh_context(struct net_device *dev,
 	struct bnxt_vnic_info *vnic;
 	int rc;
 
-	rc = bnxt_rxfh_context_check(bp, extack);
+	rc = bnxt_rxfh_context_check(bp, rxfh, extack);
 	if (rc)
 		return rc;
 
@@ -1953,7 +1959,7 @@ static int bnxt_modify_rxfh_context(struct net_device *dev,
 	struct bnxt_rss_ctx *rss_ctx;
 	int rc;
 
-	rc = bnxt_rxfh_context_check(bp, extack);
+	rc = bnxt_rxfh_context_check(bp, rxfh, extack);
 	if (rc)
 		return rc;
 
-- 
2.45.2


