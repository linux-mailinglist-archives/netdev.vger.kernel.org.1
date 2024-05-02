Return-Path: <netdev+bounces-93073-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18BB28B9EC6
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 18:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA2691F2110E
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 16:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6497015E5A9;
	Thu,  2 May 2024 16:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W2pgjOIJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA9B15381F
	for <netdev@vger.kernel.org>; Thu,  2 May 2024 16:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714668053; cv=none; b=kcKvIBEhoIkPWzqTmBwjZtrsA/609vBE8KXLXNpaLekIh/5DEz0NdhYBfPzNiFp2LlCvGL51qGD2qI8w/MKHtPp+DRnC9B+31uVEQPBxD/rHVl6DW+gFDCbU/Mqu5TcAA5j/y+OzvWXrzogl0kSOmIBX2MeCYilQ3oOZL2zsMjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714668053; c=relaxed/simple;
	bh=Z1TyWhfBAPx5vrBG5YIWXpyzDtK3FBu92kbArQtZF0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d9bZu34ibirYQqeu4j/auQ6iwugl6TL892H6EmdJ6ZkU57004CGwB1CHRLnT5oM+dklmYmY44JKCOaV8zt/ZjkFo2T3p8gQTzIfAJGwEWf97eL1I9dShK5AGud9aU8s0X5j6+erd0B9V0Tqu6yBa2WDVTwqZxOZXzRq/Bu0vMM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W2pgjOIJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98703C113CC;
	Thu,  2 May 2024 16:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714668053;
	bh=Z1TyWhfBAPx5vrBG5YIWXpyzDtK3FBu92kbArQtZF0Y=;
	h=From:To:Cc:Subject:Date:From;
	b=W2pgjOIJQOaF5OoIBdRP1onrKBHbATuxCiVc1INVsJqNWe9DmBWF8vV+iJZoGAoz3
	 IKstgp/ACAqv39n2/L/1A5KVPmOVFHHqrho4f4P6Edy6SwMIQ8rH9V1SgtzHKzNZaq
	 XhaeX6srlNt24wtdRFiycP1djx4Y9al7ucYAtsvizk81q5yP0YI5OFivE91Z6Ah6hH
	 LTaJS3HkLDEG9gYjYKpZtBzaUXY6I8XahPyWXiqwzEtVhOA5Ngb0/0rPwnQ4w1FEFt
	 id0TQcd+lN99UidWjcnraYvRBANQyqzA4kyXYx+rp0H6X/qgXJIN0JUzszR/lzMuKH
	 ws20tShn5xjVQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	donald.hunter@gmail.com,
	jiri@resnulli.us,
	alessandromarcolini99@gmail.com
Subject: [PATCH net-next] tools: ynl: add --list-ops and --list-msgs to CLI
Date: Thu,  2 May 2024 09:40:43 -0700
Message-ID: <20240502164043.2130184-1-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I often forget the exact naming of ops and have to look at
the spec to find it. Add support for listing the operations:

  $ ./cli.py --spec .../netdev.yaml --list-ops
  dev-get  [ do, dump ]
  page-pool-get  [ do, dump ]
  page-pool-stats-get  [ do, dump ]
  queue-get  [ do, dump ]
  napi-get  [ do, dump ]
  qstats-get  [ dump ]

For completeness also support listing all ops (including
notifications:

  # ./cli.py --spec .../netdev.yaml --list-msgs
  dev-get  [ dump, do ]
  dev-add-ntf  [ notify ]
  dev-del-ntf  [ notify ]
  dev-change-ntf  [ notify ]
  page-pool-get  [ dump, do ]
  page-pool-add-ntf  [ notify ]
  page-pool-del-ntf  [ notify ]
  page-pool-change-ntf  [ notify ]
  page-pool-stats-get  [ dump, do ]
  queue-get  [ dump, do ]
  napi-get  [ dump, do ]
  qstats-get  [ dump ]

Use double space after the name for slightly easier to read
output.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: donald.hunter@gmail.com
CC: jiri@resnulli.us
CC: alessandromarcolini99@gmail.com
---
 tools/net/ynl/cli.py        | 9 +++++++++
 tools/net/ynl/lib/nlspec.py | 2 ++
 2 files changed, 11 insertions(+)

diff --git a/tools/net/ynl/cli.py b/tools/net/ynl/cli.py
index 058926d69ef0..b8481f401376 100755
--- a/tools/net/ynl/cli.py
+++ b/tools/net/ynl/cli.py
@@ -40,6 +40,8 @@ from lib import YnlFamily, Netlink, NlError
     group.add_argument('--multi', dest='multi', nargs=2, action='append',
                        metavar=('DO-OPERATION', 'JSON_TEXT'), type=str)
     group.add_argument('--dump', dest='dump', metavar='DUMP-OPERATION', type=str)
+    group.add_argument('--list-ops', action='store_true')
+    group.add_argument('--list-msgs', action='store_true')
 
     parser.add_argument('--sleep', dest='sleep', type=int)
     parser.add_argument('--subscribe', dest='ntf', type=str)
@@ -81,6 +83,13 @@ from lib import YnlFamily, Netlink, NlError
     if args.sleep:
         time.sleep(args.sleep)
 
+    if args.list_ops:
+        for op_name, op in ynl.ops.items():
+            print(op_name, " [", ", ".join(op.modes), "]")
+    if args.list_msgs:
+        for op_name, op in ynl.msgs.items():
+            print(op_name, " [", ", ".join(op.modes), "]")
+
     try:
         if args.do:
             reply = ynl.do(args.do, attrs, args.flags)
diff --git a/tools/net/ynl/lib/nlspec.py b/tools/net/ynl/lib/nlspec.py
index 6d08ab9e213f..b6d6f8aef423 100644
--- a/tools/net/ynl/lib/nlspec.py
+++ b/tools/net/ynl/lib/nlspec.py
@@ -335,6 +335,7 @@ jsonschema = None
 
         req_value       numerical ID when serialized, user -> kernel
         rsp_value       numerical ID when serialized, user <- kernel
+        modes           supported operation modes (do, dump, event etc.)
         is_call         bool, whether the operation is a call
         is_async        bool, whether the operation is a notification
         is_resv         bool, whether the operation does not exist (it's just a reserved ID)
@@ -350,6 +351,7 @@ jsonschema = None
         self.req_value = req_value
         self.rsp_value = rsp_value
 
+        self.modes = yaml.keys() & {'do', 'dump', 'event', 'notify'}
         self.is_call = 'do' in yaml or 'dump' in yaml
         self.is_async = 'notify' in yaml or 'event' in yaml
         self.is_resv = not self.is_async and not self.is_call
-- 
2.44.0


