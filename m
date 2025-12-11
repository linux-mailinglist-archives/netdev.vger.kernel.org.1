Return-Path: <netdev+bounces-244382-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C457CB6017
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 14:25:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D801130053DD
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 13:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B10653128D8;
	Thu, 11 Dec 2025 13:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="CED8m0U7"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFEC930FC34
	for <netdev@vger.kernel.org>; Thu, 11 Dec 2025 13:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765459512; cv=none; b=QI+eVT0vge/qXkeyJ3qiidyp5PywiPDTaIpNfiK3Qf24EkMeb4Dp7wE2MWXWtdBabhmHSPGRd3DeCdAcS49m7rAzPM7qFiAXiXaSpq+gfYH1nFjm7NJqspSPO0sHQkd9FW4K+Wi8Gwq4zOHFvvHWLdn19QJVrwZrKEFuO6FqZJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765459512; c=relaxed/simple;
	bh=laY4BsscU+8JqNoFj3VikjPMD/kZ2xMsRi1KAeU4AGU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ROUi+gcImWOUGICTkGg5iKNIWQwIfSPxZ2iBi6xOL0sdJ8jqPGaSOJyF9XplM6E0shGUokpX6vqsm1q4JgjqfNqVJ4OQJHqUuS8WaRHX1exgEX88A41ZtIl5SFv9MZZ1I/UuBdx+jRY9EknS0zhIg96S3GOJRnWkUZ6OOVj39ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=CED8m0U7; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BBAnMNg3502117;
	Thu, 11 Dec 2025 05:24:37 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=wfQbX2SjhrGKRQbrl94o40hS6
	j97fIeP2C3+XHElKqg=; b=CED8m0U7vkVbXITVHO0xivHfeq27tkLDsksWl8M5u
	Q+EVKPc2+/pqXgefh0kEp8Q7ZKiWEtzgHaEYMpbTGU/13x9jWMoMrhxck1VojNRZ
	zdYKIdHcD9T4bW+RQW9ORGoeKrPLWun2ZUxQunYBZ8Yimov+k4aNppKRJRg9s7vX
	zjLoyPwZhcdpQZTt8WhRMhe5wTDOXWZ6MiN3lJ/AxNEVMdudX9ssgMAfPvgmbxvo
	Fq30grK3Ml47tfkfnd3yT2+SP2Hv38SHk06ebVhWEVtyJY+jjofWmJ86wANCCjdw
	TOOWiDvSOA3464tJeQOsn6KblAZlm9RCYO+VdYFvV/0kA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4ayjcr1jvj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Dec 2025 05:24:36 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 11 Dec 2025 05:24:48 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 11 Dec 2025 05:24:48 -0800
Received: from test-OptiPlex-Tower-Plus-7010 (unknown [10.29.37.157])
	by maili.marvell.com (Postfix) with SMTP id 802335B694D;
	Thu, 11 Dec 2025 05:24:34 -0800 (PST)
Date: Thu, 11 Dec 2025 18:54:33 +0530
From: Hariprasad Kelam <hkelam@marvell.com>
To: Carolina Jubran <cjubran@nvidia.com>
CC: Michal Kubecek <mkubecek@suse.cz>,
        "John W . Linville"
	<linville@tuxdriver.com>,
        <netdev@vger.kernel.org>, Yael Chemla
	<ychemla@nvidia.com>
Subject: Re: [PATCH ethtool 1/2] update UAPI header copies
Message-ID: <aTrGEQIX6b40assX@test-OptiPlex-Tower-Plus-7010>
References: <20251204075930.979564-1-cjubran@nvidia.com>
 <20251204075930.979564-2-cjubran@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251204075930.979564-2-cjubran@nvidia.com>
X-Authority-Analysis: v=2.4 cv=XtT3+FF9 c=1 sm=1 tr=0 ts=693ac614 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=kj9zAlcOel0A:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Ikd4Dj_1AAAA:8 a=cUtql3D_vCewy87OvC0A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: Gq0FeoqhOS3R1vZ45UrZvcjuEQaRWYTB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjExMDEwNSBTYWx0ZWRfX+Q5vXUfUwm3W
 lSTNVcGt54e7Drbzaw65Z9FXjwEzOUgrKoGI70gnt8NsJyIFDrwsEOFhpIwgrbiH8bTdbaGOU7N
 uVeLytoqHd57VVE9m2k60wgFGaE/N/YuBVrQ/oDCo0ltspG4IITUCUNTvFNuaJ+L99EWVhIKnAW
 f6OI0OdY/RTLjHCiF/PlZala4J/RDEVbX/SWL52zvUD7KzkqjJZUC9flBykU1f9UpoGQvAMtCrU
 hK/MS2VKWhKKqDzLidqjk1PmPVL+LyN9Ja7Rs127CkaRSl+bOboRCvoUH2nw5GBdApsTCkH6F2h
 OtqTQ5ockfxv55kbShP0rf9A7U/aCayTSrQVnrOZk0vp16KkUCCfrLCHQGybVPwq+KviTDMSZSM
 fYBEo0fM32DS+6DP69dc2qMqCJpeaA==
X-Proofpoint-GUID: Gq0FeoqhOS3R1vZ45UrZvcjuEQaRWYTB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-11_01,2025-12-09_03,2025-10-01_01

On 2025-12-04 at 13:29:29, Carolina Jubran (cjubran@nvidia.com) wrote:
> From: Yael Chemla <ychemla@nvidia.com>
> 
> Update to kernel commit 491c5dc98b84.
> 
> Signed-off-by: Yael Chemla <ychemla@nvidia.com>
> Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
> ---
>  uapi/linux/ethtool.h                   |  6 ++++
>  uapi/linux/ethtool_netlink_generated.h | 47 ++++++++++++++++++++++++++
>  uapi/linux/if_ether.h                  |  2 ++
>  uapi/linux/if_link.h                   |  3 ++
>  uapi/linux/stddef.h                    |  1 -
>  5 files changed, 58 insertions(+), 1 deletion(-)
>

	looks like there are no changes in "stddef.h", but its part of this patch.

Thanks,
Hariprasad k 

