Return-Path: <netdev+bounces-239887-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C4A7C6D90F
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 10:03:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 38DFC2D3CC
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 09:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B266331A6B;
	Wed, 19 Nov 2025 09:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dlan2A1p";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="CWDzEXr+"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AAF12E8DE2
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 09:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763542922; cv=none; b=Ql+IrM1KMTVZ5hKFtQv/kc0XKR1QgAI2qkP1FtcvoNqL5/aapPLSJ0S6lHlJBBl4q90vxWPU6F/bNEvil1KUwboVqpYYpC5hfzXusZyeg1gq/yKbeOXDH0wu1mq2WU+IahnHhFdJWT2dyFORO1WTsH59LKoKMGa7mF45Nw/wCeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763542922; c=relaxed/simple;
	bh=VGU4QRUO7tcjHFdgZ+nHt0HxE/FdqAYY5WJX1HtZVac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j0q8XLZr/7t0HwINE6azZTADrjwg8q59bQnNxm2QKAT0SjwBVYWle+qEvVyX2JElqv8L4VWd8EcTTHhL1xYt7ywOVIKj9nm1Evzg0097zYNIM8so3ciyGTXxVIuVJMlTHs1pXNGMNCdrgy0ZBaMxGdkuFfTH2RznqZfp5uw5YY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dlan2A1p; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=CWDzEXr+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763542919;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OT/rflnGD4jHalNS1sxjnUWeBFWffn/nuDxbFQiIS2E=;
	b=Dlan2A1p25IlLU/OvFbN/BNB3tqqFSg2uYuHnEhagYvOT3xlswA01qi6U/N8E3WI75yd9r
	WwNrrR/JjwcLpjKFazgKvzEz9+WQopLGgNKcZn7zju9bNK6dMj0/H40erO6eVq7T5bh0Pw
	vorT9flUONCNJrEJJDx3+mWrk+Biyfc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-272-zx13MNDVOsWlyWVy-NwjcQ-1; Wed, 19 Nov 2025 04:01:57 -0500
X-MC-Unique: zx13MNDVOsWlyWVy-NwjcQ-1
X-Mimecast-MFC-AGG-ID: zx13MNDVOsWlyWVy-NwjcQ_1763542916
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-429c93a28ebso4741145f8f.1
        for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 01:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763542916; x=1764147716; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OT/rflnGD4jHalNS1sxjnUWeBFWffn/nuDxbFQiIS2E=;
        b=CWDzEXr+QEEUyTueRlrRi7Ja2J27bCRhN84VykxK7BaItYkUCMpS0tSOGMx2b7ZjDh
         2iwsYNMlYFPtUCU5juCBkTq1rBN3dZBkVf+qk49Fu8x7iemAWjYNUV8+eMJWW2UC+QsW
         4Oaeh4xRgZZUJ5uT0hAhYd1kyZhNkFxnf3I+X05fHFoa11Qw27uMKFGccuVy8RfsmBmO
         Cxr6MfAbWafYxPa8Y5h0k/hoJNIunS1lEzc+eLWjhcSo6yvnh55ofFl2KrNVLnY8GZcr
         L2CAjwFXIa2dik2PFORTRb3IzqKBjBvtltouQIhGFE/Lz7sO8K9PkbiT8cxbXBLtzsrS
         Gq0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763542916; x=1764147716;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OT/rflnGD4jHalNS1sxjnUWeBFWffn/nuDxbFQiIS2E=;
        b=WUUpnyvrIrIer3NgviURhUVYs/VoHppzHV7m8LVDHXfbuTqLB1GTwaeTO7awOo4Ugb
         MBCr0NGqC2UVf0G0KnKuMA0Dut6dsnSqcpk5ExtZdFS8s6NWVbdLtuvZKuWqJqNkEn/Z
         B+5K587RNd+q7ip1NHA2Gs+m5PKDTsHbMi+n9BJ7TQtzaL5d55nPIh41bbY/2CMW75q5
         riqRCcwZLY8fZdKfcMlRnVoDIH1gvZCZHc7GmgQQZVaxhgCz1aAj9jIjGtIgVDLref5i
         RW8cFf9fqBUguub6ECgjFQMHa6mjAAPwzzuUTMzimEzZdsZLsSLYMqubH4GRt+QBTWs7
         1piA==
X-Gm-Message-State: AOJu0YxkVgyv93OMi76x7g/CDaDdNybm7iLRwo4q5lpfAqdJggVpWIt1
	26YDG7Gpe5zLW8SrtJCMjm9rc4Oc8BWgR+WmSM0dmsfryJbW+U/e5u1MpEl5BA+8knFO9tKoQnQ
	P7OEYp3G4pg1g+2YNact0+YdtiZCoxtekzzWV8kN362Tne5Fwi3LdggDRNQ==
X-Gm-Gg: ASbGncuafX3T+YD+x258XvjQwv38SLbhzO36AYtodRMI+vvZl1bKV5wTkEbgyNCjX69
	F0UlEcyBY9RoFSVPg4BB22kcfj1iv+eLKSYaQXLzoNgcO9w5SO0CRiKLHTqY8+o6Rl/F/7WVi/I
	JrauscZbuLynB9/u5KWKnZ/MXr37Z/3mr2k4hYvmr46dARQoK9447k9xOB6IvX469aRmt7kiAIm
	IdZaHYYlMjVnqk9lW+5cdKUUEYoGdCKlinOJz/UYmc2YlnZ8YtqLhy3U91yxFdPadWVerKHdi05
	T0WjZRsjMw9YaGEw7eAZ1AF18PFMJUOdzFXB2Ckd1K6NZwJB4yjVv3X/cIflRq/k3pXXxhUwmNq
	A29rjSlPsi+vRIZQcFtm1aPCJ5MKqWQ==
X-Received: by 2002:a05:6000:2001:b0:42b:4247:b07e with SMTP id ffacd0b85a97d-42b5934b278mr20025974f8f.25.1763542916187;
        Wed, 19 Nov 2025 01:01:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHxqSjRc606HQPYSuwRei/TlibJFpVfltszgkpJzG1O/Vry2+3uLQ41MDE1dXj3mXKLydFfyA==
X-Received: by 2002:a05:6000:2001:b0:42b:4247:b07e with SMTP id ffacd0b85a97d-42b5934b278mr20025921f8f.25.1763542915714;
        Wed, 19 Nov 2025 01:01:55 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53f0b8a0sm37444435f8f.25.2025.11.19.01.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 01:01:55 -0800 (PST)
Date: Wed, 19 Nov 2025 04:01:52 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
	virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, jgg@ziepe.ca, kevin.tian@intel.com,
	kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net-next v11 08/12] virtio_net: Use existing classifier
 if possible
Message-ID: <20251119035943-mutt-send-email-mst@kernel.org>
References: <20251118143903.958844-1-danielj@nvidia.com>
 <20251118143903.958844-9-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251118143903.958844-9-danielj@nvidia.com>

On Tue, Nov 18, 2025 at 08:38:58AM -0600, Daniel Jurgens wrote:
> Classifiers can be used by more than one rule. If there is an existing
> classifier, use it instead of creating a new one.
> 
> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
> Reviewed-by: Parav Pandit <parav@nvidia.com>
> Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
> v4:
>     - Fixed typo in commit message
>     - for (int -> for (
> 
> v8:
>     - Removed unused num_classifiers. Jason Wang
> ---
>  drivers/net/virtio_net.c | 40 +++++++++++++++++++++++++++-------------
>  1 file changed, 27 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index de1a23c71449..f392ea30f2c7 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -299,7 +299,6 @@ struct virtnet_ff {
>  	struct virtio_net_ff_cap_mask_data *ff_mask;
>  	struct virtio_net_ff_actions *ff_actions;
>  	struct xarray classifiers;
> -	int num_classifiers;
>  	struct virtnet_ethtool_ff ethtool;
>  };
>  
> @@ -6827,6 +6826,7 @@ struct virtnet_ethtool_rule {
>  /* The classifier struct must be the last field in this struct */
>  struct virtnet_classifier {
>  	size_t size;
> +	refcount_t refcount;
>  	u32 id;
>  	struct virtio_net_resource_obj_ff_classifier classifier;
>  };


BTW if you are going to use refcount_t you should include
refcount.h not rely on some other header to pull it in for you.

-- 
MST


