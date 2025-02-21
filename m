Return-Path: <netdev+bounces-168504-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6EA7A3F2E6
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 12:26:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8093917FF10
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 11:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C480020767A;
	Fri, 21 Feb 2025 11:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="HFyo8V+W"
X-Original-To: netdev@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4B92AE89
	for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 11:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740137205; cv=none; b=hpcB2EDttMCH2wp5+DIwllrNjTykMDyROV+9Ckcg8Ss0nevtaqNmWZp2qCl4Ap+H7UTkH9tVtNJexTxVjfGwxGlHtKESJc+qvOEfa0w+TEQNQ37A2mHKCPMwS2G7bEf8ZlXhyGMHCT0taDxUp7IOXDO961U430T/J4ajt6DzArc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740137205; c=relaxed/simple;
	bh=1Dc+HlFCO4DtuoykWFJMsvnkcwYITFyIzYIw9vMx0RE=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=eB5p9i0TwkJ8RcZQiE2vhsVRrND1VMl9/TCLOCSc9F2sTs7WjRJc/ZObvT8BvF+Mhn8ZXs4JbVpQ0U4rTIPTzahSZk1/KQFuwbNA/gAfvezY93PC90Hyu+3KHU7Lyh2c2VQBuLgJPIG9Drs4URLgZTbyhBAT5ZcVJR+pSm2XHlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=HFyo8V+W; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250221112641epoutp03d923dfe048efb3e2b9b7a1c98674ed81~mNZCYyxdD1964419644epoutp037
	for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 11:26:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250221112641epoutp03d923dfe048efb3e2b9b7a1c98674ed81~mNZCYyxdD1964419644epoutp037
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1740137201;
	bh=FC2a7r9b8EaahE6S8ThbScqtlkOLkA61RMYEzBudLJI=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=HFyo8V+W0oGfVIpcTeOwk/8/jS7xJYoO3JULX3QBONh3AX2nZ4gSaOEKVZ2pT9kfJ
	 Tb19EHyWZB2cV363RbDMYC5MHLAFipwFb/pvfXNog5DOl4sIJLWhDkuDanVtS8MVln
	 WbMQcFMQ6rbvoT+pELm7qY7KmDIeAqiAvlj8KDV4=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20250221112640epcas5p2b59e9083652c09779847fba4ea0ba7b5~mNZByuAuO1579915799epcas5p2L;
	Fri, 21 Feb 2025 11:26:40 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.176]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4Yznrt4zKrz4x9Pv; Fri, 21 Feb
	2025 11:26:38 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	85.8A.19933.EE268B76; Fri, 21 Feb 2025 20:26:38 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20250221103441epcas5p2c8e62837664debd0d110c4867101b6ee~mMroj_Z6p3072330723epcas5p2h;
	Fri, 21 Feb 2025 10:34:41 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250221103441epsmtrp1d7e41e6faff723be9bc894665ae37201~mMrojJCUO3243132431epsmtrp1K;
	Fri, 21 Feb 2025 10:34:41 +0000 (GMT)
X-AuditID: b6c32a4a-c1fda70000004ddd-ed-67b862eeb0fa
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	D6.65.33707.0C658B76; Fri, 21 Feb 2025 19:34:40 +0900 (KST)
Received: from FDSFTE596 (unknown [107.122.82.131]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20250221103435epsmtip29eb15f0027d30a7bbbce44d7a9e548d3~mMrjithd30551405514epsmtip2G;
	Fri, 21 Feb 2025 10:34:35 +0000 (GMT)
From: "Swathi K S" <swathi.ks@samsung.com>
To: "'Russell King \(Oracle\)'" <linux@armlinux.org.uk>
Cc: <krzk+dt@kernel.org>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<robh@kernel.org>, <conor+dt@kernel.org>, <richardcochran@gmail.com>,
	<mcoquelin.stm32@gmail.com>, <alexandre.torgue@foss.st.com>,
	<netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<pankaj.dubey@samsung.com>, <ravi.patel@samsung.com>, <gost.dev@samsung.com>
In-Reply-To: <Z7cimPBdZ3W9GKmI@shell.armlinux.org.uk>
Subject: RE: [PATCH v7 2/2] net: stmmac: dwc-qos: Add FSD EQoS support
Date: Fri, 21 Feb 2025 16:04:25 +0530
Message-ID: <02b701db844c$36b7aeb0$a4270c10$@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGZEuZRAcWsCKSMCeR5cs/NRCOZvwH8VK0qAZITr+wCOUn/krOoNIYg
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0xTVxzHc+6jtxBrLojzwIKy62vgKC1ry8WJbpPhjZsR2CvBbfVC7wqh
	tF0fG4qmLhAizUAgotARID5YhkOyyqMVC8gKuI2hhNGlWVh4PzYcZIoZEHWUi47/Pr9fvr/f
	93zPyRGigcuCEGGG1sQZtKyGEvhjzT+Eh0f+nepQSxqvU/TizAVAfzPswOnvXH0IXXk3D6Or
	3X04PdE9StDeDidCz9j+END3motw2j7mwemBm5UC2uoZx+nOMhegqx7X43R3zQv0o59nAX2p
	6SFBj8zfImh37zRKP73lIF4PYgY8/SjT+K0XYSbONRGM0zZEMDV2M2OvKxAwN65YGKfjAcLM
	tQ0KmKLGOsDcbpMyD+xbEzekZO5L51gVZwjjtGk6VYZWHUe9/a7yoFKukEgjpbF0DBWmZbO4
	OCr+ncTIhAzNSkwq7HNWY15pJbJGIxW1f59BZzZxYek6oymO4vQqjV6mFxvZLKNZqxZrOdNe
	qUQSLV8RHs9M73PMEvqv5dnV+cPIGXBtjxX4CSEpg/1zVwRW4C8MJFsBnHL343zxD4DfN1Rj
	z4v6p27UCoSrI1NjJr7vBHChoJ7gi2kAR4YKEN9eARkBLxW1ET4OImNgWYF7dS1KlmKwvGkS
	8W3yI+XwrAv4NJvIBOiZ7F3VY+ROODzvxnwsImPhbOs0wXMA/LFifLWPkttgy/1KlM8QBhcn
	anHeKwHW1j3Cec0W2LX4FerzheRlPzju6kf4gXhY0VuI87wJ/tnTSPAcAmfO5a+xEl4rGsR4
	TodDSyUCng/Ajl8rMd/5UTIcNtyM4tuhsOyn6wjvuxEWLo+vWYmgo+oZb4eP//KsrQyGzVfn
	iGJA2dZFs62LZlsXwfa/Ww3A6kAwpzdmqTmjXB+t5b54/uBpuiw7WP0FEYcdYGR4XtwJECHo
	BFCIUkGifEujOlCkYk+c5Aw6pcGs4YydQL5y3yVoyOY03co30pqUUlmsRKZQKGSxryqk1BZR
	rjNPHUiqWROXyXF6zvBsDhH6hZxBZMm7TtWeh6VbS5Psd9w7Hvb82x0sGevqbVko5dKoE32Y
	cohi8L0XLKacHUkxTs2u0ZzTztPn7R/lvXb02HZZxVR5WULNJ9jAKZkjSyzusVydV2+cR1sK
	ygND0WJMnGueaveaDy3e2JmSpCgZ8AZE3M1eOvJZk/zO7d9m38jtuDhAfMAIvYUv92YnZcvb
	qzIsX+7xSjJ1v9QvPdk8pSrOtV1Wtx77OGHwoNUZyrafTd0/eeD9Ghd2HM353b2sOhmw+/Ar
	91Lvb9iWFMI1PLH5tSezKersrhdD8z+ti7bEE6N97HvauIvRTov1pQaPK+pQf/nCQq7Vv/vD
	5uC3RMlvHqUwYzorjUANRvY/ThNrt44EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0iTYRTGe7/7JOXzkr5qWC26sHBlWL3liOhiH0F3KRPCln6utWlrUyuz
	FIyRw1ZRCq2hZst0KeK8zUorWwvJSyXOtNsqLRNNyzAks5oj8r+Hc57fc54/DoP7vCaCGHlS
	Mq9OkiqFlAdR+1A4J/T+HqtsWetYBBr/nAfQTaeVRGUNbRgytp8hUIGtjUR99vc06r5fj6HP
	hjcUelqrJ5Hlg4NEHbeNFNI5eknUlNsAUP6vchLZC/3R2JNBgIpqvtPo3chdGtla+nH0+66V
	XufHdTie4Vx1aTfG9Z2vobl6w2uaK7SkcBZzNsVVmTK4eusoxg03dlKcvtoMuAeNYdyoJWTH
	zBgPSTyvlKfy6qVrD3gcarMO0qqrK44XaJ1YJri1RAcYBrLh8NOHZB3wYHzYOgDbr5VgOiD4
	Ow+E37JySbf2haWTn2i36SOA3cMXKNeCYkWwSN9Iu7QfuwrmZttIlwlnSwj4ovEV4SZ6ASzr
	Kadc5wTsCni2AbgAXzYSOj62TMEEuwA6R2yES3uyq+HgnX7arb1h85VewoXirBhqK6dQnJ0D
	64aMuLvcXDjeV0y6O0TCYvMY6fYEwEfjOfgF4GuYlmT4n2SYlmSYRhQCwgxm8SpNoiwxThUm
	1kgTNSlJMnHckUQLmPoA0S4rKK74JW4CGAOaAGRwoZ+nNqNa5uMZLz2RxquPxKpTlLymCQQz
	hDDAc74yO96HlUmTeQXPq3j1vy3GCIIysXMqTf66SoUjpOJHaHCOZFPCCUVq7Clx1MG92wV5
	y7vR/rIue0Deev/be7qW/BjYNjyv3DwjPGZ2ZJE+dKR1d+yM/psLIx53TXbEOdeezL3Ya5rZ
	vM+UL/cv2v713gbyzEaRRCXKejk0+YK6VHxyU8ciZ34431kuOS067Pd2sTxziEpYOtAzYRdK
	JU8nsKPLn8sEip3VPaYb9RrSuPfeyuCGpCivFu+q9Ah8KDZjy/VrXjBVniM93G6/sSU9oDnN
	pgv5Yp0cfZTe93OiZjzmJxVVYLRVaQey1ng9SaigXraleitGC8XHQqO/RwcpT6cdi78cadKL
	Nrdu1QZ2cuRWc6CQ0BySholwtUb6Bw/KCtdwAwAA
X-CMS-MailID: 20250221103441epcas5p2c8e62837664debd0d110c4867101b6ee
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250220044132epcas5p305e4ed7ed1c84f9800299c2091ea0790
References: <20250220043712.31966-1-swathi.ks@samsung.com>
	<CGME20250220044132epcas5p305e4ed7ed1c84f9800299c2091ea0790@epcas5p3.samsung.com>
	<20250220043712.31966-3-swathi.ks@samsung.com>
	<Z7cimPBdZ3W9GKmI@shell.armlinux.org.uk>



> -----Original Message-----
> From: Russell King (Oracle) <linux@armlinux.org.uk>
> Sent: 20 February 2025 18:10
> To: Swathi K S <swathi.ks@samsung.com>
> Cc: krzk+dt@kernel.org; andrew+netdev@lunn.ch; davem@davemloft.net;
> edumazet@google.com; kuba@kernel.org; pabeni@redhat.com;
> robh@kernel.org; conor+dt@kernel.org; richardcochran@gmail.com;
> mcoquelin.stm32@gmail.com; alexandre.torgue@foss.st.com;
> netdev@vger.kernel.org; devicetree@vger.kernel.org; linux-stm32@st-md-
> mailman.stormreply.com; linux-arm-kernel@lists.infradead.org; linux-
> kernel@vger.kernel.org; pankaj.dubey@samsung.com;
> ravi.patel@samsung.com; gost.dev@samsung.com
> Subject: Re: [PATCH v7 2/2] net: stmmac: dwc-qos: Add FSD EQoS support
> 
> On Thu, Feb 20, 2025 at 10:07:12AM +0530, Swathi K S wrote:
> > +static int fsd_eqos_probe(struct platform_device *pdev,
> > +			  struct plat_stmmacenet_data *data,
> > +			  struct stmmac_resources *res)
> > +{
> > +	struct clk *clk_rx1 = NULL;
> > +	struct clk *clk_rx2 = NULL;
> > +
> > +	for (int i = 0; i < data->num_clks; i++) {
> > +		if (strcmp(data->clks[i].id, "slave_bus") == 0)
> > +			data->stmmac_clk = data->clks[i].clk;
> > +		else if (strcmp(data->clks[i].id, "eqos_rxclk_mux") == 0)
> > +			clk_rx1 = data->clks[i].clk;
> > +		else if (strcmp(data->clks[i].id, "eqos_phyrxclk") == 0)
> > +			clk_rx2 = data->clks[i].clk;
> > +	}
> > +
> > +	/* Eth0 RX clock doesn't support MUX */
> > +	if (clk_rx1)
> > +		clk_set_parent(clk_rx1, clk_rx2);
> 
> Isn't there support in DT for automatically setting the clock tree?
> See
> https://protect2.fireeye.com/v1/url?k=f0089f78-90ea0225-f0091437-
> 000babd9f1ba-cf835b8b94ccd94a&q=1&e=4ae794ec-f443-4d77-aee4-
> 449f53a3a1a4&u=https%3A%2F%2Fgithub.com%2Fdevicetree-org%2Fdt-
> schema%2Fblob%2Fmain%2Fdtschema%2Fschemas%2Fclock%2Fclock.yaml
> %23L24
> 
> Also, I think a cleanup like the below (sorry, it's on top of other
patches I'm
> working on at the moment but could be rebased) would make sense.
> 
> With both of these, this should mean that your changes amount to:
> 
> 1. making data->probe optional
> 2. providing a dwc_eth_dwmac_data structure that has .stmmac_clk_name
>    filled in
> 3. adding your compatible to the match data with a pointer to the
>    above structure.

Hi Russell, 
Thanks for your input.
Will implement this in v8.
But I could not find your patch 'net: stmmac: clean up clock initialisation'
in mailing list
Could you point me to that?
Or do you want me to integrate the below changes into my patch series and
post?

Please let me know

- Swathi

> 
> In other words, support for your device becomes just a matter of adding
data
> structures rather than a chunk of extra code.
> 
> Thanks.
> 
> 8<====
> From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
> Subject: [PATCH net-next] net: stmmac: clean up clock initialisation
> 
> Clean up the clock initialisation by providing a helper to find a named
clock in
> the bulk clocks, and provide the name of the stmmac clock in match data so
> we can locate the stmmac clock in generic code.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>  .../stmicro/stmmac/dwmac-dwc-qos-eth.c        | 32 +++++++++++--------
>  1 file changed, 18 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
> b/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
> index 581c0b40db57..8e343ab7a7e2 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
> @@ -34,6 +34,16 @@ struct tegra_eqos {
>  	struct gpio_desc *reset;
>  };
> 
> +static struct clk *dwc_eth_find_clk(struct plat_stmmacenet_data
*plat_dat,
> +				    const char *name)
> +{
> +	for (int i = 0; i < plat_dat->num_clks; i++)
> +		if (strcmp(plat_dat->clks[i].id, name) == 0)
> +			return plat_dat->clks[i].clk;
> +
> +	return 0;
> +}
> +
>  static int dwc_eth_dwmac_config_dt(struct platform_device *pdev,
>  				   struct plat_stmmacenet_data *plat_dat)  {
> @@ -120,12 +130,7 @@ static int dwc_qos_probe(struct platform_device
> *pdev,
>  			 struct plat_stmmacenet_data *plat_dat,
>  			 struct stmmac_resources *stmmac_res)  {
> -	for (int i = 0; i < plat_dat->num_clks; i++) {
> -		if (strcmp(plat_dat->clks[i].id, "apb_pclk") == 0)
> -			plat_dat->stmmac_clk = plat_dat->clks[i].clk;
> -		else if (strcmp(plat_dat->clks[i].id, "phy_ref_clk") == 0)
> -			plat_dat->pclk = plat_dat->clks[i].clk;
> -	}
> +	plat_dat->pclk = dwc_eth_find_clk(plat_dat, "phy_ref_clk");
> 
>  	return 0;
>  }
> @@ -230,18 +235,12 @@ static int tegra_eqos_probe(struct platform_device
> *pdev,
> 
>  	eqos->dev = &pdev->dev;
>  	eqos->regs = res->addr;
> +	eqos->clk_slave = data->stmmac_clk;
> 
>  	if (!is_of_node(dev->fwnode))
>  		goto bypass_clk_reset_gpio;
> 
> -	for (int i = 0; i < data->num_clks; i++) {
> -		if (strcmp(data->clks[i].id, "slave_bus") == 0) {
> -			eqos->clk_slave = data->clks[i].clk;
> -			data->stmmac_clk = eqos->clk_slave;
> -		} else if (strcmp(data->clks[i].id, "tx") == 0) {
> -			data->clk_tx_i = data->clks[i].clk;
> -		}
> -	}
> +	data->clk_tx_i = dwc_eth_find_clk(data, "tx");
> 
>  	eqos->reset = devm_gpiod_get(&pdev->dev, "phy-reset",
> GPIOD_OUT_HIGH);
>  	if (IS_ERR(eqos->reset)) {
> @@ -306,15 +305,18 @@ struct dwc_eth_dwmac_data {
>  		     struct plat_stmmacenet_data *data,
>  		     struct stmmac_resources *res);
>  	void (*remove)(struct platform_device *pdev);
> +	const char *stmmac_clk_name;
>  };
> 
>  static const struct dwc_eth_dwmac_data dwc_qos_data = {
>  	.probe = dwc_qos_probe,
> +	.stmmac_clk_name = "apb_pclk",
>  };
> 
>  static const struct dwc_eth_dwmac_data tegra_eqos_data = {
>  	.probe = tegra_eqos_probe,
>  	.remove = tegra_eqos_remove,
> +	.stmmac_clk_name = "slave_bus",
>  };
> 
>  static int dwc_eth_dwmac_probe(struct platform_device *pdev) @@ -354,6
> +356,8 @@ static int dwc_eth_dwmac_probe(struct platform_device *pdev)
>  	if (ret)
>  		return dev_err_probe(&pdev->dev, ret, "Failed to enable
> clocks\n");
> 
> +	data->stmmac_clk = dwc_eth_find_clk(plat_dat, data-
> >stmmac_clk_name);
> +
>  	ret = data->probe(pdev, plat_dat, &stmmac_res);
>  	if (ret < 0) {
>  		dev_err_probe(&pdev->dev, ret, "failed to probe
> subdriver\n");
> --
> 2.30.2
> 
> 
> --
> RMK's Patch system: https://protect2.fireeye.com/v1/url?k=bd23955d-
> ddc10800-bd221e12-000babd9f1ba-890d84739eaced1c&q=1&e=4ae794ec-
> f443-4d77-aee4-
> 449f53a3a1a4&u=https%3A%2F%2Fwww.armlinux.org.uk%2Fdeveloper%2F
> patches%2F
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


