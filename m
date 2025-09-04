Return-Path: <netdev+bounces-220141-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC83B44905
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 00:03:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 972FDA464C2
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 22:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BA352DAFBB;
	Thu,  4 Sep 2025 22:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="Kf+BU0Mb"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87A8284688;
	Thu,  4 Sep 2025 22:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757023408; cv=none; b=NW1+7yEAo+HqDjDT/69yBzaEKav5MYW/kDLhnn2GZnrZ/Y8abx/qYC6yGrI9cNQ6XjnREfqPjn6tVcybfpID5NmqVijMDH0as/jMa+WTgm1YcwAwCWTrY0R2ZR1gw6KSPN2cAkBMeEdAtQlcXBGvi+aADMXkXmMBITmdKVi5euw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757023408; c=relaxed/simple;
	bh=rgolZjPG+XHuMI4WAnndyywf6dHN7deNYLKzBJ40Ug8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L0GbU2NlaB82oqxiG39FVIJVI7a5DW1X145m530s6VhHytuwGrxRmc2dlLzeXKzHEXX5xvN85H7YglBIMwwqkZBsG8CPrPMiqqyhcJn7LJ8pXG3ChyqUWsxyTE/JPMKrQ7A8JnX/PNamO04ZSy0/r/O9Ot9WJY1h9lxBNvLOpAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=Kf+BU0Mb; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1757023398;
	bh=rgolZjPG+XHuMI4WAnndyywf6dHN7deNYLKzBJ40Ug8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Kf+BU0Mbw6te1L3Y0k0/wJuAWt208nEyXV8HTdlhU489vDYjfjqTUGezvTHZ38jnA
	 5ueFnP+5W7ERO9HX9DZOUjs6OGIqA2L0WfYSFvIdxaYr7WfsOb0Im3TCSZbjc7JDbg
	 amwVSjPtlfc0zjxzue7V6oU8vR8ogXIQkBHpKguqfsHUQ2+gAWoM04EvfTV79oTPU9
	 4S/+dXuantJZ0UxrcVAC/bFSghtiXda6Iu17+Noa0R7+6ABjT4aQOitwV/a7DyaZJA
	 xcMc042Yu3yy1Covvf6MNeeyTsbgP0lGgLXNI957fsnGgsybcV7N+hGuBmann7ltmJ
	 qQW3ShRKa2mIQ==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 8D9476000C;
	Thu,  4 Sep 2025 22:03:11 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id DFCAC2027BB; Thu, 04 Sep 2025 22:02:09 +0000 (UTC)
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
Subject: [PATCH net-next 10/11] tools: ynl: decode hex input
Date: Thu,  4 Sep 2025 22:01:33 +0000
Message-ID: <20250904220156.1006541-10-ast@fiberby.net>
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

This patch add support for decoding hex input, so
that binary attributes can be read through --json.

Example (using future wireguard.yaml):
 $ sudo ./tools/net/ynl/pyynl/cli.py --family wireguard \
   --do set-device --json '{"ifindex":3,
     "private-key":"2a ae 6c 35 c9 4f cf <... to 32 bytes>"}'

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
 tools/net/ynl/pyynl/lib/ynl.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/net/ynl/pyynl/lib/ynl.py b/tools/net/ynl/pyynl/lib/ynl.py
index a37294a751da..78c0245ca587 100644
--- a/tools/net/ynl/pyynl/lib/ynl.py
+++ b/tools/net/ynl/pyynl/lib/ynl.py
@@ -973,6 +973,8 @@ class YnlFamily(SpecFamily):
                 raw = ip.packed
             else:
                 raw = int(ip)
+        elif attr_spec.display_hint == 'hex':
+            raw = bytes.fromhex(string)
         else:
             raise Exception(f"Display hint '{attr_spec.display_hint}' not implemented"
                             f" when parsing '{attr_spec['name']}'")
-- 
2.51.0


