Return-Path: <netdev+bounces-221890-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC99B5247D
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 01:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DC9C485662
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 23:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6338E31D396;
	Wed, 10 Sep 2025 23:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="bBqxdVSi"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D519314B69;
	Wed, 10 Sep 2025 23:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757545745; cv=none; b=f3K8nfp5FQO2IL67Br+Ehe11k44FJGQTlWLE/Qz9A/1zOcy4pUIjHbtdZK2819ut6hVNz3ItKRa0KZJJY8T4OIAqWWzWrkAy8FZUXHwlWk2kv7xhBNf77/Tofr1nZSwtyOjqzsKG+wL2r99LuXBJdVE3nRaNskN1btR/QW+UBso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757545745; c=relaxed/simple;
	bh=BXBJfFZ+zTwLVHSQB68jOM4LzO0NIRI61RviYfjsvu0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fz9OHOu5hO7PCP2zn0MZzQtkid7iZjqtBk3zKUUjQvvsFl4uA4Fmb/mU69+G9No03eTo0ie/ZQYujnUTEj04hDFymA9BcbSw5uUsaTaIwLkKK43em9psxkh3deNWh3U5T/eeSCmddT1eul0ckQUVACNArJT78Y2afEbYLzQp8wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=bBqxdVSi; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1757545730;
	bh=BXBJfFZ+zTwLVHSQB68jOM4LzO0NIRI61RviYfjsvu0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bBqxdVSi6kSZofaDl44lkOtbNg80c6YNbSYMuAf/AVwIgtPHOnlUkvjG6C+9f/qb/
	 n4eJh4JMpEt/CuHjB3UuvkMvSsAqrNZ8ZnrHKL5NM2IZJWygHJYezgIte5L5XJK4T+
	 sG7WJwx/nA9z27PkDE5BWAvytDssIibs9UkxXW3Ybq5b0K6pMxFEFy0SuNIGLSKA7g
	 sBbv6SugbhobBsrALc3zjxhz54HVei8JvaGYG5GWxHN25rGr/hLr+wYd9Pj/xePqV7
	 fIbWxY/BL9W5L1KlIh3b2+ilAFSTMWwblORxPM4FQch3U/h9Nn9tguwN7/PpvpO+a+
	 ycqzJ+476TWZA==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id E947960140;
	Wed, 10 Sep 2025 23:08:50 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id C7C10201D12; Wed, 10 Sep 2025 23:08:42 +0000 (UTC)
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
Subject: [PATCH net-next v2 01/12] tools: ynl-gen: allow overriding name-prefix for constants
Date: Wed, 10 Sep 2025 23:08:23 +0000
Message-ID: <20250910230841.384545-2-ast@fiberby.net>
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

Allow using custom name-prefix with constants,
just like it is for enum and flags declarations.

This is needed for generating WG_KEY_LEN in
include/uapi/linux/wireguard.h from a spec.

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
Reviewed-by: Donald Hunter <donald.hunter@gmail.com>
Reviewed-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
---
 tools/net/ynl/pyynl/ynl_gen_c.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index fb7e03805a11..1543d4911bf5 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -3211,8 +3211,9 @@ def render_uapi(family, cw):
             cw.block_end(line=';')
             cw.nl()
         elif const['type'] == 'const':
+            name_pfx = const.get('name-prefix', f"{family.ident_name}-")
             defines.append([c_upper(family.get('c-define-name',
-                                               f"{family.ident_name}-{const['name']}")),
+                                               f"{name_pfx}{const['name']}")),
                             const['value']])
 
     if defines:
-- 
2.51.0


