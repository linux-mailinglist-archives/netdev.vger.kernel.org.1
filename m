Return-Path: <netdev+bounces-211160-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF00B16F84
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 12:29:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C530B3BAAF9
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 10:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351F52BE65F;
	Thu, 31 Jul 2025 10:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="dp5LHohK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B612BE65A
	for <netdev@vger.kernel.org>; Thu, 31 Jul 2025 10:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753957721; cv=none; b=opiff3z87Jss/9L1hxMiWX1Mzn2IL8O2U08iB0bB2Mq9KN3w9i7hMP3SZLtLMrNOwkOmKdjLdXEzFLpGYfiGlLKWKQtTf+Zx04BJHOLHJG7X+GL0g0SxUNwvriEACj7qY+JNYaxYUNc+IYzBsT/iRr4XZ1dMZM4+edTU1GyoNH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753957721; c=relaxed/simple;
	bh=6lefPy4pLLhuIjRSarK/JZllaot0EAvW9lX25Tym5zs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rsmj3xLwbIvtzy8HvE4A41eWfh2axLV7z4EcL83OKRG1d/lMSgBvPonsK4emKVZgwHmR8KSKHJ1+zSnnKyWQ8cmjGXLuL96J9A5Z4QyeKqJjuC/UPa5T3993tc/xGxvT1iSR5Vj22nSbZXvywGq1ZV+30HyWns+lVn/+uWmWRtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=dp5LHohK; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-61557997574so1038422a12.3
        for <netdev@vger.kernel.org>; Thu, 31 Jul 2025 03:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1753957717; x=1754562517; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i/WU4t3bXNXHytiZBMYllM2g5xtPpYjdz0N6ykqxU6s=;
        b=dp5LHohKR+U0G1fH3lZGkvj+eF0bHulDYyNlxidmOfDZRg4DfbTgRsd/IdiYrvex9T
         I/NicZFDweA90hG65YLQtlcxpmuMs1lkAnY/iglpIgjvaybTIsfy0en50FyqWWe1PKFt
         47gcojGJZ7fcHjOxS4DFLms2m0uMNNwuMyDlNJujFVYVmiWq0q9987bjpCy463S5nem7
         9A3X+mdaJP+i9JNKADIZFyxihsAPa5GyUMc7RGW23eAmx9h4ghGy2Jq3zycv/V1kd9IX
         AsrIvdvstkKQoOdInOiv5Y/ql2+MfWCQOwjhuZnsSbJoJkR66u6PdSbtlhtGSne6taCG
         eOtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753957717; x=1754562517;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i/WU4t3bXNXHytiZBMYllM2g5xtPpYjdz0N6ykqxU6s=;
        b=jdCBZc45YIrpBLhBtWbNWzFZyr17A/1Xy+7CO3ijeYeH1LHIKMhghHB7ubaFrIuNqk
         fNPXafoGSOR/7iUezG8b+3FPw5GJ/uO9ElgdKSnCXOa+QKNI3Dds8HnwvwBWs1ZHyvyQ
         Xgwy7nLNl4I3aVIz+5dCe80iQZCojkD9vAQw+ss0mEX7iw0m+El3jCqEtYt5bAQCHiES
         xcNScOXG8hiaMhvZG16GYBdn6xsKTFOT+Gc5MPtFnSeN50vnbh94UshM70OtX9QcTzF8
         kIAJrds/ejNEZkp5o4Xq5CLqzDBBSihwkv8CIBR0f5FeMLP1Aix9RpTYDa/W+cOymwf7
         hN6A==
X-Forwarded-Encrypted: i=1; AJvYcCUD+lXZLUePhP4AQNC609T4Gxl11ni7jH65n5oJhZImShpHFghea6K1nOxcYxxbjQQhQ1E4Ulk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxS1dZTJrccLI0NInw8NQmTeQAEMNZc/nzN9Ugu6ABHOfmFi8FC
	UiiBIMt0zITayfZ8DyPdGAytP+q8EFT0o9yG0bOjkF1zZzxcCerlsreAjdmHJ+Iv5PE=
X-Gm-Gg: ASbGncuGAdDSEyI7fNKsJERGQX7DtRlkYG3Mg85MC88S8mN8o6dsLhiQ7e/cfaPplXj
	O8gtnfwUTcqCgkhFGoEKBVwFhrfv+ksF45i9yhE6XWxEgyK7TeKHZXBWAk+c3hcUGjKmfbjhueZ
	6MC201iA3hl3DXBubwvU7GYrb6dvJ9Hk/sdT984SJL6A2UH2lE1R6ZjyQCRMNcECWJ5RJpEHCyu
	jofq0LlQq27R6QwMNz6+3U99/NWUW6DGFn9vG3XK15KaQ4pUHIjlmcKLLuxi/WXJiOq2OxEX3Gj
	f550jKfX0qYJCPsuQcrh7vkrWy2MoTSYqtzMpzgegrQ8zycQsBxrZFqmNw8grrZQcT95JS1ADgu
	Gd148QVbj0v/3KR8=
X-Google-Smtp-Source: AGHT+IFNWFAIZ7FjSYT641utsgYLGRfOM8eGcuSz4a/x2fBUxZrKib/OSWy+gRe/u9Q7NzM6fw3zZg==
X-Received: by 2002:aa7:d612:0:b0:615:4227:3b2e with SMTP id 4fb4d7f45d1cf-615871ce192mr5437531a12.23.1753957717500;
        Thu, 31 Jul 2025 03:28:37 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2432::39b:eb])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a911451csm883003a12.60.2025.07.31.03.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 03:28:37 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Thu, 31 Jul 2025 12:28:18 +0200
Subject: [PATCH bpf-next v5 4/9] selftests/bpf: Pass just bpf_map to
 xdp_context_test helper
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250731-skb-metadata-thru-dynptr-v5-4-f02f6b5688dc@cloudflare.com>
References: <20250731-skb-metadata-thru-dynptr-v5-0-f02f6b5688dc@cloudflare.com>
In-Reply-To: <20250731-skb-metadata-thru-dynptr-v5-0-f02f6b5688dc@cloudflare.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, Arthur Fabre <arthur@arthurfabre.com>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Eduard Zingerman <eddyz87@gmail.com>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
 Jesse Brandeburg <jbrandeburg@cloudflare.com>, 
 Joanne Koong <joannelkoong@gmail.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <thoiland@redhat.com>, 
 Yan Zhai <yan@cloudflare.com>, kernel-team@cloudflare.com, 
 netdev@vger.kernel.org, Stanislav Fomichev <sdf@fomichev.me>
X-Mailer: b4 0.15-dev-07fe9

Prepare for parametrizing the xdp_context tests. The assert_test_result
helper doesn't need the whole skeleton. Pass just what it needs.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Reviewed-by: Jesse Brandeburg <jbrandeburg@cloudflare.com>
Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
index b9d9f0a502ce..0134651d94ab 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
@@ -156,15 +156,14 @@ static int send_test_packet(int ifindex)
 	return -1;
 }
 
-static void assert_test_result(struct test_xdp_meta *skel)
+static void assert_test_result(const struct bpf_map *result_map)
 {
 	int err;
 	__u32 map_key = 0;
 	__u8 map_value[TEST_PAYLOAD_LEN];
 
-	err = bpf_map__lookup_elem(skel->maps.test_result, &map_key,
-				   sizeof(map_key), &map_value,
-				   TEST_PAYLOAD_LEN, BPF_ANY);
+	err = bpf_map__lookup_elem(result_map, &map_key, sizeof(map_key),
+				   &map_value, TEST_PAYLOAD_LEN, BPF_ANY);
 	if (!ASSERT_OK(err, "lookup test_result"))
 		return;
 
@@ -248,7 +247,7 @@ void test_xdp_context_veth(void)
 	if (!ASSERT_OK(ret, "send_test_packet"))
 		goto close;
 
-	assert_test_result(skel);
+	assert_test_result(skel->maps.test_result);
 
 close:
 	close_netns(nstoken);
@@ -313,7 +312,7 @@ void test_xdp_context_tuntap(void)
 	if (!ASSERT_EQ(ret, sizeof(packet), "write packet"))
 		goto close;
 
-	assert_test_result(skel);
+	assert_test_result(skel->maps.test_result);
 
 close:
 	if (tap_fd >= 0)

-- 
2.43.0


