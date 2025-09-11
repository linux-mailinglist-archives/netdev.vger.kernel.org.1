Return-Path: <netdev+bounces-222288-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3206EB53CD4
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 22:05:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6AD81750A5
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 20:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D1B241663;
	Thu, 11 Sep 2025 20:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="p954Zw0D"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038B32DC784;
	Thu, 11 Sep 2025 20:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757621132; cv=none; b=gclZt+G520TMf9LLH42zZDVAmg5ADcUqIoCZi8VxsNSakSAeuU71F+lHfgTryXxBTlE+RINguB53LYJRgWygOvaTz2avd3KkImCVEVhKRwNXxZhoM6MHBehPMXHWNukItpA936+Jz+PvDv0dlqnQrlsASFBTmzSJyyTYsgM/+u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757621132; c=relaxed/simple;
	bh=cBJ8N3+usDyC0kts12vANVIdZbJUEHQHgUg3Ehv0XcY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t03y6KSiSQ3pqXV3WjOHsk5S6m4yPJWHO9IX4++mzIs2Ty3/bQfS8G2DgCnxRRuNV+gNGnL0fL3fBkPAOLDb6615w/SdnpZRdj2Tnhq0nSCi8Wqj9hRaPWSjadzXNerpYK/ZZw9Ybc9FLk1vQ1h4vO7NSMh3WObmmb4XLV+MAlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=p954Zw0D; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1757621127;
	bh=cBJ8N3+usDyC0kts12vANVIdZbJUEHQHgUg3Ehv0XcY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p954Zw0DXV1nCLEnrXMHUbaYWpXk6FPwoHeSN8IJ2aGGThLLjS0F79TIjgvs+v2Af
	 siMe/sDs+zpTlU9xPE2sPnC+CflXGs3Tdg6YZ1Ae3rdEVIa1vc9/9WbDEjKW3bjNe5
	 WSPsVDnzMWtOlI1Ed5zDZQ8daypp79UcicpFhfqBod3m9KsrJm5xrE51/4uQ9+WOVu
	 5OCLFQwMx9kRh8COcEkVqdV3HvLWjdumVIdpqI6AtSyB6ML5KDZf0B8cgoCMCb8XKF
	 lP77tJgd8+3iZcLyym/Z5wHSSGhwaceWgtmh2efqqRPxLEAB7kj3f0t0HnNYf6iDJF
	 QJSAo9v+lD+gw==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 8DFED600C4;
	Thu, 11 Sep 2025 20:05:26 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id 46FA62054AD; Thu, 11 Sep 2025 20:05:21 +0000 (UTC)
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
Subject: [PATCH net-next v3 11/13] tools: ynl: encode indexed-arrays
Date: Thu, 11 Sep 2025 20:05:04 +0000
Message-ID: <20250911200508.79341-12-ast@fiberby.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250911200508.79341-1-ast@fiberby.net>
References: <20250911200508.79341-1-ast@fiberby.net>
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


