Return-Path: <netdev+bounces-45901-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A3417E0337
	for <lists+netdev@lfdr.de>; Fri,  3 Nov 2023 13:57:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51D6E281CE4
	for <lists+netdev@lfdr.de>; Fri,  3 Nov 2023 12:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D836171AF;
	Fri,  3 Nov 2023 12:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nToruN3x"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BD3168DE
	for <netdev@vger.kernel.org>; Fri,  3 Nov 2023 12:57:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA855C433C8;
	Fri,  3 Nov 2023 12:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1699016236;
	bh=Z4GRd0KC2ISywGcPf/cNtZiFl5y4kqZBVx/tBDTs7UE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nToruN3xBPwHT7q+LbTARIMHGepo2OT9MGLynrmTvE1MVVtD4JrzpvjyZI0k2tMXU
	 L8/l12OKmkFdt4SEQtmhXbbM+GSmJYkZEO4XHGAOQPwRoiY/IX6kL6Tw2YnRZf41VS
	 BRGgalmr0TqJwJI7LfUoaH/1WgufMVPsljEvDXjA=
Date: Fri, 3 Nov 2023 13:57:13 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Yuran Pereira <yuran.pereira@hotmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
	florian.fainelli@broadcom.com, linux-kernel@vger.kernel.org,
	justin.chen@broadcom.com, edumazet@google.com,
	bcm-kernel-feedback-list@broadcom.com, kuba@kernel.org,
	pabeni@redhat.com, linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] Prevent out-of-bounds read/write in bcmasp_netfilt_rd
 and bcmasp_netfilt_wr
Message-ID: <2023110301-purist-reputable-fab7@gregkh>
References: <DB3PR10MB6835E073F668AD24F57AE64AE8A5A@DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB3PR10MB6835E073F668AD24F57AE64AE8A5A@DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM>

On Fri, Nov 03, 2023 at 05:57:48PM +0530, Yuran Pereira wrote:
> The functions `bcmasp_netfilt_rd` and `bcmasp_netfilt_wr` both call
> `bcmasp_netfilt_get_reg_offset` which, when it fails, returns `-EINVAL`.
> This could lead to an out-of-bounds read or write when `rx_filter_core_rl`
> or `rx_filter_core_wl` is called.
> 
> This patch adds a check in both functions to return immediately if
> `bcmasp_netfilt_get_reg_offset` fails. This prevents potential out-of-bounds read
> or writes, and ensures that no undefined or buggy behavior would originate from
> the failure of `bcmasp_netfilt_get_reg_offset`.
> 
> Addresses-Coverity-IDs: 1544536 ("Out-of-bounds access")
> Signed-off-by: Yuran Pereira <yuran.pereira@hotmail.com>
> ---
>  drivers/net/ethernet/broadcom/asp2/bcmasp.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp.c b/drivers/net/ethernet/broadcom/asp2/bcmasp.c
> index 29b04a274d07..8b90b761bdec 100644
> --- a/drivers/net/ethernet/broadcom/asp2/bcmasp.c
> +++ b/drivers/net/ethernet/broadcom/asp2/bcmasp.c
> @@ -227,6 +227,8 @@ static void bcmasp_netfilt_wr(struct bcmasp_priv *priv,
>  
>  	reg_offset = bcmasp_netfilt_get_reg_offset(priv, nfilt, reg_type,
>  						   offset);
> +	if (reg_offset < 0)
> +		return;
>  
>  	rx_filter_core_wl(priv, val, reg_offset);
>  }
> @@ -244,6 +246,8 @@ static u32 bcmasp_netfilt_rd(struct bcmasp_priv *priv,
>  
>  	reg_offset = bcmasp_netfilt_get_reg_offset(priv, nfilt, reg_type,
>  						   offset);
> +	if (reg_offset < 0)
> +		return 0;

Shouldn't you return an error here?

thanks

greg k-h

