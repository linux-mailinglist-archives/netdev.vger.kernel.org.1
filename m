Return-Path: <netdev+bounces-44233-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 538CB7D7342
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 20:27:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D5212812F3
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 18:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E99DC30D13;
	Wed, 25 Oct 2023 18:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P/TuKCa+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA1B2AB5C
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 18:27:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E37C6C433C7;
	Wed, 25 Oct 2023 18:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698258462;
	bh=YYXy/gObPp1fL1bjr3KnsA6bknexBMfSLaMP4mbqZbY=;
	h=From:To:Cc:Subject:Date:From;
	b=P/TuKCa+FdE0+IfHVfkKcKRIcQEn4jdleZmn5lEFDWTqzbpLtg0xT08y/QoNhDMex
	 v9OZkg3zI4NgLE6/pZL/YWBExjt25uORb+ke9VYbtj3khNcWp1nJl1CUAgVQ/p73c/
	 I014riFyIYn45Der/qlGXcUhXQJTWYfRoUxN8bR/YsdoTWXwQHRi2CBKYC4L9geXB2
	 a/9Fplxm6GmEoLdjtngBib07EkuFskJO1D4mSIXpAbuqa2CVEnXOR24tWs4jEmRBR9
	 5VwVpyxHRQbzQqK8EQPW5hTyH7Y9fSDttiDvJGBXjuqnMwYKIUXL1iYZ7Oxo9Z+sBZ
	 ml+vBSAY84gRQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	martineau@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Davide Caratti <dcaratti@redhat.com>
Subject: [PATCH net-next] tools: ynl-gen: respect attr-cnt-name at the attr set level
Date: Wed, 25 Oct 2023 11:27:39 -0700
Message-ID: <20231025182739.184706-1-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Davide reports that we look for the attr-cnt-name in the wrong
object. We try to read it from the family, but the schema only
allows for it to exist at attr-set level.

Reported-by: Davide Caratti <dcaratti@redhat.com>
Link: https://lore.kernel.org/all/CAKa-r6vCj+gPEUKpv7AsXqM77N6pB0evuh7myHq=585RA3oD5g@mail.gmail.com/
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
Looking at the schema this is plain wrong, so we should fix
regardless of what you decide to do with MPTCP.
---
 tools/net/ynl/ynl-gen-c.py | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/ynl-gen-c.py
index 1c7474ad92dc..13427436bfb7 100755
--- a/tools/net/ynl/ynl-gen-c.py
+++ b/tools/net/ynl/ynl-gen-c.py
@@ -789,9 +789,11 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
                 pfx = f"{family.name}-a-{self.name}-"
             self.name_prefix = c_upper(pfx)
             self.max_name = c_upper(self.yaml.get('attr-max-name', f"{self.name_prefix}max"))
+            self.cnt_name = c_upper(self.yaml.get('attr-cnt-name', f"__{self.name_prefix}max"))
         else:
             self.name_prefix = family.attr_sets[self.subset_of].name_prefix
             self.max_name = family.attr_sets[self.subset_of].max_name
+            self.cnt_name = family.attr_sets[self.subset_of].cnt_name
 
         # Added by resolve:
         self.c_name = None
@@ -2354,8 +2356,7 @@ _C_KW = {
         if attr_set.subset_of:
             continue
 
-        cnt_name = c_upper(family.get('attr-cnt-name', f"__{attr_set.name_prefix}MAX"))
-        max_value = f"({cnt_name} - 1)"
+        max_value = f"({attr_set.cnt_name} - 1)"
 
         val = 0
         uapi_enum_start(family, cw, attr_set.yaml, 'enum-name')
@@ -2367,7 +2368,7 @@ _C_KW = {
             val += 1
             cw.p(attr.enum_name + suffix)
         cw.nl()
-        cw.p(cnt_name + ('' if max_by_define else ','))
+        cw.p(attr_set.cnt_name + ('' if max_by_define else ','))
         if not max_by_define:
             cw.p(f"{attr_set.max_name} = {max_value}")
         cw.block_end(line=';')
-- 
2.41.0


