Return-Path: <netdev+bounces-299389-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tqwyIq7UL2q5HgUAu9opvQ
	(envelope-from <netdev+bounces-299389-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 12:32:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F0C76855D6
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 12:32:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=temperror reason="query timed out" header.from=lzu.edu.cn (policy=temperror);
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299389-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-299389-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 19C1D3016919
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 10:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A33571990C7;
	Mon, 15 Jun 2026 10:31:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net (zg8tmtyylji0my4xnjeumjiw.icoremail.net [162.243.161.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4370B40D586
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 10:31:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781519504; cv=none; b=EakVRwGBjE4tyXscMg2W7p+MUI8x3muQSqFwRyWngb7eDlkiwR4y3vMnVJ/9hQjjhLZPgvZEE97X2LWI2IE6b4ubiwZzJ5ciBlCVLvGEX1pLLJa5E9G5PWceC4W4tja71JhIeXkb8Xwbe6NL5qcyivbAJPNLCPqR4R0WTQh5fcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781519504; c=relaxed/simple;
	bh=A6Cr8/t/bGSOIZJeSzkaWAFO/B5G71kPImAb0vMVRwk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tTv+XqIrOFoxa7yb2XtFpH/L/Y6uLB8uI3igNI1bm9I366/TTWy03NC+8+3UBSSBNup4+hxJaTj4F5RQZWDlNVRuZsEPV8/rzaL75UlL3gtLMefSlwB9dB/XtVLF4vcuAEln9ls1oJis7cipxWRLBtn0fvayt4KEJk3pbZA1r8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn; spf=pass smtp.mailfrom=lzu.edu.cn; arc=none smtp.client-ip=162.243.161.220
Received: from enjou-Legion-Y7000P-2019 (unknown [172.23.56.36])
	by app1 (Coremail) with SMTP id ygmowAB3j7l11C9qBlWIAA--.41455S2;
	Mon, 15 Jun 2026 18:31:17 +0800 (CST)
From: Ren Wei <n05ec@lzu.edu.cn>
To: netdev@vger.kernel.org,
	edumazet@google.com,
	kuniyu@google.com,
	david.laight.linux@gmail.com
Cc: ncardwell@google.com,
	pabeni@redhat.com,
	chia-yu.chang@nokia-bell-labs.com,
	ij@kernel.org,
	yuuchihsu@gmail.com,
	idosch@nvidia.com,
	fmancera@suse.de,
	herbert@gondor.apana.org.au,
	yuantan098@gmail.com,
	zcliangcn@gmail.com,
	bird@lzu.edu.cn,
	bronzed_45_vested@icloud.com,
	n05ec@lzu.edu.cn
Subject: [PATCH net v2 1/1] net: ipv4: bound TCP reordering sysctl writes and MTU probe sizes
Date: Mon, 15 Jun 2026 18:31:18 +0800
Message-ID: <1a5b7e1ef4d70fbad8c8ee0b82d8405f3c964a3d.1781395200.git.bronzed_45_vested@icloud.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ygmowAB3j7l11C9qBlWIAA--.41455S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJF47CFy8Kr1rAFW7Gw18Grg_yoWrAry3pF
	Z0k345tr4rGryxKas7ZFW8Zr1xKr48ZF4ak3s8Gryfuw4DWryxAFn2qFWa9Fyj9rWSkrW3
	Z3WDtr98J3yDAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB01xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
	w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
	IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E
	87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c
	8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_
	Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
	xGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAa
	w2AFwI0_GFv_Wrylc2xSY4AK6svPMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY2
	0_Gr4l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjTRMXdjDUUUU
X-CM-SenderInfo: zqqvvuo6o23hxhgxhubq/1tbiAQETCWouZFIO2QACs9
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299389-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:edumazet@google.com,m:kuniyu@google.com,m:david.laight.linux@gmail.com,m:ncardwell@google.com,m:pabeni@redhat.com,m:chia-yu.chang@nokia-bell-labs.com,m:ij@kernel.org,m:yuuchihsu@gmail.com,m:idosch@nvidia.com,m:fmancera@suse.de,m:herbert@gondor.apana.org.au,m:yuantan098@gmail.com,m:zcliangcn@gmail.com,m:bird@lzu.edu.cn,m:bronzed_45_vested@icloud.com,m:n05ec@lzu.edu.cn,m:davidlaightlinux@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[vger.kernel.org,google.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[google.com,redhat.com,nokia-bell-labs.com,kernel.org,gmail.com,nvidia.com,suse.de,gondor.apana.org.au,lzu.edu.cn,icloud.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[n05ec@lzu.edu.cn,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[n05ec@lzu.edu.cn,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	DMARC_DNSFAIL(0.00)[lzu.edu.cn : query timed out];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,icloud.com:mid,icloud.com:email,lzu.edu.cn:from_mime,lzu.edu.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1F0C76855D6

From: Wyatt Feng <bronzed_45_vested@icloud.com>

Reject invalid `net.ipv4.tcp_reordering` values before they reach TCP
socket state. The sysctl is stored as an `int` but copied into the
`u32` `tp->reordering` field for new sockets, so negative writes wrap
to large values.

With `tcp_mtu_probing=2`, the wrapped value can overflow the
`tcp_mtu_probe()` size calculation and drive the MTU probing path into
an out-of-bounds read. Route `tcp_reordering` writes through
`proc_dointvec_minmax()` and require it to be at least 1. Also require
`tcp_max_reordering` to be at least 1 so the configured maximum cannot
become negative either.

When registering the table for a non-init network namespace, relocate
`extra2` pointers that refer into `init_net.ipv4` so the
`tcp_reordering` upper bound follows that namespace's
`tcp_max_reordering`.

Harden `tcp_mtu_probe()` itself by computing `size_needed` as `u64`.
This keeps the send queue and window checks from being bypassed through
signed integer overflow.

Fixes: 91cc17c0e5e5 ("[TCP]: MTUprobe: receiver window & data available checks fixed")
Cc: stable@vger.kernel.org
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Zhengchuan Liang <zcliangcn@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Suggested-by: Eric Dumazet <edumazet@google.com>
Assisted-by: Codex:GPT-5.4
Signed-off-by: Wyatt Feng <bronzed_45_vested@icloud.com>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
---
Changes in v2:
- Use proc_dointvec_minmax() directly for tcp_reordering and
  tcp_max_reordering, as suggested in review.
- Relocate ipv4 .extra2 sysctl pointers for non-init network namespaces.
- Harden tcp_mtu_probe() by making size_needed a u64.
- v1 link: https://lore.kernel.org/all/42cd30856907350e1b3834a3338364f9828a307b.1780979031.git.bronzed_45_vested@icloud.com/

 net/ipv4/sysctl_net_ipv4.c | 10 ++++++++--
 net/ipv4/tcp_output.c      |  4 ++--
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
index c0e85cc171ae..ca1180dba1de 100644
--- a/net/ipv4/sysctl_net_ipv4.c
+++ b/net/ipv4/sysctl_net_ipv4.c
@@ -1058,7 +1058,9 @@ static struct ctl_table ipv4_net_table[] = {
 		.data		= &init_net.ipv4.sysctl_tcp_reordering,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ONE,
+		.extra2		= &init_net.ipv4.sysctl_tcp_max_reordering,
 	},
 	{
 		.procname	= "tcp_retries1",
@@ -1293,7 +1295,8 @@ static struct ctl_table ipv4_net_table[] = {
 		.data		= &init_net.ipv4.sysctl_tcp_max_reordering,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ONE,
 	},
 	{
 		.procname	= "tcp_dsack",
@@ -1676,6 +1679,9 @@ static __net_init int ipv4_sysctl_init_net(struct net *net)
 				 */
 				table[i].mode &= ~0222;
 			}
+			if (table[i].extra2 >= (void *)&init_net.ipv4 &&
+			    table[i].extra2 < (void *)(&init_net.ipv4 + 1))
+				table[i].extra2 += (void *)net - (void *)&init_net;
 		}
 	}
 
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 6e4bb411dc04..193637a58dcc 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -2687,7 +2687,7 @@ static int tcp_mtu_probe(struct sock *sk)
 	struct sk_buff *skb, *nskb, *next;
 	struct net *net = sock_net(sk);
 	int probe_size;
-	int size_needed;
+	u64 size_needed;
 	int copy, len;
 	int mss_now;
 	int interval;
@@ -2711,7 +2711,7 @@ static int tcp_mtu_probe(struct sock *sk)
 	mss_now = tcp_current_mss(sk);
 	probe_size = tcp_mtu_to_mss(sk, (icsk->icsk_mtup.search_high +
 				    icsk->icsk_mtup.search_low) >> 1);
-	size_needed = probe_size + (tp->reordering + 1) * tp->mss_cache;
+	size_needed = probe_size + (tp->reordering + 1) * (u64)tp->mss_cache;
 	interval = icsk->icsk_mtup.search_high - icsk->icsk_mtup.search_low;
 	/* When misfortune happens, we are reprobing actively,
 	 * and then reprobe timer has expired. We stick with current
-- 
2.47.3


