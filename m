Return-Path: <netdev+bounces-248766-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A7CD0DF34
	for <lists+netdev@lfdr.de>; Sun, 11 Jan 2026 00:32:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C3FE8300E8F5
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 23:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 971522C08A1;
	Sat, 10 Jan 2026 23:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DkgO+kDa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756462BEFFE
	for <netdev@vger.kernel.org>; Sat, 10 Jan 2026 23:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768087912; cv=none; b=i4iugWqMjMIj2PLj7jIC1EN9xHKG0umI6GUrxATYtnhG7zQw6vrZ1G0aSGUKY84Y2G8n02JkMdY7v8HrXG/9pdbzvLILBJ8Bn3amQPjAcTfNDbc4kNPlEhvCSsJN0z+gn3kByfS5YAZ9aEn847JG4npFu/QStsbbmvGueMAINUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768087912; c=relaxed/simple;
	bh=7uZ07Jw3PjFg0UXtmqPwJDLAhovdmjVMQZDQD2TsEBY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AE1PDaYGr8MMrXEJOAgHebP8U5HMWhlnCkC2T3RIeH3pi4vBjL9BhNPanWOGsKbjh8vUNE98q0GprkD4KCE1DmeAXN3HyuxNkSN9qoBwJHRNMx2lLZT5bLO4Z2sRxeaX+Dfp8yy3YspF3W56XNkATCUKs2WPbAAnokLezidROuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DkgO+kDa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2685C19423;
	Sat, 10 Jan 2026 23:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768087912;
	bh=7uZ07Jw3PjFg0UXtmqPwJDLAhovdmjVMQZDQD2TsEBY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DkgO+kDaWZmU53hXGGYit4kXVHhfD4vMvvfeuGMVWqs2i7GK3wBnWmYMUH4rWBv2P
	 IllE+R2kxFu2HcWJv4mSYi87NPvR0opkbbq0qs8TKr+D+N3S2EuYJnzyDJY8xXhCbH
	 PiAf9R1/2sjzJmoS9q14FENzLuJ0CoTNT/yWxyeO1DC4EF095O7DXJNH0a1Ic/nFRG
	 vVedt6KaN23EXxZi3scjkqX5uAVRcuixaCiuWu7fTZ4NcSa7RI2vqk3wenFhp/TdjV
	 8in3KIXk/7nH8b/OkLDHz6TDyK8JIH5fhK/00htENYpu+AbrPFpb90gq62YAXVxRgb
	 HQ/uv6+Vb6yBw==
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
Subject: [PATCH net-next v2 2/7] tools: ynl: cli: wrap the doc text if it's long
Date: Sat, 10 Jan 2026 15:31:37 -0800
Message-ID: <20260110233142.3921386-3-kuba@kernel.org>
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

We already use textwrap when printing "doc" section about an attribute,
but only to indent the text. Switch to using fill() to split and indent
all the lines. While at it indent the text by 2 more spaces, so that it
doesn't align with the name of the attribute.

Before (I'm drawing a "box" at ~60 cols here, in an attempt for clarity):

 |  - irq-suspend-timeout: uint                              |
 |    The timeout, in nanoseconds, of how long to suspend irq|
 |processing, if event polling finds events                  |

After:

 |  - irq-suspend-timeout: uint                              |
 |      The timeout, in nanoseconds, of how long to suspend  |
 |      irq processing, if event polling finds events        |

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - remove the explicit sys.stdout.isatty() check
v1: https://lore.kernel.org/20260109211756.3342477-3-kuba@kernel.org
---
 tools/net/ynl/pyynl/cli.py | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/net/ynl/pyynl/cli.py b/tools/net/ynl/pyynl/cli.py
index aa50d42e35ac..dc84619e5518 100755
--- a/tools/net/ynl/pyynl/cli.py
+++ b/tools/net/ynl/pyynl/cli.py
@@ -10,6 +10,7 @@ import json
 import os
 import pathlib
 import pprint
+import shutil
 import sys
 import textwrap
 
@@ -101,7 +102,11 @@ RELATIVE_SCHEMA_DIR='../../../../Documentation/netlink'
                 attr_info += f" -> {nested_set_name}"
 
             if attr.yaml.get('doc'):
-                doc_text = textwrap.indent(attr.yaml['doc'], prefix + '  ')
+                doc_prefix = prefix + ' ' * 4
+                term_width = shutil.get_terminal_size().columns
+                doc_text = textwrap.fill(attr.yaml['doc'], width=term_width,
+                                         initial_indent=doc_prefix,
+                                         subsequent_indent=doc_prefix)
                 attr_info += f"\n{doc_text}"
             print(attr_info)
 
-- 
2.52.0


