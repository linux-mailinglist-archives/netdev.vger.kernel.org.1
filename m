Return-Path: <netdev+bounces-126584-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A662E971EB1
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 18:05:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F6A21F22E39
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 16:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6B058ABF;
	Mon,  9 Sep 2024 16:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i9BzynDs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6661D1BC39;
	Mon,  9 Sep 2024 16:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725897933; cv=none; b=AQ+d5d+/hjbCaYN8V1qcN03iYv4zuquMcEEs9S18lGmsXY6oiYPV9/k3nVA+kKsCvqfCYh32VxKCUNuIGlPKciFjZrL4L0y9JeQHRc61NGNcPM6vsgk7eSWNCMrB4Ak7vzyLAzZEgRu14Y30c+QB2VvXlXM8PpRI9Pja2MJiAds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725897933; c=relaxed/simple;
	bh=rLBEZClf5sJqX9/vE4kuYddxEfLE1Osjv0Le7WjUtSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iF/02eCxqMqljcrSm147DV34FWIn3Sm4oBpS44/NUw1XB5zdpBeFhV1bQaSzC8Ml+mR9DS2Y57F4/0IB1o8lqFrEP9g317QSwyCJfswGf0ODS/ZfFmn7v+xjQCgnPVcktVsJqPPvZ0P/X2/aFpdN99tnaMRvF4Dt0xKErTAfNr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i9BzynDs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5A9AC4CEC5;
	Mon,  9 Sep 2024 16:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725897933;
	bh=rLBEZClf5sJqX9/vE4kuYddxEfLE1Osjv0Le7WjUtSg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i9BzynDsFLsdl0Qhw2jV3w1WYGXnni69g9qGCSX74XByYBK/DYmg3ZsWVlhWiWkp5
	 Hc5j8rnyigxjgQXGC/pANc8ckzmgy1Y9RsDs7eT7VFZ7AouCPIGFw/h9N5Kv2bb1ty
	 5Wrm5dtzgfBuUHGM0Njg94hLqsmmBpGLu1ESitdUSKPaPjZXMr8etTfJ8vOEE2DFCJ
	 KgkH+PdA7PvNwIuvG7B/12Zf+dDOelGQ9HmqvumgZ11T8JrsWYWgJNNZwIlLQ4Zaac
	 UqeLyeuApBVOGFDRYEgm3/qL1VlXpsvjZiHaRolh0OBCY5euIeDk4lK2WwdOAfUF0Q
	 6RUhjvhOqM7Jw==
Date: Mon, 9 Sep 2024 17:05:28 +0100
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, thepacketgeek@gmail.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, davej@codemonkey.org.uk,
	vlad.wing@gmail.com, max@kutsevol.com
Subject: Re: [PATCH net-next v2 08/10] net: netconsole: do not pass userdata
 up to the tail
Message-ID: <20240909160528.GD2097826@kernel.org>
References: <20240909130756.2722126-1-leitao@debian.org>
 <20240909130756.2722126-9-leitao@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240909130756.2722126-9-leitao@debian.org>

On Mon, Sep 09, 2024 at 06:07:49AM -0700, Breno Leitao wrote:
> Do not pass userdata to send_msg_fragmented, since we can get it later.
> 
> This will be more useful in the next patch, where send_msg_fragmented()
> will be split even more, and userdata is only necessary in the last
> function.
> 
> Suggested-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Breno Leitao <leitao@debian.org>

...

> @@ -1094,7 +1098,6 @@ static void append_release(char *buf)
>  
>  static void send_msg_fragmented(struct netconsole_target *nt,
>  				const char *msg,
> -				const char *userdata,
>  				int msg_len,
>  				int release_len)
>  {
> @@ -1103,8 +1106,10 @@ static void send_msg_fragmented(struct netconsole_target *nt,
>  	int offset = 0, userdata_len = 0;
>  	const char *header, *msgbody;
>  
> -	if (userdata)
> -		userdata_len = nt->userdata_length;
> +#ifdef CONFIG_NETCONSOLE_DYNAMIC
> +	userdata = nt->userdata_complete;
> +	userdata_len = nt->userdata_length;
> +#endif

userdata does not appear to be declared in this scope :(

.../netconsole.c:1110:9: error: 'userdata' undeclared (first use in this function)
 1110 |         userdata = nt->userdata_complete;

>  
>  	/* need to insert extra header fields, detect header and msgbody */
>  	header = msg;

...

