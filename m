Return-Path: <netdev+bounces-161598-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02A98A228D4
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 07:13:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39A4218872E4
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 06:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D10321922F3;
	Thu, 30 Jan 2025 06:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="rIxNK1SJ"
X-Original-To: netdev@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89602190058
	for <netdev@vger.kernel.org>; Thu, 30 Jan 2025 06:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738217625; cv=none; b=Ld9auuw4dHC9APnjHlNH2vBajyQXE/S5i0op6Bba8ca8eCQlTr0eKdMEN7agzF8Ixg2BKcM2yKXMMpbFkvkuY+cCcX0cVd91ArY/50DCuM0EXBzOdDvDNCiiicjgHAKsgeYKpn/WoHLak27KWhzvz/jV9TtdcHgaFOgrIOh3IKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738217625; c=relaxed/simple;
	bh=uF9JA9Ob30UgQwQ1EYDlYDH5pEk2arl1xRBWSnFEHyo=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=uMhJqgqQ6wrQaiMLJEN2nuzxgZ/ECmqAYcy7Uw+vzo8R7ZX0BwYKT6oTzHJ33ssg3SLPc8HtRASKFJgvYpuxQ5RRRr9BOcY4Z6nLQ/8QkubAXGrsBAvACcmGTauOXxWJROkQXE1AebKWL1xOMqCVYeK4bqLNV2+aWT3SR0uvsok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=rIxNK1SJ; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250130061341epoutp023c7224e3e01c3490732e32924f40b7f7~fY7etDfkG1168211682epoutp02L
	for <netdev@vger.kernel.org>; Thu, 30 Jan 2025 06:13:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250130061341epoutp023c7224e3e01c3490732e32924f40b7f7~fY7etDfkG1168211682epoutp02L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1738217621;
	bh=mztnCaIfHV9x+Yu8hRVDPHeOy7Gt+locQNzg3InAHw0=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=rIxNK1SJxI+kr8oKzEzSnj/WY8bjOZUxA+10qURZa3MHn/TQ8QsnmXKnpuJ0+/GGZ
	 Xghd2imI7C+FCvPfyyNaBhASoeoAMIKtBbSh3uT2UQkaFO6yLG868OX6suCo4nisvC
	 Q2gfEUWf46w791KaQ1YVnWjVeWcxcFVrRJVNJIgo=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20250130061340epcas5p14b19103336506df38be9e60b4b6ed97e~fY7eADqDL0799607996epcas5p1t;
	Thu, 30 Jan 2025 06:13:40 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.182]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4Yk7xv05Z6z4x9Py; Thu, 30 Jan
	2025 06:13:39 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	8F.A0.19710.2981B976; Thu, 30 Jan 2025 15:13:38 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20250130060554epcas5p4035cae282c2bf0df98d9d1086ec86c97~fY0sAw_OS0133901339epcas5p4L;
	Thu, 30 Jan 2025 06:05:54 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250130060554epsmtrp2f4afe7f2e17be1554037ce8a5e047085~fY0r-tffn1752517525epsmtrp2i;
	Thu, 30 Jan 2025 06:05:54 +0000 (GMT)
X-AuditID: b6c32a44-363dc70000004cfe-5c-679b189231f5
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	95.D2.18949.2C61B976; Thu, 30 Jan 2025 15:05:54 +0900 (KST)
Received: from FDSFTE596 (unknown [107.122.82.131]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20250130060551epsmtip274c505e64f7493196e8cdb953c009479~fY0oaE8sX0835108351epsmtip2a;
	Thu, 30 Jan 2025 06:05:50 +0000 (GMT)
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
Date: Thu, 30 Jan 2025 11:35:17 +0530
Message-ID: <005b01db72dd$059f81c0$10de8540$@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQDx5RsunPn3lkU9PtjwM0wRa6rGBAHz93duAhzDMjcC64gLR7TKB+9g
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA01Ta0xTZxj2O6ftaZnVIyB8YlRSRyIo0GLBjylOJ5JjcJFpgruopYFjIZTS
	9YKDP6AYcWyCqEwpt0rEcWcCZeVWGTCIsFAIl5QfqAgoAooBR7hMWeHAxr/nfd7nfZ/vfb+8
	XNy2gHDiRig0tEohlQs4NqzqZtc97rdgpkyYPHUAzb/+BaDnOdUcZB5swlFJQyeGssxXWSi3
	pZONRltfEGigsQZDLe0PMPQ07y0bmc2/EairOoWNKob72Who/Czqqc3ioHtmE4aS+0fYKOdD
	KRu16h3QbMckQHmG9wRamjAANPSunkC6LiMbtfw1hqOleiOB8p7r2Ue2U1WFAxg1mmogqBrd
	IEHpK7RURdGPHKryQTxVY5zBqClTH4dKqSoC1B8mETU614BTVY9nAPXxSjZBzVTsDNr0beSh
	cFoaRqucaUVodFiEQuYnCDwjOSbx9hGK3EW+6IDAWSGNov0E/ieD3AMi5NaVCJxjpHKtlQqS
	qtUCz8OHVNFaDe0cHq3W+AloZZhcKVZ6qKVRaq1C5qGgNZ+JhEIvb6swJDJcbxoGyjb7H54m
	nUwAiWQy4HEhKYZJKfUgGdhwbck6AHvLuwgmmAYwe2EKY4JZAIde1eNrJabKIRaTaAAwdbyD
	zQRjABYYGtjLKg7pBvNSTMQytifdYaXl15W+ONnBho2GRM5ygkcehvllmSsFduRXMNeSssKz
	SBf40jDMWsZ80hdeK+zjMHgLfJIxssLj5F748P7E6pOc4fzoQzZjFgC7em5hjMYR/jn/M75s
	DMkXPNjfxogg6Q8n7idwGGwHx9uqCAY7wZm3Dau8BBan9LEYHA4HF9JW+c9hY2+WledaDVxh
	ea0nQ++A6e1lq76b4I3FEYzh+dCYs4Z3ww8T/astt8Hq/CniJhDo1o2mWzeabt0Iuv/d9IBV
	BLbRSnWUjA71VooU9KX/fjw0OqoCrJyMm78RWHI/ejQBjAuaAOTiAnv++c57Mlt+mDQ2jlZF
	S1RaOa1uAt7WfafhTltDo603p9BIRGJfodjHx0fsu99HJHDkJ9ZcldmSMqmGjqRpJa1aq8O4
	PKcEzFE2Nxev3zceQwTu/vSfR5dr8yebIkp2bd9nfLS57ja59afjxQVzAbpaMHNK3k1nfBnZ
	+e5Cb2mI5e6068usuMVdScfza2KulHvcPSoZEB3Fp429YwqvwCFPiSD/mqj8WZrtTQde5cXr
	b5o23jjRLXP5PZh1MN1iep8xa2zM3umRvDFLsn8DT3xa6H2ncD5kMj1e7uV1omqpLHM+zgYE
	F5R+08dvPphxvvv22BGXZwt5RKKDvtUibY5VnslSnlp0jHjzxeO8jNoNId9dNidpMJu/z13c
	0vH95pIdX3Ne1bVrdf09n+xluehen8vck2qHTxWrL9iPXXriGnv9rG6XIfj0nckcAUsdLhW5
	4Sq19F9IxoHduwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAKsWRmVeSWpSXmKPExsWy7bCSvO4hsdnpBhP7TCx+vpzGaPFg3jY2
	i/N3DzFbrNl7jslizvkWFov5R86xWjw99ojd4uaBnUwWR04tYbK4t+gdq8X58xvYLS5s62O1
	2PT4GqvFw1fhFpd3zWGzmHF+H5NF17UnrBbz/q5ltTi2QMzi2+k3jBaLtn5ht/j/eiujxcMP
	e9gtZl3YwWpx5MwLZov/e3awWyx6sIDVQdpjy8qbTB5P+7eye+ycdZfdY8GmUo9NqzrZPDYv
	qffYueMzk8f7fVfZPPq2rGL0OLjP0OPpj73MHlv2f2b0+Nc0l93j8ya5AL4oLpuU1JzMstQi
	fbsEroyzc6ewFfwUrrh6eRpLA+NW/i5GTg4JAROJfZsfsnQxcnEICexmlHizaSk7REJS4lPz
	VFYIW1hi5b/n7BBFzxglrnQdYAZJsAloSSzq2wfWICKgK7H5xnIwm1ngJavE0TUREA1vGSVW
	PtnCCJLgFLCTWLpuNthUYQF/iWmXDoLZLAKqEs+2PmYBsXkFLCXaVl5lg7AFJU7OfMICMVRb
	ovdhKyOMvWzha2aI6xQkfj5dxgpxhJvEhcuTmCBqxCWO/uxhnsAoPAvJqFlIRs1CMmoWkpYF
	jCyrGCVTC4pz03OLDQuM8lLL9YoTc4tL89L1kvNzNzGCE42W1g7GPas+6B1iZOJgPMQowcGs
	JMIbe25GuhBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHeb697U4QE0hNLUrNTUwtSi2CyTBycUg1M
	3OVbvh24Xx9z46iF5twNx3wUJLfnTZ49k7/nwDvGcy++rTv760GlvfR534SDB5Y2FWU2ul2c
	6LfmUniZRB+DrafvRrHQCebXah8Z8HPfOnJb3VZrR+Hs9MDPN0IU8+z/n+Lo0nqmedlddMax
	itOLSlISli/8uKgmaPXODV82zO8Olr5fXnv8xIkHe9cGHFLJcdY0Y7617oXB1ZaMPUJf1myd
	HjVPTbrwdN/eeaskWrb5S+XMObxldUCl1CX/ia7C3p/27wrz4DMLXv32tfr2z1fn8b5IviW2
	a91UrWUFLTMt7/q4fZpes7BCivFp7JLDygGt1/nqxd5J2pmEPHqVO6PjUGnu8QZpLuFWEcWl
	ukosxRmJhlrMRcWJALevC2mjAwAA
X-CMS-MailID: 20250130060554epcas5p4035cae282c2bf0df98d9d1086ec86c97
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
>=20
> > +
> > +  clock-names:
> > +    minItems: 5
> > +    maxItems: 10
>=20
> Same here.
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

This label is used to enable the node in dts. Could see similar labels in o=
ther yaml files. Am I missing something here?

>=20
> > +              compatible =3D =22tesla,fsd-ethqos=22;
> > +              reg =3D <0x0 0x14300000 0x0 0x10000>;
>=20
> And since there is going to be new version, switch to the preferred
> indentation (4-space). Other option is 2 spaces, but not 8.
>=20
> > +...
>=20
>=20
> Best regards,
> Krzysztof


