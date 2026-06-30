Return-Path: <netdev+bounces-303049-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0xM2HL2JQ2qqagoAu9opvQ
	(envelope-from <netdev+bounces-303049-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 11:17:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED496E2060
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 11:17:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qq.com header.s=s201512 header.b=eLMLjOw9;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303049-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303049-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=qq.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6D5BE302B854
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 09:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB533EBF18;
	Tue, 30 Jun 2026 09:13:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out203-205-221-236.mail.qq.com (out203-205-221-236.mail.qq.com [203.205.221.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F213EB0F6
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 09:12:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782810781; cv=none; b=HJd86dB0JymI23xOJKoFWvJhzGzlrJYvS0ndisoB+Kkp2lreJ6T1Le7S2eOy2JyZ6G854E+9reiUFA4s6f/fZFa5pgIIieCGLYDytFLLqg4XkwpOdub9ffIQFwdGwtnGomJPyAZvHhhUzMSp5pl+O+oTqo5cyT7/WVr7/Isvp+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782810781; c=relaxed/simple;
	bh=kySt2e1rfj7LptBox57g7w5ICPrmxbvLWzxRFUNeSIk=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=Td6L7VZVRDYKgyndECbAcDKc7FbP2lB77j8Ua+MCg8ArkxMIsFKNzf4stKpRV3PQtj3yvxl7IWTIMCJsbV1DAHEo9vddksMlPEjlAfyW2L/yEAlEQ780gv3qBdwkwOY2uHIQL0CYBqqaumlVh4yBN1x1oDvi3V1lmpsutiYzfK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=eLMLjOw9; arc=none smtp.client-ip=203.205.221.236
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1782810771; bh=1dfi7biA1sGA59UN+588jwNbvleUJ44ok6h9LBwNWnQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eLMLjOw9BtVwLzyGRzJArQOxUH90D3ZB6VLA/p0qQUsC/Bo27oXGruxKXYANx83Or
	 iY3MmDx5P8RTFpJlqvsP0ZQ07y+IBb3o6KbN+5dHqtPuGOw2ur8R3xGRQW33iv1h8b
	 4RqBQ01uBe/GyxRZ5iK3yCSNn/wSo9zwUPrAqh1s=
Received: from lxu-ped-host.. ([111.198.231.89])
	by newxmesmtplogicsvrszc56-0.qq.com (NewEsmtp) with SMTP
	id 2E201616; Tue, 30 Jun 2026 17:11:34 +0800
X-QQ-mid: xmsmtpt1782810694t6vhyvnda
Message-ID: <tencent_45066D89AD6EF9AED34CA567FA46CA52C606@qq.com>
X-QQ-XMAILINFO: OZZSS56D9fAjxnsilrLdrNDiNIRRjgkkepro8vxPt12NBctPvNYFwCeu81DM9Z
	 OfV9p6l/T41Jd7iuk/0sCvJQp27jU2a8CqX+dbCRmFWqGdxu+EEQZ7Gk/Cy44shP0EY5lPVZoZsg
	 RFQ811puuNOmncYOKpncYqU/JwF8Ue9RIV26QJZCXvJywPog5kzprRTKcagiwtitp9GFnMFF8z9t
	 h7w4NWkt/POpJZylA3b9sfRSlDUHR/vuJxrYENwD1yJ5AiYi+XJ4L75UJLZYBgyqGusmN7ajLlCW
	 9NFj9zHo/XHVAM9ifgBGbcV+ccU/E0N7ihtM4+Lp5GbqqWtjViujRPi5Y63R11szcpGvCTJRiwkD
	 6AUBajf7g16xLSnWyOpIYM2EAr0S7RQhIKK6ATOA9s5UgU3jv5PDZmdE7gsTDZNiOlnxYQjtkCj2
	 97Xa/k+UfZvtFLLZLZMjtOaNFW5QzqYlS5mPpvg02rbpvtuCtb+tEF1zD2qi3dP+lVL5Cbe9zEhE
	 wveQsB403beKq0POyjCojG3k/BOsFbX1UdWKePkSYqRtp4CmpU1zJWgVh7qfVOwMYGWAbLxs8FD5
	 Q/+pN7MdZtvkqN8Uo9DZrBZorS2st0JEArCr93+un1raqkMAm3h7CTxVGWfAjfKSWN8Z5ZdMe1tc
	 MbWkNbDrDk8+1/8Ym78hvkm3h3Jia8BRDj5docEiLxwl61qZdvPUfm4zQuvfWwN0Q46HsRwxyNpn
	 HZQMCKTHaE7zXWO/1ph8+/79fu0Gc0CtlND9QzPNE9lzuBWiqjN3bkCujGPE0sOSr/8fIobtQuaA
	 rL/c8paAMIVVptF02XVSEr1oY81Ab/PC3Jun55jNC9DZkuifWxRv58UbfLJ+cejVWYOqD+5UCtvy
	 f1ImAa15F0cNqwm8GMuYv7lNkDWxto5R3zvXi3cCPLXp4zkx7DOPsIdOxtqDKSmPAjB2ej69Edvc
	 5N17TF5nSxzg9M4FDGwmgneHMHLOX+5BQhU6u4xfybG/+9FsHip+ukJJWZz+Y8/hkmu08AFTVUXv
	 95VN6HYt64DzETfL1I7GdlAbO0DQDMcShe97JLS31So/nlglm89spHRfvsH62SFGqnMlDUZ+ulWY
	 9yVaYr
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
From: Edward Adam Davis <eadavis@qq.com>
To: sashiko-bot@kernel.org
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
Subject: [PATCH v2] bpf: Fix smp_processor_id() call trace for preemptible kernels
Date: Tue, 30 Jun 2026 17:11:33 +0800
X-OQ-MSGID: <20260630091132.941145-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260630084910.D5C3A1F000E9@smtp.kernel.org>
References: <20260630084910.D5C3A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qq.com,quarantine];
	R_DKIM_ALLOW(-0.20)[qq.com:s=s201512];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-303049-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,iogearbox.net,gmail.com,etsalapatis.com,linux.dev,googlegroups.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[eadavis@qq.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:sashiko-bot@kernel.org,m:andrii@kernel.org,m:ast@kernel.org,m:bpf@vger.kernel.org,m:daniel@iogearbox.net,m:eddyz87@gmail.com,m:emil@etsalapatis.com,m:jolsa@kernel.org,m:linux-kernel@vger.kernel.org,m:martin.lau@linux.dev,m:memxor@gmail.com,m:netdev@vger.kernel.org,m:song@kernel.org,m:syzkaller-bugs@googlegroups.com,m:yonghong.song@linux.dev,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eadavis@qq.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qq.com:+];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[qq.com];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,qq.com:dkim,qq.com:email,qq.com:mid,qq.com:from_mime,vger.kernel.org:from_smtp,syzkaller.appspot.com:url,appspotmail.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0ED496E2060

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

this_cpu_ptr() access needs to be guarded against preemption.

Fixes: 5af6807bdb10 ("bpf: Introduce bpf_mem_free_rcu() similar to kfree_rcu().")
Reported-by: syzbot+fd7e415d891073b83e1f@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=fd7e415d891073b83e1f
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
v1 -> v2: using guard against preemption

 kernel/bpf/memalloc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index bd45dda9dc35..1d7ddfc1c9d1 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -957,7 +957,9 @@ void notrace bpf_mem_cache_free_rcu(struct bpf_mem_alloc *ma, void *ptr)
 	if (!ptr)
 		return;
 
+	get_cpu();
 	unit_free_rcu(this_cpu_ptr(ma->cache), ptr);
+	put_cpu();
 }
 
 /* Directly does a kfree() without putting 'ptr' back to the free_llist
-- 
2.43.0


