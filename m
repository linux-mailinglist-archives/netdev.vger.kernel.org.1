Return-Path: <netdev+bounces-272945-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OLE9LmtZyWkuxgUAu9opvQ
	(envelope-from <netdev+bounces-272945-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 18:55:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1276D3532F0
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 18:55:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A9073006B1B
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 16:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF6A43815C8;
	Sun, 29 Mar 2026 16:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HUeAtjOS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABDA2BD0B
	for <netdev@vger.kernel.org>; Sun, 29 Mar 2026 16:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774803237; cv=none; b=JbvxuaYdzBoDk20/za99xyih9kplMd2D6PuI27ADfo/d8SDqylbmDYa1IjwKNnwmWjtqCNJOM1NWjhVuL04h5cA9QBQ518jFHkcnwUXASjzdWz1cxk3xD4Fp6uCrfOKPW0tHYO5zbbISh4iC4JJ3ESmqE/kaGdYw/1gAeYzNPzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774803237; c=relaxed/simple;
	bh=+BTKBD59YWu2xkn2TAEqe31LoHLRQO1O0pRXWEi5f18=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B8WzW8VSJ/FNpapus3hOWyc+5DOFGYjdgrLf/70qxCvUNMRkmmEbNbBVncV9z9GHhbUGN5gEHSCuVd/xV6LjHbBZwuE8VBf+xX7WBuXufgQpF34zb9riFGUEnU9vZEIkrmxQzU9XAfW2XcK6lN2DmqUQBG2SGGz0bgUALKBeBxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HUeAtjOS; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-35d971fb6f1so840922a91.0
        for <netdev@vger.kernel.org>; Sun, 29 Mar 2026 09:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774803236; x=1775408036; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3gqeZSuHutjivB5N11MVmiWyWDlLluyBO9c1a+A4Zxk=;
        b=HUeAtjOSozl0wrZQEDpGfuz2s4sD+qjHPMbgSQpKmS3LttHI3uBY1r2ZrDrysKP4Ny
         7432+Q3P1fnbFohh5HVHRlu16cQvwpWKT4VZ8TpW5oIeqYMbCyTIbinfjhjuXFsGoaJQ
         wbjB4+FjtZMqO044Cv3gKtsfB8PFro6bQ26yZYDogLCd+5rJx25HSKdGbRCkuh9rZNyu
         oMHsfFTX3qzFbE7P/axIovk2mBELfssQ/JljyxVQCcL8e8livT+6oBpLRPxPlaHPbgRZ
         7s0rVG1yo41mTa/U9jmH5lVt3I0qlxzX/43A4+LSbVgqL36FZm8pgeoqtcCIJdrPvsrR
         bJ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774803236; x=1775408036;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3gqeZSuHutjivB5N11MVmiWyWDlLluyBO9c1a+A4Zxk=;
        b=GafscJflNCvxHnoEfz/LFxCKNaOd4nAAfgu/d3F9svLI66O5450v5LTrpYbrtNSODA
         TWOQiUx5B1zdDNw12hGlV1D0fAOOifO31m6m8pKCg7jW+4UopNTVRBo8c8Zaz2B9EtLz
         4cY4+84vmONBjEWSMWZrEKuybyRv5TPNeogbSU/MG8yYau6/Iy0JuFOTzvnZacYoPxkw
         1hbFi6uza6LiQkT+7rm87RKhnVZOe0i2mB/YeQuj9nEY38ZlzBWWG3pFTHhF6H3dtp0q
         kC7ZK8417Kp07aPnbEt4Bx49toDCH3rx3bRwo02G5YL86KRfEc8RP8XOR1VYZQbzNFlA
         /gjA==
X-Forwarded-Encrypted: i=1; AJvYcCVzqDnOlPDFP6MI012ius+LnU3Y12Gr/aEPNwAprzpmkUAQhxZsKiofP24+4MFO4UvI7duzWu0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhZn6GZ3ALEH4qQnhsNHltAnqcx/RFuFDbHU3bMXl9QE9QbpSR
	gB+flWBAKczLSOeXYcR90nm78b1ZhcUKDeQQoH2ylU+DbTJC0dGjCZSa
X-Gm-Gg: ATEYQzz11RdfCzoB6RZ/148uTgFagbv4hlLw6sgT0tDNREyv1vYfJi4fjcjaiHXTN1Y
	okx9GGuqgBrc92eiO0sDwWEw/Dw3EAvgpGiNsLEIeO/DEXiBiLCNDRyeY7BqylxA8zb8uSod2Wk
	cgcwzpCPTpwFpFvGxWLbQLt4RMpyOdlsPcoQPCqz+ZCtgeNfH2KnkwjpLL2naj3x4vQV21x2ljj
	9vp6Wb79wSThFLLf2ef56SZcCIg2JJ0SPhFdWevuLU86wIa2Z0GDgHOIGPLSc7XXp+vzSuu6F18
	IG+arjdbc1DmSpSeD5D3wI2mCOw6KMWjpc4L+pW4YTw6xlBxPblNsPBrGIAfHpLmNUeLka5SCtb
	SbQBbOSM9Rwyh32z4adsuGla5zb69iHxWntqFhTxjFpw0Si3preLdWg0kc0yJXzbXxJQIrttKWx
	QJNVhlQZltKdOyOivWzUvP//AzkdCIVzHFhWAx34uNz0p4TQ==
X-Received: by 2002:a05:6a21:7a45:b0:39c:8c0a:d09b with SMTP id adf61e73a8af0-39c8c0ad0fbmr9737476637.49.1774803236054;
        Sun, 29 Mar 2026 09:53:56 -0700 (PDT)
Received: from localhost.localdomain ([47.236.127.140])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76917bb809sm4224736a12.28.2026.03.29.09.53.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 09:53:55 -0700 (PDT)
From: Qi Tang <tpluszz77@gmail.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	Qi Tang <tpluszz77@gmail.com>
Subject: [PATCH] net/sched: cls_flow: reject baseclass resolution on shared blocks
Date: Mon, 30 Mar 2026 00:53:49 +0800
Message-ID: <20260329165349.241123-1-tpluszz77@gmail.com>
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-272945-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tpluszz77@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1276D3532F0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

flow_change() calls tcf_block_q() and immediately dereferences the
returned qdisc pointer to resolve a zero-major baseclass handle.
On shared blocks, tcf_block_q() returns NULL because no qdisc owns
the block, causing a NULL pointer dereference.

Check for NULL before dereferencing and return -EOPNOTSUPP, since
shared blocks have no qdisc handle to derive the major number from.

Triggered by creating a cls_flow filter on a shared block without
a non-zero-major TCA_FLOW_BASECLASS:

  Kernel panic - not syncing: kernel: panic_on_warn set ...
  Call Trace:
   <TASK>
   check_panic_on_warn+0x5d/0x80
   __warn+0xe7/0x300
   flow_change+0x1422/0x1900
   report_bug+0x9a/0x1e0
   handle_bug+0x14c/0x360
   exc_invalid_op+0x13/0x40
   asm_exc_invalid_op+0x16/0x20
  RIP: 0010:flow_change+0x1422/0x1900
   tc_new_tfilter+0x92b/0x2060
   rtnetlink_rcv_msg+0x758/0xab0
   netlink_rcv_skb+0x120/0x350
   netlink_unicast+0x755/0xaa0
   netlink_sendmsg+0x787/0xc30
   ____sys_sendmsg+0x8b6/0xb00
   ___sys_sendmsg+0xed/0x170
   __sys_sendmsg+0x107/0x1a0
   do_syscall_64+0xe0/0x1290
   entry_SYSCALL_64_after_hwframe+0x76/0x7e

Fixes: 1abf272022cf ("net: sched: tcindex, fw, flow: use tcf_block_q helper to get struct Qdisc")
Signed-off-by: Qi Tang <tpluszz77@gmail.com>
---
 net/sched/cls_flow.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/sched/cls_flow.c b/net/sched/cls_flow.c
index 339c664beff6..ad8b4c375d1c 100644
--- a/net/sched/cls_flow.c
+++ b/net/sched/cls_flow.c
@@ -505,6 +505,10 @@ static int flow_change(struct net *net, struct sk_buff *in_skb,
 		if (TC_H_MAJ(baseclass) == 0) {
 			struct Qdisc *q = tcf_block_q(tp->chain->block);
 
+			if (!q) {
+				err = -EOPNOTSUPP;
+				goto err2;
+			}
 			baseclass = TC_H_MAKE(q->handle, baseclass);
 		}
 		if (TC_H_MIN(baseclass) == 0)
-- 
2.43.0


