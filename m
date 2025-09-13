Return-Path: <netdev+bounces-222817-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F1DAB563ED
	for <lists+netdev@lfdr.de>; Sun, 14 Sep 2025 02:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 122E4189EC04
	for <lists+netdev@lfdr.de>; Sun, 14 Sep 2025 00:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE172C11DF;
	Sat, 13 Sep 2025 23:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="Xm3vjlFN"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C07B2C11CA;
	Sat, 13 Sep 2025 23:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757807958; cv=none; b=PIDguIDm4vPIoB2jpmjUiHrkFtQgHvdmQabx4Ya2p3edlDGISh4UxqtDT3gvZHFeFfTHeh6H2t47D2XitEi2Abia9xgjIxqNZ4jO5fWM1xWuxKq+m7WC3kaacLcZcpRkBK2SY+0ipgWeSaWEOp41trC3k7QBSKdTJ1Cz96KhsgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757807958; c=relaxed/simple;
	bh=EZJrSC8HKLIZeYkZ/ou7/O3NW58W1W8t+y2LSY8Uu94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VWK9TFs6+dPaMnPN+n/Nr/7ho7PIm5Bz/c6QBrtOcMoQl3X2j0eOhyNj7ZnUR32iOwHqK2EkQhYm3IY00wlVJOdwmupqH+HxU47i6Zh7Hl3LzwafQigGctojNKGy+AXB9OR+Rj1zJMlFckCZJz0ll7Ef1HQ7z8M1AoeLx2CJLn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=Xm3vjlFN; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1757807952;
	bh=EZJrSC8HKLIZeYkZ/ou7/O3NW58W1W8t+y2LSY8Uu94=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xm3vjlFNGg+PC2MuFwo/YHxsjBdtYgSTmDGb05RcKqwbGjVrOmUEn3KSDXp3hmrLC
	 CNfzPS9uYrrgg7hU9Z9Qy62o6KvWNilvebhCLMvbOF/9gPa7na9bia4r4zw/XSa6ze
	 MJY5JJ4TlvQNqqHUuTA2Sz1P4QAB1sgaSr7nHmejovxGUv8m+Qd8SiuVecftGHfxn2
	 r2Xd4PCdr9pX/bqdMVJURnwMsfM1WKTcGR9S9dnEEYKxjO2d2F32ks1r9SulpPCIlC
	 N4tzs4LGq8Wfgzv7q7gKkJ4T2U+xyV+0wzvYnm58ryGPYiqXBdXR8RpB6qCEsklunm
	 R3mbguZdl3O3A==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 502BC6000C;
	Sat, 13 Sep 2025 23:59:12 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id 45C6D2038ED; Sat, 13 Sep 2025 23:58:57 +0000 (UTC)
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
Subject: [PATCH net-next v4 03/11] tools: ynl-gen: add sub-type check
Date: Sat, 13 Sep 2025 23:58:24 +0000
Message-ID: <20250913235847.358851-4-ast@fiberby.net>
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


