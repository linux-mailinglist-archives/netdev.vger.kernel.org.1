Return-Path: <netdev+bounces-278765-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJ77BOWJ32l5VAAAu9opvQ
	(envelope-from <netdev+bounces-278765-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 14:51:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A69E404838
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 14:51:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 872CE3037EFB
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 12:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2006A275B15;
	Wed, 15 Apr 2026 12:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i+qgBSOW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DFC19A288
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 12:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776257506; cv=none; b=S4UB2OQ2T+p3vMcvGpglxo+Sogh3a5xdRU+u1joNXqvh10Qr1sLYWY6MQm/o0Ax85nyqP21HvVzL6Q3UYJd1ZvCwonqTcwEo2KYKkCFGRuqfk9XsooK8DO6dN6ZX+XbzFElpGF68xNycPEn6uM6myWDLtqZM4p0Xe7VqLvDx6Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776257506; c=relaxed/simple;
	bh=BlWhuiAQt0+BoSrJTv31mpQPd6BWvEG9oyHSRuDct5k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VhvFFkY/f4Bh4AUyBc6+4p5q2nG5bBX2H02cdACAK27KZVXawScLldBcTyXfn7slrahtloTvqG/hsokPr+m26xdOffqeZPjj5Tc13yn3+4WJx1U3ZgqN6zeQGM5abk+TWonrgR9n1DHwI+TXumkvoKFN4XPHEE7maPT/IS+oPds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i+qgBSOW; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2bdd40d3c61so5989960eec.1
        for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 05:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776257504; x=1776862304; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yNVtghdFDqTr06npTeuHS9vtArWDTpcLIvYINogqhXM=;
        b=i+qgBSOWwVXb1JeIz7epNqFk+zf88y0WKdyHI11h9UBObbC0hIAh8eXgmJTAEknScx
         PB+ZwrN3tZbaPkkZyFM/D0Tztx80m4H3voSL9/TCpH25nOvjdpLQLhxGNAaN9Nyf2Bo2
         v6UD9yHRKm6co+2sE2AdM7Mxm38pRq2VuSkhOfOUyfpbXbJ1o/pegM6oE6Mv1znJpsrS
         +vpBUok8+gLzkY6i75Y0+EumSubfbZea7LDfz+ItK8ypHlPxYsUzIWTq/IOs3Lfpzu1Z
         KcF7Z/VabCDdWcBZF7etHyYttO94BZAnHk+bnfSqRwKURXCYEyrLr4q9JOlL0G2SUzkQ
         f3Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776257504; x=1776862304;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yNVtghdFDqTr06npTeuHS9vtArWDTpcLIvYINogqhXM=;
        b=H6xnEAJXpWsWohIEU377Sh+72wny6vIY8qK2soQ6Ov5HvrUpjFJ7Ph/K0Co3aNbBIC
         YawWED6F8WYENkUFHthUmBDFtePAOPyx23UXPG4JcQoaMfYqMkh/kph0eRPgt9CQe8EC
         oRLtwAvqMlhqZqNm33BTrON79pYF6gc0LtyiV+yFZ+cG6P5kSEOUrDHBtDooQkKCrub4
         fTazFI5iI4Kj6jqLdGxdMtJl+84IFIn5nH1KexgDV0zXSQ2EefVsnhAktivJH36AdTfJ
         o3CgrhQ2ljh2iWWFyOU6MZKMmFPKuQHQtu12BMmyQUk95D1L3dVZjjRb2omYPQYof9RK
         76bA==
X-Forwarded-Encrypted: i=1; AFNElJ9UT+GQbWwu0AbxUIyc3giUZcXDv/sjWN5Np+2SDWSvcA7syvgSbulqZdpOGOVcLWR0HC8vUO8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4n0FurpObi0X98IG/Dyoaue4/pP5CWzTI4z24zMf7BZRLUiGU
	FAwKduKPcuP0GO55sAkfYY757FQYdzMtI2V+RL3QnXtoMhAxT0WMOTvX
X-Gm-Gg: AeBDievhc6eZolJGyFcSpVGuiMeIq6+Y7f1b9DFCaM/k2u3GPetzbpDTCURgqwfaJJI
	DeeuUi9fw7asf06fCTW/ml4B9vHZma/eFj+GJh95ClDZGUQtqUJ9bjtkm9wV7Tk2PRZofiyuI1h
	fMhnHht/JSj7zW+IKi4Rl3eb5kBO6rIQUWmjsRMWq0Ca3SNk9Hmh/A1mRvnDc/qHe6eFEiFFZ9l
	ozYLKRZebpUcJ65R4xDyyru7ZC4Y+aH6AVxiXIApYUcu2IVWuGx7CtXJ1n19BEp5+O5Xm1lqT7C
	dFHofhdtwPbNtFUKziz2KVnyTr+z0Qe086XP+5c9b6QBppr78NRF08i9/z3dD8RdIxjPTJBlrdt
	r/K6iEyAccmsCKA5fzA0tJ+VYKk657GqnZ75wBWE6xh+ErznYe0LrE8x8NxYwnmekd2MpmIVCZQ
	Cuekl4STRng+9Vu+U2j1EeRT1g9zV+b2A659QhlSmUJfZ3l5GwyvRF9HPFI4OOGaOJC9gOVDHr/
	XVs7Q4zhA==
X-Received: by 2002:a05:7300:7249:b0:2d9:89c8:8893 with SMTP id 5a478bee46e88-2d989c8be4bmr6380645eec.3.1776257503732;
        Wed, 15 Apr 2026 05:51:43 -0700 (PDT)
Received: from 6cb30d4270db.tailc0aff1.ts.net ([206.206.192.132])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2de8c90cd7esm3012690eec.13.2026.04.15.05.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 05:51:42 -0700 (PDT)
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
	Alex Wang <alexw@nicira.com>,
	Thomas Graf <tgraf@redhat.com>,
	netdev@vger.kernel.org,
	dev@openvswitch.org,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>
Subject: [PATCH net v4] openvswitch: cap upcall PID array size and pre-size vport replies
Date: Wed, 15 Apr 2026 05:51:22 -0700
Message-ID: <20260415125121.110874-2-bestswngs@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,nicira.com,redhat.com,vger.kernel.org,openvswitch.org,asu.edu,gmail.com];
	TAGGED_FROM(0.00)[bounces-278765-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bestswngs@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,asu.edu:email]
X-Rspamd-Queue-Id: 5A69E404838
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
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
v4 (per Ilya):
- Use nr_cpu_ids instead of num_possible_cpus() for consistency with
  the per-CPU dispatch on the datapath side.
- Annotate ovs_vport_cmd_msg_size() per-attribute; split nested sums.
v3: Cap at num_possible_cpus(); add ovs_vport_cmd_msg_size(); keep
    BUG_ON(); fix Fixes tag.
v2: Dynamically size reply skb; drop WARN_ON_ONCE, return plain errors.
---
 net/openvswitch/datapath.c | 33 +++++++++++++++++++++++++++++++--
 net/openvswitch/vport.c    |  3 +++
 2 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
index e209099218b4..35e67e51b0d2 100644
--- a/net/openvswitch/datapath.c
+++ b/net/openvswitch/datapath.c
@@ -2184,9 +2184,38 @@ static int ovs_vport_cmd_fill_info(struct vport *vport, struct sk_buff *skb,
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
+	/* OVS_VPORT_ATTR_STATS */
+	msgsize += nla_total_size_64bit(sizeof(struct ovs_vport_stats));
+	/* OVS_VPORT_ATTR_UPCALL_STATS(OVS_VPORT_UPCALL_ATTR_SUCCESS +
+	 *                             OVS_VPORT_UPCALL_ATTR_FAIL)
+	 */
+	msgsize += nla_total_size(nla_total_size_64bit(sizeof(u64)) +
+				  nla_total_size_64bit(sizeof(u64)));
+	/* OVS_VPORT_ATTR_UPCALL_PID (capped at nr_cpu_ids by
+	 * ovs_vport_set_upcall_portids())
+	 */
+	msgsize += nla_total_size(nr_cpu_ids * sizeof(u32));
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
@@ -2196,7 +2225,7 @@ struct sk_buff *ovs_vport_cmd_build_info(struct vport *vport, struct net *net,
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


