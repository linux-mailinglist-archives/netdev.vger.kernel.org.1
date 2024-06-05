Return-Path: <netdev+bounces-101115-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E118FD656
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 21:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 682FB1F25C9A
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 19:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6628213DDAA;
	Wed,  5 Jun 2024 19:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IRq24csK"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD04DF59;
	Wed,  5 Jun 2024 19:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717615032; cv=none; b=p+q556hXEj+7GQ2FxqP2Ysj0oIG4KAamprMnp6phshRVatmSp7WyNkqN/4ZFWhKL85GPwMqB6ExsJ1o+qYyP292ugkrv37Z6Vy9BPI/f21GDsEJbaSFFHwe/pa32gUcDQQx/PhKkaGmzMQpprR2XstQLE4uYuBcUwQ4Mx+YXbBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717615032; c=relaxed/simple;
	bh=vH7XJo83ZzgqsjWJbdY+GJ+FqBdRtMokMVB6JjiNR3U=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=KkYRuPsQHy8bxvKodXlIiL4UZhS5IKQ+S5TWR95xQxrLmMldNivDKO2chE/TbrsVzwZKFiWfQxx7XinAubs3uTEKheMMScfT/AQav1AewsgA1qq7XssI8VO8ZxpfggfQo8/49ZAJFrXbbi1nc8pIofHuEfKBBsjaZx4VtMojAnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=IRq24csK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 455I2pLf014121;
	Wed, 5 Jun 2024 19:15:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Iax0TXe7lCdgSrDctzGhpk3ecqdcbYISR7fv6wW2KY8=; b=IRq24csKsysHAIIV
	oTMXEiCGBXdaptsbC6U3dG9PTH7ZI7Y7shW1oszbhH+M3d1uJ35XfGzaJyi1Rs6i
	i1j231z90GqHFApKG5Anp5RJbOl6hl+AZdZ57BuXCS7setIw7Kt9uwkwc2InJPSq
	NmkpJvqhq1atEl7HdlYL9Q1j+SgCePfTWjNmWYr+gc9oBbZ2DGYdVRAONogVh2Zx
	sdA5MmgC+oY0t4c4fy7UT96ayHQ+TyklfcYhu/6DFEfj4ROj19z8q+tDvg2w0Hc0
	6KPUiSonZqDMF3nGplzIKDD6iydsdNnDTYNgRbgpN7f2UnNrYxprCtvEzKsP5/Cv
	waA4zw==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yjvxy85kr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Jun 2024 19:15:56 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 455JFt2v016817
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 5 Jun 2024 19:15:55 GMT
Received: from [10.46.19.239] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 5 Jun 2024
 12:15:55 -0700
Message-ID: <4a6aa0ba-a5ff-4d28-8ad4-12d461e44381@quicinc.com>
Date: Wed, 5 Jun 2024 12:15:54 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 04/10] net: pcs: xpcs: Convert xpcs_compat to
 dw_xpcs_compat
Content-Language: en-US
To: Serge Semin <fancer.lancer@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu
	<joabreu@synopsys.com>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        Vladimir Oltean
	<olteanv@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "Maxime
 Chevallier" <maxime.chevallier@bootlin.com>,
        Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
CC: Sagar Cheluvegowda <quic_scheluve@quicinc.com>,
        Andrew Halaney
	<ahalaney@redhat.com>,
        Jiawen Wu <jiawenwu@trustnetic.com>,
        Mengyuan Lou
	<mengyuanlou@net-swift.com>,
        Tomer Maimon <tmaimon77@gmail.com>, <openbmc@lists.ozlabs.org>,
        <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20240602143636.5839-1-fancer.lancer@gmail.com>
 <20240602143636.5839-5-fancer.lancer@gmail.com>
From: "Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com>
In-Reply-To: <20240602143636.5839-5-fancer.lancer@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 7b6R9bemf8GjmsjZ5Tr8QtplyqO02yJ1
X-Proofpoint-GUID: 7b6R9bemf8GjmsjZ5Tr8QtplyqO02yJ1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-05_02,2024-06-05_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 spamscore=0
 mlxscore=0 adultscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 mlxlogscore=999 impostorscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406050146


> @@ -482,7 +482,7 @@ static int xpcs_config_aneg_c73(struct dw_xpcs *xpcs,
>  
>  static int xpcs_aneg_done_c73(struct dw_xpcs *xpcs,
>  			      struct phylink_link_state *state,
> -			      const struct xpcs_compat *compat, u16 an_stat1)
> +			      const struct dw_xpcs_compat *compat, u16 an_stat1)
>  {
>  	int ret;
>  
> @@ -607,7 +607,7 @@ static int xpcs_validate(struct phylink_pcs *pcs, unsigned long *supported,
>  			 const struct phylink_link_state *state)
>  {
>  	__ETHTOOL_DECLARE_LINK_MODE_MASK(xpcs_supported) = { 0, };
> -	const struct xpcs_compat *compat;
> +	const struct dw_xpcs_compat *compat;
>  	struct dw_xpcs *xpcs;
>  	int i;
>  
> @@ -633,7 +633,7 @@ void xpcs_get_interfaces(struct dw_xpcs *xpcs, unsigned long *interfaces)
>  	int i, j;
>  
>  	for (i = 0; i < DW_XPCS_INTERFACE_MAX; i++) {
> -		const struct xpcs_compat *compat = &xpcs->desc->compat[i];
> +		const struct dw_xpcs_compat *compat = &xpcs->desc->compat[i];
>  
>  		for (j = 0; j < compat->num_interfaces; j++)
>  			__set_bit(compat->interface[j], interfaces);
> @@ -850,7 +850,7 @@ static int xpcs_config_2500basex(struct dw_xpcs *xpcs)
>  int xpcs_do_config(struct dw_xpcs *xpcs, phy_interface_t interface,
>  		   const unsigned long *advertising, unsigned int neg_mode)
>  {
> -	const struct xpcs_compat *compat;
> +	const struct dw_xpcs_compat *compat;
>  	int ret;
>  
>  	compat = xpcs_find_compat(xpcs->desc, interface);
> @@ -915,7 +915,7 @@ static int xpcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
>  
>  static int xpcs_get_state_c73(struct dw_xpcs *xpcs,
>  			      struct phylink_link_state *state,
> -			      const struct xpcs_compat *compat)
> +			      const struct dw_xpcs_compat *compat)
>  {
>  	bool an_enabled;
>  	int pcs_stat1;
> @@ -1115,7 +1115,7 @@ static void xpcs_get_state(struct phylink_pcs *pcs,
>  			   struct phylink_link_state *state)
>  {
>  	struct dw_xpcs *xpcs = phylink_pcs_to_xpcs(pcs);
> -	const struct xpcs_compat *compat;
> +	const struct dw_xpcs_compat *compat;
>  	int ret;
>  
>  	compat = xpcs_find_compat(xpcs->desc, state->interface);
> @@ -1269,7 +1269,7 @@ static u32 xpcs_get_id(struct dw_xpcs *xpcs)
>  	return 0xffffffff;
>  }
>  
> -static const struct xpcs_compat synopsys_xpcs_compat[DW_XPCS_INTERFACE_MAX] = {
> +static const struct dw_xpcs_compat synopsys_xpcs_compat[DW_XPCS_INTERFACE_MAX] = {
>  	[DW_XPCS_USXGMII] = {
>  		.supported = xpcs_usxgmii_features,
>  		.interface = xpcs_usxgmii_interfaces,
> @@ -1314,7 +1314,7 @@ static const struct xpcs_compat synopsys_xpcs_compat[DW_XPCS_INTERFACE_MAX] = {
>  	},
>  };
>  
Serge, Thank you for raising these patches. Minor comments which shows warning on my workspace. 

WARNING: line length of 82 exceeds 80 columns
#153: FILE: drivers/net/pcs/pcs-xpcs.c:1272:
+static const struct dw_xpcs_compat synopsys_xpcs_compat[DW_XPCS_INTERFACE_MAX] = {

WARNING: line length of 85 exceeds 80 columns
#162: FILE: drivers/net/pcs/pcs-xpcs.c:1317:
+static const struct dw_xpcs_compat nxp_sja1105_xpcs_compat[DW_XPCS_INTERFACE_MAX] = {

WARNING: line length of 85 exceeds 80 columns
#171: FILE: drivers/net/pcs/pcs-xpcs.c:1327:
+static const struct dw_xpcs_compat nxp_sja1110_xpcs_compat[DW_XPCS_INTERFACE_MAX] = {

> -static const struct xpcs_compat nxp_sja1105_xpcs_compat[DW_XPCS_INTERFACE_MAX] = {
> +static const struct dw_xpcs_compat nxp_sja1105_xpcs_compat[DW_XPCS_INTERFACE_MAX] = {
>  	[DW_XPCS_SGMII] = {
>  		.supported = xpcs_sgmii_features,
>  		.interface = xpcs_sgmii_interfaces,
> @@ -1324,7 +1324,7 @@ static const struct xpcs_compat nxp_sja1105_xpcs_compat[DW_XPCS_INTERFACE_MAX] =
>  	},
>  };
>  
> -static const struct xpcs_compat nxp_sja1110_xpcs_compat[DW_XPCS_INTERFACE_MAX] = {
> +static const struct dw_xpcs_compat nxp_sja1110_xpcs_compat[DW_XPCS_INTERFACE_MAX] = {
>  	[DW_XPCS_SGMII] = {
>  		.supported = xpcs_sgmii_features,
>  		.interface = xpcs_sgmii_interfaces,
> @@ -1418,7 +1418,7 @@ static int xpcs_init_id(struct dw_xpcs *xpcs)
>  
>  static int xpcs_init_iface(struct dw_xpcs *xpcs, phy_interface_t interface)
>  {
> -	const struct xpcs_compat *compat;
> +	const struct dw_xpcs_compat *compat;
>  
>  	compat = xpcs_find_compat(xpcs->desc, interface);
>  	if (!compat)

