Return-Path: <netdev+bounces-214860-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3206BB2B7B6
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 05:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B70BE7B37B8
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 03:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED8D24678E;
	Tue, 19 Aug 2025 03:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b="vP1HF5qY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-24422.protonmail.ch (mail-24422.protonmail.ch [109.224.244.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CFA220F21
	for <netdev@vger.kernel.org>; Tue, 19 Aug 2025 03:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755574634; cv=none; b=SOEOxtI5MidAzPNd7f2r02wxOPysQPiRfWcPtq6xuyTh19SMn/kTzMqSB9GZvCPBRegF6fiFunwlxfv1Eefj514yz/F71SHLMo+uUaANEGYVmOVmuyqrE50M81n9DcDX4bJgU/zakJpWJma+umobsxIeQ/cfPwJRfMcjm54nyM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755574634; c=relaxed/simple;
	bh=otQxlRbfs12Tm6jQHCJ7Bi/vAt44Lp4Olg/SN3JtIVY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fXTSCIrsEnmjjWctem8DXrV5Pc57V49YO7B+z4cU1EAiy0YmQ0u0lKnSxiML35aYOQ5hNGqCU0lQ8Mdow2IPO9v/XePbDil7jjQ37WizCPHqD/OUjhtD8poxlqeOCU4WwaaPPRgLPqT8GuUbflrp5PAua/yG/598hc3q7wAGVEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io; spf=pass smtp.mailfrom=willsroot.io; dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b=vP1HF5qY; arc=none smtp.client-ip=109.224.244.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=willsroot.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=willsroot.io;
	s=protonmail2; t=1755574625; x=1755833825;
	bh=8jFOE2i1llqvjqv+5WETuyLKZL1V2XOXfWrfYTuNnqI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=vP1HF5qYox0OKYQb8z7AWA60h/1+cdU+ncGdaTcr/tQzJGm5Xf0RtPdMHkpWjBkml
	 9uogOJT/iFZlXUArXmfG2ZVpJfz4oh/3JMGkDgz4OvHz1uXxdJjnaG4AGEH/CiWVjs
	 nNurKicv4njBJsYQ1njV+cEQJq7mMBpxmYEo4xbx2/zDxPWQkg/zziWGVL4HUQxs+e
	 L6VinvlCBaEoYOvLeBnxRtm9ZKOrtw/vuVbiijgbNUpo8ygaLKGmJFQUfTKDnu6uQC
	 Y2GRjC2XsXDTRs85Mez4T7e8cpt4pyeaZuq7OaffFtgzngrj5G4BkEfWJPv4gMMhxV
	 sDu1Xx6mNrReg==
Date: Tue, 19 Aug 2025 03:36:59 +0000
To: netdev@vger.kernel.org
From: William Liu <will@willsroot.io>
Cc: toke@toke.dk, dave.taht@gmail.com, jhs@mojatatu.com, xiyou.wangcong@gmail.com, pabeni@redhat.com, kuba@kernel.org, savy@syst3mfailure.io, jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, horms@kernel.org, cake@lists.bufferbloat.net, William Liu <will@willsroot.io>
Subject: [PATCH net v2 2/2] net/sched: Remove unnecessary WARNING condition for empty child qdisc in htb_activate
Message-ID: <20250819033632.579854-1-will@willsroot.io>
In-Reply-To: <20250819033601.579821-1-will@willsroot.io>
References: <20250819033601.579821-1-will@willsroot.io>
Feedback-ID: 42723359:user:proton
X-Pm-Message-ID: 8341d675178945483f1e2c5c6fab3d0b41bbdca4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

The WARN_ON trigger based on !cl->leaf.q->q.qlen is unnecessary in
htb_activate. htb_dequeue_tree already accounts for that scenario.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: William Liu <will@willsroot.io>
Reviewed-by: Savino Dicanosa <savy@syst3mfailure.io>
---
 net/sched/sch_htb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sched/sch_htb.c b/net/sched/sch_htb.c
index c968ea763774..b5e40c51655a 100644
--- a/net/sched/sch_htb.c
+++ b/net/sched/sch_htb.c
@@ -592,7 +592,7 @@ htb_change_class_mode(struct htb_sched *q, struct htb_c=
lass *cl, s64 *diff)
  */
 static inline void htb_activate(struct htb_sched *q, struct htb_class *cl)
 {
-=09WARN_ON(cl->level || !cl->leaf.q || !cl->leaf.q->q.qlen);
+=09WARN_ON(cl->level || !cl->leaf.q);
=20
 =09if (!cl->prio_activity) {
 =09=09cl->prio_activity =3D 1 << cl->prio;
--=20
2.43.0



