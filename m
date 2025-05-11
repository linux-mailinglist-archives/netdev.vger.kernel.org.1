Return-Path: <netdev+bounces-189540-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3401BAB2914
	for <lists+netdev@lfdr.de>; Sun, 11 May 2025 16:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F12F43B7F2C
	for <lists+netdev@lfdr.de>; Sun, 11 May 2025 14:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AFCD25A2AB;
	Sun, 11 May 2025 14:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b="ETMgC4t3"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B8725A624;
	Sun, 11 May 2025 14:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746973638; cv=none; b=Y2jdiiUPrPGYosOAzrT7xDJCe/bg3Xd1o5/ardEuntwEIwke/MJCpSCxPEKZsM8RiYuzHPrS+hRRuod/TKuYRgsGnEvFMORvoEdW385yfXc/TsIKDvjFzb57YaswpAc2cMQexWJncbbNHDO68yYk2lrfWv9sX/STtM8+dv7wGT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746973638; c=relaxed/simple;
	bh=d93z9+ehYtoAigHYNKFQesxsq3DBD3XbEKwtrYnVYBE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lGbF6fBqda5U644kCSPFtQ/IQtPqPQPMTtOapQBOK0WhXJITemlBdrX0XlHFQNy4wl/0N0J0Xc3o/Dp+S/DowBU4lmJyGimtgjCM4WJB8B5RdaUOejyEChhEge280Y0F1UggKtXw1KN218buOKmpusrx/gdvjOf7u8jueSt2ESU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de; spf=pass smtp.mailfrom=public-files.de; dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b=ETMgC4t3; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=public-files.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=public-files.de;
	s=s31663417; t=1746973625; x=1747578425; i=frank-w@public-files.de;
	bh=ZzNDznxpyqlReNyoWtKo+MRxI8KqkWOoBYb9IsBg9Pk=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ETMgC4t3pbYkXUZThHXwp/YZhR0oUMB/tgFU220wpjmNz8ycc9bnH0tg+HU/I48t
	 kxmy2XRcTDHwoDYCPJYeHhLLicU/7ZLQjdfKht35k6kzaHq52mDduWUvX/FEpbZtk
	 90XFqAK6CEjGB4MEO3Xe8i5+E3o11rbmmoy3AQtiz8+11YRADvwKGwu9mcyoM/+Xv
	 9CHJmu0WdBf3Zc4NX54BG+2ZfdUkEBhdV6yNXG6X6exU2sPk5hT/8/V/w/uKgL4OI
	 lDxMZ/f1Ol5iQ+NPpO3OqWa2JoTO8s8PtnfcZleD5EZcXoHuA78Gx8hcEzRL9Gnn0
	 XytW3pgLSB6apcMOSA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from frank-u24 ([194.15.84.99]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MNsw4-1ucNge3AYC-00I0O6; Sun, 11
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
Subject: [PATCH v1 12/14] arm64: dts: mediatek: mt7988a-bpi-r4: add proc-supply for cci
Date: Sun, 11 May 2025 16:26:52 +0200
Message-ID: <20250511142655.11007-3-frank-w@public-files.de>
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
X-Provags-ID: V03:K1:Qae9R1ROAS7GGhKcoocDvvfSN1lTbwmOckLSmBT/RcUE+p369Rc
 V5vHaYCbVIVSdn/CBRPbUI168BCkmjiXQ443AqxYedYM2ygTw8zXjVK8wopC8tKzhAOV6g3
 iq8PHXl3YJKuQpFKGXO2gfgkeu4VxeGGeefAJHmX/lSNyGCLLm9ZrJx4qMvQdM1+yRhMig4
 K0NBiuf8j+lPrfBpHNEZg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:jTOjf/Ji844=;E3z+Qeg+R/XZp97Xq0gAqHj1gPn
 vN5wLL1hphsmKSPu77Pu2Cxt2BSxKFBLpYzD+3vNLvxU4hHykOf7/c5dat0dKP7CE8J4jmf6T
 hOD7dr/+Q7M2hbrW7cf88VXX4rzIoSo+YgSmQytZ9vOcimsabGYEpI1DCrGFIrBAnA+rROlV9
 v+KcnuPO7JtCQXTa5EnhCbwupe7l39uSQogfH22CNlprV0OEo6JjNpxyujceuyUF3xqkPTFoU
 MyGbmI4mUGbV5gcwS3S6eiTYIii4pjPzooxWfODZdHODmGXNS/L44VOqWx0EraagQXOZ6n/Cs
 ceu8gUD9RMC5GHs1mqTC1GES3HHv+QLAGA/z5ZynUmiWQVb2CCMw8K4LzlrVP4lTWUwiB8lvx
 QIddg1pgxApwkB90KrQxKeqlhMv8gq5unqRVigYU0iHkbu7uVm64W/4LqEJnXjf7ulEkE8E6g
 e5jJnDaRfhYQP8DF/88iPPh5UQM/ZvjA3jQFtcH/+pi1Nvc2Exa6LX4AD62CjH1Mm5N5RsSDH
 T/hlGf8TTwWHRC8ubAvpnw/hbODk3jn0zVqnaROnPZ3u36E3MlO5vM3QXZfPRyjTJxx/6iBlV
 +fkBM6mjw+c2Jcw4Owu0EUK/1s3o6ZMVRcGCZyNFfIqXIBcvARxiWKzb8Af/D2LpYnowQGwkC
 l+bnVT9jVti6AzXA3xqp3uTH+oy7dSo7NMCl+8TinKFZkKlFfO1x13TMLOX4yM+Ll2s7b/2My
 Xwf6XugXdDnU6VDOS7MIsUeTnna8q5d7HAR7eRPkd/xRRlKvNHL8EpASGuvnNFq1/hwEJisTI
 aQVPa0rPmFT4RIp+QQ28cAiGPTXwZRRMmkrJmsE3WlkGPXyfUKj45Q8lmtofv1YZK4wJfq1Os
 YOHuhDdQAod5u/q2hAvcBwgqzEcGedhOB/1L4dex1FgHj5XxJKd9FleJpiIceROLXHdYiY9eU
 sI3uBAdn1I8PiD+xILev6JbmGOTHHplmDWGSq/3rLS5Z8aUmY9oXb8+fpoU9B8p5ZYw17OC2E
 3VRNNoyWsE0dptv0apA60bAHcoL47U5vkxUq9i1WiMVBCd5I4dndB9015dSx8W8HeAqZ2WGbR
 sE1HhUr8vaXgD8T++FdZyg/imXDKkVuJXApFO4E1xAbIy5FcuRKRdhZ8CfyfbCZETJGOTEb+m
 748tM6XJPlLxoloJRg4p/HMRKt4+4843AfAdHJ7DhTNWlOmJq3NHt1G0cjjPJAcDxDEd3YToA
 OjIAU65QCF0/d7VS+8jZFnQ0N0cxE3x4Liz2qApPhLcmuKqU8MPXihiqytP3Q7DS9h+xjTivY
 q2/2qcmKL5v/DVkvzOC7Ye32DKh5o6MQovboYb+tFt9wRAtNHUBtk+ZNHfVLr1wYnAvjCMyuF
 +Ino712uTHN78O3r19iGrHSggA8PfBQYudXVmv+yf3GEN22m7k9yI4irJpRRwscygTtJm58nV
 pRDFfeBjvMiM2Ru8vVRTjl20l2lh3I0KVMbDKsiOCtT7s30kD7dDiE+pXuZo3ntyHE7RLi42q
 KyBnQwvJ+tKxW0PRwXZxddNG6ehIEjfxe1TSuHorPosPmpeYhfkFotVdN8QKwumEBbXYYp+QE
 EbYYS+7sqL73+8PrP1gk2ouq1XMsO5q2DOdXoPgH1uxAokC13rJCzd4YQRahPOzaaEKmu4rih
 tZXth7lXOYjnve6qbvCNLbNggcgIcdRku+wwCoe2bVDlVPuQJzIiS/XxtJowcdUWv0Eh54ih4
 vLfNhuwP0a/lCNyMl1dnJHEncc4sxCrbYuQmlt15uPiDOPlbUDJE/HiVtZS8kFp2ZEeci4Vcz
 iR9JX1VojjfPWiKR+S0desP/GrhPUFZXzfRzVcO8feXezPLi1zRa3ZYOXkis7TPGTqzC6ki8l
 HE/eU7pUaLIemwmBqZ80NnLgaLJuVNmSxiRTpk3X3TXBeDO0Aey8JgBaFiDd/9ixwK3TKzfnx
 Kf/v3+0ceog9gS2A+b1OfNS1Chr+gXg3T8xTY3juHm7dr9vVq5Jvf6PXOOTHOaRnF8KkM+AAN
 0otFBZO1BsUuY3NDxshMHFbVfi7pE93NtZ92+NNC00W8xEBVzsRbYALlOa3LF3X3eef6Weuqp
 leh8WwjfQ0RBtDS/dHr6XyR+s/tmOQv+9ewnUWgIAO+sr9o37wiNzm9CrK9CDUBbsCbMKtf/N
 8H/izsgMt7Qo7EXOGrjmGj9b7cV9iZedWJ2kovQ3QRZUai3okbCThGGj9WpqUk8/+MGWsbl3V
 3C47XEx+Z2m/1aw1TWQr7R3DEVeiAFa6RB9euDpV8QM8o/3Gv6XHjk/Pom7941M5X9RIsPxEz
 VKUgfmYfz97GDG+KTWi8Jzju84vjQSmLm+lIC7cdcFfGV85NRpz5EXMma5NDaGeXIWs69F/Gg
 dGhALDhvi7m6vi2faUzRj02+rgEH7Nf/AhWK1sOIgvPeZvxPCqOxaEqo8TIcsBQtxVR+uAotK
 LTZ66uxJrZPGzd9W4qO9912I6aQZOWTTHDFKYB1nu+GAymSpIMvctV14lSC2mrt6y+4VMVhzi
 dbxni9j8Sd/jLtJhLV90QEURVo6jPAxq7Pf0omVlGGLKD1mRx96+s/dMY9SCGv0L0FI7n0lgW
 CFG6rv3HLQUkeR2jnV88ZtOl0JTEaGVLd5HFMyzPD6ch0Pz/1CKaWjeZv1tzpa88+qZ0d83hL
 2toFLZZ6nr48XZHbbT1l1yR4ogSHC5+5oaOANoAVW21kYVBhu98u335h3bKbmJb5Yvpj5k6Hy
 Ekc05HdSYO3ffBAA0qN6zScj7MsL8tgcnhE007t1+8ECtCtKPhEFHnU71jjufNfW4+oY06RAm
 Sts5hbQLHq5LPvF00lSqQ94wo90djURiB38K4f41ycrAt9KQZnoJDxVT298GUSpCCQJ3OVnEK
 n3r1suYvoPMjSnxV+oXICSfKZGKmg6mJ+ApR3LdvXvrmGQapAPRPwWZvxD+5RK6MYfpdGxhoo
 5gMpRZnDLLk0+Te0L1CKZQgY8BJRmyybvhjGwVWNINAbTvDTUWYfWTEULKUNpWjc4lNcIfYbJ
 LcjWtSkTzyX7Kzitt92xoQByFuEp5j0+7BpLxZNwVOBH/ZecDeTub0IOcnNEwER0XrzxfjoFp
 aSUxLEaHxOKMHb7zQX0monFtqKwMYsc++v3B9woCi+xvKLZc9j46ihLMKSy+asrV7O2SnIo++
 TE/Ji3L/aN5ShBNxvcubq1lhN

CCI requires proc-supply. Add it on board level.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
=2D--
 arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dtsi b/a=
rch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dtsi
index 81ba045e0e0e..afa9e3b2b16a 100644
=2D-- a/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dtsi
@@ -40,6 +40,10 @@ reg_3p3v: regulator-3p3v {
 	};
 };
=20
+&cci {
+	proc-supply =3D <&rt5190_buck3>;
+};
+
 &cpu0 {
 	proc-supply =3D <&rt5190_buck3>;
 };
=2D-=20
2.43.0


