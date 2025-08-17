Return-Path: <netdev+bounces-214406-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D7BB2948C
	for <lists+netdev@lfdr.de>; Sun, 17 Aug 2025 19:24:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 275161B26897
	for <lists+netdev@lfdr.de>; Sun, 17 Aug 2025 17:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F2F1F4717;
	Sun, 17 Aug 2025 17:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b="Qv8kjU/F"
X-Original-To: netdev@vger.kernel.org
Received: from mail-4323.protonmail.ch (mail-4323.protonmail.ch [185.70.43.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0F2221FC4
	for <netdev@vger.kernel.org>; Sun, 17 Aug 2025 17:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755451473; cv=none; b=n7cJ1UfbN9sDcNloB5xqKb5QkeqE60bbtnJWdlfNXP+vSLb4L5ICL9pDj7kE6jKKjM8T5IRohlMsOCANrEaQxenTjYcEPhmPRJyHQaBMZ0V+XX+nrGik9gsy0eHkwtgL6J6DjGmslLKvddTAPKUPfmHs4hNklBkNsU3A4/jiHoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755451473; c=relaxed/simple;
	bh=omIc8mNAk/gq3H73GvtGc57UDOYkV2lBSUrucDfQtjQ=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=J70/bdr3qNKLkgd0ZcAhPqm2vk/uHQ2Ur4EPkfG9sd2qJsnhk25JGkQE+v48jnx9vWYKw7inBD76ylYFAAehDX6IwqlFW5BM1hX81Z8KvrPeK3dry5O3ptfvbcAApM53JbKBhuSy5kSiPDOoYrUe8wWdfIKRVITcscQKSvnN8I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io; spf=pass smtp.mailfrom=willsroot.io; dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b=Qv8kjU/F; arc=none smtp.client-ip=185.70.43.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=willsroot.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=willsroot.io;
	s=protonmail2; t=1755451461; x=1755710661;
	bh=WlfDB9f9hx9/p9nnw0AggcvHEZASiW/W23imChJvDRs=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=Qv8kjU/FeEZiLiubE8LWpXEQuBjMIZ/UxMDCLm7TbEwKblW9Yx77zmZvl9731xXyS
	 A8FqtBzB7yaxwEHTCgFgg4mVN3kEUN9/dECRtbsdPli6EZETqrVhnWfknJ7zrLk+5x
	 7ruIw0o29BvwB8YWZwuhLokbznKVALEnxf9pjtmIIqf6ib9OEujT3aWrLWRdObBQ5B
	 AeOYW8bkxlONmIxUWrS/ezlW8PGjjq78OBvUme6MRdPl2Gg5blhPFPV9SxRrcwOa09
	 rSfJ/LKSsh6c821EzmjDWwy4ueKQIDDxonKUhKbQdHJy5cWS/VKc24z+h4AD1VMg4M
	 +nwPRHFJwHzYw==
Date: Sun, 17 Aug 2025 17:24:17 +0000
To: netdev@vger.kernel.org
From: William Liu <will@willsroot.io>
Cc: toke@toke.dk, jhs@mojatatu.com, xiyou.wangcong@gmail.com, pabeni@redhat.com, kuba@kernel.org, savy@syst3mfailure.io, jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, horms@kernel.org, cake@lists.bufferbloat.net, William Liu <will@willsroot.io>
Subject: [PATCH net 1/2] net/sched: Make cake_enqueue return NET_XMIT_CN when past buffer_limit
Message-ID: <20250817172344.449992-1-will@willsroot.io>
Feedback-ID: 42723359:user:proton
X-Pm-Message-ID: 8da73108157485efe91066723bbc5a3e3ac39643
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
empty child qdisc.

I do not believe return value of NET_XMIT_CN is necessary for packet
drops in the case of ack filtering, as that is meant to optimize
performance, not to signal congestion.

Fixes: 046f6fd5daef ("sched: Add Common Applications Kept Enhanced (cake) q=
disc")
Signed-off-by: William Liu <will@willsroot.io>
Reviewed-by: Savino Dicanosa <savy@syst3mfailure.io>
---
 net/sched/sch_cake.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index dbcfb948c867..40814449f17a 100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -1934,6 +1934,9 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Q=
disc *sch,
 =09=09=09cake_drop(sch, to_free);
 =09=09}
 =09=09b->drop_overlimit +=3D dropped;
+
+=09=09if (dropped)
+=09=09=09return NET_XMIT_CN;
 =09}
 =09return NET_XMIT_SUCCESS;
 }
--=20
2.43.0



