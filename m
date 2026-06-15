Return-Path: <netdev+bounces-299353-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id B1pGKr2sL2qfEQUAu9opvQ
	(envelope-from <netdev+bounces-299353-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 09:41:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1100A68448D
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 09:41:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=HylVFj8o;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299353-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299353-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A3D31303AB7A
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 07:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D3FE3BE633;
	Mon, 15 Jun 2026 07:39:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F2C3BF685
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 07:39:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781509180; cv=none; b=OYNAxCb48wbF3942Fockx4hObO2r8jn/76KOtAEHzvzuCifPAaWmJpVjprGYRNv5ab0fqd+7FgnYsemITZhPqcR7uU5dNqm6lBhCA+Vcjyq6OVBA9dugliXOJMM9HiEbTWDioXJQn7ex8fdZ9XKGqCTuJBX53FUy3YwliiyZl0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781509180; c=relaxed/simple;
	bh=gLE8CCQ5SH12vR+rRgkoSJvrMBzBUKCuuw23IvWdWz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gxETHe4R0BP5tm9kNtOl2g1zml+TcGk2jUAUOJychaYXeEi7N2LCJ0laPQYIOGzp8AlNVzMGPME7Ke0JkBUbB9oHQn7QeFCeXt17uoUOmSVBfH5a7UjM6IV1gw7/lbKes+OCgvZMJKAipv12crgxC1EqTG+RObTCAjG9SPsIWBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HylVFj8o; arc=none smtp.client-ip=209.85.214.178
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2c0c32f6ce1so20138275ad.2
        for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 00:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781509177; x=1782113977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vbxyv2uuWx2uMg89JQUtXul+SksXRCRyTkytnWrdbbs=;
        b=HylVFj8olbHUfUyxSEIEg9YPMet/+ntPQWFLo9hdVoorB+YhdS9hNFUJIUSHR8Ib2V
         kG9bsprvYkkKY6qwgnqt5u4IuHTRKn70Z/g0Np2yOhdvUef/CQSk5lhBVmqiDMwJdMBM
         JG3WSM54Viep3VFRJSCHEt69AvkI1YBF4TdtPMeHis8arqH6DqAREGPgwYUquiDv4zIk
         Khe3m0LETBwReGBkHaautnRGSndbR1l60gcMMlcf0Xol1oMEVGUqCvCi+0dp4t7q7d9k
         +KCxIeQ7JJWpIguW2j9kw+DcQEM9H1EvncKke5yJc2NaPqO2X8RJ416LHijdISkFg/gz
         wn7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781509177; x=1782113977;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vbxyv2uuWx2uMg89JQUtXul+SksXRCRyTkytnWrdbbs=;
        b=dyYDRcwpzlQ89ipll61tXyIS6O/ft+9fKksGP1bstspKydsmQD5NpipC5IQid5Lu8e
         5ajKkO4yFXbs9ZnqDVudYA1UP0ky0q0gYFgOAarNUCPtw862LEHd9e4V30j+bQIyzCs9
         CBELifRsoItVoMqWF3FZldlpiTFO1nqAQj5T7qgTvkanHQ2F1abGJOyxACIgdLiTy6f+
         0DzBkNcsQXEljf/k7OD7XhqWfrkJ802vVaiOaXMzu6W+nOxRhvoa1L5y159rau+S38RC
         q8ocxHZad3uifu1RvBRhXeUGSCEUwvk8KXV/Psic2mRANX0XvGHXlIdmGvxc3DPfN1nW
         xmTA==
X-Gm-Message-State: AOJu0YzQV2GMndy0228zpd75Tg4a27r7OwBTx5qq00lE6g5Paqpzv5ER
	LyxobK3tkc0PsT78r1Ko5RMNtnzL3IsbxC3VCeaCumcyKQ4zwL0BUR/7
X-Gm-Gg: Acq92OEmtXk0FeL+1HoT4DB8qF5e3z5xe/WbqHImQYCI2mp+6vkrK/NWBmbDCDqSiSi
	V1Ztb1xO619IVemVWSGnJseryK55hd1R7kYVbGpUA8MRtvLHeg0HbUfftRYxDL8EhTRgEREP4mD
	rTlNGolbosd/PaiUTAd/mTiLasKt8aMhdZrKGnhD4k13aEH7FF0JuaSt8OkKFknE1dLdWEY2ipt
	oV7iII8JOajy+bBQHPOtXJdG+yllTvYBqeAGTfB4fAAfkOXPT54txBG8QQnV/R6nXla6rAwBVCr
	lRWRhqvfJdcNt+486IpFUFZDLuV1Ncs1+Nh67A4f4N27jgCgTHJymuUVKgZIHcV3YMAwxz6zgr3
	JkDXkNNXaJNEt5seq4xjo/RmSfeCBrKN4hysdeE2jZxcgX9i/IA7aQEyMwMKlZjPKZKagnTkeU3
	Tq+L6ZoaAM/GSNibeGYqRAsx7JxHVbGUOEVNKNBjPdL+qdCEFndhGGl/F/USOg/3s=
X-Received: by 2002:a17:903:1a30:b0:2c6:7479:644d with SMTP id d9443c01a7336-2c674796a84mr71837965ad.5.1781509176848;
        Mon, 15 Jun 2026 00:39:36 -0700 (PDT)
Received: from localhost.localdomain ([2a12:a304:100::209f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c43307a259sm91271345ad.68.2026.06.15.00.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 00:39:36 -0700 (PDT)
From: Sun Jian <sun.jian.kdev@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	shuah@kernel.org,
	paul.chaignon@gmail.com,
	Sun Jian <sun.jian.kdev@gmail.com>
Subject: [PATCH bpf 2/2] selftests/bpf: Cover partial copy of non-linear skb test_run output
Date: Mon, 15 Jun 2026 15:38:56 +0800
Message-ID: <20260615073856.152479-3-sun.jian.kdev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260615073856.152479-1-sun.jian.kdev@gmail.com>
References: <20260615073856.152479-1-sun.jian.kdev@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299353-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,iogearbox.net,linux.dev,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:martin.lau@linux.dev,m:eddyz87@gmail.com,m:memxor@gmail.com,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:shuah@kernel.org,m:paul.chaignon@gmail.com,m:sun.jian.kdev@gmail.com,m:paulchaignon@gmail.com,m:sunjiankdev@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[sunjiankdev@gmail.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sunjiankdev@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1100A68448D

Add a test case for BPF_PROG_TEST_RUN with a non-linear skb and a short
data_out buffer.

The test verifies that test_run returns -ENOSPC, reports the full packet
length through data_size_out, and copies the packet prefix into data_out.
The test uses a 100-byte data_out buffer with a 64-byte linear head, so the
expected output spans both the skb head and the first fragment.

Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
---
 .../selftests/bpf/prog_tests/skb_load_bytes.c | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/skb_load_bytes.c b/tools/testing/selftests/bpf/prog_tests/skb_load_bytes.c
index d7f83c0a40a5..134be0ea8ed7 100644
--- a/tools/testing/selftests/bpf/prog_tests/skb_load_bytes.c
+++ b/tools/testing/selftests/bpf/prog_tests/skb_load_bytes.c
@@ -3,6 +3,39 @@
 #include <network_helpers.h>
 #include "skb_load_bytes.skel.h"
 
+#define NONLINEAR_PKT_LEN 9000
+#define NONLINEAR_HEAD_LEN 64
+#define SHORT_OUT_LEN 100
+
+static void test_nonlinear_data_out_partial(int prog_fd)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, tattr);
+	__u8 pkt[NONLINEAR_PKT_LEN];
+	__u8 out[SHORT_OUT_LEN];
+	struct __sk_buff skb = {};
+	int err, i;
+
+	for (i = 0; i < sizeof(pkt); i++)
+		pkt[i] = i & 0xff;
+
+	memset(out, 0xa5, sizeof(out));
+
+	skb.data_end = NONLINEAR_HEAD_LEN;
+
+	tattr.data_in = pkt;
+	tattr.data_size_in = sizeof(pkt);
+	tattr.data_out = out;
+	tattr.data_size_out = sizeof(out);
+	tattr.ctx_in = &skb;
+	tattr.ctx_size_in = sizeof(skb);
+
+	err = bpf_prog_test_run_opts(prog_fd, &tattr);
+
+	ASSERT_EQ(err, -ENOSPC, "nonlinear_partial_err");
+	ASSERT_EQ(tattr.data_size_out, sizeof(pkt), "nonlinear_partial_data_size_out");
+	ASSERT_OK(memcmp(out, pkt, sizeof(out)), "nonlinear_partial_data_out");
+}
+
 void test_skb_load_bytes(void)
 {
 	struct skb_load_bytes *skel;
@@ -40,6 +73,8 @@ void test_skb_load_bytes(void)
 	if (!ASSERT_EQ(test_result, 0, "offset 10"))
 		goto out;
 
+	test_nonlinear_data_out_partial(prog_fd);
+
 out:
 	skb_load_bytes__destroy(skel);
 }
-- 
2.43.0


