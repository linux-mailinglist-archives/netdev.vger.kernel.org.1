Return-Path: <netdev+bounces-248610-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ADECD0C47F
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 22:19:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7E1CD30123D4
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 21:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5048033DEE6;
	Fri,  9 Jan 2026 21:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EchqHz0o"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E76233DEDF
	for <netdev@vger.kernel.org>; Fri,  9 Jan 2026 21:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767993505; cv=none; b=pvXYJZOe1OtTNN9p+AQe8S8L7XsnuY4GQErMcrAqDsNPUr+lDn9pBFbygoxHW82TACiMss/V4y51m75zm7TA9Rx1V4anx4/piZDzk90EJdAsaX2jdd2iyqER3yQLsIx3qsLHircdlzBhUw0WLejUa+niffRTqrgSEc14ZrshtAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767993505; c=relaxed/simple;
	bh=CQuouA9CxsC1Ni6s5FlMoNLm2fZCWv+uIeNeHbF2aXs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qcA4MuLtc5cVnGdsjzCjzrpov4zFbGixM/jbVJojsXUfWJqSKWTH4CKdhflyF5/FjI+exUyVsKrIYWMBaXOyfHD+oeADnjlsw/zfTuzPMw0IrT9Oj6Z66B1RRSTmX7J3T3/atSf4RRIJ1uYc2p7RSwfy55wl8lh2rY+wP3/T3hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EchqHz0o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96AA4C16AAE;
	Fri,  9 Jan 2026 21:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767993505;
	bh=CQuouA9CxsC1Ni6s5FlMoNLm2fZCWv+uIeNeHbF2aXs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EchqHz0o6kI+oEGraKyqV9JMSbxE/uuwewBYFh35iEWHoO1Y2HtbLO1al7czMjN4W
	 58PsAI9po7mTvYXizS3k/tWxwLhCS9zshU+ZevUlKVFTioTzzO1d9zDyF3uJDuI0cI
	 LJ82r1ZyJWk/YTPpyx9M2Oh4YKRveSaIOhlCuGyG2RFwrNtIXXZV1co0Xt18ufkzkk
	 HWkWpFJMbHga2wD5wugeXlQZa2JnOspjAiDW39roxm4472ERBavPpnh/rMtGbc1Cae
	 iVNPNwp37+CmIpZBuIVMmZ6foMOJ49WhqpsFNjHT6i2btieeB2mhVyE4Cjt5q6cu1f
	 pf2UX9fu8zJ2Q==
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
Subject: [PATCH net-next 6/7] tools: ynl: cli: extract the event/notify handling in --list-attrs
Date: Fri,  9 Jan 2026 13:17:55 -0800
Message-ID: <20260109211756.3342477-7-kuba@kernel.org>
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

Event and notify handling is quite different from do / dump
handling. Forcing it into print_mode_attrs() doesn't really
buy us anything as events and notifications do not have requests.
Call print_attr_list() directly. Apart form subjective code
clarity this also removes the word "reply" from the output:

Before:

  Event reply attributes:

Now:

  Event attributes:

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/pyynl/cli.py | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/tools/net/ynl/pyynl/cli.py b/tools/net/ynl/pyynl/cli.py
index e0deb50a4ee7..dc3438345714 100755
--- a/tools/net/ynl/pyynl/cli.py
+++ b/tools/net/ynl/pyynl/cli.py
@@ -123,11 +123,11 @@ RELATIVE_SCHEMA_DIR='../../../../Documentation/netlink'
                     print_attr_list(ynl, nested_names, nested_set, indent + 4)
 
 
-def print_mode_attrs(ynl, mode, mode_spec, attr_set, print_request=True):
+def print_mode_attrs(ynl, mode, mode_spec, attr_set):
     """Print a given mode (do/dump/event/notify)."""
     mode_title = mode.capitalize()
 
-    if print_request and 'request' in mode_spec and 'attributes' in mode_spec['request']:
+    if 'request' in mode_spec and 'attributes' in mode_spec['request']:
         print(f'\n{mode_title} request attributes:')
         print_attr_list(ynl, mode_spec['request']['attributes'], attr_set)
 
@@ -135,25 +135,28 @@ RELATIVE_SCHEMA_DIR='../../../../Documentation/netlink'
         print(f'\n{mode_title} reply attributes:')
         print_attr_list(ynl, mode_spec['reply']['attributes'], attr_set)
 
-    if 'attributes' in mode_spec:
-        print(f'\n{mode_title} attributes:')
-        print_attr_list(ynl, mode_spec['attributes'], attr_set)
-
 
 def do_doc(ynl, op):
     """Handle --list-attrs $op, print the attr information to stdout"""
     print(f'Operation: {color(op.name, Colors.BOLD)}')
     print(op.yaml['doc'])
 
-    for mode in ['do', 'dump', 'event']:
+    for mode in ['do', 'dump']:
         if mode in op.yaml:
-            print_mode_attrs(ynl, mode, op.yaml[mode], op.attr_set, True)
+            print_mode_attrs(ynl, mode, op.yaml[mode], op.attr_set)
+
+    if 'attributes' in op.yaml.get('event', {}):
+        print('\nEvent attributes:')
+        print_attr_list(ynl, op.yaml['event']['attributes'], op.attr_set)
 
     if 'notify' in op.yaml:
         mode_spec = op.yaml['notify']
         ref_spec = ynl.msgs.get(mode_spec).yaml.get('do')
+        if not ref_spec:
+            ref_spec = ynl.msgs.get(mode_spec).yaml.get('dump')
         if ref_spec:
-            print_mode_attrs(ynl, 'notify', ref_spec, op.attr_set, False)
+            print('\nNotification attributes:')
+            print_attr_list(ynl, ref_spec['reply']['attributes'], op.attr_set)
 
     if 'mcgrp' in op.yaml:
         print(f"\nMulticast group: {op.yaml['mcgrp']}")
-- 
2.52.0


