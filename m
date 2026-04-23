Return-Path: <netdev+bounces-280576-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OLJNE+GE6WmMcAIAu9opvQ
	(envelope-from <netdev+bounces-280576-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 04:33:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A80DF44C4C0
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 04:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E2EF63038527
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 02:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 291663563F3;
	Thu, 23 Apr 2026 02:32:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9872D0606;
	Thu, 23 Apr 2026 02:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776911549; cv=none; b=uet9Mb7D9j8fR6TIuLsLI8pItggrpXEHh8U6bcTiQA0CLD1DOSk5bQIdFuky5+5Uzyuuwd8ls5GUaUOw++c38ziAibqVCOex3OIeWOc21ZoaAQHyj/KJyoLXKJxceigLiXTLsz1aE3FHMuXCWWqlQ2PoQLic+XiH5WtTcTjnUSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776911549; c=relaxed/simple;
	bh=gS0oSm5i99AbVs9CeLksrQR6AmvvSrWVodH8rL+XmK4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X7iDJCshV/ELAgsDe1ZQCrFf3ArxMjWrlGPLIY/zdOcX7e/sP1j1o8xQsvdr3TGdZqbdmgQRp7pjtmxAbNddIE6iMBKjEygWDnBQdQmPenjO7zxZ29zLajMvAi/H41zPnxG44Mipt3zHJd2kBaVKtSkFsvRvn6JcDVKfX+GFe18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: a76686aa3ebc11f1aa26b74ffac11d73-20260423
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:de99f394-8256-49d9-8148-8e206f356253,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:bcc851152b7c2d67186e3b2bab96aec4,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|850|898,TC:nil,Content:0|15|50
	,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,O
	SA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: a76686aa3ebc11f1aa26b74ffac11d73-20260423
X-User: lilinmao@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <lilinmao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 615437787; Thu, 23 Apr 2026 10:32:20 +0800
From: Linmao Li <lilinmao@kylinos.cn>
To: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	stephen@networkplumber.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Linmao Li <lilinmao@kylinos.cn>
Subject: [PATCH net v3] ipv6: addrconf: skip ERRDAD transition when address already DEAD
Date: Thu, 23 Apr 2026 10:32:16 +0800
Message-Id: <20260423023216.1221731-1-lilinmao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260421075033.1110816-1-lilinmao@kylinos.cn>
References: <20260421075033.1110816-1-lilinmao@kylinos.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280576-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[kylinos.cn];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[lilinmao@kylinos.cn,netdev@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kylinos.cn:mid,kylinos.cn:email]
X-Rspamd-Queue-Id: A80DF44C4C0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

addrconf_dad_failure() transitions ifp->state from DAD to POSTDAD
via addrconf_dad_end(), which drops ifp->lock on return.  The lock
is re-acquired after net_info_ratelimited().  A concurrent
ipv6_del_addr() can take the lock in that window, set ifp->state
to DEAD and run list_del_rcu(&ifp->if_list).

addrconf_dad_failure() then overwrites DEAD with ERRDAD at errdad:
and schedules a new dad_work.  The work calls ipv6_del_addr()
again, hitting the already-poisoned list entry:

  general protection fault: 0000 [#1] SMP NOPTI
  CPU: 4 PID: 217 Comm: kworker/4:1
  Workqueue: ipv6_addrconf addrconf_dad_work
  RIP: 0010:ipv6_del_addr+0xe9/0x280
  RAX: dead000000000122
  Call Trace:
   addrconf_dad_stop+0x113/0x140
   addrconf_dad_work+0x28c/0x430
   process_one_work+0x1eb/0x3b0
   worker_thread+0x4d/0x400
   kthread+0x104/0x140
   ret_from_fork+0x35/0x40

Fold the addrconf_dad_end() logic into addrconf_dad_failure()
under a single ifp->lock critical section.  The STABLE_PRIVACY
branch temporarily drops ifp->lock, so keep a state-is-DEAD
bail-out at errdad: for that remaining window.

Fixes: c15b1ccadb32 ("ipv6: move DAD and addrconf_verify processing to workqueue")
Signed-off-by: Linmao Li <lilinmao@kylinos.cn>
---
 net/ipv6/addrconf.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 5476b6536eb7..c9ea0d5042d0 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -2166,16 +2166,18 @@ void addrconf_dad_failure(struct sk_buff *skb, struct inet6_ifaddr *ifp)
 	struct net *net = dev_net(idev->dev);
 	int max_addresses;
 
-	if (addrconf_dad_end(ifp)) {
+	spin_lock_bh(&ifp->lock);
+
+	if (ifp->state != INET6_IFADDR_STATE_DAD) {
+		spin_unlock_bh(&ifp->lock);
 		in6_ifa_put(ifp);
 		return;
 	}
+	ifp->state = INET6_IFADDR_STATE_POSTDAD;
 
 	net_info_ratelimited("%s: IPv6 duplicate address %pI6c used by %pM detected!\n",
 			     ifp->idev->dev->name, &ifp->addr, eth_hdr(skb)->h_source);
 
-	spin_lock_bh(&ifp->lock);
-
 	if (ifp->flags & IFA_F_STABLE_PRIVACY) {
 		struct in6_addr new_addr;
 		struct inet6_ifaddr *ifp2;
@@ -2227,6 +2229,11 @@ void addrconf_dad_failure(struct sk_buff *skb, struct inet6_ifaddr *ifp)
 
 errdad:
 	/* transition from _POSTDAD to _ERRDAD */
+	if (ifp->state == INET6_IFADDR_STATE_DEAD) {
+		spin_unlock_bh(&ifp->lock);
+		in6_ifa_put(ifp);
+		return;
+	}
 	ifp->state = INET6_IFADDR_STATE_ERRDAD;
 	spin_unlock_bh(&ifp->lock);
 
-- 
2.25.1


