Return-Path: <netdev+bounces-289911-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yEGgGXajDWq10QUAu9opvQ
	(envelope-from <netdev+bounces-289911-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 14:05:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF6F058D3CF
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 14:05:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 81697322238D
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 11:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 255A6371063;
	Wed, 20 May 2026 11:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="opjUvsFn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1467365A13
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 11:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779277334; cv=none; b=pW/OGK5cJnlk3lt7jeXjrH1NnNP8xqLVUwZg3Rhe+nqH+i7ltVWOn9zthL42wv7vA3DDoXjjNWU16zByGF7h+J2LMyG4zx6dLhRUF7fVTdrZYELxoWnniNcpkM0tpqXsNS6j0QcE7j/VZLMhC73XFb46GFkKpH/+x1JeLb+dFVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779277334; c=relaxed/simple;
	bh=HyCy4WILmkBZi+hq1dJB6rltF17bSvnmXqDPoaFf+is=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ib7hhlAq/qJTKLvPiGq9FfG2h7Lby3CwjlhQADRffZfM6cYsAaVs42mw918dSNeqFuCpxP5wsfNOjLam4RNhMULW6VjsE4Y++oD7wPstFxPSq4ajLRf1kAg72fFHBICXGKef8VvHDdZd0yPX43i2DvJo8HjjZLZbmoWj/PHHy1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=opjUvsFn; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-50d9a6a853bso135234851cf.0
        for <netdev@vger.kernel.org>; Wed, 20 May 2026 04:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779277331; x=1779882131; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Wlle5DMc7ZBUDRnaeyWXWTc704a1wfEb/CL8LcRxd60=;
        b=opjUvsFnXByWmRabhIVTzzaKQ2Yc5qNy0iMj00xznbnIF2gMHWTYoV59Uppr7eMMpP
         sB3SWC0SEobmxh3WbSTSUZSxxw1ml6HbN1Our5GS61LORpEvqnkeEAjJW4k9jEZgIfW7
         UAQW20VdpoNiNVIiHWQ65sLUxfbaNiFR3VqZcYJXAHMdKCFPkomqYrkx+xK4dgpQTr95
         ZnR+KLgOLF/eGGC1UI8O32JQUaF3GixZ4FwRSBqTfOG9l5lcVdTh0KxsSCiNRuRbr981
         pSYkga0pCA7XRtGT9O2v5rOMrrp3kfwvV5t24TxD/4N4K65KsugiZRi1+XTDNYt2yqWl
         Z50A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779277331; x=1779882131;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wlle5DMc7ZBUDRnaeyWXWTc704a1wfEb/CL8LcRxd60=;
        b=JxX24e+qzIak+EahPNjgf3quDlr6T4jGeemNwHvKw6wqKE2HTpzFVJ9LwcDBRsDUQk
         zE2yUqJYaDHrqYApZlLiVe9dPFuQoVGYReRGMMnLqzirt1F2WuARo4MGy5xsn9StVrxN
         dbZtOiCSV3xoA7K5/WA4DvbeASqXd1z/Mjxwb5glews4l90UWxEZa999nX73pmuEdgdq
         Aq8forAQs0gYaHl6R68iUA1Oio08ur+oJ6z2m279J49Jnguj9Bae66iRLCUocyHxWoDx
         Qb/idcf5ztaSmmDC8PAt64Va8mePicUJ7qaqhPcSpyEE8QZihO2UJjLoPYm5yLL1fpWT
         avMA==
X-Forwarded-Encrypted: i=1; AFNElJ/6bbkdPdmAaDyqooKuijBvTjv8Ax2ky+Ovl/gPJg1KzHl7+qgKWz+CYrCNIQ+rBIL1LHhMK5Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzI8PFzPKYsFwkCPkkJgwjQtpXIBOpUXaeotTLKmeRXWtDXTd1q
	bBPHosf0wPmiwyJfaJIYWZcpnk1wdFtKffEUrJWCX9UAO3Wy84M9JBMf9Pf32FPmMBdWfL29ZzW
	layTTeomXTE0bUg==
X-Received: from qtpi13.prod.google.com ([2002:ac8:71cd:0:b0:50d:75d9:61aa])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:6bcd:b0:50f:c36a:381a with SMTP id d75a77b69052e-5165a26a99emr253069561cf.55.1779277331174;
 Wed, 20 May 2026 04:42:11 -0700 (PDT)
Date: Wed, 20 May 2026 11:42:07 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.631.ge1b05301d1-goog
Message-ID: <20260520114207.1394241-1-edumazet@google.com>
Subject: [PATCH v2 net] net: bridge: prevent too big nested attributes in br_fill_linkxstats()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot+a35f9259d08f907c06e6@syzkaller.appspotmail.com, 
	Nikolay Aleksandrov <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,google.com,syzkaller.appspotmail.com,blackwall.org,nvidia.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289911-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,a35f9259d08f907c06e6];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,blackwall.org:email,appspotmail.com:email,nvidia.com:email]
X-Rspamd-Queue-Id: BF6F058D3CF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

After commit ff205bf8c554 ("netlink: add one debug check in nla_nest_end()")
syzbot found that br_fill_linkxstats() can send corrupted netlink packets.

Make sure the nested attribute size is bounded.

Fixes: a60c090361ea ("bridge: netlink: export per-vlan stats")
Reported-by: syzbot+a35f9259d08f907c06e6@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/6a0b0da3.050a0220.175f0c.0000.GAE@google.com/
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
Cc: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Ido Schimmel <idosch@nvidia.com>
---
v2: remove the WARN_ON(err == -EMSGSIZE) in rtnl_stats_get() (Ido)
    adjust limit (Ido)
v1: https://lore.kernel.org/netdev/20260518130531.1015332-1-edumazet@google.com/

 net/bridge/br_netlink.c | 10 ++++++++++
 net/core/rtnetlink.c    |  5 +++--
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index 6fd5386a1d646542c184702e13cc2e6c8ee1820d..c04a4d0889ae412a9fc3e2458faa41200f26b098 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -1824,6 +1824,7 @@ static int br_fill_linkxstats(struct sk_buff *skb,
 			      const struct net_device *dev,
 			      int *prividx, int attr)
 {
+	unsigned int limit = U16_MAX - nla_total_size(0);
 	struct nlattr *nla __maybe_unused;
 	struct net_bridge_port *p = NULL;
 	struct net_bridge_vlan_group *vg;
@@ -1841,6 +1842,7 @@ static int br_fill_linkxstats(struct sk_buff *skb,
 		p = br_port_get_rtnl(dev);
 		if (!p)
 			return 0;
+		limit -= nla_total_size_64bit(sizeof(p->stp_xstats));
 		br = p->br;
 		vg = nbp_vlan_group(p);
 		break;
@@ -1855,6 +1857,9 @@ static int br_fill_linkxstats(struct sk_buff *skb,
 	if (vg) {
 		u16 pvid;
 
+#ifdef CONFIG_BRIDGE_IGMP_SNOOPING
+		limit -= nla_total_size_64bit(sizeof(struct br_mcast_stats));
+#endif
 		pvid = br_get_pvid(vg);
 		list_for_each_entry(v, &vg->vlan_list, vlist) {
 			struct bridge_vlan_xstats vxi;
@@ -1862,6 +1867,11 @@ static int br_fill_linkxstats(struct sk_buff *skb,
 
 			if (++vl_idx < *prividx)
 				continue;
+
+			if (skb_tail_pointer(skb) - (unsigned char *)nest +
+			    nla_total_size(sizeof(vxi)) >= limit)
+				goto nla_put_failure;
+
 			memset(&vxi, 0, sizeof(vxi));
 			vxi.vid = v->vid;
 			vxi.flags = v->flags;
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index df042da422ef3137ed67efaf8d243cc6b1fec6c7..511c25bf6f2a25563b7dd8d618fb46c9297d2ed7 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -6328,8 +6328,9 @@ static int rtnl_stats_get(struct sk_buff *skb, struct nlmsghdr *nlh,
 				  NETLINK_CB(skb).portid, nlh->nlmsg_seq, 0,
 				  0, &filters, &idxattr, &prividx, extack);
 	if (err < 0) {
-		/* -EMSGSIZE implies BUG in if_nlmsg_stats_size */
-		WARN_ON(err == -EMSGSIZE);
+		/* -EMSGSIZE implies BUG in if_nlmsg_stats_size
+		 * or a too big nested attribute.
+		 */
 		kfree_skb(nskb);
 	} else {
 		err = rtnl_unicast(nskb, net, NETLINK_CB(skb).portid);
-- 
2.54.0.631.ge1b05301d1-goog


