Return-Path: <netdev+bounces-167751-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C71DA3C0C5
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 14:57:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E27901891D87
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 13:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A83371EB1AA;
	Wed, 19 Feb 2025 13:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lXyMXy8N"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822981EA7FB
	for <netdev@vger.kernel.org>; Wed, 19 Feb 2025 13:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739973098; cv=none; b=tjOoHK70l5dtDJRv82nqzmiy/cqwXqPodsaM1KkMnrzJ1e65D/dB6XKjYS0PUFpy+AtI9qT4rVNrt8r883E03Takx8rt2VVPV2UV5XQLGiPxvZBWtwNTNCpC9S1Wud+Q/FuwX0JIRENKNiPSQxbQq+yhR7wNdmDrHmI+t1+v+LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739973098; c=relaxed/simple;
	bh=7ayQVDbeE3K7HJHF9knbzquixudKqy5ny3N3He+cUJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eW5ky+pNvRue1Y+/ZNQPFxN4phACsKwvNMJUxyVACc02Vm5N6RFNlJhKIqEYLpS2gwn27QzMrtUqkayDk24V44FzC8IrE6w4XBcSl3OQL1KlyihS8AoRG5RcjiYlJtGjKoTE8+BCMYVxDWXU+rhJDbZDUa6tXzQ5p05NXo8jwus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lXyMXy8N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6DD1C4CED1;
	Wed, 19 Feb 2025 13:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739973098;
	bh=7ayQVDbeE3K7HJHF9knbzquixudKqy5ny3N3He+cUJ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lXyMXy8NJVlWnczofcNLAXy0LWY4iNP9mefHvoHapC4uqcmh3z09CKoPq8prNK4L8
	 G1TTxW0xkU1P3Hd/OnRNDPq/hMckbWY0Ob0VwmrVyPVc39I+VHhJ9v2iqdD/CpncFT
	 7ow4PwbRWge7OnOgLkCHoMCEYqQZck54S0BjvUjzrw3/r2eMzfsIfs3Cfl+248Y60n
	 dSL32dwLZiP1bgAvKhHWt2PyAW8tIYdRKQ/nKVD6vO8ljVOKSKEt4oWYRKrloZtx9i
	 F2S6fzvSZDCPkq9tfx/fN0qbVTN7LN9eFLpZrHqYLIOWej7KfPgVBOU2VAl1R+weua
	 MkTaXqPBsd4Uw==
From: Leon Romanovsky <leon@kernel.org>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: [PATCH ipsec-next v1 3/5] xfrm: rely on XFRM offload
Date: Wed, 19 Feb 2025 15:50:59 +0200
Message-ID: <332ca3fbc24b1c79ade38204646760090aaab4da.1739972570.git.leon@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1739972570.git.leon@kernel.org>
References: <cover.1739972570.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

After change of initialization of x->type_offload pointer to be valid
only for offloaded SAs. There is no need to rely on both x->type_offload
and x->xso.type to determine if SA is offloaded or not.

Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 net/xfrm/xfrm_device.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/net/xfrm/xfrm_device.c b/net/xfrm/xfrm_device.c
index 97c8030cc417..8d24f4743107 100644
--- a/net/xfrm/xfrm_device.c
+++ b/net/xfrm/xfrm_device.c
@@ -419,13 +419,11 @@ bool xfrm_dev_offload_ok(struct sk_buff *skb, struct xfrm_state *x)
 	struct xfrm_dst *xdst = (struct xfrm_dst *)dst;
 	struct net_device *dev = x->xso.dev;
 
-	if (!x->type_offload ||
-	    (x->xso.type == XFRM_DEV_OFFLOAD_UNSPECIFIED && x->encap))
+	if (x->xso.type == XFRM_DEV_OFFLOAD_UNSPECIFIED)
 		return false;
 
 	if (x->xso.type == XFRM_DEV_OFFLOAD_PACKET ||
-	    ((!dev || (dev == xfrm_dst_path(dst)->dev)) &&
-	     !xdst->child->xfrm)) {
+	    ((dev == xfrm_dst_path(dst)->dev) && !xdst->child->xfrm)) {
 		mtu = xfrm_state_mtu(x, xdst->child_mtu_cached);
 		if (skb->len <= mtu)
 			goto ok;
@@ -437,8 +435,8 @@ bool xfrm_dev_offload_ok(struct sk_buff *skb, struct xfrm_state *x)
 	return false;
 
 ok:
-	if (dev && dev->xfrmdev_ops && dev->xfrmdev_ops->xdo_dev_offload_ok)
-		return x->xso.dev->xfrmdev_ops->xdo_dev_offload_ok(skb, x);
+	if (dev->xfrmdev_ops->xdo_dev_offload_ok)
+		return dev->xfrmdev_ops->xdo_dev_offload_ok(skb, x);
 
 	return true;
 }
-- 
2.48.1


