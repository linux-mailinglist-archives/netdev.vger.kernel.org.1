Return-Path: <netdev+bounces-109699-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F2392992E
	for <lists+netdev@lfdr.de>; Sun,  7 Jul 2024 19:27:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF0282816B5
	for <lists+netdev@lfdr.de>; Sun,  7 Jul 2024 17:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71FCC548EE;
	Sun,  7 Jul 2024 17:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="caRviqmY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E6A2E64B
	for <netdev@vger.kernel.org>; Sun,  7 Jul 2024 17:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720373268; cv=none; b=I4cMQJjVpW36IfulMRPHk4QM+HQQYsjM+fUTGyhNauNNbBA487O1WfJ2KhhXl7KWZ9nlgTT7t0Z+43KT9R3GqlF/5EB6E0O+jHPvOJ9aZIAW8WO6uB4Mvjm7sxSkJo58Lg3x0wMpOdsY7r/wQGowDfBe1XF5WHeFBMX7/F48tVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720373268; c=relaxed/simple;
	bh=+8ACkQPOMb0wRyWGGVBRDuA9AWXhAPvGoWGxNvcspUo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oCIGXZ9nwzQ4/9xxHnLK+qBT5E1v/4fhVTETgbEZ8+VIASQ26YRsravyL89z+relcLxmJtAjAcQ/Y2WPU41mk0eFjfzXvsVGTT/kAaRU4zfgd+qBtmSkLNDBL4vp3t0mtksN9Gy+2xc+M4LarSBC7mniSaJ9+3fapVnjJr+HqHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=caRviqmY; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52e97e5a84bso4709549e87.2
        for <netdev@vger.kernel.org>; Sun, 07 Jul 2024 10:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720373265; x=1720978065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vlQSSTUMMMK75pdsG8jsImsNtpOGs3j2SswwmkxvR/M=;
        b=caRviqmYcXU9zVeTSYr7c0nZo0zpL7FaekozrBoF7VTkL9XujmUc8BGHcEyADb88Oz
         PFA4MRSlsjP8T/TEyyXxi812BjiQMhulp7KNyi6nCU8u4E11BWpVKYbirls9P/aXoMiB
         6iTzDoIr3fTRdfnUXrbeBYexvBRcJO3TXErNCLnIa2wu8Mw8jGswqVckptEwYI+ocqix
         UO8wHHySzdTdsCb86ZLsbxIhhRSByPtp5PqKwJ/8rY4QExp5Qze8GgenI5UhW3reaZxU
         nptiTGQatRhHILk+7kNlL4wpmBLriSDxQtihszWUedaMjkRCvmPjQVnCZzP2T3apYRVW
         5edg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720373265; x=1720978065;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vlQSSTUMMMK75pdsG8jsImsNtpOGs3j2SswwmkxvR/M=;
        b=TzkfaCMAc5CAGQszaEtlvQKxBL124OWKZ/WJlTiXfJo228INDR/xgzIbFmQECAf7bW
         JlAsPAoADkNtr6SPb7nc64OzMHLermrt5xl92cuVHjj1GefSpQ7QPRBikvAcrf8vbZjl
         bCoeUN7u3K/9VOuD6HbkMPdUhmp9yuANoYy3zAMlTHQUiVy7v5vrt+AojhVcTmB91RZX
         MWIY+61DoRZNUW3GPd1U/gt0pWgWxKES8/j7Z8U09lWCq111r9eriMKVV4Jpho12NNay
         gQB3UT1MIKMPIY666HEEAUgNO8FYH7RR6BjA2Wi5uX/PM9etbmi3sN87pzyEGPh15wq5
         lhLg==
X-Forwarded-Encrypted: i=1; AJvYcCUPq33G1fd9gZWjkI6Vzyp3cvnGRGnZWvsVl1SdSh+a8zr7ylVMW7gD25/Eryp8lAcxnrvtHqLhW+6c0APC/CQqt/GC+c+4
X-Gm-Message-State: AOJu0YwEy61LfC5USTKGAZ6EHMT8TpQDpvkK/KfgpYRYZ/H2RBD1mF2c
	QuTjZXstTb+bCo36se0IYhZNXGr3zgd0Gsc5KWGUcxR8Wv7FMvRUxEBtFg==
X-Google-Smtp-Source: AGHT+IFhiaKiEPtvdCTlE/G602Q6xG2GzMq9IpOwQKz8EmnNk3c0rUi3QjGr1v9EiqoK+UdIueJjCQ==
X-Received: by 2002:ac2:44d2:0:b0:52e:76f6:aa5b with SMTP id 2adb3069b0e04-52ea0621d0amr8278348e87.17.1720373264575;
        Sun, 07 Jul 2024 10:27:44 -0700 (PDT)
Received: from lnb1191fv.rasu.local (95-37-1-112.dynamic.mts-nn.ru. [95.37.1.112])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ead300b22sm290428e87.69.2024.07.07.10.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jul 2024 10:27:44 -0700 (PDT)
From: Maks Mishin <maks.mishinfz@gmail.com>
X-Google-Original-From: Maks Mishin <maks.mishinFZ@gmail.com>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Maks Mishin <maks.mishinFZ@gmail.com>,
	netdev@vger.kernel.org
Subject: [PATCH] f_flower: Remove always zero checks
Date: Sun,  7 Jul 2024 20:27:41 +0300
Message-Id: <20240707172741.30618-1-maks.mishinFZ@gmail.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Expression 'ttl & ~(255 >> 0)' is always zero, because right operand
has 8 trailing zero bits, which is greater or equal than the size
of the left operand == 8 bits.

Found by RASU JSC.

Signed-off-by: Maks Mishin <maks.mishinFZ@gmail.com>
---
 tc/f_flower.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tc/f_flower.c b/tc/f_flower.c
index 08c1001a..244f0f7e 100644
--- a/tc/f_flower.c
+++ b/tc/f_flower.c
@@ -1523,7 +1523,7 @@ static int flower_parse_mpls_lse(int *argc_p, char ***argv_p,
 
 			NEXT_ARG();
 			ret = get_u8(&ttl, *argv, 10);
-			if (ret < 0 || ttl & ~(MPLS_LS_TTL_MASK >> MPLS_LS_TTL_SHIFT)) {
+			if (ret < 0) {
 				fprintf(stderr, "Illegal \"ttl\"\n");
 				return -1;
 			}
@@ -1936,7 +1936,7 @@ static int flower_parse_opt(const struct filter_util *qu, char *handle,
 			}
 			mpls_format_old = true;
 			ret = get_u8(&ttl, *argv, 10);
-			if (ret < 0 || ttl & ~(MPLS_LS_TTL_MASK >> MPLS_LS_TTL_SHIFT)) {
+			if (ret < 0) {
 				fprintf(stderr, "Illegal \"mpls_ttl\"\n");
 				return -1;
 			}
-- 
2.30.2


