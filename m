Return-Path: <netdev+bounces-48756-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BA2F7EF6CC
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 18:12:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E325028116C
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 17:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A6543152;
	Fri, 17 Nov 2023 17:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="sd5eOrNm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B230D57
	for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 09:12:38 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1cc3388621cso25046265ad.1
        for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 09:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1700241157; x=1700845957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4sSM2YYcJWYCrctxv7+5tEvoUWWBO1kFQOKrhYqc9ds=;
        b=sd5eOrNmGRO4dX7PnMsRQ8Mu3TOMnr0N1bF1uo9fuyFsrSnYIg8b7S+RaQF9dyzQLL
         WdIyNWjx2BaQ9kZYGGDKiKLkOVn0+Onun6BBuQNPDROT73jQp3Wy6v6bgslMyccpMLzU
         1VVj8kc1QnyHLovx9s2Axdqbs5WxmlOrqb2ATneRmX7cH6NZoaYW5mMIYING4GaaZKGh
         NUgV5N7nFAy0y+15M3erdcOx19AZKnrPQ+/ilWaGggHE0HHizNJv9TTmydVx/RlmRpXl
         c+UX/TPdjHZZLjeUqxZQyuVuQrh2MmS7hGWQkZlYjiQguHHN1ZbTkz2sRuyOaGiRnQ9h
         VMwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700241157; x=1700845957;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4sSM2YYcJWYCrctxv7+5tEvoUWWBO1kFQOKrhYqc9ds=;
        b=KeBiflu6ErnuTeBGrFZ3764uxbKAbysymouk1+hm9fnVW+fJSkL8+Wh33Rb1lSJX6H
         sdedBhvbPFRyJvDyzSHF63vY9n6LmJXRQ5t38xVcpJ1/W+R8+6Q3KMb4FPIbELCwQdkV
         stxgzAF1fzkhRoQSevF6oEXds4AlKGB5w3ZxIbfqk9DMImvn6qo3r0klgivnBN7AxTEg
         /8o8bb6RHKRGt6oAqSsV3pZV7a7yuviXoCD/OmsZp0a6xCSiDQFj6tLY4kIWQ+YXezbw
         Y5c1yozSjGoDT9ZlihvAxD/L5gQUpHThvrt+Lop0gbKYI1NjPazSv7ZgeMOIowHEAmCL
         0P0g==
X-Gm-Message-State: AOJu0YyL4AkZpSJZcfpmGZOrQNJZD1zAlYlJuxxSco4ZA7E8gx3qW98P
	AkwB+Bhk78qWo0A4/c/v9tt6r0w6UArGugMLx6g=
X-Google-Smtp-Source: AGHT+IGFk6zQcJi6Wrn5fa+btHvWP9izBoZjX6bY2ibKD4OLNn1EImDdOkNlxHAS5eO+XWSzWSxgVA==
X-Received: by 2002:a17:902:e845:b0:1cc:6078:52ff with SMTP id t5-20020a170902e84500b001cc607852ffmr7283744plg.26.1700241157386;
        Fri, 17 Nov 2023 09:12:37 -0800 (PST)
Received: from rogue-one.tail33bf8.ts.net ([2804:14d:5c5e:44fb:49f6:37e1:cbd9:76d])
        by smtp.gmail.com with ESMTPSA id c4-20020a170902c1c400b001ce5f0de726sm1343979plc.70.2023.11.17.09.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 09:12:37 -0800 (PST)
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
Subject: [PATCH net-next 3/6] selftests: tc-testing: use netns delete from pyroute2
Date: Fri, 17 Nov 2023 14:12:05 -0300
Message-Id: <20231117171208.2066136-4-pctammela@mojatatu.com>
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

When pyroute2 is available, use the native netns delete routine instead
of calling iproute2 to do it. As forks are expensive with some kernel
configs, minimize its usage to avoid kselftests timeouts.

Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
---
 .../testing/selftests/tc-testing/plugin-lib/nsPlugin.py  | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/tc-testing/plugin-lib/nsPlugin.py b/tools/testing/selftests/tc-testing/plugin-lib/nsPlugin.py
index 2b8cbfdf1083..920dcbedc395 100644
--- a/tools/testing/selftests/tc-testing/plugin-lib/nsPlugin.py
+++ b/tools/testing/selftests/tc-testing/plugin-lib/nsPlugin.py
@@ -64,7 +64,10 @@ class SubPlugin(TdcPlugin):
         if self.args.verbose:
             print('{}.post_case'.format(self.sub_class))
 
-        self._ns_destroy()
+        if netlink == True:
+            self._nl_ns_destroy()
+        else:
+            self._ns_destroy()
 
     def post_suite(self, index):
         if self.args.verbose:
@@ -174,6 +177,10 @@ class SubPlugin(TdcPlugin):
         '''
         self._exec_cmd_batched('pre', self._ns_create_cmds())
 
+    def _nl_ns_destroy(self):
+        ns = self.args.NAMES['NS']
+        netns.remove(ns)
+
     def _ns_destroy_cmd(self):
         return self._replace_keywords('netns delete {}'.format(self.args.NAMES['NS']))
 
-- 
2.40.1


