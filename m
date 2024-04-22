Return-Path: <netdev+bounces-90013-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B23A18AC85D
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 11:05:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6722D1F217EE
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 09:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E62385579A;
	Mon, 22 Apr 2024 09:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smtpcorp.com header.i=@smtpcorp.com header.b="cmZ1zD7L";
	dkim=pass (2048-bit key) header.d=asem.it header.i=@asem.it header.b="ZjiEvEjn"
X-Original-To: netdev@vger.kernel.org
Received: from e2i187.smtp2go.com (e2i187.smtp2go.com [103.2.140.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79802140365
	for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 09:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.2.140.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713776678; cv=none; b=hvtpI4/wJp01yLXkPmk+qQx1SCVJd9GzJA7ym6rKFr8sYm081O3JNZ/IGKR25Uyg5U7dcjKnwIoLZplMK7JK/PG2ce9b6DkaObz0dtxmxcRQySSv743h227MKWXOoahKk2erB4vg26mvC5j4uwvAys9YlsP5ZQBwFwJ4BE6O7eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713776678; c=relaxed/simple;
	bh=YhE8qxmtx9VsAQdA927K/LfjbzSzYqjoVBsHAjnTLis=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G4PjwgwqjqygzHw4QqZ3pa95yiIBOAHxKuHEuyc2pgjF/paNKXAUUXjYMhfA6PKASrSey1ZhjmmcEST7GUxoZRFs2JQuzcbKkLMsDa30X98kv/0QeNxOdfLiXoFgoOnUm61oivzcnyMywEtrRWyoWP5REtFFsupo+ypk16mt5Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asem.it; spf=pass smtp.mailfrom=em1174574.asem.it; dkim=pass (2048-bit key) header.d=smtpcorp.com header.i=@smtpcorp.com header.b=cmZ1zD7L; dkim=pass (2048-bit key) header.d=asem.it header.i=@asem.it header.b=ZjiEvEjn; arc=none smtp.client-ip=103.2.140.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asem.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em1174574.asem.it
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpcorp.com; s=a1-4; h=Feedback-ID:X-Smtpcorp-Track:Message-Id:Date:
	Subject:To:From:Reply-To:Sender:List-Unsubscribe;
	bh=6xxT4AnGOT/oiwLV/mUq6t1GblNvqgs6p8n35GukuSU=; b=cmZ1zD7LDA4NhFK57yKsy3aOX2
	p5lUgabVLmGBKw3bawckkXhRqWMSymKW+n0/xCpXJsNGNpgCWD6bbK3TR9T5OuD+NsLRa1D4l+s3e
	zRV09J9vZYqPeYjw8xm9sQjyu1bRlLEBhWTTOLb+bWHt6bzJyP43vlmwCFTVl1vmFrIBitr3qykKJ
	TJaa6kW7LXn9CxTGyE0fxf5B4q1cPB4O+MQNIhM18xjWTfinDyZkZeaxid5Qvs3ho1OSeJFIwRk+B
	APLnqd/lOwp/FpRD4BAyA8GF2tGL2QXw0AFYQ6DYCBAZcOkvzuCwGU1axT4G4PfbvKdlPWANOWYe3
	IdH1UkbQ==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=asem.it;
 i=@asem.it; q=dns/txt; s=s1174574; t=1713776653; h=from : subject : to
 : message-id : date; bh=6xxT4AnGOT/oiwLV/mUq6t1GblNvqgs6p8n35GukuSU=;
 b=ZjiEvEjn/w6zUeDYerfK3nyWjCeft7s/iUuZjzEtEysUDT1YrUIYQdcxttmiKm7ZyaJ2R
 p55/U6YmlrdG1XvmNR6YfDnxLdtCqCLNovWOdDi9FO8ojMHKW6nKSm2Spuh7zovcdgEGSyx
 DXTUQmXTrg7XfLwwbzIWDX4cvyOvIpDWlOK5Zrgop2sni4h7CrdZe8VCge7LI+ULOCC2I5j
 GI+Bed1MlcwTRw0WSmR6+KxQ2ixIDzsU74JvBPmCtQcYcOFy6d0NjGnlfHcculhkZ9FF+oH
 kuwDCjjmdXNmFJ54NJRdedJLVSDBrLAQH7w3ePNVdEBpZCmwPkqw7GuZejIA==
Received: from [10.143.42.182] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <f.suligoi@asem.it>)
 id 1rypat-Y8PDvh-8B; Mon, 22 Apr 2024 09:04:11 +0000
Received: from [10.86.249.198] (helo=asas054.asem.intra)
 by smtpcorp.com with esmtpa (Exim 4.97-S2G)
 (envelope-from <f.suligoi@asem.it>) id 1rypas-FnQW0hPpvx6-he9B;
 Mon, 22 Apr 2024 09:04:10 +0000
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
Subject: [PATCH v3 1/5] arm64: dts: freescale: imx8mp-beacon: remove
 tx-sched-sp property
Date: Mon, 22 Apr 2024 11:03:58 +0200
Message-Id: <20240422090402.33397-2-f.suligoi@asem.it>
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
X-OriginalArrivalTime: 22 Apr 2024 09:04:08.0808 (UTC)
 FILETIME=[09027E80:01DA9494]
X-Smtpcorp-Track: 4RRjp2yweKZL.a_O2J4Vr_ndX.CMxMNQH9LGo
Feedback-ID: 1174574m:1174574aXfMg4B:1174574seGOAHZBY8
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


