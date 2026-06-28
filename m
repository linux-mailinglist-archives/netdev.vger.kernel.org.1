Return-Path: <netdev+bounces-302388-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PHWqBr8HQWpmkQkAu9opvQ
	(envelope-from <netdev+bounces-302388-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 28 Jun 2026 13:38:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D0D16D3B0E
	for <lists+netdev@lfdr.de>; Sun, 28 Jun 2026 13:38:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302388-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-302388-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EDD93300D854
	for <lists+netdev@lfdr.de>; Sun, 28 Jun 2026 11:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C33352005;
	Sun, 28 Jun 2026 11:38:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from zg8tmja2lje4os4yms4ymjma.icoremail.net (zg8tmja2lje4os4yms4ymjma.icoremail.net [206.189.21.223])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0096433B6C4
	for <netdev@vger.kernel.org>; Sun, 28 Jun 2026 11:38:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782646710; cv=none; b=rSFRWH0YZVzPzevZcKB+VtdEQ1L0BxNpKdQvyosm3PLgMZi9n5ngYxQu3cUy8rpWzsd/O25waZqkjjjon3E86ssK6rb5Y+jhv/kRb1RQ/GO4BRsGcJXk9ZM8M+fXrVUuoBdGEtE7+tXN42vB/jEfw2HZNsqs8k86//WsuRbPqGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782646710; c=relaxed/simple;
	bh=dT0x9zKduV0I8BZNm3gs09ipQRXhjy21+kdREAJTsFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CSHUw20WqzoWdvPh2vVatBSfPyqtp1YDnFpIPC2QKXUX/B/9yr3HEwU5x+szPtW1fam4bzVagef+q1Pd/BVknjCHdUk2NAHa1YgKOx/Q+OejJ//x1e7Jw1nROgJ7TPG+1+cVxhmgG2z7DGGe+3YlJeX/i3yEHbrt27oCq8DIfVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn; spf=pass smtp.mailfrom=lzu.edu.cn; arc=none smtp.client-ip=206.189.21.223
Received: from enjou-Legion-Y7000P-2019 (unknown [172.23.56.36])
	by app1 (Coremail) with SMTP id ygmowAC31L6TB0FqVwG_AA--.53723S3;
	Sun, 28 Jun 2026 19:38:03 +0800 (CST)
From: Ren Wei <n05ec@lzu.edu.cn>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	chia-yu.chang@nokia-bell-labs.com,
	ij@kernel.org,
	idosch@nvidia.com,
	fmancera@suse.de,
	bronzed_45_vested@icloud.com,
	yuuchihsu@gmail.com,
	kuniyu@google.com,
	yuantan098@gmail.com,
	yifanwucs@gmail.com,
	tomapufckgml@gmail.com,
	bird@lzu.edu.cn,
	roxy520tt@gmail.com,
	n05ec@lzu.edu.cn
Subject: [PATCH net 1/1] tcp: Require init_net CAP_NET_ADMIN for tcp_child_ehash_entries
Date: Sun, 28 Jun 2026 19:37:38 +0800
Message-ID: <012fba43272abc560acfc0fa37ae22182a60b457.1782641525.git.roxy520tt@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1782641525.git.roxy520tt@gmail.com>
References: <cover.1782641525.git.roxy520tt@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ygmowAC31L6TB0FqVwG_AA--.53723S3
X-Coremail-Antispam: 1UD129KBjvJXoWxJF17WrW5GrW5WFW5JrWfGrg_yoW5Ar15pF
	WFkryUKrZ8GF17KFn2vw4ftF17Ww4kXr47Cr92gwnFvwnIgr92yFsYgrySqFnFkrW2kFWY
	vFW2yan8Gw45ZrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBY1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
	w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
	IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E
	87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c
	8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_
	JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
	xGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAa
	w2AFwI0_GFv_Wrylc2xSY4AK6svPMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY2
	0_Gr4l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I
	0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUU0zuJUUUUU==
X-CM-SenderInfo: zqqvvuo6o23hxhgxhubq/1tbiAQsMCWpA2VUB6gAAsC
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-302388-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[lzu.edu.cn];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:chia-yu.chang@nokia-bell-labs.com,m:ij@kernel.org,m:idosch@nvidia.com,m:fmancera@suse.de,m:bronzed_45_vested@icloud.com,m:yuuchihsu@gmail.com,m:kuniyu@google.com,m:yuantan098@gmail.com,m:yifanwucs@gmail.com,m:tomapufckgml@gmail.com,m:bird@lzu.edu.cn,m:roxy520tt@gmail.com,m:n05ec@lzu.edu.cn,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,redhat.com,kernel.org,nokia-bell-labs.com,nvidia.com,suse.de,icloud.com,gmail.com,lzu.edu.cn];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[n05ec@lzu.edu.cn,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[18];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[n05ec@lzu.edu.cn,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,lzu.edu.cn:from_mime,lzu.edu.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9D0D16D3B0E

From: Zhiling Zou <roxy520tt@gmail.com>

tcp_child_ehash_entries controls the size of the private TCP established
hash table allocated for subsequently created child network namespaces.
The value is consumed during child netns creation by tcp_set_hashinfo()
and passed to inet_pernet_hashinfo_alloc(), which can allocate a large
per-netns ehash.

The sysctl is writable in each network namespace, and net sysctl
permissions allow a task with CAP_NET_ADMIN in the namespace's owning
user namespace to write it.  An unprivileged user can therefore create a
user and network namespace, set tcp_child_ehash_entries to its maximum
value, and repeatedly create nested network namespaces to force large
kernel allocations and exhaust host memory.

Require CAP_NET_ADMIN in the initial user namespace before accepting
writes to tcp_child_ehash_entries.  This keeps the tuning knob available
to the host administrator while preventing unprivileged user namespaces
from using it to drive host-wide memory consumption.

Fixes: d1e5e6408b30 ("tcp: Introduce optional per-netns ehash.")
Cc: stable@vger.kernel.org
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Assisted-by: Codex:gpt-5.4
Signed-off-by: Zhiling Zou <roxy520tt@gmail.com>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
---
 net/ipv4/sysctl_net_ipv4.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
index ca1180dba1de..1cad1b5cb826 100644
--- a/net/ipv4/sysctl_net_ipv4.c
+++ b/net/ipv4/sysctl_net_ipv4.c
@@ -9,6 +9,7 @@
 #include <linux/sysctl.h>
 #include <linux/seqlock.h>
 #include <linux/init.h>
+#include <linux/capability.h>
 #include <linux/slab.h>
 #include <net/icmp.h>
 #include <net/ip.h>
@@ -415,6 +416,16 @@ static int proc_tcp_ehash_entries(const struct ctl_table *table, int write,
 	return proc_dointvec(&tbl, write, buffer, lenp, ppos);
 }
 
+static int proc_tcp_child_ehash_entries(const struct ctl_table *table, int write,
+					void *buffer, size_t *lenp,
+					loff_t *ppos)
+{
+	if (write && !capable(CAP_NET_ADMIN))
+		return -EPERM;
+
+	return proc_douintvec_minmax(table, write, buffer, lenp, ppos);
+}
+
 static int proc_udp_hash_entries(const struct ctl_table *table, int write,
 				 void *buffer, size_t *lenp, loff_t *ppos)
 {
@@ -1524,7 +1535,7 @@ static struct ctl_table ipv4_net_table[] = {
 		.data		= &init_net.ipv4.sysctl_tcp_child_ehash_entries,
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
-		.proc_handler	= proc_douintvec_minmax,
+		.proc_handler	= proc_tcp_child_ehash_entries,
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= &tcp_child_ehash_entries_max,
 	},
-- 
2.43.0


