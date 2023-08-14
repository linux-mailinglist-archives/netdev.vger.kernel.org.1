Return-Path: <netdev+bounces-27477-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 517A877C1E0
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 22:57:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E5D21C20B84
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 20:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC29EDF69;
	Mon, 14 Aug 2023 20:56:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83835DDD2
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 20:56:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C30D3C433C7;
	Mon, 14 Aug 2023 20:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692046593;
	bh=fZa5u3rKhblFUJXeA49wV6czKxOro69Ms5qMfD7QvoA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rq6hWVZ5HHlria4pyBFD2FMQT+db0X/kkoOMRiy7iX7HNm+nhMWtOA8b84oRMNfn8
	 nrsDcwNJ275fIdLb9RXaMO/9ZCdkZ8SIwmckQfGhLngZwZSLIs0e5XVNc4tqVMJt3J
	 VGrXmV8id+RnzeLSdShF1/D5uB9Hhm/hKmkbikrXy7rlc0elJbhTTGAzGK/pK7dyT7
	 bYmBwTU9knBkkiiGTqTNWvRMz109v4jDqDLEagoiFmSk4uqgfCh9O3+pbKmLRY/B8C
	 iGHWIJSXWoR3zTf7S+Ef2GBbEr5yDtEVuO6NQaQzsrCHY0g1SvHnSzjTrL4veoxx7+
	 3bu00Gl/hl1sg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	donald.hunter@gmail.com
Subject: [PATCH net-next 3/3] tools: ynl: add more info to KeyErrors on missing attrs
Date: Mon, 14 Aug 2023 13:56:27 -0700
Message-ID: <20230814205627.2914583-4-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230814205627.2914583-1-kuba@kernel.org>
References: <20230814205627.2914583-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When developing specs its useful to know which attr space
YNL was trying to find an attribute in on key error.

Instead of printing:
 KeyError: 0
add info about the space:
 Exception: Space 'vport' has no attribute with value '0'

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: donald.hunter@gmail.com
---
 tools/net/ynl/lib/ynl.py | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
index 3ca28d4bcb18..6951bcc7efdc 100644
--- a/tools/net/ynl/lib/ynl.py
+++ b/tools/net/ynl/lib/ynl.py
@@ -395,7 +395,10 @@ genl_family_name_to_id = None
                              self.family.genl_family['mcast'][mcast_name])
 
     def _add_attr(self, space, name, value):
-        attr = self.attr_sets[space][name]
+        try:
+            attr = self.attr_sets[space][name]
+        except KeyError:
+            raise Exception(f"Space '{space}' has no attribute '{name}'")
         nl_type = attr.value
         if attr["type"] == 'nest':
             nl_type |= Netlink.NLA_F_NESTED
@@ -450,7 +453,10 @@ genl_family_name_to_id = None
         attr_space = self.attr_sets[space]
         rsp = dict()
         for attr in attrs:
-            attr_spec = attr_space.attrs_by_val[attr.type]
+            try:
+                attr_spec = attr_space.attrs_by_val[attr.type]
+            except KeyError:
+                raise Exception(f"Space '{space}' has no attribute with value '{attr.type}'")
             if attr_spec["type"] == 'nest':
                 subdict = self._decode(NlAttrs(attr.raw), attr_spec['nested-attributes'])
                 decoded = subdict
@@ -479,7 +485,10 @@ genl_family_name_to_id = None
 
     def _decode_extack_path(self, attrs, attr_set, offset, target):
         for attr in attrs:
-            attr_spec = attr_set.attrs_by_val[attr.type]
+            try:
+                attr_spec = attr_set.attrs_by_val[attr.type]
+            except KeyError:
+                raise Exception(f"Space '{attr_set.name}' has no attribute with value '{attr.type}'")
             if offset > target:
                 break
             if offset == target:
-- 
2.41.0


