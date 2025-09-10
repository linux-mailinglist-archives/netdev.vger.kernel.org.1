Return-Path: <netdev+bounces-221887-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF7CDB52477
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 01:09:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA5801C82813
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 23:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9156631327D;
	Wed, 10 Sep 2025 23:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="uidoNNm4"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BC730FF3F;
	Wed, 10 Sep 2025 23:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757545742; cv=none; b=ZPlihRRhY/v/DUrnBrv6SGbZ73UqvnSfm/dYVnEzul9intfIz8CzPYwzU8+tA8DUKiAm8aKKSGXfNHwoUpEdA0FyrCPSRMPrIraUQ8p8ToWCt77tJVK2LlNMAqjyc23lhfK/whBGYJaBY5LeJ0gCx1KtA45eSp+ka/oGDR/BONg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757545742; c=relaxed/simple;
	bh=mHCxHMaMTlUNc8yNdBlBwvuCNIWstdK/GS0nKVCzvbM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tIBsgJ/YXd3XTi8JXOrf68ogLjIrWrOsYV+PdJ6VdUtySqypfQ6T1s6ZNfv6+hR4N2bDNvkbNu/Ug+mOW9qsNj/l1tcWeI03ZYE+isJwK5acuIE9DhXskbzF8+kYSlBZp3FnbGjRgsaCHY+VdxdoX7a+IM1Oqqe6ME1gVu82iNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=uidoNNm4; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1757545730;
	bh=mHCxHMaMTlUNc8yNdBlBwvuCNIWstdK/GS0nKVCzvbM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uidoNNm48j4rEEdkjJMfaKXIcU2W5eWc8JlPd1inHIZAEeBg9e33lXkR0p8KsI9gw
	 YpIvfri0nB/UXDskxgy897Ao39UtgpKXvb2LuU6ruAtmyfEZpcejVXVQ3l9jryoSxl
	 jWbV5FjHCzAXPL/ngfcdtlACoar+nChkt6kYYgVktCTbomNRdt1RyXcpZGrjTsv9RC
	 HTmqp+H58yJO+PClPNBPvX+9FoqEJQg2hjn/1XDk8rj9twWhgmXPdoOm4WCaa7QiAA
	 w4KNhZUPOxNMpjkRie75wkok/k/3wwt5XS4dqyLD+U7CfQzXq8nPazfKQcPjAVBA4n
	 sz9VMGz9tTpQw==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 7E7746012E;
	Wed, 10 Sep 2025 23:08:50 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id 44AB02051E5; Wed, 10 Sep 2025 23:08:43 +0000 (UTC)
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
Subject: [PATCH net-next v2 12/12] tools: ynl: add ipv4-or-v6 display hint
Date: Wed, 10 Sep 2025 23:08:34 +0000
Message-ID: <20250910230841.384545-13-ast@fiberby.net>
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

The attribute WGALLOWEDIP_A_IPADDR can contain either an IPv4
or an IPv6 address depending on WGALLOWEDIP_A_FAMILY, however
in practice it is enough to look at the attribute length.

This patch implements an ipv4-or-v6 display hint, that can
deal with this kind of attribute.

It only implements this display hint for genetlink-legacy, it
can be added to other protocol variants if needed, but we don't
want to encourage it's use.

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
Reviewed-by: Donald Hunter <donald.hunter@gmail.com>
---
 Documentation/netlink/genetlink-legacy.yaml | 2 +-
 tools/net/ynl/pyynl/lib/ynl.py              | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/netlink/genetlink-legacy.yaml b/Documentation/netlink/genetlink-legacy.yaml
index b29d62eefa16..66fb8653a344 100644
--- a/Documentation/netlink/genetlink-legacy.yaml
+++ b/Documentation/netlink/genetlink-legacy.yaml
@@ -154,7 +154,7 @@ properties:
                   Optional format indicator that is intended only for choosing
                   the right formatting mechanism when displaying values of this
                   type.
-                enum: [ hex, mac, fddi, ipv4, ipv6, uuid ]
+                enum: [ hex, mac, fddi, ipv4, ipv6, ipv4-or-v6, uuid ]
               struct:
                 description: Name of the nested struct type.
                 type: string
diff --git a/tools/net/ynl/pyynl/lib/ynl.py b/tools/net/ynl/pyynl/lib/ynl.py
index 50f4889e721b..4f2c8126d6e9 100644
--- a/tools/net/ynl/pyynl/lib/ynl.py
+++ b/tools/net/ynl/pyynl/lib/ynl.py
@@ -957,7 +957,7 @@ class YnlFamily(SpecFamily):
                 formatted = hex(raw)
             else:
                 formatted = bytes.hex(raw, ' ')
-        elif display_hint in [ 'ipv4', 'ipv6' ]:
+        elif display_hint in [ 'ipv4', 'ipv6', 'ipv4-or-v6' ]:
             formatted = format(ipaddress.ip_address(raw))
         elif display_hint == 'uuid':
             formatted = str(uuid.UUID(bytes=raw))
@@ -966,7 +966,7 @@ class YnlFamily(SpecFamily):
         return formatted
 
     def _from_string(self, string, attr_spec):
-        if attr_spec.display_hint in ['ipv4', 'ipv6']:
+        if attr_spec.display_hint in ['ipv4', 'ipv6', 'ipv4-or-v6']:
             ip = ipaddress.ip_address(string)
             if attr_spec['type'] == 'binary':
                 raw = ip.packed
-- 
2.51.0


