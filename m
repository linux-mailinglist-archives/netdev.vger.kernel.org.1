Return-Path: <netdev+bounces-116566-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5998C94AF38
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 19:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A74F1C21A75
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 17:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC14313EFEE;
	Wed,  7 Aug 2024 17:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="b2m4bVA/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9EAC13D25E
	for <netdev@vger.kernel.org>; Wed,  7 Aug 2024 17:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723053329; cv=none; b=Ja7nMYpVLd3lwA+W7IgV7O8mQDzUnVcU58suov1ZjbpweQyxYsE5sVQnVkflwweshPN7m+Ky+LxbrG8h+i3j5jB3mpmAGTrp6qE7CT2kyxQ+EXaY6xYZxjTvSv1KO67pj+K6TcQN5iRgpdY0GRe37CmmoLAfsnx1RzkUKErz6a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723053329; c=relaxed/simple;
	bh=gWWdO5xBWX5tU7fXTnRIHBQdQkp9TESMBHiNigorEHA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Tm8JXmUsu03rhOcqPcabD6sCx7TVUPBYLc+aoPLm302MCwapkcRfVnQ5EInc7b9Ct4Pb9/4jnumUZqre4X9f37Rza1zfQOU6JqqhYbn4VSdw24rkQZlP4Zv9abl8de0yjb/DP+4aUli6BBAf0SNSAkWFhFIC+yiM21oUvkKF5Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=b2m4bVA/; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a7ad02501c3so9242666b.2
        for <netdev@vger.kernel.org>; Wed, 07 Aug 2024 10:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1723053326; x=1723658126; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W7D0AJSGl0P0jq0Bi/L5OZ1HP+papERMI7L86hsLZjQ=;
        b=b2m4bVA/D9r8LQT9EcdFGdYD40yAi/sKJvgwKIi5kkrSlZhr1C30bZoV3DNyRgOdmI
         O9CsQRxyn3/yxjyUlixgnqcM36wHWuKAa9dQa/2FLR0OuThgoEiLtkZ0sjQJlWMRMd56
         d8yBdXd9dgWtAfi9qcp/ZY7w510XoRFx/r9sylShaTpgw9sgT0HBuVTwxKJmAhZNtRME
         g5UrDXQFyLtYf2oUgo0urXF9SsEnoGRWWj1eSJdlPiClKfoe0qH6n5atjfqU6sFQpOfP
         gcuZd3yHpfWWcvP1OP6TchIKXsCso/xLCqpYy3EQSkx/bZqATqe1VaW/nDcODC2pmxnZ
         9u3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723053326; x=1723658126;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W7D0AJSGl0P0jq0Bi/L5OZ1HP+papERMI7L86hsLZjQ=;
        b=nWuorZ4c0+6/Muw7qHaYDDasYa9bsQ/BDRIEWkYpSlKLZgOQdCdavweB/SBiFMb962
         yZlqpvShvjFYv0Kj5XiyqXKJrR62dy294uAnio2s37MQRQKg0+Qf7jqPWKbxGCkk11Am
         su1Jv5Db+yL045uVK5Ismq83aRV5i2dh1FVmtwTtaOts4MgzkuPYUabX4TECYhptnFfM
         V5PCd6jTUvPmxXzGndbVIA4eGqy5ht0O5k37WMtijieL2Trq4z9K/lBhqdq4QyreMpuo
         eFa7TT4cNfWkzG8ml6A08tJhD8woNid273StCtacvrfjcf9nPweH3bP8iosOPj7qDnD/
         hf7w==
X-Gm-Message-State: AOJu0Yx22cTPghDtk5uGyMWEbocogohvS8yo+FiDQwdJO48Bn/ggaf/M
	OgluZppLnUuk/bMTSUMdknTRmEye6rm5eY4zTaJDPagmsLw/CCSv3hWBeXHjDvs=
X-Google-Smtp-Source: AGHT+IHp2jgvISaG8pBADYmKzuKQNcKydtleGTpYCgyTjJfNufmaAx8m5p8j8hG/hltuTUKERtyeEw==
X-Received: by 2002:a17:906:7315:b0:a7a:af5d:f314 with SMTP id a640c23a62f3a-a7dc51bd623mr1467070966b.63.1723053325937;
        Wed, 07 Aug 2024 10:55:25 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2387::38a:2f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9ecabb2sm654261966b.214.2024.08.07.10.55.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 10:55:25 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Wed, 07 Aug 2024 19:55:05 +0200
Subject: [PATCH net v3 3/3] selftests/net: Add coverage for UDP GSO with
 IPv6 extension headers
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240807-udp-gso-egress-from-tunnel-v3-3-8828d93c5b45@cloudflare.com>
References: <20240807-udp-gso-egress-from-tunnel-v3-0-8828d93c5b45@cloudflare.com>
In-Reply-To: <20240807-udp-gso-egress-from-tunnel-v3-0-8828d93c5b45@cloudflare.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 kernel-team@cloudflare.com, Jakub Sitnicki <jakub@cloudflare.com>
X-Mailer: b4 0.14.1

After enabling UDP GSO for devices not offering checksum offload, we have
hit a regression where a bad offload warning can be triggered when sending
a datagram with IPv6 extension headers.

Extend the UDP GSO IPv6 tests to cover this scenario.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 tools/testing/selftests/net/udpgso.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/udpgso.c b/tools/testing/selftests/net/udpgso.c
index 3e74cfa1a2bf..3f2fca02fec5 100644
--- a/tools/testing/selftests/net/udpgso.c
+++ b/tools/testing/selftests/net/udpgso.c
@@ -67,6 +67,7 @@ struct testcase {
 	int gso_len;		/* mss after applying gso */
 	int r_num_mss;		/* recv(): number of calls of full mss */
 	int r_len_last;		/* recv(): size of last non-mss dgram, if any */
+	bool v6_ext_hdr;	/* send() dgrams with IPv6 extension headers */
 };
 
 const struct in6_addr addr6 = {
@@ -77,6 +78,8 @@ const struct in_addr addr4 = {
 	__constant_htonl(0x0a000001), /* 10.0.0.1 */
 };
 
+static const char ipv6_hopopts_pad1[8] = { 0 };
+
 struct testcase testcases_v4[] = {
 	{
 		/* no GSO: send a single byte */
@@ -255,6 +258,13 @@ struct testcase testcases_v6[] = {
 		.gso_len = 1,
 		.r_num_mss = 2,
 	},
+	{
+		/* send 2 1B segments with extension headers */
+		.tlen = 2,
+		.gso_len = 1,
+		.r_num_mss = 2,
+		.v6_ext_hdr = true,
+	},
 	{
 		/* send 2B + 2B + 1B segments */
 		.tlen = 5,
@@ -396,11 +406,18 @@ static void run_one(struct testcase *test, int fdt, int fdr,
 	int i, ret, val, mss;
 	bool sent;
 
-	fprintf(stderr, "ipv%d tx:%d gso:%d %s\n",
+	fprintf(stderr, "ipv%d tx:%d gso:%d %s%s\n",
 			addr->sa_family == AF_INET ? 4 : 6,
 			test->tlen, test->gso_len,
+			test->v6_ext_hdr ? "ext-hdr " : "",
 			test->tfail ? "(fail)" : "");
 
+	if (test->v6_ext_hdr) {
+		if (setsockopt(fdt, IPPROTO_IPV6, IPV6_HOPOPTS,
+			       ipv6_hopopts_pad1, sizeof(ipv6_hopopts_pad1)))
+			error(1, errno, "setsockopt ipv6 hopopts");
+	}
+
 	val = test->gso_len;
 	if (cfg_do_setsockopt) {
 		if (setsockopt(fdt, SOL_UDP, UDP_SEGMENT, &val, sizeof(val)))
@@ -412,6 +429,12 @@ static void run_one(struct testcase *test, int fdt, int fdr,
 		error(1, 0, "send succeeded while expecting failure");
 	if (!sent && !test->tfail)
 		error(1, 0, "send failed while expecting success");
+
+	if (test->v6_ext_hdr) {
+		if (setsockopt(fdt, IPPROTO_IPV6, IPV6_HOPOPTS, NULL, 0))
+			error(1, errno, "setsockopt ipv6 hopopts clear");
+	}
+
 	if (!sent)
 		return;
 

-- 
2.40.1


