Return-Path: <netdev+bounces-186546-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F71AA9F957
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 21:21:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC5301A8615D
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 19:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F75293B6A;
	Mon, 28 Apr 2025 19:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G6Io6Y2u"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C991C5D46;
	Mon, 28 Apr 2025 19:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745868084; cv=none; b=dC6HWgE7ujlW8iyzCTxPPSr3kNRtSoW1TPLnyWy1cRXqf7y+GKCx1EPUyL2h0BDUvTklAv94nO3pCkdnOkXwJI9rXTfwzWyKmp+TWEC2A3c/6gK7ww8t6xoNClTWZcSG6Y1Iv7wKmMGZ4+NrxtmrFQQF3bnKwow1mqdtxnETxnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745868084; c=relaxed/simple;
	bh=UfsTuZg/5y3Yq5r3UE+NGULY2eti12GEg0x0dZNFC/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L8J0b1sIffC5IOAyN7/9pVzNlvsg8TcEXIr4ZP9CtlY5lxGmoDdS6dUgR6mxvifyKvk657nqzpiMlzF4j5Dnx440hwDfv37w76MIJ+7InbEKm03HqJka/iD5Q1adXLug8aDEahhCffxwQDtE/B6pNblabHdNiCuShZTfQy05vqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G6Io6Y2u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F093FC4CEE4;
	Mon, 28 Apr 2025 19:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745868083;
	bh=UfsTuZg/5y3Yq5r3UE+NGULY2eti12GEg0x0dZNFC/0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G6Io6Y2u0m7Y3TuvNccstkaaNZkCmSjgJVzNVsq18v5orkBgS2m89clDeUl93rc5G
	 jT1xbxbfJ+7hvVBr+Dj8DerHVd1y5jQeuYhmAwLUWEtF+C9Ss9B7fMk71MBCzprljl
	 +A7vWhTXkR+nma9RwndhLYIAHPGtrQYAIDYd+Je7chD9mqz5lFk4CMuPm7/eND2mcV
	 ypMzQblquNuB9Wa3J824v/C8UV7YBH4JlQBatFu+L7MKw4JGpdq60FJcaRbouMiQxu
	 ztCVsQ/7RSfI/2PtX2JqTv886A1y978FuLnmbOfFAxsyqumWovhEX5bgoJJT0UXw2i
	 pLL5rx140GKNg==
Date: Mon, 28 Apr 2025 20:21:19 +0100
From: Simon Horman <horms@kernel.org>
To: Shannon Nelson <shannon.nelson@amd.com>
Cc: andrew+netdev@lunn.ch, brett.creeley@amd.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net] pds_core: remove write-after-free of client_id
Message-ID: <20250428192119.GI3339421@horms.kernel.org>
References: <20250425203857.71547-1-shannon.nelson@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250425203857.71547-1-shannon.nelson@amd.com>

On Fri, Apr 25, 2025 at 01:38:57PM -0700, Shannon Nelson wrote:
> A use-after-free error popped up in stress testing:
> 
> [Mon Apr 21 21:21:33 2025] BUG: KFENCE: use-after-free write in pdsc_auxbus_dev_del+0xef/0x160 [pds_core]
> [Mon Apr 21 21:21:33 2025] Use-after-free write at 0x000000007013ecd1 (in kfence-#47):
> [Mon Apr 21 21:21:33 2025]  pdsc_auxbus_dev_del+0xef/0x160 [pds_core]
> [Mon Apr 21 21:21:33 2025]  pdsc_remove+0xc0/0x1b0 [pds_core]
> [Mon Apr 21 21:21:33 2025]  pci_device_remove+0x24/0x70
> [Mon Apr 21 21:21:33 2025]  device_release_driver_internal+0x11f/0x180
> [Mon Apr 21 21:21:33 2025]  driver_detach+0x45/0x80
> [Mon Apr 21 21:21:33 2025]  bus_remove_driver+0x83/0xe0
> [Mon Apr 21 21:21:33 2025]  pci_unregister_driver+0x1a/0x80
> 
> The actual device uninit usually happens on a separate thread
> scheduled after this code runs, but there is no guarantee of order
> of thread execution, so this could be a problem.  There's no
> actual need to clear the client_id at this point, so simply
> remove the offending code.
> 
> Fixes: 10659034c622 ("pds_core: add the aux client API")
> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>

Thinking out loud:

My understanding is that after auxiliary_device_uninit() has
been called then pdsc_auxbus_dev_release(), which frees the memory
used by padev, will be called asynchronously.

And, as per the patch description, this usually happens after
the line deleted by this patch has been executed. But there are no
guarantees about that ordering. And sometimes it does not. *Boom*.

Based on my understanding above this patch looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

> ---
>  drivers/net/ethernet/amd/pds_core/auxbus.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/amd/pds_core/auxbus.c b/drivers/net/ethernet/amd/pds_core/auxbus.c
> index c9aac27883a3..92f359f2b449 100644
> --- a/drivers/net/ethernet/amd/pds_core/auxbus.c
> +++ b/drivers/net/ethernet/amd/pds_core/auxbus.c
> @@ -186,7 +186,6 @@ void pdsc_auxbus_dev_del(struct pdsc *cf, struct pdsc *pf,
>  	pds_client_unregister(pf, padev->client_id);
>  	auxiliary_device_delete(&padev->aux_dev);
>  	auxiliary_device_uninit(&padev->aux_dev);
> -	padev->client_id = 0;
>  	*pd_ptr = NULL;
>  
>  	mutex_unlock(&pf->config_lock);
> -- 
> 2.17.1
> 
> 

