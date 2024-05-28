Return-Path: <netdev+bounces-98461-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F5818D183E
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 12:16:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 401701F24D56
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 10:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01DC81667F4;
	Tue, 28 May 2024 10:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smtpcorp.com header.i=@smtpcorp.com header.b="ilY3hhM9";
	dkim=pass (2048-bit key) header.d=asem.it header.i=@asem.it header.b="iWWZh4ZV"
X-Original-To: netdev@vger.kernel.org
Received: from e2i187.smtp2go.com (e2i187.smtp2go.com [103.2.140.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C837346B
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 10:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.2.140.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716891384; cv=none; b=QeyF/7wcLmq9Jrgen4rux5CoQCXvRYINyoof+DzwZpfcgpSveJRZl+JKuSio0vxpyFfg1jfNnwEv//itB1Tex8YkIXDrUPinX1r7rU/l+KQCmGhxN5ElayRURzv/YLNvmWOOcq2KgF6PaBqcBIULzjCIAs0Ht14lDMZBVU6n0Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716891384; c=relaxed/simple;
	bh=6oC0Iuu393khyKlVI9xXwwcZLOlRA27Y75uOzGSXvFs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Hoxt1fmP45pGnfxvV8CBu2jkd/0cxXK6ZNxQp1I4fMuTFMbnIkDB3WHdMr2df7UByGoQAiEvDfy9FkklE8FOyn4orlRiRZX5jaSNVGUB4QZ/ZheECY1f0Vx2djp7GQN4L/BSNnATuIDK3E8ObopMKlNOiRwrTt9/Ju6ZAG+rBRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asem.it; spf=pass smtp.mailfrom=em1174574.asem.it; dkim=pass (2048-bit key) header.d=smtpcorp.com header.i=@smtpcorp.com header.b=ilY3hhM9; dkim=pass (2048-bit key) header.d=asem.it header.i=@asem.it header.b=iWWZh4ZV; arc=none smtp.client-ip=103.2.140.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asem.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em1174574.asem.it
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpcorp.com; s=a1-4; h=Feedback-ID:X-Smtpcorp-Track:Message-Id:Date:
	Subject:To:From:Reply-To:Sender:List-Unsubscribe:List-Unsubscribe-Post;
	bh=AuGU9ww0mJkm0U99Qi0nDaMfje+KtX6V7T19eN68Ao0=; b=ilY3hhM9VW2zA/n6wgvcEG2yMl
	T7Vaa1Pwv3dAI/pfE6z5/Thpv1rrnwoOytweKcpgPEft5MU6aOYVGcUTfb2wzilldyJ5HCdkMPXaj
	RJDXsOTDlN+u6RxCM9OLtSlKF9umuphAmboPS7uMkcTKB18t+qewAvZZQDfplW5EKGzcWwLHF/hW+
	ZlzfQ48l7jl7/IUooe0DFiL1JcxWvbS5et1DD7mL+4nay2CMEF5Oub8cZ2Q+RQXSI/AMUDK92P2hZ
	TffnZiVYclU2unwHgVrIiNtRbR4RZkgJYPKi7E/pirwoXlDE9XE0L1pSd4iIa9BIpqANZkhVDBwuc
	q5mgMewA==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=asem.it;
 i=@asem.it; q=dns/txt; s=s1174574; t=1716891382; h=from : subject : to
 : message-id : date; bh=AuGU9ww0mJkm0U99Qi0nDaMfje+KtX6V7T19eN68Ao0=;
 b=iWWZh4ZVYKghvZg87qh4/OcIFIGfJKAIwxJKg58stkDHvoPR247tTS9fxKYb/8CZaj/aA
 WpqG/ErGwA7TZBtSnePr1eMgeeMSyXabXzq6Ucc1HJgXNt3McmqNn0wcuC20wZLA0bEfj48
 18+p+lbslhj9ERIkhvbaCHjPVfTB3Eu8Cjks5AAzwIQh+jHsxJ1GgG1GgqMSu6eB8Abd8ZB
 llyxIPcMj49fpH/T1/nYFO5d3YvjBtN38MvYgKXJdHmZt8wWfKcTMS/0PhzhScOxlvZRSz6
 4oCp/A1MRLplfsyQzuCg89CXDhC507tZroswWhrr6WRPeqfPaCzmWZ3JzjOQ==
Received: from [10.45.56.87] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <f.suligoi@asem.it>)
 id 1sBtsS-Y8PCR4-9O; Tue, 28 May 2024 10:16:20 +0000
Received: from [10.86.249.198] (helo=asas054.asem.intra)
 by smtpcorp.com with esmtpa (Exim 4.97-S2G)
 (envelope-from <f.suligoi@asem.it>) id 1sBtsQ-FnQW0hPuHwL-cTe3;
 Tue, 28 May 2024 10:16:18 +0000
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
Subject: [PATCH v4 1/5] arm64: dts: freescale: imx8mp-beacon: remove
 tx-sched-sp property
Date: Tue, 28 May 2024 12:15:49 +0200
Message-Id: <20240528101553.339214-2-f.suligoi@asem.it>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240528101553.339214-1-f.suligoi@asem.it>
References: <20240528101553.339214-1-f.suligoi@asem.it>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 28 May 2024 10:16:14.0263 (UTC)
 FILETIME=[120D8C70:01DAB0E8]
X-Smtpcorp-Track: kcLYYUmzJ3P0.1VnP2b_WbkYr.4nuqFAL2XVU
Feedback-ID: 1174574m:1174574aXfMg4B:1174574sk39EAmvT5
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>

Strict priority for the tx scheduler is by default in Linux driver, so the
tx-sched-sp property was removed in commit aed6864035b1 ("net: stmmac:
platform: Delete a redundant condition branch").

So we can safely remove this property from this device-tree.

Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
---

v4 - Resend after some weeks (also added the tag "Reviewed-by: Krzysztof
     Kozlowski <krzysztof.kozlowski@linaro.org>" in patch num. 5/5.
v3 - Removed the tag "Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>"
     (it was added by mistake).
     Added history, as well as in the cover-letter.
v2 - This patch is the 2nd version of a previous patch, where both the DTS
     and the yaml files were included toghether. Then I split this 1st patch
     series in two, as suggested by Krzysztof.
v1 - Original version of the patch where, in addition to this DTS patch,
     there was also the one related to the correspondent snps,dwmac.yaml
     dt_binding file.

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


