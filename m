Return-Path: <netdev+bounces-248765-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AF994D0DF31
	for <lists+netdev@lfdr.de>; Sun, 11 Jan 2026 00:32:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E7CE930090E6
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 23:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D100128B407;
	Sat, 10 Jan 2026 23:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BO3MzFVd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE39227B34E
	for <netdev@vger.kernel.org>; Sat, 10 Jan 2026 23:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768087911; cv=none; b=BqbHmP3a6a9yVHj0dSCqY1MPIhGpdnaLOy5J/wV1MnMFHhSRgULwvyxwz4CEw0lLEY7DNKZjS9OQlGq9GXJi4w0ZwXsljsFbE2gIRXdyusjDpw+3ITGk0ObN2znzBc+lMN4b0iPOLi9OKyUrr0CDduJXzp+cjUacRUDXp8a7/mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768087911; c=relaxed/simple;
	bh=rsK6a8zSqNQH5laJSHYa3ZotV3Rir34S3JRgXgqZjUo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mFcs57tXOTUjQ1NAQ7AiDQlgfsGIKQb6Y5idiEa7SxAs0SZPPHi286mrXrBP5fGvi5/+zlR6MX3TDL3VDMJgaFQ9CxaKyppXZa7MWRTB/KS+oW3JuYIQWltBJCx+q/Y/7PPb+Fnuyq9B13vzPNFUAaDJ4UDH1WpnP9XzXS+VC6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BO3MzFVd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE82AC116C6;
	Sat, 10 Jan 2026 23:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768087911;
	bh=rsK6a8zSqNQH5laJSHYa3ZotV3Rir34S3JRgXgqZjUo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BO3MzFVd0lrboqNg6koaDe4PF8LaIslPoeBGY/ZpyD+qa7BOMFEfBbLb3nXW2rSC4
	 iPuVNKH7PfzMzSAH/9MztTqKxMcIcW6sp3LKryeSB4Jxua+4tyFV26SYgpdSqITaUK
	 cCI+z/DfKO4hbpMG3IlUE1ELFq7mxoDEmyquR0PTgoAwmDLKi+56z8MveIHTZGW1xH
	 K7tLQ/dEsPUwsVP/0UFgpLM/tXUvTeBjfqp8yZAfnKbl+XFvnKL5JJxoEtX1rhIFPj
	 Hq7ttk7iN3248A9lRDwLhmV23HfTMaFq56Dh2Pg2Db4DzuUJopGTQJvaBpAXcdAVnD
	 LoRaO9zhqunLQ==
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
Subject: [PATCH net-next v2 1/7] tools: ynl: cli: introduce formatting for attr names in --list-attrs
Date: Sat, 10 Jan 2026 15:31:36 -0800
Message-ID: <20260110233142.3921386-2-kuba@kernel.org>
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

It's a little hard to make sense of the output of --list-attrs,
it looks like a wall of text. Sprinkle a little bit of formatting -
make op and attr names bold, and Enum: / Flags: keywords italics.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/pyynl/cli.py | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/tools/net/ynl/pyynl/cli.py b/tools/net/ynl/pyynl/cli.py
index 5fee45e48bbf..aa50d42e35ac 100755
--- a/tools/net/ynl/pyynl/cli.py
+++ b/tools/net/ynl/pyynl/cli.py
@@ -20,6 +20,29 @@ from lib import YnlFamily, Netlink, NlError, SpecFamily, SpecException, YnlExcep
 SYS_SCHEMA_DIR='/usr/share/ynl'
 RELATIVE_SCHEMA_DIR='../../../../Documentation/netlink'
 
+# pylint: disable=too-few-public-methods,too-many-locals
+class Colors:
+    """ANSI color and font modifier codes"""
+    RESET = '\033[0m'
+
+    BOLD = '\033[1m'
+    ITALICS = '\033[3m'
+    UNDERLINE = '\033[4m'
+    INVERT = '\033[7m'
+
+
+def color(text, modifiers):
+    """Add color to text if output is a TTY
+
+    Returns:
+        Colored text if stdout is a TTY, otherwise plain text
+    """
+    if sys.stdout.isatty():
+        # Join the colors if they are a list, if it's a string this a noop
+        modifiers = "".join(modifiers)
+        return f"{modifiers}{text}{Colors.RESET}"
+    return text
+
 def schema_dir():
     """
     Return the effective schema directory, preferring in-tree before
@@ -60,7 +83,7 @@ RELATIVE_SCHEMA_DIR='../../../../Documentation/netlink'
     for attr_name in attr_names:
         if attr_name in attr_set.attrs:
             attr = attr_set.attrs[attr_name]
-            attr_info = f'{prefix}- {attr_name}: {attr.type}'
+            attr_info = f'{prefix}- {color(attr_name, Colors.BOLD)}: {attr.type}'
             if 'enum' in attr.yaml:
                 enum_name = attr.yaml['enum']
                 attr_info += f" (enum: {enum_name})"
@@ -68,7 +91,8 @@ RELATIVE_SCHEMA_DIR='../../../../Documentation/netlink'
                 if enum_name in ynl.consts:
                     const = ynl.consts[enum_name]
                     enum_values = list(const.entries.keys())
-                    attr_info += f"\n{prefix}  {const.type.capitalize()}: {', '.join(enum_values)}"
+                    type_fmted = color(const.type.capitalize(), Colors.ITALICS)
+                    attr_info += f"\n{prefix}  {type_fmted}: {', '.join(enum_values)}"
 
             # Show nested attributes reference and recursively display them
             nested_set_name = None
@@ -226,7 +250,7 @@ RELATIVE_SCHEMA_DIR='../../../../Documentation/netlink'
             print(f'Operation {args.list_attrs} not found')
             sys.exit(1)
 
-        print(f'Operation: {op.name}')
+        print(f'Operation: {color(op.name, Colors.BOLD)}')
         print(op.yaml['doc'])
 
         for mode in ['do', 'dump', 'event']:
-- 
2.52.0


