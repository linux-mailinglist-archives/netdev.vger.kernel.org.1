Return-Path: <netdev+bounces-248770-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B4BCD0DF3A
	for <lists+netdev@lfdr.de>; Sun, 11 Jan 2026 00:32:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6BB333012A50
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 23:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66E7C2C17B3;
	Sat, 10 Jan 2026 23:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KrYgrfNO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4434028C2DD
	for <netdev@vger.kernel.org>; Sat, 10 Jan 2026 23:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768087915; cv=none; b=ZuYqHuscCTdfQnRDOoo4WieQ/+4Vml7obquujeQVEAS8xpmkZS2dgjnw9iANGqIGqXLBZdXeqOx5qV3lcoKymwVM7hmU08c3cWXIGuHTXaVHkRqYVVjcHGZR0XictrCZ2J16uGBGQeoUZIzBT9hwP7T4ZC2qgM7hgQY7IJ7XMAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768087915; c=relaxed/simple;
	bh=yjWOtxpRDVPUIFzhJxj2nrxnTqYzFj6sV8th3iVu4BM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ka8cx//5CbjJDASLDAHQVVhWSnqTjpxyc+RNoVdLxjTSulhYT7gdS88xpLf3B6bz4iE1hbMyYNHw3U8a34TflzXupC1kHRoNjG8+BC6IvlmVYiwDYeJ+94kEG1gkNpbYh0NfEmXXOshbwD4rqpaCqgtrkWCDVBQyUYbF2LZK+V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KrYgrfNO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3427C19423;
	Sat, 10 Jan 2026 23:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768087915;
	bh=yjWOtxpRDVPUIFzhJxj2nrxnTqYzFj6sV8th3iVu4BM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KrYgrfNOdhoHe4pnOLhFKTjA20JL68RB90V988EbxRUKYkI7hjLks8bq/mSD3tpoe
	 LZfcWpAxXWgb/emx2rbPwojaMaRe0gPMax8Pw92g8Ly/hrVLmhj9Ob3kV602lwBYiK
	 KlNvjdqe1GJEhEbBQ2ITbmlC1fqArN/lT11DQ8x6/lanXUb6y5MtOU6SZoJwfrbG0Z
	 52/veBv+n4WxlnXKEF1cGP2x+T6JULSEOaY2ixUsVP8ehNJv2DIF7Z9RVSnilrq7+N
	 D1EZPSPOzuWgg1hhkWDNPjXycE3+B2iaVMnOgKupXC8Y78XDQeXUSUgl3BzO4hJrIE
	 hHT6xC77JWWRw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	sdf@fomichev.me,
	donald.hunter@gmail.com,
	gal@nvidia.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 7/7] tools: ynl: cli: print reply in combined format if possible
Date: Sat, 10 Jan 2026 15:31:42 -0800
Message-ID: <20260110233142.3921386-8-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260110233142.3921386-1-kuba@kernel.org>
References: <20260110233142.3921386-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As pointed out during review of the --list-attrs support the GET
ops very often return the same attrs from do and dump. Make the
output more readable by combining the reply information, from:

  Do request attributes:
    - ifindex: u32
      netdev ifindex

  Do reply attributes:
    - ifindex: u32
      netdev ifindex
    [ .. other attrs .. ]

  Dump reply attributes:
    - ifindex: u32
      netdev ifindex
    [ .. other attrs .. ]

To, after:

  Do request attributes:
    - ifindex: u32
      netdev ifindex

  Do and Dump reply attributes:
    - ifindex: u32
      netdev ifindex
    [ .. other attrs .. ]

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/pyynl/cli.py | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/tools/net/ynl/pyynl/cli.py b/tools/net/ynl/pyynl/cli.py
index 6d2f0412dde0..fdac1ab10a40 100755
--- a/tools/net/ynl/pyynl/cli.py
+++ b/tools/net/ynl/pyynl/cli.py
@@ -120,7 +120,7 @@ RELATIVE_SCHEMA_DIR='../../../../Documentation/netlink'
                     print_attr_list(ynl, nested_names, nested_set, indent + 4)
 
 
-def print_mode_attrs(ynl, mode, mode_spec, attr_set):
+def print_mode_attrs(ynl, mode, mode_spec, attr_set, consistent_dd_reply=None):
     """Print a given mode (do/dump/event/notify)."""
     mode_title = mode.capitalize()
 
@@ -129,8 +129,15 @@ RELATIVE_SCHEMA_DIR='../../../../Documentation/netlink'
         print_attr_list(ynl, mode_spec['request']['attributes'], attr_set)
 
     if 'reply' in mode_spec and 'attributes' in mode_spec['reply']:
-        print(f'\n{mode_title} reply attributes:')
-        print_attr_list(ynl, mode_spec['reply']['attributes'], attr_set)
+        if consistent_dd_reply and mode == "do":
+            title = None  # Dump handling will print in combined format
+        elif consistent_dd_reply and mode == "dump":
+            title = 'Do and Dump'
+        else:
+            title = f'{mode_title}'
+        if title:
+            print(f'\n{title} reply attributes:')
+            print_attr_list(ynl, mode_spec['reply']['attributes'], attr_set)
 
 
 def do_doc(ynl, op):
@@ -138,9 +145,15 @@ RELATIVE_SCHEMA_DIR='../../../../Documentation/netlink'
     print(f'Operation: {color(op.name, Colors.BOLD)}')
     print(op.yaml['doc'])
 
+    consistent_dd_reply = False
+    if 'do' in op.yaml and 'dump' in op.yaml and 'reply' in op.yaml['do'] and \
+       op.yaml['do']['reply'] == op.yaml['dump'].get('reply'):
+        consistent_dd_reply = True
+
     for mode in ['do', 'dump']:
         if mode in op.yaml:
-            print_mode_attrs(ynl, mode, op.yaml[mode], op.attr_set)
+            print_mode_attrs(ynl, mode, op.yaml[mode], op.attr_set,
+                             consistent_dd_reply=consistent_dd_reply)
 
     if 'attributes' in op.yaml.get('event', {}):
         print('\nEvent attributes:')
-- 
2.52.0


