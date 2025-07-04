Return-Path: <netdev+bounces-204146-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 038D0AF9328
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 14:52:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 998D0543A62
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 12:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A8912D9EDB;
	Fri,  4 Jul 2025 12:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NljcD97H"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86A72D94B9;
	Fri,  4 Jul 2025 12:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751633562; cv=none; b=TGP7otCtn/Jvv3mILeHJQmWhoN6zlOWLeK4cwmZc2PLvjnocY559KmMRAUREgROJJ81YqWuFIsXNAHUpWn/6O3rpL8kNjVLPU/JQ7OeWiTSCu0Ff4SgRTf/hWBX/9TMI9aCA2NrhZwquj6J2ALUx/UeYISAQVf00ldtgRJmtRGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751633562; c=relaxed/simple;
	bh=c0ayyYPG+6L6jSFBRrSSs/MMnb/OVuujyQj4eLgzJqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SxuiI41L5N8fN+pC6BLWc4NPdIBjhISv7d2sPdMK0T11PR9BlLlQDnzPcxuoFlYc2CaPTr9BGiTyPJIl2eDanu8mTlgx25i508iIvChuH5K5Qu0U84jncc9HQhmeIxjPypPzbLEqlLMOsyh27eUfTNCaqAdc3U8avgVxIOG822o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NljcD97H; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ae0dd7ac1f5so170559966b.2;
        Fri, 04 Jul 2025 05:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751633559; x=1752238359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Fnp24A+F18p2VXKqfxoHkduyIpuB09MSbIN1sn/af0=;
        b=NljcD97HfTSvJ9Vpit4R2M/dFIdoi6V15h5hdxNZtwb+NJIiEO3rVZ2mqApODpXmvf
         OWbePds1hmLEV8Yvb8HU0thiHqf+9jWwX52eTHc1h+/ovHtXQuKVpX3m7fKmtuLYdsEF
         tbmNyr7YofJzH50BI5txczXSl9a4fIlyznOJhNb57jyOF8EWEqff5a6bBBCpoNpnxA7J
         dp+nDJOJo0aaKjJoVopVNA3mvCLqyJ8PPO6hQYAEr8I9UmSV7BZi0xcgRe7pF4JtGFPF
         VIhscRQlyUw2v9dxslQMVjhcu6b8NyItLeZvNsQ0uplBB9wpXGeB2iHg2Pj4AWVG/OBI
         L6+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751633559; x=1752238359;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Fnp24A+F18p2VXKqfxoHkduyIpuB09MSbIN1sn/af0=;
        b=pIifS7Qu+e9iUUfqq/+kV/nTHzRytHr0BQbrwcTiWjI+42HgZ5aG2tbttpbRVkEkqq
         7opzf8wcm99i4EqEjHsbTfe2ecXPI6SqC+45as4YpC2nA5wdgad071HY9OJKQk/e3J+p
         JjbXTd80y2Ww1K+6jo/3BnOPKsC2I0JaMdpAaNhV/0byYCTJ3PV2iOO9b/Q+NY0uhzCm
         4M8it/PRB78D/hsDZXrgwQOptL4xCprZfxmR3hBT/0LE/UMEKzgWmhe5R2AfkV+nNrsr
         f0Y+8+Xz4ACu/4ZI5WyIrnVI+nZnZhL+mwkx/h6k2VbkuNH19fowyeiW342izwDNv2va
         4Jjw==
X-Forwarded-Encrypted: i=1; AJvYcCU02lY3o5TSdtJeZ3Szf/59mUeCz4sv1/SrphnmtwfOztpPRKhd5mfvzHrqgjiird04qDRgZ6qVNL7gqWg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwH3U/U1KR54f5gNKDjxfAvOi/OSMTBXeIDxE1F9VXM4Rxdslb4
	xsOFabdRoYPjBWbd4tPuE4lGO4Z8JIGSeb2GRvLjQCV/kbvZ5GtF95ffos0zCunb2dmUFg==
X-Gm-Gg: ASbGncvJi3vPnFBSy3nNJI8O+hd46bQ0XyyLkgpqGfxINjd44i0qCCcTWDqsK2aGKAa
	312XwMfGOhlYtY+6g3z0IY6LqoaMyj/j9zAQc7dwCad7n5IeKKAch4te2MFMLDbtgaiYGWvmrHa
	OKl9xusVBTI1TeDS7BLlemjQhT2nKhSMbCXsuowOxXPXm96Ct1oOdlbrd9wTPjgKKHLdK9qSBim
	56plTkHet2JQANWyyFy+sYM2qfY0XQ32jHhhT243hgW5GtspJN/8wAEFnldCieMKpwyxsisFQCl
	+QSXP+XlX1PtKsycfBjSDuMVpYDD8fKTs5VHIPNBjiXIHjrNFIR4aTpcFmwUuD+vv5XUHN/cJMz
	rTo584iOmRC34m26y3gPdA/CHiA/e2PaCpgpOs6lZOSPuivLmJmS/ciJh11zy4g==
X-Google-Smtp-Source: AGHT+IFVmbHZUSILaEE/lAxcLbnmzBB8SiuydGw2FFP3jin7eyGZLSoBl6WUDvTGJQwVu3yzJWY5cg==
X-Received: by 2002:a17:907:7249:b0:ae3:6708:941c with SMTP id a640c23a62f3a-ae3fbc2c1e0mr236415266b.6.1751633558609;
        Fri, 04 Jul 2025 05:52:38 -0700 (PDT)
Received: from legolas.fritz.box (p200300d0af416e00eb84418c678abf7e.dip0.t-ipconnect.de. [2003:d0:af41:6e00:eb84:418c:678a:bf7e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f6b64f5asm166346066b.162.2025.07.04.05.52.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 05:52:38 -0700 (PDT)
From: Markus Theil <theil.markus@gmail.com>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: davem@davemloft.net,
	akpm@linux-foundation.org,
	Jason@zx2c4.com,
	Markus Theil <theil.markus@gmail.com>
Subject: [PATCH v2 1/4] prandom: add usage comments for cryptography
Date: Fri,  4 Jul 2025 14:52:30 +0200
Message-ID: <20250704125233.2653779-2-theil.markus@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250704125233.2653779-1-theil.markus@gmail.com>
References: <20250704125233.2653779-1-theil.markus@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make it more explicit, that the PRNG must not
be used for cryptographic purposes.

Future code may also check such things in checkpatch.pl,
but it is probably hard to differentiate valid testing
code only by looking at paths. Therefore this is left
out here by intention.

Signed-off-by: Markus Theil <theil.markus@gmail.com>
---
 include/linux/prandom.h | 2 ++
 lib/random32.c          | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/include/linux/prandom.h b/include/linux/prandom.h
index ff7dcc3fa105..63d1fe4b30c8 100644
--- a/include/linux/prandom.h
+++ b/include/linux/prandom.h
@@ -17,7 +17,9 @@ struct rnd_state {
 	__u32 s1, s2, s3, s4;
 };
 
+/* WARNING: this API MUST NOT be used for cryptographic purposes! */
 u32 prandom_u32_state(struct rnd_state *state);
+/* WARNING: this API MUST NOT be used for cryptographic purposes! */
 void prandom_bytes_state(struct rnd_state *state, void *buf, size_t nbytes);
 void prandom_seed_full_state(struct rnd_state __percpu *pcpu_state);
 
diff --git a/lib/random32.c b/lib/random32.c
index 24e7acd9343f..c808745a4b53 100644
--- a/lib/random32.c
+++ b/lib/random32.c
@@ -1,5 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
+ * WARNING: this API MUST NOT be used for cryptographic purposes!
+ *
  * This is a maximally equidistributed combined Tausworthe generator
  * based on code from GNU Scientific Library 1.5 (30 Jun 2004)
  *
@@ -48,6 +50,8 @@
  *
  *	This is used for pseudo-randomness with no outside seeding.
  *	For more random results, use get_random_u32().
+ *
+ *	WARNING: this API MUST NOT be used for cryptographic purposes!
  */
 u32 prandom_u32_state(struct rnd_state *state)
 {
@@ -70,6 +74,8 @@ EXPORT_SYMBOL(prandom_u32_state);
  *
  *	This is used for pseudo-randomness with no outside seeding.
  *	For more random results, use get_random_bytes().
+ *
+ *	WARNING: this API MUST NOT be used for cryptographic purposes!
  */
 void prandom_bytes_state(struct rnd_state *state, void *buf, size_t bytes)
 {
-- 
2.49.0


