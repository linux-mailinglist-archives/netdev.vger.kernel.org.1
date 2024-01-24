Return-Path: <netdev+bounces-65505-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9681D83AD7F
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 16:37:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC9461C210D3
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 15:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E06877C083;
	Wed, 24 Jan 2024 15:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="HEayDUUq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE3A7A729
	for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 15:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706110668; cv=none; b=NoOLQbINwxSaa93ffp789ZS3nfXmJuTyV5pI8sro8Ery4sIyVil1TGZLr+EGJXKAk1qYVpxCLFZV84dm55o1HnA3Pv8Uld8WmV6yYePRsX4IFvT+sK447t48RjlEVD10TIw8v/xVJT8ynsECFrpjxKTZOd2DPGTlN1IZGsr2t7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706110668; c=relaxed/simple;
	bh=1g0+jyA0TIHFlph50vci2p1M5IaEFEwQ/UdWafOlG3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M7DcgUXq8MkHYkVG7vBOtiVJwgCBO0NJqfR616ZDRIiszmpQWeXPa/YwApB73ykJ8eB4UZeDHG5sn+4SrQO0QwOB8j9b33p+8EHQm+UEyrC4N6fbyjM6NdeBKrr2mrcHl+XjBVhoc+HI2fskUyCGYKfB+N76+46rgLqd48XYCWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=HEayDUUq; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d7354ba334so34792215ad.1
        for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 07:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1706110666; x=1706715466; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ClQQw4qNd3GfJ3FxBTexyIn5PW1ERkPEgwB1ggWKE24=;
        b=HEayDUUqxhH/MhU6x+dBWAYo1IiKZ+YLiUT7v0iTRu3HxOou73sFyNtbE2Fx+T7klj
         T2nbLXpg3WDf9c/sQwPEL6HohjnL6XJt0EbSBkfB3M5lCktYdoxuhH9w+izlzmmNp1/C
         ZuLvk9OA9yz8c8ToBYXKR9UoEF+QHg9fJrzqo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706110666; x=1706715466;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ClQQw4qNd3GfJ3FxBTexyIn5PW1ERkPEgwB1ggWKE24=;
        b=AUs+NQyh94IcKuwvzMzJORPf1POgJrqs55dlUmnNFSDzJ8FTMsLhO/OVrXszsFcOED
         t5Wr5TpQNUvbukE7olIu1vw0HjQfsHHiBp8O5HQ8yIR+PmIAKm6jZD39Iqr/ZkRJKgKO
         IIe7722sYTN/zdNE1xlZFWZfxs1nr52CeVhG9JVLXFP/3ezmVJHcuG888ptBnb8KNZ3a
         hLVK33kohTtdsEhN3NQX5/REsbomX/iaavMzJE3lEjPxnwZpv5qHEGWiRDHXrI4BJjO+
         zAfZLt+b1kkp/S/9qKFUnMjWRgVo0Xb0tnZuGZHcFt0jLbjkfy+L8e9mJZptL2SKb4/y
         IJHQ==
X-Gm-Message-State: AOJu0YzywkxjkpC6n4A2YNyMkCvFL/TAaazczkzwtpo1P5sVjlgC6RyW
	k/XHNxV5Ku+xPVaHylfb5G/2abDDY3jbiU9h0KrBR2dh91PtPcpmnAkupMaGz6cADjgbfrVM6NF
	OcERN9nRmBtbIRiLbXOMH8WKGmH6JBt7NIsdn+V9tHu7yEkoB/znAmIxS+ruzb+1jKNF+TlzL+B
	wKPYJsZHsz7/cJ22bD5KvoiDJH5wKkhRAM41E=
X-Google-Smtp-Source: AGHT+IH6Rfx/MwuDQs1uCkM5orR22klptLn6TfM4VyPKF7Unf/mKIGimtKEELdAh98AsVGDpoCDzIw==
X-Received: by 2002:a17:902:ea10:b0:1d7:461c:fe46 with SMTP id s16-20020a170902ea1000b001d7461cfe46mr1230604plg.31.1706110666275;
        Wed, 24 Jan 2024 07:37:46 -0800 (PST)
Received: from fastly.com (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id kk6-20020a170903070600b001d720a7a616sm8703658plb.165.2024.01.24.07.37.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jan 2024 07:37:45 -0800 (PST)
Date: Wed, 24 Jan 2024 07:37:43 -0800
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: chuck.lever@oracle.com, jlayton@kernel.org, linux-api@vger.kernel.org,
	brauner@kernel.org, edumazet@google.com, davem@davemloft.net,
	alexander.duyck@gmail.com, sridhar.samudrala@intel.com,
	kuba@kernel.org
Subject: Re: [net-next 3/3] eventpoll: Add epoll ioctl for epoll_params
Message-ID: <20240124153742.GA6808@fastly.com>
References: <20240124025359.11419-1-jdamato@fastly.com>
 <20240124025359.11419-4-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124025359.11419-4-jdamato@fastly.com>
User-Agent: Mutt/1.5.24 (2015-08-30)

On Wed, Jan 24, 2024 at 02:53:59AM +0000, Joe Damato wrote:
> Add an ioctl for getting and setting epoll_params. User programs can use
> this ioctl to get and set the busy poll usec time or packet budget
> params for a specific epoll context.
> 
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> ---
>  .../userspace-api/ioctl/ioctl-number.rst      |  1 +
>  fs/eventpoll.c                                | 41 +++++++++++++++++++
>  include/uapi/linux/eventpoll.h                | 12 ++++++
>  3 files changed, 54 insertions(+)
> 
> diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
> index 457e16f06e04..b33918232f78 100644
> --- a/Documentation/userspace-api/ioctl/ioctl-number.rst
> +++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
> @@ -309,6 +309,7 @@ Code  Seq#    Include File                                           Comments
>  0x89  0B-DF  linux/sockios.h
>  0x89  E0-EF  linux/sockios.h                                         SIOCPROTOPRIVATE range
>  0x89  F0-FF  linux/sockios.h                                         SIOCDEVPRIVATE range
> +0x8A  00-1F  linux/eventpoll.h
>  0x8B  all    linux/wireless.h
>  0x8C  00-3F                                                          WiNRADiO driver
>                                                                       <http://www.winradio.com.au/>
> diff --git a/fs/eventpoll.c b/fs/eventpoll.c
> index 40bd97477b91..d973147c015c 100644
> --- a/fs/eventpoll.c
> +++ b/fs/eventpoll.c
> @@ -869,6 +869,45 @@ static void ep_clear_and_put(struct eventpoll *ep)
>  		ep_free(ep);
>  }
>  
> +static long ep_eventpoll_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
> +{
> +	int ret;
> +	struct eventpoll *ep;
> +	struct epoll_params epoll_params;
> +	void __user *uarg = (void __user *) arg;
> +
> +	if (!is_file_epoll(file))
> +		return -EINVAL;
> +
> +	ep = file->private_data;
> +
> +	switch (cmd) {
> +#ifdef CONFIG_NET_RX_BUSY_POLL
> +	case EPIOCSPARAMS:
> +		if (copy_from_user(&epoll_params, uarg, sizeof(epoll_params)))
> +			return -EFAULT;
> +
> +		ep->busy_poll_usecs = epoll_params.busy_poll_usecs;
> +		ep->busy_poll_budget = epoll_params.busy_poll_budget;
> +		return 0;
> +
> +	case EPIOCGPARAMS:
> +		memset(&epoll_params, 0, sizeof(epoll_params));
> +		epoll_params.busy_poll_usecs = ep->busy_poll_usecs;
> +		epoll_params.busy_poll_budget = ep->busy_poll_budget;
> +		if (copy_to_user(uarg, &epoll_params, sizeof(epoll_params)))
> +			return -EFAULT;
> +
> +		return 0;
> +#endif
> +	default:
> +		ret = -EINVAL;
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
>  static int ep_eventpoll_release(struct inode *inode, struct file *file)
>  {
>  	struct eventpoll *ep = file->private_data;
> @@ -975,6 +1014,8 @@ static const struct file_operations eventpoll_fops = {
>  	.release	= ep_eventpoll_release,
>  	.poll		= ep_eventpoll_poll,
>  	.llseek		= noop_llseek,
> +	.unlocked_ioctl	= ep_eventpoll_ioctl,
> +	.compat_ioctl   = compat_ptr_ioctl,
>  };
>  
>  /*
> diff --git a/include/uapi/linux/eventpoll.h b/include/uapi/linux/eventpoll.h
> index cfbcc4cc49ac..9211103779c4 100644
> --- a/include/uapi/linux/eventpoll.h
> +++ b/include/uapi/linux/eventpoll.h
> @@ -85,4 +85,16 @@ struct epoll_event {
>  	__u64 data;
>  } EPOLL_PACKED;
>  
> +struct epoll_params {
> +	u64 busy_poll_usecs;
> +	u16 busy_poll_budget;
> +
> +	/* for future fields */
> +	uint8_t data[118];

Err, just noticed that this should be a u8, instead. Sorry I missed this.

I assume there will be other feedback to address, but if not, I've noted
that I need to fix this in the v2.

