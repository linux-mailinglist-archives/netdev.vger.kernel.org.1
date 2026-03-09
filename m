Return-Path: <netdev+bounces-265534-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uEDsLi7ArmlEIgIAu9opvQ
	(envelope-from <netdev+bounces-265534-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 13:42:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D6387239035
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 13:42:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2E5DB30488D1
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 12:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957A43AEF52;
	Mon,  9 Mar 2026 12:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IsDbB9KX"
X-Original-To: netdev@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190343AEF3F
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 12:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773059979; cv=none; b=QmzokqFh6C3Y5+eBlBpyvY3S4fO/AV8i7/Yp1LCKuMZDLpjoEyfbT7uaYl5eqGZr9LjCcp8hOWCmukvRXZKCYco9m4yshFfKSamhNrOtRnTAzE+To5z8H2JvNZMR4tJkU7hKz0Y4vV1akkbYIFe1P5o+laORn0UocfXIw+imJNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773059979; c=relaxed/simple;
	bh=K0B+9CgesUCAtvj8Cvvkj7KcgdWQMEdRLu/B1U2WzuA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ug75IY+acMxsRRLKeeTtb/Sx8KmFh/3hMPHdEWs+fyRMyeACsfy8Pwb67E7On3CL8pmQLTlBZcP1PVJxfB8oZZmwlNcfWz3GQ0eaAPPVyamp3+JFquQh449Hvsw8Wyg8rAZbqxhxLZVaMwMqMf2wiM7nVsxes6qWWqClZt9dhfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IsDbB9KX; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773059966;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KEmp/me7gtMmg7DycYcIv6LHKVCKwSXM1LEKVU8XNbI=;
	b=IsDbB9KXNMVr7fZJ6tIlj/Y4Sq1eXEXwH3vX+plFDSs9GXDdXQPClbSM+s6r1VzuhdjVJP
	M6XZABrhRcIaCgX6LBrraNGWAdIyjn/XssVeH8g7uoxfZPa7NP2tvNWtOxxdn/5/UAaGJX
	PIM4txdecoos+1Ak40tjprslyLRdJb4=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: netdev@vger.kernel.org,
	horms@kernel.org,
	gustavoars@kernel.org
Cc: Jiayuan Chen <jiayuan.chen@shopee.com>,
	syzbot+d5ace703ed883df56e42@syzkaller.appspotmail.com,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH net-next v2] net: sched: cls_u32: Avoid memcpy() false-positive warning in u32_init_knode()
Date: Mon,  9 Mar 2026 20:39:16 +0800
Message-ID: <20260309123917.402183-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: D6387239035
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-265534-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.991];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,d5ace703ed883df56e42];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,syzkaller.appspot.com:url,shopee.com:email,linux.dev:dkim,linux.dev:mid,appspotmail.com:email]
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
Reviewed-by: Simon Horman <horms@kernel.org>
Acked-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>

---
v1 -> v2 : Drop unnecessary commit message
https://lore.kernel.org/netdev/20260309121240.GH461701@kernel.org/T/#t
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


