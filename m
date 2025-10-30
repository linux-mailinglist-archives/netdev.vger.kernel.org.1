Return-Path: <netdev+bounces-234403-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DB75CC2034C
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 14:21:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 61E3E34EF5A
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 13:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A73286405;
	Thu, 30 Oct 2025 13:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RsaL9m8E";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZUiL3S8s"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DAC258ECB
	for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 13:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761830464; cv=none; b=VYd/spqCG+iV0+znqEq+enwtsYUhF00jAgaGwSNJb18QdQkTO6f3H7hLsgRdSBspXAuCrJ1pi+0oi1ndSH17W8FOoWO9CF144IFHEwfZRQA89c2klIQJHdmakPew2CriEzIOmuG2zU9cua+0MvLCus9GVI/VIaI16VMZKuK+Xiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761830464; c=relaxed/simple;
	bh=7Ki79C17Bc4kFf2frYRo9+PMWy4TZ3bxY3J8W0MQjdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rFFEhASR7jRc+f485Ri8/eYkt6f5aNkR+ZgXaFl8V39iHWauXyvRuS/KBQjSqX3HukhSBG/pGWimrnM9AHnfNNJIC1aE8HcqFGM9HbhfyHRMWCvuLzwcB2aA/Wovj2heWvBHodqGya3kbGqusBjOpxnywD/Ebm1T3WmW52F09p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RsaL9m8E; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZUiL3S8s; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59U7iCc81693371
	for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 13:21:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=N8JSx8eXmT6reNBlGsFi2hWH
	mKSJP+1vYMEJYEvPQSo=; b=RsaL9m8EKgArn3MqplxuH0kWpyBDOCA1/ooGEia7
	vlKlHYEJvgwgKxwsTH/3nskh3+qjcq461oKmQskbm7beCOyxQiysSJyC+2Isvd/6
	PMBrg5TCIP7B+i3GpYhZV7DGKwOACHLK+uDkn8v7ClZoJ/M+hvTVH4+OxDdfZSn+
	Cv71HfhIWrl4pDoMQc5CHRp/0/0mmzUpyYGii99tJWvxcWmeja8S1CTvUtnw3QK3
	QuodHPln77+fDn/+mr/fQpyXTLdcpvtU6s54Q8cqHlIOSEOIq5GoKHhp9t0Su9+e
	ASHu6dKTZ0muonz9ubVmCoAA9p+SdNa7G9CuJlSytfSYuQ==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a3trv2dnb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 13:21:01 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7a27837ead0so865526b3a.3
        for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 06:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761830461; x=1762435261; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N8JSx8eXmT6reNBlGsFi2hWHmKSJP+1vYMEJYEvPQSo=;
        b=ZUiL3S8sqvCq6DoWV19Jrpzwqz0sW/1U7qXUVpRrWHSFdFfCXjQR6O4v3Dq0McmU83
         LYCY/e1XscMaQ23bnc5yao4w0Gda1b5R/1pgM7IzV76++1BaO/Au5gUvKgQhSoi0ZtQ9
         JWlt8tJ4gc1Hy+3cG5TILgRiH8CN5ciQVUuhz0vreGedslCrmAhiCf/9Xky1LXAOq4AO
         FU6QnRpO6Wv8C6dED7mkkwSzUvzVqUxojU8jRUflWn4RfyW2pBv1lQGwE1rubgOOI+ae
         TXqN+cb8KG2fB2O8jfOyKxWAeF0YqnDZ7dkazJVXfDHBbASacf/XgHZbDzPs2xfSAZUR
         cLww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761830461; x=1762435261;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N8JSx8eXmT6reNBlGsFi2hWHmKSJP+1vYMEJYEvPQSo=;
        b=toE9tXrGWKni3qSIZkksn7tUIzboOzARXjs8jvcUwYYLFxYlEUxLIiqVAKethmUgIK
         4xQ+EF3IT/BRZFQt2KE238a8W3/T6x5hQGrp9Zl0ZPxnLaZP5R7VwL2y3IHeVoAvIEng
         tMbNpYhKFbxgFve9fbiGvI7bOyMrQ5x0B2FVraK5ZSo04D6vWdqRQlOhEwCgrRU5HSDv
         5Un65/F7KrRdFPcpPBNF8UCa95Hm3YIvqFS2KGnc8kvPJ9xq8TzXFnXqxz5oXmp5xqg+
         8IU4NgotgNaQl1UUXWUBDl2dcBoM+mo7PwX3BCdVju5RaUCl7y8760nQnHN0wBWqcUCl
         292w==
X-Forwarded-Encrypted: i=1; AJvYcCX+NbN1VGUf6rrycdmfgprw/4WqNev4WN1tu0fciwjpTO+qQZnx5nsGqAPu91CbtQeZutHI6LY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbHlk+/krkn4e7nJUNU5H+7ke3I0i18LS5VfHwQVCyUSvzrrkM
	IjQJ4dhlXiuRHArJAHU1P1ubU7eUxa/xAu8voGHmwKmjCBM1F2aqCEMYW+uwfgUXtdCWu7zjiIG
	dinco9okTHVqN0J5qG7ymZlvuhKqUb4sJK29qoj/VsddRQESCIdoM77UPX38=
X-Gm-Gg: ASbGnculbxjVqPX7KMmBhO/1fC6QFhEZ7h3srpFStXO/mfF1fb85wSJACzZJxTd8iHD
	+IOcUYiDFrmWpAmEoENLDMFtBSaQTpHw6lcFLvrF262y0vAizTKkquJX3riz/QZs1tFobOhUPPP
	WC3VTv4Wi+ybjD7t/4znq6hYtsR8k1OmlIsLYyreKAj+EQboZmLQCLviuO0FzXpsyQcSz4ekLld
	QLonzqk8SB9pOrsE2OD+53qnpQQrTzCdvz6/Cb4TtgPe4JY9r4aszPJ+Uk98HNWmZ9i8WERrWkL
	KIZ/SyH98wK3SM8m5VKvGs79ExO1B7ZG8MCUJB3jzpH/Pcih1iehaGQg4+CwFXH8F4FDE/M0Q7G
	a9vGhmqPDY8sw
X-Received: by 2002:a05:6a20:2448:b0:340:e2dc:95b3 with SMTP id adf61e73a8af0-347876911d2mr4494878637.55.1761830460387;
        Thu, 30 Oct 2025 06:21:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEi/DCs49lmkfOKByJGfWQqDwDeolNz2XBvEbRU2iz1p4Vspe9DF/BjXzv/hEwWwborxHL8OA==
X-Received: by 2002:a05:6a20:2448:b0:340:e2dc:95b3 with SMTP id adf61e73a8af0-347876911d2mr4494822637.55.1761830459746;
        Thu, 30 Oct 2025 06:20:59 -0700 (PDT)
Received: from oss.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b712d4f12f2sm17508780a12.30.2025.10.30.06.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 06:20:59 -0700 (PDT)
Date: Thu, 30 Oct 2025 18:50:51 +0530
From: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Alexis =?iso-8859-1?Q?Lothor=E9?= <alexis.lothore@bootlin.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        Boon Khai Ng <boon.khai.ng@altera.com>,
        Daniel Machon <daniel.machon@microchip.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Furong Xu <0x1207@gmail.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Vladimir Oltean <olteanv@gmail.com>,
        Yu-Chun Lin <eleanor15x@gmail.com>
Subject: Re: [PATCH net-next 0/3] net: stmmac: phylink PCS conversion part 3
 (dodgy stuff)
Message-ID: <aQNmM5+cptKllTS8@oss.qualcomm.com>
References: <aP03aQLADMg-J_4W@shell.armlinux.org.uk>
 <aQExx0zXT5SvFxAk@oss.qualcomm.com>
 <aQHc6SowbWsIA1A5@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQHc6SowbWsIA1A5@shell.armlinux.org.uk>
X-Proofpoint-GUID: goc7KcBSq14cr__jmHXNuX7kXqZjP4QC
X-Authority-Analysis: v=2.4 cv=D+ZK6/Rj c=1 sm=1 tr=0 ts=6903663d cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=ld7dpV6llueYRqIT5ogA:9 a=CjuIK1q_8ugA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: goc7KcBSq14cr__jmHXNuX7kXqZjP4QC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDEwOCBTYWx0ZWRfX+KRWF5ZZqb0g
 7r9r4vIn1B26ogCTY4r5EXsrYQRnXyVffwnTz7NUXi+wSMIQ+4QQqYlaBsF4ydPDTAjRE7MLtor
 DnQT2mk7AKAfDkVLIWrWMwEZ29F06hth2mk/DdQrdtHQY7imQ0eS/Wfb4Ho9UQ0B/exsIOm+Rzv
 r7QTUe5zktSeHgTlbbslP2iZXaP+2Rz03dQzDJCzqqg60zi//9rS1zsbmBfE1nWiUP7+38IagP/
 rcrvzaNEUTh2dCy2ZMoItYZ8Bj5ZC47tmgcwQrV4/02Q+CLhSvDG+thUN+gszaqqNhxaIHnJd7m
 HYo/fej72hbrtdyG6c882PYJUNQmIJtcBRpGOWM8GWoyyo4FrZG22reOfePBPsoOItxHqETJ3Cj
 dUQSPgX5aace9pQXCTClo1aQ8qAtjg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_04,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 malwarescore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510300108

Hi Russell,
On Wed, Oct 29, 2025 at 09:22:49AM +0000, Russell King (Oracle) wrote:
> > # Patch Series (current): net: stmmac: phylink PCS conversion part 3
> > (dodgy stuff)
> >   - QCS9100 Ride R3 - functionality seems to be fine (again, probably
> >     due to the changes only affecting SGMII mode). However, the warning
> >     added in patch 2 comes up whenever there's a speed change (I added
> >     an additional WARN_ON to check the sequence):
> >   	[   61.663685] qcom-ethqos 23000000.ethernet eth0: Link is Down
> > 	[   66.235461] dwmac: PCS configuration changed from phylink by glue, please report: 0x00001000 -> 0x00000000
> 
> That's clearing ANE, turning off AN. This will be because we're not
> using the PCS code for 2500base-X.
> 
> Can you try:
> 
> 1. in stmmac_check_pcs_mode(), as a hack, add:
> 
> 	if (priv->dma_cap.pcs && interface == PHY_INTERFACE_MODE_2500BASEX)
> 		priv->hw->pcs = STMMAC_PCS_SGMII;
> 
> 2. with part 3 added, please change dwmac4_pcs_init() to:
> 
> 	phy_interface_t modes[] = {
> 		PHY_INTERFACE_MODE_SGMII,
> 		PHY_INTERFACE_MODE_2500BASEX,
> 	};
> 	...
> 	return stmmac_integrated_pcs_init(priv, GMAC_PCS_BASE,
> 					  GMAC_INT_PCS_LINK | GMAC_INT_PCS_ANE,
> 					  modes, ARRAY_SIZE(modes));
> 
> This will cause the integrated PCS to also be used for 2500BASE-X.
> 
> 3. modify dwmac_integrated_pcs_inband_caps() to return
>    LINK_INBAND_DISABLE for PHY_INTERFACE_MODE_2500BASEX.
> 
> This should result in the warning going away for you.
> 
> I'm not suggesting that this is a final solution.

Here are my observations (with phylink logs if it helps):

1. Link up at 2.5G
[    8.429331] qcom-ethqos 23000000.ethernet: User ID: 0x20, Synopsys ID: 0x52
[    8.436610] qcom-ethqos 23000000.ethernet:   DWMAC4/5
[   10.395163] qcom-ethqos 23000000.ethernet eth0: PHY stmmac-0:00 uses interfaces 4,23,27, validating 23
[   10.407759] qcom-ethqos 23000000.ethernet eth0:  interface 23 (2500base-x) rate match pause supports 0-7,9,13-14,47
[   10.418507] qcom-ethqos 23000000.ethernet eth0: PHY [stmmac-0:00] driver [Aquantia AQR115C] (irq=343)
[   10.428003] qcom-ethqos 23000000.ethernet eth0: phy: 2500base-x setting supported 0000000,00000000,00008000,000062ff advertising 0000000,00000000,00008000,000062ff
[   10.461072] qcom-ethqos 23000000.ethernet eth0: Enabling Safety Features
[   10.478201] qcom-ethqos 23000000.ethernet eth0: IEEE 1588-2008 Advanced Timestamp supported
[   10.487449] qcom-ethqos 23000000.ethernet eth0: registered PTP clock
[   10.494010] qcom-ethqos 23000000.ethernet eth0: configuring for phy/2500base-x link mode
[   10.494014] qcom-ethqos 23000000.ethernet eth0: major config, requested phy/2500base-x
[   10.494018] qcom-ethqos 23000000.ethernet eth0: interface 2500base-x inband modes: pcs=01 phy=00
[   10.494021] qcom-ethqos 23000000.ethernet eth0: major config, active phy/outband/2500base-x
[   10.494024] qcom-ethqos 23000000.ethernet eth0: phylink_mac_config: mode=phy/2500base-x/none adv=0000000,00000000,00000000,00000000 pause=00
[   10.508824] qcom-ethqos 23000000.ethernet eth0: phy link down 2500base-x/Unknown/Unknown/none/off/nolpi
[   15.099693] qcom-ethqos 23000000.ethernet eth0: phy link up 2500base-x/2.5Gbps/Full/none/rx/tx/nolpi
[   15.122160] dwmac: PCS configuration changed from phylink by glue, please report: 0x00041000 -> 0x00040000
[   15.140458] qcom-ethqos 23000000.ethernet eth0: Link is Up - 2.5Gbps/Full - flow control rx/tx
[   15.140939] stmmac_pcs: Link Up

As I understand it, the glue layer disables ANE at 2.5G.

2. Link up at 1G:
[    6.261112] qcom-ethqos 23000000.ethernet: User ID: 0x20, Synopsys ID: 0x52
[    6.261116] qcom-ethqos 23000000.ethernet:   DWMAC4/5
[    9.051693] qcom-ethqos 23000000.ethernet eth0: PHY stmmac-0:00 uses interfaces 4,23,27, validating 23
[    9.061261] qcom-ethqos 23000000.ethernet eth0:  interface 23 (2500base-x) rate match pause supports 0-7,9,13-14,47
[    9.061266] qcom-ethqos 23000000.ethernet eth0: PHY [stmmac-0:00] driver [Aquantia AQR115C] (irq=305)
[    9.061269] qcom-ethqos 23000000.ethernet eth0: phy: 2500base-x setting supported 0000000,00000000,00008000,000062ff advertising 0000000,00000000,00008000,000062ff
[    9.080324] qcom-ethqos 23000000.ethernet eth0: Enabling Safety Features
[    9.114550] qcom-ethqos 23000000.ethernet eth0: IEEE 1588-2008 Advanced Timestamp supported
[    9.123870] qcom-ethqos 23000000.ethernet eth0: registered PTP clock
[    9.130412] qcom-ethqos 23000000.ethernet eth0: configuring for phy/2500base-x link mode
[    9.138726] qcom-ethqos 23000000.ethernet eth0: major config, requested phy/2500base-x
[    9.138729] qcom-ethqos 23000000.ethernet eth0: interface 2500base-x inband modes: pcs=01 phy=00
[    9.138731] qcom-ethqos 23000000.ethernet eth0: major config, active phy/outband/2500base-x
[    9.164930] qcom-ethqos 23000000.ethernet eth0: phylink_mac_config: mode=phy/2500base-x/none adv=0000000,00000000,00000000,00000000 pause=00
[    9.194764] qcom-ethqos 23000000.ethernet eth0: phy link down 2500base-x/Unknown/Unknown/none/off/nolpi
[   12.542771] qcom-ethqos 23000000.ethernet eth0: phy link up sgmii/1Gbps/Full/none/rx/tx/nolpi
[   12.553890] qcom-ethqos 23000000.ethernet eth0: major config, requested phy/sgmii
[   12.561617] qcom-ethqos 23000000.ethernet eth0: interface sgmii inband modes: pcs=03 phy=03
[   12.570220] qcom-ethqos 23000000.ethernet eth0: major config, active phy/outband/sgmii
[   12.578367] qcom-ethqos 23000000.ethernet eth0: phylink_mac_config: mode=phy/sgmii/none adv=0000000,00000000,00000000,00000000 pause=03
[   12.599545] stmmac_pcs: ANE process completed
[   12.607910] dwmac: PCS configuration changed from phylink by glue, please report: 0x00041000 -> 0x00041200
[   12.616188] stmmac_pcs: Link Up
[   12.634351] qcom-ethqos 23000000.ethernet eth0: Link is Up - 1Gbps/Full - flow control rx/tx
[   12.639575] stmmac_pcs: ANE process completed
[   12.647498] stmmac_pcs: Link Up

This is probably fine since Bit(9) is self-clearing and its value just
after this is 0x00041000.

> 
> Please note, however, that the stmmac driver does not support on-the-fly
> reconfiguration of the PHY-side interface as it stands (and questionable
> whether it ever will do.) The hardware samples phy_intf_sel inputs to
> the core at reset (including, I believe, software reset) which
> configures the core to use the appropriate PHY interface. Performing
> any kind of reset is very disruptive to the core - likely even causes
> the PTP timekeeping block to be reset. In my opinion, PHYs that switch
> their host-side interface were not considered when this IP was
> designed.
> 
> To get stmmac's driver to a state where it _can_ do this if desired is
> going to take a massive amount of work due to all these glue drivers.
> 
> I do have patches which introduce a new callback into platform drivers
> to set the phy_intf_sel inputs from the core code... but that's some
> way off before it can be merged (too many other patches I need to get
> in first.)
> 
> I haven't noticed qcom-ethqos using a register field that corresponds
> with the phy_intf_sel inputs, so even in that series, this driver
> doesn't get converted.

True, I think qcom-ethqos's behaviour is different than other glue
drivers. For both SGMII and 2500Base-X, it uses the same
ethqos_configure_sgmii() function which is just changing the SerDes
speed and PCS and depending on the current speed.

	Ayaan

