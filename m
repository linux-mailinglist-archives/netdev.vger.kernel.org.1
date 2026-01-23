Return-Path: <netdev+bounces-252668-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oLG5MKEmc2kAswAAu9opvQ
	(envelope-from <netdev+bounces-252668-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 08:43:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3039E71EBC
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 08:43:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E410A30873C6
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 07:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 953DA33B97D;
	Fri, 23 Jan 2026 07:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yf6ZOjya"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CA033A039
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 07:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769153839; cv=none; b=QmhbARJ+lPzvQEfAo2ZB9897m5vvcSoUusNCisGbVcFaZ/uLOqUrkGrgAQFtr+I04/fjECRBSJr4Ba4p7/BuTpg9qRP6KV2rYOLQ5AB1+WGrqSdBqP9zz1VhfFVXUnOXWbsuxRdK5bxtirT0KKX0bxQzXuzuu+/BMXKv5yoBQ50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769153839; c=relaxed/simple;
	bh=EI3S9m8lXbyfiPr0rXLXLlNg6jz6WDFgZ7OGN3ndRII=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XlU0RGX10GGODqFf3Qs7t5TvIltHIOtkXWUQtS9D9FyYeeKv25HWfi/TRueQ6wSJaD7SSKDljprYF18xxLIFX9fdO8g/1YBshT3MnDY1+NOJBA7TNFNN1h5I33ydE7lu4TUNxWLodcRcyDfmbaCewuLVy5MdcS3QcZGm540MdSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yf6ZOjya; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-81e8a9d521dso1121401b3a.2
        for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 23:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769153837; x=1769758637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aFdyTmkIAkHsLaNZCmQPSpqba17vOR1m1y1zTk9qCAE=;
        b=Yf6ZOjya3MLh1Xnf8W/4FwtFVOx0M9nloYnBpbgUV9a/nn/8AIdt8kazT39oICvmqe
         t1ZvEjHycHixxkAgt5nG+5zGCyBfZhvOt2yNrIJwgwusk66fCVlr6y/PVfhWBOto5Lsf
         4cooazDHMB4eiR3z2T5MoDVvDrLpyp3m3W1q7we84QrMDEoamAfO2tDmF7zOEamdfPHA
         K79m6LGh8XpGXMtKmAaWWmUunYjCaOJCxENZOmLrf+0OHV+WE1zJXy6FcaB8U1hkpsVG
         ZnGkHAqPrNYfwGpjuf8JN9y6GI+wTA+hBAZjHVsOVgKW+6tGAG9KEEkVB2UJ+7Wrpw6T
         DCRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769153837; x=1769758637;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aFdyTmkIAkHsLaNZCmQPSpqba17vOR1m1y1zTk9qCAE=;
        b=pEwOnlidz1G6BaChUMH/qi//vrbbeiMNYrmOmyAhiLqJ188uLFHJUCfyT+mHBm6+Nb
         V0+zUSohoevqiW5HCv8cMhHQDWGdTDj3xsaENyxQJpbyFEr1XhVr4/TMCPbXjRVqG8zu
         qen4GBXdb3pPcvsdHZRQntx3KGEIxOp2R98vBLHiX2f7I9ouacAM+9NF2unNTkH1TMF2
         QKy9zxgm4jYcVXsxEv74GI64R913ZRUfAjG4v5VxGRrcoqWgZWVp3lcpYg7XQBWkAiyb
         xLdK3+Sue0w0CpViC+XfuRMzFuGRPCINysM6vjeLIyFoiwOySjyx6ZyJPPZxqxXiYNME
         8aiA==
X-Forwarded-Encrypted: i=1; AJvYcCV65VdtXEYSXJ4WTKprB1603n8VGejlI39HS1bAROvZ+bU4hKckOlzlDp/JlD34YU3dTPbZWgI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKKi7ZrqVwct1oAHZFypTWAQjP7SxozPpvHRcY3MlBRkF6saWt
	Lgc+fhR3MZtHVUIy3ngtGN1HNt3f1CoMFkRcpWzya8DE2zGDmjmuYGwv
X-Gm-Gg: AZuq6aKIlCtUjOiuw+tY7Mr6IEcgvDXtKvMZ82ydXlq+Lfe3DXqcn6gG4e188BMBHPK
	G0UqDYgN0Oh6M0xCx4GmSmKYA2nDcwwYdrkg9DSbfPEKgEPIAi3u8W//cWJ/tyaEjy9Oxks6fQq
	3MFzKtfpci8R9jdjBlIZL1TZEyVUL3WwTiZBVdE1y2aXfxIzvCA0Eqld9p6H7Co04D9n7m4UO9l
	QV/R7RyADjd2g7iqzaJ5yOjb6zl6asbbrvPhsLp3OADgAK7pgjW0yCo4NlffkTyY7Uo0vzkhZLM
	/zcowtfr3Xaq3hC3pwh1kjVgyFcqzMzoLZneCMq5Q+y4n4rAMLRbgbM7DrWtyMZrZ3yyL8XBCl/
	ToqvG7dpOvfW070IDcd+Kw/kmX/BaJXBkPrWVlk+ybhCP4+IxQ+GD2lsra/TpEgBi075C1MIzFf
	m6Q7DUOHr8
X-Received: by 2002:a05:6a00:1c88:b0:81f:82b2:ecf8 with SMTP id d2e1a72fcca58-82317ed8d49mr1870818b3a.63.1769153837561;
        Thu, 22 Jan 2026 23:37:17 -0800 (PST)
Received: from 7940hx ([103.173.155.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8231876fd1fsm1334205b3a.69.2026.01.22.23.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 23:37:17 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: andrii@kernel.org
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
Subject: [PATCH bpf-next v11 11/12] selftests/bpf: add testcases for fsession cookie
Date: Fri, 23 Jan 2026 15:35:31 +0800
Message-ID: <20260123073532.238985-12-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260123073532.238985-1-dongml2@chinatelecom.cn>
References: <20260123073532.238985-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252668-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[iogearbox.net,linux.dev,gmail.com,kernel.org,fomichev.me,google.com,davemloft.net,linutronix.de,redhat.com,alien8.de,linux.intel.com,zytor.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[23];
	FROM_NEQ_ENVFROM(0.00)[menglong8dong@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,chinatelecom.cn:mid,chinatelecom.cn:email]
X-Rspamd-Queue-Id: 3039E71EBC
X-Rspamd-Action: no action

Test session cookie for fsession. Multiple fsession BPF progs is attached
to bpf_fentry_test1() and session cookie is read and write in the
testcase.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
v11:
- add "volatile" to the variable "cookie"

v3:
- restructure the testcase by combine the testcases for session cookie and
  get_func_ip into one patch
---
 .../selftests/bpf/progs/fsession_test.c       | 53 +++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/fsession_test.c b/tools/testing/selftests/bpf/progs/fsession_test.c
index f504984d42f2..211332bdcccb 100644
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
+	volatile __u64 *cookie = bpf_session_cookie(ctx);
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
+	volatile __u64 *cookie = bpf_session_cookie(ctx);
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


