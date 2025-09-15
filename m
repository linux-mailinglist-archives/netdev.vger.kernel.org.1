Return-Path: <netdev+bounces-223100-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89C16B57F64
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 16:47:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0ED7E1AA125F
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 14:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD799335BBF;
	Mon, 15 Sep 2025 14:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="hoMUSXVK"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCA43218DD;
	Mon, 15 Sep 2025 14:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757947670; cv=none; b=hn3dn+2WG7OfrG4VJ7dOZ63j4IahOeMjAMoeYiTUrOjG9FxaO3jlDimLiwXSS2D1NIrqVzOb2MVLGZQn0IqoU41TT8aopkXLcOwkxwFvwttr19EDC9ovPkAatWYvT4b0fKcoD1UHM10+dFZzmmmkQYm9aBbGAs7OM47bUxL4Q9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757947670; c=relaxed/simple;
	bh=pnz1Z9RsFEA/w79qMxEPA9j3gcVp4d2qUkVblwMqsWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nm5FcHDISQQ1bxxM98vbFyOan75Gyb1fFPJ8SyWYoBSpLyShH5vumqYOs2areao52f2pFhlnVml3F4Hxuwnuic/Pe45/PhX9zcUJ6L2SmsJ1rAsUDNJtynr16i0Cs9vlRcDrLRbyxLQG+9FZOGk5aASt46r1/Z+MdE9kR1ImEuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=hoMUSXVK; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1757947660;
	bh=pnz1Z9RsFEA/w79qMxEPA9j3gcVp4d2qUkVblwMqsWk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hoMUSXVKFfde3bsoRfAP+zKKVg8wQ4eLCkWF1SzvhH1Wb6HPrw1v8MmYimae+etjC
	 Sn9cxM2gVRlBrAJuYUrDNhJMzt9o5bHQg/M67nFE8tf/b5V7cwR3spDypevXEYSKp/
	 IccJ6FRAys2IHLZOPcLEy61sP/qfB4LJGQDbAHROORyWNHwoffBho6lYDWUb8X/hPF
	 lw59aqHGpAJ0oUVcEIXYIyA/2oTwtWXagwKy9bjzk8Lr7o7DPy1GiKvpypIuRa3o7w
	 +jmI9PQiTe8MEDl3ZeVoyohEV43LO1fMh3WPu34OExv4gZIuJtSiRhSTAaL6RMm2Za
	 VQtXhQFWrs7pQ==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id CD0FB6000C;
	Mon, 15 Sep 2025 14:47:39 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id 06495201B79; Mon, 15 Sep 2025 14:43:06 +0000 (UTC)
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
Subject: [PATCH net-next v5 01/11] tools: ynl-gen: allow overriding name-prefix for constants
Date: Mon, 15 Sep 2025 14:42:46 +0000
Message-ID: <20250915144301.725949-2-ast@fiberby.net>
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
index 101d8ba9626f..c8b15569ecc1 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -3208,8 +3208,9 @@ def render_uapi(family, cw):
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


