Return-Path: <netdev+bounces-189535-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F144AB2904
	for <lists+netdev@lfdr.de>; Sun, 11 May 2025 16:27:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D72E517193B
	for <lists+netdev@lfdr.de>; Sun, 11 May 2025 14:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49EA525A329;
	Sun, 11 May 2025 14:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b="Spx2Zd1N"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B04825A2C8;
	Sun, 11 May 2025 14:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746973634; cv=none; b=ip9F0tg0x0ZwcBOS0yRJ4DNpQtuZB35xtOGDp/wKRqvo/UPI1zSpDR7vhlT8fTPQbTc44qDzd00TMDj5LWnXQugChHpCQyoeGf8xGf48xE53B4CKJ4dDdAnnw8jyFxwZcc5/70crNKaKwApBB8uZu+G87taYxjpj+lZ27MGvWDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746973634; c=relaxed/simple;
	bh=LmmVKnPbU8jgX+9Y+2e2Q6tzWKMA1huWOUYuv7Df+3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qlaRo0NoeFm0Fvo6A8Z2ww525JYnQkUvdUQkdhv1Ga6CMpBTL+EZlmK7H/oSKB/kVbl5YcUqzhevPoRI1ef4jvUMtEiyqqkSGG16tu76+54FdJq3ev2N8tUnZ9/mnoHUrhD1I8r97NlkGU8sU34za3Tb9JlSts69LelwQ7VBV4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de; spf=pass smtp.mailfrom=public-files.de; dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b=Spx2Zd1N; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=public-files.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=public-files.de;
	s=s31663417; t=1746973624; x=1747578424; i=frank-w@public-files.de;
	bh=xQPOiEtR7UNHd2nQC/5bFGE9QHObHe7dXPPAZ9TilpI=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Spx2Zd1N1nbvSaQTOq3706izCQS+9pC8Os7OO25AoIVBFhryAo9OfkNdfaSfzXEl
	 Z7fIpw4B6omoA3nXRh7gZQ6FhfJTUNopgnkez7b9JOL6hpofYw8OB6FCPy1GIIYFP
	 yIlsDa+nq6E0Zgw6nfCRna+QCebU7oxeF52ExlzYmWn1TDdqqDu/oCAK7yGfmj/Jn
	 qQ5qoea3S9hk8mD03OC9KFXTZ+dFKIJyN7ZCzaEIkKL98RoizXRJMYsXs01LvBRhH
	 ps768oVsFVJYbSQz/FLMdmyVVWY7mlA7ZxYzxfN3ZiG9ms4AhcLCGq/DvvSrsSk0q
	 o16k/9eRAQD4fde3Kg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from frank-u24 ([194.15.84.99]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MD9XF-1u5YvB0cIj-00FOt5; Sun, 11
 May 2025 16:27:04 +0200
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
Subject: [PATCH v1 11/14] arm64: dts: mediatek: mt7988a-bpi-r4: configure spi-nodes
Date: Sun, 11 May 2025 16:26:51 +0200
Message-ID: <20250511142655.11007-2-frank-w@public-files.de>
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
X-Provags-ID: V03:K1:tAcmEa8FaAS4uDeXXzw+jL2GXIN2E2kq18ViGasr5wUEniIZWNM
 IO/oT8iB0sS31c4FIi778Dn9zf0Qz06xLjIjhDDIGJ/3KaIzr4CiIr5T2mZKTQAbkm2+TK+
 ERxdS+TxvTCUBLbufNx6GhAPP71NPhNFmZyOQbUNB2ez7mzQfGp6FP+Zxr7N18zXoMowV2U
 D3UHzHHEvRjs8Sk4x1lyQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:sgEX27r696c=;9yZ2XzEX/OBRA7D4NPuXydIC9ju
 uzyub9i9Lh4dwrP4jWNO2un9Il+qmXGAl6PdCVSxe4XgKvOiiuuGfFz4m7uSweK50Nv24z1SQ
 QtyYvmKmU1wrxLRPxo8PajbwMeoYj+fSGD0mnf8NP/I9cWD1tnJMRhBFZzCj+h/EIQNbWzCPd
 qU14TmVMbBqmBM46EcGQ2Q4mRCA702mXo2vw3xvjxW4KzGV6Nc/5qgVBZbmNYaFy3mF8uVfOW
 B4zEedXAQLH3WMPn3j7jofMr2DKH9IlW+xxn/qeFbVYkVRGOBN0vZcmgO0LO9mg6+p5PYb6t8
 sSoggIaK1ss55Lwda0gmcSLJoKQrFKO3rNGRRtz4bZlC0BE+BFQ0aK9M6LAQ6Yoe7VPHp/0G5
 zDF9kI9viVQ60lNbv5GHcfLqlYUvJE/TZeZh0NA+XQL25+Z2JXxX8ao/SlhpFrpo0muChh+hT
 q3wJAf1uFmfL3axTbOfb1M0jbjluzF8+FhmBjStXq8Jzp+gUPnD81wCcT/o8WDlCr1iFCqhmw
 cSF4gh6aN/ksaBgOsaimOZaDn/Nu68jvxqC4REU31fsI5mUzjF9o/0e9NKovCbAwdgaCVkgrD
 Y5EsKD78KOg2vkcwTUcbij4W6HmiaIeJVN9j56LabwEdaKrNSlg3zTiLt/qhDIfAx7W9iHq4l
 9akmydA2KvAg6nDa8E8rs32tBas1r0qNZFBWJACFrzhmxJTp6G4NSAIErziJDECF3lEbHiji8
 OH/eHFMw9QiojH5cMS7cMEqoozovh/Pb21wKQ0MNMmOwT/Xd54kJrULJ8kaERoof5o8UXPmKh
 7hcKfKtip1Cmp2t4l3anm5zEgjFSLMYwytf3axvQHGOzCgA7p9hfGUfzQKOHu60YKzN/1fiaB
 lHKWIHnRM2RuP3E3VJKqk31AnDUVJTZMdyEPYV0jav36tmvUmdYObSwTA1UI7zIcRW42bhPx1
 Jnt/X91ZnBpG2ZO1PfoCKPtHqG5QSY80ajmw/ukX9cnGnorff5x03D2SOrILxrkTnoQi2jq4Y
 W3DterY8P64BKXvLHSQ20LF5nuf6xmHKL5NmNiFPBx9TLBqEAwGuTC+fwmdHWky/Q54twVgsK
 aLIIJ3SAviDXQ29GOcUPQaS6HICKRgrAdn7j41yeN711kJ0McQ88CWkLBikAl4eLSjlLOMCWp
 vNskGo0FHiLVpQfYv/QdSHrglo2WsMPBb3t+fCSeBWQelmJPdqh5IizR4UT067uATc31AoLD9
 O/3CFkX96br3jIw+dvkhqnPlIWreM0mlX47trj2J1JuMUufqqk+DbI0vMKcOhYKJjRxideuGl
 +HyQ2cDpCCgnr+l0cVSf1Dl6y7LuLVJfFriLQ7uoER40zwwCepwg5gp6QfxCVbbAIkZbvyx2O
 AMGC2PgjRnAnBgoH0q2tVjkvRs+O3DPPJri8sD+wnK0FbYQ1Ap2ViFXSUCSmS6ewku9mgET5k
 h7Gy25UQDedBtIEMKbfeJrw2p0L7bWQbQOkZHACWyU18kGQ2dGRLV834vdtt9Jv7zQ8cb/z53
 rrRVfgrhpN32y4KfK7qqFo8cKpRsvPfaURCa1mmvMUO1YuwYP+Tt8Z8QIjyUkcx4WrBczJCr2
 eKCMzSV6R8azITs8cQYJQCwBQ5ZA6d3BpGaNa/ZiGvx7esyWg/3Tgi8zT0Z1mayvPXmrFv86O
 tf6xtW/WE5hab1TdgAp8WSTqK0Q3rMMg6Mi0oYBaxcyK4SWcvKk43y66GlU8qAp8P/J3VZ91u
 o6QBheos31hrkdBNR6NhA+5v6WaNfBWb0TohLqu32pljhtvkFC7Q6GWoKV4V72WT0oaj1sFWJ
 G5f4KsxDWGxCRqO9bhTxtT69r21tcK2srVv/ubRI7wlWct6Uk6Sg4ET5KcRIQ+AipM3GhMAxa
 iPxPdgdSAWohuHQnyfvD2cLoFAXyvRnriwKJGjDnT1EgQrEAwC+tsT248ZbWp0AoVOo69q4q4
 O8wwtLsMAj2YGYgywVsb+cBwbabByNVpa2Gv1Rd7wQmoLD15hXn6XqI/u/lLkLmMdnx4K9Kll
 Ql/gEwtojok9UXTm848wMd3aL/oTaCOi8n10rPSb/0OTCy1IgIc1eXW95XGLojWp1bKOTJ+2v
 WyJJDIpTLw4MZQoa8mRXgx3WDayUnoxnZXHzHR4mD6xWwenPlkfP0lrMJapZcupGSr3ao//8x
 YxF7vorROPbX80XjVxdkrZjAhMXqjt1fodAMOUn5nMe+JxKV7ylTT1JTlR5RIdgPiW9F+h7h0
 s5QdtHxOM0lw6A4Kh6pb+Yth4Fg0+aj5alJBg66o0az1jgv71vZxoZz5XbnkkvJ2e2qz2AsFy
 VhIHf3AiyWD9eVc4g5wE6UV4tiSQJ8R1lfCjRKYQB8e8i2Hp3hZ56MFbRWs/937o2ScgtavD3
 dc7arpYCdm5Ivt2r4cO9awTo+026SAGaPNOgWUITds6WW3qYmbEX+jTSRm294plAIFHm6Qk4l
 TmpIrSUtilk3MCPD1Wj/msqxmXrKyzIGvSYZZ8+KMtjtyQOskXx/j5umvpCo93vA5jhMX2N53
 A1CYr2rkrI5Y9udXGA1/vRAwWIF+shU20xFZHaHAaqGd+WTQVMoQA6+zzVA3qTVYr0bxiYQOq
 O7EYsRnITMCCYz2xuIvrPp/XaM9zUQp7qIDV3Hs+QA6aKC+I3sgAEoLaDliHAlZIxzGdYik15
 E2WrgA7p4JCVaXu+63u7PQ8ZCUZhDZ2neBzwYyXnuLtCNvOqAFpoVJthZ7XUsigBHJQnTNuRp
 F1iUq9G5Y9d8UHktSrrq3na01audT2Y+/8RZLS0vMorBX9ZJz+XYM+xmflFsVNcIswpmaFfDx
 xdIFn/wdi082+bVRniOeRU480kAS5GVoiTnH9/NCo0BcuDWsyciCnInS6A4g4jsZY6bGK4n1M
 +LLT9yYzop1AJpn1RLLwmamlUEKZzLGSdTECSmOpWiaXCV46JNedlovH6MUrmSFr0zzb0ijE+
 i3ZLUOcQ7N+SJ5JEbo2IdCRGHw2oTq0U+Ebi9rnf7gjFsiYpONHotNwRC+SnXrhIjXknsl5lV
 b5YO+X0XVjcqW3A6Y9rBM+nI3obtd86OP+kFgFEKGdescrn/aQfkxeaH7iwZVZEZqXkpMjHAP
 Xj2oxU/GHpMzvdEkHKHeyyh4Ex9LjO/kCd9lVL4GMaO4ARoobTJ2yr5QTKCeTTe5pfwN4XoXW
 Vc9FJclE5ITWbHY5y7rvgTYbc

Configure and enable SPI nodes on Bananapi R4 board.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
=2D--
 .../dts/mediatek/mt7988a-bananapi-bpi-r4.dtsi | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dtsi b/a=
rch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dtsi
index c6f84de82a4d..81ba045e0e0e 100644
=2D-- a/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dtsi
@@ -401,6 +401,38 @@ &serial0 {
 	status =3D "okay";
 };
=20
+&spi0 {
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&spi0_flash_pins>;
+	status =3D "okay";
+
+	spi_nand: flash@0 {
+		compatible =3D "spi-nand";
+		reg =3D <0>;
+		spi-max-frequency =3D <52000000>;
+		spi-tx-bus-width =3D <4>;
+		spi-rx-bus-width =3D <4>;
+	};
+};
+
+&spi1 {
+	status =3D "okay";
+};
+
+&spi_nand {
+	partitions {
+		compatible =3D "fixed-partitions";
+		#address-cells =3D <1>;
+		#size-cells =3D <1>;
+
+		partition@0 {
+			label =3D "bl2";
+			reg =3D <0x0 0x200000>;
+			read-only;
+		};
+	};
+};
+
 &ssusb1 {
 	status =3D "okay";
 };
=2D-=20
2.43.0


