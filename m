Return-Path: <netdev+bounces-239734-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DDFEC6BD60
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 23:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C45EE35D54C
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 22:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62AD230F535;
	Tue, 18 Nov 2025 22:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EdQ5cohC";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="dpywdD/d"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6B326FDBF
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 22:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763504105; cv=none; b=ivhc5Y12q+c6Fa9IblETCjyUNyzAZQBy+EpbQ+d8W969h1PFtat6oGvB84EdkLFDT4nnitckiljCUfx5cIdq3urNiWHuDubmRzaC72q9XWJfneL5syaYAdWQBheYv32P24wHBQnTHZdWYoYv2VVIPwqklIILC4m3k/KwN7/fumM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763504105; c=relaxed/simple;
	bh=UebwBc4wvYmdjjBpC5J+/F1JyAju4zl5Jn6Kf5bKNsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y2GbCRW4oX9rVzQRtWgMfidV6MkWNDaG7+tRvPzgsWMGfxayWZbWDOrzdz6QPeNMBtO+DoxVQYemPtcRlPlDTSGLUuhjSRoOYuVw67mjxN2NxCwvT7rZUiUHLt4lWHlcOzmvuxmlxt+hzSg87vukuWlFP0EuBxAUxHGjgZmTOj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EdQ5cohC; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=dpywdD/d; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763504102;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RcMergSwauY/1NAWI0QqhSLEWf4nuFMROFc+j9jdmGk=;
	b=EdQ5cohCsb9dXlWB22B+/1hTfrXXtWo32gA8SqprM7suq6EzslunEdZAoi/KZZ6mJ7z9mG
	ivnexE2QOWtFmrVpXsY1zilFoQM6gXiY2ALCVn5as3u8belrGlEJRcU0pTNCzNFWiPMQnY
	M+iGc11LGrKrQxz01S4NB+V6m33GscU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-fXpDHJPKN0uD-x-46LadHg-1; Tue, 18 Nov 2025 17:15:00 -0500
X-MC-Unique: fXpDHJPKN0uD-x-46LadHg-1
X-Mimecast-MFC-AGG-ID: fXpDHJPKN0uD-x-46LadHg_1763504099
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-429cce847c4so2656940f8f.2
        for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 14:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763504099; x=1764108899; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RcMergSwauY/1NAWI0QqhSLEWf4nuFMROFc+j9jdmGk=;
        b=dpywdD/dseqPpampuUuZD1yQeCbrlp/Owdj01hgU/j2pOB0ZBGF9mqddUSo+OVIS9Q
         /lb1JUnlRHlOG8U7jc5Ge9QBQjhxuHt3kSGsDpACCOYQd9mtn6ZfwEUEXyL4Yk2Tx03x
         mVQD9WZsKQMuh/u2haphPIH0YNC/nLecz3SzjCRz0tnprrXZeUT+dSdeA7JNmIO8H9jy
         tqhfUkCJG6KJg/XvArZDvcvVu+t0NN1Unl/HnXPRzOm29EyFQN+A3OUoi8hzNjsBPy/Q
         efByWF0dlv5mqA5Dbb9z2Ww6R99kTLoBlb2VmT76M3Z1hBrJI5+9FbFMbgRkyKLyHQgR
         Ij8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763504099; x=1764108899;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RcMergSwauY/1NAWI0QqhSLEWf4nuFMROFc+j9jdmGk=;
        b=WfGVZYocKv90/tjnkOhOfFcN/AUDHLWgYYDdXhecPjnUEOGCK6sFiCz3hN5kChamuS
         65yjp2x7teFn7VNxq+/Y4fqHkEXv3pcwnL0pnkXTC9mWlao3t8mcCZDUCGNPCIuEISiE
         GOtvJL4xqUdHKx6qn8x8uwr+JouBI1D5mqEp70WXrYA4xWTxDFlNNW6r3IcJiY5xilXI
         ZLwqhlauosD0SJsXsiYYWXamboGGMKNrrjx1cHpTPq1SnfzP3P/XyAnpKTewnEgsnduF
         C6NLO4YO9VrkTJ9nSd6LJkVOuP0Emro9JxehXeI7CAiH4Jmz5lxPx7lzbcC6jxgZFJ+l
         wmYQ==
X-Gm-Message-State: AOJu0YxkkBdyHxB2JAHCUGRkJrHlIBQaOv/e72xyRI3DQYTPmtFvZEM0
	Pr2E6AYY05Iv94AbZnyrKYbEbbycMJS/ZlT66V9KPN6wCn7BgdNam6RC8wdfsRRzAg7UtPdsk+2
	Z7PBtw94EEeJwxPh7elqHldZFwzbkcM8ZfujHYXy+wwN7rbmSw5Vv9iWrd96n+9yk/g==
X-Gm-Gg: ASbGncue8eiNk7Df+PkxREGjw+gWSUzicj6wser/GQNkl+2t2GNfJnLjKKrrLYALL0Y
	CtuMsqnCNyV8OWZSrGBS+chspDX7yyO3PROq+YjShi81Nufl5fHH8lVTmcTtlBZadcvE8CgMV44
	n7fJLI9TCK4PS7k6HJAtnPdgATFMQ+jtASN4cOmNeasG6KzhEsKw6uYUAmDg5kuqJ9kknhZablP
	YfcaMTJJgx8XWISxj0tj+4Phx6jifYLwkh0V0EOBAcISUdXerJlMbHzGW3u+USvOXVMqLCBPd8L
	4LUMAoWI/6w5GpvTd3vW6KxUSd3x3PjP4JcJ79FLaaf7LHLIM521SMmEPW3+7Iends/1HGb/Wg4
	m92SDCKTnY6REhdJYzPYmLlLA2ML8VQ==
X-Received: by 2002:a05:6000:1786:b0:429:bc93:9d8a with SMTP id ffacd0b85a97d-42b59367879mr15687625f8f.37.1763504098573;
        Tue, 18 Nov 2025 14:14:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFaQTHDLRGB+J4QEWont+WA6Rkw3ObVf6Z/E2y14Jl425BejksKFCL7rq5yLCNgi3wMzN8cog==
X-Received: by 2002:a05:6000:1786:b0:429:bc93:9d8a with SMTP id ffacd0b85a97d-42b59367879mr15687613f8f.37.1763504098103;
        Tue, 18 Nov 2025 14:14:58 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53e7ae98sm33856532f8f.2.2025.11.18.14.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 14:14:57 -0800 (PST)
Date: Tue, 18 Nov 2025 17:14:54 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
	virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, jgg@ziepe.ca, kevin.tian@intel.com,
	kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net-next v11 04/12] virtio: Expose object create and
 destroy API
Message-ID: <20251118171338-mutt-send-email-mst@kernel.org>
References: <20251118143903.958844-1-danielj@nvidia.com>
 <20251118143903.958844-5-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251118143903.958844-5-danielj@nvidia.com>

On Tue, Nov 18, 2025 at 08:38:54AM -0600, Daniel Jurgens wrote:
> Object create and destroy were implemented specifically for dev parts
> device objects. Create general purpose APIs for use by upper layer
> drivers.
> 
> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
> Reviewed-by: Parav Pandit <parav@nvidia.com>
> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> 
> ---
> v4: Moved this logic from virtio_pci_modern to new file
>     virtio_admin_commands.
> v5: Added missing params, and synced names in comments (Alok Tiwari)
> ---
>  drivers/virtio/virtio_admin_commands.c | 75 ++++++++++++++++++++++++++
>  include/linux/virtio_admin.h           | 44 +++++++++++++++
>  2 files changed, 119 insertions(+)
> 
> diff --git a/drivers/virtio/virtio_admin_commands.c b/drivers/virtio/virtio_admin_commands.c
> index 94751d16b3c4..2b80548ba3bc 100644
> --- a/drivers/virtio/virtio_admin_commands.c
> +++ b/drivers/virtio/virtio_admin_commands.c
> @@ -88,3 +88,78 @@ int virtio_admin_cap_set(struct virtio_device *vdev,
>  	return err;
>  }
>  EXPORT_SYMBOL_GPL(virtio_admin_cap_set);
> +
> +int virtio_admin_obj_create(struct virtio_device *vdev,
> +			    u16 obj_type,
> +			    u32 obj_id,
> +			    u16 group_type,
> +			    u64 group_member_id,
> +			    const void *obj_specific_data,
> +			    size_t obj_specific_data_size)
> +{
> +	size_t data_size = sizeof(struct virtio_admin_cmd_resource_obj_create_data);
> +	struct virtio_admin_cmd_resource_obj_create_data *obj_create_data;
> +	struct virtio_admin_cmd cmd = {};
> +	struct scatterlist data_sg;
> +	void *data;
> +	int err;
> +
> +	if (!vdev->config->admin_cmd_exec)
> +		return -EOPNOTSUPP;
> +
> +	data_size += obj_specific_data_size;
> +	data = kzalloc(data_size, GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	obj_create_data = data;
> +	obj_create_data->hdr.type = cpu_to_le16(obj_type);
> +	obj_create_data->hdr.id = cpu_to_le32(obj_id);
> +	memcpy(obj_create_data->resource_obj_specific_data, obj_specific_data,
> +	       obj_specific_data_size);
> +	sg_init_one(&data_sg, data, data_size);
> +
> +	cmd.opcode = cpu_to_le16(VIRTIO_ADMIN_CMD_RESOURCE_OBJ_CREATE);
> +	cmd.group_type = cpu_to_le16(group_type);
> +	cmd.group_member_id = cpu_to_le64(group_member_id);
> +	cmd.data_sg = &data_sg;
> +
> +	err = vdev->config->admin_cmd_exec(vdev, &cmd);
> +	kfree(data);
> +
> +	return err;
> +}
> +EXPORT_SYMBOL_GPL(virtio_admin_obj_create);
> +
> +int virtio_admin_obj_destroy(struct virtio_device *vdev,
> +			     u16 obj_type,
> +			     u32 obj_id,
> +			     u16 group_type,
> +			     u64 group_member_id)

what's the point of making it int when none of the callers
check the return type?

> +{
> +	struct virtio_admin_cmd_resource_obj_cmd_hdr *data;
> +	struct virtio_admin_cmd cmd = {};
> +	struct scatterlist data_sg;
> +	int err;
> +
> +	if (!vdev->config->admin_cmd_exec)
> +		return -EOPNOTSUPP;
> +
> +	data = kzalloc(sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	data->type = cpu_to_le16(obj_type);
> +	data->id = cpu_to_le32(obj_id);
> +	sg_init_one(&data_sg, data, sizeof(*data));
> +	cmd.opcode = cpu_to_le16(VIRTIO_ADMIN_CMD_RESOURCE_OBJ_DESTROY);
> +	cmd.group_type = cpu_to_le16(group_type);
> +	cmd.group_member_id = cpu_to_le64(group_member_id);
> +	cmd.data_sg = &data_sg;
> +
> +	err = vdev->config->admin_cmd_exec(vdev, &cmd);
> +	kfree(data);
> +
> +	return err;
> +}
> +EXPORT_SYMBOL_GPL(virtio_admin_obj_destroy);
> diff --git a/include/linux/virtio_admin.h b/include/linux/virtio_admin.h
> index 36df97b6487a..039b996f73ec 100644
> --- a/include/linux/virtio_admin.h
> +++ b/include/linux/virtio_admin.h
> @@ -77,4 +77,48 @@ int virtio_admin_cap_set(struct virtio_device *vdev,
>  			 const void *caps,
>  			 size_t cap_size);
>  
> +/**
> + * virtio_admin_obj_create - Create an object on a virtio device
> + * @vdev: the virtio device
> + * @obj_type: type of object to create
> + * @obj_id: ID for the new object
> + * @group_type: administrative group type for the operation
> + * @group_member_id: member identifier within the administrative group
> + * @obj_specific_data: object-specific data for creation
> + * @obj_specific_data_size: size of the object-specific data in bytes
> + *
> + * Creates a new object on the virtio device with the specified type and ID.
> + * The object may require object-specific data for proper initialization.
> + *
> + * Return: 0 on success, -EOPNOTSUPP if the device doesn't support admin
> + * operations or object creation, or a negative error code on other failures.
> + */
> +int virtio_admin_obj_create(struct virtio_device *vdev,
> +			    u16 obj_type,
> +			    u32 obj_id,
> +			    u16 group_type,
> +			    u64 group_member_id,
> +			    const void *obj_specific_data,
> +			    size_t obj_specific_data_size);
> +
> +/**
> + * virtio_admin_obj_destroy - Destroy an object on a virtio device
> + * @vdev: the virtio device
> + * @obj_type: type of object to destroy
> + * @obj_id: ID of the object to destroy
> + * @group_type: administrative group type for the operation
> + * @group_member_id: member identifier within the administrative group
> + *
> + * Destroys an existing object on the virtio device with the specified type
> + * and ID.
> + *
> + * Return: 0 on success, -EOPNOTSUPP if the device doesn't support admin
> + * operations or object destruction, or a negative error code on other failures.
> + */
> +int virtio_admin_obj_destroy(struct virtio_device *vdev,
> +			     u16 obj_type,
> +			     u32 obj_id,
> +			     u16 group_type,
> +			     u64 group_member_id);
> +
>  #endif /* _LINUX_VIRTIO_ADMIN_H */
> -- 
> 2.50.1


