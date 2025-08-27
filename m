Return-Path: <netdev+bounces-217342-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4231BB3865C
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 17:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE7BC1897D58
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 15:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 289F12773D5;
	Wed, 27 Aug 2025 15:19:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430CA2765F0
	for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 15:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756307961; cv=none; b=jgFZetteEj627k0boMy5AfnRw7UqOqa0jpN3eGAMsUL7M8FkLBe9w1XvKJS55O49VaVgarMMUKWoTh/6OPULT0twVSGpvkO6qYpIPyD8zW0RANxGbQ9HGLsydpbfHTt3miCndD34OhbrKGEe8jTCOzrW4yPa0+H7lauzbUQGmhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756307961; c=relaxed/simple;
	bh=wiHdVIx7NeY03OvTHrfmadbaX0sn2bp8AerV+jK1DSE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CdwBLdUVKP473QLVBqK0jxgGJ0x2G9wa6yjRvFssgU7EQsriC+Sv9E2m2Fe7QEA8dORqUxOMZIDQcK/aPjjM3dvvY7s3HCB8oyXmEepxTeuE6EhKUwsS4eHSPhv8Idux9sFpl4mI//gEubIADkFv3xLamq5PQ0ouZahjAfpQnz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.2.202] (p5dc558dd.dip0.t-ipconnect.de [93.197.88.221])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id B625A60213AC3;
	Wed, 27 Aug 2025 17:18:35 +0200 (CEST)
Message-ID: <6dc3bd8e-66db-4237-86bc-717f7b5c7b2a@molgen.mpg.de>
Date: Wed, 27 Aug 2025 17:18:34 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH] i40e: Fix potential invalid access when
 MAC list is empty
To: Zhen Ni <zhen.ni@easystack.cn>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org
References: <20250827032348.1374048-1-zhen.ni@easystack.cn>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250827032348.1374048-1-zhen.ni@easystack.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Zhen,


Thank you for your patch.

Am 27.08.25 um 05:23 schrieb Zhen Ni:
> list_first_entry() never returns NULL — if the list is empty, it still
> returns a pointer to an invalid object, leading to potential invalid
> memory access when dereferenced.
> 
> Fix this by checking list_empty() before calling list_first_entry(),
> and only copying the MAC address when the list is not empty.
> 
> Fixes: e3219ce6a775 ("i40e: Add support for client interface for IWARP driver")
> Signed-off-by: Zhen Ni <zhen.ni@easystack.cn>
> ---
>   drivers/net/ethernet/intel/i40e/i40e_client.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_client.c b/drivers/net/ethernet/intel/i40e/i40e_client.c
> index 5f1a405cbbf8..0a72157aee0e 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_client.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_client.c
> @@ -359,12 +359,13 @@ static void i40e_client_add_instance(struct i40e_pf *pf)
>   	if (i40e_client_get_params(vsi, &cdev->lan_info.params))
>   		goto free_cdev;
>   
> -	mac = list_first_entry(&cdev->lan_info.netdev->dev_addrs.list,
> -			       struct netdev_hw_addr, list);
> -	if (mac)
> +	if (!list_empty(&cdev->lan_info.netdev->dev_addrs.list)) {
> +		mac = list_first_entry(&cdev->lan_info.netdev->dev_addrs.list,
> +				       struct netdev_hw_addr, list);
>   		ether_addr_copy(cdev->lan_info.lanmac, mac->addr);
> -	else
> +	} else {
>   		dev_err(&pf->pdev->dev, "MAC address list is empty!\n");
> +	}
>   
>   	pf->cinst = cdev;
>   

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul

