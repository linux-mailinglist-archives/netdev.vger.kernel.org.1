Return-Path: <netdev+bounces-198897-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 899FAADE3E4
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 08:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB84B189CE17
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 06:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD19D207A32;
	Wed, 18 Jun 2025 06:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="LyRkDIjO"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84B8205E3E;
	Wed, 18 Jun 2025 06:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750228986; cv=none; b=JpIhVB6SriT+COY/L/fTR1nBlEPhLA1nLVzbH6TRCGIG8Qhm9zPpccO4LLyu45G7m6ECYnAR9oE/XujlfWD8WI2yFmCC/XBQnAVr8Be+/xxxK6sL4OfWkxrSAA5x2YByASI0KzVnMhil/n8D6yqvADPZ5gBz+5Laezvz7JroqXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750228986; c=relaxed/simple;
	bh=TJUZCm6ddsBdak6VruOCcHc1UW0VdnrNlHVFekdpcOA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=joWDMh+vwnnQbQpLbQSK0xFQUQSMT5fc+jVJmPF06tdd5UQ7GDgg1uT8BXhd2Et8VygUqXlLPK6a8YzStMuLMmRTvrYuV8kgoIsM37/NqYFEPXUHFu5JuDWDmzWcI4CHmyKzf8h8fMEpP/z3GFNwTH6HAkS+IUau+u5r0eiwOWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=LyRkDIjO; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55HNXMQg023310;
	Tue, 17 Jun 2025 23:42:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=TJUZCm6ddsBdak6VruOCcHc1U
	W0VdnrNlHVFekdpcOA=; b=LyRkDIjOd5tX//Yc3kweBYU6sM3/7DQohOPvITVx2
	G4AV415wnHRMdAIztoWAdxLAg2RUiRBFZC0b+zGGjsFcWRHNg1x5R9sAjnTDh9en
	3a74ICYq+OuEw6qsKaPDnftML0RaXPbn53HLUrep2OdN1mpJl/ro7RaUZJieedTS
	IqOVaxRGeukP9+mH4RlprfUzamDC8/u7UtI7vCl4Mw/AJId1hM4Cy2PedjsAiByn
	Wj8dwXmIo2CdCehIadhxmPDFDUP56OfSud6xGrVadWhePbf8vUefrvVRBetR0xXB
	uxfIIWDDP4rCHZUtv+6Y0CCYIidATUjJYGJe23Sm+IjPA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 47bj4xrp9u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Jun 2025 23:42:34 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 17 Jun 2025 23:42:34 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 17 Jun 2025 23:42:33 -0700
Received: from maili.marvell.com (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 81BF83F7043;
	Tue, 17 Jun 2025 23:42:30 -0700 (PDT)
Date: Wed, 18 Jun 2025 12:12:29 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <linyunsheng@huawei.com>
Subject: Re: [RFC]Page pool buffers stuck in App's socket queue
Message-ID: <20250618064229.GA824830@maili.marvell.com>
References: <20250616080530.GA279797@maili.marvell.com>
 <aFHkpVXoAP5JtCzQ@lore-desk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aFHkpVXoAP5JtCzQ@lore-desk>
X-Authority-Analysis: v=2.4 cv=ULrdHDfy c=1 sm=1 tr=0 ts=68525fda cx=c_pps a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=aV8IDli8uWC4K53TSP0A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE4MDA1NiBTYWx0ZWRfX2pZG7u6c+SW3 V1VVPzPSnryHcHcdQsh/MdJwDeOug2sDpy0qqiyaMNQSekolcHVPFFJmavWeNjSbq/0lG2RH+qj Pn3p0t8Byu8ajtNZhJL7isPlDiVrD0Nrn1CYD1k9fOKHLweE+ODaD9Jb5D53Cb9KSx71ih7ngIi
 oKeyjEK1bYJdP2Tq4QKMLJX9u2I9CWyotojYmV0DrlAFpNZxDanyR/vIzFWgXL/KiKWck6FmyvT E05ZhkaV7+FRpV4RY6X1Dds/2A4lWf3GgQF1VziL+5RVD2EtE0HLdv+NR5nk3hmz7u4PDjwcD7w LNtWszW9jIme+SgM16NtlUAv9vMB1teoQJhOU8KFWUIS9VVkFPJo7AWIh4Kr+9ynpQu6gbNq65M
 D8gpQxrGwNLFvTqDEKmsWFWMfmkgnEZ+3+bHJzQuJXfMcE/8VwGqSB43NeHIP4/smAq5XIn/
X-Proofpoint-GUID: 4brJkww31Ll_X-odFeJyVQUzHLo6Ue6W
X-Proofpoint-ORIG-GUID: 4brJkww31Ll_X-odFeJyVQUzHLo6Ue6W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-18_02,2025-06-13_01,2025-03-28_01

On 2025-06-18 at 03:26:53, Lorenzo Bianconi (lorenzo.bianconi@redhat.com) wrote:
>
> Hi,
>
> this problem recall me an issue I had in the past with page_pool
> and TCP traffic destroying the pool (not sure if it is still valid):
>
> https://lore.kernel.org/netdev/ZD2HjZZSOjtsnQaf@lore-desk/
>
> Do you have ongoing TCP flows?
No. it is just ping running. If we kill the ping process, Page pool prints stops.

