Return-Path: <netdev+bounces-246150-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF15CE018D
	for <lists+netdev@lfdr.de>; Sat, 27 Dec 2025 20:41:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D5DD13002D1D
	for <lists+netdev@lfdr.de>; Sat, 27 Dec 2025 19:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 508FE32860F;
	Sat, 27 Dec 2025 19:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KhDBuLFl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80E6288502
	for <netdev@vger.kernel.org>; Sat, 27 Dec 2025 19:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766864508; cv=none; b=DbF2oc92lnNV5ijx4GtkSUzgW4kBBgbaICwd9cQOj6kEz/9BgmVDdHfcYD7D5ru2VkYvpp/nxfxPRTFFAYYHPSLIy8hxYCZ+OGFS38RhyEI8DiV5DihovEDIgSWSfkgxjeRYDakuQ+znBtm7ffg5nKEzZkAUPd9IjK3q5oW4CAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766864508; c=relaxed/simple;
	bh=60js29DrxEmVfjRyNSAa9cu3X1JpEWwx4tMUQluF6zs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oUvzaCOhAV0y79QS8xQVpsMV+alTFkKlDm02D5RCfI2vAuMoA9Ajz5FJjHtS7X9+R+p8e6S1MbKchTwBTzokC6DgvlAUltnCI9cDALVNbFkDgMEyal20AY8wWhaJqzEbNKcOEUJ9ffOAQgdL68sRKOva463dp57lCsEM3pB5kp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KhDBuLFl; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-bc274b8b15bso8599407a12.1
        for <netdev@vger.kernel.org>; Sat, 27 Dec 2025 11:41:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766864506; x=1767469306; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m+L1lDxbwhOQ5D6cAie83c615A1Xhu0BfxGqT7vZoyw=;
        b=KhDBuLFlqebL3iPgmkr/Kw+c8gdu0nepvpHh0MQKpGBqkbFQFO18bCO7mDjjMiHjSj
         4VjvbMAlAaiMvN2HVw/A/QukK46I9Ubbjpge9nTfbbBai5GTXYblO7Rc07YMp1pY5kGJ
         PK3ZOoIG61drl+06KlcJN4tYICeIbTI7pz2hKCxnRSJiNKlSeHCG9lpgOfuGIfO2Ih5R
         U9+U4jVRv7aKvakVEiTBKFxt8nUrtAEzUskDD7tHQVCtYoW54UN9aDCMt8+zfaW5ZQR0
         TwN2t4rTBUgB+vM1wXiqNWdav/nQhVsRWGLhIcr01V9kvNyNs62/wrC3kNBqp1hVSPtE
         At8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766864506; x=1767469306;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m+L1lDxbwhOQ5D6cAie83c615A1Xhu0BfxGqT7vZoyw=;
        b=VtlxA30kw9l/GspExYm38LcyYFGPw/xOheTDYZ9zQ7KkJCs2d7ITbNkkPx1g0p9OC0
         W2BdktV2MxN23nfCQKUXopUF+1bP3NMLi3Qi8ULw8PAFAEekEngIkS1GBdmd3U1fYcmE
         QqN2jhIwzprYY2v7T2CJUtSDgJHZB2JmJuIYj+jxqcQsZzJQf69ZXcazVU/ttWLRY3Pt
         +J8ZkPBHvQDAc7T4TGLuUSc0DhgH2IOfxT4Rw9rhCy+ZuuOJLk8ALO5HZiIRKkwVj7oV
         DFBrQgcIHMUzjfsv/uudzDrwhskeon7AOgxiDIjVc0Xht0m3Kqxk0xWsKBRNFHjAyceZ
         5lBA==
X-Gm-Message-State: AOJu0YwK0VVVRZcg/okDsqIB0xhge1MvECPCai0A5YPwwLh7vog2gczO
	Mnbm2qFDL/Vu1RTVzH+CgRGXdLQw8NiAVdpKPPclGK6OHAYP8e0qGShFLcNBMQ==
X-Gm-Gg: AY/fxX4Gicg+5aB40nWAaYlaoYmzO9b5E/Pb8EYKCjo14ikW/GOMvecqMemXNbjVYEZ
	0gP9ungyq7Ke6BSUyXdH37a+kp7s4kNwNov1pBHM+VLKaZDe576vGOXb5Zbt/5meEemsz+mMhAP
	or/0aRDB5ExswN/CYIDV1EmLLEmdnWYqOBZWOwoRJQOCZgRjLTuLITgL9hpPgrvaFXP1CChI5eC
	oDY0bYwjxVM2SUkA6m3eLCGWp1S9pRHgPKd4ZdyuhJ+TD9/ro/jKNvEm/jc0fJzl8qy99TXNitX
	x+Znlk4CHmpZxoyV5WleY9vtRGnpTi5/c70bhANA+GS2su5cxhhvBhtRyZs23SfySYQ3sB7043v
	kAoCF5GCxBBqYFKIwMq4/DTqcX2+HuDpceB3OCOa3t1q8U3cJuN77ipiVZ9sbmg/799N6GzxNy2
	x1e5OrKgVgstx/f1ik
X-Google-Smtp-Source: AGHT+IHinn8ThZ75EQNwuOQyNf/w57tZBTQScS3UQt+T/Abquv91XwFsWdPF+gvTbODdlsfAr5KHWA==
X-Received: by 2002:a05:7300:51ea:b0:2ae:57c2:7c96 with SMTP id 5a478bee46e88-2b05ec6f3cfmr20325502eec.24.1766864505610;
        Sat, 27 Dec 2025 11:41:45 -0800 (PST)
Received: from pop-os.. ([2601:647:6802:dbc0:de11:3cdc:eebf:e8cf])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b05fe5653esm59087584eec.1.2025.12.27.11.41.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Dec 2025 11:41:45 -0800 (PST)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: Cong Wang <xiyou.wangcong@gmail.com>,
	Xiang Mei <xmei5@asu.edu>
Subject: [Patch net v6 1/8] net_sched: Check the return value of qfq_choose_next_agg()
Date: Sat, 27 Dec 2025 11:41:28 -0800
Message-Id: <20251227194135.1111972-2-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251227194135.1111972-1-xiyou.wangcong@gmail.com>
References: <20251227194135.1111972-1-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

qfq_choose_next_agg() could return NULL so its return value should be
properly checked unless NULL is acceptable.

There are two cases we need to deal with:

1) q->in_serv_agg, which is okay with NULL since it is either checked or
   just compared with other pointer without dereferencing. In fact, it
   is even intentionally set to NULL in one of the cases.

2) in_serv_agg, which is a temporary local variable, which is not okay
   with NULL, since it is dereferenced immediately, hence must be checked.

This fix corrects one of the 2nd cases, and leaving the 1st case as they are.

Although this bug is triggered with the netem duplicate change, the root
cause is still within qfq qdisc.

Fixes: 462dbc9101ac ("pkt_sched: QFQ Plus: fair-queueing service at DRR cost")
Reviewed-by: Xiang Mei <xmei5@asu.edu>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
---
 net/sched/sch_qfq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/sched/sch_qfq.c b/net/sched/sch_qfq.c
index d920f57dc6d7..bb7ebaff75cf 100644
--- a/net/sched/sch_qfq.c
+++ b/net/sched/sch_qfq.c
@@ -1145,6 +1145,8 @@ static struct sk_buff *qfq_dequeue(struct Qdisc *sch)
 		 * choose the new aggregate to serve.
 		 */
 		in_serv_agg = q->in_serv_agg = qfq_choose_next_agg(q);
+		if (!in_serv_agg)
+			return NULL;
 		skb = qfq_peek_skb(in_serv_agg, &cl, &len);
 	}
 	if (!skb)
-- 
2.34.1


