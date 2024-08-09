Return-Path: <netdev+bounces-117310-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D64B94D86A
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 23:22:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D012228394D
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 21:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 972CE16A92F;
	Fri,  9 Aug 2024 21:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="p4GiyJgR"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DF016849C;
	Fri,  9 Aug 2024 21:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723238543; cv=none; b=SekSNsf3K59z2fwOxeiYtMSQ4Pi6n8e9enruGNsLaRzpr2JFnP5BYsV2QqxppxkyuMJQ6tNXwW3L2gyFxAkqSnzKmKlqUE1P5AY6Nw7hlnBrY4+YGZPs5564Cga459DXa0n96ZclDh3NTwGbrpVZ4R8dAovzFx/cr5iAC9pBFAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723238543; c=relaxed/simple;
	bh=eooEmzaOdzdOErWsWRhRnE9i8LNRWrUtqqpU7D1PZc8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nULFVsoE6+yoroL95KBQ21oDkonf/oLk9AnLyPF++DW56PUExZEZd2aO7zTTb+CIVi6yWpYAZ6WH8uEJjUXhDVbKSbCW2RwmvuzlNFyeaosYK024EQjXVqg7KQXV7jBtC47BbMFCw3Js2m7mC/PqiqQsS4SPjnKfSeuW/PJ7i6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=p4GiyJgR; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1723238542; x=1754774542;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=eooEmzaOdzdOErWsWRhRnE9i8LNRWrUtqqpU7D1PZc8=;
  b=p4GiyJgRx9pUD0/Y9+N0BrxZFBw279skB/XaTat70BxoSiRTbloHsEeh
   niSApaEHAA/qEgLdWFbSs/hKU9rCOVwaqTbcdeMVPkc3Y/sZiNuW022aS
   YTisTgeXI0rwR7/ckFWpNfsQTTP/lmNshiF/cb6nwN7rnAHz93oDGVpHA
   eq+/ChtYGuNjL+2BJiJHPizrJ06L2Fm8xqtj7CgEBtzHGsn8gd9KuiDyO
   g8NK5AnC7xav/n54WaW+O9QcUC6DlKPR0NlCTAuvQcHR6ob06nyvchRbd
   Ii2dfA3/v8W2ewL81ptXpiXGyIFRDhlE1rXRvDH934ebbcLCuM+KXElrF
   w==;
X-CSE-ConnectionGUID: SZeDCiigQtOuVYjSeAD19w==
X-CSE-MsgGUID: VOZBNf2dQdOQLe/ZzanNBA==
X-IronPort-AV: E=Sophos;i="6.09,277,1716274800"; 
   d="scan'208";a="261235334"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Aug 2024 14:22:15 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 9 Aug 2024 14:21:42 -0700
Received: from pop-os.microchip.com (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Fri, 9 Aug 2024 14:21:41 -0700
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
Subject: [PATCH net-next v3 0/2] net: dsa: microchip: Add KSZ8895/KSZ8864 switch support
Date: Fri, 9 Aug 2024 14:21:40 -0700
Message-ID: <20240809212142.3575-1-Tristram.Ha@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Tristram Ha <tristram.ha@microchip.com>

This series of patches is to add KSZ8895/KSZ8864 switch support to the
KSZ DSA driver.

v3
- Correct microchip,ksz.yaml to pass yamllint check

v2
- Add maintainers for devicetree

Tristram Ha (2):
  dt-bindings: net: dsa: microchip: Add KSZ8895/KSZ8864 switch support
  net: dsa: microchip: Add KSZ8895/KSZ8864 switch support

 .../bindings/net/dsa/microchip,ksz.yaml       |   2 +
 drivers/net/dsa/microchip/ksz8795.c           |  16 ++-
 drivers/net/dsa/microchip/ksz_common.c        | 130 +++++++++++++++++-
 drivers/net/dsa/microchip/ksz_common.h        |  20 ++-
 drivers/net/dsa/microchip/ksz_spi.c           |  15 +-
 include/linux/platform_data/microchip-ksz.h   |   2 +
 6 files changed, 172 insertions(+), 13 deletions(-)

-- 
2.34.1


