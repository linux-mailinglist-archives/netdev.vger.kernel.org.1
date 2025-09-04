Return-Path: <netdev+bounces-220156-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ECDEB44926
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 00:07:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34EE0AA3490
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 22:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F772F0C64;
	Thu,  4 Sep 2025 22:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="Ch1JYDPr"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633E72EAB94;
	Thu,  4 Sep 2025 22:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757023415; cv=none; b=nyDFsw8WdAdTeYsGA5tW/YuDdecfbRuHXOJhPMBN4WSWAi9rjybc0OzSbhJ4sK8m1I1HMAp8UkoFFs0dvaQJWsDB2h02m0baKE1TfNek2G1jDvCwcPQQwoVrcKdQPg7bdWOoG9UvCGU7dA86fTLq9mWWEnGWCQhiDM+dh5G4l7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757023415; c=relaxed/simple;
	bh=o6ldSlIH7/zXAlDQRWE4ITIETHzFOXj7+iucAitTmIU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P+et68e1ImNWkSZXZlEvNbvet03EqIc2E72bHhybcOrrqYeKum4bqaQMJIqYmFGQFlc/mWraBM2Y77Q3wAd/N0EzttjW+eu7SVHovcSQdPoA37vivJiRRFbImkJNsFpHdmXgQ8beNcsjl9h7r4uP3a5KFH7ANoTKR+Z0dOtheWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=Ch1JYDPr; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1757023398;
	bh=o6ldSlIH7/zXAlDQRWE4ITIETHzFOXj7+iucAitTmIU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ch1JYDPrM/bQzg/3xT3mqPg31nnaIncgf/czIIIivDK/pMwll/OxOZapbyfXsYBVk
	 1HUfXC0pGaUPixOmEaPou/Gff9IWv//SngiWFCYVn5b2jOqnJGoJyXGobd6Zq6F/yV
	 +ff0KbWYKA8/UPOdlY0sy0JCxVvsHpPmkT6EjRz47B5EjZIfLRBzXhs0gk5BnLTV84
	 oZKi9eRVEBtJ3/xhVhg9382yigZ1pqvVXsD4cfgQb3GCx5FDYNZ+Ct/YIPD23T8FK5
	 awfj7uOsFpSkNC7GdG/XfvLTsA4pYd3X8uXZO+3hDTJ8Xrjat7qXoAVCUBN3VvLuXZ
	 ZJBP5QgaYOzEw==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id B85616039F;
	Thu,  4 Sep 2025 22:03:18 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id E96A12027C4; Thu, 04 Sep 2025 22:02:09 +0000 (UTC)
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
Subject: [PATCH net-next 11/11] tools: ynl: add ipv4-or-v6 display hint
Date: Thu,  4 Sep 2025 22:01:34 +0000
Message-ID: <20250904220156.1006541-11-ast@fiberby.net>
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

The attribute WGALLOWEDIP_A_IPADDR can contain either an IPv4
or an IPv6 address depending on WGALLOWEDIP_A_FAMILY, however
in practice it is enough to look at the attribute length.

This patch implements an ipv4-or-v6 display hint, that can
deal with this kind of attribute.

It only implements this display hint for genetlink-legacy, it
can be added to other protocol variants if needed, but we don't
want to encourage it's use.

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
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
index 78c0245ca587..6d2f12d43a08 100644
--- a/tools/net/ynl/pyynl/lib/ynl.py
+++ b/tools/net/ynl/pyynl/lib/ynl.py
@@ -958,7 +958,7 @@ class YnlFamily(SpecFamily):
                 formatted = hex(raw)
             else:
                 formatted = bytes.hex(raw, ' ')
-        elif display_hint in [ 'ipv4', 'ipv6' ]:
+        elif display_hint in [ 'ipv4', 'ipv6', 'ipv4-or-v6' ]:
             formatted = format(ipaddress.ip_address(raw))
         elif display_hint == 'uuid':
             formatted = str(uuid.UUID(bytes=raw))
@@ -967,7 +967,7 @@ class YnlFamily(SpecFamily):
         return formatted
 
     def _from_string(self, string, attr_spec):
-        if attr_spec.display_hint in ['ipv4', 'ipv6']:
+        if attr_spec.display_hint in ['ipv4', 'ipv6', 'ipv4-or-v6']:
             ip = ipaddress.ip_address(string)
             if attr_spec['type'] == 'binary':
                 raw = ip.packed
-- 
2.51.0


