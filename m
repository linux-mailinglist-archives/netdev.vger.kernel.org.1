Return-Path: <netdev+bounces-248609-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 731D7D0C478
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 22:18:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0CC723020772
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 21:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8FEC33DEC9;
	Fri,  9 Jan 2026 21:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HAfSZArj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9738533D50B
	for <netdev@vger.kernel.org>; Fri,  9 Jan 2026 21:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767993504; cv=none; b=H0ILo7LLXSAksIOJpoQjTvGM7/CbcktZozzV65Ofv7+QBrCQJ8g2nSoJRXAx3DBFeLv+hJjtg1eOpXBiBVthmoOkn0iNcWEyV3v/ZbDy4+OHhSTCvGMZ01DB4ZuMLG8EzNtHVuPzzmblwYv/HgULjPnAhc10Iv+wFJHOdlmuJRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767993504; c=relaxed/simple;
	bh=pD9L8dpQKvuxXyt9EHiTyp1D8bjk8SOIPDMu1v1R4jk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p0Ch1xI0qjfIwWw5gKAXQbzMEMQ3pU2g19Wv7PJaWSlarywj6KtBwYJ+D3/NOUtyuxPYPbhHuDkGbPlVZhbwUmTzebgz/WZ4vdaxeM7dg2ZH2OTVtPVgxz9akdea3OWegb812tHGd/bf0VnCmR+pP0w4HixqC8Kpi+vZTE34Ye0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HAfSZArj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15269C2BC86;
	Fri,  9 Jan 2026 21:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767993504;
	bh=pD9L8dpQKvuxXyt9EHiTyp1D8bjk8SOIPDMu1v1R4jk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HAfSZArjh7uRxYcbwJD7momzO1o7eZD/ilfYPuZcVeIkGSsSP1Hyon9mZVY9vBg5p
	 0QZH5YVyBpQmWrH1pZjjfmxouju7AMdRbD1zSKIAlV2mdBi5fl7R7VCU+kDkBlpCx1
	 QKPwz0g25ziP4eWwbWlFFiWMBND87f3+/syc+LJB2Pt0jcJcuSoouEZBNg1+EnkSbc
	 GAOr5eHiBk3LXflRfpYRmbE2aRf6Utu996fLu7bud1SDnnyUzf/mjJEVpwecY2Cw1t
	 Zj0w+mXWJKl4E0hOfobNsywcgRh8+MJLJkJ7lFDtP/CacL1B5I+zuxTrzs+0C590jZ
	 HmKUnDmgt1nuQ==
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
Subject: [PATCH net-next 5/7] tools: ynl: cli: factor out --list-attrs / --doc handling
Date: Fri,  9 Jan 2026 13:17:54 -0800
Message-ID: <20260109211756.3342477-6-kuba@kernel.org>
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

We'll soon add more code to the --doc handling. Factor it out
to avoid making main() too long.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/pyynl/cli.py | 35 ++++++++++++++++++++---------------
 1 file changed, 20 insertions(+), 15 deletions(-)

diff --git a/tools/net/ynl/pyynl/cli.py b/tools/net/ynl/pyynl/cli.py
index 88e9fbe4ac5b..e0deb50a4ee7 100755
--- a/tools/net/ynl/pyynl/cli.py
+++ b/tools/net/ynl/pyynl/cli.py
@@ -140,6 +140,25 @@ RELATIVE_SCHEMA_DIR='../../../../Documentation/netlink'
         print_attr_list(ynl, mode_spec['attributes'], attr_set)
 
 
+def do_doc(ynl, op):
+    """Handle --list-attrs $op, print the attr information to stdout"""
+    print(f'Operation: {color(op.name, Colors.BOLD)}')
+    print(op.yaml['doc'])
+
+    for mode in ['do', 'dump', 'event']:
+        if mode in op.yaml:
+            print_mode_attrs(ynl, mode, op.yaml[mode], op.attr_set, True)
+
+    if 'notify' in op.yaml:
+        mode_spec = op.yaml['notify']
+        ref_spec = ynl.msgs.get(mode_spec).yaml.get('do')
+        if ref_spec:
+            print_mode_attrs(ynl, 'notify', ref_spec, op.attr_set, False)
+
+    if 'mcgrp' in op.yaml:
+        print(f"\nMulticast group: {op.yaml['mcgrp']}")
+
+
 # pylint: disable=too-many-locals,too-many-branches,too-many-statements
 def main():
     """YNL cli tool"""
@@ -289,21 +308,7 @@ RELATIVE_SCHEMA_DIR='../../../../Documentation/netlink'
             print(f'Operation {args.list_attrs} not found')
             sys.exit(1)
 
-        print(f'Operation: {color(op.name, Colors.BOLD)}')
-        print(op.yaml['doc'])
-
-        for mode in ['do', 'dump', 'event']:
-            if mode in op.yaml:
-                print_mode_attrs(ynl, mode, op.yaml[mode], op.attr_set, True)
-
-        if 'notify' in op.yaml:
-            mode_spec = op.yaml['notify']
-            ref_spec = ynl.msgs.get(mode_spec).yaml.get('do')
-            if ref_spec:
-                print_mode_attrs(ynl, 'notify', ref_spec, op.attr_set, False)
-
-        if 'mcgrp' in op.yaml:
-            print(f"\nMulticast group: {op.yaml['mcgrp']}")
+        do_doc(ynl, op)
 
     try:
         if args.do:
-- 
2.52.0


