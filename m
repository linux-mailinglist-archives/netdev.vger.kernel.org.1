Return-Path: <netdev+bounces-290654-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WAPTHAvHD2qJPgYAu9opvQ
	(envelope-from <netdev+bounces-290654-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 05:01:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 161C15AE373
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 05:01:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ADC7C30182A0
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 02:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E97F30F806;
	Fri, 22 May 2026 02:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QJN48+DS"
X-Original-To: netdev@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4FCB2C031E
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 02:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779418774; cv=none; b=Ixv/DM3xPkMI32xQkWaAxF1kBUexhg1VJvjYYJWKqQ9RNDhshj6ZOAmyVVFnaR7oXKQXzSsLbz9/yy1voI+dcIiD0kL1offnj0TWwYRX2zEjYwJwPWd5uuRQi2eJr6tct+E7cu78IA6snA/MdQLd0tWk4WPnYVZvHfwjgqGGXM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779418774; c=relaxed/simple;
	bh=XcAeZ1xUWN5YbsF3zkXJL5jaBtdzE7hmE7JLhl4tByw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RdGxlt8Ulso1mIkAoL1nQMRBH+SDFoH7gvwbzl2opMDuiKGZxtaDnwGaH2dkIVSmOHxLjnca0eh3Z4YchyIzL04WrK+9YMGYMk3HaPHpiCK1ia1vXgUkR48DOhXIJkJX8Y2eGXkeYM8o6ANEVcEz1DZE+hAjvTYXGYju1qM5JDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QJN48+DS; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779418759;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZHMKu37bWNXYpVKFqT7lIbO39Wj8aWEiP+AeO+SmrKo=;
	b=QJN48+DSEepn3oelHyzvw7UCKSV7jN5dVjgaZdQcOZ8b29fuFth4EtToxsGAhYhIgdFc5Q
	RRLX+v9APcKfoEH0ZD0BdO8UJr5BrLzfBDB1DGltnSuJonIGvaEk+7f7om8ZyCu8n63/WY
	mo793DftGfPcB5gTVf7LJ5rzo0sAYnE=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	kuba@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf] net/sched: cls_bpf: prevent unbounded recursion in offload rollback
Date: Fri, 22 May 2026 10:58:53 +0800
Message-ID: <20260522025854.341647-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux.dev,kernel.org,gmail.com,fomichev.me,mojatatu.com,resnulli.us,davemloft.net,google.com,redhat.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[22];
	TAGGED_FROM(0.00)[bounces-290654-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,linux.dev:mid,linux.dev:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 161C15AE373
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Quan Sun reported [1] a stack overflow in cls_bpf_offload_cmd().

Reproducer on netdevsim: add a skip_sw cls_bpf filter, set the
bpf_tc_accept debugfs knob to 0, then `tc filter replace`. The replace
calls tc_setup_cb_replace() which fails. cls_bpf_offload_cmd() then
swaps prog/oldprog and recursively calls itself to roll back. But
bpf_tc_accept=0 makes the rollback fail too, which triggers yet another
rollback frame with the same arguments, and so on until the stack is
exhausted.

bpf_tc_accept is just a convenient knob for the reproducer. Any driver
whose tc_setup_cb_replace() fails twice in a row can hit the same loop,
so this is not a netdevsim-only issue.

Two ways to fix it:

  1) Have the rollback call tc_setup_cb_add() on oldprog instead of
     re-entering cls_bpf_offload_cmd().
  2) Mark the rollback frame with a flag and skip a second-level
     rollback from inside it.

Go with (2). It is the smaller change and keeps the original behaviour:
the rollback still goes through tc_setup_cb_replace(), so the driver
gets one real chance to restore its state. If that attempt also fails,
we just return the original error instead of recursing.

[1]: https://lore.kernel.org/bpf/ce5a6005-3c5e-4696-9e05-eba9461dc860@std.uestc.edu.cn/T/#u

Fixes: 102740bd9436 ("cls_bpf: fix offload assumptions after callback conversion")
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 net/sched/cls_bpf.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/net/sched/cls_bpf.c b/net/sched/cls_bpf.c
index 9a346b6221b35..d71fbf7cb407e 100644
--- a/net/sched/cls_bpf.c
+++ b/net/sched/cls_bpf.c
@@ -142,7 +142,8 @@ static bool cls_bpf_is_ebpf(const struct cls_bpf_prog *prog)
 
 static int cls_bpf_offload_cmd(struct tcf_proto *tp, struct cls_bpf_prog *prog,
 			       struct cls_bpf_prog *oldprog,
-			       struct netlink_ext_ack *extack)
+			       struct netlink_ext_ack *extack,
+			       bool is_rollback)
 {
 	struct tcf_block *block = tp->chain->block;
 	struct tc_cls_bpf_offload cls_bpf = {};
@@ -176,8 +177,8 @@ static int cls_bpf_offload_cmd(struct tcf_proto *tp, struct cls_bpf_prog *prog,
 					  skip_sw, &oldprog->gen_flags,
 					  &oldprog->in_hw_count, true);
 
-	if (prog && err) {
-		cls_bpf_offload_cmd(tp, oldprog, prog, extack);
+	if (prog && err && !is_rollback) {
+		cls_bpf_offload_cmd(tp, oldprog, prog, extack, true);
 		return err;
 	}
 
@@ -208,7 +209,7 @@ static int cls_bpf_offload(struct tcf_proto *tp, struct cls_bpf_prog *prog,
 	if (!prog && !oldprog)
 		return 0;
 
-	return cls_bpf_offload_cmd(tp, prog, oldprog, extack);
+	return cls_bpf_offload_cmd(tp, prog, oldprog, extack, false);
 }
 
 static void cls_bpf_stop_offload(struct tcf_proto *tp,
@@ -217,7 +218,7 @@ static void cls_bpf_stop_offload(struct tcf_proto *tp,
 {
 	int err;
 
-	err = cls_bpf_offload_cmd(tp, NULL, prog, extack);
+	err = cls_bpf_offload_cmd(tp, NULL, prog, extack, false);
 	if (err)
 		pr_err("Stopping hardware offload failed: %d\n", err);
 }
-- 
2.43.0


