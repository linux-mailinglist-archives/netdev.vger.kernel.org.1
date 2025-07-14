Return-Path: <netdev+bounces-206503-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9DCDB034D1
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 05:13:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12539170EE9
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 03:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BDE11EEA31;
	Mon, 14 Jul 2025 03:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b="uYApWcY7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-4323.protonmail.ch (mail-4323.protonmail.ch [185.70.43.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02A71DE3DB
	for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 03:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752462790; cv=none; b=S6SDj6Te89L2064CxYCHKcGhEPFKFa5gHaQfu11KJkDb+B9sJ5oyX6kVN+WaUhDq1P37SJOQTkfWfDjJZdgbdS9kRcVuFCNyRrisC7TZ99SsEFyP5YhVbWdMyxV7dS7Baiizkx8Wa34IkseMRyIS1SjhUnklcyWjirMq0vFtINc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752462790; c=relaxed/simple;
	bh=yNMrWf+38zkCxPLSNWlGTiuYVS2EgxmEaKWnhJuvkcY=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=hbdWVfT69eeaOBiSuNhaS0zjvEgcRrSuWp5rjcktjnXRDBQ5SEAvPoUQf0XQyC5yXH2pFwVIgAL0nJui514888MU7K+1UVrTgVf7zGkdmKkNQteH8NGj//UwnWHiTYRY636CpM0ad5JcSMcDC48vGHpRv4/Qw7xrPju8U1YixU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io; spf=pass smtp.mailfrom=willsroot.io; dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b=uYApWcY7; arc=none smtp.client-ip=185.70.43.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=willsroot.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=willsroot.io;
	s=protonmail; t=1752462785; x=1752721985;
	bh=jdzB+BTx958CK5iS3uhuzWdOPSfm87o+wpzNKtLXF48=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=uYApWcY7phYob1pualxksHi/7drK/P0V80LT01WVejAvrm7V9sHB28S8HdjFJA3Dh
	 i7Jx2htidFDS2qH8RK4sAOGhlGOOEPGXHFCEb1spwOWUPVibVAzsxwTUDgzMliCCZV
	 2NIUNIkjEIHwcySucNNU2Pcl1lFJGFrBybSWt9e4n7PkTQfgXpsUh9cg4CeflYY7E2
	 HzDsryxjDFdql9QHhHov+v1omkDEU1MPOU2SkNyXnAqlrSUmtYVW7ktBi0ODRl2kZm
	 k8wE3UIXtGLYvFHtRCNuhklotTOZ2AbXFXbeQnIJ4XkF2gGUBp0QrBw2568sdJo6yn
	 YPq5ePHLbNJ9g==
Date: Mon, 14 Jul 2025 03:12:59 +0000
To: netdev@vger.kernel.org
From: William Liu <will@willsroot.io>
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, pabeni@redhat.com, kuba@kernel.org, savy@syst3mfailure.io, jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, horms@kernel.org, William Liu <will@willsroot.io>
Subject: [PATCH net 1/2] net/sched: Return NULL when htb_lookup_leaf encounters an empty rbtree
Message-ID: <20250714031238.76077-1-will@willsroot.io>
Feedback-ID: 42723359:user:proton
X-Pm-Message-ID: ad49b06bc5733a6a7153df08f2b432d60a650209
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



