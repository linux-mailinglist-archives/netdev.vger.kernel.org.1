Return-Path: <netdev+bounces-261126-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MJRbKw+yn2kpdQQAu9opvQ
	(envelope-from <netdev+bounces-261126-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 03:38:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A8FA1A0273
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 03:38:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 32564305597B
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 02:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1217A37882A;
	Thu, 26 Feb 2026 02:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zIkMGHwn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA3B378825
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 02:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772073407; cv=none; b=chxvHjP9xm0vHOshcWeGQ/ESYtMVErOiTpS//gZ7bhVSpEs9qP4AlxiJInJUH4ZJ8GGCVaoKJTPKaQJKd705NuNwWoMOA+KWlsEBGEgcepWWhSYajYtXvHKUwpBH81rYGbevfZhFqDV52+YNrvp12ITSWNXjN5WJ+K0gB3H7EW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772073407; c=relaxed/simple;
	bh=GVWx/4pLEBTqF867Ba6M0um9jMVlcBc8IoYeuIRXmX0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TiNeYAyIaa8f+Co/8XAHQyG90C2FJm3xrGyTQ1IweKeDvLWnDeHZvMB4QeRDtyr1qhsEmzHgUJuPhunTzG+pz33XSIXykFTTeOobYwPf9Yl8e/0Q/850mK2VGttNNyJetlla+eRTLgXRhlYc7L+zzo8vwwoa/+MMAiZmxo1EY3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zIkMGHwn; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2aaf0dbd073so3263745ad.3
        for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 18:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772073405; x=1772678205; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gioSEsN56KXZqnGSb5uZUBo6roHxqlKPoQLw23YGeKo=;
        b=zIkMGHwnwZFVEte9WHXhuO4r3DY3NwkNGeE3QHJY0ISYX/I0QDy8qnRRE2UCtCG2Wh
         59tin8foh5w1pjTa7+T4MM2HvRzoVoUjsyKBwr4yUmrPaBcI5xhKZ4sT5Q6AjHBwe29Y
         U67esBiMhWv52pJwVvZNEibk98enE5qlX5a/GCbDBiYhZSDOQPwwYd0W9sObPn2NUPsD
         5OgWtVoRMBiu6SiS98rUlIOZnwBg4qTdDx5n5pLL7FKbJtFZNEp2HOAblY2Cv5KZu262
         0kVG3BKGKBaA5X9CN2b4Y1fPELQwjXnHrPhy4ss5hMla5sPRfdHQqBTdNr2TjyUp2uI6
         4Oyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772073405; x=1772678205;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gioSEsN56KXZqnGSb5uZUBo6roHxqlKPoQLw23YGeKo=;
        b=cKz82BnvgWv5btatGSAdsWrKwLDbqvdHrQIHWA0gExjRCenL92O1eTwZxcMdp0y3R4
         SGCUh6khkg/HVGwWcVqvIZqY2tpeunpr/Ul95JsWZ8gIn2e9s1G+nyuF4iz0cjht4iZV
         h8J1deBcJNf04KD6ElFddl5/lI6hQj1l0oYuVUtIzk2s4L7PsTmKNGWFIlTnoNFeX+fh
         3njtWdNkc2aUASB93Ajen1+vTz+XcWY8l3ZWeaw40P5E4v/NSHKNkyAooL2aIEh0PFzQ
         pj1sVYMiKYmf09ZlhXpEQZMEeVUsTmiuNpUkOtD/WWHKhCJo8BkeycreaDpegI8MR7xQ
         7fUA==
X-Forwarded-Encrypted: i=1; AJvYcCUVP8LIJ7//ZtNc540h81/A6m5wO+XdoXJnLyvJFizjFwjyIiyuh18k5hWF3ZrBYZruwyhQlUA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMUqs3wBMopdwVHjQZ6FK0NvSrjAQ6ywOqlcEfLPWsNPFF54ey
	n+wNImIMl0eoQoH2bR2fCB7Mmob1PTsPUY0XcqNAtV5po2XqlymegBRKh8+HV3akS0gzD3EEua2
	ESjw1ig==
X-Received: from plq18.prod.google.com ([2002:a17:903:2f92:b0:268:4e0:9c09])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2a90:b0:2a9:30d4:2b0c
 with SMTP id d9443c01a7336-2ad74562045mr185026775ad.46.1772073405030; Wed, 25
 Feb 2026 18:36:45 -0800 (PST)
Date: Thu, 26 Feb 2026 02:35:15 +0000
In-Reply-To: <20260226023637.1335854-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260226023637.1335854-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.414.gf7e9f6c205-goog
Message-ID: <20260226023637.1335854-4-kuniyu@google.com>
Subject: [PATCH v1 net-next 03/15] ipmr: Convert ipmr_rtm_dumplink() to RCU.
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261126-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3A8FA1A0273
X-Rspamd-Action: no action

net->ipv4.mr_tables is updated under RTNL and can be read
safely under RCU.

Once created, the multicast route tables are not removed
until netns dismantle.

ipmr_rtm_dumplink() does not need RTNL protection for
ipmr_for_each_table() and ipmr_fill_table() if RCU is held.

Let's convert it to RCU.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv4/ipmr.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index 377b5848f99c..a4bc653e04ed 100644
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
2.53.0.414.gf7e9f6c205-goog


