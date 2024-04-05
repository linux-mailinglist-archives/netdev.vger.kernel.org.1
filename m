Return-Path: <netdev+bounces-85294-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E0ADE89A11F
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 17:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72860B2505F
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 15:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F9D17109B;
	Fri,  5 Apr 2024 15:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smtpcorp.com header.i=@smtpcorp.com header.b="R8vo1cuG";
	dkim=pass (2048-bit key) header.d=asem.it header.i=@asem.it header.b="ltGt4Jk3"
X-Original-To: netdev@vger.kernel.org
Received: from e3i57.smtp2go.com (e3i57.smtp2go.com [158.120.84.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B810516F91A
	for <netdev@vger.kernel.org>; Fri,  5 Apr 2024 15:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.120.84.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712330962; cv=none; b=UFZnheJStSA35mbkcLu2kjmjH0M2dOE8Q/svW/X3bhIqLLmxpXlBTGDMRo+Txl26U4E/E6ELefTaH8tn1bXSU5sdcG4wQimBkd6NHTrfl2Il8McRBnD7VQD76TbQ0J+f0NRc5ctct/yuSALnE9KO4sSY/ar9Gr501VthbJwGQAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712330962; c=relaxed/simple;
	bh=B/Y9KFHnGrgSCyRy0/AylRmUryM/Ly5WlXGcNe5R6y8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mo6xtuSxgM2tf+biio9me44gqezlEb0aH5GfgPcAIfosa0LAtqBufn4t6x5wsIlsOnsCpEyeC5jr+QkpGPCil2HCnm/y79+VPPQ+W0DjgVsHMWkHOK+99HzxGK3Z3JmtcNZrcEdnn0nkyOLXD2H67IAKZkTmEXTQDeOqARQ3Mlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asem.it; spf=pass smtp.mailfrom=em1174574.asem.it; dkim=pass (2048-bit key) header.d=smtpcorp.com header.i=@smtpcorp.com header.b=R8vo1cuG; dkim=pass (2048-bit key) header.d=asem.it header.i=@asem.it header.b=ltGt4Jk3; arc=none smtp.client-ip=158.120.84.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asem.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em1174574.asem.it
Received: from [10.86.249.198] (helo=asas054.asem.intra)
	by smtpcorp.com with esmtpa (Exim 4.96.1-S2G)
	(envelope-from <f.suligoi@asem.it>)
	id 1rslV3-04gIYl-1T;
	Fri, 05 Apr 2024 15:29:05 +0000
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
Subject: [PATCH 5/6] arm64: dts: qcom: sa8540p-ride: remove tx-sched-sp property
Date: Fri,  5 Apr 2024 17:27:59 +0200
Message-Id: <20240405152800.638461-6-f.suligoi@asem.it>
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
X-OriginalArrivalTime: 05 Apr 2024 15:29:01.0719 (UTC) FILETIME=[FC6F5270:01DA876D]
X-smtpcorp-track: 1rs_V304gmY_1T.EuMjjfTvOUCWO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smtpcorp.com;
 i=@smtpcorp.com; q=dns/txt; s=a1-4; t=1712330947; h=feedback-id :
 x-smtpcorp-track : date : message-id : to : subject : from : reply-to
 : sender : list-unsubscribe;
 bh=6HGwCVZ1ZliNjksUiz6WB6FukgOBYyF3KdLTYEIBNkQ=;
 b=R8vo1cuGfGFO38Q11zNco3H+R3oYEW1ELtEC+0cTUaYXYlCj2vWvxPUMKEg8JbjJ3lfAC
 N6OTX7b1OU9CpEkEVCbRsgnS8t3dLtBQpamyiJroDIHz9BCWkSQOJ8sEjhmz3Ok6TNLCmea
 /RwEUEV9rh2EzeN6t07Y2vwmFP4uHJyfa2MheAybohbXnKVyDIkFSkwIPRMZYjc8jxC8pjp
 SBhEAqBDws/cfJjrEUaLYgNZfYRojHOmhRQg5PI1fm9omJVjaB6qdfBzMobwEmiRAdhLC+p
 yotbwpWGVhgPdg7vN49VjBTtZjl6ekpqtk0iKUxrcBezvybKqM1zrJszkTQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=asem.it;
 i=@asem.it; q=dns/txt; s=s1174574; t=1712330947; h=from : subject : to
 : message-id : date; bh=6HGwCVZ1ZliNjksUiz6WB6FukgOBYyF3KdLTYEIBNkQ=;
 b=ltGt4Jk3FUdS/luWLMsWvoNhsCBkH+B0RIh51ZArshaizhETiAMiGWpvER0pViVXaM9Yn
 ai5At9O+uKPbDomdEDvm6yMT6v6DAP0PvNPxxE5oIERqSeLJVWy1si/vdPyUV3xbZ8ZjMgK
 CzfuLmT1Mfv4SiXj8UFGtIVpMmmwAbRcABY6c1c20gQF79P2nUc4F9Rh1RxXU7jaWxp10Ph
 UWv8jCGwsdjmuvYGxW4KcaGmZhejPA32zW8r62Voq/b8+/7MSqp0r6x2NiUia2CC2UsNmTo
 i7U2fycfQf2E6qjfUajSanQmWPssW1Kx52sFPLBpdZnQ/f62pJ8wAnxkxdFg==

The property "tx-sched-sp" no longer exists, as it was removed from the
file:

drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c

by the commit:

commit aed6864035b1 ("net: stmmac: platform: Delete a redundant condition
branch")

Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
---
 arch/arm64/boot/dts/qcom/sa8540p-ride.dts | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sa8540p-ride.dts b/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
index 177b9dad6ff7..11663cf81e45 100644
--- a/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
+++ b/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
@@ -225,7 +225,6 @@ queue3 {
 
 	ethernet0_mtl_tx_setup: tx-queues-config {
 		snps,tx-queues-to-use = <1>;
-		snps,tx-sched-sp;
 
 		queue0 {
 			snps,dcb-algorithm;
@@ -302,7 +301,6 @@ queue3 {
 
 	ethernet1_mtl_tx_setup: tx-queues-config {
 		snps,tx-queues-to-use = <1>;
-		snps,tx-sched-sp;
 
 		queue0 {
 			snps,dcb-algorithm;
-- 
2.34.1


