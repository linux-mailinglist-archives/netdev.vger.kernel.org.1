Return-Path: <netdev+bounces-235842-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B238C368A6
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 17:02:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 32E604F9F5D
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 15:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 806B0333736;
	Wed,  5 Nov 2025 15:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jNDMOC5U";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RKVLM5jW"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F7732936B
	for <netdev@vger.kernel.org>; Wed,  5 Nov 2025 15:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762357583; cv=none; b=URpLkXVNuW02y/GZ0Lg5CzQhghqqXTQh8MtEytyCQEiZjOhGF0eXJci/LfEatwndLvKSypCn8Vq4jAydg+A+2jC0qiKIFrgnLhIWln2U/sTJyX4k+k7zz2Bumfos/b8NLnGfQe0lhvXU8XjeFVV9JVCy+CmNHO8mAkal1MM1f7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762357583; c=relaxed/simple;
	bh=lDItyC7ImtgMzPiHkhPinZtBNev0NJmQuWKpmY5H7tY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XPx+EHOuZXd0/S7mhBzp6SZZ++4hCQrYMl76staofHti5xCYgZRaMBLpiqxfFeeFPTNG2sjMWByW58NWQaJAN0tp8/7IKTGs4MEXvJwh2PSaWMLG28nNm8Tjf17gc6+uK/MO0eQU1Q3S3gg9RcrMoTov+EJ+fW+fOg9AcF/Omqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jNDMOC5U; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RKVLM5jW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A580iJH3165120
	for <netdev@vger.kernel.org>; Wed, 5 Nov 2025 15:46:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WtMImrq5sUGsl+nfEKnxwvnyMAUi6lby1sFo37hl/pU=; b=jNDMOC5UT5EKn/oR
	bvBvwEURvzL4+SGnHM7VnNeiKycJrCuf6muoMET6ChHenkWyFdl3xfxQi6d/kVo8
	eQjcSK9ASPs2r0Osm84sEPjIby7z0hB5fP3Y1vrvuqhePrxrxOsAnIlJWcaQb2dv
	fWUjJX6fpC6BdI0ocCsni1uca/xKSpH3iKK0faB0nMlJ0cRUSifF8t6haAewjaOm
	llClOLHB0y0z901QB7EtB6TBtfuwtdknejf2YMxmgjxLl6Wr1icP63kNS65Z0dtY
	DHsxTS9zQEtPamng8ncrUcbwmXiIa20gp20dAVQ7WDcLhuigwbh9MsUas3ysbAUj
	TqPT0A==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a7ketm2bn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 05 Nov 2025 15:46:20 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b471737e673so11139193a12.1
        for <netdev@vger.kernel.org>; Wed, 05 Nov 2025 07:46:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762357579; x=1762962379; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WtMImrq5sUGsl+nfEKnxwvnyMAUi6lby1sFo37hl/pU=;
        b=RKVLM5jWnL9u+Mou3Y2vNJg4z1OBiB20UGse52ZLt7Wv4sdBSmvMXqlYdwXTMmCDA/
         qy1RiBd/uPhzxV4yHMZXyndOclBNRCp//8+5jYkdkyS7berl9tvX9tUVVf1IijKClfdZ
         ykyJm/9ym5lWx2Y0s047P3+xbFhCKXwfUS10uU7Ir0uYAmZ3VFGIfdHYYCS6UF2hSfq7
         TETrSapaz/FvFzVGM1O9qWM001w4yKvukHceH6ZPzoyRg6yAq2YQ3UHdVLebSbw8ZPZ9
         DbldT2Aw8PRRWBWxEl7ejKMxMuqlGLvwk9Dqe+ZW/pLSY54LJf09hQXQj9tZVPYaqMus
         PxVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762357579; x=1762962379;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WtMImrq5sUGsl+nfEKnxwvnyMAUi6lby1sFo37hl/pU=;
        b=QJfEKUG9bTjj3/oQn7dpeQK5pfInC5uS6wNLo1JTWi0nGx3GPxiyP2+HB0M6X0kDxr
         wn+neDZhpoiKOaUTNbhslAsoEYyWC1J32zudjXjvYiSIJJ8X/QC7jtI/UA33ZkeA4S4I
         c1F+WJBK/S3GMR4wSExVFAXXqDc1S6B6FIgNBDKlmBebFWUahtGEFH4X1ddY1uHXTiHm
         0FWDFSP42FAGiF7RSyAA43XUFxXU7UDF8wH/e0LJ/U1H/BEiDJh/fwqQOQhi9His94wO
         LA+17yyBrTxYBkXnQq3iS+AOqK7heyYo1N+w1FpbIYrIkLdze/mFP7V6+/Av4accjXCW
         kJLA==
X-Forwarded-Encrypted: i=1; AJvYcCUUCvqG3p5WVxMVKzNU1TaEVwL89/8Ww5Tu6qhA3DSa3XoMPjvSNuHBB8dj0yZj0B3j2c9To4U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/y4z9nztWbo0ilGhNvoNuPahMBdoBH5FaUAmXXkiFSc9JaIpm
	GpFWpgD92XFgwXqK1QMzSxpWHWslP+BmjjUKuzfnqb5lbnUaXNU45iKAuqLDpWsvw+Vf7wzDFVO
	MOZCvTO5mbVhWi3Ghl42jtFgQLvx+cNPhMh66S/HW7V8Rqy+l5A4isjsiztA=
X-Gm-Gg: ASbGncsWABqJMyDBkSqj6BIiOYkdeiJn/Anhmepy6cAOB3QxUr5uRs5SvSFojGtTJ+Y
	KrzBM0htJlB/iH1CzQTs+bpIoUH3YAWMYCHF2j3htrHpeKsmtenJD1nUDlyolMfnMsJ/BBazZpT
	S2CAx9NSHaw1Tv6oJCcuzHcnWoI0MFnHMPm1QdbDDiR5luJSi3oeyMVBTLApklcycjh48dcxPl6
	1bo5nFCIlWivWiDUUOM8yi8zOKHWeFiZ/Ey33No7kLYk6GDXUDIanN2Ex0ojesY88xJYVuiEWf5
	M/lczEFsqkM5Lq4kuouEiTuTRHgishqTynIwvJ9UbZODZmBeBcyrqZcGGBXnCtQwipcy+ycRrt8
	NZNekd8suwj5f
X-Received: by 2002:a05:6a20:3ca3:b0:34e:8442:73e0 with SMTP id adf61e73a8af0-34f8720b34bmr4685621637.54.1762357579093;
        Wed, 05 Nov 2025 07:46:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHSJW8YvgHVcelwHGX1XRYFa34Q7po9DWxf0yubMW5LL5qqG1RUf4UwwqX7iFTXUlwuWEeYVg==
X-Received: by 2002:a05:6a20:3ca3:b0:34e:8442:73e0 with SMTP id adf61e73a8af0-34f8720b34bmr4685546637.54.1762357578170;
        Wed, 05 Nov 2025 07:46:18 -0800 (PST)
Received: from oss.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba1f765eda9sm5869855a12.18.2025.11.05.07.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 07:46:17 -0800 (PST)
Date: Wed, 5 Nov 2025 21:16:10 +0530
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
Message-ID: <aQtxQgPWQ3+CCrZI@oss.qualcomm.com>
References: <aP03aQLADMg-J_4W@shell.armlinux.org.uk>
 <aQExx0zXT5SvFxAk@oss.qualcomm.com>
 <aQHc6SowbWsIA1A5@shell.armlinux.org.uk>
 <aQNmM5+cptKllTS8@oss.qualcomm.com>
 <aQOB_yCzCmAVM34V@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aQOB_yCzCmAVM34V@shell.armlinux.org.uk>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDEyMCBTYWx0ZWRfX3Qe2ppmZ+KlD
 D1GV87g2UFRsERiVK/tuTeQ0Fz1Bn4NTHASV9j1x4YCNs3BYwhXzg83JFJlcNET3lsc7HpvmW7f
 ihHU8MjhwhsTQYbYgXiZWP+y79aoMMw32wzrgKjFr+sBvumF8cOyXnsC3enSHARNIyzGAe7QDtP
 EgwzhX5jh4z3Sqi4f44AJife4zFZaYHMFl32QnqDjHrds60j7XuZPX+Xw/PdWuDu90TiW+C1zeT
 oWcWBhlhrBOlziCq2xoUXb4fk9yvqqTuVRnEI8eRYSbUxUUdf8N+1c51ALU1mtXSlMjW1X+4zIr
 YGBhsGw7oF0znaeYgONFufYDX8QtCYvjZMuaJUWNaP/IphNCKjc5W2/VETXC55tNd9XaduoLrI9
 BmnykK45Q5jkJR+vMIWnYpLRwLJv9g==
X-Proofpoint-GUID: o-VEpasrTqPI1Tkd39Ch5x7sP66zblkB
X-Authority-Analysis: v=2.4 cv=IdSKmGqa c=1 sm=1 tr=0 ts=690b714c cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=tRw71FBK4ubUaVLUln4A:9 a=wR370b9K0M9R-dgo:21
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: o-VEpasrTqPI1Tkd39Ch5x7sP66zblkB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_06,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 impostorscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511050120

Hello Russell,
On Thu, Oct 30, 2025 at 03:19:27PM +0000, Russell King (Oracle) wrote:
> > > Can you try:
> > > 
> > > 1. in stmmac_check_pcs_mode(), as a hack, add:
> > > 
> > > 	if (priv->dma_cap.pcs && interface == PHY_INTERFACE_MODE_2500BASEX)
> > > 		priv->hw->pcs = STMMAC_PCS_SGMII;
> > > 
> > > 2. with part 3 added, please change dwmac4_pcs_init() to:
> > > 
> > > 	phy_interface_t modes[] = {
> > > 		PHY_INTERFACE_MODE_SGMII,
> > > 		PHY_INTERFACE_MODE_2500BASEX,
> > > 	};
> > > 	...
> > > 	return stmmac_integrated_pcs_init(priv, GMAC_PCS_BASE,
> > > 					  GMAC_INT_PCS_LINK | GMAC_INT_PCS_ANE,
> > > 					  modes, ARRAY_SIZE(modes));
> > > 
> > > This will cause the integrated PCS to also be used for 2500BASE-X.
> > > 
> > > 3. modify dwmac_integrated_pcs_inband_caps() to return
> > >    LINK_INBAND_DISABLE for PHY_INTERFACE_MODE_2500BASEX.
> > > 
> > > This should result in the warning going away for you.
> > > 
> > > I'm not suggesting that this is a final solution.
> <snip>
> Please try again, this time with snps,ps-speed removed from the DT
> description for the interface. This property was a buggy attempt at
> reverse-SGMII, and incorrectly produced a warning if not specified
> when the integrated PCS was being used. The "bug" in the attempt
> with this was a typo in each MAC core driver, where specifying this
> set the TE (transmit enable) bit rather than the TC (transmit
> configuration) bit in the MAC control register. All the rest of the
> setup for reverse-SGMII mode was in place, but this bug made the
> entire thing useless.
> 

I finally got some time to test out 100M/1G/2.5G with all these changes
on the QCS9100 Ride R3 board (AQR115C PHY, qcom-ethqos).

Apart from this patch series, I incorporated the following changes:
1. Hacks suggested to have the PCS code work for 2500Base-X.
2. Removed snps,ps-speed from DT.
3. Picked [PATCH net-next v2] net: stmmac: qcom-ethqos: remove
MAC_CTRL_REG modification.

Apologies for the lengthy email- I’ve included phylink logs for all
five points for completeness.

*Observations:*

1. 2.5G Link up - no warning about the PCS configuration getting changed
by glue. Data path works fine.

	[   10.342908] qcom-ethqos 23000000.ethernet eth0: PHY stmmac-0:00 uses interfaces 4,23,27, validating 23
	[   10.352486] qcom-ethqos 23000000.ethernet eth0:  interface 23 (2500base-x) rate match pause supports 0-7,9,13-14,47
	[   10.363215] qcom-ethqos 23000000.ethernet eth0: PHY [stmmac-0:00] driver [Aquantia AQR115C] (irq=365)
	[   10.372690] qcom-ethqos 23000000.ethernet eth0: phy: 2500base-x setting supported 0000000,00000000,00008000,000062ff advertising 0000000,00000000,00008000,000062ff
	[   10.428389] qcom-ethqos 23000000.ethernet eth0: configuring for phy/2500base-x link mode
	[   10.436717] qcom-ethqos 23000000.ethernet eth0: major config, requested phy/2500base-x
	[   10.444870] qcom-ethqos 23000000.ethernet eth0: interface 2500base-x inband modes: pcs=01 phy=00
	[   10.453913] qcom-ethqos 23000000.ethernet eth0: major config, active phy/outband/2500base-x
	[   10.462506] qcom-ethqos 23000000.ethernet eth0: phylink_mac_config: mode=phy/2500base-x/none adv=0000000,00000000,00000000,00000000 pause=00
	[   10.485700] qcom-ethqos 23000000.ethernet eth0: phy link down 2500base-x/Unknown/Unknown/none/off/nolpi
	[   15.131941] qcom-ethqos 23000000.ethernet eth0: phy link up 2500base-x/2.5Gbps/Full/none/rx/tx/nolpi
	[   15.143632] qcom-ethqos 23000000.ethernet eth0: ethqos_configure_sgmii : Speed = 2500
	[   15.153226] stmmac_pcs: Link Up
	[   15.153274] qcom-ethqos 23000000.ethernet eth0: Link is Up - 2.5Gbps/Full - flow control rx/tx


2. 1G Link up - Warning (PCS configuration changed from phylink by glue,
please report: 0x00040000 -> 0x00041200). Data path works fine.

	[   10.420439] qcom-ethqos 23000000.ethernet eth0: PHY stmmac-0:00 uses interfaces 4,23,27, validating 23
	[   10.430023] qcom-ethqos 23000000.ethernet eth0:  interface 23 (2500base-x) rate match pause supports 0-7,9,13-14,47
	[   10.440749] qcom-ethqos 23000000.ethernet eth0: PHY [stmmac-0:00] driver [Aquantia AQR115C] (irq=365)
	[   10.450223] qcom-ethqos 23000000.ethernet eth0: phy: 2500base-x setting supported 0000000,00000000,00008000,000062ff advertising 0000000,00000000,00008000,000062ff
	[   10.506829] qcom-ethqos 23000000.ethernet eth0: configuring for phy/2500base-x link mode
	[   10.515147] qcom-ethqos 23000000.ethernet eth0: major config, requested phy/2500base-x
	[   10.523291] qcom-ethqos 23000000.ethernet eth0: interface 2500base-x inband modes: pcs=01 phy=00
	[   10.532328] qcom-ethqos 23000000.ethernet eth0: major config, active phy/outband/2500base-x
	[   10.540919] qcom-ethqos 23000000.ethernet eth0: phylink_mac_config: mode=phy/2500base-x/none adv=0000000,00000000,00000000,00000000 pause=00
	[   10.563437] qcom-ethqos 23000000.ethernet eth0: phy link down 2500base-x/Unknown/Unknown/none/off/nolpi
	[   13.912074] qcom-ethqos 23000000.ethernet eth0: phy link up sgmii/1Gbps/Full/none/rx/tx/nolpi
	[   13.919074] stmmac_pcs: Link Up
	< a *bunch* of "stmmac_pcs: Link Down" prints, more details in 4.>
	[   14.948996] stmmac_pcs: Link Up
	[   14.949149] stmmac_pcs: Link Down
	[   14.949169] stmmac_pcs: Link Up
	[   14.949301] qcom-ethqos 23000000.ethernet eth0: major config, requested phy/sgmii
	[   14.949317] stmmac_pcs: Link Down
	[   14.949326] qcom-ethqos 23000000.ethernet eth0: interface sgmii inband modes: pcs=03 phy=03
	[   14.949331] qcom-ethqos 23000000.ethernet eth0: major config, active phy/outband/sgmii
	[   14.949335] qcom-ethqos 23000000.ethernet eth0: phylink_mac_config: mode=phy/sgmii/none adv=0000000,00000000,00000000,00000000 pause=03
	[   14.952026] qcom-ethqos 23000000.ethernet eth0: ethqos_configure_sgmii : Speed = 1000
	[   14.952033] dwmac: PCS configuration changed from phylink by glue, please report: 0x00040000 -> 0x00041200
	[   14.952057] qcom-ethqos 23000000.ethernet eth0: Link is Up - 1Gbps/Full - flow control rx/tx
	[   15.035977] stmmac_pcs: ANE process completed
	[   15.035978] stmmac_pcs: Link Down
	[   15.036004] stmmac_pcs: Link Up


3. 100M Link up - Warning (PCS configuration changed from phylink by
glue, please report: 0x00040000 -> 0x00041200). Data path works fine.

	[   20.273135] qcom-ethqos 23000000.ethernet eth0: PHY stmmac-0:00 uses interfaces 4,23,27, validating 23
	[   20.282703] qcom-ethqos 23000000.ethernet eth0:  interface 23 (2500base-x) rate match pause supports 0-7,9,13-14,47
	[   20.293413] qcom-ethqos 23000000.ethernet eth0: PHY [stmmac-0:00] driver [Aquantia AQR115C] (irq=340)
	[   20.302877] qcom-ethqos 23000000.ethernet eth0: phy: 2500base-x setting supported 0000000,00000000,00008000,000062ff advertising 0000000,00000000,00008000,000062ff
	[   20.358642] qcom-ethqos 23000000.ethernet eth0: configuring for phy/2500base-x link mode
	[   20.366973] qcom-ethqos 23000000.ethernet eth0: major config, requested phy/2500base-x
	[   20.381114] qcom-ethqos 23000000.ethernet eth0: interface 2500base-x inband modes: pcs=01 phy=00
	[   20.390144] qcom-ethqos 23000000.ethernet eth0: major config, active phy/outband/2500base-x
	[   20.398720] qcom-ethqos 23000000.ethernet eth0: phylink_mac_config: mode=phy/2500base-x/none adv=0000000,00000000,00000000,00000000 pause=00
	[   20.418477] stmmac_pcs: Link Down
	[   20.421912] stmmac_pcs: Link Down
	[   20.426255] qcom-ethqos 23000000.ethernet eth0: phy link down 2500base-x/100Mbps/Full/none/rx/tx/nolpi
	[   20.440795] stmmac_pcs: Link Down
	[   23.095229] qcom-ethqos 23000000.ethernet eth0: phy link up sgmii/100Mbps/Full/none/rx/tx/nolpi
	[   23.101362] stmmac_pcs: Link Down
	[   23.106527] qcom-ethqos 23000000.ethernet eth0: major config, requested phy/sgmii
	[   23.107624] stmmac_pcs: Link Down
	[   23.118707] stmmac_pcs: Link Down
	[   23.124703] qcom-ethqos 23000000.ethernet eth0: interface sgmii inband modes: pcs=03 phy=03
	[   23.128141] stmmac_pcs: Link Down
	[   23.136699] qcom-ethqos 23000000.ethernet eth0: major config, active phy/outband/sgmii
	[   23.140126] stmmac_pcs: Link Down
	[   23.148232] qcom-ethqos 23000000.ethernet eth0: phylink_mac_config: mode=phy/sgmii/none adv=0000000,00000000,00000000,00000000 pause=03
	[   23.151657] stmmac_pcs: Link Down
	[   23.166924] qcom-ethqos 23000000.ethernet eth0: ethqos_configure_sgmii : Speed = 100
	[   23.167584] stmmac_pcs: Link Down
	[   23.175511] dwmac: PCS configuration changed from phylink by glue, please report: 0x00040000 -> 0x00041200
	[   23.178944] stmmac_pcs: Link Up
	[   23.188862] qcom-ethqos 23000000.ethernet eth0: Link is Up - 100Mbps/Full - flow control rx/tx
	[   23.192097] stmmac_pcs: Link Down
	[   23.204346] stmmac_pcs: ANE process completed
	[   23.208828] stmmac_pcs: Link Up

4. Sometimes after toggling the interface or even during boot-up, the
console gets flooded with "stmmac_pcs: Link Down" prints. For e.g.,

	// Interface toggled
	< a bunch of "stmmac_pcs: Link Down" prints>
	[  549.898750] stmmac_pcs: Link Down
	[  549.902186] stmmac_pcs: Link Down
	[  549.905628] stmmac_pcs: Link Down
	[  549.909069] stmmac_pcs: Link Down
	[  549.912509] stmmac_pcs: Link Down
	[  549.915948] stmmac_pcs: Link Down
	[  549.919391] stmmac_pcs: Link Down
	[  549.922858] stmmac_pcs: Link Down
	[  549.924140] qcom-ethqos 23000000.ethernet eth0: ethqos_configure_sgmii : Speed = 2500
	[  549.926304] stmmac_pcs: Link Down
	[  549.934349] qcom-ethqos 23000000.ethernet eth0: Link is Up - 2.5Gbps/Full - flow control rx/tx
	[  549.937746] stmmac_pcs: Link Up

   ethtool stats reveal an unusually high number of interrupts (I have
   seen this number go as high as about 16000 when booting up with a 1G
   link)
	     irq_pcs_ane_n: 0
	     irq_pcs_link_n: 1998	

5. Switching between 100M/1G/2.5G link is a bit of a mixed bag.
Sometimes it works, sometimes the data path breaks and needs an
interface toggle to be functional again. I don't necessarily think that
it's due to the speed specific configurations done by configure_sgmii as
that shouldn't impact switching between 1G and 2.5G, or even the switch
from 1G/2.5G to 100M.

While this is *broken* on net-next as well, the current patch series
allowed me to notice a peculiar behavior - it looks like sometimes the
PCS link doesn't come up:
	
	[   55.491996] qcom-ethqos 23000000.ethernet eth0: phy link down 2500base-x/2.5Gbps/Full/none/rx/tx/nolpi
	[   55.501622] qcom-ethqos 23000000.ethernet eth0: Link is Down
	[   58.907705] qcom-ethqos 23000000.ethernet eth0: phy link up sgmii/1Gbps/Full/none/rx/tx/nolpi
	[   58.913724] stmmac_pcs: Link Down
	[   58.919947] qcom-ethqos 23000000.ethernet eth0: major config, requested phy/sgmii
	[   58.927656] qcom-ethqos 23000000.ethernet eth0: interface sgmii inband modes: pcs=03 phy=03
	[   58.936256] qcom-ethqos 23000000.ethernet eth0: major config, active phy/outband/sgmii
	[   58.944409] qcom-ethqos 23000000.ethernet eth0: phylink_mac_config: mode=phy/sgmii/none adv=0000000,00000000,00000000,00000000 pause=03
	[   58.958298] qcom-ethqos 23000000.ethernet eth0: ethqos_configure_sgmii : Speed = 1000
	[   58.967448] dwmac: PCS configuration changed from phylink by glue, please report: 0x00040000 -> 0x00041200
	[   58.977392] qcom-ethqos 23000000.ethernet eth0: Link is Up - 1Gbps/Full - flow control rx/tx


Since 5 is unrelated to this series (I'll try to debug it separately),
let me know if you'd like me to run any other experiments for 2, 3, and
4.

> The "invalid port speed" warning that results if this property is
> not set to 10, 100 or 1000 is another bug - only if this warning
> is printed will the "normal" mode be selected.
> 
> Since the PCS series 1 and 2 have been merged into net-next, it
> will be safe to submit patches removing these properties from your
> DT files, without fear of this warning appearing.
> 

Thanks for the explanation. I see the incorrect use of snps,ps-speed in
the DT of a couple of more boards that use the same MAC core. Would it
be okay to add your Suggested-by when submitting the fix patches?

	Ayaan


