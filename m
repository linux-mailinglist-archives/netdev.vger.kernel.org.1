Return-Path: <netdev+bounces-248017-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7695BD01E55
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 10:45:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BE2E73067DE8
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 09:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB2B43C064;
	Thu,  8 Jan 2026 09:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="dUTpM8KT"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5543538A286;
	Thu,  8 Jan 2026 09:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767864465; cv=none; b=lmX0L1W9IkyxVKbIbRZD8Aq+gpYD2VtDwzol2GE6DFW90OmuKEORPzAwu6DirMOt8VLgJJCtJtieh9r1YzcdZ+6rssSiM3McfenauwgxY9mQGuqqL2hAUTU9lGG24hfnARpxEU7SN+qQAjspKUT7ALhgFDbmgS1q6tMwSOYq/xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767864465; c=relaxed/simple;
	bh=FUB9y7uQHKoTSC3Ry5HZNWSHTwXAhvoVu+y505bgF6Q=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JtlwcPuQzN/OoFdbr1puR5cv1L477ElgKWiI8dwpXmHKMilxOfF3cxr2Q1fmDHjfiVkz9qXadujteQSZcegrKPhaiNoeqKjtww03s9m5rmiRNR6FFD0GhJEP6IKR6DcSOrK8zXShBD0/wLxT+hGJ3u4m7ojuJt9MEqMA7MRr584=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=dUTpM8KT; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6085hWdT2472736;
	Thu, 8 Jan 2026 01:27:25 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=FUB9y7uQHKoTSC3Ry5HZNWSHT
	wXAhvoVu+y505bgF6Q=; b=dUTpM8KTkm+43mT4hAh6ru//QRtrFZvn+buLbvs8l
	20QwZ7yuEgIXo4T0icg9txi1MqsgqjNO4wqHmvAW9juBWGx40ZsI6FOza8ZUVzJr
	7V6aLlutL04ApkGtI06EYYBdOedydpiBQJI73gkL2KZ7yXiTsYvAwBmnJLUlUqWR
	MiUz0na91bz2K81nDQE4cpwhzlS0cFJ5wr6FJkpRjOUxReU9VO/KhnhEUxwOuUcU
	MO8mCD2GuH1f+Ubdstmn2FtoYi6eJ26BzQh6KcFtG0PpK1TmerFuFxbAnbA4u2AG
	sNvniC1rb3AOXtZc9kMHlkP6PaQDklf4imykAvhTtH5PA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4bgf3fyhse-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Jan 2026 01:27:25 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 8 Jan 2026 01:27:38 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 8 Jan 2026 01:27:38 -0800
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id C490D3F70EC;
	Thu,  8 Jan 2026 01:27:21 -0800 (PST)
Date: Thu, 8 Jan 2026 14:57:20 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: ALOK TIWARI <alok.a.tiwari@oracle.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <andrew+netdev@lunn.ch>, <sgoutham@marvell.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next v2 03/10] octeontx2-pf: switch: Add pf files
 hierarchy
Message-ID: <aV94ePgeAh-F1R4r@rkannoth-OptiPlex-7090>
References: <20260107132408.3904352-1-rkannoth@marvell.com>
 <20260107132408.3904352-4-rkannoth@marvell.com>
 <90d2b744-5895-446d-9d10-9d2cbf341c57@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <90d2b744-5895-446d-9d10-9d2cbf341c57@oracle.com>
X-Authority-Analysis: v=2.4 cv=PLgCOPqC c=1 sm=1 tr=0 ts=695f787d cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=ajlV4JsdAVDJLnkw5vgA:9 a=CjuIK1q_8ugA:10 a=0Xyr-1JMx14A:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA4MDA2MiBTYWx0ZWRfX+RWEoXEHDX/N
 rte+FOYXS2w0fuOvdsJxHYPkXKeK4ELFiLIYVSXVZ8NCzTnlYKXbqSKR2nBIcUlg+gbFxcMWwDP
 g07l2EoZcqIx2NtS9lGtOsK6D7tbipJSYwVZ7v3lMoGNsPmO8O6euaV1k2ocJMXgJsyTnReIrx6
 t2oHwiU/yJet1kZkk1680sErJVkDEPa0B27cmma8go16Fyqc0QljAVsgtTTlz5nYqPK0XLwL7NV
 GqitjOcqoW/C0/+lI5MFcIEfvdC/TbjaVH5Odc90TeKhRd8Y/KV5DJCSdNi1WW71On/OPgXHz0G
 18m9CnW6o67C3XSR+COcYxpTFd383Q+LdLAHU+2q7uyZM0QRSCQbNCgmVlSHzJ8QHE1qMMHBTNB
 1ltSP1hGLKIIWuPROFyyCzM6WppPI1Nk0/PJWMIOnRFd9IytJFNfUhAdgxzrduvgscPAAXvD2Ti
 0aYJm+FULozP5Nwmb1Q==
X-Proofpoint-GUID: Ve6f_SLjjK3Wy7LqC8Q9n3gR9DcyOHlj
X-Proofpoint-ORIG-GUID: Ve6f_SLjjK3Wy7LqC8Q9n3gR9DcyOHlj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-08_02,2026-01-07_03,2025-10-01_01

On 2026-01-08 at 14:43:46, ALOK TIWARI (alok.a.tiwari@oracle.com) wrote:
>
>
> On 1/7/2026 6:54 PM, Ratheesh Kannoth wrote:
> > +int sw_nb_register(void);
> > +int sw_nb_unregister(void);
> > +
> > +#endif // SW_NB_H__
>
> SW_NB_H__ -> SW_NB_H_
ACK

