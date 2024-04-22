Return-Path: <netdev+bounces-90016-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D70738AC862
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 11:06:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E9AB1F2174B
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 09:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A49B13FD7D;
	Mon, 22 Apr 2024 09:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smtpcorp.com header.i=@smtpcorp.com header.b="KnOgOpJh";
	dkim=pass (2048-bit key) header.d=asem.it header.i=@asem.it header.b="nW9WIJ1/"
X-Original-To: netdev@vger.kernel.org
Received: from e2i187.smtp2go.com (e2i187.smtp2go.com [103.2.140.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB3213E03D
	for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 09:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.2.140.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713776680; cv=none; b=mv+7N9gJxvhHnqxKNIMjXqhV5EalY2+BdsE9ZfI6CmXiFFk+RR1vu2DT6x+tKEfdwB833XAbhYCrGNJaaTznn1oURZ/t5sOS66ATqg93GnJ5guYy6FpnIET7NpjUd6fvnIUB002ee00jq2zhp9hqby/vmWiWPlXg5Swm1DG2LCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713776680; c=relaxed/simple;
	bh=vr3mP70Ml+CTsiCqXFkvm+bmpkhuQn6pWYBnGDF4u1I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t/9KSxsBZ0E2rt+ixi0XI4Y0mHcnLVKfM2HyJSzfdb83la3y3opkyxx31Tmcnr1ULE21UZUAz7k80p2uXWqGmmlDHO4LpHK2Ff3OzbWR2QUILouO729JmsyK8zsjObScTONwxENjLlL3UnQzoTmgiVDkG1AxuMe2KgGUB7EGXSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asem.it; spf=pass smtp.mailfrom=em1174574.asem.it; dkim=pass (2048-bit key) header.d=smtpcorp.com header.i=@smtpcorp.com header.b=KnOgOpJh; dkim=pass (2048-bit key) header.d=asem.it header.i=@asem.it header.b=nW9WIJ1/; arc=none smtp.client-ip=103.2.140.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asem.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em1174574.asem.it
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpcorp.com; s=a1-4; h=Feedback-ID:X-Smtpcorp-Track:Message-Id:Date:
	Subject:To:From:Reply-To:Sender:List-Unsubscribe;
	bh=QgmQ2Gqg/9Dc9h8gAthGPlmhLJ1iqOTv73ICctSoMIU=; b=KnOgOpJhBScr7wA54sbUjFmoh3
	0cC4ls+jOZW0q5wjBX292u/MptbUHpDTyjpA/aBOPYqs7ymEFW0h3L6GXtP/L0VgN0Sg7qMRrFENV
	/evBB1ccaN3NIuCMbRYMadRpwa30gP6g9Ubv3LVKV3/pgiC/1wAVgqDz5XfiVk/O2p/hj/W/LMjp+
	5zN4Xp8vkXOVtgKmmkV4mXLbMEMmOFeHQuQw60/Bm38eEgawsF1bI44qgQu4aCWkoZ8RGAxhH+3W7
	4c7g1DosTRb2ISRznLrYtG/dgCXgDVL5YR5D2Z9sQOHZ0XShMJ14cdvqmLCWdGMDdA9Cyakii22Il
	5PqL8rEg==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=asem.it;
 i=@asem.it; q=dns/txt; s=s1174574; t=1713776655; h=from : subject : to
 : message-id : date; bh=QgmQ2Gqg/9Dc9h8gAthGPlmhLJ1iqOTv73ICctSoMIU=;
 b=nW9WIJ1/zEUa1nlhr6KtrCc65Wsqkp6cpIwFQEio26iB1LgBZ32DppHUsIwDnIoJgldip
 ZgBK9ZAhmFs6sOXWELBGH42Clsl1B8TQHNQn9xoC2/WZJ479yH8cGyBwMz3CwH8KVpVj224
 cC5omgd2yD1Qh1VAfjSFb+fNE8cQawyme+yjfvCTXXUMPOrKSEyCB8W1yPlH35reCr29oTa
 WemesYEUdQ8vMQALFPbsbyOK8BDSqpOvw8m1b0C3s6bixgvAg8CvyML3cD4QtOAZ8SikPxT
 ehV+WI0nkGfAFrZ6nnpgZxf3KXvgTZdGmlidXjEh8sW3nOj3V9GE8eN0MS2g==
Received: from [10.143.42.182] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <f.suligoi@asem.it>)
 id 1rypav-Y8PE4i-Cc; Mon, 22 Apr 2024 09:04:13 +0000
Received: from [10.86.249.198] (helo=asas054.asem.intra)
 by smtpcorp.com with esmtpa (Exim 4.97-S2G)
 (envelope-from <f.suligoi@asem.it>) id 1rypau-FnQW0hPpvx6-iJmZ;
 Mon, 22 Apr 2024 09:04:12 +0000
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
Subject: [PATCH v3 5/5] arm64: dts: qcom: sa8775p-ride: remove tx-sched-sp
 property
Date: Mon, 22 Apr 2024 11:04:02 +0200
Message-Id: <20240422090402.33397-6-f.suligoi@asem.it>
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
X-OriginalArrivalTime: 22 Apr 2024 09:04:08.0995 (UTC)
 FILETIME=[091F0730:01DA9494]
X-Smtpcorp-Track: zUp79NGZ1B57.gYJZroMy5d0s.ss699wuhzRr
Feedback-ID: 1174574m:1174574aXfMg4B:1174574sM5RhJVoQE
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


