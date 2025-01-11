Return-Path: <netdev+bounces-157469-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE15EA0A619
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 22:15:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12038168322
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 21:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA2C15CD49;
	Sat, 11 Jan 2025 21:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="eWEzGDwZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D830179D2
	for <netdev@vger.kernel.org>; Sat, 11 Jan 2025 21:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736630125; cv=none; b=rjVG+XpSR9ZjQupYmUMh2DMk6RpVvq2hYlDkPHURn8azYKubWB1E0gpvvJQAbxT6Iv9lZw3H63d+UCktvV96OZvRsC47gTIRHeT1YC+RWcroxZPAzybgtdJXzIv+Te2M138cM6Zw3Z43BWEkUux6Jg5KPR5HQ03nknVNjXddsKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736630125; c=relaxed/simple;
	bh=Xa3SVgDOaumHgpiQsMpIRgPOJY5zOXEb17r7l7+J7nc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r360+Ez0j9XC+cPvUVAg/or30JSlznq1UFuc+l3fa3M+G+FcKX8aIWuL0dNvCj7JHDLwjX50ut9SdJ22kFofcY3CRPc5ZbjqJ422WhjEubFPZdW+Mltx/9OggtjidxR78eTvuQXAucjKCvB7sghcfwiUsvWoCGVowk2w5+gagbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=eWEzGDwZ; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-71deb3745easo706643a34.3
        for <netdev@vger.kernel.org>; Sat, 11 Jan 2025 13:15:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1736630123; x=1737234923; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eV9BiXPhhTPRUOwKR3WUc4qBqV6yoojVmJ3Va7ikAqw=;
        b=eWEzGDwZn8RnjIoUMCeC1mJsosm0LJCQyof4/xvTcNAYO4Etb1FxqZ5zLemwzudA91
         l5uE0SMobF/MgxOFRfelizMjkvA3K30f5svNSP/XaGjzw46LY+FiGMDE8E4q2gX/8mBZ
         1yMrRTgG5B8aDjdZ7/l4Kcw/qRJLIsy9ddiCm9qvJVYBoPXbXr7RpDkXCzk+js/861ES
         x40BpPEhnT/k4uOpFZG8d6JCRXs7QHjfLoJIkOt/D5PqiIz7W1nzr6Vn65SJBbS+7/Ig
         Hhu9VculywZtILofn4dfzeWyzzZQ+nzvJF0m8iMJ+ht0/8xBkews/kc/reO5Kn6KWCDd
         izXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736630123; x=1737234923;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eV9BiXPhhTPRUOwKR3WUc4qBqV6yoojVmJ3Va7ikAqw=;
        b=Kwxu72hXO1/V2cWAgZUO8xNW80DrhevCcjNwLijUS1+9gAfm7+OZb0ePSIcKibntmN
         sCo8Qojead0JLV/pd5Wv+SjYalKdACX4ZkjfGPXIQW7H7xjNKgNLrH5eeAutM2SomNyl
         kgPveljnQhl7mexk41/V5VvSqB66L70i+cDbMr9izPmVVTo1upRZ1EEZGEae1acsgeIb
         /5akoDLvddYX/Anm0LquV5it5if1opBYUvqY4qiDj6UUg9NocZeB/n2sk1eGXP1vppv6
         7ssK1xBxKtevVBdGlxf23B1fDw2fZWmPSVZnUUEuQ5UHpmZMTt/US0WvSA/q8rD6ZCMk
         I9BA==
X-Forwarded-Encrypted: i=1; AJvYcCW3++0CtNrMrdbgfIHaXznI+F5wpu3aO3TyXop9wwS5NySnwxRTjxyw9xNiM4ROsMXAm8S4UAI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeN61IJBiNECaIQkJCmdFqNh/tftyHtof4vrsedHdXMC6En2K8
	e3q10yw2u4AcQQv0XiyqYYcplcPYNBRKifQGNexxzAn6OGsM1drHAVQgqZxuCg==
X-Gm-Gg: ASbGnctxh/QRcL0YNCU4X4UOQ5VAlOevLY5en+IC5o/GOmtqz3SbXwrGDzsNAtMXBwZ
	gJnvKg8IlG7SzbeRcMGdww3tBi4+XFddWY2+7zOisS+PbeqAOgArnYK8eUGZ/GHOAkXPC2l7rU0
	WVHTW5tOzSjEBYD/BRJFhw3bLDlNiiQCpWvcG+03ptA6e6FeSJOF5jGpiTcf/LSlwbjpqYzafh4
	8907RHqbl6cJXVTNnXM7hyfh8jez5QJZvCp/dSXCPexzksBlTILIIw8SFcIkiRHp3oF9g==
X-Google-Smtp-Source: AGHT+IGAcAhQ66r2OyKhr1+jwmQbWNwTb53qXxeJ189MHJ1pWtV9Ghc8okTBBPQr4PwUVs8VXeXLNg==
X-Received: by 2002:a05:6808:2dc3:b0:3ea:4e7c:a91a with SMTP id 5614622812f47-3ef2ed59414mr9812734b6e.34.1736630122838;
        Sat, 11 Jan 2025 13:15:22 -0800 (PST)
Received: from localhost.localdomain ([2804:7f1:e2c1:b0f8:56cc:33d:37da:1df8])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f037693615sm1750533b6e.24.2025.01.11.13.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jan 2025 13:15:22 -0800 (PST)
From: Victor Nogueira <victor@mojatatu.com>
To: kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch
Cc: jhs@mojatatu.com,
	kernel@mojatatu.com,
	netdev@vger.kernel.org
Subject: [PATCH net] selftests: net: Adapt ethtool mq tests to fix in qdisc graft
Date: Sat, 11 Jan 2025 18:15:15 -0300
Message-ID: <20250111211515.2783472-1-victor@mojatatu.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Because of patch[1] the graft behaviour changed

So the command:

tcq replace parent 100:1 handle 204:

Is no longer valid and will not delete 100:4 added by command:

tcq replace parent 100:4 handle 204: pfifo_fast

So to maintain the original behaviour, this patch manually deletes 100:4
and grafts 100:1

Note: This change will also work fine without [1]

[1] https://lore.kernel.org/netdev/20250111151455.75480-1-jhs@mojatatu.com/T/#u

Signed-off-by: Victor Nogueira <victor@mojatatu.com>
Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 .../selftests/drivers/net/netdevsim/tc-mq-visibility.sh  | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/netdevsim/tc-mq-visibility.sh b/tools/testing/selftests/drivers/net/netdevsim/tc-mq-visibility.sh
index fd13c8cfb7a8..b411fe66510f 100755
--- a/tools/testing/selftests/drivers/net/netdevsim/tc-mq-visibility.sh
+++ b/tools/testing/selftests/drivers/net/netdevsim/tc-mq-visibility.sh
@@ -58,9 +58,12 @@ for root in mq mqprio; do
     ethtool -L $NDEV combined 4
     n_child_assert 4 "One real queue, rest default"
 
-    # Graft some
-    tcq replace parent 100:1 handle 204:
-    n_child_assert 3 "Grafted"
+    # Remove real one
+    tcq del parent 100:4 handle 204:
+
+    # Replace default with pfifo
+    tcq replace parent 100:1 handle 205: pfifo limit 1000
+    n_child_assert 3 "Deleting real one, replacing default one with pfifo"
 
     ethtool -L $NDEV combined 1
     n_child_assert 1 "Grafted, one"
-- 
2.34.1


