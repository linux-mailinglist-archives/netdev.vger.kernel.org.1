Return-Path: <netdev+bounces-306283-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ziPzAKG0T2ounAIAu9opvQ
	(envelope-from <netdev+bounces-306283-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 16:48:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BEA273272E
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 16:48:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=QgUA++cw;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306283-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306283-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 93300300DED8
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 14:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 664E5382379;
	Thu,  9 Jul 2026 14:47:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7D43822AB
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 14:47:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783608452; cv=none; b=MkJs3yv7rLIOvpgt/cLIQuWjakYSGYloTnSC4dHK8QbdBD0YCeRtSSvBL81VGyTiprU7e38QH38NKZTKJEFvvcOw7xHazErYm8ezGh+Ou80Jztn0QfK4OdTGm6GvC3yj+lxaUeCWOlLVPhRXwnzZpGXHyju+kHZ2qVu/NHXuf+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783608452; c=relaxed/simple;
	bh=oB2JJkbrOZkT+N27iXIwCK+Q5Z6H387Wts64+spzjys=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fPRExnDaD5E5pspw5q5JYavcabPc18oPOaAR0goeFkKGt3RKbZJpoyUohMANYwMCy+N9swtIgo1wIQdSrCYCO7sFtq8+xAptzNvRynTcLEVU4jHIKXsCY/D1unnj34CLOZdJQdd2KuGee1tNgyEkDB+LorhgPDN+WfxmgvTPNcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QgUA++cw; arc=none smtp.client-ip=209.85.215.174
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-ca957432c7fso170847a12.1
        for <netdev@vger.kernel.org>; Thu, 09 Jul 2026 07:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783608450; x=1784213250; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RW6vSA6mnZK5Lr/pJZ9dP1N7NRFIaPvsAxSMgjYokLM=;
        b=QgUA++cwjW+klElTjUOzD/j35hOBhGUYyM8rgW3jrR3bsc/2QtNvvafv6dA2TB6kIZ
         VzwPGi3ibivLHqt/nRFnIsdbj6ZShirGKyRouomzZNVvauSgohLeH/c1GXYBalGhCYQM
         nk3ibSJZh1AQzVR+yQm/xq1I5ObF7ss4ygQ1EldOsfz9QYPrbm6veAruvf+wQdAQgyOb
         snwEHSfzZaiAafMxsgHKJyocAEJJVukKMrgyc6gl2ue6w//C893m3u4DrSqi6TIDnjUP
         vf9DE9cQ72Utaxa9jz/b2NLU4qrDi5+S2HWQtlqIuv+h0IIupE690yWwMGqVqmrAZtvk
         uHUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783608450; x=1784213250;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RW6vSA6mnZK5Lr/pJZ9dP1N7NRFIaPvsAxSMgjYokLM=;
        b=F9HpwOjAG6KnSePM6wtUhHMVWSxNnhihOdEhVZ7g7ahsvq8mYc3Bp09m7Xb0du1fE4
         Ko73O3le4jPmZ/lLsfaBf3h8z6gl5mBYv9ZnCQO0Frz+Kne2xCieysFpH5Ch3z8DNOjI
         0/yhwDOIv4bxj72Vsf/wQaqCdaVRK5zAYBVAKRBgpTOKjHSX30I7p2FpkDGGuQ1UiuQe
         PC/YJdowPETt5zu+iy75aYkY3oGBp2qczE61wsvtipRRME8uu2AfM+pKEEOOuZYDlzrU
         XTZ6lHND/bi2QAyz6e1QlFy+y1hHS1fSJwrAPJtafUvvgHLecuKt98Rrm/l/g625jMzx
         Njig==
X-Forwarded-Encrypted: i=1; AHgh+RpqSuAdJ8nkUm81fykg+um5Jg8sVgkJj7IYa4TTsGz1JDIJTFpUR9wVbsMzssnjWPwnjmgrGrA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAyp51Kpih6sQ/fgl5ajOwH0qWCWXoOAU7/rSDrHVxplivS4PD
	C2VWsZaumSFv+JAiJNUOt8i0qqxTxaAogVVRcqxbJLVAeSykyj2jOfao
X-Gm-Gg: AfdE7cmbsmdEJR7UI8OB7HKOteogk9HGpdySvhXu+eSQRKR34szZrDxr9NC7pwnvVeO
	bP2CRSE8NHadIW+SndDggGzbCSKrGVovTNu6Yzr2Wt18s78UYj7ZofoAhKDGcqV4Sxpfrl6r4LH
	XmuVVcWF8R14h+DkCbMQWfwa8ripG8yObDtOOqqZsQcO6Y60K/SwMvOiVEKZI1b07Aw5HTSjEjR
	WfkUdHIyXV2L/QgX7AAZZYEj0l8/Jm4ND1gFSVIex/fnYeNbtFC6fe+tqAIIKPQVUhiCUAfLKaT
	vS9KtBcjiv3ywQ8r3doAIY0A2R2xCLO6wGd7XdTvX7ET2vIDaAfxGI8CNn7WDYViXBsBb0GzHzg
	hpSImsHr2Kjwd50KFQ97cGlxmT+YGodH+oPR3QbvIgzLSvg1lmjgk1JE9s+MCKaTSr3SIgBGiXQ
	zvoMnus7oZSPid5r+5znJfp3aUhOvcS9Z1qcm73yZMsUX7TcekoTyCU2Yg0Q==
X-Received: by 2002:a05:6a21:a95:b0:3bf:6c08:fb9d with SMTP id adf61e73a8af0-3c0bcead1b1mr9885193637.49.1783608450224;
        Thu, 09 Jul 2026 07:47:30 -0700 (PDT)
Received: from fx.tailc0aff1.ts.net ([206.206.192.132])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3118ee6080dsm18376697eec.17.2026.07.09.07.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 07:47:29 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Jon Maloy <jmaloy@redhat.com>,
	Tung Quang Nguyen <tung.quang.nguyen@est.tech>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: Xiang Mei <xmei5@asu.edu>,
	netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Weiming Shi <bestswngs@gmail.com>
Subject: [PATCH net v3] tipc: fix NULL deref in tipc_lxc_xmit() on node up
Date: Thu,  9 Jul 2026 07:47:19 -0700
Message-ID: <20260709144718.64535-2-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[asu.edu,vger.kernel.org,lists.sourceforge.net,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-306283-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jmaloy@redhat.com,m:tung.quang.nguyen@est.tech,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:xmei5@asu.edu,m:netdev@vger.kernel.org,m:tipc-discussion@lists.sourceforge.net,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:bestswngs@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[bestswngs@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bestswngs@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,est.tech:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8BEA273272E

tipc_named_node_up() builds a bulk of this node's cluster-scope service
bindings for a peer that just came up and sends it with tipc_node_xmit().
Neither step tolerates an empty skb chain: named_distribute() finishes
with buf_msg(skb_peek_tail(list)) to tag the last message, and for a
same-host peer tipc_node_xmit() routes into tipc_lxc_xmit(), which reads
buf_msg(skb_peek(list)). skb_peek*() returns NULL on an empty chain, so
buf_msg(NULL) faults.

The chain is empty in two cases: when cluster_scope itself is empty, and
when named_distribute() bails out on an allocation failure without
queueing any buffer. cluster_scope is legitimately empty during the
window in tipc_net_finalize() between setting the node address, after
which peers can link up and trigger tipc_named_node_up(), and
tipc_nametbl_publish() inserting the first self-binding. A peer linking
in that window crashes the node. It is reachable by an unprivileged
user, who can gain CAP_NET_ADMIN in a private net namespace and drive
TIPC there.

 Oops: general protection fault, probably for non-canonical address
 KASAN: null-ptr-deref in range [0x00000000000000d8-0x00000000000000df]
 RIP: 0010:tipc_lxc_xmit (net/tipc/node.c:1629 net/tipc/msg.h:202)
  tipc_node_xmit (net/tipc/node.c:1718)
  tipc_named_node_up (net/tipc/name_distr.c:222)
  tipc_node_write_unlock (net/tipc/node.c:428)
  tipc_rcv (net/tipc/node.c:2185)
  tipc_l2_rcv_msg (net/tipc/bearer.c:669)

Distribute only when cluster_scope is non-empty, and send only when
named_distribute() actually produced a buffer. An empty bulk carries no
bindings, so not sending it changes nothing. tipc_node_xmit() does not
touch cluster_scope, so move it out of cluster_scope_lock.

Fixes: cad2929dc432 ("tipc: update a binding service via broadcast")
Reported-by: Xiang Mei <xmei5@asu.edu>
Suggested-by: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
Assisted-by: Claude:claude-opus-4-8
Cc: stable@vger.kernel.org
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
v3:
 - Guard tipc_node_xmit() with skb_queue_empty(&head) so an empty chain
   from a named_distribute() allocation failure is not sent either, and
   move it out of cluster_scope_lock since it does not use cluster_scope
   (Tung Quang Nguyen).
v2:
 - Guard in tipc_named_node_up() instead of inside named_distribute().
 net/tipc/name_distr.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/tipc/name_distr.c b/net/tipc/name_distr.c
index ba4f4906e13b..888a87d769e7 100644
--- a/net/tipc/name_distr.c
+++ b/net/tipc/name_distr.c
@@ -218,9 +218,12 @@ void tipc_named_node_up(struct net *net, u32 dnode, u16 capabilities)
 	spin_unlock_bh(&tn->nametbl_lock);
 
 	read_lock_bh(&nt->cluster_scope_lock);
-	named_distribute(net, &head, dnode, &nt->cluster_scope, seqno);
-	tipc_node_xmit(net, &head, dnode, 0);
+	if (!list_empty(&nt->cluster_scope))
+		named_distribute(net, &head, dnode, &nt->cluster_scope, seqno);
 	read_unlock_bh(&nt->cluster_scope_lock);
+
+	if (!skb_queue_empty(&head))
+		tipc_node_xmit(net, &head, dnode, 0);
 }
 
 /**
-- 
2.43.0


