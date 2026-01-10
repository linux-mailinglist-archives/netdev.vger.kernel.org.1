Return-Path: <netdev+bounces-248769-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 34657D0DF37
	for <lists+netdev@lfdr.de>; Sun, 11 Jan 2026 00:32:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7B49930124E0
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 23:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762A62D0635;
	Sat, 10 Jan 2026 23:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nCL+Ww50"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53BB424DFF9
	for <netdev@vger.kernel.org>; Sat, 10 Jan 2026 23:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768087914; cv=none; b=Asy+E4saO6QQ8z1x5/bdSPBLFeAo7X2vQIymxuHWV/1bb+KAu++1sQc2KufjzQP/MxYzdoRXb+VnzfJza/f0DW1cDp0YMnhHiBBVkrdUjZcIiV5wt4NCosdkrAGSW66Cn6rP1i5EPyAsievGm+F9QDrxkTWfOg7RalJt6ScyxiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768087914; c=relaxed/simple;
	bh=pJ3fnFwVSvfNZFYyxI/B9oRRbyU47BCpj9Gry0elPWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WLiKbxEzg93jb7RgMJtLy+Q4G772M+1wB1kc98LRm41zzDHxs9puztHoCno/xFAN1QwAV+pmkcM6vRNr8m4mWiOTj3E5lLobqoOnumJOdy2LInw4DqugMN4zCKJnblvBJcVZVnECd4OgEOGgrEc7exl8y82LIjD/y9/UA5yeZOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nCL+Ww50; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80DE5C4CEF1;
	Sat, 10 Jan 2026 23:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768087914;
	bh=pJ3fnFwVSvfNZFYyxI/B9oRRbyU47BCpj9Gry0elPWA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nCL+Ww50wEESoB8MFx0Q50/mecxHWdQVkq0lmhm1nrRv+TwdQ7U9VSuQmtUt5Ktgd
	 uRlDwbZVW4V+w38v25XP59wb9ZrOCoG1DlU5j5CBs9gAS6IKWT+dJkvnKCa6zYWO4T
	 yo77mPFrzMDzRXtdDzN6lPA2/BURx7iBHyd80e1UDlbINfkNxsE4xeQscVKC878aH8
	 k0SwbUFWjWyG04mwmDJhikMi/0Db7I3CbKxug4KeiK0GXN7zjxCc4JM3TJFXKB+hmV
	 RzG02SkaTt3XKML1m0WFpAJ/KEuHuBShN8069Eo/adWFMD7ASRNGoJSF+A4/iHDf7E
	 FeyHSqgMwhqeQ==
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
Subject: [PATCH net-next v2 5/7] tools: ynl: cli: factor out --list-attrs / --doc handling
Date: Sat, 10 Jan 2026 15:31:40 -0800
Message-ID: <20260110233142.3921386-6-kuba@kernel.org>
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

We'll soon add more code to the --doc handling. Factor it out
to avoid making main() too long.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/pyynl/cli.py | 35 ++++++++++++++++++++---------------
 1 file changed, 20 insertions(+), 15 deletions(-)

diff --git a/tools/net/ynl/pyynl/cli.py b/tools/net/ynl/pyynl/cli.py
index 4147c498b479..6975efa7874f 100755
--- a/tools/net/ynl/pyynl/cli.py
+++ b/tools/net/ynl/pyynl/cli.py
@@ -137,6 +137,25 @@ RELATIVE_SCHEMA_DIR='../../../../Documentation/netlink'
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
@@ -286,21 +305,7 @@ RELATIVE_SCHEMA_DIR='../../../../Documentation/netlink'
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


