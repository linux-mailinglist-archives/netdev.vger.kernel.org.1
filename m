Return-Path: <netdev+bounces-303178-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TqULECvAQ2oqggoAu9opvQ
	(envelope-from <netdev+bounces-303178-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 15:10:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D9D26E4A55
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 15:10:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qq.com header.s=s201512 header.b=NRTwWo8i;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303178-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303178-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=qq.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CDD31302C5E4
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 13:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D92D4413D8E;
	Tue, 30 Jun 2026 13:09:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out203-205-221-209.mail.qq.com (out203-205-221-209.mail.qq.com [203.205.221.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4F8406829;
	Tue, 30 Jun 2026 13:09:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782824999; cv=none; b=WkOENgiQkr9fhh81/CIjLcaSdEDRlxENMlSfs1caTsOKrPcNMy3b1YRjFE+t5bS9Eq4FZUhuvuOSSOxq2V0QKg+rBOUokwnOLzWYrnFjcM43R5QIU81CI/9ateuN7bNzlPLRIaMxNiOedCTXqSiQCHSZ6DUlA6wz/MUKg8IZumk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782824999; c=relaxed/simple;
	bh=dnu21409BfWniyjA2dNfWjGlJbexQMqKOmfzZid0lQo=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=ooihhOHxLIn2GEk62jPHzknOI0YyKuPAwP8JEBXa3fpQeoHu4elUeLYEPhyABIQYam6LD5edlQEhcj5J49ydPSXU7NDEuYeheVjSE1pKwhTYimSPogRc9J2m+AUnmAD0uAVLalajA7t/fqEHu7ft0vy4pVO5P/Zr6/ccG6TyMWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=NRTwWo8i; arc=none smtp.client-ip=203.205.221.209
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1782824994; bh=7HskIzzUHXw3md6kiQ2qF8NTdxNXoTsE1DQjR31NoGw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NRTwWo8iP6U+iF/5XtXFPYDxL0Nl30ykl37rvcLZjNQTIEAMYlGhQaXoMBnjVBOcr
	 LHY1cFxcFuJdxPZBY6wyNwlOxwqZ6sfTZYq20Jt/iIoehf0WqPtcUNTAsYADFTX7gX
	 zBzY2VE/8R3iH/oGMGZxmuJOMZjtBuTuSUre4Pe8=
Received: from lxu-ped-host.. ([111.198.231.89])
	by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
	id 2720E82B; Tue, 30 Jun 2026 21:09:50 +0800
X-QQ-mid: xmsmtpt1782824990tfudmil50
Message-ID: <tencent_4F9E5F1B854B1D1BB42574BA76BB5133BF08@qq.com>
X-QQ-XMAILINFO: MZg/qcWmVFFr2+zJK0Ieu9UNm2IFC9pNiLCARFSy6AdxMgyfPOh0P6+id5WEFX
	 KMfw/4BtJYG2OkuEzNAefUcXoIDtRr+qMrebpxPxiwN8Z1bnMH/A1o/g/LcongHpQS8i47FHv8Ir
	 mu+ej7SA9cV5hp8Ur5V35wlpBb4fp9QTRfYpZc9zyVM0jeq64ZOInrDLimC4C71/W4l4q+gr8uEa
	 dFV1GZbDgnNkgjTQHjClZoFzjYvG8hgBOM7V/I2c80+O+PI0o87dBbPd75p8giI82a9nm0ne2Oyq
	 LxuVt0hv0dhEg9W2Lz6ElZH7gMwcPHK33r5NaulpqweMeZ27WtiMTi0vWIyvxtFndp+vHPUXfW0P
	 NjLDhW/OfRxzL+9PDln2dfmi4+4XO6RuAZe4aoMAuW4kssKzvtVU7tyqm8uGKtQtO1eL03rEJuDL
	 JjGcFf6VrlP2+vnaBTgzOQyxl0JNHqkjodowP9wwbnFMSbfwhC5rEUqAoXbtdjvWQFEr2Lvqtt7q
	 dbqlDt/A1hKPZn1Nhp9F0AeaAtD5CCUGeU24U4peZxZJCGwLXSMrY5jIOTtuy01eQwZLOIbvkIHG
	 wk4wEZ5XGwwYusGS/xAnl1aT7GxJLxrxP1obSz9O7EmrT5ZPdEw9zB/13xwG2BIdu7c02Ntco+YB
	 guH1MdyJ55g37438y79w90yaLqt3T3DuaT26M0YI9peyYHtD4UPTBME9LjhH4oO7YMCkqfeiJDUL
	 3ii72B/YxWC6nrxm3HP+p624xSOC7ebYZXWLmP16E0Od2soH4AYL9H5xpWntrjagl7hwqhF99mnq
	 +ZmpagotP8wFPRsKx+TVk71o/KdCBWDJ0MpkBstfZjdhH8/uHrlSpRKhkF4AL0qYjFOqnFEyknl7
	 aWxphlWuvA9vIq8tpkOcaKxN4qnvN/im75OAOwtsQVqaIK7+4x3QT0tyzkj6yVZaMAbYv70ZK8uv
	 WR6D9zlit4Tzezg7Wjk0Zt/OO7oHO5cwU4cQkRQw5afZtdQ/2jrlqfraGVU87PkC0tFJFlggj8Bj
	 tV8K3p6biIlFj/qiJfowAVBnEMr730ebrfPD0/bTFSCShPG0GXdaAEPNe/fmZg8+EZeIq8AqxGkO
	 LZCa5VtGtbGWRza6pXGGgVDstqKMMhzbIkSdyc1XYE0k0hT7Y=
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
From: Edward Adam Davis <eadavis@qq.com>
To: eadavis@qq.com
Cc: jiayuan.chen@linux.dev,
	sashiko-bot@kernel.org,
	sashiko-reviews@lists.linux.dev,
	andrii@kernel.org,
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
Subject: [PATCH v3] bpf: Fix smp_processor_id() call trace for preemptible kernels
Date: Tue, 30 Jun 2026 21:09:50 +0800
X-OQ-MSGID: <20260630130949.954947-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <tencent_B6259ABAF5BB63335B9E3C1BB74B071BD608@qq.com>
References: <tencent_B6259ABAF5BB63335B9E3C1BB74B071BD608@qq.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-303178-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:eadavis@qq.com,m:jiayuan.chen@linux.dev,m:sashiko-bot@kernel.org,m:sashiko-reviews@lists.linux.dev,m:andrii@kernel.org,m:ast@kernel.org,m:bpf@vger.kernel.org,m:daniel@iogearbox.net,m:eddyz87@gmail.com,m:emil@etsalapatis.com,m:jolsa@kernel.org,m:linux-kernel@vger.kernel.org,m:martin.lau@linux.dev,m:memxor@gmail.com,m:netdev@vger.kernel.org,m:song@kernel.org,m:syzkaller-bugs@googlegroups.com,m:yonghong.song@linux.dev,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[linux.dev,kernel.org,lists.linux.dev,vger.kernel.org,iogearbox.net,gmail.com,etsalapatis.com,googlegroups.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[eadavis@qq.com,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[qq.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[qq.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eadavis@qq.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qq.com:+];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qq.com:dkim,qq.com:email,qq.com:mid,qq.com:from_mime,appspotmail.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0D9D26E4A55

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
v2 -> v3: replace get/put_cpu() to bpf_disable/enable_instrumentation()

 kernel/bpf/hashtab.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 9f394e1aa2e8..d3f2f8a379e8 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -3299,6 +3299,7 @@ static int __rhtab_map_lookup_and_delete_batch(struct bpf_map *map,
 	dst_val = values;
 	total = 0;
 
+	bpf_disable_instrumentation();
 	rcu_read_lock();
 
 	/*
@@ -3313,6 +3314,7 @@ static int __rhtab_map_lookup_and_delete_batch(struct bpf_map *map,
 		elem = rhtab_lookup_elem(map, cursor);
 		if (!elem) {
 			rcu_read_unlock();
+			bpf_enable_instrumentation();
 			ret = -EAGAIN;
 			goto free;
 		}
@@ -3350,6 +3352,7 @@ static int __rhtab_map_lookup_and_delete_batch(struct bpf_map *map,
 	}
 
 	rcu_read_unlock();
+	bpf_enable_instrumentation();
 
 	if (total == 0) {
 		ret = -ENOENT;
-- 
2.43.0


