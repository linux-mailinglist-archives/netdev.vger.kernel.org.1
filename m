Return-Path: <netdev+bounces-50359-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1019A7F56D6
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 04:11:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FACF1C20DDD
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 03:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5EF77493;
	Thu, 23 Nov 2023 03:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y4WAyrsu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4EE6133
	for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 03:10:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5A97C433C7;
	Thu, 23 Nov 2023 03:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700709053;
	bh=xrvJzBE5n95XKBXUHJ0b8Xa+oX8tWmkFE415/3lK8AE=;
	h=From:To:Cc:Subject:Date:From;
	b=Y4WAyrsuCntTBg5n3rIOkM5SeS7MQa9WSmkjsuH4T3UMgD8yDMy6Xtxv9HguMDDKG
	 76V8DGFB+qfPzu2efqtJZASOWz24cpMgp5MkA9/QD7H8aRXwxafg+OYNE8CueBFsNv
	 7QF3XISz5JdTjpnVh+J3jTwcbOaS3ELJEk+4IJm/Y553An0HN5YecHezDO+cWTaLex
	 Mda1X4ZoQX14k88YDST30wxZbVzTsRWvrBq2RQI3CvXo5ihIoAefIzLq4dhT9S8CF7
	 tq6BkqaHoT9OW8hGumR3UBu7wephYCkWfiX4HSBqt0hRAfsCCzdzBj0yrZYcJXaxom
	 CLVZfvyyskb2Q==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next] tools: ynl-gen: use enum name from the spec
Date: Wed, 22 Nov 2023 19:10:50 -0800
Message-ID: <20231123031050.1614505-1-kuba@kernel.org>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The enum name used for id-to-str table does not handle
the enum-name override in the spec correctly.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/ynl-gen-c.py | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/ynl-gen-c.py
index 88a1e50e6ba8..b891044ecb14 100755
--- a/tools/net/ynl/ynl-gen-c.py
+++ b/tools/net/ynl/ynl-gen-c.py
@@ -755,11 +755,17 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
         if 'enum-name' in yaml:
             if yaml['enum-name']:
                 self.enum_name = 'enum ' + c_lower(yaml['enum-name'])
+                self.user_type = self.enum_name
             else:
                 self.enum_name = None
         else:
             self.enum_name = 'enum ' + self.render_name
 
+        if self.enum_name:
+            self.user_type = self.enum_name
+        else:
+            self.user_type = 'int'
+
         self.value_pfx = yaml.get('name-prefix', f"{family.name}-{yaml['name']}-")
 
         super().__init__(family, yaml)
@@ -1483,8 +1489,8 @@ _C_KW = {
 
 def _put_enum_to_str_helper(cw, render_name, map_name, arg_name, enum=None):
     args = [f'int {arg_name}']
-    if enum and not ('enum-name' in enum and not enum['enum-name']):
-        args = [f'enum {render_name} {arg_name}']
+    if enum:
+        args = [enum.user_type + ' ' + arg_name]
     cw.write_func_prot('const char *', f'{render_name}_str', args)
     cw.block_start()
     if enum and enum.type == 'flags':
@@ -1516,9 +1522,7 @@ _C_KW = {
 
 
 def put_enum_to_str_fwd(family, cw, enum):
-    args = [f'enum {enum.render_name} value']
-    if 'enum-name' in enum and not enum['enum-name']:
-        args = ['int value']
+    args = [enum.user_type + ' value']
     cw.write_func_prot('const char *', f'{enum.render_name}_str', args, suffix=';')
 
 
-- 
2.42.0


