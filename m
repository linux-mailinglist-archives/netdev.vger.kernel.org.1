Return-Path: <netdev+bounces-79437-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F3BB3879362
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 12:55:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E5A7B21EE6
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 11:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C3F79B84;
	Tue, 12 Mar 2024 11:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HOHu2ZdA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089B779DA6
	for <netdev@vger.kernel.org>; Tue, 12 Mar 2024 11:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710244529; cv=none; b=IJkpI/lp68KW29OwL3ruAq2J2Iomv600weaiROXVqKrlqHPfL7EuDUr06J54SusyV2scA11aJ3VJFGbFSpeQl6LkBhJMslvkWA5zqFzHW2/S2CDj9s7d6lkrdyzy1xyJXFiineLCmqJkoDWi5oGhMmf2A6FC7nUbvC/8f0NObBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710244529; c=relaxed/simple;
	bh=frAkhbj+mlQDeWpcash9GTFgtBeJ9Yx2RHLXwMYH9pQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RC/dIzMwypc+bCZF6+zzQZPeT2ddDEScE7i4oISSfqJM7N6YsJSkNSaozgYkeAwuxdLCYEh88cFE/cPw+bKnBNyB5YPny5SsTV9tDGxTRuug2yGNxYu2r9h/ANVA3EyCp3bNm5Ep6XUzJ4s7egybDju50kTGZDY635FcfogTPV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HOHu2ZdA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1F34C433C7;
	Tue, 12 Mar 2024 11:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710244528;
	bh=frAkhbj+mlQDeWpcash9GTFgtBeJ9Yx2RHLXwMYH9pQ=;
	h=From:To:Cc:Subject:Date:From;
	b=HOHu2ZdAVjyfuM918C3sgZlAzBFRstQCMvPh6j7kGowmG+pq6jXhF7cyCh8GEMQBo
	 rxEdTdMB/98zbo1sk3LDSERBvhoraB3VLdlFBuq5n/bjJp9jRqhx6xjotjL+O7UY7T
	 DbOc96yn+mTDWxPWttQoJo+K+uMp64ZegAk8M42T554dy/SPEhBgSDIIR2EUaVB72w
	 5HDdIujH9fWzLGfcQ8X3A5nJ1imwe4DWj427sEW5meYA12mcUKxqdmcekBIbtL1aQz
	 4VtKP7+gGA+x5Tapg6EkbJ0kuYbjdwLvG1vi/4vM2djkiuMbxztiNVnPlnWz44K6vM
	 GTpr00xm3LIFg==
From: Leon Romanovsky <leon@kernel.org>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH xfrm] xfrm: Allow UDP encapsulation only in offload modes
Date: Tue, 12 Mar 2024 13:55:22 +0200
Message-ID: <3d3a34ffce4f66b8242791d1e6b3091aec8a2c25.1710244420.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

The missing check of x->encap caused to the situation where GSO packets
were created with UDP encapsulation.

As a solution return the encap check for non-offloaded SA.

Fixes: 9f2b55961a80 ("xfrm: Pass UDP encapsulation in TX packet offload")
Closes: https://lore.kernel.org/all/a650221ae500f0c7cf496c61c96c1b103dcb6f67.camel@redhat.com
Reported-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 net/xfrm/xfrm_device.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_device.c b/net/xfrm/xfrm_device.c
index 653e51ae3964..6346690d5c69 100644
--- a/net/xfrm/xfrm_device.c
+++ b/net/xfrm/xfrm_device.c
@@ -407,7 +407,8 @@ bool xfrm_dev_offload_ok(struct sk_buff *skb, struct xfrm_state *x)
 	struct xfrm_dst *xdst = (struct xfrm_dst *)dst;
 	struct net_device *dev = x->xso.dev;
 
-	if (!x->type_offload)
+	if (!x->type_offload ||
+	    (x->xso.type == XFRM_DEV_OFFLOAD_UNSPECIFIED && x->encap))
 		return false;
 
 	if (x->xso.type == XFRM_DEV_OFFLOAD_PACKET ||
-- 
2.44.0


