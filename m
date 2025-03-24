Return-Path: <netdev+bounces-177013-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A2646A6D418
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 07:19:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1828B7A396C
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 06:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A8C18FC80;
	Mon, 24 Mar 2025 06:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="e/IQulgo"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8303E13FEE
	for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 06:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742797150; cv=none; b=Hb6D3pPFMrmm/unyOr539ljW33rtlfohzeFjq5jqNiVuqP9v+iVSRawqnvDJR4Dkn+9AwdawIJl2HYaRh48VcSrJcH4RStENIsY1Bd24NZ9UD3awr7PLRKcOv9WxFqMEj/xGFjHlvu8cqh/FvMk6k6mCJ56X1Y8ymQDiFSXoeJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742797150; c=relaxed/simple;
	bh=Q9nZD8g5kV2Kp+b6H5Z0GfrAseGQdAheVGppZ/BACYk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ja3nib731bpvNQU7h8iKXOlKnw97RsRfHxJbGLR6oY6J3dApUqaF+pvlNtMybTEfRvyy25YysMvKmqUQ/hYvSsh7PP30049+UmrMBqvuybR++/zPlA/XkT34cH42DUvOihXEZmOkO0g8CfF3/7gL5Y5drmxucsN3AFA1P2XZmQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=e/IQulgo; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 2FCCB20539;
	Mon, 24 Mar 2025 07:18:59 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hpBV4edNkpWX; Mon, 24 Mar 2025 07:18:58 +0100 (CET)
Received: from cas-essen-01.secunet.de (rl1.secunet.de [10.53.40.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 579592074F;
	Mon, 24 Mar 2025 07:18:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 579592074F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1742797138;
	bh=gQAJ39wDU0xAYtXFzfFJXOJPOTsZjFhJ5RUuQ39rsTM=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=e/IQulgokfIEsBUvt0Qj/kkuSzqvsnMZ9DEDGI1ZpFIMqfpEIO9AYqJjhKTjCjxXh
	 fwyaMhPN9AsF1ac/Gyy8dZSrAkV/WEjLXRSa4fh4J8sZO3i2NuFlPzMrtc0z6dmlVT
	 VikMS8zF6/oWhgxUmz76IAbebwxesIxziNO/o1Pznt++UTQJK9qTncvUU8CcgMU7+z
	 rl1Uwj4GAMjkdvO/eav/RyiSc6t7poB2pTmRm7ofrMWaJXH9X4L31trSmWR4BsbN6e
	 n6EpRQq09/QPOxTU2IQf++CJxqJa9hN1F7yIqyKrB5eKYUMDEtRf36CuBYX/0ax8xm
	 z5oGLvSU5Hsbg==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 24 Mar 2025 07:18:58 +0100
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Mar
 2025 07:18:57 +0100
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 807BD3182E94; Mon, 24 Mar 2025 07:18:57 +0100 (CET)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 2/8] xfrm: delay initialization of offload path till its actually requested
Date: Mon, 24 Mar 2025 07:18:49 +0100
Message-ID: <20250324061855.4116819-3-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250324061855.4116819-1-steffen.klassert@secunet.com>
References: <20250324061855.4116819-1-steffen.klassert@secunet.com>
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

From: Leon Romanovsky <leonro@nvidia.com>

XFRM offload path is probed even if offload isn't needed at all. Let's
make sure that x->type_offload pointer stays NULL for such path to
reduce ambiguity.

Fixes: 9d389d7f84bb ("xfrm: Add a xfrm type offload.")
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 include/net/xfrm.h     | 11 ++++++++++-
 net/xfrm/xfrm_device.c | 13 ++++++++-----
 net/xfrm/xfrm_state.c  | 32 ++++++++++++++------------------
 net/xfrm/xfrm_user.c   |  2 +-
 4 files changed, 33 insertions(+), 25 deletions(-)

diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index ed4b83696c77..e1eed5d47d07 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -464,6 +464,15 @@ struct xfrm_type_offload {
 
 int xfrm_register_type_offload(const struct xfrm_type_offload *type, unsigned short family);
 void xfrm_unregister_type_offload(const struct xfrm_type_offload *type, unsigned short family);
+void xfrm_set_type_offload(struct xfrm_state *x);
+static inline void xfrm_unset_type_offload(struct xfrm_state *x)
+{
+	if (!x->type_offload)
+		return;
+
+	module_put(x->type_offload->owner);
+	x->type_offload = NULL;
+}
 
 /**
  * struct xfrm_mode_cbs - XFRM mode callbacks
@@ -1760,7 +1769,7 @@ void xfrm_spd_getinfo(struct net *net, struct xfrmk_spdinfo *si);
 u32 xfrm_replay_seqhi(struct xfrm_state *x, __be32 net_seq);
 int xfrm_init_replay(struct xfrm_state *x, struct netlink_ext_ack *extack);
 u32 xfrm_state_mtu(struct xfrm_state *x, int mtu);
-int __xfrm_init_state(struct xfrm_state *x, bool init_replay, bool offload,
+int __xfrm_init_state(struct xfrm_state *x, bool init_replay,
 		      struct netlink_ext_ack *extack);
 int xfrm_init_state(struct xfrm_state *x);
 int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type);
diff --git a/net/xfrm/xfrm_device.c b/net/xfrm/xfrm_device.c
index d1fa94e52cea..97c8030cc417 100644
--- a/net/xfrm/xfrm_device.c
+++ b/net/xfrm/xfrm_device.c
@@ -244,11 +244,6 @@ int xfrm_dev_state_add(struct net *net, struct xfrm_state *x,
 	xfrm_address_t *daddr;
 	bool is_packet_offload;
 
-	if (!x->type_offload) {
-		NL_SET_ERR_MSG(extack, "Type doesn't support offload");
-		return -EINVAL;
-	}
-
 	if (xuo->flags &
 	    ~(XFRM_OFFLOAD_IPV6 | XFRM_OFFLOAD_INBOUND | XFRM_OFFLOAD_PACKET)) {
 		NL_SET_ERR_MSG(extack, "Unrecognized flags in offload request");
@@ -310,6 +305,13 @@ int xfrm_dev_state_add(struct net *net, struct xfrm_state *x,
 		return -EINVAL;
 	}
 
+	xfrm_set_type_offload(x);
+	if (!x->type_offload) {
+		NL_SET_ERR_MSG(extack, "Type doesn't support offload");
+		dev_put(dev);
+		return -EINVAL;
+	}
+
 	xso->dev = dev;
 	netdev_tracker_alloc(dev, &xso->dev_tracker, GFP_ATOMIC);
 	xso->real_dev = dev;
@@ -332,6 +334,7 @@ int xfrm_dev_state_add(struct net *net, struct xfrm_state *x,
 		netdev_put(dev, &xso->dev_tracker);
 		xso->type = XFRM_DEV_OFFLOAD_UNSPECIFIED;
 
+		xfrm_unset_type_offload(x);
 		/* User explicitly requested packet offload mode and configured
 		 * policy in addition to the XFRM state. So be civil to users,
 		 * and return an error instead of taking fallback path.
diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index ad2202fa82f3..69af5964c886 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -424,18 +424,18 @@ void xfrm_unregister_type_offload(const struct xfrm_type_offload *type,
 }
 EXPORT_SYMBOL(xfrm_unregister_type_offload);
 
-static const struct xfrm_type_offload *
-xfrm_get_type_offload(u8 proto, unsigned short family, bool try_load)
+void xfrm_set_type_offload(struct xfrm_state *x)
 {
 	const struct xfrm_type_offload *type = NULL;
 	struct xfrm_state_afinfo *afinfo;
+	bool try_load = true;
 
 retry:
-	afinfo = xfrm_state_get_afinfo(family);
+	afinfo = xfrm_state_get_afinfo(x->props.family);
 	if (unlikely(afinfo == NULL))
-		return NULL;
+		goto out;
 
-	switch (proto) {
+	switch (x->id.proto) {
 	case IPPROTO_ESP:
 		type = afinfo->type_offload_esp;
 		break;
@@ -449,18 +449,16 @@ xfrm_get_type_offload(u8 proto, unsigned short family, bool try_load)
 	rcu_read_unlock();
 
 	if (!type && try_load) {
-		request_module("xfrm-offload-%d-%d", family, proto);
+		request_module("xfrm-offload-%d-%d", x->props.family,
+			       x->id.proto);
 		try_load = false;
 		goto retry;
 	}
 
-	return type;
-}
-
-static void xfrm_put_type_offload(const struct xfrm_type_offload *type)
-{
-	module_put(type->owner);
+out:
+	x->type_offload = type;
 }
+EXPORT_SYMBOL(xfrm_set_type_offload);
 
 static const struct xfrm_mode xfrm4_mode_map[XFRM_MODE_MAX] = {
 	[XFRM_MODE_BEET] = {
@@ -609,8 +607,6 @@ static void ___xfrm_state_destroy(struct xfrm_state *x)
 	kfree(x->coaddr);
 	kfree(x->replay_esn);
 	kfree(x->preplay_esn);
-	if (x->type_offload)
-		xfrm_put_type_offload(x->type_offload);
 	if (x->type) {
 		x->type->destructor(x);
 		xfrm_put_type(x->type);
@@ -784,6 +780,8 @@ void xfrm_dev_state_free(struct xfrm_state *x)
 	struct xfrm_dev_offload *xso = &x->xso;
 	struct net_device *dev = READ_ONCE(xso->dev);
 
+	xfrm_unset_type_offload(x);
+
 	if (dev && dev->xfrmdev_ops) {
 		spin_lock_bh(&xfrm_state_dev_gc_lock);
 		if (!hlist_unhashed(&x->dev_gclist))
@@ -3122,7 +3120,7 @@ u32 xfrm_state_mtu(struct xfrm_state *x, int mtu)
 }
 EXPORT_SYMBOL_GPL(xfrm_state_mtu);
 
-int __xfrm_init_state(struct xfrm_state *x, bool init_replay, bool offload,
+int __xfrm_init_state(struct xfrm_state *x, bool init_replay,
 		      struct netlink_ext_ack *extack)
 {
 	const struct xfrm_mode *inner_mode;
@@ -3178,8 +3176,6 @@ int __xfrm_init_state(struct xfrm_state *x, bool init_replay, bool offload,
 		goto error;
 	}
 
-	x->type_offload = xfrm_get_type_offload(x->id.proto, family, offload);
-
 	err = x->type->init_state(x, extack);
 	if (err)
 		goto error;
@@ -3229,7 +3225,7 @@ int xfrm_init_state(struct xfrm_state *x)
 {
 	int err;
 
-	err = __xfrm_init_state(x, true, false, NULL);
+	err = __xfrm_init_state(x, true, NULL);
 	if (!err)
 		x->km.state = XFRM_STATE_VALID;
 
diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index 5877eabe9d95..b5266e0848e8 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -919,7 +919,7 @@ static struct xfrm_state *xfrm_state_construct(struct net *net,
 			goto error;
 	}
 
-	err = __xfrm_init_state(x, false, attrs[XFRMA_OFFLOAD_DEV], extack);
+	err = __xfrm_init_state(x, false, extack);
 	if (err)
 		goto error;
 
-- 
2.34.1


