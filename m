Return-Path: <netdev+bounces-65354-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF1F83A3D7
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 09:14:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9832FB29DD8
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 08:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC636171C9;
	Wed, 24 Jan 2024 08:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h/HsZn5o"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883FC17548
	for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 08:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706084048; cv=none; b=kvf+IsZWSH4D4dgf1+qxmQm6Zq1MPxCqYCgp13XnrfJ0McbNVS9ypVZ3DdIMAA1NH4oxSyEJ9EdHMAgWIzJFTNPZLArc4uNJ1wWutkoGWK1l8lGYFfu1fBji/wZU3Y3U+wzRzAiaWEHWiSPrhWCq7xTBPNE294CQne/o7xGa7Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706084048; c=relaxed/simple;
	bh=w12lrpFQkQHQCQaZbaQFaqqpQ3ajIxCZJXt5mJB4e+M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pMDGdIhuFY3KSE1n9kUh0fSndMMuJ3GI3OGVtx/eolo37+n6LY5efHwQbHORAmIYNrJO4zU1f8N/llXSbp9n2VjY2CcRD65yvPwO7UNH84q5RQ1GwYfjEeOI9sChzN3NTK1fIuLYMyyIGM3hqLC6QMXsmuqzgSGvkyr3fZVpYJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h/HsZn5o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C97ACC433C7;
	Wed, 24 Jan 2024 08:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706084048;
	bh=w12lrpFQkQHQCQaZbaQFaqqpQ3ajIxCZJXt5mJB4e+M=;
	h=From:To:Cc:Subject:Date:From;
	b=h/HsZn5oUKxg0DeaBU4dIfErfA7F6fXJeh3g9ex7GMe++S34P30bxz4P/gjCQU8NH
	 XEO7RUmGZoK9wryx+VNpvaLq7uEB1tudQmITG5gdxG4PXW/gpdpVdKaMStHBq2z0dh
	 7U/7hppsRhES5cviXvsaTSTlSrGDCftVRWe0V2yug9TkoMjvxN0FTue9NX5PEKbNqW
	 t2B1x9GkyHZhY7Q1DkRfNbFTr/YxWA9jfkChkOct1iuhdCx/ftAls3Qs8pVbl9dK2z
	 R97f/U5fTwKosnKmtxf4itOmOefFkc+O7LzUEfAYsZJKDUjV1EiTjNt00mbVume26d
	 horfcn9xHQZ4Q==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Mike Yu <yumike@google.com>
Subject: [PATCH net] xfrm: Pass UDP encapsulation in TX packet offload
Date: Wed, 24 Jan 2024 00:13:54 -0800
Message-ID: <20240124081354.111307-1-saeed@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

In addition to citied commit in Fixes line, allow UDP encapsulation in
TX path too.

Fixes: 89edf40220be ("xfrm: Support UDP encapsulation in packet offload mode")
CC: Steffen Klassert <steffen.klassert@secunet.com> 
Reported-by: Mike Yu <yumike@google.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 net/xfrm/xfrm_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_device.c b/net/xfrm/xfrm_device.c
index 3784534c9185..653e51ae3964 100644
--- a/net/xfrm/xfrm_device.c
+++ b/net/xfrm/xfrm_device.c
@@ -407,7 +407,7 @@ bool xfrm_dev_offload_ok(struct sk_buff *skb, struct xfrm_state *x)
 	struct xfrm_dst *xdst = (struct xfrm_dst *)dst;
 	struct net_device *dev = x->xso.dev;
 
-	if (!x->type_offload || x->encap)
+	if (!x->type_offload)
 		return false;
 
 	if (x->xso.type == XFRM_DEV_OFFLOAD_PACKET ||
-- 
2.43.0


