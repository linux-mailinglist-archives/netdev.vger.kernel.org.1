Return-Path: <netdev+bounces-190009-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD139AB4E23
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 10:32:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D76617E91C
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 08:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC221F8BBD;
	Tue, 13 May 2025 08:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="RldO8bwS"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625C01F2C44
	for <netdev@vger.kernel.org>; Tue, 13 May 2025 08:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747125146; cv=none; b=g0eDnocByJQOLAgaksH9kinswKtNVP3Y2pzh1A1fOnLjM+MLsxhr7SC12NS1LTxc9civnOsQTDCLj3p23zawk9POtZ1ODSG/ipK9+B+4mwqzdgh2j7yUuFJV/Mi6TMu/7tQiajutE9li9gBVcfDHVVYlQkNuDLTd0JE5pTorDy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747125146; c=relaxed/simple;
	bh=faFBfjYEq8nob5YC35X7rsulHWjxG0g5WcEMYq45RtQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IlvB5z5OodBHpVnHrLnzdfV/OE0gRxO4tJd8cmOTp4CJUdINk8c4Lt5PLXoxMTZhKurECCJRstA+Xzu1nFGck3M29M9bncyX4Z/bUc1iBukLp+VEL5KZciczPG7UacWPKyFelbFbVCRjVSVdOHUJ6R68B5pbvxFP4ry1QPcSJPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=RldO8bwS; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54D8RwKX023877;
	Tue, 13 May 2025 01:32:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=G266QBVu9i2HkTtnGgucaGscd
	1ZLggN81JADSLgWNKY=; b=RldO8bwSNWQtK+UeazwpzAU4kt8nlFXsKmLwppH8d
	KUbfoy+N1HWO9UjwGkU1XH9mMRgXrmtCWp2QBytuRw4nn1dfm6fnaLuKb5KL+Bs8
	xdtw0EP/IMDoWS3WOd6/rH3qUYX+SrEszETE0KsVsphJImHV7M75w8NcHAseQ8ku
	RkvEUJXS2H2g3x1FFIeSbfF62+onnNaqGWqOmysBVOpp+lIe8RB0JNr5xsaG6qXt
	UF9nfZmvWXsWTxylP5ClpzEhsxbRQx2G2mChP7OjTYmfJbCy1dJzMjSbkqr3VYgw
	GDNGmg8Zh/l2zRIqk52xr4dEPmoC1UUVLEL0bqC3P8TDQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 46m2kb8087-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 May 2025 01:32:14 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 13 May 2025 01:32:13 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 13 May 2025 01:32:13 -0700
Received: from 59cc1f87bccd (HY-LT91368.marvell.com [10.29.24.116])
	by maili.marvell.com (Postfix) with SMTP id 5EAFA3F7079;
	Tue, 13 May 2025 01:32:09 -0700 (PDT)
Date: Tue, 13 May 2025 08:32:07 +0000
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: Simon Horman <horms@kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <gakula@marvell.com>,
        <hkelam@marvell.com>, <sgoutham@marvell.com>, <lcherian@marvell.com>,
        <bbhushan2@marvell.com>, <jerinj@marvell.com>,
        <netdev@vger.kernel.org>
Subject: Re: [net-next v2 PATCH 2/2] octeontx2-pf: macsec: Get MACSEC
 capability flag from AF
Message-ID: <aCMDhyuY2_B-c0CE@59cc1f87bccd>
References: <1746969767-13129-1-git-send-email-sbhatta@marvell.com>
 <1746969767-13129-3-git-send-email-sbhatta@marvell.com>
 <20250512163732.GS3339421@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250512163732.GS3339421@horms.kernel.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEzMDA4MCBTYWx0ZWRfX/oD8gA7sxM5/ Re563Bjqgw/l37r4tsvG1Z0/mmY8ZBg/FDMh6HWXhol+L65AFDZQ4i5tqduIdYY7g9ECpy+hHtx 0LWKpmh5k3Gtr87zCNn6zTLblNibtEtLA6YOVEVB49yzZ9Gq5AMbJaksCSaSfi7Ig5losASr4gb
 ZxHfu5TDiGmAu1otiESrxkPTKo71oQf/FB5i9rsL6Z+B/InTKI0+E3d8TVjLboujvRcxZ+73hfu cQm7ypAaMdgBJtsc9AAlKzhI3c/jQmza96Y5h9RH2xXX62CAUdQiuCEilJKntJmik9oWVJjORlb HUGVE3s/3PG/AHg6zSiX4llH9rI3cKm51aX/ZRzEsGsZkX16QmiiPj7OeehbIhu+SGtj4mtbulP
 A+gsBx+5A5PWQ4ZzEkvf0RhqKLuYGG9VcN5vd8ZtlzGCNP9l8rXZzOWImDpDCUBeB/CSaBVU
X-Authority-Analysis: v=2.4 cv=RvXFLDmK c=1 sm=1 tr=0 ts=6823038e cx=c_pps a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8 a=WSI0S-zNqxrGslh8q8AA:9 a=CjuIK1q_8ugA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: 3d-PqArv5CTXBuDqOXllmeb-RhWMuRbM
X-Proofpoint-ORIG-GUID: 3d-PqArv5CTXBuDqOXllmeb-RhWMuRbM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_07,2025-05-09_01,2025-02-21_01

Hi Simon,

On 2025-05-12 at 16:37:32, Simon Horman (horms@kernel.org) wrote:
> On Sun, May 11, 2025 at 06:52:47PM +0530, Subbaraya Sundeep wrote:
> > The presence of MACSEC block is currently figured out based
> > on the running silicon variant. This may not be correct all
> > the times since the MACSEC block can be fused out. Hence get
> > the macsec info from AF via mailbox.
> > 
> > Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
> 
> ...
> 
> > diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
> > index 7e3ddb0..7d0e39d 100644
> > --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
> > +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
> > @@ -631,9 +631,6 @@ static inline void otx2_setup_dev_hw_settings(struct otx2_nic *pfvf)
> >  		__set_bit(CN10K_PTP_ONESTEP, &hw->cap_flag);
> >  		__set_bit(QOS_CIR_PIR_SUPPORT, &hw->cap_flag);
> >  	}
> > -
> > -	if (is_dev_cn10kb(pfvf->pdev))
> > -		__set_bit(CN10K_HW_MACSEC, &hw->cap_flag);
> >  }
> >  
> >  /* Register read/write APIs */
> > @@ -1043,6 +1040,7 @@ void otx2_disable_napi(struct otx2_nic *pf);
> >  irqreturn_t otx2_cq_intr_handler(int irq, void *cq_irq);
> >  int otx2_rq_init(struct otx2_nic *pfvf, u16 qidx, u16 lpb_aura);
> >  int otx2_cq_init(struct otx2_nic *pfvf, u16 qidx);
> > +int otx2_set_hw_capabilities(struct otx2_nic *pfvf);
> >  
> >  /* RSS configuration APIs*/
> >  int otx2_rss_init(struct otx2_nic *pfvf);
> > diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> > index 0aee8e3..a8ad4a2 100644
> > --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> > +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> > @@ -3126,6 +3126,8 @@ static int otx2_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> >  	if (err)
> >  		goto err_ptp_destroy;
> >  
> > +	otx2_set_hw_capabilities(pf);
> > +
> >  	err = cn10k_mcs_init(pf);
> >  	if (err)
> >  		goto err_del_mcam_entries;
> 
> Hi Subbaraya,
> 
> If I read things correctly otx2_setup_dev_hw_settings() is called
> for both representors and non-representors, while otx2_probe is
> only called for non-representors.
> 
> If so, my question is if this patch changes behaviour for representors.
> And, again if so, if that is intentional.
I assume you mean VF driver for representors and PF driver for
non-representor. Yes this is intentional. We currently do not support
macscec offload on VFs hence I changed only PF driver. In case we want
to support macsec offload on VFs too then otx2vf_probe also need to be
changed like:
otx2_set_hw_capabilities(vf);
err = cn10k_mcs_init(vf);

Thanks,
Sundeep

