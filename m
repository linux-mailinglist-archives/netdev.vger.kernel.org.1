Return-Path: <netdev+bounces-142705-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A83F9C00E2
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 10:12:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBC4F1F222A2
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 09:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03CB01DF744;
	Thu,  7 Nov 2024 09:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="LIHD+jdH"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FC219CC36;
	Thu,  7 Nov 2024 09:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730970767; cv=none; b=BkSG3NOcdW9tU8w++uJqoJ+GtKGaQIZXzUkMg3zAHbdSKFuDrtKAG4eZv6FwdVH5bxoRWe+tJLa6U2UguWmTHSc3OgYq7ilVX2REQJHFlVN20/1iwNOaIaKPyTZAAlhleDwi5GFazBn+yRSMW9Dpe3JVWt2b8Yny/eKZM6satug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730970767; c=relaxed/simple;
	bh=/dyb7qFLx2EvxC0lQ1P/4TvXTZIOenT38YkyOrdCuJ0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r37w9o3UIFapxCcyf7vkMk9OI2Gs4iS0InM6p2DrbjgPXqOhuP6SZY4E0ckBmPAtFqIJScEluMxnobhxuGKmsf3IP2jJkAbcu49BhPLuAPy2gBRsaWtQxSVqgI/tvdO+NJsNKmZgtWqHS9AVJ5nlN36KwbwmKyuTXJjKziYySFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=LIHD+jdH; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A76tkQ7007341;
	Thu, 7 Nov 2024 01:12:25 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=Kl7S0JXpKvyVm+9beracpWgeu
	VI9VzfXcK/4zszh2+4=; b=LIHD+jdHJ7WzDv+zPxy+LjVK7szCiLTgBK8OFS9Ud
	dd8ehs4Q3w3iZAvR7jAfhNR2PqWwD+Do6EHoJpAvFguZq6cNhqZYQdT46459++Tb
	11/GOUy9doj4ers98QXhHge9nJ+aRcZ1fFJUcxX43FyOF83AVolmjC9Q4Fi0plgO
	GelFTkPB6o/vvwhaBYt0RKlT3izTx2vM/5Ua7Cn9TfNlAwy3VrDxj9/ySoL0JUva
	OqtXofG1m51qq8sPgYqd6Ai7h/cY0Ggy4syrqhWwhy7giGJJ0oGnEyVyyx98+lAz
	zDgZu8i7AvT6SzmjInETBjonUwV83vfaRBoJUAT95FfzQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 42rrqa87jp-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Nov 2024 01:12:24 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 7 Nov 2024 01:12:22 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 7 Nov 2024 01:12:21 -0800
Received: from test-OptiPlex-Tower-Plus-7010 (unknown [10.29.37.157])
	by maili.marvell.com (Postfix) with SMTP id 3339E3F7050;
	Thu,  7 Nov 2024 01:12:17 -0800 (PST)
Date: Thu, 7 Nov 2024 14:42:12 +0530
From: Hariprasad Kelam <hkelam@marvell.com>
To: Wei Fang <wei.fang@nxp.com>
CC: <claudiu.manoil@nxp.com>, <vladimir.oltean@nxp.com>,
        <xiaoning.wang@nxp.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <imx@lists.linux.dev>
Subject: Re: [PATCH net-next 0/5] Add more feautues for ENETC v4 - round 1
Message-ID: <ZyyEbCKxjkVFXUMB@test-OptiPlex-Tower-Plus-7010>
References: <20241107033817.1654163-1-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241107033817.1654163-1-wei.fang@nxp.com>
X-Proofpoint-ORIG-GUID: LhRfencOvJt1EKve0myO96XLecv8uDpu
X-Proofpoint-GUID: LhRfencOvJt1EKve0myO96XLecv8uDpu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

On 2024-11-07 at 09:08:12, Wei Fang (wei.fang@nxp.com) wrote:
> Compared to ENETC v1 (LS1028A), ENETC v4 (i.MX95) adds more features, and
> some features are configured completely differently from v1. In order to
> more fully support ENETC v4, these features will be added through several
> rounds of patch sets. This round adds these features, such as Tx and Rx
> checksum offload, increase maximum chained Tx BD number and Large send
> offload (LSO).
> 
> Wei Fang (5):
>   net: enetc: add Rx checksum offload for i.MX95 ENETC
>   net: enetc: add Tx checksum offload for i.MX95 ENETC
>   net: enetc: update max chained Tx BD number for i.MX95 ENETC
>   net: enetc: add LSO support for i.MX95 ENETC PF
>   net: enetc: add UDP segmentation offload support
>

Can you refactor the patches in a way that "ndev->hw_features" set 
in corresponding patch.


Setting NETIF_F_HW_CSUM in "net: enetc: add UDP segmentation offload
support" does not look good to me.

Thanks,
Hariprasad k


>  drivers/net/ethernet/freescale/enetc/enetc.c  | 345 ++++++++++++++++--
>  drivers/net/ethernet/freescale/enetc/enetc.h  |  32 +-
>  .../net/ethernet/freescale/enetc/enetc4_hw.h  |  22 ++
>  .../net/ethernet/freescale/enetc/enetc_hw.h   |  31 +-
>  .../freescale/enetc/enetc_pf_common.c         |  16 +-
>  .../net/ethernet/freescale/enetc/enetc_vf.c   |   7 +-
>  6 files changed, 419 insertions(+), 34 deletions(-)
> 
> -- 
> 2.34.1
> 
> 

