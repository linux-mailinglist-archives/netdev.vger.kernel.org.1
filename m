Return-Path: <netdev+bounces-57112-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D2498122B0
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 00:14:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 470591C21424
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 23:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5F9D83AFA;
	Wed, 13 Dec 2023 23:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c0k521/L"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA8183AF3
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 23:14:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A4E2C433CC;
	Wed, 13 Dec 2023 23:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702509285;
	bh=hr3/r10NXv4Up8rrG8F/Yi6BNbqmzwJQjx4d6rVYrQ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c0k521/LdwmKpg2BVC8FqAKBN5jHO9jrVBuoMhuIxmIW1JVKYsG57UiXbzQvAP6RJ
	 buy7VR+5Fr/lEIvfqob1WTzYLmr2BGlRvumgLg9u4joyUl70M7qz2vWIiye0yj2SQ9
	 0SeYsYAvA/s2e8kL9sz1kH03+txIcDZWX0F4/yTq41dShdwTjb5Xb6zVwdYwa4HHJT
	 tq6bJ47++gG8n+kOM5GK59rZf78e2wTTn6ZlrWbF5Fg8xBPXrclN9hLLf3TPCG5RIK
	 dVdR9ljlUyrMGCips1bjCaJ5v8xtPyxVUwTamDKmokEVJASwfN/HbFilXZUD3+volG
	 lJm5WMQc0x+AQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	nicolas.dichtel@6wind.com,
	jiri@resnulli.us,
	donald.hunter@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 2/8] tools: ynl-gen: use enum user type for members and args
Date: Wed, 13 Dec 2023 15:14:26 -0800
Message-ID: <20231213231432.2944749-3-kuba@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231213231432.2944749-1-kuba@kernel.org>
References: <20231213231432.2944749-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 30c902001534 ("tools: ynl-gen: use enum name from the spec")
added pre-cooked user type for enums. Use it to fix ignoring
enum-name provided in the spec.

This changes a type in struct ethtool_tunnel_udp_entry but is
generally inconsequential for current families.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/ynl-gen-c.py | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/ynl-gen-c.py
index 9484882dbc2e..ab009d0f9db5 100755
--- a/tools/net/ynl/ynl-gen-c.py
+++ b/tools/net/ynl/ynl-gen-c.py
@@ -333,9 +333,8 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
         else:
             self.is_bitfield = False
 
-        maybe_enum = not self.is_bitfield and 'enum' in self.attr
-        if maybe_enum and self.family.consts[self.attr['enum']].enum_name:
-            self.type_name = c_lower(f"enum {self.family.name}_{self.attr['enum']}")
+        if not self.is_bitfield and 'enum' in self.attr:
+            self.type_name = self.family.consts[self.attr['enum']].user_type
         elif self.is_auto_scalar:
             self.type_name = '__' + self.type[0] + '64'
         else:
-- 
2.43.0


