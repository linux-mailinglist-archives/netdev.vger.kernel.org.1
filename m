Return-Path: <netdev+bounces-65574-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB61C83B0E1
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 19:20:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFF981C22210
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 18:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7C1F12A16E;
	Wed, 24 Jan 2024 18:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="H60eTJkS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABEE12AAC7
	for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 18:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706120398; cv=none; b=QO4cG1CDYTskvEGLh0qywtKXj1aJTtMMLUvT6hVQBYI5orKAa6m6Pht3d4vVo1c8ZzXL2olxRJT1DftNIs3RkqDAKc/foIIMFnQM6byXOgTGracza0j+/MaVVF7YzhWFR/sDzafe0PwgRI/bvWCF9XgEvLcI+OtRSrrf0GThfMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706120398; c=relaxed/simple;
	bh=pQOrA7c8IcacL1fUQsE2uSC6rSNsb5lJxjB+TAL4fOk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=La0eUfM7Sh34y3N1SI9DEhNKuFj0GwMX+Vl1bK/SXdzVV5sMXi/5rtxb4AJhc/zE256ooxp8V2kf3sCHv3j8mjGWdiIYuWeIVOiZIPTXv88JVm6smxs/HlCPA5bH7uoMUz99cp3pRGF91RdrzORpKJ9SjRlJJKo9+FIGKgiQ11w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=H60eTJkS; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d70a98c189so35571365ad.1
        for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 10:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1706120396; x=1706725196; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gFBxT7xsVHh+8ayeAuuuih0ZuzmZPtNAj1TB2KnXVb0=;
        b=H60eTJkSCehlFB9RHNIgWcWDymyWFyKQV+2kudCVyAgBcw51qpOKlbTqcsYUcA6Gh9
         B+D/uK2zUemOKIot52I25UUTqbUG0H4HCXVKmK4g9ouq3RkbeonKOocSm7w7mRGfsJBx
         szkfLNSQmwYRT+oVwXsIdVcWCktlfSjbNStad7xcR9K8BSPTW0C7DPdMrApGCVDiw6hZ
         ihoiTkz49EwbbHfOEiJC8foKESbZNGcoUymICOkDvS6C8P5pWowe46iTaILsVY3PubgF
         +yoU6noNByEjomMAysveC39T8EBVHy6QE4hKBMU9KTxXDUvY9vRtYZiOrJbXHkh8qBZY
         04ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706120396; x=1706725196;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gFBxT7xsVHh+8ayeAuuuih0ZuzmZPtNAj1TB2KnXVb0=;
        b=EgwgVwDpavBiLsMm2RzBHoiXJJLCVhZuO1frXuQtKR8WKXLRC4tfZWpqRAJzrESZN5
         4yBO8P2hj27RRSr7uhU7alV61EKvI2h/8M3exut3NU/rMTs5s63j1KPdSkBK3OTwiET3
         FqfeRMOX4siVLQeFzS1xVA+p1RSgolh3ICq2LREJOzN/12u5FabYkoGEsh6aAqGHUavS
         xsTI62YUcqV/DbhsrH56C0WVtCKn5j/67OZa8cqQLHvMTLehcppRbWd7+7nfGXZmZeVu
         bEMW3ddop0d2FY01Xun9IXOdy8oHQncHWF6iwO1rpbpJufC5YRjfw+zvzz/jFHP+7Urc
         DnKw==
X-Gm-Message-State: AOJu0YwH540DYEUM3YKXOutlJZQRxTQxLNCK8o9Y86cCbB3tTr8c+kxy
	tJe074oTdaYc29ggIzCmBKecDXKblZQRAeSRuZJXgkwd7ZLdVsoLHjs/aGm0zK4yfc/2O85JBEe
	P9g==
X-Google-Smtp-Source: AGHT+IEd6Wt/I3bXZmlWfCk17h95CFddyzKiIkQSqc0P8TG3O2iY0L79PoKudaTfDAgw/Mn9kguxJg==
X-Received: by 2002:a17:902:dac8:b0:1d7:4a66:87c1 with SMTP id q8-20020a170902dac800b001d74a6687c1mr1141175plx.50.1706120396439;
        Wed, 24 Jan 2024 10:19:56 -0800 (PST)
Received: from rogue-one.tail33bf8.ts.net ([201.17.86.134])
        by smtp.gmail.com with ESMTPSA id kd4-20020a17090313c400b001d74ce2ae23sm5577084plb.290.2024.01.24.10.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 10:19:56 -0800 (PST)
From: Pedro Tammela <pctammela@mojatatu.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	shuah@kernel.org,
	kuba@kernel.org,
	vladimir.oltean@nxp.com,
	dcaratti@redhat.com,
	edumazet@google.com,
	pabeni@redhat.com,
	linux-kselftest@vger.kernel.org,
	Pedro Tammela <pctammela@mojatatu.com>
Subject: [PATCH net-next v2 2/5] selftests: tc-testing: check if 'jq' is available in taprio tests
Date: Wed, 24 Jan 2024 15:19:30 -0300
Message-Id: <20240124181933.75724-3-pctammela@mojatatu.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240124181933.75724-1-pctammela@mojatatu.com>
References: <20240124181933.75724-1-pctammela@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If 'jq' is not available the taprio tests might enter an infinite loop,
use the "dependsOn" feature from tdc to check if jq is present. If it's
not the test is skipped.

Suggested-by: Davide Caratti <dcaratti@redhat.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
---
 tools/testing/selftests/tc-testing/tc-tests/qdiscs/taprio.json | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/taprio.json b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/taprio.json
index 2d603ef2e375..12da0a939e3e 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/taprio.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/taprio.json
@@ -167,6 +167,7 @@
         "plugins": {
             "requires": "nsPlugin"
         },
+        "dependsOn": "echo '' | jq",
         "setup": [
             "echo \"1 1 8\" > /sys/bus/netdevsim/new_device",
             "$TC qdisc replace dev $ETH handle 8001: parent root stab overhead 24 taprio num_tc 8 map 0 1 2 3 4 5 6 7 queues 1@0 1@1 1@2 1@3 1@4 1@5 1@6 1@7 base-time 0 sched-entry S ff 20000000 clockid CLOCK_TAI",
@@ -192,6 +193,7 @@
         "plugins": {
             "requires": "nsPlugin"
         },
+        "dependsOn": "echo '' | jq",
         "setup": [
             "echo \"1 1 8\" > /sys/bus/netdevsim/new_device",
             "$TC qdisc replace dev $ETH handle 8001: parent root stab overhead 24 taprio num_tc 8 map 0 1 2 3 4 5 6 7 queues 1@0 1@1 1@2 1@3 1@4 1@5 1@6 1@7 base-time 0 sched-entry S ff 20000000 flags 0x2",
-- 
2.40.1


