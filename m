Return-Path: <netdev+bounces-227463-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C3E8BB010F
	for <lists+netdev@lfdr.de>; Wed, 01 Oct 2025 12:54:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CED072A1AA2
	for <lists+netdev@lfdr.de>; Wed,  1 Oct 2025 10:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E8D82C08C5;
	Wed,  1 Oct 2025 10:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="fZz5QBbl"
X-Original-To: netdev@vger.kernel.org
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779D827D771;
	Wed,  1 Oct 2025 10:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759316076; cv=none; b=mFM6TI/IT7hA1oVkkm0PoqWAyAw/vDxCckBVF8DjL/RcWblTAvqG3DQ2TFlV+Aupg+ObQ2XX4wrA5pKEmnoxgWAzfL+jsJ1SGpnixubb8RooJVa6ON462m8JOOpsvVQsz0LwhEsF3w9+Q3zge9cyiK6QmQ4ROO9ATSe6YLvmBH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759316076; c=relaxed/simple;
	bh=fCcJjN3ZPSE7Fa2VbJuzxB9W3FCX1nVxcbuvxXsy43Q=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mbyYcCkYA3+/XmXWiGuXqcz2OccORiufV8ZK2Muce3sQK9cWkDM3xS1o9OpPn+RH5+m+YH/ULhMjcC2fylLg6Vo4IZwfJX2s5Lsq7q7SfguobZVDRrSfExBSC0yv+BHs/Oyc5nsDWfNGsSQEgX9b1WzO/H+kXrZJzKzUWEwahP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=fZz5QBbl; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 591AsHEv3111395;
	Wed, 1 Oct 2025 05:54:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1759316057;
	bh=UYdxBV+94zA32DysCLFBKsalzqZRzMhjxb0wxmqa7s4=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=fZz5QBblX+c4TKgL0/CJxr6HPdTftxvkONJ2Fqj0ceZTEvUYMzt4SwyI5djQdfTCn
	 KuSu3Td7ukii5E4y7T+g8FoyW37HJIt562gD4oJ1OlmfYtZBlfFcYJN+5WkTQILaKz
	 Vj6JU2YLFimotW3XjP8xeRUbCjwsFunu7EB4gEIM=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 591AsGCd2811532
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 1 Oct 2025 05:54:16 -0500
Received: from DLEE200.ent.ti.com (157.170.170.75) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 1
 Oct 2025 05:54:16 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 1 Oct 2025 05:54:16 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 591AsGAW205422;
	Wed, 1 Oct 2025 05:54:16 -0500
Date: Wed, 1 Oct 2025 05:54:16 -0500
From: Nishanth Menon <nm@ti.com>
To: Jacob Keller <jacob.e.keller@intel.com>
CC: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
        Paolo
 Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet
	<edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn
	<andrew+netdev@lunn.ch>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Simon
 Horman <horms@kernel.org>,
        Siddharth Vadapalli <s-vadapalli@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>
Subject: Re: [PATCH V2 3/3] net: ethernet: ti: Remove IS_ERR_OR_NULL checks
 for knav_dma_open_channel
Message-ID: <20251001105416.frbebh5ws2rnxquu@quality>
References: <20250930121609.158419-1-nm@ti.com>
 <20250930121609.158419-4-nm@ti.com>
 <0cae855b-e842-47a1-9aaf-b2a297ec32d6@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0cae855b-e842-47a1-9aaf-b2a297ec32d6@intel.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 16:59-20250930, Jacob Keller wrote:
> 
> 
> On 9/30/2025 5:16 AM, Nishanth Menon wrote:
> > knav_dma_open_channel now only returns NULL on failure instead of error
> > pointers. Replace IS_ERR_OR_NULL checks with simple NULL checks.
> > 
> > Suggested-by: Simon Horman <horms@kernel.org>
> > Signed-off-by: Nishanth Menon <nm@ti.com>
> > ---
> > Changes in V2:
> > * renewed version
> > * Dropped the fixes since code refactoring was involved.
> > 
> 
> Whats the justification for splitting this apart from patch 1 of 3?
> 
> It seems like we ought to just do all this in a single patch. I don't
> see the value in splitting this apart into 3 patches, unless someone
> else on the list thinks it is valuable.

The only reason I have done that is to ensure the patches are
bisectable. at patch #1, we are still returning -EINVAL, the driver
should still function when we switch the return over to NULL.

[...]

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
https://ti.com/opensource

