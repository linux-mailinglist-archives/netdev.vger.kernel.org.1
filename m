Return-Path: <netdev+bounces-87953-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CFB58A514A
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 15:28:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4ED2E1C22260
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 13:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 389D183CB9;
	Mon, 15 Apr 2024 13:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PiMcoc5U"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C380983A0A
	for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 13:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713187267; cv=none; b=jErPpXYcN5YpcbYfpwsdxqcKA3nTxFATRYTFuYEAm6m2BmA9o64MC14qpkIg23MijIaIycJ12gqMDoZcRwqbRLeFKrS+AEsjlg6kDvqmdVfY42Zl2u1g67fKV3zM/GrV9ZMQ8pkBGo46Lcd18neXaGS+1MPrbquU/yXbOaQ1wrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713187267; c=relaxed/simple;
	bh=CjsjQ+yVMr/aYiDnmks5Z/g6Vq5gK5w2SOGR5dDm4mg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=umQetc77b/SFeC2SOJbN2yJBshkHs5BeleJ88yYg623Bh9kxmDltaE/PiLFKjmQTsfR4v9ZE89/Dt0SxTWm7doOkjtMRc6Fj1S4MXavhX7YTiKqEp3AmNOQmvn25F4vwkqPbZVPOvAqKHgZLRoKKF7NJlIh13W4w4oD0cRyPros=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PiMcoc5U; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-ddaf2f115f2so4579916276.3
        for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 06:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713187265; x=1713792065; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=shuoDMWDIQAb4xjF8TvMXV0W+kS1OzrCQN9OhM8Lglk=;
        b=PiMcoc5Uvm4unhBFr2CT7AgZa4jHCsu7v4N1OtYeLE3YXPVjxLvzVPFVWYSt5lHLLY
         aIV7Pva63Pr7u8UT4XBfCgdkuGGAxPD3tkabclW9eGKM9Ly9GyBpsRUePyd/3JpAIJa2
         rjXKnXNOBKE65IsFsiksqJ+SmYkCdoGIokSLuXV1bhDHdSOijC+fcVOU0dSpnFaa3nX3
         G+Hf4Wv9R6oyCYcPqvP+GfeVz0scvc3BhFLau+NLf33HETt0OXxI5zNDS5cB+dsLFJf3
         wV7agor0A+nEAB9B+jiJ3bi0ZaOTTIQk9gAHQEZc0IlT+NbTY2GyT3jjJdmS2LuSlFkI
         BRMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713187265; x=1713792065;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=shuoDMWDIQAb4xjF8TvMXV0W+kS1OzrCQN9OhM8Lglk=;
        b=ADL0RZq/wWclmbVmU09b3VKVEIv7Jw0Lv0co008n2n94lrhHcw0ngE5cafoc28CkxT
         h2Qop5tSS8M9rbauvFtexQ2ZGlQy97xF55wAmCr5fvxlQgOGUa2Ej862zbciW/56ld0W
         pEtVnPc33pPF0Ac+6hc+sf5Cyo9noEv+udnhzDKSn+0VbWek++w6p7gkS8+L68URdnZb
         LAz7stTQMDvIcMCWpH5xEILEWFsTVon8rBx3qd1ek25ifVGak72E4ONYCAFynZgxZA7b
         Ty8LR86GsWGJTpRnePoH51T4pruIJnWgxTuhatAuVqwUkRVLUju5clY9EWLIYrPxSt9a
         KdhQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwXbM6f0WZ3QtFw2hCepwMrim43rrsAYjNabXNMlSK/Qb90c9ySYLI9R9z/We4pd9OZ3M8eJCjFETQLAWe89omPCCTlxhT
X-Gm-Message-State: AOJu0YyFJTmTEV42fcYMUM53TQjrYIPv+pzPDtA6g41ydxbZ+/1bKFUL
	wEk8Fox0hqfBYw0tA6Fme28bS1cTztCfY5kKU4YyIwilJejQQ6V/nYeZXRzAlz+rogtLtqGASle
	+HW4Nd+m4qQ==
X-Google-Smtp-Source: AGHT+IGS4HDaAwYtHiB4d0v1vJVf3HJMxbOnopv+Z/8XURMaq12XB8fwmcFRwrzl8IdnnwyqvbZceHrzsh5oXg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:c0c:b0:de1:d49:7ff6 with SMTP id
 fs12-20020a0569020c0c00b00de10d497ff6mr802725ybb.7.1713187264733; Mon, 15 Apr
 2024 06:21:04 -0700 (PDT)
Date: Mon, 15 Apr 2024 13:20:46 +0000
In-Reply-To: <20240415132054.3822230-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240415132054.3822230-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Message-ID: <20240415132054.3822230-7-edumazet@google.com>
Subject: [PATCH net-next 06/14] net_sched: sch_tfs: implement lockless etf_dump()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Instead of relying on RTNL, codel_dump() can use READ_ONCE()
annotations.

There is no etf_change() yet, this patch imply aligns
this qdisc with others.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/sched/sch_etf.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/sched/sch_etf.c b/net/sched/sch_etf.c
index 2e4bef713b6abc4aad836bc9248796c20a22e476..c74d778c32a1eda639650df4d1d103c5338f14e6 100644
--- a/net/sched/sch_etf.c
+++ b/net/sched/sch_etf.c
@@ -467,15 +467,15 @@ static int etf_dump(struct Qdisc *sch, struct sk_buff *skb)
 	if (!nest)
 		goto nla_put_failure;
 
-	opt.delta = q->delta;
-	opt.clockid = q->clockid;
-	if (q->offload)
+	opt.delta = READ_ONCE(q->delta);
+	opt.clockid = READ_ONCE(q->clockid);
+	if (READ_ONCE(q->offload))
 		opt.flags |= TC_ETF_OFFLOAD_ON;
 
-	if (q->deadline_mode)
+	if (READ_ONCE(q->deadline_mode))
 		opt.flags |= TC_ETF_DEADLINE_MODE_ON;
 
-	if (q->skip_sock_check)
+	if (READ_ONCE(q->skip_sock_check))
 		opt.flags |= TC_ETF_SKIP_SOCK_CHECK;
 
 	if (nla_put(skb, TCA_ETF_PARMS, sizeof(opt), &opt))
-- 
2.44.0.683.g7961c838ac-goog


