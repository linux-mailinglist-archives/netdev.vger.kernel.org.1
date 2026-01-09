Return-Path: <netdev+bounces-248605-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 70465D0C472
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 22:18:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C89443024240
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 21:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E41A33CE9D;
	Fri,  9 Jan 2026 21:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sNUlFhWP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCE233C50F
	for <netdev@vger.kernel.org>; Fri,  9 Jan 2026 21:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767993502; cv=none; b=hvrumA6ae/gCjVGNSItrbe79tqzKshtbeaGrHIGzXly1WEOS6jPpl46FVMlIxVyk9wCKzh9V71woOfMHFEupEUAadKVPhl0oK8l5pMrRRc1rVONRwS51XzDturuABFi/N2Tuh9xfKUWI46iuax4bZKt5foOz0BvlAA1ZBgpMIOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767993502; c=relaxed/simple;
	bh=rsK6a8zSqNQH5laJSHYa3ZotV3Rir34S3JRgXgqZjUo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a5JQXloXxwNWAav4+yolnaXLsL24Rl4D6yvsDV3EdikTfv80f/+qRROGJxVOWYAhuUT7cN5ATk/JGNQ1sLn46xpWIu48bokXlvdfnfie6jhn1Mr9vTRZuIqkS0UysbqZlkoP2XgJaJlpTQa1tFncxcceKIHX8vBXtc+DuRyY2Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sNUlFhWP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7674C16AAE;
	Fri,  9 Jan 2026 21:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767993502;
	bh=rsK6a8zSqNQH5laJSHYa3ZotV3Rir34S3JRgXgqZjUo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sNUlFhWP0ZJj+z1dp+zxi6vPj77tRtYP8DEkcPdq85FZ+sPR47WtZHB6Vnku1xayS
	 q4qMzLlRAekE4qxvfhiJDwoHTl86N3WibPhu/v59Qbrj/PyYqvB4Y/Jg/tg4X75iA9
	 HbAkvZZdkfn011zX+QGOhrWELWubktaFh9+QYfafspC9BorARC+5whoPEa6Q9LX7sL
	 ng2tgZy8QH85WkfnWDeWg/Rgs7SW+Rwhjf3vsI2SO+jI4RnGIPiNg6iQqaWOcWjUNW
	 jWFAPqYVEO9StL9koVFNLTl5kR1Ni7YqUMBu3SHrMLki1FBOl+5R9gslZ6SGHT5hfm
	 QL6Gu6uAMQzvQ==
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
Subject: [PATCH net-next 1/7] tools: ynl: cli: introduce formatting for attr names in --list-attrs
Date: Fri,  9 Jan 2026 13:17:50 -0800
Message-ID: <20260109211756.3342477-2-kuba@kernel.org>
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


