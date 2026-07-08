Return-Path: <netdev+bounces-305891-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ENY/Gpp6TmpiNgIAu9opvQ
	(envelope-from <netdev+bounces-305891-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 18:28:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E901728B41
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 18:28:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=MbtZEVtM;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305891-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305891-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C975D302BD96
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 16:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 038B340928D;
	Wed,  8 Jul 2026 16:14:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7BB37B415
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 16:14:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783527247; cv=none; b=uKoMTE81s8g4uxiHSEkp5IeKKUJOXHT73p9OcQKPHWhfGaT9XW5eppK/KnZC5AvzLCH/E702gcaIytFT+gEBxnsU1p71cH6xDi2KENlIfIAP1uIbiMQipd0LaClQfNtoRqcfyYYhazfEjFjiSKWabWUKjRjeSYOi103RQkwjmDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783527247; c=relaxed/simple;
	bh=GcUlruM+NGqEx7z3ydLkr+i+uXVPzazlpG6H7pNviRg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DxCdDKV+yhHab9L1MHvrLbIwWJzZaoYZCFgJT9yBDjYCUe6bBNdqfJM3MLE+bbg0xEIbuN47V8DSADSHVR1/TLgJKPQXWCK8yKBz+OZXaFF6Nj73ySX3pIfh5tbWpyH+e1K9NDL3iTQpI/hladHxELwgCX9xiCnocADrEpmyJJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MbtZEVtM; arc=none smtp.client-ip=209.85.216.44
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-381018b9375so986492a91.0
        for <netdev@vger.kernel.org>; Wed, 08 Jul 2026 09:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783527246; x=1784132046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+myLTsla0EBewCTP4a0cFztuzTTZxCB2bGQ0rDnbLXs=;
        b=MbtZEVtM3z8t/DBANpCtfJ/3cev2hldfimO+M4zOvlT/5ZLHVaXXZ4dOIrXl0JAAX1
         pt/Gq8fSphVU75zQudSgFGC8o1bNkpnUezUaAM5F8L2tUoRwfEcWnUqsimz1JlvYqYIE
         7Kycimi2ezAttQl4cmPDsALTNTUgEpfYCwEbxPGsEF+sIfJxz2YWfYv575e7iT2H6zCi
         zi+PyRahZ3JR4YfJBFazOSgaLo/g3+IyI+5DXMLjg4BqVu8CIBxxwfRD7RR0rnkrd+V/
         z36lowvxUPc2kB5mgVJOtyM/TUMFSaOemNgkgMqwhYzB2PcLvqjb7Pt3JInEtERKx6Ws
         jrjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783527246; x=1784132046;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+myLTsla0EBewCTP4a0cFztuzTTZxCB2bGQ0rDnbLXs=;
        b=nC43oQsr8iVcU4v+bVubBwC6axkPtNfoy8OFrFCb+XJ5j7FjRNecPCYmSQ9K8+SxEE
         r+07MbkR54MOtNSiS5Camr3+AW2CUqUIB9qknVcWVFwgkA+fAPCDM+NHtdTzvGwd9N7I
         /PQzjA4HnHzgvoLp0Rij34N/oAyVKqjIu68qlIwD24sAw2jCrTFH6bx6Mh24fD5DE+uH
         rAhTjZD8Onyi/dfKq+Ai+38GxtPLd1JQDKh405F2kvvaBDrU54OAMnUeG6Wf0+0QmlsI
         ExMqBZrIKXe4THeeE8pFoedEmGpd/ogjT7FeXHZ3AvtoSSvicgmTiFnGEZjtlapxEBYZ
         nCEQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqv0yGQAacO47asm4ka0mE+q3n0JKaSlVZT+pfcy3xoknipdNuRYs5FS1VskvmGqvppm+8Pcc0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiqAwGbknhfk8td6QtXWIcSeofxt2/72XE7QdXAo2EOJPWn8dr
	HFeK4GLcHUEproa8s1ofW84eAq1wzdGR9eCcJ+NXr8pW8fKHU4HYdWEy
X-Gm-Gg: AfdE7cmG7khhprv1qZEnYES56nqPVZa3+EPWs/jH609+MtC1vkIho/UGIMI5TORLlrj
	czqFoCWIvGQYgVBhqPlq4giA0f1N/56Z5AZy9Bzi3SsEcKdGHKt8FMyy1cHIpdUFUWFT1oaNj/Y
	G1c6J7SPhuT/Fhl9R7KaRB/4iGXRMVa14/6Nnfo1QzXZa6MiOETmqRB3p+7I9wJeasLyZGfXSLB
	VM2leyt9IMlzt3JcZlYxp7aix3mVZV/GBGQuw+q/sEyWd+mcClOy4UkNVijU5EAkbSyr4c3At+W
	yub048cI6BqfgdsNsPrlA38DU2bY1Nr1GVhsd9vFtCakTbvVQRTvfOLwuqeR0JWPOiVB186UC8J
	qlMb5XsQRk1s4Pa8QSNVdQZtyDy6o1o5LPgQbsWtQ2G018sSSIrS+xzVf+SRcUkAf9TND0pX0xX
	fXxLlBMcIHk8+LKC9ZgMnw+Er5OFqdGYSYD/69Dy9+TyPE/z2qDTvURZvSNQ==
X-Received: by 2002:a17:90b:5384:b0:381:c500:b0d1 with SMTP id 98e67ed59e1d1-389421ae13emr3606078a91.20.1783527245930;
        Wed, 08 Jul 2026 09:14:05 -0700 (PDT)
Received: from fx.tailc0aff1.ts.net ([206.206.192.132])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174a8f521sm21215064eec.22.2026.07.08.09.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 09:14:05 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Jon Maloy <jmaloy@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S . Miller" <davem@davemloft.net>,
	Simon Horman <horms@kernel.org>
Cc: Xiang Mei <xmei5@asu.edu>,
	netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	Weiming Shi <bestswngs@gmail.com>
Subject: [PATCH net] tipc: guard against empty buffer list in tipc_node_xmit()
Date: Wed,  8 Jul 2026 09:13:25 -0700
Message-ID: <20260708161324.2954113-2-bestswngs@gmail.com>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[asu.edu,vger.kernel.org,lists.sourceforge.net,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-305891-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jmaloy@redhat.com,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:davem@davemloft.net,m:horms@kernel.org,m:xmei5@asu.edu,m:netdev@vger.kernel.org,m:tipc-discussion@lists.sourceforge.net,m:bestswngs@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[bestswngs@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bestswngs@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,asu.edu:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5E901728B41

tipc_node_xmit() dispatches a buffer list either to the bearer path via
tipc_link_xmit() or, when the destination node lives in a sibling network
namespace on the same host (n->peer_net set), to tipc_lxc_xmit(). The
bearer path returns early on an empty list, but tipc_node_xmit() does not,
and tipc_lxc_xmit() dereferences the first buffer without checking:

	struct tipc_msg *hdr = buf_msg(skb_peek(list));

named_distribute() can hand tipc_node_xmit() an empty list. It bails out
early when named_prepare_buf() fails its GFP_ATOMIC allocation, leaving
the queue empty, and tipc_named_node_up() then calls tipc_node_xmit() on
it unconditionally. On the intra-host container path skb_peek() returns
NULL and msg_user() reads through it.

The TIPC configuration ops are flagged GENL_UNS_ADMIN_PERM, so an
unprivileged user can reach this via unshare(CLONE_NEWUSER|CLONE_NEWNET).

  Oops: general protection fault, probably for non-canonical address 0xdffffc000000001b
  KASAN: null-ptr-deref in range [0x00000000000000d8-0x00000000000000df]
  CPU: 0 Comm: ksoftirqd/0
  RIP: 0010:tipc_lxc_xmit (net/tipc/msg.h:202 net/tipc/node.c:1629)
  Call Trace:
   tipc_node_xmit (net/tipc/node.c:1721)
   tipc_named_node_up (net/tipc/name_distr.c:223)
   tipc_node_write_unlock (net/tipc/node.c:428)
   tipc_rcv (net/tipc/node.c:2189)
   tipc_l2_rcv_msg (net/tipc/bearer.c:670)

Return early from tipc_node_xmit() when the list is empty.

Fixes: f73b12812a3d ("tipc: improve throughput between nodes in netns")
Reported-by: Xiang Mei <xmei5@asu.edu>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 net/tipc/node.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/tipc/node.c b/net/tipc/node.c
index 8e4ef2630ae4..cd05269e5335 100644
--- a/net/tipc/node.c
+++ b/net/tipc/node.c
@@ -1695,6 +1695,9 @@ int tipc_node_xmit(struct net *net, struct sk_buff_head *list,
 	int bearer_id;
 	int rc;
 
+	if (skb_queue_empty(list))
+		return 0;
+
 	if (in_own_node(net, dnode)) {
 		tipc_loopback_trace(net, list);
 		spin_lock_init(&list->lock);
-- 
2.43.0


