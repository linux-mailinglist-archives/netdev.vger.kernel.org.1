Return-Path: <netdev+bounces-200910-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 997A6AE7521
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 05:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 163331749F6
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 03:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 723611DEFF3;
	Wed, 25 Jun 2025 03:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iiz6nPsY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCF91DDA32;
	Wed, 25 Jun 2025 03:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750821091; cv=none; b=T2b3BUtWc8c/ozN73RYJy48fM0u1BIfdfEvJsbHE2t30ALk00rP72tvNkUY0VnwnmxOr7OFZgHoMEdxWCvO1mIrojZXZNQOWcFdiM5ahag3nV/w4p6hcvq/ZXYs0Syz8gUjMjMZLwITV1EXH5saFqzDbVS2MjIBMJ+gSpktwJP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750821091; c=relaxed/simple;
	bh=duTW7lZrJNtK7UEEDJSzyS45AgiLLDWdc/06eYlkxEM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t/AKuW9Ow2r/SZJ99vGkkrS8l5w4V8t+rKYrLYd0a1T8iXSHghifOH0IlSKbbFcRwx+6hQXz35jkmOAbqkQf3Rusw/gCp6dQgmAn/rJdXkkNSTk436I+cWWqCohMhoUgT+u8Vt7INAnjrKbB95NcWyJeMy0HqL7UeC/WTSAtUY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iiz6nPsY; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7d3da67de87so111649585a.3;
        Tue, 24 Jun 2025 20:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750821088; x=1751425888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DK7y8fCnybk/HJabsb4vjDUHN1LvZsSF478PQROiY+k=;
        b=iiz6nPsY416dkI1IlRC7/DO+ri8nSrRnZ++f3cJCTt9m3spQqmH1e2XA5io/KtlDE9
         uTia9EFtoWdSjW6iPcbo+QlNJrt0QmK94OvwDC5FKpQ/AdgtJH9Tk3+kMGrDaswz+D05
         aMuu5zzTZP2zM55CPJVLAdsm1fSE3/JQ2adyocbuQrKdGR3p5l25mA7oa6iz0vdNMFmX
         vf24Wnd1SvnxUcHlv8PKwC1oV+5SAv51m3ah1PfcXbj3eltpDKw2aDIn184ccs3x47O0
         lpFn4Fp5CvMEnzitUQTYr4OgsAGSiphcHEoX2l+7TNxVQNSM59bHjXOmnzUtVD0o6dTw
         6BDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750821088; x=1751425888;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DK7y8fCnybk/HJabsb4vjDUHN1LvZsSF478PQROiY+k=;
        b=DypFQuz/li/3QlhkXVyCnXafVIPTXGPX0lruW7acisTjnYZ/kfYQzI8cD/YLpjrWIn
         GC/rWhkwC3eep98bc2WpL4dxOtfefl2s8I0t8sTQhSZra0mRZHK+fNnp9yuofHQRvsNK
         vq7d+LvyoJjDS/w+8JzuxHKFMhuPzWBOpx2roKMwS7qk/LnjCTqS1YwPagWQO8WRJAOx
         yCKozP+sInxDZOqYQz8QxsT0nbPr9t2zMIxeDdJdtWnM6BvdR0RaOyZMq/FN1ao3licd
         CsD7DvM3yP8KwZXEqdx/5m2fi+uc2wa2lBWnG5VEcaiklN8nODidD23GaZZ7I2GRz4MC
         Pzyw==
X-Forwarded-Encrypted: i=1; AJvYcCUp7SHJ+/ROPjC/3D3jNz1d3A7tro/KOGlcXBIBcVLWUzbNiKcu5jZv2WoiePDnbFFw5PNt@vger.kernel.org, AJvYcCVVQkD89XU4Z1OXJMAae824616FNp2S8BF/AyYMRU35a6FyRKZ299/fpTAq1/ZZJgPsLE7BTy0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdRun+afHrXamGOWIEgC/T9zNlQbSrBQVAB71mN1veylpY1sVu
	djoGuiytMbn+DtgHy3oVucG0OiVUa93qcDFzAtklt2F/OJg+UQswkg85
X-Gm-Gg: ASbGnctkA0biCAtIwVOhs2/fSMwcd9chsukYzSUvq6UMcojHz13a/eziLMDdYxppC7p
	OwgsSznKEafx+3Hwqbb9r3vFX54djIE+yJysU0ml4X1yyim9JiLH3jf/K7QadAw7SIQ/XZ6t/UC
	O2+Xf+uL8r0rkOnJS58ZvXQrzlbWz7233ZfFWeSACwt7/imRWLRms9GRghVhst85l+1vwuZSCbI
	Wfa+qkNJFC+ov7v/xOWnlMwXwHggXD/DM2pwS5Cq5w0SfnyJaCbXcpgyngGOGUN/B0hEO8xAFm0
	ayVG169Bp+a/hf7U0Z5FW22vtFpdjbmwEiKP/jiqCNPUE104n9afqRskYtGINy97zLkZlQK8MhO
	KobfvUZHRRGUkI3WCxEAcrAE7pijEpnKKVpOSrt+knVddpvkHL4Ms
X-Google-Smtp-Source: AGHT+IExxiStgtde1OhSWnRVxkmvUnW7k/+Lfu1ZBv7pox0OQJqTmpZsld1V4TSwetgR20fZq5Y+Bw==
X-Received: by 2002:a05:620a:1987:b0:7d2:fc7:9572 with SMTP id af79cd13be357-7d42971d8acmr177374985a.57.1750821088463;
        Tue, 24 Jun 2025 20:11:28 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d3f99a6724sm562079485a.41.2025.06.24.20.11.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 20:11:28 -0700 (PDT)
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id 7CAC4F40066;
	Tue, 24 Jun 2025 23:11:27 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 24 Jun 2025 23:11:27 -0400
X-ME-Sender: <xms:32hbaFbwgE2soKavsjsb4U3NtK78h5X_8xwKvF9yXgOxqaRWnlmKhw>
    <xme:32hbaMa0EUO1JZ5XwYCPX2u3KLAQbkLoiJTlJfRTcxKkWFzzmhJ67pfNMbSzLlM14
    Ylh_j3NwILbHpZWAA>
X-ME-Received: <xmr:32hbaH803MgUp0Xms9t70plJieGcRL1ITS5M1F91FNt8oeqfeTKQhAHCjg>
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
X-ME-Proxy: <xmx:32hbaDrg4yhrx3lNkpe2EhnE9fAnVZ3wi58kOe6KQdRzmX7zoOlleg>
    <xmx:32hbaApZNmLUrkJNTI-1dzfdnq2RRQCgJUbMr6S-DBwUg5gQoVXF5g>
    <xmx:32hbaJSBQefksqNTtwWPnLLd55diQld-ltyCxfIunKeFBSS6QqSa7A>
    <xmx:32hbaIq1XJBujOy060Z6qzNZLH0NYFcg-SjLJvvZ5DyhZXu3vctFfQ>
    <xmx:32hbaJ4UfNKnl1hstcIme_5F7Zj_ctVyFRJ2L54fHUld3kf4avR2VY1C>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Jun 2025 23:11:26 -0400 (EDT)
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
Subject: [PATCH 2/8] shazptr: Add refscale test
Date: Tue, 24 Jun 2025 20:10:55 -0700
Message-Id: <20250625031101.12555-3-boqun.feng@gmail.com>
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
2.39.5 (Apple Git-154)


