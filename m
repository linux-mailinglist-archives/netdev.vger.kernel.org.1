Return-Path: <netdev+bounces-248606-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D4FCD0C475
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 22:18:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A454B3033989
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 21:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 367CB33D4F2;
	Fri,  9 Jan 2026 21:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aXTY+QUj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1261633CEBC
	for <netdev@vger.kernel.org>; Fri,  9 Jan 2026 21:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767993503; cv=none; b=pl0Zm1mXb7jPDrRJXTOXKcFK82SdEI4ykwf0mC9zNW/NAjSJZk1qkpUzJeHWMDPCpRJODH9WJcSqj+sEjubliZMp8nbl8DpsCrOuBPm/v7DgQEAFPhiBnq2coeEarWLiH1UG5+UZ9/l+dmLOf62RBgleEnmiEA1RHUWj3FAXHcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767993503; c=relaxed/simple;
	bh=9zrXHXpVkTJKt6Yeq+1Mxy0eulHNdgo1eCeilYdcFgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aaEKkn9OKuctU6g0PzMXMESHmvRRPXVsyQxarkVlg/Ep205/mtXeAzW5+sqzY5Vd/G2ntrlYlacy46iN6zhN6VGS4Uh9HgsoTFZGp0DNxbw/gJtk/tFmjeO5xjYzrnZZC6pJN0c6+M5ACMYaqjIfYR4W0dG+7wnHza6hV6pzl8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aXTY+QUj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75C1BC4CEF1;
	Fri,  9 Jan 2026 21:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767993502;
	bh=9zrXHXpVkTJKt6Yeq+1Mxy0eulHNdgo1eCeilYdcFgE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aXTY+QUjL/CTMi8rm5RoPHUbOb2c5SCo0qAq4wF2lx0Z7T44NdOszGCOxkHrrnrTL
	 UdBSfoXl0DS+de4OSKbxotLPC90Qt2xMzkNSKa4z+VzKdUQ5n2aP9uOQ2x466ZViJ5
	 eZsQmMZuE1kgOQjawfOoSzj2U3m1nMJV+DpoeixACImJQ8O/gkIOOA+sAbDWUq0O5d
	 2btQsR386NJErbJFC1/v/yJcazuFUKHDWke1rPLVzxoa/liuyS/wNoRVzsJ3Kswjgj
	 IjpD/5qfG+SKlsHqLH0rYVAbnGHAYsGFASD3LNk67Mxl+IhmjnytpkVrrymWW+UDiz
	 oc13r2m4Wr4CQ==
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
Subject: [PATCH net-next 2/7] tools: ynl: cli: wrap the doc text if it's long
Date: Fri,  9 Jan 2026 13:17:51 -0800
Message-ID: <20260109211756.3342477-3-kuba@kernel.org>
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
 tools/net/ynl/pyynl/cli.py | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/net/ynl/pyynl/cli.py b/tools/net/ynl/pyynl/cli.py
index aa50d42e35ac..e5e71ee4e133 100755
--- a/tools/net/ynl/pyynl/cli.py
+++ b/tools/net/ynl/pyynl/cli.py
@@ -10,6 +10,7 @@ import json
 import os
 import pathlib
 import pprint
+import shutil
 import sys
 import textwrap
 
@@ -101,7 +102,14 @@ RELATIVE_SCHEMA_DIR='../../../../Documentation/netlink'
                 attr_info += f" -> {nested_set_name}"
 
             if attr.yaml.get('doc'):
-                doc_text = textwrap.indent(attr.yaml['doc'], prefix + '  ')
+                doc_prefix = prefix + ' ' * 4
+                if sys.stdout.isatty():
+                    term_width = shutil.get_terminal_size().columns
+                else:
+                    term_width = 80
+                doc_text = textwrap.fill(attr.yaml['doc'], width=term_width,
+                                         initial_indent=doc_prefix,
+                                         subsequent_indent=doc_prefix)
                 attr_info += f"\n{doc_text}"
             print(attr_info)
 
-- 
2.52.0


