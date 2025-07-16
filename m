Return-Path: <netdev+bounces-207527-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A67DB07B0B
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 18:21:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1CFE188F47B
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 16:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D61A2F548D;
	Wed, 16 Jul 2025 16:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="FCl01u+a"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896472F6FB3
	for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 16:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752682689; cv=none; b=GgEsvUzEPpdGzF5cz73w91pLg+ackaGf8vyN3lfk14LrHYL18/dE8xbsugunbBNOy717CVI57TYNz0BugiZVfsEtXBrKwInnnnS6UnQO8FezpshZ3dx8dZDlTMO91vG2VKtiLu92Z4OIDF9C3o2E9tYx5crabcLvz3KQeZVpjlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752682689; c=relaxed/simple;
	bh=5sucfcekR6mfS933e2rJSPc+7Q//wV1KFm98S+aVSG4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dZ1N75n570h/Ynq2LtP/1dJ2vWrQF+o8HdXqKYL6UXSiNIYZermBCB4P5PkBfFdI0EM7db8kj/Tgl4p8dZ2SVIkOPAC7a7nSr5oMqXou3XgkxANW7rP+O4TTK4DPL5TLrqoh9LW4ha/jy0o5yiTr3PSnmLS7iKP/1/s8EeVlAOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=FCl01u+a; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-55a25635385so43040e87.3
        for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 09:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1752682686; x=1753287486; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mscKavLvXzEa+mVaH2owrKNriHucVI9xry09mCnttp8=;
        b=FCl01u+aZlQ3fjsjSqydgsAbBWLm8G6urtxaOJU1Pd6oSuMK2tfXoe8lDgdLVCvdSz
         1z0WYKbaaJpM8wq5P5/ce12dy15HGozP7h4s6jYvxZ+qv+se9vJOwX4jgfw1iNL4dALM
         Y/SzUlTgYhA59cs11yE04ryQ+jlAY5642MHXVCl4aDf9b9Rgf0KrfkpRbD1pNnby3GL/
         FHQlR/jSxketZAjiFIFI+Do0o9DtKkejFw33JoAY6WYsUt64qRsyfERK+6ePycUkdMvD
         PLc2BbMHhVuIN10tD7u7hSE57ZgJ31fuCmiluA1xVB/ukCfnHRWBLNAJjDEItxdfOGjz
         6+lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752682686; x=1753287486;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mscKavLvXzEa+mVaH2owrKNriHucVI9xry09mCnttp8=;
        b=btsqEcdy+e+B7oLocbPSIVZnj0YGZrOuIH9hY6XvH3qwFLeYVDvPug3xUI1P6cbeRJ
         bflKCPrQzOLmvfh+hYRu+NxRfGfmJ3Mt9Twz1EzoJiT+fnlGdXigZhfJ6sAZqNn4fez2
         /1TNekHgWY85CXX+ObMTubxUK1h/sUVx7emnIr46DWo+rrq/6eG/Y2WHEcDGmrIPORtX
         kY+gZ6DiyMJ28xG31LxSbu5Oqs3FQW2PPt56CbHv/XLi9dtowdRtEkzXDSHLYv5Iw03B
         B9LojwyTQuev8fc+T1ApGaoBezp7W3+dR5Y/hBwRHxUlRbj5xNG8wfQH1PnWOhw45nxD
         xVbw==
X-Forwarded-Encrypted: i=1; AJvYcCXMaZ2obYm85IlFo/pv4bbH96ysVO4FxwRImwGxhiI8kpxjhqUSmAmfsZ+x42A+Ww5fW20RhsM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ2Z3pG3N3tF9z19TAmVLbErKUxIVIqMob4CZzUsfmazJDtvp5
	KGebG8dDF6dThHt8Ouq5ONOAtqP1f1Ro/CJWi9NTAVNTRdZ0BP9fNVdVV8TlpSd7CzJW1lwCMcC
	4Mvf5
X-Gm-Gg: ASbGncvAkrfRCUt3rqAIRZ1nNvxAlxqc1dZt16nC5UcBkv+iLosQsVCGCxjfGupdw4Y
	HIemZ9R3mFL5//gLDOO0JyMzpIUt+ZErcc8WJtsN4vQKBfIARDnv5O3tzzliabUXRb5ct8eIxs4
	RcR3X20jTbp1/77ICI8bE2XGs9VqPoEKbsflYngY2qr22th8MW7uiBqRlo9+mqIgdxSSBLdgPLu
	qKEELZyR+7syGDhGwtSylogmK/8t9Iti9KB1auTraWfGnaqjEhfTRzIibVf98dbhCAoywUiTrRA
	l0woSCXT08YTe7cnal+mkoT/cUky3ehjUrzCsgu+jzg1ReL7Nk2hd4ijvN13AeQEKuMlpVDnej8
	dBrEs1wAGYO1TiioJAEdSqbfztowMsEOhdaeUkvLDnXUCBvN2tHCR/yONzcZqvGJ1Qnac
X-Google-Smtp-Source: AGHT+IFjtflamFoKYfoz1skfosfmwqnMg77UKVFe6w714iNatgB7qs8D23wsFN7sbP5g2fwixigK7Q==
X-Received: by 2002:ac2:568f:0:b0:553:2450:58a6 with SMTP id 2adb3069b0e04-55a2330100bmr1186433e87.1.1752682685644;
        Wed, 16 Jul 2025 09:18:05 -0700 (PDT)
Received: from cloudflare.com (79.184.150.73.ipv4.supernova.orange.pl. [79.184.150.73])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5593c9d0b42sm2703689e87.136.2025.07.16.09.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 09:18:04 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Wed, 16 Jul 2025 18:16:51 +0200
Subject: [PATCH bpf-next v2 07/13] selftests/bpf: Pass just bpf_map to
 xdp_context_test helper
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250716-skb-metadata-thru-dynptr-v2-7-5f580447e1df@cloudflare.com>
References: <20250716-skb-metadata-thru-dynptr-v2-0-5f580447e1df@cloudflare.com>
In-Reply-To: <20250716-skb-metadata-thru-dynptr-v2-0-5f580447e1df@cloudflare.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, Arthur Fabre <arthur@arthurfabre.com>, 
 Daniel Borkmann <daniel@iogearbox.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
 Jesse Brandeburg <jbrandeburg@cloudflare.com>, 
 Joanne Koong <joannelkoong@gmail.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, 
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <thoiland@redhat.com>, 
 Yan Zhai <yan@cloudflare.com>, kernel-team@cloudflare.com, 
 netdev@vger.kernel.org, Stanislav Fomichev <sdf@fomichev.me>
X-Mailer: b4 0.15-dev-07fe9

Prepare for parametrizing the xdp_context tests. The assert_test_result
helper doesn't need the whole skeleton. Pass just what it needs.

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


