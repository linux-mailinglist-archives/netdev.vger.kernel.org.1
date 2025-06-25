Return-Path: <netdev+bounces-200915-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3627AE7529
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 05:13:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65ADC17AA8D
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 03:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043821F4C83;
	Wed, 25 Jun 2025 03:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h7tyJscd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0FF1EF39E;
	Wed, 25 Jun 2025 03:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750821097; cv=none; b=ef6EutfwFy3Oo7MOcyXuAx2BfMGg9BhyjWBm1bufrtr/gdki6i+OcryST0Mh2PllDfEHy4fYd77ki+EBSDc02KdeDF1qc/7aXxH8OaAT+9fhxR1N7a9NJWyW0q85LfwgHivTujEtW4lYudmuqgw12DvcmbMj5VTjIs4cXYtEadw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750821097; c=relaxed/simple;
	bh=2Zl3n64ENVCvkp3q5SHTf+XFtSOXGOOsCzI/DQkaM/Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MP4oPwlsza8iF9u07EofbHbXP5Kri59NxTFcxYSFCTwCvHVi+erxHwl7Wn3KEHjQ03y76/tv1K3APd9NfMigHXfDObDjxmEqvIF4qpTwZdWCdktwDIFoM6kTUttLHnAUjbTG89qrTJ6Aw7nbk2TXQpgeF7ld4FcC80xArivnqk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h7tyJscd; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7d098f7bd77so57718985a.0;
        Tue, 24 Jun 2025 20:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750821095; x=1751425895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/1uL4SnLWRugsWnQE9sdQcVDzQKPklHv+4Xueonr/8Q=;
        b=h7tyJscd3NJKMhZAy75lakEvZZY78q/8021OvjMvoufBv4W44TrPrNDSNCnkYFJyv5
         DQ/G4KJBxXPIJyUqRQqvpqRzyAE1G7V7iukGj2cZZODGBW2y4JpRyT+2KI0CNsKPnJVn
         krfaoBWdbOszlVpFTIBirC2Rg1/8QfZexruWhyXs/cGwDqWDx/fvTcHAPiviYL4F5XS/
         uwE2ZAYvyaGUkWYjuyl3RKz3R4Vlsix47TTUsEgiXFsqdoCNapy80b0GwglXbFO75Ngd
         nolWmQwLcNaj+ArwwLKHucluo+VJAoD1o/m770rMZX3w8+V0xeSoeC2aGiutyPQQ4n6H
         TMJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750821095; x=1751425895;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/1uL4SnLWRugsWnQE9sdQcVDzQKPklHv+4Xueonr/8Q=;
        b=wRmz425VP87x8njxmUq7XTdPH5UyEQQ+a8+D8pa11qtorgYLooUGQ7fJRhHugi/ra2
         M3qjpp1yrMRFE5rHAhwEPu0fQ/T5Y19w2eBJn/11NwNjvO152sg4HYkefyvc+izeDxim
         mJGZGt9U87ikfrV9uB0zKJ/B1rCygQjglhwaa5qFlGRHJnvUyi2VZfa7ucQp0oV4dj+S
         jzWQ+5WyWt45thQwFVR2ejRQNhnW/vrUPvzd57ewgO23HpDUuuEuQm5mJTdnX9OHdoWq
         o9XxGWqWruQyauELIwXxv37nWdCJFsSOeiWj++kQvKcXMQEXQxm32fng+krTb7bXN9qG
         ly5w==
X-Forwarded-Encrypted: i=1; AJvYcCXUzO6BLHtc7o2eXyKxsjZy5NmlnYv6FERxsef6KgfsRMkuTZOuUjGU5LT5AW53NUgtWY3h@vger.kernel.org, AJvYcCXnlYe2kVj0US+UfcV4qmIKx0aYJ8LeBBa4AjHVPnGX72d0ObTIAHHagCiobml+EmcOZw4Q5hQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4w0AwspkhWdQR8arV+rJN+TRj5MZOCc0XpQw4pa7Ekh+8/aNT
	sj7VD3LYMsEKd6z26o+Y08QomlqJRYuLwU2T0WFRaqn+uL3egAXKqaB+
X-Gm-Gg: ASbGncvtjTg0q8ef3CSAwuJAB+RNW+WHTUpMEIHBVATT2jNflBIWWYLwmWny7NNeNKY
	jn3/NE/WlZb6k5tGRg+liPHogqfs14jzNxIuimgmZz1IrxleX089eQeWSFxkXU5FDt1X40Ppjrz
	7aOhnC2Qra+SED2YQk83DeoVbtcz3DNr9C4NLopzgKik4WztgXvmmuWB9V2MqtIiCT9Iq0KOptf
	/FvLACLI2fU+qNmx7aMXInraHL2UZZwkPS9TSWa29RFtp+65VoHHgMGYUZB0G4oR5ML/lllXE8E
	8BewxU2CpflzoC/iCChfCMsu4NzOq24BDm7veatr9o7M2W5ZvtvQJIUMCE0T6W9irNKArAjWT+3
	lBPgLqpsLF90oQHd3dbdaH5UOpTjoJTRbEPQttu4XAx5z4+SDGgh0
X-Google-Smtp-Source: AGHT+IEd9r5s1fnXpoG01dbVdt03H4HfKlf+nXWdSHDs3RHqDgvG/mKgmy92mv9tB0zyvfPMzHQ/Ug==
X-Received: by 2002:a05:620a:1a02:b0:7ce:fc0b:d39d with SMTP id af79cd13be357-7d41ebf3aa2mr831583985a.6.1750821094938;
        Tue, 24 Jun 2025 20:11:34 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d3f99faaacsm564338085a.87.2025.06.24.20.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 20:11:34 -0700 (PDT)
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfauth.phl.internal (Postfix) with ESMTP id C51FAF40066;
	Tue, 24 Jun 2025 23:11:33 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Tue, 24 Jun 2025 23:11:33 -0400
X-ME-Sender: <xms:5WhbaBdbc3ebMqMa_Bx5AabOJz4XUu28qlQMWB9kHsREzuKPDotXVw>
    <xme:5WhbaPOOHrPTEI4uZYy1U7SC_vj_Zqo0ASAlNUBxz5KY2qb8lrBFot3-LilsWJdfO
    BSyzKIfkP5BrG3FFw>
X-ME-Received: <xmr:5WhbaKiH1THxO67IXJ2w391OjPu33nlfg3snlCajrWjwYWLRi4vGUiYnvw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddvudeihecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:5WhbaK8ejxPBA17BuJ-xkR7bfVQ58OITl9qFY3L2If4O3xPRaAQozQ>
    <xmx:5WhbaNsOGTH29Oh53q5wUi4ddL-n3QXCOS74-YPDbUm5oEZKrj2YEw>
    <xmx:5WhbaJGxzofUBhVZptdMnMsV8JVMLKR6b9QQ0ZCWzVBP_WnHI7MsTQ>
    <xmx:5WhbaENy02itaB1tvf_fLM3hrry2qJ3_i1dBBOibIgCopcYv8QWBJQ>
    <xmx:5WhbaGOlJBOGSohLur4hAOpqiBgNigg-Lom_-8e7tIhdrPBED9EDYhyR>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Jun 2025 23:11:33 -0400 (EDT)
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
Subject: [PATCH 7/8] rcuscale: Add tests for simple hazard pointers
Date: Tue, 24 Jun 2025 20:11:00 -0700
Message-Id: <20250625031101.12555-8-boqun.feng@gmail.com>
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

Add two rcu_scale_ops to include tests from simple hazard pointers
(shazptr). One is with evenly distributed readers, and the other is with
all WILDCARD readers. This could show the best and worst case scenarios
for the synchronization time of simple hazard pointers.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 kernel/rcu/rcuscale.c | 52 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 51 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
index 45413a73d61e..357431bf802b 100644
--- a/kernel/rcu/rcuscale.c
+++ b/kernel/rcu/rcuscale.c
@@ -32,6 +32,7 @@
 #include <linux/freezer.h>
 #include <linux/cpu.h>
 #include <linux/delay.h>
+#include <linux/shazptr.h>
 #include <linux/stat.h>
 #include <linux/srcu.h>
 #include <linux/slab.h>
@@ -429,6 +430,54 @@ static struct rcu_scale_ops tasks_tracing_ops = {
 
 #endif // #else // #ifdef CONFIG_TASKS_TRACE_RCU
 
+static int shazptr_scale_read_lock(void)
+{
+	long cpu = raw_smp_processor_id();
+
+	/* Use cpu + 1 as the key */
+	guard(shazptr)((void *)(cpu + 1));
+
+	return 0;
+}
+
+static int shazptr_scale_wc_read_lock(void)
+{
+	guard(shazptr)(SHAZPTR_WILDCARD);
+
+	return 0;
+}
+
+
+static void shazptr_scale_read_unlock(int idx)
+{
+	/* Do nothing, it's OK since readers are doing back-to-back lock+unlock*/
+}
+
+static void shazptr_scale_sync(void)
+{
+	long cpu = raw_smp_processor_id();
+
+	synchronize_shazptr((void *)(cpu + 1));
+}
+
+static struct rcu_scale_ops shazptr_ops = {
+	.ptype		= RCU_FLAVOR,
+	.readlock	= shazptr_scale_read_lock,
+	.readunlock	= shazptr_scale_read_unlock,
+	.sync		= shazptr_scale_sync,
+	.exp_sync	= shazptr_scale_sync,
+	.name		= "shazptr"
+};
+
+static struct rcu_scale_ops shazptr_wc_ops = {
+	.ptype		= RCU_FLAVOR,
+	.readlock	= shazptr_scale_wc_read_lock,
+	.readunlock	= shazptr_scale_read_unlock,
+	.sync		= shazptr_scale_sync,
+	.exp_sync	= shazptr_scale_sync,
+	.name		= "shazptr_wildcard"
+};
+
 static unsigned long rcuscale_seq_diff(unsigned long new, unsigned long old)
 {
 	if (!cur_ops->gp_diff)
@@ -1090,7 +1139,8 @@ rcu_scale_init(void)
 	long i;
 	long j;
 	static struct rcu_scale_ops *scale_ops[] = {
-		&rcu_ops, &srcu_ops, &srcud_ops, TASKS_OPS TASKS_RUDE_OPS TASKS_TRACING_OPS
+		&rcu_ops, &srcu_ops, &srcud_ops, &shazptr_ops, &shazptr_wc_ops,
+		TASKS_OPS TASKS_RUDE_OPS TASKS_TRACING_OPS
 	};
 
 	if (!torture_init_begin(scale_type, verbose))
-- 
2.39.5 (Apple Git-154)


