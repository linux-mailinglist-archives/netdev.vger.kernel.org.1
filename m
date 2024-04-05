Return-Path: <netdev+bounces-85296-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A4EB89A138
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 17:31:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B962B287DA0
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 15:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42884171E7B;
	Fri,  5 Apr 2024 15:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smtpcorp.com header.i=@smtpcorp.com header.b="stjRjJVJ";
	dkim=pass (2048-bit key) header.d=asem.it header.i=@asem.it header.b="Vxkix0St"
X-Original-To: netdev@vger.kernel.org
Received: from e3i57.smtp2go.com (e3i57.smtp2go.com [158.120.84.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE52171E7D
	for <netdev@vger.kernel.org>; Fri,  5 Apr 2024 15:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.120.84.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712330981; cv=none; b=hrdckmWwtWPmaOROcdpypVOybt5CT6SfAIaYhxojDN03P6UVeg4PnThuRpvhuBPz8wwO2nhPShgzPRNMP/x0C55wZqDJglPm9BsmhCCyMk2bT2I2fjrb/qKrwWY6ZLHXgmXxm+Gs1pkGuZZtThvUb2ys6ez5Ihdu/bfBkFavcBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712330981; c=relaxed/simple;
	bh=0pYDM4UNhKfS+fr+khXSp9jVPuhVAFWiMJpP1HoiGpE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PgYTm7qXC4e6Vi8Nu9iYOcBeiE4Zg3wvs/4leQPwkJT+nifk9dHiBrHRN+l4nWpOXrhAHkLssBRKHHHpYak2p6OhKZICktNGBpt2VaHcj4OIlB6QgkeDiPI99hp6LU/OZg9fBPvHTzHTrlkpU/kt1BCCN+rtl8VoXOmNHvFZxLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asem.it; spf=pass smtp.mailfrom=em1174574.asem.it; dkim=pass (2048-bit key) header.d=smtpcorp.com header.i=@smtpcorp.com header.b=stjRjJVJ; dkim=pass (2048-bit key) header.d=asem.it header.i=@asem.it header.b=Vxkix0St; arc=none smtp.client-ip=158.120.84.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asem.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em1174574.asem.it
Received: from [10.86.249.198] (helo=asas054.asem.intra)
	by smtpcorp.com with esmtpa (Exim 4.96.1-S2G)
	(envelope-from <f.suligoi@asem.it>)
	id 1rslV4-04gIYl-08;
	Fri, 05 Apr 2024 15:29:06 +0000
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
Subject: [PATCH 6/6] dts: qcom: sa8775p-ride: remove tx-sched-sp property
Date: Fri,  5 Apr 2024 17:28:00 +0200
Message-Id: <20240405152800.638461-7-f.suligoi@asem.it>
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
X-OriginalArrivalTime: 05 Apr 2024 15:29:01.0798 (UTC) FILETIME=[FC7B6060:01DA876D]
X-smtpcorp-track: 1rs_V404gmY_08.EuMDjfTsS_drq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smtpcorp.com;
 i=@smtpcorp.com; q=dns/txt; s=a1-4; t=1712330948; h=feedback-id :
 x-smtpcorp-track : date : message-id : to : subject : from : reply-to
 : sender : list-unsubscribe;
 bh=ZlqPPXH5bNJhEltSGKCBrMvzg4Eqwu2ZB1ba92tVMY8=;
 b=stjRjJVJ5WbaqBtjtfhvALlwIBf3Hwvz6ccV5rTyuN7AshURZlFwRctd7O0V4X9jNglJk
 2rV+Jt5BEuLWtzaH0SSJLzeP/0mbJpa6n5d+UgM+Ikg5FXqwN8iCNMpcnsbN0l/ufat5GtK
 Rg0MCcxBcnPZy0ang0H1j2CIJ6F2b6FiuI2o9CeSuLFHyqoMc4e8la19a7AQNiZzICT/zY1
 kWzdvhLN7VZGfMRjREMvRpID9gDxscu5Tyw3HFU/NxO7C43KELlZcDVOivQ3bHJyGL1UQCx
 zY9rXgb81Q2ZFrDmP5799TKXHTGMC3K+gx9glTFxGtfPKckL9iNT7OVX+WVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=asem.it;
 i=@asem.it; q=dns/txt; s=s1174574; t=1712330948; h=from : subject : to
 : message-id : date; bh=ZlqPPXH5bNJhEltSGKCBrMvzg4Eqwu2ZB1ba92tVMY8=;
 b=Vxkix0StbBvzufGOtbjGx0hu/r55r7PAZwNN4r+l7saEeNMJpnBKNmv0g7ta96Nqol6Dc
 pviVQKBSjgO0Lo1TG5yDsl6W7H7MlLhd22Wqf0fNKl9f3RFv1GuKIdCfmSbdghPulsy8QSP
 nw4Wp3Dt86kaieU11B09Z25byIB+Uk660G/gStUuRJsr3jiiiDxKo5zi28qpRScF3ljAFgQ
 Az5DZOn21jKjeuX/CkbZC8YLWfS1/0H5+dttimeuaZBVBYC0tZPuyZpGXXGeBonD7CggiO+
 Wvs2BTNNTb4a9H9WzWcG8jt7VGKntSEmIFNONAHLeET/8+GpMlN4pIXelaEA==

The property "tx-sched-sp" no longer exists, as it was removed from the
file:

drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c

by the commit:

commit aed6864035b1 ("net: stmmac: platform: Delete a redundant condition
branch")

Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
---
 arch/arm64/boot/dts/qcom/sa8775p-ride.dts | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
index 26ad05bd3b3f..2e1770e07f45 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
+++ b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
@@ -334,7 +334,6 @@ queue3 {
 
 	mtl_tx_setup: tx-queues-config {
 		snps,tx-queues-to-use = <4>;
-		snps,tx-sched-sp;
 
 		queue0 {
 			snps,dcb-algorithm;
@@ -404,7 +403,6 @@ queue3 {
 
 	mtl_tx_setup1: tx-queues-config {
 		snps,tx-queues-to-use = <4>;
-		snps,tx-sched-sp;
 
 		queue0 {
 			snps,dcb-algorithm;
-- 
2.34.1


