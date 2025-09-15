Return-Path: <netdev+bounces-223108-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AACE9B57F77
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 16:49:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25A331AA16C8
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 14:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07DE63431E9;
	Mon, 15 Sep 2025 14:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="R3xdIgxC"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1840340DAB;
	Mon, 15 Sep 2025 14:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757947674; cv=none; b=d91ubmHq3BMCKtFOPVXnj10ranPU5/yk0geEgqzERxqG/4YnqdS3QLOseRG96NwBVB18cUB6PSyCpQCrKKUy68BJfGg4MuE+X/vrIZAWZkbp3H5lgOugCdeXQWDsqMyEBEyPkVgPaKqKgsC4n5sxwZ2RKU7ODMUBBTq7Ih/y8r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757947674; c=relaxed/simple;
	bh=+xB7OdBH5/hOoPqTnhZSd84UXQV32QC9Igc+BZIJ9TQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lzvMoooF5NKvtLVK9eyuTIwwiKoLp8T2m6AZ3KFGf3utjyF2P+tB41mm2CyDlSFc66Wt1RS/CU7MKv8iAGK8nO64qLJHIkLm32rv34YgJQ+FPXb7Hz5Ko5MOau0cq0YwUvugThxlnW0FGIICAxT+3XBvHcOr9JzswS9HYzeMjKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=R3xdIgxC; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1757947661;
	bh=+xB7OdBH5/hOoPqTnhZSd84UXQV32QC9Igc+BZIJ9TQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R3xdIgxCeA3n4EbMNYcIrRdec2kx3Q55RbVNs+fSZKSnNH5f96l+aN38xj69pVEAt
	 db26hmc7StGFTbOrlTaTgzK1klDBXy7P1S7lqjLT6P/LWOC5cvG6Bj5dRfeskgLJpZ
	 /R2sICGICoqeRWvob38nD55yijrLSrt268BJkwPAJrq0IhSxX1jy2I51aRjxuSUBLl
	 vQ0XTBI1pTD9sALnALoMt25Kb+Kv+7lFY+ArK6S7FbU0eu7TnKpn0psSQ2PQ//7XNP
	 Leyzagw/8nm2vQsAzjv6hvQOIJSlZuk8JrN/8jiNamkdoJqAS4Gso4KCtKEcIudQ3l
	 IFk5MM98qlD5Q==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 1A8A960140;
	Mon, 15 Sep 2025 14:47:41 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id 60EC0204FB3; Mon, 15 Sep 2025 14:43:06 +0000 (UTC)
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
Subject: [PATCH net-next v5 09/11] tools: ynl: encode indexed-arrays
Date: Mon, 15 Sep 2025 14:42:54 +0000
Message-ID: <20250915144301.725949-10-ast@fiberby.net>
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

This patch adds support for encoding indexed-array
attributes with sub-type nest in pyynl.

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
Reviewed-by: Donald Hunter <donald.hunter@gmail.com>
---
 tools/net/ynl/pyynl/lib/ynl.py | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/net/ynl/pyynl/lib/ynl.py b/tools/net/ynl/pyynl/lib/ynl.py
index 92ff26f34f4d..9fd83f8b091f 100644
--- a/tools/net/ynl/pyynl/lib/ynl.py
+++ b/tools/net/ynl/pyynl/lib/ynl.py
@@ -563,6 +563,11 @@ class YnlFamily(SpecFamily):
             nl_type |= Netlink.NLA_F_NESTED
             sub_space = attr['nested-attributes']
             attr_payload = self._add_nest_attrs(value, sub_space, search_attrs)
+        elif attr['type'] == 'indexed-array' and attr['sub-type'] == 'nest':
+            nl_type |= Netlink.NLA_F_NESTED
+            sub_space = attr['nested-attributes']
+            attr_payload = self._encode_indexed_array(value, sub_space,
+                                                      search_attrs)
         elif attr["type"] == 'flag':
             if not value:
                 # If value is absent or false then skip attribute creation.
@@ -616,6 +621,9 @@ class YnlFamily(SpecFamily):
         else:
             raise Exception(f'Unknown type at {space} {name} {value} {attr["type"]}')
 
+        return self._add_attr_raw(nl_type, attr_payload)
+
+    def _add_attr_raw(self, nl_type, attr_payload):
         pad = b'\x00' * ((4 - len(attr_payload) % 4) % 4)
         return struct.pack('HH', len(attr_payload) + 4, nl_type) + attr_payload + pad
 
@@ -627,6 +635,14 @@ class YnlFamily(SpecFamily):
                                            sub_attrs)
         return attr_payload
 
+    def _encode_indexed_array(self, vals, sub_space, search_attrs):
+        attr_payload = b''
+        for i, val in enumerate(vals):
+            idx = i | Netlink.NLA_F_NESTED
+            val_payload = self._add_nest_attrs(val, sub_space, search_attrs)
+            attr_payload += self._add_attr_raw(idx, val_payload)
+        return attr_payload
+
     def _get_enum_or_unknown(self, enum, raw):
         try:
             name = enum.entries_by_val[raw].name
-- 
2.51.0


