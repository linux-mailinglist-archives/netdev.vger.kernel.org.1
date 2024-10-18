Return-Path: <netdev+bounces-137061-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F337C9A43D2
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 18:26:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF8EF28397C
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 16:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 915C6202F71;
	Fri, 18 Oct 2024 16:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="I4ohWXCs"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63AC2022F5
	for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 16:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729268795; cv=none; b=OvQ6gQhaUs4KVT9YR9WTnOWXVTkg9s+kzt8xc+2sK3YBFVOc3+VWJ0ieAxU6cDvDJvmj0lpqGRnmU8hXjloicE0nOW+XVfq+xTJUbIG7o+oO4gE4ySdVJzT/p70s6Q8rjFIYN/SzgEUt2qk+wY4+vWkdkK9wBh0uI5W9s2xC4UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729268795; c=relaxed/simple;
	bh=dS6yaL6xz/usLMXdOoZh1NDiGr93N7hjr7UlSsCnKn4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u/B1w6Gt6bV6ktHfRRJZE1G7PwSt1SvXMAI+4JDZYu3o9SwU/QbWIVWNpykcgNbmwkBCsnmXtgCq/5dEzM9OQMuSCZwZKtGeIOQ6cl3MNFF//UtO3bSOQcJNN3OnezDOPWuqIHxWPvfbS9FOv+ur0HpThxJPFVJTB+j7UuKMSAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=I4ohWXCs; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49I9TAXU013017;
	Fri, 18 Oct 2024 09:26:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=0yLvsGtan4odMmzXY1KXVWoCB
	MZEVVD5cqw7V/ISgcI=; b=I4ohWXCsSIjRmtvDQUYrIIhmIBaqxVZJ1X6CBvcTz
	kj1GBfW9RlprXk7SZvTH4/p6bk8ym7r7Yb5sgyX6NEHJgbD7yQVw+uXWftFTMEJ0
	i4rNrww4GttR5EqJQvrS4WmcLSi8kvFUN809u96JRwKGjr3qJN8hUKelxzuxQdHD
	wfpUZ82pRpwLXlHEIU3Z03KNtR7j4A5Fd9aPULhiGAsyyzC2WYX7ak8O9qyPVUV6
	PHxhjqLEN//3I074FatO44ikScXuZn5S2jMXQqik8X13lTwasIvjwH5xOyLmbX1A
	fkoelF5x6mvzWM0+xcVz82rUl1/88MPqD2H+asGdbfj9A==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 42bm18h130-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Oct 2024 09:26:09 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 18 Oct 2024 09:26:09 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 18 Oct 2024 09:26:09 -0700
Received: from test-OptiPlex-Tower-Plus-7010 (unknown [10.29.37.157])
	by maili.marvell.com (Postfix) with SMTP id 2FAF33F7068;
	Fri, 18 Oct 2024 09:26:04 -0700 (PDT)
Date: Fri, 18 Oct 2024 21:56:04 +0530
From: Hariprasad Kelam <hkelam@marvell.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>
CC: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
        Mark Lee
	<Mark-MC.Lee@mediatek.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] net: airoha: Reset BQL stopping the netdevice
Message-ID: <ZxKMHFYr2QJXlxFl@test-OptiPlex-Tower-Plus-7010>
References: <20241017-airoha-en7581-reset-bql-v1-1-08c0c9888de5@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241017-airoha-en7581-reset-bql-v1-1-08c0c9888de5@kernel.org>
X-Proofpoint-GUID: 4-6DMuTv2nkYEwRRsc_Wc3L9qDA2DYaB
X-Proofpoint-ORIG-GUID: 4-6DMuTv2nkYEwRRsc_Wc3L9qDA2DYaB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

On 2024-10-17 at 19:31:41, Lorenzo Bianconi (lorenzo@kernel.org) wrote:
> Run airoha_qdma_cleanup_tx_queue() in ndo_stop callback in order to
> unmap pending skbs. Moreover, reset BQL txq state stopping the netdevice,
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
Reviewed-by: Hariprasad Kelam <hkelam@marvell.com>

