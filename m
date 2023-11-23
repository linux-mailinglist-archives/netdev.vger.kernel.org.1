Return-Path: <netdev+bounces-50351-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B55A7F56B4
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 04:06:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 348AB281341
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 03:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3071253B6;
	Thu, 23 Nov 2023 03:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X/69nASY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DF65245
	for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 03:06:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F97CC433C7;
	Thu, 23 Nov 2023 03:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700708760;
	bh=2B2vvV3n/qfQp+4iNcM3q4TfvVFY4wyn6vKnW2qO5EE=;
	h=From:To:Cc:Subject:Date:From;
	b=X/69nASYMtyPSOnT364mGCyFyR9SXrQ5LFl7535gjfkuHLhYuchJiHMyeCNByI9OD
	 9sQthIe9YTYukepZvS7WTMITFQtL1F8ARcIUGKZPXNGzuFn0rFJ0eEUuqYbbDPe4Th
	 cwMTHVAf2bCS2dmCjVDDIT4b8W7CD8cCs767SW74nIWeGzAszmUsYyCPnmvRfelk9s
	 OaxsHZcIgENmnndzLLvKVY3Dzo8ZyDSUGDAcvJN/hTTnT/iDNuc1NI5+gwYq3Byc2t
	 N8dm/uJol7qWIBZ8Y4+bdumuxguvCqUaJzUHga5kHPOoya5Zbpn5v6TVpk8beJlFEk
	 bYGdZXxSkW86Q==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	jiri@resnulli.us,
	jacob.e.keller@intel.com
Subject: [PATCH net] tools: ynl: fix duplicate op name in devlink
Date: Wed, 22 Nov 2023 19:05:58 -0800
Message-ID: <20231123030558.1611831-1-kuba@kernel.org>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

We don't support CRUD-inspired message types in YNL too well.
One aspect that currently trips us up is the fact that single
message ID can be used in multiple commands (as the response).
This leads to duplicate entries in the id-to-string tables:

devlink-user.c:19:34: warning: initialized field overwritten [-Woverride-init]
   19 |         [DEVLINK_CMD_PORT_NEW] = "port-new",
      |                                  ^~~~~~~~~~
devlink-user.c:19:34: note: (near initialization for ‘devlink_op_strmap[7]’)

Fixes tag points at where the code was generated, the "real" problem
is that the code generator does not support CRUD.

Fixes: f2f9dd164db0 ("netlink: specs: devlink: add the remaining command to generate complete split_ops")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: jiri@resnulli.us
CC: jacob.e.keller@intel.com
---
 tools/net/ynl/generated/devlink-user.c | 2 +-
 tools/net/ynl/ynl-gen-c.py             | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/net/ynl/generated/devlink-user.c b/tools/net/ynl/generated/devlink-user.c
index bc5065bd99b2..c12ca87ca2bb 100644
--- a/tools/net/ynl/generated/devlink-user.c
+++ b/tools/net/ynl/generated/devlink-user.c
@@ -15,7 +15,7 @@
 /* Enums */
 static const char * const devlink_op_strmap[] = {
 	[3] = "get",
-	[7] = "port-get",
+	// skip "port-get", duplicate reply value
 	[DEVLINK_CMD_PORT_NEW] = "port-new",
 	[13] = "sb-get",
 	[17] = "sb-pool-get",
diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/ynl-gen-c.py
index c4003a83cd5d..3bd6b928c14f 100755
--- a/tools/net/ynl/ynl-gen-c.py
+++ b/tools/net/ynl/ynl-gen-c.py
@@ -1505,6 +1505,12 @@ _C_KW = {
     cw.block_start(line=f"static const char * const {map_name}[] =")
     for op_name, op in family.msgs.items():
         if op.rsp_value:
+            # Make sure we don't add duplicated entries, if multiple commands
+            # produce the same response in legacy families.
+            if family.rsp_by_value[op.rsp_value] != op:
+                cw.p(f'// skip "{op_name}", duplicate reply value')
+                continue
+
             if op.req_value == op.rsp_value:
                 cw.p(f'[{op.enum_name}] = "{op_name}",')
             else:
-- 
2.42.0


