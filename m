Return-Path: <netdev+bounces-170084-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E70A473A8
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 04:37:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 766817A3509
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 03:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3FE41E8355;
	Thu, 27 Feb 2025 03:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="oVF89agC"
X-Original-To: netdev@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BC01D935C
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 03:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740627441; cv=none; b=rI6JxwV+na9gOITHATWRCRVCfuWhRWfWBmueWYDKhIw9XGpa6Ccz/08o9qLjSjD+GtpenitlOQrqh97kR4R3VRbFGaIo3+tFa5sq5M5wDb0z3hVUIvETSe+4tsj0zPIXPzL40VUb84KtpkSo8IkxQlk32yOzg0pFKmcoZG/W8Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740627441; c=relaxed/simple;
	bh=lSumbw1PWf7tSByOP5CKs66VRaIHHh6tWApRYCGgNjo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:Content-Type:
	 References; b=Ew0hZRLO0/jCPvj+9saclb/Hz4HghVevhMtz8R7lbB5eYs73+rDhp2QhLzpggNdDz5Fz4MH2MdJr/vHzix+kU7SRLpPoVuQ0gPC0zS6I+0pe9DtfGZ/9GThiW5rwDjE4xK/JOX0L0B7cj9zUjB5pn7eKPZvLBriMqdvVvbC9U/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=oVF89agC; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250227033716epoutp0253897aa1499cd728784a0eb5d0549916~n8255RXJP3171431714epoutp02S
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 03:37:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250227033716epoutp0253897aa1499cd728784a0eb5d0549916~n8255RXJP3171431714epoutp02S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1740627436;
	bh=rJUWO7g9RjJRp9fZlO7QpyX9lTOA51pukK5hQ5BEOsw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oVF89agC/G7UYT4ieerLuP7AhDgYHyfLqW+HYmb74iFS65Ea48PIGYB7bw38wnwGZ
	 zSabbPkFT1xVG61T8ydRUvYOjafCKZ18mBRLZdHbdnOWfP8fLky8EM5W3yVQpjS24t
	 lccX5qmq75VneHb2ihwKQL55e/7tVfCdORzHGHiw=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20250227033716epcas5p3e5c9f9958f59dca7b91d2bf26f839b7d~n825aMZYV1825818258epcas5p3O;
	Thu, 27 Feb 2025 03:37:16 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.181]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4Z3H8W0Lb3z4x9Py; Thu, 27 Feb
	2025 03:37:15 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	59.EB.19933.AEDDFB76; Thu, 27 Feb 2025 12:37:14 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250226103145epcas5p12873b39b9b467f35a38151e1938976d4~nu3gUOMuK3171031710epcas5p19;
	Wed, 26 Feb 2025 10:31:45 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250226103145epsmtrp16cae50a09d5d8d4e288ba32326fc4ed9~nu3gTSt412262222622epsmtrp1W;
	Wed, 26 Feb 2025 10:31:45 +0000 (GMT)
X-AuditID: b6c32a4a-c1fda70000004ddd-e6-67bfddeacc9e
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	65.B5.23488.19DEEB76; Wed, 26 Feb 2025 19:31:45 +0900 (KST)
Received: from cheetah.samsungds.net (unknown [107.109.115.53]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250226103142epsmtip1527f0d1050a1c8f0fe72e6a3929311c6~nu3d6d-Dt0651706517epsmtip1n;
	Wed, 26 Feb 2025 10:31:42 +0000 (GMT)
From: Swathi K S <swathi.ks@samsung.com>
To: rmk+kernel@armlinux.org.uk
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, krzk+dt@kernel.org, swathi.ks@samsung.com,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	pankaj.dubey@samsung.com, ravi.patel@samsung.com, gost.dev@samsung.com
Subject: Re: [PATCH net-next] net: stmmac: dwc-qos: clean up clock
 initialisation
Date: Wed, 26 Feb 2025 15:56:34 +0530
Message-Id: <20250226102634.4584-1-swathi.ks@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <E1tlRMP-004Vt5-W1@rmk-PC.armlinux.org.uk>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WTe0xbVRzHd27b2xYoXAvigTggV5fBJqxFHrduDJ3LcuP4A8MkxkS7Sm/a
	QrntelsURyYCK46ERxNlSpAVtzkGgekdYHlNYAq4ySbg0DroqDwi3dzYKEu6BbCloP99fs/v
	7/zOOQKOuAONFGhoI2WgFVocDeB2Xo3bGe+a/kElmW2UEZ7FWkBcmLHxiPqbZVzizI83eMT8
	0F98wt7fhRCLdQ6U+LWzikews5M8YqK7HiUqJud4RMNqK48YsoYTj6/fA8TXHW4+4Vzq5RPj
	1RaEcH9n578qJicmxzhk+0U7Qs5Xd/DJrrppPmllTSTbfAolL5/7mOyyLSPkgyu3ULKqvRmQ
	A1ek5DIblRn0Tt4+NaVQUoYYis7RKTW0Kg0/nCV/XZ6cIpHGS2VEKh5DK/KpNPxgRmb8IY3W
	ezg8pkChNXldmQqGwffs32fQmYxUjFrHGNNwSq/U6pP0CYwinzHRqgSaMr4ilUgSk72JR/PU
	49bt+k78w8bZBbQY/Pl8BRAKIJYEH7rMSAUIEIixHgAv9Exx/MYjAB2jJTy/8RjAkfIFzlZJ
	+Xz/ZqAPwBb7INdvuAE0e1iuLwvFYuHvTd/zfRyGRUGzdRr1MQcb4ECHM8HHoVgWvL3yCPiY
	i+2A8+zABoswGTyz1LapFg1bvu3fYCGWCpdOtaE+MYiNCKC9/A7wJx2Et0uvIn4Oha7hdr6f
	I+FitXmT5bCl6hbXz2o4/cSC+jkd9v9W7/ULvMPFwUvde/zu7fDza22If+ZgWPl0brO9CNoa
	tvgFuHp3crNlBOw8/4DvawMxEj49H+rfSQWAJdXjoAZE1f2vYAWgGURQeiZfRTHJ+kSa+uC/
	S8vR5bNg4/3uesMGnDNLCYMAEYBBAAUcPEwk1PSqxCKlovAjyqCTG0xaihkEyd79WTiRz+bo
	vB+ANsqlSTJJUkpKSpLs5RQp/pyotKtMJcZUCiOVR1F6yrBVhwiEkcVIGD38E0pI24ruWjVT
	f3/5UiC7jvyxbbQYp0drPxVT6t3K431flYpQ55Hw6Rr9nfhvmkZ2TFxOJ2tuckTRwZF9cZoJ
	ffwnvQuthXOBIXvdq2hR4hehFvNbscKOA2M/z0iPhr99uOWa7VjjkdRDGRaFrbZkRZua+0xr
	Q/abotxa9X42wIGzzjWb/H7Q8Gup1wvGCoveDX7oLPFs2xnIVka4P1uP7Q7JNr24LshwpV88
	ea/Pc87zfvTZvY6ZS1FDK6O7104UeFwnRCXq5cogebUmfy3xn7PuMOFS2Y2p08dPhxT88sR1
	v8fByAsOHMNkTezicnZ9Vot5SCk56cJz37Nn4VxGrZDu4hgYxb8yUgurSAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRfSyUcQDH/Z53cjyO9PPenmm7riVXVr9aa7aWnmVWaaaUdPE4ymF3XmKr
	pCSnedlCM3HMpiPi1CHmrYZppciVjMlLZRPKS0nUsP77bN/Pvt8/vgwunsLtmfDIGEEVKY/g
	KDPC8Jxz3pn9rVnhnp1ihZYmcwEqG6knUUHPLQIVvXhNoomOURoNtDZgaDJ/mEJvDBkk0o8Z
	SdT3rIBCGuM4iQpXKknUobVFiy+nACp5Ok+jT7NNNOrNzMbQfM0A7Snm+4xvcf6JbgDjJzKf
	0nxD/hDNa/WxvL48jeJrS6/zDfVzGD/T3E/xGU/KAd/WLOPn9M4nzAPMDoYIEeFxgmrXoQtm
	Yb1ap2gDd6V47DOVBD46aoApA1kPmDrRSmqAGSNmGwFcyLlNbQR28MfNHHKDraFu9Qu9If0A
	sPL34LpEsRL4/mEdvcY2rDO8rR2i1iSc7cdhsVaPawDDWLMnYW0yt+YQ7DY4oW8Dayxi98Oi
	2Sp8Y8AFVlS3rrMpuw/OplWt94vZvTCr8xGWBSy0wKQc2AnRaqVCGSyLlkUK8W5quVIdG6lw
	C45S6sH6IVJJPZheTN7VDjAGtAPI4JyNyDS8SSEWhcgTEgVVVJAqNkJQtwMHhuC2iHSy0wox
	q5DHCJcFIVpQ/U8xxtQ+CTO3r98T2r/8/eiBlbK0a6Lp+LwHZ934HYW879Xzq8Nlf3IXMgyf
	egy6CmXOgprQLWepAyVFfZ3idGmKd2fjfbki8JLE3U/l+2FEMmdudL4xFnJP9jNA07V9+djP
	O+cs97l2OVYW4c3ShOqEpl8aD3aqRW8SN30w9F3MUveBGWzGATtiEbj57vVZolBREWr08uo3
	afT1afvL+FugrzWbSkIGXVJXd49xl1stHWzc7BpXXimVxv1+daRrWV5Q92FJ/k1vanzS1aR0
	tc9l8jERP2pOR9DSU55E1cWcpR586xkfLpRATk7pPsNWQotjokYC8fbftv5vBkXHK69aZXKE
	Okwuk+IqtfwfUGfyHv8CAAA=
X-CMS-MailID: 20250226103145epcas5p12873b39b9b467f35a38151e1938976d4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250226103145epcas5p12873b39b9b467f35a38151e1938976d4
References: <E1tlRMP-004Vt5-W1@rmk-PC.armlinux.org.uk>
	<CGME20250226103145epcas5p12873b39b9b467f35a38151e1938976d4@epcas5p1.samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

>Precedence: bulk
>X-Mailing-List: netdev@vger.kernel.org
>List-Id: <netdev.vger.kernel.org>
>List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
>List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
>MIME-Version: 1.0
>Content-Disposition: inline
>Content-Transfer-Encoding: 8bit
>Content-Type: text/plain; charset="utf-8"
>Message-Id: <E1tlRMP-004Vt5-W1@rmk-PC.armlinux.org.uk>
>Sender: Russell King <rmk@armlinux.org.uk>
>Date: Fri, 21 Feb 2025 11:38:25 +0000
>
>Clean up the clock initialisation by providing a helper to find a
>named clock in the bulk clocks, and provide the name of the stmmac
>clock in match data so we can locate the stmmac clock in generic
>code.
>
>Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
>---
>dwc_eth_find_clk() should probably become a generic helper given that
>plat_dat->clks is part of the core platform support code, but that
>can be done later when converting more drivers - which I will get
>around to once I've got the set_clk_tx_rate() patch series out that
>someone else needs to make progress.
>
> .../stmicro/stmmac/dwmac-dwc-qos-eth.c        | 32 +++++++++++--------
> 1 file changed, 18 insertions(+), 14 deletions(-)
>
>diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
>index 392574bdd4a4..9e2035d1fb86 100644
>--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
>+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
>@@ -35,6 +35,16 @@ struct tegra_eqos {
> 	struct gpio_desc *reset;
> };
> 
>+static struct clk *dwc_eth_find_clk(struct plat_stmmacenet_data *plat_dat,
>+				    const char *name)
>+{
>+	for (int i = 0; i < plat_dat->num_clks; i++)
>+		if (strcmp(plat_dat->clks[i].id, name) == 0)
>+			return plat_dat->clks[i].clk;
>+
>+	return 0;
>+}
>+
> static int dwc_eth_dwmac_config_dt(struct platform_device *pdev,
> 				   struct plat_stmmacenet_data *plat_dat)
> {
>@@ -121,12 +131,7 @@ static int dwc_qos_probe(struct platform_device *pdev,
> 			 struct plat_stmmacenet_data *plat_dat,
> 			 struct stmmac_resources *stmmac_res)
> {
>-	for (int i = 0; i < plat_dat->num_clks; i++) {
>-		if (strcmp(plat_dat->clks[i].id, "apb_pclk") == 0)
>-			plat_dat->stmmac_clk = plat_dat->clks[i].clk;
>-		else if (strcmp(plat_dat->clks[i].id, "phy_ref_clk") == 0)
>-			plat_dat->pclk = plat_dat->clks[i].clk;
>-	}
>+	plat_dat->pclk = dwc_eth_find_clk(plat_dat, "phy_ref_clk");
> 
> 	return 0;
> }
>@@ -237,18 +242,12 @@ static int tegra_eqos_probe(struct platform_device *pdev,
> 
> 	eqos->dev = &pdev->dev;
> 	eqos->regs = res->addr;
>+	eqos->clk_slave = data->stmmac_clk;
> 
> 	if (!is_of_node(dev->fwnode))
> 		goto bypass_clk_reset_gpio;
> 
>-	for (int i = 0; i < data->num_clks; i++) {
>-		if (strcmp(data->clks[i].id, "slave_bus") == 0) {
>-			eqos->clk_slave = data->clks[i].clk;
>-			data->stmmac_clk = eqos->clk_slave;
>-		} else if (strcmp(data->clks[i].id, "tx") == 0) {
>-			eqos->clk_tx = data->clks[i].clk;
>-		}
>-	}
>+	eqos->clk_tx = dwc_eth_find_clk(data, "tx");
> 
> 	eqos->reset = devm_gpiod_get(&pdev->dev, "phy-reset", GPIOD_OUT_HIGH);
> 	if (IS_ERR(eqos->reset)) {
>@@ -312,15 +311,18 @@ struct dwc_eth_dwmac_data {
> 		     struct plat_stmmacenet_data *data,
> 		     struct stmmac_resources *res);
> 	void (*remove)(struct platform_device *pdev);
>+	const char *stmmac_clk_name;
> };
> 
> static const struct dwc_eth_dwmac_data dwc_qos_data = {
> 	.probe = dwc_qos_probe,
>+	.stmmac_clk_name = "apb_pclk",
> };
> 
> static const struct dwc_eth_dwmac_data tegra_eqos_data = {
> 	.probe = tegra_eqos_probe,
> 	.remove = tegra_eqos_remove,
>+	.stmmac_clk_name = "slave_bus",
> };
> 
> static int dwc_eth_dwmac_probe(struct platform_device *pdev)
>@@ -360,6 +362,8 @@ static int dwc_eth_dwmac_probe(struct platform_device *pdev)
> 	if (ret)
> 		return dev_err_probe(&pdev->dev, ret, "Failed to enable clocks\n");
> 
>+	data->stmmac_clk = dwc_eth_find_clk(plat_dat, data->stmmac_clk_name);
>+
> 	ret = data->probe(pdev, plat_dat, &stmmac_res);
> 	if (ret < 0) {
> 		dev_err_probe(&pdev->dev, ret, "failed to probe subdriver\n");

Hi Russell,
Tested this patch on FSD platform and it works.
Please feel free to add Tested-by: Swathi K S <swathi.ks@samsung.com>

-Swathi

>-- 
>2.30.2

