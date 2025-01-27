Return-Path: <netdev+bounces-161094-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EC00A1D490
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 11:32:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F1763A6DE1
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 10:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF4741FDA86;
	Mon, 27 Jan 2025 10:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="HhNeC7/I"
X-Original-To: netdev@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5861FCF55
	for <netdev@vger.kernel.org>; Mon, 27 Jan 2025 10:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737973964; cv=none; b=VvRhYDVHrVm2/Hycl0EdMbEb86G4ojF/IVTds/2dsa5LDsxZLXyjZxbvJpPeUb0zpgnGIWgRDQACed3Me120oq+1upzwvhzKa+lUjhGH+tstw7QCdx0hkHAWHVYAHcPn20oA+KwsGfL0hl/F3XywTMU3p9tCZH88xX5i6PU4nvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737973964; c=relaxed/simple;
	bh=nDQxahnbxNpxuKTdyEywdl9LsrttiGrst7UuaYPDD8M=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=STh0n8XPnm5i5qHQfE57f+SGOvseQXEN0j2TCunFlVH/0gn4ur2sbeN3BfhG9739G/X6/f8XaToneinXrbceRImHpouKHFQSxPUz3q/RChamadBK8AxoiRC1YhmMxy2Yz7VlUTzgjdx7oJMLECJeBmoqw+j7ZMd8AVWQOMVGPw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=HhNeC7/I; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250127103234epoutp016d3d2e6621acc915cff51f6bdde4abbd~ehhpdleww1579315793epoutp01D
	for <netdev@vger.kernel.org>; Mon, 27 Jan 2025 10:32:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250127103234epoutp016d3d2e6621acc915cff51f6bdde4abbd~ehhpdleww1579315793epoutp01D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1737973954;
	bh=gAKbZvqT9Q5ulJ/Foe0hjc3e2sZYmVIC2ncVLLWesbk=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=HhNeC7/I0KckDXx12XSCFAzqFYZQZSpZSXd+yptmt50VN0Gz6EKdkHHACZ3kCVOQg
	 lq5rTVL3XonLhhc1idtBHay4TOpIC8MBkgkF5jPgj1fbPVnQAZIPG1SgsDLGSCcX/v
	 dizzFkPWOrnq+pAw9GBQtS3l7Dpke5m4myYogi8w=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20250127103232epcas5p37c492ab6de27ec79418e15ac1aebe0a7~ehhogNBgG1368113681epcas5p3b;
	Mon, 27 Jan 2025 10:32:32 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.182]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4YhPqy5NQHz4x9Pp; Mon, 27 Jan
	2025 10:32:30 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	EA.FF.20052.EB067976; Mon, 27 Jan 2025 19:32:30 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20250127094514epcas5p2b5f3757a75c1871cdb219b904499aad9~eg4UzEjpb2884028840epcas5p2G;
	Mon, 27 Jan 2025 09:45:14 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250127094514epsmtrp17389931eaaa1a95b292eb46bac821181~eg4UxlJZm1933319333epsmtrp1e;
	Mon, 27 Jan 2025 09:45:14 +0000 (GMT)
X-AuditID: b6c32a49-3fffd70000004e54-77-679760beab57
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	B1.A5.18949.AA557976; Mon, 27 Jan 2025 18:45:14 +0900 (KST)
Received: from FDSFTE596 (unknown [107.122.82.131]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20250127094510epsmtip128b53f2a49647c74971dc89a8eacc94e~eg4QzWiyn0609506095epsmtip18;
	Mon, 27 Jan 2025 09:45:09 +0000 (GMT)
From: "Swathi K S" <swathi.ks@samsung.com>
To: "'Serge Semin'" <fancer.lancer@gmail.com>, "'Andrew Lunn'"
	<andrew@lunn.ch>
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
In-Reply-To: <yqih2sck5ayuhk5wcvgwahcndc4xb3gxthcjxgt4yqg33zfii5@ub25raxykxdp>
Subject: RE: [PATCH v4 2/4] net: stmmac: dwc-qos: Add FSD EQoS support
Date: Mon, 27 Jan 2025 15:15:08 +0530
Message-ID: <085201db70a0$29d736d0$7d85a470$@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQD2Gw94KDf30OIcDBeWExyH9iGvOgIzKibnAjAKSeACs1P8YLS8UVdQ
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0xbVRzHc+7t7W2ZjAubcEDH8M4ZwBQoK3iAVRbdyDUaBcmE+QhUuCkM
	uK1tQTE+5mAGcGMSYLCG8RKnsKGsa0tBYIzXhCltpqAYeSmMx9yzk8AYYqFF+e/z+57f43zP
	yU+AuzWSXoJUTsOqOFk6zXfiGbv9/EQdiWXyINOPvmhp7hRAE5VGPjKPduHofPsghirMuTxU
	1TNIoOm+P0jUlFdBoJHOFgz1DNRhaKz2FoHM5iYSWYyFBNL9OUygyfk49FNrBR+VmzswVDA8
	RaDKlUYC9VW7o4WrfwFUa7hPotUbBoAm77SRSGsxEajnh1kcrbaZSFQ7UU3se5zR149gzPRJ
	A8m0aEdJplqXyega8vnMxbqPmRaTFWNudwzxmUJ9A2Aud4iZ6cV2nNFfsgLmn6NnSMaq847e
	+nra3hRWlsyqfFguSZGcysml9IuxCc8nhIQGiUXiMPQM7cPJMlgpvf+laFFUarrtXWifLFl6
	pk2KlqnVdOCze1WKTA3rk6JQa6Q0q0xOV0qUAWpZhjqTkwdwrCZcHBQUHGJLTExLKTUM8JUl
	r7xnGSsCR0BvZAEQCiAlgebuOrwAOAncqO8ANMx2AntwD8D+lTJHsABgjTGHt1Hy2xfHSPtB
	O4Bnj111BLMAPqgpINey+JQ/rC3sWOftVAxsW8pbr8apQQJ+ZqHWWEi9DMt/XQZrvI2Kggbj
	N9ga86jdsOQr47ruTIXB4uExzM6usP/0lKPPTth8swK338gHLk2fJeyzomBO3QW+PccD9i4d
	XzcHqXtCONNdRtgL9sOpM1dIO2+D81f0DvaCcyc/dXACPFc45LCcAkcfFPHtHAk7f66w6QLb
	AD/4bWugXd4BSwfs98eprfDE8hRm152hqXKDd8GVG8OOlp7Q+OVt8nNAazdZ026ypt1kQfv/
	tGrAawCerFKdIWfVIUoxx777348nKTJ0YH1v/F8wgdGJOwFdABOALgAFOL3dOX+kRO7mnCzL
	fp9VKRJUmemsuguE2N67CPd6NElhWzxOkyCWhAVJQkNDJWF7QsW0h3NOS67cjZLLNGwayypZ
	1UYdJhB6HcESRb/oh6oP58U8PJh7eNUa764fnQe+Uhfh6bsBu44HS8l9l6PDx71fRRHn5R59
	rwXXxMRmM3Nv3Dy1238xTBpYLHE3uCYsjkRYaJfe4B2YKO7r4sRrUQ+XmvAs6y0Zn34snjv0
	hL4/4kKbZeCA1Y0ODh8VaT8a6f7wLT8uK+96n+7a78/NNGeXrwZYxn0N1WXxLsIDjd+LI1Zm
	TlQm1xQy3GCaKEfh1lVWoSl9Z8ue9vrSWu/lCGPqRc2TTk73e4rUWa45zZP7zpmdI5/Kf7vp
	buw0D40fKvWLE5vilF2TrcVH3wz94NIjwno4X7Vzi6J4Ifjplv6Vv6uoT5LyPU0Hr9M8dYpM
	7I+r1LJ/AShiTnHABAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMKsWRmVeSWpSXmKPExsWy7bCSnO6q0OnpBvf3s1n8fDmN0eLBvG1s
	FufvHmK2WLP3HJPFnPMtLBbzj5xjtXh67BG7xYaOOawWNw/sZLI4cmoJk8W9Re9YLc6f38Bu
	cWFbH6vFpsfXWC0evgq3uLxrDpvFjPP7mCy6rj1htZj3dy2rxbEFYhbfTr9htFi09Qu7xf/X
	WxktHn7Yw24x68IOVosjZ14wW/zfs4PdYtGDBawOMh5bVt5k8njav5XdY+esu+weCzaVemxa
	1cnmsXlJvcfOHZ+ZPN7vu8rm0bdlFaPHwX2GHk9/7GX22LL/M6PHv6a57B6fN8kF8EVx2aSk
	5mSWpRbp2yVwZUzdeoqtYIp/xYV7ExkbGI/adzFyckgImEjcWtzK3sXIxSEksJtR4tDCx6wQ
	CUmJT81ToWxhiZX/nkMVPWOUmPz6FDNIgk1AS2JR3z52EFtEIFDizsanbCBFzAKvWCUenJ7C
	ApIQEvjLKLH2WTGIzSngJzHjxm9GEFtYwE1i67Z1TCA2i4CqxJTl28DivAKWEpOv3WOCsAUl
	Ts58AjSHA2ionkTbRrASZgF5ie1v5zBDHKcg8fPpMlaIG9wkmpdsZIOoEZc4+rOHeQKj8Cwk
	k2YhTJqFZNIsJB0LGFlWMUqmFhTnpucWGxYY5aWW6xUn5haX5qXrJefnbmIEpxstrR2Me1Z9
	0DvEyMTBeIhRgoNZSYS38+aUdCHelMTKqtSi/Pii0pzU4kOM0hwsSuK83173pggJpCeWpGan
	phakFsFkmTg4pRqYmGN6Tm7I5vq0UnMGq2rZV3bxou83bsu47rMpfNQZk8SeM9evPvn/2dfn
	m7LuGhfdWzXX9l/VqeJFix/eWb9B8tid04dW1l7Qtfz6c+/9zmIFyxmrJEKECxJfv3p6o72T
	P4O/bE396qlVKYJBDbdun/WZNvnkiv2BGcv9Db/EzVl4omDelaQHIeGPXx5/G83yMXXCrLe3
	vdd/C3nHm7M2oCfGh3MR//nfbYfVFs7eWrXlfbjZ/78OzxxEZ5jU/HzoKzI3nlGD++Cla4Z6
	K2ykg+b7BMgwT7z12Ng/MqvSqOjkH0fra7O8bQ6yvnbsEsrZbZ1bPjNiw5LypC+rfTgDM1bJ
	2NmvEekqjVu651uCrBJLcUaioRZzUXEiANgTawmmAwAA
X-CMS-MailID: 20250127094514epcas5p2b5f3757a75c1871cdb219b904499aad9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240730092902epcas5p1520f9cac624dad29f74a92ed4c559b25
References: <20240730091648.72322-1-swathi.ks@samsung.com>
	<CGME20240730092902epcas5p1520f9cac624dad29f74a92ed4c559b25@epcas5p1.samsung.com>
	<20240730091648.72322-3-swathi.ks@samsung.com>
	<yqih2sck5ayuhk5wcvgwahcndc4xb3gxthcjxgt4yqg33zfii5@ub25raxykxdp>



> -----Original Message-----
> From: Serge Semin <fancer.lancer@gmail.com>
> Sent: 02 August 2024 00:40
> To: Swathi K S <swathi.ks@samsung.com>; Andrew Lunn <andrew@lunn.ch>
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
> Subject: Re: [PATCH v4 2/4] net: stmmac: dwc-qos: Add FSD EQoS support
> 
> Hi Swathi, Andrew
> 
> On Tue, Jul 30, 2024 at 02:46:46PM +0530, Swathi K S wrote:
> > The FSD SoC contains two instance of the Synopsys DWC ethernet QOS IP
> core.
> > The binding that it uses is slightly different from existing ones
> > because of the integration (clocks, resets).
> >
> 
> > For FSD SoC, a mux switch is needed between internal and external
clocks.
> > By default after reset internal clock is used but for receiving
> > packets properly, external clock is needed. Mux switch to external
> > clock happens only when the external clock is present.
> >
> > Signed-off-by: Chandrasekar R <rcsekar@samsung.com>
> > Signed-off-by: Suresh Siddha <ssiddha@tesla.com>
> > Signed-off-by: Swathi K S <swathi.ks@samsung.com>
> > ---
> >  .../stmicro/stmmac/dwmac-dwc-qos-eth.c        | 90
> +++++++++++++++++++
> >  .../net/ethernet/stmicro/stmmac/stmmac_main.c | 28 +++++-
> >  include/linux/stmmac.h                        |  1 +
> >  3 files changed, 117 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
> > b/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
> > index ec924c6c76c6..bc97b3b573b7 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
> > @@ -20,6 +20,7 @@
> >  #include <linux/platform_device.h>
> >  #include <linux/reset.h>
> >  #include <linux/stmmac.h>
> > +#include <linux/regmap.h>
> >
> >  #include "stmmac_platform.h"
> >  #include "dwmac4.h"
> > @@ -37,6 +38,13 @@ struct tegra_eqos {
> >  	struct gpio_desc *reset;
> >  };
> >
> > +struct fsd_eqos_plat_data {
> > +	const struct fsd_eqos_variant *fsd_eqos_inst_var;
> > +	struct clk_bulk_data *clks;
> > +	int num_clks;
> > +	struct device *dev;
> > +};
> > +
> >  static int dwc_eth_dwmac_config_dt(struct platform_device *pdev,
> >  				   struct plat_stmmacenet_data *plat_dat)  {
> @@ -265,6 +273,82 @@
> > static int tegra_eqos_init(struct platform_device *pdev, void *priv)
> >  	return 0;
> >  }
> >
> > +static int dwc_eqos_rxmux_setup(void *priv, bool external) {
> > +	int i = 0;
> > +	struct fsd_eqos_plat_data *plat = priv;
> > +	struct clk *rx1 = NULL;
> > +	struct clk *rx2 = NULL;
> > +	struct clk *rx3 = NULL;
> > +
> > +	for (i = 0; i < plat->num_clks; i++) {
> > +		if (strcmp(plat->clks[i].id, "eqos_rxclk_mux") == 0)
> > +			rx1 = plat->clks[i].clk;
> > +		else if (strcmp(plat->clks[i].id, "eqos_phyrxclk") == 0)
> > +			rx2 = plat->clks[i].clk;
> > +		else if (strcmp(plat->clks[i].id, "dout_peric_rgmii_clk") ==
0)
> > +			rx3 = plat->clks[i].clk;
> > +	}
> > +
> > +	/* doesn't support RX clock mux */
> > +	if (!rx1)
> > +		return 0;
> > +
> > +	if (external)
> > +		return clk_set_parent(rx1, rx2);
> > +	else
> > +		return clk_set_parent(rx1, rx3);
> > +}
> 
> Andrew is right asking about this implementation. It does seem
> questionable:
> 
> 1. AFAIR RGMII Rx clock is supposed to be retrieved the PHY. So the
> eqos_phyrxclk and dout_peric_rgmii_clk are the PHY clocks. Do you have a
> PHY integrated in the SoC? If so you should have defined it as a separate
DT-
> node and moved the clocks definition in there.

In this case, there is no PHY integrated in the SoC.

> 
> 2. Do you really need to perform the "eqos_rxclk_mux" clock re-parenting
on
> each interface open/close? Based on the commit log you don't. So the re-
> parenting can be done in the glue driver or even in the device tree by
means
> of the "assigned-clock-parents" property.

Thanks for the insight, we investigated further and realized that this is
not mandatory. So I will remove the reparenting done in every open/ close in
the updated patchset v5.

-Swathi

> 
> -Serge(y)
> 
> > +
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
> > +
> > +	data->bsp_priv = priv_plat;
> > +	data->clks_config = fsd_clks_endisable;
> > +	data->rxmux_setup = dwc_eqos_rxmux_setup;
> > +
> > +	ret = fsd_clks_endisable(priv_plat, true);
> > +	if (ret)
> > +		return dev_err_probe(&pdev->dev, ret, "Unable to enable
> fsd
> > +clock\n");
> > +
> > +	return 0;
> > +}
> > +
> > +static void fsd_eqos_remove(struct platform_device *pdev) {
> > +	struct fsd_eqos_plat_data *priv_plat =
> > +get_stmmac_bsp_priv(&pdev->dev);
> > +
> > +	fsd_clks_endisable(priv_plat, false); }
> > +
> >  static int tegra_eqos_probe(struct platform_device *pdev,
> >  			    struct plat_stmmacenet_data *data,
> >  			    struct stmmac_resources *res)
> > @@ -411,6 +495,11 @@ static const struct dwc_eth_dwmac_data
> tegra_eqos_data = {
> >  	.remove = tegra_eqos_remove,
> >  };
> >
> > +static const struct dwc_eth_dwmac_data fsd_eqos_data = {
> > +	.probe = fsd_eqos_probe,
> > +	.remove = fsd_eqos_remove,
> > +};
> > +
> >  static int dwc_eth_dwmac_probe(struct platform_device *pdev)  {
> >  	const struct dwc_eth_dwmac_data *data; @@ -473,6 +562,7 @@
> static
> > void dwc_eth_dwmac_remove(struct platform_device *pdev)  static const
> > struct of_device_id dwc_eth_dwmac_match[] = {
> >  	{ .compatible = "snps,dwc-qos-ethernet-4.10", .data =
> &dwc_qos_data },
> >  	{ .compatible = "nvidia,tegra186-eqos", .data = &tegra_eqos_data },
> > +	{ .compatible = "tesla,fsd-ethqos", .data = &fsd_eqos_data },
> >  	{ }
> >  };
> >  MODULE_DEVICE_TABLE(of, dwc_eth_dwmac_match); diff --git
> > a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > index 12689774d755..2ef82edec522 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > @@ -4001,6 +4001,12 @@ static int __stmmac_open(struct net_device
> *dev,
> >  	netif_tx_start_all_queues(priv->dev);
> >  	stmmac_enable_all_dma_irq(priv);
> >
> > +	if (priv->plat->rxmux_setup) {
> > +		ret = priv->plat->rxmux_setup(priv->plat->bsp_priv, true);
> > +		if (ret)
> > +			netdev_err(priv->dev, "Rxmux setup failed\n");
> > +	}
> > +
> >  	return 0;
> >
> >  irq_error:
> > @@ -4056,7 +4062,13 @@ static void stmmac_fpe_stop_wq(struct
> > stmmac_priv *priv)  static int stmmac_release(struct net_device *dev)
> > {
> >  	struct stmmac_priv *priv = netdev_priv(dev);
> > -	u32 chan;
> > +	u32 chan, ret;
> > +
> > +	if (priv->plat->rxmux_setup) {
> > +		ret = priv->plat->rxmux_setup(priv->plat->bsp_priv, false);
> > +		if (ret)
> > +			netdev_err(priv->dev, "Rxmux setup failed\n");
> > +	}
> >
> >  	if (device_may_wakeup(priv->device))
> >  		phylink_speed_down(priv->phylink, false); @@ -7848,11
> +7860,17 @@
> > int stmmac_suspend(struct device *dev)  {
> >  	struct net_device *ndev = dev_get_drvdata(dev);
> >  	struct stmmac_priv *priv = netdev_priv(ndev);
> > -	u32 chan;
> > +	u32 chan, ret;
> >
> >  	if (!ndev || !netif_running(ndev))
> >  		return 0;
> >
> > +	if (priv->plat->rxmux_setup) {
> > +		ret = priv->plat->rxmux_setup(priv->plat->bsp_priv, false);
> > +		if (ret)
> > +			netdev_err(priv->dev, "Rxmux setup failed\n");
> > +	}
> > +
> >  	mutex_lock(&priv->lock);
> >
> >  	netif_device_detach(ndev);
> > @@ -8018,6 +8036,12 @@ int stmmac_resume(struct device *dev)
> >  	mutex_unlock(&priv->lock);
> >  	rtnl_unlock();
> >
> > +	if (priv->plat->rxmux_setup) {
> > +		ret = priv->plat->rxmux_setup(priv->plat->bsp_priv, true);
> > +		if (ret)
> > +			netdev_err(priv->dev, "Rxmux setup failed\n");
> > +	}
> > +
> >  	netif_device_attach(ndev);
> >
> >  	return 0;
> > diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h index
> > 84e13bd5df28..f017b818d421 100644
> > --- a/include/linux/stmmac.h
> > +++ b/include/linux/stmmac.h
> > @@ -264,6 +264,7 @@ struct plat_stmmacenet_data {
> >  	void (*ptp_clk_freq_config)(struct stmmac_priv *priv);
> >  	int (*init)(struct platform_device *pdev, void *priv);
> >  	void (*exit)(struct platform_device *pdev, void *priv);
> > +	int (*rxmux_setup)(void *priv, bool external);
> >  	struct mac_device_info *(*setup)(void *priv);
> >  	int (*clks_config)(void *priv, bool enabled);
> >  	int (*crosststamp)(ktime_t *device, struct system_counterval_t
> > *system,
> > --
> > 2.17.1
> >
> >


