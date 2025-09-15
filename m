Return-Path: <netdev+bounces-223104-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A3D0B57F71
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 16:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC4997A2FF6
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 14:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C369341662;
	Mon, 15 Sep 2025 14:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="as0GBHV0"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A9A321F34;
	Mon, 15 Sep 2025 14:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757947673; cv=none; b=haqUyIb6IXrUBx90s1NZFMitdg+Hnnbd3U1fiM5xAaHYbhIBHgeA/c6WauRWxy6dRkX3X3aiFhBeipzKerJkKFkdJXO8+rJzCkWaS39rI1xJnrbQlbSDeHep10NpcN4816xprOSlWql+/g157NW0b7GCQqD+u8hMfY6oHPL8row=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757947673; c=relaxed/simple;
	bh=M8RZw0PcAr23td7B4SWZsTm8GfTk/HQcBuK2/+z1TOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VafUUbQK1YVpee+XtsaTYTsggkJ7TsOLGCbWuNR7+xhCxSJqZJBP1LDw0Nkld9kSQJSkzGw26XR6/BBO5HGs4/I1xd2/6genakR+tSayoLWXLeaHpXpdNU0ZKUsGSAMbwpXJnsLQB6l9LKP6pS5Rg2SKvH6k5ci1w3suM1/TI5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=as0GBHV0; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1757947660;
	bh=M8RZw0PcAr23td7B4SWZsTm8GfTk/HQcBuK2/+z1TOk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=as0GBHV0zPBIF3vPf/Xn8QmEv/ATEJXmEpq/t/DjKQB1j5tfGayg5uClH77bjdVEU
	 SCyE/KncrSDIGYFVYvocihwMR2GOmjT/baz1ppscCC0j3s+zfzOidwDmRp0imzTIA8
	 6f9M8vpaiC7+3gF2JIitPTSHBaT6TtcgjzjBq7om8KLce6RxQkJCvp4PYrfZwwLSnI
	 zcY0FBdEB1i5Wmc1HiDQqXTZucwYr6J0Digh/KrY+y2YVmYHxsYbe+IsoyJrVf6SfR
	 ANBLXkN3BCS9SEpVbLA+geKOXqYFRIUZSc2bBdsbSvbDIQRRd2xM9Kf6noj1OUYh66
	 TJOyDOG/owh4Q==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id E316860128;
	Mon, 15 Sep 2025 14:47:39 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id 75DD42054AD; Mon, 15 Sep 2025 14:43:06 +0000 (UTC)
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
Subject: [PATCH net-next v5 11/11] tools: ynl: add ipv4-or-v6 display hint
Date: Mon, 15 Sep 2025 14:42:56 +0000
Message-ID: <20250915144301.725949-12-ast@fiberby.net>
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
index 707753e371e2..62383c70ebb9 100644
--- a/tools/net/ynl/pyynl/lib/ynl.py
+++ b/tools/net/ynl/pyynl/lib/ynl.py
@@ -956,7 +956,7 @@ class YnlFamily(SpecFamily):
                 formatted = hex(raw)
             else:
                 formatted = bytes.hex(raw, ' ')
-        elif display_hint in [ 'ipv4', 'ipv6' ]:
+        elif display_hint in [ 'ipv4', 'ipv6', 'ipv4-or-v6' ]:
             formatted = format(ipaddress.ip_address(raw))
         elif display_hint == 'uuid':
             formatted = str(uuid.UUID(bytes=raw))
@@ -965,7 +965,7 @@ class YnlFamily(SpecFamily):
         return formatted
 
     def _from_string(self, string, attr_spec):
-        if attr_spec.display_hint in ['ipv4', 'ipv6']:
+        if attr_spec.display_hint in ['ipv4', 'ipv6', 'ipv4-or-v6']:
             ip = ipaddress.ip_address(string)
             if attr_spec['type'] == 'binary':
                 raw = ip.packed
-- 
2.51.0


