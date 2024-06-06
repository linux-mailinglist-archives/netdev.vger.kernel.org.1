Return-Path: <netdev+bounces-101346-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62C338FE31A
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 11:38:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 729261C25DF7
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 09:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E6301791ED;
	Thu,  6 Jun 2024 09:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="lDe9iSjY"
X-Original-To: netdev@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA38C17839B
	for <netdev@vger.kernel.org>; Thu,  6 Jun 2024 09:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717666638; cv=none; b=bUvhnFTSqCtEw1pdYfQ69bh9dIZiB05SdYH+4UZRynaiQxZHeYceStn0skBHpEsMokzfmDhkhmPij6NKVxxz8BVwdjTmGNgEEnQUeOruYb74ZwYtrP5TSYFSaJLS+karty8zaSNerA7ghiN5LWU2WVlXoZv/KiV6nGg9da5zzWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717666638; c=relaxed/simple;
	bh=kVV5LyIkN1HBUvZJtL2AaAsVy962XcPeFU3Hzwm0aUs=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=coD4+zFTBSfeoRWkrJAShNot6dA04ffw5OhjD2sunwMZAikZUX1gxRN7iS9CAdrIqEaMtew2YffmyHvxxK9oWEPBVliGGWhRLsTFE7xgvnTTQTQynQYDKiCaJs/MROKrDy8oyOsZEwX7rdrpyVLIf5CW1BrPUVdEtvnKNTG+PWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=lDe9iSjY; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240606093715epoutp02b6b9e64a108d79fd298c735bea608451~WYLRK_AmW1583515835epoutp02w
	for <netdev@vger.kernel.org>; Thu,  6 Jun 2024 09:37:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240606093715epoutp02b6b9e64a108d79fd298c735bea608451~WYLRK_AmW1583515835epoutp02w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1717666635;
	bh=k//rUFK6ioPKyiPWu8vrK3hMgJf+tmmntQhomCJq75E=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=lDe9iSjYRDM4/ZJ4Dkn/zMFq6FdlSG5FzIwzzHsHkq2O7+zzJAEM18jSss2rixQfI
	 04JQuL6GoqxuNtu3o4jC8o6v0XJg2/SJ12f6+Ub0E++RIjNcwmq7G3pBkzpbM7IGb+
	 N2D7PO5aRlgByAZhk9ZGNIDxC+LpF2+Vc67afEFM=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20240606093714epcas5p38a560e8ab7770c88bb1b5c1543b6f240~WYLQeb1uh0034700347epcas5p3b;
	Thu,  6 Jun 2024 09:37:14 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.176]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4Vvzkc63K7z4x9Pt; Thu,  6 Jun
	2024 09:37:12 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	3A.9F.10035.84381666; Thu,  6 Jun 2024 18:37:12 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20240606091616epcas5p4806885e4893357ddf8d231ae045a5efc~WX48mSDif1383013830epcas5p40;
	Thu,  6 Jun 2024 09:16:16 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240606091616epsmtrp1cf324bd16ddeb63e9659d90ec2a81c32~WX48lLBh52458024580epsmtrp1w;
	Thu,  6 Jun 2024 09:16:16 +0000 (GMT)
X-AuditID: b6c32a4b-8afff70000002733-19-666183481fa8
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	9E.89.08336.06E71666; Thu,  6 Jun 2024 18:16:16 +0900 (KST)
Received: from FDSFTE596 (unknown [107.122.82.131]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20240606091612epsmtip17f4f85cdc23f67a787eeaf619af8fe2d~WX45BtATA0216002160epsmtip1U;
	Thu,  6 Jun 2024 09:16:12 +0000 (GMT)
From: "Swathi K S" <swathi.ks@samsung.com>
To: "'Andrew Lunn'" <andrew@lunn.ch>, "'Sriranjani P'"
	<sriranjani.p@samsung.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<richardcochran@gmail.com>, <alexandre.torgue@foss.st.com>,
	<joabreu@synopsys.com>, <mcoquelin.stm32@gmail.com>,
	<alim.akhtar@samsung.com>, <linux-fsd@tesla.com>,
	<pankaj.dubey@samsung.com>, <ravi.patel@samsung.com>,
	<netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-samsung-soc@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, "'Chandrasekar R'"
	<rcsekar@samsung.com>, "'Suresh Siddha'" <ssiddha@tesla.com>
In-Reply-To: <c17ce6db-4823-44cb-8fda-6ef62f4768fd@lunn.ch>
Subject: RE: [PATCH v3 2/4] net: stmmac: dwc-qos: Add FSD EQoS support
Date: Thu, 6 Jun 2024 14:46:11 +0530
Message-ID: <000401dab7f2$2ee2b8f0$8ca82ad0$@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQG0kE2cByMDcfrFjxkR49X5VWx9JAI1Xm+tAnXeS/UB6i7tpbHG4X3w
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0xTVxzHd2/bewvS5Y6HHEgY7O4lJECrtJ6q6IwEL4MQEsPYxKw29FIY
	faW3bMNlmXODBMLTRMaaCqRRllVwWsqrPESeQxC6KShOTAGZoIJMkQwcutILG/99zvf8ft/f
	+Z6Tw+d4F+GB/EyNgdZr5CoS8+Q2dofuCKe+k6cLjbci4MpcOQKdlY0YHJno4sDa9mEUmka+
	58KqnmEenOmbwuE98wIPFs9OcqCjsZgHrdNjPDj5MAXesJswWDHSgcLKtToe7KveDpcHHyPQ
	3LCEw8nFNhwaHc082DM0y4G57T04NDureR/4U7afx1FqpqQBp1qMEzhVbc2mrJZ8jLo71oZR
	9ee+oVqan6HUk45RjCq2WRDKduUZQr08dRannlnfTBIczdqXQcsVtD6E1qRpFZkaZTQZf0R2
	SCaWCEXhIincTYZo5Go6moxJSAqPzVS5opMhn8tV2S4pSc4wZOT+fXpttoEOydAyhmiS1ilU
	uihdBCNXM9kaZYSGNuwRCYU7xa7C41kZg+OXUd2q4Mu6vKvck4h9WwHiwQdEFCgcuY2uszfR
	ioCGV0dZfoqAwZnkAsTTxcsIqHT8xt1scNxs47Eb7QgYGprnsotZBLy69NJthRFhwFzcga+z
	L3EE3BlscDOHKOKB2+fdNR7EXlD11x9uVx8iFlQ7yt3MJd4B9Z2jnHUWEFJw92Itl+U3wMCP
	97msTzBomjdx2BOFgJWZGh47KxbccvyAsDX+oHelcKOm2wP0WiDLMWB44J8N3Qc87LfhLAeC
	uZK8DZaBC8WjG4kzwMRqGcbyAdB50+TS+S7/UPCLPZKVg8CZaxdRduzroOjFfZTVBaC5cpPf
	BmuPxjYsA0Dj+Sd4KUIatyQzbklm3JLA+P+0aoRrQQJoHaNW0oxYt0tDf/Hfc6dp1VbE/S/C
	4puRKediRBeC8pEuBPA5pK8gkZGlewsU8pwTtF4r02eraKYLEbuuu4wT6JemdX0sjUEmipIK
	oyQSSZR0l0RE+gse5Z5VeBNKuYHOomkdrd/sQ/kegSdRy8HXarxeXPhq6c7ARHyPj2a7b0UL
	/33l9Ss3PrYzz9M7eO1Pdd+GXQXS0vH+ORvVveCll/10oCG6ZVw9mth67TRWN9+P5C7ZyTzO
	cor/sQJl6vF3T1umxF6Pp/NVFYFFObr4Q3H3nvdNw9TUhTjPD7ETD/KvG3bv8Wl7L21I2xZe
	e05cvwNKzQ9qnK3KkuC1sl8TCoV9CV9fUjWFp2FNfMXeT0/5fLJ4uPXYZ+ntJsFHTvRwR/Cq
	bSy/s2pRkJxD+jntQSvbhvz4WGhccHlkb2KAOsf5Z4yXnpCgb0nrpkyO4GQcLbWO/X1w59rv
	l4P8PSan+/abcwjcNDmeEqAiuUyGXBTG0TPyfwF9OF4PoAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUzMcRzHfX/PnR0/d9S3EDvPmass822smWG/mWdLnvObfkUP1+1OyEMq
	NA85eUwnOaHUla3rOleS5ESx7jZ1tB5IIhSRspBxHdN/r+39+rz3/uPD4JKfhAezXbFDUCn4
	SBklIkz3ZZ4ztsTxoT5ZehHqe3ceoJcZJgpZmypwlHenBkPp1kMEumypIVFb5SsaNWd+JJGm
	vQVHNpOGRIZWO4la3gehpyXpFLpgLcNQRn8+iSp1rqj3cQdAmUVfadTSVUojrc1MIsuTdhwd
	vmOhUUPHTRJlvtSR8yBnzKnHuLaTRTRXrG2iOZ0hhjPkHqW4RnspxRVeO8AVm7sx7lNZHcVp
	jLmAM97tBtyvxEs0123wXCFeL5obIkRu3ymovAO2iLY9ri/AlN/Fu/OT7hHxoGToMeDCQNYP
	2mpLyWNAxEjY2wDWv7ABZ+AOvxw8RzpZCnN+vaWd0hsAm+09AwHFesFMTRnt4JHsaphouEI4
	JJy9SsI6nZlyXnQBWF56gXJYLuwcePlzA+FgKbsI6mznB5hgJ8LC8jrcwWLWHzbezCOcPAJW
	pb3+w8yfVjlMKhhYh7Pj4K3OdNy5bjzsa8sinSMWwWe21L+OG3zQl4ynAKl2UJP2f5N2UJN2
	0IUOELnAXVCqo8Ki1L5KX4WwS67mo9QxijD51ugoAxh4EK9pZnArt0teATAGVADI4LKR4mXq
	4FCJOISP3SOoooNVMZGCugKMZgiZm9it/USIhA3jdwgRgqAUVP9SjHHxiMeWvzXVJ/w4w9Q9
	bF42qqC28rQ0sfBRtVThF06Ke4/6lHjOsm8cuuLSlOEH0qbPT5EvNutXtk0oqh7i2iqfPJtp
	PvwA740r9ru49Ij1XcNUhHln+0TkGze+yFs640nWs+mB0UGVTTO1J5pWPk/NSthnXtIYpF/r
	rmfYNf6NF0f0J3vz8fOTe7Dbxjio3EN/2+D7nR+TXN3vYSxcHmjZfP96ultsQY59Q/fYpFTr
	mFp/Q/Y1SZwmP0XqOnb/8fLZ2OpT4QEdhjzJwoxNAQnrNi88q/g898biNH1Q9iRb0t7ED4qd
	4yyzTD9Qq6TnOv1qWGdV6IKI8HudgasU5XRVyKdHwTWxMkK9jff1wlVq/jd7aMISjwMAAA==
X-CMS-MailID: 20240606091616epcas5p4806885e4893357ddf8d231ae045a5efc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230814112612epcas5p275cffb4d3dae86c6090ca246083631c4
References: <20230814112539.70453-1-sriranjani.p@samsung.com>
	<CGME20230814112612epcas5p275cffb4d3dae86c6090ca246083631c4@epcas5p2.samsung.com>
	<20230814112539.70453-3-sriranjani.p@samsung.com>
	<c17ce6db-4823-44cb-8fda-6ef62f4768fd@lunn.ch>



> -----Original Message-----
> From: Andrew Lunn [mailto:andrew@lunn.ch]
> Sent: 15 August 2023 02:17
> To: Sriranjani P <sriranjani.p@samsung.com>
> Cc: davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> pabeni@redhat.com; robh+dt@kernel.org;
> krzysztof.kozlowski+dt@linaro.org; conor+dt@kernel.org;
> richardcochran@gmail.com; alexandre.torgue@foss.st.com;
> joabreu@synopsys.com; mcoquelin.stm32@gmail.com;
> alim.akhtar@samsung.com; linux-fsd@tesla.com;
> pankaj.dubey@samsung.com; swathi.ks@samsung.com;
> ravi.patel@samsung.com; netdev@vger.kernel.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; linux-samsung-
> soc@vger.kernel.org; linux-arm-kernel@lists.infradead.org; Chandrasekar R
> <rcsekar@samsung.com>; Suresh Siddha <ssiddha@tesla.com>
> Subject: Re: [PATCH v3 2/4] net: stmmac: dwc-qos: Add FSD EQoS support
> 
> > +static const int rx_clock_skew_val[] = {0x2, 0x0};
> 
> > +static int dwc_eqos_setup_rxclock(struct platform_device *pdev, int
> > +ins_num) {
> > +	struct device_node *np = pdev->dev.of_node;
> > +	struct regmap *syscon;
> > +	unsigned int reg;
> > +
> > +	if (np && of_property_read_bool(np, "fsd-rx-clock-skew")) {
> > +		syscon = syscon_regmap_lookup_by_phandle_args(np,
> > +							      "fsd-rx-clock-
> skew",
> > +							      1, &reg);
> > +		if (IS_ERR(syscon)) {
> > +			dev_err(&pdev->dev,
> > +				"couldn't get the rx-clock-skew syscon!\n");
> > +			return PTR_ERR(syscon);
> > +		}
> > +
> > +		regmap_write(syscon, reg, rx_clock_skew_val[ins_num]);
> 
> Please could you explain what this is doing.

As per customer requirement, we need to provide a delay of 2ns in FSYS in
both TX and RX path and no delay in peric block

> 
>        Andrew

Regards,
Swathi


