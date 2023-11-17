Return-Path: <netdev+bounces-48757-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 180387EF6CE
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 18:12:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99AE3281290
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 17:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C98743163;
	Fri, 17 Nov 2023 17:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="wD8d0+5F"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7453CD79
	for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 09:12:41 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1cc3c51f830so18222065ad.1
        for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 09:12:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1700241161; x=1700845961; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5sFgMe+AuXutIDLD0oR35V1Wr0GcNbXboHMMBFDV8h8=;
        b=wD8d0+5FYKfc+rbNtjZx2XazYiI70/fA2K/9LqgJ3dYGEDwRRjeJJB1VuwDuyffiG3
         PuER6UvOL8qkCsuhRW3pXoy4lxyeMDKzKkdyyBimqYX7BlFtcupZOa2vGKuG/WOnjp41
         +xWcArbTZyyahiZzgWAnOLvvAx0uhENp9JjxKAIaGgqHBYUh3cSipoZ9Evno88/QExFV
         ZaXyG6KgMbB3h7dYDV+GvJeYLPrHrDBE7ScwZEHAg1YqqpNKEZ7aeTd7pLNfIVLz8Nz5
         lpgGU+Dq+qBC93CdtC4U9duiXAEnkj55ElF5pBR7E1iZj/pqzjzZVLJHdMc2l5G1t4yZ
         OaAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700241161; x=1700845961;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5sFgMe+AuXutIDLD0oR35V1Wr0GcNbXboHMMBFDV8h8=;
        b=b7xMWmN6u1yFHT2+iAOTnXubuTnyiJE5qTlO0n1XWCHsthHQA9Ph/8V8cJHklYcfxF
         QJstTAaaJuAe2ofiPmlPfvl+oLx1nK/j7C1ic2wjbbfEpm6+A3dMnlcbBYxNlVvc1iWr
         m35krh3ycd1d1F2jZbeLF5XefTjQbhwHbS7/fCydcmH3JlQl67JGjPHtFs9wC+0pMFBA
         RFVU543UrCeUQlkaHuww+BhjIIKsJyvW9IolcDFxcQ7IVApwi4njYQyvo2dGy4crqdc7
         8kOdbOVoDNOat8SOIXCwaFjHFlJ6E5m+7/AXfgzL3BtD6bTz/1h5E1Xw2Uba+j2rKYRO
         A4+A==
X-Gm-Message-State: AOJu0Yz+tLAOg3ZQU+BZ1KkYG156VouR0o8f3FHGjlFOiOyqBJOE6/Hp
	Y6SVbDQ9+lYypsQMKzfJoc/36nQJTgauGMQW1Go=
X-Google-Smtp-Source: AGHT+IFB2SxTHkLQnD+QJwN2OjwQGluzURrQNK3Z2ZoSDnFCcVJl1zvHnuzFDpo9Ds3k0ahrZ0tIGQ==
X-Received: by 2002:a17:902:d50d:b0:1ce:1892:2fa6 with SMTP id b13-20020a170902d50d00b001ce18922fa6mr385321plg.0.1700241160635;
        Fri, 17 Nov 2023 09:12:40 -0800 (PST)
Received: from rogue-one.tail33bf8.ts.net ([2804:14d:5c5e:44fb:49f6:37e1:cbd9:76d])
        by smtp.gmail.com with ESMTPSA id c4-20020a170902c1c400b001ce5f0de726sm1343979plc.70.2023.11.17.09.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 09:12:40 -0800 (PST)
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
Subject: [PATCH net-next 4/6] selftests: tc-testing: leverage -all in suite ns teardown
Date: Fri, 17 Nov 2023 14:12:06 -0300
Message-Id: <20231117171208.2066136-5-pctammela@mojatatu.com>
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

Instead of listing lingering ns pinned files and delete them one by one, leverage '-all'
from iproute2 to do it in a single process fork.

Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
---
 .../testing/selftests/tc-testing/plugin-lib/nsPlugin.py  | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/tc-testing/plugin-lib/nsPlugin.py b/tools/testing/selftests/tc-testing/plugin-lib/nsPlugin.py
index 920dcbedc395..7b674befceec 100644
--- a/tools/testing/selftests/tc-testing/plugin-lib/nsPlugin.py
+++ b/tools/testing/selftests/tc-testing/plugin-lib/nsPlugin.py
@@ -74,13 +74,12 @@ class SubPlugin(TdcPlugin):
             print('{}.post_suite'.format(self.sub_class))
 
         # Make sure we don't leak resources
-        for f in os.listdir('/run/netns/'):
-            cmd = self._replace_keywords("$IP netns del {}".format(f))
+        cmd = "$IP -a netns del"
 
-            if self.args.verbose > 3:
-                print('_exec_cmd:  command "{}"'.format(cmd))
+        if self.args.verbose > 3:
+            print('_exec_cmd:  command "{}"'.format(cmd))
 
-            subprocess.run(cmd, shell=True, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
+        subprocess.run(cmd, shell=True, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
 
     def adjust_command(self, stage, command):
         super().adjust_command(stage, command)
-- 
2.40.1


