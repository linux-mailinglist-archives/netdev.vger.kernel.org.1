Return-Path: <netdev+bounces-171821-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79665A4ED8E
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 20:38:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96E1E171A89
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 19:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B505204F62;
	Tue,  4 Mar 2025 19:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L9YRT8Yb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B692E3371
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 19:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741117118; cv=none; b=m31/GRYH6dNIARBoIqiU5LtwkZoVM1pSM/oCw3xZ4NBLDmw7r7R1hOquqFLwark0F13djCt5ehIVn7P6B8MUcMARf4J1SJo2nQaBA2mcBsX5/F7+okgvBGAm2fAdD6xAyq9DLOC8sL3NLvIY1bIx3h/d2fBug6McvXh40pUKXxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741117118; c=relaxed/simple;
	bh=OeBVVoQdgwgqTCurG+p/NAuJSEvlBBrYzIDwKbAyOqQ=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tKtz/klucsn0tadQNLgGmZ36fJwwARK7Gfjh1Vc52I67oyHbXXd0nsVm7929tlXOJd3TggaxGFsHYteWqPXyMfn6k6JBy7rB6uBN1P7+utAHN3TwyTdMRSAtfyWbF0sEMpVZxmB7Z/eb3PgZ6z2ETvpRWbUKJFsU/RfDga6tV5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L9YRT8Yb; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2ff087762bbso4175428a91.3
        for <netdev@vger.kernel.org>; Tue, 04 Mar 2025 11:38:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741117116; x=1741721916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0ARCC8+pv4wzG5T0BXnIx4KnRpChyalfiBSEMCBZ3N0=;
        b=L9YRT8Yb3LOnVZW30lPPLGfTINemJ9xRlfgjhfSII0q/GIw+twKxWwht8PFywQD3SA
         InuBehx/cYIziifNoT/api7LQwuunrdbpmsgiATqErWrODZSHG3DIY8NwwJNPd9hcF3S
         1HMddHpPJd/a3zu9jLX04mn74Vdw/x85WF/1zgX3kRHB+CA8cIBjPpw66pzYJ7UkMdnL
         A2jhMynkzOWTr7W9rGQ/hm7xseC5H+vdc+QpgjL9m8obC8TmMDDL2d43szQQivPzkggZ
         goObE6oLcH4eAlP328oew32574CxLdv2O49TFuHYzATfsqRxCcoAqSU+klRcSgbtmWY7
         ipdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741117116; x=1741721916;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0ARCC8+pv4wzG5T0BXnIx4KnRpChyalfiBSEMCBZ3N0=;
        b=OuKT98lR12jdGxVBMEFMD/3UBIlKFoAdYkaAB4YIK2o4pXBzeAy4h7cfoUj57ECfdx
         LmBi6U+KpTxre13Yh4U9G9aIvOvlPPeKcu0YRiodNJlE/RqPnPjqJs/uulLzDDGE0wAj
         nZVIkwyiZP4FdG4cdW8y/CRqMLRTbl4t+zXKoP0TgOiebrxkmcCD/A9G8NqehpKhjJjW
         34FppiCeKGu2jwG3KyZTKmOVqqnsnhfbKx3SbpgG6qnSydPADGxKp2ItlVa9qNq1Y0AG
         56ymUbiFN0BO3krpQ7EnLCesvum3Co9OLkM1rapAegeRmiymLk9gz2ohf4dMzxiS+XPd
         ITUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwPldWBNjs0pRdAxTIYZMWwGQNqpjwO3lfUL+Coq1Lfhc+Nem3gDdEL9loLviswTpnt0NW3yI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJPKAtARnE4abUH2pIFMfgf5we+8AZ7HmYP+F58FRhlbyTTeM/
	r1ZMxjjCsRPu8J15ArBYJBd+lOh070ij0RxM3fCHslPd7vbGXHLP
X-Gm-Gg: ASbGnctJcpZDERKJK3MAj6cxISmz5uKOtjp9KSAGopzeDcKhlLLJl32f8TAH/fZE9AO
	b784Kqsiqn+Vpb0OxbFwYVw8/rf3rpaZcVkMEUzWELh3Vw7F/tFuWzLHfMGwqWcYetz+GDlrHUi
	MlkbkJ+rqKmZgi7abRczCSDJw52ZtuXtIdYdrHgKbKxrggYQJACqnUQVKMtYz0CW9UKcp0xI/zy
	Vq2Ds4CdpQqMs+6Rk2QQN6PDUDFZ14HlL8sfZxwMQFaaXobqLeqK72Lr/3Z0vXvA2I+yvk52Or1
	7NQsbTJarEBMuVYlNySW7RiNn5qJ5c6OCMAsviIdNchpNAKa2Tt2BgaMSGOurDoQRbujv8Y=
X-Google-Smtp-Source: AGHT+IGz9nTR8lsUflPJb+wPqUaw2XZYHqDgTZqNEr65gwk6uSWBqSi08DWxM1C0YoOgNeM36NRjUg==
X-Received: by 2002:a17:90b:5112:b0:2ee:c9b6:4c42 with SMTP id 98e67ed59e1d1-2ff49790657mr915172a91.16.1741117115973;
        Tue, 04 Mar 2025 11:38:35 -0800 (PST)
Received: from jlennox2.jitsi.com ([129.146.236.57])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fea6753137sm11505994a91.6.2025.03.04.11.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 11:38:35 -0800 (PST)
From: Jonathan Lennox <jonathan.lennox42@gmail.com>
X-Google-Original-From: Jonathan Lennox <jonathan.lennox@8x8.com>
To: Jonathan Lennox <jonathan.lennox@8x8.com>,
	Jonathan Lennox <jonathan.lennox42@gmail.com>,
	David Ahern <dsahern@kernel.org>,
	netdev@vger.kernel.org,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH net-next] tc-tests: Update tc police action tests for tc buffer size rounding fixes.
Date: Tue,  4 Mar 2025 19:38:13 +0000
Message-Id: <20250304193813.3225343-1-jonathan.lennox@8x8.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2d8adcbe-c379-45c3-9ca9-4f50dbe6a6da@mojatatu.com>
References: <2d8adcbe-c379-45c3-9ca9-4f50dbe6a6da@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------2.34.1"
Content-Transfer-Encoding: 8bit

This is a multi-part message in MIME format.
--------------2.34.1
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit


Before tc's recent change to fix rounding errors, several tests which
specified a burst size of "1m" would translate back to being 1048574
bytes (2b less than 1Mb).  sprint_size prints this as "1024Kb".

With the tc fix, the burst size is instead correctly reported as
1048576 bytes (precisely 1Mb), which sprint_size prints as "1Mb".

This updates the expected output in the tests' matchPattern values
accordingly.

Signed-off-by: Jonathan Lennox <jonathan.lennox@8x8.com>
---
 .../selftests/tc-testing/tc-tests/actions/police.json  | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)


--------------2.34.1
Content-Type: text/x-patch; name="0001-tc-tests-Update-tc-police-action-tests-for-tc-buffer.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline; filename="0001-tc-tests-Update-tc-police-action-tests-for-tc-buffer.patch"

diff --git a/tools/testing/selftests/tc-testing/tc-tests/actions/police.json b/tools/testing/selftests/tc-testing/tc-tests/actions/police.json
index dd8109768f8f..ae31dbeb45d8 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/actions/police.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/actions/police.json
@@ -689,7 +689,7 @@
         "cmdUnderTest": "$TC actions add action police rate 7mbit burst 1m continue index 1",
         "expExitCode": "0",
         "verifyCmd": "$TC actions get action police index 1",
-        "matchPattern": "action order [0-9]*:  police 0x1 rate 7Mbit burst 1024Kb mtu 2Kb action continue",
+        "matchPattern": "action order [0-9]*:  police 0x1 rate 7Mbit burst 1Mb mtu 2Kb action continue",
         "matchCount": "1",
         "teardown": [
             "$TC actions flush action police"
@@ -716,7 +716,7 @@
         "cmdUnderTest": "$TC actions add action police rate 7mbit burst 1m drop index 1",
         "expExitCode": "0",
         "verifyCmd": "$TC actions ls action police",
-        "matchPattern": "action order [0-9]*:  police 0x1 rate 7Mbit burst 1024Kb mtu 2Kb action drop",
+        "matchPattern": "action order [0-9]*:  police 0x1 rate 7Mbit burst 1Mb mtu 2Kb action drop",
         "matchCount": "1",
         "teardown": [
             "$TC actions flush action police"
@@ -743,7 +743,7 @@
         "cmdUnderTest": "$TC actions add action police rate 7mbit burst 1m ok index 1",
         "expExitCode": "0",
         "verifyCmd": "$TC actions ls action police",
-        "matchPattern": "action order [0-9]*:  police 0x1 rate 7Mbit burst 1024Kb mtu 2Kb action pass",
+        "matchPattern": "action order [0-9]*:  police 0x1 rate 7Mbit burst 1Mb mtu 2Kb action pass",
         "matchCount": "1",
         "teardown": [
             "$TC actions flush action police"
@@ -770,7 +770,7 @@
         "cmdUnderTest": "$TC actions add action police rate 7mbit burst 1m reclassify index 1",
         "expExitCode": "0",
         "verifyCmd": "$TC actions get action police index 1",
-        "matchPattern": "action order [0-9]*:  police 0x1 rate 7Mbit burst 1024Kb mtu 2Kb action reclassify",
+        "matchPattern": "action order [0-9]*:  police 0x1 rate 7Mbit burst 1Mb mtu 2Kb action reclassify",
         "matchCount": "1",
         "teardown": [
             "$TC actions flush action police"
@@ -797,7 +797,7 @@
         "cmdUnderTest": "$TC actions add action police rate 7mbit burst 1m pipe index 1",
         "expExitCode": "0",
         "verifyCmd": "$TC actions ls action police",
-        "matchPattern": "action order [0-9]*:  police 0x1 rate 7Mbit burst 1024Kb mtu 2Kb action pipe",
+        "matchPattern": "action order [0-9]*:  police 0x1 rate 7Mbit burst 1Mb mtu 2Kb action pipe",
         "matchCount": "1",
         "teardown": [
             "$TC actions flush action police"

--------------2.34.1--



