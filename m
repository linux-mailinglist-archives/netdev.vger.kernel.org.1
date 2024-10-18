Return-Path: <netdev+bounces-137074-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C0D29A4455
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 19:09:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEB0D2813AA
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 17:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A395E2036F7;
	Fri, 18 Oct 2024 17:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="B31IuP8h"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64061F428A;
	Fri, 18 Oct 2024 17:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729271354; cv=none; b=dDkASfNITNOuKlv0W/szVkmKKGjwkfGn6YlWaDvN3pWhmkFA5zLe9D9CMPTRx6h+3E1NBKxAWlRszqFsRmTLG1XnaKHYP32u4kMAuUe1wXrVUhKZKpGYZDLGIx8vvgcQiGHPoup2vfGDiIsE737CbQJ9Qzdvxas0J3h2UHAsAAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729271354; c=relaxed/simple;
	bh=dcWpLFwW77yaOp3NoUz/Ox3vjJRBWe2DK58dQ/3bh20=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eHowE46GduhQUHq9wFAB2INw2GOnctCepcy6NNBgfgNq6CQOm9HOfjIQAtvV3jQhgzdVFang5Z4QGKFmLGZMebK4mbxkL7OCjVZ1E15Sbk00qAjqtdcPZZfN4eSLiQFmjwzwv/2OrBRLvUC02YKemyDiv5Ojt/Fdfa48AV/inBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=B31IuP8h; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49IA8crq032610;
	Fri, 18 Oct 2024 10:08:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=Qs2DU5FTRsEj78vMHWdipZdMt
	nEt5a/Zc/dGpilUIPY=; b=B31IuP8hRCwso/KsF7cIVDY2tFVdgfCAyrD22ubbD
	8puSwwLoPftMvZOESwRT3PtLQrj/TucfsgtY286l99SWrChcMuAsyyLtnrFwo9Ld
	/3LIChP8oQOSgiydrSC6Ox9Jg/yZS0am5dgioREZxhtSQ7WlZq4mRPBxo+mUJc/X
	BLgY1BnF2XXMh4gJ43CY/utCw1qfeq/EanOG0MYG//4RyaYJWkoQraai+j6EksSs
	yPLjAhx+Z1nOgKbnswA5xfZHeM8Oa1vEJHi13p08TBuxZUxk3a3ER1+2CWWFVWgN
	Xfj7gMaFiLhyr8/eBO8a0bshJmoOuVdgfftMKnAcPk7xA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 42bnnbgwdq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Oct 2024 10:08:45 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 18 Oct 2024 10:08:44 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 18 Oct 2024 10:08:44 -0700
Received: from test-OptiPlex-Tower-Plus-7010 (unknown [10.29.37.157])
	by maili.marvell.com (Postfix) with SMTP id DA2543F7068;
	Fri, 18 Oct 2024 10:08:41 -0700 (PDT)
Date: Fri, 18 Oct 2024 22:38:40 +0530
From: Hariprasad Kelam <hkelam@marvell.com>
To: Lorenz Brun <lorenz@brun.one>
CC: Igor Russkikh <irusskikh@marvell.com>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] net: atlantic: support reading SFP module info
Message-ID: <ZxKWGBAMsVqsnS87@test-OptiPlex-Tower-Plus-7010>
References: <20241018154741.2565618-1-lorenz@brun.one>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241018154741.2565618-1-lorenz@brun.one>
X-Proofpoint-GUID: iipTzzbPWUbQCWHeIdXoA0CxWWaGK75U
X-Proofpoint-ORIG-GUID: iipTzzbPWUbQCWHeIdXoA0CxWWaGK75U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

On 2024-10-18 at 21:17:38, Lorenz Brun (lorenz@brun.one) wrote:
> Add support for reading SFP module info and digital diagnostic
> monitoring data if supported by the module. The only Aquantia
> controller without an integrated PHY is the AQC100 which belongs to
> the B0 revision, that's why it's only implemented there.
> 
> The register information was extracted from a diagnostic tool made
> publicly available by Dell, but all code was written from scratch by me.
> 
> This has been tested to work with a variety of both optical and direct
> attach modules I had lying around and seems to work fine with all of
> them, including the diagnostics if supported by an optical module.
> All tests have been done with an AQC100 on an TL-NT521F card on firmware
> version 3.1.121 (current at the time of this patch).
> 
> Signed-off-by: Lorenz Brun <lorenz@brun.one>
> ---
    Since this is not a fix, please submit this patch to "net-next"
    tree by changing the subject prefix. 



