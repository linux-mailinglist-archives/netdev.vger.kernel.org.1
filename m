Return-Path: <netdev+bounces-174296-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B86FDA5E315
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 18:48:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED71C169975
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 17:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 758161DDC3F;
	Wed, 12 Mar 2025 17:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jCn41SIb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB39220EB
	for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 17:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741801697; cv=none; b=GnbIlX3kEfdpPyMylOH3ii69dVyiOcA4kXb6k4R+m8z6eiXdixBcYPxZRU3li6zn9h/RhZsVTnLRCuKI41hl0vV0TsjXoM+GuR4/DASpuabMqcPNkDDKlr4T1FOH0ydKYP/cA6MPraB8xfrf4cXn2I1RKuMnkY9ceeVC4h8jBzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741801697; c=relaxed/simple;
	bh=nQBfNkMjiBZvXXSalUXl18jyJnRFQ4RL02YKC7TFi10=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SLh3Kn+4br/qN5/ezbRuSWwpO16TL6w6CMy1u5vlW6Gnh97Xmeqi8Qd5I5sGY+fbuZdyzxm1EKKyMVaHo0DUuhyM4gAKPPl99R1pbdB3llwKSx6kcWWug6usCpavhhHE+Ahdl9cNAwOwxSPV4XGMM6g7dfPJaPCIVTjHbhSsxNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jCn41SIb; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2254e0b4b79so3337325ad.2
        for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 10:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741801695; x=1742406495; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PQtP2NcblxI9ljabmwLbGh9xiBDAAZLvH5hTBPTiBnY=;
        b=jCn41SIbA6+DZSrk0uXUfKhWicaOIiLIxMvyprkqVYCqqtPInSs8cErFgTKWbyJVkH
         26pTzyS9qa5pCBo8WESYlSUbVNltGTRMSVNjX3HS2sYAV/7KCU9/M6lGII/tIUIlr/iH
         FN2iCG79ThbA3C/AgSKQ5S3nGUvS2Kicf6zJ1lSy+EacOS3rCTvOpi0IJL+sEktzhlaT
         mIU9ClhgYjZx7zkge5ivZuPDH0b90hgQSnWoch09BmtT6qh6DfBjSiz3XR609BOnLAUh
         eD2nq6OViRy7DCg+G96YZFr91XnIDCOlIFUVWSrb7LKGAbK/mYGBs5EFErZfONvBh1GV
         C/uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741801695; x=1742406495;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PQtP2NcblxI9ljabmwLbGh9xiBDAAZLvH5hTBPTiBnY=;
        b=s/wXnWsTR7AXQBFcf5xFLfkBNVEoVJh+5ZXG4QWlSyFiZBTP8f/vZMZ08D+EV0dsfN
         3WROB03UyX1DGMDnrmvz/F5AbEhZTsaOtbsVa/f8bqc1/TzXXW2sZIDNaz7tKVLpLqzb
         J0jYSYVb4IdBIByxJGCWEamIq5JWlpP9Ctb/hrrZ6CST1pjdWE7WevkWd3z3l49JoGBj
         jDuYMH9CrtyjOY4M1RFg6wEDTRl9hPI91XCWDHYKW1Xp9g673ldApwd7NMX3Qa5jXr0c
         NRxLSpBBusssXILXYeyH1McMzQMsRJU6BI0LSnhISbvBzkmZDx7qimLf+SpUE10cM3gl
         0IYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUuDLcsjMjXMdm3Cy/oQJ+lkTzCIHddvZ7dB6uNIGkPZvD6TQuxXyNw5O56W7NVazv4nv6kJX4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu86uoW7s+pEIXds6eVm+BUYKm75He8JVHMvgDACI7s2e+TQF+
	nPfxqq3AHraFFrrFLsdDWn8JHszDM913MkUPqgmhCyxDqyjj1LqXFhy8Otqa
X-Gm-Gg: ASbGncuxm217us3bry5ZsNg+p5E9ruJ5CW0lsbKUI+RnbAeNVtUcS7Bfi2ZFk1tMtyY
	sPlTEOnzYk0JPtP2Lsy5qDJtPP0+QXRUbrawBbGfVa9xGhywf0yCqC6qzL6DsOhjpSEDuKTP31v
	0jNfVwnsdFdkKZo8SKBhxW+tKL/ajf8cejGqIHmqtyvUgL+5ocikolu046JmfudSecCxxj8E89k
	/mj/a353hlMGZmGFHgUI9wX3+u7MKpEtXu9A27/Yjgg0ddM6KTQU+SvUyodzQRi+mC1XT6RwkoW
	jkOzTDgeTukehT7G//Gt46fr4T8LIu26hTJRxdsFfQZYSRJ3c32lDchJn7XaOukFqDpL0yk=
X-Google-Smtp-Source: AGHT+IFojvXGKG7ivrs7mw1GHZ1dvkfri2slZtFoiB3Gx+ksEWi4K5w4DPjCk/zNEEUntDv4JIc0xg==
X-Received: by 2002:a05:6a00:987:b0:736:326a:bb3e with SMTP id d2e1a72fcca58-736aaadefccmr30903769b3a.15.1741801695096;
        Wed, 12 Mar 2025 10:48:15 -0700 (PDT)
Received: from jlennox2.jitsi.com ([129.146.236.57])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736d141b234sm7104710b3a.32.2025.03.12.10.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 10:48:14 -0700 (PDT)
From: Jonathan Lennox <jonathan.lennox42@gmail.com>
X-Google-Original-From: Jonathan Lennox <jonathan.lennox@8x8.com>
To: Jakub Kicinski <kuba@kernel.org>,
	Jonathan Lennox <jonathan.lennox42@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Lennox <jonathan.lennox@8x8.com>,
	David Ahern <dsahern@kernel.org>,
	netdev@vger.kernel.org,
	Stephen Hemminger <stephen@networkplumber.org>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Pedro Tammela <pctammela@mojatatu.com>
Subject: [PATCH net-next v3] tc-tests: Update tc police action tests for tc buffer size rounding fixes.
Date: Wed, 12 Mar 2025 17:48:04 +0000
Message-Id: <20250312174804.313107-1-jonathan.lennox@8x8.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2d8adcbe-c379-45c3-9ca9-4f50dbe6a6da@mojatatu.com>
References: <2d8adcbe-c379-45c3-9ca9-4f50dbe6a6da@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Before tc's recent change to fix rounding errors, several tests which
specified a burst size of "1m" would translate back to being 1048574
bytes (2b less than 1Mb).  sprint_size prints this as "1024Kb".

With the tc fix, the burst size is instead correctly reported as
1048576 bytes (precisely 1Mb), which sprint_size prints as "1Mb".

This updates the expected output in the tests' matchPattern values
to accept either the old or the new output.

Signed-off-by: Jonathan Lennox <jonathan.lennox@8x8.com>
---
 .../selftests/tc-testing/tc-tests/actions/police.json  | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/actions/police.json b/tools/testing/selftests/tc-testing/tc-tests/actions/police.json
index dd8109768f8f..5596f4df0e9f 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/actions/police.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/actions/police.json
@@ -689,7 +689,7 @@
         "cmdUnderTest": "$TC actions add action police rate 7mbit burst 1m continue index 1",
         "expExitCode": "0",
         "verifyCmd": "$TC actions get action police index 1",
-        "matchPattern": "action order [0-9]*:  police 0x1 rate 7Mbit burst 1024Kb mtu 2Kb action continue",
+        "matchPattern": "action order [0-9]*:  police 0x1 rate 7Mbit burst (1024Kb|1Mb) mtu 2Kb action continue",
         "matchCount": "1",
         "teardown": [
             "$TC actions flush action police"
@@ -716,7 +716,7 @@
         "cmdUnderTest": "$TC actions add action police rate 7mbit burst 1m drop index 1",
         "expExitCode": "0",
         "verifyCmd": "$TC actions ls action police",
-        "matchPattern": "action order [0-9]*:  police 0x1 rate 7Mbit burst 1024Kb mtu 2Kb action drop",
+        "matchPattern": "action order [0-9]*:  police 0x1 rate 7Mbit burst (1024Kb|1Mb) mtu 2Kb action drop",
         "matchCount": "1",
         "teardown": [
             "$TC actions flush action police"
@@ -743,7 +743,7 @@
         "cmdUnderTest": "$TC actions add action police rate 7mbit burst 1m ok index 1",
         "expExitCode": "0",
         "verifyCmd": "$TC actions ls action police",
-        "matchPattern": "action order [0-9]*:  police 0x1 rate 7Mbit burst 1024Kb mtu 2Kb action pass",
+        "matchPattern": "action order [0-9]*:  police 0x1 rate 7Mbit burst (1024Kb|1Mb) mtu 2Kb action pass",
         "matchCount": "1",
         "teardown": [
             "$TC actions flush action police"
@@ -770,7 +770,7 @@
         "cmdUnderTest": "$TC actions add action police rate 7mbit burst 1m reclassify index 1",
         "expExitCode": "0",
         "verifyCmd": "$TC actions get action police index 1",
-        "matchPattern": "action order [0-9]*:  police 0x1 rate 7Mbit burst 1024Kb mtu 2Kb action reclassify",
+        "matchPattern": "action order [0-9]*:  police 0x1 rate 7Mbit burst (1024Kb|1Mb) mtu 2Kb action reclassify",
         "matchCount": "1",
         "teardown": [
             "$TC actions flush action police"
@@ -797,7 +797,7 @@
         "cmdUnderTest": "$TC actions add action police rate 7mbit burst 1m pipe index 1",
         "expExitCode": "0",
         "verifyCmd": "$TC actions ls action police",
-        "matchPattern": "action order [0-9]*:  police 0x1 rate 7Mbit burst 1024Kb mtu 2Kb action pipe",
+        "matchPattern": "action order [0-9]*:  police 0x1 rate 7Mbit burst (1024Kb|1Mb) mtu 2Kb action pipe",
         "matchCount": "1",
         "teardown": [
             "$TC actions flush action police"
-- 
2.34.1


