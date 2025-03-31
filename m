Return-Path: <netdev+bounces-178404-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D849CA76DCB
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 21:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F88516B06D
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 19:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ACCA218EB1;
	Mon, 31 Mar 2025 19:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="wQfNtAoa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A68218585
	for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 19:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743451006; cv=none; b=Uww07w1+FZmuNAhNJbRqDQTcoPDYNW+xjPnHTCx5U6/ed9v2CmAZsA5TCxTvOrgAuc+JyMV5iIiI9cwJIB/i5pcjMEEqfJSJD6BUiMjsN9zwA5o6sg9Ln8BLMJQHXXtP9TFmLC4XJCTmJYgdrqgIS2Q+77hjyGhmU5Sy23fSCt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743451006; c=relaxed/simple;
	bh=vAxCqO8D+zzqb/qZNB5/FCTsdHivJpMM4FMnnmj32U8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WoOXSXQnVIQQwQXDF3UfsJiLfnXrb3TKtQGqOXOXaKwAzYtx0KDYbCWShELEGwq1RaH5O9rm0mQXt/COQaKVXOXz4SQt4Jwu/vL/+GdT9qEA/VlXL54NQxyNXbdC1LuxNbLECLCZoE3ClXoyDHSvlf1pFOYVkx5lwYAv+VDglnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=wQfNtAoa; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-223fd89d036so102402885ad.1
        for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 12:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1743451003; x=1744055803; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AzqSa6qdLoYyh4MHGFR7tGBhWMYj3VcZWbyxOBNFEgk=;
        b=wQfNtAoaOTDHACeqKolF4hex7jcF2MtR0IXe8aOTrPmPKl+i4PZsYiY5ZiBCyPe0O8
         biyyGGStZ7YLhpArvX7dAPP2s6Vw4ol4yjVoBLmLMy8ZNBGcSje55I0ZYxJ0ADUBv/CR
         QZAkPBy2ZrSvZgIjMsRSW5CVFAONkd66D/U5/EKvVsju/36x2IXaD46GraGR+/HS3aKV
         2glsO1EFZo4uFjS4X41oq5uvivVRGxQ0LXiprr6I+3NwWtGdWMlyG5IyNV2pOOaTczj5
         ODs6Y+OXVosnLKksBj3XZNceha19Wr12Y8fZWp8XmIOA4IqdIoSw5MVaIiGwPdJlERqz
         JWvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743451003; x=1744055803;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AzqSa6qdLoYyh4MHGFR7tGBhWMYj3VcZWbyxOBNFEgk=;
        b=WEU+OkMPoNSLzyUlEHwoExRsvaq8tJFg6QrPetzKwH8BmBqfGMlo+aGQ/w25+sePg+
         tcJD8tQWjPy54j0k2BBaSHWaHbE31BRa537rjtgpLJ+lERwbCAfi9j5TXVceV5u0kZ29
         5Oun22lnD1PJlVkIgD9m0Arg21ZuKUZrFPG7zXK7d7IyHHh08N16laAhopmfoCZQFIt/
         z53xdG5DoCEqEPQZHyUBtr13RjFizrEKxJVWk23a7/vfJZwCzY1AORLHkkpzuA9VANbQ
         gRcEPCRpy9TL4GBwYXnLDN8lKil6bxuxvwi+y/gE/BXcsENg6gSdqt2Fi3Z+woGHTA2o
         J+mQ==
X-Gm-Message-State: AOJu0YyEf5rAZ3M8B7J3EBHaXF9z6YgaDblLW95iuU2/NxxmAn09o+7n
	as18OoapLdc0ewTZ+2DqIYYNmeehs+8siLRTeoPtiOe8vlIoTBoRNyA6s5zRioU5xt416NHkCTg
	=
X-Gm-Gg: ASbGncv+UZx5Mca65k0QcXvzuS6rAQQnQZtqQ+vv8YkGq3OggB2j507urQewgqZUqi+
	4wzV1k31yDGLUT3zlvDDkX0xMTWpvymqE+xipcR+v7z6wvd9dEBfgkyiRMPzNtcor2v+neZ01Yz
	5C/Odb7YWVSKUfPRZjPutuRKToCP1aVtItInmx5Cts8qaGJ504cnyqEW3URYSdOv7XeFylfwbUa
	5ms1hvAdNvOmd8fnILO/qxYbFj/34CMWXaZV3ucBW6q4AwGLrnOICaPMV+Iu1iKr5RzaDQIhkhk
	TbIQeH5kMLdrdsIqDYMR7exORG9pJDWx48lJvsls+jok9ScXlSzoCqLbKwMrj6H2zG+7
X-Google-Smtp-Source: AGHT+IEpEnY4rZKG+/LUO41TSZFdr+jiBWbL1y7GD4aLnGkKhbPHZ+UMnU43ZPvQuWmZC/hfP1zMgw==
X-Received: by 2002:a05:6a00:3901:b0:736:54c9:df2c with SMTP id d2e1a72fcca58-73980415eafmr12174016b3a.15.1743451002841;
        Mon, 31 Mar 2025 12:56:42 -0700 (PDT)
Received: from rogue-one.tail33bf8.ts.net ([179.218.14.134])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73970deee97sm7313082b3a.25.2025.03.31.12.56.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 12:56:42 -0700 (PDT)
From: Pedro Tammela <pctammela@mojatatu.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	shuah@kernel.org,
	pctammela@mojatatu.com,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net] selftests: tc-testing: fix nat regex matching
Date: Mon, 31 Mar 2025 16:56:18 -0300
Message-ID: <20250331195618.535992-1-pctammela@mojatatu.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In iproute 6.14, the nat ip mask logic was fixed to remove a undefined
behaviour. So now instead of reporting '0.0.0.0/32' on x86 and potentially
'0.0.0.0/0' in other platforms, it reports '0.0.0.0/0' in all platforms.

Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
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


