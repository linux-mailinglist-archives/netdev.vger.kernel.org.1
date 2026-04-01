Return-Path: <netdev+bounces-273981-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SGY6CHnVzGnnWwYAu9opvQ
	(envelope-from <netdev+bounces-273981-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 10:21:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BCEEA376AD0
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 10:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 13021306478D
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 08:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 511923A4F34;
	Wed,  1 Apr 2026 08:17:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D633E39A051
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 08:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775031476; cv=none; b=GC8ysPUeseLvvnJYaZnaZ1T21L+BXPTCORr+dGPxxzoOY0qku4Iedb9/VCXCV1Ac1+0w5rnc3b7ZZg3USV1DR2+md3UhzzYfu87jDQpE6ZQGUhgMEzzrcoDaeA/s/AlxGJ4GxOs3LUWkyK7VC+hs3WjRxt+r890klCl0IC78nzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775031476; c=relaxed/simple;
	bh=/e+KzszB1WIfLDMhl+3rQtcpIQ0czVnv9cCbiSVQtnM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fjQQby1w0HgwS9H4lmBomfEC/6BeDYLyqQVHG9VRKaglndx+JEdgWPAg9je5engb7aGXx/f3qoWq123MS2uDVLyuWq5RewC+z3wTMA51MOWFniD9aGl+Ju4nVKwYrDJw/4yrPPUDRQbyzj/d5FPApsa7g/z9PxuLuM/Cw7qI36g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 446064D1E6;
	Wed,  1 Apr 2026 08:17:53 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8644B4A0B0;
	Wed,  1 Apr 2026 08:17:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YE/OHbDUzGlmegAAD6G6ig
	(envelope-from <fmancera@suse.de>); Wed, 01 Apr 2026 08:17:52 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netdev@vger.kernel.org
Cc: idosch@nvidia.com,
	petrm@nvidia.com,
	horms@kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	kees@kernel.org,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	Yiming Qian <yimingqian591@gmail.com>
Subject: [PATCH 2/2 net v2] ipv4: nexthop: allocate skb dynamically in rtm_get_nexthop()
Date: Wed,  1 Apr 2026 10:17:41 +0200
Message-ID: <20260401081741.4273-2-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260401081741.4273-1-fmancera@suse.de>
References: <20260401081741.4273-1-fmancera@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Spamd-Result: default: False [0.14 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[suse.de : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[nvidia.com,kernel.org,redhat.com,google.com,davemloft.net,suse.de,gmail.com];
	TAGGED_FROM(0.00)[bounces-273981-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.351];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,suse.de:email,suse.de:mid]
X-Rspamd-Queue-Id: BCEEA376AD0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When querying a nexthop object via RTM_GETNEXTHOP, the kernel currently
allocates a fixed-size skb using NLMSG_GOODSIZE. While sufficient for
single nexthops and small Equal-Cost Multi-Path groups, this fixed
allocation fails for large nexthop groups like 512 nexthops.

This results in the following warning splat:

 WARNING: net/ipv4/nexthop.c:3395 at rtm_get_nexthop+0x176/0x1c0, CPU#20: rep/4608
 [...]
 RIP: 0010:rtm_get_nexthop (net/ipv4/nexthop.c:3395)
 [...]
 Call Trace:
  <TASK>
  rtnetlink_rcv_msg (net/core/rtnetlink.c:6989)
  netlink_rcv_skb (net/netlink/af_netlink.c:2550)
  netlink_unicast (net/netlink/af_netlink.c:1319 net/netlink/af_netlink.c:1344)
  netlink_sendmsg (net/netlink/af_netlink.c:1894)
  ____sys_sendmsg (net/socket.c:721 net/socket.c:736 net/socket.c:2585)
  ___sys_sendmsg (net/socket.c:2641)
  __sys_sendmsg (net/socket.c:2671)
  do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:94)
  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
  </TASK>

Fix this by allocating the size dynamically using nh_nlmsg_size() and
using nlmsg_new(), this is consistent with nexthop_notify() behavior. In
addition, adjust nh_nlmsg_size_grp() so it calculates the size needed
based on flags passed.

This cannot be reproduced via iproute2 as the group size is currently
limited and the command fails as follows:

addattr_l ERROR: message exceeded bound of 1048

Fixes: 430a049190de ("nexthop: Add support for nexthop groups")
Reported-by: Yiming Qian <yimingqian591@gmail.com>
Closes: https://lore.kernel.org/netdev/CAL_bE8Li2h4KO+AQFXW4S6Yb_u5X4oSKnkywW+LPFjuErhqELA@mail.gmail.com/
Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
---
v2: adjust nh_nlmsg_size_grp() to handle size for stats and add symbols
to the trace in commit message
---
 net/ipv4/nexthop.c | 35 +++++++++++++++++++++++++----------
 1 file changed, 25 insertions(+), 10 deletions(-)

diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
index a0c694583299..9abbf3989f23 100644
--- a/net/ipv4/nexthop.c
+++ b/net/ipv4/nexthop.c
@@ -1003,7 +1003,7 @@ static size_t nh_nlmsg_size_grp_res(struct nh_group *nhg)
 		nla_total_size_64bit(8);/* NHA_RES_GROUP_UNBALANCED_TIME */
 }
 
-static size_t nh_nlmsg_size_grp(struct nexthop *nh)
+static size_t nh_nlmsg_size_grp(struct nexthop *nh, u32 op_flags)
 {
 	struct nh_group *nhg = rtnl_dereference(nh->nh_grp);
 	size_t sz = sizeof(struct nexthop_grp) * nhg->num_nh;
@@ -1013,6 +1013,21 @@ static size_t nh_nlmsg_size_grp(struct nexthop *nh)
 	if (nhg->resilient)
 		tot += nh_nlmsg_size_grp_res(nhg);
 
+	if (op_flags & NHA_OP_FLAG_DUMP_STATS) {
+		tot += nla_total_size(0) +	  /* NHA_GROUP_STATS */
+		       nla_total_size(4);	  /* NHA_HW_STATS_ENABLE */
+		tot += nhg->num_nh *
+		       (nla_total_size(0) +	  /* NHA_GROUP_STATS_ENTRY */
+			nla_total_size(4) +	  /* NHA_GROUP_STATS_ENTRY_ID */
+			nla_total_size_64bit(8)); /* NHA_GROUP_STATS_ENTRY_PACKETS */
+
+		if (op_flags & NHA_OP_FLAG_DUMP_HW_STATS) {
+			tot += nhg->num_nh *
+			       nla_total_size_64bit(8); /* NHA_GROUP_STATS_ENTRY_PACKETS_HW */
+			tot += nla_total_size(4);	/* NHA_HW_STATS_USED */
+		}
+	}
+
 	return tot;
 }
 
@@ -1047,14 +1062,14 @@ static size_t nh_nlmsg_size_single(struct nexthop *nh)
 	return sz;
 }
 
-static size_t nh_nlmsg_size(struct nexthop *nh)
+static size_t nh_nlmsg_size(struct nexthop *nh, u32 op_flags)
 {
 	size_t sz = NLMSG_ALIGN(sizeof(struct nhmsg));
 
 	sz += nla_total_size(4); /* NHA_ID */
 
 	if (nh->is_group)
-		sz += nh_nlmsg_size_grp(nh) +
+		sz += nh_nlmsg_size_grp(nh, op_flags) +
 		      nla_total_size(4) +	/* NHA_OP_FLAGS */
 		      0;
 	else
@@ -1070,7 +1085,7 @@ static void nexthop_notify(int event, struct nexthop *nh, struct nl_info *info)
 	struct sk_buff *skb;
 	int err = -ENOBUFS;
 
-	skb = nlmsg_new(nh_nlmsg_size(nh), gfp_any());
+	skb = nlmsg_new(nh_nlmsg_size(nh, 0), gfp_any());
 	if (!skb)
 		goto errout;
 
@@ -3376,15 +3391,15 @@ static int rtm_get_nexthop(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 	if (err)
 		return err;
 
-	err = -ENOBUFS;
-	skb = alloc_skb(NLMSG_GOODSIZE, GFP_KERNEL);
-	if (!skb)
-		goto out;
-
 	err = -ENOENT;
 	nh = nexthop_find_by_id(net, id);
 	if (!nh)
-		goto errout_free;
+		goto out;
+
+	err = -ENOBUFS;
+	skb = nlmsg_new(nh_nlmsg_size(nh, op_flags), GFP_KERNEL);
+	if (!skb)
+		goto out;
 
 	err = nh_fill_node(skb, nh, RTM_NEWNEXTHOP, NETLINK_CB(in_skb).portid,
 			   nlh->nlmsg_seq, 0, op_flags);
-- 
2.53.0


