Return-Path: <netdev+bounces-289823-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gBqCFfZuDWp9xQUAu9opvQ
	(envelope-from <netdev+bounces-289823-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 10:21:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E5A5899F2
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 10:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A3CB30DBD87
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 08:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A4493A873D;
	Wed, 20 May 2026 08:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f9iquGcG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3F93A7845
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 08:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779264631; cv=none; b=twLKqLzL7oSKSnA8D/UCXsUmHzCLQpg07+AXCaHA4FfW708agpkGDuf/bJfSAwphRVfeGzdmKVMu4o922Q9c/5h3rSkYfyaQ0lhYe4hY57E9It8CRurEe6hoRl+TcURmCERDSH92wuJ3jLTy+dWXnvWPaAzuB4LByMJJbfUyB8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779264631; c=relaxed/simple;
	bh=73443vAbOnViwJT99Snz/ZFTOD/YCP1uLgVIWnv0a50=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t79W7QQo2GmqKt1OjPOP6p675NPsw76E178QuzF0XfXFtYxyIOpVRCJNyrIpKpOolmudC9NQxxxt7KC9ogX1HLm5jZY3Lsnm7z/Bmrqc0pdStfVn3iGXiM6/6AjpiaiXhnietWFOIQQrqrwge6YpD6tgj3pFAW+Q1B3L8HDLsy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f9iquGcG; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-36a15ed5119so1054859a91.3
        for <netdev@vger.kernel.org>; Wed, 20 May 2026 01:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779264629; x=1779869429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vuIq0omjUggvBDRqrxdMgf0DV4raWV/SHuyYkGAo0Y8=;
        b=f9iquGcGVwemiYfwxzl/zSq+cRUMYjMTzWfgdQcuir2KNzPcJDCwh6P6udyRbn0fIB
         Bulj4BvJ3zYqcaGaleOABzu9HoGYKVigMnjeK2j0o0dx92FEQzx45i+J6c6EnVE0C295
         20QpeP+sK/ey2AVtD/djN2RaV96GNjJ+WAVNYblQgGRBj15ZA+gFYUOnmnTyaQyRbkD5
         uWbbgsHrCtemyx+Fp2n6uwDZPXejLTrSAbo/SUh0l0TeC/sc6h5TUmQ/ek14QqsAsvO/
         e0s3nUecv1YfIWR6Gber9LDHtHXqNsg4CT9VZyFX3Jt01ZsOKYBT7vhgiTjyh+uhNkwC
         hiUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779264629; x=1779869429;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vuIq0omjUggvBDRqrxdMgf0DV4raWV/SHuyYkGAo0Y8=;
        b=LQl2ydxZOKN4o0P3YWCrKDmywuq1DVz5d59b86MIJhb68tx5Op1JBiouw6AJqc0gs+
         9qp2bTHvGBW9YAWEhj6Zi5Jv939xSxT2wTMgJ3Jhtv9/t+OBe3y4/mmug51JX+l7kvv1
         v9DYcqxpc/GcpnROpmzBjqOhngYz/azaWZREbsQ+3fY/cn7Ybiw1D05GRd0uA99IsVhY
         iyuLKRJGUMyK/yp82itpY7g57sbvmc8K09EmufiIvNBZQmcjp4kPhwv7wapZ+P8rYiyi
         dadPuVGyHroxpxkX+z6qntcx8Cn/Q1CIDevGqj8t7nWKLeOePFhgLMcuTP0aSh+dLdTI
         o+Bw==
X-Gm-Message-State: AOJu0YzJgwZ02G8F2mjORuOiPhhwCcLlfeI2df75PAp4fuhmx9UjGY83
	mP8XsPxzGD6qiodoMksA3eZ9GnVvVMiNV9JiyK8rhAUl6COqbWjVdVtGDC1ynKLy
X-Gm-Gg: Acq92OEkEEK0M4kgPWlaWw1l63YKzd912ktedC1aZQn6fPVOGdUwvypmoEQuP9Z2H6k
	s/VNEgmUTYeKgru1m53Nrw6bg8alc1CDYMApVWOtlXMcVFCyQlrewM7K3adGw486Hb08rO5JOAv
	PJZMqEA8Lr9zKwm8xspqTuTi+BcWerEnR5AS6z/ho+nA0o7lB2XjA2UdUEDU+wfedjzseO9KJ11
	HLwu112tBDmmbl/cvjxEb/1V2Nq/N9zEjTxl77+fuKojLP8snr/KgwJo9vQqNnNz3+xLgDhKEAl
	9e5eGzCtgMS/Y25X2vQpW9SQ6SQxYWn3sINn72F5YwvTwtUspRFqDWlZtU6jsvwHflJCJYzW7nk
	SGjf+ZEKPgUA8olVDZ+WCG1CmyyDTXRxPdBf20W7HqjrWtgop9qnlCCYGArS2UyiftaQSOI8thU
	FDQLwqnrIqLdRMjatM/YodCsruapk5312N/ovVOicXgQ==
X-Received: by 2002:a17:902:8304:b0:2bc:8beb:525b with SMTP id d9443c01a7336-2bd7e8506a1mr188895445ad.18.1779264628831;
        Wed, 20 May 2026 01:10:28 -0700 (PDT)
Received: from mincom1 ([14.67.155.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5d116287sm211632735ad.68.2026.05.20.01.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 01:10:28 -0700 (PDT)
From: Jihong Min <hurryman2212@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	linux-kernel@vger.kernel.org,
	Jihong Min <hurryman2212@gmail.com>
Subject: [PATCH RFC net-next 1/4] xfrm: add a lower-device offload handle resolver
Date: Wed, 20 May 2026 17:10:01 +0900
Message-ID: <20260520081004.2232091-2-hurryman2212@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520081004.2232091-1-hurryman2212@gmail.com>
References: <20260520081004.2232091-1-hurryman2212@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[jvosburgh.net,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,secunet.com,gondor.apana.org.au,vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-289823-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hurryman2212@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: C6E5A5899F2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

An upper device can own an XFRM offload state while the selected
datapath device is one of its lower devices. A single xso.offload_handle
is not enough for that case because each lower device may return a
different hardware handle for the same state.

Add an optional xfrmdev_ops resolver and a lower-driver opt-in flag so
helper-aware lower drivers can resolve the handle for the lower device
they are transmitting or receiving on. Keep the direct-device path as
the fast path and clear upper private state when device offload state is
freed.

Assisted-by: Codex:gpt-5.5
Signed-off-by: Jihong Min <hurryman2212@gmail.com>
---
 include/linux/netdevice.h | 27 ++++++++++++++++++++++
 include/net/xfrm.h        | 48 +++++++++++++++++++++++++++++++++++++--
 net/xfrm/xfrm_state.c     |  1 +
 3 files changed, 74 insertions(+), 2 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 0e1e581efc5a..b4e844e90db8 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1033,6 +1033,16 @@ struct netdev_bpf {
 #define XDP_WAKEUP_TX (1 << 1)
 
 #ifdef CONFIG_XFRM_OFFLOAD
+/*
+ * xfrmdev_ops.flags values.
+ *
+ * XFRMDEV_OPS_F_LOWER_HANDLE marks a lower driver whose datapath gets XFRM
+ * hardware handles with xfrm_dev_state_lower_handle(). This is required when
+ * the XFRM state is owned by an upper device because xso.offload_handle may
+ * not contain the handle for the current lower device.
+ */
+#define XFRMDEV_OPS_F_LOWER_HANDLE	BIT(0)
+
 struct xfrmdev_ops {
 	int	(*xdo_dev_state_add)(struct net_device *dev,
 				     struct xfrm_state *x,
@@ -1048,6 +1058,23 @@ struct xfrmdev_ops {
 	int	(*xdo_dev_policy_add) (struct xfrm_policy *x, struct netlink_ext_ack *extack);
 	void	(*xdo_dev_policy_delete) (struct xfrm_policy *x);
 	void	(*xdo_dev_policy_free) (struct xfrm_policy *x);
+	/*
+	 * Resolve the offload handle for lower_dev when this upper device
+	 * owns the XFRM state. This belongs in xfrmdev_ops because the
+	 * resolver is an XFRM offload operation of the device that owns the
+	 * state. Keeping the dispatch here avoids a bonding-specific dependency
+	 * in the XFRM helper.
+	 *
+	 * Upper devices like bonding may implement this callback when they
+	 * keep the lower-device handle mapping. Lower devices must leave it
+	 * NULL because they do not own that map. Lower drivers advertise
+	 * that their datapath calls the resolver with
+	 * XFRMDEV_OPS_F_LOWER_HANDLE instead.
+	 */
+	unsigned long (*xdo_dev_state_lower_handle)(struct net_device *dev,
+						    struct xfrm_state *x,
+						    struct net_device *lower_dev);
+	u32	flags;
 };
 #endif
 
diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index 10d3edde6b2f..b61e2c023eb4 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -162,6 +162,10 @@ struct xfrm_dev_offload {
 	 */
 	struct net_device	*real_dev;
 	unsigned long		offload_handle;
+	/* Private state owned by dev in this structure when that device is an
+	 * upper device. Lower drivers must not use this directly.
+	 */
+	void __rcu		*upper_priv;
 	u8			dir : 2;
 	u8			type : 2;
 	u8			flags : 2;
@@ -1700,6 +1704,37 @@ struct xfrm_state *xfrm_state_lookup_byspi(struct net *net, __be32 spi,
 int xfrm_state_check_expire(struct xfrm_state *x);
 void xfrm_state_update_stats(struct net *net);
 #ifdef CONFIG_XFRM_OFFLOAD
+/*
+ * Return the hardware offload handle lower_dev should use for x. States
+ * installed directly on lower_dev use xso.offload_handle. States owned by an
+ * upper device are resolved through the owner's xdo_dev_state_lower_handle().
+ * Bonding uses that callback for replicated XFRM states because it installs the
+ * state on each slave and keeps the per-slave hardware handles internally.
+ */
+static inline unsigned long
+xfrm_dev_state_lower_handle(struct xfrm_state *x, struct net_device *lower_dev)
+{
+	struct xfrm_dev_offload *xdo = &x->xso;
+	struct net_device *real_dev = READ_ONCE(xdo->real_dev);
+	struct net_device *dev = READ_ONCE(xdo->dev);
+	unsigned long offload_handle = READ_ONCE(xdo->offload_handle);
+
+	if (!dev || !lower_dev)
+		return 0;
+
+	if (dev == lower_dev)
+		return offload_handle;
+
+	if (dev->xfrmdev_ops && dev->xfrmdev_ops->xdo_dev_state_lower_handle)
+		return dev->xfrmdev_ops->xdo_dev_state_lower_handle(dev, x,
+								    lower_dev);
+
+	if (real_dev == lower_dev)
+		return offload_handle;
+
+	return 0;
+}
+
 static inline void xfrm_dev_state_update_stats(struct xfrm_state *x)
 {
 	struct xfrm_dev_offload *xdo = &x->xso;
@@ -1711,6 +1746,12 @@ static inline void xfrm_dev_state_update_stats(struct xfrm_state *x)
 
 }
 #else
+static inline unsigned long
+xfrm_dev_state_lower_handle(struct xfrm_state *x, struct net_device *lower_dev)
+{
+	return 0;
+}
+
 static inline void xfrm_dev_state_update_stats(struct xfrm_state *x) {}
 #endif
 void xfrm_state_insert(struct xfrm_state *x);
@@ -2089,15 +2130,18 @@ static inline void xfrm_dev_state_advance_esn(struct xfrm_state *x)
 static inline bool xfrm_dst_offload_ok(struct dst_entry *dst)
 {
 	struct xfrm_state *x = dst->xfrm;
+	bool has_offload_state;
 	struct xfrm_dst *xdst;
 
 	if (!x || !x->type_offload)
 		return false;
 
 	xdst = (struct xfrm_dst *) dst;
-	if (!x->xso.offload_handle && !xdst->child->xfrm)
+	has_offload_state = x->xso.offload_handle ||
+			    rcu_access_pointer(x->xso.upper_priv);
+	if (!has_offload_state && !xdst->child->xfrm)
 		return true;
-	if (x->xso.offload_handle && (x->xso.dev == xfrm_dst_path(dst)->dev) &&
+	if (has_offload_state && (x->xso.dev == xfrm_dst_path(dst)->dev) &&
 	    !xdst->child->xfrm)
 		return true;
 
diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 686014d39429..584f913751bf 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -791,6 +791,7 @@ void xfrm_dev_state_free(struct xfrm_state *x)
 		if (dev->xfrmdev_ops->xdo_dev_state_free)
 			dev->xfrmdev_ops->xdo_dev_state_free(dev, x);
 		WRITE_ONCE(xso->dev, NULL);
+		RCU_INIT_POINTER(xso->upper_priv, NULL);
 		xso->type = XFRM_DEV_OFFLOAD_UNSPECIFIED;
 		netdev_put(dev, &xso->dev_tracker);
 	}
-- 
2.53.0

