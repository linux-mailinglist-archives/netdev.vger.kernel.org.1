Return-Path: <netdev+bounces-217343-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA7AB38663
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 17:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7210420046A
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 15:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2E6275AE7;
	Wed, 27 Aug 2025 15:20:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E852765E9
	for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 15:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756308035; cv=none; b=b7/ppGjHI4zzkx9hN0sreYlVw23ypdcVn4QRs8vS11gkEmipfLugUH17V0B7WsAF4CZC0cBjXUon6Morbwp+p7zFhgoocFG0bmfLJ1Mrpj7ZVCbkiIlKo6/Tjamxb9dmdDgl0+6NJrFi4B6QPrvxJoNqF6fit5db/Ax0GRrI3hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756308035; c=relaxed/simple;
	bh=oGdeTfooEFMLJ+N87LzyYV6hf0p3yN8WOXY979+ZRJk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iSajwDzDbV/Dz8M3MOGztTKLJiFWcz36GKq+esxjMLCsi83qbO/zbPWwrUyEQ03ax1O6Hfrs28xSU3pryJJh3ulhZCQ2NL2iRqAh+WFhCGLJURzdL5PGdPm038aXepGpEncBvSCpIkywYvxa6I8YA/GTl0xRX7Zf1nie1tODU/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.2.202] (p5dc558dd.dip0.t-ipconnect.de [93.197.88.221])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 70BDD60213AC3;
	Wed, 27 Aug 2025 17:19:57 +0200 (CEST)
Message-ID: <a8fa64e8-d6d4-4269-9e57-19eaec822303@molgen.mpg.de>
Date: Wed, 27 Aug 2025 17:19:56 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v2] i40e: Fix potential invalid
 access when MAC list is empty
To: Zhen Ni <zhen.ni@easystack.cn>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org
References: <20250827032348.1374048-1-zhen.ni@easystack.cn>
 <20250827115631.1428742-1-zhen.ni@easystack.cn>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250827115631.1428742-1-zhen.ni@easystack.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Zhen,


Thank you for your patch.

Am 27.08.25 um 13:56 schrieb Zhen Ni:
> list_first_entry() never returns NULL — if the list is empty, it still
> returns a pointer to an invalid object, leading to potential invalid
> memory access when dereferenced.
> 
> Fix this by using list_first_entry_or_null instead of list_first_entry.
> 
> Fixes: e3219ce6a775 ("i40e: Add support for client interface for IWARP driver")
> Signed-off-by: Zhen Ni <zhen.ni@easystack.cn>
> ---
> Changes in v2:
> - Replace the list_empty() pre-check with list_first_entry_or_null()
> ---
>   drivers/net/ethernet/intel/i40e/i40e_client.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_client.c b/drivers/net/ethernet/intel/i40e/i40e_client.c
> index 5f1a405cbbf8..518bc738ea3b 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_client.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_client.c
> @@ -359,8 +359,8 @@ static void i40e_client_add_instance(struct i40e_pf *pf)
>   	if (i40e_client_get_params(vsi, &cdev->lan_info.params))
>   		goto free_cdev;
>   
> -	mac = list_first_entry(&cdev->lan_info.netdev->dev_addrs.list,
> -			       struct netdev_hw_addr, list);
> +	mac = list_first_entry_or_null(&cdev->lan_info.netdev->dev_addrs.list,
> +				       struct netdev_hw_addr, list);
>   	if (mac)
>   		ether_addr_copy(cdev->lan_info.lanmac, mac->addr);
>   	else

That’s even better.

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul

