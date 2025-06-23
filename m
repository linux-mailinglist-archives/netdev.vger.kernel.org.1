Return-Path: <netdev+bounces-200360-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8638AE4A8C
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 18:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B83D17E20C
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 16:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ECEE2DFA27;
	Mon, 23 Jun 2025 16:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="IBzJLZOg"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AD22DECAF;
	Mon, 23 Jun 2025 16:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750695050; cv=none; b=TJ1OgGZQTB2TRICXQ5HKxkj0YrhkpLYOpcQE9zzx7iBesswsMiK21/2nvMO7PTwwNJLDim7uXa4ZdSRLbblHgcVIB6b6Eg76BqYCdZ/EuYUGS2Xo0Dr5InmuYWayX4BvryE6czX08GthgvJi8LU+DiMa6OPnADfnoDy3migc254=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750695050; c=relaxed/simple;
	bh=aBOjlPRKdMcxD8PHAn4EGg/r0CIp3KRLerTAYfraJHA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P7DpH2b2Dy4d0Yh1+hs1P2/izWJpuZE5N0UTnmVWYYKhCjymMSwSPt/8hPu8EJqt8rfY/l6u5evmbMwrXAfz7rlOvOos9tJXyL0LQ2FtTKt5cB5TwLSKAca4RW47H0fbLDpLjBY5jp20Ojxv9VIbkGVCtmnzBaz2J34HWUPrU08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=IBzJLZOg; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1750695048; x=1782231048;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aBOjlPRKdMcxD8PHAn4EGg/r0CIp3KRLerTAYfraJHA=;
  b=IBzJLZOgoqnCg+3pjEddKwNxnjOQvf70eRF2dH6WU4nr1m9TvKk6BT9l
   y+NZ9huzMh1SG99Ry8ZnWcPExP0+PFV6zxNLMHi1ha+vfKVzSTqZmgzsp
   +t4aL/2n3MEQwxvkOCdOUqGPBYEMjLjhkgi3WLe43Um9FdRKr6NMZ8x+h
   59sqaZk3iMOgT4pWreB0oJik/rQvi2QxqjfxooKP1k2jt9nFdyQX4xaYZ
   XwxkwDKA+pK+4fvsRzbLDY2zV5+HApzVQnunVmpr1zqMk8nvPIZ2gFxi/
   +OI8WGKlfKXrlH6fVE98nY3tbfVwPBQD553eUdjkrYqhNdwOFQfrsYQml
   A==;
X-CSE-ConnectionGUID: 9d4q2IluRVm9uF2HS7TYvg==
X-CSE-MsgGUID: 3LOxFOjHTBGyGOverkiLvA==
X-IronPort-AV: E=Sophos;i="6.16,259,1744095600"; 
   d="scan'208";a="48173830"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Jun 2025 09:10:47 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 23 Jun 2025 09:10:27 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Mon, 23 Jun 2025 09:10:27 -0700
From: <Ryan.Wanner@microchip.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <nicolas.ferre@microchip.com>, <claudiu.beznea@tuxon.dev>,
	<netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Ryan Wanner <Ryan.Wanner@microchip.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [RESEND][PATCH 1/1] dt-bindings: net: cdns,macb: add sama7d65 ethernet interface
Date: Mon, 23 Jun 2025 09:11:08 -0700
Message-ID: <35808b7cee5ba5b2ce55d741ae1ada0f1cd2f7cb.1750694691.git.Ryan.Wanner@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1750694691.git.Ryan.Wanner@microchip.com>
References: <cover.1750694691.git.Ryan.Wanner@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Ryan Wanner <Ryan.Wanner@microchip.com>

Add documentation for sama7d65 ethernet interface.

Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 Documentation/devicetree/bindings/net/cdns,macb.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/cdns,macb.yaml b/Documentation/devicetree/bindings/net/cdns,macb.yaml
index 3c30dd23cd4e..eeb9b6592720 100644
--- a/Documentation/devicetree/bindings/net/cdns,macb.yaml
+++ b/Documentation/devicetree/bindings/net/cdns,macb.yaml
@@ -62,6 +62,7 @@ properties:
       - items:
           - enum:
               - microchip,sam9x7-gem     # Microchip SAM9X7 gigabit ethernet interface
+              - microchip,sama7d65-gem   # Microchip SAMA7D65 gigabit ethernet interface
           - const: microchip,sama7g5-gem # Microchip SAMA7G5 gigabit ethernet interface
 
   reg:
-- 
2.43.0


