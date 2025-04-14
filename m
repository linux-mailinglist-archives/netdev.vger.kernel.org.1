Return-Path: <netdev+bounces-182041-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E64A877B0
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 08:03:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4C7F188BA0E
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 06:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9518A1C3BFC;
	Mon, 14 Apr 2025 06:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VNcoStDc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1671B0435;
	Mon, 14 Apr 2025 06:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744610489; cv=none; b=tc6XHN/8Y2lQmp75m2nLWT3KLCIV2Mw/Te94aBrg6YKtbgY0cQR9yFcDC4iJ76QZXSpJgIWA1Qg7pv9zMlvmlJ5Tx0+eDLZNxWiMP9koCW9wgs1vzxGimZ1MmUkNev3xgzHa5YxxeDBCRvXzZj0ALsRKG/97yGolpeyV4S1BhXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744610489; c=relaxed/simple;
	bh=HpxyqsdMGeeK9YhHPSA4BDxEq1DuqcU6xX/njThfNuA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cJ1II+DUqgHYqNEQ4tJelpHJYf+UqqmLk/ohvhhzEt+V2Yv7U37vlKQpVjHtvUhnAtPCkVk+dgKeBrUYpyw1hUirEvOhYJcpXqGVlfIVDHUW5h7KQAnIdIaKXDpIn2nHDNISxzSIejaTJMoc/69xZhLM6cCgvJbcrPtiKAos3Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VNcoStDc; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-476ac73c76fso40470441cf.0;
        Sun, 13 Apr 2025 23:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744610486; x=1745215286; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3mqBPYEpj3oDYcW+ecgfymE5jpTfEb8iQzjKpUR+M/M=;
        b=VNcoStDclQZuf2M11vA9a3gFCUslE8UE1N2vuih1nKbVIqpYE8Dlnvna5waqxB/3Cf
         7HTWUrCh09S84vMgHaJ3rUJUiz6VlnGTq+DLs2FvVKQAtAWVkVJg0hPjL5T5KR8YOIdO
         P2p6HYXEDT1DRNvE1mxbBjlFWWp2cl7TeuD4A0RsHBguzws3ECsrri2po3iZj2c9OAtO
         R8RIexw+XDAhldqBFLLFqfs7I2GtRjj5gOcRxzDa5llCAfE3oXhaMoKAZ0QVp06vDOSl
         G6UVT+4n56pxqzETD+OUSuSJQcivXYcN3iiq4cjgSoV6nTBvDpkvFbWq8V6trFL1pWFN
         hURA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744610486; x=1745215286;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3mqBPYEpj3oDYcW+ecgfymE5jpTfEb8iQzjKpUR+M/M=;
        b=bsdog8c2jkyaT8BZfi9U7DR8flUVX/j58Gx4iH2D/cqCrhknOTvcJuxn2QHDMGbzwz
         qYFR1YDvXqdptjRMV0X3mBn0WHqGOk/58OztP4lntBgJ+05gMgHvkI0opNIt2vyOqk17
         B2BNE1YMhTrhJ4j8DQsG7t9YQTDJgm+pEo61idgGLLMqzxTwZoDFwfn2YLdDqpXzh8fp
         E08slNIxdVcb35g+QZGWQvOtvDjtH87s5o2j3EsRC+75Nu55Mef4FVAlYVTwWDS0pTIc
         4ZkbwZ9D9frkrK4+Juh4ZHv7DVE/2QBKBvQDxekOd+jta7FWny9uv0eUGQwjYWvjezIU
         E1hQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlkDk24fY6O8ncHGAZml7GdbYC2MTPtU040tJ1iLXmup/oA2LaKAcnMTB35v41uH2ptrQO0RoB0lIyVHA=@vger.kernel.org, AJvYcCVOpPooVTy+9JjFVPIPLqZYUvHJv+v51swpGDCsDgMtYDsIZ/Sa2Uar9DBanbV3XS5L06Du@vger.kernel.org, AJvYcCWmVOjl66Ggrw5K7VZc1mQH64t8zmCcnc27BzDwjMMIfBq6DWxbFUANwEFh8wSp17rnmutiemi4@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4eOVEg8dgVrgGLtTD6/wfn4IqwBf8SaV5Ma/jtYHbnGKXj0vd
	rfi5LpW1vYkt+w/gispiWyeDwmW2pLC0lDiBUjZdWdsiKiLSw3zf
X-Gm-Gg: ASbGncvq7RpDdG7eBIVUBdYRcoZWtstfDBmzBg6NWe3INLp1uUjd0JIeJAvCCWkDZyD
	ahbAbwB20h1H8az83GWJ/cLfMIANi80RbmrlwyxvTlWMuJWzL2NvtyqE7Z4cmwnYqjIPhY0QnGT
	Y5c8Qa06B3gs2eHg/a2z54Vqxfo6h1/OkYJzUBp9fZNTOa/iDq4R0T1aX/+ids8TsdXA8sGuj09
	u7tXd169VkXHj6S1m/4l5ZMESWZ5rVKOBoFGJMMhuIPl017iQttxobpRy1tAVO79GpnOOIv4t1t
	+z1o1KaWgKylMec6qvqCgoQZInmFNN67r0RshwZzEO7lvqHLAU4OEv8NqoHYqGqxk2lMz8Zua5O
	NW8hvCeqS/6bb9uBTQJrJEaEGUAdvGZo=
X-Google-Smtp-Source: AGHT+IFgJw9RjZ7bPzTHoqthvvHfyn2CHESDBCpwdMKpPEwzMJFJSQWnogh732fCX+skQ5ehIli/Bw==
X-Received: by 2002:a05:622a:190b:b0:477:8a01:afc7 with SMTP id d75a77b69052e-479773fa138mr136252621cf.0.1744610486486;
        Sun, 13 Apr 2025 23:01:26 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4796edc20aesm69144241cf.78.2025.04.13.23.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Apr 2025 23:01:26 -0700 (PDT)
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 6A59C1200043;
	Mon, 14 Apr 2025 02:01:25 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 14 Apr 2025 02:01:25 -0400
X-ME-Sender: <xms:taT8Z632A_wSlfPFrtFzHympXGhrom7ElJbt3DO-AUpi5ujksOHkVA>
    <xme:taT8Z9GRwZIRrrEszaWkS0FOLgbTDOZFP-vmJy8D3ijG60mshXydAxn9IvkkgCm1z
    zw-jQN1rLYOv9Pw0w>
X-ME-Received: <xmr:taT8Zy40eQe4HKQ-Q2bpiLNqFgdHlqA-RYGla0mzvUw43_tqLcmb41hvvL8ouw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvudeljeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredt
    tdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpeegleejiedthedvheeggfejveefjeejkefg
    veffieeujefhueeigfegueehgeeggfenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgr
    lhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppe
    hgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepudelpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehlvghithgrohesuggvsghirghnrdhorh
    hgpdhrtghpthhtohepphgvthgvrhiisehinhhfrhgruggvrggurdhorhhgpdhrtghpthht
    ohepmhhinhhgohesrhgvughhrghtrdgtohhmpdhrtghpthhtohepfihilhhlsehkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehlohhnghhmrghnsehrvgguhhgrthdrtghomhdprhgt
    phhtthhopegrvghhsehmvghtrgdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnh
    gvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvghtuggvvhesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegvughumhgriigvthesghhoohhglh
    gvrdgtohhm
X-ME-Proxy: <xmx:taT8Z733x1ZAriJQvRQ2UvQZADUBj2d3i_5g4AhvO2RwjmXeOtrOqA>
    <xmx:taT8Z9ENOCDdymrT-ACBjIecTiAjptrY7-fI7BWWjGrLkFUGI5E3mw>
    <xmx:taT8Z09E2o_2DGLFdcaCbIrKlrosX7gnsTdcu9aZdxuncUtbA6uULQ>
    <xmx:taT8Zymhv0b48by0Wx8_pTfmZQAF_XMgk41Is9FJ3lBY0RXKrh_s-g>
    <xmx:taT8Z1FB33KosmqtYIwuCdt5J8_E6i-trZeO98DzaXAF27jVRA5IBJUg>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Apr 2025 02:01:24 -0400 (EDT)
From: Boqun Feng <boqun.feng@gmail.com>
To: Breno Leitao <leitao@debian.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>
Cc: aeh@meta.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	edumazet@google.com,
	jhs@mojatatu.com,
	kernel-team@meta.com,
	Erik Lundgren <elundgren@meta.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	rcu@vger.kernel.org,
	Boqun Feng <boqun.feng@gmail.com>
Subject: [RFC PATCH 5/8] shazptr: Allow skip self scan in synchronize_shaptr()
Date: Sun, 13 Apr 2025 23:00:52 -0700
Message-ID: <20250414060055.341516-6-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250414060055.341516-1-boqun.feng@gmail.com>
References: <20250414060055.341516-1-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a module parameter for shazptr to allow skip the self scan in
synchronize_shaptr(). This can force every synchronize_shaptr() to use
shazptr scan kthread, and help testing the shazptr scan kthread.

Another reason users may want to set this paramter is to reduce the self
scan CPU cost in synchronize_shaptr().

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 kernel/locking/shazptr.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/kernel/locking/shazptr.c b/kernel/locking/shazptr.c
index a8559cb559f8..b3f7e8390eb2 100644
--- a/kernel/locking/shazptr.c
+++ b/kernel/locking/shazptr.c
@@ -14,11 +14,17 @@
 #include <linux/completion.h>
 #include <linux/kthread.h>
 #include <linux/list.h>
+#include <linux/moduleparam.h>
 #include <linux/mutex.h>
 #include <linux/shazptr.h>
 #include <linux/slab.h>
 #include <linux/sort.h>
 
+#ifdef MODULE_PARAM_PREFIX
+#undef MODULE_PARAM_PREFIX
+#endif
+#define MODULE_PARAM_PREFIX "shazptr."
+
 DEFINE_PER_CPU_SHARED_ALIGNED(void *, shazptr_slots);
 EXPORT_PER_CPU_SYMBOL_GPL(shazptr_slots);
 
@@ -252,6 +258,10 @@ static void synchronize_shazptr_busywait(void *ptr)
 	}
 }
 
+/* Disabled by default. */
+static int skip_synchronize_self_scan;
+module_param(skip_synchronize_self_scan, int, 0644);
+
 static void synchronize_shazptr_normal(void *ptr)
 {
 	int cpu;
@@ -259,15 +269,19 @@ static void synchronize_shazptr_normal(void *ptr)
 
 	smp_mb(); /* Synchronize with the smp_mb() in shazptr_acquire(). */
 
-	for_each_possible_cpu(cpu) {
-		void **slot = per_cpu_ptr(&shazptr_slots, cpu);
-		void *val;
+	if (unlikely(skip_synchronize_self_scan)) {
+		blocking_grp_mask = ~0UL;
+	} else {
+		for_each_possible_cpu(cpu) {
+			void **slot = per_cpu_ptr(&shazptr_slots, cpu);
+			void *val;
 
-		/* Pair with smp_store_release() in shazptr_clear(). */
-		val = smp_load_acquire(slot);
+			/* Pair with smp_store_release() in shazptr_clear(). */
+			val = smp_load_acquire(slot);
 
-		if (val == ptr || val == SHAZPTR_WILDCARD)
-			blocking_grp_mask |= 1UL << (cpu / shazptr_scan.cpu_grp_size);
+			if (val == ptr || val == SHAZPTR_WILDCARD)
+				blocking_grp_mask |= 1UL << (cpu / shazptr_scan.cpu_grp_size);
+		}
 	}
 
 	/* Found blocking slots, prepare to wait. */
-- 
2.47.1


