Return-Path: <netdev+bounces-222818-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E45B563EC
	for <lists+netdev@lfdr.de>; Sun, 14 Sep 2025 02:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25E783A4493
	for <lists+netdev@lfdr.de>; Sun, 14 Sep 2025 00:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 017C12C21F2;
	Sat, 13 Sep 2025 23:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="le4JH8fI"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688DB2C11CC;
	Sat, 13 Sep 2025 23:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757807958; cv=none; b=etPZK/wbO0xEB+MFbN3CbAFSauJYZN1nao/IkjuiLaYZFEDS0i9cd8LWjdKCpquaBMXeOwHJU72wjDP5a2d1oTH5YhJBcA21FUXzMFZHCAaSja31039HnIBmeYJSnEHbJ5RdEdYalz33GsOwE8PK61F6iHG5b2rRcYdzW8zwOdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757807958; c=relaxed/simple;
	bh=HqyIhwC1Ng9W9Rs+TyJnvWCNwSRIXH4apSsRMl21lQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FO4easMbd057oqpn1Km4wLoiDryxSMD+Kl5ehOLY5HTG1j/CZrnwm7vCIEFYPtN2MGWvPXRQzT9ei7vaSymbIKwUA1f/l7G7kK9ytzMEfHrfrQ6lRELSA7NlXC8iGO3jde/w0bYkfvZy2uwlZNwcUO+XeLzh7iSiJqSv+hHjr1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=le4JH8fI; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1757807952;
	bh=HqyIhwC1Ng9W9Rs+TyJnvWCNwSRIXH4apSsRMl21lQA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=le4JH8fI75erN98H+o4YToCsQY9N/LYcIKUefNNJf85hoyeGBl4urZHbdkoQvJN7D
	 nIDk0FzfygsPBlrMH0toZpnFxJnBsP2nS4lXsh1TSKHalHXC7BjAHJ4nPENP6rfafq
	 isDbhCLIspbDwifBF0NbPADXdrEb3ZORL8iZ0B7r5u1mSME7keRU0cgCACfn8RXY/E
	 PzqgugldhzK42isqyrxuvg3fkDm0GCoflVS1ue60SyVZNjirz9fHjC+WqU9bb/GZib
	 pWypIMyXCqDuxC6jPyrQpGnedCZwwlAaYTIV5QhcFsh8aNNO5ZyNU08K29bgEIPqpz
	 7IT2XDlhiDqiA==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 5585A600C4;
	Sat, 13 Sep 2025 23:59:12 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id 75069204E9E; Sat, 13 Sep 2025 23:58:57 +0000 (UTC)
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
Subject: [PATCH net-next v4 08/11] tools: ynl: move nest packing to a helper function
Date: Sat, 13 Sep 2025 23:58:29 +0000
Message-ID: <20250913235847.358851-9-ast@fiberby.net>
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


