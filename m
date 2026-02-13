Return-Path: <netdev+bounces-258527-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QDmONIuAjmn6CgEAu9opvQ
	(envelope-from <netdev+bounces-258527-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 02:38:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7203F1324E8
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 02:38:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D6F54306BF30
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 01:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 016D722D9F7;
	Fri, 13 Feb 2026 01:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pcdn5Nsi"
X-Original-To: netdev@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0BB9C8E6
	for <netdev@vger.kernel.org>; Fri, 13 Feb 2026 01:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770946673; cv=none; b=MqhzNwY1uKP14EG4+x2Uet1nwVjbM+jUm32AsTlMl8DbDMpiFDlDaoPOYNdWgsmBzcmI27cUHxOz+zZBJl9nAw7jS//JUZze7fcUU4XK7oMHrsfCR83bSH+rnFfEDL8+R1d9HpR/IMkgdMj7q5aQrDhRfB7SraZDtU3PcFUOp90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770946673; c=relaxed/simple;
	bh=i76kBt/xx7gYTzlZGlhKxfL9BhtGwRuhGAoQCiOIzUk=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=TWQQ4tB08pFNtDpRq25+B3GQhBD7fXPZS4OE5pWKvWcpv46UMkEohFvhWdfwWZCJ5MKWhJtsOW21AlLQhY58NxDkX/YQlxQZvIL71Ii+D6e4mfaqLb2kN++p2bcrZn9dKO2kJcwp4tLrZMFYKt6loN8nMzayytedkN9zGZLzPmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pcdn5Nsi; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770946658;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qz7VWiykJZdAqjJypSWZD+BaPWeczMbaqBbLq8/OY50=;
	b=pcdn5NsiF0Yj4Iz0WXeKpzO+FsFyE0kCuw5YX/H1npI37twO+xtYJTuQCK6wgavV/pl10o
	G9pt7IqjkM0kLRw62FsgCoQFjWbXcLRxgCgzDqVxvdSyDCN1B8dnE+Q00v5OLhNJ6/jYCk
	otsW6uN1wJq3gEtFxk1lPzqfzVMMuuY=
Date: Fri, 13 Feb 2026 01:37:35 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Message-ID: <4efdec422a00d95a2bd7d227b8bcab61ebc231ce@linux.dev>
TLS-Required: No
Subject: Re: [PATCH bpf v2] bpf: cpumap: fix race in bq_flush_to_queue on
 PREEMPT_RT
To: "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>
Cc: xxx@vger.kernel.org, "Jiayuan Chen" <jiayuan.chen@shopee.com>,
 syzbot+2b3391f44313b3983e91@syzkaller.appspotmail.com, "Alexei
 Starovoitov" <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>,
 "David S. Miller" <davem@davemloft.net>, "Jakub Kicinski"
 <kuba@kernel.org>, "Jesper Dangaard Brouer" <hawk@kernel.org>, "John
 Fastabend" <john.fastabend@gmail.com>, "Stanislav Fomichev"
 <sdf@fomichev.me>, "Andrii Nakryiko" <andrii@kernel.org>, "Martin KaFai
 Lau" <martin.lau@linux.dev>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Song Liu" <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>,
 "KP Singh" <kpsingh@kernel.org>, "Hao Luo" <haoluo@google.com>, "Jiri
 Olsa" <jolsa@kernel.org>, "Clark Williams" <clrkwllms@kernel.org>,
 "Steven Rostedt" <rostedt@goodmis.org>, "Thomas Gleixner"
 <tglx@kernel.org>, netdev@vger.kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
In-Reply-To: <20260212143344.j3_GaCuV@linutronix.de>
References: <20260212023634.366343-1-jiayuan.chen@linux.dev>
 <20260212143344.j3_GaCuV@linutronix.de>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258527-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	FREEMAIL_CC(0.00)[vger.kernel.org,shopee.com,syzkaller.appspotmail.com,kernel.org,iogearbox.net,davemloft.net,gmail.com,fomichev.me,linux.dev,google.com,goodmis.org,lists.linux.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,2b3391f44313b3983e91];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[shopee.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linutronix.de:email,appspotmail.com:email]
X-Rspamd-Queue-Id: 7203F1324E8
X-Rspamd-Action: no action

2026/2/12 22:33, "Sebastian Andrzej Siewior" <bigeasy@linutronix.de mailt=
o:bigeasy@linutronix.de?to=3D%22Sebastian%20Andrzej%20Siewior%22%20%3Cbig=
easy%40linutronix.de%3E > wrote:




Thanks for the review, Sebastian.


> There is no spin_lock() otherwise there would be no problem.


Right, will fix the description. The per-CPU bq has no lock at all,
which is the root cause...
> =E2=80=A6
>=20
>=20>=20
>=20> Fix this by adding a local_lock_t to xdp_bulk_queue and acquiring i=
t
> >  in bq_enqueue() and __cpu_map_flush(). On non-RT kernels, local_lock
> >  maps to preempt_disable/enable with zero additional overhead. On
> >  PREEMPT_RT, it provides a per-CPU sleeping lock that serializes
> >  access to the bq. Use local_lock_nested_bh() since these paths alrea=
dy
> >  run under local_bh_disable().
> >=20
>=20So you use local_lock_nested_bh() and not local_lock() but you mentio=
n
> local_lock. The difference is that the former does not add any
> preempt_disable() on !RT. At this point I am curious how much of this
> was written by you and how much is auto generated.=20


Sorry=20about the inconsistencies. The commit message became messy after
several rounds of editing across versions, and I failed to update all
the descriptions to match the final code.


> >=20
>=20> An alternative approach of snapshotting bq->count and bq->q[] befor=
e
> >  releasing the producer_lock was considered, but it requires copying
> >  the entire bq->q[] array on every flush, adding unnecessary overhead=
.
> >=20
>=20But you still have list_head which is not protected.

The snapshot alternative is incomplete as described. Will drop that parag=
raph.

> >=20
>=20> To reproduce, insert an mdelay(100) between spin_unlock() and
> >  __list_del_clearprev() in bq_flush_to_queue(), then run reproducer
> >  provided by syzkaller.
> >=20=20
>=20>  Panic:
> >  =3D=3D=3D
> >  BUG: kernel NULL pointer dereference, address: 0000000000000000
> >  #PF: supervisor write access in kernel mode
> >  #PF: error_code(0x0002) - not-present page
> >  PGD 0 P4D 0
> >  Oops: Oops: 0002 [#1] SMP PTI
> >  CPU: 0 UID: 0 PID: 377 Comm: a.out Not tainted 6.19.0+ #21 PREEMPT_R=
T
> >  RIP: 0010:bq_flush_to_queue+0x145/0x200
> >  Call Trace:
> >  <TASK>
> >  __cpu_map_flush+0x2c/0x70
> >  xdp_do_flush+0x64/0x1b0
> >  xdp_test_run_batch.constprop.0+0x4d4/0x6d0
> >  bpf_test_run_xdp_live+0x24b/0x3e0
> >  bpf_prog_test_run_xdp+0x4a1/0x6e0
> >  __sys_bpf+0x44a/0x2760
> >  __x64_sys_bpf+0x1a/0x30
> >  x64_sys_call+0x146c/0x26e0
> >  do_syscall_64+0xd5/0x5a0
> >  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> >  </TASK>
> >=20
>=20This could be omitted. It is obvious once you see it. I somehow misse=
d

Will remove the panic trace.

> this alloc_percpu instance while looking for this kind of bugs.
> Another one is hiding in devmap.c. Mind to take a look? I think I
> skip this entire folder=E2=80=A6


I see the same pattern there - xdp_dev_bulk_queue is per-CPU with no pree=
mption
protection in bq_enqueue() and __dev_flush().

> >=20
>=20> Fixes: 3253cb49cbad ("softirq: Allow to drop the softirq-BKL lock o=
n PREEMPT_RT")
> >  Reported-by: syzbot+2b3391f44313b3983e91@syzkaller.appspotmail.com
> >  Closes: https://lore.kernel.org/all/69369331.a70a0220.38f243.009d.GA=
E@google.com/T/
> >  Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
> >  Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> >  ---
> >  v1 -> v2: https://lore.kernel.org/bpf/20260211064417.196401-1-jiayua=
n.chen@linux.dev/
> >  - Use local_lock_nested_bh()/local_unlock_nested_bh() instead of
> >  local_lock()/local_unlock(), since these paths already run under
> >  local_bh_disable(). (Sebastian Andrzej Siewior)
> >  - Replace "Caller must hold bq->bq_lock" comment with
> >  lockdep_assert_held() in bq_flush_to_queue(). (Sebastian Andrzej Sie=
wior)
> >  - Fix Fixes tag to 3253cb49cbad ("softirq: Allow to drop the
> >  softirq-BKL lock on PREEMPT_RT") which is the actual commit that
> >  makes the race possible. (Sebastian Andrzej Siewior)
> >  ---
> >  kernel/bpf/cpumap.c | 17 +++++++++++++++--
> >  1 file changed, 15 insertions(+), 2 deletions(-)
> >=20
>=20The changes below look good.

Thanks!

> Sebastian

