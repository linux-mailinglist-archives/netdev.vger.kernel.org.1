Return-Path: <netdev+bounces-237777-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB777C501E1
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 01:19:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C3743B275A
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 00:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFCEC1DE2A5;
	Wed, 12 Nov 2025 00:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="Bza38wBF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380E31C84B8
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 00:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762906689; cv=none; b=DFDrPWqyL3FVFrLkGBV9FPD+VJw67xGjGMoHyySLT0VKI8bwvnObt0SMA+UUHGIT/Y24HgR6T2veqDtEU42FAkF5R/TkQUlcIgUrkeAJYm5HdPYKyusYZWrj+WEfpIiznXJFGL6KuDNAz8gPoUFyNafmcKXgHzR1DGzsQfvZnro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762906689; c=relaxed/simple;
	bh=kUrSiXw+9BASOphE8896OeaX0ILPFEG/1yBCQcdTw+Q=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wgb8nQeiBxZ2I1Pz/VxxBvwQCs89f2dAWgh27txd1Ldw5Y0ifSvtDee4BV/Df+jJKnR3qfBQbj64SoIWeqi2DW1UxNQn2ic5PzqMIQFXr+74KzMrkAwh72DXYWgAeQyUHQPeDHzgXJ2f9FnY8meNlW2R6zPWExrrEvlMZSFuHKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=Bza38wBF; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7aace33b75bso250845b3a.1
        for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 16:18:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1762906687; x=1763511487; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IRfdslyxqvIb4bjNZjJVEK1Cw+XE/zO+WTGcOzJubCA=;
        b=Bza38wBFb4ARTA1YBhWHJkeuYZA7qwNa90uBkrcD/rtmZz7t1p2xmffTMFQ/sBQAW5
         vl0Tr52jMNfWI2XvVD86C0IzRaQIQ75XAEWhIP0lNTYHwh2n7z+zFu0E8D+wlIDrrp7D
         SCDQ2Uny2C5TzrZV/1mtalLPuVzOO5h75kA1CmAteGCUTj/B04nyZ3BNF1w4IASB/xrO
         RR/B64zN2x5vp82UVWEkO/3huYraG0rw0R4VGkK8GvuAeZz2+wtPngL1AtlIJK6RYm+p
         WKPQJcKq0PKVyolYIEQZr6/P7EFgG8SDX0Ep5IKJcylmnHb17m4HlrbM1ma8loXPaK1p
         KKlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762906687; x=1763511487;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IRfdslyxqvIb4bjNZjJVEK1Cw+XE/zO+WTGcOzJubCA=;
        b=oEEUJ9jp5d083tH6YwPKtU+oU1wRHR3HxY75ogfLwraU1C8ISFPoM+t6eOiV2XYWt/
         YnZ6vlBB8ejjhCsVF4t1Vu3sd0yaTKdcUGxzY/QTsn9BwnrdfQw5ubBbO/Ow+gikKx9j
         25tUt43UoSfIvPyhgzFRkSGxV6A0Qx1C9ZsBESgl9MFvxIXGypNgLSz2tnfi2rO8iNLl
         qBRk5n3vVvwhyKtwieKyNaQWfpDO5Ltp2A/nVB3ayS6MLzWJEJe5385+hpBbJrOrLH7T
         ezYtv0Hu/PV5yi7V6D3oLXJT1sQGls/sDorGJUPNoA+QTEm086nQbvDRbiE30ptktOyH
         cHkw==
X-Forwarded-Encrypted: i=1; AJvYcCVJE2CcQkbTMO6JcE8SLRtcpIHp5yLYHhSzYDxrwLv+8baSzelp0W8rt2AUaDPak/HYfF3XJIE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhUAnqdD0PssnMbFCJbCGByM78Mj2E7MnM3SXXDrpuaWBRmGvt
	fvB66af2CKvk7FgyyoNDQzBf1ON3Ddc94zW54qYABhXuP5Pb7GJTZZf3yUKZz3jByFakUZi0QgE
	piJwXZA==
X-Gm-Gg: ASbGnct7f+Mu97LUhR2qnmrig6R/ibGQkc+7jgoUfpfaODt0mz3XaNhcm/MJMBw6+W0
	n4UzEa7y+wpTpArgIFdue5BTqjCQ4kLqO+F3bJ3s3FfCtm+IyuYJXHMbU16Hgd8+qiW5fEFdrzF
	8BatjnJYGE/nQEjmqFzIOMQPvEu6+dLStJEXn1tV6zaSaWbDs7wfPa20w2YTWUkGWalAD0NyJ3D
	zdqDfqvUpKZNtGzTvswOshBrMgd9lO1HecP52eXEX7HHGmrdwBqRf79ZVHSy7ZJ6c3T6WFJ6+X2
	iK9K74h/sn//UXU3KIpWP9kXQSZMfN10KQ4MS4JsfWtxld1FC1L0t5qlkAi8IXRCdqidYwKfstB
	oqOc3TQtaZzYm8p1RkCyQew7e3Efge3ib2NpljwlB9DXZCWyZnQBUeavn4lZNqXP33RyX4e0+fQ
	ftYSaieOc9GwG8dghlExy6E/uWA6qiz2A2ZXZM4TdyNHc5LA==
X-Google-Smtp-Source: AGHT+IHmI1R4gs3Q3bcaYl40SAePPr3k/kHLti58OfZIp6L6aMKJMgVxLzvviCC1uAOzpRhSRfZTMw==
X-Received: by 2002:a05:6a20:4305:b0:33d:5e7b:2f2b with SMTP id adf61e73a8af0-3590b524197mr1129898637.44.1762906687190;
        Tue, 11 Nov 2025 16:18:07 -0800 (PST)
Received: from pong.herbertland.com ([2601:646:8980:b330:8c01:13c7:88d7:93c8])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bbf1782bed9sm754222a12.27.2025.11.11.16.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 16:18:06 -0800 (PST)
From: Tom Herbert <tom@herbertland.com>
To: tom@herbertland.com,
	davem@davemloft.net,
	kuba@kernel.org,
	netdev@vger.kernel.org
Subject: [RFC net-next 3/3] ipv6: Document defauit of zero for max_dst_opts_number
Date: Tue, 11 Nov 2025 16:16:01 -0800
Message-ID: <20251112001744.24479-4-tom@herbertland.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251112001744.24479-1-tom@herbertland.com>
References: <20251112001744.24479-1-tom@herbertland.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a note and rationalization for setting the default maximum number
of Destination options to zero. This means by default Destination
Options extension headers are not processed on receive and packets
with Destination Options extension headers are dropped
---
 Documentation/networking/ip-sysctl.rst | 38 ++++++++++++++++++--------
 1 file changed, 27 insertions(+), 11 deletions(-)

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index 7cd35bfd39e6..2acaad94c475 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -2454,20 +2454,36 @@ mld_qrv - INTEGER
 	Minimum: 1 (as specified by RFC6636 4.5)
 
 max_dst_opts_number - INTEGER
-	Maximum number of non-padding TLVs allowed in a Destination
-	options extension header. If this value is less than zero
-	then unknown options are disallowed and the number of known
-	TLVs allowed is the absolute value of this number.
-
-	Default: 8
+        Maximum number of non-padding TLVs allowed in a Destination
+        options extension header. If this value is zero then receive
+        Destination Options processing is disabled in which case packets
+        with the Destination Options extension header are dropped. If
+        this value is less than zero then unknown options are disallowed
+        and the number of known TLVs allowed is the absolute value of
+        this number.
+
+        The default is zero which means the all received packets with
+        Destination Options extension header are dropped. The rationale is that
+        for the vast majority of hosts, Destination Options serve no purpose.
+        In the thirty years of IPv6 no broadly useful IPv6 Destination options
+        have been defined, they have no security or even checksum protection,
+        latest data shows the Destination have drop rates on the Internet
+        from ten percent to more than thirty percent (depending on the size of
+        the extension header). They also have the potential to be used as a
+        Denial of Service attack.
+
+        Default: 0
 
 max_hbh_opts_number - INTEGER
 	Maximum number of non-padding TLVs allowed in a Hop-by-Hop
-	options extension header. If this value is less than zero
-	then unknown options are disallowed and the number of known
-	TLVs allowed is the absolute value of this number.
-
-	Default: 8
+	options extension header. If this value is zero then receive
+        Hop-by-Hop Options processing is disabled in which case packets
+        with the Hop-by-Hop Options extension header are dropped.
+        If this value is less than zero then unknown options are disallowed
+        and the number of known TLVs allowed is the absolute value of this
+        number.
+
+        Default: 8
 
 max_dst_opts_length - INTEGER
 	Maximum length allowed for a Destination options extension
-- 
2.43.0


