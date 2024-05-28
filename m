Return-Path: <netdev+bounces-98462-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EED08D183F
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 12:16:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17217283A50
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 10:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B7DC15E96;
	Tue, 28 May 2024 10:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smtpcorp.com header.i=@smtpcorp.com header.b="IZJxeY+8";
	dkim=pass (2048-bit key) header.d=asem.it header.i=@asem.it header.b="fRRYK/dG"
X-Original-To: netdev@vger.kernel.org
Received: from e2i187.smtp2go.com (e2i187.smtp2go.com [103.2.140.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C34B13C80E
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 10:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.2.140.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716891386; cv=none; b=ZcRvZJ0R2vVEz6XOEYWIRnB+h8siWeK1fnTpYz4Awyw7Y3W23MY5uQ2hRI/5g1FRcgua2dUa0H00KwZ2jUwY63NW3q2m+gjt7qA0naDaC4+jlmd8SfwDj6t8fXy62AMrgzFu+FpVUu4yNv0XtZpoq7fT6y/ydAOojC/qzM5jI5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716891386; c=relaxed/simple;
	bh=tXx6p7BbCuL55D0qt9hWOFE+RgKNnMzF+7tb9TnuI98=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sPgFrduljSJxa947FWcZqI5dINnvvCDaTv6UBh5wtRFIJz2yhH9aM6OshWA+gyZY/qrA7BSWTB8xr3LH+oh0CSnu1gj1JMYC7ddIw8EtjO8BY+bnGPASjd/ON8m45T0CWwu4cA0MC3CTh5fnRrQqZtCY4LNhzyCyEk9bjO7h9CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asem.it; spf=pass smtp.mailfrom=em1174574.asem.it; dkim=pass (2048-bit key) header.d=smtpcorp.com header.i=@smtpcorp.com header.b=IZJxeY+8; dkim=pass (2048-bit key) header.d=asem.it header.i=@asem.it header.b=fRRYK/dG; arc=none smtp.client-ip=103.2.140.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asem.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em1174574.asem.it
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpcorp.com; s=a1-4; h=Feedback-ID:X-Smtpcorp-Track:Message-Id:Date:
	Subject:To:From:Reply-To:Sender:List-Unsubscribe:List-Unsubscribe-Post;
	bh=BBch9oN1usl9P0mIN17UyeXOwYlWmbIz0xSKtVbo3H4=; b=IZJxeY+8ei8ZLDfIISvbeeGAmh
	SyMuXWuD8KXhTEXzlkT+aduSjI+QFNMSb4t8uFBoUCzPafNlnSHGzyjtdyYDZISz/85J7eWO/g0h7
	F7U4llcXuHPGAGTKLM3CN8tOYajc+oqA577YPu0bkvqaoZJwkJeVNcxxeER7XjuGsT+TFnPFeR8ES
	MCnEBCs6llXR8OjxaPoLC9YO0n4He6C98N/svJPg+pUfs+6ZykdeBok1dlN3/RuSMhCPcCy8lUVfO
	axDRkp6IIzPVdcFMvXvNYWWy5chHOd7mQzeNMMmPYM7AvhvdzDvTOlfHF9uPlNT1eh/H3X0DC/XVt
	QytVPD8w==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=asem.it;
 i=@asem.it; q=dns/txt; s=s1174574; t=1716891384; h=from : subject : to
 : message-id : date; bh=BBch9oN1usl9P0mIN17UyeXOwYlWmbIz0xSKtVbo3H4=;
 b=fRRYK/dG9jSW3h5ANrqWAXekLC7K9/oQLOF1ICidBTAlw3G0qht4CxT7JH7/l/FjBl5FW
 xo3FcfK/9yu8jlXjwich2LLvjLKIpwHVEMOkWuRwHGMs282bB8uELs6R1cCUJqdFc+K7Ymi
 +9MNrjUBpAV93GerSTf/MJr6M32O/wwJZyt8qX4EXIrexhM6i0Rjy6pV1zQWPIaHezMkIQy
 eg50uEnxIgSf1uHdXjx+/jiW/9LYypRMCXnIZo6BPhgF7dFA+ItpLJTwT089xHUP7miGc4l
 q9ASLlShzX/nO0ZjDdSOcm6XJ9C8muZhl3sXBpxQLU9dDn4ubvKe8tMVC59Q==
Received: from [10.45.56.87] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <f.suligoi@asem.it>)
 id 1sBtsT-Y8PCdf-Vn; Tue, 28 May 2024 10:16:21 +0000
Received: from [10.86.249.198] (helo=asas054.asem.intra)
 by smtpcorp.com with esmtpa (Exim 4.97-S2G)
 (envelope-from <f.suligoi@asem.it>) id 1sBtsR-FnQW0hPuHwL-fOl7;
 Tue, 28 May 2024 10:16:20 +0000
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
Subject: [PATCH v4 2/5] arm64: dts: freescale: imx8mp-evk: remove tx-sched-sp
 property
Date: Tue, 28 May 2024 12:15:50 +0200
Message-Id: <20240528101553.339214-3-f.suligoi@asem.it>
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
X-OriginalArrivalTime: 28 May 2024 10:16:14.0278 (UTC)
 FILETIME=[120FD660:01DAB0E8]
X-Smtpcorp-Track: pjOBmuZ4jah8.aBGpyMXW0J8o.NiikZAFn7zl
Feedback-ID: 1174574m:1174574aXfMg4B:1174574sgakE8KTJm
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
     dt_binding file

 arch/arm64/boot/dts/freescale/imx8mp-evk.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
index 8be5b2a57f27..bb1003363e3e 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
@@ -251,7 +251,6 @@ ethphy0: ethernet-phy@1 {
 
 	mtl_tx_setup: tx-queues-config {
 		snps,tx-queues-to-use = <5>;
-		snps,tx-sched-sp;
 
 		queue0 {
 			snps,dcb-algorithm;
-- 
2.34.1


