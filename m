Return-Path: <netdev+bounces-98465-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E93D18D1844
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 12:17:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 230041C22BF0
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 10:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4516916C44D;
	Tue, 28 May 2024 10:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smtpcorp.com header.i=@smtpcorp.com header.b="hxAJPure";
	dkim=pass (2048-bit key) header.d=asem.it header.i=@asem.it header.b="g8IJ0b2R"
X-Original-To: netdev@vger.kernel.org
Received: from e2i187.smtp2go.com (e2i187.smtp2go.com [103.2.140.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95BB716B753
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 10:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.2.140.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716891390; cv=none; b=Wh6pEyyzbHqDoyUYhlrBBWIbocV0caQ1VvoQwrFA84RjVoTRU6CXDNiQf33+MaPmazlAuMgeF90ewalu/OgekZpcWW4szxrCNs85d6XHN1EedxRM14EmS4P/BvPubkBmoU/6iN+C6S1BcUPnxWob5zES0wga/i79fzQ+KUHMf2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716891390; c=relaxed/simple;
	bh=5F+iDYpbnmnqiU4VSKO2K0zkALQApme+Wow4A9DBOo0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sCeSYuU+omq33vUcvn4yLlKcWaYLppo4GKhroWPyLtGqv6QO2YVXRRfVpROz1rwfbAB+K7FRc09URZETVW6opGdOoF1+PbvVwymnUqQRjBNgFcNKNRWf8EjQ7fPLxL7ErCw/TB/fF8ORX9kp1vGCui68xokev2vKS+ND2HkUeJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asem.it; spf=pass smtp.mailfrom=em1174574.asem.it; dkim=pass (2048-bit key) header.d=smtpcorp.com header.i=@smtpcorp.com header.b=hxAJPure; dkim=pass (2048-bit key) header.d=asem.it header.i=@asem.it header.b=g8IJ0b2R; arc=none smtp.client-ip=103.2.140.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asem.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em1174574.asem.it
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpcorp.com; s=a1-4; h=Feedback-ID:X-Smtpcorp-Track:Message-Id:Date:
	Subject:To:From:Reply-To:Sender:List-Unsubscribe:List-Unsubscribe-Post;
	bh=oa6h68qDDGHy9Qw+YR/L3ULv9tToF4ZR16++RM2seHg=; b=hxAJPureUjtNeU/zcfTATX+YjL
	mw5JY75O00fPG0NTw2QYpf0Wd3zZUX15YChtYbyJ6OIMdhWZXOS/4dgIsoVOgGsDwIiFdRO5OqFFa
	DaLIq18S+ahUwYNSnCStgV1pi+xkduzHJL1GD7a9PfSEV4ntp5XU7+pgzceQc0j1syaXXr+xL0S8c
	mhxQ117fnXAga+WIOfRr6+mBMJ8q/xfRY+DfST53TnJhh6Ne8IKc25uFA3B3hmogM00uexmx4cnnY
	Q0mC4+rcRKrQvbSmQz7wc60ob+tRBg1OAl1lJDOmm1aZ18cl2cvKYkxm8Z/TkBmAJ6SareVsWb1Qc
	hzLttwGg==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=asem.it;
 i=@asem.it; q=dns/txt; s=s1174574; t=1716891388; h=from : subject : to
 : message-id : date; bh=oa6h68qDDGHy9Qw+YR/L3ULv9tToF4ZR16++RM2seHg=;
 b=g8IJ0b2RnNnm/jOAPNczKMzI0yGWua6mu7peNiZiNhkcudBtw7Ov2XhtmGbATlME6N/OV
 vcyVNwSpAA4secrK20z6xpRY9wZtZC93fZEM+7/l78ZiR2JBc+AS4+SC67HYrKrvWXTW6im
 rIcD984PaQTalUGqRzDTj7Ib21kuBNvxD3rPi1JJn/ZZvKQZPlmYzuFSxvIPMWmlAP+NEU4
 Q54EsPxnRuL4NhMiNyBmTT8gCozW7FVIXXiA+T7+JjLYISAAz5iVnYqCWFlKiBQkixcpfnp
 IxM9cYs6fgzKWavqXxfeJX2C4DdWQhFlsBY9exIr0gG7MJLfhqEtMbIZ14lg==
Received: from [10.45.56.87] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <f.suligoi@asem.it>)
 id 1sBtsY-Y8PCtQ-Ux; Tue, 28 May 2024 10:16:26 +0000
Received: from [10.86.249.198] (helo=asas054.asem.intra)
 by smtpcorp.com with esmtpa (Exim 4.97-S2G)
 (envelope-from <f.suligoi@asem.it>) id 1sBtsW-FnQW0hPuHwL-fPMb;
 Tue, 28 May 2024 10:16:25 +0000
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
 linux-kernel@vger.kernel.org, Flavio Suligoi <f.suligoi@asem.it>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 5/5] arm64: dts: qcom: sa8775p-ride: remove tx-sched-sp
 property
Date: Tue, 28 May 2024 12:15:53 +0200
Message-Id: <20240528101553.339214-6-f.suligoi@asem.it>
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
X-OriginalArrivalTime: 28 May 2024 10:16:14.0341 (UTC)
 FILETIME=[12197350:01DAB0E8]
X-Smtpcorp-Track: MNdoBk2fGo78.9CDehDn3zfds.E3UoIQ_B9qR
Feedback-ID: 1174574m:1174574aXfMg4B:1174574sUnubbTcW2
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>

Strict priority for the tx scheduler is by default in Linux driver, so the
tx-sched-sp property was removed in commit aed6864035b1 ("net: stmmac:
platform: Delete a redundant condition branch").

So we can safely remove this property from this device-tree.

Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---

v4 - Resend after some weeks.
     Added the tag "Reviewed-by: Krzysztof Kozlowski
     <krzysztof.kozlowski@linaro.org>"
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


