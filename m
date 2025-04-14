Return-Path: <netdev+bounces-182038-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 007C8A877A8
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 08:02:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F3CA7A3150
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 06:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79861AB6D4;
	Mon, 14 Apr 2025 06:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h3N7LvDU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02EE71A23B1;
	Mon, 14 Apr 2025 06:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744610486; cv=none; b=qYIVp/BMDPz5ISY1yBfZllPA5XG1b/v2VDOD9asUCjCTeLqUFyC0EkIHFuEUZ4I6oNYF1YfSGtljwg4AgYQFbf6058s77EZAJAF3N7JcEDo1tM1tI0hx/b5K3gPwsgq6r8s4sGMIYHQ2InFc+p6+KSjIVZ9nLK6aPI0EX5lmWlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744610486; c=relaxed/simple;
	bh=46AnLWGOvwy4R4xqUGhMY1GRT3BPqIPloV90uxpkFIs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cHc+lcRSFdXLNOf0p85oesQsm4d3TjzHb8i0F/RryLCzc5ssYsfZQQ/vCZPBRm8jiP+3LJ6/4c4uOjkL312HYzHgHUa+Lw87y/yOnoG/Sp9dAXh4oD3I2dMz+NAnGauHzp0JzzlqW2tcEZXxIiIuUWhmaIKU0gWWLhONQQnZqDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h3N7LvDU; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6f0ad744811so23548276d6.1;
        Sun, 13 Apr 2025 23:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744610484; x=1745215284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hLSzZQgiNEWo3FbcTs2LNPwbUJUrF+q+NANxOYOv6MA=;
        b=h3N7LvDUFY+dJ4T3xJbkR8Pl7u5+JA1j8ZhaixW/mvcbe42qwhqvsuFHXpB6Kr6ztG
         vNuJXjZAlaAT1mVl5444W1qMAn5K8NJV941UH7fvsg79wc1DkTygEooRER9bWMu3jKrq
         U9yG2Uz5F3vYjeC29kpcXbiE3K95zMQZVf3B4uUVVWxI3N2//oYU4BTH6HDoctAE6CWa
         H8mp1me3vW0gcP/aGvDvHOSlQIpulkluNkroNyGAvSkl39yuyl843Y8PvkRxEMehEbKp
         DFYGCpE/rhw0xKasPmaD0l41rYbKY/Ne/vmn8+KQj/wjfLImhaeOlaFErd2vS6R3MWNJ
         bpQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744610484; x=1745215284;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hLSzZQgiNEWo3FbcTs2LNPwbUJUrF+q+NANxOYOv6MA=;
        b=aQa1Gdc+BzQ00COmLrS9CB/0mhua3Zh2y25s88tEwn51377+RkXsPQoQgSSdy6RrPE
         q7Qe+XSW0iD4rzN+maX1X2eeWcR/m+Q1/jh4mFd7ACDTAyzWKIAS3Zd4u/OIYMiSOgCS
         3bV+n7L+msNf2Ozol4enfWHs8hPAZoukhdy30FLLBx9F7OLPN4c6ObP4H8ekzit+++hw
         NM8zBWa1dru+hbZH+eXsvBt5YEn9B99M5Ux/iTkcuoZoEwA7mzFkbjYBL+El5T1eS3xb
         hQduXqCy+k1eS2sXBUIdQUlPXRGDOaOHLhBpp+GGKgTWhYm3kmmWpLJSjYMobq5kWDYE
         s55g==
X-Forwarded-Encrypted: i=1; AJvYcCVHhYV7TkBpXFzSLShOYXkdv6IBYXu32EMqxpvQaYm3mzP6Vg8f3fb7p2FwJ/l2dbTu4qqm@vger.kernel.org, AJvYcCWTMpaXjMWd2uIyOZi8UtqYfevs7TtspuDi2KoKHHbe6cjkdNtPHJQ10F16Yj+78NZFA96MPO6v@vger.kernel.org, AJvYcCXNjFLS2i7r96QbaB6+KEUYftYcCEU8LeMwegIoD28nRDJzUsNBjXvc305h92JnsK0wmJL8hLkM4ZvJ1YA=@vger.kernel.org
X-Gm-Message-State: AOJu0YweWRUs8Ie4xywaYcxmoPZr0/Vk5s1tNnRnIp1rK747TIcHuJRq
	WvTM5FkDMl1IS7EF0thkjsCRwaUW5LB65SOrriiW/PDOQ0Z8T2tv
X-Gm-Gg: ASbGncsNhld3BGThyACVXB+Kbt2z+N59oRRE4d3O+MfqxjnVmPTmLXtNvXAUChJ6vgN
	nyB3TpgUZWNUZ4t8sA+3Njx+x+kvXPsi7/CgdVd4ojJkxMIm0sIGTkDc0XYguNJaiYBcTTxJ0ts
	4ZEHnnEeW8Hb7+iU8ayAEpco2QIVyVvS4haZjyVUvtDnMNjZbGP6cl+QFWpjyz3IewnLyea8Myd
	3Vp8RzrMO4VECr6hLXh4X8eRbE1XNhUlXEIn3HGuhpU2GW8kbvHRRSu3vM5IXIj0AeV9fT4rRwP
	5GR4GkOq8IHwPt6SYL3Is/VfqY7b+RmWUaFALPAKj+IO6cBqDsZ5drf7+l/bfiwJiyuJkpZf+DE
	6k4bkZQvJnhLG2RfyiWZgzd05rSbpdH1p97M/14XtHw==
X-Google-Smtp-Source: AGHT+IHxjTo84xD1QJtcQfo6b2PbGTrIcy6W1myY8lywI+/f1fLgFOTQuFvktp2h5zmiI7EZ4JRoJQ==
X-Received: by 2002:a05:6214:d83:b0:6e8:f3af:ed44 with SMTP id 6a1803df08f44-6f230ccfa37mr147657136d6.12.1744610483624;
        Sun, 13 Apr 2025 23:01:23 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f0de95f7bdsm79022596d6.23.2025.04.13.23.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Apr 2025 23:01:23 -0700 (PDT)
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id 720101200068;
	Mon, 14 Apr 2025 02:01:22 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 14 Apr 2025 02:01:22 -0400
X-ME-Sender: <xms:sqT8Z_L-NwRg-ypOtx_fTrFiQJdzqCPawPvGCST2k5YBYZ0V7T0afw>
    <xme:sqT8ZzIV80Wf9EwWntzOU4bL2BpeBGW6A2AEhPYtFDVQBnNUJMKv_4_AM9kDFhUIA
    VVdP-BOP11RwBXjsA>
X-ME-Received: <xmr:sqT8Z3tKAwvnXFwtrYmr9BryLQb4_p8SvXzpf9RtSdFdXLNftZtAha0yQHA8Jg>
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
X-ME-Proxy: <xmx:sqT8Z4akmD0ZFBcTma9sOJrMJDPQdEYpk9pS0lvYNNeK0afQ0V0PNQ>
    <xmx:sqT8Z2Y1mnkRVXnFrmftFnj2vGypRH4NVjnG4LU2NBQiwSOqpNuOYg>
    <xmx:sqT8Z8D8kIGeN0qdAot4eEnwL_vam3mukVYA_oIR7AY6go2Y1gYO_w>
    <xmx:sqT8Z0avbWE_gjlWh2JC6vKfnWU1bB-HoacNIcRdQ8a7kZQ-bTLhVA>
    <xmx:sqT8Z6pRZVh62gahkDhRnY4Ph634swemuKszCaKa3pU9nht04pO3lD_4>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Apr 2025 02:01:21 -0400 (EDT)
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
Subject: [RFC PATCH 3/8] shazptr: Add refscale test for wildcard
Date: Sun, 13 Apr 2025 23:00:50 -0700
Message-ID: <20250414060055.341516-4-boqun.feng@gmail.com>
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
2.47.1


