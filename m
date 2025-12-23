Return-Path: <netdev+bounces-245786-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA8BCD7ED3
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 03:57:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AD59A301D318
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 02:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 031C32BEFEF;
	Tue, 23 Dec 2025 02:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="GvCYdH5P"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C21C29E0E9;
	Tue, 23 Dec 2025 02:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766458677; cv=none; b=jKh+16uR7oAR6Fwhvr3EfZQJjeW3Lu6t0pHDtMu5rTURkTy6UuweVDbWK6p2RLyqE0VJQ/HyXIZ+OHTyHCK3mefVOFPgMEfIj15dWIH1l3MkdB440rDkt1hLzedy5ork2pHDd2ziknZakBNBxx0IMWFvxgmPN9CT2Z8uwG6q/OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766458677; c=relaxed/simple;
	bh=9cGE2tRq6P+0tNDoHJjTvFR6nB3IKMQtn6sQf3V8heE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TAtNf9/O9HZr/yF6Fa+9wkWQuafN+iPJVqSJJZTDkAcu/INHD/0Jil6G+3IfZA7WbRK7B+dGsd7dhgGDQLCqeNceWLuzDU2iZuzPAU4+/x9gYu7f4dhePHyMBIeJBgpbpFLV0wgWAki222zT95RX87FJQyzOqfAKGz31e1mTZwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=GvCYdH5P; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BMNScOX3134322;
	Mon, 22 Dec 2025 18:57:41 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=mj5nFdjzeG1QZUj5sHBM7NhZg
	N49Qp4a7ZK4MvGDiQA=; b=GvCYdH5PuNFUYwZ9FTs4Q5e/yj/dG4B/fs3+CtIyN
	1Ikw2JLOm/+82aJt2SL1HNlCD6HcEJjLNt1tfk+jGdgDaVcEc7/CPH2++FQ61dUR
	uXS+sJ+auTgJQBVck8dn9R5qcmrno0Lt5FO5IQfmtPZ1FzU40aEvFDq1SBBeEAQg
	u39sa5tcAakiDEJ82mlVZk4Eq9BY3YocQX008qpEZvSL9SpjJ+0J6faKbErsg4YV
	GmKBGgz+lh2TvtZQdek3rS+JipEsWcYdXKGFlA+GEpmrGRdt+yCSZmxn4T1nPQj2
	4T2z7WcOPXDQGM66ocedBG25gP1q/2ZBkvIiCyr7JIlfg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4b7fpjra54-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Dec 2025 18:57:41 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 22 Dec 2025 18:57:54 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 22 Dec 2025 18:57:54 -0800
Received: from kernel-ep2 (unknown [10.29.36.53])
	by maili.marvell.com (Postfix) with SMTP id B85015B6939;
	Mon, 22 Dec 2025 18:57:38 -0800 (PST)
Date: Tue, 23 Dec 2025 08:27:37 +0530
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: Osose Itua <osose.itua@savoirfairelinux.com>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <michael.hennerich@analog.com>,
        <jerome.oufella@savoirfairelinux.com>
Subject: Re: [PATCH v2 1/2] net: phy: adin: enable configuration of the LP
 Termination Register
Message-ID: <20251223025737.GA319469@kernel-ep2>
References: <20251222222210.3651577-1-osose.itua@savoirfairelinux.com>
 <20251222222210.3651577-2-osose.itua@savoirfairelinux.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251222222210.3651577-2-osose.itua@savoirfairelinux.com>
X-Proofpoint-GUID: 6gq_iqXHrUtAzJiERRwXwu3jMlqrNzEc
X-Proofpoint-ORIG-GUID: 6gq_iqXHrUtAzJiERRwXwu3jMlqrNzEc
X-Authority-Analysis: v=2.4 cv=TIJIilla c=1 sm=1 tr=0 ts=694a0525 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=kj9zAlcOel0A:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=9R54UkLUAAAA:8 a=VwQbUJbxAAAA:8 a=aRxQL1JOAAAA:8 a=VmpaGiyl27xw82UiNMQA:9
 a=CjuIK1q_8ugA:10 a=5hNPEnYuNAgA:10 a=YTcpBFlVQWkNscrzJ_Dz:22
 a=lBRdisTmIr2YKkuu8atg:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIzMDAyMyBTYWx0ZWRfX2N+5TZxW2um9
 vDS+BtBPwSML2YC0hBpxS5EoK1qPbJK4sGUjboR3XCgIy8p+XibEUJ332/9EWvrD53XWDEH21Lw
 kNqbeBztaqMJcikdjtQaiDa1EuKGqOZSs/L3f7qd9WYdAfbPeVBqDvEmwaTfE2LFDYN/9/6VluF
 I39ugojNXMAVAr7lRGJ04lT23IG6mLl2T9MgpVcgWWHh9BusCEqG5DtZ7y4SIIgYvZRTk3hcGv+
 tYWJ0jphhpzL4k9xbAh3G3ZYH+gwZbZMwOd7k7c41DZCiOZhM+V42YqRPxq4tHL0g/v6LsTtI13
 Ufn0/xqpizDVsbHiETz2VGgpQsnmyq7wh3IYocEQC2hBu/ghRXfxdxw4DadT5eLPXscVwo6XXhr
 vcnTIErJJwoSYDNjDlPB2b52CBPkTNV7xcZ12dJdLz4C4O43F9encW2u6vPmZSspUClhqFPCgkP
 2PN6Z1AGbyJSyMhCfAg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-23_01,2025-12-22_01,2025-10-01_01

Hi,

On 2025-12-23 at 03:51:04, Osose Itua (osose.itua@savoirfairelinux.com) wrote:
> The ADIN1200/ADIN1300 provide a control bit that selects between normal
> receive termination and the lowest common mode impedance for 100BASE-TX
> operation. This behavior is controlled through the Low Power Termination
> register (B_100_ZPTM_EN_DIMRX).
> 
> Bit 0 of this register enables normal termination when set (this is the
> default), and selects the lowest common mode impedance when cleared.
> 
> Signed-off-by: Osose Itua <osose.itua@savoirfairelinux.com>
> ---
>  drivers/net/phy/adin.c | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 
> diff --git a/drivers/net/phy/adin.c b/drivers/net/phy/adin.c
> index 7fa713ca8d45..e8b778cb191d 100644
> --- a/drivers/net/phy/adin.c
> +++ b/drivers/net/phy/adin.c
> @@ -4,6 +4,7 @@
>   *
>   * Copyright 2019 Analog Devices Inc.
>   */
> +#include <cerrno>
>  #include <linux/kernel.h>
>  #include <linux/bitfield.h>
>  #include <linux/delay.h>
> @@ -89,6 +90,9 @@
>  #define ADIN1300_CLOCK_STOP_REG			0x9400
>  #define ADIN1300_LPI_WAKE_ERR_CNT_REG		0xa000
>  
> +#define ADIN1300_B_100_ZPTM_DIMRX		0xB685
> +#define ADIN1300_B_100_ZPTM_EN_DIMRX		BIT(0)
> +
>  #define ADIN1300_CDIAG_RUN			0xba1b
>  #define   ADIN1300_CDIAG_RUN_EN			BIT(0)
>  
> @@ -522,6 +526,32 @@ static int adin_config_clk_out(struct phy_device *phydev)
>  			      ADIN1300_GE_CLK_CFG_MASK, sel);
>  }
>  
> +static int adin_config_zptm100(struct phy_device *phydev)
> +{
> +	struct device *dev = &phydev->mdio.dev;
> +	int reg;
> +	int rc;
> +
> +	if (!(device_property_read_bool(dev, "adi,low-cmode-impedance")))
> +		return 0;
> +
> +	/* set to 0 to configure for lowest common-mode impedance */
> +	rc = phy_write_mmd(phydev, MDIO_MMD_VEND1, ADIN1300_B_100_ZPTM_DIMRX, 0x0);

This clears full register instead of just bit 0. Is that intended?

> +	if (rc < 0)
> +		return rc;
> +
> +	reg = phy_read_mmd(phydev, MDIO_MMD_VEND1, ADIN1300_B_100_ZPTM_DIMRX);
> +	if (reg < 0)
> +		return reg;
> +
> +	if (!(reg & ADIN1300_B_100_ZPTM_EN_DIMRX)) {

From commit description, check should be if (reg & ADIN1300_B_100_ZPTM_EN_DIMRX)
AI review also caught this:
https://netdev-ai.bots.linux.dev/ai-review.html?id=05b38bb2-1244-46fc-a4d9-311ca8c825ee#patch-0

Fix the build errors reported at:
https://patchwork.kernel.org/project/netdevbpf/patch/20251222222210.3651577-2-osose.itua@savoirfairelinux.com/

Also net-next is closed till Jan 2. Please post v3 after that.

Thanks,
Sundeep
> +		phydev_err(phydev, "Failed to set lowest common-mode impedance.\n");
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
>  static int adin_config_init(struct phy_device *phydev)
>  {
>  	int rc;
> @@ -548,6 +578,10 @@ static int adin_config_init(struct phy_device *phydev)
>  	if (rc < 0)
>  		return rc;
>  
> +	rc = adin_config_zptm100(phydev);
> +	if (rc < 0)
> +		return rc;
> +
>  	phydev_dbg(phydev, "PHY is using mode '%s'\n",
>  		   phy_modes(phydev->interface));
>  

