Return-Path: <netdev+bounces-116772-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB2294BA2F
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 11:57:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BC8F1F2292F
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 09:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B13D189F55;
	Thu,  8 Aug 2024 09:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="DweI1Z/I"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A309189F45
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 09:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723111005; cv=none; b=n8soyrUa73hNOARniJOc5EX3ktW315PN6T+rvouqggZvADPFK+frmEdu9nYVHVOoUwDJ/o3hJf4w3uUuhhiBCFM+yG/GgGE+CBX5GXKwCS57jkklKm8bpPGwzHuG0HNtTiGI+gqFOOuDHURytf6cqVspnZusF0l/MagiOvFYLTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723111005; c=relaxed/simple;
	bh=8BjMynsZaaj57fS5DI7aS9+ZN6eNmRHZXtcj7EopA0U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eH59eduryZ5G1XqOTjhj312fp4nzO6GKnLJ/upkUaQiV5beH7dHcX4mrKdH++8gFrahKNgs2RKmrh0mFExNw4pdZBsHjdUudqhLNDUcTL16OxdToVc4ZbSbByPWuEvR4E/nzmFxQtKhrgrXi/OZ9Yk/9ju5+oD3P9CKwUyyRCEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=DweI1Z/I; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52efdf02d13so1407703e87.2
        for <netdev@vger.kernel.org>; Thu, 08 Aug 2024 02:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1723111002; x=1723715802; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7vouzriBAMAKjajYgG7l6gvwiTRC39rAAvH0plnTP8A=;
        b=DweI1Z/IJ/607FBg8uU/oCDCxS5CQH/olfppAq7BvPLL6AQSr9M4iJt5J0rU8qNASd
         p3pVdqv1haxNmO8QeaubXWk05DBFDqasbD90C25LXRw81/JB2XDaga9iAw4hsTy84p80
         6CYHL6xQi1zCtXrNvxNqk84pLe+nDxo7K7oL6kznkFyF/yd3s4HOExZZglo3xVW/C5l+
         x+mzsBTeXiNd0VFAVOnxgUM8o1yfk24QUgivdpreZn+j9Yz+hrF9HF7pgHbOAR5ZXGVh
         jginHLNTd/spzCKjFbh9cYGcXGDWucDoTMnSCVxKqjc27gXfizJe0GTn/sQKz/Ua+jmC
         9nRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723111002; x=1723715802;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7vouzriBAMAKjajYgG7l6gvwiTRC39rAAvH0plnTP8A=;
        b=xLmjac5/YwsKQsRpZhw1UqvNfZY54/J4Xn0EvtvMiyU1Xezy/DhkYE6WyKkiPS99s5
         GSVZHzTxqY3etwikhv99VMfRMi0xc+rQtOu44WGSuh5Gvv6/zc6pfaTee39q9hicNd9T
         IOB+1roUpOa16BfWXMzE4PN2LR9vFagn+Ff6uIE23W6SBFQ92wEExD+hEFpeVRA3j4bI
         xaMgm9YhptRy29D9mWMdKocr9+qEvHCRJitrOzdQpZ9BuJL6D0zowoEZ6lSONirnuR/d
         j6pJdMc/i2kXvtFz0Eu+7AtVjOIpWmCvgfDXci4jhtCO/50Fr12fkbpPaYVfakzwpafZ
         RPtQ==
X-Gm-Message-State: AOJu0Yx69Qpnk5dvfDgnSGn6vLIfCXchanrxXQtW0e483OOyaykBspf1
	1MYqe/6AXnoKzjhknCJraPQae3NlvaHUp8fzV1vvXnmVKN1GOzyGC+e420gYca+5HNC1A/OyOh6
	J
X-Google-Smtp-Source: AGHT+IHhfQZ/HL5WMZatt0cvM7cD5/mZYPamjME+qzJzm9uhTX19KgvTPZWfSC741/LWItVbKWNm4g==
X-Received: by 2002:a05:6512:3b1f:b0:52c:8b69:e039 with SMTP id 2adb3069b0e04-530e581224cmr1195510e87.4.1723111001632;
        Thu, 08 Aug 2024 02:56:41 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2387::38a:2f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9c129e2sm718398266b.82.2024.08.08.02.56.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 02:56:40 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Thu, 08 Aug 2024 11:56:23 +0200
Subject: [PATCH net v4 3/3] selftests/net: Add coverage for UDP GSO with
 IPv6 extension headers
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240808-udp-gso-egress-from-tunnel-v4-3-f5c5b4149ab9@cloudflare.com>
References: <20240808-udp-gso-egress-from-tunnel-v4-0-f5c5b4149ab9@cloudflare.com>
In-Reply-To: <20240808-udp-gso-egress-from-tunnel-v4-0-f5c5b4149ab9@cloudflare.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 kernel-team@cloudflare.com, Willem de Bruijn <willemb@google.com>
X-Mailer: b4 0.14.1

After enabling UDP GSO for devices not offering checksum offload, we have
hit a regression where a bad offload warning can be triggered when sending
a datagram with IPv6 extension headers.

Extend the UDP GSO IPv6 tests to cover this scenario.

Reviewed-by: Willem de Bruijn <willemb@google.com>
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


