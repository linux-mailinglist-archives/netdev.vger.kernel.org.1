Return-Path: <netdev+bounces-220150-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC00EB44916
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 00:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F924547796
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 22:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89F342EAD13;
	Thu,  4 Sep 2025 22:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="qEEI4Ltt"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7792C2E7184;
	Thu,  4 Sep 2025 22:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757023413; cv=none; b=IwTBTXqB0JzGfvaSrK5pLL6m6glNEbvroQhKNQti58Wz6v0KkCyqVp/pgRW4JaAiwZQVf18xwEIleNijAMElAqTS0zihzuYfYlh/QdZWJ6DFDs1MADVomkelcbMBUJoKM1KGibYBXlPPqtUil/hxLT7mD6NS4G3l3ghSZX6Zo3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757023413; c=relaxed/simple;
	bh=6Iy0Yilm5oHEhz283wxOZHnY/ug/LSR1F9Nk/MVOvDs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ee/XdZ77hT2iYqs/bM6J75TJHWa5vHrAuKzJOuSH2RSoIjqI7vUmovmbkVyImMuGWKJhmMvd3ca66j3J9BK9jcKUzkL+N1affh22ewyecx2Mh6XWfw2ek+NNjFXqiUU+ll5sbQKHE9tc0Ek/KwIi2HDmvxFxDVbfYIHe+sbC00Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=qEEI4Ltt; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1757023398;
	bh=6Iy0Yilm5oHEhz283wxOZHnY/ug/LSR1F9Nk/MVOvDs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qEEI4LttJNohu7lB6eUkOQr2nz2sTpGWRZhz6XnAoO+tBSvFgNejInjjNn44+fq8s
	 KIUiy2z3dVkp7iTJdhYCT/sWqzUGuNj0BCMsVOJ37xKGe5AbJFZWC86TxOwl06tGRw
	 CiLstuomxop6jk+Kqii8jEoXu2ZxRFYwNaf1+L3+Y6L30mfIi9q8dzhMAt+YjPT/e7
	 0CmImC1pjSrgTQB5Ri+K6uhgwdSRNUlbE9FEHttx7zbZIz3/c0tQvBtp32M/kpYL1W
	 xnfwGdwA+k6O0AYUtVxC98XFgUgZtBJlNOjTsHbpZhsLuUNi0I2C1L7ci0DXqLENEx
	 VCJO3FJ4k8Icw==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 8F0B660140;
	Thu,  4 Sep 2025 22:03:18 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id BA5F62025C0; Thu, 04 Sep 2025 22:02:09 +0000 (UTC)
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
Subject: [PATCH net-next 06/11] tools: ynl-gen: don't validate nested array attribute types
Date: Thu,  4 Sep 2025 22:01:29 +0000
Message-ID: <20250904220156.1006541-6-ast@fiberby.net>
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

In nested arrays don't require that the intermediate
attribute type should be a valid attribute type, it
might just be an index or simple 0, it is often not
even used.

See include/net/netlink.h about NLA_NESTED_ARRAY:
> The difference to NLA_NESTED is the structure:
> NLA_NESTED has the nested attributes directly inside
> while an array has the nested attributes at another
> level down and the attribute types directly in the
> nesting don't matter.

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
 tools/net/ynl/pyynl/ynl_gen_c.py | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index e6a84e13ec0a..3c0b158c4da8 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -834,11 +834,12 @@ class TypeArrayNest(Type):
     def _attr_get(self, ri, var):
         local_vars = ['const struct nlattr *attr2;']
         get_lines = [f'attr_{self.c_name} = attr;',
-                     'ynl_attr_for_each_nested(attr2, attr) {',
-                     '\tif (ynl_attr_validate(yarg, attr2))',
-                     '\t\treturn YNL_PARSE_CB_ERROR;',
-                     f'\tn_{self.c_name}++;',
-                     '}']
+                     'ynl_attr_for_each_nested(attr2, attr) {']
+        if self.attr['sub-type'] != 'nest':
+            get_lines.append('\tif (ynl_attr_validate(yarg, attr2))')
+            get_lines.append('\t\treturn YNL_PARSE_CB_ERROR;')
+        get_lines.append(f'\tn_{self.c_name}++;')
+        get_lines.append('}')
         return get_lines, None, local_vars
 
     def attr_put(self, ri, var):
-- 
2.51.0


