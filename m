Return-Path: <netdev+bounces-262236-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SM13NtJpo2mACgUAu9opvQ
	(envelope-from <netdev+bounces-262236-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 23:18:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C6F1C9712
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 23:18:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 45923306817D
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 22:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA8938F627;
	Sat, 28 Feb 2026 22:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u37emKys"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF4D3D4138
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 22:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772317089; cv=none; b=JN9dYyvvdgW3WqhazMVcn+9Qk666S5gFzFkxsPU7zcfkoBmNZQb4+8oYQ5qzzGwbqk3WPM9j8TnfrmDH3TNkn34joAKUbhHCWJSIZ5tQ/C7ZRxdbLsx+0oZUSoc1xmElKrORMVbcdTi/0/0+KGo5hNEfNDVDozijgA7ikGlbf8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772317089; c=relaxed/simple;
	bh=500iFZbX5a+N1JO91Notx0qYv9ZeO68ZrDXTOhcO1FM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=If1O5g1+G1+Gf+jETsgr5JYK5Ko2SBbS1u328f49PW5vRZ6UrCKUWvGpHIYqM0+I4BDon3No6K6OiIS62IdStsfcHl3V4xZ+ao/qUZhldZxCVGfFP90hq57OLf4sad+to5ZfxrOih+FO+uafQvcFXtSn1lIb09H2uytVcaWkowY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u37emKys; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-35983ee9f3bso246930a91.1
        for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 14:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772317088; x=1772921888; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sezDCQ3F4A/GEqeomKVHDpRRHyFgxlheA9HbwLlNCi0=;
        b=u37emKysdvRBuJtep4EJw6KZk1c0rYzffcH+19jMwQyUbzXplDSB+COX+y/GkeBpSn
         mhf72g9XokNKdaLr/4gmq5jiYicBOdAD07kcWZ5R+GlpMH5TdnJMonh0W0WvA+8u9Egn
         hF6jUuJnfYzyzW47ZGwdyyCnVBoVPtZVFy+3SgXiz/5iW3JA4fUQKvcul8cxogLtLB0l
         b9mhrXlfZ0HYfJQFOv7j7O1tLbl52es1W6tLiVbhTwpqEs0owKOreJY+9twqNNCK5lOD
         pLoKIZ3zDHzg3BXVrRy5UuNJDcQVqax9kIaTE2uU9Pk4dqhAiJiXOXbhdqWgrJF7b9J7
         K/vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772317088; x=1772921888;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sezDCQ3F4A/GEqeomKVHDpRRHyFgxlheA9HbwLlNCi0=;
        b=xCS+s7kqbeB7nIclZgL8J8dp/zCLqfOz8YA1/EB0Dblo0FdDoSH58M+TmjZ9P9WaYi
         Azm1sT98qznYuE2hdbMVR/+7cUxaQdC8x5YpiR7PB0qf/e5/TJiwfYvpWRmyAutkFH0F
         QYAWV9ekF0zR0yB4CpyeOkpQ826vjBityUq1xhaiedKD1xxpGBl4owg3j+9H1HANELtm
         0GsP3Tq7724owsZTX9mZ/uYDopKxT9brodg4N4aJhrlHfmGi4KfL1LnFKqr2S4k7TGRk
         ERJJYyxlt1QF/t/kvGZyvDKsAqjTrFKK/3XUn4pffWmtTPw81ChGBdB5qOMqySJYOXJ1
         cLUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWF95YdpcKEml9Qg338pJHnuoKrIpPBAjelEeDLnociCHQBa0Zc3L8VfvvWTb0nqEpKu3IaYkY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqwXxkO5AjEDIYIlIvrfLyabTUS5YQp8Xk0RM5UPZI3qXKnxWD
	Dys3M5DyS4p4r84VOGc9qpzWmBtV4Cbg9kkTIkOtMt67/zI0yNZgAAMh1Dhpo11i3EEn9LFO1uK
	yDOcXIQ==
X-Received: from pgam16.prod.google.com ([2002:a05:6a02:2b50:b0:c6d:e340:fa67])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:44c1:b0:34f:14d6:15f5
 with SMTP id adf61e73a8af0-395c3a47f8emr6875318637.29.1772317087823; Sat, 28
 Feb 2026 14:18:07 -0800 (PST)
Date: Sat, 28 Feb 2026 22:17:21 +0000
In-Reply-To: <20260228221800.1082070-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260228221800.1082070-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260228221800.1082070-4-kuniyu@google.com>
Subject: [PATCH v3 net-next 03/15] ipmr: Convert ipmr_rtm_dumplink() to RCU.
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262236-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 42C6F1C9712
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
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
v2: Add READ_ONCE() for mrt->maxvif in ipmr_rtm_dumplink().
---
 net/ipv4/ipmr.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index 970f173654c7..eecc79a835d1 100644
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


