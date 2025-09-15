Return-Path: <netdev+bounces-223107-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF6AB57F72
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 16:49:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24E091AA19BF
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 14:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8A3C342C98;
	Mon, 15 Sep 2025 14:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="YQuirKBE"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940FE340D83;
	Mon, 15 Sep 2025 14:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757947674; cv=none; b=diCSb1Ytk1f19+ToX5AiPd39reRu/7uMAwO1kbuxny/bLmgG6aFAocYhWkqn7pUTiDv7aDyaNvk0xPvFsZpf+h459hYj3b+h+jIqaFMVNKj3I2/Yov8vAqU2ANEPF6sqsxr6N7BTzM3DTT0mua9KwxBErzJx8Az7xqZ21TyjbkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757947674; c=relaxed/simple;
	bh=HqyIhwC1Ng9W9Rs+TyJnvWCNwSRIXH4apSsRMl21lQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gwdYAumoBhSvmjvi2JWwMtri2ZZWqYfJ8eU/i76OTwrvUTnmPyNjqHoMksxzpx6dv5TsRWtIYa2dyfN0ngeXY/D19IVO6O2g0fv5d7TmZRuGlzpiYBTFXvXpS0V9if++P4CwsAHfyLnil6GAruTcrNx575jzn4V3GD6RC8dbww4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=YQuirKBE; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1757947661;
	bh=HqyIhwC1Ng9W9Rs+TyJnvWCNwSRIXH4apSsRMl21lQA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YQuirKBE7nmnkHnjZ+/f5UNewQW0CsnPpiH2DG62E5cu/dGlE/dwMyOTAzJqBhjG6
	 vqUROmNXoNGpG+WqNETsk7hHD6oJXL2zLInMgiqpnItA6bRYWbl/VlT3lReGQJEZQw
	 rPeqmojL3dkmfkIy147FLlilZD1NUQmTNzjn51EEISChIc9PzU0JavUwmA6oeAfHBR
	 38OKjZRSbgeOLJd3FOwNXjL6CcYPu7O2vGOJFEQprcHnFt0HPloNMxd8ufTPzNx/Xc
	 vw2GX6NnKpcJXlinvpX8P1JBNIaNQC6+IZyu2z5DuBWEdu1rFv+KKYonzaXZZOLChL
	 OdrgDMAwKoxSw==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 0CEFF6013E;
	Mon, 15 Sep 2025 14:47:41 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id 56735204EE2; Mon, 15 Sep 2025 14:43:06 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	Donald Hunter <donald.hunter@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	wireguard@lists.zx2c4.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v5 08/11] tools: ynl: move nest packing to a helper function
Date: Mon, 15 Sep 2025 14:42:53 +0000
Message-ID: <20250915144301.725949-9-ast@fiberby.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250915144301.725949-1-ast@fiberby.net>
References: <20250915144301.725949-1-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch moves nest packing into a helper function,
that can also be used for packing indexed arrays.

No behavioural changes intended.

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
Reviewed-by: Donald Hunter <donald.hunter@gmail.com>
---
 tools/net/ynl/pyynl/lib/ynl.py | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/tools/net/ynl/pyynl/lib/ynl.py b/tools/net/ynl/pyynl/lib/ynl.py
index 50805e05020a..92ff26f34f4d 100644
--- a/tools/net/ynl/pyynl/lib/ynl.py
+++ b/tools/net/ynl/pyynl/lib/ynl.py
@@ -561,11 +561,8 @@ class YnlFamily(SpecFamily):
 
         if attr["type"] == 'nest':
             nl_type |= Netlink.NLA_F_NESTED
-            attr_payload = b''
             sub_space = attr['nested-attributes']
-            sub_attrs = SpaceAttrs(self.attr_sets[sub_space], value, search_attrs)
-            for subname, subvalue in value.items():
-                attr_payload += self._add_attr(sub_space, subname, subvalue, sub_attrs)
+            attr_payload = self._add_nest_attrs(value, sub_space, search_attrs)
         elif attr["type"] == 'flag':
             if not value:
                 # If value is absent or false then skip attribute creation.
@@ -622,6 +619,14 @@ class YnlFamily(SpecFamily):
         pad = b'\x00' * ((4 - len(attr_payload) % 4) % 4)
         return struct.pack('HH', len(attr_payload) + 4, nl_type) + attr_payload + pad
 
+    def _add_nest_attrs(self, value, sub_space, search_attrs):
+        sub_attrs = SpaceAttrs(self.attr_sets[sub_space], value, search_attrs)
+        attr_payload = b''
+        for subname, subvalue in value.items():
+            attr_payload += self._add_attr(sub_space, subname, subvalue,
+                                           sub_attrs)
+        return attr_payload
+
     def _get_enum_or_unknown(self, enum, raw):
         try:
             name = enum.entries_by_val[raw].name
-- 
2.51.0


