Return-Path: <netdev+bounces-200913-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD2CAE7526
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 05:12:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B4DD1922507
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 03:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6130C1EB5DA;
	Wed, 25 Jun 2025 03:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HpSRA0v1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70BE71E32BE;
	Wed, 25 Jun 2025 03:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750821095; cv=none; b=KvXPxAs7Sj1bjkBBpMhGL4XrShTRKohxa/Vn6Mr+bl6FHbznhNMzjEws7OxR5KuS1K8LBuM1TFDO+S2VdAuuWlkMax+RgGmZG4aiT1UPUfkCOBFhcXXR2INhf4MHiJVoJlFjd4SI6JJGyT69CE1JUPNBcNSdlFmRvrQuChBqo+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750821095; c=relaxed/simple;
	bh=JPcvKh/jQAHEETOG+k6olIvrMgI+nTXU1PIG0qFgfik=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VCo5wcqXFiK5uyuVhrajnabFUq/ApHSZ4i6r+Tc2KpVOdHgsF7bx3medRV0JV3gOqRygY3F4rAbrILDas/urf067Xh8a2KnF2VEEmt2JCAa1M7qIlXnnvD78RVboB2cA5whdn+lt5NhDpwjtbCKx50kDEtbdT1HvR7VhA32TPeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HpSRA0v1; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4a58d95ea53so5962521cf.0;
        Tue, 24 Jun 2025 20:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750821092; x=1751425892; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CPJydrkhnERanEDJeh8iKFAtkTK1x51r4pmOIL1PfXo=;
        b=HpSRA0v19F9mUJnOXdepSt3nr9KiSJPHqh+KMuMeiu6vyC/ou3HAjGW6ag6nw+d8VB
         BwgtjTwyibi9Dxe4ircFPB3Xdt+GjmAmYHAJeV18DESVSeCJc9orxxpWMbtHOAmrPiHV
         4EPFvVtETjDdMiW/xsxMO6UqTxY9E3bqeL484w3QN5IEXG3wG3QirWuwiwN7LehRsl3i
         l4utsRcduPSQT7mCuqE3cX89hS0DnvHTl5xb9qVF/HmpJeBdr1KHbhwQhIN5UHP7TL+3
         O3R3kbrIbL4DS5HbQEwNdxa2hi8TTUKdbW3e0ctAsRatbeReNqRKrPycwJwfXx4F3xS8
         WNVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750821092; x=1751425892;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CPJydrkhnERanEDJeh8iKFAtkTK1x51r4pmOIL1PfXo=;
        b=u2PZzqla7FtZ8DbKju3KikB7YK0jc0pPLix+lXsARS+QmNvglEP1lf1lbHkU84Jxwu
         lJDUAIpzPumUmDEidGlaEdGyDn13D69OqlF4pm1AvOyz5V+hs4Ji6+tMSuhBVo0UApRW
         UCj9oYeVL2TkDmONwrLuk3R5MKouiclFJROPy8EGoSUmPr2gdQznc5DnTGgKW5FCXiAz
         oyrCRQ9BfUQYMJZBHimty19krJqjKkz0JmAMCqtNRqNFNRzkWhQXOdIkIAgEFe4/97ZD
         T2FTLUXrFhoHmxm1lCIolXkmqRpFKI1mo9NSPD80cjBGE24lUsCME7xX66BQ89vH7Pen
         XfMw==
X-Forwarded-Encrypted: i=1; AJvYcCUsDCa0Dp5d1zHItyVOW6duPOYB3NGoofukZTPPJBS5ZPkHLkxaXGJYCaS/kaWf4NazjI3E@vger.kernel.org, AJvYcCXU6BKp9DiKvmmmMQ5/ZBpn0WALTSSjxhVVGdojd/D0ZkNBxGP6sUZm8zMe5NxcijsKNuG4ZpI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQCFmmiNk62cozgS6xd/SxO5GXhmlvfCEUt4wTE2roq3Jf8Nxo
	EmEDZmjfxckpEKt5ky+8ae33c7Fm7x0Bfc6Vzl0wswSdJykGmMjQUzC6
X-Gm-Gg: ASbGncuOOhC1xuzcENGnQl+30ehszkZ3bJzy8CmGG+J2TC19IiGK0ogm9f/FmRPR/KZ
	P7RUmL59gq5OGJ4PYtPn3L24kyMwsVl1ca+PdhbsL3HS7xNU1KCYO/yh68f08xkxKL53fV/fpbe
	grCm/oDOzgRKIpoFKDYpfaHKb3CuX6DCK+3XKrcdG6eqLoRKKgFIq8uTT8aeNppkOuSEYw5ZCAl
	VxtNaOv74EblBADdR/uf1Ck4iJTg14HwrK1jlwWmfQLCyp59taYPEabh7Kl+8O4vCnfjZ27G4tp
	UD20nQE4rDkRIFvGDAaNZp/ic71xF1Uz4dhk3y8wbe5lSYOG9yVaB0NaGJd0NvIRFbLGQmJxcfG
	3jRG0vAons0y+yjILHYJozZix9OMVutOm1gtk9wISmDls/MDzDPh0
X-Google-Smtp-Source: AGHT+IGW0TiZzG9hPxpBHcORi1BL38UTs0PtOJHlHm1exg6B9dlOGYVh+aZvZ1C6ZdIypaz5HFXCZA==
X-Received: by 2002:a05:622a:198c:b0:4a7:896:f2d3 with SMTP id d75a77b69052e-4a7c112d0a4mr23737041cf.0.1750821092305;
        Tue, 24 Jun 2025 20:11:32 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a79de8d57bsm30445411cf.72.2025.06.24.20.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 20:11:31 -0700 (PDT)
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id 480CEF40066;
	Tue, 24 Jun 2025 23:11:31 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 24 Jun 2025 23:11:31 -0400
X-ME-Sender: <xms:42hbaBhMrsLSSrKXGy2cqVaOA-TomG5qY0N0LZ0GBN6NpyAqq-b3rQ>
    <xme:42hbaGASqrquj2Ce9HBs6_butqyLZ1VZpL6l2gTa8N1pxNlhwwCAZT-uKfS89fT9-
    dZ1SfnO8xdGsddJ5A>
X-ME-Received: <xmr:42hbaBFrzG7lqP739Fku6viILzTb57216pLJWTRl-WMthRz2gmchEMuYyQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddvudeiiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhepgeeljeeitdehvdehgefgjeevfeejjeekgfevffeiueejhfeuiefggeeuheeggefg
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqh
    hunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddu
    jeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvg
    drnhgrmhgvpdhnsggprhgtphhtthhopedviedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheprhgtuhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlkhhm
    mheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehpvghtvghriiesihhnfh
    hrrgguvggrugdrohhrghdprhgtphhtthhopehmihhnghhosehkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopeifihhllheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghoqhhunh
    drfhgvnhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhonhhgmhgrnhesrhgvughh
    rghtrdgtohhmpdhrtghpthhtohepuggrvhgvsehsthhgohhlrggsshdrnhgvth
X-ME-Proxy: <xmx:42hbaGRIyovSvjttgDxdfbsUKtTsdSLsy2bkpzFIgElwzm-YdmTf2Q>
    <xmx:42hbaOxunvJBdATlcKJlKuc7Cs-2dGdO0ySX04nFqpNKg9SB8g6JRA>
    <xmx:42hbaM7ekw8IxW8uGG9nieV4yJp4DSpEzwvqwb6jVoELd3nwBgXhUA>
    <xmx:42hbaDyDqPhj36L404m3T_XYwrRPJ8gnpMJW7diV-MLKkmFr61rEmw>
    <xmx:42hbaGiVqFHEUDsyecN6wRFPlcmFfdb_aGFnpSGK2A_7X7Ph3hqsdLWK>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Jun 2025 23:11:30 -0400 (EDT)
From: Boqun Feng <boqun.feng@gmail.com>
To: linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org,
	lkmm@lists.linux.dev
Cc: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Will Deacon <will@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Waiman Long <longman@redhat.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Breno Leitao <leitao@debian.org>,
	aeh@meta.com,
	netdev@vger.kernel.org,
	edumazet@google.com,
	jhs@mojatatu.com,
	kernel-team@meta.com,
	Erik Lundgren <elundgren@meta.com>
Subject: [PATCH 5/8] shazptr: Allow skip self scan in synchronize_shaptr()
Date: Tue, 24 Jun 2025 20:10:58 -0700
Message-Id: <20250625031101.12555-6-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250625031101.12555-1-boqun.feng@gmail.com>
References: <20250625031101.12555-1-boqun.feng@gmail.com>
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
2.39.5 (Apple Git-154)


