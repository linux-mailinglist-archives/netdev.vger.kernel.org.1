Return-Path: <netdev+bounces-222301-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59FF7B53CEC
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 22:08:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D714AA035D9
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 20:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE43280A2F;
	Thu, 11 Sep 2025 20:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="Ckqf8y3/"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75B927602A;
	Thu, 11 Sep 2025 20:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757621137; cv=none; b=ZQRVSOn2tkHB48hm8QQMTmIYr8AeY/7y9GZnURN6tjIzTdz53/LYvV4tPvN555R8FqcxnhHr0ngR3fD2yM23QPWYaky6mruJU8wYVBnLrT4gh+6Eg38CpG3MHUYk2jvgrH0cBdhTP2kyC3RBO5S53+Bh1GDgSfx8+QBLBmykl3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757621137; c=relaxed/simple;
	bh=M8RZw0PcAr23td7B4SWZsTm8GfTk/HQcBuK2/+z1TOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jHTrDvhxQrmnn/ZtoeW91vu2eGQ/t4ouQHF1dBqmw7DRYbj8t+iukIFI0Ykj0kQ5yB2Rw3xYeGDMDtPOLLhht1OIhsKtFPo0N8hSh3tUtYiOm3aL9R+SGqTfVyMklgr/WgEDE7x20AKgolk+QlnVojRjOcWqqKsOs0wpG/dgQac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=Ckqf8y3/; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1757621127;
	bh=M8RZw0PcAr23td7B4SWZsTm8GfTk/HQcBuK2/+z1TOk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ckqf8y3/AzjVvxnZC2k9ly4RI51ZQ712aXjBCfSJ1VWDwgQ6rwgd/eYNnJFOKinFf
	 4kzX0y7z5ebvlRob3JLsiSN4EB9s/YIYoa7rAcH8yZtYxpZ7W2EZbcsyBR7kHR5ar4
	 R01PXD+xvbgd0pAhIIPCSTPk0vZMchw95XuL9HUU9lXYJtSy9aOxrzFIt0i4I5EB6g
	 i+vM068jPRcJbP1Q8XaYbNY43x7LFUxC85WmJixa7oLMvnbvIeYMz8uWZA01Lf5ey3
	 mGMC69ouOTPYidd/N/e2G0KOK0gsjHZ3ZAGo63kyNjaCM0u9m/F6OOaQ0QvKGoyQfP
	 89APPZycwQAFw==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 96AED601B9;
	Thu, 11 Sep 2025 20:05:27 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id 5964120573E; Thu, 11 Sep 2025 20:05:21 +0000 (UTC)
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
Subject: [PATCH net-next v3 13/13] tools: ynl: add ipv4-or-v6 display hint
Date: Thu, 11 Sep 2025 20:05:06 +0000
Message-ID: <20250911200508.79341-14-ast@fiberby.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250911200508.79341-1-ast@fiberby.net>
References: <20250911200508.79341-1-ast@fiberby.net>
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


