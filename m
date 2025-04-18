Return-Path: <netdev+bounces-184041-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35C33A92FD2
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 04:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CFAE7A6AAB
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 02:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C68A267713;
	Fri, 18 Apr 2025 02:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dBkJhz8C"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BC721930B
	for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 02:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744942637; cv=none; b=N2EsKaneUZizYKAjYWbl0W0fLgt+fOVjmusnpW7gO2B/yv+woCDxWj3DHOHbrTZQyt2dVZtjDFMkSX+3rrVezngtQVuFd/Zs96tQMFWBJYjzisJrqfcjEN0JttOG82wJOmBRoKtbWOvyrX7EHr9sHOa409POD7fGjAyxczY1X7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744942637; c=relaxed/simple;
	bh=ak0H73PeUTSwAL/0ZTF8DDXVbbMPerb8nIMn2bHzGys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QV3WJKEhquRL5CeVBSq6kd9bUyyu/cBpcYYxwS4IRgsx8/yoLoqlyC2aQHtkEPgJ8OALWxJPzHWEhd4/CtWJdMSc1V5hOx0w0NiCE/d6/SCWA3CFzpHjlvbPIbwdRfCRiQUMLYjbpkV2TstU9FbqO4HyqKBJdSHBlvEIN7NaUeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dBkJhz8C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A71AC4CEED;
	Fri, 18 Apr 2025 02:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744942636;
	bh=ak0H73PeUTSwAL/0ZTF8DDXVbbMPerb8nIMn2bHzGys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dBkJhz8CxtJef8MpVOXlZBhMtUUsmzOoT+0JwPRlFjMWE7gkQMiCFCWXl0jJ/HRJc
	 t/zLQoAKSdYlWrjJixkYjPzW3ZltD3XkaQcjjV7cAHMGtGkTA7RSOMKx78fN1T7agT
	 4e2cHeewqUMR0dLQVvKqDj0wgq6jKYwCa/lirfPJNSmKyZFZPzELilSZPcmTHsQGPU
	 uIAKEa19YutsnNtSizX00WT83RfEmNEvHHiYgxpzU/HWdeBSQVQG5pN+G/BTPXUK8S
	 7sqmOo2dHBaUxzrssg1dQHJY6BDLbhkAlsiNazdx8ovQukkdmu9RXKeyVYaPkwTFFn
	 12c43+sFcaHvw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net,
	donald.hunter@gmail.com
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 01/12] netlink: specs: allow header properties for attribute sets
Date: Thu, 17 Apr 2025 19:16:55 -0700
Message-ID: <20250418021706.1967583-2-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250418021706.1967583-1-kuba@kernel.org>
References: <20250418021706.1967583-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rt-link has a number of disjoint headers, plus it uses attributes
of other families (e.g. DPLL). Allow declaring a attribute set
as "foreign" by specifying which header its definition is coming
from.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/netlink/genetlink-c.yaml      | 3 +++
 Documentation/netlink/genetlink-legacy.yaml | 3 +++
 Documentation/netlink/netlink-raw.yaml      | 3 +++
 tools/net/ynl/pyynl/ynl_gen_c.py            | 2 +-
 4 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/Documentation/netlink/genetlink-c.yaml b/Documentation/netlink/genetlink-c.yaml
index 96fa1f1522ed..5a234e9b5fa2 100644
--- a/Documentation/netlink/genetlink-c.yaml
+++ b/Documentation/netlink/genetlink-c.yaml
@@ -148,6 +148,9 @@ additionalProperties: False
         attr-max-name:
           description: The explicit name for last member of attribute enum.
           type: string
+        header:
+          description: For C-compatible languages, header which already defines this attribute set.
+          type: string
         # End genetlink-c
         attributes:
           description: List of attributes in the space.
diff --git a/Documentation/netlink/genetlink-legacy.yaml b/Documentation/netlink/genetlink-legacy.yaml
index a8c5b521937d..4cbfe666e6f5 100644
--- a/Documentation/netlink/genetlink-legacy.yaml
+++ b/Documentation/netlink/genetlink-legacy.yaml
@@ -193,6 +193,9 @@ additionalProperties: False
         attr-max-name:
           description: The explicit name for last member of attribute enum.
           type: string
+        header:
+          description: For C-compatible languages, header which already defines this attribute set.
+          type: string
         # End genetlink-c
         attributes:
           description: List of attributes in the space.
diff --git a/Documentation/netlink/netlink-raw.yaml b/Documentation/netlink/netlink-raw.yaml
index 1b0772c8e333..e34bf23897fa 100644
--- a/Documentation/netlink/netlink-raw.yaml
+++ b/Documentation/netlink/netlink-raw.yaml
@@ -207,6 +207,9 @@ additionalProperties: False
         attr-max-name:
           description: The explicit name for last member of attribute enum.
           type: string
+        header:
+          description: For C-compatible languages, header which already defines this attribute set.
+          type: string
         # End genetlink-c
         attributes:
           description: List of attributes in the space.
diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index 0d930c17f963..9613a6135003 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -2909,7 +2909,7 @@ _C_KW = {
             cw.p(f'#include "{hdr_file}"')
             cw.p('#include "ynl.h"')
         headers = []
-    for definition in parsed['definitions']:
+    for definition in parsed['definitions'] + parsed['attribute-sets']:
         if 'header' in definition:
             headers.append(definition['header'])
     if args.mode == 'user':
-- 
2.49.0


