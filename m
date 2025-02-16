Return-Path: <netdev+bounces-166730-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50F3BA371CD
	for <lists+netdev@lfdr.de>; Sun, 16 Feb 2025 03:14:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81B6B3B0340
	for <lists+netdev@lfdr.de>; Sun, 16 Feb 2025 02:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8574253A7;
	Sun, 16 Feb 2025 02:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GxLfXYB5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B096E2904
	for <netdev@vger.kernel.org>; Sun, 16 Feb 2025 02:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739672062; cv=none; b=Z4+xVeOjC2sD2vHa6m4cPkQCFbtXsFqz2A9R9X1cYhHhlX43Isw/USe4S+LR6/TS08Zkc+aQNgbMXtBBHC7sLMV+Q0UXOa7qWTjFZtTUUERd4BQCKmoOHXu4iYAAVRxV3DhvPvKzE88S2K+aI3jJSPdcqdPrg/lfbvURJHEbun0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739672062; c=relaxed/simple;
	bh=q69M93P0z0sJ1WTGkQ2VySwh/XbYssMPdprCj0FW7pg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UZ/ct9kRpcLKVtAQsMtRvKA2JYeMxiaoffLUvu+tpJalzspBxQxfyClZrljvsnhA0eBSu9SJE5SSdraaUxj5LeHWeGOMxZ/1dZQsWS/IM9wmZlT4/3plPhZEC8b6ouXNvzDVCOypBk9/Z5+3tz4ErU0Jn6jvt4PfddNPOhJ6NsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GxLfXYB5; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-54504bf07cdso3369967e87.2
        for <netdev@vger.kernel.org>; Sat, 15 Feb 2025 18:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739672058; x=1740276858; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ssOFppK4+waIG2a/M0DalpoUbTkwdwGEaGVEU9XRLvE=;
        b=GxLfXYB5jUF50aMTMGyzWk6/0XTmDHWkhnGMdCpxH3jtiqJ31U4pQwyPFbp3/6NJ4S
         YYko6oV8/Xx9JGyc4PhOTlimcba/I0qsYMlemjqUxfrZy0UQGY7ItO42/LnbZxjzWMIF
         oTwfRolosLw7tFYmBbQ28uey2WH2Kil/KqsPJZI1cwzb6W5xFP9JOuLxAKPmSl8w64xx
         tSxGRl25Dw/088trFOQuqCFFIwEnwGNRu7j/Z94UDkgIzdvTHigxsL6YbaxBz/VbZJn2
         qFxxs9VTjgl7ggR5+7sSipehpwI6GQE7AtJ3T0HVvsF60LW0K5iY9QCWhxvH15jlTgvF
         JXRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739672058; x=1740276858;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ssOFppK4+waIG2a/M0DalpoUbTkwdwGEaGVEU9XRLvE=;
        b=Z8rWCYUKIjdiNDaAMtZDLpoWJOemtwFFMCJuCcS6Dcf6HZPjUZugkUg4faFheZT/dg
         r8gBN4736D1NL5RCNaZZwZq3Mmt0i83GzQ3bGSP/e3GbgikiisoJZuq9n3o0lGapv2dE
         h3At3ys4S4lFoYqa6Oumx1GVcRs7XqgMHHs2LNL/k2PxP9kfcIQb248+wZoXfMZbZKN3
         8gJttfL0fNZ5CbNXBoWq6mIrvp2absMPu7HsAEOvL1+MsCAhAKohR/BQv6Bxm+4er+Qe
         omCFGzZS61JLprXt4KbBJzdUCYadMJ2AK7Otz92OyKt2Shv/V0DDzZt2jKSRMDtoLYV4
         wvHQ==
X-Gm-Message-State: AOJu0YwRLqG+cZMM76BQ3d5NKDvH50LxCA0zB1KS9wUmAb3ssGM7ezAl
	zrfAjbYgl7oF8Crp1sxLJa4CpN6LT2oe+RzAvAlsRkP7e6QiJXcSpTwzDzE/zd+1Wg==
X-Gm-Gg: ASbGncvvXzaEGN2R+iIMM5HrZnnjQyqyV0rbr5ihCPR4goHQabMl1sCsNQNmTkdONOU
	ze4lxPB+JgvvwJmkcIidaTK88YRaSaRFQTHOIjM9/eNeyv9mHNKS0kgVjcELWE2LJAC6hg9KmNh
	vWuPPBdAv6REJ3u4Q+mMJ1JisFHjKkuhoKZzMTG++UUjpm7vzXA6Y/yvehgEgfcO7QH50JEUYJY
	20fYlhCww3JoQO98cFYp/PN2vX/a7OhkcdZGxMYkntuxaIE9R4764qYIsNtn9FHCosC5YYRF9fx
	8kMfjEQWT1Ls9S7YGV0YgNkb1/NqJ2x7vfnozkiEbMiWFBTBd6KcDEiolkOzZtEMalQfRhZD
X-Google-Smtp-Source: AGHT+IFgPeF4zrhboRFEMWlFBKePfRo4pbENPBhSGjWTA4g5wIqoQfnCGSIlac/ctqCtIMoMvZrkLw==
X-Received: by 2002:a05:6512:318c:b0:545:2f9f:5f6a with SMTP id 2adb3069b0e04-5452fe3a89cmr1271204e87.14.1739672057181;
        Sat, 15 Feb 2025 18:14:17 -0800 (PST)
Received: from astra-student.rasu.local (109-252-121-101.nat.spd-mgts.ru. [109.252.121.101])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5452db28594sm622910e87.40.2025.02.15.18.14.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2025 18:14:15 -0800 (PST)
From: Anton Moryakov <ant.v.moryakov@gmail.com>
To: netdev@vger.kernel.org
Cc: Anton Moryakov <ant.v.moryakov@gmail.com>
Subject: [PATCH] lib: remove redundant checks in get_u64 and get_s64
Date: Sun, 16 Feb 2025 05:14:11 +0300
Message-Id: <20250216021411.645708-1-ant.v.moryakov@gmail.com>
X-Mailer: git-send-email 2.30.2
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


