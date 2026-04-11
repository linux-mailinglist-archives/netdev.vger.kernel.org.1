Return-Path: <netdev+bounces-277670-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id htiXC13j2Wn9uQgAu9opvQ
	(envelope-from <netdev+bounces-277670-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 07:59:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F45A3DE7DB
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 07:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5AE9A3012BCC
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 05:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DAA73112AD;
	Sat, 11 Apr 2026 05:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KWRYhTwG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F237E30FF2A
	for <netdev@vger.kernel.org>; Sat, 11 Apr 2026 05:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775887193; cv=none; b=vAIAaCI79Z61KHDYpmrRyghxICfKJQbr6M+QuOUIeo61E8l5DsmYrikGC/WwptCEzTHK5i3yj/GzSy+l3DHNHcHoTGvu0GpMCygh8GPxGLXPHFTuNZJLzdRAUyeK5UjBP8o2W6vvM9/oKFXdjwmDcHOokOIJHfz1ecxnwOdroDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775887193; c=relaxed/simple;
	bh=Hsi0fuo6nm7JcUMNml41QeYSQlmoNAkNdgBSMZOxkz0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WIdqeyTkyfEStfBTomdyZED0PogJC9HKTMUqqfKirX5jXSMBzCJoEVVsZSufTmdgUXFw+UB3XlioFBzMpXu0eM6A6XAOJdxnZn9aCAja4Zvv7jiIGOKglPnyPS4n91P4kHDvivLIe62CK7WOQNk7IOXgbBH0eTzN7WfMZ4CGCTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KWRYhTwG; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-12c20010f10so7027923c88.0
        for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 22:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775887191; x=1776491991; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0ECEJ7N7pSGGDGib0bgAOerxrVcm8lCH9jDWjAKSBVo=;
        b=KWRYhTwGdMQLpfY7QtzLKNWH5qjlP/FLFs7Yqvvy0LYWBo/lXriZvhqVWy+I/b97KJ
         Nr3AdBGK1xHkuOugkV+Mb1z/IQ6XggUvv8ZytRWOeMe0SAaYY2OQT4d2bqA2EvAAyogf
         zrMz2XU8SrXSJUW46OKnfxg88aHDOIBPSHH7jcVB8G68ATCbu/A9uK5vvRydFqDOMOAN
         3JKRlh7cewfQnsPXclYq44UCD5VTLPLa07BSNKqlyjwc3pIlzOJjguocJPmrDQloUFck
         W40glZoF8MYm0VQ6DsHT3gU/Cc5OZSpB6PaRPDmKt++Mw89wlRjWf3kNdGkJXHPMCLVa
         8NnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775887191; x=1776491991;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0ECEJ7N7pSGGDGib0bgAOerxrVcm8lCH9jDWjAKSBVo=;
        b=XBo76un91yPNPsltt0C9mk5NFXtSb8Rs1ndQBUCVY5jCuTKCkc5DTdAWt+W1d5zIzw
         erJJb6ad8vZLQIJcZr92umbxBLt6TaT2yTflnNmLxNAprRa1Hf6Snb4ZXaEdP6doK6oz
         stXWXdAcIlHz4CylbddNSYLOPkRibmhO8G4484UC2kpzas0BTGFKbgouhA6YKyj0Ky6f
         12ZYHSfj2tRw7tWgRU8JiYXK9oarWMbzaznNz3uE5PxsRFsqbN6x4lk0uLBI/HdYMM39
         lZZ1/A7Sa7HEYHbkN8bOMdV+Qh263mHjdau4wqrNGpVWFh6OOiyjJaEedWRrOomlQPOy
         dH2A==
X-Forwarded-Encrypted: i=1; AJvYcCXco0++FPwNkTgn0d+TZDo6KHhUYTfCWWTX2nKq597dJgXxjjvi+INaNkjryy8usFx1NrEfv04=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWd4Y+4nFhdj0OjL104Ljb5ju3UQ2rLDmD9+Cr0jE8i35kBizl
	hYsA6KFPyAYubGZvXWADDeTLpxTgGvJOf5TsyfdD1O6D8oZEZPnS0xdpsx6/iKLGXHm9Cg==
X-Gm-Gg: AeBDiesMHTo015euauj6s9VoRDxPG6GJaWw+HBe98oh+53Sdb1lmpUeesPxiwnGf2ef
	k6BDiSW84mn8UPnE8xvFOYgVX88vOO6Fy9mUuPBUkQkd3nsgdA3V5owpwQ/zG7NI9AObqXROu5c
	egYx9CyOnnjnTl7kncLSyoQiH6q39/5J2BjMe/WAdf+jAqqDluLBzFOKhDUoBsxcWaIlBJ98hAp
	oKuLo3fJAOtL7QnpcQ2QIO0QA9msbb0OeN3BWZx6iSAITrYK7n1l6q8uNMxdO6cBPXPr949+3CX
	Q1M7Ek8OEvXAcCLF3R4PYj9dbAHUbujwJRQ0cweYuG9WMjqasXUfVoWlR4YQCZRmlbS0ChUGBHG
	sBMrdn7Bk8YurAAP5oz9oSKoAr7KHsVmVstLIzKjWTnizdIxpYrGAPT0Ohu5qElMGWlxouRDiI+
	CsgkAy/i4TI9oH/8xaeJPaLtrsUT+uZif3HcjLsBRKez0MLT2ZsowrNyGty9x33Baj9fG9DUXYO
	PkQV0fu+w==
X-Received: by 2002:a05:7022:628c:b0:128:d438:cad with SMTP id a92af1059eb24-12c34ede1e6mr3760909c88.18.1775887190883;
        Fri, 10 Apr 2026 22:59:50 -0700 (PDT)
Received: from efaec68ba852.tailc0aff1.ts.net ([206.206.192.132])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c34acb077sm5793482c88.6.2026.04.10.22.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 22:59:50 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Pravin B Shelar <pshelar@ovn.org>,
	Flavio Leitner <fbl@sysclose.org>,
	Mark Gray <mark.d.gray@redhat.com>,
	netdev@vger.kernel.org,
	dev@openvswitch.org,
	linux-kernel@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>
Subject: [PATCH net] openvswitch: fix kernel panic from oversized vport upcall PID arrays
Date: Fri, 10 Apr 2026 22:59:16 -0700
Message-ID: <20260411055915.1224902-2-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,ovn.org,sysclose.org,redhat.com,vger.kernel.org,openvswitch.org,asu.edu,gmail.com];
	TAGGED_FROM(0.00)[bounces-277670-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bestswngs@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9F45A3DE7DB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The vport netlink reply helpers allocate a fixed-size skb with
nlmsg_new(NLMSG_DEFAULT_SIZE, ...) but serialize the full upcall PID
array via ovs_vport_get_upcall_portids(). Since
ovs_vport_set_upcall_portids() accepts any non-zero multiple of
sizeof(u32) with no upper bound, a CAP_NET_ADMIN user can install a
PID array large enough to overflow the reply buffer. When the
subsequent nla_put() fails with -EMSGSIZE, five BUG_ON(err < 0) sites
fire and panic the kernel. On systems with unprivileged user namespaces
enabled (e.g., Ubuntu default), this is reachable via unshare -Urn.

 kernel BUG at net/openvswitch/datapath.c:2414!
 Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
 CPU: 1 UID: 0 PID: 65 Comm: poc Not tainted 7.0.0-rc7-00195-geb216e422044 #1
 RIP: 0010:ovs_vport_cmd_set (net/openvswitch/datapath.c:2414 (discriminator 1))
 Call Trace:
  <TASK>
  genl_family_rcv_msg_doit (net/netlink/genetlink.c:1116)
  genl_rcv_msg (net/netlink/genetlink.c:1194 net/netlink/genetlink.c:1209)
  netlink_rcv_skb (net/netlink/af_netlink.c:2550)
  genl_rcv (net/netlink/genetlink.c:1219)
  netlink_unicast (net/netlink/af_netlink.c:1319 net/netlink/af_netlink.c:1344)
  netlink_sendmsg (net/netlink/af_netlink.c:1894)
  __sys_sendto (net/socket.c:2206 (discriminator 1))
  __x64_sys_sendto (net/socket.c:2209)
  do_syscall_64 (arch/x86/entry/syscall_64.c:63 (discriminator 1))
  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
  </TASK>
 Kernel panic - not syncing: Fatal exception

Dynamically compute the reply skb size based on the vport's actual PID
array length instead of using a fixed NLMSG_DEFAULT_SIZE, and replace
the BUG_ON() calls with WARN_ON_ONCE() plus graceful error returns.

Fixes: b83d23a2a38b ("openvswitch: Introduce per-cpu upcall dispatch")
Reported-by: Xiang Mei <xmei5@asu.edu>
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 net/openvswitch/datapath.c | 95 ++++++++++++++++++++++++++------------
 1 file changed, 66 insertions(+), 29 deletions(-)

diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
index e209099218b4..3649a1f2a3f5 100644
--- a/net/openvswitch/datapath.c
+++ b/net/openvswitch/datapath.c
@@ -2184,9 +2184,17 @@ static int ovs_vport_cmd_fill_info(struct vport *vport, struct sk_buff *skb,
 	return err;
 }
 
-static struct sk_buff *ovs_vport_cmd_alloc_info(void)
+/* Must be called with ovs_mutex or rcu_read_lock. */
+static size_t ovs_vport_cmd_msg_size(const struct vport *vport)
 {
-	return nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	const struct vport_portids *ids;
+	size_t msgsize = NLMSG_DEFAULT_SIZE;
+
+	ids = rcu_dereference_ovsl(vport->upcall_portids);
+	if (ids && (vport->dp->user_features & OVS_DP_F_VPORT_PIDS))
+		msgsize += ids->n_ids * sizeof(u32);
+
+	return msgsize;
 }
 
 /* Called with ovs_mutex, only via ovs_dp_notify_wq(). */
@@ -2196,13 +2204,16 @@ struct sk_buff *ovs_vport_cmd_build_info(struct vport *vport, struct net *net,
 	struct sk_buff *skb;
 	int retval;
 
-	skb = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	skb = nlmsg_new(ovs_vport_cmd_msg_size(vport), GFP_KERNEL);
 	if (!skb)
 		return ERR_PTR(-ENOMEM);
 
 	retval = ovs_vport_cmd_fill_info(vport, skb, net, portid, seq, 0, cmd,
 					 GFP_KERNEL);
-	BUG_ON(retval < 0);
+	if (WARN_ON_ONCE(retval < 0)) {
+		kfree_skb(skb);
+		return ERR_PTR(retval);
+	}
 
 	return skb;
 }
@@ -2303,7 +2314,8 @@ static int ovs_vport_cmd_new(struct sk_buff *skb, struct genl_info *info)
 	if (port_no >= DP_MAX_PORTS)
 		return -EFBIG;
 
-	reply = ovs_vport_cmd_alloc_info();
+	reply = genlmsg_new(NLMSG_DEFAULT_SIZE +
+			    nla_len(a[OVS_VPORT_ATTR_UPCALL_PID]), GFP_KERNEL);
 	if (!reply)
 		return -ENOMEM;
 
@@ -2358,7 +2370,9 @@ static int ovs_vport_cmd_new(struct sk_buff *skb, struct genl_info *info)
 	else
 		netdev_set_rx_headroom(vport->dev, dp->max_headroom);
 
-	BUG_ON(err < 0);
+	if (WARN_ON_ONCE(err < 0))
+		goto exit_unlock_free;
+
 	ovs_unlock();
 
 	ovs_notify(&dp_vport_genl_family, reply, info);
@@ -2377,49 +2391,52 @@ static int ovs_vport_cmd_set(struct sk_buff *skb, struct genl_info *info)
 	struct vport *vport;
 	int err;
 
-	reply = ovs_vport_cmd_alloc_info();
-	if (!reply)
-		return -ENOMEM;
-
 	ovs_lock();
 	vport = lookup_vport(sock_net(skb->sk), genl_info_userhdr(info), a);
 	err = PTR_ERR(vport);
 	if (IS_ERR(vport))
-		goto exit_unlock_free;
+		goto exit_unlock;
 
 	if (a[OVS_VPORT_ATTR_TYPE] &&
 	    nla_get_u32(a[OVS_VPORT_ATTR_TYPE]) != vport->ops->type) {
 		err = -EINVAL;
-		goto exit_unlock_free;
+		goto exit_unlock;
 	}
 
 	if (a[OVS_VPORT_ATTR_OPTIONS]) {
 		err = ovs_vport_set_options(vport, a[OVS_VPORT_ATTR_OPTIONS]);
 		if (err)
-			goto exit_unlock_free;
+			goto exit_unlock;
 	}
 
-
 	if (a[OVS_VPORT_ATTR_UPCALL_PID]) {
 		struct nlattr *ids = a[OVS_VPORT_ATTR_UPCALL_PID];
 
 		err = ovs_vport_set_upcall_portids(vport, ids);
 		if (err)
-			goto exit_unlock_free;
+			goto exit_unlock;
+	}
+
+	reply = genlmsg_new(ovs_vport_cmd_msg_size(vport), GFP_KERNEL);
+	if (!reply) {
+		err = -ENOMEM;
+		goto exit_unlock;
 	}
 
 	err = ovs_vport_cmd_fill_info(vport, reply, genl_info_net(info),
 				      info->snd_portid, info->snd_seq, 0,
 				      OVS_VPORT_CMD_SET, GFP_KERNEL);
-	BUG_ON(err < 0);
+	if (WARN_ON_ONCE(err < 0)) {
+		kfree_skb(reply);
+		goto exit_unlock;
+	}
 
 	ovs_unlock();
 	ovs_notify(&dp_vport_genl_family, reply, info);
 	return 0;
 
-exit_unlock_free:
+exit_unlock:
 	ovs_unlock();
-	kfree_skb(reply);
 	return err;
 }
 
@@ -2433,25 +2450,30 @@ static int ovs_vport_cmd_del(struct sk_buff *skb, struct genl_info *info)
 	unsigned int new_headroom;
 	int err;
 
-	reply = ovs_vport_cmd_alloc_info();
-	if (!reply)
-		return -ENOMEM;
-
 	ovs_lock();
 	vport = lookup_vport(sock_net(skb->sk), genl_info_userhdr(info), a);
 	err = PTR_ERR(vport);
 	if (IS_ERR(vport))
-		goto exit_unlock_free;
+		goto exit_unlock;
 
 	if (vport->port_no == OVSP_LOCAL) {
 		err = -EINVAL;
-		goto exit_unlock_free;
+		goto exit_unlock;
+	}
+
+	reply = genlmsg_new(ovs_vport_cmd_msg_size(vport), GFP_KERNEL);
+	if (!reply) {
+		err = -ENOMEM;
+		goto exit_unlock;
 	}
 
 	err = ovs_vport_cmd_fill_info(vport, reply, genl_info_net(info),
 				      info->snd_portid, info->snd_seq, 0,
 				      OVS_VPORT_CMD_DEL, GFP_KERNEL);
-	BUG_ON(err < 0);
+	if (WARN_ON_ONCE(err < 0)) {
+		kfree_skb(reply);
+		goto exit_unlock;
+	}
 
 	/* the vport deletion may trigger dp headroom update */
 	dp = vport->dp;
@@ -2472,9 +2494,8 @@ static int ovs_vport_cmd_del(struct sk_buff *skb, struct genl_info *info)
 	ovs_notify(&dp_vport_genl_family, reply, info);
 	return 0;
 
-exit_unlock_free:
+exit_unlock:
 	ovs_unlock();
-	kfree_skb(reply);
 	return err;
 }
 
@@ -2484,9 +2505,20 @@ static int ovs_vport_cmd_get(struct sk_buff *skb, struct genl_info *info)
 	struct ovs_header *ovs_header = genl_info_userhdr(info);
 	struct sk_buff *reply;
 	struct vport *vport;
+	size_t msg_size;
 	int err;
 
-	reply = ovs_vport_cmd_alloc_info();
+	rcu_read_lock();
+	vport = lookup_vport(sock_net(skb->sk), ovs_header, a);
+	err = PTR_ERR(vport);
+	if (IS_ERR(vport)) {
+		rcu_read_unlock();
+		return err;
+	}
+	msg_size = ovs_vport_cmd_msg_size(vport);
+	rcu_read_unlock();
+
+	reply = genlmsg_new(msg_size, GFP_KERNEL);
 	if (!reply)
 		return -ENOMEM;
 
@@ -2495,12 +2527,17 @@ static int ovs_vport_cmd_get(struct sk_buff *skb, struct genl_info *info)
 	err = PTR_ERR(vport);
 	if (IS_ERR(vport))
 		goto exit_unlock_free;
+
 	err = ovs_vport_cmd_fill_info(vport, reply, genl_info_net(info),
 				      info->snd_portid, info->snd_seq, 0,
 				      OVS_VPORT_CMD_GET, GFP_ATOMIC);
-	BUG_ON(err < 0);
 	rcu_read_unlock();
 
+	if (err < 0) {
+		kfree_skb(reply);
+		return err;
+	}
+
 	return genlmsg_reply(reply, info);
 
 exit_unlock_free:
-- 
2.43.0


