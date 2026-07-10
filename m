Return-Path: <netdev+bounces-306478-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IIbFMzC6UGpU4AIAu9opvQ
	(envelope-from <netdev+bounces-306478-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 11:24:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 622F0738FFF
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 11:24:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=secunet.com header.s=202301 header.b="hzv/dEIw";
	dmarc=pass (policy=none) header.from=secunet.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306478-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-306478-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 06E0130CEFE0
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 09:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11D613DBD49;
	Fri, 10 Jul 2026 09:04:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB623DB315
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 09:04:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783674253; cv=none; b=otmticlSzdKAM+OqRpgJOobFG9M9HmD07NzV/wPSYd0P7jvSCJ2Ad5joIhOVE74Xza9ibv34izyLuKAJQ4wsSN2Fl80gbl5s4zW7lAQunmNty1eEJ/5J4L7mbkQgZlPnasCsDrJjQZ5bG2eISSbmQkrkG3inG9niUrHwZ7rNt6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783674253; c=relaxed/simple;
	bh=9+KAQhCpS2itwjSTuUZc1cTrSeya+kHUDkW/jTcMZr8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OLu4tL0anS5wECOWi7YiCMpSMdbA1GK6j1ft51iWI/UhmzBENbxg6/Ze1TuDOmwiUUkLQ6KLFv9ItdCPJ9aULAf5BgyQjDO4YrKjf7oCAsNBGwwlndjaI956zwphxjw26L5Moo3TRkXr06MMUL8Jgg5mYsKEtHk1WUUwCQaTFdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=hzv/dEIw; arc=none smtp.client-ip=62.96.220.36
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id D3DDB206D0;
	Fri, 10 Jul 2026 11:04:09 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id byz9cgTQcXks; Fri, 10 Jul 2026 11:04:09 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 48C59205E5;
	Fri, 10 Jul 2026 11:04:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 48C59205E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1783674247;
	bh=KjXyigDSWU1Zy7/Uq5MoDGa2rX93h4mgMijKjichSOE=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=hzv/dEIwvQ7HLLAkdDoMLLijL56hKhOW/dhPu0mWyNFKd9KiD1RsVY7Ovl0Xw5q3N
	 9aiJ2rjxB02Wmf80TEs6fseJ2u98tr1bDYni8qwEabthkXI04fM7GEcOiHwckTZ2ri
	 p1RsE6HbxsKIdAft0uGaOsxPyisTvHbvAey5oWt0mXbLsR7ZDxUg0SF49ScnUdCZQW
	 9msOOMZgf9dHePRl1Xt3+WL4aHJodNkyhxjzRQwez/ss+LBR1FhXYAS4txaUK17OVd
	 ngmMYXXLGUBjnLeZ/kzbPOREutwATPIvS/gMcXebSE8eC65r0p81sJzuKOGIxEW6m/
	 l6SjHxE7+iEfw==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 10 Jul
 2026 11:04:06 +0200
Received: (nullmailer pid 343848 invoked by uid 1000);
	Fri, 10 Jul 2026 09:03:52 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 05/10] xfrm: cache the offload ifindex for netlink dumps
Date: Fri, 10 Jul 2026 11:03:18 +0200
Message-ID: <20260710090349.343389-6-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260710090349.343389-1-steffen.klassert@secunet.com>
References: <20260710090349.343389-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EXCH-04.secunet.de (10.32.0.184) To EXCH-01.secunet.de
 (10.32.0.171)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306478-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:herbert@gondor.apana.org.au,m:steffen.klassert@secunet.com,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[secunet.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[secunet.com:from_mime,secunet.com:email,secunet.com:mid,secunet.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 622F0738FFF

From: Cen Zhang <zzzccc427@gmail.com>

copy_to_user_state_extra() only holds a reference to the outer xfrm_state.
That does not pin x->xso.dev. NETDEV_DOWN and NETDEV_UNREGISTER can race
through xfrm_dev_state_flush(), xfrm_state_delete(), and
xfrm_dev_state_free(), which clears xso->dev and drops the netdev
reference before the GETSA dump reaches xso_to_xuo() and reads
xso->dev->ifindex.

The buggy scenario involves two paths, with each column showing the order
within that path:

XFRM_MSG_GETSA dump path:           NETDEV teardown path:
1. xfrm_get_sa() gets xfrm_state    1. xfrm_dev_state_flush() finds x
2. copy_to_user_state_extra() sees  2. xfrm_state_delete() removes x
   x->xso.dev                          from the SAD
3. copy_user_offload() calls        3. xfrm_dev_state_free() clears
   xso_to_xuo()                        xso->dev
4. xso->dev->ifindex dereferences   4. netdev_put() drops the device
   a detached net_device               reference

Avoid following the live net_device from the dump paths. Cache the
attached ifindex in xfrm_dev_offload when state or policy offload is bound
to a device, and serialize that snapshot instead. This preserves the
user-visible XFRMA_OFFLOAD_DEV value without depending on the embedded
net_device lifetime.

Validation reproduced this kernel report:
Oops: general protection fault

Call Trace:
 <TASK>
 copy_to_user_state_extra+0xb8d/0x1370 [xfrm_user]
 ? __pfx_copy_to_user_state_extra+0x10/0x10 [xfrm_user]
 ? __asan_memset+0x23/0x50
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? __alloc_skb+0x342/0x960
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? __asan_memset+0x23/0x50
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? __nlmsg_put+0x147/0x1b0
 dump_one_state+0x1c7/0x3e0 [xfrm_user]
 xfrm_state_netlink+0xcb/0x130 [xfrm_user]
 ? __pfx_xfrm_state_netlink+0x10/0x10 [xfrm_user]
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? xfrm_user_state_lookup.constprop.0+0x230/0x310 [xfrm_user]
 xfrm_get_sa+0x102/0x250 [xfrm_user]
 ? __pfx_xfrm_get_sa+0x10/0x10 [xfrm_user]
 xfrm_user_rcv_msg+0x504/0xaa0 [xfrm_user]
 ? __pfx_xfrm_user_rcv_msg+0x10/0x10 [xfrm_user]
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? stack_trace_save+0x8e/0xc0
 ? __pfx_stack_trace_save+0x10/0x10
 netlink_rcv_skb+0x11f/0x350
 ? __pfx_xfrm_user_rcv_msg+0x10/0x10 [xfrm_user]
 ? __pfx_netlink_rcv_skb+0x10/0x10
 ? __pfx_mutex_lock+0x10/0x10
 ? srso_alias_return_thunk+0x5/0xfbef5
 xfrm_netlink_rcv+0x65/0x80 [xfrm_user]
 netlink_unicast+0x600/0x870
 ? __pfx_netlink_unicast+0x10/0x10
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? __pfx_stack_trace_save+0x10/0x10
 netlink_sendmsg+0x75d/0xc10
 ? __pfx_netlink_sendmsg+0x10/0x10
 ? srso_alias_return_thunk+0x5/0xfbef5
 ____sys_sendmsg+0x77a/0x900
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? __pfx_____sys_sendmsg+0x10/0x10
 ? __pfx_copy_msghdr_from_user+0x10/0x10
 ? release_sock+0x1a/0x1d0
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? netlink_insert+0x143/0xec0
 ___sys_sendmsg+0xff/0x180
 ? __pfx____sys_sendmsg+0x10/0x10
 ? _raw_spin_lock_irqsave+0x85/0xe0
 ? do_getsockname+0xf9/0x170
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? fdget+0x53/0x3b0
 __sys_sendmsg+0x111/0x1a0
 ? __pfx___sys_sendmsg+0x10/0x10
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? __sys_getsockname+0x8c/0x100
 do_syscall_64+0x102/0x5a0
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Fixes: 07b87f9eea0c ("xfrm: Fix unregister netdevice hang on hardware offload.")
Assisted-by: Codex:gpt-5.5
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 include/net/xfrm.h     |  2 ++
 net/xfrm/xfrm_device.c |  1 +
 net/xfrm/xfrm_state.c  |  1 +
 net/xfrm/xfrm_user.c   | 38 +++++++++++++++++++++++++++++---------
 4 files changed, 33 insertions(+), 9 deletions(-)

diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index 519a0156a05c..a6d69aaa6cd2 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -162,6 +162,8 @@ struct xfrm_dev_offload {
 	 */
 	struct net_device	*real_dev;
 	unsigned long		offload_handle;
+	/* Snapshot the attached device index for dump paths. */
+	int			ifindex;
 	u8			dir : 2;
 	u8			type : 2;
 	u8			flags : 2;
diff --git a/net/xfrm/xfrm_device.c b/net/xfrm/xfrm_device.c
index aec1e1184a71..f153bf695b9d 100644
--- a/net/xfrm/xfrm_device.c
+++ b/net/xfrm/xfrm_device.c
@@ -321,6 +321,7 @@ int xfrm_dev_state_add(struct net *net, struct xfrm_state *x,
 	}
 
 	xso->dev = dev;
+	xso->ifindex = dev->ifindex;
 	netdev_tracker_alloc(dev, &xso->dev_tracker, GFP_ATOMIC);
 
 	if (xuo->flags & XFRM_OFFLOAD_INBOUND)
diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 08ba6805ddb3..10e5a1a95fe3 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -1547,6 +1547,7 @@ xfrm_state_find(const xfrm_address_t *daddr, const xfrm_address_t *saddr,
 			xso->type = XFRM_DEV_OFFLOAD_PACKET;
 			xso->dir = xdo->dir;
 			xso->dev = dev;
+			xso->ifindex = dev->ifindex;
 			xso->flags = XFRM_DEV_OFFLOAD_FLAG_ACQ;
 			netdev_hold(dev, &xso->dev_tracker, GFP_ATOMIC);
 			error = dev->xfrmdev_ops->xdo_dev_state_add(dev, x,
diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index 6384795ee6b2..0eb87fc998d1 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -1201,17 +1201,26 @@ static int copy_sec_ctx(struct xfrm_sec_ctx *s, struct sk_buff *skb)
 	return 0;
 }
 
-static void xso_to_xuo(const struct xfrm_dev_offload *xso,
-		       struct xfrm_user_offload *xuo)
+static void xso_to_xuo_ifindex(const struct xfrm_dev_offload *xso, int ifindex,
+			       struct xfrm_user_offload *xuo)
 {
-	xuo->ifindex = xso->dev->ifindex;
+	xuo->ifindex = ifindex;
 	if (xso->dir == XFRM_DEV_OFFLOAD_IN)
 		xuo->flags = XFRM_OFFLOAD_INBOUND;
 	if (xso->type == XFRM_DEV_OFFLOAD_PACKET)
 		xuo->flags |= XFRM_OFFLOAD_PACKET;
 }
 
-static int copy_user_offload(struct xfrm_dev_offload *xso, struct sk_buff *skb)
+#ifdef CONFIG_XFRM_MIGRATE
+static void xso_to_xuo(const struct xfrm_dev_offload *xso,
+		       struct xfrm_user_offload *xuo)
+{
+	xso_to_xuo_ifindex(xso, xso->dev->ifindex, xuo);
+}
+#endif
+
+static int copy_user_offload_ifindex(const struct xfrm_dev_offload *xso,
+				     int ifindex, struct sk_buff *skb)
 {
 	struct xfrm_user_offload *xuo;
 	struct nlattr *attr;
@@ -1222,11 +1231,22 @@ static int copy_user_offload(struct xfrm_dev_offload *xso, struct sk_buff *skb)
 
 	xuo = nla_data(attr);
 	memset(xuo, 0, sizeof(*xuo));
-	xso_to_xuo(xso, xuo);
+	xso_to_xuo_ifindex(xso, ifindex, xuo);
 
 	return 0;
 }
 
+static int copy_user_offload(struct xfrm_dev_offload *xso, struct sk_buff *skb)
+{
+	return copy_user_offload_ifindex(xso, xso->dev->ifindex, skb);
+}
+
+static int copy_user_state_offload(const struct xfrm_dev_offload *xso,
+				   struct sk_buff *skb)
+{
+	return copy_user_offload_ifindex(xso, READ_ONCE(xso->ifindex), skb);
+}
+
 static bool xfrm_redact(void)
 {
 	return IS_ENABLED(CONFIG_SECURITY) &&
@@ -1433,8 +1453,8 @@ static int copy_to_user_state_extra(struct xfrm_state *x,
 			      &x->replay);
 	if (ret)
 		goto out;
-	if(x->xso.dev)
-		ret = copy_user_offload(&x->xso, skb);
+	if (READ_ONCE(x->xso.dev))
+		ret = copy_user_state_offload(&x->xso, skb);
 	if (ret)
 		goto out;
 	if (x->if_id) {
@@ -4046,8 +4066,8 @@ static inline unsigned int xfrm_sa_len(struct xfrm_state *x)
 		l += nla_total_size(sizeof(*x->coaddr));
 	if (x->props.extra_flags)
 		l += nla_total_size(sizeof(x->props.extra_flags));
-	if (x->xso.dev)
-		 l += nla_total_size(sizeof(struct xfrm_user_offload));
+	if (READ_ONCE(x->xso.dev))
+		l += nla_total_size(sizeof(struct xfrm_user_offload));
 	if (x->props.smark.v | x->props.smark.m) {
 		l += nla_total_size(sizeof(x->props.smark.v));
 		l += nla_total_size(sizeof(x->props.smark.m));
-- 
2.43.0


