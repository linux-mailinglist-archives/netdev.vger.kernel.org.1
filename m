Return-Path: <netdev+bounces-222822-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FAC2B563F5
	for <lists+netdev@lfdr.de>; Sun, 14 Sep 2025 02:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 901FC4210F8
	for <lists+netdev@lfdr.de>; Sun, 14 Sep 2025 00:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4868B2D4811;
	Sat, 13 Sep 2025 23:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="NrZQX0B6"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1092D060E;
	Sat, 13 Sep 2025 23:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757807962; cv=none; b=Iu61iHC35NR5YH43Fv1O+iFy+P5l1eskImqHW2UObqfAlx+KeWcDiJiy/gCbDcSkRqnrM2Y6KYyqpAmRM6+Z+QXAUcQIhcHx+sgAccRg88oVLU05+hLmHZ8xX1Uq1GxEfiLjEFxqHC4X3J6d8Vs0Rhy8XkFUXDeYxND8sAoTSm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757807962; c=relaxed/simple;
	bh=+xB7OdBH5/hOoPqTnhZSd84UXQV32QC9Igc+BZIJ9TQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WGhr1+JQmtHK5H0n9bSnG52zSWX8Ick54hrkMSIHel4ftcJ6wzZb9LbhU2pHFHTh730eW/rTi2dP3MymcF19vLyrYzVP6Nh0YqAJe/kiWICHwpExl9ODX/fQ6xkhHMPJZ0ZaZ9dAy0/5eevju+nOoeHAGJzAj28PWtsbXLEG0RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=NrZQX0B6; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1757807953;
	bh=+xB7OdBH5/hOoPqTnhZSd84UXQV32QC9Igc+BZIJ9TQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NrZQX0B6c0VYXfc1W00IuMRAyT6sTusNLKz0qI/f5ImeJ7fPVHXoy3ak5EVb4vh7q
	 0S2olyQRNCz2A8EzsHc1Tn2+JmwYG6aOd8Edzd2wd8MQJdHei68rRnZK+oDCrBHPf4
	 FI0Wt8gSTuCE41u8idQDSSHdwhoDCtj4cWdp6vpRShRZ8TzAj4Rpdu3nHSK8S8Ojfa
	 EFyF7+iEjaFafzs7QJUF57VN5r5TMv1td5k3HcX9rofv8W6KjaGlPzSRn5RXBdRUbg
	 WNnVfGd99JQ21uoCzjBs6RBd4xmlYw0P7s0r759v3lzBIZ7+BzYmY98AfS2wlAkuz8
	 zY5EddjHEE39g==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 9B8866013B;
	Sat, 13 Sep 2025 23:59:13 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id 7E196204EED; Sat, 13 Sep 2025 23:58:57 +0000 (UTC)
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
Subject: [PATCH net-next v4 09/11] tools: ynl: encode indexed-arrays
Date: Sat, 13 Sep 2025 23:58:30 +0000
Message-ID: <20250913235847.358851-10-ast@fiberby.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250913235847.358851-1-ast@fiberby.net>
References: <20250913235847.358851-1-ast@fiberby.net>
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


