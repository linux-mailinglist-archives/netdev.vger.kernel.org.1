Return-Path: <netdev+bounces-92066-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F012E8B5438
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 11:27:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E7C2B20BD4
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 09:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B47F6224EA;
	Mon, 29 Apr 2024 09:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smtpcorp.com header.i=@smtpcorp.com header.b="us5Ie726";
	dkim=pass (2048-bit key) header.d=asem.it header.i=@asem.it header.b="Cghz4bEJ"
X-Original-To: netdev@vger.kernel.org
Received: from e2i187.smtp2go.com (e2i187.smtp2go.com [103.2.140.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0091118D
	for <netdev@vger.kernel.org>; Mon, 29 Apr 2024 09:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.2.140.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714382846; cv=none; b=B49tPbnbtqWzWx+fdKAAmgYC+W2ZV7svi3qtv+pZ0Dl5TMpQZJ1ewfTXWJttep9SWWuDxVu/AV6Ufg6xrk98nxfEoS2BkHpD7NziHMCvnSluRC3PNim+VD27qj9uoCXVetktMh08CxaZmIKt0bqAgQhfl+zAQT7+Ao5Ko8LqB9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714382846; c=relaxed/simple;
	bh=PeIo8633KxMCicFSGbU5eN9BSne6OhoxkH2gFHVl+WI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FIVjO7OegFiPTGA+C00zKB/xftbGC2j2Q60SA8KZqU1p0UUJ00bWYbGa4PqNmuPAnVBXW9sBOGl0sVHVYEWWagXAA/rTqUdv07qC6bsSb4Ca8E1HcEtf3xhRCcsZSvyq6rOKkS4hLQbAS/RGrNKlJbUNj2eX36AJkcVxKWZWnB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asem.it; spf=pass smtp.mailfrom=em1174574.asem.it; dkim=pass (2048-bit key) header.d=smtpcorp.com header.i=@smtpcorp.com header.b=us5Ie726; dkim=pass (2048-bit key) header.d=asem.it header.i=@asem.it header.b=Cghz4bEJ; arc=none smtp.client-ip=103.2.140.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asem.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em1174574.asem.it
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpcorp.com; s=a1-4; h=Feedback-ID:X-Smtpcorp-Track:Message-Id:Date:
	Subject:To:From:Reply-To:Sender:List-Unsubscribe;
	bh=/jnzyymWoI0n+E9HMAHvZ+vi8662r/KZP+FVgSW63Ds=; b=us5Ie726uNE2ne1qXT7Vyhgmov
	Aa6//fkgXvTIMjHedgmgivzjzWtdyAHlfK5wejW4x6wbLFU7GudOylS6zKHxsXN91UqMyK6IZrena
	1lmAClg9idRmI88XTSyaMsjExFgl+bM1nDE1D0Uqp/gNWq5SDt1DU7LNTy9FExcPR1/7RFfHhK5tp
	SAh1TftHWJztDVUQ3UuVq02XbPxTufXi3j4JymEn/EWC7fsut9L8iL5tvQqFO+AHdWApDPWGdW9eO
	CAC2cko+e9yYmf7SQp/Daa6Mvm/455EcQL2SuM0CjXml21iD3MW/T7IttRdRRgokvpa39vYZD/p7C
	bRzPy/jw==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=asem.it;
 i=@asem.it; q=dns/txt; s=s1174574; t=1714382844; h=from : subject : to
 : message-id : date; bh=/jnzyymWoI0n+E9HMAHvZ+vi8662r/KZP+FVgSW63Ds=;
 b=Cghz4bEJVqkAix6371reZzA6EpDhz6e4Oc49sx7sPh/qgAmid/Fnd+95yTlm3Gzf5lMCc
 d42CLZatwMGtBmlu1/fs18wpvxMc47xC/5jgmF9G+8cJz34RwaPLOl7guIwdZuzO13XI2Mt
 720GpDo8lhj4IQpBHUa5b5u9oa3HEBWwpiCDKUUr3zCyqCPEFVQzNSQMFUzwxCY9f/SWa+X
 eXECWPtOTF0IyALBeEWXwxpuzlxMiKHlFv3JKE7iSzcjxd+0zF4bcGN+ZJPXYWikW0xCJCl
 ZawdSbw5qZPCTCrqBO8Qc+ClfaF4cjb793D4zbmdQkFyHMmtn0EaCSPhb8Sw==
Received: from [10.45.79.114] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <f.suligoi@asem.it>)
 id 1s1NI9-Y8PKfn-Go; Mon, 29 Apr 2024 09:27:21 +0000
Received: from [10.86.249.198] (helo=asas054.asem.intra)
 by smtpcorp.com with esmtpa (Exim 4.97-S2G)
 (envelope-from <f.suligoi@asem.it>) id 1s1NI8-FnQW0hPkfet-LMc9;
 Mon, 29 Apr 2024 09:27:20 +0000
Received: from flavio-x.asem.intra ([172.16.18.47]) by asas054.asem.intra with
 Microsoft SMTPSVC(10.0.14393.4169); Mon, 29 Apr 2024 11:27:18 +0200
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
Subject: [PATCH net-next v3 0/1] dt-bindings: net: snps,
 dwmac: remove tx-sched-sp property
Date: Mon, 29 Apr 2024 11:26:53 +0200
Message-Id: <20240429092654.31390-1-f.suligoi@asem.it>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 29 Apr 2024 09:27:18.0342 (UTC)
 FILETIME=[6E20CE60:01DA9A17]
X-Smtpcorp-Track: 0T_dL25ji5TB.fY1hL600-kD9.Ol9Hcgqy7Bh
Feedback-ID: 1174574m:1174574aXfMg4B:1174574sSVfFvi59V
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>

Strict priority for the tx scheduler is by default in Linux driver, so the
tx-sched-sp property was removed in commit aed6864035b1 ("net: stmmac:
platform: Delete a redundant condition branch").

This property is still in use in the following DT (and it will be removed
in a separate patch series):

- arch/arm64/boot/dts/freescale/imx8mp-beacon-som.dtsi
- arch/arm64/boot/dts/freescale/imx8mp-evk.dts
- arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
- arch/arm64/boot/dts/qcom/sa8540p-ride.dts
- arch/arm64/boot/dts/qcom/sa8775p-ride.dts

There is no problem if that property is still used in the DTs above,
since, as seen above, it is a default property of the driver.

v3 - Added history in the patch, as well as in the cover-letter.
   - Add "Acked-by: Adam Ford <aford173@gmail.com>".
v2 - This patch is the 2nd version of a previous patch series, where both
     the DTS and the yaml files were included toghether. Then I split this
     1st patch series in two, as suggested by Krzysztof.
   - Add "Acked-by: Krzysztof Kozlowski <krzk@kernel.org>".
v1 - Original version of the patch series, including, in addition to this
     patch, also other five DTS patches, in which the property
     "snps,tx-sched-sp" appeared.

Flavio Suligoi (1):
  dt-bindings: net: snps,dwmac: remove tx-sched-sp property

 .../devicetree/bindings/net/snps,dwmac.yaml        | 14 --------------
 1 file changed, 14 deletions(-)

-- 
2.34.1


