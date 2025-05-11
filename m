Return-Path: <netdev+bounces-189542-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FBB3AB291E
	for <lists+netdev@lfdr.de>; Sun, 11 May 2025 16:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB6C316F0FF
	for <lists+netdev@lfdr.de>; Sun, 11 May 2025 14:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC33425A2DC;
	Sun, 11 May 2025 14:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b="ciVXOTG2"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC4325A2C1;
	Sun, 11 May 2025 14:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746973651; cv=none; b=G2aFC4mbEl82ZLS6qOJchkyq9i4OM2qc5KllPzavyoQ6Twi7SoI1fzlJUReZAUTkFDhLFZ1XbUOK+rpjnFOkyeG2pDLTG5RKxuD7My2qogF90FSSBjQ/EC3YmD79SovT4R3eEx9uzWQ3/DLjTe3aomr2lOnGkIZIZFuwswOq11k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746973651; c=relaxed/simple;
	bh=OFyghmmVAiH9GOcjSd0NG57pcKVVBIzeYLh25Wv17wc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TOn9LJSOyujPPsOQftZN35jfEFRiXDYsxy1Tz8IdGEBNKToBIgyDIZuOsx80wcQNCI/EbYOspgnCsRUgA7CwYYUCziy6siHxvdanzcRaiNf9n1HvBoN7jf97pEkkf0Asw1EjQkdUrii+slgxSxUcwZ3BTbmWjAkTjVIXzgfA7OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de; spf=pass smtp.mailfrom=public-files.de; dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b=ciVXOTG2; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=public-files.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=public-files.de;
	s=s31663417; t=1746973625; x=1747578425; i=frank-w@public-files.de;
	bh=4to9ZyqZvU/x51jryccBrFVcUgwrKHXYYudvl9o5pk4=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ciVXOTG2USCBUEfJcv8yecl/U549M4dqIaR1schy1moRGRKtBAgfdVjMw2LLfoe6
	 Wrjmr1xBRjtQpISk0OeUGYyVkPlsVQJe9aa9JmcTOIDFJu81gzNt0q0JnQDktJzv2
	 G5U6VAAepO+gsgLciJ9sphvvaQvaooD7zBPdEO9ZBQ314I2rMjgobMHbkeS4E3XHj
	 b2jvvSk98N5Zl99+iH8vLcW/iz1CSpVPzLlpkw8XKqJV5Dcg8B/2TndtaZ1zgo7VH
	 6xEvLGxfN8RapPBdKUaNVeYxxWr1ZwYsn7COsErNEqmnXrA3ZTSNjGTv1FuYh79Ke
	 uwVKiqM9t/ZMC0Wuwg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from frank-u24 ([194.15.84.99]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MRCKC-1ubHED1Teu-00LIi2; Sun, 11
 May 2025 16:27:05 +0200
From: Frank Wunderlich <frank-w@public-files.de>
To: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Frank Wunderlich <frank-w@public-files.de>,
	=?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
	Landen Chao <Landen.Chao@mediatek.com>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Felix Fietkau <nbd@nbd.name>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v1 13/14] arm64: dts: mediatek: mt7988a-bpi-r4: add sfp cages and link to gmac
Date: Sun, 11 May 2025 16:26:53 +0200
Message-ID: <20250511142655.11007-4-frank-w@public-files.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250511142655.11007-1-frank-w@public-files.de>
References: <20250511142655.11007-1-frank-w@public-files.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0FIMzvmol5OwWW/s+oKnmWqPLKif7eUUetyeAUpe30uMfzz6oHR
 7v9b1MN0QfJ68Bky8dr8Zo0z3bh/eut61pxYQR8POebsFIEDHIwNA7NiCuSxEDLheiIg6P+
 skRbL0JJgvITpETSotrseWvQzZlKMWr5zCmaZr3F54mLpWlaj7NcyKXFUtaNfuZRkllxVpC
 +Ec4iVTevoqx2FEBOY05w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:FqA3IeV3Kqw=;e/tFETDvpxmdofV486gRJEcwxSa
 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
 QE0k=

Add SFP cages to Bananapi-R4 board. The 2.5g phy variant only contains the
wan-SFP, so add this to common dtsi and the lan-sfp only to the dual-SFP
variant.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
=2D--
 .../mediatek/mt7988a-bananapi-bpi-r4-2g5.dts   | 11 +++++++++++
 .../dts/mediatek/mt7988a-bananapi-bpi-r4.dts   | 18 ++++++++++++++++++
 .../dts/mediatek/mt7988a-bananapi-bpi-r4.dtsi  | 18 ++++++++++++++++++
 3 files changed, 47 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4-2g5.dts =
b/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4-2g5.dts
index 53de9c113f60..574ac1b853a6 100644
=2D-- a/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4-2g5.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4-2g5.dts
@@ -9,3 +9,14 @@ / {
 	model =3D "Banana Pi BPI-R4 (1x SFP+, 1x 2.5GbE)";
 	chassis-type =3D "embedded";
 };
+
+&gmac1 {
+	phy-mode =3D "internal";
+	phy-connection-type =3D "internal";
+	phy =3D <&int_2p5g_phy>;
+};
+
+&int_2p5g_phy {
+	pinctrl-names =3D "i2p5gbe-led";
+	pinctrl-0 =3D <&i2p5gbe_led0_pins>;
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dts b/ar=
ch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dts
index 36bd1ef2efab..3136dc4ba4cc 100644
=2D-- a/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dts
@@ -8,6 +8,24 @@ / {
 	compatible =3D "bananapi,bpi-r4", "mediatek,mt7988a";
 	model =3D "Banana Pi BPI-R4 (2x SFP+)";
 	chassis-type =3D "embedded";
+
+	/* SFP2 cage (LAN) */
+	sfp2: sfp2 {
+		compatible =3D "sff,sfp";
+		i2c-bus =3D <&i2c_sfp2>;
+		los-gpios =3D <&pio 2 GPIO_ACTIVE_HIGH>;
+		mod-def0-gpios =3D <&pio 83 GPIO_ACTIVE_LOW>;
+		tx-disable-gpios =3D <&pio 0 GPIO_ACTIVE_HIGH>;
+		tx-fault-gpios =3D <&pio 1 GPIO_ACTIVE_HIGH>;
+		rate-select0-gpios =3D <&pio 3 GPIO_ACTIVE_LOW>;
+		maximum-power-milliwatt =3D <3000>;
+	};
+};
+
+&gmac1 {
+	sfp =3D <&sfp2>;
+	managed =3D "in-band-status";
+	phy-mode =3D "usxgmii";
 };
=20
 &pca9545 {
diff --git a/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dtsi b/a=
rch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dtsi
index afa9e3b2b16a..d40c8dbcd18e 100644
=2D-- a/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dtsi
@@ -38,6 +38,18 @@ reg_3p3v: regulator-3p3v {
 		regulator-boot-on;
 		regulator-always-on;
 	};
+
+	/* SFP1 cage (WAN) */
+	sfp1: sfp1 {
+		compatible =3D "sff,sfp";
+		i2c-bus =3D <&i2c_sfp1>;
+		los-gpios =3D <&pio 54 GPIO_ACTIVE_HIGH>;
+		mod-def0-gpios =3D <&pio 82 GPIO_ACTIVE_LOW>;
+		tx-disable-gpios =3D <&pio 70 GPIO_ACTIVE_HIGH>;
+		tx-fault-gpios =3D <&pio 69 GPIO_ACTIVE_HIGH>;
+		rate-select0-gpios =3D <&pio 21 GPIO_ACTIVE_LOW>;
+		maximum-power-milliwatt =3D <3000>;
+	};
 };
=20
 &cci {
@@ -108,6 +120,12 @@ map-cpu-active-low {
 	};
 };
=20
+&gmac2 {
+	sfp =3D <&sfp1>;
+	managed =3D "in-band-status";
+	phy-mode =3D "usxgmii";
+};
+
 &i2c0 {
 	pinctrl-names =3D "default";
 	pinctrl-0 =3D <&i2c0_pins>;
=2D-=20
2.43.0


