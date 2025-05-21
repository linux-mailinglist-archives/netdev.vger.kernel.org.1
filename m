Return-Path: <netdev+bounces-192160-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4F11ABEB85
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 07:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 724EC17C95E
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 05:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470C322FF42;
	Wed, 21 May 2025 05:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bGK2QMIv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE70E22D4F2
	for <netdev@vger.kernel.org>; Wed, 21 May 2025 05:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747806783; cv=none; b=Y9ztHtZZ7MNM5ZUbf4APh/Iv0i2MNwhmUFk7GAauA29mC3T97tB3LRX9KEBMAf6ejTOY0n+Ax+8eEQ0Dpe4xAYR4gFkzQO6ZZlPoC93UY/XXBrsuuzGXcz7hJHoe3xjVBjUNM2n1xaEnS6wsLkgneX4nyB2F8npYoiH5fmZmvkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747806783; c=relaxed/simple;
	bh=bw3WQB6kSQR1zc6JQgW/89lpk46txZA2ZfOeo3QKK3g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tvYfoGGlij6YQNkUD075SLDcmzCCmhY9URQFfslS+edh1kBHUKWYS+kMVdR1fqDMDH7syUiG6eYtuLzoqwjp/Pk0FmgOoYtDY3q1OiatIzCCAT2tF9YiaLWmW299h291XoZdHlVKNrD3ZOQd5Qmsh11jSDoMH8f+rdqf72Wb2K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bGK2QMIv; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-742c5f3456fso2752062b3a.0
        for <netdev@vger.kernel.org>; Tue, 20 May 2025 22:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747806781; x=1748411581; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BuFY2r/5u62DVQnsm0rMuIqkytzqgHDVbnhTLOAV/iY=;
        b=bGK2QMIv7MgZ2x5S7WRI3XuEtTpc7nOcjNw3oWqB7HYjKxqI28OLO9e5EG8Q1cGkiz
         1elru4Xj0A9RTvTaLs/jyvJkfB3HBY3V4VtrWtWtvExtNYUpMcpm7sNcWRUvCE71WKnD
         7ciUVBn+AG0pcarqCfa7y2edzKntGTutfyI73Mze06InQw18alGAE2s4CGPRtUBTJuOM
         of8QoyZ52T1SEubvYBHre2wGKqQ0R6QkHzo5gIv1p120ytSDV3qxLU8xZ8xObbKvH2sx
         1MJK0sEKe4+Q4tyf4d8xoIRZyvzYomPgCuY/KgBn91sr0CnJJbxeXnCr3T+kXkhko834
         rDTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747806781; x=1748411581;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BuFY2r/5u62DVQnsm0rMuIqkytzqgHDVbnhTLOAV/iY=;
        b=ed7GfxhY1NtJnL9kq7TLoorJAl2RL9apLgKDqkyFnC8nUrnXpgTfjJJPFTElTuvMKG
         jIWTXDxf/dvrJSKZSigfT6ZgQ8rE8KOpZF5shT/3VEXq4k9sgKRTLVJMHwn1B2IDeBZM
         6/pUDFo2qkmaYzPHZ3mmtlIbOBovIpX8QbZAr/pcAU5Dd8UkE0nQUMAo4fjMqKiI5alU
         OhmtyThmVmWscYiPS2AIZssfFChWGWWb1Yuw8nRlZfV9BM6FqLb8mF0wNgWNdyo5MIs2
         z/impu4F0rkBfG8DaCqY+5eaIWMVaej4x1YG9ebDHo3KtgJyDSoorGY62urBFy54gQgA
         w21Q==
X-Gm-Message-State: AOJu0YxXFgvSxguT6QfwBQJ3FZf5KIVHB5dTImzBV+2MQ1P873SESMap
	s9ozdlj+BmPdoAHZrkI5LuRwyZfhn3m+KeMxqgz87WFL+L2Mh4jkrc5h62mdgmx6
X-Gm-Gg: ASbGncuSUetWC7rvCa98Dnv1GaNE1UpMN6HdjiyPqya8SRxx8k2Eb+gWPGa+6QZ6MRX
	bV9skGOtURMu7248vV7o34zUBxlBItIeIEkZXomsmzxA6g/CKPtMio+OaNfBv5AwwrH0rOIMWz/
	KRgTZ/olLS1z5oa+YMieEIOkybhUcxGs/Ig9fM5Phh4RK6xGM3MHNnXXVCpd5SLIAyJBerNfDSt
	TXJ7YIaTGHop5/t+HPzufIockhmnOyiPI/XMhkzc9xn6RCAHfgzDzAUMmujaX/lYMaKJol4BiVS
	6i2WcZD+z8GUx2V3MR3J1Tc34ShGFk/Y3UpBtjnkyoNsuViNJ3G2FKiBTZS2ms47y3qHKQbkcXt
	O0g==
X-Google-Smtp-Source: AGHT+IFdRdaiSh5Z3Ukdxtm1ZEvvF17Od3i1UtZ4NRG6iLTnCR+pq8vK3JUCIMlm9kl/z9BpuNcaiQ==
X-Received: by 2002:a05:6a00:1256:b0:730:75b1:7219 with SMTP id d2e1a72fcca58-742a97df604mr27961325b3a.12.1747806780700;
        Tue, 20 May 2025 22:53:00 -0700 (PDT)
Received: from shankari-IdeaPad.. ([103.24.60.247])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a970c6b1sm9188428b3a.59.2025.05.20.22.52.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 22:53:00 -0700 (PDT)
From: Shankari Anand <shankari.ak0208@gmail.com>
To: netdev@vger.kernel.org
Cc: allison.henderson@oracle.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	Shankari02 <shankari.ak0208@gmail.com>
Subject: [PATCH v3] net: rds: Replace strncpy with strscpy in connection setup
Date: Wed, 21 May 2025 11:22:50 +0530
Message-Id: <20250521055250.3090172-1-shankari.ak0208@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250430181657.GW3339421@horms.kernel.org>
References: <20250430181657.GW3339421@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shankari02 <shankari.ak0208@gmail.com>

Replaces strncpy() with strscpy_pad() for copying the transport field.
Unlike strscpy(), strscpy_pad() ensures the destination buffer is fully padded with null bytes, avoiding garbage data.
This is safer for struct copies and comparisons. As strncpy() is deprecated (see: kernel.org/doc/html/latest/process/deprecated.html#strcpy),
this change improves correctness and adheres to kernel guidelines for safe, bounded string handling.

Signed-off-by: Shankari Anand <shankari.ak0208@gmail.com>
---
 net/rds/connection.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/rds/connection.c b/net/rds/connection.c
index c749c5525b40..fb2f14a1279a 100644
--- a/net/rds/connection.c
+++ b/net/rds/connection.c
@@ -749,7 +749,7 @@ static int rds_conn_info_visitor(struct rds_conn_path *cp, void *buffer)
 	cinfo->laddr = conn->c_laddr.s6_addr32[3];
 	cinfo->faddr = conn->c_faddr.s6_addr32[3];
 	cinfo->tos = conn->c_tos;
-	strncpy(cinfo->transport, conn->c_trans->t_name,
+	strscpy(cinfo->transport, conn->c_trans->t_name,
 		sizeof(cinfo->transport));
 	cinfo->flags = 0;
 
@@ -775,7 +775,7 @@ static int rds6_conn_info_visitor(struct rds_conn_path *cp, void *buffer)
 	cinfo6->next_rx_seq = cp->cp_next_rx_seq;
 	cinfo6->laddr = conn->c_laddr;
 	cinfo6->faddr = conn->c_faddr;
-	strncpy(cinfo6->transport, conn->c_trans->t_name,
+	strscpy(cinfo6->transport, conn->c_trans->t_name,
 		sizeof(cinfo6->transport));
 	cinfo6->flags = 0;
 
-- 
2.34.1


