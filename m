Return-Path: <netdev+bounces-98463-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2573D8D1840
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 12:16:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80B76B23307
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 10:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6714A16B73C;
	Tue, 28 May 2024 10:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smtpcorp.com header.i=@smtpcorp.com header.b="y4wEn4Zh";
	dkim=pass (2048-bit key) header.d=asem.it header.i=@asem.it header.b="lGOFiqbt"
X-Original-To: netdev@vger.kernel.org
Received: from e2i187.smtp2go.com (e2i187.smtp2go.com [103.2.140.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E85316ABD7
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 10:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.2.140.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716891387; cv=none; b=lcD7bSA+gWLzZa/FjNkWW7gMwgylcUTDofjw01uksXADzIkxvvAWOe8wOSFacNgUlUp3LIv0/cp3KVsjQ/gSadvBnaPBuoXY6s1pC4QskAl0S4sLJxEpPhbMLmCeUMrd2J0fYokUPQAi+KnNH6Ph2iocr+8I86ZB2dom0Oa+vIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716891387; c=relaxed/simple;
	bh=FxzUFMdru4osktFl89QiRJttKIRmQcse+pcZI7VhhWo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GqfDsdj/qCIxA0CwCjCNpPgp78Lrg3mCm3zBW0ZEsZWkDrEInX0uSAtEwxR81P2pQjDznea7IPmsNbojmillylYf6MdFqAmBvVizjDecI4QCXEZANbgXErV6bwFXhuOaeNJPlGbnD8PkVxYerYqvpZeR41/M+VmIFJeIIlUgDzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asem.it; spf=pass smtp.mailfrom=em1174574.asem.it; dkim=pass (2048-bit key) header.d=smtpcorp.com header.i=@smtpcorp.com header.b=y4wEn4Zh; dkim=pass (2048-bit key) header.d=asem.it header.i=@asem.it header.b=lGOFiqbt; arc=none smtp.client-ip=103.2.140.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asem.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em1174574.asem.it
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpcorp.com; s=a1-4; h=Feedback-ID:X-Smtpcorp-Track:Message-Id:Date:
	Subject:To:From:Reply-To:Sender:List-Unsubscribe:List-Unsubscribe-Post;
	bh=WTJGKszru6/8OXc1XDAhsOOFXU+bGmBkM3qo5s6aOGI=; b=y4wEn4Zh616NqlCE/6cN0yWXD8
	+36WJfZl9KMjoY2g8YqYbONQ1DvTdWFUEozF6BH0jBxxS8ka7HTyfH33ZJnp42baKalgvx2CQ/9LY
	KormQYDmx7NxpP23tcoL8sdGLgKo4Dq9h4uw9PxR8vQJRfOGg8eF7whBj62CJHoFow1ObzMPp46Q/
	yvmJW7oGzMJkAUfWvJwswDIVCbrL7N7NYrD04Ls62LKNMdWXMWXwN+YRTrqzLdntpxhOpFCWlInBW
	9hV20FzMyHLumEbrn9p+e1mGjmtetglEpmsjVgUBsbX9Zug9bNUiRiui4xUBv58SxsZhtezgcjwaO
	lG1Wxo5A==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=asem.it;
 i=@asem.it; q=dns/txt; s=s1174574; t=1716891385; h=from : subject : to
 : message-id : date; bh=WTJGKszru6/8OXc1XDAhsOOFXU+bGmBkM3qo5s6aOGI=;
 b=lGOFiqbtXmuUeL3YrGEnWPdpLFpR2zZXET4O/7IeoB4RHHwPfAXNlsgQzlZ4jSR+Ycrxg
 L4tzs4bYCfRKMFRMW8N2ZAtk1k+TTYSoJ/OSwJziqSAe7ArBSVZijymXIbV3MSUcpDQUXWH
 7eIalrypmqCYNKQPZAk5qIUaJkmUsIiaQ/9xSFozYjWUDqihqFYkEax5JQJUi0Wxouc1MDx
 R4fukZBWuI4zIp7BvMnh8WKr6dojIPO6KqJDHGCN4D5B0QWZvtZW5t7cVaRBChZtAgvpZqZ
 UejYZ/r7dFxVUGQT6YqgT+CzxvfUTITYsSH3q/EPnAzs+jyvRCUiEdfXhrFg==
Received: from [10.45.56.87] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <f.suligoi@asem.it>)
 id 1sBtsV-Y8PCjN-MG; Tue, 28 May 2024 10:16:23 +0000
Received: from [10.86.249.198] (helo=asas054.asem.intra)
 by smtpcorp.com with esmtpa (Exim 4.97-S2G)
 (envelope-from <f.suligoi@asem.it>) id 1sBtsT-FnQW0hPuHwL-dxGp;
 Tue, 28 May 2024 10:16:21 +0000
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
Subject: [PATCH v4 3/5] arm64: dts: freescale: imx8mp-verdin: remove
 tx-sched-sp property
Date: Tue, 28 May 2024 12:15:51 +0200
Message-Id: <20240528101553.339214-4-f.suligoi@asem.it>
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
X-OriginalArrivalTime: 28 May 2024 10:16:14.0294 (UTC)
 FILETIME=[12124760:01DAB0E8]
X-Smtpcorp-Track: Qa9Dj7O7rV_V.wTX4R47g5wj4.4z1kqA28Q-D
Feedback-ID: 1174574m:1174574aXfMg4B:1174574s7KWN2naAj
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

 arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
index aef4bef4bccd..222521f116f5 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
@@ -276,7 +276,6 @@ queue4 {
 
 	mtl_tx_setup: tx-queues-config {
 		snps,tx-queues-to-use = <5>;
-		snps,tx-sched-sp;
 
 		queue0 {
 			snps,dcb-algorithm;
-- 
2.34.1


