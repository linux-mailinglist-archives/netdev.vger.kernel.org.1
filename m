Return-Path: <netdev+bounces-182043-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00878A877B4
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 08:04:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6E34188A920
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 06:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2205F1D5CDD;
	Mon, 14 Apr 2025 06:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RyMIcpFR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAB61A4F2F;
	Mon, 14 Apr 2025 06:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744610492; cv=none; b=KZqrBfevVmz7XGqxWTos5w2ddeqnizcubJySzqbOYqjQ0VF0Lv0rkQidhAEG68YL+6WtCy8wz6D9Kk9Beq+vEuruoaTUCkqVA2UczK7dZsGSO/tFuamTIPKrnWvS8Qw/81jJ18ZmbOcAAEI5m6sMusBmcDXAVSSlPTwdM8hC6ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744610492; c=relaxed/simple;
	bh=o4mB1YbCjqOm0ivTnYwzfnJZ2vRxG5qWVplnqdlWr2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mwf2ZbRLK/aeYRtPzssXdEEta1rJWYBGoTfc4j202teH+D0QEsfVzd9HAHxYh+jzF5Cx3mVISkjQ/9/I390KwFZ1InEtJ4kI+40q8M06gVXPq6drgBNlXAKWf5nOZkkncTgf5Dak+WA9pfBp3q6VtXy5RIf+VumWhxz5fvZaYmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RyMIcpFR; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7c59e7039eeso580951885a.2;
        Sun, 13 Apr 2025 23:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744610489; x=1745215289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0yyPz4XrJINYrh8fPH3G34ZmNN9tSR8UbhBvw2fpH+U=;
        b=RyMIcpFRRxLpbj5SzaIEqQ6Kxa49pZIVQZKIiY/H/oSzObbCLb8LqeuOKVB+gCgaHp
         ga+7s7MwVMfL+tWnQNIlNCYxrsLZXr87rXAjyz7M9ruK2ws3SHFRGWTwVJn9uGr2Vrzr
         h57w5hur/PWHxZ3Nukokz+XApyJ2pAxsK64iGr+1jrPFzDfiEwi62l68qOD8P41Q8CWN
         E9dMgg4qX/CYLLGxm6nSrDYyeDA8yPmr8eYOWYvMte0COlMBR50bLE7ObOyXNMnVlwX7
         uYw4ylUdaMoO5l2N7mTkOddKudsSt4YIO8EdJIXbckoLmSWSs8ZBBWDQ/VfZ5Ldc/wM0
         ijJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744610489; x=1745215289;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0yyPz4XrJINYrh8fPH3G34ZmNN9tSR8UbhBvw2fpH+U=;
        b=M2r6wwPJ+gxrPIRyBDvFCLI3Vh80MK7zfwIh69nZNYqCBBoS7LB+mmgXOUsNqe99Sn
         0KMCm6BeMt4RAPdjBNvwbiFZD4E0fQ2SpUP1cLBUhfpZ8GfBCv8SDW/G4btqKqiKlhjZ
         LfsZFooBJbhoBolLYt8vN0Pi/hZ0N8+hu1WoWWpqa4mINy7rVSJfs2A9vCsBCHkXmUxv
         oXlpz6bGkP5WLqOSgw5izAcS1u9sxPzXR3FLOHvlh6FtxoNFagbpaCFr3ulTCRuhaqYs
         mSDcuSEU+gTmTGc3suWBIdVkeUdn7WW0KGXl7u6GZbpcPtbkiUF9d3v7tCv9B7d/QlZe
         5GLA==
X-Forwarded-Encrypted: i=1; AJvYcCUWIqCyPo37+sWtMrHHb3b37IzuNtL7W1zXo18oGgxqG/Bdz9D/zprhIqBI18SWDaJeLf1/@vger.kernel.org, AJvYcCVpGKD7vr/U+PR/qwnVnY7qLxskvQvNWWRTtWoKVoARkDHTnWJiIoxbAiH+P45LbSYb+gH2ezue@vger.kernel.org, AJvYcCVwBl0OJ2MljJJaEJY31R9RTLTXtQ7/OwpKsv0O8k/rEispiuQm55Gm8INWJVgkHRs0p8IOsI0zjJU8kGg=@vger.kernel.org
X-Gm-Message-State: AOJu0YynsAXrBhMYHkHkYEJwJttH5/g6zOUcqhgtf53BRi8X8UdVDRwv
	P0oz5o8rmMzGS4ddaxxmtKcjmwjwprwiE0RR4VSJywOhij17P90A
X-Gm-Gg: ASbGnct7npZmZEvutGJOkqm43vXQd8doZLemm0co0mpIY6u5cL2SMP1ljWiwWWH88+b
	GGk7RcFUIg0FhXYqJvTMYVA2HTCH8eweg6kIzUDaXrq4ahEFMCzG/HKfDPUyvITKfQtrhD+5g39
	zNYYbOTLfTr1zSvbA0dm8rk1Dqylrm0ijGFPhJ5YKimicutWAwqC1B04FKT0WXT7dwjd28Fb8WO
	PXQ/qxVvVeMvrSLB1hWeXefxgKLie0djLfzSCsG6IZ1RxZlNepseYMLHKSa19e4SqdZ1MiNRnQH
	dkseiLaY9L/uqKLiYdeKciHlvgtQIRXYQz9vF7m2Vk3iFd12txU6d5IP6YBy+okBi+sI71cYddJ
	JDuwx8DzetAZrKpVBW1xF2XG0p/aFzwQ=
X-Google-Smtp-Source: AGHT+IGdwbtcc/LhSM+g7SxvZuQaQmJqgZUb+rWK7xVQAi5pEHJFx90WVfW5h8ejkETd2bD7aLB+Fg==
X-Received: by 2002:a05:620a:4001:b0:7c7:a5f5:5616 with SMTP id af79cd13be357-7c7af1d8653mr1402849885a.42.1744610489258;
        Sun, 13 Apr 2025 23:01:29 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f0de98096bsm77957846d6.59.2025.04.13.23.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Apr 2025 23:01:28 -0700 (PDT)
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id 616EC1200066;
	Mon, 14 Apr 2025 02:01:28 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 14 Apr 2025 02:01:28 -0400
X-ME-Sender: <xms:uKT8ZwI6gtnFL6uDBVBY9aTm-ILNBXpUc5xToKTs0XgLwc2jf-oaRw>
    <xme:uKT8ZwKbXhojk9lRbGqDPaxKV_GkRm5DtqL4rz5MfwZP8nFR16qrWdgBDAA3cXe2z
    XKJdQsN2UpjnOAWIA>
X-ME-Received: <xmr:uKT8ZwskxNKMSByKo6neGt8EvF9VMkr7TMkW_ONQ176BB5TIXJvIxsN-TmM1EA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvudeljeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredt
    tdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpeegleejiedthedvheeggfejveefjeejkefg
    veffieeujefhueeigfegueehgeeggfenucevlhhushhtvghrufhiiigvpedunecurfgrrh
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
X-ME-Proxy: <xmx:uKT8Z9am7P75Qr6_1xO6B5s38caRNCUcsH7346-OBMQ-U3BUqU5IPQ>
    <xmx:uKT8Z3YRM8ajBHJdf8TkZ9NzAOMXcKqFJM471cilfjnmwlh3i_Tazg>
    <xmx:uKT8Z5APHTNK9zNg6w_bQoTzvgAzeavGsk3rOiAw9jl95NcRJXy1rQ>
    <xmx:uKT8Z9aRuIoyP-HrkI8KJBlORoUUeK103wWGJktXXCB5FUTubd6nfg>
    <xmx:uKT8Z_oolfHCFFSrRGv9EUnnuCaIZNjGIqQAurguf9GG2VDLI2nCiEAV>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Apr 2025 02:01:27 -0400 (EDT)
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
Subject: [RFC PATCH 7/8] rcuscale: Add tests for simple hazard pointers
Date: Sun, 13 Apr 2025 23:00:54 -0700
Message-ID: <20250414060055.341516-8-boqun.feng@gmail.com>
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

Add two rcu_scale_ops to include tests from simple hazard pointers
(shazptr). One is with evenly distributed readers, and the other is with
all WILDCARD readers. This could show the best and worst case scenarios
for the synchronization time of simple hazard pointers.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 kernel/rcu/rcuscale.c | 52 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 51 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
index d9bff4b1928b..cab42bcc1d26 100644
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
2.47.1


