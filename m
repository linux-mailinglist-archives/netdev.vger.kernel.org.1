Return-Path: <netdev+bounces-223111-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31B5BB57F82
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 16:51:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0EDA7B1B06
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 14:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21F243469F8;
	Mon, 15 Sep 2025 14:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="NbaxkH1V"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1911341AA3;
	Mon, 15 Sep 2025 14:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757947676; cv=none; b=fRyawuFCs09LMsJvL7AbuAGIluvE7//BiIaSGwslPbK/l8lJyNsTlZjzVpk8VWr5XDep2Vqs8f/J4EbglfohTmVa6YlEf/wqUNJWETVyhqXOQFNam/eY7BX5HhkUZRlGHZkDLf79OAwGQ+V+pi8AnlZz6dbUF4UqOQd40KTKsyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757947676; c=relaxed/simple;
	bh=CklzBOgUQddwzBO3UlL2pkEPjFixeUSxqIJvFTCFOhk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HZAtwng9o3vbfHa9+Xj8wBXthQkpWgR7z1YVkC5txozYxz+cuUR3flOZ+4qx0zPgCMKSTw8xV+f565uhjOCGff85CXbxRhAYCouxrnbmN3THACFeAZR67fd9PEQt/8+Mkd5D53XhS9MEw73QkWrDdhWyTuNdTH1Y0l4tJAGKr5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=NbaxkH1V; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1757947661;
	bh=CklzBOgUQddwzBO3UlL2pkEPjFixeUSxqIJvFTCFOhk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NbaxkH1VfBJI70Q8opnolbnjhvJ1jUIqdURF+XM4qienrRTxTbBacP/Pw/cmf1Cdx
	 OSNJpX2wL5Flr4MC81YhmyL+TJCYYQsUulAdZfdRU/d2OI1uDeHIuzmhIUjc/aMNPJ
	 tijZZqTH/dwvDdA9PrdgHEW/bnXTlKcICBtdArHZGgODGK4Pe6gRdgLQFZ3Xx2lsBc
	 FRRfrykrJ0EKgz6K6a6mZ33FuTe9x8fK9lg14ZajECK8xJhItyI1K4ZWECkhbIsIIP
	 kMkhJql1ilT2J3iiReDSVGLJz/a/qFXGLsFdeqXXEYjNf7Rbur+7PEkMd1LC0B7vHs
	 n1kuyYAByvgAA==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 1556C6013F;
	Mon, 15 Sep 2025 14:47:41 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id 6B8212051A8; Mon, 15 Sep 2025 14:43:06 +0000 (UTC)
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
Subject: [PATCH net-next v5 10/11] tools: ynl: decode hex input
Date: Mon, 15 Sep 2025 14:42:55 +0000
Message-ID: <20250915144301.725949-11-ast@fiberby.net>
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

This patch adds support for decoding hex input, so
that binary attributes can be read through --json.

Example (using future wireguard.yaml):
 $ sudo ./tools/net/ynl/pyynl/cli.py --family wireguard \
   --do set-device --json '{"ifindex":3,
     "private-key":"2a ae 6c 35 c9 4f cf <... to 32 bytes>"}'

In order to somewhat mirror what is done in _formatted_string(),
then for non-binary attributes attempt to convert it to an int.

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
Reviewed-by: Donald Hunter <donald.hunter@gmail.com>
---
 tools/net/ynl/pyynl/lib/ynl.py | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/net/ynl/pyynl/lib/ynl.py b/tools/net/ynl/pyynl/lib/ynl.py
index 9fd83f8b091f..707753e371e2 100644
--- a/tools/net/ynl/pyynl/lib/ynl.py
+++ b/tools/net/ynl/pyynl/lib/ynl.py
@@ -971,6 +971,11 @@ class YnlFamily(SpecFamily):
                 raw = ip.packed
             else:
                 raw = int(ip)
+        elif attr_spec.display_hint == 'hex':
+            if attr_spec['type'] == 'binary':
+                raw = bytes.fromhex(string)
+            else:
+                raw = int(string, 16)
         else:
             raise Exception(f"Display hint '{attr_spec.display_hint}' not implemented"
                             f" when parsing '{attr_spec['name']}'")
-- 
2.51.0


