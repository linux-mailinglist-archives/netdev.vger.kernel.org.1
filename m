Return-Path: <netdev+bounces-142241-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F4079BDF70
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 08:33:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7A7AB23120
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 07:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7332C1917CD;
	Wed,  6 Nov 2024 07:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b5k0dBli"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5518C145B14
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 07:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730878381; cv=none; b=N8OEkTSyLYUXu1kqxPMNS263d1RWpMh23ODk+AvU64gWENvAqsvlK6K+TSnuRslg4Aek96Jyf+2Xyhp/Opvmt7W1neKpRF2E6kSWUi7RElnWVqfoZPry8RMY2FPzpZm2+OQEsOJa0J2cIuuHdesdkUbDGGZBKSuij2P55DPwvhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730878381; c=relaxed/simple;
	bh=1TK5jWQmYm5lF5a0elC3Jq/CHvGV6cfz4sc++/qpT/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iCwTWuQnJ+nfTRlI76wgYI+X7/yatLI4mWpSloY7Fk62Eo86qEldb+VDjwE133ExZO1Nh7RaEZMAXXd+rsw/xHYLgv8dXdnbVh/DSqfuXKpKzvXJtNdDWIXd3tB+q4w/57KqOR6V6uJuaPRjKZ3F6fr2pshvUf/pNVDqjYVdWMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b5k0dBli; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730878378;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I0Nl77wHyDTDBUHU8VfL2oqjen/EEFJo/J8tC1+irrs=;
	b=b5k0dBlig2vuFj1Jqi/4N3tqWNBqFumFZl8zc5t9+r2bl2/8T/yXJVe816TeYAt7ZbeFPC
	dit1dCwTWseWIzNE5JFw4Sf8mw6ZACn1tbtK17W1+iB/IzBnHkE2IgFezJSJWOylvHmeXT
	LR8XB1kH7dJqCXXh+j0NhslSFjQDI2M=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-wtuSN4ZcOuirroJusgBUgA-1; Wed, 06 Nov 2024 02:32:56 -0500
X-MC-Unique: wtuSN4ZcOuirroJusgBUgA-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2fb3da343ceso45054641fa.0
        for <netdev@vger.kernel.org>; Tue, 05 Nov 2024 23:32:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730878375; x=1731483175;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I0Nl77wHyDTDBUHU8VfL2oqjen/EEFJo/J8tC1+irrs=;
        b=L1UWck/bfuo9Sza4L1Q/sN3GArEj+md48q6rLsy9z1ANQWMQjhqrUPTqucYAe5OoBi
         nGiHe59rKV4ZgGYg5BThPfrXGbMaQ+UcwwedFitT8kIYh8g7aizCuRIuhEPPpP5yY8ze
         a+xgvCwLGMudvS8OOfxGw6Fd18WjZjjTd9+5E9JHSkiIPJRhlllh8DQMLNfxTP+hluEH
         FOWF2jDIdh/mlmqPfLwOQOeZPmLY427Q22kcq58LOK4Phf2KElxxwhhBrbEiAJ+lnnhc
         8OoW00/mBAoUIUBjqoOVy0GT5hitIpJZTCQ8huEHV4T8FU3DKXAPQyhTlzOU1frpUSL+
         30WQ==
X-Forwarded-Encrypted: i=1; AJvYcCXV3tGfUeIcbICRIVnjT8sQAxg1L28vwMKbuvANyLKkhqT6susoz8olKlfHiA9H3OzlNdm6c60=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9k6V00gahjkhvOKAh6q6yT8W3U9V4ISONSQQEScx2Df/+su63
	hijCYcWvH/gsc8aXOE6QcawQNDNEBCj1h++4mqB47aJz1vwLApRUxE8kiKC12GKKKLctztsOyZI
	oX2qHHB4kya4dw9cieCkOdg8E0DOIHY+ta46UB1WMK0VjyWgM9GjnKQ==
X-Received: by 2002:a05:6512:3a8c:b0:539:ed5e:e226 with SMTP id 2adb3069b0e04-53b3490f0demr19783060e87.26.1730878375086;
        Tue, 05 Nov 2024 23:32:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGjB2BJOsn+j3Y41tPwiKFVeRVoGZVa9+cut0MOvJu0SDjEm2Wp6FGY8emxABWpEuw8y0y3Bg==
X-Received: by 2002:a05:6512:3a8c:b0:539:ed5e:e226 with SMTP id 2adb3069b0e04-53b3490f0demr19783047e87.26.1730878374648;
        Tue, 05 Nov 2024 23:32:54 -0800 (PST)
Received: from redhat.com ([2a02:14f:178:e74:5fcf:8a69:659d:f2b2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432aa7397e4sm11883915e9.40.2024.11.05.23.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 23:32:53 -0800 (PST)
Date: Wed, 6 Nov 2024 02:31:31 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, michael.christie@oracle.com, sgarzare@redhat.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [PATCH v3 7/9] vhost: Add new UAPI to support change to task mode
Message-ID: <20241106022630-mutt-send-email-mst@kernel.org>
References: <20241105072642.898710-1-lulu@redhat.com>
 <20241105072642.898710-8-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105072642.898710-8-lulu@redhat.com>

On Tue, Nov 05, 2024 at 03:25:26PM +0800, Cindy Lu wrote:
> Add a new UAPI to enable setting the vhost device to task mode.
> The userspace application can use VHOST_SET_INHERIT_FROM_OWNER
> to configure the mode if necessary.
> This setting must be applied before VHOST_SET_OWNER, as the worker
> will be created in the VHOST_SET_OWNER function
> 
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  drivers/vhost/vhost.c      | 15 ++++++++++++++-
>  include/uapi/linux/vhost.h |  2 ++
>  2 files changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index c17dc01febcc..70c793b63905 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -2274,8 +2274,9 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *argp)
>  {
>  	struct eventfd_ctx *ctx;
>  	u64 p;
> -	long r;
> +	long r = 0;
>  	int i, fd;
> +	bool inherit_owner;
>  
>  	/* If you are not the owner, you can become one */
>  	if (ioctl == VHOST_SET_OWNER) {
> @@ -2332,6 +2333,18 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *argp)
>  		if (ctx)
>  			eventfd_ctx_put(ctx);
>  		break;
> +	case VHOST_SET_INHERIT_FROM_OWNER:
> +		/*inherit_owner can only be modified before owner is set*/

bad coding style

> +		if (vhost_dev_has_owner(d))
> +			break;

is this silently failing? should return EBUSY or something like this.

> +
> +		if (copy_from_user(&inherit_owner, argp,
> +				   sizeof(inherit_owner))) {

not good, 


> +			r = -EFAULT;
> +			break;
> +		}
> +		d->inherit_owner = inherit_owner;




> +		break;
>  	default:
>  		r = -ENOIOCTLCMD;
>  		break;



This means any task can break out of jail
and steal root group system time by setting inherit_owner to 0
even if system is configured to inherit by default.

we need a modparam to block this.


> diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
> index b95dd84eef2d..1e192038633d 100644
> --- a/include/uapi/linux/vhost.h
> +++ b/include/uapi/linux/vhost.h
> @@ -235,4 +235,6 @@
>   */
>  #define VHOST_VDPA_GET_VRING_SIZE	_IOWR(VHOST_VIRTIO, 0x82,	\
>  					      struct vhost_vring_state)
> +
> +#define VHOST_SET_INHERIT_FROM_OWNER _IOW(VHOST_VIRTIO, 0x83, bool)

do not put bool in interfaces. something like u8 and validate it is 0 or
1.

>  #endif
> -- 
> 2.45.0


