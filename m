Return-Path: <netdev+bounces-277701-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sKCTKnhX2mn/0QgAu9opvQ
	(envelope-from <netdev+bounces-277701-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 16:15:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 235A23E0470
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 16:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1500F304BBB8
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 14:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E720936EABF;
	Sat, 11 Apr 2026 14:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fqX/gWy6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B3119EED3
	for <netdev@vger.kernel.org>; Sat, 11 Apr 2026 14:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775916917; cv=none; b=AK5HAMJmNrlAWb+WJ+uP468t9QBEcM8qt57mUgYrewr6oDHfIfeKN9a31J8cxFfaUD8r7jvAPJeunErCF4u+S7CZ3M43qlsufaC6UN1Jmv0Nodn7fvuH2/PYZcLoEfxmWn72EFTgFp5u0uD9wpJ6S7MUl5isErl5eb6t8Z5wqcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775916917; c=relaxed/simple;
	bh=xz8ufQeOfD0RaPa3cxDIYLWhvLmAnj3P8cLi3v5AiJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DPS71O4tk3RmKErQaY4a+bI05BH3q4vTN4WIQFN41R6EAkFofHwLcZkdjU+rGDg2sRYFAXJOzxLQfy1b3CZoKFZB1uR7wPRtoTUrH6+IYzGmpkNxVF9FGOSIVCCZ+9+Bkx0rQaXJnvwgOKXO3pIB75HAHdpKNkr4sWoT/YmFdJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fqX/gWy6; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2d323567f11so1279070eec.1
        for <netdev@vger.kernel.org>; Sat, 11 Apr 2026 07:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775916912; x=1776521712; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ek3Lj4/DR6Mztj9LHpSZ6EK4fq4aWP0dbrOFhIMHTkU=;
        b=fqX/gWy69gA6ofNBP/A0P/US8+8mtVdgOluFB+06lVga2gi/dhZN274e3loimjHsIy
         CLWV+fad1cCQnd37pvYlfFe8SoRqDEpzHoD9yQ0RfvCylZ6xwmGzFGZoBBn8Uh70v6PN
         2hZ3wFJyuORRv6gShA9U9yWlVwSDwR6SXDTLgHlyCHGvhGD4dG1RyYwYUf0aPTsRhSrN
         USbI02ykNMkXlaqHBRAUvlI2zXFfeEox0Z8h3YPDm/T3O+1sT+on0Vt6VNGCi+1LH5wO
         T1iHvD/wuc7kLtPl5jg0tk8CyXqzOmZfYnlqbzotsS4ZocscFN+iyOJjF19K+mTOfI2R
         yE1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775916912; x=1776521712;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ek3Lj4/DR6Mztj9LHpSZ6EK4fq4aWP0dbrOFhIMHTkU=;
        b=NXYjrwNcKYQHx3RPuo8Ey7TjCMUcxjRU6aB5DxEfRpRsoxDZkWAiwO+uKlSxFuXYNE
         47JHW0QTknLbojhlHjku79maKcbaxQ33BNAzcrjHN4mofLUazpf6kmzBad3dbe3ndjqS
         j/P26REzaQUXqT07WTKlILyJL2mcFSuwauNWh46/DQv4LS9in0k/DDdYGbRzMjOdahye
         jXUe0uNirZ9nrDxYy7YI5ihkgLtmDHpI4QYm7pU5CmNkKtmN+A58FWWk3jdcc5Gj6H8x
         64sQRf1f9QkXkGQk5vWJjehGpDHK2jFdo/mPCRWKc9bcXhDQQtYBbs/SVulTDlyS680p
         jtUg==
X-Forwarded-Encrypted: i=1; AJvYcCUG6TCJph8TaSywxvv26Zsaqt28vkOPy+aKS9pAM3RDH+qhs7mn7GhrBgmepgA7mAW7y4IC/xw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbNsRBqONuCwcAqPlFMJdcaSthkBpZMw3rBGZZ5yRtoHN/r1fI
	s6v7gS/ximpPx0cIVBM8JF5db9gmOZqlnXy6P6zt8AxnNa6sz9hL7Uhn
X-Gm-Gg: AeBDievAofZq2+7ZyPLiYG9zhl7wuDeKjjOQtp3JV0YWKxObSKYHAftoYNyi7gUKQ+x
	zjzDy5mM54TZq3DliPVByFGjFBWwg7S5CNbLZQJ6vHGUjQAT5ByOxxI/PXdtDGwCe/QvAnKafx0
	zthnuRyTd1oRpD2ZXOaYpJGPNQ671YJgLzlFHv2Bakce0G+Q5DLCyb+S7YwdlkzYiowhVImORF8
	qFvdSSd4K2fFvWZs1JPUHo+QsLQLSNZRoAY0LySBEteENhPWj/59MKnyjYfY3ZWVn9HjR8A2QUq
	rsyPYjERB2627J6TgujiypH3nroJW9gTAv/iAcM8Axy30dMFwzVa7WZfNgCFOPjVxhKPPwTmCOu
	TQNPUc8CxYN4U51aCyPD/Ck7fOuv8DGnPQPRahmLYDLBJzjYZ/+bpurwRYprbegqAJscDZ4hBtx
	CBf5vB5OMV7oz59dmwKFIPLVOklOjfucrpKEV5zVk1NjInxJI2vqsysiNIxuGPQ1RFKzVIuCU4R
	ST9Gopk6g==
X-Received: by 2002:a05:7300:cd8a:b0:2d3:9c91:6c45 with SMTP id 5a478bee46e88-2d599d816d0mr3341767eec.6.1775916911685;
        Sat, 11 Apr 2026 07:15:11 -0700 (PDT)
Received: from efaec68ba852.tailc0aff1.ts.net ([206.206.192.132])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d561cd2a4esm11236005eec.16.2026.04.11.07.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 07:15:11 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Pravin B Shelar <pshelar@ovn.org>,
	Flavio Leitner <fbl@sysclose.org>,
	Mark Gray <mark.d.gray@redhat.com>,
	netdev@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>
Subject: [PATCH v2 net] openvswitch: fix vport netlink reply size for large upcall PID arrays
Date: Sat, 11 Apr 2026 07:14:50 -0700
Message-ID: <20260411141448.1479933-3-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <v1-message-id>
References: <v1-message-id>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,ovn.org,sysclose.org,vger.kernel.org,asu.edu,gmail.com];
	TAGGED_FROM(0.00)[bounces-277701-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,asu.edu:email]
X-Rspamd-Queue-Id: 235A23E0470
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The vport netlink reply helpers allocate a fixed-size skb with
nlmsg_new(NLMSG_DEFAULT_SIZE, ...) but serialize the full upcall PID
array via ovs_vport_get_upcall_portids(). Since
ovs_vport_set_upcall_portids() accepts any non-zero multiple of
sizeof(u32) with no upper bound, a CAP_NET_ADMIN user can install a PID
array large enough to overflow the reply buffer. On systems with
unprivileged user namespaces enabled (e.g., Ubuntu default), this is
reachable via unshare -Urn since all OVS vport genl operations use
GENL_UNS_ADMIN_PERM.

When the subsequent nla_put() fails with -EMSGSIZE, five BUG_ON(err < 0)
sites fire and panic the kernel:

 kernel BUG at net/openvswitch/datapath.c:2414!
 Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
 CPU: 1 UID: 0 PID: 65 Comm: poc Not tainted 7.0.0-rc7-00195-geb216e422044 #1
 RIP: 0010:ovs_vport_cmd_set+0x34c/0x400
 Call Trace:
  <TASK>
  genl_family_rcv_msg_doit (net/netlink/genetlink.c:1116)
  genl_rcv_msg (net/netlink/genetlink.c:1194)
  netlink_rcv_skb (net/netlink/af_netlink.c:2550)
  genl_rcv (net/netlink/genetlink.c:1219)
  netlink_unicast (net/netlink/af_netlink.c:1344)
  netlink_sendmsg (net/netlink/af_netlink.c:1894)
  __sys_sendto (net/socket.c:2206)
  __x64_sys_sendto (net/socket.c:2209)
  do_syscall_64 (arch/x86/entry/syscall_64.c:63)
  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
  </TASK>
 Kernel panic - not syncing: Fatal exception

Fix this by dynamically sizing the reply skb to account for the actual
PID array length, and replace the BUG_ON() calls with graceful error
returns.

Fixes: b83d23a2a38b ("openvswitch: Introduce per-cpu upcall dispatch")
Reported-by: Xiang Mei <xmei5@asu.edu>
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
Changes in v2:
 - Dynamically size reply skb instead of using fixed NLMSG_DEFAULT_SIZE.
 - Drop WARN_ON_ONCE (still panics with panic_on_warn); use plain error
   returns instead.

 net/openvswitch/datapath.c | 102 +++++++++++++++++++++++++------------
 net/openvswitch/vport.c    |  12 +++++
 net/openvswitch/vport.h    |   1 +
 3 files changed, 82 insertions(+), 33 deletions(-)

diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
index e209099218b4..72e27a38d3a7 100644
--- a/net/openvswitch/datapath.c
+++ b/net/openvswitch/datapath.c
@@ -2184,9 +2184,11 @@ static int ovs_vport_cmd_fill_info(struct vport *vport, struct sk_buff *skb,
 	return err;
 }
 
-static struct sk_buff *ovs_vport_cmd_alloc_info(void)
+static struct sk_buff *ovs_vport_cmd_alloc_info(struct vport *vport)
 {
-	return nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	return nlmsg_new(NLMSG_DEFAULT_SIZE +
+			 ovs_vport_get_upcall_portids_size(vport),
+			 GFP_KERNEL);
 }
 
 /* Called with ovs_mutex, only via ovs_dp_notify_wq(). */
@@ -2196,13 +2198,16 @@ struct sk_buff *ovs_vport_cmd_build_info(struct vport *vport, struct net *net,
 	struct sk_buff *skb;
 	int retval;
 
-	skb = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	skb = ovs_vport_cmd_alloc_info(vport);
 	if (!skb)
 		return ERR_PTR(-ENOMEM);
 
 	retval = ovs_vport_cmd_fill_info(vport, skb, net, portid, seq, 0, cmd,
 					 GFP_KERNEL);
-	BUG_ON(retval < 0);
+	if (retval < 0) {
+		kfree_skb(skb);
+		return ERR_PTR(retval);
+	}
 
 	return skb;
 }
@@ -2303,10 +2308,6 @@ static int ovs_vport_cmd_new(struct sk_buff *skb, struct genl_info *info)
 	if (port_no >= DP_MAX_PORTS)
 		return -EFBIG;
 
-	reply = ovs_vport_cmd_alloc_info();
-	if (!reply)
-		return -ENOMEM;
-
 	ovs_lock();
 restart:
 	dp = get_dp(sock_net(skb->sk), ovs_header->dp_ifindex);
@@ -2347,6 +2348,13 @@ static int ovs_vport_cmd_new(struct sk_buff *skb, struct genl_info *info)
 		goto exit_unlock_free;
 	}
 
+	reply = ovs_vport_cmd_alloc_info(vport);
+	if (!reply) {
+		ovs_dp_detach_port(vport);
+		err = -ENOMEM;
+		goto exit_unlock_free;
+	}
+
 	err = ovs_vport_cmd_fill_info(vport, reply, genl_info_net(info),
 				      info->snd_portid, info->snd_seq, 0,
 				      OVS_VPORT_CMD_NEW, GFP_KERNEL);
@@ -2358,7 +2366,11 @@ static int ovs_vport_cmd_new(struct sk_buff *skb, struct genl_info *info)
 	else
 		netdev_set_rx_headroom(vport->dev, dp->max_headroom);
 
-	BUG_ON(err < 0);
+	if (err < 0) {
+		ovs_unlock();
+		kfree_skb(reply);
+		return err;
+	}
 	ovs_unlock();
 
 	ovs_notify(&dp_vport_genl_family, reply, info);
@@ -2366,7 +2378,6 @@ static int ovs_vport_cmd_new(struct sk_buff *skb, struct genl_info *info)
 
 exit_unlock_free:
 	ovs_unlock();
-	kfree_skb(reply);
 	return err;
 }
 
@@ -2377,10 +2388,6 @@ static int ovs_vport_cmd_set(struct sk_buff *skb, struct genl_info *info)
 	struct vport *vport;
 	int err;
 
-	reply = ovs_vport_cmd_alloc_info();
-	if (!reply)
-		return -ENOMEM;
-
 	ovs_lock();
 	vport = lookup_vport(sock_net(skb->sk), genl_info_userhdr(info), a);
 	err = PTR_ERR(vport);
@@ -2399,7 +2406,6 @@ static int ovs_vport_cmd_set(struct sk_buff *skb, struct genl_info *info)
 			goto exit_unlock_free;
 	}
 
-
 	if (a[OVS_VPORT_ATTR_UPCALL_PID]) {
 		struct nlattr *ids = a[OVS_VPORT_ATTR_UPCALL_PID];
 
@@ -2408,10 +2414,20 @@ static int ovs_vport_cmd_set(struct sk_buff *skb, struct genl_info *info)
 			goto exit_unlock_free;
 	}
 
+	reply = ovs_vport_cmd_alloc_info(vport);
+	if (!reply) {
+		err = -ENOMEM;
+		goto exit_unlock_free;
+	}
+
 	err = ovs_vport_cmd_fill_info(vport, reply, genl_info_net(info),
 				      info->snd_portid, info->snd_seq, 0,
 				      OVS_VPORT_CMD_SET, GFP_KERNEL);
-	BUG_ON(err < 0);
+	if (err < 0) {
+		ovs_unlock();
+		kfree_skb(reply);
+		return err;
+	}
 
 	ovs_unlock();
 	ovs_notify(&dp_vport_genl_family, reply, info);
@@ -2419,7 +2435,6 @@ static int ovs_vport_cmd_set(struct sk_buff *skb, struct genl_info *info)
 
 exit_unlock_free:
 	ovs_unlock();
-	kfree_skb(reply);
 	return err;
 }
 
@@ -2433,10 +2448,6 @@ static int ovs_vport_cmd_del(struct sk_buff *skb, struct genl_info *info)
 	unsigned int new_headroom;
 	int err;
 
-	reply = ovs_vport_cmd_alloc_info();
-	if (!reply)
-		return -ENOMEM;
-
 	ovs_lock();
 	vport = lookup_vport(sock_net(skb->sk), genl_info_userhdr(info), a);
 	err = PTR_ERR(vport);
@@ -2448,10 +2459,20 @@ static int ovs_vport_cmd_del(struct sk_buff *skb, struct genl_info *info)
 		goto exit_unlock_free;
 	}
 
+	reply = ovs_vport_cmd_alloc_info(vport);
+	if (!reply) {
+		err = -ENOMEM;
+		goto exit_unlock_free;
+	}
+
 	err = ovs_vport_cmd_fill_info(vport, reply, genl_info_net(info),
 				      info->snd_portid, info->snd_seq, 0,
 				      OVS_VPORT_CMD_DEL, GFP_KERNEL);
-	BUG_ON(err < 0);
+	if (err < 0) {
+		ovs_unlock();
+		kfree_skb(reply);
+		return err;
+	}
 
 	/* the vport deletion may trigger dp headroom update */
 	dp = vport->dp;
@@ -2474,7 +2495,6 @@ static int ovs_vport_cmd_del(struct sk_buff *skb, struct genl_info *info)
 
 exit_unlock_free:
 	ovs_unlock();
-	kfree_skb(reply);
 	return err;
 }
 
@@ -2484,29 +2504,45 @@ static int ovs_vport_cmd_get(struct sk_buff *skb, struct genl_info *info)
 	struct ovs_header *ovs_header = genl_info_userhdr(info);
 	struct sk_buff *reply;
 	struct vport *vport;
+	size_t portids_size;
 	int err;
 
-	reply = ovs_vport_cmd_alloc_info();
+	/* Get portids size under RCU, then allocate outside RCU
+	 * since nlmsg_new(GFP_KERNEL) may sleep.
+	 */
+	rcu_read_lock();
+	vport = lookup_vport(sock_net(skb->sk), ovs_header, a);
+	if (IS_ERR(vport)) {
+		err = PTR_ERR(vport);
+		rcu_read_unlock();
+		return err;
+	}
+	portids_size = ovs_vport_get_upcall_portids_size(vport);
+	rcu_read_unlock();
+
+	reply = nlmsg_new(NLMSG_DEFAULT_SIZE + portids_size, GFP_KERNEL);
 	if (!reply)
 		return -ENOMEM;
 
 	rcu_read_lock();
 	vport = lookup_vport(sock_net(skb->sk), ovs_header, a);
-	err = PTR_ERR(vport);
-	if (IS_ERR(vport))
-		goto exit_unlock_free;
+	if (IS_ERR(vport)) {
+		err = PTR_ERR(vport);
+		rcu_read_unlock();
+		kfree_skb(reply);
+		return err;
+	}
 	err = ovs_vport_cmd_fill_info(vport, reply, genl_info_net(info),
 				      info->snd_portid, info->snd_seq, 0,
 				      OVS_VPORT_CMD_GET, GFP_ATOMIC);
-	BUG_ON(err < 0);
 	rcu_read_unlock();
 
-	return genlmsg_reply(reply, info);
+	if (err < 0) {
+		kfree_skb(reply);
+		return err;
+	}
 
-exit_unlock_free:
-	rcu_read_unlock();
-	kfree_skb(reply);
-	return err;
+	return genlmsg_reply(reply, info);
 }
 
 static int ovs_vport_cmd_dump(struct sk_buff *skb, struct netlink_callback *cb)
diff --git a/net/openvswitch/vport.c b/net/openvswitch/vport.c
index 23f629e94a36..57a6df7d6829 100644
--- a/net/openvswitch/vport.c
+++ b/net/openvswitch/vport.c
@@ -424,6 +424,18 @@ int ovs_vport_set_upcall_portids(struct vport *vport, const struct nlattr *ids)
 	return 0;
 }
 
+int ovs_vport_get_upcall_portids_size(const struct vport *vport)
+{
+	struct vport_portids *ids;
+
+	ids = rcu_dereference_ovsl(vport->upcall_portids);
+
+	if (vport->dp->user_features & OVS_DP_F_VPORT_PIDS)
+		return nla_total_size(ids->n_ids * sizeof(u32));
+	else
+		return nla_total_size(sizeof(u32));
+}
+
 /**
  *	ovs_vport_get_upcall_portids - get the upcall_portids of @vport.
  *
diff --git a/net/openvswitch/vport.h b/net/openvswitch/vport.h
index 9f67b9dd49f9..ee674d59a9c6 100644
--- a/net/openvswitch/vport.h
+++ b/net/openvswitch/vport.h
@@ -38,6 +38,7 @@ int ovs_vport_set_options(struct vport *, struct nlattr *options);
 int ovs_vport_get_options(const struct vport *, struct sk_buff *);
 
 int ovs_vport_set_upcall_portids(struct vport *, const struct nlattr *pids);
+int ovs_vport_get_upcall_portids_size(const struct vport *vport);
 int ovs_vport_get_upcall_portids(const struct vport *, struct sk_buff *);
 u32 ovs_vport_find_upcall_portid(const struct vport *, struct sk_buff *);
 
-- 
2.43.0


