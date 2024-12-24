Return-Path: <netdev+bounces-154204-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E4559FC0FC
	for <lists+netdev@lfdr.de>; Tue, 24 Dec 2024 18:28:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 306B7188374E
	for <lists+netdev@lfdr.de>; Tue, 24 Dec 2024 17:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC18212D64;
	Tue, 24 Dec 2024 17:28:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78423212B2B;
	Tue, 24 Dec 2024 17:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735061284; cv=none; b=MyypYgQSUMwht5pdhkhJa2naTGiNvixwrEB1HD9ZKPTGCWg/HYmsmtpTiIXj5n8irpaDmwxvL0+ERbD+JLqd4SZiWt2skCz7VZDaXL8WVVQ7nxVDkpFTMGvtfK6kNX2BLMtaI3zLl6KCkI39bEoBpxOToOv/ZzVSyso8+aZllvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735061284; c=relaxed/simple;
	bh=dzV8trfPKNr23iwdlyGa4YPMJa6NWOrbls6ABuc45q4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=blQR/OkChRrQgZqhYO9FR1Ouoq9yEd4wPf6cr4QT840bayWF4sZjXjuJ2sU/FgM1BD6os0Euljbm44jePlrlEUWqAPS6TPIF3zw+7S6TauPSG9BKwZugp5q2/BqNadf3W6YuSlVxzebNov0JeKUW4Q731HUI2bI7FnIXVOGIwc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YHhZb1g79z6K95C;
	Wed, 25 Dec 2024 01:24:07 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id A606B140736;
	Wed, 25 Dec 2024 01:28:00 +0800 (CST)
Received: from localhost (10.48.156.150) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 24 Dec
 2024 18:27:59 +0100
Date: Tue, 24 Dec 2024 17:27:57 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <dave.jiang@intel.com>, Alejandro
 Lucero <alucerop@amd.com>
Subject: Re: [PATCH v8 10/27] resource: harden resource_contains
Message-ID: <20241224172757.00003610@huawei.com>
In-Reply-To: <20241216161042.42108-11-alejandro.lucero-palau@amd.com>
References: <20241216161042.42108-1-alejandro.lucero-palau@amd.com>
	<20241216161042.42108-11-alejandro.lucero-palau@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100010.china.huawei.com (7.191.174.197) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 16 Dec 2024 16:10:25 +0000
<alejandro.lucero-palau@amd.com> wrote:

> From: Alejandro Lucero <alucerop@amd.com>
> 
> While resource_contains checks for IORESOURCE_UNSET flag for the
> resources given, if r1 was initialized with 0 size, the function
> returns a false positive. This is so because resource start and
> end fields are unsigned with end initialised to size - 1 by current
> resource macros.
> 
> Make the function to check for the resource size for both resources
> since r2 with size 0 should not be considered as valid for the function
> purpose.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Suggested-by: Alison Schofield <alison.schofield@intel.com>
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Seems sensible.
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  include/linux/ioport.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/linux/ioport.h b/include/linux/ioport.h
> index 5385349f0b8a..7ba31a222536 100644
> --- a/include/linux/ioport.h
> +++ b/include/linux/ioport.h
> @@ -296,6 +296,8 @@ static inline unsigned long resource_ext_type(const struct resource *res)
>  /* True iff r1 completely contains r2 */
>  static inline bool resource_contains(const struct resource *r1, const struct resource *r2)
>  {
> +	if (!resource_size(r1) || !resource_size(r2))
> +		return false;
>  	if (resource_type(r1) != resource_type(r2))
>  		return false;
>  	if (r1->flags & IORESOURCE_UNSET || r2->flags & IORESOURCE_UNSET)


