Return-Path: <netdev+bounces-167053-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B7FA38907
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 17:22:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CB381887ED2
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 16:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B000E225773;
	Mon, 17 Feb 2025 16:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e+TRy1ZM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB2C225760
	for <netdev@vger.kernel.org>; Mon, 17 Feb 2025 16:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739809342; cv=none; b=BwiKabMZxfyxB9XCAk/lrrbg7p62Sv1YntlpOCB3yEo3lV8g3cnpR+WGOWfxAcWrtSNZcTqLe27F/kUOXsxRXjZMjrG8xzK0TExtnm0Fj7TVUGVxV8nuaiGOdjeaT+jiapFO3zlvJI/DITJkE3DoS+0BAumE37Z0k9kxip9fYS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739809342; c=relaxed/simple;
	bh=q69M93P0z0sJ1WTGkQ2VySwh/XbYssMPdprCj0FW7pg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HS96RrmwA3vKeC3t55Jc2RA7FtEUlCa2jbGBQYyDjCe4Cy81jgxinViMecA+OotN7roshr7U4NsfJGCAR9lS4S6AoNtc56j8lL5LAIbaKDXjhfiIp1h952eFpBwwF7C7csiKq+xliB99EYC/Ke431oCApUbhiYiMQR8HA7RQyzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e+TRy1ZM; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-30a2cdb2b98so12641211fa.0
        for <netdev@vger.kernel.org>; Mon, 17 Feb 2025 08:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739809339; x=1740414139; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ssOFppK4+waIG2a/M0DalpoUbTkwdwGEaGVEU9XRLvE=;
        b=e+TRy1ZMZd9k36tmebWsbx0B7ESF1E0yGCJNXjAudrkxoqMnfgJf9CEfiuq5Hy74us
         IrTdQcq/A13BfnRLQvJwOkjg0oiiy7muA2kzZNWpW+N3MzP+6M5/puxVZdHLcpvYMygS
         QSGicDl2a7l9G+60vV/Gm+50QOQVdVBcr7vj1VJXNvfep/sWoEbI2Sf/Z6FexYZkXcA+
         1s6/OSC8YgxVlwh0VtAA7UtIayOCnhiTnNSNy0nIsVmiI9Nk6cyrqi9w+TgupSzfXDtp
         +q0+PT0YNu/so3E2yu+POzTn/e9pqcy6PvdNGdcTDAdeFYSczR5mTydj8/DzUw4Pn/st
         av9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739809339; x=1740414139;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ssOFppK4+waIG2a/M0DalpoUbTkwdwGEaGVEU9XRLvE=;
        b=whgpW50DYhJ2v//McOBIhop0S71Cz6FT/q2+A0bxezWQn0bWVVeKvGc6mtfshkuYeQ
         JJr8pfPfBT81nNO5sfDf3PYUti4jJTJagA2J2nVknDvLrqiyvPak3vMtTFLVRlTrjX5h
         ZatEXQXVARKmUTMAzN9zsB7Bo8baKqtPu6xi+E3E8wlCpYd4RqzEhuXn/pe20BKalj3N
         099zx88yTeus125h+/XhkTD5Os8Xtfzgyc3O3ZB5mMM3vKIagvlhKCiGRV/wtIowcGGu
         wLtJrT1tlv4NLV2ZLRYftzbX41EXkAREehAyREDpE56BjTxc5U3/LeOPLQUhMuH7KREW
         I9/Q==
X-Gm-Message-State: AOJu0Yx2F82fwm/dUWPShvR7mdPQ+ifm+xscLb2sr3WYGtt/JllUJheh
	SvUJ8mMf8Ly2lSYC1sbyKAAZDIqYiJDTWzyV/Y7HNIVSsmnp4YLMEprVpjZNILx2tA==
X-Gm-Gg: ASbGncurGWmX694/dckkFubMZeWHUydHCmkn0PCKKRQBggo05m7slRNlW+Pc9assdlR
	ax1pcMan/15PH6u8whRZQZKddVmor780qRD4hBVHxXmyY8EqZUWLqVr7cI6DfzfwDfMaLJA6GTr
	Q+oCuDDaifEpzWITh0uln2yrSq6XUFVma/wnwZQGWzEcWQW4rMBQuppW+vdsoxuVcFUg7h8Rl/f
	9/ZQmFaWejtA4AIR6Pr4Fif/VrTa6vsyXamDlBahiyagBqE6hTiOYvryZw6AMuySrXwBat20d7p
	5y2cumYnqt8tByRzgsiQb/LNPPwyLN84YqSKdoMeZt5j/Zctct4Ez10NB8R3C0ZgLh7QzjE9
X-Google-Smtp-Source: AGHT+IHaqHhlceRZxbO89O8KksTheJh5gKlLxUeOF5GB3urA3wzdT+N3We6inwhrqG2VES8Ecv2dmA==
X-Received: by 2002:a2e:850c:0:b0:308:ec50:e841 with SMTP id 38308e7fff4ca-30927b1e20emr31397141fa.25.1739809338374;
        Mon, 17 Feb 2025 08:22:18 -0800 (PST)
Received: from astra-student.rasu.local (109-252-121-101.nat.spd-mgts.ru. [109.252.121.101])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30a2794fcf2sm6817331fa.51.2025.02.17.08.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 08:22:17 -0800 (PST)
From: Anton Moryakov <ant.v.moryakov@gmail.com>
To: netdev@vger.kernel.org
Cc: Anton Moryakov <ant.v.moryakov@gmail.com>
Subject: [PATCH iproute2-next] lib: remove redundant checks in get_u64 and get_s64
Date: Mon, 17 Feb 2025 19:21:53 +0300
Message-Id: <20250217162153.838113-4-ant.v.moryakov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20250217162153.838113-1-ant.v.moryakov@gmail.com>
References: <20250217162153.838113-1-ant.v.moryakov@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Static analyzer reported:
1. if (res > 0xFFFFFFFFFFFFFFFFULL)
Expression 'res > 0xFFFFFFFFFFFFFFFFULL' is always false , which may be caused by a logical error: 
'res' has a type 'unsigned long long' with minimum value '0' and a maximum value '18446744073709551615'

2. if (res > INT64_MAX || res < INT64_MIN)
Expression 'res > INT64_MAX' is always false , which may be caused by a logical error: 'res' has a type 'long long' 
with minimum value '-9223372036854775808' and a maximum value '9223372036854775807'
Expression 'res < INT64_MIN' is always false , which may be caused by a logical error: 'res' has a type 'long long' 
with minimum value '-9223372036854775808' and a maximum value '9223372036854775807'

Corrections explained:
- Removed redundant check `res > 0xFFFFFFFFFFFFFFFFULL` in `get_u64`,
  as `res` cannot exceed this value due to its type.
- Removed redundant checks `res > INT64_MAX` and `res < INT64_MIN` in `get_s64`,
  as `res` cannot exceed the range of `long long`.

Triggers found by static analyzer Svace.

Signed-off-by: Anton Moryakov <ant.v.moryakov@gmail.com>

---
 lib/utils.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/lib/utils.c b/lib/utils.c
index be2ce0fe..706e93c3 100644
--- a/lib/utils.c
+++ b/lib/utils.c
@@ -304,10 +304,6 @@ int get_u64(__u64 *val, const char *arg, int base)
 	if (res == ULLONG_MAX && errno == ERANGE)
 		return -1;
 
-	/* in case ULL is 128 bits */
-	if (res > 0xFFFFFFFFFFFFFFFFULL)
-		return -1;
-
 	*val = res;
 	return 0;
 }
@@ -399,8 +395,6 @@ int get_s64(__s64 *val, const char *arg, int base)
 		return -1;
 	if ((res == LLONG_MIN || res == LLONG_MAX) && errno == ERANGE)
 		return -1;
-	if (res > INT64_MAX || res < INT64_MIN)
-		return -1;
 
 	*val = res;
 	return 0;
-- 
2.30.2


