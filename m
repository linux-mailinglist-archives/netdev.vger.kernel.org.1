Return-Path: <netdev+bounces-272379-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gHNBDPkfxmlbGwUAu9opvQ
	(envelope-from <netdev+bounces-272379-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 07:13:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C4233F687
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 07:13:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 28C70302F989
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 06:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C813446CB;
	Fri, 27 Mar 2026 06:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="N8k7IFuD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B9026056D
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 06:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774591990; cv=none; b=cbrMRVW5jETh99lKwGPIETTUeCIY9R6o/fJmH5GAdMant1XKkEhSh8pCu7QcIclXxN5/gQZrjWLhCaCGjaOOHtFUCh5jWoZel+dPK7DYGq+izNkO6A67hKDNSWuywJDuWWbSQ2F19vGQuGLXAtR3OPJMJGNkAB07FOPL3XjP5P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774591990; c=relaxed/simple;
	bh=zpcgG/q9jwUjVk2oQ92H6B45ZkkJw8aJCvI8rucmPEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TlXCeff3lqOr/EWFQ3dQTIex3XOPKKkIKPKeAmiWUgcAsHa4MaIyMUQ6CybU4RX7vaGAU0QIT2fOh+bQYivm04Xxw8aeiEYIz121gDQoQjO/UNwavcMKXkKgcfScGkdVMI9QpSLtnXqyLT1RBo46M3ZhuUp1ocMpfr0uvVl34Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=N8k7IFuD; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2bdcf5970cdso1095321eec.0
        for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 23:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1774591988; x=1775196788; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SHqWlJnE5CLl5MgimSUDN9MdvKhupwl0UvY7ZewJxaI=;
        b=N8k7IFuDBPfZPhoFMNJ5IqgQAsJBrBZnGYCNmS4/txySYkfBIrmgr+uIciS1N2xlFh
         SIc2/eLFf9bnGUhYqByVoRI9adz3PXn7oPPSEXC7/ktOD7KRJmM7FZ7AX3hDtRgoDzCd
         1WH+ZsWF77dPl8uErOnK5DPZlUl+ewX1BmYry9WrTSxJi2KhASUH3To6xQcOOOlZqzZO
         XHd3UxQhWaYFlUeFRwp77TyeXThFRBA/zvszGpdwZ45aoS5XvkywsIp/gbL7C6R/gAGq
         aYjGKzQv2fatUy5bo5OCj6QIjw2Jvrwuz4d8S8mlCtGOKj+/mYsh+Dr1sQrFCfWw4Xmo
         eLhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774591988; x=1775196788;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SHqWlJnE5CLl5MgimSUDN9MdvKhupwl0UvY7ZewJxaI=;
        b=b6mvSiQxi/CtQ+UwEcxLzpPMPWgBTucQjC+UsPhu8jNc4a1xoGZ6bYCc0dauDYhSNP
         vF0oQu4rTuC8ecJF5aiKJYK/HMy8GjhKdbq8fTzDu1NGP4xXe1/LJmDiI1+3sqIeVfBx
         uwxNz7juX3wYpwFiDhtYveywAYeMVKGbYoPMrWh/r0PFr5wAUmt7A74tYX+0sBrDQ+zq
         wbNCQMpaASSkD7Tfs8F/wTlPfDDKzTTCL3AwqvGYf0MsDQSlahfRgR5zoMmLqAXvLuOa
         /xvApcZ4iK9lQB2LxSL5CjzcZFnne0rd/j4ZSgHYgVmcFKfGkCTpTM8WFGuydlP0iukg
         eLJw==
X-Gm-Message-State: AOJu0YxnDTSEHnc7LP/JJQxOMJ8EzKXbDYBcAbSYuCQ16Hn7+XKXoKlq
	MNQUWBq1AFj1/Om+Puxdy2/d8znYZKungyRv1GZTEOjqWfCLJCItISRYGi87tzCFUbEfRcf+lTO
	EnkA8Iw==
X-Gm-Gg: ATEYQzzCDEg6JEQTvPueJBmXz1uFYVZAA3VMf68lLtiWAhb370dFqtrEhy71lt8hU8M
	e6r4lUzrbPT5Q0N9Wv7p/Q83FPCxPXrnb1VwVldbbs3wOe8VQdNUXOnPgL0nyAQNwerUSdaQP9Y
	nev2aMW4eOtmIJGA2/XK7LPVslaJi/6TFdn6xmD6JbAuMttZJjPM80V88Gk9BilM/KcyPrZoMWe
	5nNg4iSZ2aOs/m5efSqVH4RFyFw+GHhk1XeRk0vuDVeWbbYZBQGggAYWq/B5sMULOPWCs/8sJMY
	Zqgt0jJVta8cJyeyRDBN2DwWmnJ1TaKvGmvTzSzixSqZ7z65qLGf3/o9Z76+SAAd8dtOoARcpDR
	rBYjXmUIMmzR4Mewx8BIguT6w9jVR3p7nIcvgTXkjstiOtW+Pngc8+rk1pX4YP7bOdbcUTZ/UKJ
	AULS5XWmOjAdblqyjNC5zmamgAvsrkt9vf2F3ujIOWmso3GRTgSZ5bBQ==
X-Received: by 2002:a05:7300:7313:b0:2be:6693:9b4d with SMTP id 5a478bee46e88-2c1771bb572mr2355872eec.9.1774591987708;
        Thu, 26 Mar 2026 23:13:07 -0700 (PDT)
Received: from p1.scai.dhcp.asu.edu (209-147-138-15.nat.asu.edu. [209.147.138.15])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c16ec26651sm4629441eec.2.2026.03.26.23.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 23:13:07 -0700 (PDT)
From: Xiang Mei <xmei5@asu.edu>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	horms@kernel.org,
	shuah@kernel.org,
	bestswngs@gmail.com,
	Xiang Mei <xmei5@asu.edu>
Subject: [PATCH net 1/3] net/sched: cls_fw: fix NULL pointer dereference on shared blocks
Date: Thu, 26 Mar 2026 23:12:58 -0700
Message-ID: <20260327061300.3066844-1-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[asu.edu,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[asu.edu:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272379-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[mojatatu.com,resnulli.us,davemloft.net,google.com,kernel.org,gmail.com,asu.edu];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[asu.edu:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 69C4233F687
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The old-method path in fw_classify() calls tcf_block_q() and
dereferences q->handle. Shared blocks leave block->q NULL, causing a
NULL deref when an empty cls_fw filter is attached to a shared block
and a packet with a nonzero major skb mark is classified.

Check tcf_block_shared() before accessing block->q and return -1 (no
match) for shared blocks, consistent with cls_u32's tc_u_common_ptr().

The fixed null-ptr-deref calling stack:
 KASAN: null-ptr-deref in range [0x0000000000000038-0x000000000000003f]
 RIP: 0010:fw_classify (net/sched/cls_fw.c:81)
 Call Trace:
  tcf_classify (./include/net/tc_wrapper.h:197 net/sched/cls_api.c:1764 net/sched/cls_api.c:1860)
  tc_run (net/core/dev.c:4401)
  __dev_queue_xmit (net/core/dev.c:4535 net/core/dev.c:4790)

Fixes: 1abf272022cf ("net: sched: tcindex, fw, flow: use tcf_block_q helper to get struct Qdisc")
Reported-by: Weiming Shi <bestswngs@gmail.com>
Signed-off-by: Xiang Mei <xmei5@asu.edu>
---
 net/sched/cls_fw.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/sched/cls_fw.c b/net/sched/cls_fw.c
index be81c108179d..caf17ab3be87 100644
--- a/net/sched/cls_fw.c
+++ b/net/sched/cls_fw.c
@@ -74,9 +74,14 @@ TC_INDIRECT_SCOPE int fw_classify(struct sk_buff *skb,
 			}
 		}
 	} else {
-		struct Qdisc *q = tcf_block_q(tp->chain->block);
+		struct tcf_block *block = tp->chain->block;
+		struct Qdisc *q;
+
+		if (tcf_block_shared(block))
+			return -1;
 
 		/* Old method: classify the packet using its skb mark. */
+		q = tcf_block_q(block);
 		if (id && (TC_H_MAJ(id) == 0 ||
 			   !(TC_H_MAJ(id ^ q->handle)))) {
 			res->classid = id;
-- 
2.43.0


