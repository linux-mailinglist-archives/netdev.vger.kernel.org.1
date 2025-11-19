Return-Path: <netdev+bounces-239855-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 00041C6D364
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 08:43:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CC27D4F687C
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 07:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6B823254B4;
	Wed, 19 Nov 2025 07:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aPkBlLlD";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fe1O2NQf"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79EF43254A1
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 07:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763537824; cv=none; b=JI4936s0p48ZP/IU6HH9JZDD2bFnIFltA1RfcxbgO49G/dyGEQFgyJqzQGad9hc6dxlnMnbxel0/VCSb2amPgETx9LP0W5CHH/6TB92WdjPP6HaDwkqRPrQ/XTYENEBkNoRntFnY9MMGse+ptG4UQZ8gsuZnGUasvO3PUiyK5ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763537824; c=relaxed/simple;
	bh=cmtU4gPsNitt6wi6TsmuAXEhTT++xLKyo8o0jqXT8gI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BRQWVYJ6jxndiSP5iYAc7AL8Dc1rf6pzE9bmMUMOQjVFODbFZXg5Plaju4n/DW/2uz6k1RXTTP+pPYelFzEXaXVT4hqHGL68JaMpMe90aX+wXUb9Opc6JrdxD/RCESTIR4abPsnuG4dNjvNLGgGh1IKz4kXJ9Zy+GdYRIt1Pm8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aPkBlLlD; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fe1O2NQf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763537821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f0GO7js7Nzcb9CILh+UVwGdqet9Y6vrdD2ygmkgwObQ=;
	b=aPkBlLlDnddYqMB3KmwxyO4SVgZD4p1cyArgjcOoOOc6Ck1lWvGr3eD4nzwLOyPCJXDQNE
	lEmrQMQkjU6gZOaDSbkWaHmLrY2v55DbNj7MgusJimNMaRVDrmfJ5Y6xf+ZSTDzAv5zi+A
	OVM8XQTZ40d/DWpQS6WJS07X4XXob+w=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-rAV9HS8eM1CW1Ubddk_pag-1; Wed, 19 Nov 2025 02:36:59 -0500
X-MC-Unique: rAV9HS8eM1CW1Ubddk_pag-1
X-Mimecast-MFC-AGG-ID: rAV9HS8eM1CW1Ubddk_pag_1763537818
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-42b3086a055so4192639f8f.3
        for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 23:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763537818; x=1764142618; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=f0GO7js7Nzcb9CILh+UVwGdqet9Y6vrdD2ygmkgwObQ=;
        b=Fe1O2NQfOXKAJKkUJaviYIDr6Zu+iF8uwxxnD5o3p8FPOnoPyN3emVzROi4zLeoPSR
         SllSigJFYXXsgkc3t5ADgzyxTo7p6JmlwTe+6CBkBIbu5+PMekI7bDJ+wcvCl+PXVdaT
         I93MNc3F7jjNTuThY91ouhSGIISi7wtgJZwBrlTZewVDYry8LX4YDhl45MF9k5CZt8Oz
         osUnGLmA9lALVuHUk5uYlIkw6os9EtsjnleozhmV1ol/4HWde8rA8KWzlOYtrioNc0oK
         IMKg6OgfNnUrdHFocn0GmTpd+/vQ9wSz5FjXWOmhSDeRsUzqIYFwjufpH7NR9h2uwQWl
         rGAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763537818; x=1764142618;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f0GO7js7Nzcb9CILh+UVwGdqet9Y6vrdD2ygmkgwObQ=;
        b=E0jnKCYeUaUGHQdqNLMDeDAySIZBi/eMax8kQ5owZZAT9Dc1J+KERdRDrXel/WHiJj
         csqIduMCecYdOJN7vXEVKquTz9q0X/fuHYvX4SnY7W19wboidNTGf6V83d+f33RdLa8D
         AOuC/ta9jSz8OADkpwZowC8s5MMiU7/gnKUMszXfkyDaO7s/XHOWoHvoKAdxcRFmLqe7
         /RDPadv5KV3A+j7Nq4d7pavat3LM79UnFD8fXxxvC/geFA7GRgvyL+ddamfWHlkXDZjk
         mnApSQImBTMTjHTU0u0S7jmgVolQtxJV1wMusJ5Zb+mTHshgaVCQNPZ3qMUF4erbyV7m
         arBA==
X-Gm-Message-State: AOJu0YxEFAvKL6iuScA6bxsQUhsj89Gzgkt+eG/zztMs653vfBfGBUhU
	XhMzgXRtrptfX4R70pr7QGDvvRYd2u6pyEo/16H7Ls1uh9DoIlEo6OucOCNLjv8olHXyGymjosB
	W10KlM/Q2R4yqUUC2sDNrUsu4GKtI6FhoEnI/H03chse3Ud8KDqmlkebyTg==
X-Gm-Gg: ASbGncsj6q9/YKBVRJpR9ghXK8NksvxgEBcYrn0FaQQOdKPfUqI9+UEDpQGXWpBHkC/
	Ik5Hcg8Be6EcpgLXicTcIikVLDebE+HZAuzLo3R5PQlxYW4MhILDpNDhqyrQEzPNGMI1j4+N09k
	BJmS5SG+JQzGn6xCHYGy2CQfgtsJwrvVkLcn8PlHeX3lTz4yaGLzci6f0m9cfyj2r2cC4B9UlfB
	QAb7P8BZwopjmSbNdBd4Ef2hTMDQqZiCffuAvf9ykzaaSvca7KXK4VFPaMZfmmwTxETTQ3BS4Ij
	n675poEClbc987loV0KmGiTNuk9BBUQucFNBima30EOUnCR22q8gUBp0je0lUAveOZ+nibGPyc2
	p5+zyGaJKKhZODnJIVxp2d98k+APAuQ==
X-Received: by 2002:a05:6000:1ace:b0:429:d6dc:ae10 with SMTP id ffacd0b85a97d-42b59385bc3mr19572574f8f.29.1763537818431;
        Tue, 18 Nov 2025 23:36:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE38OxUIXqfpq4weRteGFX8sC7MBmLIWf7WZAfGxmzVD/+o9SG94zeJxoMbsiZGgOokbhQwrQ==
X-Received: by 2002:a05:6000:1ace:b0:429:d6dc:ae10 with SMTP id ffacd0b85a97d-42b59385bc3mr19572540f8f.29.1763537817915;
        Tue, 18 Nov 2025 23:36:57 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53e845bdsm35079172f8f.12.2025.11.18.23.36.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 23:36:57 -0800 (PST)
Date: Wed, 19 Nov 2025 02:36:54 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
	virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, jgg@ziepe.ca, kevin.tian@intel.com,
	kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net-next v11 02/12] virtio: Add config_op for admin
 commands
Message-ID: <20251119023455-mutt-send-email-mst@kernel.org>
References: <20251118143903.958844-1-danielj@nvidia.com>
 <20251118143903.958844-3-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251118143903.958844-3-danielj@nvidia.com>

On Tue, Nov 18, 2025 at 08:38:52AM -0600, Daniel Jurgens wrote:
> This will allow device drivers to issue administration commands.
> 
> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
> Reviewed-by: Parav Pandit <parav@nvidia.com>
> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> 
> ---
> v4: New patch for v4
> ---
>  drivers/virtio/virtio_pci_modern.c | 2 ++
>  include/linux/virtio_config.h      | 6 ++++++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
> index ff11de5b3d69..acc3f958f96a 100644
> --- a/drivers/virtio/virtio_pci_modern.c
> +++ b/drivers/virtio/virtio_pci_modern.c
> @@ -1236,6 +1236,7 @@ static const struct virtio_config_ops virtio_pci_config_nodev_ops = {
>  	.get_shm_region  = vp_get_shm_region,
>  	.disable_vq_and_reset = vp_modern_disable_vq_and_reset,
>  	.enable_vq_after_reset = vp_modern_enable_vq_after_reset,
> +	.admin_cmd_exec = vp_modern_admin_cmd_exec,
>  };
>  
>  static const struct virtio_config_ops virtio_pci_config_ops = {
> @@ -1256,6 +1257,7 @@ static const struct virtio_config_ops virtio_pci_config_ops = {
>  	.get_shm_region  = vp_get_shm_region,
>  	.disable_vq_and_reset = vp_modern_disable_vq_and_reset,
>  	.enable_vq_after_reset = vp_modern_enable_vq_after_reset,
> +	.admin_cmd_exec = vp_modern_admin_cmd_exec,
>  };
>  
>  /* the PCI probing function */
> diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
> index 16001e9f9b39..19606609254e 100644
> --- a/include/linux/virtio_config.h
> +++ b/include/linux/virtio_config.h
> @@ -108,6 +108,10 @@ struct virtqueue_info {
>   *	Returns 0 on success or error status
>   *	If disable_vq_and_reset is set, then enable_vq_after_reset must also be
>   *	set.
> + * @admin_cmd_exec: Execute an admin VQ command.

should say (optional) since only pci implements this so far
and callers check it.


> + *	vdev: the virtio_device
> + *	cmd: the command to execute
> + *	Returns 0 on success or error status
>   */
>  struct virtio_config_ops {
>  	void (*get)(struct virtio_device *vdev, unsigned offset,
> @@ -137,6 +141,8 @@ struct virtio_config_ops {
>  			       struct virtio_shm_region *region, u8 id);
>  	int (*disable_vq_and_reset)(struct virtqueue *vq);
>  	int (*enable_vq_after_reset)(struct virtqueue *vq);
> +	int (*admin_cmd_exec)(struct virtio_device *vdev,
> +			      struct virtio_admin_cmd *cmd);
>  };
>  
>  /**
> -- 
> 2.50.1


