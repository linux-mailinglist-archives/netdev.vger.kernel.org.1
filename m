Return-Path: <netdev+bounces-302300-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5AaMC/M8P2qkQAkAu9opvQ
	(envelope-from <netdev+bounces-302300-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 05:01:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 70BD96D0D11
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 05:01:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=GBiY+z4N;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302300-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302300-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 41C20301F9A2
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 03:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B3F3491E1;
	Sat, 27 Jun 2026 03:01:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C42346FD2
	for <netdev@vger.kernel.org>; Sat, 27 Jun 2026 03:01:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782529264; cv=none; b=hydbDSBgsWMX+vgH/TMoMnouaucokMWeoLr3d+SFcz2pl0ths0OZOvY1tdDMi2JLL3jfVtnkkGItWSh8wW8tt1p52BYUKhJNOa6Hj6WVZHNYemakhUnqno4ngDCUvoQ8LxRvUlZXPvLgcSSpnsoVSDyaMW90Y5aMV8l7Q1rNJRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782529264; c=relaxed/simple;
	bh=Kh75R7DmlSYhESNcSDDDtl4urK7lPjej2NTi+9++N4s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WuRBSQ7QbgYG25IrxOdHKllMzIN+5ogWVGsy5k5M4ZcItgub4VJopqtM/7u2EDDItRUQgb9/zOFsdHwRu0EMmiqmpdS7XzKoDBoSl8z0DF/DDeIUA/y8Dj0mjZlWK5gDYTKnluyf/CPl3CfL9Eow61GOiqIskYcdqxEIREyVF+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GBiY+z4N; arc=none smtp.client-ip=209.85.216.53
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-37d70036426so797341a91.3
        for <netdev@vger.kernel.org>; Fri, 26 Jun 2026 20:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782529263; x=1783134063; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X24AWUaTOZWiutm7CT7bA4p1nabeII8d8YsJrrXK/GM=;
        b=GBiY+z4Nqd46Q14WpztdTrpiS6hh1eUrTDaNxUyrl/fjbOs9Ktcu5PwcluYlUqBris
         T6mTQ2g8zeM18O/O+9kMvvtKsbcVCbuDhqmCRPy4tNQWd7AyKysGc1tCbymRaNDNQUaw
         b+tnvKIS/j8GhGfR4jbqLJMMmR1m8S6NHRSmjPvwSbthYs/eFcQLmWcHIVk9Rtj/6Qae
         kniBSi5azVB2WlT7yOF67ykIFReHkg7tuShOn1cw7xkPsMmEm7tYhkWnMFfOfxfmFOji
         NXxVIa5EK72+fmrMz2/Xo1wU4Kfy0s6mQJuJ4sI0cb94U2iCj9Cbo6cjHV1gdbKfA2xD
         LZbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782529263; x=1783134063;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X24AWUaTOZWiutm7CT7bA4p1nabeII8d8YsJrrXK/GM=;
        b=rb2jyixAjZY+ax15Op/psBHRq0RHonHRhXv3p4Kb8ydV7DfhLYM6NdGNRo1Wg3ufnk
         Ev4MBFNJAkdTVRDp43lyn8mShkn3qOGwv9wrNOaw1sOqlexFBXRP52DckH7b8pRpCWvW
         WBysxBXFQ7RiaLE9mSCftmzlKWwaoG/d+aA7pZkQTykhwdLTI3IoGKz81yG7fpRLLIRA
         JZP2wW6yfhjT/HkRp3wX9uB7EwXaT2fxRUsvwWc9aRhXSRJO13wZusPx2Ruwi1sjvwHz
         yl/48ZWorl1aHZOiphdi0JhzAvdEM+5+6PZgepl3Qz7+6gIJFxTcAp3If9z2V5KpAYbS
         /O0Q==
X-Gm-Message-State: AOJu0YzFq35TfZMjgntMLIjEGxZPzQchDwhIoCw9Lk4VI0rKCJZ5yTn5
	rc1vwmXjJQKjHiEXIsI8YV6rW5J8v/WrqVUbxL/MXOodhFTl0hpcKy1H
X-Gm-Gg: AfdE7cn61px2VVdw9DEitT4KN30SA4mzFhKZohOOLzyq1jOz04eeUg59orRdal99JN9
	u6sJKO4Es96MeNuiK9EA1bz35lGLiK8weCzmumUudIU1aaf7sdU95Si1p3aO0Bj467Is+s9awG4
	t4WKA38qBSvcRAOzwov9LQuMOtSp5vvmzjZIAp/WDcfQjEsw6THbg8oS8JF8t70Y0wq/64duBdT
	aQNoxT1wpJLAs5wugL/Ro3BcJAUTvw+BoNaexroUUx6Fd60YRN6Z9a/zN6JhNQXinIiYpsFBmJA
	hiZgU9F/SrcsTV3j1tuGlV/aJKsRR7IXn8p6+tQxDvyk2DpU9nXZBSJpAKZmwzPz32MDBZ5pfOG
	UcUrIOMtZg4A+3V8nbiYRmLp7G9YUQmn8zgipuxTggkCkN7uBx0IYUA/u3Ncw///DKjWeOSkJMH
	A7UgvTnz8=
X-Received: by 2002:a17:90b:5444:b0:36b:79aa:cda4 with SMTP id 98e67ed59e1d1-37dfa1bc80dmr8603689a91.8.1782529262631;
        Fri, 26 Jun 2026 20:01:02 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37e12c79443sm1422520a91.1.2026.06.26.20.00.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 20:01:02 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH] xfrm: cache the offload ifindex for netlink dumps
Date: Sat, 27 Jun 2026 11:00:55 +0800
Message-Id: <20260627030055.2613718-1-zzzccc427@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER(0.00)[zzzccc427@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-302300-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:steffen.klassert@secunet.com,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:baijiaju1990@gmail.com,m:zzzccc427@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zzzccc427@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 70BD96D0D11

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

Fixes: 07b87f9eea0c ("xfrm: Fix unregister netdevice hang on hardware offload.")
Assisted-by: Codex:gpt-5.5
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
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
index 630f3dd31cc5..44bfaa04e621 100644
--- a/net/xfrm/xfrm_device.c
+++ b/net/xfrm/xfrm_device.c
@@ -313,6 +313,7 @@ int xfrm_dev_state_add(struct net *net, struct xfrm_state *x,
 	}
 
 	xso->dev = dev;
+	xso->ifindex = dev->ifindex;
 	netdev_tracker_alloc(dev, &xso->dev_tracker, GFP_ATOMIC);
 
 	if (xuo->flags & XFRM_OFFLOAD_INBOUND)
diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index c58cd024e3c6..707e29c82020 100644
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


