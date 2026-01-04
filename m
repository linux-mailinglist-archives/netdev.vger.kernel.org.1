Return-Path: <netdev+bounces-246752-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C4ECACF0EFF
	for <lists+netdev@lfdr.de>; Sun, 04 Jan 2026 13:41:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 693413001823
	for <lists+netdev@lfdr.de>; Sun,  4 Jan 2026 12:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E1F2DECBA;
	Sun,  4 Jan 2026 12:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TqPkms3U"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f195.google.com (mail-yw1-f195.google.com [209.85.128.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7522C2343
	for <netdev@vger.kernel.org>; Sun,  4 Jan 2026 12:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767529843; cv=none; b=ocbXBBqiLzNllmlGtIAlaWB0d6p+lOpc9cxSV6JklwWg4bipnEPSDRA5k8m1CYMKCQxJ/I0vGfVyxiz5GpzZrkkXQeKLx7RUU2O4XdR+O/Exut9epyXv4AyhKmCrOX/o7fuUsvjlUjlJM/KYqtlwIhfYfrHM1iLsDH+uww18FFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767529843; c=relaxed/simple;
	bh=ARq0/QucFj/sxPqr+22ybRos7rUcjBBi5nq/Y4PoAvU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dRSsTYYziBjea/h3PYBVb+C8Zv50XyfbSog3dqlZjDm8y+doVvR/jhLl4xThk0JRRNp92e+U/Of45tZL9i9MIoS/Ck8W3gKHmMV5Q4IAWpLy05thodMeBcCOc7FBtpvIu4oy2M/WsbODT0gkVZSE67TaJuOeheeciJhoyU9+fQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TqPkms3U; arc=none smtp.client-ip=209.85.128.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f195.google.com with SMTP id 00721157ae682-78f99901ed5so113887597b3.3
        for <netdev@vger.kernel.org>; Sun, 04 Jan 2026 04:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767529841; x=1768134641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ki8yj47Ksf2sOkp6JBKCA9cB1ptX2Wx6sb0cvY7RlMA=;
        b=TqPkms3U+iW3ZtHfZVQjlxgEmv0kdW+TEc691Q1F9AVik7R1CxM07xU7sYmYBVdTut
         YvJEwRyigQ5XFg1f7RzDNSD3bh2JcV7WL/9BJ3LTQ0zYR6Vdk0j9pO8dneLnayedCXqc
         LEUM1gufSqq0uuveuXnxoag76AtvwEJ7x19FKID0Ls60Op0pCUIAQzJlHRBrGt/AkY8p
         e4Ct6NtYXCI14AdCF8c0n5JEOY6cIEWXviAQ9nfuSF+p7cY0AKDL+2Vh8fUPuJ9uZs7W
         vK4ovstoqjMQOr/l+xVySfCshB9DkSnht4D9YXD0x1xwbiNUOgBfzP+kpl+N1TlUZe5D
         ltpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767529841; x=1768134641;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ki8yj47Ksf2sOkp6JBKCA9cB1ptX2Wx6sb0cvY7RlMA=;
        b=HAu3e99cnyVs9dbXoQHTQ5uGb3f2XS2Cr/g4c2+/Qza7vgIEKQGObIs8QMBzmJ9Rh4
         sHVZHOdXtiUy7AKNWPFR9yLhdMdIP7A0VlcYC8RKvBsAETkHeojm0acypsIjNUgBRKJG
         h4ItrS3PjoqSXAIQoZq6RRL2Cu74/IxUFYvncRqErSCeqauU05RvyZmKF3CAZO0/AIPN
         wQvznix/9kp4AGOoarDJvfsE1n9+oYgbL2hNenG6yCpa+ZqjPXedfSeCXGk61k6a9MIH
         TPWIRtjMz2/eWX+sSJUI+xUHg93ytRDwLHRTQI/SaAVSrdeVg1rYtm5uDMPu8PCbTgxb
         tgqA==
X-Forwarded-Encrypted: i=1; AJvYcCXEWVjXpomawA4vZKaAqtbShh4EaPikXcLMCVn+mi2omnoQ6xX9B4WPZ9OGEuW9ZrZZ0d204f0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlQmBfQOp9ZAubCc19HCYwX3++ZNZa7kWcKG16pLtU9qcuBos9
	GQMDPkbM61PxcUdcON+3UKvTMYuSIgDAUQDkhipoXbTWtdNO0dEW6GP5
X-Gm-Gg: AY/fxX65hca99I3pDQpuz4LkAwJvuS14wMrkCnXL46ainDp4apMyN3Yd/Pcj0lusS0l
	gCi6KPGXbOKJo5Ou9xU1xbKAHDY9LhGVDPCvZskRvsPH/YYdEBs6hR1ZIDmYfmGUQy9877KMgjB
	4OS1fceoBaus+GtD1nQNjv05cPQH2R7/DR/FR7keGh7LaLJhS1kHNcaQu3eF3NqijMx79xYHltV
	djHdlvAbFqpZ+GoPVF4AyGN91mtWhVJLIXQfX3Cw+PMQoj/X0/MnojTEXNWIUeBDKkhfCqypFn/
	uhu+S7wca9XCt1DQsuydlC6KNAF/fsuMcjCjbd8X8PR3Xk9Wjdb3HOwvkkNpCqASPP1ote+ZJFP
	GT92bmJIXoD4D8nyU0H04dAYef44WBQSTCEHgDfohLkuMlYXCKdJw6YoWeHZ1giTDS0kqPNM3Ob
	gqs6qiHVU=
X-Google-Smtp-Source: AGHT+IHvmhNvokdhiDeZCaYjQcCM0epcPEZFOjtq+9XoutL8WlCTfktxFdlZD6VAvB+jQfPzwTGVbQ==
X-Received: by 2002:a53:acdc:0:10b0:644:79fb:7db7 with SMTP id 956f58d0204a3-6466a87f95emr31497735d50.13.1767529840792;
        Sun, 04 Jan 2026 04:30:40 -0800 (PST)
Received: from 7940hx ([23.94.188.235])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78fb4378372sm175449427b3.12.2026.01.04.04.30.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 04:30:40 -0800 (PST)
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
Subject: [PATCH bpf-next v6 10/10] selftests/bpf: test fsession mixed with fentry and fexit
Date: Sun,  4 Jan 2026 20:28:14 +0800
Message-ID: <20260104122814.183732-11-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260104122814.183732-1-dongml2@chinatelecom.cn>
References: <20260104122814.183732-1-dongml2@chinatelecom.cn>
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
 .../testing/selftests/bpf/progs/fsession_test.c  | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/fsession_test.c b/tools/testing/selftests/bpf/progs/fsession_test.c
index 5630cf3bbd8b..acf76e20284b 100644
--- a/tools/testing/selftests/bpf/progs/fsession_test.c
+++ b/tools/testing/selftests/bpf/progs/fsession_test.c
@@ -180,3 +180,19 @@ int BPF_PROG(test11, int a, int ret)
 	*cookie = 0;
 	return 0;
 }
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


