Return-Path: <netdev+bounces-160736-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED92A1B037
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 07:08:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E58CC188E5E2
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 06:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B361D8E16;
	Fri, 24 Jan 2025 06:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UDRxKT1D"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF34D1D968E
	for <netdev@vger.kernel.org>; Fri, 24 Jan 2025 06:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737698879; cv=none; b=MoWk/6rdHXa22dcdpbTNS6iJBqQ5/dxOtoCMbHtzcIuTey87gkiuHfxRGEfMogrFx/n86TquioLE8IPhWYg94UJkPIZqW48H/p+H42MEMKHhI/H53YvZOTczzLNNhi6c2CwJOlGZSRiIpIcI5URs/yxdXYJVuJonYLvaA5V5lck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737698879; c=relaxed/simple;
	bh=NGQZyMvtGPJctqp/u7KirqF8TEL0GrjtH6RmqQFvBZc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cH5fWwYAfykJkmqTiFR6B2ccIS+3ZDLInwIjocsGlJCniFCzU0vZ9BQcKjr3uopN4AE/GRE/dn+o1l+XL6MmqYHgOIkuW1DJ+n4uEQdzrP1t50j5MlZp3ZbBx1j7w9tsjhTgCto3X2kTjaR2oB02pUzc3cUeBwLWIMVBGnS/nvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UDRxKT1D; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-21649a7bcdcso29954415ad.1
        for <netdev@vger.kernel.org>; Thu, 23 Jan 2025 22:07:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737698877; x=1738303677; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XT1ci9/QE3bV2zcCOvz/9PZR+oE9y+h4s0OlCPGky18=;
        b=UDRxKT1DqM1dN5+/FPKm7sHKG3ntwmeFN+zWAMe7t13/BSshnHafhw9Eqq0wJJPfYl
         KtnCE81gS+o0PZnFhf61ApNve8APqRr6XkkBOQEQ1yzrRWraQHSiNyAzQ/6wcsJgjo/6
         xSnCSn1eaLXJ/4bzqeCgyubVNEN9koJNMD5VfA5EKtbkCc04ePle5P6BOhtNnPiirCoW
         1IWFHvzeLRXN53O8atduDVhd9JqN0Hz0WLottujo4q03sz72gEc/EL+knYuCMmHOTXwa
         /ERqiTyUcNKJXKhGLQTrkfL2tcPzX7jziTt4bjttPX2NpBMK2xYYu+sOYubIakgeqzIl
         7xBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737698877; x=1738303677;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XT1ci9/QE3bV2zcCOvz/9PZR+oE9y+h4s0OlCPGky18=;
        b=mF47RGSJeR/3qdI52KqchBZV/HwEAEx9ZXlH7rUr307Kx1JjjW/J95y1OeJk3xdwIp
         rqFmE6g1pV+DwNqSJadOqP6CI1UYm7Yh+gEcP0YKV8GOndPJsYXqA5AELeT8tRgBSYKF
         9vmjkww+DzwCd+Fh+K7FlU0kJQaZUbkmI9TGDjeMSZC4g8qjOywjr0LjcY4ISB3sff+8
         8zB/sLXmUKaPUS8Gvl2y8IMh0kXji9yUa16XvFYL5v6KcBJ4Z0xnZo1GXvG7LblCV13J
         6T2KWLCoO7w4jk0YnYvw8hpnZyegmeFFm1M44NZcKxIsr3RrJ3uVA6GYWV1KSszqCGte
         Q+4w==
X-Gm-Message-State: AOJu0Yz/d7moTBtnNuf/SBFGuWCJRrVATFvwYV1GoOsWUqOLymxFlVY/
	ZRcrV9mKQkEilq7vUHy5JRH8R0h6d6iOG4Jzw7LpxvUEovGabtpzkGDXfQ==
X-Gm-Gg: ASbGncukUHWGbq0AM2JPtJSjAWcC+oquXZIfRA+fSIhAasKZ8KICwYEjwwhm/9bIMdy
	a4O279esbydfMEPqxc60zWRagLcBpWJTMuYbfbGik0B54gSHp2iD+x7QHqx8sMlDxnuIJv1TPCE
	JmbGqQYJO+Lp0S2rgNCHX+4b9UV5jX77aOB5JR0n4+8FVbJWYA2aBhOaWO8rBgbakyBxHPrKrgl
	UwXdntVmaeX5V2QYw4glgZwbYhaXOCTnc1njBhRBGuTY8fUNQMl6t55It/uvSbXPeoywgfMWPc3
	sT9HQwHvNdvfsKO3Oh0kIR7LzAM0Vonc
X-Google-Smtp-Source: AGHT+IGw8X4zaq91BiGxL9cCMFCn3Ys7WOY0DuoYkH0F/Y2tfMRivH3rsnN0PtVHTVqd/S/n0UYG/w==
X-Received: by 2002:a17:902:f689:b0:215:5935:7eef with SMTP id d9443c01a7336-21c35549f0fmr413151565ad.22.1737698876734;
        Thu, 23 Jan 2025 22:07:56 -0800 (PST)
Received: from pop-os.hsd1.ca.comcast.net ([2601:647:6881:9060:2d85:604b:726:74b9])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da3ea55dasm8696095ad.101.2025.01.23.22.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 22:07:55 -0800 (PST)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	jiri@resnulli.us,
	quanglex97@gmail.com,
	mincho@theori.io,
	Cong Wang <cong.wang@bytedance.com>
Subject: [Patch net 4/4] selftests/tc-testing: add tests for qdisc_tree_reduce_backlog
Date: Thu, 23 Jan 2025 22:07:40 -0800
Message-Id: <20250124060740.356527-5-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250124060740.356527-1-xiyou.wangcong@gmail.com>
References: <20250124060740.356527-1-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Cong Wang <cong.wang@bytedance.com>

Integrate the test case provided by Mingi Cho into TDC.

All test results:

1..4
ok 1 ca5e - Check class delete notification for ffff:
ok 2 e4b7 - Check class delete notification for root ffff:
ok 3 33a9 - Check ingress is not searchable on backlog update
ok 4 a4b9 - Check class qlen notification

Cc: Mingi Cho <mincho@theori.io>
Signed-off-by: Cong Wang <cong.wang@bytedance.com>
---
 .../tc-testing/tc-tests/infra/qdiscs.json     | 34 ++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json b/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
index d3dd65b05b5f..5810869a0636 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
@@ -94,5 +94,37 @@
             "$TC qdisc del dev $DUMMY ingress",
             "$IP addr del 10.10.10.10/24 dev $DUMMY"
         ]
-    }
+    },
+    {
+	"id": "a4b9",
+	"name": "Check class qlen notification",
+	"category": [
+	    "qdisc"
+	],
+	"plugins": {
+	    "requires": "nsPlugin"
+	},
+	"setup": [
+            "$IP link set dev $DUMMY up || true",
+            "$IP addr add 10.10.10.10/24 dev $DUMMY || true",
+            "$TC qdisc add dev $DUMMY root handle 1: drr",
+            "$TC filter add dev $DUMMY parent 1: basic classid 1:1",
+            "$TC class add dev $DUMMY parent 1: classid 1:1 drr",
+            "$TC qdisc add dev $DUMMY parent 1:1 handle 2: netem",
+            "$TC qdisc add dev $DUMMY parent 2: handle 3: drr",
+            "$TC filter add dev $DUMMY parent 3: basic action drop",
+            "$TC class add dev $DUMMY parent 3: classid 3:1 drr",
+            "$TC class del dev $DUMMY classid 1:1",
+            "$TC class add dev $DUMMY parent 1: classid 1:1 drr"
+        ],
+        "cmdUnderTest": "ping -c1 -W0.01 -I $DUMMY 10.10.10.1",
+        "expExitCode": "1",
+        "verifyCmd": "$TC qdisc ls dev $DUMMY",
+        "matchPattern": "drr 1: root",
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev $DUMMY root handle 1: drr",
+            "$IP addr del 10.10.10.10/24 dev $DUMMY"
+        ]
+   }
 ]
-- 
2.34.1


