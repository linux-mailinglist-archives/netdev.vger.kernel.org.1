Return-Path: <netdev+bounces-180819-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F7FBA829A0
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 17:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73A389A0947
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 14:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5AC7278154;
	Wed,  9 Apr 2025 14:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MbDbNWX6"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2348527781B
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 14:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744210298; cv=none; b=j9tQ/vS1vTUnWhBuDVGmVwnN4ufsmRFzDBw0kGpX3qcIbsk7rsSCRxceeIqc8SGMeSjFlsQIb9DFx85NOFDCasi530a9P6I+slvnPcwTjXSVmKtC0m1Iayvr8hkU4EUM8K6sBvjHJ8sjhqdEpoBkRcUu07bzDKcCGmYo9Xn9f0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744210298; c=relaxed/simple;
	bh=4DUob6+eMdIz5RoHjq05jW8GZiksk7IQ/Wo8KKlT220=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kNaQ05gjuaBfgVwwo4e1l9R+orrMWJhP+8kjLHBloTgy0XFJVshu1fiHfV6ZYxrSu56qrcEPpPQG2ZBQ8jOBk0F8F3F/9VJFapBSWYs7u6V6+xj0cYB4IsFn9TmAItikve1owp/JEvkYjs15zS0P0cp6Ta+AdR/sjFPqFwFcPEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MbDbNWX6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744210294;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=WBh/oxXtw+maKeUB3gFYpOwHzm3sbyiLyYnxbG7BaBM=;
	b=MbDbNWX6/p8oo76LjHxXMDBXIz2MDL+8WpCWatrfoinomvDLUhwi5Cfqb6+cRflSTD3MYo
	c12ZbTQIYxZ6WT2nkyYRcNclz9aimGIeH2R0Wp54ks9BeW6xZDWpGqzHAvpN1tZMknLKr5
	M77HZY7uZjdNt3C/RYuLWwH7wNQ2dlo=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-361-ERFNx0UfMOa83i5dvDabzQ-1; Wed, 09 Apr 2025 10:51:32 -0400
X-MC-Unique: ERFNx0UfMOa83i5dvDabzQ-1
X-Mimecast-MFC-AGG-ID: ERFNx0UfMOa83i5dvDabzQ_1744210290
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-ac6ce5fe9bfso149046666b.1
        for <netdev@vger.kernel.org>; Wed, 09 Apr 2025 07:51:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744210289; x=1744815089;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WBh/oxXtw+maKeUB3gFYpOwHzm3sbyiLyYnxbG7BaBM=;
        b=liBtZwToxua8aGuvNUHVgP3WYu0aleNKQ1vNGg+t5y+gwM0wLz3rcO7kXaBRI+m2eS
         zg/gV1hdCfd52ifbK4JLTDPfwWW+XI2dH1WVo2ef/SedqdVcuf4wxtqKEUTL7mMnCeIB
         U2ZgGI+kURBzoQ2LFvWO1wAjKEiE+QuhNDERFL3SPpKowBNkXlU+9pPARaj9ZRkz1YM7
         nHiSXE8K+z/Hv0lXPhHg1PzsmGOkXMdMal6MHzf0fK8rrPfM3NP7HVQQIDhXvXchJZF6
         bQf9eJK/u3f99yH01vFxpacoLKi/ZO1tzIDnmRcvr1N3A0YzY+Q3ht3HtpRRfdWXPd0p
         TBzA==
X-Forwarded-Encrypted: i=1; AJvYcCUrmqzNPI8yh241VCT5ZvTfRQVd59eNG19gJE2Xh95VL4EqL8d5se9Nz8lEZrIRpOKCSwXSUjI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNcFrzndUZMRcRopgetafTaCBXmUa4iDOZQUZt6XHFZJe02Xtx
	Vk/nuxbDfyOrFSDsWFmUrx6aHHWhE8iDryMRst9AQjruGgvgv1TgElbSeVnmVQhruW0E9LzYlRN
	ALFsESwfGOoG13halr1MMyIY2d8ohhB2T2//glsJ1k0ALIC0y6V+Mew==
X-Gm-Gg: ASbGncv5Q5goNlPuU3yTd9wl177FSNaHWbcq2hO1mtxostiNO1eBYuW8yIwrqMQhLZr
	dauwTOeJ/+WKY2PTvB6rHA+r4jsxGZ3N/OcX97zttipHvV6+E7p15pQKJv4/z1KjzP8EKBPj4dF
	AERQGf8Y7BF2YY8fP6jPJwh4RyLUJB5JABvCAKDsGXjv7D3wERZLFeEslkl7ZinTAI0NYQ0Q8dD
	YIaLHsfphA+CHCvhDB8uaBOTMiyrT/rbDzmrwd/1WcwuQarPaz3IYzlDLqY2BfxFv0KrUg3VAiP
	tX0nlr+SyfNvKN83hAEcMMSRLswFp4o3Aw2L
X-Received: by 2002:a17:907:706:b0:ac7:95b0:d0fb with SMTP id a640c23a62f3a-aca9b6bc5f3mr342548066b.34.1744210289581;
        Wed, 09 Apr 2025 07:51:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFy9g+DIrOAE96RAAhVeZY/4RHlv/rCrPjYfagAafONsEIrunVZvC7JorsmpzIoJdHOpPNMcw==
X-Received: by 2002:a17:907:706:b0:ac7:95b0:d0fb with SMTP id a640c23a62f3a-aca9b6bc5f3mr342545466b.34.1744210289199;
        Wed, 09 Apr 2025 07:51:29 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1be9632sm112413866b.66.2025.04.09.07.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 07:51:28 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 6C98F19920EC; Wed, 09 Apr 2025 16:51:27 +0200 (CEST)
From: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org
Subject: [PATCH net] selftests/tc-testing: Add test for echo of big TC filters
Date: Wed,  9 Apr 2025 16:51:22 +0200
Message-ID: <20250409145123.163446-1-toke@redhat.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add a selftest that checks whether the kernel can successfully echo a
big tc filter, to test the fix introduced in commit:

369609fc6272 ("tc: Ensure we have enough buffer space when sending filter netlink notifications")

Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 .../tc-testing/tc-tests/filters/u32.json      | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/filters/u32.json b/tools/testing/selftests/tc-testing/tc-tests/filters/u32.json
index b2ca9d4e991b..67117f86fef0 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/filters/u32.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/filters/u32.json
@@ -353,5 +353,27 @@
         "teardown": [
             "$TC qdisc del dev $DEV1 parent root drr"
         ]
+    },
+    {
+        "id": "33f4",
+        "name": "Check echo of big filter command",
+        "category": [
+            "filter",
+            "u32"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "$TC qdisc add dev $DEV1 parent root handle 10: fq_codel"
+        ],
+        "cmdUnderTest": "bash -c '$TC -echo filter add dev $DEV1 parent 10: u32 match u32 0 0 $(for i in $(seq 32); do echo action pedit munge ip dport set 22; done) | grep \"added filter\"'",
+        "verifyCmd": "",
+        "expExitCode": "0",
+        "matchCount": "0",
+        "matchPattern": "",
+        "teardown": [
+            "$TC qdisc del dev $DEV1 parent root fq_codel"
+        ]
     }
 ]
-- 
2.49.0


