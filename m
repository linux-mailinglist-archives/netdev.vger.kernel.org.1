Return-Path: <netdev+bounces-178621-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D73A3A77E30
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 16:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8401C16319C
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 14:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C663B204F6B;
	Tue,  1 Apr 2025 14:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="geUaY8gt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23AF01E47B3
	for <netdev@vger.kernel.org>; Tue,  1 Apr 2025 14:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743518962; cv=none; b=IKkPyEG0prfwDGeJFBrlTyCA/65vcMds7gM5Ob2Iqbwau4NT/IvELjyDAnm/Jiy5mJDISf+6q1BgxoDTm+4A9U59atH6Rlj+PL7PDaJGFSNVMDsCm3OoqZMXDqDIAcxRIntoC6NJJe3CWf7RapY807HOu5AiQquqzsYSCEXlBLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743518962; c=relaxed/simple;
	bh=zfvY5ilblRz1ZETzZCRpmPJmoOETggjCXhq2caObBnM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qQurHZS2Ob+9NZKx6EWPFutG0U6ynlJtWzLhdIs5PoRCNzY29zTuNoTJQY8KQKzmzT8KIEnyhYa9vyKOp7eEdflVTDxdiqZfew+SN/t4wYhXJ+k6/YqM/y78qyn5AHkxzyDZmU5TC8W0qEuoTjjw1BkJLL1R2SgqB0UFAAcZPQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=geUaY8gt; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2295d78b45cso20550555ad.0
        for <netdev@vger.kernel.org>; Tue, 01 Apr 2025 07:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1743518960; x=1744123760; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nvvg2/Gk/l5x3IN/jgeamuut3HGiVttHMqWOPVL9kGk=;
        b=geUaY8gtEfkK8vIofpS8xtOziY1xAGnsN0IAXQXhP0gfytWpdaM5uFUPWvlpyeQmza
         wSsYGM/ag72ngXM2UmJc1mMLXOWotA/+snZ+SzhSJNti8aq/nSH6LaV+7+EI0KsbvDxj
         OFF/ySyfLkNfYbe5rQewNsffdiKFo3CNUQDCUnedsmvtc1Tin0KaPSMEOaOLjPnyUhVZ
         5qdRgrEHk1FIOubQ1pEThLjwMI9Rbsy6cbGiy9eCoYDql790JpkJWnFHbz4TMJei325t
         Twc6moafz7GnSf4ph3zKbMjZknB73uzb4eoFGUXOmDHU1PRW27cGPHUkiDkD/F2gkAEv
         CcqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743518960; x=1744123760;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nvvg2/Gk/l5x3IN/jgeamuut3HGiVttHMqWOPVL9kGk=;
        b=olN0DiBdibVKJVGJRYuzWR3Nk783ujctVN8Vp0A0kotjtB8zrGPPSmOhIRG8SxQAb5
         fCrtA6rO7QofknetLX87NNLGzaAj7xrqZpeAkm4Mmm5axGsbV8oY/0Dns4Lccdm/RJng
         Vf12ZIqtgYnnQcr43lq1nrLUbXIPnO/rj4/wIm2SoDzJTNo+fMGOCMGuuJIP8RjKCXNY
         ymRNtqBwsiucz672bANjOlxF5UIAYnBaCttyr2fGHrCpu08Pwm6/WikZBB+1kUETtZqL
         Gxosb0b5Y1YWL4uj7owaz1trpsKWGCCrr5mvXmwbtqI+nucR5HXgdX75ukN7u7ONuIhZ
         jZgA==
X-Gm-Message-State: AOJu0YzgVii6SXKdmE9NGeHsdUAUD+Yrmo4mkp7Z2xrw0sV9UETGYk+o
	3z5jZ7m6zRoTg/RWWXPxbxNUJInvZWCAzdFpDzrEjSRw2968iwj8SfWp1ydBXh9+QoZ6Enz9Qso
	=
X-Gm-Gg: ASbGnctnKhkWXGKaNpnrP+ymx/FucscKp+U74LqVR5evfbhxycTpIgppZ+AO4CCG+S4
	mhWSNKEjN2GproIzEuDpt0+yuBA91LlzZ9wZJ8f4k/q/E6BH7njXF6flenH/Vvy2rcYW8QWPHwZ
	f3R0dCYtY9ZN/bCqntk65nmrwTExp1CpHDRvc1NUCUYgcRRJEjgZ3cl7eolSUSPjaSlmIN6uVPx
	w/LYVP1ODWCXtQ5rRfaByXyioVG5Nq1CPqx8yOo8B3xPTwt6khJMnr+X+MLF0SJpt06kvRGc70L
	QTxDrP/RlVwPBB8VU+tVZZamtRatzskjM6aPoNqAL+dV6nb474v86SO/S8zG1f+K9kRB
X-Google-Smtp-Source: AGHT+IFRoyfRjpj2ypIJeacRkpuzmigIRbGGpUfFVuVkeHHePN1/B92eV2AUslffLwHY+8sbiTcM0A==
X-Received: by 2002:a05:6a00:4b0d:b0:736:31cf:2590 with SMTP id d2e1a72fcca58-7398041fd44mr20622359b3a.16.1743518960182;
        Tue, 01 Apr 2025 07:49:20 -0700 (PDT)
Received: from rogue-one.tail33bf8.ts.net ([179.218.14.134])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739710d6a08sm9270954b3a.170.2025.04.01.07.49.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 07:49:19 -0700 (PDT)
From: Pedro Tammela <pctammela@mojatatu.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	shuah@kernel.org,
	pctammela@mojatatu.com,
	linux-kselftest@vger.kernel.org,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net v2] selftests: tc-testing: fix nat regex matching
Date: Tue,  1 Apr 2025 11:49:08 -0300
Message-ID: <20250401144908.568140-1-pctammela@mojatatu.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In iproute 6.14, the nat ip mask logic was fixed to remove an undefined
behaviour[1]. So now instead of reporting '0.0.0.0/32' on x86 and potentially
'0.0.0.0/0' in other platforms, it reports '0.0.0.0/0' in all platforms.

[1] https://lore.kernel.org/netdev/20250306112520.188728-1-torben.nielsen@prevas.dk/

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
---
v2: Add reference to iproute2 commit and collect Simon's reviewed-by
---
 .../selftests/tc-testing/tc-tests/actions/nat.json | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/actions/nat.json b/tools/testing/selftests/tc-testing/tc-tests/actions/nat.json
index ee2792998c89..4f21aeb8a3fb 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/actions/nat.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/actions/nat.json
@@ -305,7 +305,7 @@
         "cmdUnderTest": "$TC actions add action nat ingress default 10.10.10.1 index 12",
         "expExitCode": "0",
         "verifyCmd": "$TC actions get action nat index 12",
-        "matchPattern": "action order [0-9]+:  nat ingress 0.0.0.0/32 10.10.10.1 pass.*index 12 ref",
+        "matchPattern": "action order [0-9]+:  nat ingress 0.0.0.0/0 10.10.10.1 pass.*index 12 ref",
         "matchCount": "1",
         "teardown": [
             "$TC actions flush action nat"
@@ -332,7 +332,7 @@
         "cmdUnderTest": "$TC actions add action nat ingress any 10.10.10.1 index 12",
         "expExitCode": "0",
         "verifyCmd": "$TC actions get action nat index 12",
-        "matchPattern": "action order [0-9]+:  nat ingress 0.0.0.0/32 10.10.10.1 pass.*index 12 ref",
+        "matchPattern": "action order [0-9]+:  nat ingress 0.0.0.0/0 10.10.10.1 pass.*index 12 ref",
         "matchCount": "1",
         "teardown": [
             "$TC actions flush action nat"
@@ -359,7 +359,7 @@
         "cmdUnderTest": "$TC actions add action nat ingress all 10.10.10.1 index 12",
         "expExitCode": "0",
         "verifyCmd": "$TC actions get action nat index 12",
-        "matchPattern": "action order [0-9]+:  nat ingress 0.0.0.0/32 10.10.10.1 pass.*index 12 ref",
+        "matchPattern": "action order [0-9]+:  nat ingress 0.0.0.0/0 10.10.10.1 pass.*index 12 ref",
         "matchCount": "1",
         "teardown": [
             "$TC actions flush action nat"
@@ -548,7 +548,7 @@
         "cmdUnderTest": "$TC actions add action nat egress default 20.20.20.1 pipe index 10",
         "expExitCode": "0",
         "verifyCmd": "$TC actions get action nat index 10",
-        "matchPattern": "action order [0-9]+:  nat egress 0.0.0.0/32 20.20.20.1 pipe.*index 10 ref",
+        "matchPattern": "action order [0-9]+:  nat egress 0.0.0.0/0 20.20.20.1 pipe.*index 10 ref",
         "matchCount": "1",
         "teardown": [
             "$TC actions flush action nat"
@@ -575,7 +575,7 @@
         "cmdUnderTest": "$TC actions add action nat egress any 20.20.20.1 pipe index 10",
         "expExitCode": "0",
         "verifyCmd": "$TC actions get action nat index 10",
-        "matchPattern": "action order [0-9]+:  nat egress 0.0.0.0/32 20.20.20.1 pipe.*index 10 ref",
+        "matchPattern": "action order [0-9]+:  nat egress 0.0.0.0/0 20.20.20.1 pipe.*index 10 ref",
         "matchCount": "1",
         "teardown": [
             "$TC actions flush action nat"
@@ -602,7 +602,7 @@
         "cmdUnderTest": "$TC actions add action nat egress all 20.20.20.1 pipe index 10",
         "expExitCode": "0",
         "verifyCmd": "$TC actions get action nat index 10",
-        "matchPattern": "action order [0-9]+:  nat egress 0.0.0.0/32 20.20.20.1 pipe.*index 10 ref",
+        "matchPattern": "action order [0-9]+:  nat egress 0.0.0.0/0 20.20.20.1 pipe.*index 10 ref",
         "matchCount": "1",
         "teardown": [
             "$TC actions flush action nat"
@@ -629,7 +629,7 @@
         "cmdUnderTest": "$TC actions add action nat egress all 20.20.20.1 pipe index 10 cookie aa1bc2d3eeff112233445566778800a1",
         "expExitCode": "0",
         "verifyCmd": "$TC actions get action nat index 10",
-        "matchPattern": "action order [0-9]+:  nat egress 0.0.0.0/32 20.20.20.1 pipe.*index 10 ref.*cookie aa1bc2d3eeff112233445566778800a1",
+        "matchPattern": "action order [0-9]+:  nat egress 0.0.0.0/0 20.20.20.1 pipe.*index 10 ref.*cookie aa1bc2d3eeff112233445566778800a1",
         "matchCount": "1",
         "teardown": [
             "$TC actions flush action nat"
-- 
2.43.0


