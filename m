Return-Path: <netdev+bounces-197996-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B7BADAC94
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 11:58:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 217F13B0E17
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 09:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66ED22749DC;
	Mon, 16 Jun 2025 09:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="RwJKJIiQ"
X-Original-To: netdev@vger.kernel.org
Received: from mxout1.routing.net (mxout1.routing.net [134.0.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E034274652;
	Mon, 16 Jun 2025 09:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750067925; cv=none; b=b+QQzB8DPG8vOr+pcDul/Audsh0OPYzO2ds8NpPSmK2lfWgNE6IaXwwEwz46W6VJMmGA++RHoRjlX/U4HySazRnqGZusEyvfAxpUUtdetkYF3bcccSEzkMcykKEveUxusHhAChy+FcH5sgcnDvelM6b46HUjNFp173RO6T0UzD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750067925; c=relaxed/simple;
	bh=tlgL48I7/TYG/q/B1zUn6HDvHEKOHNp6X1V2o3Sv0A0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P1xq7WxyoVdXrKbzEdDxnC2t1NpUi5fOTiRTHqUQZuo0P3DXSgfm0s8zEk9xJvZ/rcVtqyL+YeitoX7plwqwCDXhYFFRPEgmJGiE5B7IuJJdnVKDnA3aJFT9pKWhnUyFWj+7Gn5JH2WEISDHVcKgwZGfI+PtNAOAS5sSnP8BttY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=RwJKJIiQ; arc=none smtp.client-ip=134.0.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbulk.masterlogin.de (unknown [192.168.10.85])
	by mxout1.routing.net (Postfix) with ESMTP id D0B2541ACB;
	Mon, 16 Jun 2025 09:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1750067920;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=sKNrJpeGsrwkC38zDGJR08n+rDpEEs6AmLxRCw9vAYY=;
	b=RwJKJIiQT88D3B/81u8TiLk/VLaBLC9uget+oeOk3fp/eAbo0Jvx79aZQKTtO/iENwYho2
	D9KeDEET8ZamhXxKXMiOQZlHJh8qk8JXKLrsEn5E1dqNXiEmFfCuOtwGpa/ENF3AguuXlf
	YNKzpfgOmnv9A0RZfREeRAfrHEbE224=
Received: from frank-u24.. (fttx-pool-194.15.87.210.bambit.de [194.15.87.210])
	by mxbulk.masterlogin.de (Postfix) with ESMTPSA id 6D17A122677;
	Mon, 16 Jun 2025 09:58:39 +0000 (UTC)
From: Frank Wunderlich <linux@fw-web.de>
To: MyungJoo Ham <myungjoo.ham@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Georgi Djakov <djakov@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Frank Wunderlich <frank-w@public-files.de>,
	Jia-Wei Chang <jia-wei.chang@mediatek.com>,
	Johnson Wang <johnson.wang@mediatek.com>,
	=?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
	Landen Chao <Landen.Chao@mediatek.com>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Felix Fietkau <nbd@nbd.name>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v4 00/13] further mt7988 devicetree work
Date: Mon, 16 Jun 2025 11:58:10 +0200
Message-ID: <20250616095828.160900-1-linux@fw-web.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Frank Wunderlich <frank-w@public-files.de>

This series continues mt7988 devicetree work

- Extend cpu frequency scaling with CCI
- GPIO leds
- Basic network-support (ethernet controller + builtin switch + SFP Cages)

depencies (i hope this list is complete and latest patches/series linked):

support interrupt-names because reserved IRQs are now dropped, so index based access is now wrong
https://patchwork.kernel.org/project/netdevbpf/patch/20250616080738.117993-2-linux@fw-web.de/

for SFP-Function (macs currently disabled):

PCS clearance which is a 1.5 year discussion currently ongoing

e.g. something like this (one of):
* https://patchwork.kernel.org/project/netdevbpf/patch/20250610233134.3588011-4-sean.anderson@linux.dev/ (v6)
* https://patchwork.kernel.org/project/netdevbpf/patch/20250511201250.3789083-4-ansuelsmth@gmail.com/ (v4)
* https://patchwork.kernel.org/project/netdevbpf/patch/ba4e359584a6b3bc4b3470822c42186d5b0856f9.1721910728.git.daniel@makrotopia.org/

full usxgmii driver:
https://patchwork.kernel.org/project/netdevbpf/patch/07845ec900ba41ff992875dce12c622277592c32.1702352117.git.daniel@makrotopia.org/

first PCS-discussion is here:
https://patchwork.kernel.org/project/netdevbpf/patch/8aa905080bdb6760875d62cb3b2b41258837f80e.1702352117.git.daniel@makrotopia.org/

and then dts nodes for sgmiisys+usxgmii+2g5 firmware

when above depencies are solved the mac1/2 can be enabled and 2.5G phy/SFP slots will work.

changes:
v4:
  net-binding:
    - allow interrupt names and increase max interrupts to 6 because of RSS/LRO interrupts
      (dropped Robs RB due to this change)

  dts-patches:
  - add interrupts for RSS/LRO and interrupt-names for ethernet node
  - eth-reg and clock whitespace-fix
  - comment for fixed-link on gmac0
  - drop phy-mode properties as suggested by andrew
  - drop phy-connection-type on 2g5 board
  - reorder some properties
  - update 2g5 phy node
    - unit-name dec instead of hex to match reg property
    - move compatible before reg
    - drop phy-mode

v3:
  - dropped patches already applied (SPI+thermal)
  - added soc specific cci compatible (new binding patch + changed dts)
  - enable 2g5 phy because driver is now merged
  - add patch for cleaning up unnecessary pins
  - add patch for gpio-leds
  - add patch for adding ethernet aliases

v2:
  - change reg to list of items in eth binding
  - changed mt7530 binding:
    - unevaluatedProperties=false
    - mediatek,pio subproperty
    - from patternProperty to property
  - board specific properties like led function and labels moved to bpi-r4 dtsi


Frank Wunderlich (13):
  dt-bindings: net: mediatek,net: update for mt7988
  dt-bindings: net: dsa: mediatek,mt7530: add dsa-port definition for
    mt7988
  dt-bindings: net: dsa: mediatek,mt7530: add internal mdio bus
  dt-bindings: interconnect: add mt7988-cci compatible
  arm64: dts: mediatek: mt7988: add cci node
  arm64: dts: mediatek: mt7988: add basic ethernet-nodes
  arm64: dts: mediatek: mt7988: add switch node
  arm64: dts: mediatek: mt7988a-bpi-r4: add proc-supply for cci
  arm64: dts: mediatek: mt7988a-bpi-r4: drop unused pins
  arm64: dts: mediatek: mt7988a-bpi-r4: add gpio leds
  arm64: dts: mediatek: mt7988a-bpi-r4: add aliases for ethernet
  arm64: dts: mediatek: mt7988a-bpi-r4: add sfp cages and link to gmac
  arm64: dts: mediatek: mt7988a-bpi-r4: configure switch phys and leds

 .../bindings/interconnect/mediatek,cci.yaml   |  11 +-
 .../bindings/net/dsa/mediatek,mt7530.yaml     |  24 +-
 .../devicetree/bindings/net/mediatek,net.yaml |  28 +-
 .../mediatek/mt7988a-bananapi-bpi-r4-2g5.dts  |  11 +
 .../dts/mediatek/mt7988a-bananapi-bpi-r4.dts  |  19 ++
 .../dts/mediatek/mt7988a-bananapi-bpi-r4.dtsi | 198 ++++++-----
 arch/arm64/boot/dts/mediatek/mt7988a.dtsi     | 307 +++++++++++++++++-
 7 files changed, 498 insertions(+), 100 deletions(-)

-- 
2.43.0


