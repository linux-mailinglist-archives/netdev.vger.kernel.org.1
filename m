Return-Path: <netdev+bounces-200911-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B127DAE7523
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 05:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16B13176E97
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 03:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20EBF1E1E12;
	Wed, 25 Jun 2025 03:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QIJS0OfZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65351DE4DC;
	Wed, 25 Jun 2025 03:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750821093; cv=none; b=IUWGbLh2DqUxDyNMusExQ75SYfp0zwj1C+fnWyeZLZ2HhklNmMvCE5oy8rnCmCOJeyRVeJ2Khfyd8Y95bQghmTHjSsTliu78Uh4EqqYfaVUoF386BjZwd/7g69IhOau12lPo7DESwKANrf/jYAYa8pIURCC9RIlUTowwHcO2tLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750821093; c=relaxed/simple;
	bh=TZOtCUxplLpVZwlulyF2AdR7IutlsKFrx5aA44BpK6Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NnnO8k0gxFQk+WdqHiCzjTvnrdUjzL/p434y5R856PBLYwsC6g7jq5HqbiqSUjXJqT6iUamwdleI7ouWtTszbD/wD+Le3JDgYHrJYCHBxQDzPlcocGgD5NSdjuPWXzV3BKVQzQ39kPNkj+ipve5oEvwBL9VJadz/BHXuRe3a5RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QIJS0OfZ; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7d3e5df4785so408181685a.0;
        Tue, 24 Jun 2025 20:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750821090; x=1751425890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qhQXR4q/1FKoBNWknRJmtYgN/63wc+pb7z14qfrzMOI=;
        b=QIJS0OfZeKYhj3IlYZFBGiCOB4LBouPxvd102+FS1UqnVFuWop6xkvtBRECGtR+FNz
         E02GrMKJeFyclFseoZSwoyPbSjcFIx+SUciunYBwdeInLuJsFcaNGMOuGoxQ6VGknS5E
         f31l8RTkpNKr7uwTBw66nNma6oJzb5rzTfLf/B9uTZsf7w6XkE6wfhqV+lJu/QF/ilXp
         qhmIggKdCJmHG3T2UqwCC7JjPupu+9uh/iuJcm/YUPAUTAah4IqcWkUTR+e6IT61pbMm
         jUbK2qpU9+imo6EUHYNKUZY02gsp+w+wP5rMyxnG8FTu6h0fBlfdmO1YIlywWTZCIUo8
         aXzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750821090; x=1751425890;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qhQXR4q/1FKoBNWknRJmtYgN/63wc+pb7z14qfrzMOI=;
        b=lgK5mKe5AvjuxSHoz8v4U718/6OjouaYTpMSrBHeXFOUJB4ogA1x5V0cxeb/r8edbR
         yvr/JraBWWb0waUjHIAAZxBieK7nS/+KnV8aEb94wqFLO5Ik7HdlMd1GpTisJ5nkSJVN
         CLzDvZQNdG4N7QvbPfS2K69OuT7gv7KKil4rT50GvJeGfGLL4suLtOE/CPyq0gObFYdI
         iT+JZ8KbUVRsC/QSu0UC57LZf65FBbRAVL1ZgTo9usxWwtOYEaQEj0bhUSEwJ9VGFu1B
         7M9xjHRWkyTuU9z0Cahp+mV0acLmlfV/Vk6i+6Fc516k4qIYP/IqmxDJO5aTdeppPgwG
         kS5A==
X-Forwarded-Encrypted: i=1; AJvYcCUQIxhpUTp0EdkFnMSGEHucxRoBfrTugh9IJu1G4RVpGZbAqgpWmRCgX6zs05VuHSK6JH10GOM=@vger.kernel.org, AJvYcCWX7JUfd01GENW12pROpfpxLWcFi0PnBDNvJFh6Km3gZ0OqgJ9EDbx4T2m2c1Ms5kmDrjQf@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl3X9pZd8pYtPMQg29nwELI/5wyqrinZkvv2CsKzb/btl4Ghog
	Z0g6+obYO63ICAvC3CTlwr4fXIevyUHHgFQTR11VlMXQA6UAvLAQOix7
X-Gm-Gg: ASbGnctNyF80pokmm3vGO4Agr/vJ1IclFZtsH2qx5GGmts9N3W3aXVcEsXnuzEju00x
	P5BMsxGCmwyO43gX3phD1RNez8FhyWVbvP4O7TTr9hEU7/zWWSfKJHue24yUQUJITZS8nwe7qwS
	hpNZ8O3/fTHg6LdzmPl9zOXi7peYaRbfrnN7cWah01ViAZYr44Qs7Sg5w6aaDoO+rElJ/HfrO/k
	zvnYtHs7tY9uRKkXSFqAwcs+DzUEfw0N6le5pGfFeJUblvxO+odBLUFOetd4FhHEpeDVjuenC90
	7mAuyd/8k5Rfc0KhnaG+++VQ+0oOwAnA7k50nrJNLcyMz8IWcWmDwvmFDrwUj4cjAmTAxaScopQ
	xSdg4JC7x8pb8Kgh6ZVcO0iYL6wGiO520xjdM8trVKpeTdi6rXyRd
X-Google-Smtp-Source: AGHT+IEcTWAIOOFSCQca6pLktm0oe2Iu3mQqxK8tubUlzRS0uHFLS6o5cXHt4DbBg4x47R2Z4s8MFw==
X-Received: by 2002:a05:620a:6a14:b0:7d4:29ea:a9a7 with SMTP id af79cd13be357-7d429eaaaf9mr113733385a.49.1750821089756;
        Tue, 24 Jun 2025 20:11:29 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d3f999a5a8sm566908585a.18.2025.06.24.20.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 20:11:29 -0700 (PDT)
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id C0A4CF40066;
	Tue, 24 Jun 2025 23:11:28 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 24 Jun 2025 23:11:28 -0400
X-ME-Sender: <xms:4GhbaAshV837yyRgI5hdabuiYaKWvA_nvNFJmqlobWwl9tCokX65oQ>
    <xme:4GhbaNcP4_0MOtrRqIOpydv_z6G1DehWZSwA_E7IyC_VU1rMh5P7fISi6SulWE1gL
    C7oHH4DuKDtq8Ff1w>
X-ME-Received: <xmr:4GhbaLxAfR0ZZalGGBpcGRV4qqXUHimwSKdWEhMQm3JywMO3OufFpHlLaw>
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
X-ME-Proxy: <xmx:4GhbaDPksBCZcfdzklDTbpZCJJfDMAodPdwNrA9nvfTPNMrgytKeAA>
    <xmx:4GhbaA_Ant31p09B8hgfPf0aE9RYp-hJtzjb3JXqA1QcSfQkrCNuRw>
    <xmx:4GhbaLXc341HcEi4epQd4K-xNuxskJhw1xwNpW_hlXmW-SzKcGhj1A>
    <xmx:4GhbaJcoFWjVIYzOt-i0ZLYUK2hz0XxL6EEBVKPrSY1_wUXMhbkZ2g>
    <xmx:4GhbaCe_XrlQZGP6mDaJ2vhS0NlJc_kteqtLcHRvcqiw4W34gkl9CZN1>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Jun 2025 23:11:28 -0400 (EDT)
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
Subject: [PATCH 3/8] shazptr: Add refscale test for wildcard
Date: Tue, 24 Jun 2025 20:10:56 -0700
Message-Id: <20250625031101.12555-4-boqun.feng@gmail.com>
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

Add the refscale test for shazptr, which starts another shazptr critical
section inside an existing one to measure the reader side performance
when wildcard logic is triggered.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 kernel/rcu/refscale.c | 40 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/refscale.c b/kernel/rcu/refscale.c
index 154520e4ee4c..fdbb4a2c91fe 100644
--- a/kernel/rcu/refscale.c
+++ b/kernel/rcu/refscale.c
@@ -928,6 +928,44 @@ static const struct ref_scale_ops shazptr_ops = {
 	.name		= "shazptr"
 };
 
+static void ref_shazptr_wc_read_section(const int nloops)
+{
+	int i;
+
+	for (i = nloops; i >= 0; i--) {
+		preempt_disable();
+		{
+			guard(shazptr)(ref_shazptr_read_section);
+			/* Trigger wildcard logic */
+			guard(shazptr)(ref_shazptr_wc_read_section);
+		}
+		preempt_enable();
+	}
+}
+
+static void ref_shazptr_wc_delay_section(const int nloops, const int udl, const int ndl)
+{
+	int i;
+
+	for (i = nloops; i >= 0; i--) {
+		preempt_disable();
+		{
+			guard(shazptr)(ref_shazptr_delay_section);
+			/* Trigger wildcard logic */
+			guard(shazptr)(ref_shazptr_wc_delay_section);
+			un_delay(udl, ndl);
+		}
+		preempt_enable();
+	}
+}
+
+static const struct ref_scale_ops shazptr_wildcard_ops = {
+	.init		= ref_shazptr_init,
+	.readsection	= ref_shazptr_wc_read_section,
+	.delaysection	= ref_shazptr_wc_delay_section,
+	.name		= "shazptr_wildcard"
+};
+
 static void rcu_scale_one_reader(void)
 {
 	if (readdelay <= 0)
@@ -1235,7 +1273,7 @@ ref_scale_init(void)
 		&refcnt_ops, &rwlock_ops, &rwsem_ops, &lock_ops, &lock_irq_ops,
 		&acqrel_ops, &sched_clock_ops, &clock_ops, &jiffies_ops,
 		&typesafe_ref_ops, &typesafe_lock_ops, &typesafe_seqlock_ops,
-		&shazptr_ops,
+		&shazptr_ops, &shazptr_wildcard_ops,
 	};
 
 	if (!torture_init_begin(scale_type, verbose))
-- 
2.39.5 (Apple Git-154)


