Return-Path: <netdev+bounces-239896-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A6EAEC6DBF8
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 10:35:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AFD374FE344
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 09:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E9133B6F4;
	Wed, 19 Nov 2025 09:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MxjfQvnP";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="o9dymNem"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFCF30648A
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 09:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763543932; cv=none; b=me230yZkQiQP8qjZt6sUvbXQhqKgn/FcRnyqLPawKrddxUeKzxTTCbZ/zpHIhfILYI8q0CZqf38edAegZuNOaJyxLAWCpI5ADQI0mTwIL2GwkjB8nuIxdNAVzzCabzUVSEwYWUsHLZSyxuLGbojXs3UmjWX4s/9j3c2f2CASvaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763543932; c=relaxed/simple;
	bh=eD8SrHrMaadYG50GIhGP1OcsE+eBdPe4buzRGFAm4Zs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nGpJ+YYRwYnihBkWmzNvx58SM0QlY+Md8ZdkGxFKPduKezQnpoVDCTA3c9gC3vHwlKjoGrSMRx2Oo2xSfa8swA59BXbBxVfYTSWGxF/Zhz7rP2vXjSSa9m2MEHCeTOPlaN3eyKF8um5gjVoXVseTbIRmR6L2HxrGbj1+JUZm/JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MxjfQvnP; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=o9dymNem; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763543929;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ykiTizCFtTIndhsPVLB6d9JwBV5HvA0v8sThcwbCDCw=;
	b=MxjfQvnPXxgNE57CwPZdPElKNPOUlxRfynN2/WE1opOTLUKP/UOukVxSg+9g5LSwBL0L+L
	WaLQZwZgdCQXS2N2xEvqp9GzhopRwsen6XctsW5ETjl2OSF8qZjovw8Cw0eLywHrF2ZfEJ
	8VAmapTHfwASCXt1q/svkqdjTrWitjE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-272-ACiNhPqFP5e6Vs_Qa5r7qQ-1; Wed, 19 Nov 2025 04:18:48 -0500
X-MC-Unique: ACiNhPqFP5e6Vs_Qa5r7qQ-1
X-Mimecast-MFC-AGG-ID: ACiNhPqFP5e6Vs_Qa5r7qQ_1763543927
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4779c35a66bso26444065e9.2
        for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 01:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763543927; x=1764148727; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ykiTizCFtTIndhsPVLB6d9JwBV5HvA0v8sThcwbCDCw=;
        b=o9dymNemXkUAy8qAt/QbRSTGJ56reFTc46qUL1xwY6uVDSGsFveNRFAKuEIlSFeie+
         adC2i0vsOoMAYOrK/9jcuGRGHBHO6LYiM+D+XIW16rYaDZC9JgBgm+cpEGhaA1E3KcCZ
         lUiKwjqUl5ePxhbL3qq3uPyJ96k6/RqfRzuDLBXTA4qp5grrriOsSANxv9lTnFom8INj
         Vrl8gbVswSch7G7nya8EntTfxgDximqb3G5ykAG5yFkyRuNxCWbcl+FCpbbS0e5IUdUA
         O6gLcxXcX+9+XVZArAzwhTo+wjQmCF9Ny2NAfG6YgVTWXPHPMwZEYoOhd/gWfkycnfdn
         LmZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763543927; x=1764148727;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ykiTizCFtTIndhsPVLB6d9JwBV5HvA0v8sThcwbCDCw=;
        b=H49/nUeSpHfgL63jpDIDqFU5+7YURWgfMHMCm7MGBE3rxy2no0fGtFvCVy2CHAULYB
         MnzGBamu3RMKKS+uqPRiwb8N8pUn8RQgc3TAai9Vhudh1kHVeeKZzPok9DXoDjrK5Ecs
         K/EgHRSfy20MEfE88LV1wEAyFaZBD/imBARlVGl7sI7zW9fk+98I8C0brxl0htsV2Cel
         j2hIm7h+fGsw9KF3InSApk4klTiNgRBUJe2GOiNLt90ZlySlnWXhnUPn2OuBmu0++KPb
         mfWhQzc7AKqZbaWVnIYWQWGh+x+aaErs8hbAuo54kDBMngM9OzZlwBoBdHr6yONJFhmv
         xmxQ==
X-Gm-Message-State: AOJu0YyAnrHYcA811TdsFDrqpSQ9g9+PVOCXTV3gaANB5cYu/ZHrdtCD
	oiwGWZNNDcAUdzhrh8KmTF5AhJHYA7doAGYQGkTLxUDj6ydU4ZKR7v5Kv/8pxXpwoLGU2X77vKw
	YGzZK1ATzWjDaBmydnYMwXMPF+7WNMp8zNx5Y3lWvHLOYDIMfVyZxPx7S/w==
X-Gm-Gg: ASbGncv/w0zI6w+f63ymbmOLxdAJrba/kTzbD7cw/1fhfWFqxNm/HqC0dijdAA/Ej/h
	4JSzSIP30GYpJsdqVtHGNUw0L8y6pRfYtAdQ2PlWIpU+hO8ydNAshAF6uHan14zUwnd9FjSG0Rc
	t9VEhUPkVDwwVRbgL0hm5QwhQ0E9lMKzO0zlZmtwFeXdIkgHffLEnKbzU01qVP2taH8P/4H7dcx
	iDz+HaURe8VmEY6efnOEIqYPU7Ic9XWjXIx8b+NrT3PQZzddrTbYPb8CrLPOVDRSMMEaI53tQ34
	B628nzir3ANnp6vXlQr9qBo/+K8UlYehjv2cc0udLOYOwbpQF6iu9c/QipcPfJU20W+bgHnfelz
	6pdshuyP8HlGV1xKkqUk8+BRrWVVheQ==
X-Received: by 2002:a05:600c:c48f:b0:477:7b16:5f80 with SMTP id 5b1f17b1804b1-4778fe49c0bmr188982535e9.10.1763543926582;
        Wed, 19 Nov 2025 01:18:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFJ0kf7jlIDNUdvm7TX8LR8Op1tEhe9CwD+MgXbg7FzSdj44TfR1SeRP2n+wUWlmPpEYHNLLQ==
X-Received: by 2002:a05:600c:c48f:b0:477:7b16:5f80 with SMTP id 5b1f17b1804b1-4778fe49c0bmr188982255e9.10.1763543926189;
        Wed, 19 Nov 2025 01:18:46 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53e91f2dsm37899071f8f.19.2025.11.19.01.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 01:18:45 -0800 (PST)
Date: Wed, 19 Nov 2025 04:18:42 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
	virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, jgg@ziepe.ca, kevin.tian@intel.com,
	kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net-next v11 09/12] virtio_net: Implement IPv4 ethtool
 flow rules
Message-ID: <20251119041745-mutt-send-email-mst@kernel.org>
References: <20251118143903.958844-1-danielj@nvidia.com>
 <20251118143903.958844-10-danielj@nvidia.com>
 <20251118161734-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251118161734-mutt-send-email-mst@kernel.org>

On Tue, Nov 18, 2025 at 04:31:09PM -0500, Michael S. Tsirkin wrote:
> > +static int setup_ip_key_mask(struct virtio_net_ff_selector *selector,
> > +			     u8 *key,
> > +			     const struct ethtool_rx_flow_spec *fs)
> > +{
> > +	struct iphdr *v4_m = (struct iphdr *)&selector->mask;
> > +	struct iphdr *v4_k = (struct iphdr *)key;
> > +
> > +	selector->type = VIRTIO_NET_FF_MASK_TYPE_IPV4;
> > +	selector->length = sizeof(struct iphdr);
> > +
> > +	if (fs->h_u.usr_ip4_spec.l4_4_bytes ||
> > +	    fs->h_u.usr_ip4_spec.tos ||
> > +	    fs->h_u.usr_ip4_spec.ip_ver != ETH_RX_NFC_IP4)
> > +		return -EOPNOTSUPP;
> 
> So include/uapi/linux/ethtool.h says:
> 
>  * struct ethtool_usrip4_spec - general flow specification for IPv4
>  * @ip4src: Source host
>  * @ip4dst: Destination host
>  * @l4_4_bytes: First 4 bytes of transport (layer 4) header
>  * @tos: Type-of-service
>  * @ip_ver: Value must be %ETH_RX_NFC_IP4; mask must be 0
>  * @proto: Transport protocol number; mask must be 0
> 
> I guess this ETH_RX_NFC_IP4 check validates that userspace follows this
> documentation? But then shouldn't you check the mask
> as well? and mask for proto?
> 
> 
> 

in fact, what if e.g. tos is 0 but mask is non-zero? should not
this be rejected, too?


