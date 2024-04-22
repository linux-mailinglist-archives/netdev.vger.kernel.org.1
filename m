Return-Path: <netdev+bounces-90012-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC6458AC85B
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 11:05:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 621BA1F21324
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 09:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C99A1422A4;
	Mon, 22 Apr 2024 09:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smtpcorp.com header.i=@smtpcorp.com header.b="R7b8UlcR";
	dkim=pass (2048-bit key) header.d=asem.it header.i=@asem.it header.b="McFguXsj"
X-Original-To: netdev@vger.kernel.org
Received: from e2i187.smtp2go.com (e2i187.smtp2go.com [103.2.140.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142B613F443
	for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 09:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.2.140.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713776678; cv=none; b=SGZOuYYLWToNClLXL4XebTqE3x7EZNPbp0Zy5q3e2iCxD3DtSz2+ymijxboLGrihaY3Fgu6LLk1S/hXoODdBhT0gV0PttAlHAaZdtLUoxuCuwTimXl2Az8OeDiEgATHB+AYEswDQepvyswdgGolerMbe/55F5uHKGjI598XoGz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713776678; c=relaxed/simple;
	bh=t2eI8tvKI1hpvEgK+1gE/rmaW5rWqOU0VQ8ytyd3ng0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Oy3aqYetI3ci7d8oxrAoBa/wgPtD6lMG+aNjqSXrRh/3X00+e1jyq8SUv1UOiZELmce6yKuITzdPHdc2gC0JP1aYmg+zh1A4IPYKIbMIf0znemVaQWwnp2GmwrzVNvr8EFYes1AbsaQ7O5VRqNy/xs9jU+RyBtXp1mdiss3D4JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asem.it; spf=pass smtp.mailfrom=em1174574.asem.it; dkim=pass (2048-bit key) header.d=smtpcorp.com header.i=@smtpcorp.com header.b=R7b8UlcR; dkim=pass (2048-bit key) header.d=asem.it header.i=@asem.it header.b=McFguXsj; arc=none smtp.client-ip=103.2.140.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asem.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em1174574.asem.it
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpcorp.com; s=a1-4; h=Feedback-ID:X-Smtpcorp-Track:Message-Id:Date:
	Subject:To:From:Reply-To:Sender:List-Unsubscribe;
	bh=TH2B+Yui+mmCtAONXy6DE87yiqCx8QnMvncW24XxHS8=; b=R7b8UlcRtH/PbIh/AFgyXbTrw6
	gYNrSVH7CVP4UdG93RwacpZmsv8d+iNacBYRvi57X2GY8Il2dzIe1Pn0IRuKXdjitt7crfn8dkkga
	g62u+mOsqxTCGVVEh6TTWsq8SV85A6xmkirP4exyz84j6KKy5DsgmKdQVeMfjRCS1nXpfqpOgeNn7
	szbPa/0s3s0mCoXIRC+nfWktwdUFJtjAttIZXaje/F7tpD6bKQxNrVhdYO/trHtF7PJWegTvk2C5n
	R3FRlbZeG0N9KuAtFYm8U0esbBCGf8qxyRK3d5PxvoD6bELXVy+AoD24oXS/7Q/8V1YaODbuqDWB6
	7Yx7uIDA==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=asem.it;
 i=@asem.it; q=dns/txt; s=s1174574; t=1713776654; h=from : subject : to
 : message-id : date; bh=TH2B+Yui+mmCtAONXy6DE87yiqCx8QnMvncW24XxHS8=;
 b=McFguXsjLi/lQnwAP0q7N/J7Gvgo9xLdZDRV6dp4Q9Ls2q20uMyedseVFXUzIXhlG1bey
 U0XahHeexqowHxk7kLi1Crb3kqV8pYEOe/RclzkdyAMVXKWIRg0HIBhsZZKkNbAcYFtkXQU
 30x8wd7L5g0z4cxh0BGIPsTzyvYTV6t/4IvU13lcjeb0mX1VcBZXB9Uh/ebCXQvUQopI/xn
 /TBGV1/y/cx1+oSbh//OF0+1fj3ilbzjZrRZ7Yis0AQbaQfrJxFp7GTvIiDHYGYbp1bZnQo
 BR/Y2idNYd5vAgf/N505g4C7/WCA2WqSKsyO7m1h59I+wVZgT5bCj9uVV9LA==
Received: from [10.143.42.182] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <f.suligoi@asem.it>)
 id 1rypau-Y8PDzp-8e; Mon, 22 Apr 2024 09:04:12 +0000
Received: from [10.86.249.198] (helo=asas054.asem.intra)
 by smtpcorp.com with esmtpa (Exim 4.97-S2G)
 (envelope-from <f.suligoi@asem.it>) id 1rypat-FnQW0hPpvx6-i0lV;
 Mon, 22 Apr 2024 09:04:11 +0000
Received: from flavio-x.asem.intra ([172.16.18.47]) by asas054.asem.intra with
 Microsoft SMTPSVC(10.0.14393.4169); Mon, 22 Apr 2024 11:04:08 +0200
From: Flavio Suligoi <f.suligoi@asem.it>
To: "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Giuseppe Cavallaro <peppe.cavallaro@st.com>,
 Jose Abreu <joabreu@synopsys.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Flavio Suligoi <f.suligoi@asem.it>
Subject: [PATCH v3 3/5] arm64: dts: freescale: imx8mp-verdin: remove
 tx-sched-sp property
Date: Mon, 22 Apr 2024 11:04:00 +0200
Message-Id: <20240422090402.33397-4-f.suligoi@asem.it>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240422090402.33397-1-f.suligoi@asem.it>
References: <20240422090402.33397-1-f.suligoi@asem.it>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 22 Apr 2024 09:04:08.0964 (UTC)
 FILETIME=[091A4C40:01DA9494]
X-Smtpcorp-Track: ylXavbU19F7Y.qZDACkiKWoQ7.cX8RwAcEnP2
Feedback-ID: 1174574m:1174574aXfMg4B:1174574s9VjVG4CTv
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>

Strict priority for the tx scheduler is by default in Linux driver, so the
tx-sched-sp property was removed in commit aed6864035b1 ("net: stmmac:
platform: Delete a redundant condition branch").

So we can safely remove this property from this device-tree.

Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
---

v3 - Removed the tag "Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>"
     (it was added by mistake).
     Added history, as well as in the cover-letter.
v2 - This patch is the 2nd version of a previous patch, where both the DTS
     and the yaml files were included toghether. Then I split this 1st patch
     series in two, as suggested by Krzysztof.
v1 - Original version of the patch where, in addition to this DTS patch,
     there was also the one related to the correspondent snps,dwmac.yaml
     dt_binding file.

 arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
index faa17cbbe2fd..21d4b6a9a1af 100644
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


