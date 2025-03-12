Return-Path: <netdev+bounces-174280-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 416FAA5E1FD
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 17:47:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5CE93B3045
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 16:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4A0D23C8A1;
	Wed, 12 Mar 2025 16:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hvUT/0dt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D8418D643
	for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 16:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741798066; cv=none; b=cK9ppxcxz7Tm9WDj42fP8rfqOccMDv8Iyea285ut4yJpZywaSToglucYy2qmLQXCmHFYSxVWHZUd58ZryTuyerIy41Ndi+lEiE38xEcMjsO5ll6wNYDpL2uEy1zYGA6luyaaQE0dSy07qIBYb/sdWF2N96L3FT7d83Nj8OevPdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741798066; c=relaxed/simple;
	bh=0c5S/g/owxivC5AbAwMxgOim8yD64j3DTrj6skoi5io=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RNM9Ieoy9zCl0KVGh9Z7lRxuBsAhMHPSLnCUa8fvoVagGTw2VqnSeY/epRP+wUlRkN0JoybGwUGDssye/C0Wi24C8m4RDftIpj1Sh+IbF5T5a7u9iiM4RJxzuM+Y6ROi3cIV9Oi26ePB55Eu32QJaXT5VTdSeuhRzkEzHFiT7e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hvUT/0dt; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-22401f4d35aso1153315ad.2
        for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 09:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741798064; x=1742402864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dSjWjORF+JX9QV84SOCtC+CRH6HYQinA7zfQCTmRJL8=;
        b=hvUT/0dt4QkfvPJOGvwXy1u3HgLhx+QOJcXSAapWDtfWAigppDaW/nc0aY/+au5y49
         AmGDksQSzMUBxGpeosm3haWCc4h1eoAttBP1qOkfsv9WOzve3ok33rMrtcGt1ntoke6K
         4iKVtS0eujtJeLqO3+0f4YqaU0kD1p/XTxl/m9BEtaHIKpdkhgNy4E1z2WngQv97JFBH
         vzlovQ1pMVoaewqto3p5X5FTCfQiL+HHBpMoUsdDWGilmpcRre7F/S7H/l6gL5O2KqGB
         rNTI9LvrkI0m5Wp8q3LeLi40Rf9wQdZBbNxniVIaOcKtQBaBSF+vWHfajt/83T7pc9UB
         13zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741798064; x=1742402864;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dSjWjORF+JX9QV84SOCtC+CRH6HYQinA7zfQCTmRJL8=;
        b=w6GO+L2OAK+shdo1cMwqjN2QjDO3hDzHgPzxe2JRKBAX1G8/ObW4h7kBJrSr1O5CrF
         BSDiAKiLov61Cc7rcwotSqgyuX5eIpg4oHGw0f9hV2Hzz0bqlrmC5L+MrqUD25iP4cAb
         +SgA4YizXOj9IwRkbxJd1JNmne6qCttPm48nMwc8PGzJmMRFb+BcTNWBVRQ2Ca28Emou
         H/mcOQ1RkMaZqCabOvOU8G25YHUZGVzd8kWXr7XDC2YjDOB/tqz9k88RBWqBQsh6ClkL
         g3uHgFq8y2xbEYRKI/CvPjQ98E+XyQfZjnLGabWKwf5qI1G3w4EA3gjbiUrCmR3nyolX
         rHew==
X-Forwarded-Encrypted: i=1; AJvYcCVQtBi/eSU0gFMPecOu2nY7/MO/J3xRcLOKp7y7jEF85SlD/wyFKpnh8J2ehF+fBGQ4TqCF96M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8WlLig8E+qOnnzkSWE4F7au4jkFR0nI1ZIxVww4TBW0c5dsBr
	SIEOU5/GMkBYfJpY0vBDmd1FCT/I5cMr6bryneSbk+HNvId2AAMW
X-Gm-Gg: ASbGncsucRMOEJV/s/ZBc7N0WQb0zEUmNtWUUWppANDwnagl1yVIbIf6XOIYFqigj0y
	vy4bsTw10NK+Q46eMcLiu95MBzayMsMVIYV+jOezBlfIaPyBrmswYzBf24fzq3gtuHkPxl/b9xh
	XkAcApOfk9msR7D3tXan9qeBYFa75b/DhKn3jT2T3/Mlm9iy1ur7IfISPJlPyB1vZBd4yMUHsOc
	lqdbaVMc2uEhEek6oNGxZp2exRCSdsxA4LmepELn2Y/JAO/XAXnZYAca73jjGGpn+ux8exXwbyC
	9r7lrEqYQvTogPrKSGm0aMZPgdhjZJrFh5V8+1GPurE0x8d/4XImFqkRikos4uY7iy5bR3g=
X-Google-Smtp-Source: AGHT+IGdRDlsAKlppeUQzxW9eXFsBluDKuWjTl5cbIHiYi1ZgoHZy4gmQOgN7kmz+PhPNZbNVlzeEw==
X-Received: by 2002:a17:903:41c2:b0:224:1ec0:8a0c with SMTP id d9443c01a7336-22592e4494emr115665415ad.29.1741798064476;
        Wed, 12 Mar 2025 09:47:44 -0700 (PDT)
Received: from jlennox2.jitsi.com ([129.146.236.57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410aa5c36sm118498105ad.235.2025.03.12.09.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 09:47:43 -0700 (PDT)
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
Subject: [PATCH net-next v2] tc-tests: Update tc police action tests for tc buffer size rounding fixes.
Date: Wed, 12 Mar 2025 16:47:20 +0000
Message-Id: <20250312164720.283689-1-jonathan.lennox@8x8.com>
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
to accept either the old or the new output.

Signed-off-by: Jonathan Lennox <jonathan.lennox@8x8.com>
---
 .../selftests/tc-testing/tc-tests/actions/police.json  | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)


--------------2.34.1
Content-Type: text/x-patch; name="0001-tc-tests-Update-tc-police-action-tests-for-tc-buffer.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline; filename="0001-tc-tests-Update-tc-police-action-tests-for-tc-buffer.patch"

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

--------------2.34.1--



