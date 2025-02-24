Return-Path: <netdev+bounces-169228-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 582F4A4302A
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 23:34:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 504DA1695E1
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 22:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 820AB19B586;
	Mon, 24 Feb 2025 22:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ojv6rtqD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF8F2571B2
	for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 22:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740436471; cv=none; b=GeU3oqKuMHqMaz0l7YwmMupITJowOJ0AhpbmzDYYka+MSOhapVRLS4AU5LJX+HBaPdAmvX/bQkxVPy4YwhqDrsqzxyk8aFPNrZ9rXbdiUceAeIwzeppFK+Tq8cv/u97rBdplJC9Yj+k4zJiRQ+fSmP0h61WqCbsqQHC1QR/ABRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740436471; c=relaxed/simple;
	bh=DwbTS3RuUAZbDZnuaNl7MZ0jOyBWMARJc0tzqb6114o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A5STiph7tUcGM4nXgf7Mu05vQQq8OWNOnxVqBJsXNNLv5Watr8qDY1+xKc35npajgshfuqNfEFl8MsAeOG7iWqW59pqESz8k/BdxmOPLH9CZkceUsFXdWKADqAm7dIRfiHC9Op8Ldo0CTNPgxvYqjpEDytohNKfL17ygOr6Xwqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ojv6rtqD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDB43C4CED6;
	Mon, 24 Feb 2025 22:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740436470;
	bh=DwbTS3RuUAZbDZnuaNl7MZ0jOyBWMARJc0tzqb6114o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ojv6rtqDqAjfsxJkB7kDK15koEwd2CR3Y0eshCOt0k18wiHlpgx23sZu1yhl61du5
	 DCkK7PHveeAl8ezjaGmBzKeDoDb025IphBmGiF1AsXnasN2/9WtmSBJmkehLBJjeoh
	 /DsOPSE+W/gzfRcI/Tj9YS6Pb/xOV83tT8vydj4wIcCVxF+uRCb4Y0LxdcWD2NnXI7
	 A1Kq2PpDFMzUSvQ954ImFPOoL34zCNisDubQwFtvN6t7PLjcCcBjj1ipkPgLG54XAu
	 7UjmnVMF1RmKTpUF2U2XqK+SZ79qn0TM+A+PVpRFD7yhABLlMEW5Y+DT7tk4wI4p87
	 QdEs3RT4nDFWw==
Date: Mon, 24 Feb 2025 14:34:30 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Mohammad Heib <mheib@redhat.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net] net: Clear old fragment checksum value in
 napi_get_frags
Message-ID: <20250224143430.5fa61a68@kernel.org>
In-Reply-To: <20250221161405.1921296-1-mheib@redhat.com>
References: <20250221161405.1921296-1-mheib@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Feb 2025 18:14:05 +0200 Mohammad Heib wrote:
> In certain cases, napi_get_frags() returns an skb that points to an old
> received fragment, This skb may have its skb->ip_summed, csum, and other
> fields set from previous fragment handling.
> 
> Some network drivers set skb->ip_summed to either CHECKSUM_COMPLETE or
> CHECKSUM_UNNECESSARY when getting skb from napi_get_frags(), while
> others only set skb->ip_summed when RX checksum offload is enabled on
> the device, and do not set any value for skb->ip_summed when hardware
> checksum offload is disabled, assuming that the skb->ip_summed
> initiated to zero by napi_get_frags.
> 
> This inconsistency sometimes leads to checksum validation issues in the
> upper layers of the network stack.
> 
> To resolve this, this patch clears the skb->ip_summed value for each skb
> returned by napi_get_frags(), ensuring that the caller is responsible
> for setting the correct checksum status. This eliminates potential
> checksum validation issues caused by improper handling of
> skb->ip_summed.

Could you give an example of a driver where this may happen?
Otherwise the commit message reads too hypothetical.

> Fixes: 76620aafd66f ("gro: New frags interface to avoid copying shinfo")
> Signed-off-by: Mohammad Heib <mheib@redhat.com>
> ---
>  net/core/gro.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/net/core/gro.c b/net/core/gro.c
> index 78b320b63174..e98007d8f26f 100644
> --- a/net/core/gro.c
> +++ b/net/core/gro.c
> @@ -675,6 +675,8 @@ struct sk_buff *napi_get_frags(struct napi_struct *napi)
>  			napi->skb = skb;
>  			skb_mark_napi_id(skb, napi);
>  		}
> +	} else {
> +		skb->ip_summed = CHECKSUM_NONE;
>  	}
>  	return skb;
>  }

I think this belongs in napi_reuse_skb(), doesn't it ?

Please make sure you CC maintainers on v2, especially Eric.
-- 
pw-bot: cr

