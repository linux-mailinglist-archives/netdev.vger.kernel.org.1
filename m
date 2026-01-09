Return-Path: <netdev+bounces-248611-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B6084D0C48A
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 22:19:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1D4823055C26
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 21:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D448833CE90;
	Fri,  9 Jan 2026 21:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lp+k5g49"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1EDD33D6E1
	for <netdev@vger.kernel.org>; Fri,  9 Jan 2026 21:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767993505; cv=none; b=RpyeNObUwdW7KayHDBrSTj0amscHNWnwHfYjAMv7sPycrh4BgyNZW2dsVp3+CVoAV3F5sVu4gB+FFDtonPYbfO5RP/5QwyZt+H/ijWDP2hV0WiED7dxxfkgvhVlR/yVfSdGYKPCLoNHo6C1P6yI9t8TdAcHc5qvjIvuigtE9yiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767993505; c=relaxed/simple;
	bh=uMWyn3rGD3iPS8tSEajH/cCHYI/0uH/haYC/OS93YBA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R3QEaRmCXCWHOil0ttqNQ66qoPSu6rXegHd65vZTQUMBddIwp2RtXZ2vZu+6jt+A86JOdbB6rpWeHhW6/ZjgLxy6VRO9HYNu8oIQfLPSEkYhrdytN+4e5ml490aRGNGdMJt2GKy830avV3ONbLIu7SPmxIRlJYB1JGvjiU8oOZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lp+k5g49; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2671DC19421;
	Fri,  9 Jan 2026 21:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767993505;
	bh=uMWyn3rGD3iPS8tSEajH/cCHYI/0uH/haYC/OS93YBA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lp+k5g49U3UZT/sl8Secm+MOAI77IUApVoPiC93cDxhAyyX0baL0iK1lSUSivLhTV
	 UssE0q5usrm417R/yHEqYBFtfM48DBseUJ0w3JttLYE+nJwa+v/FVPp5XhM5pC6nRK
	 hwPyUemTtRbiwIoL7Gfms9XwNrOyF8qrT5bxGIAkoTP8EG/YfPgD0IVAa/6jNIm7oO
	 7My86tofKY/ajPZ9f2+fU1kr9qtihfDg3OrgIg39jrKouWTqlZ9B3gjQlJWBSu7ZoV
	 6yJD0KS52fnDODHdPu4e2F/lVxVJD/EzqwZJy/Wu96kbekROzVk9g3xsrPknFQ6Vpg
	 Up8+gnKaJYtbQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	gal@nvidia.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 7/7] tools: ynl: cli: print reply in combined format if possible
Date: Fri,  9 Jan 2026 13:17:56 -0800
Message-ID: <20260109211756.3342477-8-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260109211756.3342477-1-kuba@kernel.org>
References: <20260109211756.3342477-1-kuba@kernel.org>
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
index dc3438345714..2a9ffe1f0fc2 100755
--- a/tools/net/ynl/pyynl/cli.py
+++ b/tools/net/ynl/pyynl/cli.py
@@ -123,7 +123,7 @@ RELATIVE_SCHEMA_DIR='../../../../Documentation/netlink'
                     print_attr_list(ynl, nested_names, nested_set, indent + 4)
 
 
-def print_mode_attrs(ynl, mode, mode_spec, attr_set):
+def print_mode_attrs(ynl, mode, mode_spec, attr_set, consistent_dd_reply=None):
     """Print a given mode (do/dump/event/notify)."""
     mode_title = mode.capitalize()
 
@@ -132,8 +132,15 @@ RELATIVE_SCHEMA_DIR='../../../../Documentation/netlink'
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
@@ -141,9 +148,15 @@ RELATIVE_SCHEMA_DIR='../../../../Documentation/netlink'
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


