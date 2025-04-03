Return-Path: <netdev+bounces-179183-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 192EDA7B106
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 23:26:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 735A03BB7FD
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 21:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F106D1DFF0;
	Thu,  3 Apr 2025 21:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lcsNE8+r"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F83E2E62CF
	for <netdev@vger.kernel.org>; Thu,  3 Apr 2025 21:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743715014; cv=none; b=HkOhjNd50vNCIQN8T7RLXxZOHLujTDHektKFCK8BqbNaURZpBM+khaGzm3jdum7Vf/CSV49b88hD1DBF7lkCpPxbkV2Lo6N0rgkiPnK9LABeMa8t7UVO7XFyBkI8/nL5YuqVyT3i5L8AirSEXvtS9wAL5j2r1tV/bV+S/jyT2rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743715014; c=relaxed/simple;
	bh=0fPd0Q4/U3z0jrlXytLXpdD/TkEGbEZWkfewqfRVAOk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WVCbModQWg+WGHeCmvvRQ7MoTRxMaY0nmhnFbg2GwLHhw+qg51Oa3oUzXaq4pzFvMPGnBcXBsvXa+LaMESCrNaqqZUT/pcqT3izXWnsy6mX+64z3hc/iV/bcgrLVFNx6nUJvaIXmN6pn7TWjPUs2LZqWQZhvKInC57IoOs9lZVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lcsNE8+r; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-224191d92e4so13779445ad.3
        for <netdev@vger.kernel.org>; Thu, 03 Apr 2025 14:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743715012; x=1744319812; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J8WXVB53LP5Ujulj9nHrc2HMXPJEHmx29rYa03EXBBo=;
        b=lcsNE8+rbdWmirquIC1FgPzPUu/66n8tTHqnGLKd0TlFBTIO/hC02TAT7uF12+R3gK
         63i6hKdotOamRBokHOpfvWWrNPVpkftizxwQ+s0kgWQDtnXxdzglaHXZzz5z+7k/YnZu
         kdREtWeJ8S6iLtNF74TBoQu2sjhsJgPjgzQ7ftAgEfpXWoWGOYfp0KJWXG/CUvSSI7kO
         d0piNVAmtAAgcMeX69EQPGeGBEXbrioCaONayJpWPNST+y8TTjYem/aYCXoRW2/LrMHd
         6rh/XnhFJvIBeQdd5ivqWYn9EN8KOUvTh7z9qfNqmLw2A6R6BC0Pz1vr1vdF6p2CUA7+
         uTPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743715012; x=1744319812;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J8WXVB53LP5Ujulj9nHrc2HMXPJEHmx29rYa03EXBBo=;
        b=HYXOmJJOZzhlC68DuyEIDjBHz5RMCivy4t9WQZDTVSmpFFldCd5DcqZTYZk6a+Lnmi
         oPgnj93GpvkUJQI90J8mTo+IdN43SvKh/+xwl+KaigdCtevqsd1hMFuWi03bYSXt96bn
         Tt6T9bEdekvGujLiBKZdJNz65Ai4wTLdDz15DIKbxZGjs3I3VNRYPYvdA0+e/0oUjGiU
         c5WA8eU5Y6azJmdYA2TRrVGBW+pgu1MgKGIazGzKYzhizJehBawbUggZUlnnb0IAyDc0
         1kHTkB0Ll4x2oZB4E+OBo3XtNi9CqVexkxlXYjkEy22XCwOhjaOUlvoMdeEoNXSyPOaV
         eG3Q==
X-Gm-Message-State: AOJu0Ywyvs+vfJTVVoHK63r+JMuPs5MYQtIY9aeNY3t3KxCXbPgl+aAL
	b/j4zkPqA0hTBuNWWBsO/DbAOnJ0ysA/pTG+uHxAqFbRUT+3Rj5nF3c/6A==
X-Gm-Gg: ASbGncv8Im3ackyhLTLtqd4eQDve+0P/T2LgtdWwCWhtd80AYbAv6AUNQWuXgMT0y8A
	6K29imHWhQ+VHCuSNc3J2QPoi+jT+pzaSYO/0x/w2D06Hooda55qTULRoqMyYFC1LtamleHBigF
	V397aaFOMF2ZXSvnBVsu1PdkjfbqJJnqaAZT8GsZO/7tngCEio2r6PJaPscvTuS51MMC3mH9hKB
	7MQn/Thv5NsRNWaUal8KG803BnflxG0ZD+7+KXY1sW1WjYF3PIDmMAz4wVKO9O1Q7QvfN+UFfae
	Ax8Fh9ZZHvI2W0rQ8PSgnKuvq+b625Om6kVbGyzG+X0k5yB9sN/TZAI=
X-Google-Smtp-Source: AGHT+IGS5bjDHw09VQDO7kmnA2RwNdvZ9uMgmHMNULOgWbRhMmt0TeuBa4hFzZIbUbp3V8nd+S58bw==
X-Received: by 2002:a17:903:120b:b0:216:6901:d588 with SMTP id d9443c01a7336-22a8a0579b1mr8225495ad.15.1743715012290;
        Thu, 03 Apr 2025 14:16:52 -0700 (PDT)
Received: from pop-os.scu.edu ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2297866e1b4sm19332145ad.181.2025.04.03.14.16.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 14:16:51 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	jiri@resnulli.us,
	victor@mojatatu.com,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Pedro Tammela <pctammela@mojatatu.com>
Subject: [Patch net v2 07/11] selftests/tc-testing: Add a test case for FQ_CODEL with HTB parent
Date: Thu,  3 Apr 2025 14:16:32 -0700
Message-Id: <20250403211636.166257-2-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250403211636.166257-1-xiyou.wangcong@gmail.com>
References: <20250403211033.166059-1-xiyou.wangcong@gmail.com>
 <20250403211636.166257-1-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a test case for FQ_CODEL with HTB parent to verify packet drop
behavior when the queue becomes empty. This helps ensure proper
notification mechanisms between qdiscs.

Note this is best-effort, it is hard to play with those parameters
perfectly to always trigger ->qlen_notify().

Cc: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
---
 .../tc-testing/tc-tests/infra/qdiscs.json     | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json b/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
index 25454fd95537..545966b6adc6 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
@@ -158,5 +158,36 @@
             "$TC qdisc del dev $DUMMY handle 1: root",
             "$IP addr del 10.10.10.10/24 dev $DUMMY || true"
         ]
+    },
+    {
+        "id": "a4bb",
+        "name": "Test FQ_CODEL with HTB parent - force packet drop with empty queue",
+        "category": [
+            "qdisc",
+            "fq_codel",
+            "htb"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "$IP link set dev $DUMMY up || true",
+            "$IP addr add 10.10.10.10/24 dev $DUMMY || true",
+            "$TC qdisc add dev $DUMMY handle 1: root htb default 10",
+            "$TC class add dev $DUMMY parent 1: classid 1:10 htb rate 1kbit",
+            "$TC qdisc add dev $DUMMY parent 1:10 handle 10: fq_codel memory_limit 1 flows 1 target 0.1ms interval 1ms",
+            "$TC filter add dev $DUMMY parent 1: protocol ip prio 1 u32 match ip protocol 1 0xff flowid 1:10",
+            "ping -c 5 -f -I $DUMMY 10.10.10.1 > /dev/null || true",
+            "sleep 0.1"
+        ],
+        "cmdUnderTest": "$TC -s qdisc show dev $DUMMY",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -s qdisc show dev $DUMMY | grep -A 5 'qdisc fq_codel'",
+        "matchPattern": "dropped [1-9][0-9]*",
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev $DUMMY handle 1: root",
+            "$IP addr del 10.10.10.10/24 dev $DUMMY || true"
+        ]
     }
 ]
-- 
2.34.1


