Return-Path: <netdev+bounces-109700-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C92929931
	for <lists+netdev@lfdr.de>; Sun,  7 Jul 2024 19:55:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B5B01F2109C
	for <lists+netdev@lfdr.de>; Sun,  7 Jul 2024 17:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25650376E0;
	Sun,  7 Jul 2024 17:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EE4dhXEQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D7E1DDCE
	for <netdev@vger.kernel.org>; Sun,  7 Jul 2024 17:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720374946; cv=none; b=m7vnyvXenGV3Q2EKYo2faYSY26lmiOfZb/msUtxddNEAihk/1S6IsB7U7zkFhiDfIALEhO8wJ/b4NyvILTv2U8MVZtEZHNNLZV1qSpL0uyV8z8VE7m6UdGEykI0WYMCA1ckDofTP0lg8SaqJ77eLFO5FjwzSla+4N/LGAq13jDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720374946; c=relaxed/simple;
	bh=1/CfkgLbPMcH+enhhSnqxRH5+ta645VWKDOMzQqIJUQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nzIRj8lLlKfTg2vGkWqEJdM6clJ8elfqrzfwlTWinrtVx/OXvU843ebz+roqHVYnNRrPSeeozXRqDP2ah5d3apfCKWGcRF5HwQl94KJDfhFAGL2u0/c6UJ59lUbm6djAPMTr5gi51y5PRMOT6+51qoyOl4MnAANkr3ICc7Kl3Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EE4dhXEQ; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2ebed33cb65so41375251fa.2
        for <netdev@vger.kernel.org>; Sun, 07 Jul 2024 10:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720374942; x=1720979742; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uUOZZcQyDlRadEhOldCYLftaRvp/nxVIpQ5uBGJ3cWk=;
        b=EE4dhXEQ6MJh4MHjwsGBX2U22zruLIyfoOUCYCAbQp3P6ytEqMnDgvmKoQ6jQBXOMo
         RI0SwUBfsLvtBFIXaY6NfXjvoFi2DUVvPGB62pCTupxmD/Kmpw1OPCNcNPPe4ZhVpAqU
         5t7c0YUlzOdYNN4qJxUMjMxPvw5lmGQl5+jMvsYVX+J1qyybKt4hO9Lb/K3Z/ABZIqYK
         nr7fEmGOta0g9r4Wwgl79qHQH1jJ1G8dC3s0fsJQ5FWwLbaEy541C8YKSiS/11s0VU77
         tBffrocONyZz7LskUwQyxTUpjS3i1eqfCpQM9LdtzXNtfRkN0meeSM1br7T/7QGLcKB6
         DM6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720374942; x=1720979742;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uUOZZcQyDlRadEhOldCYLftaRvp/nxVIpQ5uBGJ3cWk=;
        b=Jx+7fV1lFfG7cFTfgn94sZ2pYiBeHL9wY0D7nBPUJp9HakJv5gUyMcK8ifg/1ln/ln
         DuwAVqENtLoXgRA0ZnPp/UuMSPmVCkjMGFzS/WNKdfus9MdJDoy5Cmo4tWfkqvxhFCIg
         kI2ZEpkh4TNeTVywD6qrDNLos847Cealu5+5YVspYMcMfGPU+/nI6lqjyYx8McnXRz3F
         h0vCnJh6PU9f0epjm2GW2Ys3Nhv6+OqoH3yQsJj/0EobbwKRYPzxXcTLsqLIa5XXipVH
         dRHkyg82IJGX5Se0fgzkjdEuNHfKLy4mkFNxcVluph091F1Ayp9Uxx99rXp0vL6GndB+
         VoFg==
X-Forwarded-Encrypted: i=1; AJvYcCU0zz/7ljUKcFWBpQB/FQk7L51nzPFou7eRw53NMl7SzZYURMyc8C2Q8nMVXRka4iXX/HXfp7Ezu4cU1Nck6Ab585IEGTeL
X-Gm-Message-State: AOJu0Yx4LDTMtJJSpZ/1klwClzg/I5ufAXMjC+cq5B/k6xK/5AvTEqu2
	a9X/zcuCItMSIijBtBypeizdOMhI2nyoqjtu0FpuvnufyzM6e0y21ngoTw==
X-Google-Smtp-Source: AGHT+IELWJnyUqn0Sx1VDdqjesfvgJRp7BcLPpfmtJOvCHyc61ZGra4hgZu699wyeKkUGRo7qe86Nw==
X-Received: by 2002:a05:6512:2826:b0:52c:df5f:7b4e with SMTP id 2adb3069b0e04-52ea0644c5bmr8585088e87.38.1720374942088;
        Sun, 07 Jul 2024 10:55:42 -0700 (PDT)
Received: from lnb1191fv.rasu.local (95-37-1-112.dynamic.mts-nn.ru. [95.37.1.112])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52eac51fa1esm341691e87.228.2024.07.07.10.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jul 2024 10:55:41 -0700 (PDT)
From: Maks Mishin <maks.mishinfz@gmail.com>
X-Google-Original-From: Maks Mishin <maks.mishinFZ@gmail.com>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Maks Mishin <maks.mishinFZ@gmail.com>,
	netdev@vger.kernel.org
Subject: [PATCH] q_tbf: Fix potential static-overflow in tbf_print_opt
Date: Sun,  7 Jul 2024 20:55:38 +0300
Message-Id: <20240707175538.1245-1-maks.mishinFZ@gmail.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An element of array '&b1[0]' of size 64, declared at q_tbf.c:257,
is accessed by an index with values in [0, 74] at q_tbf.c:279,
which may lead to a buffer overflow.

Details: Format string: '%s/%u'. Size of buffer parameter is 63;
Specifier '%u': min value '-2147483647' requires 10 character(s),
max value '2147483647' requires 10 character(s), so the buffer needs
enough space to receive 10 character(s).
Size of the string except for specifiers is 1; Total maximum size is 74.

Found by RASU JSC.

Signed-off-by: Maks Mishin <maks.mishinFZ@gmail.com>
---
 tc/q_tbf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tc/q_tbf.c b/tc/q_tbf.c
index 9356dfd2..b9f4191c 100644
--- a/tc/q_tbf.c
+++ b/tc/q_tbf.c
@@ -254,7 +254,7 @@ static int tbf_print_opt(const struct qdisc_util *qu, FILE *f, struct rtattr *op
 	double latency, lat2;
 	__u64 rate64 = 0, prate64 = 0;
 
-	SPRINT_BUF(b1);
+	char b1[74];
 	SPRINT_BUF(b2);
 	SPRINT_BUF(b3);
 
-- 
2.30.2


