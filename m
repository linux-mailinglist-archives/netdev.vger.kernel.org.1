Return-Path: <netdev+bounces-156428-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0D59A065BD
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 21:08:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4604518896F0
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 20:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395D81CDFD5;
	Wed,  8 Jan 2025 20:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YqROLKrB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13476198A06
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 20:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736366880; cv=none; b=AMPIdnT0R0/oyIAIG27F3O5aBFJd9cXqvqYQq5Vb3ayYjo+UgvY85eoxSSTigGlMbJt3gYQ34Xd7t/HxnrSjnnc+WSbtQVgGIQZpJxPaFQayj0El9pOPBlLEhb/bRhweNuYZUOW6nx8oqYBLFKbeRPKgaUEl57JMjZCkMpMlNys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736366880; c=relaxed/simple;
	bh=Ii6L/p6vXM9Fwd1Re1bBC0na+7RJZu6kDR5eL/NbIx0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Pb33asCQhSwrP82TzFyuBv551ZTLbRGugA+wYgMOC7lrmmrGMiGnEekrYFy98HYVSXbFahpJdcZAAcS3bAbJqqaGaCH76wId1Hf9ZmVPAtZshxUTyVBgM/p9eLJqSKOjp+WRhWxlgBzPzOPDhqHNfW3VIFZj4sNJpjKZD6UiWEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YqROLKrB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85DBAC4CED3;
	Wed,  8 Jan 2025 20:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736366879;
	bh=Ii6L/p6vXM9Fwd1Re1bBC0na+7RJZu6kDR5eL/NbIx0=;
	h=From:To:Cc:Subject:Date:From;
	b=YqROLKrBPyGRvB7k43IgXDghmn8RCrXV6dSK+yJqQsGyuYyWgu5u93F1FYASRheAK
	 UBs/m0rlwGeZKAQtcskxsgD4ggokPjFGCgyEV7HKri0LdwWtigDF832DfG9rKi+fre
	 fEV4AscNsjNnzfAzbiLKSiKqQ18zFNlKFbGi8Txvt+napnRKi08Ory9aVY5sILZ5ZR
	 f2Fg4T6Y8yr9bojAFUXhFkNpAnh8G49qAwTwPFC7ARbGqczKGdhy0tW5+vTUamuxe8
	 lfcU1VhGpnoJOt5kuDH/s9/31WS3Rak2vWMZAZX50P5B22RqRNlpb6bGNwIIZ3YsD8
	 WmPvKDzJFvE4w==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	dw@davidwei.uk,
	donald.hunter@gmail.com,
	nicolas.dichtel@6wind.com,
	sdf@fomichev.me
Subject: [PATCH net-next] tools: ynl-gen-c: improve support for empty nests
Date: Wed,  8 Jan 2025 12:07:58 -0800
Message-ID: <20250108200758.2693155-1-kuba@kernel.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Empty nests are the same size as a flag at the netlink level
(just a 4 byte nlattr without a payload). They are sometimes
useful in case we want to only communicate a presence of
something but may want to add more details later.
This may be the case in the upcoming io_uring ZC patches,
for example.

Improve handling of nested empty structs. We already support
empty structs since a lot of netlink replies are empty, but
for nested ones we need minor tweaks to avoid pointless empty
lines and unused variables.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: dw@davidwei.uk
CC: donald.hunter@gmail.com
CC: nicolas.dichtel@6wind.com
CC: sdf@fomichev.me
---
 tools/net/ynl/ynl-gen-c.py | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/ynl-gen-c.py
index ec2288948795..9722a8f72a46 100755
--- a/tools/net/ynl/ynl-gen-c.py
+++ b/tools/net/ynl/ynl-gen-c.py
@@ -1765,7 +1765,14 @@ _C_KW = {
                   f'{struct.ptr_name}dst = yarg->data;']
     init_lines = []
 
-    _multi_parse(ri, struct, init_lines, local_vars)
+    if struct.member_list():
+        _multi_parse(ri, struct, init_lines, local_vars)
+    else:
+        # Empty nest
+        ri.cw.block_start()
+        ri.cw.p('return 0;')
+        ri.cw.block_end()
+        ri.cw.nl()
 
 
 def parse_rsp_msg(ri, deref=False):
@@ -2592,7 +2599,8 @@ _C_KW = {
                 val = attr.value
             val += 1
             cw.p(attr.enum_name + suffix)
-        cw.nl()
+        if attr_set.items():
+            cw.nl()
         cw.p(attr_set.cnt_name + ('' if max_by_define else ','))
         if not max_by_define:
             cw.p(f"{attr_set.max_name} = {max_value}")
-- 
2.47.1


