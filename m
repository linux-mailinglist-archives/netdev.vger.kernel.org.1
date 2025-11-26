Return-Path: <netdev+bounces-242037-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B354DC8BB81
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 20:55:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 75DA735C30F
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 19:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9BD34405D;
	Wed, 26 Nov 2025 19:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i2yIRv1A"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2EE5344024
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 19:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764186788; cv=none; b=IioyPm+NBefU3CkOnqaUvfZd5Dui5USLa5c2vPH7vAFSmvSzOpdf4F+Wf/Y4aGKLUiCXfuLeZh38VEOOa/oZEPuRCpMw7VY72LV83guGcN9YBERtKevt9u6Z6Xa7ZJhuS7JmMPeIgFELR9zaf/V+yRMUXeFWk3ITiqQRD5PmuoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764186788; c=relaxed/simple;
	bh=kntrPqgVxKbdQ996gVGP4uixd7rWhrTOhuWETpKlXos=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kkibKxajihkx7NHbEOh2w9j+gA+t/KAnLYvyHRBQZSPcUVJ0dhnLykKxbsKYZ2ZHON+PGndKAvKUejdm2AmvTmj6hOghi4dBRg50NLkv9bxNZFWSF9N04+WM7yHvBwsZkLK0xw7fK52re+hH2A4/MnEuBt0Db3e0MVlQIfQIg9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i2yIRv1A; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7bab7c997eeso109282b3a.0
        for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 11:53:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764186786; x=1764791586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fA3SPZvIKhJTInxC++bFxXWVhONrb+yHCN4v7X82Xwk=;
        b=i2yIRv1AxxSbap07YT3saQOwRDa6ZkJisisOXawK88kpDZkmsKDeTBgXScfSFai9tF
         wLz3fE/4TA4MyNA7O3nl0oI0wobsZXnl9RQmVYOj7bynMTz6P0OQfD1ym5Se8gyKyABk
         88tzwYV0O58tYgaXDYz1m6rjiV18r/JP53TtOBO3twy+NvgiLCk8KZgrUZVrFz367VWL
         324+kdojsbbGsr5+1AEkNak1xJMbtYZb76VdeJ2FCnnp3NYdbGMcBBQOQNTSevXF16VH
         J/V6A+i+VancOtf+vMpfoTzrVfNoVIqDHetz7GSptcWlrp2HnSuvXVTrwRHBV6vSTXNU
         SZbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764186786; x=1764791586;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fA3SPZvIKhJTInxC++bFxXWVhONrb+yHCN4v7X82Xwk=;
        b=IwLqUi8+eA48dEQGZQXPs7fOx9aQjL+VZ2yU4ERoWsZBjNOhIBIyD08jqf83tZBUvc
         aK9nqPUtF4yIxB3BK8lFKlxVUGzlOPBIwZHmNy8CcJRXTdxs2TCnxtbIyjWw7fc8tGp4
         Mk9LAUCm8NV/tHTCNx7MHNTZVFQr2RVA1b0y5KHJYvIulSzHOa/3DTfm5CU92A/DkKhD
         A/QJZfs58y+3Yqt/0eA9HRo4Kt+dSMSFb15VDpBd6FTw/OXJ5zJdvfxUfQMM6+buXcs7
         ki8rTmBThaCOfpj2o00YLoK/Khu3KfPJk/v7a16mbC/xZk6FZL+h0pCvTfIAr8fJ6ZTr
         +EpA==
X-Gm-Message-State: AOJu0YyDR6brPjg2u/fHzC+AFc/ux6zcYrU2HgWXy/W9tHs8D90HTPkR
	oIxQBMN0ecyFAoWhLLYPArkJTsOISbSXnAHNHHwf3e3ciEt6eqxZvDPpbcf/3xFp
X-Gm-Gg: ASbGncu41SYpWu4p5fjFEmB1XdHHHbo4GCOU9GFOHP5Sq1D7XSDTHFS4RdSv0G4+PrP
	0a/6WO1plZGxdhdKaoe12baU77t14p6aTbQq9X9I2VZHQOe56Fa9xin0jKk8NQgDkeMHNLKxxAQ
	En+fP4ejtVXnkiCHrNFQxXIXQ/RfjlIDbGy2cCa7qQuUWK8NSL3nz0JOolIRH1L1qiBbtnSqOw0
	vjponbwCcLe3gY56xSes2rck2+6Twi9BR5uwJs1zziweXwIhpcdjYzbiM+nRmr3I8+tH4AxofHG
	UtBMQ9/8fYemEyyfqgGxxtVPBpg4BvXLCC/Cdlz55LIV1d7OutgC4NBsPovlu8R+uZVc+O7RLZF
	53BGHsJD6mPiHFWTOs4YA8oqfpt5OhiYcW2WVh308zdgnkGwV3L6BXlmQc63QXG3/9AY3+bdA/+
	D7ru9UaD6YOAnmuIiNIqczWcOQdEcBKj3u
X-Google-Smtp-Source: AGHT+IFMINmYSMC1tilYbaZAc65Sd4pDcsvEQyIp2RVnA5kO4nmCWtjC7FCHdqnFqGlOIwOzvRGeaQ==
X-Received: by 2002:a05:7022:2393:b0:119:e569:f279 with SMTP id a92af1059eb24-11c9d865659mr16206199c88.34.1764186785787;
        Wed, 26 Nov 2025 11:53:05 -0800 (PST)
Received: from pop-os.scu.edu ([129.210.115.107])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11c93db4a23sm101508235c88.2.2025.11.26.11.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 11:53:05 -0800 (PST)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: stephen@networkplumber.org,
	kuba@kernel.org,
	Cong Wang <xiyou.wangcong@gmail.com>
Subject: [Patch net v5 8/9] selftests/tc-testing: Add a test case for mq with netem duplicate
Date: Wed, 26 Nov 2025 11:52:43 -0800
Message-Id: <20251126195244.88124-9-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251126195244.88124-1-xiyou.wangcong@gmail.com>
References: <20251126195244.88124-1-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Given that multi-queue NICs are prevalent and the global spinlock issue with
single netem instances is a known performance limitation, the setup using
mq as a parent for netem is an excellent and highly reasonable pattern for
applying netem effects like 100% duplication efficiently on modern Linux
systems.

Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
---
 .../tc-testing/tc-tests/infra/qdiscs.json     | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json b/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
index 1f342173e8fe..ce8c9c14dabb 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
@@ -1035,5 +1035,36 @@
         "teardown": [
             "$TC qdisc del dev $DUMMY clsact"
         ]
+    },
+    {
+        "id": "94a8",
+        "name": "Test MQ with NETEM duplication",
+        "category": [
+            "qdisc",
+            "mq",
+            "netem"
+        ],
+        "plugins": {
+            "requires": ["nsPlugin", "scapyPlugin"]
+        },
+        "setup": [
+            "$IP link set dev $DEV1 up",
+            "$TC qdisc add dev $DEV1 root handle 1: mq",
+            "$TC qdisc add dev $DEV1 parent 1:1 handle 10: netem duplicate 100%",
+            "$TC qdisc add dev $DEV1 parent 1:2 handle 20: netem duplicate 100%"
+        ],
+        "scapy": {
+            "iface": "$DEV0",
+            "count": 5,
+            "packet": "Ether()/IP(dst='10.10.10.1', src='10.10.10.10')/ICMP()"
+        },
+        "cmdUnderTest": "$TC -s qdisc show dev $DEV1",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -s qdisc show dev $DEV1 | grep -A 5 'qdisc netem' | grep -E 'Sent [0-9]+ bytes [0-9]+ pkt'",
+        "matchPattern": "Sent \\d+ bytes (\\d+) pkt",
+        "matchCount": "2",
+        "teardown": [
+            "$TC qdisc del dev $DEV1 root handle 1: mq"
+        ]
     }
 ]
-- 
2.34.1


