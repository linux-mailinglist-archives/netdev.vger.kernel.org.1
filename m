Return-Path: <netdev+bounces-273463-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OOdALGpVy2moGQYAu9opvQ
	(envelope-from <netdev+bounces-273463-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 07:02:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0431A363F87
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 07:02:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EAF46304A560
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 05:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F1034CFCF;
	Tue, 31 Mar 2026 05:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="l+9pM7UB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFDE26D4C3
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 05:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774933346; cv=none; b=ZAZmMzHFt0YIMpmjFJpiWRIXohiOnoI4r7rbdQ0JTMJw/lGPWvf2nME5DWxV0NQEaGlVq17taradkju+sXd1OcqjpvmkdNr+skqjmlWWNkGN2IUyJZyHKU86I6+HZz3HbOIRiVWCDjFGa1FqcEHeL1UGERYBltxc9Qqa3hE0W+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774933346; c=relaxed/simple;
	bh=ijA2JECet5Iqn8ufPr/qjEyMr0tbycswcFP4aRltqM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yhw0GptOZ3AM3ZhgIb3aTBbnWVBlUtSvKO4lUkvnRD64KXfE1wgrsQsmwKXFXOHzW3tweFO6fXXvyuDCTHAop5aK//DRXXsXnFIZdfwySu2b70F/K/St2Wq8+NaK1MbM1ummSjIYC9SUraPkVlod+4y6uZktxM2/HKl6T74b9Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=l+9pM7UB; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2bdd40d3c61so4192257eec.1
        for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 22:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1774933344; x=1775538144; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a4O1BrrcCR9HaMieNMKhDd7YDicwjnJ90a9ij/a6Ygo=;
        b=l+9pM7UBFNNtGVBivJKLMen7lZK24++GL8fVL13/2rGMpIAtZcmuvmmNRubjugUH07
         Gk37cnzWzF1/KCamwZ7FT3+ezPc91e0LZRyak5dUPaEeo+Cmux6acBgagk/q2WDRjvAu
         HcNICnDlOORRRc6O7I+WhPFcin3li/bovMEkRzNstcFGIHTgShrYSRM0k4LBItdmhKJr
         TVMjVDcRqaPUUwrBle1aJ9GAkcTm+qzRPE43dLhYJa1pOwxSYbV9H2pJoenbGJQ0KPOi
         PL/FcHbcqT3bj8PGC4d7AxauzQH/se6xaXt8ZoJNJK9P7AHVibehQ87T7OhilQV/o1qH
         0byw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774933344; x=1775538144;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a4O1BrrcCR9HaMieNMKhDd7YDicwjnJ90a9ij/a6Ygo=;
        b=WUobUJZ4YKg4+Pr48gEUiTB+TqcDIAZ3F6qqA03+4rF5tWhQ6Nz9I9q9W+Hv4w9FPV
         h+R61qBROgxv1dUjQcxsvw/T3JUJtWdnAj8z1v+qCerd76cE1OMSmrWA26AHviIxVoPO
         kWBUM95EtSS0LLlJjoKGiwUg67qeYObqXdqdb1IfUMSkwFifVPv5jUAkreyunZTVuqub
         10WuaJ05GfWVd/8ORf4+ADj5Kj3U0ZJvpi1exJ/Y/QBliBM25j00s/FC762EbH6Nj0GC
         dCL3emif3Nk5VcgQxKeG+eRtNqO+a4XpzTN61+cy1ysF85GYEXscymt4wVyD5k7FrR5X
         ybAQ==
X-Gm-Message-State: AOJu0YzruKJHcns0vXypXjvlsMvEYNB4YkuKqYu2zHopUhgw4ejGnrHK
	T66mk5uZI3qXPb07uNeP+6wIMsFPzZmw3J7kfCAG2r2Y2CnTi0P1gPqDcSZV7gcrvZxmbk3GMtY
	rsTo=
X-Gm-Gg: ATEYQzyDR0NZ115Q4KqzRL5MtS+RsNtfh54t1vEhRJqaQ83goKMxzO9fLqMRuraYshp
	XCbqowqBilpTcUTuVss/QWqtFYOAwFwcWv9h3cSoCkeXNjizbgxzdXCqkd/iCbS02H4EmU9zTqs
	jcvj75SWembPIEIPBRXfXGV3Q68zp+qJSQlrB9QbY/Ss+TMMBqzmrOYMQWaor7YZIU3wFcep8Hi
	Rad5NUVHCW5p5TUD5d1QnccYnivpXZATYLdbumzcIXMD1Tot3SvjGY8FU8KKqkNqmRMa5LXEDQH
	8AfOGP2oMGbBrPnHop16Gs3AlEkghf+KxdN4TyDOGAW/oUTl8h0eTfDrtJwDh4jcLL+Y3tTEEX/
	U8XDa5IHHuyEyeTTzJAzj8GLaXwXzM27Ziu5302am1bMXTKw+nRFFskaIJaelsUEGBPgTwdRxzA
	fqL71PyXja0LgGn+GbRpfrYZg2lx0Flwp2UbDROeQPrMtTuswIMQlW3g==
X-Received: by 2002:a05:7300:f191:b0:2c0:bfe3:b95c with SMTP id 5a478bee46e88-2c185d5571amr7814703eec.4.1774933344181;
        Mon, 30 Mar 2026 22:02:24 -0700 (PDT)
Received: from p1.scai.dhcp.asu.edu (209-147-138-15.nat.asu.edu. [209.147.138.15])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c3c7971d97sm9853819eec.30.2026.03.30.22.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 22:02:23 -0700 (PDT)
From: Xiang Mei <xmei5@asu.edu>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	horms@kernel.org,
	shuah@kernel.org,
	bestswngs@gmail.com,
	Xiang Mei <xmei5@asu.edu>
Subject: [PATCH net v3 3/3] selftests/tc-testing: add tests for cls_fw and cls_flow on shared blocks
Date: Mon, 30 Mar 2026 22:02:17 -0700
Message-ID: <20260331050217.504278-3-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260331050217.504278-1-xmei5@asu.edu>
References: <20260331050217.504278-1-xmei5@asu.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[asu.edu,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[asu.edu:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273463-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[mojatatu.com,resnulli.us,davemloft.net,google.com,kernel.org,gmail.com,asu.edu];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[asu.edu:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[asu.edu:dkim,asu.edu:email,asu.edu:mid]
X-Rspamd-Queue-Id: 0431A363F87
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Regression tests for the shared-block NULL derefs fixed in the previous
two patches:

  - fw: attempt to attach an empty fw filter to a shared block and
    verify the configuration is rejected with EINVAL.
  - flow: create a flow filter on a shared block without a baseclass
    and verify the configuration is rejected with EINVAL.

Signed-off-by: Xiang Mei <xmei5@asu.edu>
---
v2: Correct 3/3 selftest case
v3: make b7e3 forcus on fw_change
 
 .../tc-testing/tc-tests/infra/filter.json     | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/infra/filter.json b/tools/testing/selftests/tc-testing/tc-tests/infra/filter.json
index 8d10042b489b..dbce6436ed26 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/infra/filter.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/infra/filter.json
@@ -22,5 +22,49 @@
         "teardown": [
             "$TC qdisc del dev $DUMMY root handle 1: htb default 1"
         ]
+    },
+    {
+        "id": "b7e3",
+        "name": "Empty fw filter on shared block - rejected at config time",
+        "category": [
+            "filter",
+            "fw"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "$TC qdisc add dev $DEV1 egress_block 1 clsact"
+        ],
+        "cmdUnderTest": "$TC filter add block 1 protocol ip prio 1 fw",
+        "expExitCode": "2",
+        "verifyCmd": "$TC filter show block 1",
+        "matchPattern": "fw",
+        "matchCount": "0",
+        "teardown": [
+            "$TC qdisc del dev $DEV1 clsact"
+        ]
+    },
+    {
+        "id": "c8f4",
+        "name": "Flow filter on shared block without baseclass - rejected at config time",
+        "category": [
+            "filter",
+            "flow"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "$TC qdisc add dev $DEV1 ingress_block 1 clsact"
+        ],
+        "cmdUnderTest": "$TC filter add block 1 protocol ip prio 1 handle 1 flow map key dst",
+        "expExitCode": "2",
+        "verifyCmd": "$TC filter show block 1",
+        "matchPattern": "flow",
+        "matchCount": "0",
+        "teardown": [
+            "$TC qdisc del dev $DEV1 clsact"
+        ]
     }
 ]
-- 
2.43.0


