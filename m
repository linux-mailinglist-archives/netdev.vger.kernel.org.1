Return-Path: <netdev+bounces-245110-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC7FCC6F2E
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 11:01:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F13430A5E96
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 09:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3821344034;
	Wed, 17 Dec 2025 09:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vrsuoc0G"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BC234105C
	for <netdev@vger.kernel.org>; Wed, 17 Dec 2025 09:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765965354; cv=none; b=VE1a4P/FfCDT+UvIZ95xB9vWyx61jV5Z7DxXHk57H/Ajc6OrHBerLoT0oTNqOYjPK0B6fa0O0Lqx3ivbWeq9rEvb+lmii0+VXIcnBfNR6q7mQEEmpRjZNjEYkBBj+aPG2NNeI69gyS6KgXYQWP2f6KziKFG5HoIiYex6k5ukAxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765965354; c=relaxed/simple;
	bh=Yb5/UWx4ETqVzjpmnt4mp4ucReGhuU4KaNvRMGqzA/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pnr6IIQVuO+cETYzDEK2lYwYtlCv9rFjTYXePasLT6bzfC7BnOsvKpdhFJCXfjk9VHjEV1tpq9CMrUv0P7kqfSChjPYbpYIPHKDehTTBek7kowOifFBuIcV5W4OKvPqJ9CYhO+1fOBvhRguzkb0adDAsUP/GXc6May00gd1SvTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vrsuoc0G; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-2a110548cdeso34948135ad.0
        for <netdev@vger.kernel.org>; Wed, 17 Dec 2025 01:55:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765965352; x=1766570152; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N1TUFEJUx0NUwFPar33N5JyqgDjZHtLZ8/dAi+dAv+U=;
        b=Vrsuoc0GGDCWFdn/fgOI4170rQDbkpEruQK0lgp3GxtjQKpW5K2lvepj6Ly8CSgSO6
         02kPVnPwHVLGYXGM/DlykQ6jWYov3gX13dBeMOJG1VdOXbHGxjpuIyxEjB7l1s0EwMmR
         6IskURwA59Kwp6VtI2YxoDZQLvIFBFo98lR7lad6mPgdfFhNcROj/gJq8r/nwnMSJHMk
         DQdKKsai+4dXCaEyRiBwGrjT3e9CecVVjNJcfUGWaLvzqmpwSdwW/kIZREnSy0KC9ylj
         zu/vvXAPoQhB+A2JfCDv+4xr0q5+0N5jOL3XQFaJN7O+uceVaFgcUMv8QqZNpsZLf0J6
         qnRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765965352; x=1766570152;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N1TUFEJUx0NUwFPar33N5JyqgDjZHtLZ8/dAi+dAv+U=;
        b=HRgt828AaGKRuDSJJK+j3PvcyBiXe489dIc27JEpT55pNARIrWaJiw9Vd43XYStRyB
         mS+6Rb8bOCs0oqLjeqwn5yrlaBOee52Fa8ILbS2CMGrjpRRX6r53O43UCjrQw8HczSGW
         TKmazIiUA5d35VCQAt1qz4qSH2OJT+BRZF7SkJodgEc5clsMWkX5CrAFWirU7Y17mYGF
         iBvgG58UXvqBk+sk9RpgFg0kXQiS/amgpmQC9iC5KW2qFm2XcBSv/ZihbwyCY5V7yFZ5
         bYCXJvT93rWjEaOvAyuOHUIoGi+YfdOiJQDLb7W+2XOjcRB9rIDPso+t9REt3dsu1NKJ
         qcjw==
X-Forwarded-Encrypted: i=1; AJvYcCU2PY/FP/rjCj+CTBG0BTjWThjdaxdYmLO9ABmWCcczTJpM4AXjPNfre33Pq+xEKes1xeWBAPI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYHtwA6sRpDMBATTa3b4Do25EDR+22Jf/76WPria9anrpfZnMY
	TiutBTt1A2iAlXHvuDF2Dw1SSKP6EQtQ4n/3i8ybW9zcP7HjStKTCdQ3
X-Gm-Gg: AY/fxX7u7edTbnz6WhXS7c9N0qXWgrDeFXp7oGbBuvwfe+tTGZ4t9J1iCUQyhpnaZ5J
	j/T2UlkeqeKcCoxkqR0r0hq5WMf3dnkVw2WWUViTBbE//qDfomcHD6h6tlkpVMefan3heAh+0LY
	fdeHwmMn5F4+GedLQz1JsAjxOqNgewXWZ1LHae6jnWs1qhF+L9xhbugzi6tfcD5Bl8SVTIpc9eg
	cnjBtNzrXR6Rw65EgcpDMvNdRSIUELM1Ura2eX0EJ1HBR1XWjUzRqE9VHZY5JtrA6I8ZTOSQRjh
	qnwpZFuT+Qdbm8qcV2FT36mxDc4mJD5Hhv5SMAXkxoDA0qDkUPSmbQMJ+I6+to+AC/9+RF28Mct
	+Y4BMsFuOoyZWe8VHPaDglu8gJWv5hsRKLRSUdA0b1ljWPqXeixpC9jQujRbG65SNLoZuHFioPW
	b+1zwkje8=
X-Google-Smtp-Source: AGHT+IH/IrGCAvWhN5SwCzXnuM6ATb26TVbLzAtyqwtKp2xc+K59EJog5pKbvQBAIw3NE1gXxnNZ3Q==
X-Received: by 2002:a17:903:144f:b0:2a0:e80e:b118 with SMTP id d9443c01a7336-2a0e80eb3bemr106850305ad.7.1765965352560;
        Wed, 17 Dec 2025 01:55:52 -0800 (PST)
Received: from 7940hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a07fa0b1aasm140715945ad.3.2025.12.17.01.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 01:55:52 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org,
	andrii@kernel.org
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v4 9/9] selftests/bpf: test fsession mixed with fentry and fexit
Date: Wed, 17 Dec 2025 17:54:45 +0800
Message-ID: <20251217095445.218428-10-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251217095445.218428-1-dongml2@chinatelecom.cn>
References: <20251217095445.218428-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test the fsession when it is used together with fentry, fexit.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 .../selftests/bpf/progs/fsession_test.c       | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/fsession_test.c b/tools/testing/selftests/bpf/progs/fsession_test.c
index f7c96ef1c7a9..223a6ea47888 100644
--- a/tools/testing/selftests/bpf/progs/fsession_test.c
+++ b/tools/testing/selftests/bpf/progs/fsession_test.c
@@ -190,3 +190,37 @@ int BPF_PROG(test10, int a)
 		test10_exit_ok = *cookie == 0x1111222233334444ull;
 	return 0;
 }
+
+__u64 test11_entry_result = 0;
+__u64 test11_exit_result = 0;
+
+SEC("fsession/bpf_fentry_test1")
+int BPF_PROG(test11, int a, int ret)
+{
+	__u64 *cookie = bpf_fsession_cookie(ctx);
+
+	if (!bpf_fsession_is_return(ctx)) {
+		test11_entry_result = a == 1 && ret == 0;
+		*cookie = 0x123456ULL;
+		return 0;
+	}
+
+	test11_exit_result = a == 1 && ret == 2 && *cookie == 0x123456ULL;
+	return 0;
+}
+
+__u64 test12_result = 0;
+SEC("fexit/bpf_fentry_test1")
+int BPF_PROG(test12, int a, int ret)
+{
+	test12_result = a == 1 && ret == 2;
+	return 0;
+}
+
+__u64 test13_result = 0;
+SEC("fentry/bpf_fentry_test1")
+int BPF_PROG(test13, int a)
+{
+	test13_result = a == 1;
+	return 0;
+}
-- 
2.52.0


