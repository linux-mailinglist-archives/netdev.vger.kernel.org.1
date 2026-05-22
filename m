Return-Path: <netdev+bounces-290900-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QDSZGuWVEGqBZwYAu9opvQ
	(envelope-from <netdev+bounces-290900-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 19:44:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D534F5B8747
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 19:44:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 81B72309C7EA
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 17:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C3C5366560;
	Fri, 22 May 2026 17:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h+rUo6yn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C8E3644C1
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 17:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779471015; cv=none; b=ChC4GqxVa3cTh9sDhwutdSGw4OMNWCJrrvj0GcP65gOHumBn1ITj7pxLxyrOyhJ7D5Z6CXJMtnYpU+0NUAzW/oNyFURLo8Jg+67qudim/DgWhrBr6kCXCG6BwcIH9vmqpIpN2kZEv9GpCuOTtKslCkgCMi3rNFgdcnHCyAYmiJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779471015; c=relaxed/simple;
	bh=gUWxxZtnOL+o2PDS6FjvoFzYc9lSlREbNCTzDrL1p8U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VlWLmCTgwHKW/1o3a23nKFtxd8Lr5rsAAPi4sVPZQbC9TP/8uFKR/xuOXPB8huQEzUy38lJU9Bv8mGDJKvApkVN3Rn0TyNO0FLYF2noTA3vWdlDodBWdCRMNtEGTCIQahTaOaYo+Uah8pR3sxDcZHnSiV6YxEETkF0i9pvp3haI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h+rUo6yn; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-8c3bdb60dadso83469406d6.1
        for <netdev@vger.kernel.org>; Fri, 22 May 2026 10:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779471013; x=1780075813; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ez59jbxLWEDb4JbB3+cibH4bU1bZop/VeuMqn4Rqju4=;
        b=h+rUo6ynYD4Yhs+0h9CgiFBvNy44R4EbPQ6Jh2dMeZNiyl1X1NvIBt9XEZLgUeE4Vc
         Z/qhmIqnkp49QLFXm7R96oBCzg2ntKVNbXd7m5R0uZY8bvixB284hsxprlp2UAM9XJPz
         AWu/6I0yX79aygVuLg3Ymo4Xe0HKdCD+/kAxXJsb3d0Ncj6smYw+RErVNNv6lLhYumst
         iO7DrHXENi2Bc47GZKm8kGtQ+gu1/K4HdDc6R6VvHWkj6P0YymRvoBlRp1wecagYN9yK
         OnzvW983ZHBHyXvEJs5Ke8xL1GCw4U9xWhX4hgvP6Dl7sWeWFLjCiMjKNlIdXpjpa2Xr
         n8RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779471013; x=1780075813;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ez59jbxLWEDb4JbB3+cibH4bU1bZop/VeuMqn4Rqju4=;
        b=J/4Pw1Uh8ZV4php+EsLBzU2MiMd+aPn5joPCx4jDf29J3yqP40BaWhwNh61Vf/xS4y
         bvG5hDJa4129HcIgEIpV2kEobHJGbHaqpOM6tmDkQAx6+jeiNed4q1QZ/j2Wxj+9K8Ic
         SntEQjcqVQveWxgeOleBQx+B1J/bYf+71/75rPfciS4see7ezuwKb6QYZsS1uDjxDajK
         mVAaMAB6YaBCiyr6KO44v0HJUM34yc5zjkwhqtfqNg27U7zRJsvnJtNdNgnzjMtw+kpC
         R028K8o2grbvu/soyqYDfe0qiYENHSHzc6mqfk2OUuTwFDf725eggJRQR0dSbQOHBV3n
         UbIw==
X-Forwarded-Encrypted: i=1; AFNElJ8CUUEk2Lut5M/yI95cgRVXIQriB3F42GYMgrDRQpNoogECoi5vbblvndREJtDuPsc7HK0epC0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLHKCjXCUzMKUEJqS/6eMCVXDqULBPpPp0AcHOQmC630NJT51h
	KhSFT43D2QLOIER6m/HyjMIquYZyn4NAs0ZdqlS7uJlY02TFfmXvFHGkjgWlJ+TTnDP1NtVz+Fx
	nQh4xR6OdrACATA==
X-Received: from qtwu4.prod.google.com ([2002:a05:622a:104:b0:516:cb75:f20f])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:8588:b0:50f:de06:45e2 with SMTP id d75a77b69052e-516d436f402mr52670431cf.31.1779471012421;
 Fri, 22 May 2026 10:30:12 -0700 (PDT)
Date: Fri, 22 May 2026 17:30:02 +0000
In-Reply-To: <20260522173002.2181677-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260522173002.2181677-1-edumazet@google.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260522173002.2181677-6-edumazet@google.com>
Subject: [PATCH v4 net-next 5/5] rtnetlink: add RTEXT_FILTER_NAME_ONLY support
 to rtnl_dump_ifinfo()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290900-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.936];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: D534F5B8747
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When user requests RTEXT_FILTER_NAME_ONLY flag, we limit the dump
parts to:

 - struct nlmsghdr
 - IFLA_IFNAME
 - IFLA_PROP_LIST (alternate names)

- This saves space in the dump, pushing more devices per system call.
- This can be done without acquiring RTNL.

I still have a long term goal to avoid RTNL in rtnl_dump_ifinfo()
regardless of RTEXT_FILTER_NAME_ONLY being used.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/rtnetlink.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index bad036ef7614ffae52a65c447344ac1314f5521b..9045285ba2f8be8d7ff32e4f90ee546651f1a05f 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -2499,6 +2499,7 @@ static int rtnl_dump_ifinfo(struct sk_buff *skb, struct netlink_callback *cb)
 	int ops_srcu_index;
 	int master_idx = 0;
 	int netnsid = -1;
+	bool need_rtnl;
 	int err, i;
 
 	err = rtnl_valid_dump_ifinfo_req(nlh, cb->strict_check, tb, extack);
@@ -2548,6 +2549,12 @@ static int rtnl_dump_ifinfo(struct sk_buff *skb, struct netlink_callback *cb)
 
 walk_entries:
 	err = 0;
+	need_rtnl = !(ext_filter_mask & RTEXT_FILTER_NAME_ONLY);
+	if (need_rtnl)
+		rtnl_lock();
+	else
+		rcu_read_lock();
+
 	for_each_netdev_dump(tgt_net, dev, ctx->ifindex) {
 		if (link_dump_filtered(dev, master_idx, kind_ops))
 			continue;
@@ -2559,11 +2566,13 @@ static int rtnl_dump_ifinfo(struct sk_buff *skb, struct netlink_callback *cb)
 		if (err < 0)
 			break;
 	}
-
-
-	cb->seq = tgt_net->dev_base_seq;
+	cb->seq = READ_ONCE(tgt_net->dev_base_seq);
 	nl_dump_check_consistent(cb, nlmsg_hdr(skb));
 
+	if (need_rtnl)
+		rtnl_unlock();
+	else
+		rcu_read_unlock();
 out:
 
 	if (kind_ops)
@@ -7159,7 +7168,9 @@ static const struct rtnl_msg_handler rtnetlink_rtnl_msg_handlers[] __initconst =
 	 .flags = RTNL_FLAG_DOIT_PERNET_WIP},
 	{.msgtype = RTM_GETLINK, .doit = rtnl_getlink,
 	 .dumpit = rtnl_dump_ifinfo,
-	 .flags = RTNL_FLAG_DUMP_SPLIT_NLM_DONE | RTNL_FLAG_DOIT_UNLOCKED},
+	 .flags = RTNL_FLAG_DUMP_SPLIT_NLM_DONE |
+		  RTNL_FLAG_DOIT_UNLOCKED |
+		  RTNL_FLAG_DUMP_UNLOCKED},
 	{.msgtype = RTM_SETLINK, .doit = rtnl_setlink,
 	 .flags = RTNL_FLAG_DOIT_PERNET_WIP},
 	{.msgtype = RTM_GETADDR, .dumpit = rtnl_dump_all},
-- 
2.54.0.746.g67dd491aae-goog


