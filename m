Return-Path: <netdev+bounces-38669-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A0417BBFFC
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 22:06:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEDE1280F0E
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 20:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BABB041A8E;
	Fri,  6 Oct 2023 20:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eXCOyQZ0"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD18B3B28E
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 20:06:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B09CA;
	Fri,  6 Oct 2023 13:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=CcUhLWm6Uitg1RPnfOWl75RnCJGsrCoiVJ2CURtoDI4=; b=eXCOyQZ0Rru3UbvhtaghjcnmMt
	fFgKul/RuM3GvX8rjYcZiPvsnOwVv5k7EAhycrqnQEox2XMJzmhylmZmqaExuwsTa6VYKXpn4EfbM
	VChQIIXMP634743XyJg86/Ctx5uZSwDSexWOS1jJhqS3JjFwmxVgbvSeYG7U0BYFoeNtFTP2ounMO
	7ixHIFxD0tVzbUw9behh9HO/2i0lVkAqeYEVx6gMDvbXEGlcWuLYai/kr2FRC8tP+K3GjhgkVQAuQ
	En9YQFy+7rVwUYqlpfCtxlSa1BJu72kxzYhIVClbyOAcgePb1b2YW2k+z+t5tiPr7bTKjMcLsz/nW
	xbvf6qNA==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1qor5C-006QO2-15;
	Fri, 06 Oct 2023 20:05:58 +0000
Message-ID: <1c6bdfbf-54c1-4251-916e-9a703a9f644c@infradead.org>
Date: Fri, 6 Oct 2023 13:05:57 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/smc: Fix dependency of SMC on ISM
Content-Language: en-US
To: Gerd Bayer <gbayer@linux.ibm.com>, wenjia@linux.ibm.com
Cc: linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
 netdev@vger.kernel.org, raspl@linux.ibm.com, sfr@canb.auug.org.au,
 alibuda@linux.alibaba.com, wintera@linux.ibm.com, guwen@linux.alibaba.com,
 tonylu@linux.alibaba.com, jaka@linux.ibm.com
References: <d9a2d47d-c8bd-cf17-83e0-d9b82561a594@linux.ibm.com>
 <20231006125847.1517840-1-gbayer@linux.ibm.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20231006125847.1517840-1-gbayer@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

On 10/6/23 05:58, Gerd Bayer wrote:
> When the SMC protocol is built into the kernel proper while ISM is
> configured to be built as module, linking the kernel fails due to
> unresolved dependencies out of net/smc/smc_ism.o to
> ism_get_smcd_ops, ism_register_client, and ism_unregister_client
> as reported via the linux-next test automation (see link).
> This however is a bug introduced a while ago.
> 
> Correct the dependency list in ISM's and SMC's Kconfig to reflect the
> dependencies that are actually inverted. With this you cannot build a
> kernel with CONFIG_SMC=y and CONFIG_ISM=m. Either ISM needs to be 'y',
> too - or a 'n'. That way, SMC can still be configured on non-s390
> architectures that do not have (nor need) an ISM driver.
> 
> Fixes: 89e7d2ba61b7 ("net/ism: Add new API for client registration")
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Closes: https://lore.kernel.org/linux-next/d53b5b50-d894-4df8-8969-fd39e63440ae@infradead.org/
> Co-developed-by: Wenjia Zhang <wenjia@linux.ibm.com>
> Signed-off-by: Wenjia Zhang <wenjia@linux.ibm.com>
> Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>

Works for me. Thanks.

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org> # build-tested


> ---
>  drivers/s390/net/Kconfig | 2 +-
>  net/smc/Kconfig          | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/s390/net/Kconfig b/drivers/s390/net/Kconfig
> index 74760c1a163b..4902d45e929c 100644
> --- a/drivers/s390/net/Kconfig
> +++ b/drivers/s390/net/Kconfig
> @@ -102,7 +102,7 @@ config CCWGROUP
>  
>  config ISM
>  	tristate "Support for ISM vPCI Adapter"
> -	depends on PCI && SMC
> +	depends on PCI
>  	default n
>  	help
>  	  Select this option if you want to use the Internal Shared Memory
> diff --git a/net/smc/Kconfig b/net/smc/Kconfig
> index 1ab3c5a2c5ad..746be3996768 100644
> --- a/net/smc/Kconfig
> +++ b/net/smc/Kconfig
> @@ -2,6 +2,7 @@
>  config SMC
>  	tristate "SMC socket protocol family"
>  	depends on INET && INFINIBAND
> +	depends on m || ISM != m
>  	help
>  	  SMC-R provides a "sockets over RDMA" solution making use of
>  	  RDMA over Converged Ethernet (RoCE) technology to upgrade

-- 
~Randy

