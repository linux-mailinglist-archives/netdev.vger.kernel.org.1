Return-Path: <netdev+bounces-174394-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C301A5E782
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 23:35:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 088231899C93
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 22:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA6A51F0E26;
	Wed, 12 Mar 2025 22:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O3fRef9I"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C2B1DFD95
	for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 22:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741818920; cv=none; b=oFCrfNsVyVrFNNeeKW8a7QjmzZeNHQcDO3JgswnowSbEauGqG2K33Nl9EHDAGoXPscryccdHGFvSV2lSF6wXsEbxB6LqCuouGsMEIguwIMiBxPDRPyBuiv3koe93JHg84VCTXTbaHTzbrJpw/H5DwOGgd/fAkTwPG/q1D4JHVZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741818920; c=relaxed/simple;
	bh=mUMfc61+oHRmSbEZXt/K/mgy4oEcVaPT6Jl9gBK4+NY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lDVfUaVRZ7288VRxOCTrN5bn/4lyszdovo9ZIoXnWeeHL/5lmoHvY9EX1fo1uMZRNUj17QE7knaQ5oyIO444Cyrh1NAQiauSaXl1zrhqf7TMYwQ/kDmBfZd74OH44+ckXwZcpolB8K7l5a81XANQFn4xnHek8fytUZxdjDlWjVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O3fRef9I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34BF0C4CEE3;
	Wed, 12 Mar 2025 22:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741818920;
	bh=mUMfc61+oHRmSbEZXt/K/mgy4oEcVaPT6Jl9gBK4+NY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O3fRef9IUqpCL3bpPuUWSNsdyA9H7lgML1frSadcazZgzXflnFHDESDz0Dwh+0YmT
	 MEdzcjMYZGfbC/Ebp7rQwxjl2K4Z20tkYdm/reV6inrCv0AKbLy+OdoxKjukeR+NcQ
	 YoaC+rLj4yr/TXbv827zOzVDP517pxgMPACyZlOkR2fwVfe68BTDyHGOVyhKMwcEwA
	 ShFQ/gDl3oLZuzOzJ1vOH75SM3/qHyCASmvK1jFlTDeOUSI/cHcuMBJYdcpVcrpapF
	 vS79+MGDQth1wJIrR6JhF3TItaKMJJauHQHPPdtigHS5VU+7h3VUnIYwGE6dpyP5dg
	 R5fdezIJj8cRA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	sdf@fomichev.me,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 01/11] net: bubble up taking netdev instance lock to callers of net_devmem_unbind_dmabuf()
Date: Wed, 12 Mar 2025 23:34:57 +0100
Message-ID: <20250312223507.805719-2-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250312223507.805719-1-kuba@kernel.org>
References: <20250312223507.805719-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A recent commit added taking the netdev instance lock
in netdev_nl_bind_rx_doit(), but didn't remove it in
net_devmem_unbind_dmabuf() which it calls from an error path.
Always expect the callers of net_devmem_unbind_dmabuf() to
hold the lock. This is consistent with net_devmem_bind_dmabuf().

(Not so) coincidentally this also protects mp_param with the instance
lock, which the rest of this series needs.

Fixes: 1d22d3060b9b ("net: drop rtnl_lock for queue_mgmt operations")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/core/devmem.c      | 2 --
 net/core/netdev-genl.c | 2 ++
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/core/devmem.c b/net/core/devmem.c
index 5c4d79a1bcd8..9e9db6de8631 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -127,10 +127,8 @@ void net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *binding)
 		rxq->mp_params.mp_priv = NULL;
 		rxq->mp_params.mp_ops = NULL;
 
-		netdev_lock(binding->dev);
 		rxq_idx = get_netdev_rx_queue_index(rxq);
 		WARN_ON(netdev_rx_queue_restart(binding->dev, rxq_idx));
-		netdev_unlock(binding->dev);
 	}
 
 	xa_erase(&net_devmem_dmabuf_bindings, binding->id);
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index a186fea63c09..9e4882a22407 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -947,7 +947,9 @@ void netdev_nl_sock_priv_destroy(struct netdev_nl_sock *priv)
 
 	mutex_lock(&priv->lock);
 	list_for_each_entry_safe(binding, temp, &priv->bindings, list) {
+		netdev_lock(binding->dev);
 		net_devmem_unbind_dmabuf(binding);
+		netdev_unlock(binding->dev);
 	}
 	mutex_unlock(&priv->lock);
 }
-- 
2.48.1


