Return-Path: <netdev+bounces-280701-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0DmRHor06WnApwIAu9opvQ
	(envelope-from <netdev+bounces-280701-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 12:29:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B3B3450AD5
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 12:29:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 197F03033DF9
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 10:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4917138C401;
	Thu, 23 Apr 2026 10:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hgBnkK6I"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4904388E6A
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 10:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776939817; cv=none; b=mVzTsbjdhL/wHaf0+Fuy6DyBkj30hUl7K9o2nGl8biulXV0JbRftRgmZNPoC8pkzeUBofB4poFl9D4vG3I9l1+VL6xC5gcsYic3ZJwGvRRfchr4OkdTxsAGRqPtMgwDj4TpR3mjA7khDS7LLs9BKSCiflqg9VR1LkFFo7vABZj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776939817; c=relaxed/simple;
	bh=J9wltRpm+JXoVsKCgBgyKjNN2ECwPCrjGUIJDCKfJpI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Xf0ohyvjy4byDbQlESM80RXIoiLbtgkZouJ9vcrUD9cq6mS9r/eZR/VXP8zeT79CUetRcNlgnOJH/1PiUJ06+rB925aYZ7Rei4gRC3gePpV3AGs3QF/j3SvXNFKFcqBgxVdUzVQ717eHlojXN6bG6y4h0qUhA0qG6qBpBD1Mhto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hgBnkK6I; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-8ebe2c596c6so784931085a.1
        for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 03:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776939815; x=1777544615; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tqqdHqpScFzQ5d4J01+wsg0tdKGATkwt64W3ep/b1As=;
        b=hgBnkK6IsgXtqneYxwQoGEpJVSYm4zktJ0J8uCq9PXjxCZQqGzrw4jBLabl3Nm+xPr
         h1qLgxwzFalQQy7hLzLX4j1n5XRYeicmorOGF3PL/6i1uAL4Ni04ryPmQ8VRnEFbCiaZ
         1VAR/2dCHGqGkufBm+FmuTgw9sh3CU2kqU8FroosWJzfTpkHagljVBzI/CdLMJuZxjF9
         LGaVHN/gqzIVIiB0nvZh5O+TX7Tk9+Nr615fbjCyQ8BDpuEM9aILnbzzyucDTv7lzAUe
         jSYmcZuqxl8T65f0eC02j/yy6CbW4JDk6RM3OJ4H9qGuQT/klGtm8LXwKyDqNORcO6PR
         p7VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776939815; x=1777544615;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tqqdHqpScFzQ5d4J01+wsg0tdKGATkwt64W3ep/b1As=;
        b=NTIJBgPzpJ2vvH8DCwOiSilCrnsXXt91b6JLyAa68sE0KvvViy5k2x2aksZkP37FQb
         eGn/dhOvmnbGuaKt9WmFDVRnghgdcAqjq6E4Muuq4Jy1RTYGLH+wpuvA5lIW3rptTxX9
         SYrXSCfJtmSPwawpyhh/dzd24ZUDdWS3VayKB5ydnkepx4m3ckZaxgD3abenPRTc78Dm
         3LwOtnCDMfaceT3gdH0meiXsDQEiNj4DgLeOMnGKKE016YAkwNy/KFMc7Twn5NEDJpCF
         jAvbhPB6q52kkVX4gVrhmYUB1dtYFNrOXxe02FZsnKBdH3y5aztEr9ZEs0n7eXpyl2fG
         jMhg==
X-Forwarded-Encrypted: i=1; AFNElJ96q9J22xXaxwABx9XlQuaNt7J5Zv6lCpLfY9S6s+CrnKmK2uiK6BFYhd+AZ2W5OCS4Ie13DXY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yynjf9g/gveFqeXUVHeqCVBfrfc7vZ6jBWFjfMNaYFyuEVejJfO
	lVTfie8ipOb0GFwdRcuVy1Y7loIZ0LUrhqk5aRGOM4quMf6/x/giZI9OrURvaMCaZZtbsXM9Rc+
	4wMy6tjvUxOAicA==
X-Received: from qkkh6.prod.google.com ([2002:a05:620a:10a6:b0:8d4:b5d7:384d])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:f0e:b0:8ed:bafb:26cb with SMTP id af79cd13be357-8edbafb2b52mr1958438285a.44.1776939814661;
 Thu, 23 Apr 2026 03:23:34 -0700 (PDT)
Date: Thu, 23 Apr 2026 10:23:24 +0000
In-Reply-To: <20260423102324.3172448-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260423102324.3172448-1-edumazet@google.com>
X-Mailer: git-send-email 2.54.0.rc2.544.gc7ae2d5bb8-goog
Message-ID: <20260423102324.3172448-6-edumazet@google.com>
Subject: [PATCH net 5/5] net/sched: sch_cake: annotate data-races in
 cake_dump_stats() (V)
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	"=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?=" <toke@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, 
	"=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?=" <toke@toke.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,mojatatu.com,resnulli.us,redhat.com,vger.kernel.org,gmail.com,google.com,toke.dk];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280701-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,toke.dk:email,cparams.target:url]
X-Rspamd-Queue-Id: 2B3B3450AD5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

cake_dump_stats() runs without qdisc spinlock being held.

In this final patch, I add READ_ONCE()/WRITE_ONCE() annotations
for cparams.target and cparams.interval.

Fixes: 046f6fd5daef ("sched: Add Common Applications Kept Enhanced (cake) q=
disc")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: "Toke H=C3=B8iland-J=C3=B8rgensen" <toke@toke.dk>
---
 net/sched/sch_cake.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index c3b09f67f0fdbc51d23b3d22df9ab89a716c7e2b..53d90062c32fcf647e4837416e3=
35f4562ab97d9 100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -2356,10 +2356,11 @@ static void cake_set_rate(struct cake_tin_data *b, =
u64 rate, u32 mtu,
=20
 	byte_target_ns =3D (byte_target * rate_ns) >> rate_shft;
=20
-	b->cparams.target =3D max((byte_target_ns * 3) / 2, target_ns);
-	b->cparams.interval =3D max(rtt_est_ns +
-				     b->cparams.target - target_ns,
-				     b->cparams.target * 2);
+	WRITE_ONCE(b->cparams.target,
+		   max((byte_target_ns * 3) / 2, target_ns));
+	WRITE_ONCE(b->cparams.interval,
+		   max(rtt_est_ns + b->cparams.target - target_ns,
+		       b->cparams.target * 2));
 	b->cparams.mtu_time =3D byte_target_ns;
 	b->cparams.p_inc =3D 1 << 24; /* 1/256 */
 	b->cparams.p_dec =3D 1 << 20; /* 1/4096 */
@@ -3042,9 +3043,9 @@ static int cake_dump_stats(struct Qdisc *sch, struct =
gnet_dump *d)
 		PUT_TSTAT_U32(BACKLOG_BYTES, READ_ONCE(b->tin_backlog));
=20
 		PUT_TSTAT_U32(TARGET_US,
-			      ktime_to_us(ns_to_ktime(b->cparams.target)));
+			      ktime_to_us(ns_to_ktime(READ_ONCE(b->cparams.target))));
 		PUT_TSTAT_U32(INTERVAL_US,
-			      ktime_to_us(ns_to_ktime(b->cparams.interval)));
+			      ktime_to_us(ns_to_ktime(READ_ONCE(b->cparams.interval))));
=20
 		PUT_TSTAT_U32(SENT_PACKETS, READ_ONCE(b->packets));
 		PUT_TSTAT_U32(DROPPED_PACKETS, READ_ONCE(b->tin_dropped));
--=20
2.54.0.rc2.544.gc7ae2d5bb8-goog


