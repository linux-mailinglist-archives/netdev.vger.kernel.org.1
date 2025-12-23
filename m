Return-Path: <netdev+bounces-245883-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C8CADCD9EED
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 17:23:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 675283019E0A
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 16:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B61335545;
	Tue, 23 Dec 2025 16:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nq7tIh2k"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80260279324
	for <netdev@vger.kernel.org>; Tue, 23 Dec 2025 16:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766506989; cv=none; b=mwgqUh6dH8YHsXN3Usl6W1CJfaRtxFfEb3cz+qIUo/YZh696wqXmxGgURdsAogs55PgpKfaO/fry1ZHMb8bTK0EwcvN0TecEkspCHEWEaFkzCIpiMsPUmYwH/xm3jFwR52/3t2y4BwJ81F0US8YGDFQGOEB+GuB42hFmUuP1uYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766506989; c=relaxed/simple;
	bh=W7Kmewx74CQUT/jw/IRpbzAwhK2jEyGtRXl+6mNIgrE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kMqRjydrMVbCK9NHhhIQ4U+U9V67mUq1iOBDv1kGs8xGaaejzCR8d/faIA2rXrv0fryL4+YzMfJr9UBEDkpCvZu4aq4LMAMVmxzZ+EXq4/KBVO3ZkK9dOpPLj6O4iQ8Sj9GJfv7BPnZE4V8CpjJR+iQQHPe1Hkubnfe/uIBb5Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nq7tIh2k; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-640c9c85255so5299530d50.3
        for <netdev@vger.kernel.org>; Tue, 23 Dec 2025 08:23:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766506986; x=1767111786; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bu9hANCrqcrzn01CQ6+qCySerDAxUYWA0/vX02ujpFY=;
        b=nq7tIh2kzYWqMiVm/Q8VV2UVz2XH0jrChkZxwqvFiCXxFP/xkSeEpLoRP+u0i9mV56
         fR603QXjP82JJw0/Q/uZEOUSQpwfSt3hmrD9UIMnCwiwagzGvR9yzQzAxa4dhbEMGx0T
         rizA829xQ2ErDAtt+N0r+YfbGqAqUZcv2HQ3CUQ2IYE6xUfVH0hXCI6HmmrjysCTukW4
         7B72ks7aNTcMa8nw8lNS9PeUkt1DHzRr2xoCmLFhGBQleB9E6T8gmDPTq5lC7wtR+s3A
         VpZlb/bCtmF44PDw7AfkK7ONSTqM95EsI53X2L4LewkVTbfW4Wi3R9PqyxivGqAsi+m4
         1etw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766506986; x=1767111786;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Bu9hANCrqcrzn01CQ6+qCySerDAxUYWA0/vX02ujpFY=;
        b=kIADrTOdnYXU4vEPTughry27pDqJNfpO2USsnIp54Ma04MujRC3TSEqiujFfaav3D2
         aINnJqHthXhNM8WPjTQ2brmj/ip16Ch5CLySuR+/NmB05BZjSWsfk0dx3Ko/A8TFiNdp
         TsAD1IvZFQor652sbIZdpUVmakrB7UeYcaFJxqkf+CKOR1LkByBMHwn9AVOjs5kn94mi
         F6EMwk31qG33noqgoGL22oLjGPaZM5W2KlsPQSwhWw5J7e7ctJm3GAwNx2T0bnMQew5c
         ELzl/TlEGUUbb2cLSX+JK2HCovsbZ5JmurLPdjpyhihcVGeLtI/ZGoI2pZkz7oECi9mX
         ImZg==
X-Forwarded-Encrypted: i=1; AJvYcCW8UYUcI87vm+JZ1t87cvCPwwYNt4RHEGmxrYwYpcPv9n72DvM+9H/cM50bCbqZfH4Mw+2alj4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkA4vjlwLJAgRpbgMpfRDIL0EOLF/HZDkHb56Qx1c09jHUS4Vu
	AI+Ld+ZnBVK/JQEkcwoStw+xLYO5TvMS4tl9W5KKDI5v0+UN24H8t+Jk
X-Gm-Gg: AY/fxX5nEF+nskaxGS2XVRthbSGD4nLcegXCANHETHW6AcJmkTp0qr3RTgSJmerI/Z+
	Ov9kXI0FMXF3fM/u22WzEyi9s238dNs5oVqWrzP4DbQVLph7zLJ5bwSLyGGw9d8hrwVmlDBY5om
	J7HiKGz6OVZITRQajZLICeee7mEKXA6kcImWrGDlzLDns8y3TbBZjAJdbBBKYueznjRSszSZg5b
	hrY2xI3oL5daU1Nhqk8E7OUpxdAjADi43CVejPsjtPgPQG5nKcXHDKotQXnNOGwgwUGGFaYSwbE
	c4DjABmiqOq1Cd8T4geEQmUXG424kyactTCWq2ksaqaK7gI69gQFAH/tusovJpz83xdnz4+xRK/
	doxrENQgbE4QnJY7z7O+0lgQFevlKDzVQ0rvYyuWGKrBe+qhDCQGCjdtpXtbA5vUpEeYbQV/gcn
	S+j7jwAAM=
X-Google-Smtp-Source: AGHT+IExQlcrRvP5bpGZsniR6NEoCL2BesRdWqeHSXBthxN++RkTXQKi6hOc4cN4HB6bL+lo8PUVtA==
X-Received: by 2002:a53:da86:0:b0:63f:9c11:cfed with SMTP id 956f58d0204a3-6466a842daamr9378345d50.32.1766506986363;
        Tue, 23 Dec 2025 08:23:06 -0800 (PST)
Received: from localhost ([2601:346:0:79bd:4913:14a4:1114:ff0d])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6466a8b16e2sm7101778d50.2.2025.12.23.08.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 08:23:06 -0800 (PST)
From: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Andrew Morton <akpm@linux-foundation.org>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] bitmap: introduce bitmap_weighted_xor()
Date: Tue, 23 Dec 2025 11:23:00 -0500
Message-ID: <20251223162303.434659-2-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251223162303.434659-1-yury.norov@gmail.com>
References: <20251223162303.434659-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function helps to XOR bitmaps and calculate Hamming weight of
the result in one pass.

Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
---
 include/linux/bitmap.h | 14 ++++++++++++++
 lib/bitmap.c           |  7 +++++++
 2 files changed, 21 insertions(+)

diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index 0f4789e1f7cb..7ecf56e0d3b5 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -169,6 +169,8 @@ void __bitmap_or(unsigned long *dst, const unsigned long *bitmap1,
 		 const unsigned long *bitmap2, unsigned int nbits);
 unsigned int __bitmap_weighted_or(unsigned long *dst, const unsigned long *bitmap1,
 				  const unsigned long *bitmap2, unsigned int nbits);
+unsigned int __bitmap_weighted_xor(unsigned long *dst, const unsigned long *bitmap1,
+				  const unsigned long *bitmap2, unsigned int nbits);
 void __bitmap_xor(unsigned long *dst, const unsigned long *bitmap1,
 		  const unsigned long *bitmap2, unsigned int nbits);
 bool __bitmap_andnot(unsigned long *dst, const unsigned long *bitmap1,
@@ -355,6 +357,18 @@ unsigned int bitmap_weighted_or(unsigned long *dst, const unsigned long *src1,
 	}
 }
 
+static __always_inline
+unsigned int bitmap_weighted_xor(unsigned long *dst, const unsigned long *src1,
+				const unsigned long *src2, unsigned int nbits)
+{
+	if (small_const_nbits(nbits)) {
+		*dst = *src1 ^ *src2;
+		return hweight_long(*dst & BITMAP_LAST_WORD_MASK(nbits));
+	} else {
+		return __bitmap_weighted_xor(dst, src1, src2, nbits);
+	}
+}
+
 static __always_inline
 void bitmap_xor(unsigned long *dst, const unsigned long *src1,
 		const unsigned long *src2, unsigned int nbits)
diff --git a/lib/bitmap.c b/lib/bitmap.c
index 698d15933c84..bed32b8cd23a 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -382,6 +382,13 @@ unsigned int __bitmap_weighted_or(unsigned long *dst, const unsigned long *bitma
 	return BITMAP_WEIGHT(({dst[idx] = bitmap1[idx] | bitmap2[idx]; dst[idx]; }), bits);
 }
 
+unsigned int __bitmap_weighted_xor(unsigned long *dst, const unsigned long *bitmap1,
+				  const unsigned long *bitmap2, unsigned int bits)
+{
+	return BITMAP_WEIGHT(({dst[idx] = bitmap1[idx] ^ bitmap2[idx]; dst[idx]; }), bits);
+}
+EXPORT_SYMBOL(__bitmap_weighted_xor);
+
 unsigned long __bitmap_weight_from(const unsigned long *bitmap,
 				   unsigned int start, unsigned int nbits)
 {
-- 
2.43.0


