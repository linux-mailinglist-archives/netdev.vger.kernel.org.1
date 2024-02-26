Return-Path: <netdev+bounces-75001-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F24867BA2
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 17:21:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E7CFB32096
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 15:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906AA12CD96;
	Mon, 26 Feb 2024 15:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NlX39HaN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D5212C55F
	for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 15:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708962679; cv=none; b=tRQPn/wgWSzCLvN6YZErod38Op5/e53H+PQ8A5ioDU90q2T0L4GwgNnKJm0LbYAasLjoiPOKOSxWL5yBehvdNzvU291eTjvuOcmFkHSM1xFcW2W74/o/BSRsB7w21ulhlsMi45fiwJLNdmwyYaWFoelfdhsSspNx7IGFINJfBTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708962679; c=relaxed/simple;
	bh=GLILOSxCZ2DqLzkJWkLjcT5JTuB232j0AbzPRjBs/ZU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=H7K9fEeM4gImDGXOAW1q/wr/dNjU8dS3WTHdtk3CxMJVT8HRiFKicrXbN/gWTwCg2Vc95ivNm89USEuf8+mzhlOiT0+gUKwCH3CtZf8Ofosox16ZasnVeuRHp7s8MOsh8/MIh8EXna+/cyayc9dDpxLHz5RK+SebaKGgmF5vvNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NlX39HaN; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60832a48684so48750807b3.1
        for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 07:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708962677; x=1709567477; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=D05c69v2En4zL++gk9H2Vf+b0n0+Zb9pBNQgR/CyUI4=;
        b=NlX39HaNcTcW7AUFexuH4VrbdvMIw37ymZfXjwDd23nb7vRyKNFBXhEQxX9RPzLD92
         VWikVFWjCzWIlQ20nVmMoBZaFwD3P/JDSNPx90FinLmhziivSgcP551TJKLKotgC4Joc
         hn1AHXIo8POrbhSNJMd3jvkv2Yl89GOqnLtGsPP6gPoR1VhkYbi560NbypXsYHCFLbx+
         mBlhgYtMLSF6Xqrvq3d5zq1kEgzsyrCE4x4aoCQz0NukXlVBy2L8dQsCSrsHBz/D5zAa
         133/2GUsBKFhCTJzCj9UwAxen0+kzkMQYcZCIG8PzoQ6xVb1nJeT7J05WiBUIS1agBuD
         HK0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708962677; x=1709567477;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D05c69v2En4zL++gk9H2Vf+b0n0+Zb9pBNQgR/CyUI4=;
        b=rYVr5YAr22MSNX0On+voH0xP8wbGKsBWr6DOZl85pBxGUAvF5XysMGGNqm+1G0+2mH
         lKCt5j2sl4+RhHwBq5ztgUIRCywqasWVt4k5o/16R0P+bTdUIsjJOz1aA2Bo2O9/lyjC
         pN9pfvSne2ndp6lNvpzDgQDGzc/6goxzceKbD3z7ki4Majr/8gD1aaE3n21nYk3jtNvq
         P8H2fgdT7mKmudLeiuHsdp6ERedDqOUNbz70RZ3P/9blY2S6sm+0Cv5dNRiYDnvxv9lZ
         y2vZLZAXgCeiUnQ6iFw06dALz1D4wfenOp1JYXGy7ACbh9FwjyWmHAEn/E2Vv84vCnfs
         BXiA==
X-Forwarded-Encrypted: i=1; AJvYcCVXdS83GDuV2A6E5eqm7b7t7ygdKL9/iqv9PfunoZXuJ5PszB0r5W6dsebig3tcBoQLGSLcZaxK6TpYnKSVQm4ktPcq47an
X-Gm-Message-State: AOJu0YwUg61JNm700fqjSj2v5DXZrOlIClLuHptAIUm08nO6rZsYNcQq
	JQXTddOhLuwPtU3PMIB+svxsu46IJAaTwobD7u32nK/E5mBppIv9jlrCYd3dZrRHW6wvCtJnCyg
	UyLRo2QSXHQ==
X-Google-Smtp-Source: AGHT+IGOC9rzykW+OJ57OYGcVM4PnuXEezt4UvB5EeKyX15U4wNGQtizVKF3/KlU8ItgE4a/LczAGLu4awei/g==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:690c:995:b0:609:20ac:da08 with SMTP
 id ce21-20020a05690c099500b0060920acda08mr35902ywb.7.1708962677087; Mon, 26
 Feb 2024 07:51:17 -0800 (PST)
Date: Mon, 26 Feb 2024 15:50:50 +0000
In-Reply-To: <20240226155055.1141336-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240226155055.1141336-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240226155055.1141336-9-edumazet@google.com>
Subject: [PATCH net-next 08/13] ipv6: annotate data-races in rt6_probe()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Use READ_ONCE() while reading idev->cnf.rtr_probe_interval
while its value could be changed.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv6/route.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 6a2b53de48182525a923e62ba3fbd13cba60a48a..1b897c57c55fe22eff71a22b51ad25269db622f5 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -645,14 +645,15 @@ static void rt6_probe(struct fib6_nh *fib6_nh)
 		write_lock_bh(&neigh->lock);
 		if (!(neigh->nud_state & NUD_VALID) &&
 		    time_after(jiffies,
-			       neigh->updated + idev->cnf.rtr_probe_interval)) {
+			       neigh->updated +
+			       READ_ONCE(idev->cnf.rtr_probe_interval))) {
 			work = kmalloc(sizeof(*work), GFP_ATOMIC);
 			if (work)
 				__neigh_set_probe_once(neigh);
 		}
 		write_unlock_bh(&neigh->lock);
 	} else if (time_after(jiffies, last_probe +
-				       idev->cnf.rtr_probe_interval)) {
+				       READ_ONCE(idev->cnf.rtr_probe_interval))) {
 		work = kmalloc(sizeof(*work), GFP_ATOMIC);
 	}
 
-- 
2.44.0.rc1.240.g4c46232300-goog


