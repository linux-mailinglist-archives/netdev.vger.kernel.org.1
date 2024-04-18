Return-Path: <netdev+bounces-89176-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 685268A99CB
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 14:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24A4428128C
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 12:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A15B515FCEA;
	Thu, 18 Apr 2024 12:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smtpcorp.com header.i=@smtpcorp.com header.b="U7Q7ChxZ";
	dkim=pass (2048-bit key) header.d=asem.it header.i=@asem.it header.b="PlydqyOr"
X-Original-To: netdev@vger.kernel.org
Received: from e3i51.smtp2go.com (e3i51.smtp2go.com [158.120.84.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB17B15F40B
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 12:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.120.84.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713443372; cv=none; b=s0Sa0wNVfNh74EgJU9rxJWyhcC8o8MDbEIk6W704fi606dC0sw8bAe3Sed468mFxxuM3WZWeemdjK+62DbNvd8UUhFBn6+fb64Qy7Xz4ihz7gWoi7weOfY1q+FQfTaTUbxmkg+SrvIKcxlUNHA9Tt71KoKAUykh6286z4Qhxckw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713443372; c=relaxed/simple;
	bh=fop2tDdvT4Rg5l7ondzUbscaRR+uHGG3gHYZCup3Lls=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LJK90322hjhHOmD4PtRPXn4Ew7gAqFVLkHm4p9Nk88uKYJ1c3lUmHwgpUcKHYaTlGzJ9PbKS3QuIg3+kXLZCfUaMh78VWfPAuDHd+6oCt7YSrdItzfnIdYLD+jMFfe/A4TQFr5pJdMbG6wij4tOuAjjPiTB+8vy6jkX2aicUrJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asem.it; spf=pass smtp.mailfrom=em1174574.asem.it; dkim=pass (2048-bit key) header.d=smtpcorp.com header.i=@smtpcorp.com header.b=U7Q7ChxZ; dkim=pass (2048-bit key) header.d=asem.it header.i=@asem.it header.b=PlydqyOr; arc=none smtp.client-ip=158.120.84.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asem.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em1174574.asem.it
Received: from [10.86.249.198] (helo=asas054.asem.intra)
	by smtpcorp.com with esmtpa (Exim 4.96.1-S2G)
	(envelope-from <f.suligoi@asem.it>)
	id 1rxQtI-wSFvR6-2U;
	Thu, 18 Apr 2024 12:29:24 +0000
Received: from flavio-x.asem.intra ([172.16.18.47]) by asas054.asem.intra with Microsoft SMTPSVC(10.0.14393.4169);
	 Thu, 18 Apr 2024 14:29:23 +0200
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
Subject: [PATCH v2 0/5] arm64: dts: remove tx-sched-sp property in snps,dwmac
Date: Thu, 18 Apr 2024 14:28:54 +0200
Message-Id: <20240418122859.2079099-1-f.suligoi@asem.it>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 18 Apr 2024 12:29:23.0515 (UTC) FILETIME=[0B7EA8B0:01DA918C]
X-smtpcorp-track: 1rxQtmwSFvR62l.mcm_ue4K1eBQZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smtpcorp.com;
 i=@smtpcorp.com; q=dns/txt; s=a1-4; t=1713443366; h=feedback-id :
 x-smtpcorp-track : date : message-id : to : subject : from : reply-to
 : sender : list-unsubscribe;
 bh=gHoVF4+qnuYpG3bFpPHolfB6dA01j229z+bTKcaSRuA=;
 b=U7Q7ChxZpD8VW6Sm92T5KDzj/I1qwiZpb3vCeji2oRaLOs2ZqNK++0udNNBLI0cfFfdSQ
 BBMiq226v7JAd6HeCxs9ceLsZT1a7LKjAYJJNWS0qvAL73D0HdVKRFjcz4/ua95VvsRPMnD
 ldE4KbLyua3Tsa4LCZ0CcHDoUqkZm7q7ne05IWG29+KKLwxa+vKM6ykQxjDwp4uJC/XYzmT
 2dBiq9TFXhszrQu94IP+xIE1X0FA8o9gkeXljjNdybabV7EmN0f774MswMatIkDcZGzGL9h
 ItlrAxr52JXJvsZaoVeEiMAlfoZAZ9CPBEUOP379Sn+yx/eomS4/YrEWzT1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=asem.it;
 i=@asem.it; q=dns/txt; s=s1174574; t=1713443366; h=from : subject : to
 : message-id : date; bh=gHoVF4+qnuYpG3bFpPHolfB6dA01j229z+bTKcaSRuA=;
 b=PlydqyOrtD4hsTAl7I1ZhCGZVE9jyua/ddh/rTxm4Odqr33f43QBrTAcuq4BJI1MldP/U
 Dme8Pzl3jd1xu2PWHHnexUzdewGX6/aiqgMykdyT+1tIvYYmxb/2MYmIM24PKwQq+M5bcRS
 eCzhEIy/hCtjCT7Lxc3qHdhg9No9LUZqdN1/cdJCxM056MbMQ91ItXXCBx2kLfRYP7+ycm0
 /xXk0whs1IUAWHf7/TPzX1vxCFsxz1f2VwX56uv8HNn/Ov0MfJqpkC1znFnXNMkZ+lrIbao
 lEo1OyaRlIBQaEPyJDQhYHLa6BCn8JGCa6t9CJLZk3TrjnUVLP6edAQXe0Tw==

In the ethernet stmmac device driver:

- drivers/net/ethernet/stmicro/stmmac/

The "Strict priority" for the tx scheduler is by default in Linux driver,
so the tx-sched-sp property was removed in commit aed6864035b1 ("net:
stmmac: platform: Delete a redundant condition branch").

This patch series remove this property from the following device-tree
files:

- arch/arm64/boot/dts/freescale/imx8mp-beacon-som.dtsi
- arch/arm64/boot/dts/freescale/imx8mp-evk.dts
- arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
- arch/arm64/boot/dts/qcom/sa8540p-ride.dts
- arch/arm64/boot/dts/qcom/sa8775p-ride.dts

There is no problem if that property is still used in these DTS,
since, as seen above, it is a default property of the driver.

The property is also removed, in a separate patch, from the corresponding
dt_bindings file:
- Documentation/devicetree/bindings/net/snps,dwmac.yaml

v2 - This patch is the 2nd version of a previous patch, where both the DTS
     and the yaml files were included toghether. Then I split this 1st
     patch in two, as suggested by Krzysztof.
v1 - original version of the patch where, in addition to these DTS patches,
     there was also the one related to the correspondent snps,dwmac.yaml
     dt_binding file.

Flavio Suligoi (5):
  arm64: dts: freescale: imx8mp-beacon: remove tx-sched-sp property
  arm64: dts: freescale: imx8mp-evk: remove tx-sched-sp property
  arm64: dts: freescale: imx8mp-verdin: remove tx-sched-sp property
  arm64: dts: qcom: sa8540p-ride: remove tx-sched-sp property
  arm64: dts: qcom: sa8775p-ride: remove tx-sched-sp property

 arch/arm64/boot/dts/freescale/imx8mp-beacon-som.dtsi | 1 -
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts         | 1 -
 arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi     | 1 -
 arch/arm64/boot/dts/qcom/sa8540p-ride.dts            | 2 --
 arch/arm64/boot/dts/qcom/sa8775p-ride.dts            | 2 --
 5 files changed, 7 deletions(-)

-- 
2.34.1


