Return-Path: <netdev+bounces-98860-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F638D2B6C
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 05:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CE8B1F23921
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 03:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633FC15B0F8;
	Wed, 29 May 2024 03:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="KExnirD7"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAAB58BE0;
	Wed, 29 May 2024 03:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716953153; cv=none; b=QXBsLyplglqCO00bkE0w6zudvWcyBsF9g6fdMdrqX6y6fiF/8+xVL2Bk3CvWETJv1I8MIAIxsAYG14Iw8WHdmZRQ9fbg2rE+xtft+jIS9rJbpwJG+760bGQfY4W5FNbd+ioP8D7/kGfKFBNMpAjQ+hufzdUeTpX6gBOnTj+ZKyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716953153; c=relaxed/simple;
	bh=a76FVNEm9gPLwLvUPh2ExXQFC1oXoRQpE0AaeCg3ZxY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G5nHXIQ7hit/K0ONg17LC6C6uypKQ/Gy6/ev9vOEfzgNpcAZFletpCG6BgZNcg85wKM49MjZQOEqbYrPsq48bFGynsML46GhU6IsP5tXxtED+nVm++tc1DjPq57jHPwmeEUFAHBk2KNxazis+bXfi53bciO6E+pUU+fcvW9mk/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=KExnirD7; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44SHEAmU018871;
	Tue, 28 May 2024 20:25:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=hv2zHESF7jBZNBd/f2RV34Igz
	n5aP+jhDOHRXS0Nnxc=; b=KExnirD787xCddPfmKPBAhH4WJ/mSLnw69Mt9g801
	suiMb/uPoJqBwvPCggyJCWt1g2am4yKBY1cAq7nZKXYyOlde9CzjmmV92Aa309pM
	MLyP+fwLifGQ9oNyKUX3JAQzHkJCaTpnFtghCvY31+EMYk9yRWC9W1FVRFXyvdPU
	F/9OkBLO6N6YlrycSF/B7aF5e2Ri2XRmEXu1p3kHrRgGEdIioRWuLBtNk1uNbnDq
	vsP2d6umGqtl8OL4Wwmc+h50sbMi0sOw6i2ZBpiSAaok6vI5n3efMDL0qB8qow+k
	x9LUwD66wPeALJ6Dk+HhB5v2mN9QKbW0MEH6QJtdFeLeg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3ydhcj2yap-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 May 2024 20:25:45 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 28 May 2024 20:25:44 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 28 May 2024 20:25:44 -0700
Received: from maili.marvell.com (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 7E20A3F70A9;
	Tue, 28 May 2024 20:25:42 -0700 (PDT)
Date: Wed, 29 May 2024 08:55:41 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <admiyo@os.amperecomputing.com>
CC: Robert Moore <robert.moore@intel.com>,
        "Rafael J. Wysocki"
	<rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] mctp pcc: Allow PCC Data Type in MCTP resource.
Message-ID: <20240529032541.GA2452291@maili.marvell.com>
References: <20240513173546.679061-1-admiyo@os.amperecomputing.com>
 <20240528191823.17775-1-admiyo@os.amperecomputing.com>
 <20240528191823.17775-3-admiyo@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240528191823.17775-3-admiyo@os.amperecomputing.com>
X-Proofpoint-GUID: dtTGU9cth_aXobRhjyPViY88njLs1msf
X-Proofpoint-ORIG-GUID: dtTGU9cth_aXobRhjyPViY88njLs1msf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-28_14,2024-05-28_01,2024-05-17_01

On 2024-05-29 at 00:48:22, admiyo@os.amperecomputing.com (admiyo@os.amperecomputing.com) wrote:
> From: Adam Young <admiyo@amperecomputing.com>
> --- a/drivers/acpi/acpica/rsaddr.c
> +++ b/drivers/acpi/acpica/rsaddr.c
> @@ -282,7 +282,7 @@ acpi_rs_get_address_common(struct acpi_resource *resource,
>
>  	/* Validate the Resource Type */
>
> -	if ((address.resource_type > 2) && (address.resource_type < 0xC0)) {
> +	if ((address.resource_type > 2) && (address.resource_type < 0xC0) && (address.resource_type != 10)) {
use macros or enums instead of hard coded numbers. That will improve code readability.

>  		return (FALSE);
>  	}
>
> --
> 2.34.1
>

