Return-Path: <netdev+bounces-184478-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE956A95A57
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 03:17:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BBA816FE39
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 01:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A90174EF0;
	Tue, 22 Apr 2025 01:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lPwc9Lb5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1D53D6A
	for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 01:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745284628; cv=none; b=t++eLA7WAFUmZEM/nW+ySYn33I4xofzkkmEtCsO5u4HH/K8KxF5qlsSXa3FS0i+H4WAbOTKeq9ejKJo2+paW/MQawImf+C4lreX6oy3bO8Ds/UNORqyV0POezgYlIfA+w4VNbHHtK4fTyINWlALbYVvhDge3sFNunxOaHa3elz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745284628; c=relaxed/simple;
	bh=GfaMNTFMVfkspfV5xoMIfCbuTf2dYrYClHiO/wgBK0I=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=brOowmmRegPgua8KPt40V2JfUADKVfgraAjBkOTdQlR2oURpniLQo+ng2nJiXo7+GG8elbx1/Ibi4+zPi05QjcErgci0SjzZ1+sst7VdjAH82v+TeLZEPbjqSjMZz++FPqFRjmXUNSrXLPV5DXNLE8x418HgHViFsI94m4SIzu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lPwc9Lb5; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3087a704c6bso3410781a91.2
        for <netdev@vger.kernel.org>; Mon, 21 Apr 2025 18:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745284625; x=1745889425; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=j1MUyKQ9U/NG55RD5R2ZQj332SLYWQY3D73CQ+rdOK4=;
        b=lPwc9Lb5p6CPNHeoZp4pLRJ6dKiUusAqb0CJ8ta09+fZCvViimkbyBQt7uXHz7GyFq
         IEsWhEeY1MdbJaPfpYqAq+PUuP2hvoo1sPW2meaX8FuAsHLm1/Wqt+PvsmEtQxgUtCh7
         ol7w+GUQdfQllqJwgkt+gqeDAfF3NSfg9V64axXEhOFtBKRXKZk+w3p2KwFRI4XoAiwe
         1dHYZ2nKN99QRscfj16Pa7EWcZhBgtIehX8BEl+Aw4AvQSbHkNmsIGGH51WgialM3dLX
         y6/cwExpKS66St2qt0T9PlRZ4T2qIgETrB4rzpfxU78EOOQWsoq7wq/s6h0eMON2YhaW
         KHvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745284625; x=1745889425;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j1MUyKQ9U/NG55RD5R2ZQj332SLYWQY3D73CQ+rdOK4=;
        b=vCc0vX35hFGyzdP8HWSKRC21WdeWT1XPD4Gfo0gF+T/vUXeC3pNhlZ3In9JLaeuANJ
         W+pdPCI3jOhT6Mkye/qB3JVRkP81ozMR6pMXGJwYAPIaOKBd2OePra/jELMGye9Vy2Kq
         SBbh5OkKMHUKQ1M0cwO8dAI1t8cH4XcY47FDHw7ZdkVKDgqHd/xPH4l3jgSoKgLz/dtK
         1WSxF/PowhiFxYy0aI67sJYqUOXttJxW452go4ldkv1pl+MNcHfohdvepF/40nwDMN5I
         aig2zXY6pzMnbEkSWo3hh/bTHMWfV238Y/vOQeeXyuCXnXkUSKxidgriVeju8rbkOhQH
         5SnA==
X-Gm-Message-State: AOJu0YzUI07lXC8+ZJK5rcnLPq/KnJQwsFHtJPx1WkDaHRaEnUDu1byL
	RCIkunFzqnhsNZs+y/ipHw3dOS36PhLB3Z5S61PsXhC+QL5oYtN8g1fuxv5uyaAtyc+/gTValnk
	i6ZvNN23ZvdREYrQsmbsrPuqm3ZYFS8ebMFTSQ9TPP+YgqtQYKS85vnkCw2CZEqJK2yzSUhXZg3
	5CnE9qehLLXqg3RJdINKJLIoHpftv8KqZoAXdiCW8ADJc=
X-Google-Smtp-Source: AGHT+IHWBqFfEGYxXdqALuKh2tlP9SZ3mN9clBIIss7v0GCHLMwKyZJ9kxUd3+2F7t522UC+HRfXLj1RZ8Ulqg==
X-Received: from pjbst13.prod.google.com ([2002:a17:90b:1fcd:b0:2fe:7f7a:74b2])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:5827:b0:2ee:f076:20f1 with SMTP id 98e67ed59e1d1-3087ba53cd7mr22984986a91.0.1745284624818;
 Mon, 21 Apr 2025 18:17:04 -0700 (PDT)
Date: Mon, 21 Apr 2025 18:16:32 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.805.g082f7c87e0-goog
Message-ID: <20250422011643.3509287-1-joshwash@google.com>
Subject: [PATCH net-next] xdp: create locked/unlocked instances of xdp
 redirect target setters
From: Joshua Washington <joshwash@google.com>
To: netdev@vger.kernel.org
Cc: Joshua Washington <joshwash@google.com>, bpf@vger.kernel.org, 
	Mina Almasry <almasrymina@google.com>, Willem de Bruijn <willemb@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Jeroen de Borst <jeroendb@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Simon Horman <horms@kernel.org>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Shailend Chand <shailend@google.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Joe Damato <jdamato@fastly.com>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Commit 03df156dd3a6 ("xdp: double protect netdev->xdp_flags with
netdev->lock") introduces the netdev lock to xdp_set_features_flag().
The change includes a _locked version of the method, as it is possible
for a driver to have already acquired the netdev lock before calling
this helper. However, the same applies to
xdp_features_(set|clear)_redirect_flags(), which ends up calling the
unlocked version of xdp_set_features_flags() leading to deadlocks in
GVE, which grabs the netdev lock as part of its suspend, reset, and
shutdown processes:

[  833.265543] WARNING: possible recursive locking detected
[  833.270949] 6.15.0-rc1 #6 Tainted: G            E
[  833.276271] --------------------------------------------
[  833.281681] systemd-shutdow/1 is trying to acquire lock:
[  833.287090] ffff949d2b148c68 (&dev->lock){+.+.}-{4:4}, at: xdp_set_features_flag+0x29/0x90
[  833.295470]
[  833.295470] but task is already holding lock:
[  833.301400] ffff949d2b148c68 (&dev->lock){+.+.}-{4:4}, at: gve_shutdown+0x44/0x90 [gve]
[  833.309508]
[  833.309508] other info that might help us debug this:
[  833.316130]  Possible unsafe locking scenario:
[  833.316130]
[  833.322142]        CPU0
[  833.324681]        ----
[  833.327220]   lock(&dev->lock);
[  833.330455]   lock(&dev->lock);
[  833.333689]
[  833.333689]  *** DEADLOCK ***
[  833.333689]
[  833.339701]  May be due to missing lock nesting notation
[  833.339701]
[  833.346582] 5 locks held by systemd-shutdow/1:
[  833.351205]  #0: ffffffffa9c89130 (system_transition_mutex){+.+.}-{4:4}, at: __se_sys_reboot+0xe6/0x210
[  833.360695]  #1: ffff93b399e5c1b8 (&dev->mutex){....}-{4:4}, at: device_shutdown+0xb4/0x1f0
[  833.369144]  #2: ffff949d19a471b8 (&dev->mutex){....}-{4:4}, at: device_shutdown+0xc2/0x1f0
[  833.377603]  #3: ffffffffa9eca050 (rtnl_mutex){+.+.}-{4:4}, at: gve_shutdown+0x33/0x90 [gve]
[  833.386138]  #4: ffff949d2b148c68 (&dev->lock){+.+.}-{4:4}, at: gve_shutdown+0x44/0x90 [gve]

Introduce xdp_features_(set|clear)_redirect_target_locked() versions
which assume that the netdev lock has already been acquired before
setting the XDP feature flag and update GVE to use the locked version.

Cc: bpf@vger.kernel.org
Fixes: 03df156dd3a6 ("xdp: double protect netdev->xdp_flags with netdev->lock")
Tested-by: Mina Almasry <almasrymina@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
Signed-off-by: Joshua Washington <joshwash@google.com>
---
 drivers/net/ethernet/google/gve/gve_main.c |  4 ++--
 include/net/xdp.h                          |  3 +++
 net/core/xdp.c                             | 25 ++++++++++++++++++----
 3 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 8aaac9101377..446e4b6fd3f1 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -1830,7 +1830,7 @@ static void gve_turndown(struct gve_priv *priv)
 	/* Stop tx queues */
 	netif_tx_disable(priv->dev);
 
-	xdp_features_clear_redirect_target(priv->dev);
+	xdp_features_clear_redirect_target_locked(priv->dev);
 
 	gve_clear_napi_enabled(priv);
 	gve_clear_report_stats(priv);
@@ -1902,7 +1902,7 @@ static void gve_turnup(struct gve_priv *priv)
 	}
 
 	if (priv->tx_cfg.num_xdp_queues && gve_supports_xdp_xmit(priv))
-		xdp_features_set_redirect_target(priv->dev, false);
+		xdp_features_set_redirect_target_locked(priv->dev, false);
 
 	gve_set_napi_enabled(priv);
 }
diff --git a/include/net/xdp.h b/include/net/xdp.h
index 20e41b5ff319..b40f1f96cb11 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -618,7 +618,10 @@ bool bpf_dev_bound_kfunc_id(u32 btf_id);
 void xdp_set_features_flag(struct net_device *dev, xdp_features_t val);
 void xdp_set_features_flag_locked(struct net_device *dev, xdp_features_t val);
 void xdp_features_set_redirect_target(struct net_device *dev, bool support_sg);
+void xdp_features_set_redirect_target_locked(struct net_device *dev,
+					     bool support_sg);
 void xdp_features_clear_redirect_target(struct net_device *dev);
+void xdp_features_clear_redirect_target_locked(struct net_device *dev);
 #else
 static inline u32 bpf_xdp_metadata_kfunc_id(int id) { return 0; }
 static inline bool bpf_dev_bound_kfunc_id(u32 btf_id) { return false; }
diff --git a/net/core/xdp.c b/net/core/xdp.c
index a014df88620c..ea819764ae39 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -1014,21 +1014,38 @@ void xdp_set_features_flag(struct net_device *dev, xdp_features_t val)
 }
 EXPORT_SYMBOL_GPL(xdp_set_features_flag);
 
-void xdp_features_set_redirect_target(struct net_device *dev, bool support_sg)
+void xdp_features_set_redirect_target_locked(struct net_device *dev,
+					     bool support_sg)
 {
 	xdp_features_t val = (dev->xdp_features | NETDEV_XDP_ACT_NDO_XMIT);
 
 	if (support_sg)
 		val |= NETDEV_XDP_ACT_NDO_XMIT_SG;
-	xdp_set_features_flag(dev, val);
+	xdp_set_features_flag_locked(dev, val);
+}
+EXPORT_SYMBOL_GPL(xdp_features_set_redirect_target_locked);
+
+void xdp_features_set_redirect_target(struct net_device *dev, bool support_sg)
+{
+	netdev_lock(dev);
+	xdp_features_set_redirect_target_locked(dev, support_sg);
+	netdev_unlock(dev);
 }
 EXPORT_SYMBOL_GPL(xdp_features_set_redirect_target);
 
-void xdp_features_clear_redirect_target(struct net_device *dev)
+void xdp_features_clear_redirect_target_locked(struct net_device *dev)
 {
 	xdp_features_t val = dev->xdp_features;
 
 	val &= ~(NETDEV_XDP_ACT_NDO_XMIT | NETDEV_XDP_ACT_NDO_XMIT_SG);
-	xdp_set_features_flag(dev, val);
+	xdp_set_features_flag_locked(dev, val);
+}
+EXPORT_SYMBOL_GPL(xdp_features_clear_redirect_target_locked);
+
+void xdp_features_clear_redirect_target(struct net_device *dev)
+{
+	netdev_lock(dev);
+	xdp_features_clear_redirect_target_locked(dev);
+	netdev_unlock(dev);
 }
 EXPORT_SYMBOL_GPL(xdp_features_clear_redirect_target);
-- 
2.49.0.805.g082f7c87e0-goog


