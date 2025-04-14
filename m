Return-Path: <netdev+bounces-182039-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E6DDA877A9
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 08:02:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 657A87A74D6
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 06:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ACD41AD41F;
	Mon, 14 Apr 2025 06:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nmp04mx0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1D91A2564;
	Mon, 14 Apr 2025 06:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744610487; cv=none; b=XIcI+ORQb18KYy5k9ACM3tje/5a8y1bm44HqQxrUyIe6y15b5alNrod6xH9mq8yk3Igl3KtmnUx1f4/1GvLHdpXOQAHgBKW8fKgZw18B7zf9nFL9LjtlbQEsewn5bATRLfoIcq7DMCg9fwb/30DgC4zLV7M4X4HfJ5V9vkNvods=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744610487; c=relaxed/simple;
	bh=0a0sKTLnZCu8ERlafxFR8eDC2liFbwaV8kBs40QJ5AE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uspe4jhIueAtxjiFvEWbnqcx9D0e/91E17qF+nG3ENm0AjzzdARzYVLODHZDg+JUqcZN76ItoUunBxkapS8KM+JcRAHFM5bhC/89XCKEVW4t6klW5CioEYj2THWEXZGdWfsVa0MSQvN2HssbVOF/VRgyzWpOqm2lCCo7hxPtFQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nmp04mx0; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6e904f53151so35091236d6.3;
        Sun, 13 Apr 2025 23:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744610484; x=1745215284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=crSoWmS+wlxuDSJzcFBATB5TfRUeFAx3Edno5+zB6/o=;
        b=nmp04mx06rTQiN+A7tKaCjhvmrSokinyu3LHHlvmc7529SNIMw+HSTISh/Pt8D2htI
         Pd/DGiM7r8Cu6GZwSmKCe1rCDVr9ZWytGG3r30Yo79rE4rRcqFYdrABBLQsgs6c5hmw+
         Up09p1GpYbptUnGdSE7sMcuNXhRBBF0TVAhwOH/h2dYWATXTubRGvcHlt6enmCOjCBEO
         SnBuCwHD02aDOIFVj7DJvLFrhjKQk2oYap62rEtHgJQeK+em8SdqHR5y0iMPeqvkZCe8
         YIUTWVhsdUk4CabGHjGOHqN6drx1SZPsZXh7QhNYUMDKOXuYqkxcnPF4gv6gWajkH2Q3
         WEpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744610484; x=1745215284;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=crSoWmS+wlxuDSJzcFBATB5TfRUeFAx3Edno5+zB6/o=;
        b=HnczNQaP8YCIOAbhhoeB72YvrCXmvjj9PDRtI/Ag7eWmDYZvBE8YGTkMGk98H6rJzV
         7fY954NimpIblCmL4cg/G4btKFonf9ruhbDDafc7u+bqVxZGX365zp8g7dsk8dnjD++n
         qbOTrHEWUMV7wjG40eOwlDne1IAyR133JY0YVlxx6QlfHKu3qT8QiamjRjkT2T75x9cn
         4i8PWk2TMnKkqFHttLYRWTTmW5x20R06gEdOlNsfJZoJBZplRyitjCjjl/PYunR0DdfA
         ZiTIk3mEh7HfW5hxX35iQ4eXqsLe4D42PaAgZ4JMzoVcHRAcxGWkK8Egp23EQE54FpMu
         HFZw==
X-Forwarded-Encrypted: i=1; AJvYcCUHJafggFpaEU2CfStkxVO1hOj7ErcE1amZ+jSG0xCOoiZ97J9N+IrtRBH/uKhzBCcdHVXCLWgZ8HFCZFY=@vger.kernel.org, AJvYcCWnXBGzej159CUMBpvjZOjwst/Ehh+xv5MwiS/d1TzGQfFDnKTqIyb5lhij7yth/geuB97Qagdz@vger.kernel.org, AJvYcCXmTc7Z0qBrP6gHKp42e8PBFfXnGJTv4aUjDGAH8eMbRltth7mHwRYLI+7qwRx9HbcOolnH@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9oPbEGZ8Q8QT3FvzxV2/LCnB+4WdaJOcExTf1ywszMNgiI0hK
	fEDggQMZGVbJPaYV2cMjQryf+RE9TpeWXeqZUsa6eE1b0I//1EXUMyEFLg==
X-Gm-Gg: ASbGnctIPRSteLY16pJmd08h2FZCWKlMvlcv3jMHgMadwFT9sMwPcapwp9BR76BhQ5k
	4ikvyCA37r8dT4CE5U+kzEIqrEYIlPDAAxKR7J086UiXv2L0/X89ZPPserLtsGMsfyj7x6WFujJ
	7azTddogBDqhYjwbQG/t/p9h/pnCOxVtHbrpTRwvs9NiYP7nq/GLY3Vu2a9yQb0127zrGeXC5Iq
	A64rd4Zs/a2PtqeGvibRDfEj/3nYVV5E9aiqaskGpJSe/cttrNIfJVAkvxCXJR8qJ9JEeIGSyyD
	LgjNTVApSjVNsC1it4z194F31HFajGZUridcRqFQxgw5cWifJz/yz9cvEBhsDBK9hPdmy4cnFn8
	GlaeyBqsUp5K6w696oxNWscYJ9vptFDo=
X-Google-Smtp-Source: AGHT+IGUm83pSj0m13ld8odbNA7X/XFuelxmJULW6GNlofNBV4oRp5k19QpyqoObZltGPO3/o2xurA==
X-Received: by 2002:a05:6214:5089:b0:6e8:86d3:be78 with SMTP id 6a1803df08f44-6f23f14665dmr155990676d6.37.1744610484032;
        Sun, 13 Apr 2025 23:01:24 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c7a896b01fsm684471485a.65.2025.04.13.23.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Apr 2025 23:01:23 -0700 (PDT)
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id 046FB1200043;
	Mon, 14 Apr 2025 02:01:21 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 14 Apr 2025 02:01:21 -0400
X-ME-Sender: <xms:sKT8Z3LDG-V5pgBpp_hsSnR1QGv7H0ghkpeoumbrx4RfZuoRKCok8w>
    <xme:sKT8Z7K_eM9iVru8ON8mxKkMhPdv5BUQXiFp1H67jnWVgFRhH1ZPmrgMpt452EAvi
    XPmax52gORb7T84Jg>
X-ME-Received: <xmr:sKT8Z_viG96-padrAA5dQtUhsiweo2XA4m6Bn4NjulEI_Hkn3NgxqFEB5MFDdg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvudeljeejucetufdoteggodetrf
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
X-ME-Proxy: <xmx:sKT8ZwaTFM5qlJUFs7ayw_CML6aVpx-s9NAtlk5rjRPZGNDYnDfwxA>
    <xmx:sKT8Z-bBpTSqR8rXMkSlX3D_7vo1-mUzt_pZQmjS5x6mOf6GFjAKSw>
    <xmx:sKT8Z0DPtgs0RXekk6ZYkHUmP8xUTVkuWLE6ZRT-lLTsgc2c4j5Neg>
    <xmx:sKT8Z8ZPpzySOFYjFUZy2KchFY0Fv4umag2Iwa5SuQs6wcgABwt5pQ>
    <xmx:sKT8ZyqoIWyuk3coXidMDHKlHA-kztWIRZ8qhDSS7AFkpYx11K38dXEh>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Apr 2025 02:01:20 -0400 (EDT)
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
Subject: [RFC PATCH 2/8] shazptr: Add refscale test
Date: Sun, 13 Apr 2025 23:00:49 -0700
Message-ID: <20250414060055.341516-3-boqun.feng@gmail.com>
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

Add the refscale test for shazptr to measure the reader side
performance.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 kernel/rcu/refscale.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/kernel/rcu/refscale.c b/kernel/rcu/refscale.c
index f11a7c2af778..154520e4ee4c 100644
--- a/kernel/rcu/refscale.c
+++ b/kernel/rcu/refscale.c
@@ -29,6 +29,7 @@
 #include <linux/reboot.h>
 #include <linux/sched.h>
 #include <linux/seq_buf.h>
+#include <linux/shazptr.h>
 #include <linux/spinlock.h>
 #include <linux/smp.h>
 #include <linux/stat.h>
@@ -890,6 +891,43 @@ static const struct ref_scale_ops typesafe_seqlock_ops = {
 	.name		= "typesafe_seqlock"
 };
 
+static void ref_shazptr_read_section(const int nloops)
+{
+	int i;
+
+	for (i = nloops; i >= 0; i--) {
+		preempt_disable();
+		{ guard(shazptr)(ref_shazptr_read_section); }
+		preempt_enable();
+	}
+}
+
+static void ref_shazptr_delay_section(const int nloops, const int udl, const int ndl)
+{
+	int i;
+
+	for (i = nloops; i >= 0; i--) {
+		preempt_disable();
+		{
+			guard(shazptr)(ref_shazptr_delay_section);
+			un_delay(udl, ndl);
+		}
+		preempt_enable();
+	}
+}
+
+static bool ref_shazptr_init(void)
+{
+	return true;
+}
+
+static const struct ref_scale_ops shazptr_ops = {
+	.init		= ref_shazptr_init,
+	.readsection	= ref_shazptr_read_section,
+	.delaysection	= ref_shazptr_delay_section,
+	.name		= "shazptr"
+};
+
 static void rcu_scale_one_reader(void)
 {
 	if (readdelay <= 0)
@@ -1197,6 +1235,7 @@ ref_scale_init(void)
 		&refcnt_ops, &rwlock_ops, &rwsem_ops, &lock_ops, &lock_irq_ops,
 		&acqrel_ops, &sched_clock_ops, &clock_ops, &jiffies_ops,
 		&typesafe_ref_ops, &typesafe_lock_ops, &typesafe_seqlock_ops,
+		&shazptr_ops,
 	};
 
 	if (!torture_init_begin(scale_type, verbose))
-- 
2.47.1


