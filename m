Return-Path: <netdev+bounces-251050-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 854CFD3A657
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 12:09:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 746B8302550E
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 11:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38AD33590DD;
	Mon, 19 Jan 2026 11:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="lOKqtFkb"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D313590D9
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 11:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768820913; cv=none; b=tPEyB/FfXoPWgAbMNcuSjRqbv4jExbQjgXHwGqN0obij6Mv4RJJnd4KN9VucOic94mSKCFS/UGrLY5IPP3vSaoj8sEr8CwjmgaU073wTOS6LBWEQqN1BKQHWpTb6RclM0QeoBdt7T7pPDuWtG7leEfOx9WjrDOeEuGlqs7pSHtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768820913; c=relaxed/simple;
	bh=r0zdOyYcIl2us2Z7PYxZRD6ZD6u18Wv8v4Zhh6NmzoQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RveGVzKxkDkJbS3lW+rTBXduJBTB7gpXtapSGS0Xfv7BHSjz3b/yR64DHqd+vMIyQYaWQmYRzBDViT64dKktiCOz3VG4K4OWUsmH5hRDywMPBzgDtHVZUsYt6csyk98Ruhcxcs3Y6BldmDLRnWOJ8uXsM3Yhv8SftFFzttUDAcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=lOKqtFkb; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60J7EMgp1824128;
	Mon, 19 Jan 2026 03:08:18 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=4gHbJe53rkw95x7pgyN6gpZ3/
	M3PAtGilj0WtCNCXs0=; b=lOKqtFkbg7xgbsqO2iIX7x0KpaM2KZOPCmlV5FkVl
	gDZHvCDOlEzQiEDhrKQ5GJ5sxakhz5aVvwo/is1awUVFE49apvgYRPYn4+S9LC3J
	ydTU3RsAqgJziE/VgUFLFzPQJL6cBLjGymryqOChC2MmATO0z5g3PJvLeM/oiAVI
	IdUb6nhlBEkv2oB6HE3t9TXk1hIOjjlV80XebBtWVovYWZc4vMbvNeTbuEC4SqTr
	qbKAnE0TVgQB3QYJz9tctLdZIWxkBN6UJm/a3RBeMK16u0WVoPPs9oz483iixnMa
	8Jd8lLtRnpPiuE/TQKZQJnt0hVe5fVPpcsyVFNeJ0kxnw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4bsg208cu4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Jan 2026 03:08:17 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 19 Jan 2026 03:08:32 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 19 Jan 2026 03:08:32 -0800
Received: from kernel-ep2 (unknown [10.29.36.53])
	by maili.marvell.com (Postfix) with SMTP id 6E80A3F7051;
	Mon, 19 Jan 2026 03:08:12 -0800 (PST)
Date: Mon, 19 Jan 2026 16:38:11 +0530
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: Alok Tiwari <alok.a.tiwari@oracle.com>
CC: <sd@queasysnail.net>, <bbhushan2@marvell.com>, <pabeni@redhat.com>,
        <kuba@kernel.org>, <edumazet@google.com>, <davem@davemloft.net>,
        <andrew+netdev@lunn.ch>, <jerinj@marvell.com>, <hkelam@marvell.com>,
        <gakula@marvell.com>, <lcherian@marvell.com>, <sgoutham@marvell.com>,
        <george.cherian@marvell.com>, <netdev@vger.kernel.org>,
        <alok.a.tiwarilinux@gmail.com>
Subject: Re: [PATCH net-next] octeontx2: cn10k: fix RX flowid TCAM mask
 handling
Message-ID: <20260119110811.GA1492101@kernel-ep2>
References: <20260116164724.2733511-1-alok.a.tiwari@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260116164724.2733511-1-alok.a.tiwari@oracle.com>
X-Proofpoint-ORIG-GUID: HBW3Upl3ybiahIt5diQrwsE4X3B-Z7Hn
X-Authority-Analysis: v=2.4 cv=XPY9iAhE c=1 sm=1 tr=0 ts=696e10a1 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=M5GUcnROAAAA:8 a=T7My_dRlYyChwkeLhiYA:9 a=CjuIK1q_8ugA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=8_z660xuARpGUQqPBE_n:22
X-Proofpoint-GUID: HBW3Upl3ybiahIt5diQrwsE4X3B-Z7Hn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE5MDA5MiBTYWx0ZWRfXzpSM1RnavjM2
 Pnk/BDdxzX9iIj5AroxbW9lZ6AsdehLJlKhWZ8xoV9bIygU41o+CKV09Mh3oowJOGK3LpvOwimk
 7MULog7kipv9Z9MdxQoVyHngIqBXU5P+imU1fGdznXpHPd2ptutsYEzp6SLak0wkhsctEkGEDO9
 +kbrJ55APwtpTnl3G+Z1ePaO/z9bpvLJRCisELOoMY5xmxSrRg8WaxxMdmJN5fjvQuYsEPs65Ml
 11LF6AzjZ90GnYME2MTpDdKt1zdTz31tJwEY0UQDiHHiV+PErI1aIHNd3imXnGMlcTZbsb1aFRL
 g2K7Jmka4Qp9VZaIX82ZzBlqYT6ph6xU6/AFznabJBKZl7YrtZHbwhL7nboALZojpMGF2uRFxkO
 /+fKaRx2mCHU9wKskJuKb7qz+ewTNG1+55RMpNzUeZKBPVEyjlC+haYhOkQhF42GSOeDffteNEd
 0OhuKUr62x7u1wU803A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-19_02,2026-01-19_02,2025-10-01_01

On 2026-01-16 at 22:17:12, Alok Tiwari (alok.a.tiwari@oracle.com) wrote:
> The RX flowid programming initializes the TCAM mask to all ones, but
> then overwrites it when clearing the MAC DA mask bits. This results
> in losing the intended initialization and may affect other match fields.
> 
> Update the code to clear the MAC DA bits using an AND operation, making
> the handling of mask[0] consistent with mask[1], where the field-specific
> bits are cleared after initializing the mask to ~0ULL.
> 
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
This has no impact in functionality and it is better to be consistent with
mask[1]. Thanks for the change.

Reviewed-by: Subbaraya Sundeep <sbhatta@marvell.com>

> ---
>  drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c
> index 4c7e0f345cb5..060c715ebad0 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c
> @@ -328,7 +328,7 @@ static int cn10k_mcs_write_rx_flowid(struct otx2_nic *pfvf,
>  
>  	req->data[0] = FIELD_PREP(MCS_TCAM0_MAC_DA_MASK, mac_da);
>  	req->mask[0] = ~0ULL;
> -	req->mask[0] = ~MCS_TCAM0_MAC_DA_MASK;
> +	req->mask[0] &= ~MCS_TCAM0_MAC_DA_MASK;
>  
>  	req->data[1] = FIELD_PREP(MCS_TCAM1_ETYPE_MASK, ETH_P_MACSEC);
>  	req->mask[1] = ~0ULL;
> -- 
> 2.50.1
> 

