Return-Path: <netdev+bounces-207683-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A945B082F7
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 04:29:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8D151C219C5
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 02:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0CCE1DA62E;
	Thu, 17 Jul 2025 02:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b="xoH8De6P"
X-Original-To: netdev@vger.kernel.org
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B471D5151
	for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 02:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.77.79.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752719336; cv=none; b=mjfx41+8hOs7FRIGfGXNrMBvYbjSHhUspt2Y55AmjBXqWgQknEWUmLF8pugyUhAhsjnU5SNsDSiwT6HX96/n109yO50frZ0RD4S3a9XPqiB2Dmx1z6FlbH5sbjjlnkrJu6smazxjgUbtIwXRVVZEAPNQbGECLFYuP9VlpiJKYHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752719336; c=relaxed/simple;
	bh=yNMrWf+38zkCxPLSNWlGTiuYVS2EgxmEaKWnhJuvkcY=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=CvDRvm3Itpu3LHEKrLHGeRBl3kgMWuNXJzqmwzR1oe25IqLmNHsj3B4P8Whwp/b9HvGqk7WRCf9q34R4DWN9r41SgUak0tSjMgCCimxaaqqjUoNbkxo1gDcRKjQ1EuphrNKmmHVyJ3WSlrUT+pO8q7Q9No1fd8LHi7kpvKUu340=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io; spf=pass smtp.mailfrom=willsroot.io; dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b=xoH8De6P; arc=none smtp.client-ip=51.77.79.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=willsroot.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=willsroot.io;
	s=protonmail; t=1752719323; x=1752978523;
	bh=jdzB+BTx958CK5iS3uhuzWdOPSfm87o+wpzNKtLXF48=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=xoH8De6PZRmKjPpIY+kxFZZU8WNz8MNX55I1P3PAmgrw6ebQ1CrOiUkYVhKIQgeIS
	 G+k0OAbxgv+tpyN1tVgFbEtUYaGyWvpt9LV1ahWGHH/1zkkl8H9PbP7i7KPpOTC2Xb
	 lbs26wpNOzLqKuBAshpnV3Opn7+NuspXsIB1M10yCWkan3m7xzqcW/CUxwFMtJHavU
	 dfdWvnXmiJxIx/1I54tKR0uRkrZfuaopcsLP5DACPUK3ZJxYsEV+GvJ0ZhQhCuuoNu
	 GAL8te7vDfShIhMkb4Lu6uLhiVah/eMMZg0gFgvpDgQfU6XaAPbBkKRnGGee4Qs2YE
	 DPq60BV7kudpA==
Date: Thu, 17 Jul 2025 02:28:38 +0000
To: netdev@vger.kernel.org
From: William Liu <will@willsroot.io>
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, pabeni@redhat.com, kuba@kernel.org, savy@syst3mfailure.io, jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, horms@kernel.org, William Liu <will@willsroot.io>
Subject: [PATCH net v2 1/2] net/sched: Return NULL when htb_lookup_leaf encounters an empty rbtree
Message-ID: <20250717022816.221364-1-will@willsroot.io>
Feedback-ID: 42723359:user:proton
X-Pm-Message-ID: 41bd5a6d3e84dd8707be651a8a0da0f25dc332f8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

htb_lookup_leaf has a BUG_ON that can trigger with the following:

tc qdisc del dev lo root
tc qdisc add dev lo root handle 1: htb default 1
tc class add dev lo parent 1: classid 1:1 htb rate 64bit
tc qdisc add dev lo parent 1:1 handle 2: netem
tc qdisc add dev lo parent 2:1 handle 3: blackhole
ping -I lo -c1 -W0.001 127.0.0.1

The root cause is the following:

1. htb_dequeue calls htb_dequeue_tree which calls the dequeue handler on
   the selected leaf qdisc
2. netem_dequeue calls enqueue on the child qdisc
3. blackhole_enqueue drops the packet and returns a value that is not
   just NET_XMIT_SUCCESS
4. Because of this, netem_dequeue calls qdisc_tree_reduce_backlog, and
   since qlen is now 0, it calls htb_qlen_notify -> htb_deactivate ->
   htb_deactiviate_prios -> htb_remove_class_from_row -> htb_safe_rb_erase
5. As this is the only class in the selected hprio rbtree,
   __rb_change_child in __rb_erase_augmented sets the rb_root pointer to
   NULL
6. Because blackhole_dequeue returns NULL, netem_dequeue returns NULL,
   which causes htb_dequeue_tree to call htb_lookup_leaf with the same
   hprio rbtree, and fail the BUG_ON

The function graph for this scenario is shown here:
 0)               |  htb_enqueue() {
 0) + 13.635 us   |    netem_enqueue();
 0)   4.719 us    |    htb_activate_prios();
 0) # 2249.199 us |  }
 0)               |  htb_dequeue() {
 0)   2.355 us    |    htb_lookup_leaf();
 0)               |    netem_dequeue() {
 0) + 11.061 us   |      blackhole_enqueue();
 0)               |      qdisc_tree_reduce_backlog() {
 0)               |        qdisc_lookup_rcu() {
 0)   1.873 us    |          qdisc_match_from_root();
 0)   6.292 us    |        }
 0)   1.894 us    |        htb_search();
 0)               |        htb_qlen_notify() {
 0)   2.655 us    |          htb_deactivate_prios();
 0)   6.933 us    |        }
 0) + 25.227 us   |      }
 0)   1.983 us    |      blackhole_dequeue();
 0) + 86.553 us   |    }
 0) # 2932.761 us |    qdisc_warn_nonwc();
 0)               |    htb_lookup_leaf() {
 0)               |      BUG_ON();
 ------------------------------------------

The full original bug report can be seen here [1].

We can fix this just by returning NULL instead of the BUG_ON,
as htb_dequeue_tree returns NULL when htb_lookup_leaf returns
NULL.

[1] https://lore.kernel.org/netdev/pF5XOOIim0IuEfhI-SOxTgRvNoDwuux7UHKnE_Y5=
-zVd4wmGvNk2ceHjKb8ORnzw0cGwfmVu42g9dL7XyJLf1NEzaztboTWcm0Ogxuojoeo=3D@will=
sroot.io/

Fixes: 512bb43eb542 ("pkt_sched: sch_htb: Optimize WARN_ONs in htb_dequeue_=
tree() etc.")
Signed-off-by: William Liu <will@willsroot.io>
Signed-off-by: Savino Dicanosa <savy@syst3mfailure.io>
---
 net/sched/sch_htb.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/sched/sch_htb.c b/net/sched/sch_htb.c
index 14bf71f57057..c968ea763774 100644
--- a/net/sched/sch_htb.c
+++ b/net/sched/sch_htb.c
@@ -821,7 +821,9 @@ static struct htb_class *htb_lookup_leaf(struct htb_pri=
o *hprio, const int prio)
 =09=09u32 *pid;
 =09} stk[TC_HTB_MAXDEPTH], *sp =3D stk;
=20
-=09BUG_ON(!hprio->row.rb_node);
+=09if (unlikely(!hprio->row.rb_node))
+=09=09return NULL;
+
 =09sp->root =3D hprio->row.rb_node;
 =09sp->pptr =3D &hprio->ptr;
 =09sp->pid =3D &hprio->last_ptr_id;
--=20
2.43.0



