Return-Path: <netdev+bounces-222815-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 535CDB563E8
	for <lists+netdev@lfdr.de>; Sun, 14 Sep 2025 02:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 470AF3A26CB
	for <lists+netdev@lfdr.de>; Sun, 14 Sep 2025 00:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15DF02C11E3;
	Sat, 13 Sep 2025 23:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="ZFbeA0ob"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688692BEFFB;
	Sat, 13 Sep 2025 23:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757807958; cv=none; b=nRnxUnvQrAWOVtfQbLt2ntvmmgq0K6dHqwrm7j0pVDEK1CKAxDs+cqSRMc/+A2YiN1rcjzfX2uWpaR2cdtNgxTv0CBR/XFFHhqsGiOVoJ1Z2PFIYlkeWKwztuABYJjIv+rSza3qMD4RMc7x5EBW67EBpX8HOZrqovFJ2F1+bXDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757807958; c=relaxed/simple;
	bh=CklzBOgUQddwzBO3UlL2pkEPjFixeUSxqIJvFTCFOhk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WdF7zfRjvnwJUqVvCxVAaT2R2X2WcSCCjGPNaAWoVAYyx+kMxFg2O/eXSPmd8CGOA494qqsL/Ap/Ixi2zdvUj5Vw9wwMMX1aQbyp0N2FqyeR2BGeWSbAhKJh3HVDAsjTbTz3RJzmJvQbvbBIzbxnIOLkApOtiNfc8EdyU1fDcwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=ZFbeA0ob; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1757807952;
	bh=CklzBOgUQddwzBO3UlL2pkEPjFixeUSxqIJvFTCFOhk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZFbeA0obsZ/LV8zfxCNfnZr8P4fn3Izl0iP8loTpz26QA5GLRLQbhr07vsyiqvzu2
	 HXSxDiAFT6+ebF4L/cfkX7RVaboS2r+GNrWugJeHtc5TyVEGAkm40/rQ89dLvRKMe0
	 TerYLVBMzIM5GzwQZrUMT5WnQfkLUKVoPvha0FnJ7AO97JTeZD3QwVgvgFaW15gnIw
	 J4UemLGvg9KLghk8Yb/D2yjU1ElPyIas0QzJprWMAId83fchbSpS+LfywCle/tJ9hz
	 g5bDx5aKUZvdqTmrYsPtWe62Z8qmHJ+mg7o3JsGUDtxH+loDxFOHg46SKnD7bC4kS1
	 PvtYvCI9CaeMQ==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 5310960078;
	Sat, 13 Sep 2025 23:59:12 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id 878D420519B; Sat, 13 Sep 2025 23:58:57 +0000 (UTC)
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
Subject: [PATCH net-next v4 10/11] tools: ynl: decode hex input
Date: Sat, 13 Sep 2025 23:58:31 +0000
Message-ID: <20250913235847.358851-11-ast@fiberby.net>
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


