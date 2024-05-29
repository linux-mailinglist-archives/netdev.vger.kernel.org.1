Return-Path: <netdev+bounces-98861-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C1D8D2B6E
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 05:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1678E286313
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 03:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1700415B111;
	Wed, 29 May 2024 03:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Qw+E4ozk"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB15315AAD6;
	Wed, 29 May 2024 03:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716953228; cv=none; b=R990DuwtFs4dAk2UyMU7SyiaLwrpcZJi1tatDn/T86/IErfUZ1zutCNQc+3wm4UCjx/sCvNAmQ+d1IaJwB6gVpOM19BrkjMsyT+EsheghSbGNZlmKrwOu+z+RKJzl+1BhYtsgk/+qtGJSs9OUxq7fwHCI021JNf/U/j1OITfv9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716953228; c=relaxed/simple;
	bh=kQfP42T/dAHcc/tnWKAwbI8C/k2XqzabQEapm5nIR1k=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zya4njlx5tIK93optBgEdxgB9sSNYVFvbft6SRygjSWRcY9dJt4CQ6QhCyX1JtYMxRAGBCKL/6pbQn/WweE+xVTI5Gg2g+yS6vJ+stI6WNCneFTOiE3rWomMRoZgR8PQI8Nc8DgESxWvoJDNXyJPSd+d0FLH0MJ4PhcwFFtoUME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Qw+E4ozk; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44SHEAsG018876;
	Tue, 28 May 2024 20:26:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=EzsftoVAdJpzN/fNHfBnxc2es
	4lKHibS5VZTZ9TXl7Q=; b=Qw+E4ozk3iZQp/NJISY2sOpya+FqViFAod13fEP5o
	nBZU4sGw0SX5b2emr4UL3QUujDsrlKv73zQzVyoy5Mk/tzGAqnLVzYTtXufB7HEN
	JVFhlVgBIGr6FfPJ2W4r03KdHtv6xS1aj+El6lg6eULxub4ABU1y8gXNWQxhBz6O
	kK/9OgCj9IVs4+J6J7718OGfsvIWGL76IvWU+wKK5dsGjzCuCIEpxFn0SaYK5by8
	HvqnKvqPhlY66dFcjw7FQ9tyS4sFlP3P813Yyjc7HqPyqctE5d+Ki0l0TDivi/3H
	SYCj7GlqApyuX1dGbqbo5Uml+Q3dc5cu/YH2sIY3nsNZw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3ydhcj2ydv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 May 2024 20:26:57 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 28 May 2024 20:26:56 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 28 May 2024 20:26:56 -0700
Received: from maili.marvell.com (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 501683F70A9;
	Tue, 28 May 2024 20:26:54 -0700 (PDT)
Date: Wed, 29 May 2024 08:56:53 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <admiyo@os.amperecomputing.com>
CC: Sudeep Holla <sudeep.holla@arm.com>,
        Jassi Brar
	<jassisinghbrar@gmail.com>,
        Robert Moore <robert.moore@intel.com>,
        "Rafael J.
 Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] mctp pcc: Check before sending MCTP PCC response
 ACK
Message-ID: <20240529032653.GB2452291@maili.marvell.com>
References: <20240513173546.679061-1-admiyo@os.amperecomputing.com>
 <20240528191823.17775-1-admiyo@os.amperecomputing.com>
 <20240528191823.17775-2-admiyo@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240528191823.17775-2-admiyo@os.amperecomputing.com>
X-Proofpoint-GUID: Ov3njcPBFClY2NnUyboYJ7w05xiond0Z
X-Proofpoint-ORIG-GUID: Ov3njcPBFClY2NnUyboYJ7w05xiond0Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-28_14,2024-05-28_01,2024-05-17_01

On 2024-05-29 at 00:48:21, admiyo@os.amperecomputing.com (admiyo@os.amperecomputing.com) wrote:
> From: Adam Young <admiyo@amperecomputing.com>
>
> diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
> index 94885e411085..774727b89693 100644
> --- a/drivers/mailbox/pcc.c
> +++ b/drivers/mailbox/pcc.c
> @@ -280,6 +280,7 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
>  {
>  	struct pcc_chan_info *pchan;
>  	struct mbox_chan *chan = p;
> +	struct pcc_mbox_chan *pmchan;
Reverse xmas tree.

>  	u64 val;
>  	int ret;
>
>

