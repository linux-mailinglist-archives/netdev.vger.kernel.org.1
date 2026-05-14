Return-Path: <netdev+bounces-287796-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IImlEOE9BWqmTgIAu9opvQ
	(envelope-from <netdev+bounces-287796-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 05:13:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A2C53D444
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 05:13:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7DE0530136DD
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 03:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7716730EF89;
	Thu, 14 May 2026 03:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IW8cOtjK"
X-Original-To: netdev@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E082D739C
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 03:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778728411; cv=none; b=a2tzAD/qa/v0eoqueUprfBUXPXmDj4dXc0xOUgB2duFqGBabcssCoCTeha6kV+sVj0WnPcTEzyYrTYf2vRQhv6mDWaXVBLRy/C8Qw5J84f/tOB05hY7HAZ9mCZYy49MNbwMeTl0M0LaaijAJiQDdq84ClJYR8ozBs3zbWjo3hXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778728411; c=relaxed/simple;
	bh=3kA1//bSmca2SJWAa5Qg+GOJr3UYVjDN4Wd3DT1Npeo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mm4WbV+OsQUJdOU0STNok6803lJyDwWdK5G7j0S0qlpCK74RTnUJ+PtH2MgL8waCBGVQ2u+Pje7WhqUyuj644kyq5RJ9pWTNOs2hjdNeAafOXKHY5Z14nPYpUHET+5PFUi0v9L2gjEPcqHxxLcvVf7KxoYdSg/qCAoRm+gzJU+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IW8cOtjK; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778728397;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=eBWc/0cRFXWioL6sZo4GRULHpWdy/0kLs7KYIAgjR+s=;
	b=IW8cOtjKj8KNXcgar/MvorT09sRCR9/MSDKDp8bKowHoq4GblzYzUpb7djfVOwjSoCBOaU
	FXhjY5FaeyAbinr1OxIsEkPoUxSxd4ltS49rB697dYQTZG0LY8is5eHEAAYkCs6L9vGoWb
	e2D/1WV2I5KDnKYCz6aZwWEjSUSoFLs=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: netdev@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	syzbot+9744ccaabe337c6fb123@syzkaller.appspotmail.com,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Victor Nogueira <victor@mojatatu.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net/sched: re-enable queue reset on root qdisc graft
Date: Thu, 14 May 2026 11:12:41 +0800
Message-ID: <20260514031242.2667-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 27A2C53D444
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-287796-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,9744ccaabe337c6fb123];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,linux.dev:mid,linux.dev:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Commit 47e8dbb6e763 ("net/sched: do not reset queues in graft
operations") changed dev_deactivate() in qdisc_graft() from
reset_needed=true to false. This was the right call for graft paths
where the new qdisc has an ->attach op (mq): the new root
takes over per-tx-queue state via attach, and a blanket reset would
needlessly drop packets in unrelated leaves on every graft.

For the path where the new qdisc has no ->attach (e.g. HTB, sfq
as root, or qdisc_graft() called for deletion with new == NULL), the
old root subtree is going to be torn down anyway: every leaf will be
freed shortly via __qdisc_destroy(). Skipping the early reset there
provides no benefit, but it leaves leaf qdiscs with their queues
intact during the window between rcu_assign_pointer(dev->qdisc, new)
and the per-leaf sfq_destroy()/timer_delete_sync(). If a leaf has a
self-armed timer that walks the parent chain (sfq_perturbation ->
sfq_rehash -> qdisc_tree_reduce_backlog), the timer can fire after the
old root has been swapped out, find dev->qdisc no longer matching,
and trigger WARN_ON_ONCE(parentid != TC_H_ROOT).

Reported-by: syzbot+9744ccaabe337c6fb123@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/6a0175e0.a00a0220.1c3806.0016.GAE@google.com/T/
Fixes: 47e8dbb6e763 ("net/sched: do not reset queues in graft operations")
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 net/sched/sch_api.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index 6f7847c5536f..932cd1144b2b 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -1097,6 +1097,7 @@ static int qdisc_graft(struct net_device *dev, struct Qdisc *parent,
 	struct net *net = dev_net(dev);
 
 	if (parent == NULL) {
+		bool need_skip = false;
 		unsigned int i, num_q, ingress;
 		struct netdev_queue *dev_queue;
 
@@ -1123,12 +1124,15 @@ static int qdisc_graft(struct net_device *dev, struct Qdisc *parent,
 			}
 		}
 
+		if (new && new->ops->attach && !ingress)
+			need_skip = true;
+
 		if (dev->flags & IFF_UP)
-			dev_deactivate(dev, false);
+			dev_deactivate(dev, !need_skip);
 
 		qdisc_offload_graft_root(dev, new, old, extack);
 
-		if (new && new->ops->attach && !ingress)
+		if (need_skip)
 			goto skip;
 
 		if (!ingress) {
-- 
2.43.0


