Return-Path: <netdev+bounces-80921-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B599881AD3
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 03:02:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FD391F21B19
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 02:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A7F0A23;
	Thu, 21 Mar 2024 02:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O5/rSQvf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14EB420E6
	for <netdev@vger.kernel.org>; Thu, 21 Mar 2024 02:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710986538; cv=none; b=uCEcJR+x0ww+Iy6B5jWu8Q8cllsbCgCB3M8cI6uxuTbezYI/nvk97jq3k3UItwZRtvGcxRTEb7OPkQO2QSaNo2do7sfAB9G56SsJ8TmmDxGYW+FSjUfIyefi3xGbGRUsnBIIOEIWWtch7K98HcQ+UyuYl1KqvCWUZkXFMy2YAaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710986538; c=relaxed/simple;
	bh=dfxDnNU2G7fZmZ5Uv283tT0oWFLycNamh5QEPp08OLs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qUgNw5PzetbVVGN+AyJnwa/4nm2Gc44C5f01aCCiO5zSYO27wh4dtVLphSa+K+UJhlrnxnsR4xhC32lWtkURQypfV/rJOxyD2rp/kHQ+cYVSnjK5QvdOko+QQVO+Um3JdV0SjAqCFb7/ojmhcHLtQ4Ioc3P0X/7bWj6qaTFAVhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O5/rSQvf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 372FDC433F1;
	Thu, 21 Mar 2024 02:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710986537;
	bh=dfxDnNU2G7fZmZ5Uv283tT0oWFLycNamh5QEPp08OLs=;
	h=From:To:Cc:Subject:Date:From;
	b=O5/rSQvfrXaaCB7Nd/Fun0m+7tgLBe/NZn0/Ok/klGNDs7EytbY57DUzFn59t7wZX
	 VXQUp+Bmzl/XFzJgszYbHQlARyGVj6+85XW2I5Rnkkf6hH21gCYnD0133lei6rmP1N
	 5395vLSAtYt9Q/vTXuGPMSWkeQBsbg1X0hLvYZd3Xq+o9jVZIKVWyFZl898tKgSQVn
	 9p8Fi08M0sunEII4ysddY+fGQhmlJy6y1aRzu0pAWZOkl4//16u0V5GeACM5FOVOhM
	 Fv4oT6k/XozQK3yMVtIeZgsPJdh3pbIYrGsIn8kKhdNNEZkpMgv0jii2ckXIDsQCMs
	 J+9EKhvTCDZVA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	sdf@google.com
Subject: [PATCH net] tools: ynl: fix setting presence bits in simple nests
Date: Wed, 20 Mar 2024 19:02:14 -0700
Message-ID: <20240321020214.1250202-1-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When we set members of simple nested structures in requests
we need to set "presence" bits for all the nesting layers
below. This has nothing to do with the presence type of
the last layer.

Fixes: be5bea1cc0bf ("net: add basic C code generators for Netlink")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: sdf@google.com
---
 tools/net/ynl/ynl-gen-c.py | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/ynl-gen-c.py
index 6b7eb2d2aaf1..a451cbfbd781 100755
--- a/tools/net/ynl/ynl-gen-c.py
+++ b/tools/net/ynl/ynl-gen-c.py
@@ -228,8 +228,11 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
         presence = ''
         for i in range(0, len(ref)):
             presence = f"{var}->{'.'.join(ref[:i] + [''])}_present.{ref[i]}"
-            if self.presence_type() == 'bit':
-                code.append(presence + ' = 1;')
+            # Every layer below last is a nest, so we know it uses bit presence
+            # last layer is "self" and may be a complex type
+            if i == len(ref) - 1 and self.presence_type() != 'bit':
+                continue
+            code.append(presence + ' = 1;')
         code += self._setter_lines(ri, member, presence)
 
         func_name = f"{op_prefix(ri, direction, deref=deref)}_set_{'_'.join(ref)}"
-- 
2.44.0


