Return-Path: <netdev+bounces-209456-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB7E5B0F96F
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 19:42:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2588217AB7D
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 17:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 184F823D291;
	Wed, 23 Jul 2025 17:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="ebMLZZTi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2811A23B618
	for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 17:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753292220; cv=none; b=I11bMldIvi64u2Ljai/6Xfybw7VGs1XVwLvM2HnBcngccCMcRyVb5xSWTp9sCSv7nSfxEFstFpRfAvabAdy6pt8n014VbNV2k97kZY9UjO+ASQS8OGNaYGgj/PkzI4fPPwX5mkSzD31/AIq74jaS3nJUFoFIhz+uer5L3VCh2rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753292220; c=relaxed/simple;
	bh=decGL3VBT2/U0Ugg7xS5kWS3Dn8x3on6I3bEYiw55/A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gU0ZkwWuyhSnQE2y/WFU3hooxOtw4FUBPufCdJXUsIzv3ie26TKSPdU05s/PKE2t30SeAgrg2+7qPFPrg357Gw/b6N7F5V+R+cBV3bbhETbiwfMY3xPoYDvMm8yXE80SsEkxJFLdM4c2C3WTqNMfdXYK+/P6Ien+SQ83EbL11Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=ebMLZZTi; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ae3cd8fdd77so18902466b.1
        for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 10:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1753292216; x=1753897016; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aOla5hHlXODRGZYkPKj5UUE/0WAIWw+09FPmXz5awJk=;
        b=ebMLZZTiurqg4f4Dxr+AUZK5vbMHnKjSInDRapWDG+YqynKfzD6IVfkPeWrTv0F4Na
         hPoc5rHfyhzH8/pZYyl4mZ3vNztTwpVTI6buWQZwmj4rPdwcn+a6ZhRQBxB0n0eUlDVf
         p55vo9WKpf1blq/lXxih2rwNnGypzW34zAPYqGsspOWVVJmO5kruo5PDdj/A8QGpAluS
         +hWgbJWRrdVsFIo4TQ2idS2wNHYtFTwRaSRUsJK00lVqDcpfgaD6YN/NEjTSAisSk3cc
         gmDql1IwxXAIm5SJMhCNJcM7HEe0xqwyYM5T21OTFx0DI1Auh+3gRHXWHpotiMSXNnRc
         rUDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753292216; x=1753897016;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aOla5hHlXODRGZYkPKj5UUE/0WAIWw+09FPmXz5awJk=;
        b=ZnpOR0PDKdxq2jbp/SnhWBF5b0Hs4MRWpPRYDC2ShJ1JTxlhw5/UrAx41EBkLhr/sX
         dc5ga6mM57rwIrMF7YS7onGwhmMjqm03ywV/hulzYONId8ccpIxCRf4crq/MfmNg7n8f
         vsx1Nu2WBQtUGlMNaGK8XkM+E1QzKimH61cXiuRG9o/IrlXrZy72vTyc9IrQwCnGlREw
         ZTjOrfv2TvKJN/rfSaDg6BNkgo6VWJIL3+vSY09z7CLOGYeN33iOXgVYaaF8XHdeH/0I
         AC8zSLj0ZrZ2JaG2aM7DXS++BJg0dSClFm9bv3ym4i4ILOiu6mx7LiNLizp3IuZsNrbj
         movw==
X-Forwarded-Encrypted: i=1; AJvYcCVtNxgmExxyzZ0YCOnteUj3U9vBqtH/Ywk+1GBCfj6ljEU5UoxKKrxjiZ8FxNePoB3inKsIkIE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5Uazp35vyJb0WjVAYrNSWYfSMdJ0GL7hPGFgC4vRhHuB80+bS
	wo0L7TnvV/Yw5K3rv1VasxFuL/yEwLjjO2NPc6x+meZRBxFgByO8YuZiVKYvkijlglY=
X-Gm-Gg: ASbGnct/gDC9F6mruXdCiPjcQF+Bqryrp+fiKqegMdClLLr8qBNsdzxFpCr/2DzX7es
	x1aYpN1W1TkHygfhQaDsviuVVi/epOP5pd4gsYUqkowz5YizxKcIpAVLaf0HefIYCth+hrlOmIv
	IqZhGzVy/a3fZ7Twq0NlVJcAdPT7OjUQslLgvnQvA1uoeEgSgIl+nBywOPSyA0Sg22GzhTm5eWU
	i2KPNOio4Thgc2MaE/ulR8hKV2IshB6PtkIkpruT1zA2SbSXOg9CezKNsmKA37I+2YS4PXkKrCV
	BcZ8LwkqCStKcNcCa2tVZbktQTcMNCWLv+IPHSBSs+PXmYga4hPlOgaFSWfr1uqS+ptoT0WOH5b
	n1hd/LKXnNT3Dnxs08TdQbfpKh8RpPk+m9Y16YQqlwWGtydXjQQimt4x/TveUsdo+5ms7DV4=
X-Google-Smtp-Source: AGHT+IGIaEVoYAPWws+OaSvtcM3NEqzinR1DTpdLJCoC1/hM7MtJ5rVPIaWSAhF16Tks23WeOY607w==
X-Received: by 2002:a17:907:9452:b0:ae3:4f57:2110 with SMTP id a640c23a62f3a-af2f9273273mr431862766b.54.1753292216376;
        Wed, 23 Jul 2025 10:36:56 -0700 (PDT)
Received: from cloudflare.com (79.184.149.187.ipv4.supernova.orange.pl. [79.184.149.187])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6ca7bca4sm1076548966b.107.2025.07.23.10.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 10:36:55 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Wed, 23 Jul 2025 19:36:49 +0200
Subject: [PATCH bpf-next v4 4/8] selftests/bpf: Pass just bpf_map to
 xdp_context_test helper
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250723-skb-metadata-thru-dynptr-v4-4-a0fed48bcd37@cloudflare.com>
References: <20250723-skb-metadata-thru-dynptr-v4-0-a0fed48bcd37@cloudflare.com>
In-Reply-To: <20250723-skb-metadata-thru-dynptr-v4-0-a0fed48bcd37@cloudflare.com>
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


