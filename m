Return-Path: <netdev+bounces-221889-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C52F1B5247C
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 01:10:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4278E582C47
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 23:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D576731A573;
	Wed, 10 Sep 2025 23:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="a50bW58U"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85D2313E36;
	Wed, 10 Sep 2025 23:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757545744; cv=none; b=Z++bQEMKERa5sBaJUTqhcAUHRUf3nto8Mnr52VMoqBrxpLTRWZUIuCGtpIdAVExLPx7fri7wbuVp/94zTHZ9I5ew+j0DfOPciIJNj2bH00SPL9GQb81GqQh58jkJaTmZmtVE2GANgTfr0+zmoqwYWf+Ht4J95b7z5tvSFi7LtMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757545744; c=relaxed/simple;
	bh=zYZnZi0XfZFGANAoH/LGTsc2D0gQ6Tox0actlKX6EnA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d/JB7HIuRMQ2vk+npM6gl5nRlGooY1Bl4WutUmiB5GVbpHFXb9jnzVt5JYdtKawTWFgyBnqot3zzUiiqkov4tVir9JCz983DYLAnsc6PLZgZ0oTko+JSPfmNiFWUnqmleP8a9uqh7QGofCxd+G1a9O7DVp6Sm1aMMPpZVvDJkQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=a50bW58U; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1757545730;
	bh=zYZnZi0XfZFGANAoH/LGTsc2D0gQ6Tox0actlKX6EnA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a50bW58UB2o8fhRf2PHclk9ZQ6uKZ9vysOFTgFmsgFgpfG1kO1S8GNZTm7ZUFaotw
	 I+Sdu6PUVJNZpFlo42KXX/3fb2YJ9hrurHE+wdmJxghH4xd1BM1zU4mTBFV7WEz1Ae
	 cmapCYKbmtMrpwuzqiURTAbU39p5ZV8Xk/WlCU6XdYy/vL4Xt6hRknMRTLupKh/aF+
	 6fbe9FnrytcFy4JHls87nWDSWcLDt2w82kZBJXyujcxbeUock8Ln3x3+6PGjhFyfp1
	 VnCp8lTX8oCrwDPgnoppSXlYRRhIW67MLfjIrtsRQkUofsL2I6P4eN/S9O3frG3933
	 wpNBTEqNwGvWQ==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id E11C46013F;
	Wed, 10 Sep 2025 23:08:50 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id 31239204EED; Wed, 10 Sep 2025 23:08:43 +0000 (UTC)
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
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Sabrina Dubroca <sd@queasysnail.net>,
	wireguard@lists.zx2c4.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 10/12] tools: ynl: encode indexed-arrays
Date: Wed, 10 Sep 2025 23:08:32 +0000
Message-ID: <20250910230841.384545-11-ast@fiberby.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250910230841.384545-1-ast@fiberby.net>
References: <20250910230841.384545-1-ast@fiberby.net>
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
---
 tools/net/ynl/pyynl/lib/ynl.py | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/net/ynl/pyynl/lib/ynl.py b/tools/net/ynl/pyynl/lib/ynl.py
index 4928b41c636a..7ddf689a2a6e 100644
--- a/tools/net/ynl/pyynl/lib/ynl.py
+++ b/tools/net/ynl/pyynl/lib/ynl.py
@@ -564,6 +564,11 @@ class YnlFamily(SpecFamily):
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
@@ -617,6 +622,9 @@ class YnlFamily(SpecFamily):
         else:
             raise Exception(f'Unknown type at {space} {name} {value} {attr["type"]}')
 
+        return self._add_attr_raw(nl_type, attr_payload)
+
+    def _add_attr_raw(self, nl_type, attr_payload):
         pad = b'\x00' * ((4 - len(attr_payload) % 4) % 4)
         return struct.pack('HH', len(attr_payload) + 4, nl_type) + attr_payload + pad
 
@@ -628,6 +636,14 @@ class YnlFamily(SpecFamily):
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


