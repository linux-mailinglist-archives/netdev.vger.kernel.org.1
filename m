Return-Path: <netdev+bounces-42263-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC0E7CDEA0
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 16:13:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC1851C20D13
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 14:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2C4737179;
	Wed, 18 Oct 2023 14:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c8EwJaB8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841B336B1A
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 14:13:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1FC0C433C7;
	Wed, 18 Oct 2023 14:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697638384;
	bh=B7dxUlq/kdSdbybS/JUI4ITP3ZFzYrqJM2aaibW8JOE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c8EwJaB88lELsEe3OhKmCChqLnfYyGHrPeZx1d3+ilSrx83R/cEDm57BItFzSsRYr
	 xtti7uHBKZD6G6HE2rUOmL77o9RJoLr+e/FeXR73wkQMwS8sfl6zCRNrwEer4DVHTl
	 Ff5sMif0aaoqvkO9d4TShm6GDEf0rsKnNhqfGJca+HhNnML2gu6gOnkltYX7nlHsg7
	 rgug4PyB9xp6SL1YWTbLV6eufTqZEpxemi3EEd0fFzh7Uv0VGjrMNiF2lVHtj0uZGO
	 4LtgAGwdkWdc4H5ugzpvgC0sTJsMs98Boi98EHi9T/55jN4weXwWAxp6iLh3jik8YC
	 KVxn4V86fNxVQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.5 26/31] net: macsec: indicate next pn update when offloading
Date: Wed, 18 Oct 2023 10:11:43 -0400
Message-Id: <20231018141151.1334501-26-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231018141151.1334501-1-sashal@kernel.org>
References: <20231018141151.1334501-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.7
Content-Transfer-Encoding: 8bit

From: "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>

[ Upstream commit 0412cc846a1ef38697c3f321f9b174da91ecd3b5 ]

Indicate next PN update using update_pn flag in macsec_context.
Offloaded MACsec implementations does not know whether or not the
MACSEC_SA_ATTR_PN attribute was passed for an SA update and assume
that next PN should always updated, but this is not always true.

The PN can be reset to its initial value using the following command:
$ ip macsec set macsec0 tx sa 0 off #octeontx2-pf case

Or, the update PN command will succeed even if the driver does not support
PN updates.
$ ip macsec set macsec0 tx sa 0 pn 1 on #mscc phy driver case

Comparing the initial PN with the new PN value is not a solution. When
the user updates the PN using its initial value the command will
succeed, even if the driver does not support it. Like this:
$ ip macsec add macsec0 tx sa 0 pn 1 on key 00 \
ead3664f508eb06c40ac7104cdae4ce5
$ ip macsec set macsec0 tx sa 0 pn 1 on #mlx5 case

Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/macsec.c | 2 ++
 include/net/macsec.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index 2d64650f4eb3c..1c60548c1ddde 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -2394,6 +2394,7 @@ static int macsec_upd_txsa(struct sk_buff *skb, struct genl_info *info)
 
 		ctx.sa.assoc_num = assoc_num;
 		ctx.sa.tx_sa = tx_sa;
+		ctx.sa.update_pn = !!prev_pn.full64;
 		ctx.secy = secy;
 
 		ret = macsec_offload(ops->mdo_upd_txsa, &ctx);
@@ -2487,6 +2488,7 @@ static int macsec_upd_rxsa(struct sk_buff *skb, struct genl_info *info)
 
 		ctx.sa.assoc_num = assoc_num;
 		ctx.sa.rx_sa = rx_sa;
+		ctx.sa.update_pn = !!prev_pn.full64;
 		ctx.secy = secy;
 
 		ret = macsec_offload(ops->mdo_upd_rxsa, &ctx);
diff --git a/include/net/macsec.h b/include/net/macsec.h
index 441ed8fd4b5f6..41c1884a3e419 100644
--- a/include/net/macsec.h
+++ b/include/net/macsec.h
@@ -258,6 +258,7 @@ struct macsec_context {
 	struct macsec_secy *secy;
 	struct macsec_rx_sc *rx_sc;
 	struct {
+		bool update_pn;
 		unsigned char assoc_num;
 		u8 key[MACSEC_MAX_KEY_LEN];
 		union {
-- 
2.40.1


