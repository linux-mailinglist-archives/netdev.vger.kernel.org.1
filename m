Return-Path: <netdev+bounces-161471-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7022A21BF6
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 12:16:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 076F81884A95
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 11:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ACD71DE2CF;
	Wed, 29 Jan 2025 11:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="lAryOmNl"
X-Original-To: netdev@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C4A1DE2C4
	for <netdev@vger.kernel.org>; Wed, 29 Jan 2025 11:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738149337; cv=none; b=VROs5bYTeinlcRK4Sy6bZ2zb0Uvu8OdtFEPCi9TAqc+PZy6Q/ccQdRffDo0aIC84BOjsbwnrqhNxCttr5Kzc3t8gqQBjvQDok6USTjDZ/IBosX0to4TUJKGW+4xzKC8Ry+8LjHNyrgDX0C22YWe2RS4+fDRA4l9GUUj2iGo28Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738149337; c=relaxed/simple;
	bh=MJsLvRSeOoUSSHDcVwIfXqsvThwM3b2jgUdx9AERp/o=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=SaX2RMrGTc9pOpTfJnDA+P8AtlgELVF47615nive3EfZD9QsYyVEpBwCNQwUoUmWdKrfLEclSP1h6k0BbV/UH1Hg9omJqFbR1LjGJTPr9YG0qNg3NVm5oDDvJks03IpunLUViGhj5qHg0CRH8DXuBwi6Hw3YIRlLG350jx71qMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=lAryOmNl; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250129111533epoutp04b209e5f66505e2ccf63e6b5f68d08ece~fJZwk-ruQ1184511845epoutp04U
	for <netdev@vger.kernel.org>; Wed, 29 Jan 2025 11:15:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250129111533epoutp04b209e5f66505e2ccf63e6b5f68d08ece~fJZwk-ruQ1184511845epoutp04U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1738149333;
	bh=7KafLwe5Ak864laadz4lWr0U4uUHjRPyDm3Um1r99to=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=lAryOmNlo8wF2Yt09qmbIalPFwNJwZisuwRl63Aw5mKAGzw73JwJ9rGVWvgLeCaFx
	 iSLSJDxGDoterQZvIOW5wJ3RrxHVcbZwi7VQlkJBfuuhwUJufH/PfzaKGjX1Pk2m55
	 hHEnSG+onKJDir/+mXS2NhXWPYfTqEux0WR02PVQ=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20250129111533epcas5p3fb6c773931fe4b1ec6a10c86d9dfa680~fJZv9gpLW2607226072epcas5p3J;
	Wed, 29 Jan 2025 11:15:33 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.176]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4Yjfhg52tRz4x9Pv; Wed, 29 Jan
	2025 11:15:31 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	7A.A6.19710.3DD0A976; Wed, 29 Jan 2025 20:15:31 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20250129091536epcas5p34ebefd253ea0f1dfd5156bf61d2178be~fHxBy2mfS1265012650epcas5p3i;
	Wed, 29 Jan 2025 09:15:36 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250129091536epsmtrp165ebd84cf7b218de312cb1eaa5292f00~fHxBwoZFK2781527815epsmtrp1D;
	Wed, 29 Jan 2025 09:15:36 +0000 (GMT)
X-AuditID: b6c32a44-363dc70000004cfe-91-679a0dd38b67
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	39.D8.18949.8B1F9976; Wed, 29 Jan 2025 18:15:36 +0900 (KST)
Received: from FDSFTE596 (unknown [107.122.82.131]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20250129091532epsmtip1c2376a781b64ca3de87ec443b8928834~fHw_L9rX62441124411epsmtip1O;
	Wed, 29 Jan 2025 09:15:32 +0000 (GMT)
From: "Swathi K S" <swathi.ks@samsung.com>
To: "'Andrew Lunn'" <andrew@lunn.ch>
Cc: <krzk@kernel.org>, <robh@kernel.org>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<conor+dt@kernel.org>, <richardcochran@gmail.com>,
	<mcoquelin.stm32@gmail.com>, <alim.akhtar@samsung.com>,
	<linux-fsd@tesla.com>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-samsung-soc@vger.kernel.org>,
	<alexandre.torgue@foss.st.com>, <peppe.cavallaro@st.com>,
	<joabreu@synopsys.com>, <rcsekar@samsung.com>, <ssiddha@tesla.com>,
	<jayati.sahu@samsung.com>, <pankaj.dubey@samsung.com>,
	<ravi.patel@samsung.com>, <gost.dev@samsung.com>
In-Reply-To: <63e64aa6-d018-4e45-acc7-f9d88a7db60f@lunn.ch>
Subject: RE: [PATCH v5 2/4] net: stmmac: dwc-qos: Add FSD EQoS support
Date: Wed, 29 Jan 2025 14:45:30 +0530
Message-ID: <002c01db722e$5abc8d10$1035a730$@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQDx5RsunPn3lkU9PtjwM0wRa6rGBAGYfFpdAhQG56QCgzy5ibTPFAeg
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA02TeUybZRzH97x927csdrwcbs9YcFhHFDaObtA9TBg7muXVzYAh0Wg0pYHX
	cvWgLUz8Q1GJhg6ZjLGUWkppUA6FSS215RzIMbdJwTHGiCychmPdZMyNww1bCsp/n+eb7+98
	8mMzvI2EHztVqqIVUlEGl7Udt/wSFBRyk6MVhy+pA9Hy7CWAxvQWFrKPdjLQD619GNLZ83BU
	3tXHRNM9EwS6c8WGoa5rlRi6a7zPRHb7jwTqtxQykWlyiInG595GN5t0LKSxt2FIPTTFRPqn
	dUzUY9iJHl+/B5Cx8RGB1uYbARr/q4VA2n4rE3XdmGGgtRYrgYxjBuaxPZS55g5GTZ9vJCib
	dpSgDKYsylSbz6J+qvyEslkXMepB2y0WVWiuBVRHG4+aXmplUOb2RUA9+6yMoBZNL8TveDc9
	OoUWJdOKAFqaJEtOlYpjuKcThCeFkfxwXggvCh3mBkhFEjqGKzgTH3IqNcO5Em5AtigjyynF
	i5RKbtjRaIUsS0UHpMiUqhguLU/OkEfIQ5UiiTJLKg6V0qojvPDwg5FOY2J6ymhhEy4f9v6w
	blKaCy57qoEHG5IR8A+rGqjBdrY32Qxg/3IToQZs5+MhgGWBLo83+RjAmRGvTX/dioHh9rcC
	qFnVbwTPANj8pAlzuVhkMDQWthEu9iX3QX3ZxXWdQfYx4bl+0lXAg3wVrmhed8k+5ClYPVUC
	XIyTgbDh4SDuYg4ZBS/kjwE3e8FfS6dwd5q98GeHjuFuKAAuT3/HdKX0deaxnXvFbdkFu5cL
	1vuE5JwHHLxvJ9x+AZx80gzc7APnes0buh+cPf/FBgvh94W3cDenwNGVIpabY+GVQR3uqsUg
	g+DlpjC37A9LrtVvTLgDfrU6hbl1DrTqN/kl+HR+aCPlbmj59gHxNeBqt0ym3TKZdssI2v+r
	GQBeC3bTcqVETCdFynlS+ux/f50kk5jA+rEEC6xguPxZaCfA2KATQDaD68t5v08j9uYki3I+
	ohUyoSIrg1Z2gkjnuosYfs8nyZzXJlUJeRFR4RF8Pj8i6hCfx93F+dyWJ/YmxSIVnU7Tclqx
	GYexPfxyse40cXbSAl4kekPTDAuuHlAXB/yOeHUfV2ftNUpjMyfWLtQTwd/ggw3H06r827w8
	wmDCm522+YGF4YriYqMhLuxwYZc1O/10qaOSNxLXcXcBtzg6ehUCHfO25mBK2ZL1ekuNztP8
	28k9jqrqoE+jfPP49bGv9YzUBhdILi3GvRiWeigx1XFvddySeYzaVlrV7khM6H2ugmc9IckR
	WOxBBdWCt7QfNDTum3jPnMT9shszlaQF/cmX8/Vn+PnK49suHq3ZX97o8/LqPzmJjyIYNQua
	/YH9FZUHhvyF7Z4wsy8+OrRmYFaVe/tv3w408M6JNc+zV48038C7A9dkO3E7i4srU0S8YIZC
	KfoXeU2tyLUEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupileLIzCtJLcpLzFFi42LZdlhJTnfHx5npBj+65Cx+vpzGaPFg3jY2
	i/N3DzFbrNl7jslizvkWFov5R86xWjw99ojd4uaBnUwWR04tYbK4t+gdq8X58xvYLS5s62O1
	2PT4GqvFw1fhFpd3zWGzmHF+H5NF17UnrBbz/q5ltTi2QMzi2+k3jBaLtn5ht/j/eiujxcMP
	e9gtZl3YwWpx5MwLZov/e3awWyx6sIDVQdpjy8qbTB5P+7eye+ycdZfdY8GmUo9NqzrZPDYv
	qffYueMzk8f7fVfZPPq2rGL0OLjP0OPpj73MHlv2f2b0+Nc0l93j8ya5AL4oLpuU1JzMstQi
	fbsEroy7fbtYCm4IVax9nNfAuJ6/i5GTQ0LARGLtrwXMILaQwG5GiW+79SHikhKfmqeyQtjC
	Eiv/PWfvYuQCqnnGKPH64FNGkASbgJbEor597CC2iICKxLy5U5hAipgFXrFKPDg9hQVi6itG
	iZdPlbsYOTg4Bawlfs3wAgkLC7hJrHgyFWwOi4CqxMZPV8DKeQUsJSZ1PmCEsAUlTs58wgLS
	yiygJ9G2ESzMLCAvsf3tHGaI2xQkfj5dxgpSIgI0cme3BkSJuMTRnz3MExiFZyEZNAth0Cwk
	g2Yh6VjAyLKKUTK1oDg3PbfYsMAoL7Vcrzgxt7g0L10vOT93EyM4uWhp7WDcs+qD3iFGJg7G
	Q4wSHMxKIryx52akC/GmJFZWpRblxxeV5qQWH2KU5mBREuf99ro3RUggPbEkNTs1tSC1CCbL
	xMEp1cDkaM4nE1AcpBrmdrP+pEWoxJ/+59nrfdUSbQOPpvDvUQlLzEoS4PrVZZmjo7J9i+jb
	80XHZi3iMnFVnvRYc7f2bsFHgrO+R4V/Y2VhO8D1eIH9e/ns4uaLX7VrohTPTN2pHzjv1kre
	2hl6DfmH/xaYtp5JEnznXRnuaFAQp2t9+EebkFFA16VSO/EnYosUp0i/DSg91JM6/9ex4wVb
	ww2z/2d8vnqt3i2He8VcvWN2hq8Pvdqzc+YJX47egweDfWYePSe+as98yci3tfL9nrLLvkaf
	35m3Za/nOrU9tQXVS85v/b7lWfp0nR/tly9vmdDsaLZk2fdH1XH8M7ZaLg9Z8141U+ecnd50
	p08GeTxKLMUZiYZazEXFiQBz2b4dnQMAAA==
X-CMS-MailID: 20250129091536epcas5p34ebefd253ea0f1dfd5156bf61d2178be
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
	<63e64aa6-d018-4e45-acc7-f9d88a7db60f@lunn.ch>



> -----Original Message-----
> From: Andrew Lunn <andrew@lunn.ch>
> Sent: 28 January 2025 19:19
> To: Swathi K S <swathi.ks@samsung.com>
> Cc: krzk@kernel.org; robh@kernel.org; davem@davemloft.net;
> edumazet@google.com; kuba@kernel.org; pabeni@redhat.com;
> conor+dt@kernel.org; richardcochran@gmail.com;
> mcoquelin.stm32@gmail.com; alim.akhtar@samsung.com; linux-
> fsd@tesla.com; netdev@vger.kernel.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org; linux-stm32@st-md-mailman.stormreply.com;
> linux-arm-kernel@lists.infradead.org; linux-samsung-soc@vger.kernel.org;
> alexandre.torgue@foss.st.com; peppe.cavallaro@st.com;
> joabreu@synopsys.com; rcsekar@samsung.com; ssiddha@tesla.com;
> jayati.sahu@samsung.com; pankaj.dubey@samsung.com;
> ravi.patel@samsung.com; gost.dev@samsung.com
> Subject: Re: [PATCH v5 2/4] net: stmmac: dwc-qos: Add FSD EQoS support
> 
> > +static int fsd_clks_endisable(void *priv, bool enabled) {
> > +	struct fsd_eqos_plat_data *plat = priv;
> > +
> > +	if (enabled) {
> > +		return clk_bulk_prepare_enable(plat->num_clks, plat->clks);
> > +	} else {
> > +		clk_bulk_disable_unprepare(plat->num_clks, plat->clks);
> > +		return 0;
> > +	}
> > +}
> > +
> > +static int fsd_eqos_probe(struct platform_device *pdev,
> > +			  struct plat_stmmacenet_data *data,
> > +			  struct stmmac_resources *res)
> > +{
> > +	struct fsd_eqos_plat_data *priv_plat;
> > +	struct clk *rx1 = NULL;
> > +	struct clk *rx2 = NULL;
> > +	int ret = 0;
> > +
> > +	priv_plat = devm_kzalloc(&pdev->dev, sizeof(*priv_plat),
> GFP_KERNEL);
> > +	if (!priv_plat)
> > +		return -ENOMEM;
> > +
> > +	priv_plat->dev = &pdev->dev;
> > +
> > +	ret = devm_clk_bulk_get_all(&pdev->dev, &priv_plat->clks);
> > +	if (ret < 0)
> > +		return dev_err_probe(&pdev->dev, ret, "No clocks
> available\n");
> > +
> > +	priv_plat->num_clks = ret;
> 
> It looks like you should be able to share all the clk_bulk code with
> tegra_eqos_probe(). The stmmac driver suffers from lots of cut/paste code
> with no consolidation. You can at least not make the tegra code worse by
> doing a little refactoring.

Hi Andrew, 
Just to clarify, you were referring to refactoring tegra code to use
clk_bulk APIs, right?
In that case, will look into this and evaluate the best approach for
refactoring the code. 

- Swathi

> 
> 	Andrew


