Return-Path: <netdev+bounces-183225-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC5CCA8B6BE
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 12:25:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F01A1770DE
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 10:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 662CC24887F;
	Wed, 16 Apr 2025 10:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="gFitkO0c"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E443E248869
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 10:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744799087; cv=none; b=gvD5adCdRtUzerjHt0GrWu4bfHmjkItF1oRcXOlzKf4Lg6UZ0yREl01mhgHymB7HGkOTEVejF30f0mGgBPTr26yp2dJjAr3NPyvd8c6cAcKNjpfSODId1N1Qn1SYOEmmGSOCUYC2RBL/J1pEVBujJwZAyRYL7UYO5HCMrl+eeT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744799087; c=relaxed/simple;
	bh=l/t6gA4UY1kIv67YoF9M+fIKr91RXpRPC0lZR5sniGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WCWg/4xDodPS3HfVEJ0S9YzZ6mEhnRCMHP5WJrRV2Yv+XTVieeEkLVY43bKzXEeb3UVJjVpJdAvIox2hy+4h1tX3BRejpRWcopw8JwrzSRuU8EE0emNsHNuR4WNhA5yRqW2a9dRTTbmSjteDhiDUA1PumtWLCEIU59+R0I4THt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=gFitkO0c; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-af5139ad9a2so4585057a12.1
        for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 03:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1744799085; x=1745403885; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Rh8ko+Y85Vwg2eEvNNVcZcq5fGAb2hbLBn++HtKH28=;
        b=gFitkO0caH6fFU5I34H8DsMS//vRmXVQb6UMu+tlgJFQIzgJmmIdJMgSGOQZq3Nswl
         aNgfzkVX3iipvwASctIZYeFsk5esW4DjdBnWXyBAvgCc4ClPVk2f6Z660pc6ntzTD2EU
         I+DMxMXQ6CeYKPMOFPrWy8gOZcIMalpYw7MNXheyIRo2jnP8WhsfYEm5+ORNTz41CqOx
         w9YQCZSyi7GHwVEV6KTXZOlCEbShgrC7CxRN3dH0pwqF/dA0FmET6tG4ZZbAnjDLFuYl
         XyBVWyisPB1pj1u+Z4SOqZlOFRdUX7ad3ur9IlaDKtGJ5ZiASpviZmMPLsQPQY6DI+IX
         IFrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744799085; x=1745403885;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Rh8ko+Y85Vwg2eEvNNVcZcq5fGAb2hbLBn++HtKH28=;
        b=hqcIDZbupQ183+c5ipQ8teb+VQMvW33nzBUByni5q+TDXVdcwoclzMsE+4OEEzEpe2
         uLBFMgoroZaiArrt31ahMFdmVSPmeQz++5BWCbeP3bB5dprbIOkALpeRx+MW0f4SF2Pn
         vNXAFl9MeuIViyJMm3S2Vemty64xcMLWHyoV64n8jvwhm3qrALYbYK8dcwKU/w9eayKm
         roltwHicdmKYKlE44CgHBcdiQzDygdSxZSO15HPYsfdzT1w12CHnN10irRYcm60nI1/i
         9BoPFpA0pzsh4EX255E4eyM9cb/Pel6DTst+4kzmBsDR454BhxkW5lGtU96Bdg3w63Ti
         YZCw==
X-Gm-Message-State: AOJu0YyzKncLyhJwUz3SN1vy1re7Wy2D4rogSEDr5eGYVfJ6YW40h9ig
	UP0j0gPm2hZMxDmAdaSrmLwOuAP/As79tNTv/JXrxqDaBVshUUhPnwvMKQv2FHVVkP0XJzkjCHc
	=
X-Gm-Gg: ASbGncs46yIbJanFOGP2q5cmm8qhtbTrPnoFL2wL0ryr75xn87DKbtS6y6+Jbd/UNYB
	l4eHYuhCBa1mdVSFTLWnF3sylQKgfiuwdP6az0vremTpYDbErD4fBYrPl6i4llKDYp379uG3570
	srFjs3VAvxP/fwOSEkK1o/zT0akP+azdlI19J4HtoFcJ9KFUalwM+sWTvDpvJz+vngW9Ps8M07P
	NolVEDEyFZeFQy4byJIFVDDhm6qVWk1N5FIulv6bORiD++TWxKo4ucmuG9rmxvRdiqqFr0z3wM9
	NPnAYfXlM6B6ni161vuqMUTu9tCYk3+t9ObLkaYBUXMCSRQQ1CWZiHp2DJ3Df0pM
X-Google-Smtp-Source: AGHT+IHrNBEXD32tTc2ctTVHbEdKxeIs6e6pH+yjtSX96OZr9VqbDkWxIBvU+yXYWzxzCbGydguGrg==
X-Received: by 2002:a17:90b:58c3:b0:2fe:a0ac:5fcc with SMTP id 98e67ed59e1d1-30864173c30mr1521518a91.34.1744799084906;
        Wed, 16 Apr 2025 03:24:44 -0700 (PDT)
Received: from exu-caveira.tail33bf8.ts.net ([2804:7f1:e2c3:dc7b:da12:1e53:d800:3508])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-308613cb765sm1193075a91.43.2025.04.16.03.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 03:24:44 -0700 (PDT)
From: Victor Nogueira <victor@mojatatu.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	toke@redhat.com,
	gerrard.tai@starlabs.sg,
	pctammela@mojatatu.com
Subject: [PATCH net v2 3/5] net_sched: ets: Fix double list add in class with netem as child qdisc
Date: Wed, 16 Apr 2025 07:24:25 -0300
Message-ID: <20250416102427.3219655-4-victor@mojatatu.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250416102427.3219655-1-victor@mojatatu.com>
References: <20250416102427.3219655-1-victor@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As described in Gerrard's report [1], there are use cases where a netem
child qdisc will make the parent qdisc's enqueue callback reentrant.
In the case of ets, there won't be a UAF, but the code will add the same
classifier to the list twice, which will cause memory corruption.

In addition to checking for qlen being zero, this patch checks whether
the class was already added to the active_list (cl_is_initialised) before
doing the addition to cater for the reentrant case.

[1] https://lore.kernel.org/netdev/CAHcdcOm+03OD2j6R0=YHKqmy=VgJ8xEOKuP6c7mSgnp-TEJJbw@mail.gmail.com/

Fixes: 37d9cf1a3ce3 ("sched: Fix detection of empty queues in child qdiscs")
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
---
 net/sched/sch_ets.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/sched/sch_ets.c b/net/sched/sch_ets.c
index c3bdeb14185b..af5827377ebc 100644
--- a/net/sched/sch_ets.c
+++ b/net/sched/sch_ets.c
@@ -74,6 +74,11 @@ static const struct nla_policy ets_class_policy[TCA_ETS_MAX + 1] = {
 	[TCA_ETS_QUANTA_BAND] = { .type = NLA_U32 },
 };
 
+static bool cl_is_initialised(struct ets_class *cl)
+{
+	return !list_empty(&cl->alist);
+}
+
 static int ets_quantum_parse(struct Qdisc *sch, const struct nlattr *attr,
 			     unsigned int *quantum,
 			     struct netlink_ext_ack *extack)
@@ -436,7 +441,7 @@ static int ets_qdisc_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		return err;
 	}
 
-	if (first && !ets_class_is_strict(q, cl)) {
+	if (first && !cl_is_initialised(cl) && !ets_class_is_strict(q, cl)) {
 		list_add_tail(&cl->alist, &q->active);
 		cl->deficit = cl->quantum;
 	}
-- 
2.34.1


