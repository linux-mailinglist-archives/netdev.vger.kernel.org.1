Return-Path: <netdev+bounces-277985-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OOuUELWn3GkEUgkAu9opvQ
	(envelope-from <netdev+bounces-277985-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 10:22:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A2063E909B
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 10:22:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 58D0F300B8F4
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 08:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 435743A784B;
	Mon, 13 Apr 2026 08:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ik0jwPp8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA3B3A75AE
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 08:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776068437; cv=none; b=VZiX1LK7YVgKu+lR+3IkySaIX6FtoAFGNaHx9O+4FvPbhVht8DG3QrxXD47FZzMWDbkeWjdIw/SEeL/pB25236VWmGFnQx4qKz0Dg3RZdZySNLG1iJZqq3ErzAi5h3d69rm0gTDvaOb5iGmrTk1aecf+/XtLKqARjIlwphaKFck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776068437; c=relaxed/simple;
	bh=ZpxPLeXpDudAHB1vfPu3H3+tflsKWNVqI/+7E/D8yl4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rQtH/iiU7yys4S5chX+TgLPFdJsoPgF8j1kP/A/azMnbXYX/CTFXfc9u/AQ0eA7ZlqVJHm3DxkmqPFneZi0XWIOXZR0PUy7zF+6+udCRC+w/Lc89HG92LxBjhyic340Zfq1Pg5CB9WguQMJf1hHyYTBuim64quT1IciQWZItTu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ik0jwPp8; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-35d95017a68so2571536a91.3
        for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 01:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776068435; x=1776673235; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kl3F5dX0VanlFuC2/COyBNs0Ns8vPwKSkzIIDi55UM8=;
        b=Ik0jwPp8k0y0m0xr4hPBBEGpDpz0v6AqhlIrbZHFJjRD/O6ft8PNVAId/G7vVf3lx7
         764RHEjSiUwD5IIv/AwWxxS1/wuiEObyU/qlNO7k47PqFmmZNgHPKBqxx6EbgKDQ1AWh
         npYLBb1oGrnFJXVe8q05444EZHh1Sy+lIon31XBhetoFECZO7L2T50g9b14YJn1Fu5X2
         9rG4GrqTSkwJYi5wtD5jh34NbgD4DKU4Mn0UZHerwwdHNs0tJ2KPrUNejnYlYwJ3t/uw
         kXyR0A8Ub1i4IJIy+IjdCzrUKdV68ggnxx9Cl0t+h6D2r4pvYHsdyYUA4F3dWhBDRH/E
         aiVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776068435; x=1776673235;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kl3F5dX0VanlFuC2/COyBNs0Ns8vPwKSkzIIDi55UM8=;
        b=U8CQtYVruBdwRJ8GHMlAoafQuDh0QK1oFNLvRg/9WEMFxKn2nbAu4BBT9+AoE5kqyg
         4c74F+n5pYT7BnFq084dnF9fAXbHL6JjL+xExZ90u2Zd1Pwp/CRkRAR0sGSG7txLbnll
         3WM0smDMjRUdjQpni0ZSsp3t44hJ9Y0AIpGsDiTbtVL/fO+iW6aji0IEd2JRLf7IxeHI
         rfAfO/X90zHQVCfbd8xTzJg87rJHps4TjQpA+2F/ylytEuyRsTWmpjU55GEXgCLMWpN4
         5eFhgJXRVEBf1Z4/uq53mUNuoMzwqhbpFB6WKTnwVbsIVoXWkDcHDPqfedCxCDnY7XMx
         iNSg==
X-Forwarded-Encrypted: i=1; AFNElJ+bNQjfdcoFmcPgF2H6Ey3Gyj7JeufA2AcTgy/ZjiflytR4Xe6lVHcYvR32pmfFi+9XxvA2w+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhZPELH5vZ36NyDLvfA6S3ije2C6216M+8k/VwEjN1Ti4wQW7y
	BfbhjXNM0eKmA3CbS+8ryBTbGXAv96UVNUKCSbmJmfCiI9G7yhRWvWrS
X-Gm-Gg: AeBDieuOifXiI1W/i3N3ECmPf66IkWLEaRb+D3s7qQ98BdtdF+p8t1WuaynccZRs4Fg
	4hxIDK3SnIyLOBz80zAclwVwqKBkSqK2f2zzFXg0dEZYdRbS5np6yPYaujfz1BJ3u52UkWhdwCN
	jWbnq4CW4iLOrNp85cZv1zutnNiItidoEUTrMKZt0SJgeOTUOQbdwoHu3ZGx3fpn3y/yY7NTuii
	YxrU6AKX67Hb0dtDLWhlPMxkURGMJlF9EPiq7BNd74/PqdlRwGcNyvLt1EB9V8j3Y49Lm4tdOQQ
	cycWzScVGs3bnAP0F1pF6EsXwB+FuVG1UmkOz2rcVn7o58A+fz7Gm+3339XUs2PxvJ9m/6iirHy
	2ilfVc6DRcgv6TjNy2Vc8moQPRke9/hXzS8FeVMiqDP0sVCsVaNre59BS1yOurjoyGhZF9AV2tD
	sCM93BjhKkEIkajeRAjz+5QQuwqDrz+QL/
X-Received: by 2002:a17:903:368c:b0:2b0:4ec8:fb92 with SMTP id d9443c01a7336-2b2d5a8ec02mr91724945ad.39.1776068435146;
        Mon, 13 Apr 2026 01:20:35 -0700 (PDT)
Received: from localhost.localdomain ([180.167.178.215])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2d4f0983asm116757705ad.51.2026.04.13.01.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 01:20:34 -0700 (PDT)
From: "Kito Xu (veritas501)" <hxzene@gmail.com>
To: jhs@mojatatu.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	victor@mojatatu.com,
	pctammela@mojatatu.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Kito Xu (veritas501)" <hxzene@gmail.com>
Subject: [PATCH] net/sched: act_mirred: Fix blockcast recursion bypass leading to stack overflow
Date: Mon, 13 Apr 2026 16:20:27 +0800
Message-ID: <20260413082027.2244884-1-hxzene@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,mojatatu.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-277985-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hxzene@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3A2063E909B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

tcf_mirred_act() checks sched_mirred_nest against MIRRED_NEST_LIMIT (4)
to prevent deep recursion.  However, when the action uses blockcast
(tcfm_blockid != 0), the function returns at the tcf_blockcast() call
BEFORE reaching the counter increment.  As a result, the recursion
counter never advances and the limit check is entirely bypassed.

When two devices share a TC egress block with a mirred blockcast rule,
a packet egressing on device A is mirrored to device B via blockcast;
device B's egress TC re-enters tcf_mirred_act() via blockcast and
mirrors back to A, creating an unbounded recursion loop:

  tcf_mirred_act -> tcf_blockcast -> tcf_mirred_to_dev -> dev_queue_xmit
  -> sch_handle_egress -> tcf_classify -> tcf_mirred_act -> (repeat)

This recursion continues until the kernel stack overflows.

The bug is reachable from an unprivileged user via
unshare(CLONE_NEWUSER | CLONE_NEWNET): user namespaces grant
CAP_NET_ADMIN in the new network namespace, which is sufficient to
create dummy devices, attach clsact qdiscs with shared blocks, and
install mirred blockcast filters.

 BUG: TASK stack guard page was hit at ffffc90000b7fff8
 Oops: stack guard page: 0000 [#1] SMP KASAN NOPTI
 CPU: 2 UID: 1000 PID: 169 Comm: poc Not tainted 7.0.0-rc7-next-20260410
 RIP: 0010:xas_find+0x17/0x480
 Call Trace:
  xa_find+0x17b/0x1d0
  tcf_mirred_act+0x640/0x1060
  tcf_action_exec+0x400/0x530
  basic_classify+0x128/0x1d0
  tcf_classify+0xd83/0x1150
  tc_run+0x328/0x620
  __dev_queue_xmit+0x797/0x3100
  tcf_mirred_to_dev+0x7b1/0xf70
  tcf_mirred_act+0x68a/0x1060
  [repeating ~30+ times until stack overflow]
 Kernel panic - not syncing: Fatal exception in interrupt

Fix this by incrementing sched_mirred_nest before calling
tcf_blockcast() and decrementing it on return, mirroring the
non-blockcast path.  This ensures subsequent recursive entries see the
updated counter and are correctly limited by MIRRED_NEST_LIMIT.

Fixes: 42f39036cda8 ("net/sched: act_mirred: Allow mirred to block")
Signed-off-by: Kito Xu (veritas501) <hxzene@gmail.com>
---
 net/sched/act_mirred.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/sched/act_mirred.c b/net/sched/act_mirred.c
index 05e0b14b5773..5928fcf3e651 100644
--- a/net/sched/act_mirred.c
+++ b/net/sched/act_mirred.c
@@ -444,8 +444,12 @@ TC_INDIRECT_SCOPE int tcf_mirred_act(struct sk_buff *skb,
 	tcf_action_update_bstats(&m->common, skb);
 
 	blockid = READ_ONCE(m->tcfm_blockid);
-	if (blockid)
-		return tcf_blockcast(skb, m, blockid, res, retval);
+	if (blockid) {
+		xmit->sched_mirred_nest++;
+		retval = tcf_blockcast(skb, m, blockid, res, retval);
+		xmit->sched_mirred_nest--;
+		return retval;
+	}
 
 	dev = rcu_dereference_bh(m->tcfm_dev);
 	if (unlikely(!dev)) {
-- 
2.43.0


