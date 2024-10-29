Return-Path: <netdev+bounces-139970-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B85A9B4D4B
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 16:14:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A187128465D
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 15:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77774194A70;
	Tue, 29 Oct 2024 15:14:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46329193079;
	Tue, 29 Oct 2024 15:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730214852; cv=none; b=ALxRfYH2NRmXgM6pHwW0JVFPqO4BydWj7GGdjgv+5d7jf7avYYt1anNmjJKRZXZYNvKIBa6ewB99K6xkdWUCXTekI3ds38acMk+h2jW64jMQzGQUhUpnMwglwDsaX+THRn5xfdv/Ee+8md8kEwqjFbC5BzvvskZGCvc8LfuKa/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730214852; c=relaxed/simple;
	bh=WgGpLyjBU3b3E5OLUPA1vuXbqM43Xq5gfghAo706Pg8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IMFUoW9iwv3PNRrqBJ8FuBOt16fE2BOz3BW6QD7IkHJIq5fRVhzEISRBEtu+ImGXZoOUmq/wA7JB9tROv4qBzATpBUmbf4nghmTIbUM/axlu2rW9xvaaS5L8absSbOb05IKFC7t6L9u6fWd0okxs8wrPPnpe5UfcGpLjcyc2jbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XdDJz09xyz6D8Wn;
	Tue, 29 Oct 2024 23:12:51 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 94C211404F5;
	Tue, 29 Oct 2024 23:14:06 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 29 Oct
 2024 16:14:05 +0100
Date: Tue, 29 Oct 2024 15:14:04 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Alejandro Lucero Palau <alucerop@amd.com>
CC: <alejandro.lucero-palau@amd.com>, <linux-cxl@vger.kernel.org>,
	<netdev@vger.kernel.org>, <dan.j.williams@intel.com>,
	<martin.habets@xilinx.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>
Subject: Re: [PATCH v4 02/26] sfc: add cxl support using new CXL API
Message-ID: <20241029151404.000034be@Huawei.com>
In-Reply-To: <b6c1ced9-0038-7819-8e61-7e486da8bd35@amd.com>
References: <20241017165225.21206-1-alejandro.lucero-palau@amd.com>
	<20241017165225.21206-3-alejandro.lucero-palau@amd.com>
	<20241025150314.00007122@Huawei.com>
	<b6c1ced9-0038-7819-8e61-7e486da8bd35@amd.com>
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
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 frapeml500008.china.huawei.com (7.182.85.71)

> >> +
> >> +	cxl = kzalloc(sizeof(*cxl), GFP_KERNEL);  
> > __free magic here.
> > Assuming later changes don't make that a bad idea - I've not
> > read the whole set for a while.  
> 
> 
> Remember we are in netdev territory and those free magic things are not 
> liked ...

I'll keep forgetting that. Feel free to ignore me when I do!



> >> diff --git a/drivers/net/ethernet/sfc/net_driver.h b/drivers/net/ethernet/sfc/net_driver.h
> >> index b85c51cbe7f9..77261de65e63 100644
> >> --- a/drivers/net/ethernet/sfc/net_driver.h
> >> +++ b/drivers/net/ethernet/sfc/net_driver.h
> >> @@ -817,6 +817,8 @@ enum efx_xdp_tx_queues_mode {
> >>   
> >>   struct efx_mae;
> >>   
> >> +struct efx_cxl;
> >> +
> >>   /**
> >>    * struct efx_nic - an Efx NIC
> >>    * @name: Device name (net device name or bus id before net device registered)
> >> @@ -963,6 +965,8 @@ struct efx_mae;
> >>    * @tc: state for TC offload (EF100).
> >>    * @devlink: reference to devlink structure owned by this device
> >>    * @dl_port: devlink port associated with the PF
> >> + * @cxl: details of related cxl objects
> >> + * @efx_cxl_pio_initialised: clx initialization outcome.  
> > cxl  
> 
> 
> Well spotted. I'll fix it.
> 
> 
> > Also, it's in a struct called efx_nic, so is the efx_ prefix
> > useful?  
> 
> 
> I do not like to have the name as the struct ...
You've lost me.  efx_nic->cxl_pio_initialised was that I was suggesting
and not setting how this comment applies.

J

