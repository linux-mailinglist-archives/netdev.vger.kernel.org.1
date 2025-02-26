Return-Path: <netdev+bounces-169948-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1A69A4699D
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 19:26:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B58CC173999
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 18:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D124235C0F;
	Wed, 26 Feb 2025 18:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="PtnobXW/"
X-Original-To: netdev@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96DB235BE1
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 18:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740594036; cv=none; b=ApF7LKCxhkdyjV7FusznL6hrAXNqY8Mcifj8ciFyMwkYCAQCW6REKeGo9bq6288Ot5zHUmHhz2S5P+7uBS7lw3wITbPZlQ/qEn8oc+g1IaLIM8iDTt5NRi21llQ5zS1rd7ACqYqYu0dYvlwXnYGIfOxkcbyXBmGs+yATyqMqnSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740594036; c=relaxed/simple;
	bh=3J3XJd8PRuO6gmaNC0orT4R44OnxcZeK0a561XdDj8I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CY8TO+clrS6EwHgz19TYNu80nHOBsytsjav9jD18VUBiAtxPrgofGYCtRxOYb/qHTq70Wa5k4pfBmrv6aeIciW8yXXf90ToZ30ZabVlwQ7oYQ5dm8IcRiEBkdhieaa9uimFXjqh0kTmVBEGJ2W/QzNqKJWHXQrOkvGor8BgKzj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=PtnobXW/; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=b13hFSebNGCQkZy2Ggu3MRadml5qSAvcvzKRmbKtOM4=; b=PtnobXW/taBEKjyO9hfYPtMPHB
	6B4uymkkgy/f1ZJwPlw0dX9OEMEjCqfNcM6S3I7NX+bkXEygSFps1PVV8+88hEfGhKg6Kod5jx37T
	PUPKEBi3TOlrj0bfNENB7OxYTojSSDFiHZRqU8cJjX38elwUYGRXFfChFKnqNUG3oXD4BNQXLPnIk
	NbAbLEFQlRxfofKX+xsqAyAFp46l+ZiFaatevgphejAnHEscm074oxqU0S3z+yVk7z1bWHtxB2NGA
	qrsFPA4GVT1YALUhyhiBAIM3q3j9Ms/gsVKvHSuPDTiM2Z7mtmTZh5fOCjttccwfpmlVabnRNfP/+
	Os6az4pA==;
Received: from 226.206.1.85.dynamic.cust.swisscom.net ([85.1.206.226] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1tnM1H-000BLN-1Y;
	Wed, 26 Feb 2025 19:20:31 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
To: kuba@kernel.org
Cc: pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: [PATCH net-next v2 2/2] geneve, specs: Add port range to rt_link specification
Date: Wed, 26 Feb 2025 19:20:30 +0100
Message-ID: <20250226182030.89440-2-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250226182030.89440-1-daniel@iogearbox.net>
References: <20250226182030.89440-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 1.0.7/27561/Wed Feb 26 10:36:26 2025)

Add the port range to rt_link, example:

  # tools/net/ynl/pyynl/cli.py --spec Documentation/netlink/specs/rt_link.yaml \
    --do getlink --json '{"ifname": "geneve1"}' --output-json | jq
  {
    "ifname": "geneve1",
    [...]
    "linkinfo": {
      "kind": "geneve",
      "data": {
        "id": 1000,
        "remote": "147.28.227.100",
        "udp-csum": 0,
        "ttl": 0,
        "tos": 0,
        "label": 0,
        "df": 0,
        "port": 49431,
        "udp-zero-csum6-rx": 1,
        "ttl-inherit": 0,
        "port-range": {
          "low": 4000,
          "high": 5000
        }
      }
    },
    [...]
  }

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 v1->v2:
   - add byte-order

 Documentation/netlink/specs/rt_link.yaml | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/netlink/specs/rt_link.yaml b/Documentation/netlink/specs/rt_link.yaml
index 0d492500c7e5..8b5c0f067328 100644
--- a/Documentation/netlink/specs/rt_link.yaml
+++ b/Documentation/netlink/specs/rt_link.yaml
@@ -770,6 +770,18 @@ definitions:
       -
         name: to
         type: u32
+  -
+    name: ifla-geneve-port-range
+    type: struct
+    members:
+      -
+        name: low
+        type: u16
+        byte-order: big-endian
+      -
+        name: high
+        type: u16
+        byte-order: big-endian
   -
     name: ifla-vf-mac
     type: struct
@@ -1915,6 +1927,10 @@ attribute-sets:
       -
         name: inner-proto-inherit
         type: flag
+      -
+        name: port-range
+        type: binary
+        struct: ifla-geneve-port-range
   -
     name: linkinfo-iptun-attrs
     name-prefix: ifla-iptun-
-- 
2.43.0


