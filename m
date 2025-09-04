Return-Path: <netdev+bounces-220158-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 384B8B44920
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 00:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 533DA7BB6CB
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 22:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4360D2D9EF4;
	Thu,  4 Sep 2025 22:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="ky1OlIjG"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14AF62EA15E;
	Thu,  4 Sep 2025 22:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757023416; cv=none; b=ZOBRtPt9jgNt39jg0Z9niu3RSeb6f1uLK4J2pdTWTspXQ5n1TF05vVigCrvq7GT6ZJJNsrq2sySNfUPefi9G8u0w1HiY6/l1qMhYI/n8OK/bywxWPyYzH9b/B8vYGve00Au+Xaao6YdHZ2FMbhiqbm+6kEoRlX/bBS0SLyP1N44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757023416; c=relaxed/simple;
	bh=1d9dz0MFSz7ZmhIL6hDuc8ci8qBPILxE41nDcSMMkeg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=motbwAp/3QlRrLHyPZVMrUNZrppn/6EuQ4gDahD+4Bbpamu7+S6+BHoTenARukxtxEO+Lf66MSxG+i16g9nGelpufUn8hpOddG8o63Kpn4+uXcm9pt0JCTxIpT4US6ROLLxq/s9udHyz0skgiOaldwG0/fbrFKzDsM+aF3F/fhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=ky1OlIjG; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1757023398;
	bh=1d9dz0MFSz7ZmhIL6hDuc8ci8qBPILxE41nDcSMMkeg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ky1OlIjG9upN4xQj7DcuxsvGtECcUoeZ+xy+n6+pfAZiYlAuY5U8HoIG9f0mnn719
	 df1ZFS8nsGgJCdGGB25lagosD0M/7FcIu9HlhGJn2yxsduWWoxg4QAMc2aUH9PaMvH
	 D2F36N0EWmCG8OEOaNpC2QD0hXCCY1NFNnUTaA9NRK6kXMM2iHld1QyRSyGLcnLGwU
	 8TuiU378kRJZ4beVM9gEhZNhTAoF3TK/pvk5vALhug0P6N+X2BgLm2nvZ8GyoT5um+
	 e4S79rz0rJSAKWIip+yOe3pqUD3Ma8BZumdpg0A32mawG/Z6JcRZp8QmrISAe3JwMi
	 GNB3+VYWBfLCg==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id ED15B6057F;
	Thu,  4 Sep 2025 22:03:18 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id C34122025D6; Thu, 04 Sep 2025 22:02:09 +0000 (UTC)
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
	wireguard@lists.zx2c4.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 07/11] tools: ynl-gen: rename TypeArrayNest to TypeIndexedArray
Date: Thu,  4 Sep 2025 22:01:30 +0000
Message-ID: <20250904220156.1006541-7-ast@fiberby.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250904-wg-ynl-prep@fiberby.net>
References: <20250904-wg-ynl-prep@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

As TypeArrayNest can now be used with many other sub-types
than nest, then rename it to TypeIndexedArray, to reduce
confusion.

This is a trivial patch with no behavioural changes intended.

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
 tools/net/ynl/pyynl/ynl_gen_c.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index 3c0b158c4da8..c4a6895ab5bb 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -792,7 +792,7 @@ class TypeMultiAttr(Type):
                 f"{presence} = n_{self.c_name};"]
 
 
-class TypeArrayNest(Type):
+class TypeIndexedArray(Type):
     def is_multi_val(self):
         return True
 
@@ -829,7 +829,7 @@ class TypeArrayNest(Type):
         elif self.attr['sub-type'] == 'nest':
             return f'.type = YNL_PT_NEST, .nest = &{self.nested_render_name}_nest, '
         else:
-            raise Exception(f"Typol for ArrayNest sub-type {self.attr['sub-type']} not supported, yet")
+            raise Exception(f"Typol for IndexedArray sub-type {self.attr['sub-type']} not supported, yet")
 
     def _attr_get(self, ri, var):
         local_vars = ['const struct nlattr *attr2;']
@@ -859,7 +859,7 @@ class TypeArrayNest(Type):
             ri.cw.p(f'for (i = 0; i < {var}->_count.{self.c_name}; i++)')
             ri.cw.p(f"{self.nested_render_name}_put(nlh, i, &{var}->{self.c_name}[i]);")
         else:
-            raise Exception(f"Put for ArrayNest sub-type {self.attr['sub-type']} not supported, yet")
+            raise Exception(f"Put for IndexedArray sub-type {self.attr['sub-type']} not supported, yet")
         ri.cw.p('ynl_attr_nest_end(nlh, array);')
         ri.cw.block_end()
 
@@ -1137,7 +1137,7 @@ class AttrSet(SpecAttrSet):
             t = TypeNest(self.family, self, elem, value)
         elif elem['type'] == 'indexed-array' and 'sub-type' in elem:
             if elem["sub-type"] in ['binary', 'nest', 'u32']:
-                t = TypeArrayNest(self.family, self, elem, value)
+                t = TypeIndexedArray(self.family, self, elem, value)
             else:
                 raise Exception(f'new_attr: unsupported sub-type {elem["sub-type"]}')
         elif elem['type'] == 'nest-type-value':
-- 
2.51.0


