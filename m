Return-Path: <netdev+bounces-221888-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 79193B52478
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 01:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 575B24E156E
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 23:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB411313E3B;
	Wed, 10 Sep 2025 23:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="umbYFG1d"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B0730FF39;
	Wed, 10 Sep 2025 23:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757545742; cv=none; b=ZsjCJXS9+ZBKXpvnl/2CLMm8EZq4jXI70m4EufVnk+bOYnerJYO5mS1AX4ec2iWNPpTaen4LwG4wX6L5FVQhRoYF3Q8v7dndMBsSFkUBIWv/tEeodpqG96i1j1le6gyXSNnxgoxNQLAxhneYTNXBbI7IuJsUzkSSRQ1GkvLiFNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757545742; c=relaxed/simple;
	bh=Ns7Cgk5ZDdtF+Q6dyaF9mQHUhLgGBUAAJadXXI0Ry6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VE5CF+UyLCADfhSzNOqTaZDotKvX751HNhyWbR7A5a0m4eVWJKR1fBKSZX/yAajTyWqzZ+Ui7ZInhkzfrnHlkTBnwjQLsWBNumezk0PMcHXa4/u2jxSi7Rfl5fjh4M7jaEMSxdULXGWnzY1n57RTGqp+yK12lysF9HLwxLqOn9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=umbYFG1d; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1757545730;
	bh=Ns7Cgk5ZDdtF+Q6dyaF9mQHUhLgGBUAAJadXXI0Ry6M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=umbYFG1d5Yak61rLgZzoGxrWRIqKSxbBUaFIbuDdfZU1mTzy6jhP0VGirnCNImw5z
	 MySboBdfMvv+xHfYnjq2OiKHmbaodKvF6CCyAAdBlSIOtlTeIHxrAZoVDIDYZ/AAQU
	 f8hPGt6GK7+xz0sf9jKTI67/B8H3ry8VlDJpxzB47LEhd0+sFqoTtR88EB6bMrz3Xr
	 tNkqDER4VnB7JpFKB8un/pEp2TsXF8Nj6ZGSknA20gpJ0biBm2cOxrslEhgpfxDqr6
	 3kuga41VpSqcsIe6zGZn5RF6MB7rskNQ0+FbYqM3LFwUozTzKpR1SGeJJHlAjcuqZJ
	 nFet1GbCbDnSQ==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id CFABB6013B;
	Wed, 10 Sep 2025 23:08:50 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id 27688204E9E; Wed, 10 Sep 2025 23:08:43 +0000 (UTC)
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
Subject: [PATCH net-next v2 09/12] tools: ynl: move nest packing to a helper function
Date: Wed, 10 Sep 2025 23:08:31 +0000
Message-ID: <20250910230841.384545-10-ast@fiberby.net>
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

This patch moves nest packing into a helper function,
that can also be used for packing indexed arrays.

No behavioural changes intended.

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
Reviewed-by: Donald Hunter <donald.hunter@gmail.com>
---
 tools/net/ynl/pyynl/lib/ynl.py | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/tools/net/ynl/pyynl/lib/ynl.py b/tools/net/ynl/pyynl/lib/ynl.py
index 8244a5f440b2..4928b41c636a 100644
--- a/tools/net/ynl/pyynl/lib/ynl.py
+++ b/tools/net/ynl/pyynl/lib/ynl.py
@@ -562,11 +562,8 @@ class YnlFamily(SpecFamily):
 
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
@@ -623,6 +620,14 @@ class YnlFamily(SpecFamily):
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


