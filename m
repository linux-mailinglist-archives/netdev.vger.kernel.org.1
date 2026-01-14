Return-Path: <netdev+bounces-249877-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 609B4D2015A
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 17:10:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6F07A30A9A7A
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 16:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B41653A1D1A;
	Wed, 14 Jan 2026 16:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="gblB5Mzq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179623A1CFE
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 16:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768406585; cv=none; b=k9wE/5pZbWimC1nmPQkVyvbatTLuNvnBYLc/GNwwPUSrzfM4s4RnJx842MvUs7KA/5ItAIi73b43fBIyViIVUaXcEUtQfLY/8IfKhVd0eMnKtR63iTXNrbTa6PzFqP5RcTC8pgxwKcKo2wr9eY/RzcQRWoEtw253yOYhafUDMyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768406585; c=relaxed/simple;
	bh=FAZmoxJyG/Z1zX7IgJ/LNodWI+3kg5EIpn9r5EmFwYk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KPKBLOKZFTx6LpQSAq45UHOC1ZYUIRdroT3shqq714wYvjfSQIZmnm/kCUI4j0dKnPH8oyytt+gNEaCh2X9I+s2/mkO04Uvv20OrZlxdbU/tXveLkQHiqeLzfx0glxa6u9+zvb03JfhIajVF/Q8kWyu8hvZUxYvcmTJ0GP0BxCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=gblB5Mzq; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4f4cd02f915so65312291cf.1
        for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 08:03:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1768406583; x=1769011383; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tI/HeA98SsZvEyoqNuMmPq8nNGPBFX09hbB4KOZQX/M=;
        b=gblB5MzqSwnW+1EhK1Hezel/ZBBKiglfXsoava3xDU24rRMcOnZPWW8BKzel7coZFy
         NEIP6ALJVL6KhqzpkFqzVhxbdNg2xrwlD6ZoqrEsT8cg5yTpE19U0xrcZcUidEIkU9Ql
         QMxG6TFjtZULwrGee3BWkZxwd3yUZxJd3bAqN1xRdNwS4Be1Y1AxIsvdaWCbnMTBfqX9
         rXemeXXLGOiqda1wipoahSdvPDUF07GDWDKliQIhjXqlMzsKM/gvMDtLcNTnC6T5f5EX
         irhp5RTu6CzXk+B8xWkb5KOXHnTjR3CeyshXKjYB1/XLRccMsOZIgMhE+Xm2Z2QvsWpg
         RRog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768406583; x=1769011383;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tI/HeA98SsZvEyoqNuMmPq8nNGPBFX09hbB4KOZQX/M=;
        b=W3oeZGKtuUmoMRDMx/LGSa0Bj/Tu8lN/p3voU33P8RCGW1sNIhRFix7GgBXsFKZucH
         yWAVhbmsmfq172jX0RdJ4udj3JlrKKIpiumdaLVftu51dao3+NsyJNsZd/eNHKg74jv4
         o4/M6cl7oNQriNBUJEfjqYPHH1TA4fkg0sSskAIlY2j8MjZFC3sjf/+ZkQe5AYIC00dC
         xmqq1lSfHaYbHRYVpX0crjiMrt2Xb8B4K1y/VqVZq3cFTxg2EkGhzqL9hqwwdKNrI2PK
         /1NjaA9McKaE1biJBvsh6+rwznP+yxVzGh+yET6jWbscvtqQAOP5PiozJCIRHHnoD9om
         deDA==
X-Gm-Message-State: AOJu0YwGqoCNmzGZiZdzh8juss7ToGyi2dq3rUoOg6fO/6VoSNCMb3wU
	EmMpVmFXx42HJN4ZWPaqXO1NmKyhqmXV4Q8vNWJjGOuPQokBbmmXhE8Zr2gsaq3ICg==
X-Gm-Gg: AY/fxX7I0wjEBBEMzJ5FJCV85n7VJdjBXbZ0tH+ohXaJR7gq/ieMqDYdeS5U73uiJle
	BHCVie8LHLD+CePjNb15v8gEInm+jHpKjDHh38If0RltjiQBp7QrqYXJU9dPWbbMtyZ/ylRkyMd
	ex5Lic2mpw/dI4a6gTwpi1nvo4ltZlyk0cxloaeNJEQibC9/kc5KEoARaYh7R9RlOebFRThD71u
	07YoKPW9bC5tNh/fByszHmMzFCl6awSzTqipVQOB7mzmiwybUQDCCYuVIDXGEGSmNQUHoUGTYqb
	JGgH5MgLp2UIOmQyvvYvP14t0lcEeUL7U/hXy7F3UGozEGjNKEGVDeUSv6HzoubMNsBP1gjUgbA
	bhCX6cpVTdEPepxbnOrIkadLeFpKle57ESAyOgE32317bxt6QKZFkXW3ZqZSgEWnBnK/KgLld8y
	CWRhnbVsXbHHA=
X-Received: by 2002:a05:622a:5518:b0:4ee:2352:1bb2 with SMTP id d75a77b69052e-501481da4c8mr53085001cf.11.1768406580736;
        Wed, 14 Jan 2026 08:03:00 -0800 (PST)
Received: from majuu.waya ([70.50.89.69])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50148ecc0e4sm15543451cf.23.2026.01.14.08.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 08:02:59 -0800 (PST)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch
Cc: netdev@vger.kernel.org,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	victor@mojatatu.com,
	km.kim1503@gmail.com,
	security@kernel.org,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: [PATCH net 1/3] net/sched: Enforce that teql can only be used as root qdisc
Date: Wed, 14 Jan 2026 11:02:41 -0500
Message-Id: <20260114160243.913069-2-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260114160243.913069-1-jhs@mojatatu.com>
References: <20260114160243.913069-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Design intent of teql is that it is only supposed to be used as root qdisc.
We need to check for that constraint.

Although not important, I will describe the scenario that unearthed this
issue for the curious.

GangMin Kim <km.kim1503@gmail.com> managed to concot a scenario as follows:

ROOT qdisc 1:0 (QFQ)
  ├── class 1:1 (weight=15, lmax=16384) netem with delay 6.4s
  └── class 1:2 (weight=1, lmax=1514) teql

GangMin sends a packet which is enqueued to 1:1 (netem).
Any invocation of dequeue by QFQ from this class will not return a packet
until after 6.4s. In the meantime, a second packet is sent and it lands on
1:2. teql's enqueue will return success and this will activate class 1:2.
Main issue is that teql only updates the parent visible qlen (sch->q.qlen)
at dequeue. Since QFQ will only call dequeue if peek succeeds (and teql's
peek always returns NULL), dequeue will never be called and thus the qlen
will remain as 0. With that in mind, when GangMin updates 1:2's lmax value,
the qfq_change_class calls qfq_deact_rm_from_agg. Since the child qdisc's
qlen was not incremented, qfq fails to deactivate the class, but still
frees its pointers from the aggregate. So when the first packet is
rescheduled after 6.4 seconds (netem's delay), a dangling pointer is
accessed causing GangMin's causing a UAF.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: GangMin Kim <km.kim1503@gmail.com>
Tested-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/sched/sch_teql.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/sched/sch_teql.c b/net/sched/sch_teql.c
index 8badec6d82a2..6e4bdaa876ed 100644
--- a/net/sched/sch_teql.c
+++ b/net/sched/sch_teql.c
@@ -178,6 +178,11 @@ static int teql_qdisc_init(struct Qdisc *sch, struct nlattr *opt,
 	if (m->dev == dev)
 		return -ELOOP;
 
+	if (sch->parent != TC_H_ROOT) {
+		NL_SET_ERR_MSG_MOD(extack, "teql can only be used as root");
+		return -EOPNOTSUPP;
+	}
+
 	q->m = m;
 
 	skb_queue_head_init(&q->q);
-- 
2.34.1


