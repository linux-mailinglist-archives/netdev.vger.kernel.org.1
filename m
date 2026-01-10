Return-Path: <netdev+bounces-248771-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB75D0DF43
	for <lists+netdev@lfdr.de>; Sun, 11 Jan 2026 00:33:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B0D25306089E
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 23:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F9D0299949;
	Sat, 10 Jan 2026 23:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VLNhmKtC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E096523ED5B
	for <netdev@vger.kernel.org>; Sat, 10 Jan 2026 23:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768087917; cv=none; b=sbMfVAdqUZt5nfXj9TIV/Q7s+tUVd9V7rP3/1c7R4nuaMrE41aAHJlmBLjr+B61da8Bh7PXfGgvGX5lyj5Dc74O8roPsBdHeytuI3+YPmMmyIeFOI4//esoUumrRkEUwPwFDAg64qYtq7GqvszAwy7C4i+dOItM4RJ4KxSpkaMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768087917; c=relaxed/simple;
	bh=OvEqz1ZxTjwEWw9Mo400/Ls2m6sHuum2MQWHwr0Fk84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=riAn09AyriqpcKbtw+r69/7WMseU2ihn15XnOogHoamowJBLqadC4royEcfRNFjL4XZbHwFkkrzUsGxlhT8A9E9tA4erWrFFz3ehB+QXrXjSlH4ML79U73o4DESEQKdJmOpJZj+QTMHcIyxWi64aSIOQxIqM40kDnvzg+40xtKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VLNhmKtC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25B88C116C6;
	Sat, 10 Jan 2026 23:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768087914;
	bh=OvEqz1ZxTjwEWw9Mo400/Ls2m6sHuum2MQWHwr0Fk84=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VLNhmKtCT7kcUbvmkYXOqsDEBHhPQMPxnqk8SZfGf3aBvmihuaxPBq0rC/JIToQjF
	 caUaUfGPYTTA6azqvvrZ4n3duTivRRKfqjoHlwYuFmAYV8HgjqorEpJvQOAYGpXEtW
	 gZwz7qqFanaiL6DOgKtOfpQ80Z61Rfkk2m8iTrBfVV0VBzwLE5yGtGDxEeXUOR6/Y9
	 X0042vMcuCTxpTe8j2XavqfA3DRvaCbLYD+vIEXL9Y7xWp23BRPX246O5T5rRYGqhG
	 lh01mrJPHji00tWce5vybcfZIlMSlOJryxkrZPOiP3KUf1f+1ONa0qSKYwtHa7EtcB
	 MCX3tzEwXYDxw==
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
Subject: [PATCH net-next v2 6/7] tools: ynl: cli: extract the event/notify handling in --list-attrs
Date: Sat, 10 Jan 2026 15:31:41 -0800
Message-ID: <20260110233142.3921386-7-kuba@kernel.org>
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
index 6975efa7874f..6d2f0412dde0 100755
--- a/tools/net/ynl/pyynl/cli.py
+++ b/tools/net/ynl/pyynl/cli.py
@@ -120,11 +120,11 @@ RELATIVE_SCHEMA_DIR='../../../../Documentation/netlink'
                     print_attr_list(ynl, nested_names, nested_set, indent + 4)
 
 
-def print_mode_attrs(ynl, mode, mode_spec, attr_set, print_request=True):
+def print_mode_attrs(ynl, mode, mode_spec, attr_set):
     """Print a given mode (do/dump/event/notify)."""
     mode_title = mode.capitalize()
 
-    if print_request and 'request' in mode_spec and 'attributes' in mode_spec['request']:
+    if 'request' in mode_spec and 'attributes' in mode_spec['request']:
         print(f'\n{mode_title} request attributes:')
         print_attr_list(ynl, mode_spec['request']['attributes'], attr_set)
 
@@ -132,25 +132,28 @@ RELATIVE_SCHEMA_DIR='../../../../Documentation/netlink'
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


