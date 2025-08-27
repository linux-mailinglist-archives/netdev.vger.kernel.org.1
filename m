Return-Path: <netdev+bounces-217253-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 611D0B380FE
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 13:25:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CEA124E4074
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 11:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B7834DCFE;
	Wed, 27 Aug 2025 11:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="QjI4Xl9f"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C7B34F47B
	for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 11:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756293880; cv=none; b=cj6P9eokbOAAWI8GI6a1gxTBeBWarTS93d8YXUSjpX0sOqAQwTX/dlpLKtLCv+HWtdVXKW1gJ0AuAWAKuZa/d7xsfZnh5KavMNxDfIgRpwS1vqVLm17BVMxBePWjFxH0Kgbh41qDIF0mkvvvMTOZHc4w4roRjBS1gGnEhqsvmCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756293880; c=relaxed/simple;
	bh=YuVSyXvn2aPABQSkNuUxEB/GTr8dCb57wMzQBJMPwqc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EOy5yFUegrl6+ioMScB5Ghhl11ObYiIp6KCcMkpNnf6sR53qLnc8ECJH3P82LzqPiY2GQjycA2FFey9RA6HwGFpzxL7npZLucOnK9hpskN3U1JMJTE159bZugrmH45rRNKj8TtqnyqSpCazusQ8LZPnTN3Mr8JgjWj2SbcJHsUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=QjI4Xl9f; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57R0X1D4018088;
	Wed, 27 Aug 2025 04:24:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=XXWW7WAxER/aFBi0e1G0TlXxo
	qZgrlenJ6xILJsnmTg=; b=QjI4Xl9f5KxQXZn4CXSAoH9GCyEnVWSP8+IncNvk5
	TkgPEFst5HqdsIoIijWW8ESvCxgjLl6g7F7Zz7tCdBImUracFmdqa42vNzTycVNq
	wlHkUhBMaxN95YKTsqLngzBkKIM5r/UZ5wI14SZ44spIUc9bXiJKOWiVXorPCr/N
	eCEhEjBzI1pnFFoDYcP+V6tXIzVEmARLTx7FtHMNiki0+4YufAmm/uAlVcY4J6zk
	T1OLrpajotRudat1j2D3kUL1yYLOjfhuc+1QVOb3ZqQhIj+z1CI9gCSyyPH552jZ
	0v/VuAXcsq1N7Ejzd5AecKd5qnWjViSDMlwxlC27X/eDQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 48spmm9b01-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Aug 2025 04:24:03 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 27 Aug 2025 04:24:02 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 27 Aug 2025 04:24:02 -0700
Received: from opensource (unknown [10.29.8.22])
	by maili.marvell.com (Postfix) with SMTP id CE4453F706B;
	Wed, 27 Aug 2025 04:23:58 -0700 (PDT)
Date: Wed, 27 Aug 2025 11:23:57 +0000
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
CC: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Andrew Lunn
	<andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>, <netdev@vger.kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>
Subject: Re: [PATCH net-next] net: stmmac: mdio: use netdev_priv() directly
Message-ID: <aK7qzc_uVt2A53NH@opensource>
References: <E1urBj2-000000002as-0pod@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <E1urBj2-000000002as-0pod@rmk-PC.armlinux.org.uk>
X-Proofpoint-ORIG-GUID: fMcyWFOQZuVFKBAbYKMRqgneaqPJlFCJ
X-Proofpoint-GUID: fMcyWFOQZuVFKBAbYKMRqgneaqPJlFCJ
X-Authority-Analysis: v=2.4 cv=RMyzH5i+ c=1 sm=1 tr=0 ts=68aeead3 cx=c_pps a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17 a=kj9zAlcOel0A:10 a=2OwXVqhp2XgA:10 a=PHq6YzTAAAAA:8 a=M5GUcnROAAAA:8 a=QyAlcnm2dVGNXgeYg58A:9 a=CjuIK1q_8ugA:10
 a=ZKzU8r6zoKMcqsNulkmm:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI2MDIwNSBTYWx0ZWRfX8k+P0IlW1oW5 PSSPsuASQ4fmrK9jLrJ/BUqs+FaiIeAhtve2OFysMLuoQY8SVfhGGv1CCCNicguI/i3V0m4NDYT SZKzeU1DmlsNtcSUo6FBGmzIYiqK9O/YrHgyLZNtYzanDsHLQ4qCFBL/89fNq0TypENOpkNJpTD
 /f3Q9tjFifz0VWrUtjwmZYlMIhAo2qlWjncqZDsse8YG05LrHlWdO/M9/kECDEknqiKUhVBVKT7 XtlHsXK4S8el7duZ1DHmJpRtBQx+uMD4kO5ddKeEZ70aK8ZZleP+FZGMGN1FPmyV7Bg5u/XHU4F 5fMX3FyC6SBdsUh35yNealXIF00zmxwKf9p5GF1OJc0mHl04XABUxhhIjtugBopZspLiLqPWa0F XYJtX/jq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-27_02,2025-08-26_01,2025-03-28_01

On 2025-08-27 at 08:41:48, Russell King (Oracle) (rmk+kernel@armlinux.org.uk) wrote:
> netdev_priv() is an inline function, taking a struct net_device
> pointer. When passing in the MII bus->priv, which is a void pointer,
> there is no need to go via a local ndev variable to type it first.
> 
> Thus, instead of:
> 
> 	struct net_device *ndev = bus->priv;
> 	struct stmmac_priv *priv;
> ...
> 	priv = netdev_priv(ndev);
> 
> we can simply do:
> 
> 	struct stmmac_priv *priv = netdev_priv(bus->priv);
> 
> which simplifies the code.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Subbaraya Sundeep <sbhatta@marvell.com>

Thanks,
Sundeep

> ---
>  .../net/ethernet/stmicro/stmmac/stmmac_mdio.c | 38 +++++--------------
>  1 file changed, 10 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
> index 836f2848dfeb..86021e6b67b2 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
> @@ -131,12 +131,9 @@ static int stmmac_xgmac2_mdio_read(struct stmmac_priv *priv, u32 addr,
>  static int stmmac_xgmac2_mdio_read_c22(struct mii_bus *bus, int phyaddr,
>  				       int phyreg)
>  {
> -	struct net_device *ndev = bus->priv;
> -	struct stmmac_priv *priv;
> +	struct stmmac_priv *priv = netdev_priv(bus->priv);
>  	u32 addr;
>  
> -	priv = netdev_priv(ndev);
> -
>  	/* Until ver 2.20 XGMAC does not support C22 addr >= 4 */
>  	if (priv->synopsys_id < DWXGMAC_CORE_2_20 &&
>  	    phyaddr > MII_XGMAC_MAX_C22ADDR)
> @@ -150,12 +147,9 @@ static int stmmac_xgmac2_mdio_read_c22(struct mii_bus *bus, int phyaddr,
>  static int stmmac_xgmac2_mdio_read_c45(struct mii_bus *bus, int phyaddr,
>  				       int devad, int phyreg)
>  {
> -	struct net_device *ndev = bus->priv;
> -	struct stmmac_priv *priv;
> +	struct stmmac_priv *priv = netdev_priv(bus->priv);
>  	u32 addr;
>  
> -	priv = netdev_priv(ndev);
> -
>  	stmmac_xgmac2_c45_format(priv, phyaddr, devad, phyreg, &addr);
>  
>  	return stmmac_xgmac2_mdio_read(priv, addr, MII_XGMAC_BUSY);
> @@ -209,12 +203,9 @@ static int stmmac_xgmac2_mdio_write(struct stmmac_priv *priv, u32 addr,
>  static int stmmac_xgmac2_mdio_write_c22(struct mii_bus *bus, int phyaddr,
>  					int phyreg, u16 phydata)
>  {
> -	struct net_device *ndev = bus->priv;
> -	struct stmmac_priv *priv;
> +	struct stmmac_priv *priv = netdev_priv(bus->priv);
>  	u32 addr;
>  
> -	priv = netdev_priv(ndev);
> -
>  	/* Until ver 2.20 XGMAC does not support C22 addr >= 4 */
>  	if (priv->synopsys_id < DWXGMAC_CORE_2_20 &&
>  	    phyaddr > MII_XGMAC_MAX_C22ADDR)
> @@ -229,12 +220,9 @@ static int stmmac_xgmac2_mdio_write_c22(struct mii_bus *bus, int phyaddr,
>  static int stmmac_xgmac2_mdio_write_c45(struct mii_bus *bus, int phyaddr,
>  					int devad, int phyreg, u16 phydata)
>  {
> -	struct net_device *ndev = bus->priv;
> -	struct stmmac_priv *priv;
> +	struct stmmac_priv *priv = netdev_priv(bus->priv);
>  	u32 addr;
>  
> -	priv = netdev_priv(ndev);
> -
>  	stmmac_xgmac2_c45_format(priv, phyaddr, devad, phyreg, &addr);
>  
>  	return stmmac_xgmac2_mdio_write(priv, addr, MII_XGMAC_BUSY,
> @@ -274,8 +262,7 @@ static int stmmac_mdio_read(struct stmmac_priv *priv, int data, u32 value)
>   */
>  static int stmmac_mdio_read_c22(struct mii_bus *bus, int phyaddr, int phyreg)
>  {
> -	struct net_device *ndev = bus->priv;
> -	struct stmmac_priv *priv = netdev_priv(ndev);
> +	struct stmmac_priv *priv = netdev_priv(bus->priv);
>  	u32 value = MII_BUSY;
>  	int data = 0;
>  
> @@ -312,8 +299,7 @@ static int stmmac_mdio_read_c22(struct mii_bus *bus, int phyaddr, int phyreg)
>  static int stmmac_mdio_read_c45(struct mii_bus *bus, int phyaddr, int devad,
>  				int phyreg)
>  {
> -	struct net_device *ndev = bus->priv;
> -	struct stmmac_priv *priv = netdev_priv(ndev);
> +	struct stmmac_priv *priv = netdev_priv(bus->priv);
>  	u32 value = MII_BUSY;
>  	int data = 0;
>  
> @@ -373,8 +359,7 @@ static int stmmac_mdio_write(struct stmmac_priv *priv, int data, u32 value)
>  static int stmmac_mdio_write_c22(struct mii_bus *bus, int phyaddr, int phyreg,
>  				 u16 phydata)
>  {
> -	struct net_device *ndev = bus->priv;
> -	struct stmmac_priv *priv = netdev_priv(ndev);
> +	struct stmmac_priv *priv = netdev_priv(bus->priv);
>  	int ret, data = phydata;
>  	u32 value = MII_BUSY;
>  
> @@ -412,8 +397,7 @@ static int stmmac_mdio_write_c22(struct mii_bus *bus, int phyaddr, int phyreg,
>  static int stmmac_mdio_write_c45(struct mii_bus *bus, int phyaddr,
>  				 int devad, int phyreg, u16 phydata)
>  {
> -	struct net_device *ndev = bus->priv;
> -	struct stmmac_priv *priv = netdev_priv(ndev);
> +	struct stmmac_priv *priv = netdev_priv(bus->priv);
>  	int ret, data = phydata;
>  	u32 value = MII_BUSY;
>  
> @@ -452,8 +436,7 @@ static int stmmac_mdio_write_c45(struct mii_bus *bus, int phyaddr,
>  int stmmac_mdio_reset(struct mii_bus *bus)
>  {
>  #if IS_ENABLED(CONFIG_STMMAC_PLATFORM)
> -	struct net_device *ndev = bus->priv;
> -	struct stmmac_priv *priv = netdev_priv(ndev);
> +	struct stmmac_priv *priv = netdev_priv(bus->priv);
>  	unsigned int mii_address = priv->hw->mii.addr;
>  
>  #ifdef CONFIG_OF
> @@ -497,12 +480,11 @@ int stmmac_mdio_reset(struct mii_bus *bus)
>  
>  int stmmac_pcs_setup(struct net_device *ndev)
>  {
> +	struct stmmac_priv *priv = netdev_priv(ndev);
>  	struct fwnode_handle *devnode, *pcsnode;
>  	struct dw_xpcs *xpcs = NULL;
> -	struct stmmac_priv *priv;
>  	int addr, ret;
>  
> -	priv = netdev_priv(ndev);
>  	devnode = priv->plat->port_node;
>  
>  	if (priv->plat->pcs_init) {
> -- 
> 2.47.2
> 

