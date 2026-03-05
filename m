Return-Path: <netdev+bounces-264202-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aAYKABIyqWnM2wAAu9opvQ
	(envelope-from <netdev+bounces-264202-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 08:34:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B45720CBDE
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 08:34:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B13323038F23
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 07:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B64C831B824;
	Thu,  5 Mar 2026 07:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="P63IjC4I"
X-Original-To: netdev@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45742319848
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 07:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772696060; cv=none; b=kyZEy7u/tHPbCBUIVrmiaO6ko/ieg+T9EEIhhRTBg0rHmHISFJdB7eW2yXRDQ4352R0OWYKdtFDZX0HhoVBpK77Ok8l1xW3HCbH1a/2/MN4O5mvPk9RE7HuWNnHGdmu6hAqZpgkKE6PH7jigO0tA+G2LFCNN9HF8DMt8uqPvRNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772696060; c=relaxed/simple;
	bh=MHxiNpiYg4UslTUbQeAmuvquHyi/On2XedZkol9Nn/k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ul/IM4TXjBIwfNKvHhNcbKjNgNu+nLOU/BJBPKiFg7J/BEtFWCZ2HjJC6/PO6bwlFsmXimslaafZKsak2Gs18+DOBMCouVqp7JK/IQDokHwYDRhsEKy+3lWUQ2qVo+SiBye0l6Cw6WMdgZeofzSqbPgqKUDCytY9exa8JIWUWAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=P63IjC4I; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772696057;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vrhmpsYNV6AoYX0jQ9J/i2Jc+3t5kMVOzCIjalv+idU=;
	b=P63IjC4IGxxcuTS7WhuQl6yfkOo6B4soN64++OupOMPQ8Qd7t/A75JO606nyKl82dJymoC
	Baw2Z9bvrTLPFexr4lJcOhjdi5aT7VJoJkZJK+AfnJSgPElUbrqgxquOaiOdyjxn0K1dpo
	v04jkUG5514uVuAlYpVX6jvCfXxzctY=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: netdev@vger.kernel.org
Cc: jiayuan.chen@linux.dev,
	Jiayuan Chen <jiayuan.chen@shopee.com>,
	syzbot+d5ace703ed883df56e42@syzkaller.appspotmail.com,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH net-next v1] net: sched: cls_u32: Avoid memcpy() false-positive warning in u32_init_knode()
Date: Thu,  5 Mar 2026 15:33:43 +0800
Message-ID: <20260305073343.250702-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 8B45720CBDE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-264202-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev,d5ace703ed883df56e42];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,syzkaller.appspot.com:url,shopee.com:email,linux.dev:dkim,linux.dev:mid]
X-Rspamd-Action: no action

From: Jiayuan Chen <jiayuan.chen@shopee.com>

Syzbot reported a warning in u32_init_knode() [1].

Similar to commit 7cba18332e36 ("net: sched: cls_u32: Avoid memcpy()
false-positive warning") which addressed the same issue in u32_change(),
use unsafe_memcpy() in u32_init_knode() to work around the compiler's
inability to see into composite flexible array structs.

This silences the false-positive reported by syzbot:

  memcpy: detected field-spanning write (size 32) of single field
  "&new->sel" at net/sched/cls_u32.c:855 (size 16)

Since the memory is correctly allocated with kzalloc_flex() using
s->nkeys, this is purely a false positive and does not need a Fixes tag.

[1] https://syzkaller.appspot.com/bug?extid=d5ace703ed883df56e42

Reported-by: syzbot+d5ace703ed883df56e42@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/69a811b9.a70a0220.b118c.0019.GAE@google.com/T/
Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
Made-with: Cursor
---
 net/sched/cls_u32.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/sched/cls_u32.c b/net/sched/cls_u32.c
index 9241c025aa74..8f30cc82181d 100644
--- a/net/sched/cls_u32.c
+++ b/net/sched/cls_u32.c
@@ -852,7 +852,10 @@ static struct tc_u_knode *u32_init_knode(struct net *net, struct tcf_proto *tp,
 	/* Similarly success statistics must be moved as pointers */
 	new->pcpu_success = n->pcpu_success;
 #endif
-	memcpy(&new->sel, s, struct_size(s, keys, s->nkeys));
+	unsafe_memcpy(&new->sel, s, struct_size(s, keys, s->nkeys),
+		      /* A composite flex-array structure destination,
+		       * which was correctly sized with kzalloc_flex(),
+		       * above. */);
 
 	if (tcf_exts_init(&new->exts, net, TCA_U32_ACT, TCA_U32_POLICE)) {
 		kfree(new);
-- 
2.43.0


