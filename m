Return-Path: <netdev+bounces-206876-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4640AB04A94
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 00:28:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E60BD7A382E
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 22:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70EEB278E6A;
	Mon, 14 Jul 2025 22:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rZdlbtfe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB42278753
	for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 22:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752532071; cv=none; b=juWugTGxpxKW/2skgZ3yhBRg8zoJe79VuTnIos0nMqqPrb2OqGaNrTkLF+Prs2jhPMMQwBKZgh/ZpTr8XZ6Pkd0KJESx6ZWOzC7rJsKBG489sA1PP5Vr/zzzKwmqY5WL84XTlkWLu1VmFt7dzCSQKWQn/1quf3O4knd0vsgUV/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752532071; c=relaxed/simple;
	bh=DETITJm/NYF3hcFTJsoyG7Gf6nbMVY0X9JzyWHSF6tc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EXdV/H/7IjERlNZqm8expGE7XA4knVQ/7NmI9iWRv07z1KBX0nMH1LrdUj8owmR2mUi/zsdUDahQN01J3RJMoOYmdSEISuRdKuk2Iww+kUZ3fMTBFW9JdX32fg9J/2Uw00HNjLUDWHLDzUh9OE0x9z2ghLFt7nqAb7v5S/gx3ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rZdlbtfe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FF20C4CEF4;
	Mon, 14 Jul 2025 22:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752532070;
	bh=DETITJm/NYF3hcFTJsoyG7Gf6nbMVY0X9JzyWHSF6tc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rZdlbtfey1NCPB1SX2tI/PgI/WbbAau3j5l7VUNURPADHJHR7r9ylrNKfoe9Z4WuX
	 vK0aebmjR9T05U0sV31VM+LUmsU0diDj2AMmAtcXIXHNrg9G8Px+nbJ0I9Z+Lv1rb8
	 1cc4vy9BeqnfyCNZy7UxYCpIarbqq5OPoLFp91Qvwyc9Q/8uoM3RT2QJhXjHZXYaNO
	 Pba8EebNj/LT2qNmVDDt7jKC39VF2y8iE38EiEWGhQQRD6nhV4rl3rfXGl3YO736yX
	 Vqqk7NTxh5v3VQHJVVB+bfEqVkxf1tF5btysoeAygoqWK3ctqk7SGtQswZnQufXfYf
	 +HA07m6YczTyw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	shuah@kernel.org,
	kory.maincent@bootlin.com,
	maxime.chevallier@bootlin.com,
	sdf@fomichev.me,
	ecree.xilinx@gmail.com,
	gal@nvidia.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 03/11] tools: ynl: support packing binary arrays of scalars
Date: Mon, 14 Jul 2025 15:27:21 -0700
Message-ID: <20250714222729.743282-4-kuba@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250714222729.743282-1-kuba@kernel.org>
References: <20250714222729.743282-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We support decoding a binary type with a scalar subtype already,
add support for sending such arrays to the kernel. While at it
also support using "None" to indicate that the binary attribute
should be empty. I couldn't decide whether empty binary should
be [] or None, but there should be no harm in supporting both.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: donald.hunter@gmail.com
---
 tools/net/ynl/pyynl/lib/ynl.py | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/net/ynl/pyynl/lib/ynl.py b/tools/net/ynl/pyynl/lib/ynl.py
index 006b359294a4..8244a5f440b2 100644
--- a/tools/net/ynl/pyynl/lib/ynl.py
+++ b/tools/net/ynl/pyynl/lib/ynl.py
@@ -575,7 +575,9 @@ genl_family_name_to_id = None
         elif attr["type"] == 'string':
             attr_payload = str(value).encode('ascii') + b'\x00'
         elif attr["type"] == 'binary':
-            if isinstance(value, bytes):
+            if value is None:
+                attr_payload = b''
+            elif isinstance(value, bytes):
                 attr_payload = value
             elif isinstance(value, str):
                 if attr.display_hint:
@@ -584,6 +586,9 @@ genl_family_name_to_id = None
                     attr_payload = bytes.fromhex(value)
             elif isinstance(value, dict) and attr.struct_name:
                 attr_payload = self._encode_struct(attr.struct_name, value)
+            elif isinstance(value, list) and attr.sub_type in NlAttr.type_formats:
+                format = NlAttr.get_format(attr.sub_type)
+                attr_payload = b''.join([format.pack(x) for x in value])
             else:
                 raise Exception(f'Unknown type for binary attribute, value: {value}')
         elif attr['type'] in NlAttr.type_formats or attr.is_auto_scalar:
-- 
2.50.1


