Return-Path: <netdev+bounces-117308-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D5C94D865
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 23:22:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 036D7B212AB
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 21:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA752168488;
	Fri,  9 Aug 2024 21:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="aaMtKxLE"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBCF179A7;
	Fri,  9 Aug 2024 21:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723238532; cv=none; b=S3IDGosUdZ09Vz9sCtGNY0DMK9jrUTr9WMjTthUZf0AjhYPOkq9C4qDHHWP3JBbq88ZWvZyQHPu/RrVQuJ1MuOq/c2UqeineqrOrGBg6MtHHAB2UabTMAl03FemtPHGqMTYw5n5uMKTPVDIN3adGHOtu5WMDT3nKomAn7l0pz84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723238532; c=relaxed/simple;
	bh=1JDweWZInT2dN0AeLCU2AI3GgVOyPycwz9es7dAc5XU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=clN7k9zoDCrimyvcYR2piDyusWM9Jw0mmOAfEK8AE4nYlE2rb0DP6rhTm85dMhLia+PZO5qvxvkIfK54KaXLeGHVrfdHtV/WddBuWObxDepWX5VNLbcI3U+H4BEI8kih+AjYS0OVhQbJKNAyXOd6+Smw+UFc1SbFCYHbLml+0s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=aaMtKxLE; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1723238530; x=1754774530;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1JDweWZInT2dN0AeLCU2AI3GgVOyPycwz9es7dAc5XU=;
  b=aaMtKxLE4I7sJElyA/JkkQBm4xIjbmaTRWJ3+aWtv7wPFO7M2CDMKu8k
   mBkv4pqPIRL957Yp9dCpFaUqSnaCKgGx2accKloapo0MZ2bf0330LicZM
   BqJ2ami3CQeOGIEL0q3NFKKXF8eMiKZ7awdAYe6aHyhxKA2FWbFyX6A2r
   mPglluk3EiRrlQPzxerIUL7zJF+QKS6Bf6PlVd1f3zzPk3tN9vC30RTiX
   P+3P4uC7fZWSO2sitC+u9D4Ue/5JPdUTltpUk7Owl7Po9U2xIbscpcFc2
   xyhNosl0HwXtVO4RJbm5WQI/TEGPpcQ6x9+mWSoL8aIX1vjZF/3X2FSFD
   w==;
X-CSE-ConnectionGUID: fVgutDEfQ6+TQCfyHCdg8Q==
X-CSE-MsgGUID: sRhfVodeTPCMxvPZnEqFrA==
X-IronPort-AV: E=Sophos;i="6.09,277,1716274800"; 
   d="scan'208";a="30985757"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Aug 2024 14:22:03 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 9 Aug 2024 14:21:43 -0700
Received: from pop-os.microchip.com (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Fri, 9 Aug 2024 14:21:42 -0700
From: <Tristram.Ha@microchip.com>
To: Woojung Huh <woojung.huh@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<devicetree@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli
	<f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>, Rob Herring
	<robh@kernel.org>
CC: Oleksij Rempel <o.rempel@pengutronix.de>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Marek Vasut
	<marex@denx.de>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	Tristram Ha <tristram.ha@microchip.com>
Subject: [PATCH net-next v3 1/2] dt-bindings: net: dsa: microchip: Add KSZ8895/KSZ8864 switch support
Date: Fri, 9 Aug 2024 14:21:41 -0700
Message-ID: <20240809212142.3575-2-Tristram.Ha@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240809212142.3575-1-Tristram.Ha@microchip.com>
References: <20240809212142.3575-1-Tristram.Ha@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Tristram Ha <tristram.ha@microchip.com>

KSZ8895/KSZ8864 is a switch family developed before KSZ8795 and after
KSZ8863, so it shares some registers and functions in those switches.
KSZ8895 has 5 ports and so is more similar to KSZ8795.

KSZ8864 is a 4-port version of KSZ8895.  The first port is removed
while port 5 remains as a host port.

Signed-off-by: Tristram Ha <tristram.ha@microchip.com>
---
 Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
index 52acc15ebcbf..d8efb6f0c253 100644
--- a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
@@ -21,6 +21,8 @@ properties:
       - microchip,ksz8765
       - microchip,ksz8794
       - microchip,ksz8795
+      - microchip,ksz8895  # 5-port version of KSZ8895 family switch
+      - microchip,ksz8864  # 4-port version of KSZ8895 family switch
       - microchip,ksz8863
       - microchip,ksz8873
       - microchip,ksz9477
-- 
2.34.1


