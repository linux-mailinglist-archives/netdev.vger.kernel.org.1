Return-Path: <netdev+bounces-118994-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80493953CD2
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 23:41:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 328101F2501C
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 21:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B491D15382F;
	Thu, 15 Aug 2024 21:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BJnRyG2M"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CEF1494C4
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 21:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723758097; cv=none; b=MQ4fjUEGDbeiAdQrRnjVaF1tpYEOe8AC3BMqGaHkM2ogQLrxEZd+d57nsWeN2ut2i7ldAU44ZojJ0pVdecS6LbSIRryzd1EdTlO6PQ4DU8AEFvqzmGhf0z52j/i43IqZF5OwunH9JaaIVaXDERBwlaHEe0m9SdiWzVDNLZwqkxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723758097; c=relaxed/simple;
	bh=RJOdyQk5YS5vkcEStZbhhx/Fp61qZXNrMPZ5Tz0sNxM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z7tjcRFa6d7+tOWmBqcK63Se0HUs1ft06ottusgxRGwv/ep8bpjOBSWxVBGKJl+pU5GpMdITuIEMuP+LYEsDCirBV+NAIk/GBguHDS2zT3vBJBWSYneDQ/zGe9VQxKRDpQ1AZmD3BgW+ulAv+E1rO7XXWlpiirS/aWt0Jhao52U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BJnRyG2M; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-39d2256ee95so4052885ab.2
        for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 14:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723758095; x=1724362895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JoERIu1FC2fazUz3T9WwFNEk7GAnoCdN5OwGuGypPeM=;
        b=BJnRyG2MRDY5L2624o8pnUfdlmS1TZXpPtWeCDqvV6p7BRYZGCksK5cB+n5pbufNZl
         kVWvGw1tt0cNwZ2KrWoK1PaZ10DdO6rktzcWVMU0wDxWQOu6wbeihaKyhQ/zpe7C1t6X
         KDSq3OgPXBTQ3vg1OdHvSP/ODPY0w9hhkR+W8pVIdylXXlzOOY0e/G8BdIRMlKFhS4F/
         RtKhULLOceBq5Kk7+dJSeSGFbqd6GXHw4v3wGzqZSSOhpbHUyX+J5+YTB9m2Kg8FOYfS
         oshO/M1F+CsQcfFZaUG+caUBUBj0/q5KIMRvDWRNlKev4MRC+Qqsh5pRzeax8qP4EB2L
         +nkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723758095; x=1724362895;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JoERIu1FC2fazUz3T9WwFNEk7GAnoCdN5OwGuGypPeM=;
        b=OBskSNwb1RiGJ/ilbEMpsmrOVyYqs/8mLm+rojbRxVVmzjjR+SqLAsbBclWdiNp2qK
         DnF2gHkq0ZwpZghkPu2Xwy5qtKoDjkhilIaiwmCJQ6TBnvey10JKeVUfnTZTa5qLCmKz
         Oc0G4sWdFJkTjNkvZRYF8dETmXPeYvSsiblCu+Sdr8SBCT5JfuFc6mUXJ4+fOqA+dIpp
         u0eMhwd8NRQ+AUsA40CzuHm4N0vBJ1wPSEOvxubJeHWQNJLNWPiFBngEVyaoXJl9xnjb
         Y4UqDq1MxDn4DHFlrQkrltnN8fP+1b5f7RKFbsFxt/JrVpsLUhBvJK9n9IuXiRHDka5o
         9rVg==
X-Forwarded-Encrypted: i=1; AJvYcCUYINOrgxQD+c1cODo1oOtugFqmMmIjuwqqYGe90SbQxuBr2e8PtX1kUY8cD5RCwld1IWj55QwC9/WNDPzE6UBk8RdwJ+qS
X-Gm-Message-State: AOJu0YzIUEb87QKY6kK69Sib9fDvq4gJe2pTaIWyhyLu9ME8Mc788DP+
	0n45QeNfW5ksWDw0AssE8pKWT/7d063rjkZmiOGYbTmq4pb1CIF1
X-Google-Smtp-Source: AGHT+IES2u0xs3lzQZfRNAAejaxbCSxLljDZjByIRvJIZpMaaD50Gf3BmzaU67RH6k2wKaUPZNLTqQ==
X-Received: by 2002:a05:6e02:19c8:b0:375:9c7e:d09 with SMTP id e9e14a558f8ab-39d26ce63abmr11003235ab.7.1723758095207;
        Thu, 15 Aug 2024 14:41:35 -0700 (PDT)
Received: from jshao-Precision-Tower-3620.tail18e7e.ts.net ([129.93.161.236])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-39d28e13cd8sm642125ab.22.2024.08.15.14.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 14:41:35 -0700 (PDT)
From: Mingrui Zhang <mrzhang97@gmail.com>
To: edumazet@google.com,
	davem@davemloft.net,
	ncardwell@google.com,
	netdev@vger.kernel.org
Cc: Mingrui Zhang <mrzhang97@gmail.com>,
	Lisong Xu <xu@unl.edu>
Subject: [PATCH net v3 1/3] tcp_cubic: fix to run bictcp_update() at least once per RTT
Date: Thu, 15 Aug 2024 16:40:33 -0500
Message-Id: <20240815214035.1145228-2-mrzhang97@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240815214035.1145228-1-mrzhang97@gmail.com>
References: <20240815214035.1145228-1-mrzhang97@gmail.com>
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
v2->v3: Corrent the "Fixes:" footer content
v1->v2: Separate patches
  
 net/ipv4/tcp_cubic.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_cubic.c b/net/ipv4/tcp_cubic.c
index 5dbed91c6178..11bad5317a8f 100644
--- a/net/ipv4/tcp_cubic.c
+++ b/net/ipv4/tcp_cubic.c
@@ -218,8 +218,12 @@ static inline void bictcp_update(struct bictcp *ca, u32 cwnd, u32 acked)
 
 	ca->ack_cnt += acked;	/* count the number of ACKed packets */
 
+	/* Update 32 times per second if RTT > 1/32 second,
+	 *        every RTT if RTT < 1/32 second
+	 *	  even when last_cwnd == cwnd
+	 */
 	if (ca->last_cwnd == cwnd &&
-	    (s32)(tcp_jiffies32 - ca->last_time) <= HZ / 32)
+	    (s32)(tcp_jiffies32 - ca->last_time) <= min(HZ / 32, usecs_to_jiffies(ca->delay_min)))
 		return;
 
 	/* The CUBIC function can update ca->cnt at most once per jiffy.
-- 
2.34.1


