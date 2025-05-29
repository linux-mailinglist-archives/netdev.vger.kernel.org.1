Return-Path: <netdev+bounces-194222-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02EF4AC7F72
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 16:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1A941BC0C3D
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 14:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D0591DE2A7;
	Thu, 29 May 2025 14:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="JctV4H9W"
X-Original-To: netdev@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FA81C84C0
	for <netdev@vger.kernel.org>; Thu, 29 May 2025 14:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748527339; cv=none; b=djXDT0cAcDnxLmbvdFDSedmxtZPLcy/UTFd0oejGmhxUr14taci+D7utY8uYpsc6DATSPTxLMGDcAvLAo5usVWNlp8T7dXsf44VTDf4gao20APL4dk0ZXEaOdQ74RMxGV/T2T6DwrkDpRtpQew7gVm+57HUpinNIbZuy0Fh2HDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748527339; c=relaxed/simple;
	bh=O2kt59pmSzyMddcWtLo0uEqm98Hfb/zrmOagMncxUec=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=CNNMT+VNkp3eOXqD9v1UtWj2U3R64xClP4ep7IBeFM5VpodyaRqf01wdFHYgv2WFSdEp9Pxd6RZil7CmRvBJGlXL4FRzU7BRs65mym5cYUwdGHyo0hCGNBq8gXQa0xYQ6bMJAgLcVI3LvS/NH9iko8Jjamq5ypT83HQejA395S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=JctV4H9W; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250529140215epoutp0375dded17099b4e4a8fdde86c8fe97836~EBFkENrOZ0428004280epoutp03n
	for <netdev@vger.kernel.org>; Thu, 29 May 2025 14:02:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250529140215epoutp0375dded17099b4e4a8fdde86c8fe97836~EBFkENrOZ0428004280epoutp03n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1748527335;
	bh=ngz82wMOl5404DyPdkqsVuyRGZZ/f6A/F2lmTRxHH5c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JctV4H9WIHZaiqKzwpzJkSTxTy3of+wwR1rkobpUnWdnRlHZ6WKEfX5Wq0EYkAJrp
	 8QSPdYwLQa0fhJ5+vUsHj6IlqntOhXtkQa7lroAokCnC1DLYaT46yESVFsGRqqE87K
	 w4QygLG4XXFmbt4pCxrLXqdekRe74/nOiZfwIprc=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20250529140214epcas5p4b30a94fef30da102d97ceddd87383af3~EBFjSxnZv3230132301epcas5p4x;
	Thu, 29 May 2025 14:02:14 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.182]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4b7Sjc5jNrz3hhT3; Thu, 29 May
	2025 14:02:12 +0000 (GMT)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20250529111708epcas5p232b8bb6b05795b7014d718003daef0cb~D_1ZpDcMz3240232402epcas5p2I;
	Thu, 29 May 2025 11:17:08 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250529111708epsmtrp2a3d44bba823829fe1e9b4d8af762493e~D_1ZnbkkW2239822398epsmtrp2k;
	Thu, 29 May 2025 11:17:08 +0000 (GMT)
X-AuditID: b6c32a28-46cef70000001e8a-1b-68384234d330
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	72.BF.07818.43248386; Thu, 29 May 2025 20:17:08 +0900 (KST)
Received: from bose.samsungds.net (unknown [107.108.83.9]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250529111705epsmtip1663cf218914df0b247f64e91ac67fbdf~D_1W5MQW61843718437epsmtip1k;
	Thu, 29 May 2025 11:17:05 +0000 (GMT)
From: Raghav Sharma <raghav.s@samsung.com>
To: krzk@kernel.org, s.nawrocki@samsung.com, cw00.choi@samsung.com,
	alim.akhtar@samsung.com, mturquette@baylibre.com, sboyd@kernel.org,
	robh@kernel.org, conor+dt@kernel.org, richardcochran@gmail.com,
	sunyeal.hong@samsung.com, shin.son@samsung.com
Cc: linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	chandan.vn@samsung.com, karthik.sun@samsung.com, dev.tailor@samsung.com,
	Raghav Sharma <raghav.s@samsung.com>
Subject: [PATCH v3 1/4] dt-bindings: clock: exynosautov920: sort clock
 definitions
Date: Thu, 29 May 2025 16:56:37 +0530
Message-Id: <20250529112640.1646740-2-raghav.s@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250529112640.1646740-1-raghav.s@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAIsWRmVeSWpSXmKPExsWy7bCSnK6Jk0WGwaV9+hYP5m1js5jwJcJi
	zd5zTBbXvzxntbi3Yxm7xfwj51gtGme8YbI4f34Du8Wmx9dYLT723GO1uLxrDpvFjPP7mCwu
	nnK1OLZAzOL7yjuMFkfOvGC2+L9nB7vF4TftrBb/rm1ksZh8fC2rRdOy9UwOoh7vb7Sye+yc
	dZfdY9OqTjaPzUvqPfq2rGL0+LxJLoAtissmJTUnsyy1SN8ugStj0dq9TAUTuSo2ve1jamDc
	xNHFyMkhIWAisf7YfeYuRi4OIYHdjBJPdp9lh0hISOz7/5sRwhaWWPnvOTtE0VtGiaetu8AS
	bAJaEle2v2MDSYgIdDFJnPv3igXEYRbYySTR9ngb2ChhgSCJfxeug3WwCKhK/J/7mQnE5hWw
	lli7sY0JYoW8xP6DZ5lBbE4BG4m7N5+zgNhCQDUft59hhqgXlDg58wlYnBmovnnrbOYJjAKz
	kKRmIUktYGRaxSiZWlCcm56bbFhgmJdarlecmFtcmpeul5yfu4kRHGlaGjsY331r0j/EyMTB
	eIhRgoNZSYS3yd4sQ4g3JbGyKrUoP76oNCe1+BCjNAeLkjjvSsOIdCGB9MSS1OzU1ILUIpgs
	EwenVAOTz9r8mhcXlc77nT2coGF5uruSmUvyD6vPjAet5R/ZOh32HVSI23wkRX0R8wfdxpUn
	89PuT4k9+Cr13hntC+0efYcYPj1ou6mwOvxi+2fD+YFPAjKS7+x9f3/ZpHk1a25fOrr5/EpB
	4y1dKxc9ii19vvYD/00hh8LyrD9/5kj7Zl1u//VnVR/rX5+w6DXVBz4vu1nv8nDNRtnjb7VW
	PJ0pkrhZ4KDJpqTWXXbm+aJlW7rz+aOtdsb1+fz8HNBS+F3SUOvvzw8CTntWzdyi1rfnhsPn
	SR3n/76aqJfixTPv4lPV4z9quz7VONWEdmo4akx8nb3lj6G0PvOhw6kJAZc4k53Ea1MelRxZ
	yPjbJiaZR4mlOCPRUIu5qDgRALd3VcsjAwAA
X-CMS-MailID: 20250529111708epcas5p232b8bb6b05795b7014d718003daef0cb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-543,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250529111708epcas5p232b8bb6b05795b7014d718003daef0cb
References: <20250529112640.1646740-1-raghav.s@samsung.com>
	<CGME20250529111708epcas5p232b8bb6b05795b7014d718003daef0cb@epcas5p2.samsung.com>

Sort all the clock compatible strings in alphabetical order

Signed-off-by: Raghav Sharma <raghav.s@samsung.com>
---
 .../bindings/clock/samsung,exynosautov920-clock.yaml      | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/samsung,exynosautov920-clock.yaml b/Documentation/devicetree/bindings/clock/samsung,exynosautov920-clock.yaml
index 6961a68098f4..77117b887e19 100644
--- a/Documentation/devicetree/bindings/clock/samsung,exynosautov920-clock.yaml
+++ b/Documentation/devicetree/bindings/clock/samsung,exynosautov920-clock.yaml
@@ -32,15 +32,15 @@ description: |
 properties:
   compatible:
     enum:
-      - samsung,exynosautov920-cmu-top
       - samsung,exynosautov920-cmu-cpucl0
       - samsung,exynosautov920-cmu-cpucl1
       - samsung,exynosautov920-cmu-cpucl2
-      - samsung,exynosautov920-cmu-peric0
-      - samsung,exynosautov920-cmu-peric1
-      - samsung,exynosautov920-cmu-misc
       - samsung,exynosautov920-cmu-hsi0
       - samsung,exynosautov920-cmu-hsi1
+      - samsung,exynosautov920-cmu-misc
+      - samsung,exynosautov920-cmu-peric0
+      - samsung,exynosautov920-cmu-peric1
+      - samsung,exynosautov920-cmu-top
 
   clocks:
     minItems: 1
-- 
2.34.1


