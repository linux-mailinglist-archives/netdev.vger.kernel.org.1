Return-Path: <netdev+bounces-278910-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id D8x9HDFO4GmaegAAu9opvQ
	(envelope-from <netdev+bounces-278910-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 04:49:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D1459409C06
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 04:49:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BD167301370B
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 02:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EDE91E9B3A;
	Thu, 16 Apr 2026 02:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wx6WLghb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA76D86341
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 02:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776307754; cv=none; b=q0yT68RpxALsGKIuObg7J85DPDpz6jHKBJEYeH8CREdw+xJMV+hqWVBxHualMrAfmBRTudr9l0TwCTWojyrf8rNg/0QCQy7G/Hk9wQIty6VNHXk7w/EznseZLIv7wIbyPhBko1KCQmMIv3OvIhecWp93aGOGfZsyoQ6LdlZQUhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776307754; c=relaxed/simple;
	bh=p6PLJdKN7MUAvD8bHf/FMx/ZtqSeqi0mwJQcT39uGew=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aVBYCDJY46sCuT91gtuPyfij6M4QxC9v+QtEiMSA64XJfq/2z8Lpqw/lNFXw9CF2ALkZhFQ2tFL1eP2CbUQTuUxPYThh2wQBOFji3QAK0MAQ5lk8FEv/W3vWN7BElv8SybQgrcY9RVFHZJSZP47L3yovwnOwIHCfGh2OQOm9Ae4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wx6WLghb; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2d9916deb14so6119241eec.0
        for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 19:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776307752; x=1776912552; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X0dSZtRvfdiC9Z6UENOGRIm8HsjE/DxYzuK7m+Xz0Kc=;
        b=Wx6WLghb35FEN/TB9hx08jfOAHXuVuu3Ad4QjbNCIYdkKrynEAzDNNHAj34tIMtdpq
         uoEa4UebI7CHMkudWCbJlWPUjlhNhZ89X4LBd3nFk6b1pkBr8FvsjGo+tRB+oaami8zg
         /fHEqe8HFPWzlyI/fuj7/eunqWN4KjiJSR2ss/SYbrDWRaUf+0g/RUQ5dWpVybk9VfU6
         4h4VseqVuOXUh3DRLVusGEU+gnKbeZAVXYZ/VJI1VEtjhYO0tdnvguTm7moRaHCvDElq
         nwPHmUjSzNAGycDcbKZmBBVdMy93tswLgGN2UOQ/yLL/x7SZORtvMyUZp38yAPUJgCmB
         qoKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776307752; x=1776912552;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X0dSZtRvfdiC9Z6UENOGRIm8HsjE/DxYzuK7m+Xz0Kc=;
        b=esJHl/MSiCFqqiZ50Koldo9ca+hA6738a9DXCkIqQPz/lDX72x7xBLjQgWy2BFlcMY
         HszvW5onfKg+q+zH7fDcVeNq2buppJUNvhQsP8k8CS89PrKI5ZRoPQpFNpX6ksHCIuxG
         LU0JUqYq6QvMDNsiRKV4pPWpbDMVtMlipRjLB5q1+qxwOIpUO/pZH3HfwfFgtg/LVF3b
         N1DK2rwZx6VhLm+Vfn81pir3qtVgQlKtE7tFfyi0ZXz3UHkyW/6xVIuNTgD9ERXKF4Jf
         3fxW3EfvLSDmDfD6yt2qjFlhs+wZQhDoYReBjh4IiIGucSBoPxIJcYwitreYi4ktrZRM
         li8A==
X-Forwarded-Encrypted: i=1; AFNElJ//FSeaT/z5m1T9KyeeH1TmKzxk1qAB3rwDaGUMQIoDppZZ5/VZAbrHHqgKrMtFQa3ajwuqTZw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX9c9EBwF0SEKc7nZxneN9EXopttUAs6FabTBjgP++4QtUIIwd
	q2SfmK8Tr7bTRD4xmBmIJiVhWq1Yec5N2c0N89dPqaamPLOyvSUtM9GI
X-Gm-Gg: AeBDiev2hCGHLSAgddpRls+svzbtnUb/NK2U3hnycrINHrkUFpJQTDeph8EQ2Zm7Mvi
	rbeJ5OTIompZ15bkX2Cp2FyDMqnrOkuFHQhwEhh9Ldb32dDF8YiIhb/XOc4ChoN1iuXWXDK2dx2
	7VJTjxPEMUII87Lzi+6LjHJTt3SZuCKcQ9PvLKBqkmSqlf7u7FPKaldFnO/f2hIb+X0WdjPvA1M
	sRzueuhxeG6AkczgzJYllLuPlGhAy4nWw2xVwFSLDHDgFmzUDCITJNwRmeKIaERQIYzyDkwL3+g
	quPmkB75jE2W+t6uPE+DG2aEO6abcBN2KGfqF27dAITtwXHzEhEUl1mn2L6lcmqVjBKmybODqcN
	QNr7vtJ3R5NB0y9ZqXQacwKtfeDssidOOOHc+ljH3AlP/ngtNteva9fnh3/rkcH2Az4EdlA+VWt
	tznDlVgeVZq2/DgjVaprNq8lwqOwwB8xvZnDLMua06NB0tyqMmkNh0rPZJaU69hNFKMycVNu8jJ
	Qjg1EFOCQ==
X-Received: by 2002:a05:7301:1003:b0:2c5:50fe:c795 with SMTP id 5a478bee46e88-2d58a788298mr15531877eec.29.1776307751678;
        Wed, 15 Apr 2026 19:49:11 -0700 (PDT)
Received: from 6cb30d4270db.tailc0aff1.ts.net ([206.206.192.132])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2de8f569f4bsm5266419eec.21.2026.04.15.19.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 19:49:11 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Pravin B Shelar <pshelar@nicira.com>,
	Thomas Graf <tgraf@redhat.com>,
	Alex Wang <alexw@nicira.com>,
	netdev@vger.kernel.org,
	dev@openvswitch.org,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>
Subject: [PATCH net v5] openvswitch: cap upcall PID array size and pre-size vport replies
Date: Wed, 15 Apr 2026 19:46:54 -0700
Message-ID: <20260416024653.153456-2-bestswngs@gmail.com>
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278910-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,nicira.com,redhat.com,vger.kernel.org,openvswitch.org,asu.edu,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN_FAIL(0.00)[4.211.64.104.asn.rspamd.com:server fail];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bestswngs@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D1459409C06
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The vport netlink reply helpers allocate a fixed-size skb with
nlmsg_new(NLMSG_DEFAULT_SIZE, ...) but serialize the full upcall PID
array via ovs_vport_get_upcall_portids().  Since
ovs_vport_set_upcall_portids() accepts any non-zero multiple of
sizeof(u32) with no upper bound, a CAP_NET_ADMIN user can install a PID
array large enough to overflow the reply buffer, causing nla_put() to
fail with -EMSGSIZE and hitting BUG_ON(err < 0).  On systems with
unprivileged user namespaces enabled (e.g., Ubuntu default), this is
reachable via unshare -Urn since OVS vport mutation operations use
GENL_UNS_ADMIN_PERM.

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

Reject attempts to set more PIDs than nr_cpu_ids in
ovs_vport_set_upcall_portids(), and pre-compute the worst-case reply
size in ovs_vport_cmd_msg_size() based on that bound, similar to the
existing ovs_dp_cmd_msg_size().  nr_cpu_ids matches the cap already
used by the per-CPU dispatch configuration on the datapath side
(ovs_dp_cmd_fill_info() serialises at most nr_cpu_ids PIDs), so the
two sides stay consistent.

Fixes: 5cd667b0a456 ("openvswitch: Allow each vport to have an array of 'port_id's.")
Reported-by: Xiang Mei <xmei5@asu.edu>
Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
v5 (per Ilya):
- Add blank lines before multi-line comment blocks in
  ovs_vport_cmd_msg_size() for readability.
- Drop parenthetical from the OVS_VPORT_ATTR_UPCALL_PID comment.
- Add lore links for previous versions.
v4: https://lore.kernel.org/netdev/20260415125121.110874-2-bestswngs@gmail.com
- Use nr_cpu_ids instead of num_possible_cpus() for consistency with
  the per-CPU dispatch on the datapath side.
- Annotate ovs_vport_cmd_msg_size() per-attribute; split nested sums.
v3: https://lore.kernel.org/netdev/20260413035514.2113886-3-bestswngs@gmail.com
- Cap at num_possible_cpus(); add ovs_vport_cmd_msg_size(); keep
  BUG_ON(); fix Fixes tag.
v2: https://lore.kernel.org/netdev/20260411141448.1479933-3-bestswngs@gmail.com
- Dynamically size reply skb; drop WARN_ON_ONCE, return plain errors.
v1: https://lore.kernel.org/netdev/20260411055915.1224902-2-bestswngs@gmail.com
---
 net/openvswitch/datapath.c | 35 +++++++++++++++++++++++++++++++++--
 net/openvswitch/vport.c    |  3 +++
 2 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
index e209099218b4..bbbde50fc649 100644
--- a/net/openvswitch/datapath.c
+++ b/net/openvswitch/datapath.c
@@ -2184,9 +2184,40 @@ static int ovs_vport_cmd_fill_info(struct vport *vport, struct sk_buff *skb,
 	return err;
 }
 
+static size_t ovs_vport_cmd_msg_size(void)
+{
+	size_t msgsize = NLMSG_ALIGN(sizeof(struct ovs_header));
+
+	msgsize += nla_total_size(sizeof(u32)); /* OVS_VPORT_ATTR_PORT_NO */
+	msgsize += nla_total_size(sizeof(u32)); /* OVS_VPORT_ATTR_TYPE */
+	msgsize += nla_total_size(IFNAMSIZ);    /* OVS_VPORT_ATTR_NAME */
+	msgsize += nla_total_size(sizeof(u32)); /* OVS_VPORT_ATTR_IFINDEX */
+	msgsize += nla_total_size(sizeof(s32)); /* OVS_VPORT_ATTR_NETNSID */
+
+	/* OVS_VPORT_ATTR_STATS */
+	msgsize += nla_total_size_64bit(sizeof(struct ovs_vport_stats));
+
+	/* OVS_VPORT_ATTR_UPCALL_STATS(OVS_VPORT_UPCALL_ATTR_SUCCESS +
+	 *                             OVS_VPORT_UPCALL_ATTR_FAIL)
+	 */
+	msgsize += nla_total_size(nla_total_size_64bit(sizeof(u64)) +
+				  nla_total_size_64bit(sizeof(u64)));
+
+	/* OVS_VPORT_ATTR_UPCALL_PID */
+	msgsize += nla_total_size(nr_cpu_ids * sizeof(u32));
+
+	/* OVS_VPORT_ATTR_OPTIONS(OVS_TUNNEL_ATTR_DST_PORT +
+	 *                        OVS_TUNNEL_ATTR_EXTENSION(OVS_VXLAN_EXT_GBP))
+	 */
+	msgsize += nla_total_size(nla_total_size(sizeof(u16)) +
+				  nla_total_size(nla_total_size(0)));
+
+	return msgsize;
+}
+
 static struct sk_buff *ovs_vport_cmd_alloc_info(void)
 {
-	return nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	return genlmsg_new(ovs_vport_cmd_msg_size(), GFP_KERNEL);
 }
 
 /* Called with ovs_mutex, only via ovs_dp_notify_wq(). */
@@ -2196,7 +2227,7 @@ struct sk_buff *ovs_vport_cmd_build_info(struct vport *vport, struct net *net,
 	struct sk_buff *skb;
 	int retval;
 
-	skb = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	skb = ovs_vport_cmd_alloc_info();
 	if (!skb)
 		return ERR_PTR(-ENOMEM);
 
diff --git a/net/openvswitch/vport.c b/net/openvswitch/vport.c
index 23f629e94a36..56b2e2d1a749 100644
--- a/net/openvswitch/vport.c
+++ b/net/openvswitch/vport.c
@@ -406,6 +406,9 @@ int ovs_vport_set_upcall_portids(struct vport *vport, const struct nlattr *ids)
 	if (!nla_len(ids) || nla_len(ids) % sizeof(u32))
 		return -EINVAL;
 
+	if (nla_len(ids) / sizeof(u32) > nr_cpu_ids)
+		return -EINVAL;
+
 	old = ovsl_dereference(vport->upcall_portids);
 
 	vport_portids = kmalloc(sizeof(*vport_portids) + nla_len(ids),
-- 
2.43.0


