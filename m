Return-Path: <netdev+bounces-303965-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gGhmBZ7qRWqbGgsAu9opvQ
	(envelope-from <netdev+bounces-303965-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 06:35:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A92D6F36DB
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 06:35:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qq.com header.s=s201512 header.b="r/PzeJEb";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303965-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303965-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=qq.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A83A1301690C
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 04:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B7134E745;
	Thu,  2 Jul 2026 04:35:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out203-205-221-235.mail.qq.com (out203-205-221-235.mail.qq.com [203.205.221.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8FC1231A3B
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 04:35:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782966919; cv=none; b=Ee/AsUlbAsrn4zWWrDHXa/iEJjJqX/rdSG5rHShERSYRZ6ZTh8WTzKZIKkw3DD/ds99q4T8SNLwOfIJLQtoNcMiT2WtxoBrw0bsWwKsp0tD8/5OmAPZKdliKMbBU3b2+lPpnA+KM7r6yHdb5PTMlk1c/9gyxMQBoIyjPCV8Lf/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782966919; c=relaxed/simple;
	bh=3u6EvztuLUlA+ejRxZatA6N+wbu2IiMs7KXilJNbVk4=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=g9NPObCFy9ODXR4xwQOLXpOVU1XJWv4cda36a5c55r22yAVT5L/bDbt3YVtW1SQkc55tYCBTRFljKxtUvJQ7NjygrkVihUYzyiIWfXJTqbV4yEM9cioe3LKgoKUZlsxENs7Hx3R/3CXvpQtA8Z2LoOgSy76EebP7co9KLL81piI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=r/PzeJEb; arc=none smtp.client-ip=203.205.221.235
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1782966894; bh=t1GNANpFuzLE/PYGoogesdPNStNh8vPbm2FDGBZNhLk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=r/PzeJEbRkxUDEkqnJ660hHMqI7SYRjhgFpRl6gS+6hrhyp4vVF3e2NSA9lLfyO2u
	 euT1nQF4bKCVJq2uV0LUp1bcK4IVIQaKAFTY1LrLx5+n4p+xfpxfwSYlCKslT+LcRh
	 Y9N0RqvQttB2Hpo3R3c3gmTHIOD/arc/VL32caOM=
Received: from lxu-ped-host.. ([111.198.231.89])
	by newxmesmtplogicsvrsza53-0.qq.com (NewEsmtp) with SMTP
	id 8B10EACB; Thu, 02 Jul 2026 12:34:49 +0800
X-QQ-mid: xmsmtpt1782966889tpm5fdqw5
Message-ID: <tencent_30FB52DFC6440984EEF0EEC70C90A7DAC606@qq.com>
X-QQ-XMAILINFO: NAuAIaytDrXppw3uhnqACGI+GTfyRfCrUZI81C+oro9C457KCvnVIieR7bgYrO
	 l46J0Yh1z6Y+FMKPn1PaHc9JNECPabpNNua0y7gzYBBTKgaw/5IEQ+UuW/SkTHmdcI+o8XkghSVA
	 7qlRxQPchEH/z2zhmDwJSjzgqp6neHrDSy0Bq/Wz4hLaNnPk2Tex7ReBlRMeSVOpZugc4FjV0j1n
	 9MzE/qZQROb4wCLZ2zOKF2vBAAfTjt1k6x05Yi4sIjESNqvzNYq1tgqaf6YyVysxP6AxdmJiXBDI
	 2te7+BEgIDcNQMGdRq7xKVr/cTwQYppJZsUfNxm9irzAKvrNex7R+eWqvvjspczhJsX089HwW7xM
	 iDeeOF1BIa4xVCJ7QaM3435QGCIDGB539ttTKOpCOxMbaGxSwKQq5M/TP6YylfyR1+9+gXv0Ke3W
	 X6CwuS2p1ljngDK8MyVMqnYhW2Dok357WIBGfDySpgNfDutYKINhOESF40cv364CFl5TvExNqzcO
	 DFY2xrnCuENUVu5gONmsSpTBVke63FFiS+buyl8Ba4dG56x9qx53wVsYtcQgkGlNLL8rD0m4IuJE
	 C+JpCfAzgY6CuyNRx8BURm46FfSNNNA4v1+rQ68IlEGavh+BVYFRnTz2Jg3qM6N7pLyFE2Y82qYk
	 MkI3lHgQxsHNWUuCvoIqrKrVLUpYkYQRKnWjdp9caegTvn5XANVdG2z4XsVNJ/Eu1sgEhlYzcTvE
	 dVon1LaJ5SP49xQYzDGX05jotyTLUEtoRzlINz/JK2JaBuvjegBjRg6hTYY2mELly6SQR+lneIab
	 t+d8Zw368u1mnqw2rjjCRCFj1Uij8zCOCRsOUjbqhupxVfDmYx4kWWtCWPJSBV2VI930DDG3slZa
	 lHggq1fam3x9v5P9bR1czk2G026GoUmBYydKWv3A9JY2mokZqMMV7zMZ/PufAfY9A3AI0exqJubD
	 s/dtOAkg3LlQXYLVuyjSixbvNJj+um6jzXbwKZ2rZvr3fsZpgsAdP/7XtUCKr00wbWmjfZyL+2PH
	 35iRCWsXfXT60trK5wBXoUVLi5mu31Juq+RZ60cA==
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
From: Edward Adam Davis <eadavis@qq.com>
To: andrii.nakryiko@gmail.com
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	eadavis@qq.com,
	eddyz87@gmail.com,
	emil@etsalapatis.com,
	jiayuan.chen@linux.dev,
	jolsa@kernel.org,
	linux-kernel@vger.kernel.org,
	martin.lau@linux.dev,
	memxor@gmail.com,
	netdev@vger.kernel.org,
	sashiko-bot@kernel.org,
	sashiko-reviews@lists.linux.dev,
	song@kernel.org,
	syzkaller-bugs@googlegroups.com,
	yonghong.song@linux.dev
Subject: Re: [PATCH v5] bpf: Fix smp_processor_id() call trace for preemptible kernels
Date: Thu,  2 Jul 2026 12:34:50 +0800
X-OQ-MSGID: <20260702043449.1021846-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAEf4Bzb+OOrdGyxbzjh=7MUEbA5FC05E6_iwCjDXcnSO-HZ=ig@mail.gmail.com>
References: <CAEf4Bzb+OOrdGyxbzjh=7MUEbA5FC05E6_iwCjDXcnSO-HZ=ig@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-303965-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[eadavis@qq.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:andrii.nakryiko@gmail.com,m:andrii@kernel.org,m:ast@kernel.org,m:bpf@vger.kernel.org,m:daniel@iogearbox.net,m:eadavis@qq.com,m:eddyz87@gmail.com,m:emil@etsalapatis.com,m:jiayuan.chen@linux.dev,m:jolsa@kernel.org,m:linux-kernel@vger.kernel.org,m:martin.lau@linux.dev,m:memxor@gmail.com,m:netdev@vger.kernel.org,m:sashiko-bot@kernel.org,m:sashiko-reviews@lists.linux.dev,m:song@kernel.org,m:syzkaller-bugs@googlegroups.com,m:yonghong.song@linux.dev,m:andriinakryiko@gmail.com,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,iogearbox.net,qq.com,gmail.com,etsalapatis.com,linux.dev,lists.linux.dev,googlegroups.com];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,appspotmail.com:email,qq.com:dkim,qq.com:email,qq.com:mid,qq.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,syzkaller.appspot.com:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6A92D6F36DB

On Wed, 1 Jul 2026 12:57:52 -0700, Andrii Nakryiko wrote:
> > bpf_mem_cache_free_rcu() maybe called in preemptible context, this
> > will trigger the below warning message:
> >
> > BUG: using smp_processor_id() in preemptible [00000000] code: syz.0.17/5820
> > caller is bpf_mem_cache_free_rcu+0x48/0xc0 kernel/bpf/memalloc.c:954
> > Call Trace:
> >  check_preemption_disabled+0xd3/0xe0 lib/smp_processor_id.c:47
> >  bpf_mem_cache_free_rcu+0x48/0xc0 kernel/bpf/memalloc.c:954
> >  rhtab_delete_elem+0x185a/0x1b30 kernel/bpf/hashtab.c:2969
> >  __rhtab_map_lookup_and_delete_batch+0x935/0xcb0 kernel/bpf/hashtab.c:3349
> >  bpf_map_do_batch+0x445/0x630 kernel/bpf/syscall.c:-1
> >  __sys_bpf+0x906/0xd90 kernel/bpf/syscall.c:-1
> >
> > this_cpu_ptr() requires the caller to prevent task migration.
> > These helpers currently do not enforce that requirement and may
> > be invoked from preemptible contexts, leading to accesses to another
> > CPU's per-CPU cache after migration. Use get_cpu_ptr()/put_cpu_ptr()
> > to pin the task while accessing the per-CPU allocator state.
> >
> > Fixes: 5af6807bdb10 ("bpf: Introduce bpf_mem_free_rcu() similar to kfree_rcu().")
> > Fixes: 7c8199e24fa0 ("bpf: Introduce any context BPF specific memory allocator.")
> > Reported-by: syzbot+fd7e415d891073b83e1f@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=fd7e415d891073b83e1f
> > Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> > ---
> 
> from what I can see, bpf_mem_free() is called through bpf kfuncs only,
> and all BPF programs run with migration disabled. So this seems like a
> false positive. For per-cpu checking, it should probably check that
> either preemption is disabled or migration is disabled. tl;dr, there
> doesn't seem to be any
Today, I researched the call sites of bpf_mem_free() in detail; it is
called directly by bpf kfuns only. 

Different BPF program types execute in distinct kernel contexts: for
instance, XDP and TC typically run in non-sleepable networking contexts,
whereas `raw_tp`, `tracing`, `LSM`, `syscall` and especially sleepable
BPF programs may run in contexts where preemption and migration are
enabled. Consequently, any shared BPF code (such as a helper or kfunc)
that accesses per-CPU data must not rely on the caller having disabled
migration; instead, it must internally ensure that CPU migration does
not occur during the access.

Taking into account the CI reviewer's feedback [1] and my further
investigation into BPF programs as described above, the adjustments
related to bpf_mem_free() should be retained.

[1]
https://lore.kernel.org/all/20260630094823.897BD1F00A3D@smtp.kernel.org
> 
> pw-bot: cr
> 
> > v1 -> v2: using guard against preemption
> > v2 -> v3: replace get/put_cpu() to bpf_disable/enable_instrumentation()
> > v3 -> v4: disable preempt to make this_cpu_ptr() work
> > v4 -> v5: in mem free disable preemption
> >
> 
> maybe throttle your patch resubmission spree a bit?..
My earlier actions were driven by a desire to keep pace with the CI
reviewer's response speed.
Moving forward, I will slow down the cadence of new patch submissions,
as you suggested.


