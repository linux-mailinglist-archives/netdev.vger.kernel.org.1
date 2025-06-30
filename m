Return-Path: <netdev+bounces-202512-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF2B0AEE1AD
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 16:58:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4F113A4C83
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 14:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E3128F958;
	Mon, 30 Jun 2025 14:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="chPTbocR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059AC28ECF1
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 14:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751295368; cv=none; b=AiTWsaDoLKX5HekJfZeRxJfNU2DAyXo3mDSHt41/u4qQQ6cEibXKeJ13tJYTyBjXWg2rk6XU4JYBEjt2YoAWa9sKzwEdC4Rh4Uv6HWS8XTUTdi09nRKgslUy59nDBdOBVVr/i9NRFBooS3C1685B2utDnWFe8W+dXn7WM/oGT30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751295368; c=relaxed/simple;
	bh=5sucfcekR6mfS933e2rJSPc+7Q//wV1KFm98S+aVSG4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Aja1IFAABkrn0Ru4SYxZOI6qzVRgNDIKv1C000jT6V/uWfiDRzalBydjJg/oem9mVHs3iaikb9szI2787PseCP9Hle8d1oI4HC4Rmjm/rBIur99GtyfuMQweLdcKiohbT5CG1hbA4xDDXHqljvbSuQ4sxNbGhOM+nZGiGYf6Mpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=chPTbocR; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ade5a0442dfso873210266b.1
        for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 07:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1751295365; x=1751900165; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mscKavLvXzEa+mVaH2owrKNriHucVI9xry09mCnttp8=;
        b=chPTbocR0HwIdBYSRgJuE+7infWWIg+2Jm2C+adjICkH8VniTmqZOO+/SU2hkM9EFY
         CrLmzH7Bs+LD0AKh1ecdd39CJKtIGsKjFXO0WsueUaaxxjKMH0yAeGx85y1V2O+hkGwh
         V0oeZbO3UcVoZCGWGe2OB7jovkEZ+ByPi0lWVWDvd6hfU7Qcy/vlnqn3AUlGxy7RQ7rQ
         E8q3GT4bJoZhpeOdLb4CW9V0rR7RqUx0nEADvuTSPnbtUmfzXm7OdLBmxCmiofudh7AQ
         8yrRsLBxYQLTrgXiaAMzOOOeumTMiU/aI+en6Shw/96R2s0nVshRQP3kamnR82CEz6Ul
         zdnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751295365; x=1751900165;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mscKavLvXzEa+mVaH2owrKNriHucVI9xry09mCnttp8=;
        b=YWyesOQ9sRLkFXWI8bCzNPTSmjz1DnSdaFuqMcwqkJoMCmQuEzstlB3tj4gEC5wAnN
         FFA72JoLNETM9BgH3kvVJ16dQpVTkJ+AUn4+7Yony3VQHz9X/zW8QjcjS6jGhezOAla4
         Ri7s1BraIYAbvvRxJ+SENQTByg8QxEgT7d8FD6KhkGFAI6wSCkNfDFz81C9ZKBzZNraw
         D4fKatvckchAkNfzV6+9HO7719Jfa1dcCSiOTTnbwKAB7+Gh0RaC5NdoqiC8B9jC6P8M
         hpW0K6b0sQIaSlBdYC5qEF1vjHRHLIfABgrCJIHRH+ja44DtfUSvORf46qVmnaUQd3ba
         l61w==
X-Forwarded-Encrypted: i=1; AJvYcCVzI7imSAn+VaBYl+RXuPBM0pKXC2B8La090rhRx/csxXgDy372m9aefdlfpXEEGYvmgaK4Qwk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGNtUUEC9Np0tpTT7l4+HPuY/WQ+Ni1wmDHZfuuyjh0agvBqjI
	bgH8Z2YG05iEGGPj8tMYLvxgBhPkMeTpPsUoFotL7mX3uKvb6PjBElrVRvcSOd4YbWE=
X-Gm-Gg: ASbGncvGMGHfNasUnKpjKVmrkwrEjeCApf4BZz14e1Cv+TSgEk06WYIYaSkuZdLskIM
	RXgQYqWDmdqoAqVGPXZIcrKgXgQjXF5YCqCVVniGJOmA7eEod69gEfG379+X6CpEmzlhV2kf0T4
	oboCWvdGrsA45BHAcE/al2zkSrfS6jVMi107zWaTh9h+zBIb4+8Gh3oUUYBdRP+WuW2xFgCTQmS
	broTQkNU9e8gjrjp+UjGP30flapHJstzWUEAbd8WBMlrJAD/D5OXswpllb4ieFVAymSz3d/6HK8
	78qHyvpysoj6jQSznd6e0Vpvh6dsba1fGL57cedRnVIDxY0bT8PUHA==
X-Google-Smtp-Source: AGHT+IFMtKkuhlMOPZFdG2gn6/shinVOTDssS92UjfXm2++QWcpGt4UQ+CgRgyielTZ7kuWIU6qD1Q==
X-Received: by 2002:a17:906:eecd:b0:ad8:a04e:dbd9 with SMTP id a640c23a62f3a-ae3500f377cmr1268979266b.31.1751295365467;
        Mon, 30 Jun 2025 07:56:05 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2dc::49:10a])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae353c01641sm692687766b.77.2025.06.30.07.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 07:56:04 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 30 Jun 2025 16:55:41 +0200
Subject: [PATCH bpf-next 08/13] selftests/bpf: Pass just bpf_map to
 xdp_context_test helper
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250630-skb-metadata-thru-dynptr-v1-8-f17da13625d8@cloudflare.com>
References: <20250630-skb-metadata-thru-dynptr-v1-0-f17da13625d8@cloudflare.com>
In-Reply-To: <20250630-skb-metadata-thru-dynptr-v1-0-f17da13625d8@cloudflare.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, 
 Arthur Fabre <arthur@arthurfabre.com>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
 Jesse Brandeburg <jbrandeburg@cloudflare.com>, 
 Joanne Koong <joannelkoong@gmail.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, 
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <thoiland@redhat.com>, 
 Yan Zhai <yan@cloudflare.com>, netdev@vger.kernel.org, 
 kernel-team@cloudflare.com, Stanislav Fomichev <sdf@fomichev.me>
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


