Return-Path: <netdev+bounces-306383-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vWkNF4wSUGqYswIAu9opvQ
	(envelope-from <netdev+bounces-306383-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 23:28:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F335735D03
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 23:28:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=JOB9dDaC;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306383-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-306383-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3DAF5300B8C4
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 21:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BF723BB13B;
	Thu,  9 Jul 2026 21:28:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9D03BB106
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 21:28:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783632518; cv=none; b=L0wWtPHxaLL4aPXUOIgTaafULBFzxsWeRK+xYY1U9FKbyAMk7Fj++MuEld9FOSpYmj0yOldJ/9G078llXF8MzGaPJCpIzbq/5xFIV5Icr24cH3MvZaj34Cw91L+rw6X/4s9bA8gPM5uEojCBOPrDp27JI8kOE1/7Z1+45ogn5a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783632518; c=relaxed/simple;
	bh=RfK4Rc+82FAtWUKvR0czhUym4lsT1kXkCb6HVu1HCxI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lhhyw70oWKqOOzGrOpKvQuNUK4hA3Fgy1NrWSos+gtmmbqAgOPYg4guftqAfLOspzcKzPyuo79buAzVs3nRNSDJKpe8m/26DJdXNNy+UU+/9kH1wkvL+I2Su5Vu6hNjlGitf4CuSqqVYIW3rQdO41fzFejllXvSlbMIf8rueUCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JOB9dDaC; arc=none smtp.client-ip=209.85.160.178
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-51a868b6962so2159291cf.2
        for <netdev@vger.kernel.org>; Thu, 09 Jul 2026 14:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783632515; x=1784237315; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UGPBGDpmMCJG1jdmjxc2zGCbnDM99IZvLsk38bHA9OQ=;
        b=JOB9dDaCekjMUQcPq9Nzb26Xu6j+ZCsuJVfhuuSUF6Yc6UcmtQfw3gB9iXwFc+9DVE
         YkpwNlZy6B5BevvyGGyO8sCnE9C0yEVcBfpOAwegeAnOlUXW7e71EhE2vX8taReWdMWH
         dmDxe/XMQRNtme0hH7WU2/CVid7eI8r7gny7cWx2WGUVLlNx0P+lpS6tb4Mmy2TyOMJ/
         ghy8QvaxCq5xWAamj9H3jrkaSj86Ya2tV1vKe1z8c6XjXcArFv0CWv5e7OFiflhVWvgB
         8Zfbl4VefWCARFzkJQQPhTvcJJgMd01whC82f6NGK0zuH/28RTymvLHbtgsZu/xp60sd
         M/cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783632515; x=1784237315;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UGPBGDpmMCJG1jdmjxc2zGCbnDM99IZvLsk38bHA9OQ=;
        b=l5npvqGd0qgSEgyWdYfNJAU6S65iDRlHKggH8QMdZSZ2vCGWUFK3SzP1TRh3mcdPab
         RD/WdDx79FUcGq751dPOfQm/ZWq2GC4gBnpujM7affnOK5s0r72StcrNDX70BzTZa7tS
         aq9WXU9ji54PD+bWyFI3O/ICsMHsGPzjtP73RiUXxXxiF1PAPDgcmUtUjMvVIFC6QzDr
         wEMmrXsGBbXk4+bmHhgmZB2mhH9fAe/ow1iGQ30rzsJy1Ynn6wdHhn39vsnZG7oOE19l
         /gpOUGJOUS5kaW/PB4KPljcqWy/XVj9XPcXcHYUSk49MX6MzDqQDxDRFKKFG4vfvuQ0M
         c3Wg==
X-Gm-Message-State: AOJu0YyUK3EGzUeCg5viXILMYgD4UYHObY/mnMt7Lw7MQYJ6hW5nlua6
	8ST9O5xupFCc9a+G2wE8V3XhQZjahE68XnQPQTnqHWERso1Kp88QaiGADgK1mw==
X-Gm-Gg: AfdE7cmsjPTzAk1eZELMrnHqrbQkMPvyB265YX/MKf0tLI5hQIPuuOhMWhBy4QTVybd
	MeXAThE4MqzOyM/+zXhsS2szrQ3FZNRyYFwzHvCe6BGLBtNpVSbLRgCxnbZOPCg879HTx5/Ff7D
	UYdhklz1i7SgJB0N771+QGOjEmJB8tP8Wa0YqRJw2Hc+lZdWU4ULEk8eYTeOA6WMWyNHkZsTGnu
	0uJY7GuKLIIfKl4j75yRLz2tUqTs9r/QLX+Iva8Hg/gLem/ODzlLDNp1rGLEuM/TX/q6t7E2AB4
	Bk+OTrIBKrPYs8cPlTRRkx0hWcMM3nnncv3FFwRM0PDruI189Cn4WOAZZ+NRg5Pk9kpOKha6Ncx
	hYkhjsGDxO9OhJweqwBm1yFKlF2eLyuWSCteAoLI6m0rrSUEKNYZ0pWNH+oVwgBSuFXx86Cm33I
	cROgwCSSpshu2ZwPxUwfmksLo7lZqkTTWcwNuZWTL7MVaJ1T1qVTxkZ8hiYcXuRdhXy4OZT9OJr
	vFAgIcQGFNuaS1WsdUDX0L72+tQpopPqqwyIC+osJvIwrGe4oF+v38Wujqkh5dQRw==
X-Received: by 2002:ac8:5e51:0:b0:516:e10f:7140 with SMTP id d75a77b69052e-51c8b3f9775mr89854991cf.35.1783632515371;
        Thu, 09 Jul 2026 14:28:35 -0700 (PDT)
Received: from wsfd-netdev58.anl.eng.rdu2.dc.redhat.com ([66.187.232.140])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51caae206b6sm3237861cf.14.2026.07.09.14.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 14:28:34 -0700 (PDT)
From: Xin Long <lucien.xin@gmail.com>
To: network dev <netdev@vger.kernel.org>,
	linux-sctp@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Subject: [PATCH net-next] sctp: replace cb->args[4] with a local variable in sctp_diag_dump()
Date: Thu,  9 Jul 2026 17:28:33 -0400
Message-ID: <e0076ec046fbd8a70d4f3facfb701473d08c3ebb.1783632513.git.lucien.xin@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,google.com,redhat.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-306383-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:linux-sctp@vger.kernel.org,m:davem@davemloft.net,m:kuba@kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:marcelo.leitner@gmail.com,m:marceloleitner@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[lucienxin@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucienxin@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3F335735D03

cb->args[4] is currently used as a temporary counter to track the assoc
index while traversing ep->asocs in sctp_sock_dump(). However, this
state is only needed locally within a single dump iteration and does not
need to be preserved across callbacks.

Replace cb->args[4] with a local idx variable in sctp_sock_dump(), and
update cb->args[1] directly when the dump is interrupted due to skb
space exhaustion.

This simplifies the dump state handling and removes the dependency on an
extra cb->args[] slot, making the traversal logic easier to follow.

Signed-off-by: Xin Long <lucien.xin@gmail.com>
---
 net/sctp/diag.c | 45 ++++++++++++++++++++++-----------------------
 1 file changed, 22 insertions(+), 23 deletions(-)

diff --git a/net/sctp/diag.c b/net/sctp/diag.c
index c2a0de2adf6f..a9bb31303613 100644
--- a/net/sctp/diag.c
+++ b/net/sctp/diag.c
@@ -299,18 +299,21 @@ static int sctp_sock_dump_one(struct sctp_endpoint *ep, struct sctp_transport *t
 static int sctp_sock_dump(struct sctp_endpoint *ep, struct sctp_transport *tsp, void *p)
 {
 	struct sctp_comm_param *commp = p;
-	struct sock *sk = ep->base.sk;
+	struct sock *sk = ep->base.sk, *nsk;
 	struct sk_buff *skb = commp->skb;
 	struct netlink_callback *cb = commp->cb;
 	const struct inet_diag_req_v2 *r = commp->r;
+	u32 portid = NETLINK_CB(cb->skb).portid;
 	struct sctp_association *assoc;
-	int err = 0;
+	int err = 0, idx = 0;
+
+	nsk = NETLINK_CB(cb->skb).sk;
 
 	lock_sock(sk);
 	if (ep != tsp->asoc->ep)
 		goto release;
 	list_for_each_entry(assoc, &ep->asocs, asocs) {
-		if (cb->args[4] < cb->args[1])
+		if (idx < cb->args[1])
 			goto next;
 
 		if (r->id.idiag_sport != htons(assoc->base.bind_addr.port) &&
@@ -320,32 +323,31 @@ static int sctp_sock_dump(struct sctp_endpoint *ep, struct sctp_transport *tsp,
 		    r->id.idiag_dport)
 			goto next;
 
-		if (!cb->args[3] &&
-		    inet_sctp_diag_fill(sk, NULL, skb, r,
-					sk_user_ns(NETLINK_CB(cb->skb).sk),
-					NETLINK_CB(cb->skb).portid,
-					cb->nlh->nlmsg_seq,
-					NLM_F_MULTI, cb->nlh,
-					commp->net_admin) < 0) {
-			err = 1;
-			goto release;
+		if (!cb->args[3]) {
+			err = inet_sctp_diag_fill(sk, NULL, skb, r,
+						  sk_user_ns(nsk), portid,
+						  cb->nlh->nlmsg_seq,
+						  NLM_F_MULTI, cb->nlh,
+						  commp->net_admin);
+			if (err < 0) {
+				cb->args[1] = idx;
+				goto release;
+			}
 		}
 		cb->args[3] = 1;
 
-		if (inet_sctp_diag_fill(sk, assoc, skb, r,
-					sk_user_ns(NETLINK_CB(cb->skb).sk),
-					NETLINK_CB(cb->skb).portid,
-					cb->nlh->nlmsg_seq, 0, cb->nlh,
-					commp->net_admin) < 0) {
-			err = 1;
+		err = inet_sctp_diag_fill(sk, assoc, skb, r, sk_user_ns(nsk),
+					  portid, cb->nlh->nlmsg_seq, 0,
+					  cb->nlh, commp->net_admin);
+		if (err < 0) {
+			cb->args[1] = idx;
 			goto release;
 		}
 next:
-		cb->args[4]++;
+		idx++;
 	}
 	cb->args[1] = 0;
 	cb->args[3] = 0;
-	cb->args[4] = 0;
 release:
 	release_sock(sk);
 	return err;
@@ -505,14 +507,11 @@ static void sctp_diag_dump(struct sk_buff *skb, struct netlink_callback *cb,
 	 * 1 : to record the assoc pos of this time's traversal
 	 * 2 : to record the transport pos of this time's traversal
 	 * 3 : to mark if we have dumped the ep info of the current asoc
-	 * 4 : to track position within ep->asocs list in sctp_sock_dump()
 	 */
 	pos = cb->args[2];
 	sctp_transport_traverse_process(sctp_sock_filter, sctp_sock_dump,
 					net, &pos, &commp);
 	cb->args[2] = pos;
-	cb->args[1] = cb->args[4];
-	cb->args[4] = 0;
 }
 
 static const struct inet_diag_handler sctp_diag_handler = {
-- 
2.47.1


