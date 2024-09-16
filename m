Return-Path: <netdev+bounces-128540-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 006A097A2DA
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 15:21:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6880BB2460F
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 13:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 384E013D2BC;
	Mon, 16 Sep 2024 13:21:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A831862;
	Mon, 16 Sep 2024 13:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726492902; cv=none; b=q/mz4/zw1UC7+zXebBprkbOUjc9gTPJbnOuXnWZdhjBc1FeAMsLDnF5RSR0cicuQ4CozccCGN8CGkQNrVCCL/x8M51mBx3WPfEjHXoU2WG4s3PN2DKaWMeB+v0qX5jShbFt3aNhH+sznfMXhGU29AqObaFmJQDW9s4L3YU8EL5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726492902; c=relaxed/simple;
	bh=vbZ9iuQoqweKwCB9WJ/H1vDBsNFI3sMZ8JPCwVsEbKQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H30ee94VbkA5YJqO3vQO+vuJjTvQEj2D3UccbEvzm4wQ8vdJjEsB47dmLeKWaEs0+xsntBLRhFRdKLqn1BD4upHFjPwdpj3kJsEC+Ww+WkrZTS7uoIHf+HWyqeeKtJdHI9udVoAKYk3U3I4ssTHCf1/qcKMs8qInjOagb4VDz/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4X6ltN2958z67ww1;
	Mon, 16 Sep 2024 21:21:32 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 714851400F4;
	Mon, 16 Sep 2024 21:21:36 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 16 Sep
 2024 15:21:35 +0200
Date: Mon, 16 Sep 2024 14:21:34 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Alejandro Lucero Palau <alucerop@amd.com>
CC: <alejandro.lucero-palau@amd.com>, <linux-cxl@vger.kernel.org>,
	<netdev@vger.kernel.org>, <dan.j.williams@intel.com>,
	<martin.habets@xilinx.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>
Subject: Re: [PATCH v3 06/20] cxl: add functions for resource
 request/release by a driver
Message-ID: <20240916142134.00002f11@Huawei.com>
In-Reply-To: <9c01c578-ea9d-bca6-2544-addd0225b003@amd.com>
References: <20240907081836.5801-1-alejandro.lucero-palau@amd.com>
	<20240907081836.5801-7-alejandro.lucero-palau@amd.com>
	<20240913183520.000002be@Huawei.com>
	<9c01c578-ea9d-bca6-2544-addd0225b003@amd.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 frapeml500008.china.huawei.com (7.182.85.71)


> 
> >> +	default:
> >> +		dev_err(cxlds->dev, "unknown resource type (%u)\n", type);  
> > No unknown. We know exactly what it is (DPA) but we don't have it.
> > Unexpected maybe?  
> 
> 
> Is this not the same case that you brought in previously? Should I keep 
> the default?

Just change the message to "unsupported resource type..."


