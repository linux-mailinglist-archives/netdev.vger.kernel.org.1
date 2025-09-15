Return-Path: <netdev+bounces-223106-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3024B57F6E
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 16:49:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1A1B487C47
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 14:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26754341679;
	Mon, 15 Sep 2025 14:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="tyjBku43"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C5B33EB06;
	Mon, 15 Sep 2025 14:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757947674; cv=none; b=tJ10FKMU3A9cA3UyMIKbuaBNTSSvfU3HIlOAOY4yMV8FXVgxw95wmHQHlFaQMM0wLQzRpmnOHRO1R+PXGpYNFEjIspcir8Y3Dx1//6MfRLc1K6rVH9r6h4FLE5W8XCulMRxIKf3eOLaPh7nTKPoGKFhxoApT4kH0TyjbFyOb9XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757947674; c=relaxed/simple;
	bh=EZJrSC8HKLIZeYkZ/ou7/O3NW58W1W8t+y2LSY8Uu94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mVUqQNEJZKHeOZAQm5VLLuFdlgjtqbsnHVQm8F6PPgYe39BHjGT2CIJdNcH5Dy2C6qVXGoi61KzMJHoZuodx3sq3U+e9lVB9qReV5/mljRJF+cAiurp0ZtlW50WSqFpkOrJ2gQbLK4l2F/c9LOqUyqcQtixizjEtzxwwPcsr0rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=tyjBku43; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1757947661;
	bh=EZJrSC8HKLIZeYkZ/ou7/O3NW58W1W8t+y2LSY8Uu94=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tyjBku43tj5Ngtx33BqGjDhluLloINzzLYhgEj0Aw6/Xg/XCW6Hqz6mGydYZJVZdO
	 xGYD1rPntX8gDe/oiDlrHjS/GyytFUk/XyxMZcmr333KyFWEozze0OD0c6m0hMFXGM
	 2Bq90pXxy3ygMazeyZIcDZcdDzqt3jRwGlQDxlzK/+KG1NS27tIpS+YjtCakQcdAWc
	 dDUWRZsb0yuAWDWiKgoNetqq2wyi6gr4WtJT6CxJ2C5QkUCYiAJyxf8f7GZ/wcyK2N
	 m4AJeWRKDcnxvaCzOQKLhmseH6PodzaK3zI3q0jQ4n1JKdo7Q8OHpQnJ7hIuEz49B2
	 I8u8GHu5EsThg==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 063BD6013C;
	Mon, 15 Sep 2025 14:47:41 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id 202DB20393F; Mon, 15 Sep 2025 14:43:06 +0000 (UTC)
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
Subject: [PATCH net-next v5 03/11] tools: ynl-gen: add sub-type check
Date: Mon, 15 Sep 2025 14:42:48 +0000
Message-ID: <20250915144301.725949-4-ast@fiberby.net>
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

Add a check to verify that the sub-type is "nest", and throw an
exception if no policy could be generated, as a guard to prevent
against generating a bad policy.

This is a trivial patch with no behavioural changes intended.

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
Reviewed-by: Donald Hunter <donald.hunter@gmail.com>
Reviewed-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
---
 tools/net/ynl/pyynl/ynl_gen_c.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index 95a60fdaf14e..3266af19edcd 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -825,8 +825,10 @@ class TypeArrayNest(Type):
             return f'.type = YNL_PT_U{c_upper(self.sub_type[1:])}, '
         elif self.attr['sub-type'] == 'binary' and 'exact-len' in self.checks:
             return f'.type = YNL_PT_BINARY, .len = {self.checks["exact-len"]}, '
-        else:
+        elif self.attr['sub-type'] == 'nest':
             return f'.type = YNL_PT_NEST, .nest = &{self.nested_render_name}_nest, '
+        else:
+            raise Exception(f"Typol for ArrayNest sub-type {self.attr['sub-type']} not supported, yet")
 
     def _attr_get(self, ri, var):
         local_vars = ['const struct nlattr *attr2;']
-- 
2.51.0


