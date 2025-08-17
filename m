Return-Path: <netdev+bounces-214407-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0791DB2948D
	for <lists+netdev@lfdr.de>; Sun, 17 Aug 2025 19:25:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE3C42A31A8
	for <lists+netdev@lfdr.de>; Sun, 17 Aug 2025 17:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6159829B8F8;
	Sun, 17 Aug 2025 17:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b="omJc9ktR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-10625.protonmail.ch (mail-10625.protonmail.ch [79.135.106.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD471ADC83
	for <netdev@vger.kernel.org>; Sun, 17 Aug 2025 17:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755451503; cv=none; b=Cgx/smVqCqoB1b9PSMS7WKmjEm2q7g525vogwzmBDTlxuvbyx+tlt9Mbxfwy5BnNrVwkvYtpMOIqC/BIKcusfphU9VJtoUzLrw7Z36vU7WaUGbRkVi+ehrgFo0T/IcdBzIVNX/+/ZXWeu6Q+vcswKWXtMNKkahTGTck9co7QIHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755451503; c=relaxed/simple;
	bh=otQxlRbfs12Tm6jQHCJ7Bi/vAt44Lp4Olg/SN3JtIVY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n3lzYelQtQY86d3BMoXuPD5/DlQ7okA1w0+gUk31ukXMgFOWVczWs91i8rlF6nPw1CkHEGfr/S/OMTgI7TJBAecKvJ6oa1RxJRNwd6lz4YC/PkMrO8BSQ5WVHVRVeHQmgPg4NBpQmmAy/Q/LxuAqJSUWMHJW5tMvxzvOLmaV4Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io; spf=pass smtp.mailfrom=willsroot.io; dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b=omJc9ktR; arc=none smtp.client-ip=79.135.106.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=willsroot.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=willsroot.io;
	s=protonmail2; t=1755451492; x=1755710692;
	bh=8jFOE2i1llqvjqv+5WETuyLKZL1V2XOXfWrfYTuNnqI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=omJc9ktRivDvxvx4fcZNwLbZqEe4SS7+PhbTjMdIVj7skCUfsWMj2+esByK6k18M7
	 WUSyuRMZ16rM0RwYI/Q7IK1mSm+gYTSgLfjqiPMvZg/Jo+PPWvMsaEnvOrd4h4I3VM
	 pQlk4g4M/OsZXaqpJkFI5iJa9A4SNh2y+Q8g/KGCrrH1fhZ4JAcD+6MUlLTyseX6Sk
	 3PdkwDSHgyC0DbFqBHfWp6jVeLUTN/mDfPz5dbPGWeKxnzPm4vF3kkPBR3ez/iABl2
	 qXilw/I3V4umcRdIZliCch7K9FP1rm1F0RKGH6Nw6jISDMzR6HIYznFs4gDaXI9PGA
	 a0AQpfde/9dKg==
Date: Sun, 17 Aug 2025 17:24:46 +0000
To: netdev@vger.kernel.org
From: William Liu <will@willsroot.io>
Cc: toke@toke.dk, jhs@mojatatu.com, xiyou.wangcong@gmail.com, pabeni@redhat.com, kuba@kernel.org, savy@syst3mfailure.io, jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, horms@kernel.org, cake@lists.bufferbloat.net, William Liu <will@willsroot.io>
Subject: [PATCH net 2/2] net/sched: Remove unnecessary WARNING condition for empty child qdisc in htb_activate
Message-ID: <20250817172420.450039-1-will@willsroot.io>
In-Reply-To: <20250817172344.449992-1-will@willsroot.io>
References: <20250817172344.449992-1-will@willsroot.io>
Feedback-ID: 42723359:user:proton
X-Pm-Message-ID: 5653a5754ac815c5a552cac0032c4cb9fa18b13f
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



