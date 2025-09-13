Return-Path: <netdev+bounces-222816-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81178B563E9
	for <lists+netdev@lfdr.de>; Sun, 14 Sep 2025 02:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A05F22001D
	for <lists+netdev@lfdr.de>; Sun, 14 Sep 2025 00:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546392C11F9;
	Sat, 13 Sep 2025 23:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="is9uAdaN"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043412C11CE;
	Sat, 13 Sep 2025 23:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757807958; cv=none; b=OqQvoQUTjL7ROT19FPMgL5dzRbegGYVs6fAaKME+qG3ivpIivk/q2oLAeiKfji4vvW8mRCp0Wx/y0vkWhWob4wAos7BEXFNgYYQR4rCBFBY2qXZUgnsCVBuiR++bRE+lDC2eyOFb9IZf8IOv94iEqLU536DhPEvjHViEy/v2Fjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757807958; c=relaxed/simple;
	bh=M8RZw0PcAr23td7B4SWZsTm8GfTk/HQcBuK2/+z1TOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dp3bfDVHibrDc+zZonweAvLXAondxUrs8sQpKPsmkfkba2Ba46vOqfg6+8TkXNH8+mDuig2vNZyDwLgt4LtD7WEav3bmUOk7T6pWA69xuvsrkW/24rnPdZ2qtvoFdRdkue7/oRb1OjEEfKYL+P2vk+qP9Tf1Pj4rAQNLaXdm540=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=is9uAdaN; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1757807952;
	bh=M8RZw0PcAr23td7B4SWZsTm8GfTk/HQcBuK2/+z1TOk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=is9uAdaN3UZ0mzHCMX0szSPW7peuoWfu+HJ9BcWLE0npk2Je3H+rNphAB1f7b6n9b
	 U3wa9DTDS+ktV/g9CrKQUXMQhZvIq8pjnqf0pGWsX+lFU2hkA0eBqBOY41ZDeFFa2P
	 ubNrF9EHP8wa8AiyMkaQD0+JxDwxm0+znMtQ0Xa8Y2w5IBCrZRMnewdlGd42x1mKJr
	 eb4je4zeyQ2RecQMSQPZxRoW8h5jlNor+7/HkxsIQAtj0EWJ3KqxS5LVpf58jYjWNB
	 zmwT1iDInze2uP5Z88JsigSQRVuxSuiARFr4eyrQlpXvAp4X6cJg3NEHqB/j8IIAZV
	 XnWFyaDesxDwQ==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id BF3BF6012E;
	Sat, 13 Sep 2025 23:59:12 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id 912D32051E5; Sat, 13 Sep 2025 23:58:57 +0000 (UTC)
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
Subject: [PATCH net-next v4 11/11] tools: ynl: add ipv4-or-v6 display hint
Date: Sat, 13 Sep 2025 23:58:32 +0000
Message-ID: <20250913235847.358851-12-ast@fiberby.net>
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


