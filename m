Return-Path: <netdev+bounces-161469-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E153EA21BEB
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 12:15:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB34918840B6
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 11:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0CE81C1F08;
	Wed, 29 Jan 2025 11:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="G/QXJqzi"
X-Original-To: netdev@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57C01AF0AE
	for <netdev@vger.kernel.org>; Wed, 29 Jan 2025 11:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738149327; cv=none; b=vGW0gIrp1vUfiqL/z2HFbgvuRAELEcAL21c43EBwxvYfFDZgYJJi2cs1p+HjEXsySLqqxQZmu4heGtXuR96RKP0rp35rC31fj0gJPKmrfzvYzV8Z5JG41dgo/B+rKkY7pvjPNZJ7PzRu2ZvbvJmCsGUpS+97XgwJWJmSoxYSG2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738149327; c=relaxed/simple;
	bh=w7BOx0zum4AuYuHQakjSJS7SmueHWBCaPItsDDEf6zA=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=lEQfAlhjNueOOBdVtSE/vnWL52IRFTo1I6rU9tQTYfSLTCwhGTW4QfwjlJJpODczGoVhwi1p3Q+H95xYQdGN1bRF2Eumxf+DqA7eIk22pLiu3MDue97s3rY89Vpn2V+a4o67h3B2Y/B/J2WEWnj7N16uJro0B3gxLONaoL+HYzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=G/QXJqzi; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250129111524epoutp046e9fdafa8d3749194cc69d204b03a0fa~fJZnjtilz1405614056epoutp04B
	for <netdev@vger.kernel.org>; Wed, 29 Jan 2025 11:15:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250129111524epoutp046e9fdafa8d3749194cc69d204b03a0fa~fJZnjtilz1405614056epoutp04B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1738149324;
	bh=ZcfzEEK4rpXh178AQSfoTQbVahuntN4qN6ZBSy1oBdk=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=G/QXJqzihnkLEKLRvqZmfN5a62lOvBMVmzyCDY3z2S3JFSxZiAgwHQA7Q1PRwQXgS
	 AhQVclCqxSeW9fpuDZJ/28qtpxULK7mRKD918XeO2/YQf77DbXFrlAhpSMgv7OncSm
	 Q6avGX7vsVRRGnp9vkpO/FNw/kfr2ZoK2tD1YDpA=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20250129111523epcas5p306811cb166d7d2874f0abe31c74383f6~fJZmv2fwn1856018560epcas5p3t;
	Wed, 29 Jan 2025 11:15:23 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.181]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4YjfhV0722z4x9Pt; Wed, 29 Jan
	2025 11:15:22 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	43.59.19956.9CD0A976; Wed, 29 Jan 2025 20:15:21 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250129092008epcas5p1afd754d1fdf29c077e44da33911c7a5e~fH0_6Zg_W0863008630epcas5p1V;
	Wed, 29 Jan 2025 09:20:08 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250129092008epsmtrp16ca7b1a81cbe68922412bb2b9b402779~fH0_5QEb43075430754epsmtrp1f;
	Wed, 29 Jan 2025 09:20:08 +0000 (GMT)
X-AuditID: b6c32a4b-fd1f170000004df4-fc-679a0dc96945
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	14.4A.33707.8C2F9976; Wed, 29 Jan 2025 18:20:08 +0900 (KST)
Received: from FDSFTE596 (unknown [107.122.82.131]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20250129092004epsmtip24099c1610608817c69314cbd1170e56f~fH07RBse81197711977epsmtip2Z;
	Wed, 29 Jan 2025 09:20:04 +0000 (GMT)
From: "Swathi K S" <swathi.ks@samsung.com>
To: "'Russell King \(Oracle\)'" <linux@armlinux.org.uk>
Cc: <krzk@kernel.org>, <robh@kernel.org>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<conor+dt@kernel.org>, <richardcochran@gmail.com>,
	<mcoquelin.stm32@gmail.com>, <andrew@lunn.ch>, <alim.akhtar@samsung.com>,
	<linux-fsd@tesla.com>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-samsung-soc@vger.kernel.org>,
	<alexandre.torgue@foss.st.com>, <peppe.cavallaro@st.com>,
	<joabreu@synopsys.com>, <rcsekar@samsung.com>, <ssiddha@tesla.com>,
	<jayati.sahu@samsung.com>, <pankaj.dubey@samsung.com>,
	<ravi.patel@samsung.com>, <gost.dev@samsung.com>
In-Reply-To: <Z5jw7pUXEoGjLtgP@shell.armlinux.org.uk>
Subject: RE: [PATCH v5 2/4] net: stmmac: dwc-qos: Add FSD EQoS support
Date: Wed, 29 Jan 2025 14:50:02 +0530
Message-ID: <002f01db722e$fccac1d0$f6604570$@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQDx5RsunPn3lkU9PtjwM0wRa6rGBAGYfFpdAhQG56QBwxie/rTVFr5A
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0xTVxzHc3p7e1u1eodODsRBd3Em4MBWaTkgDBYe3oxFmUzdnK7r4Nry
	apuWTqZZxtCYSaCOP+qgYbziHDAZ2PFoGXRYmAgSykNw6DCAxfGYQmBbZA5ZoeD473N+5/v9
	vU4OF3OrJjy5Scp0RqOUpVKcDez6Vl9f/w6+US6s14vRwuRlgEaK6jnIPmzD0LXmbhYqtJ9n
	o+K2bhyN3xwj0FCLhYXaOq+w0IOyJziy22sI1FOvx5Hp4SCORqeOof7GQg7Kt1tZKHvQgSOb
	oRmgosUqHN0s2Y7+vv0HQGV1fxJoaboOoNHZJgIZe8w4auuawNBSk5lAZSMleMQOun+wF6Nr
	K4ZY9PilOoK2GIcJusSko02VFzn0j1c+py3meRY9Yx3g0PraSkDfsIro8afNTs/P84B+nvUN
	Qc+bvOK2HE8JVTCyREYjYJQJqsQkpTyMio2XRkrFEqHIXxSMgiiBUpbGhFFRb8f5xySlOpdD
	CT6RpeqcoTiZVkvteSNUo9KlMwKFSpseRjHqxFR1oDpAK0vT6pTyACWTHiISCveKncKPUhSX
	FzqB+smmjNq+Nk4m0G/MBjwuJAPh49HbnGV2I38CsKpiUzbY4OQ5AH+92Ia/OPxWU8pac8zZ
	r2Muh8V5MXbAJZoAsLP/Hli+4JB+sExvJZZ5GxkEDSuZeFyMHMGhsSIwG3C5PFIM+1rQcngr
	GQPLHYYVK5t8DX5R9teKnE8Gw36zA7j4JdhR4GC70njDhseFmKsfAVwYv4q7SsXApaoLwKVx
	h78s5GDLvUFyigdzyy2rhig4OdfDdvFWONVeS7jYE05eurDKUvi9fmBVo4DD/+RxXBwOW+4U
	spf7x0hfWN24xxV+BRo6f2C56m6Guc8cq7viQ3PRGvvAxenB1ZQesP7bGeIrQBnXjWZcN5px
	3QjG/6uVAHYl8GDU2jQ5oxWr9ymZ0y+eO0GVZgIrP8cv1gzGRmYDbIDFBTYAuRi1jX+yO1/u
	xk+UfXqG0aikGl0qo7UBsXPfeZjnywkq59dTpktFgcHCQIlEEhi8TyKi3PnnLOflbqRcls6k
	MIya0az5WFyeZybrM8V8YUVrQUvD/cy7kt3Td3enOHzeqylob/wgyeYA9jQvcV3EwQtbrO+D
	GF7GIVnH3uSs19U7J4L1kdITD/KjiuofhgTcCHr3456M2HtfHyFaBk4Iw322x6fsymo1sF+1
	wO92hEQZZiMc+Q1hx3sNEeydH5Y+MmQdePTlzLmwRj/jxtIcU67kzeuZ+w+/JcJIW99QKz94
	6eykyjteQwQoi0+FysZv3eHnTUYebr/G/t3rmEdl9cHiGWvicPPYfvHmW4kdXc93TT7V8k8l
	HwntxMtjm0zao5LeZF24e7QkpwMcPTTmbzgLFq92RVPP5hbPRFZ6/zsdXSc9qRCES06/E3mf
	YmsVMpEfptHK/gMYEgkUwgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sf0ySeRzH930eHp4HjXwSyy9aeVH5h1d0llff1u/WtWfVlqtWF+1SimdY
	ATrQfm+lNpdW1Fo4Y1SMmSuTmZwY3CUpYnXYxHSatXGngpXdnRlWkwotpJb/vfd5v1/vvf/4
	UHjsJSKB2qfKZdUqqULEjeLUNYmS5j8MXJb/9Mk3FQUHSgHquVrHRR6vE0dV9a0YMnhOcdA1
	VyuB+u/3kehpgx1DLnc5hv42DRLI47lNorY6LYEsvi4C9b7agTr+MHBRmceBoZIuP4GcunqA
	robMBLpvnIbet/wHkMn6lkRj/1oB6h26SyJ9m41ArkcvcTR210YiU4+RWD2d6eh6jDO1N59i
	TP95K8nY9V6SMVryGEtlMZf5vfwEY7cNY8xrRyeX0dZWAqbRkcr0j9R/Ye4NA2a04ArJDFtm
	psdIopbLWMW+g6x6wcrMqKzSoBvkDE46XNvu4p4E2ugSwKMgnQYDnhq8BERRsfQdALsH2rGI
	IYSBQh0R0QJ4c/QFGQk9B/DxUMO4waVToEnrIMM6jl4CdcUuIhzC6VEC3moq+kr4AQwMdoIS
	QFE8+mfY3oDCgIBeD2/4dSCsOfRcmG96N17Kp5fCDpsfRPQU+NdlPyeM4rQYFtWMn3E6Cd75
	34BHxv0Ag/0VRGTDejhmLvqaiYfNwbP4BSDQT2jSf2/ST2jSTyCMgFMJprI5GqVcuTcnVayR
	KjV5Krl4b7bSAsYfJ2WLDVRUh8ROgFHACSCFi+L4v7WWyWP5MumRo6w6O0Odp2A1TpBIcUTx
	/NmKYlksLZfmsgdYNodVf3MxipdwEov3bfUmhu7dqIornCt+lDTQhyVvjJksmDUi3PZmz5D9
	ePDBe41CNEvnGBGmL2uZHb+2wE3kLvzUEFhioF4nHije9arGOmNavpnnbtYv9u9ewZd1SuZI
	XBnXvaFD9dHJ7SdkduEZgXDAvHyNn+wdYrqzVNN11kD2S96OvrTuYEejdc3+/A+eUNzoj/sz
	B7nVfauan2T2NKUcPetYFANDhxtZR2WLz8aPPrM5vYpVFmzYOZIg3fLPuV2IU/NnZoXEXO1b
	ttqoCmqHE708T/D0rY0XF2Qcy9j+MRVbN4eXXPBLxXODu82Sdz7gT55XuOlg6aFfFwLiuqRW
	zt9ZnuZ7JuJosqSpKbhaI/0MhTgcj6cDAAA=
X-CMS-MailID: 20250129092008epcas5p1afd754d1fdf29c077e44da33911c7a5e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250128102732epcas5p4618e808063ffa992b476f03f7098d991
References: <20250128102558.22459-1-swathi.ks@samsung.com>
	<CGME20250128102732epcas5p4618e808063ffa992b476f03f7098d991@epcas5p4.samsung.com>
	<20250128102558.22459-3-swathi.ks@samsung.com>
	<Z5jw7pUXEoGjLtgP@shell.armlinux.org.uk>



> -----Original Message-----
> From: Russell King (Oracle) <linux@armlinux.org.uk>
> Sent: 28 January 2025 20:30
> To: Swathi K S <swathi.ks@samsung.com>
> Cc: krzk@kernel.org; robh@kernel.org; davem@davemloft.net;
> edumazet@google.com; kuba@kernel.org; pabeni@redhat.com;
> conor+dt@kernel.org; richardcochran@gmail.com;
> mcoquelin.stm32@gmail.com; andrew@lunn.ch; alim.akhtar@samsung.com;
> linux-fsd@tesla.com; netdev@vger.kernel.org; devicetree@vger.kernel.org;
> linux-kernel@vger.kernel.org; linux-stm32@st-md-mailman.stormreply.com;
> linux-arm-kernel@lists.infradead.org; linux-samsung-soc@vger.kernel.org;
> alexandre.torgue@foss.st.com; peppe.cavallaro@st.com;
> joabreu@synopsys.com; rcsekar@samsung.com; ssiddha@tesla.com;
> jayati.sahu@samsung.com; pankaj.dubey@samsung.com;
> ravi.patel@samsung.com; gost.dev@samsung.com
> Subject: Re: [PATCH v5 2/4] net: stmmac: dwc-qos: Add FSD EQoS support
> 
> On Tue, Jan 28, 2025 at 03:55:56PM +0530, Swathi K S wrote:
> > +struct fsd_eqos_plat_data {
> > +	struct clk_bulk_data *clks;
> > +	int num_clks;
> > +	struct device *dev;
> 
> You only write to this, so it serves no purpose in this patch. Please
remove.

Hi Russell, 
Thanks for reviewing.
Will remove  struct device *dev from struct fsd_eqos_plat_data

-Swathi

> 
> Thanks.
> 
> --
> RMK's Patch system: https://protect2.fireeye.com/v1/url?k=8378c0b8-
> e2f3d582-83794bf7-74fe4860008a-3788c416dc857e61&q=1&e=4d22ed29-
> 449b-46e6-90ba-
> 9b1470e01ecb&u=https%3A%2F%2Fwww.armlinux.org.uk%2Fdeveloper%2F
> patches%2F
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


