Return-Path: <netdev+bounces-222296-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01FCEB53CE3
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 22:07:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37785166A0E
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 20:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07FB5277CBF;
	Thu, 11 Sep 2025 20:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="R1eIAfT4"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A39274B2E;
	Thu, 11 Sep 2025 20:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757621136; cv=none; b=AOteA0MsnujZkDUP46drCb0cEOq+8m1T4QvXb6apW0vh7NUOJ7JE+p1roP2S8haTyuQuFXecJ4PS/WxsZKTNLQuDPgEgivc1PuvphsV7awtDYEQU3evw5vvn844zEob780FnlVoQhK1tUyZIRZW6sFh6vs7hhkfFA8YMvNyEI2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757621136; c=relaxed/simple;
	bh=HqyIhwC1Ng9W9Rs+TyJnvWCNwSRIXH4apSsRMl21lQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DibYRyK0qxmL/JJJU8Bn/Ia4e4qXMOqwbWcvOmkerqvjErtNcN1Nt8LkpvTmWfTzRP+9x2O7E+qKJph15cQkttgGKUPfKGP4Qe7Rf8SFt+Sd4Rx/T0T78cR9GmEwuzyfyrVmW81fgD9b5CdbnALduhUEeKTXUDjj0MeK+sPkxYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=R1eIAfT4; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1757621127;
	bh=HqyIhwC1Ng9W9Rs+TyJnvWCNwSRIXH4apSsRMl21lQA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R1eIAfT4gNvjKWImBI6ECcJxub9SVJj0y/ul+m0dloFG4jGE7pLAGoMs8W5BVqbtH
	 1jUHdAgrQzNF2lQC68Yw252tvzRLU39DUkLDM1IiYjQtcXGlzCpVRVruAdMb2iAuR0
	 FvcD9iJrHOVBT4sxJBlF75uBe3hHxqDCStyJ7b3bYDNIS2eX/fcL2CTuwbGv6qL3Le
	 AM8tCDqIu05g+eNFUAB61+xqgZr9jyBqUritWs8PALMwT4aYjEAzPeK5RBorzc+4kx
	 /k59qfBf7un1ESRO6vBc24dOux4PQkyQ3r8OGQAn8HDr+FWBPEoWTb87iUFfh6bh+V
	 AmfAeSCZN69vg==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 96B42601BA;
	Thu, 11 Sep 2025 20:05:27 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id 3D2662051A8; Thu, 11 Sep 2025 20:05:21 +0000 (UTC)
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
Subject: [PATCH net-next v3 10/13] tools: ynl: move nest packing to a helper function
Date: Thu, 11 Sep 2025 20:05:03 +0000
Message-ID: <20250911200508.79341-11-ast@fiberby.net>
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


