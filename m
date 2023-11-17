Return-Path: <netdev+bounces-48758-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F2937EF6CF
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 18:13:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBB8BB209A0
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 17:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5137C4316C;
	Fri, 17 Nov 2023 17:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="EO8PhBys"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DDB8D68
	for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 09:12:44 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1ce616f12e4so5503255ad.3
        for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 09:12:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1700241164; x=1700845964; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N+qyZzDWnVznUNHIiUa56n6EFtwnakHDNjxkjPjN2zA=;
        b=EO8PhBysquLp+pei+G1gZ5kS0pyrLlF2pONSAYcdKsE40ETiBtQD19DwJy4FYMq0Vr
         P4rHbQ/xyqN+bO9yn9viqkQc2jm/5ZNWqWmFVHatSGmEhBhgliV7oi+9pwBsoDsGYN1i
         daIkAo5tOczMEizlghqEAhFD0Kgp2uXcuQ6HmCxj2oSfFOWie9S3mlJgKw/ldi40H0kN
         IBbZg/a2RWHnsPg8kTBin+mG1i4RW8J/qVpUTceoZNGLY2brS/2cqx3yRVg2JwYvC7WB
         J0ngLnDqcZU97NhGDnWygEaAd+ts3BguNJpeC+1bxZp3ABPvyt9isSFdHqGZXcituoiu
         EKxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700241164; x=1700845964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N+qyZzDWnVznUNHIiUa56n6EFtwnakHDNjxkjPjN2zA=;
        b=f3r3ZZ90rTc0PnRaH4uCnyZq/c4PPkwxXJxe7Oy+F5y5bFQ349MEv9quSYwG21Mwxc
         sA9LT2OoaRsp02uCgwEDMLlswG8SwdTIFDorFx3qLy8GdKujm5geXkRJDyFujJWT5hSZ
         OROYZpb04wmiZd4OMKtvWjyoS6E1NlWXaHlHrhOisTwqshgORcS6mpHdZ7L3TeAWKKKx
         5X51aTHw3ClyKDcm7xiHBsoZkx7BEKxgHiBWwWLPtWH2kZE4VBOuJHppLsp8N38F9JrB
         xdJva6JC/rZy8sMis6OX+zTreClrf7bABYjgNh1jCc/lkIueL+2pHuyX274cKHqrBoR/
         FWgw==
X-Gm-Message-State: AOJu0Ywgc1Vkg1aK6kcdgCe8pwgAABEi1dA2IfZZE4Yj9yaMUJPmxuPI
	HpEKDmm2mHVEdJLxYlpTOrmqggNyUxB/g3sPmtw=
X-Google-Smtp-Source: AGHT+IERm5+OG9eMPjoC9I+G/uPDt9UpN3eCVk41LuZggvbnJkO+cT0Vu+Vg+ti2BgbmunR0ZvraAw==
X-Received: by 2002:a17:902:7682:b0:1b8:954c:1f6 with SMTP id m2-20020a170902768200b001b8954c01f6mr230223pll.36.1700241163825;
        Fri, 17 Nov 2023 09:12:43 -0800 (PST)
Received: from rogue-one.tail33bf8.ts.net ([2804:14d:5c5e:44fb:49f6:37e1:cbd9:76d])
        by smtp.gmail.com with ESMTPSA id c4-20020a170902c1c400b001ce5f0de726sm1343979plc.70.2023.11.17.09.12.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 09:12:43 -0800 (PST)
From: Pedro Tammela <pctammela@mojatatu.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org,
	pctammela@mojatatu.com,
	victor@mojatatu.com
Subject: [PATCH net-next 5/6] selftests: tc-testing: timeout on unbounded loops
Date: Fri, 17 Nov 2023 14:12:07 -0300
Message-Id: <20231117171208.2066136-6-pctammela@mojatatu.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231117171208.2066136-1-pctammela@mojatatu.com>
References: <20231117171208.2066136-1-pctammela@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the spirit of failing early, timeout on unbounded loops that take
longer than 20 ticks to complete. Such loops are to ensure that objects
created are already visible so tests can proceed without any issues.

If a test setup takes more than 20 ticks to see an object, there's
definetely something wrong.

Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
---
 .../selftests/tc-testing/plugin-lib/nsPlugin.py      | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/testing/selftests/tc-testing/plugin-lib/nsPlugin.py b/tools/testing/selftests/tc-testing/plugin-lib/nsPlugin.py
index 7b674befceec..65c8f3f983b9 100644
--- a/tools/testing/selftests/tc-testing/plugin-lib/nsPlugin.py
+++ b/tools/testing/selftests/tc-testing/plugin-lib/nsPlugin.py
@@ -40,7 +40,10 @@ class SubPlugin(TdcPlugin):
             self._ns_create()
 
         # Make sure the netns is visible in the fs
+        ticks = 20
         while True:
+            if ticks == 0:
+                raise TimeoutError
             self._proc_check()
             try:
                 ns = self.args.NAMES['NS']
@@ -49,6 +52,7 @@ class SubPlugin(TdcPlugin):
                 break
             except:
                 time.sleep(0.1)
+                ticks -= 1
                 continue
 
     def pre_case(self, test, test_skip):
@@ -127,7 +131,10 @@ class SubPlugin(TdcPlugin):
         with IPRoute() as ip:
             ip.link('add', ifname=dev1, kind='veth', peer={'ifname': dev0, 'net_ns_fd':'/proc/1/ns/net'})
             ip.link('add', ifname=dummy, kind='dummy')
+            ticks = 20
             while True:
+                if ticks == 0:
+                    raise TimeoutError
                 try:
                     dev1_idx = ip.link_lookup(ifname=dev1)[0]
                     dummy_idx = ip.link_lookup(ifname=dummy)[0]
@@ -136,17 +143,22 @@ class SubPlugin(TdcPlugin):
                     break
                 except:
                     time.sleep(0.1)
+                    ticks -= 1
                     continue
         netns.popns()
 
         with IPRoute() as ip:
+            ticks = 20
             while True:
+                if ticks == 0:
+                    raise TimeoutError
                 try:
                     dev0_idx = ip.link_lookup(ifname=dev0)[0]
                     ip.link('set', index=dev0_idx, state='up')
                     break
                 except:
                     time.sleep(0.1)
+                    ticks -= 1
                     continue
 
     def _ns_create_cmds(self):
-- 
2.40.1


