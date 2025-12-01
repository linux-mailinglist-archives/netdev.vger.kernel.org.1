Return-Path: <netdev+bounces-243046-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 745EFC98C9E
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 20:00:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 46BE04E19D8
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 19:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C3023EAB7;
	Mon,  1 Dec 2025 18:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="DYat/0IL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EBF8239573
	for <netdev@vger.kernel.org>; Mon,  1 Dec 2025 18:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764615592; cv=none; b=avIkCS/u4lcwB/n2J5BjDCbiiMsHL5hH4nWtwtvW/2nanc4gSNr4hrqaOHC6kcKW5BHNpeTFLz6crjMveL3wAbECOYdQwZxhY6znNZaG1OTgB00pFwEPYs9MmXbY40TRpzzP+SlTNITmtyXAhWSR8WFL7h6n/XLL6IDbLd2z66M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764615592; c=relaxed/simple;
	bh=p0Y7lNUGLTwWUnHexkcLJoNt8eMJVbTpj8weXllBHsM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sG5jSOGB/9AmKReSyfDeO6ZZs6FV7Wm4WBnMeo4wGOlZREHh+K5pUx5fxa4cWvu0sj0oZpp/Ddfi78Cl9CaKZ9r3RGr2u3uCgFj3/5AT9jXwRadqv9yges6iUM9+qkJeDuTHlAopMtXIFBsICqfhH0zuVTsG43293lTs/XqwEGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=DYat/0IL; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7b89c1ce9easo5523844b3a.2
        for <netdev@vger.kernel.org>; Mon, 01 Dec 2025 10:59:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1764615589; x=1765220389; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x2hYElrrCSC7yXICEv0DOBHiNHdKQaLW/AjAmjIuh64=;
        b=DYat/0ILWx+SLCs7YLtZunoMnTFUF407IbpKalQfJwtvnqV5RfD8itTaqsRX0A6V8A
         vHUG6Ts7VslVIeWcBIietSz3ufmwTtHvWuInJdBrhi5UGKqwv/HEQMm20BkL8GS1Aw+/
         HIvWwXfcT6674BpzjuI9i822R8OOUyJO/6iVWtZtu7jI10FEwwvOGzoYGEOZWxGc1FH/
         P65qh3PygCpg4zJy1V0s3q/a10HJVnXKfaq1iaRIxlsoEzA/8G/3zWoSP9V1n2iA7aqi
         5mKg2/ItBBWT7OhbvUJ8xN/jvsr8t1Cg2pNj1mXvnfwhyQ4i7sPMw8QTuMikW2ifvia6
         lOYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764615589; x=1765220389;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=x2hYElrrCSC7yXICEv0DOBHiNHdKQaLW/AjAmjIuh64=;
        b=l9m2zJW9suf3OXO0os0Qe5a0u5arahOZVuc7cPP3gDnEnUbgVJrxUe3Un8g2JcIm3u
         c0vywmKgPTvSEXO9/jPxxKlPFAK1fLVz/RRAQkEeWQM4XeWy+dJlZHSsfokrtlfT3fqf
         5uY+EhVpHLgT3Wke9yw962MGPRavIM6/m2G/8Sog5hQKop8+NQXWWfCigYqC0lX/1L1T
         yhzIbWfbgFpEZaNL2bow+abgvBEk1zjQ1PeoyyU8fOOfu+QzHKQyWtaU/0Iuv9AsFQYY
         FrHH59Q37baUbQYaoLg4WGNUBCM96X/x1Zr5URQntuVRY33gSYYzshMODoHMkMldkb8/
         Of5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWaH337R5wdVJNQt2cKC4k/r3q0QlCp65T+jPUO4VGD+JN5ki3VSVDku36S3MYxW+Txicqe/ZY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtlbG5scW5ISEUMxIRNqtSpyMlbxlr3x+lfMf6o8wrkeQJpSz6
	iG5afZSohX1MfSZhu8DxU4pAhvsQARugLBsv9dQfmxxUFOWh+/qxZcgIUw486v8Xxg==
X-Gm-Gg: ASbGncvq6/G9o2Lc9ly/DTDLmEF8HkjJKjayxYLgMDYE8pg6xdwOWlQ4AT0+VFe92eW
	q4fPsGwmeHYXnZjPY30+VMFhp+wlqCdUQXwNPbA1fw8Jrc4aNZXgWWYO4erFz7immaaGxbgzMJ2
	peppgtYojzZXYMOhHzthH49A7QteXgL8We7G0keSu/fIfM4eHbHRSDm3YFo5R7k3pls5kgsobJ6
	AnY6oFwFfsUf727r8W1qlURgHOxypxmAJy51PtKzvMLbTGct9d9iIaOwDMoqpa4coGNeOgw/1Nr
	QqITGi7od89G34W4VvvLKcz+QNP+t8gX/l5KYXZtX/Piqjo1aW+T0agi4bJVxYxzRm1rMnoYQ81
	XyPsoaOdeb6UA5b70oRisiYvCeeTKsKLvRSBY1Fmtw9yq4C9g8AC5TYJj+vVCBk/C6Ey1ZIeKH1
	x4eqVMNpwy3KHZQmO7TrJi7lzzj5s5S6973lJg5gD8FeMqXCpi+xk0QauU
X-Google-Smtp-Source: AGHT+IGRViG14tazC/sVdQeINg8fRa9F9E54x1+WOChCPprSD9JHImXucT9B6gIt7k6SX7FUcpRjTw==
X-Received: by 2002:a05:6a00:1707:b0:7aa:a2a8:9808 with SMTP id d2e1a72fcca58-7c58e11088dmr39686428b3a.20.1764615589372;
        Mon, 01 Dec 2025 10:59:49 -0800 (PST)
Received: from pong.herbertland.com ([2601:646:8980:b330:14e3:ac6f:380c:fcf3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7d1520a03a3sm14522852b3a.29.2025.12.01.10.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 10:59:48 -0800 (PST)
From: Tom Herbert <tom@herbertland.com>
To: tom@herbertland.com,
	davem@davemloft.net,
	kuba@kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next 4/5] ipv6: Document default of zero for max_dst_opts_number
Date: Mon,  1 Dec 2025 10:55:33 -0800
Message-ID: <20251201185817.1003392-5-tom@herbertland.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251201185817.1003392-1-tom@herbertland.com>
References: <20251201185817.1003392-1-tom@herbertland.com>
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
index bc9a01606daf..7ccfdc74dc91 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -2474,20 +2474,36 @@ mld_qrv - INTEGER
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


