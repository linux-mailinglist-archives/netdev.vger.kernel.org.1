Return-Path: <netdev+bounces-18927-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD49375918C
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 11:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE9571C20EE7
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 09:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127DD111BF;
	Wed, 19 Jul 2023 09:27:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A1D125BF
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 09:27:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9797C433CA;
	Wed, 19 Jul 2023 09:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689758837;
	bh=rJoj7eqBJwj/0c+HCNjekYI6r1jCBXhk5rQJpmam6f0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d6qRDtveq0Xl9yMY+BhbAY2wigZhxMLvie1pInAtsvvAjgjLeApxVrc2JFTIlSqLX
	 CedcmYMt91YlZ1Fw9JW8Gjt1nYUoLGDHV/dp2rogYJFtjXIpIu5fIHZIs4KjMNloVE
	 tvSHW0Po2GaNqSm4W7qyi8SbNEpOHRZ7wapGnVGRhhMzom930pHgraJvx8WyB5uBTE
	 zJKOXH4xkbiN6lonUf+Bor1ZGX8lEzXDR8oIyCpnnubKyBdBjk8c6hQgGXqOGjQubP
	 EnkW+hMFwTEA62uSZrWJSOV0hf2UHfhn6VPXdCHWXSxsgKIMmUpIlqx74xUgtygjys
	 6nD02S40/RdIA==
From: Leon Romanovsky <leon@kernel.org>
To: Steffen Klassert <steffen.klassert@secunet.com>,
	Jakub Kicinski <kuba@kernel.org>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	Eric Dumazet <edumazet@google.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Simon Horman <simon.horman@corigine.com>,
	Ilia Lin <quic_ilial@quicinc.com>
Subject: [PATCH net-next 4/4] xfrm: Support UDP encapsulation in packet offload mode
Date: Wed, 19 Jul 2023 12:26:56 +0300
Message-ID: <051ea7f99b08e90bedb429123bf5e0a1ae0b0757.1689757619.git.leon@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1689757619.git.leon@kernel.org>
References: <cover.1689757619.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

Since mlx5 supports UDP encapsulation in packet offload, change the XFRM
core to allow users to configure it.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 net/xfrm/xfrm_device.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/net/xfrm/xfrm_device.c b/net/xfrm/xfrm_device.c
index 533697e2488f..3784534c9185 100644
--- a/net/xfrm/xfrm_device.c
+++ b/net/xfrm/xfrm_device.c
@@ -247,12 +247,6 @@ int xfrm_dev_state_add(struct net *net, struct xfrm_state *x,
 		return -EINVAL;
 	}
 
-	/* We don't yet support UDP encapsulation and TFC padding. */
-	if (x->encap || x->tfcpad) {
-		NL_SET_ERR_MSG(extack, "Encapsulation and TFC padding can't be offloaded");
-		return -EINVAL;
-	}
-
 	if (xuo->flags &
 	    ~(XFRM_OFFLOAD_IPV6 | XFRM_OFFLOAD_INBOUND | XFRM_OFFLOAD_PACKET)) {
 		NL_SET_ERR_MSG(extack, "Unrecognized flags in offload request");
@@ -260,6 +254,13 @@ int xfrm_dev_state_add(struct net *net, struct xfrm_state *x,
 	}
 
 	is_packet_offload = xuo->flags & XFRM_OFFLOAD_PACKET;
+
+	/* We don't yet support UDP encapsulation and TFC padding. */
+	if ((!is_packet_offload && x->encap) || x->tfcpad) {
+		NL_SET_ERR_MSG(extack, "Encapsulation and TFC padding can't be offloaded");
+		return -EINVAL;
+	}
+
 	dev = dev_get_by_index(net, xuo->ifindex);
 	if (!dev) {
 		if (!(xuo->flags & XFRM_OFFLOAD_INBOUND)) {
-- 
2.41.0


