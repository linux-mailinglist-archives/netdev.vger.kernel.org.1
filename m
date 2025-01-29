Return-Path: <netdev+bounces-161474-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2F6A21C1F
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 12:25:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63EAE1884752
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 11:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50AD91B414E;
	Wed, 29 Jan 2025 11:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="rsGLB8N6"
X-Original-To: netdev@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450521B0434
	for <netdev@vger.kernel.org>; Wed, 29 Jan 2025 11:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738149907; cv=none; b=eysE3gfO+zbCZAvNLu+DCp5FVgmQWtgRnXuWRePZrM0kS+80HfoI+T39xz7yPGG3zjix2QMpDknQFVeGuw2dgRBtBXXHqE1jxB87CCvcPpwin7d+N6QQHYipTk/NJ6n/OvcS9rX6ogErASwpYt8LcCjA1zEzJVS5fnbjCaLL66s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738149907; c=relaxed/simple;
	bh=J1Ie4jiZwLz5gqjKkiEK3Hl+b1Wh2aFcy3HyOD+UtsM=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=CRus7aHIGGvbFQNDRyrehAwcm2uBZOsmaMkSH97fqSwfsK3kGhWGfSSKGTXMA5Qvq0FJNl6d+lvLW4eQ7Wz0dnxv0s2h9uE3DL0VUcMBiFX4QEjU0Fz6sx/f2zAQA05H/uLRu0kee7jxCi3UzmR5BatNw5h50eQyoDJxn3SFXW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=rsGLB8N6; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250129111528epoutp0179dda26069bdb9e3ef264b2a10365877~fJZr6Rpbp2275322753epoutp01c
	for <netdev@vger.kernel.org>; Wed, 29 Jan 2025 11:15:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250129111528epoutp0179dda26069bdb9e3ef264b2a10365877~fJZr6Rpbp2275322753epoutp01c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1738149328;
	bh=xGuALcrPuSIk/tk+ACOlUB8rfuEt7Bvx3muPFTz4zHE=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=rsGLB8N6va6oUb3YqxGVT2IOpORfLhi4/PlOznnJIPedlqMZI//gP8WVO24JGsuUE
	 rVqfAvq60Gw6O4RQSOLOVeMjHiNbM2wLcNmMiUSUiKH0aNWiN1qapE0JQQYhWbtJvp
	 8T2QUFPYOLmmcBqQBnjVnIXMNV/0eZ7lB4msCskE=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20250129111528epcas5p4ece79fb77edd90a7a080715fceb8fc57~fJZrScBPq1814118141epcas5p47;
	Wed, 29 Jan 2025 11:15:28 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.175]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4YjfhY7429z4x9Pw; Wed, 29 Jan
	2025 11:15:25 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	E6.71.29212.DCD0A976; Wed, 29 Jan 2025 20:15:25 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20250129091811epcas5p338ea019f7d192f9105b9439da53abbaa~fHzR7Mapz0667606676epcas5p36;
	Wed, 29 Jan 2025 09:18:11 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250129091811epsmtrp2b18e9e73296966f0b490b888948628d5~fHzR42lxZ0365703657epsmtrp2B;
	Wed, 29 Jan 2025 09:18:11 +0000 (GMT)
X-AuditID: b6c32a50-801fa7000000721c-2d-679a0dcd7119
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	77.13.23488.352F9976; Wed, 29 Jan 2025 18:18:11 +0900 (KST)
Received: from FDSFTE596 (unknown [107.122.82.131]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20250129091807epsmtip2f010d378103714dd2c89521cab520491~fHzOT0pot1058210582epsmtip2s;
	Wed, 29 Jan 2025 09:18:07 +0000 (GMT)
From: "Swathi K S" <swathi.ks@samsung.com>
To: "'Krzysztof Kozlowski'" <krzk@kernel.org>
Cc: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-samsung-soc@vger.kernel.org>,
	<alexandre.torgue@foss.st.com>, <peppe.cavallaro@st.com>,
	<joabreu@synopsys.com>, <rcsekar@samsung.com>, <ssiddha@tesla.com>,
	<jayati.sahu@samsung.com>, <pankaj.dubey@samsung.com>,
	<ravi.patel@samsung.com>, <gost.dev@samsung.com>, <robh@kernel.org>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <conor+dt@kernel.org>, <richardcochran@gmail.com>,
	<mcoquelin.stm32@gmail.com>, <andrew@lunn.ch>, <alim.akhtar@samsung.com>,
	<linux-fsd@tesla.com>
In-Reply-To: <1da56c20-c522-428e-81ff-bc2f9ee0f524@kernel.org>
Subject: RE: [PATCH v5 1/4] dt-bindings: net: Add FSD EQoS device tree
 bindings
Date: Wed, 29 Jan 2025 14:48:05 +0530
Message-ID: <002d01db722e$b6fc4610$24f4d230$@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQDx5RsunPn3lkU9PtjwM0wRa6rGBAHz93duAhzDMjcC64gLR7TIsIcg
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA01Ta1BUZRieb8+ePYsGHbl+4Vh0igqaBVZg+yBAQsY5A8yIOFrROLjCaZeA
	3WUvCpaDgaYQETaT2HK/iIIhuAIuBLQCkUGy4AUxRZHLgAsBBjFQQ7bsgeLf8z7zvO/zPu83
	Hx+zrSKc+fEyNaOUiRMp3iZuY4ebm+CmtVbi1TnvjZafngVouKiRh4xD7Rj6vrWXgwqMJ7io
	uLMXR+NdIwS6b2jioM7uCg56VDaDI6OxjkB9jTk40o0O4OiJ6X10u7mAh84Z2zgoa2AMR0Ur
	NTjqKnFEiz3TAJU1LBDo+VQDQE/mWgik7dPjqPPXSQw9b9ETqGy4BA/eStdX3efQ4183EHST
	doigS3QaWledyaOvVqTRTfp5Dj3bdpdH59RXA/p6m5AeX2rF6Pof5wH9T3ohQc/rXo60iU4I
	kDLiOEbpwshi5XHxMkkgFb43ZmeMr8hLKBD6oXcoF5k4iQmkQiMiBbviE80noVwOixM1ZipS
	rFJRnkEBSrlGzbhI5Sp1IMUo4hIVPgoPlThJpZFJPGSM2l/o5bXd1yw8mCCdyj8FFPkOKXla
	I34cNJNZwIoPSR94cuk0ngU28W3JFgB/r63issUfAN563EywxSKAk7pF3nqLob56TdUK4Kmh
	XowtJgGs7Z/krqp4pDssy2kjVrE9KYBXBy9YRmFkDw4NDRmWUVZkEDx/OR9fxXbkHlg8mGPh
	uaQrvNb/pYW3Jv3gg6JhwOIt8JfvxiwGGPk2rCydwtiVXODyeKVZzzeb7YLP7n3ASpzgT8vZ
	luUgOWIFLy7eAKw+FHY0NOEstoOmn+sJFjvD+ZnWtZgx8FLOXS6LpXDorzNr/A5ouFPAXfXC
	SDdY2+zJ0tvgt92XOayvDfzq7zEOy1tDfdE6fg2uTA2sjXwJNp6fJXIBpd2QTLshmXZDBO3/
	biWAWw2cGYUqScLE+iqEAhlz5L8nj5Un6YDlz7hH6sGluhWPdsDhg3YA+Rhlb32g95zE1jpO
	nHqUUcpjlJpERtUOfM33PoM5O8TKzZ9Opo4R+vh5+YhEIh8/b5GQcrLOaDohsSUlYjWTwDAK
	Rrnex+FbOR/nuORFEYKu/pNOi0EXDnk//IIvjdiSPPMoJC+uYsTV9KnmldKUd1OCI9xT02v2
	v35wCd6yCXhosNvfpw+bGTeFf/OYwt6zK2gOmWiVyrfibkfl2UYJmTGdLrG/FnD9zcEjVccO
	dS9kbtMkeu29UprqP6xsrsErO3qCx23Alew5LDo32uHzBdVoXd32j0dbpTdf1e8+ra54sFnk
	9uJvsYUl1FPXP9vPRh6YixI57pYYZtMycpTpe3h3QvbZbr6dHXYjdLDNc+LDnYWfhO7TaArC
	ZP3toWnJHs8k4Unl5UuGkR0vTF/8gbj3mf8buqJcTUpyZlXY4beWTRNM+cQxUxSv+CPHSgHF
	VUnFQndMqRL/C7mz+EC8BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjleLIzCtJLcpLzFFi42LZdlhJXjf408x0gxMf+Cx+vpzGaPFg3jY2
	i/N3DzFbrNl7jslizvkWFov5R86xWjw99ojd4uaBnUwWR04tYbK4t+gdq8X58xvYLS5s62O1
	2PT4GqvFw1fhFpd3zWGzmHF+H5NF17UnrBbz/q5ltTi2QMzi2+k3jBaLtn5ht/j/eiujxcMP
	e9gtZl3YwWpx5MwLZov/e3awWyx6sIDVQdpjy8qbTB5P+7eye+ycdZfdY8GmUo9NqzrZPDYv
	qffYueMzk8f7fVfZPPq2rGL0OLjP0OPpj73MHlv2f2b0+Nc0l93j8ya5AL4oLpuU1JzMstQi
	fbsEroyOQzvYCs6KVDxfvYO1gfENfxcjJ4eEgInEgS2rWLoYuTiEBHYzShzds4ARIiEp8al5
	KiuELSyx8t9zdhBbSOAZo8TtaUUgNpuAlsSivn1gcREBXYnNN5aD2cwCL1kljq6JgBj6llFi
	5ZMtYEM5Bewklq6bDTZUWMBfYtqlg2A2i4CqxPaL3WA2r4ClxO15DxghbEGJkzOfsEAM1Zbo
	fdjKCGMvW/iaGeI4BYmfT5cB9XIAHeEm8fF6BESJuMTRnz3MExiFZyGZNAvJpFlIJs1C0rKA
	kWUVo2RqQXFuem6yYYFhXmq5XnFibnFpXrpecn7uJkZwktHS2MH47luT/iFGJg7GQ4wSHMxK
	Iryx52akC/GmJFZWpRblxxeV5qQWH2KU5mBREuddaRiRLiSQnliSmp2aWpBaBJNl4uCUamBK
	vVkhe6vuGefvOrmJWjr+u2/EVq7fN/fJrwfKUnOlBbXrN1/7yHGu5wuf+faeyIq+0wGK03m4
	um52fLyS4qy/xCo4P8bUgpvrwfVnZapC/Gr/Wo6dMbn9zeDMgrUHYsTvCLUzRAi3uy+baxSQ
	1nC0b/HX3Z7Mkzj/cvhztQe+ejSn1mfKGvWue17XP6c9DBDi2b3ZzzuAl3tyVtaH07U+s+6v
	qfDj+ujO1i98fpPrjFCXW7ePTGp9YR2+O9hZsrpq58najU8d+TMX8na63Nd6c0rl6vcvUpMv
	r4w/kM7yN3dJYje3wqt7gSIMKozJ0/frvrnxeTWf6P4pN5JvPN5enll65qTAqlqZpKUFX+Yo
	sRRnJBpqMRcVJwIAzQB4eqEDAAA=
X-CMS-MailID: 20250129091811epcas5p338ea019f7d192f9105b9439da53abbaa
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250128102725epcas5p44b02ac2980a3aeb0016ce9fdef011ecf
References: <20250128102558.22459-1-swathi.ks@samsung.com>
	<CGME20250128102725epcas5p44b02ac2980a3aeb0016ce9fdef011ecf@epcas5p4.samsung.com>
	<20250128102558.22459-2-swathi.ks@samsung.com>
	<1da56c20-c522-428e-81ff-bc2f9ee0f524@kernel.org>



> -----Original Message-----
> From: Krzysztof Kozlowski <krzk=40kernel.org>
> Sent: 28 January 2025 19:45
> To: Swathi K S <swathi.ks=40samsung.com>; robh=40kernel.org;
> davem=40davemloft.net; edumazet=40google.com; kuba=40kernel.org;
> pabeni=40redhat.com; conor+dt=40kernel.org; richardcochran=40gmail.com;
> mcoquelin.stm32=40gmail.com; andrew=40lunn.ch; alim.akhtar=40samsung.com;
> linux-fsd=40tesla.com
> Cc: netdev=40vger.kernel.org; devicetree=40vger.kernel.org; linux-
> kernel=40vger.kernel.org; linux-stm32=40st-md-mailman.stormreply.com;
> linux-arm-kernel=40lists.infradead.org; linux-samsung-soc=40vger.kernel.o=
rg;
> alexandre.torgue=40foss.st.com; peppe.cavallaro=40st.com;
> joabreu=40synopsys.com; rcsekar=40samsung.com; ssiddha=40tesla.com;
> jayati.sahu=40samsung.com; pankaj.dubey=40samsung.com;
> ravi.patel=40samsung.com; gost.dev=40samsung.com
> Subject: Re: =5BPATCH v5 1/4=5D dt-bindings: net: Add FSD EQoS device tre=
e
> bindings
>=20
> On 28/01/2025 11:25, Swathi K S wrote:
> > +  Tesla ethernet devices based on dwmmac support Gigabit ethernet.
> > +
> > +allOf:
> > +  - =24ref: snps,dwmac.yaml=23
> > +
> > +properties:
> > +  compatible:
> > +    const: tesla,fsd-ethqos.yaml
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    minItems: 5
> > +    maxItems: 10
>=20
> Why is this flexible?
>=20
> Anyway, you need to list and describe the items instead of min/maxItems.

Hi Krzysztof,
There are 2 Ethernet instances where Eth0 has 5 clocks and Eth1 has 10 cloc=
ks.
Would it be sufficient to list the clock names?

>=20
> > +
> > +  clock-names:
> > +    minItems: 5
> > +    maxItems: 10
>=20
> Same here.

Ack

>=20
> > +
> > +  iommus:
> > +    maxItems: 1
> > +
> > +  phy-mode:
> > +    enum:
> > +     - rgmii-id
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - clocks
> > +  - clock-names
> > +  - iommus
> > +  - phy-mode
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - =7C
> > +    =23include <dt-bindings/clock/fsd-clk.h>
> > +    =23include <dt-bindings/interrupt-controller/arm-gic.h>
> > +
> > +    ethernet_1: ethernet=4014300000 =7B
>=20
> Please implement last comment from Rob.
>=20
> > +              compatible =3D =22tesla,fsd-ethqos=22;
> > +              reg =3D <0x0 0x14300000 0x0 0x10000>;
>=20
> And since there is going to be new version, switch to the preferred
> indentation (4-space). Other option is 2 spaces, but not 8.

Ack, will update it this way in v6.

- Swathi

>=20
> > +...
>=20
>=20
> Best regards,
> Krzysztof


