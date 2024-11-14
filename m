Return-Path: <netdev+bounces-144670-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D35D9C8154
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 04:09:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27E221F22072
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 03:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE831E7C00;
	Thu, 14 Nov 2024 03:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QQG4UBxZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41502E634;
	Thu, 14 Nov 2024 03:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731553762; cv=none; b=D7MQjxAuhLqvwKFMUVZIrMVKqsVohhJTmWCPwuEK7GBIL0pWsNw7G0ikGcdBUZKStgZehtD4doAA2z7y/lVDobRq5OZC4NtsHiaPPAz+rK5hpx2mr0LiSHkTROvYVYOCEo3xOmMQdrGItkf26LsEUE00UHA8mmW0eqOQ/NMSw5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731553762; c=relaxed/simple;
	bh=aNA+MUiXR33lNnb7g+eD9z36PEo+w4KP8BYPgK0Kh2w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=osPInc96nhDVcaJX6N+MCuC2VQDvZ9ImQiwLIDSBBkgBqrYstwdMY82GvChGhctlgZeADcaAjnGPqQH+y0lLsc5ancLFtamJQFHRi0xvWsy+5ENEZqy1JO7TGqRixgPYpEXc676+Ay9dW3m5QYovAbeIsOe/Xbnz0GF/RBs4E3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QQG4UBxZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68434C4CEC3;
	Thu, 14 Nov 2024 03:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731553761;
	bh=aNA+MUiXR33lNnb7g+eD9z36PEo+w4KP8BYPgK0Kh2w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QQG4UBxZzz99WLCh1CqhlhsxLgYpBVK2nXRK8PkrOJ1mtquva9FvsnXw1+Pvo1u01
	 kSoXoKQiAyD+nsX0Os/T+IldoBGTutZN8QeYsOQWACKR6kiENdOaRl3yjSfmZmlm9s
	 KNF+MSBp2oCkJb7cdVy0+vI5buypTfdDmifDPRCy6Y9M4YNvY85ZFan3GIn3blCBYD
	 JAOlzbq1vawb+i3Qh6SodcO1n6xxgKj/n+Sl2mHyiQiISKC3JZRFeoWFG+/Ag4w1yb
	 qwmxitYYnkKiAe0EJaElkWrY0I1Jciy5ki/Zjhmxi2d3//xSeBERMYfmaHdbEsU8P5
	 9MR0sqfovkxlQ==
Date: Wed, 13 Nov 2024 19:09:20 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jian Zhang <zhangjian.3032@bytedance.com>
Cc: netdev@vger.kernel.org, openbmc@lists.ozlabs.org, Jeremy Kerr
 <jk@codeconstruct.com.au>, Matt Johnston <matt@codeconstruct.com.au>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH net-next] mctp i2c: notify user space on TX failure
Message-ID: <20241113190920.0ceaddf2@kernel.org>
In-Reply-To: <20241108094206.2808293-1-zhangjian.3032@bytedance.com>
References: <20241108094206.2808293-1-zhangjian.3032@bytedance.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  8 Nov 2024 17:42:06 +0800 Jian Zhang wrote:
> diff --git a/drivers/net/mctp/mctp-i2c.c b/drivers/net/mctp/mctp-i2c.c
> index 4dc057c121f5..e9a835606dfc 100644
> --- a/drivers/net/mctp/mctp-i2c.c
> +++ b/drivers/net/mctp/mctp-i2c.c
> @@ -485,6 +485,7 @@ static void mctp_i2c_xmit(struct mctp_i2c_dev *midev, struct sk_buff *skb)
>  	struct mctp_i2c_hdr *hdr;
>  	struct i2c_msg msg = {0};
>  	u8 *pecp;
> +	struct sock *sk;
>  	int rc;
>  

nit: order the variable declaration lines longest to shortest

> @@ -551,6 +552,14 @@ static void mctp_i2c_xmit(struct mctp_i2c_dev *midev, struct sk_buff *skb)
>  		dev_warn_ratelimited(&midev->adapter->dev,
>  				     "__i2c_transfer failed %d\n", rc);
>  		stats->tx_errors++;
> +
> +		sk = skb->sk;
> +		if (sk) {
> +			sk->sk_err = -rc;
> +			if (!sock_flag(sk, SOCK_DEAD))
> +				sk_error_report(sk);
> +		}

notifying socket in the xmit handler of a netdev is a bit strange,
could you do it somewhere higher in the MCTP stack?
-- 
pw-bot: cr

