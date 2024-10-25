Return-Path: <netdev+bounces-139154-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6586D9B07EC
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 17:22:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 785421C22D58
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 15:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B2E720F3FD;
	Fri, 25 Oct 2024 15:18:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from weierstrass.telenet-ops.be (weierstrass.telenet-ops.be [195.130.137.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CCD20F3E6
	for <netdev@vger.kernel.org>; Fri, 25 Oct 2024 15:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729869495; cv=none; b=L6HQghKr+t8tvRq03tMLODFhuTaUWWK/qI5xb/8ZonC54Ojp+7FGYmLYJxyQ6cyqYnwLyDYiS4SX1vTdtiwPs6aS/F/ZZgPEeY+GzVHC+IOc3rHAfYtejsJmLkNDDwo3khvDji4v+/2U3egtQtNDkEwptGn9ii1FGrKzKnvHokU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729869495; c=relaxed/simple;
	bh=Zw5LzwuhEUKiQEzoSZYvx6X6L5GiUzKRz/H836fxUqI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hxxlHITZrPjzI67Y0YnJq8ePoZxpTkUkm28DWfylgW8MpPG4aygDfahH016qbP3k7erp9gXi59R1UK5429JfL6ld3OfX3J7yEcTMrypch0SM5khSLbpXl7WkryfQ1LpV+qAQfWnupi8kGYQqxTqUh3uogGGLXUiXDRNgSbCMs9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
	by weierstrass.telenet-ops.be (Postfix) with ESMTPS id 4XZmVb25mRz4xCfP
	for <netdev@vger.kernel.org>; Fri, 25 Oct 2024 17:12:39 +0200 (CEST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:6cce:9fcf:3351:6a67])
	by xavier.telenet-ops.be with cmsmtp
	id UfCS2D00M54cQus01fCStU; Fri, 25 Oct 2024 17:12:31 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1t4Lyz-005Vqz-4L;
	Fri, 25 Oct 2024 17:12:26 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1t4LzG-00DnZc-B6;
	Fri, 25 Oct 2024 17:12:26 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Sergei Shtylyov <sergei.shtylyov@gmail.com>,
	Paul Barker <paul.barker.ct@bp.renesas.com>,
	=?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] dt-bindings: net: renesas,ether: Add iommus property
Date: Fri, 25 Oct 2024 17:12:24 +0200
Message-Id: <2ca890323477a21c22e13f6a1328288f4ee816f9.1729868894.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

make dtbs_check:

    arch/arm64/boot/dts/renesas/r8a77980-condor.dtb: ethernet@e7400000: 'iommus' does not match any of the regexes: '@[0-9a-f]$', 'pinctrl-[0-9]+'
	    from schema $id: http://devicetree.org/schemas/net/renesas,ether.yaml#

Ethernet Controllers on R-Car Gen2/Gen3 SoCs can make use of the IOMMU,
so add the missing iommus property.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/devicetree/bindings/net/renesas,ether.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/renesas,ether.yaml b/Documentation/devicetree/bindings/net/renesas,ether.yaml
index 29355ab98569daf6..d6c5983499b87d64 100644
--- a/Documentation/devicetree/bindings/net/renesas,ether.yaml
+++ b/Documentation/devicetree/bindings/net/renesas,ether.yaml
@@ -59,6 +59,9 @@ properties:
   clocks:
     maxItems: 1
 
+  iommus:
+    maxItems: 1
+
   power-domains:
     maxItems: 1
 
-- 
2.34.1


