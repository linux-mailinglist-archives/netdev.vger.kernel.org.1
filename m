Return-Path: <netdev+bounces-261699-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iFeUHeURoWlwqAQAu9opvQ
	(envelope-from <netdev+bounces-261699-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 04:39:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F141B2503
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 04:39:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CE89D3035E3D
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 03:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7927E3328EA;
	Fri, 27 Feb 2026 03:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cz3wK+OP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B2033291C
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 03:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772163552; cv=none; b=ac+mJn8tExmzpRKLK4iLTduUJiXiCMqHOcO8X3GYUY513ngBPp7jT7Sf3Z/4MzbsWGu+YZAlwHd+7bxhCCvLgLWFPlXL7MRwpJ3Bz3imL/9qGL3k0zxlNNIOBFnTWPjrxr8MmowOIGSWlhgcCJlH9RNnpE+umMfPRVHtKdwebuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772163552; c=relaxed/simple;
	bh=/bxqIj7nDzDuSI0PXpkyIp/hB7njK9RpmBb5BZpF5i8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gJu+cegqAncelPON0DH6E9lGDyuo6Kuc7br478F9Wzob8lLhSnr3Cqk+kqd+HaWfYWysk5u4h2sednPCvTZhwEC0d9WxqsZU78sGKD0IJB4ctbIXo6hNN961ksjsdu52Jht1bA9HNsfMv/ui2v13Te07idQLtC2vAAUmeUwDieY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cz3wK+OP; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-358e95e81aeso7322115a91.0
        for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 19:39:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772163550; x=1772768350; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7yMPRmQDpB/u1PkAPgPr507YppCNrsiwO886rjPYBaY=;
        b=cz3wK+OPFhE74ZEwAfgnVy/tmvItxOMLc9akVF3dbnGvkdfBrLCwRc+RzXD6qYoFCg
         oxmE5RSpbPUlXr2iWx55OhsEka66I5RXGiqTcKvlIMbFQZfC5foZngYN5BqCaUQCFumZ
         RJ6kZ2kHIhRvg9L4lQCvNdEsn+8L8a718l2+gIgXD1DbP/TZJmu0SMepUz9JImO2Ai6U
         3NViAd0fWtvmGzG3DB1iXTngHuD2aj+zw5mF0Lqhx9BapWK8n5RvsJuf/icbDHunRay0
         PyTunHL/MoaJ4aGyZ5zXX9klA/YGMth1S69WSLbCqbC/zfyWvWtNw9Sf+tPikkA3Uun5
         qhqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772163550; x=1772768350;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7yMPRmQDpB/u1PkAPgPr507YppCNrsiwO886rjPYBaY=;
        b=mVTl37gNFo87DmnxQOqeX+6oLrD2w2Bb7rU+IhJKoBB6h/Ea4+5TqbU1euBkDC+Cnq
         PTdjrnNbrFEMdsqDsvCEtCH49QtOF/dkkWvS0A/vbqNuhFcY8PJ/eIV7s6xmz//04OBB
         QwHKvpOoxMJyvu9m7hHdBrUMOuNAU6Rf3jUrajlsMy+pBynmaOhjFekYt6gOLiqVrZ8T
         +wE36cWmEiStG3PDJGH/hZfqw88N8YM7V29q69gzsRM5DGchKIRu44GCT29XF/avFv1s
         JgLZaobVecmkY3pK1EBo4P+OO5k6nbljCpo86+rG4uc/HXBF+1MnSdLTr6/QeWvV4A0o
         rH4w==
X-Forwarded-Encrypted: i=1; AJvYcCWIvCOF83K02YOMQtd08JJVY1D09Tw9YfZY+r460DEaTkg+rMOzQdfVXi5ojC17yQ1NOU7g1dU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUf2A+F/o+x3JJQvi2f6AAvDri3oalp97XvyMHPIvzPKwgI83Y
	bocByISF4xlIKmU9cAcmqQwN56Hqf8W6hjYixtWebnG0eQu17dxmOUjsqK2EgwUG3QnE8DQZoZg
	ZN5PYVA==
X-Received: from pjbgl17.prod.google.com ([2002:a17:90b:1211:b0:354:e874:cf5c])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4a:b0:354:c600:1a1
 with SMTP id 98e67ed59e1d1-35965ccf1b9mr1210275a91.19.1772163550457; Thu, 26
 Feb 2026 19:39:10 -0800 (PST)
Date: Fri, 27 Feb 2026 03:38:26 +0000
In-Reply-To: <20260227033903.3307272-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260227033903.3307272-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260227033903.3307272-4-kuniyu@google.com>
Subject: [PATCH v2 net-next 03/15] ipmr: Convert ipmr_rtm_dumplink() to RCU.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261699-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 10F141B2503
X-Rspamd-Action: no action

net->ipv4.mr_tables is updated under RTNL and can be read
safely under RCU.

Once created, the multicast route tables are not removed
until netns dismantle.

ipmr_rtm_dumplink() does not need RTNL protection for
ipmr_for_each_table() and ipmr_fill_table() if RCU is held.

Even if mrt->maxvif changes concurrently, ipmr_fill_vif()
returns true to continue dumping the next table.

Let's convert it to RCU.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
v2: Add READ_ONCE() for mrt->maxvif in ipmr_rtm_dumplink().
---
 net/ipv4/ipmr.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index 377b5848f99c..290180f3fbf7 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -2901,12 +2901,13 @@ static bool ipmr_fill_table(struct mr_table *mrt, struct sk_buff *skb)
 	if (nla_put_u32(skb, IPMRA_TABLE_ID, mrt->id) ||
 	    nla_put_u32(skb, IPMRA_TABLE_CACHE_RES_QUEUE_LEN, queue_len) ||
 	    nla_put_s32(skb, IPMRA_TABLE_MROUTE_REG_VIF_NUM,
-			mrt->mroute_reg_vif_num) ||
+			READ_ONCE(mrt->mroute_reg_vif_num)) ||
 	    nla_put_u8(skb, IPMRA_TABLE_MROUTE_DO_ASSERT,
-		       mrt->mroute_do_assert) ||
-	    nla_put_u8(skb, IPMRA_TABLE_MROUTE_DO_PIM, mrt->mroute_do_pim) ||
+		       READ_ONCE(mrt->mroute_do_assert)) ||
+	    nla_put_u8(skb, IPMRA_TABLE_MROUTE_DO_PIM,
+		       READ_ONCE(mrt->mroute_do_pim)) ||
 	    nla_put_u8(skb, IPMRA_TABLE_MROUTE_DO_WRVIFWHOLE,
-		       mrt->mroute_do_wrvifwhole))
+		       READ_ONCE(mrt->mroute_do_wrvifwhole)))
 		return false;
 
 	return true;
@@ -2919,7 +2920,7 @@ static bool ipmr_fill_vif(struct mr_table *mrt, u32 vifid, struct sk_buff *skb)
 	struct vif_device *vif;
 
 	vif = &mrt->vif_table[vifid];
-	vif_dev = rtnl_dereference(vif->dev);
+	vif_dev = vif_dev_read(vif);
 	/* if the VIF doesn't exist just continue */
 	if (!vif_dev)
 		return true;
@@ -2928,16 +2929,16 @@ static bool ipmr_fill_vif(struct mr_table *mrt, u32 vifid, struct sk_buff *skb)
 	if (!vif_nest)
 		return false;
 
-	if (nla_put_u32(skb, IPMRA_VIFA_IFINDEX, vif_dev->ifindex) ||
+	if (nla_put_u32(skb, IPMRA_VIFA_IFINDEX, READ_ONCE(vif_dev->ifindex)) ||
 	    nla_put_u32(skb, IPMRA_VIFA_VIF_ID, vifid) ||
 	    nla_put_u16(skb, IPMRA_VIFA_FLAGS, vif->flags) ||
-	    nla_put_u64_64bit(skb, IPMRA_VIFA_BYTES_IN, vif->bytes_in,
+	    nla_put_u64_64bit(skb, IPMRA_VIFA_BYTES_IN, READ_ONCE(vif->bytes_in),
 			      IPMRA_VIFA_PAD) ||
-	    nla_put_u64_64bit(skb, IPMRA_VIFA_BYTES_OUT, vif->bytes_out,
+	    nla_put_u64_64bit(skb, IPMRA_VIFA_BYTES_OUT, READ_ONCE(vif->bytes_out),
 			      IPMRA_VIFA_PAD) ||
-	    nla_put_u64_64bit(skb, IPMRA_VIFA_PACKETS_IN, vif->pkt_in,
+	    nla_put_u64_64bit(skb, IPMRA_VIFA_PACKETS_IN, READ_ONCE(vif->pkt_in),
 			      IPMRA_VIFA_PAD) ||
-	    nla_put_u64_64bit(skb, IPMRA_VIFA_PACKETS_OUT, vif->pkt_out,
+	    nla_put_u64_64bit(skb, IPMRA_VIFA_PACKETS_OUT, READ_ONCE(vif->pkt_out),
 			      IPMRA_VIFA_PAD) ||
 	    nla_put_be32(skb, IPMRA_VIFA_LOCAL_ADDR, vif->local) ||
 	    nla_put_be32(skb, IPMRA_VIFA_REMOTE_ADDR, vif->remote)) {
@@ -2992,6 +2993,8 @@ static int ipmr_rtm_dumplink(struct sk_buff *skb, struct netlink_callback *cb)
 	s_t = cb->args[0];
 	s_e = cb->args[1];
 
+	rcu_read_lock();
+
 	ipmr_for_each_table(mrt, net) {
 		struct nlattr *vifs, *af;
 		struct ifinfomsg *hdr;
@@ -3026,7 +3029,7 @@ static int ipmr_rtm_dumplink(struct sk_buff *skb, struct netlink_callback *cb)
 			nlmsg_end(skb, nlh);
 			goto out;
 		}
-		for (i = 0; i < mrt->maxvif; i++) {
+		for (i = 0; i < READ_ONCE(mrt->maxvif); i++) {
 			if (e < s_e)
 				goto skip_entry;
 			if (!ipmr_fill_vif(mrt, i, skb)) {
@@ -3048,6 +3051,8 @@ static int ipmr_rtm_dumplink(struct sk_buff *skb, struct netlink_callback *cb)
 	}
 
 out:
+	rcu_read_unlock();
+
 	cb->args[1] = e;
 	cb->args[0] = t;
 
@@ -3287,7 +3292,7 @@ static struct pernet_operations ipmr_net_ops = {
 
 static const struct rtnl_msg_handler ipmr_rtnl_msg_handlers[] __initconst = {
 	{.protocol = RTNL_FAMILY_IPMR, .msgtype = RTM_GETLINK,
-	 .dumpit = ipmr_rtm_dumplink},
+	 .dumpit = ipmr_rtm_dumplink, .flags = RTNL_FLAG_DUMP_UNLOCKED},
 	{.protocol = RTNL_FAMILY_IPMR, .msgtype = RTM_NEWROUTE,
 	 .doit = ipmr_rtm_route},
 	{.protocol = RTNL_FAMILY_IPMR, .msgtype = RTM_DELROUTE,
-- 
2.53.0.473.g4a7958ca14-goog


