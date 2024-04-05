Return-Path: <netdev+bounces-85295-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 831E889A123
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 17:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E2B9287CAE
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 15:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60743171662;
	Fri,  5 Apr 2024 15:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smtpcorp.com header.i=@smtpcorp.com header.b="OHfFhbpj";
	dkim=pass (2048-bit key) header.d=asem.it header.i=@asem.it header.b="Xs19+5Dm"
X-Original-To: netdev@vger.kernel.org
Received: from e3i57.smtp2go.com (e3i57.smtp2go.com [158.120.84.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD0417107F
	for <netdev@vger.kernel.org>; Fri,  5 Apr 2024 15:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.120.84.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712330964; cv=none; b=VfrkkEK0YkpMgDnOiqhaMxgzSKXEbtw7oX7lTpkZLGCi99F5U4yAvycCIL4LMcao/gGf0l8yQTfwaIIbo59znwo2G5w8c6aG70LR5ak2QxTQ0RzwheDKELbGKXhy2eDUON8TVpuvnELLdAfmy5n56Bwi3B8CII+lNUJ+4O88ZeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712330964; c=relaxed/simple;
	bh=fat/r3HbU9fmQ9BZUSIoNdkoDjoqNHVWvYNMh5bZGac=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Wo+o7mrTRCiaBzOWHVp8RQ3QlBOgKr4Iem/ohUeONca8Xbg7WhpbFtTG3Dwldhun12MPzmbHHmpIzUog5LNa/Dc8ukFuwFtiFXLiCGx7V0yNthdYE9fCsEz+FQq3LF029A2Q0gR2Hbqmsj+x2kjEZysYi/N3qARzJSZK17Gpfp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asem.it; spf=pass smtp.mailfrom=em1174574.asem.it; dkim=pass (2048-bit key) header.d=smtpcorp.com header.i=@smtpcorp.com header.b=OHfFhbpj; dkim=pass (2048-bit key) header.d=asem.it header.i=@asem.it header.b=Xs19+5Dm; arc=none smtp.client-ip=158.120.84.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asem.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em1174574.asem.it
Received: from [10.86.249.198] (helo=asas054.asem.intra)
	by smtpcorp.com with esmtpa (Exim 4.96.1-S2G)
	(envelope-from <f.suligoi@asem.it>)
	id 1rslV2-04gIYl-2n;
	Fri, 05 Apr 2024 15:29:04 +0000
Received: from flavio-x.asem.intra ([172.16.18.47]) by asas054.asem.intra with Microsoft SMTPSVC(10.0.14393.4169);
	 Fri, 5 Apr 2024 17:29:01 +0200
From: Flavio Suligoi <f.suligoi@asem.it>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>
Cc: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Flavio Suligoi <f.suligoi@asem.it>
Subject: [PATCH 4/6] arm64: dts: imx8mp-verdin: remove tx-sched-sp property
Date: Fri,  5 Apr 2024 17:27:58 +0200
Message-Id: <20240405152800.638461-5-f.suligoi@asem.it>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240405152800.638461-1-f.suligoi@asem.it>
References: <20240405152800.638461-1-f.suligoi@asem.it>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 05 Apr 2024 15:29:01.0641 (UTC) FILETIME=[FC636B90:01DA876D]
X-smtpcorp-track: 1rs_V204gmY_2n.EuMUjfTI28Wpb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smtpcorp.com;
 i=@smtpcorp.com; q=dns/txt; s=a1-4; t=1712330946; h=feedback-id :
 x-smtpcorp-track : date : message-id : to : subject : from : reply-to
 : sender : list-unsubscribe;
 bh=z6/lBWhbzIHfLCrRTM1SzzPe1OKp0Fc/uUJ7RPvyKV8=;
 b=OHfFhbpj+ylc8DNHhRf7Xuynk2CxLYFUhOAaA1HCKegJlVvX1rmD1YA28CwqTUBp9tFwd
 9EjZ0bSN45clAdXC6VSRu7H+QCQN2yPNI9cGqYQqX4a1xiB7wdrb7XxcxP+A3g/JIYZNuXI
 3CIlFQu+vnonhbEhYifdiV9KN8ecEup5lYlV1OU0JPibEnRAObWD2HINT0xV8EFyuFMfRQB
 F02afizM49lgK1q3u4gDHewL2nS3Xz7ie+wcK3F60GBxv6VqFkNWVUTiUeJeEiPfx8cEcr3
 AW+2VkG2JIAgNChAqhQbS8wunRgW6EaPli8XdROvNe5qqRyT3trV3mR87hNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=asem.it;
 i=@asem.it; q=dns/txt; s=s1174574; t=1712330947; h=from : subject : to
 : message-id : date; bh=z6/lBWhbzIHfLCrRTM1SzzPe1OKp0Fc/uUJ7RPvyKV8=;
 b=Xs19+5Dmf4Qwzcrghb9tf8KilcwcFqUup582Ecl0dIDSOXGOPk+PWYaQ/CUlw0mRo3gis
 rZnnN9rYWYGil9Bpe7ScXGiYousnEnzwRRfsp+695HeOHKj5g0k0qhYmAAzQ7e0OCy+MAmS
 XFdRSgX62NPAytMyDw2OjOuJUWopfzaev34TUdCfrqrjUVLnWWV6a1BfAjBQEcbNqA/y+60
 JWJkUlfmQTYFSC3pYsqBkVXzsxvD2pN2kWRm4GN1F6MWRWwUBdYoz7ES0NppU6XjmLzunVE
 u5nSOhRsbO1CTcPYVVIGvAF7yDw61kXS4IdPitgcP4RVIZ4IHIvgx0uXUn3A==

The property "tx-sched-sp" no longer exists, as it was removed from the
file:

drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c

by the commit:

commit aed6864035b1 ("net: stmmac: platform: Delete a redundant condition
branch")

Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
---
 arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
index f033d4310305..5b1b36a7ad38 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
@@ -260,7 +260,6 @@ queue4 {
 
 	mtl_tx_setup: tx-queues-config {
 		snps,tx-queues-to-use = <5>;
-		snps,tx-sched-sp;
 
 		queue0 {
 			snps,dcb-algorithm;
-- 
2.34.1


