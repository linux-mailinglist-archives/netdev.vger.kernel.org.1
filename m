Return-Path: <netdev+bounces-250121-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 38465D242E8
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 12:30:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7D3C93090996
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 11:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF92376BF3;
	Thu, 15 Jan 2026 11:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J+6Xl1OD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB7B3793D4
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 11:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768476287; cv=none; b=YQIRsRu5qfG7ZJh4AvSFAtjsJFrPm530qOIAnT7pfbo6te1vfa9mW33GwOC2TKW3/Kc525t1oiy17v20wx4533+S1UI6K0qUSa+WhJnZbyZ9MrgvCz4rUsyL4JGCjP2KlkUwr3n8R9bavZI8/IB3Pni4ux/mM5vdMrFsD7ejqc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768476287; c=relaxed/simple;
	bh=NVrwW1R4O2KcdroQjpDDjfgCMa4Z0Adcw10s6u/XdoE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Agz7bKZnrLxb9vlmzUpUKZiBvpkbNMprar7rVDCK+HX7a7AS8jj9RLjdBa9pV0WcaVX/+83dOoK3kOqcAyUbhaLKJoJh9xYeLEqix3ycDmkSrBx97LbWTVUw1feaMeboKK/Bb6bDXprJ/m9YbNX9mbCIuluROCSiygZxJDz1lm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J+6Xl1OD; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-29f0f875bc5so5759445ad.3
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 03:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768476285; x=1769081085; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=meuxC1Q8dcQIhcuiosVy+dIDQYPWfjEU4DNbMnGdavk=;
        b=J+6Xl1ODcADdLDUQQOXpd4d+/OybE5dOU2KlxLqEpbKwiXu+iwMEMsNB91yu1VowMk
         x3DeZ5upecmeGzQbrjUbJrb/ZAqNCTlfqZ60suRJ1vif+IxncewQcTeINmGYF9YfllDO
         G9KLDQAUWAKcNJ+Nl9CGp9ardizZHQlguzmeTM6uVETn8WgcaUT7APnCY+Kt1YNiMcfd
         zKbmXBOALwbdKullSrBUE+E+z/fk61CUziwAo5Pim5gy/CJHZapIxlXW5clBz5NDsaQf
         KxOjXZrDkT3vV3NyvsBEyLz/QSGzLHwRck29XA2+5nN5lXYxYjnhQe9mBM+Urnh3Byi+
         NZVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768476285; x=1769081085;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=meuxC1Q8dcQIhcuiosVy+dIDQYPWfjEU4DNbMnGdavk=;
        b=RikPCyTfODTKL3HFgHUOH0Eem7fB7EsSK/59xPWgDR03EdK1y7NbobwXsbcfVU9Gf2
         4Wm9+n3UALcvXrCiZdZwgdZB5Q7iALNjtqEL86bXrdnVmnnZSbH6kiwRPHqhk91vchgm
         RPMI9m5k7o0PTHk7glCH6Afo8zj59eUGaLbrMXbzYCIVw4gZG0b9eAEFCWxXnzdxArZJ
         8Ug2hWw8SRBCr6a4Wd7mcwlfBBzgc2OiKpBahC5ch6sv9hqt/8tB1pMKitJfgbe6m/l1
         PCiCYhkSHl6fxnea5OFyWw43SKioLuie4LLHsVt5CqdbBrUEwKm3363Tz8CBUTNU6vfd
         O0zQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvRkkPN/5OuD/Atcw/EwYa6DvLhjtSznJ+K6I1lG1ZcHH0oLuEuLCRS3yfGf/5yE4KWo6DJp8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKmRFXSPrqNjy0LsrErN6spY11w7QN1wuagG8PyaQhP62G6BmP
	6IbxW9u1KZD4+8tEb146OAk1Vft/mE4o55BNKPou5GP4H2DKHEOaYReE
X-Gm-Gg: AY/fxX5FH/+2YKIb7bwInaEN+DilKtC/mB5sfFSufgyBf9gG/sY3CCo1W7VODea1otO
	ObQNb3eYkpplN2+V/YwwspI1LSUIGpRONaiUm/RZ+bZnp/mMoB1mNFwm00FnsgIPIQY4YY63Do8
	A1hODMTrTSNMjQi87HUo022eVbBUOEJ4GxsxC98Aw4VSfzDBUu4eqcrGJB+8N+WP7VCbR6IIY+j
	bina2wKDqVc9eCEJHXo3PmyuEi1ahpRmOmO4oMTG9MqXei7p+Py/CKWE1ASaUOrYs0esYqDe9dL
	C7pxFXdGdbPobz+XytIoCK4Q8kufz2Gt2SC8MzaIlHuhOSZHXLezjVqBC8aof1mhmjb4+/YatuK
	/BUE5HIBuGVzhPxMD6ZMWutK/YeB45tlL4PG7YlvcNF6ur6xs3ninY4mKRK1TVIrkObP9gPkAK7
	9Un64xhezJIwcOuKzLtw==
X-Received: by 2002:a17:902:cf06:b0:298:3aa6:c03d with SMTP id d9443c01a7336-2a59bc61e10mr49463585ad.57.1768476285450;
        Thu, 15 Jan 2026 03:24:45 -0800 (PST)
Received: from 7940hx ([160.187.0.149])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3ba03f9sm248523225ad.0.2026.01.15.03.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 03:24:45 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	davem@davemloft.net,
	dsahern@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	jiang.biao@linux.dev,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v10 11/12] selftests/bpf: add testcases for fsession cookie
Date: Thu, 15 Jan 2026 19:22:45 +0800
Message-ID: <20260115112246.221082-12-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260115112246.221082-1-dongml2@chinatelecom.cn>
References: <20260115112246.221082-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test session cookie for fsession. Multiple fsession BPF progs is attached
to bpf_fentry_test1() and session cookie is read and write in the
testcase.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
v3:
- restructure the testcase by combine the testcases for session cookie and
  get_func_ip into one patch
---
 .../selftests/bpf/progs/fsession_test.c       | 53 +++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/fsession_test.c b/tools/testing/selftests/bpf/progs/fsession_test.c
index f504984d42f2..4e55ca67db46 100644
--- a/tools/testing/selftests/bpf/progs/fsession_test.c
+++ b/tools/testing/selftests/bpf/progs/fsession_test.c
@@ -108,3 +108,56 @@ int BPF_PROG(test6, int a)
 		test6_entry_result = (const void *) addr == &bpf_fentry_test1;
 	return 0;
 }
+
+__u64 test7_entry_ok = 0;
+__u64 test7_exit_ok = 0;
+SEC("fsession/bpf_fentry_test1")
+int BPF_PROG(test7, int a)
+{
+	__u64 *cookie = bpf_session_cookie(ctx);
+
+	if (!bpf_session_is_return(ctx)) {
+		*cookie = 0xAAAABBBBCCCCDDDDull;
+		test7_entry_ok = *cookie == 0xAAAABBBBCCCCDDDDull;
+		return 0;
+	}
+
+	test7_exit_ok = *cookie == 0xAAAABBBBCCCCDDDDull;
+	return 0;
+}
+
+__u64 test8_entry_ok = 0;
+__u64 test8_exit_ok = 0;
+
+SEC("fsession/bpf_fentry_test1")
+int BPF_PROG(test8, int a)
+{
+	__u64 *cookie = bpf_session_cookie(ctx);
+
+	if (!bpf_session_is_return(ctx)) {
+		*cookie = 0x1111222233334444ull;
+		test8_entry_ok = *cookie == 0x1111222233334444ull;
+		return 0;
+	}
+
+	test8_exit_ok = *cookie == 0x1111222233334444ull;
+	return 0;
+}
+
+__u64 test9_entry_result = 0;
+__u64 test9_exit_result = 0;
+
+SEC("fsession/bpf_fentry_test1")
+int BPF_PROG(test9, int a, int ret)
+{
+	__u64 *cookie = bpf_session_cookie(ctx);
+
+	if (!bpf_session_is_return(ctx)) {
+		test9_entry_result = a == 1 && ret == 0;
+		*cookie = 0x123456ULL;
+		return 0;
+	}
+
+	test9_exit_result = a == 1 && ret == 2 && *cookie == 0x123456ULL;
+	return 0;
+}
-- 
2.52.0


