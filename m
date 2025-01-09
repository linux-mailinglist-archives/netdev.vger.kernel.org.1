Return-Path: <netdev+bounces-156606-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E19A07221
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 10:53:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78F711886B30
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 09:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D13C216619;
	Thu,  9 Jan 2025 09:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="SZ10dAu+"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B24921660A
	for <netdev@vger.kernel.org>; Thu,  9 Jan 2025 09:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736416141; cv=none; b=hg4LpcR64lCgE3fT1s9ALy83ckOqfi0nrpcDEfTp+p1DjHdFlzbfiKx2MxIp9zVs6E3sApXehzYbmcIJh1Qudc9B+XjyX8Q715cWjkX2tQqsMAP3YXxVtmxNCLrbtG9J7TNTJLso65vYnq0syL3D9GBL2JZtbg5wABs0v9caIXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736416141; c=relaxed/simple;
	bh=ixmTz1Zaa3LIDxbPrHMFHzWhyRGgNaiKzyZ+GjHYEqM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SNt2a4LXQ0MOxBxkZyso4G3X/AiYQKA0nzBF/0EwO+yWD8fSiATn9g6hNDCOmudTyA4Cyuy3k8C9V4L8qwCu3w2J3dsNaTWmHKIm4Tf4npJ2ov/7JqiknUl/8vTtnAP2ggUF8mmJIR/itA2VJ6A6FmHH5BuOGq3EJrI5kb3Jqc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=SZ10dAu+; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id DA2C920890;
	Thu,  9 Jan 2025 10:48:57 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Hid-HHALK5u9; Thu,  9 Jan 2025 10:48:57 +0100 (CET)
Received: from cas-essen-01.secunet.de (rl1.secunet.de [10.53.40.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 020CA2085A;
	Thu,  9 Jan 2025 10:48:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 020CA2085A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1736416137;
	bh=6RxrkSvXpdCv/49BeaA7+wD2Ck2gIArYxZDzU/TZlg0=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=SZ10dAu+cl+kphjjq0ih12nzKSNQRvsDiORrECsJ611oEKQbz5grWCGtF2vw5S8Zh
	 Dvb3Tk+nuBAfFUdZcFHYfjchAwc62VZiPYMzc3HiZfUm797HWjrGHcd1QRkaBQaL+K
	 heCCAPn8i8gosgDSj1lK4pFUs1R4dS8QeISAz5AXmIKp7gtM19EZSugzFYHFERaQiZ
	 nlbnXO/gd5ucZuNTjRPbHoaPmG5z5dgi1x3xoH1FwczKOrFGDU/+0qxHfRTCpUO52W
	 Sdw9phEtx7A8oFv4WmJi6Zj8GVjFRHCsfsTusFZ3TIjbd2DTTRjXLaKgaMYhxmqYKV
	 lUUDxupXxFEng==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 9 Jan 2025 10:48:56 +0100
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 9 Jan
 2025 10:48:56 +0100
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id BA446318437E; Thu,  9 Jan 2025 10:43:29 +0100 (CET)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 16/17] xfrm: Support ESN context update to hardware for TX
Date: Thu, 9 Jan 2025 10:43:20 +0100
Message-ID: <20250109094321.2268124-17-steffen.klassert@secunet.com>
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
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

From: Jianbo Liu <jianbol@nvidia.com>

Previously xfrm_dev_state_advance_esn() was added for RX only. But
it's possible that ESN context also need to be synced to hardware for
TX, so call it for outbound in this patch.

Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 Documentation/networking/xfrm_device.rst                 | 3 ++-
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c          | 3 +++
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c | 3 +++
 net/xfrm/xfrm_replay.c                                   | 1 +
 4 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/networking/xfrm_device.rst b/Documentation/networking/xfrm_device.rst
index bfea9d8579ed..66f6e9a9b59a 100644
--- a/Documentation/networking/xfrm_device.rst
+++ b/Documentation/networking/xfrm_device.rst
@@ -169,7 +169,8 @@ the stack in xfrm_input().
 
 	hand the packet to napi_gro_receive() as usual
 
-In ESN mode, xdo_dev_state_advance_esn() is called from xfrm_replay_advance_esn().
+In ESN mode, xdo_dev_state_advance_esn() is called from
+xfrm_replay_advance_esn() for RX, and xfrm_replay_overflow_offload_esn for TX.
 Driver will check packet seq number and update HW ESN state machine if needed.
 
 Packet offload mode:
diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
index 97a261d5357e..1b3254b49443 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
@@ -6559,6 +6559,9 @@ static void cxgb4_advance_esn_state(struct xfrm_state *x)
 {
 	struct adapter *adap = netdev2adap(x->xso.dev);
 
+	if (x->xso.dir != XFRM_DEV_OFFLOAD_IN)
+		return;
+
 	if (!mutex_trylock(&uld_mutex)) {
 		dev_dbg(adap->pdev_dev,
 			"crypto uld critical resource is under use\n");
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
index ca92e518be76..3dd4f2492090 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
@@ -980,6 +980,9 @@ static void mlx5e_xfrm_advance_esn_state(struct xfrm_state *x)
 	struct mlx5e_ipsec_sa_entry *sa_entry_shadow;
 	bool need_update;
 
+	if (x->xso.dir != XFRM_DEV_OFFLOAD_IN)
+		return;
+
 	need_update = mlx5e_ipsec_update_esn_state(sa_entry);
 	if (!need_update)
 		return;
diff --git a/net/xfrm/xfrm_replay.c b/net/xfrm/xfrm_replay.c
index bc56c6305725..e500aebbad22 100644
--- a/net/xfrm/xfrm_replay.c
+++ b/net/xfrm/xfrm_replay.c
@@ -729,6 +729,7 @@ static int xfrm_replay_overflow_offload_esn(struct xfrm_state *x, struct sk_buff
 		}
 
 		replay_esn->oseq = oseq;
+		xfrm_dev_state_advance_esn(x);
 
 		if (xfrm_aevent_is_on(net))
 			xfrm_replay_notify(x, XFRM_REPLAY_UPDATE);
-- 
2.34.1


