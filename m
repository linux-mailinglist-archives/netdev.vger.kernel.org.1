Return-Path: <netdev+bounces-190111-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6050CAB5348
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 12:56:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D63F03ADF99
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 10:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C31D02874F6;
	Tue, 13 May 2025 10:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Oznm+cQ9"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028A628642F;
	Tue, 13 May 2025 10:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747133759; cv=none; b=XsX+5Zyi0Ov2rbYlI0UDGk3gtt7jeQCagj5kprqnaZWrvuUa0M8xdWkyIN7vqNrIqZVsqnbeYiqmFi4An3MpVVzbY8YA/6tMjPQay/GTDxrL6VCH2yVKkAo4s5vYdrisKR2rZkRu2e5FUfrHUwzk/Fq/4bRGg3bu6RxXRQOrhD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747133759; c=relaxed/simple;
	bh=ciOVq4sh0Ncp+ksAKbWmLmP3Suiat2c42w21Jsa+btk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e1FecPBPCt+DnMn0Y64zdPE2d0ugm7O7Pwd968XZUZAkt/okSUNoSpD1T4csOJyXkGnYdF9cyzgjhJ/gyA7ElvIO0qZgQ7+nZnKr/FqlD2IEHDt+YE24QRO3gGz5xHEJRwZ3+dYeIrzhuhKOp3zhm0lfIoHAla8IOZzmY0tJY9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Oznm+cQ9; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54D8SEfE024021;
	Tue, 13 May 2025 03:55:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=VIr8Qh2ZtEpe9hvAdMcLT/JQ0
	RZBULO0L6hPOboIZ4w=; b=Oznm+cQ9hxVH8QQdFhcCNwvBlLb0DlSVvslFBiFsY
	PiWNddwyEP68vu6s+B0PoznFdb9VPhdFXGLh/9lWEbqi09xyGo+93NToxfm4IRUu
	kzsjfOmCycE8ainQqDChjSvsqlepDG/n4v9VzZgBOKdu3d4R1J8QP8093DBdLL1u
	t3JtDKW3svKYFR2hzSvFVkE5K3POlqq14yDgpoG3SwqnrZyNEOdVWr5xkNfh4nf9
	Qvk6KZ5NFGbSOjzESmwmQn2GTR7jbx9nvUQajOpsdjThT6McvcBhXzsPGoYjamLt
	pGk/v0R5sTfrMnwfpuX5WkLvzPG5qXhuYycSme5nMvDKw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 46m2kb88sh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 May 2025 03:55:36 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 13 May 2025 03:55:35 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 13 May 2025 03:55:35 -0700
Received: from test-OptiPlex-Tower-Plus-7010 (unknown [10.29.37.157])
	by maili.marvell.com (Postfix) with SMTP id B3A723F7060;
	Tue, 13 May 2025 03:55:30 -0700 (PDT)
Date: Tue, 13 May 2025 16:25:29 +0530
From: Hariprasad Kelam <hkelam@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Sunil Goutham <sgoutham@marvell.com>, Linu Cherian <lcherian@marvell.com>,
        Geetha sowjanya <gakula@marvell.com>, Jerin Jacob <jerinj@marvell.com>,
        Subbaraya Sundeep <sbhatta@marvell.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "Bharat
 Bhushan" <bbhushan2@marvell.com>
Subject: Re: [net-next] octeontx2-pf: ethtool: Display "Autoneg" and "Port"
 fields
Message-ID: <aCMlIRyTkxBvlcQ9@test-OptiPlex-Tower-Plus-7010>
References: <20250513061351.720880-1-hkelam@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250513061351.720880-1-hkelam@marvell.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEzMDEwNCBTYWx0ZWRfX85pinZ9jHzAt PdsRGX9b2Pn0XDZSzkG1hlS7+YcHU/w/dDV7LqWMqJl90K+5s6vEuq59KiRfvkf+AvQTercZToN yuCmyvGdtehh87Prnuk9fh78Rrf+q4dPVx8FCaAyPAUMarz+hBlm80WG6n4hsOF5JZ3fpyjqOJQ
 /KQ3QWlFBDLJUxf26xaccOAAA3Tt/8P7Up7fquvl5mYfKW99aEJcDcBXacDuyo0eb/GRJbhE+IH UOY3W3XalmvAGn7c9gXIycbAbdFAumTFzZYQnTxFayjyhA+3kIWikr32Xn/O8Twly/Lu4uGxvAr aDfeQcNI6mZNUSXzRqH0eEcbJ1QvaXAl2Uwdzb7riJxC/EW6XxR0XLpN3LpfCtcTOEMXIMNmiMa
 EJzhYuetAZDUU8e6G4WNJC5KhaFnuGQu3jrE8YsFJ5u3HUPP44UQad5aWmyTF8Z0thzH9uRM
X-Authority-Analysis: v=2.4 cv=RvXFLDmK c=1 sm=1 tr=0 ts=68232528 cx=c_pps a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=ZQaTuHtM0VOx_EhDzS0A:9 a=CjuIK1q_8ugA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: S_nntCW57a2Hj6knupxHEgiToZ-CL3rs
X-Proofpoint-ORIG-GUID: S_nntCW57a2Hj6knupxHEgiToZ-CL3rs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_07,2025-05-09_01,2025-02-21_01

On 2025-05-13 at 11:43:51, Hariprasad Kelam (hkelam@marvell.com) wrote:

Please ignore this patch, accidentally submitted old version

> The Octeontx2/CN10k netdev drivers access a shared firmware structure
> to obtain link configuration details, such as supported and advertised
> link modes.
> 
> This patch updates the shared firmware data to include additional
> fields like 'Autonegotiation' and 'Port type'.
> 
> example output:
>   ethtool ethx
> 	 Advertised auto-negotiation: Yes
> 	 Port: Twisted Pair
> 
> Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
> ---
>  drivers/net/ethernet/marvell/octeontx2/af/mbox.h          | 4 +++-
>  drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c | 5 +++++
>  2 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
> index 005ca8a056c0..4a305c183987 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
> @@ -652,7 +652,9 @@ struct cgx_lmac_fwdata_s {
>  	/* Only applicable if SFP/QSFP slot is present */
>  	struct sfp_eeprom_s sfp_eeprom;
>  	struct phy_s phy;
> -#define LMAC_FWDATA_RESERVED_MEM 1021
> +	u64 advertised_an:1;
> +	u64 port;
> +#define LMAC_FWDATA_RESERVED_MEM 1019
>  	u64 reserved[LMAC_FWDATA_RESERVED_MEM];
>  };
>  
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
> index 010385b29988..d49d76eabc07 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
> @@ -1190,6 +1190,7 @@ static int otx2_get_link_ksettings(struct net_device *netdev,
>  	cmd->base.duplex  = pfvf->linfo.full_duplex;
>  	cmd->base.speed   = pfvf->linfo.speed;
>  	cmd->base.autoneg = pfvf->linfo.an;
> +	cmd->base.port    = rsp->fwdata.port;
>  
>  	rsp = otx2_get_fwdata(pfvf);
>  	if (IS_ERR(rsp))
> @@ -1199,6 +1200,10 @@ static int otx2_get_link_ksettings(struct net_device *netdev,
>  		ethtool_link_ksettings_add_link_mode(cmd,
>  						     supported,
>  						     Autoneg);
> +	if (rsp->fwdata.advertised_an)
> +		ethtool_link_ksettings_add_link_mode(cmd,
> +						     advertising,
> +						     Autoneg);
>  
>  	otx2_get_link_mode_info(rsp->fwdata.advertised_link_modes,
>  				OTX2_MODE_ADVERTISED, cmd);
> -- 
> 2.34.1
> 
> 

