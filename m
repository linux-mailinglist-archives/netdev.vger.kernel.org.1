Return-Path: <netdev+bounces-189541-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F6AAB2919
	for <lists+netdev@lfdr.de>; Sun, 11 May 2025 16:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 081453B84D6
	for <lists+netdev@lfdr.de>; Sun, 11 May 2025 14:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAD5825A2D0;
	Sun, 11 May 2025 14:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b="KBO4DcHw"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79AC725A2BC;
	Sun, 11 May 2025 14:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746973651; cv=none; b=GZ7+WpIT91XwdoN45N3ET6tdLWo604gY95QeAZI4u5QMJuyfKOcdm+3G9eKuKBKC0tFLlzHLWpIvrH8bpUMpcgwQv4VvmuDF2FkrgkaC8G7tXWzO3sftrf6og478bdjR7oPW689KCIadB9mfgPg3XKfP4djmpCCQIqnolPU0rHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746973651; c=relaxed/simple;
	bh=82yBP8PCnuqdxwRMZhbJ6tUYl+6I94IhyIK99N1dyR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uVRazhopxCPjpQmFK+UBKWC/hAb1fmgza/hifyBKoTO+01hxY0im2BSyJ3sHh0qgLIAbNS/vwcMPUAj4K+bXNpiEuJoVyXtRSHwt5k4AM285QO93mpUsq9FbDV6skGglQlk5eA+UCoNspxlzYS7kHjy0u4H4NReyCeyIb5jwFBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de; spf=pass smtp.mailfrom=public-files.de; dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b=KBO4DcHw; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=public-files.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=public-files.de;
	s=s31663417; t=1746973626; x=1747578426; i=frank-w@public-files.de;
	bh=RocC8rGT7EyG6giOZHaltcZyAtXeChy4q0QRRBBF5KU=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=KBO4DcHwPAKUnv2geUiD8jsys9UKvAsZd6CAdSEULMemA7gbp+kkXDDiCwcksS7h
	 XnYLS0tD6deXwbG/oGgWt96Xw61VBeDTfcq0RE4hoyP99iOit1n7gLKGRySQiRr8D
	 3OYe7c/OznmGxupDmEBLTdZtnv1ybkDv3yOE+W6pUA/NtxjiPxoAccdSHgq37sZSX
	 zB8Nd9RfFNiU++2PeQcwZw+WZciow9lv88xlJc8oK8brJxpccP+qSQ5AqnYiSUR/s
	 efXhPPtd96QVJl1lhB/R62TBI4nuv2TdL0VuoVppAVv/yHFaiDsPy2taHI7MYQuAj
	 VeJo2tunV6i2de4YZw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from frank-u24 ([194.15.84.99]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M7JzQ-1uLok140Ts-001RRK; Sun, 11
 May 2025 16:27:06 +0200
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
Subject: [PATCH v1 14/14] arm64: dts: mediatek: mt7988a-bpi-r4: configure switch phys and leds
Date: Sun, 11 May 2025 16:26:54 +0200
Message-ID: <20250511142655.11007-5-frank-w@public-files.de>
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
X-Provags-ID: V03:K1:z/Xxuc+GCe4mTpAJHIfgYl+TeTpVWKg2XFz+R/eThbF5luTDdBM
 ApyXNQbv15OhkowltyGIEziaMKUer3KBP6IDRBtvBqLlJI4MJcgUTVFpohMMHylL5GdkTsL
 ZBkZeytrTqNpKLNaILFReziaSHBlYhrdkeueV6CFoK062CtKPb9b0LHbrPCMQGXGNLT0r4f
 VChxTdK8Z3ZFlcTjN5dcA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:1ObFaSmp1eQ=;ECStePRFumKIJPLYWnwsWuHXPlq
 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
 eXJQIk8eSXfVTWmpZiS8MPkV3

Assign pinctrl to switch phys and leds.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
=2D--
 .../dts/mediatek/mt7988a-bananapi-bpi-r4.dtsi | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dtsi b/a=
rch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dtsi
index d40c8dbcd18e..c67b1211af18 100644
=2D-- a/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dtsi
@@ -126,6 +126,46 @@ &gmac2 {
 	phy-mode =3D "usxgmii";
 };
=20
+&gsw_phy0 {
+	pinctrl-names =3D "gbe-led";
+	pinctrl-0 =3D <&gbe0_led0_pins>;
+};
+
+&gsw_phy0_led0 {
+	status =3D "okay";
+	color =3D <LED_COLOR_ID_GREEN>;
+};
+
+&gsw_phy1 {
+	pinctrl-names =3D "gbe-led";
+	pinctrl-0 =3D <&gbe1_led0_pins>;
+};
+
+&gsw_phy1_led0 {
+	status =3D "okay";
+	color =3D <LED_COLOR_ID_GREEN>;
+};
+
+&gsw_phy2 {
+	pinctrl-names =3D "gbe-led";
+	pinctrl-0 =3D <&gbe2_led0_pins>;
+};
+
+&gsw_phy2_led0 {
+	status =3D "okay";
+	color =3D <LED_COLOR_ID_GREEN>;
+};
+
+&gsw_phy3 {
+	pinctrl-names =3D "gbe-led";
+	pinctrl-0 =3D <&gbe3_led0_pins>;
+};
+
+&gsw_phy3_led0 {
+	status =3D "okay";
+	color =3D <LED_COLOR_ID_GREEN>;
+};
+
 &i2c0 {
 	pinctrl-names =3D "default";
 	pinctrl-0 =3D <&i2c0_pins>;
=2D-=20
2.43.0


