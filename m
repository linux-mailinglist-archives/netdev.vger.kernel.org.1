Return-Path: <netdev+bounces-220140-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C23C4B44904
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 00:03:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A5EFA465E2
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 22:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D9982DA77D;
	Thu,  4 Sep 2025 22:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="P7lKnSX6"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A872C275B0A;
	Thu,  4 Sep 2025 22:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757023408; cv=none; b=VsbzOB/gf3nMySB2iWYBpBxU668xuhXvgSxfXdivN2VT+6W5aov0tR0DoWwc09vpLvPin7y2nXEZkgOl6o58tQ8CR98Ply0EqpRlYTyYcdCYgSxRi5rUYYXbg9TNmFY6NR41MWsoWGaDbMYRyy1YUfSYFCKIuHVvL8VrhVSoiPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757023408; c=relaxed/simple;
	bh=ODj6RhlwRxLTGLnRhQ5eS3l2jrWo/SBLLtOAG4EVhhM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uhhr+UYgehm2fkLgL22FoXno5c+to8MxMRy0eU3WvmFN0SBV1hwbOKQ06rKW2gHOV6/Ps3boT6mdJz9pJhC9ovm8YdgwP8IJZwC37Rjly4ooTAFlg7+alxcqtd9IH8HfbaAZlfcKpZScp5i9us1Y2ZaL75XrtO7CMMyb+q6ZEno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=P7lKnSX6; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1757023398;
	bh=ODj6RhlwRxLTGLnRhQ5eS3l2jrWo/SBLLtOAG4EVhhM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P7lKnSX6zr+/PVcx4vRXprAnAhEYt1+EhLFWZdW91EkGVGscno9bi5T9JkDgNrZhj
	 XfL6WwYvp8hGf/zxFJbDjMI1+pm4jkGv8ls6PK2K9+iDmfzmj+r0qWNxl56euJwjw5
	 jnCjRdaEDZGuqNjltbl7EGOwQaWIr6Pkq+CCQpVtNON8n4xiQGl1lpnrwNMyqEW1qE
	 KQ1rf4/jLJWgnv76XAhol+XjtPzKCmcEX8mNSvjqxRCPgkwaJofxJgGGaLMlkgDutg
	 29visO5/vmRB9z28F1e1pfjPGTiVVbWbQqER+HJQedLp4izuaAMTFd4WXQbeIBzbCM
	 glrnhKUhhF18A==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 9DE816012E;
	Thu,  4 Sep 2025 22:03:11 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id 8C1E6201FD8; Thu, 04 Sep 2025 22:02:09 +0000 (UTC)
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
Subject: [PATCH net-next 01/11] tools: ynl-gen: allow overriding name-prefix for constants
Date: Thu,  4 Sep 2025 22:01:24 +0000
Message-ID: <20250904220156.1006541-1-ast@fiberby.net>
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

Allow using custom name-prefix with constants,
just like it is for enum and flags declarations.

This is needed for generating WG_KEY_LEN in
include/uapi/linux/wireguard.h from a spec.

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
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


