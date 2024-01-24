Return-Path: <netdev+bounces-65577-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40ED183B0E8
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 19:20:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E30751F25336
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 18:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD8212AAD5;
	Wed, 24 Jan 2024 18:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="ceXq5Jv5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BE212AAEF
	for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 18:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706120410; cv=none; b=Mn4YJQ/PB0cM2BxP0Pw6DAhbwk/QBvj6nKziWjaj8z6IrocGf1nKg75YjPjLNvc+YUBytcoPT0CfcPMRW9iUnM53w3xPCLXuXjpiJTzEylhnVKIXKbC/Yd3vNswVuCPp/HJB+zSARYcvL6pow1xGSBN3RavlIk6sUSiEHhySVNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706120410; c=relaxed/simple;
	bh=RYKAneGKj5rW3ZSaKMHN+jkOKYrCveP/BkhXpCVNQZ4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uIrsCvLhaleRtHw28kxxRrVCjZVfv/D6hakfic0o8TTYieU5oOBiSi4Pkg0FKfACE6wemnDV34EU4pc+RyL8i/qYSEDNM6uQXvSqIFlKLTjnuJqN22YW4Cmb6zd796UTTJh5b/QeP5B0gwfpLm/43DTqd5oDcuVXLIklgfqO2Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=ceXq5Jv5; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d51ba18e1bso52850605ad.0
        for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 10:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1706120408; x=1706725208; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kcgbFDhBYDnDG7e+EicrCnnoYD+QkO9W9lsCV1iSmek=;
        b=ceXq5Jv5MzRHqE1C3NvD/5RICRqGnmdGvMduYyW11TMBUtZQa0G7Jqc2G1t4n+f5Kb
         toR7hETMB65j60p0lQFaAGHqM4w7Wypicd1Qaf6FWGnTXgoJIYt0ddbpMUd54CVeiq+0
         FcXGsCoVtg2OUcQivrzrkwuD0f701x3zW/aGpoQgDGOwxcc11zI1tC9n2FrszVTkyah1
         g6N+R1rlBVNGpli3EIrzPBFhRXckScRWP9Bd22P44i1nCV6etkCs9+hDLlCZeXAFfQrh
         gv/YnOCLSNmuO0QSdwj5BMiJtFFEBxPSJk1I1JpNOnk9YBGj+s+8dkmCPzqWk+BKwvt7
         8XYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706120408; x=1706725208;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kcgbFDhBYDnDG7e+EicrCnnoYD+QkO9W9lsCV1iSmek=;
        b=XTPneuy7MBc8xtgEzw2C8asiUS69tmQ7tCq3Ju2p0bq6AG9zoWafJFTd4IUToWVGLj
         MvPWmpnkhHbgZv2x3T86XXIujTt1A5T/ptxE2+0s16tNCvb6+bwgQBdQfKqexyeVzhId
         kOLMxU44mzyds39l1gJ5bCtmRHcxJoWtIaAmmravpGSsX2+zbUUnmOEUCqUNKAk0aVHN
         IKP0yRjRP9UwheCWZy4Kt2yytY1QHR1N9pULUscSMrkJc6K6SiB4eYzcvFrhErAkHJEH
         yNWbQUzvBZI8YscZ7uOmIUPz2LIFyrOPEgKeXKwQsC7aWEe73eSzU2SFYc6v9Apvfsui
         vCvw==
X-Gm-Message-State: AOJu0YwftM+2akbpUUX4LG3wpLLgP1k8LONg4wX5kEdvfnrh9JE332cM
	zlsGZnV2OwP3qrlAYEi1E6c1qw+BOFzr3+6YxXsz/EmCliuTqk5hqkfsWDSP6beiEYr0M6u3+m2
	JEA==
X-Google-Smtp-Source: AGHT+IE8CTP0k1buCWYsLl3oLDOecT3xHXO3leWrGiFV8Ppz71BOfI+ZUTkdNi12sgo3JEFHFPL0eA==
X-Received: by 2002:a17:902:700a:b0:1d4:cd41:e44b with SMTP id y10-20020a170902700a00b001d4cd41e44bmr1187925plk.124.1706120408032;
        Wed, 24 Jan 2024 10:20:08 -0800 (PST)
Received: from rogue-one.tail33bf8.ts.net ([201.17.86.134])
        by smtp.gmail.com with ESMTPSA id kd4-20020a17090313c400b001d74ce2ae23sm5577084plb.290.2024.01.24.10.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 10:20:07 -0800 (PST)
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
Subject: [PATCH net-next v2 5/5] selftests: tc-testing: return fail if a test fails in setup/teardown
Date: Wed, 24 Jan 2024 15:19:33 -0300
Message-Id: <20240124181933.75724-6-pctammela@mojatatu.com>
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

As of today tests throwing exceptions in setup/teardown phase are
treated as skipped but they should really be failures.

Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
---
 tools/testing/selftests/tc-testing/tdc.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/tc-testing/tdc.py b/tools/testing/selftests/tc-testing/tdc.py
index caeacc691587..ee349187636f 100755
--- a/tools/testing/selftests/tc-testing/tdc.py
+++ b/tools/testing/selftests/tc-testing/tdc.py
@@ -541,7 +541,7 @@ def test_runner(pm, args, filtered_tests):
             message = pmtf.message
             output = pmtf.output
             res = TestResult(tidx['id'], tidx['name'])
-            res.set_result(ResultState.skip)
+            res.set_result(ResultState.fail)
             res.set_errormsg(pmtf.message)
             res.set_failmsg(pmtf.output)
             tsr.add_resultdata(res)
-- 
2.40.1


