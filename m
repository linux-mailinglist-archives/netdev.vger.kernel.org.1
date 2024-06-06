Return-Path: <netdev+bounces-101345-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1CC8FE313
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 11:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96FE61C25B10
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 09:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5359215F335;
	Thu,  6 Jun 2024 09:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="jqpyxEIm"
X-Original-To: netdev@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C68A15381A
	for <netdev@vger.kernel.org>; Thu,  6 Jun 2024 09:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717666635; cv=none; b=gxKcDxynFKuIeIDNpetc92vOD09ecKXSXbVVY76jaWADeNCKHs923Chr9XPgLduW0ukGAxfs0Ur4ODn94I79G3+AP8iEEI+4QlZjKu57BkTi5J/HLzLAu1xffc+gTd8SpGT+SE4GJunf9pi9h2nacr015uVQ+tKbbto3V3fV/+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717666635; c=relaxed/simple;
	bh=NZQxwkhkSezXGMPWI1LiHIBA3l358+h1LmVDz75rt7g=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=bLh3rW96XOIScgu2BW+buQHyRQaOBICwd30evuVyY1KUzklR5cARXagt19+p/BlZXgnLYEZe+INmsJSSZAApe194sHqjS2u8xHGN80fVF2ZU4xWrZiwqOalmLHvsQqsB3svg0GaCjYI65q7Gh5KdhLkVD3nv9erS7mAkzglMOxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=jqpyxEIm; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240606093711epoutp03687cea6b2e780e0e8b48893a116c94c7~WYLN9npTA2341623416epoutp03e
	for <netdev@vger.kernel.org>; Thu,  6 Jun 2024 09:37:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240606093711epoutp03687cea6b2e780e0e8b48893a116c94c7~WYLN9npTA2341623416epoutp03e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1717666631;
	bh=GVy7QGfxnH+MxqqJ0VHA/xXljTsG0Ffg6LMbYz5nPgU=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=jqpyxEImjCTiSM1QXW9eKPjMnb6u+FxxzHpzh3t0UeyfXerSUccYmYXq2volj+Jbf
	 zZ20zYDWaKA1TdglS3jsjR36RSqsk8d4nWfiTSILMErP/R3qbi4kuBhAwxZgFDFxXQ
	 OO/ZtUSBg+xMm6SbRciPRPh+wJUMxbJabT0K+9e8=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20240606093711epcas5p14dad0ba5e8b51f136030978b2e5862d6~WYLNJREJn2905129051epcas5p1S;
	Thu,  6 Jun 2024 09:37:11 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.175]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4VvzkY22GPz4x9Pt; Thu,  6 Jun
	2024 09:37:09 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	38.9F.10035.54381666; Thu,  6 Jun 2024 18:37:09 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20240606091548epcas5p4883723c4f043e2784ca6c536ff55df10~WX4i3brnP0843308433epcas5p4S;
	Thu,  6 Jun 2024 09:15:48 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240606091548epsmtrp203e6476864cf97c25edbe0315d5c96e3~WX4i2hljT2889428894epsmtrp2z;
	Thu,  6 Jun 2024 09:15:48 +0000 (GMT)
X-AuditID: b6c32a4b-8afff70000002733-11-666183457415
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	D1.A7.18846.44E71666; Thu,  6 Jun 2024 18:15:48 +0900 (KST)
Received: from FDSFTE596 (unknown [107.122.82.131]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20240606091545epsmtip22743f3df6c3f100da816058de19b33dc~WX4gAmTes2296422964epsmtip2C;
	Thu,  6 Jun 2024 09:15:45 +0000 (GMT)
From: "Swathi K S" <swathi.ks@samsung.com>
To: "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<richardcochran@gmail.com>, <alexandre.torgue@foss.st.com>,
	<joabreu@synopsys.com>, <mcoquelin.stm32@gmail.com>,
	<alim.akhtar@samsung.com>, <linux-fsd@tesla.com>,
	<pankaj.dubey@samsung.com>, <ravi.patel@samsung.com>
Cc: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-samsung-soc@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
In-Reply-To: <c9344953-9367-0ab0-fa42-3117d17643eb@linaro.org>
Subject: RE: [PATCH v3 1/4] dt-bindings: net: Add FSD EQoS device tree
 bindings
Date: Thu, 6 Jun 2024 14:44:40 +0530
Message-ID: <000301dab7f2$1e684710$5b38d530$@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQG0kE2cByMDcfrFjxkR49X5VWx9JAKGcKNgAXd78/0Bp/St3wILmJFrAs2Q6cmxp49FYA==
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA02Tf1CTdRzH73me/QJZPo1fX1YUN6VLEthwjGccvyqyRyCiOMuzzvW0PQIH
	bLs9W9lPaMGRHEwtREJAXInHUNG5TUAGHRsQ+ANNoPMSFYRCITEIYxLaxoPGf6/P78/7+70P
	B+EVsvmcHKWW1CiJPAHLm2FzbAgLf+1rYqfwNycHc92uhLCbdTYWdsx+EcZqBooY2CHnRSY2
	0TPGxq4b7zIxw+QogtmnrGzsks3AxMy3hpnY6J13sSttNSysaqADxuqWjjOxnvoA7P65aQgz
	Wv9mY6P32tmY8/wkghXbnewkf9zSeBXGJ/ZY2Xhr9QgbrzfrcLNpNwu/NtzOwk//WIDPdAyx
	cIPFBOGWzjkIf6ivZeNz5ucyfLbnxmWThILUhJBKuUqRo8yKF6Rmyl6VRUuEonCRFIsRhCiJ
	fDJekJyWEb45J8+tVRDyEZGnc7syCIoSRCbEaVQ6LRmSraK08QJSrchTi9URFJFP6ZRZEUpS
	GysSCqOi3Ykf5Gbry8sg9UDwrqXJA8xCaCygFOJwACoG+gqsFPLm8NCzEJgyWRm0MQuBtqIO
	9hNj4Uqr2/BarnAYDyF0oBUC/wxWQJ4AD52EgLWP8DALDQNGA13th55DwPylJshjIGgTBCwu
	B+zJ8kITwEOnc5l90bdA3e9VLA8z0PWg/7IZ8TAXlYLp5j4WzU+Dvu/HGR5G0JdAw+EphF4p
	BLgmGpge9kPfAZXfVrDonEDQ7SpbXhWgP3iB3SWXmbTqZNB55m261hfc6bWsSOODubt2Fs0y
	0GQYYtCcDUYe7FvxJ4KfBmsYnjYIugE0t0XS7mCwv/8ETI99CpQvjsO0nwta6h7zOrA0NbzS
	MgjYjsyw90KC6lXKqlcpq16loPr/afUQwwQFkWoqP4ukotWblOTHTz5crso3Q8unEJbaAo3d
	vBfRBcEcqAsCHETgx02nZDt5XAXxyaekRiXT6PJIqguKdj/3PoTvL1e5b0mplYnEUqFYIpGI
	pZskIkEgd6q4VsFDswgtmUuSalLzuA7mePELYTz5+eg1mRXHU9Le+LJka0lAUNLnf24nGof8
	XlGeGNj2uuVglc+wfHHxQPI6w0ZjVFKcTe98cJtp2jFjr/qrWDFtHBw7lVQSFupTNu84/ZUr
	RupYkK+BT8KnqJbEhpY9ty6km5qbeTW16hhf/9nx81tutPvumvg1Ek1dCJ6P4rjKhw9KFcov
	Eq6n9LwntxfaT47UdQeuXT9TxU78TN6XkrZ224eToelBJW299yWzx/zhP5xHzwT0xAqb52Zj
	vmt39G/xLr3wzMv/Dm7e+6L+GuPR+/rMjoIdW3X8wtDDo0WdR0s3/mz4JgG+an02VswZqK98
	4ZfuI7YbjZkFj6is/b3cs2/yMwQMKpsQhSEaivgPXdjn8pMEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKIsWRmVeSWpSXmKPExsWy7bCSvK5LXWKawaK5ChY/X05jtHgwbxub
	xZq955gs5pxvYbGYf+Qcq8XTY4/YLe4tesdq0ffiIbPF3tdb2S0ubOtjtdj0+BqrxcNX4RaX
	d81hs5hxfh+Txby/a1ktji0Qs/h2+g2jxaKtX9gtHn7Yw25x5MwLZovWvUfYHUQ9tqy8yeTx
	tH8ru8fOWXfZPRZsKvXYtKqTzePOtT1sHpuX1Hu833eVzaNvyypGjy37PzN6/Guay+7xeZNc
	AE8Ul01Kak5mWWqRvl0CV0bDmcSCCbIVp7c0szQwLhTrYuTkkBAwkTi8aD5zFyMXh5DAdkaJ
	mYfamCASkhKfmqeyQtjCEiv/PWeHKHrGKLHl4RZmkASbgJbEor59YAkRgdvMEn/W72YDSTAL
	rGeUuN7nA9FxmUli+6/3LCAJTgE7iX9HjoCtEBbwl1i3YypYA4uAisSpi5vApvIKWEq8WX+S
	DcIWlDg58wkLxFBtiac3n8LZyxa+ZoY4T0Hi59NlYKeKCIRJTJs0BeoIcYmjP3uYJzAKz0Iy
	ahaSUbOQjJqFpGUBI8sqRtHUguLc9NzkAkO94sTc4tK8dL3k/NxNjOCUoBW0g3HZ+r96hxiZ
	OBgPMUpwMCuJ8PoVx6cJ8aYkVlalFuXHF5XmpBYfYpTmYFES51XO6UwREkhPLEnNTk0tSC2C
	yTJxcEo1MFnPPntp9bKZQlYLuJ+tLlz/OFzcaUIVV/PpgxGB31dOejTVT67b5pDfdvbF9m+T
	a5+eVioy+RsjWpT2LpWL7XVP9NH1K3az/nErurT//N97H4qrVY5oiMUfaxd3D/+wgHFqml5c
	QvGdXOXLOp9Tz26MW6Ih3n1IYKXu9nna+a+aXwsGbfKPklrgc+7xuncBPLvYPkupZ3360HD3
	atWzwD88G8pbJ67Zx7Ml1ueMQe2eZwtfS9xg3lfyUvHYvow3B3/ZTZd+JPzTZMqM+TM5l1TK
	vnD+NHt+3sKPJiFOzCYMnZW86dnnOk99u6q3hWdOv8LO6ONzl+ebbP85o/z2oxmd3KuakiaH
	5LPO1D6i2mGvxFKckWioxVxUnAgAq9N/O3gDAAA=
X-CMS-MailID: 20240606091548epcas5p4883723c4f043e2784ca6c536ff55df10
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230814112605epcas5p31aca7b23e70e8d93df11414291f7ce66
References: <20230814112539.70453-1-sriranjani.p@samsung.com>
	<CGME20230814112605epcas5p31aca7b23e70e8d93df11414291f7ce66@epcas5p3.samsung.com>
	<20230814112539.70453-2-sriranjani.p@samsung.com>
	<16eab776-07d4-3c31-7e82-444863303102@linaro.org>
	<000d01d9d006$a211d880$e6358980$@samsung.com>
	<c9344953-9367-0ab0-fa42-3117d17643eb@linaro.org>

Hi Krzysztof,=20

Sorry for the delay in response.
Starting now, I will be taking over this task.
I have gone through your comments and feedback and will be implementing the=
m in v4 of this patch.

> -----Original Message-----
> From: Krzysztof Kozlowski =5Bmailto:krzysztof.kozlowski=40linaro.org=5D
> Sent: 16 August 2023 11:48
> To: Sriranjani P <sriranjani.p=40samsung.com>; davem=40davemloft.net;
> edumazet=40google.com; kuba=40kernel.org; pabeni=40redhat.com;
> robh+dt=40kernel.org; krzysztof.kozlowski+dt=40linaro.org;
> conor+dt=40kernel.org; richardcochran=40gmail.com;
> alexandre.torgue=40foss.st.com; joabreu=40synopsys.com;
> mcoquelin.stm32=40gmail.com; alim.akhtar=40samsung.com; linux-
> fsd=40tesla.com; pankaj.dubey=40samsung.com; swathi.ks=40samsung.com;
> ravi.patel=40samsung.com
> Cc: netdev=40vger.kernel.org; devicetree=40vger.kernel.org; linux-
> kernel=40vger.kernel.org; linux-samsung-soc=40vger.kernel.org; linux-arm-
> kernel=40lists.infradead.org
> Subject: Re: =5BPATCH v3 1/4=5D dt-bindings: net: Add FSD EQoS device tre=
e
> bindings
>=20
> On 16/08/2023 07:58, Sriranjani P wrote:
> >>> +
> >>> +allOf:
> >>> +  - =24ref: snps,dwmac.yaml=23
> >>> +
> >>> +properties:
> >>> +  compatible:
> >>> +    const: tesla,fsd-ethqos-4.21.yaml
> >>
> >> ?
> >
> > Will fix this to tesla,fsd-ethqos.yaml
>=20
> Test your patches before sending. REALLY TEST.

Sure. Will fix this to tesla,fsd-ethqos.yaml and test the same.

>=20
> >
> >>> +
> >>> +  reg:
> >>> +    maxItems: 1
> >>> +
> >>> +  interrupts:
> >>> +    maxItems: 1
> >>> +
> >>> +  clocks:
> >>> +    minItems: 5
> >>
> >> Why? I expect it to be specific.
> >
> > Sorry, I could not understood this comment. In FSD we have two instance=
s
> of EQoS IP, one in PERIC block, which requires total 10 clocks  to be
> configured and another instance exist in FSYS0 block which needs 5 clocks=
 to
> be configured, so we kept minItems as 5 and maxItems as 10, but looks lik=
e
> latest items schema do not need maxItems entry so we will drop maxItems
> entry. In my understanding minItems still required so it should be kept w=
ith
> minimum number of clock requirements.
>=20
> No, the code is fine then.
>=20
> >
> >>
> >>> +    maxItems: 10
> >>> +
> >>> +  clock-names:
> >>> +    minItems: 5
> >>> +    maxItems: 10
> >>> +    items:
> >>> +      - const: ptp_ref
> >>> +      - const: master_bus
> >>> +      - const: slave_bus
> >>> +      - const: tx
> >>> +      - const: rx
> >>> +      - const: master2_bus
> >>> +      - const: slave2_bus
> >>> +      - const: eqos_rxclk_mux
> >>> +      - const: eqos_phyrxclk
> >>> +      - const: dout_peric_rgmii_clk
> >>> +
> >>> +  fsd-rx-clock-skew:
> >>> +    =24ref: /schemas/types.yaml=23/definitions/phandle-array
> >>> +    items:
> >>> +      - items:
> >>> +          - description: phandle to the syscon node
> >>> +          - description: offset of the control register
> >>> +    description:
> >>> +      Should be phandle/offset pair. The phandle to the syscon node.
> >>> +
> >>> +  iommus:
> >>> +    maxItems: 1
> >>> +
> >>> +  phy-mode:
> >>> +    =24ref: ethernet-controller.yaml=23/properties/phy-connection-ty=
pe
> >>> +
> >>> +required:
> >>> +  - compatible
> >>> +  - reg
> >>> +  - interrupts
> >>> +  - clocks
> >>> +  - clock-names
> >>> +  - rx-clock-skew
> >>
> >> Eee? Isn't it fsd-rx-clock-skew which anyway is not correct?
> >
> > Sorry, I missed to change this in DT schema before posting, I will make=
 this
> to fsd-rx-clock-skew.
>=20
> Remember about vendor prefixes for every custom property.

Sure, will fix this in v4.

>=20
>=20
> Best regards,
> Krzysztof

Regards,=20
Swathi



