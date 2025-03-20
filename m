Return-Path: <netdev+bounces-176616-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76460A6B19D
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 00:26:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CD654A2FDB
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 23:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E54AE22B5AB;
	Thu, 20 Mar 2025 23:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ncSKF2i1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B0F22AE68
	for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 23:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742513157; cv=none; b=ERC+v4SfuRBQE0a/Wi5qQv15HMvTagvaNVBuMAiOpN2gd3qIb0K06cTZd4uEr+DnGhNsoKVdADKge6yckQrL9pXhXkjyJJSQ+2B+VFiMGBjQT6EAfpncmuiAGqK1lUsRcv297G6DlkEMk57Li3UbGVys+rCLkAgbieilxkc/eDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742513157; c=relaxed/simple;
	bh=pQeK2BrF55u/0EXsKN0Qf4SQL6dnj2ecn8e7A3L1A0s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jPhl0XzVxYZg3OeHiHlC3c5zKshIabqbyUN83mWq55qZ80jotbBzeKg4PTNUE1mYYa4ewTi8dIYOI3IKLdJy4q2MPTeQTZ1ScnPjWGVaeHqBz/2nIbGMulADt2UvxpWSq6svbE0TtyhVgxVxbNLveINNGP78Eqz6kyH9ZVDkikk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ncSKF2i1; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-224100e9a5cso26647705ad.2
        for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 16:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742513154; x=1743117954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=moIEMrDcqnevzQAwwG+Lt8rXFaw/vlBOis0iockljXY=;
        b=ncSKF2i1W4/YUVaaI9Xm2b/Nz5KXm/+A/UNhKyOj0+//PoxwlZiUZtGHN2YufRqfWl
         QbTXLIFjvqFCUBsRvm1m328XTAX1Eniph4jxuW/uzTcVBmLMAc9FQxZ9JECBIVa7eDvr
         qTc6SpHDDPiuICnfNNrQexZ0wgIJKmPd+vyoF7nbq6WHPTNK1JNGib2F9/N6BB/4mbZO
         x+4OjOEnAb/hFw6Imw6fOuhJLseUNEUsK296r163D+X7pV3SNwH5KNV8qy2vM8Y5UEBY
         Np2L4Eror17mvHdHYBmWCBPUynCOLZOfHr9DCdhoiLgUu3ro0RqWvIY+ppVS/tY7X4I8
         Utvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742513154; x=1743117954;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=moIEMrDcqnevzQAwwG+Lt8rXFaw/vlBOis0iockljXY=;
        b=EmYAQQBE6A1vO5ww6340xkReZRnEbBnEVbXl6b8adDdtEcxJ0fqKnJLgewkfDT1Fqf
         WPnn5hJXdWKKOl0WgxeQTPjXDKNRXksocg1s6C/mivKS44tgk+C/wgclb1Uj7RssS5xQ
         leObXki7Gs3A21cqjnPLefN7ayWVL3rbJlcphMg8pGW5CVtwOddLVFH4hdFBEqLRd9m0
         Jac6cXJ+cRv2awB+77Da19P/VRqwxqs8808csb6S8TiEslZ16pGfUDpm6L+jzqeDbq09
         nrBaozUF257dwROt0XFu/XPyKkuKOgy09gj5jX7Dh7JGL0ynIayaAixhwDPDoSZh96Da
         I5VA==
X-Gm-Message-State: AOJu0YzWMZloHGxHrbixoZKYayH5rn9Dbpztg0Rl4mBisZjLyr29l3gC
	VUKyaOGqZ011hTybnY+PuomTq3GoViv0E9Qb+haOo54mZDskoDh2C0yiHg==
X-Gm-Gg: ASbGncsExQq+Cjg0tgmHBNr4zNQLfxg0Lx4GJHb2uYlJT0SaHJE+16pzRISxwheURle
	J0PeSrrPOJwox5mz1U0eY7d9u6wF0FrTbcF2lgwSwPGBAFuyxUVjqATZ0UR8xYbqWHF/kWmwT5v
	DcHXiunMZKTSGeEUzZrG6Jj0hPbKPzYrMU2hWBA1Ri2+rU5rTQr8rYzCebOl/cHh26H0fT5yeCU
	4gVwI3KMJ1GuaCq/AtR4Ksh8BfvLLm2N9y/t/XaxZ4HYBs6QAEG7A14Qma+qu0y4pd4Lhu/OCI1
	08tEk5Yi3yOVI/6zP2sY9E6jzxzPnvIhgiHDwjJBJ83mNN5zJZHX4YKEgaC5CDiGeQ==
X-Google-Smtp-Source: AGHT+IFf87YePQ0f09foI9ljWfF+G9xS6y+YMbqxzOetLb/fAEoUbSK5ZvCaJL7A+WBdb2gZLaG7kA==
X-Received: by 2002:a17:903:40cb:b0:224:e33:8896 with SMTP id d9443c01a7336-22780c536c7mr18302565ad.11.1742513153656;
        Thu, 20 Mar 2025 16:25:53 -0700 (PDT)
Received: from pop-os.scu.edu ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7390611ccf8sm416306b3a.120.2025.03.20.16.25.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 16:25:52 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	jiri@resnulli.us,
	edumazet@google.com,
	gerrard.tai@starlabs.sg,
	Cong Wang <xiyou.wangcong@gmail.com>
Subject: [Patch net 05/12] sch_ets: make est_qlen_notify() idempotent
Date: Thu, 20 Mar 2025 16:25:32 -0700
Message-Id: <20250320232539.486091-5-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250320232539.486091-1-xiyou.wangcong@gmail.com>
References: <20250320232211.485785-1-xiyou.wangcong@gmail.com>
 <20250320232539.486091-1-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

est_qlen_notify() deletes its class from its active list with
list_del() when qlen is 0, therefore, it is not idempotent and
not friendly to its callers, like fq_codel_dequeue().

Let's make it idempotent to ease qdisc_tree_reduce_backlog() callers'
life. Also change other list_del()'s to list_del_init() just to be
extra safe.

Reported-by: Gerrard Tai <gerrard.tai@starlabs.sg>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
---
 net/sched/sch_ets.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/sched/sch_ets.c b/net/sched/sch_ets.c
index 516038a44163..c3bdeb14185b 100644
--- a/net/sched/sch_ets.c
+++ b/net/sched/sch_ets.c
@@ -293,7 +293,7 @@ static void ets_class_qlen_notify(struct Qdisc *sch, unsigned long arg)
 	 * to remove them.
 	 */
 	if (!ets_class_is_strict(q, cl) && sch->q.qlen)
-		list_del(&cl->alist);
+		list_del_init(&cl->alist);
 }
 
 static int ets_class_dump(struct Qdisc *sch, unsigned long arg,
@@ -488,7 +488,7 @@ static struct sk_buff *ets_qdisc_dequeue(struct Qdisc *sch)
 			if (unlikely(!skb))
 				goto out;
 			if (cl->qdisc->q.qlen == 0)
-				list_del(&cl->alist);
+				list_del_init(&cl->alist);
 			return ets_qdisc_dequeue_skb(sch, skb);
 		}
 
@@ -657,7 +657,7 @@ static int ets_qdisc_change(struct Qdisc *sch, struct nlattr *opt,
 	}
 	for (i = q->nbands; i < oldbands; i++) {
 		if (i >= q->nstrict && q->classes[i].qdisc->q.qlen)
-			list_del(&q->classes[i].alist);
+			list_del_init(&q->classes[i].alist);
 		qdisc_tree_flush_backlog(q->classes[i].qdisc);
 	}
 	WRITE_ONCE(q->nstrict, nstrict);
@@ -713,7 +713,7 @@ static void ets_qdisc_reset(struct Qdisc *sch)
 
 	for (band = q->nstrict; band < q->nbands; band++) {
 		if (q->classes[band].qdisc->q.qlen)
-			list_del(&q->classes[band].alist);
+			list_del_init(&q->classes[band].alist);
 	}
 	for (band = 0; band < q->nbands; band++)
 		qdisc_reset(q->classes[band].qdisc);
-- 
2.34.1


