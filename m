Return-Path: <netdev+bounces-303039-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1j1hCGSBQ2rRZQoAu9opvQ
	(envelope-from <netdev+bounces-303039-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 10:42:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2851B6E1BE3
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 10:42:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qq.com header.s=s201512 header.b="f/UhJW1O";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303039-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303039-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=qq.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 92EBE3012CAD
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 08:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B39952EEE91;
	Tue, 30 Jun 2026 08:42:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9062D8DDF
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 08:41:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782808927; cv=none; b=dFJKI5DnxkPAuQnzgQN8S6oja2BKw3FwuGkMzl58Eoqc8Z1Ufrs5AxrKAPoGAnFoeWGMcm+a7wNj0lLCyULefpI5w6ZW4sMJTqdcHLHxURIDVlBmdTffDlAEUWvxg43EkbV7wv1RW++Es2pptayctBIYO62OenOi/YUTfB09eFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782808927; c=relaxed/simple;
	bh=ZfX+WUlidGt3MD9RKL56uLQHVqdQY9yPw3YfZBPiEmw=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=Kbv+e9dIy2YJWufnae1of8bWHK2sibtO2OyzSYTmOXMFuKQbb3bDR9edVJxRr7cQDQFgkCOrHDP/5p0K0kCAF1lR4wOXE5CmXKQvVtst+l2C+upEpUVgchJcXKGXXOeZP6ZqSA742GDaPw+PPrKTvWkxs0xNYPS7u0ZflYhqwEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=f/UhJW1O; arc=none smtp.client-ip=162.62.57.137
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1782808912; bh=PgRWuavyvpcMX6a1mtBTkd77HNcfXSkaUDGACw6U90c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=f/UhJW1OAGKo3j7rkLAdm5+QtQ9alnIt/PUBTKkjG8FizMidQMgERc9N+S4+DR48J
	 mlI4zp+28fEvZoFMnkLbpAANSRug0dPXfiH5sirvpgQKlH3NgPct6/dCzYvQcFqacJ
	 fF/6WWoODJ/8PuNnHsXO1goatrbQPvxFlE1lDMig=
Received: from lxu-ped-host.. ([111.198.231.89])
	by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
	id A70A549F; Tue, 30 Jun 2026 16:41:48 +0800
X-QQ-mid: xmsmtpt1782808908tg9sujbui
Message-ID: <tencent_C4C3064909A16EDCAEDB0C8767D886D01206@qq.com>
X-QQ-XMAILINFO: OVFdYp27KdlJKjm/DmkFv2Zcms1KQYsBE/KFXP5xNItufkG88nBulvvPq39P0y
	 ZZ5FzOPXrTsJZiV28EKON9rArzcCq3ZRv7qoiVDQ2ARMRH9RLvOuF7spsBzyAlBVWh3OZ7h1i1Dt
	 ekefuTX+GiCYntHA4SZENZ76AlsCmILx2k3PPV/ySXCnMqSS7fhzpbnK/KgoW9IKhxaqVIaOHBst
	 Hf50O8ZQEjkhBqXeUz8H1lsYVwFGPKRp1OkWAfQ6zI2w2O+OqsauVHNOJwOmbmtNOtwp++v3MFiT
	 EegC5f8zENP3viKP1/oRNxY8y4xOHfgSdkxGS4MOpEGwV8GjjUQuAvgO0pY4WvOjenzvTtqZo4kr
	 BRpoG99aExz7JK6jOgDTMEO+ynhn4lwZQQ1+ooq30GePYXZMw8ML6uPnCEs0tZpP1bouVEGdVgQ9
	 d+AHHrw/uPUmFe9NedxzWfmDUOWUYUc1igCit1ZylOcTDrX3Ce4aAr39qbuHBUiS+dcOyTFqOGJU
	 q7v/jgZzpRrGfXAh2lGTTaTezeCLywlUDK/aS1YojpY820EAV3Hmd20Omun3+kv+glJzvlU/J/iB
	 8KS87AX9EapvR8Q1m8/sJaImnDutYRqN7qSM12162jju0QyYQXOxwQGDrbCwQmQ73TWzu9FWc7Ld
	 140zx9Fx745alcEUbNUY4BNWdIhWu8NpHDeWvdG7b/oYVA8tPq7rGTJQOqSshE1fwacEnHGUI/lF
	 kgRZVuKylrEhkC04l7uS59De7aZf1uqE3NvNlkBw2k84Bj4oEdIfo0MbK9nUJyuY6nJWrPqlqegb
	 Xr4Bej+xa22qAHDlIqThIxzEyFfLuFi6lEDQ1kz3AjF9bhXINzemUGR8OnlcxCstXQXCcuOKRc9P
	 WUnhK5SkB+156JnO/9bCOWcff1OZwFBn36nVZYfxnsFc+ER5saG6ScZNMAdhYEyaAUZ99L0tS9cB
	 y5HgiZ8mTb81IZ8zZimQ86JEyk4Fz2xB5XdYYE3uIIwZF8ApR/OG5D4tsKmqIrYHWZiIwrRmwfG3
	 TfF4cJ3gvJevyddGCE
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+fd7e415d891073b83e1f@syzkaller.appspotmail.com
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	emil@etsalapatis.com,
	jolsa@kernel.org,
	linux-kernel@vger.kernel.org,
	martin.lau@linux.dev,
	memxor@gmail.com,
	netdev@vger.kernel.org,
	song@kernel.org,
	syzkaller-bugs@googlegroups.com,
	yonghong.song@linux.dev
Subject: [PATCH] bpf: Fix smp_processor_id() call trace for preemptible kernels
Date: Tue, 30 Jun 2026 16:41:49 +0800
X-OQ-MSGID: <20260630084148.938854-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <6a436023.b42ede87.8e801.0003.GAE@google.com>
References: <6a436023.b42ede87.8e801.0003.GAE@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qq.com,quarantine];
	R_DKIM_ALLOW(-0.20)[qq.com:s=s201512];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER(0.00)[eadavis@qq.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-303039-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:syzbot+fd7e415d891073b83e1f@syzkaller.appspotmail.com,m:andrii@kernel.org,m:ast@kernel.org,m:bpf@vger.kernel.org,m:daniel@iogearbox.net,m:eddyz87@gmail.com,m:emil@etsalapatis.com,m:jolsa@kernel.org,m:linux-kernel@vger.kernel.org,m:martin.lau@linux.dev,m:memxor@gmail.com,m:netdev@vger.kernel.org,m:song@kernel.org,m:syzkaller-bugs@googlegroups.com,m:yonghong.song@linux.dev,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,iogearbox.net,gmail.com,etsalapatis.com,linux.dev,googlegroups.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[qq.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eadavis@qq.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qq.com:+];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,fd7e415d891073b83e1f];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,appspotmail.com:email,vger.kernel.org:from_smtp,qq.com:dkim,qq.com:email,qq.com:mid,qq.com:from_mime,syzkaller.appspot.com:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2851B6E1BE3

bpf_mem_cache_free_rcu() maybe called in preemptible context, this
will trigger the below warning message:

BUG: using smp_processor_id() in preemptible [00000000] code: syz.0.17/5820
caller is bpf_mem_cache_free_rcu+0x48/0xc0 kernel/bpf/memalloc.c:954
Call Trace:
 check_preemption_disabled+0xd3/0xe0 lib/smp_processor_id.c:47
 bpf_mem_cache_free_rcu+0x48/0xc0 kernel/bpf/memalloc.c:954
 rhtab_delete_elem+0x185a/0x1b30 kernel/bpf/hashtab.c:2969
 __rhtab_map_lookup_and_delete_batch+0x935/0xcb0 kernel/bpf/hashtab.c:3349
 bpf_map_do_batch+0x445/0x630 kernel/bpf/syscall.c:-1
 __sys_bpf+0x906/0xd90 kernel/bpf/syscall.c:-1

this_cpu_ptr() calls smp_processor_id() in a preemptible context.
Fix by using per_cpu_ptr() with raw_smp_processor_id() instead.

Fixes: 5af6807bdb10 ("bpf: Introduce bpf_mem_free_rcu() similar to kfree_rcu().")
Reported-by: syzbot+fd7e415d891073b83e1f@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=fd7e415d891073b83e1f
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 kernel/bpf/memalloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index bd45dda9dc35..151d9c8183bc 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -957,7 +957,7 @@ void notrace bpf_mem_cache_free_rcu(struct bpf_mem_alloc *ma, void *ptr)
 	if (!ptr)
 		return;
 
-	unit_free_rcu(this_cpu_ptr(ma->cache), ptr);
+	unit_free_rcu(per_cpu_ptr(ma->cache, raw_smp_processor_id()), ptr);
 }
 
 /* Directly does a kfree() without putting 'ptr' back to the free_llist
-- 
2.43.0


