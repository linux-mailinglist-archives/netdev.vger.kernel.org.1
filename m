Return-Path: <netdev+bounces-85293-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A4789A11C
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 17:29:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31629287EC2
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 15:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47524171065;
	Fri,  5 Apr 2024 15:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smtpcorp.com header.i=@smtpcorp.com header.b="kIqBvHtB";
	dkim=pass (2048-bit key) header.d=asem.it header.i=@asem.it header.b="O+hRziHF"
X-Original-To: netdev@vger.kernel.org
Received: from e3i57.smtp2go.com (e3i57.smtp2go.com [158.120.84.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C77C16FF58
	for <netdev@vger.kernel.org>; Fri,  5 Apr 2024 15:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.120.84.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712330959; cv=none; b=Z7Mv4gDnUbT+i7B0F/woAaWkEmN5I1uovLH/Hr6tNChaRDzDaCjesbPydE43XNVOGEe3dhaGRjUwjFlhEBM9DzuEBZyniuIDsToJgO29gZWCtK+zwLM8OvqhwJq8WiDstwOlRXUlqZFbw6V22m40lOljANm3avngmbKJHKAgBgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712330959; c=relaxed/simple;
	bh=eTkke8cTaQuTil9Qf4Y1E+o+QFAi4UuM4kJMCq08Ef8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EZR321KRI9QmgW39SHcrGx63oqmrIte19kITiCA5zoSah3RMm29/ROuPVIJPaA9X3l7K/mAPFfZlgWWRE36DmJKdShsMALeTw8JubgozEt5vx1KPM83DJ/FsbOKMs+qTNZ4IVbquani5mqHNyIvHpUXSh+o8dtxVhAH5WIAsZzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asem.it; spf=pass smtp.mailfrom=em1174574.asem.it; dkim=pass (2048-bit key) header.d=smtpcorp.com header.i=@smtpcorp.com header.b=kIqBvHtB; dkim=pass (2048-bit key) header.d=asem.it header.i=@asem.it header.b=O+hRziHF; arc=none smtp.client-ip=158.120.84.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asem.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em1174574.asem.it
Received: from [10.86.249.198] (helo=asas054.asem.intra)
	by smtpcorp.com with esmtpa (Exim 4.96.1-S2G)
	(envelope-from <f.suligoi@asem.it>)
	id 1rslV1-04gIYl-2G;
	Fri, 05 Apr 2024 15:29:03 +0000
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
Subject: [PATCH 2/6] arm64: dts: imx8mp-beacon: remove tx-sched-sp property
Date: Fri,  5 Apr 2024 17:27:56 +0200
Message-Id: <20240405152800.638461-3-f.suligoi@asem.it>
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
X-OriginalArrivalTime: 05 Apr 2024 15:29:01.0479 (UTC) FILETIME=[FC4AB370:01DA876D]
X-smtpcorp-track: 1rs_V104gmY_2G.EuiAjfSRF1Yye
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smtpcorp.com;
 i=@smtpcorp.com; q=dns/txt; s=a1-4; t=1712330945; h=feedback-id :
 x-smtpcorp-track : date : message-id : to : subject : from : reply-to
 : sender : list-unsubscribe;
 bh=2+Mlo/B8JEt+9O2DNgOncVR4IzdOkeJ/dXwp0ZpjBmA=;
 b=kIqBvHtB2S79hN53NWytoGWgdStH0LXB0vSsG2tssJIvXjJ+fkY06HJzNovyzZpubQiHx
 kYpTKWGYOaNZkKdkIqwRobpwN+UdH9wf2ubxcfqlBsVu9F32sPSjuua9NwqM4K1HupbyK/j
 y/l450VwX2qiBmRnRy+3m6qB2EH67A4npmRlsqQQuI84BShMvdRf3ugnuQCyj3C1VZkvIDO
 mVnkG4gxoeKcE9Ivh9TcobHsu121Ww2O5OsbrFA5QqJl2CLoNAKzURXKnola+U2dN8nsNfc
 esfDDSsFcmTAv5HDWnOrfMoWSdILdMx5iGK8Tw9aX4GndOhfQ2RIWcu3ntGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=asem.it;
 i=@asem.it; q=dns/txt; s=s1174574; t=1712330945; h=from : subject : to
 : message-id : date; bh=2+Mlo/B8JEt+9O2DNgOncVR4IzdOkeJ/dXwp0ZpjBmA=;
 b=O+hRziHFk+r8XzkKSqCFsGe5sMyHGERNRI2IQJsy2C/T/yO2/eT2fLUeIQXb3CrZI2Smo
 oK7xyeprfynl3QPFYoBqJIKKN6IruOmRNaDeppqDXi6zQ6LsQfZlDeDaeorfRpAquUG1wVH
 RAx2LirVwklutCyMEu5EcjvzwWhVtFwvRuQ2OuWzGB7YypBuRSMPd2B8PwEaV5r8GJvyFbG
 tS11xFuwC6sXOcvgHnD5ILF8gTTZM+cXA/YEKOCX0MaBLsoIhBxt6F3kO28KfqtkrrFF4i8
 NHRzzL7bU8IvPEUyu1ynxjcdx/H7mhdJkqrdypdsQn2mJ4dC/oG5PJdc6q9Q==

The property "tx-sched-sp" no longer exists, as it was removed from the
file:

drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c

by the commit:

commit aed6864035b1 ("net: stmmac: platform: Delete a redundant condition
branch")

Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
---
 arch/arm64/boot/dts/freescale/imx8mp-beacon-som.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-beacon-som.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-beacon-som.dtsi
index 8be251b69378..34339dc4a635 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-beacon-som.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp-beacon-som.dtsi
@@ -106,7 +106,6 @@ queue4 {
 
 	mtl_tx_setup: tx-queues-config {
 		snps,tx-queues-to-use = <5>;
-		snps,tx-sched-sp;
 
 		queue0 {
 			snps,dcb-algorithm;
-- 
2.34.1


