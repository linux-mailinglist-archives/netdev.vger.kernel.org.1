Return-Path: <netdev+bounces-107859-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A7E91C9DC
	for <lists+netdev@lfdr.de>; Sat, 29 Jun 2024 03:02:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28E371C2154F
	for <lists+netdev@lfdr.de>; Sat, 29 Jun 2024 01:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ACD463C;
	Sat, 29 Jun 2024 01:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UdE/4GEp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C9C19B
	for <netdev@vger.kernel.org>; Sat, 29 Jun 2024 01:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719622928; cv=none; b=GEfLsXMdWdvVNkO25S+dPk2qcBQWIDNKWKRdvh8BNWlyz/kuKwN3Kq5tf3OGPNmLS8p06HWGviPHTwVVgYq2HICUyoXrEnclVgYjftSiAFR3jxjZMibY3IyWRL6kXLiMyEdwvleAjyhM0XxmN1JFuhJDYqctUPJ9EiirtNiIoeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719622928; c=relaxed/simple;
	bh=Wf0EyOjLYkG6TOLQhaW3FeDmesUYq/9Ol+OSmkcnWYk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RtrFHQVeej8l44D3H4Sgxr8AyzbXDWrj0Pl4CytkiDeo+aHTGGPLCvwE527gQn0Sd4MmYCT/uXavWBAjdyy5nkjT9YHJC1KTQ/N4aNt6D1EujJ2AbUyLh1G/FUwXJWQv/bDYoaj9Pr8fep3tYUdaNG2zbWMNYONvFRowMsKZ98c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UdE/4GEp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1714DC116B1;
	Sat, 29 Jun 2024 01:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719622927;
	bh=Wf0EyOjLYkG6TOLQhaW3FeDmesUYq/9Ol+OSmkcnWYk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UdE/4GEpzd3173xSn6LqhXQeqrVua0AmzMlfSG4boy8vg4jMDAuZYkIHRXC0NT4zA
	 DjlW3ixdCchKce8UnTmYT0SMHtBHnbEtZaq003rokZxHR2l274cGgo3VrVlV07ckOF
	 neyXqpFqHa3UHIGW+bgke29FaAa7y3LcHTCAbgyc5JRgD2caBS0wcI2eWBT0jJgLA7
	 w6v09svj4csRUJ6OHvfvBuSoyNLP9TfQeuq7uNhK6rWQkBRB2wcjg3RxZ5raRP6inW
	 TnWlGk4cyLSjsm9fufGPHU3H8t9gzhWhWbsGOuaqwHoly41pjm199tt2txEA2F+5h4
	 q5iSfXbLvIBKA==
Date: Fri, 28 Jun 2024 18:02:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Rushil Gupta <rushilg@google.com>
Cc: netdev@vger.kernel.org, jeroendb@google.com, pkaligineedi@google.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 willemb@google.com, hramamurthy@google.com, Shailend Chand
 <shailend@google.com>, Ziwei Xiao <ziweixiao@google.com>
Subject: Re: [PATCH net-next] gve: Add retry logic for recoverable adminq
 errors
Message-ID: <20240628180206.07c0a1b2@kernel.org>
In-Reply-To: <20240628204139.458075-1-rushilg@google.com>
References: <20240628204139.458075-1-rushilg@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 28 Jun 2024 20:41:39 +0000 Rushil Gupta wrote:
> An adminq command is retried if it fails with an ETIME error code
> which translates to the deadline exceeded error for the device.
> The create and destroy adminq commands are now managed via a common
> method. This method keeps track of return codes for each queue and retries
> the commands for the queues that failed with ETIME.
> Other adminq commands that do not require queue level granularity are
> simply retried in gve_adminq_execute_cmd.
> 
> Signed-off-by: Rushil Gupta <rushilg@google.com>
> Signed-off-by: Jeroen de Borst <jeroendb@google.com>
> Reviewed-by: Shailend Chand <shailend@google.com>
> Reviewed-by: Ziwei Xiao <ziweixiao@google.com>

I told you once already that you're not allowed to repost patches
within 24h. You should also include a change long when you repost.

Since Jeroen is a maintainer of this driver, and you are not listed
in the MAINTAINERS file I don't understand why you're the one sending
this. We can't teach everyone at google the upstream process one by
one so I'd like to request that only the listed maintainers post pure
GVE patches (or the folks who are heavily involved upstream).

> diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
> index c5bbc1b7524e..74c61b90ea45 100644
> --- a/drivers/net/ethernet/google/gve/gve_adminq.c
> +++ b/drivers/net/ethernet/google/gve/gve_adminq.c
> @@ -12,7 +12,7 @@
>  
>  #define GVE_MAX_ADMINQ_RELEASE_CHECK	500
>  #define GVE_ADMINQ_SLEEP_LEN		20
> -#define GVE_MAX_ADMINQ_EVENT_COUNTER_CHECK	100
> +#define GVE_MAX_ADMINQ_EVENT_COUNTER_CHECK	1000
>  
>  #define GVE_DEVICE_OPTION_ERROR_FMT "%s option error:\n" \
>  "Expected: length=%d, feature_mask=%x.\n" \
> @@ -415,14 +415,17 @@ static int gve_adminq_parse_err(struct gve_priv *priv, u32 status)
>  /* Flushes all AQ commands currently queued and waits for them to complete.
>   * If there are failures, it will return the first error.
>   */
> -static int gve_adminq_kick_and_wait(struct gve_priv *priv)
> +static int gve_adminq_kick_and_wait(struct gve_priv *priv, int ret_cnt, int *ret_codes)
>  {
>  	int tail, head;
> -	int i;
> +	int i, j;
>  
>  	tail = ioread32be(&priv->reg_bar0->adminq_event_counter);
>  	head = priv->adminq_prod_cnt;
>  
> +	if ((head - tail) > ret_cnt)

please delete all the pointless parenthesis in + lines of this patch.
-- 
pw-bot: cr

