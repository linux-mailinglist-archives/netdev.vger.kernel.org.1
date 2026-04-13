Return-Path: <netdev+bounces-277949-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0PxWGIlp3GlAQgkAu9opvQ
	(envelope-from <netdev+bounces-277949-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 05:56:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A801C3E70AD
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 05:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD470300B118
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 03:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECBD52D12F3;
	Mon, 13 Apr 2026 03:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q/Wg5iNh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F2037C11C
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 03:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776052608; cv=none; b=aEdMjY7+lRnml8/D72HkwTkpT3pd24bkiad4EZcu6m0JANMKMQQ0N59zv5lc3edfFmLdOGn7uHcpIjgEJzsTfEN/c2nKKUKb3+w5QMSb3RHFCoSCil3GhtaP9scZKQOJS+lfU8A85Z2Pt7S9MXuctQ+7E8IRVKXNUmI8ujp4m1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776052608; c=relaxed/simple;
	bh=55iLVSDzcMKGb+QmzwcjbWgiY181a6bzULKPdm4HaV0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lXOpeLnMtNBNjRooPNqM41p56Jm6kJcI41R4KP6waMi6nLoFwGx7hBgwq7Sferebi/t0kqeOi70wc8k2Ovs7oME7MEfaFklCVD0aUCy++UfubO5DCkB8MDyM0AaIj1Yfv2hnoBsr6GP+ietAroDun04USrYebJUCqR9AJoPWGFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q/Wg5iNh; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2d7bdb5ffffso2971947eec.1
        for <netdev@vger.kernel.org>; Sun, 12 Apr 2026 20:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776052607; x=1776657407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ksse4B43hM7NUUjw8ChXIOrvUMR9FRTyaZM0w6KrO/M=;
        b=Q/Wg5iNhCfXLolhgt5t7onBNUhgKGWSoEkolUHxyQ4x06exyelJ3utCb9Fkd+DmNOV
         ovjrBgzTSGNx2CLsdI1jdQ78pujBvvSbpb6DSUFLsfe39XdA3QFL16XRzNA2QIromFsK
         14BpIUqn744AW+dcBBbvsPTzHzPbBO/sp7+U2auymE/KMmYA8yEtmlth6B3PEEYcCQYR
         yOuB0QyiQg4ergWF8ydwmbrXIPo78weGjDeQGTvtWVH2e5v1a2ZCjXYxAWJjTM//cUCu
         njx7ESXfq7t6qlvZV1gGqw5Yw6VZyKmRHLZilmhvp70yqbIqMGmIFsRRGi/G8s2rBeY4
         g4TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776052607; x=1776657407;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ksse4B43hM7NUUjw8ChXIOrvUMR9FRTyaZM0w6KrO/M=;
        b=Pyyct+FtqgeqUVslCgSMwRMEUm2d3MSpbYp4/K2cso+RuWkK4/EBy9swrLUuHw7Khg
         MjN4NxWVXJMcAenspZLQFSzhranjhujbR/f6SLQk07ED95GtPRaavR2uC6HUDeRyrdeL
         AvmHeQdVQbdjTm5AegZEoviPZKUThLGHVFjpu3rzKD8yfRNrQjx881ccsMLpdHzPTrE/
         Ube0xzD6S8QV+vRQSdEdpDCDIwLYrSHN7LKb1KS9LFpANZa/EOix09oSVvbjLdRM0DmE
         MtSQ7tcdkWRS3rl/LvBA5+KJUJHS1Zpr8h6M6qM4ec9zuEyvmm6AK5XpXuKuaG8EiW/I
         mCxg==
X-Forwarded-Encrypted: i=1; AFNElJ/qteqqQ43XiCpxLFfTyCAeXudRDEI26xTSsM0JoYQ9n9NRSfhqv21tHrTdfWGBhh7H8ejMVUo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8ZbmCLpdxJ/NP6ouYxMpp/JZByPDZWHvNmnbnhbfJpVu9skpg
	K8l+DYS/PZSzfzQH2Hp80Nj+ZcAMjUnXi5dy9Ii7PSX406MBfCEyDLWT
X-Gm-Gg: AeBDiet1JW9ZkFvrLqpJuHvhdi0RsGMqikI3DelLxSXiFeFkCT4eviRyJ40PKWqw47s
	0LzycDTeQ3gT2SmaEULuT32lGC4rBkfTsnnWLIxbouMiv98MTDlyNRITTaoOQL8TJxdP58aNMzS
	nthL5G14aeV7eARJc77N3NBlOOx87BCWAvWPjUBxwBtDvbS90+B7UVwv/xW1PqAXd7VUXqCXvnI
	UjwzJYUdXOZIL9vglU2rxR4rkkUxICiKFf14iDXaD2NOj6Dx3sMwpF6IqLRwpI8mnigVBx3lx7C
	yBzc1URocpptf1Q5zoftapoDd0AW2q2Cjqm1UbjTuaMtNoHcQ9Aa6U0Csi79GtF0eWs4fxJKKKW
	Jr63bmv1SsaqF9SceBOYum5GiEP4DCG2GefLLcSbPIXZE4BFKkqXVyfVAR5tEy999/LRorV2vXg
	LCqkJen35w0gs8YbOwvWQSz/lCmm7UEiZxiUKV5RxCW+lx23NHuNJJycrKbNNCAnO2L8cvMhIYh
	ym/9ATN1T0Q8JJ/SNLh
X-Received: by 2002:a05:7300:730f:b0:2c4:8d51:f983 with SMTP id 5a478bee46e88-2d587e7f4e5mr6922857eec.11.1776052606602;
        Sun, 12 Apr 2026 20:56:46 -0700 (PDT)
Received: from efaec68ba852.tailc0aff1.ts.net ([206.206.192.132])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d55faa556esm17556759eec.8.2026.04.12.20.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 20:56:45 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Thomas Graf <tgraf@redhat.com>,
	Pravin B Shelar <pshelar@nicira.com>,
	Alex Wang <alexw@nicira.com>,
	netdev@vger.kernel.org,
	dev@openvswitch.org,
	linux-kernel@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>
Subject: [PATCH v3 net] openvswitch: limit vport upcall portids to the number of CPUs
Date: Sun, 12 Apr 2026 20:55:16 -0700
Message-ID: <20260413035514.2113886-3-bestswngs@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,nicira.com,vger.kernel.org,openvswitch.org,asu.edu,gmail.com];
	TAGGED_FROM(0.00)[bounces-277949-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A801C3E70AD
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

Reject attempts to set more PIDs than num_possible_cpus() in
ovs_vport_set_upcall_portids(), and pre-compute the worst-case reply
size in ovs_vport_cmd_msg_size() based on that bound, similar to the
existing ovs_dp_cmd_msg_size().

Fixes: 5cd667b0a456 ("openvswitch: Allow each vport to have an array of 'port_id's.")
Reported-by: Xiang Mei <xmei5@asu.edu>
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
v3:
 - Cap PID array at num_possible_cpus() in ovs_vport_set_upcall_portids().
 - Add ovs_vport_cmd_msg_size() for worst-case reply allocation.
 - Keep BUG_ON()s, fix Fixes tag.
v2:
 - Dynamically size reply skb instead of using fixed NLMSG_DEFAULT_SIZE.
 - Drop WARN_ON_ONCE; use plain error returns instead.

 net/openvswitch/datapath.c | 23 +++++++++++++++++++++--
 net/openvswitch/vport.c    |  3 +++
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
index e209099218b4..4049bfa1c4df 100644
--- a/net/openvswitch/datapath.c
+++ b/net/openvswitch/datapath.c
@@ -2184,9 +2184,28 @@ static int ovs_vport_cmd_fill_info(struct vport *vport, struct sk_buff *skb,
 	return err;
 }
 
+static size_t ovs_vport_cmd_msg_size(void)
+{
+	size_t msgsize = NLMSG_ALIGN(sizeof(struct ovs_header));
+
+	msgsize += nla_total_size(sizeof(u32)); /* OVS_VPORT_ATTR_PORT_NO */
+	msgsize += nla_total_size(sizeof(u32)); /* OVS_VPORT_ATTR_TYPE */
+	msgsize += nla_total_size(IFNAMSIZ);
+	msgsize += nla_total_size(sizeof(u32)); /* OVS_VPORT_ATTR_IFINDEX */
+	msgsize += nla_total_size(sizeof(s32)); /* OVS_VPORT_ATTR_NETNSID */
+	msgsize += nla_total_size_64bit(sizeof(struct ovs_vport_stats));
+	msgsize += nla_total_size(nla_total_size_64bit(sizeof(u64)) +
+				  nla_total_size_64bit(sizeof(u64)));
+	msgsize += nla_total_size(num_possible_cpus() * sizeof(u32));
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
@@ -2196,7 +2215,7 @@ struct sk_buff *ovs_vport_cmd_build_info(struct vport *vport, struct net *net,
 	struct sk_buff *skb;
 	int retval;
 
-	skb = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	skb = ovs_vport_cmd_alloc_info();
 	if (!skb)
 		return ERR_PTR(-ENOMEM);
 
diff --git a/net/openvswitch/vport.c b/net/openvswitch/vport.c
index 23f629e94a36..ccd43bc47bc6 100644
--- a/net/openvswitch/vport.c
+++ b/net/openvswitch/vport.c
@@ -406,6 +406,9 @@ int ovs_vport_set_upcall_portids(struct vport *vport, const struct nlattr *ids)
 	if (!nla_len(ids) || nla_len(ids) % sizeof(u32))
 		return -EINVAL;
 
+	if (nla_len(ids) / sizeof(u32) > num_possible_cpus())
+		return -EINVAL;
+
 	old = ovsl_dereference(vport->upcall_portids);
 
 	vport_portids = kmalloc(sizeof(*vport_portids) + nla_len(ids),
-- 
2.43.0


