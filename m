Return-Path: <netdev+bounces-48755-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD46A7EF6CA
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 18:12:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29B66280DC0
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 17:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FD743DB9E;
	Fri, 17 Nov 2023 17:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="KQya1Tm0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1C3CD57
	for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 09:12:34 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1cc131e52f1so25272165ad.0
        for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 09:12:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1700241154; x=1700845954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZxDQzw6ad5px6yFhBl5tnkJGwPfE9XAaXdVR53d4yv4=;
        b=KQya1Tm00LfHfngzCT8W6zFsg72buOrdaooLPVGLw+CuiuHQU07VfmODOQAZFlKPp2
         93vL4eYRvE5JmMdODROKFhXlpmvZMc5x2GXc8rXDvPG/CB9gCaiOZa/OEQoAVZGMhbZe
         5gBknA0I9nTA0buiutw2y64k1cFs5qx7dnF4YanoCgeMsIiI5sPdPDDgcF8/K3FeiDAx
         BPdu4hJCfsadyNG41JWwljN/FmTuCdAr61b8wXSnGFQKLM0UWlzBzUh9dUrCy9aOoerS
         JnJtAnmqEnqNSlfR+CM2tTsrM4cBx3AqaYIsAJh447a4miQzrAjeZ5snPZoOb+TW1TGa
         5ZjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700241154; x=1700845954;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZxDQzw6ad5px6yFhBl5tnkJGwPfE9XAaXdVR53d4yv4=;
        b=h70mnp7zL2EgMqyZ3Bi2ZdT3P9KyXy5VXxNaAH590hNEtBYNBzFAcSKsrVu9hDRHSX
         ISduiXi2yyHkftdOqJowL8aCVzCJXHOKeCd/YnTxfx1XhdwGZ6ODEqmu5C0OUhRbPmB/
         V77irszw7l3FctMYjSWOUGFjmsoW0m54OSBLU9DRpDzxPDh/qk2B5bPBCJl6GWTL7AGw
         NK5c3ZgVDcmnpk6XLBAgWapLv55lQw3ZuyyuRKNO1NklwEkFArIWP+4SBni8xruwOD/E
         ANLLyT8xNV+M/3PD3K1NBC0KaivBjZqAbLkMMJ4SGX+z4daZLgz06i4dnJXkk3zhbiZV
         q6Gw==
X-Gm-Message-State: AOJu0Yz9R6fJMw53/NKFJa8bXaUF4A2ryIG66JHrNeGW0vyHogDmgr44
	DtN2jlQADBcT7R2a6QY52hfqd1BrqEVzevWfyQI=
X-Google-Smtp-Source: AGHT+IF2cH447d6VEGuB1MVbsnaSO4m7AUa+vAiCkF0qQHPup8CjAbliC+QXGDaav3HeTShdQU8t8g==
X-Received: by 2002:a17:902:f7cf:b0:1cc:5f5a:5d3 with SMTP id h15-20020a170902f7cf00b001cc5f5a05d3mr6474902plw.22.1700241154151;
        Fri, 17 Nov 2023 09:12:34 -0800 (PST)
Received: from rogue-one.tail33bf8.ts.net ([2804:14d:5c5e:44fb:49f6:37e1:cbd9:76d])
        by smtp.gmail.com with ESMTPSA id c4-20020a170902c1c400b001ce5f0de726sm1343979plc.70.2023.11.17.09.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 09:12:33 -0800 (PST)
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
	victor@mojatatu.com,
	kernel test robot <oliver.sang@intel.com>
Subject: [PATCH net-next 2/6] selftests: tc-testing: move back to per test ns setup
Date: Fri, 17 Nov 2023 14:12:04 -0300
Message-Id: <20231117171208.2066136-3-pctammela@mojatatu.com>
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

Surprisingly in kernel configs with most of the debug knobs turned on,
pre-allocating the test resources makes tdc run much slower overall than
when allocating resources on a per test basis.

As these knobs are used in kselftests in downstream CIs, let's go back
to the old way of doing things to avoid kselftests timeouts.

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202311161129.3b45ed53-oliver.sang@intel.com
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
---
 .../tc-testing/plugin-lib/nsPlugin.py         | 68 +++++++------------
 1 file changed, 25 insertions(+), 43 deletions(-)

diff --git a/tools/testing/selftests/tc-testing/plugin-lib/nsPlugin.py b/tools/testing/selftests/tc-testing/plugin-lib/nsPlugin.py
index 62974bd3a4a5..2b8cbfdf1083 100644
--- a/tools/testing/selftests/tc-testing/plugin-lib/nsPlugin.py
+++ b/tools/testing/selftests/tc-testing/plugin-lib/nsPlugin.py
@@ -17,44 +17,6 @@ except ImportError:
     netlink = False
     print("!!! Consider installing pyroute2 !!!")
 
-def prepare_suite(obj, test):
-    original = obj.args.NAMES
-
-    if 'skip' in test and test['skip'] == 'yes':
-        return
-
-    if 'nsPlugin' not in test['plugins']:
-        return
-
-    shadow = {}
-    shadow['IP'] = original['IP']
-    shadow['TC'] = original['TC']
-    shadow['NS'] = '{}-{}'.format(original['NS'], test['random'])
-    shadow['DEV0'] = '{}id{}'.format(original['DEV0'], test['id'])
-    shadow['DEV1'] = '{}id{}'.format(original['DEV1'], test['id'])
-    shadow['DUMMY'] = '{}id{}'.format(original['DUMMY'], test['id'])
-    shadow['DEV2'] = original['DEV2']
-    obj.args.NAMES = shadow
-
-    if netlink == True:
-        obj._nl_ns_create()
-    else:
-        obj._ns_create()
-
-    # Make sure the netns is visible in the fs
-    while True:
-        obj._proc_check()
-        try:
-            ns = obj.args.NAMES['NS']
-            f = open('/run/netns/{}'.format(ns))
-            f.close()
-            break
-        except:
-            time.sleep(0.1)
-            continue
-
-    obj.args.NAMES = original
-
 class SubPlugin(TdcPlugin):
     def __init__(self):
         self.sub_class = 'ns/SubPlugin'
@@ -65,19 +27,39 @@ class SubPlugin(TdcPlugin):
 
         super().pre_suite(testcount, testlist)
 
-        print("Setting up namespaces and devices...")
+    def prepare_test(self, test):
+        if 'skip' in test and test['skip'] == 'yes':
+            return
 
-        with Pool(self.args.mp) as p:
-            it = zip(cycle([self]), testlist)
-            p.starmap(prepare_suite, it)
+        if 'nsPlugin' not in test['plugins']:
+            return
 
-    def pre_case(self, caseinfo, test_skip):
+        if netlink == True:
+            self._nl_ns_create()
+        else:
+            self._ns_create()
+
+        # Make sure the netns is visible in the fs
+        while True:
+            self._proc_check()
+            try:
+                ns = self.args.NAMES['NS']
+                f = open('/run/netns/{}'.format(ns))
+                f.close()
+                break
+            except:
+                time.sleep(0.1)
+                continue
+
+    def pre_case(self, test, test_skip):
         if self.args.verbose:
             print('{}.pre_case'.format(self.sub_class))
 
         if test_skip:
             return
 
+        self.prepare_test(test)
+
     def post_case(self):
         if self.args.verbose:
             print('{}.post_case'.format(self.sub_class))
-- 
2.40.1


