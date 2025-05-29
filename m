Return-Path: <netdev+bounces-194155-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B39A0AC796F
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 09:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DECAA9E3A7E
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 07:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D43C72571BC;
	Thu, 29 May 2025 07:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="hEFQnQD1"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351E92571A9
	for <netdev@vger.kernel.org>; Thu, 29 May 2025 07:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748502482; cv=none; b=AcS6a9PNnrkVBoV2di7QhlelS2lO1pSKXh6A1S3vtWcgYiJV6rc0DfsAQ1NX6rSlrnnb56iMRniwxSBAFFsMwdIWSd5bu7NtvXl500sIj9wOplcYsidBeUV6wh7KMn3CTg3ONbvN/GbhWtwz2aVEnxCfAD4oP11Vfjwwwd5NYIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748502482; c=relaxed/simple;
	bh=eSleppJd8hVVc/078i5WPbndk8zV7+TdSG/97LEuU5A=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c88XFSNrsG0wmHu4gVfIWZNyoBykS7zxxUnTznRYKZCjVNLHGvCSAi+VrUJBujsPOKwOeuLhiVFRR2lmcXWcHUTST+Iv53Ub7EWMkEgxTjorMQ2YoXDNQ5rg/iVL+xfcMw4XjLvx5fCOrWCpieFHhFZYptOFx/TNTgPMqfMSXRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=hEFQnQD1; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54SNUThZ032421;
	Thu, 29 May 2025 00:07:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=YqdsiddxAOApZAExxA+CvW188
	oQ25yEF2lyLq9CvITI=; b=hEFQnQD1RuW9zNRYia7whaDR012q+jsRmhHAtxUqu
	nLevYVFQHN9gORLRBTY9eOoKWVhqlBy1UlMwoqFw+uU5ZfQiMoAQJnTd5trfQvBP
	on1LngNgAhdNx0mqTN6RsDPhD/qWWrsiGYlHqaTbJ9Zg6T/fQSmejFe8MKD9Ro16
	3hToIJsT/QzTCAx1QuMwwAz2uncFOF2QfYcynQ3NMGD1v+UJal9bfDjE506QeDtr
	jYxTN8g71q25rqt43Wtbhjf9d3GbPIgYbwEaX/SR2qMkThIfATKHD44unU/byS36
	U02uuhArQApl/+D/E3PHEhPzp+l79MKX0XQCU+4v7/CSA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 46xc7h8q8g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 May 2025 00:07:13 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 29 May 2025 00:07:12 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 29 May 2025 00:07:12 -0700
Received: from e6bae70a73d4 (HY-LT91368.marvell.com [10.29.24.116])
	by maili.marvell.com (Postfix) with SMTP id 97C523F70AD;
	Thu, 29 May 2025 00:07:07 -0700 (PDT)
Date: Thu, 29 May 2025 07:07:06 +0000
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: Simon Horman <horms@kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <saikrishnag@marvell.com>,
        <gakula@marvell.com>, <hkelam@marvell.com>, <sgoutham@marvell.com>,
        <lcherian@marvell.com>, <bbhushan2@marvell.com>, <jerinj@marvell.com>,
        <netdev@vger.kernel.org>
Subject: Re: [net PATCH] octeontx2: Annotate mmio regions as __iomem
Message-ID: <aDgHmiE1bdvc4IgI@e6bae70a73d4>
References: <1748409327-25648-1-git-send-email-sbhatta@marvell.com>
 <20250528145747.GA1484967@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250528145747.GA1484967@horms.kernel.org>
X-Proofpoint-GUID: EQuXhITmSrgN0MKmqdfCQ9tbU5qQthbi
X-Proofpoint-ORIG-GUID: EQuXhITmSrgN0MKmqdfCQ9tbU5qQthbi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI5MDA2OCBTYWx0ZWRfX+IxMoc/diGJj jYzecfjADQTp/AbfAlWbYwjs14aPD2hXLEg7NaEAQvKX35Eu4d4BGq6k02rbQ7r1LkAeXvNO8jj M+/C5J6RS3A92uwlkW53Y8+QIgLVYp9bHXLGMVStXZHNerLm/YpK5Snma2hEl0WBdUaiFraUJlx
 W4BmNFKUXX0aA0E3sE2VG4zp2QaZFjEnDb/wCD8QpB70XkK1mLTB1uVmQComAHMJ+TM9ICYlBto BwJzfGiDJrYPLs0B7pDt9vJc0nHApxIeMHfIccwVixiu8SR97G+ErPvc0QQAJhUN1sko3db3FWa v8Obwgg4IGdw9UYFAR8zQRV+9R0LqUW53GoLtYY0u8vho69LgeHtWFEQvoQ6/9+IRVqLqVUEklU
 xsJfZDP3g4vNEUfsQ1RkMz7V96ltFe2z68318LRzlZJodmlFiTiQz/U9U3iikiMLUOl0m2Ya
X-Authority-Analysis: v=2.4 cv=QcBmvtbv c=1 sm=1 tr=0 ts=683807c7 cx=c_pps a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8 a=QkefSvheVK54M5M2m6AA:9 a=CjuIK1q_8ugA:10
 a=zZCYzV9kfG8A:10 a=OBjm3rFKGHvpk9ecZwUJ:22 a=lhd_8Stf4_Oa5sg58ivl:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-29_03,2025-05-27_01,2025-03-28_01

Hi Simon,

On 2025-05-28 at 14:57:47, Simon Horman (horms@kernel.org) wrote:
> On Wed, May 28, 2025 at 10:45:27AM +0530, Subbaraya Sundeep wrote:
> > This patch removes unnecessary typecasts by marking the
> > mbox_regions array as __iomem since it is used to store
> > pointers to memory-mapped I/O (MMIO) regions. Also simplified
> > the call to readq() in PF driver by removing redundant type casts.
> > 
> > Fixes: 98c561116360 ("octeontx2-af: cn10k: Add mbox support for CN10K platform")
> > Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
> 
> Thanks Subbaraya,
> 
> As per my comment on [1], I wonder if this is more of a clean-up
> for net-next (once it re-opens, no Fixes tag) than a fix.
> 
> [1] Re: [net v2 PATCH] octeontx2-pf: Avoid typecasts by simplifying otx2_atomic64_add macro 
>     https://lore.kernel.org/netdev/20250528125501.GC365796@horms.kernel.org/T/#t
>
Sure.

Thanks,
Sundeep

> ...

