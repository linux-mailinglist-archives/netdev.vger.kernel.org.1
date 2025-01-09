Return-Path: <netdev+bounces-156605-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DAFE7A0721F
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 10:53:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EDBA1882675
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 09:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DE94216615;
	Thu,  9 Jan 2025 09:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="S3qT9R+E"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23479214810
	for <netdev@vger.kernel.org>; Thu,  9 Jan 2025 09:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736416141; cv=none; b=F9y1+xHDDSt4+lGK4uz3rN1tb/1Pg+kMZTM8/chYGgMCBrRxVum1cfIZPHrIhAOedgM4+1WnWZYqaTGtALwzrUr1HmiYYNo9UUh2uDw56f0WfyWlW7gVFzt4nx0NiU8FneMhwCqHF1qYVzKnkAsYVnK0fEtSAHCrFaLa8eCL5Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736416141; c=relaxed/simple;
	bh=9hAMYhpsbwlpljUP1BM1Wn34YFUStyhHZdEKIPRvjhE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jOakg9EJnykpJgZnRIkeywycPErv93w2tFnfQbJWAKF7YKkiFv3HQYfIYziq2v24PNftWMehT0bEND9Kg868Eb5wPV2yB+E1CrooE9EtQzpbLdWU3LSYj3tAY/aw1uZ/LcDVU8M6FCoGzcMCtPYZMztxmDmVe9xfuvZHLwmPCLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=S3qT9R+E; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 4E7DA2087D;
	Thu,  9 Jan 2025 10:48:57 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CUFT6x0QO8Jq; Thu,  9 Jan 2025 10:48:56 +0100 (CET)
Received: from cas-essen-01.secunet.de (rl1.secunet.de [10.53.40.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id A7AF92006C;
	Thu,  9 Jan 2025 10:48:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com A7AF92006C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1736416136;
	bh=zEcPk9eoAimWg9Uecj12jPTg0ST66t7UqMQd6LqSfX4=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=S3qT9R+EbuE57RtFrkdMwfbnwsUP/cTPYYMjxroGk7aFuBpT0NrfBZK/qwIXnkAKO
	 4fvUhU2ATwzs/2wMowMEWzXd3y2TOywct2Eh2spW9sXXmAIb3y/NWJihLu8BmhPvVg
	 O8BD3AqhouRKcbwiKP4yBKLUqRnGz+ISJZDux/UX5M7w/v7FqDY/skmx1XX88GaGIM
	 DtvDDtlsQyiu2mpSluCDXpMW/zTZkJe2EJTBsx6H+kFAgDqeWVrvEXOaYYMDKizDR8
	 qzGVgcfCCHfkhYs/hlBHFfXwt8gU23rECDg/ZnWMVMZutAWr1GdBmE0ADukf/X8lax
	 oSFwxEWVuFKWg==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 9 Jan 2025 10:48:56 +0100
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 9 Jan
 2025 10:48:56 +0100
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id BDAE7318437F; Thu,  9 Jan 2025 10:43:29 +0100 (CET)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 17/17] net/mlx5e: Update TX ESN context for IPSec hardware offload
Date: Thu, 9 Jan 2025 10:43:21 +0100
Message-ID: <20250109094321.2268124-18-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250109094321.2268124-1-steffen.klassert@secunet.com>
References: <20250109094321.2268124-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

From: Jianbo Liu <jianbol@nvidia.com>

ESN context must be synced between software and hardware for both RX
and TX. As the call to xfrm_dev_state_advance_esn() is added for TX,
this patch add the missing logic for TX. So the update is also checked
on every packet sent, to see if need to trigger ESN update worker.

Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 .../mellanox/mlx5/core/en_accel/ipsec.c       | 40 +++++++------------
 1 file changed, 15 insertions(+), 25 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
index 3dd4f2492090..8489b0a0e8bd 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
@@ -94,25 +94,14 @@ static bool mlx5e_ipsec_update_esn_state(struct mlx5e_ipsec_sa_entry *sa_entry)
 	u32 esn, esn_msb;
 	u8 overlap;
 
-	switch (x->xso.type) {
-	case XFRM_DEV_OFFLOAD_PACKET:
-		switch (x->xso.dir) {
-		case XFRM_DEV_OFFLOAD_IN:
-			esn = x->replay_esn->seq;
-			esn_msb = x->replay_esn->seq_hi;
-			break;
-		case XFRM_DEV_OFFLOAD_OUT:
-			esn = x->replay_esn->oseq;
-			esn_msb = x->replay_esn->oseq_hi;
-			break;
-		default:
-			WARN_ON(true);
-			return false;
-		}
-		break;
-	case XFRM_DEV_OFFLOAD_CRYPTO:
-		/* Already parsed by XFRM core */
+	switch (x->xso.dir) {
+	case XFRM_DEV_OFFLOAD_IN:
 		esn = x->replay_esn->seq;
+		esn_msb = x->replay_esn->seq_hi;
+		break;
+	case XFRM_DEV_OFFLOAD_OUT:
+		esn = x->replay_esn->oseq;
+		esn_msb = x->replay_esn->oseq_hi;
 		break;
 	default:
 		WARN_ON(true);
@@ -121,11 +110,15 @@ static bool mlx5e_ipsec_update_esn_state(struct mlx5e_ipsec_sa_entry *sa_entry)
 
 	overlap = sa_entry->esn_state.overlap;
 
-	if (esn >= x->replay_esn->replay_window)
-		seq_bottom = esn - x->replay_esn->replay_window + 1;
+	if (!x->replay_esn->replay_window) {
+		seq_bottom = esn;
+	} else {
+		if (esn >= x->replay_esn->replay_window)
+			seq_bottom = esn - x->replay_esn->replay_window + 1;
 
-	if (x->xso.type == XFRM_DEV_OFFLOAD_CRYPTO)
-		esn_msb = xfrm_replay_seqhi(x, htonl(seq_bottom));
+		if (x->xso.type == XFRM_DEV_OFFLOAD_CRYPTO)
+			esn_msb = xfrm_replay_seqhi(x, htonl(seq_bottom));
+	}
 
 	if (sa_entry->esn_state.esn_msb)
 		sa_entry->esn_state.esn = esn;
@@ -980,9 +973,6 @@ static void mlx5e_xfrm_advance_esn_state(struct xfrm_state *x)
 	struct mlx5e_ipsec_sa_entry *sa_entry_shadow;
 	bool need_update;
 
-	if (x->xso.dir != XFRM_DEV_OFFLOAD_IN)
-		return;
-
 	need_update = mlx5e_ipsec_update_esn_state(sa_entry);
 	if (!need_update)
 		return;
-- 
2.34.1


