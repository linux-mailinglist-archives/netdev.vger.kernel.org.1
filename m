Return-Path: <netdev+bounces-221891-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5125B5247E
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 01:10:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E9715842AA
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 23:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F52331E0F0;
	Wed, 10 Sep 2025 23:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="hyH/WVOo"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CD9314B6B;
	Wed, 10 Sep 2025 23:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757545745; cv=none; b=VUYoOoIlPoL+cZgNu3BwIEp4/wQY6A0235jj/szm78ieLq7CC+EZMpg1Ab24vOKM9bsfT/8TleFplW7AtGas0NO6agvi9e3bW7Da7WBv8dXYdsoI1SXnVMBL3sKJkF0/zMKctF8tlMEOcMHpB3HSo+858Lub1LPgh7LI60bIvCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757545745; c=relaxed/simple;
	bh=gPzW3wCV+qM3pD5q/z5sXTnTfFB9BV31CnXtVtDMhXI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QKsxoDBhEWOmwj7FcQTZrmIhm2l38SJxYIoIoghdivSCdnHpl4+GRazepEzJ09NVHdQ9meSry5gp2A047oFKmBuDygThtow3ZzjMMsPo6lH/0rFSveYVwbp535gPCH1Kz4PpL9BedKXCpR9GOs7o0U+xucoZ1IbBEQ2dUlAym/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=hyH/WVOo; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1757545730;
	bh=gPzW3wCV+qM3pD5q/z5sXTnTfFB9BV31CnXtVtDMhXI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hyH/WVOoCpQXnsmm/RhKX8w55PKl+c6IaIxkkHUJMtocIu6ROFzZaQLMEtFETOjbC
	 T0+1wMFchb6H5DS+dk/blqGvnoEA1XU6E+bG7lxLLEEJ66uspRFdy5lrQcSsqqqIRw
	 mePeC3azkYm3GXema0IW58Wb8ccnFg6Q4sovumUjHsyCMIs9s5gtZ36iaOBpJO45yt
	 IBpyvFhUKiVSS+6xllPdq0x5iP2KdILcYSH8Zf7kyzpxBiR9ozbhB8rFVKPMcdzGkq
	 1VtMH02EGSFLmPC695ZI/uTyG8BW+FEXOx+h0C7Q4rQQJ3FK7ZHbaHxIepgg7sdikq
	 3gknIExnuyazA==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id D73AB6013E;
	Wed, 10 Sep 2025 23:08:50 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id 3B22F20519B; Wed, 10 Sep 2025 23:08:43 +0000 (UTC)
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
Subject: [PATCH net-next v2 11/12] tools: ynl: decode hex input
Date: Wed, 10 Sep 2025 23:08:33 +0000
Message-ID: <20250910230841.384545-12-ast@fiberby.net>
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

This patch adds support for decoding hex input, so
that binary attributes can be read through --json.

Example (using future wireguard.yaml):
 $ sudo ./tools/net/ynl/pyynl/cli.py --family wireguard \
   --do set-device --json '{"ifindex":3,
     "private-key":"2a ae 6c 35 c9 4f cf <... to 32 bytes>"}'

In order to somewhat mirror what is done in _formatted_string(),
then for non-binary attributes attempt to convert it to an int.

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
 tools/net/ynl/pyynl/lib/ynl.py | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/net/ynl/pyynl/lib/ynl.py b/tools/net/ynl/pyynl/lib/ynl.py
index 7ddf689a2a6e..50f4889e721b 100644
--- a/tools/net/ynl/pyynl/lib/ynl.py
+++ b/tools/net/ynl/pyynl/lib/ynl.py
@@ -972,6 +972,11 @@ class YnlFamily(SpecFamily):
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


