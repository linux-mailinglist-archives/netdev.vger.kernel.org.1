Return-Path: <netdev+bounces-209242-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 872A0B0EC92
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 10:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 154973AAD78
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 08:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB232798FF;
	Wed, 23 Jul 2025 08:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="VI2lVMau"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8212278E6A
	for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 08:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753257646; cv=none; b=FTHd2sPEsFugT73OFQpXBkD3B7Hcgp3Ih9Y9NLWJ39CrA8AU7QMQHstxKPUSew7sCydgHa7hnMdlQ7+m6clWcdB+22MxFQUyjaaUkuhBSClJteccHcCfmhP67AURuA/+7z4oBu/s2ze/nAhU2zWCr1l7vhz7utv8UpfzEW6PjdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753257646; c=relaxed/simple;
	bh=cuk5/DR0diivOqm+dcyCNXdTAwQON0dxc3vcPudM2/M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZYbi4uqnf5UoMzsLNqOGrMxN1wvA4gpoTUg+dqocR22slJyBGSIqb/iPQMAWzNpsxmodghi3QvD4hnoxtd0R/VNRl7yMsM5AcgClLUIkkF/+ULMFIMK4JF/Qg7ou5+DdTvyAILvFb/5WRt+fmQWGZPDVi2Gf2vJjaEwZxb9cUls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=VI2lVMau; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 36C3420891;
	Wed, 23 Jul 2025 09:54:21 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vBiIYheNKo09; Wed, 23 Jul 2025 09:54:20 +0200 (CEST)
Received: from EXCH-01.secunet.de (unknown [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 4727B201A1;
	Wed, 23 Jul 2025 09:54:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 4727B201A1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1753257260;
	bh=kEB9ZtWF3MsS7SU8p0+6NrTgwhEXWOQGx2EvSh1aTBk=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=VI2lVMaukiR9L9hi3Ca1YljgSLxIS8kdY/vxJsEaHYzOePe0NChvl6XqS87tMPCeb
	 qmsrCwqYcYVoOSUK2iz2/zC0DWXiaQRg9TkR8Hm+ri1356S6E7Tf3CtrCio3DxoKZq
	 VW+S/8B7EloYx6kZXSL+kDZ+/EgnZ99/TU3ZdPXZSrnFInVO/5T2zKa4wKrwVt0C6N
	 i2zz2jxMZ5yXuynes4T146N7gGfCtsxi9JNs88tvg31pDWb5cSZgZmNeRyQ/ATRW5V
	 T5+naJKDoCCW6hbbDW9aphbXvW29N2vToagDSesz1a9SEtLVLjLR1lcFC6ZzCcPALG
	 dH17+gfrSkGag==
Received: from gauss2.secunet.de (10.182.7.193) by EXCH-01.secunet.de
 (10.32.0.171) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Wed, 23 Jul
 2025 09:54:20 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 9E3423184127; Wed, 23 Jul 2025 09:54:19 +0200 (CEST)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 3/8] xfrm: always initialize offload path
Date: Wed, 23 Jul 2025 09:53:55 +0200
Message-ID: <20250723075417.3432644-4-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250723075417.3432644-1-steffen.klassert@secunet.com>
References: <20250723075417.3432644-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 EXCH-01.secunet.de (10.32.0.171)

From: Leon Romanovsky <leonro@nvidia.com>

Offload path is used for GRO with SW IPsec, and not just for HW
offload. So initialize it anyway.

Fixes: 585b64f5a620 ("xfrm: delay initialization of offload path till its actually requested")
Reported-by: Sabrina Dubroca <sd@queasysnail.net>
Closes: https://lore.kernel.org/all/aEGW_5HfPqU1rFjl@krikkit
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 include/net/xfrm.h     | 2 +-
 net/xfrm/xfrm_device.c | 1 -
 net/xfrm/xfrm_state.c  | 6 ++----
 net/xfrm/xfrm_user.c   | 1 +
 4 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index a21e276dbe44..e45a275fca26 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -474,7 +474,7 @@ struct xfrm_type_offload {
 
 int xfrm_register_type_offload(const struct xfrm_type_offload *type, unsigned short family);
 void xfrm_unregister_type_offload(const struct xfrm_type_offload *type, unsigned short family);
-void xfrm_set_type_offload(struct xfrm_state *x);
+void xfrm_set_type_offload(struct xfrm_state *x, bool try_load);
 static inline void xfrm_unset_type_offload(struct xfrm_state *x)
 {
 	if (!x->type_offload)
diff --git a/net/xfrm/xfrm_device.c b/net/xfrm/xfrm_device.c
index 81fd486b5e56..d2819baea414 100644
--- a/net/xfrm/xfrm_device.c
+++ b/net/xfrm/xfrm_device.c
@@ -305,7 +305,6 @@ int xfrm_dev_state_add(struct net *net, struct xfrm_state *x,
 		return -EINVAL;
 	}
 
-	xfrm_set_type_offload(x);
 	if (!x->type_offload) {
 		NL_SET_ERR_MSG(extack, "Type doesn't support offload");
 		dev_put(dev);
diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 7e34fc94f668..c7e6472c623d 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -424,11 +424,10 @@ void xfrm_unregister_type_offload(const struct xfrm_type_offload *type,
 }
 EXPORT_SYMBOL(xfrm_unregister_type_offload);
 
-void xfrm_set_type_offload(struct xfrm_state *x)
+void xfrm_set_type_offload(struct xfrm_state *x, bool try_load)
 {
 	const struct xfrm_type_offload *type = NULL;
 	struct xfrm_state_afinfo *afinfo;
-	bool try_load = true;
 
 retry:
 	afinfo = xfrm_state_get_afinfo(x->props.family);
@@ -607,6 +606,7 @@ static void ___xfrm_state_destroy(struct xfrm_state *x)
 	kfree(x->coaddr);
 	kfree(x->replay_esn);
 	kfree(x->preplay_esn);
+	xfrm_unset_type_offload(x);
 	if (x->type) {
 		x->type->destructor(x);
 		xfrm_put_type(x->type);
@@ -780,8 +780,6 @@ void xfrm_dev_state_free(struct xfrm_state *x)
 	struct xfrm_dev_offload *xso = &x->xso;
 	struct net_device *dev = READ_ONCE(xso->dev);
 
-	xfrm_unset_type_offload(x);
-
 	if (dev && dev->xfrmdev_ops) {
 		spin_lock_bh(&xfrm_state_dev_gc_lock);
 		if (!hlist_unhashed(&x->dev_gclist))
diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index 59f258daf830..1db18f470f42 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -977,6 +977,7 @@ static struct xfrm_state *xfrm_state_construct(struct net *net,
 	/* override default values from above */
 	xfrm_update_ae_params(x, attrs, 0);
 
+	xfrm_set_type_offload(x, attrs[XFRMA_OFFLOAD_DEV]);
 	/* configure the hardware if offload is requested */
 	if (attrs[XFRMA_OFFLOAD_DEV]) {
 		err = xfrm_dev_state_add(net, x,
-- 
2.43.0


