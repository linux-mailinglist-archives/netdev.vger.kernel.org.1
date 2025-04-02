Return-Path: <netdev+bounces-178848-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D7FA7933A
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 18:33:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 743821891B45
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 16:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513AD1A01C6;
	Wed,  2 Apr 2025 16:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xcv05iNM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DA51DB15F
	for <netdev@vger.kernel.org>; Wed,  2 Apr 2025 16:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743611289; cv=none; b=HuPxi4sYDY+h4EnOpj/2+vh3zfab9J9HbT+qKrDeB78Z42cpHzHbCvF2xjMSSpGUuXCe2mznJM5lwCHityduKQksRpKn2G6Ce/TwDxM7yTUarUrcsdnSwPwDY6zvEkRA0yJtpfxjjaucohai5bDhJ0kfMAlTywoItlCVHKmmvZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743611289; c=relaxed/simple;
	bh=le48TpsLIXgwRUE7JK2oXHpEVjkDjeIk8bkxcrTUacQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=P6QKcOXWp+PiziRUaHN2EfsD+UW5dL8q0Peq4ebJCtvTAlqZBcocfkEdwDYKJWhFVU9+OC3L79Mwjag9fTdZJNsiUsM8AUD4jLmDUpAhCRci6qZETkWA3RVjiqTesz6s94jovexIVJtP1MjNG+vSSMeNW3ilnQ8YtUOetY/M9KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tavip.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xcv05iNM; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tavip.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3032f4eacd8so11161265a91.3
        for <netdev@vger.kernel.org>; Wed, 02 Apr 2025 09:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743611286; x=1744216086; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WR5OMrXI1sfyljYWNGyiK+AjZvbJe/Y00ticFJRI05Y=;
        b=xcv05iNMADgtqon5MfnnhG+NtGn5odpF6BWzdTXQWLSBYLhvujYIwoFfG7VFJ0gbwd
         MKty76BH+2ac1pKebSTldQtRzVld05XuW5bjRiY4vRactUlzOLo3Dx2XUIzb2Po3UFx5
         A+uAFszlS0blACJQwSbfP7xYjWKOionnmNhSOTCBKYUjQxaKz92YTL5cfa3NvZByR31q
         S2c3Cd1p52xP+WXQL4CxS9oafnBAV2RYYcOANd5moClT7nhRK/ujE/w4iwuf28AabJCn
         aYmRwxC9hI2adur2FkVXm2rOC4HxLRBqMleSyfuyuSJ5+z7eHfArfUo86/zKNx5aMDeT
         5huw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743611286; x=1744216086;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WR5OMrXI1sfyljYWNGyiK+AjZvbJe/Y00ticFJRI05Y=;
        b=ixlJlCktKwYRd4R+fJxOBxi0M3z6Z4v4G58mMxeyBUqd3OxJmQoJr2YcV6X4RE2ok9
         fUjx/9xDQ0XIDB823pPErGor37rqV0SX6DcYbff8z4F2F2UKjnWDsHcWGkmJR95b/DCW
         AfeyMGju4jzdMVjoh2TxRWIYEVK1eXQ1LLFoH1RnnkK6KS5bK5N7j7vVJBBWS2vz1Od5
         IZsuVoVpoe8Q+A4d4RQfQYimgCnOQBlwq4JDhDYZNKkq81aFpcK++zREza5ntXl8SyVH
         FvSQ5HI8u4RdMShYWKgmaJPi53rqUNbV7BCaJnb3zzThi5uaLOu0g64d4Uoy4F8QXx18
         Ps0g==
X-Forwarded-Encrypted: i=1; AJvYcCXPj7lr1kruUO67aQ+iYCE/O+e36RAQhnVoY3v8TZOPI4qwc8zRIHI1o2O5aeP5JxXWmurMfX4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8xAX/704mqBpgZNoiE3XIAFJCxiGsZoyZ7sNgLCGkIIjx6+/q
	1SaEv7vzv0klCqkJRUjHo4N8azKuNODD9EtoQnlWZnG+Aa+FdQGrPam8c9/VgOGt2LZ8h7Eb1A=
	=
X-Google-Smtp-Source: AGHT+IGDaiMq0FcBeFolYyJvVt1nniMip0rSXoze+gTClkjtz+wbObgNoSNr04Kru88H1XJrjlLLejpg1w==
X-Received: from pjtd10.prod.google.com ([2002:a17:90b:4a:b0:2fa:e9b:33b7])
 (user=tavip job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:e183:b0:2ff:5357:1c7f
 with SMTP id 98e67ed59e1d1-3053215a3e5mr26898614a91.30.1743611285949; Wed, 02
 Apr 2025 09:28:05 -0700 (PDT)
Date: Wed,  2 Apr 2025 09:27:50 -0700
In-Reply-To: <20250402162750.1671155-1-tavip@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250402162750.1671155-1-tavip@google.com>
X-Mailer: git-send-email 2.49.0.472.ge94155a9ec-goog
Message-ID: <20250402162750.1671155-4-tavip@google.com>
Subject: [PATCH net v2 3/3] selftests/tc-testing: sfq: check that a derived
 limit of 1 is rejected
From: Octavian Purdila <tavip@google.com>
To: jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, shuah@kernel.org, netdev@vger.kernel.org, 
	Octavian Purdila <tavip@google.com>
Content-Type: text/plain; charset="UTF-8"

Because the limit is updated indirectly when other parameters are
updated, there are cases where even though the user requests a limit
of 2 it can actually be set to 1.

Add the following test cases to check that the kernel rejects them:
- limit 2 depth 1 flows 1
- limit 2 depth 1 divisor 1

Signed-off-by: Octavian Purdila <tavip@google.com>
---
 .../tc-testing/tc-tests/qdiscs/sfq.json       | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/sfq.json b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/sfq.json
index 50e8d72781cb..28c6ce6da7db 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/sfq.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/sfq.json
@@ -228,5 +228,41 @@
         "matchCount": "0",
         "teardown": [
         ]
+    },
+    {
+        "id": "7f8f",
+        "name": "Check that a derived limit of 1 is rejected (limit 2 depth 1 flows 1)",
+        "category": [
+            "qdisc",
+            "sfq"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [],
+        "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root sfq limit 2 depth 1 flows 1",
+        "expExitCode": "2",
+        "verifyCmd": "$TC qdisc show dev $DUMMY",
+        "matchPattern": "sfq",
+        "matchCount": "0",
+        "teardown": []
+    },
+    {
+        "id": "5168",
+        "name": "Check that a derived limit of 1 is rejected (limit 2 depth 1 divisor 1)",
+        "category": [
+            "qdisc",
+            "sfq"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [],
+        "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root sfq limit 2 depth 1 divisor 1",
+        "expExitCode": "2",
+        "verifyCmd": "$TC qdisc show dev $DUMMY",
+        "matchPattern": "sfq",
+        "matchCount": "0",
+        "teardown": []
     }
 ]
-- 
2.49.0.472.ge94155a9ec-goog


