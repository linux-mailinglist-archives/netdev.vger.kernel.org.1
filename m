Return-Path: <netdev+bounces-180998-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 863D9A835EF
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 03:48:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFFCB4658BF
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 01:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D4991DEFDD;
	Thu, 10 Apr 2025 01:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VkhfSKXh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292A51DED66
	for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 01:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744249637; cv=none; b=glXAdR0XkCOfl+VKHN80Ex5EXDhunJ4oVPeT8qj6YtpEp14Vgh5hmJ88AZivlrxoENofJT5FIs6B8EraI9j8Cu0uxDYCikyWyZnvekOkS1BbHzTffLtBQ1217ALPcdeyk/FvgwjerA8I2l5hDX4GykIGvWZpeQlLwlNPPteREms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744249637; c=relaxed/simple;
	bh=72o5Od3Tk14PFNGCLdVkqbqEPFQalaZvbZQP7fYGnvs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lnR7Ea5QMtg4jvNDcmCqDWkFdg8s9Nfko94FIzCtiFyM5wL+u4XV8W9hMcmdiV1oK/JVGL9BjZKTNcemLxDcdJmvULLr6K7EtNUhRnMXONxu4KnxRVGPDipCvvxn67c7VWuoGv2pf8/cCIScwF0nYuRrw1thj1MTQgCxZL0yurE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VkhfSKXh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96FB7C4CEE9;
	Thu, 10 Apr 2025 01:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744249637;
	bh=72o5Od3Tk14PFNGCLdVkqbqEPFQalaZvbZQP7fYGnvs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VkhfSKXhrYbB2cLdMdo+o9AVHx6RcQTuiUko/jbqJzrAWD8DER+biB3+f86REbTO5
	 GL8rpNmUWYgNsNXI7IdWdgP2O4yp82SMslTAom3VsQFcKmL08BZ7qzwU3/O/WkmHwy
	 0kA1gdo0t08e8q4vIMOzHM0SkehLzrWm560frZwy2zwxWJd661wIYvkL0jGpdskSn5
	 rAXvEfpRC6Uf8O9MEA5V3m/1zxn7iGhczmZZvKEIbukQmtGf5lQq8xoIek37UrPOQw
	 /fAgirdRV+XFDQ1HIQhvW6zCHzB65JYhZkmOgDiDushy5cybo80ZK3+/QxilovWKdV
	 /UYBpCiXXqC4A==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	jacob.e.keller@intel.com,
	yuyanghuang@google.com,
	sdf@fomichev.me,
	gnault@redhat.com,
	nicolas.dichtel@6wind.com,
	petrm@nvidia.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 11/13] tools: ynl-gen: use family c-name in notifications
Date: Wed,  9 Apr 2025 18:46:56 -0700
Message-ID: <20250410014658.782120-12-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250410014658.782120-1-kuba@kernel.org>
References: <20250410014658.782120-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Family names may include dashes. Fix notification handling
code gen to the c-compatible name.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Donald Hunter <donald.hunter@gmail.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/pyynl/ynl_gen_c.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index efed498ccb35..a9966ff2a143 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -2726,7 +2726,7 @@ _C_KW = {
         return
 
     if family.ntfs:
-        cw.block_start(line=f"static const struct ynl_ntf_info {family['name']}_ntf_info[] = ")
+        cw.block_start(line=f"static const struct ynl_ntf_info {family.c_name}_ntf_info[] = ")
         for ntf_op_name, ntf_op in family.ntfs.items():
             if 'notify' in ntf_op:
                 op = family.ops[ntf_op['notify']]
@@ -2756,8 +2756,8 @@ _C_KW = {
     else:
         cw.p('.hdr_len\t= sizeof(struct genlmsghdr),')
     if family.ntfs:
-        cw.p(f".ntf_info\t= {family['name']}_ntf_info,")
-        cw.p(f".ntf_info_size\t= YNL_ARRAY_SIZE({family['name']}_ntf_info),")
+        cw.p(f".ntf_info\t= {family.c_name}_ntf_info,")
+        cw.p(f".ntf_info_size\t= YNL_ARRAY_SIZE({family.c_name}_ntf_info),")
     cw.block_end(line=';')
 
 
-- 
2.49.0


