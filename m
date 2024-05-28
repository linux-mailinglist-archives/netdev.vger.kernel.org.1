Return-Path: <netdev+bounces-98460-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63DC58D183D
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 12:16:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5E17B23027
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 10:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC1B13D89F;
	Tue, 28 May 2024 10:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smtpcorp.com header.i=@smtpcorp.com header.b="GXknF8UN";
	dkim=pass (2048-bit key) header.d=asem.it header.i=@asem.it header.b="dZvcuvcD"
X-Original-To: netdev@vger.kernel.org
Received: from e2i187.smtp2go.com (e2i187.smtp2go.com [103.2.140.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE60B17E90E
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 10:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.2.140.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716891384; cv=none; b=mLTKE1b1bT5W1SKJ5ulmRPEs4OrZd02wvaegGqMkQ00PGaiyiuoOsgY4V3bsBLfpu+zL/qCzBE5UxKN0OZHgTMi1NaS6w4HODjVa8KcauKfSzHJPIYiWCYWH/KHxlYRiUYNf1r6Bw/SufzyTH6AxBl4R8/57m1ePVIhdo/GBl5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716891384; c=relaxed/simple;
	bh=bK8clUyAHSzXZLRJypon/9/cndNSHirh31wv3eY35Ac=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iJUL7QUJoR+gEuhWBc0E3tu/5ObeQVkkEJCfysLvIZAcMGGkzXALCJU8rc2ZlfTnWgTobkxsp0YRWOhm475gdOqNb5n/EuAml7jGbOy1cU76UqwAj5DPDlhu/PsNbfUNQWA8uG4Rxt0Z6ywwakVdQqxuAMIU51ncZI/KSXM4olg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asem.it; spf=pass smtp.mailfrom=em1174574.asem.it; dkim=pass (2048-bit key) header.d=smtpcorp.com header.i=@smtpcorp.com header.b=GXknF8UN; dkim=pass (2048-bit key) header.d=asem.it header.i=@asem.it header.b=dZvcuvcD; arc=none smtp.client-ip=103.2.140.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asem.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em1174574.asem.it
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpcorp.com; s=a1-4; h=Feedback-ID:X-Smtpcorp-Track:Message-Id:Date:
	Subject:To:From:Reply-To:Sender:List-Unsubscribe:List-Unsubscribe-Post;
	bh=w4ZAWZTNg1euJmLaEWbFNw2s9ni8efmSIaUdOd2VsbQ=; b=GXknF8UN0d/q6YYvJzEXYO02Kf
	q00x83Sc+Hg+Z+JAlBqeF+NLk6Z+Cz6AWvlO+qpi0ajdvU4Pn+BeMsceRS1eQG/P/+YpoC42JONdk
	54JqlH2oKZHyJSmkfKBdpTrIueXvOcTN5D6HH1HrAeShgNY9L/p5WTG46SaJ0K8Y+A3MOYz2ZYKFZ
	3axfDTrU32pAOxnGQrGbyxe57JkZK+4yn5AUycitI4b3Edui8VNgXR2EgefTJnxeUdyc84j4CUBzR
	RrnuWuHAYDEoY7/0O/KUQblmTKF/YQbM4hs2TalOvGe9D9SQyb/Y9LraUJ5zMkA1/kKN3i12QmBW0
	96XC3ngQ==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=asem.it;
 i=@asem.it; q=dns/txt; s=s1174574; t=1716891381; h=from : subject : to
 : message-id : date; bh=w4ZAWZTNg1euJmLaEWbFNw2s9ni8efmSIaUdOd2VsbQ=;
 b=dZvcuvcDrQhX5XCB3i+0ZTumwep4p7tiIqFZRqNNLOy5PMvImMqhOLQlA4WlSnNTfg4Bm
 Ogb6u2C4vPaj/lfI9FVeEiVA5FR0r2YiJL7P8vTayx66SvaZ/kpbtULf8lbK58Im4HuEsVI
 hTNfKHQ4y5Q5fPnue+LMEO2d+Bu3NaO23tZLB5z62O7r8rDUlPFwuqrifQOZa6p3Lcpkvcc
 hgyM3r4CrpZCjKBzRHav07YOI87mo6ct8KTI3qlvlisMVBug8V2sWjqMIN5/flneobEXKDF
 O3teBLSYG0GSwJKCzcq6glD3ykEM8wG3XYC1xLW9skgNLf0pi5rsbJXXB/Vg==
Received: from [10.45.56.87] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <f.suligoi@asem.it>)
 id 1sBtsQ-Y8PCFe-L6; Tue, 28 May 2024 10:16:18 +0000
Received: from [10.86.249.198] (helo=asas054.asem.intra)
 by smtpcorp.com with esmtpa (Exim 4.97-S2G)
 (envelope-from <f.suligoi@asem.it>) id 1sBtsO-FnQW0hPuHwL-dstN;
 Tue, 28 May 2024 10:16:16 +0000
Received: from flavio-x.asem.intra ([172.16.18.47]) by asas054.asem.intra with
 Microsoft SMTPSVC(10.0.14393.4169); Tue, 28 May 2024 12:16:14 +0200
From: Flavio Suligoi <f.suligoi@asem.it>
To: "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Giuseppe Cavallaro <peppe.cavallaro@st.com>,
 Jose Abreu <joabreu@synopsys.com>, Adam Ford <aford173@gmail.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Flavio Suligoi <f.suligoi@asem.it>
Subject: [PATCH v4 0/5] arm64: dts: remove tx-sched-sp property in snps,dwmac
Date: Tue, 28 May 2024 12:15:48 +0200
Message-Id: <20240528101553.339214-1-f.suligoi@asem.it>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 28 May 2024 10:16:14.0231 (UTC)
 FILETIME=[1208AA70:01DAB0E8]
X-Smtpcorp-Track: 17nDhEGNukrj.q2nr2E8blN4L.BCefuQNK9Nk
Feedback-ID: 1174574m:1174574aXfMg4B:1174574s6j27gZQMC
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>

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

**************************************************************************
NOTE about this v4 patch series: resending this v4 version of the patches,
     I omitted the word "RESEND" in the subject line, since I added a new
     tag in the patch num. 5/5.
**************************************************************************

v4 - Resend after some weeks and added the tag "Reviewed-by: Krzysztof
     Kozlowski <krzysztof.kozlowski@linaro.org>" in patch num. 5/5.
v3 - Removed the tag "Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>"
     in patches num. 1/5, 2/5, 3/5 and 5/5 (it was added by mistake).
     Added history in each of the patches, as well as in the cover-letter.
v2 - This patch is the 2nd version of a previous patch, where both the DTS
     and the yaml files were included toghether. Then I split this 1st
     patch series in two, as suggested by Krzysztof.
v1 - Original version of the patch where, in addition to these DTS patches,
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


