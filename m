Return-Path: <netdev+bounces-18528-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8F27577CB
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 11:24:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A56D028116F
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 09:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 989D7E55E;
	Tue, 18 Jul 2023 09:24:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC07E547
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 09:24:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10489C433C8;
	Tue, 18 Jul 2023 09:24:07 +0000 (UTC)
From: Ilia Lin <quic_ilial@quicinc.com>
To: steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	leonro@nvidia.com,
	Ilia Lin <ilia.lin@kernel.org>
Subject: [PATCH] xfrm: Allow ESP over UDP in packet offload mode
Date: Tue, 18 Jul 2023 12:24:05 +0300
Message-Id: <20230718092405.4124345-1-quic_ilial@quicinc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ESP encapsulation is not supported only in crypto mode.
In packet offload mode, the RX is bypassing the XFRM,
so we can enable the encapsulation.

Signed-off-by: Ilia Lin <ilia.lin@kernel.org>
---
 net/xfrm/xfrm_device.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/xfrm/xfrm_device.c b/net/xfrm/xfrm_device.c
index 4aff76c6f12e0..3018468d97662 100644
--- a/net/xfrm/xfrm_device.c
+++ b/net/xfrm/xfrm_device.c
@@ -246,8 +246,10 @@ int xfrm_dev_state_add(struct net *net, struct xfrm_state *x,
 		return -EINVAL;
 	}
 
-	/* We don't yet support UDP encapsulation and TFC padding. */
-	if (x->encap || x->tfcpad) {
+	is_packet_offload = xuo->flags & XFRM_OFFLOAD_PACKET;
+
+	/* We don't yet support UDP encapsulation except full mode and TFC padding. */
+	if ((!is_packet_offload && x->encap) || x->tfcpad) {
 		NL_SET_ERR_MSG(extack, "Encapsulation and TFC padding can't be offloaded");
 		return -EINVAL;
 	}
@@ -258,7 +260,6 @@ int xfrm_dev_state_add(struct net *net, struct xfrm_state *x,
 		return -EINVAL;
 	}
 
-	is_packet_offload = xuo->flags & XFRM_OFFLOAD_PACKET;
 	dev = dev_get_by_index(net, xuo->ifindex);
 	if (!dev) {
 		if (!(xuo->flags & XFRM_OFFLOAD_INBOUND)) {
-- 


