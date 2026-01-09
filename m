Return-Path: <netdev+bounces-248607-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 51DE7D0C47B
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 22:18:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 205E7303D914
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 21:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA6FB33D518;
	Fri,  9 Jan 2026 21:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YUetqj2q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9832B33D50E
	for <netdev@vger.kernel.org>; Fri,  9 Jan 2026 21:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767993503; cv=none; b=PLubeCpTmt94xpEhr17iQkuqIdARLqjAEllb6reFlMKWA5SwKtkaT5Rp96oXC5M1TMH+/EdAJK0dBuc87fWdGB04t65FBzNTDcIt6NRcQrd2clCNqzHYq2ouHQ9ERdNH3+4kT93QIXsgXHkbciNH3r92teJRkuWYjrakBIY/cRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767993503; c=relaxed/simple;
	bh=Ml3YioiDpNVbD5P32WrEWPdp1rcFhAD1AcQ9PTV5Q7w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RrX6ReELXKu1ck5lzq6msY5TXyenGl9gW1onxBW/L4J109ZN+c1EF0BrPkLwr6IHTTRaNHbBFAiPhJg9vay2SspaiTk33sipcSdN2O0dGWk9Xff5nv+xUieEagWCkFCPwQRdYDKbwGWy3OMx6jFi7QOy0Ojb2LeiMcqc+NMnwAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YUetqj2q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04735C19425;
	Fri,  9 Jan 2026 21:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767993503;
	bh=Ml3YioiDpNVbD5P32WrEWPdp1rcFhAD1AcQ9PTV5Q7w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YUetqj2qpya3HYdIz4SCVzl4I2idcFm0bRMxbhDhkiJGyNvnmDQ4QEpG5vbr/4baz
	 BiOZQ/SXVH5jZBRBNLJHQBO82M44BGikXJB+MlwbaxWL4KoZWX0nof60PMj6YOclqk
	 GtOfBUPMumUyB0rhZRB3HtrjBjXodcZjc+s7d5/B8BlpA2r/PeBQY9aFu6cfDG+EYb
	 0lmY8e787i1DIKHdNL0c/JsIx6CN2mal4eBxhXUiwrOvzk0p+h6h9UdQm5UwJSaI9c
	 B8G8P3qjubVRqWmgxrzqkT6HMV3QDi7cvWhY2UGQ41I7/FAZu4j02xVS5G9D3d7IxW
	 8ypSHbRUcUbbQ==
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
Subject: [PATCH net-next 3/7] tools: ynl: cli: improve --help
Date: Fri,  9 Jan 2026 13:17:52 -0800
Message-ID: <20260109211756.3342477-4-kuba@kernel.org>
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

Improve the clarity of --help. Reorder, provide some grouping and
add help messages to most of the options.

No functional changes intended.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/pyynl/cli.py | 107 ++++++++++++++++++++++++-------------
 1 file changed, 69 insertions(+), 38 deletions(-)

diff --git a/tools/net/ynl/pyynl/cli.py b/tools/net/ynl/pyynl/cli.py
index e5e71ee4e133..6ddb3dac08bc 100755
--- a/tools/net/ynl/pyynl/cli.py
+++ b/tools/net/ynl/pyynl/cli.py
@@ -154,47 +154,78 @@ RELATIVE_SCHEMA_DIR='../../../../Documentation/netlink'
     """
 
     parser = argparse.ArgumentParser(description=description,
-                                     epilog=epilog)
-    spec_group = parser.add_mutually_exclusive_group(required=True)
-    spec_group.add_argument('--family', dest='family', type=str,
-                            help='name of the netlink FAMILY')
-    spec_group.add_argument('--list-families', action='store_true',
-                            help='list all netlink families supported by YNL (has spec)')
-    spec_group.add_argument('--spec', dest='spec', type=str,
-                            help='choose the family by SPEC file path')
+                                     epilog=epilog, add_help=False)
 
-    parser.add_argument('--schema', dest='schema', type=str)
-    parser.add_argument('--no-schema', action='store_true')
-    parser.add_argument('--json', dest='json_text', type=str)
+    gen_group = parser.add_argument_group('General options')
+    gen_group.add_argument('-h', '--help', action='help',
+                           help='show this help message and exit')
 
-    group = parser.add_mutually_exclusive_group()
-    group.add_argument('--do', dest='do', metavar='DO-OPERATION', type=str)
-    group.add_argument('--multi', dest='multi', nargs=2, action='append',
-                       metavar=('DO-OPERATION', 'JSON_TEXT'), type=str)
-    group.add_argument('--dump', dest='dump', metavar='DUMP-OPERATION', type=str)
-    group.add_argument('--list-ops', action='store_true')
-    group.add_argument('--list-msgs', action='store_true')
-    group.add_argument('--list-attrs', dest='list_attrs', metavar='OPERATION', type=str,
-                       help='List attributes for an operation')
-    group.add_argument('--validate', action='store_true')
+    spec_group = parser.add_argument_group('Netlink family selection')
+    spec_sel = spec_group.add_mutually_exclusive_group(required=True)
+    spec_sel.add_argument('--list-families', action='store_true',
+                          help=('list Netlink families supported by YNL '
+                                '(which have a spec available in the standard '
+                                'system path)'))
+    spec_sel.add_argument('--family', dest='family', type=str,
+                          help='name of the Netlink FAMILY to use')
+    spec_sel.add_argument('--spec', dest='spec', type=str,
+                          help='full file path to the YAML spec file')
+
+    ops_group = parser.add_argument_group('Operations')
+    ops = ops_group.add_mutually_exclusive_group()
+    ops.add_argument('--do', dest='do', metavar='DO-OPERATION', type=str)
+    ops.add_argument('--dump', dest='dump', metavar='DUMP-OPERATION', type=str)
+    ops.add_argument('--multi', dest='multi', nargs=2, action='append',
+                     metavar=('DO-OPERATION', 'JSON_TEXT'), type=str,
+                     help="Multi-message operation sequence (for nftables)")
+    ops.add_argument('--list-ops', action='store_true',
+                     help="List available --do and --dump operations")
+    ops.add_argument('--list-msgs', action='store_true',
+                     help="List all messages of the family (incl. notifications)")
+    ops.add_argument('--list-attrs', dest='list_attrs', metavar='MSG',
+                     type=str, help='List attributes for a message / operation')
+    ops.add_argument('--validate', action='store_true',
+                     help="Validate the spec against schema and exit")
+
+    io_group = parser.add_argument_group('Input / Output')
+    io_group.add_argument('--json', dest='json_text', type=str,
+                          help=('Specify attributes of the message to send '
+                                'to the kernel in JSON format. Can be left out '
+                                'if the message is expected to be empty.'))
+    io_group.add_argument('--output-json', action='store_true',
+                          help='Format output as JSON')
+
+    ntf_group = parser.add_argument_group('Notifications')
+    ntf_group.add_argument('--subscribe', dest='ntf', type=str)
+    ntf_group.add_argument('--duration', dest='duration', type=int,
+                           help='when subscribed, watch for DURATION seconds')
+    ntf_group.add_argument('--sleep', dest='duration', type=int,
+                           help='alias for duration')
+
+    nlflags = parser.add_argument_group('Netlink message flags (NLM_F_*)',
+                                        ('Extra flags to set in nlmsg_flags of '
+                                         'the request, used mostly by older '
+                                         'Classic Netlink families.'))
+    nlflags.add_argument('--replace', dest='flags', action='append_const',
+                         const=Netlink.NLM_F_REPLACE)
+    nlflags.add_argument('--excl', dest='flags', action='append_const',
+                         const=Netlink.NLM_F_EXCL)
+    nlflags.add_argument('--create', dest='flags', action='append_const',
+                         const=Netlink.NLM_F_CREATE)
+    nlflags.add_argument('--append', dest='flags', action='append_const',
+                         const=Netlink.NLM_F_APPEND)
+
+    schema_group = parser.add_argument_group('Development options')
+    schema_group.add_argument('--schema', dest='schema', type=str,
+                              help="JSON schema to validate the spec")
+    schema_group.add_argument('--no-schema', action='store_true')
+
+    dbg_group = parser.add_argument_group('Debug options')
+    dbg_group.add_argument('--dbg-small-recv', default=0, const=4000,
+                           action='store', nargs='?', type=int, metavar='INT',
+                           help="Length of buffers used for recv()")
+    dbg_group.add_argument('--process-unknown', action=argparse.BooleanOptionalAction)
 
-    parser.add_argument('--duration', dest='duration', type=int,
-                        help='when subscribed, watch for DURATION seconds')
-    parser.add_argument('--sleep', dest='duration', type=int,
-                        help='alias for duration')
-    parser.add_argument('--subscribe', dest='ntf', type=str)
-    parser.add_argument('--replace', dest='flags', action='append_const',
-                        const=Netlink.NLM_F_REPLACE)
-    parser.add_argument('--excl', dest='flags', action='append_const',
-                        const=Netlink.NLM_F_EXCL)
-    parser.add_argument('--create', dest='flags', action='append_const',
-                        const=Netlink.NLM_F_CREATE)
-    parser.add_argument('--append', dest='flags', action='append_const',
-                        const=Netlink.NLM_F_APPEND)
-    parser.add_argument('--process-unknown', action=argparse.BooleanOptionalAction)
-    parser.add_argument('--output-json', action='store_true')
-    parser.add_argument('--dbg-small-recv', default=0, const=4000,
-                        action='store', nargs='?', type=int)
     args = parser.parse_args()
 
     def output(msg):
-- 
2.52.0


