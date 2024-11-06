Return-Path: <netdev+bounces-142542-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4515C9BF933
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 23:26:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B55D1C2219C
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 22:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B62B20D50F;
	Wed,  6 Nov 2024 22:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Z3nO11cF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9482720D501
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 22:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730931976; cv=none; b=aTsdj1eAWWcR/xYyvEQJYg+59SCEM+oEkL1Ba9zkQ2g6kGgPQJO16m6USdkKtpfRrhVUADQnoUV/r+178Zxw1tW097KVCOEcaS4UwiKjCYQ+q5tE8RUkBntV9os8bMqsfQKoLphs4N79HOaxd3PQNs79ffo9n17VvUKSb19LPJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730931976; c=relaxed/simple;
	bh=F3Jf6178lEkVT7qfOFeM0G9qFcfTNALZ8gAId/Er1No=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=THlu+vZCeuwdYNsOYaxMdG75zFw+oe8hKaRw9eVMhR2HdE+XP3nvVMzPXaKDRyfe51a/OLOjNdiAWEs/PUL+OpxN51kOkyNwIFpwoTm/dxRFTd2XbcsKDCMXJh9Q24Z4RPP2PaJX3cF3+oWWNILeIy4GYFBYc/3E92c4Bp13a2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Z3nO11cF; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-71850708dc9so296684a34.0
        for <netdev@vger.kernel.org>; Wed, 06 Nov 2024 14:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1730931973; x=1731536773; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WQURfqhPucUUeIUEtyy8KbqCtKtkt2GXTCiZiainfhg=;
        b=Z3nO11cF9tfW7ufwpQcDvxzXVS5ifvTdsnOg53O0rnWnbZj/iy8HChM0XtiUgNEWAq
         dtewyIl0N2XHtdQYY6OOJDzDDGBGNVSb+0fEpGj5vTqfFWkwC4zy5aQ6WW5n01mXBqkh
         f+C71AX4vblDe0PcVm6se1H635UTEPMvB4xBCu8MWR0TEQ+oN42mt/+p/8fk6speKWTH
         Fp7pgy6Akr1DJVAHAVCuU7U9BcmlDVoAZR+5aeQjvKtTNg/KeUNpTOPRfQkFdS6XoFRy
         8dvXKwODcnhjOxeU7IKuOoB4xrYDVIT1DK3NXHSgm9Hz5q8byXqsGaSpnasQz31+Dp/W
         GCVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730931973; x=1731536773;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WQURfqhPucUUeIUEtyy8KbqCtKtkt2GXTCiZiainfhg=;
        b=S4j89SyESNmN6nFDacCvwUV6tUR9G0mxSOzHjbzFKmjartaqRxL3ddXlC1GGNNPwsU
         i3r0O91MbawOlMnZVp90JBf+aUgeonTQFkqZfYnC/cUdDfZ3cmOAGnqhL9YS5QJu5xsf
         22LI/n5BAbBcF+p4SfDjTHT7j7eHAUUXKwqqOKAehU3GysWugNVKrZpIgRE22DDyxxBp
         pR3iyigNyzOs+h8dV9RqrRP7MIoq27ggvMon824MiMFaLqlst49Hv+FgHZ6sJCRatXK7
         yaYOk8zWClDzc/bq8VM+0Dn47z+G+7EySKtwNioU0EqjApBOXIKQjNdN/i7vGlA8dEg8
         ZM8A==
X-Forwarded-Encrypted: i=1; AJvYcCUPWsP74lDJFhpR54YipQMCATvAuRIuXjRwXAWBN7ay5i9+0+aVIUrsk3/6dGW2KLfgI89YtGQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYEIRqpcyKgH+dsD7INWeq6TCvLjSOveRYGGqISN45wEqWL2cL
	bIbgpJRxYu13Xwgj2QYUr7dFDGs4Q9HgRrhkzMsUjFTt2ApJneuAEamUNaJ4BLY=
X-Google-Smtp-Source: AGHT+IEQaQ3C0XG+F64ORuRhBZ1F88CEEBOsMq5gHG20F+xqAQ4wz9tn7nHxBlJ/fWUNQkD77lolWw==
X-Received: by 2002:a05:6830:310f:b0:709:3431:94c3 with SMTP id 46e09a7af769-7186828da5bmr41249141a34.23.1730931973625;
        Wed, 06 Nov 2024 14:26:13 -0800 (PST)
Received: from n191-036-066.byted.org ([139.177.233.211])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b32acf6c46sm2536585a.127.2024.11.06.14.26.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 14:26:13 -0800 (PST)
From: zijianzhang@bytedance.com
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	mykolal@fb.com,
	shuah@kernel.org,
	jakub@cloudflare.com,
	liujian56@huawei.com,
	cong.wang@bytedance.com,
	netdev@vger.kernel.org,
	Zijian Zhang <zijianzhang@bytedance.com>
Subject: [PATCH v2 bpf-next 2/8] selftests/bpf: Fix SENDPAGE data logic in test_sockmap
Date: Wed,  6 Nov 2024 22:25:14 +0000
Message-Id: <20241106222520.527076-3-zijianzhang@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241106222520.527076-1-zijianzhang@bytedance.com>
References: <20241106222520.527076-1-zijianzhang@bytedance.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zijian Zhang <zijianzhang@bytedance.com>

In the SENDPAGE test, "opt->iov_length * cnt" size of data will be sent
cnt times by sendfile.
1. In push/pop tests, they will be invoked cnt times, for the simplicity of
msg_verify_data, change chunk_sz to iov_length
2. Change iov_length in test_send_large from 1024 to 8192. We have pop test
where txmsg_start_pop is 4096. 4096 > 1024, an error will be returned.

Fixes: 328aa08a081b ("bpf: Selftests, break down test_sockmap into subtests")
Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
Reviewed-by: John Fastabend <john.fastabend@gmail.com>
---
 tools/testing/selftests/bpf/test_sockmap.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_sockmap.c b/tools/testing/selftests/bpf/test_sockmap.c
index 0f065273fde3..1d59bed90d80 100644
--- a/tools/testing/selftests/bpf/test_sockmap.c
+++ b/tools/testing/selftests/bpf/test_sockmap.c
@@ -420,16 +420,18 @@ static int msg_loop_sendpage(int fd, int iov_length, int cnt,
 {
 	bool drop = opt->drop_expected;
 	unsigned char k = 0;
+	int i, j, fp;
 	FILE *file;
-	int i, fp;
 
 	file = tmpfile();
 	if (!file) {
 		perror("create file for sendpage");
 		return 1;
 	}
-	for (i = 0; i < iov_length * cnt; i++, k++)
-		fwrite(&k, sizeof(char), 1, file);
+	for (i = 0; i < cnt; i++, k = 0) {
+		for (j = 0; j < iov_length; j++, k++)
+			fwrite(&k, sizeof(char), 1, file);
+	}
 	fflush(file);
 	fseek(file, 0, SEEK_SET);
 
@@ -623,7 +625,9 @@ static int msg_loop(int fd, int iov_count, int iov_length, int cnt,
 		 * This is really only useful for testing edge cases in code
 		 * paths.
 		 */
-		total_bytes = (float)iov_count * (float)iov_length * (float)cnt;
+		total_bytes = (float)iov_length * (float)cnt;
+		if (!opt->sendpage)
+			total_bytes *= (float)iov_count;
 		if (txmsg_apply)
 			txmsg_pop_total = txmsg_pop * (total_bytes / txmsg_apply);
 		else
@@ -701,7 +705,7 @@ static int msg_loop(int fd, int iov_count, int iov_length, int cnt,
 
 			if (data) {
 				int chunk_sz = opt->sendpage ?
-						iov_length * cnt :
+						iov_length :
 						iov_length * iov_count;
 
 				errno = msg_verify_data(&msg, recv, chunk_sz, &k, &bytes_cnt);
@@ -1466,8 +1470,8 @@ static void test_send_many(struct sockmap_options *opt, int cgrp)
 
 static void test_send_large(struct sockmap_options *opt, int cgrp)
 {
-	opt->iov_length = 256;
-	opt->iov_count = 1024;
+	opt->iov_length = 8192;
+	opt->iov_count = 32;
 	opt->rate = 2;
 	test_exec(cgrp, opt);
 }
-- 
2.20.1


