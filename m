Return-Path: <netdev+bounces-119426-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 847B49558FA
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 18:35:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01FFA282723
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 16:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA886155333;
	Sat, 17 Aug 2024 16:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bEl2KHgM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4AE225A2
	for <netdev@vger.kernel.org>; Sat, 17 Aug 2024 16:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723912522; cv=none; b=OmbESGCYsb/Pt385k6/VnFi11O0vDR+9uq+jWN1kAO2T4FtOiMJaCQk12cwc5ffPyvqidnV5tpZP1CyiLQXv1qljk/LQQviHF5prd4TN50MXyBxGODKSP0DO4vXLWRvwTUhys2gMoLtHNBZoda9q2YoNu8JRHmLwEKnGTnInKOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723912522; c=relaxed/simple;
	bh=q62qOtdxsv9W57eQq5osDzNkxZ8lZ6FUDU9zrCoO/ag=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sELJBxmuZLa6BXJ/9akqZ2f+t2LJTOr2yfAyDXz3oOo5kB25wlSCpLCv9/tJ0DBPX2Y2PA+nbAdQzWUWZyWF8lRpEi4rtwj/JIRXrzwp7OwBbung5EnXBlj/L5FvrtaTzu+ufvq8F8Rs5Ic4g1gXpUFavYAxw7ROVhQ8K6y8TLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bEl2KHgM; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6bf747371ecso12423806d6.3
        for <netdev@vger.kernel.org>; Sat, 17 Aug 2024 09:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723912520; x=1724517320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z0VsA74EdKq55dTEa5TbNU4terTLqHKKcmInS2/omLc=;
        b=bEl2KHgMWN3e31CW4oZE/F1HR4Tneb0n0lMqK0+2F2hEklqWIhuV3PFOfYfbjz7zWB
         hpR5woth6Nj8vTeVm6YfP3ntW9/Lp5Ff1zIGXTlJkToRUTP13lpPF8gYikm9ATdVs/8D
         nzJdtAdHtEsxtZ00EljpC+vLbYc7diGMkdo55KG9CGaQIrVNFzV2DIzd0Za3ktVohYxL
         nwsrPiWeItfgtwXp+3nvgWWnEBD7g6VhHbl8hlt8cnm81M5W5ClrhbjnR4ZMJGmgYmH/
         3zzTxCTgSq7x61VpJqL3qiEDc/RIAyu9/2Y4Gg5P9gBCmgCb9AjZZL/Eqqu5KySbujFP
         +SPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723912520; x=1724517320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z0VsA74EdKq55dTEa5TbNU4terTLqHKKcmInS2/omLc=;
        b=ppWPttu6S1j4pBDt1W+Jpkv4qRGSwuxk86hvEe3tAKI1G5wLO3SO3qCEPDGS218iTw
         UKd7eG9QwapY2XGQm0BVCVp0XjUsQpWyEyC6LJXOOKj34qzS4sX7b1i/SymOGQ3E94fy
         Sdlg1S+Ql3P26/7eT1NXoUrJ47ZcXJR00Mqw9Y8P/k454/iqpn6MJcRn7AnbT7mPSTik
         bwGHV/dmyV7kkl1OWbRRXrIJlfL01xccjZwPAbKIK7eFfK4QBbGD8Q5H7+THhMgUDZQE
         z5W+INtEVSVKpudTuQBver97LolfepMk3WnuXsMrlCyG8/9y7ObRtZb6zmK3LQPJrowx
         9VKA==
X-Forwarded-Encrypted: i=1; AJvYcCWrcsxJr2h7scRaPLglPHR5IgnWQwLJ47HHRqIFEnoye0GcOk0DDo7t1CVucUa9fM5ApaMIfvIuK+F3IC0N6sTcSp7k5rTO
X-Gm-Message-State: AOJu0YwNSI83bvOtHNJNqNo/b9TN8ggAiyqwHdY6RkscsAfRVDtWS7BY
	rb/t3LR3C1pnlACq0lN2WUY2WnZH0DfFKxeIPAgi/2QBcVTg+Bzn
X-Google-Smtp-Source: AGHT+IFJ8+/wTtIQcrDnhWzhBncH3aC7aw+ywtD7rFJJb38WOKLOdIo5xmU3pXVOsu7tUCBtDtwBaw==
X-Received: by 2002:a05:6214:590d:b0:6b7:9bdd:c5ac with SMTP id 6a1803df08f44-6bf7ce7c406mr65466546d6.54.1723912519940;
        Sat, 17 Aug 2024 09:35:19 -0700 (PDT)
Received: from jshao-Precision-Tower-3620.tail18e7e.ts.net ([129.93.161.236])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bf6fef242esm28319406d6.118.2024.08.17.09.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Aug 2024 09:35:19 -0700 (PDT)
From: Mingrui Zhang <mrzhang97@gmail.com>
To: edumazet@google.com,
	davem@davemloft.net,
	ncardwell@google.com,
	netdev@vger.kernel.org
Cc: Mingrui Zhang <mrzhang97@gmail.com>,
	Lisong Xu <xu@unl.edu>
Subject: [PATCH net v4 1/3] tcp_cubic: fix to run bictcp_update() at least once per RTT
Date: Sat, 17 Aug 2024 11:33:58 -0500
Message-Id: <20240817163400.2616134-2-mrzhang97@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240817163400.2616134-1-mrzhang97@gmail.com>
References: <20240817163400.2616134-1-mrzhang97@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The original code bypasses bictcp_update() under certain conditions
to reduce the CPU overhead. Intuitively, when last_cwnd==cwnd,
bictcp_update() is executed 32 times per second. As a result, 
it is possible that bictcp_update() is not executed for several 
RTTs when RTT is short (specifically < 1/32 second = 31 ms and 
last_cwnd==cwnd which may happen in small-BDP networks), 
thus leading to low throughput in these RTTs.

The patched code executes bictcp_update() 32 times per second
if RTT > 31 ms or every RTT if RTT < 31 ms, when last_cwnd==cwnd.

Fixes: df3271f3361b ("[TCP] BIC: CUBIC window growth (2.0)")
Fixes: ac35f562203a ("tcp: bic, cubic: use tcp_jiffies32 instead of tcp_time_stamp")
Signed-off-by: Mingrui Zhang <mrzhang97@gmail.com>
Signed-off-by: Lisong Xu <xu@unl.edu>
---
v3->v4: Replace min() with min_t()
v2->v3: Correct the "Fixes:" footer content
v1->v2: Separate patches

 net/ipv4/tcp_cubic.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_cubic.c b/net/ipv4/tcp_cubic.c
index 5dbed91c6178..00da7d592032 100644
--- a/net/ipv4/tcp_cubic.c
+++ b/net/ipv4/tcp_cubic.c
@@ -218,8 +218,12 @@ static inline void bictcp_update(struct bictcp *ca, u32 cwnd, u32 acked)
 
 	ca->ack_cnt += acked;	/* count the number of ACKed packets */
 
+	/* Update 32 times per second if RTT > 1/32 second,
+	 * or every RTT if RTT < 1/32 second even when last_cwnd == cwnd
+	 */
 	if (ca->last_cwnd == cwnd &&
-	    (s32)(tcp_jiffies32 - ca->last_time) <= HZ / 32)
+	    (s32)(tcp_jiffies32 - ca->last_time) <=
+	    min_t(s32, HZ / 32, usecs_to_jiffies(ca->delay_min)))
 		return;
 
 	/* The CUBIC function can update ca->cnt at most once per jiffy.
-- 
2.34.1


