Return-Path: <netdev+bounces-214859-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A46FB2B7B0
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 05:36:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84A1A561642
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 03:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 328C62376E1;
	Tue, 19 Aug 2025 03:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b="ZbFA3URZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-4323.protonmail.ch (mail-4323.protonmail.ch [185.70.43.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A663AC3B
	for <netdev@vger.kernel.org>; Tue, 19 Aug 2025 03:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755574606; cv=none; b=iPhreJ21OXBc+2lpS5wMPpeFwCSKAjAg9aSnzw/puJxoo8G7Ss+fGGDhxlDvJccphrmQpbEG5Il9WZ4aFo27WjABRp2Bi7Gu21/k9LF8pDyDyzsTc3urP26v5ZDF8WLUB+gFiTFM/8BBMcwGGt7NqlsBOAp8JQT51p7xiDVYS20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755574606; c=relaxed/simple;
	bh=IKVbwK8HJsyXoHh4mEYTOFg2GoY0C9/J5TgFP+Ra88s=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=rFYjYWkhFYSfJ//aQoiz65imWU0LnKnSSchDookr6jxMIx7O2VVdAAZxHG2rIXeibfpyOo2SlmJuPvcRW0zhWGSMp2rz4aILOfoJ4KutnLCOk8TD/eJeN3aN0DJxBZsJnQrhaYfrqNcp72FDK3Mnw2XZFYluZwDxhMvZ0H/+qe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io; spf=pass smtp.mailfrom=willsroot.io; dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b=ZbFA3URZ; arc=none smtp.client-ip=185.70.43.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=willsroot.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=willsroot.io;
	s=protonmail2; t=1755574594; x=1755833794;
	bh=Uxmcfz2NMUsFKTidylCWbt8qNHcu7Y07A5YauOztNk8=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=ZbFA3URZqoU0+XCs8G86zh4d9fxt7j3aJw7hLPS9l+c848gECKFH7zv7URzUSo14Y
	 1RW04Yyjp0EhADQpNhoSHHqHAKk3hZoRat1si9zl+ftq2u1ZsNAgU9VKclkgVLWHoe
	 toEkkCGEmgpipIe/BF8d5+qR7XJvwrB+PSa2KpFzxnOu1lU91M9DN+UeDjTBqVLjnp
	 V8ehH9Iw5ZFzVXQbKpH18f+DVmgVm7cSWbsdY2C57sK7tDio0BzEuv5B9pIyPNXVxQ
	 Qqvr3X34oy3QwmA1r8R0KR6XsTuWsgVVrXTigvV5Nis6pM26tqlgI8IuYh1wIC5BiV
	 1T9iMYvzRWtgQ==
Date: Tue, 19 Aug 2025 03:36:28 +0000
To: netdev@vger.kernel.org
From: William Liu <will@willsroot.io>
Cc: toke@toke.dk, dave.taht@gmail.com, jhs@mojatatu.com, xiyou.wangcong@gmail.com, pabeni@redhat.com, kuba@kernel.org, savy@syst3mfailure.io, jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, horms@kernel.org, cake@lists.bufferbloat.net, William Liu <will@willsroot.io>
Subject: [PATCH net v2 1/2] net/sched: Make cake_enqueue return NET_XMIT_CN when past buffer_limit
Message-ID: <20250819033601.579821-1-will@willsroot.io>
Feedback-ID: 42723359:user:proton
X-Pm-Message-ID: 2da39582976788ca4a1010f0531682d492225aac
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

The following setup can trigger a WARNING in htb_activate due to
the condition: !cl->leaf.q->q.qlen

tc qdisc del dev lo root
tc qdisc add dev lo root handle 1: htb default 1
tc class add dev lo parent 1: classid 1:1 \
       htb rate 64bit
tc qdisc add dev lo parent 1:1 handle f: \
       cake memlimit 1b
ping -I lo -f -c1 -s64 -W0.001 127.0.0.1

This is because the low memlimit leads to a low buffer_limit, which
causes packet dropping. However, cake_enqueue still returns
NET_XMIT_SUCCESS, causing htb_enqueue to call htb_activate with an
empty child qdisc. We should return NET_XMIT_CN when packets are
dropped from the same tin and flow.

I do not believe return value of NET_XMIT_CN is necessary for packet
drops in the case of ack filtering, as that is meant to optimize
performance, not to signal congestion.

Fixes: 046f6fd5daef ("sched: Add Common Applications Kept Enhanced (cake) q=
disc")
Signed-off-by: William Liu <will@willsroot.io>
Reviewed-by: Savino Dicanosa <savy@syst3mfailure.io>
---
v1 -> v2: only return NET_XMIT_CN when dropping from the same tin and flow
---
 net/sched/sch_cake.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index dbcfb948c867..32bacfc314c2 100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -1750,7 +1750,7 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Q=
disc *sch,
 =09ktime_t now =3D ktime_get();
 =09struct cake_tin_data *b;
 =09struct cake_flow *flow;
-=09u32 idx;
+=09u32 idx, tin;
=20
 =09/* choose flow to insert into */
 =09idx =3D cake_classify(sch, &b, skb, q->flow_mode, &ret);
@@ -1760,6 +1760,7 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Q=
disc *sch,
 =09=09__qdisc_drop(skb, to_free);
 =09=09return ret;
 =09}
+=09tin =3D (u32)(b - q->tins);
 =09idx--;
 =09flow =3D &b->flows[idx];
=20
@@ -1927,13 +1928,22 @@ static s32 cake_enqueue(struct sk_buff *skb, struct=
 Qdisc *sch,
 =09=09q->buffer_max_used =3D q->buffer_used;
=20
 =09if (q->buffer_used > q->buffer_limit) {
+=09=09bool same_flow =3D false;
 =09=09u32 dropped =3D 0;
+=09=09u32 drop_id;
=20
 =09=09while (q->buffer_used > q->buffer_limit) {
 =09=09=09dropped++;
-=09=09=09cake_drop(sch, to_free);
+=09=09=09drop_id =3D cake_drop(sch, to_free);
+
+=09=09=09if ((drop_id >> 16) =3D=3D tin &&
+=09=09=09    (drop_id & 0xFFFF) =3D=3D idx)
+=09=09=09=09same_flow =3D true;
 =09=09}
 =09=09b->drop_overlimit +=3D dropped;
+
+=09=09if (same_flow)
+=09=09=09return NET_XMIT_CN;
 =09}
 =09return NET_XMIT_SUCCESS;
 }
--=20
2.43.0



