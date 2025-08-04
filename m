Return-Path: <netdev+bounces-211611-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61AA3B1A616
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 17:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6808B188C270
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 15:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 172212609FD;
	Mon,  4 Aug 2025 15:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="APiwv87u"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43890221F11
	for <netdev@vger.kernel.org>; Mon,  4 Aug 2025 15:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754321584; cv=none; b=JkY+jzKkamRVfALQRUfTem7meN2Dx1n2bSScFsLxM+c4hQ8stCLVJ89MnnsL9LnQbEBPUUCBRUPlNlRh+cTvfIo20ynk9urT5QBfH2OI5qXCCEDEE9q+vIM8Wmy0GfRXtdyDcC7bpszHUF+KU9mA0W7diw/TfI7buo9b+u5H3rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754321584; c=relaxed/simple;
	bh=QDeHFxryAw+kOvwGclbqMi3F2Oo2l3BaoPtG5AGVJYM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cqNurFmtk+b+Z/ct1re4PNcgWySJsEX2kIm2v6bbntF1WAdm+4erUw+68qIUqlaCLua0SJb62oXgA6HE91a1DGQM/Kk9Uwk8EqLh/Gj4UhE42fv27oYrSw8Lt0eNidZKk2jo2UW7JWP4/nrN6VJeTpuIqupG3/hUqvGnHosZI2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=APiwv87u; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754321582;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HQP8afUfq4m9UVe65VetJLFF+40HVliKo1U+2ATcqOk=;
	b=APiwv87uxXUZt+2tZ3oztTVBdd5kx8NMapXLDX+XImyQjblNXrd072hNEqjrK9GRwOVB5S
	tQuCxNzW1L/du2oDy2whlrC/RQpdp/ODqILZeR+IFoIcJ9T0VYETACaPufvDYG7yx72MBP
	10YM9i5m7UrxWjyI3BPi1NuJPbL2ViI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-217-W8sblUz4MUaTXOzaPpFNjw-1; Mon,
 04 Aug 2025 11:32:59 -0400
X-MC-Unique: W8sblUz4MUaTXOzaPpFNjw-1
X-Mimecast-MFC-AGG-ID: W8sblUz4MUaTXOzaPpFNjw_1754321577
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ADB7F1956094;
	Mon,  4 Aug 2025 15:32:57 +0000 (UTC)
Received: from [10.44.33.21] (unknown [10.44.33.21])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 662F51956094;
	Mon,  4 Aug 2025 15:32:55 +0000 (UTC)
Message-ID: <a5c159e6-75d0-433d-92b4-f5be3fc0c1c2@redhat.com>
Date: Mon, 4 Aug 2025 17:32:54 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dpll: zl3073x: ZL3073X_I2C and ZL3073X_SPI should depend
 on NET
To: Geert Uytterhoeven <geert+renesas@glider.be>,
 Prathosh Satish <Prathosh.Satish@microchip.com>,
 Jakub Kicinski <kuba@kernel.org>, Arnd Bergmann <arnd@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel test robot <lkp@intel.com>
References: <20250802155302.3673457-1-geert+renesas@glider.be>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <20250802155302.3673457-1-geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 02. 08. 25 5:53 odp., Geert Uytterhoeven wrote:
> When making ZL3073X invisible, it was overlooked that ZL3073X depends on
> NET, while ZL3073X_I2C and ZL3073X_SPI do not, causing:
> 
>      WARNING: unmet direct dependencies detected for ZL3073X when selected by ZL3073X_I2C
>      WARNING: unmet direct dependencies detected for ZL3073X when selected by ZL3073X_SPI
>      WARNING: unmet direct dependencies detected for ZL3073X
> 	Depends on [n]: NET [=n]
> 	Selected by [y]:
> 	- ZL3073X_I2C [=y] && I2C [=y]
> 	Selected by [y]:
> 	- ZL3073X_SPI [=y] && SPI [=y]
> 
> Fix this by adding the missing dependencies to ZL3073X_I2C and
> ZL3073X_SPI.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202508022110.nTqZ5Ylu-lkp@intel.com/
> Closes: https://lore.kernel.org/oe-kbuild-all/202508022351.NHIxPF8j-lkp@intel.com/
> Fixes: a4f0866e3dbbf3fe ("dpll: Make ZL3073X invisible")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>   drivers/dpll/zl3073x/Kconfig | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dpll/zl3073x/Kconfig b/drivers/dpll/zl3073x/Kconfig
> index 9915f7423dea370c..5bbca14005813134 100644
> --- a/drivers/dpll/zl3073x/Kconfig
> +++ b/drivers/dpll/zl3073x/Kconfig
> @@ -16,7 +16,7 @@ config ZL3073X
>   
>   config ZL3073X_I2C
>   	tristate "I2C bus implementation for Microchip Azurite devices"
> -	depends on I2C
> +	depends on I2C && NET
>   	select REGMAP_I2C
>   	select ZL3073X
>   	help
> @@ -28,7 +28,7 @@ config ZL3073X_I2C
>   
>   config ZL3073X_SPI
>   	tristate "SPI bus implementation for Microchip Azurite devices"
> -	depends on SPI
> +	depends on NET && SPI
>   	select REGMAP_SPI
>   	select ZL3073X
>   	help

Acked-by: Ivan Vecera <ivecera@redhat.com>


