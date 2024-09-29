Return-Path: <netdev+bounces-130243-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D12DB989657
	for <lists+netdev@lfdr.de>; Sun, 29 Sep 2024 18:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E18941C211AE
	for <lists+netdev@lfdr.de>; Sun, 29 Sep 2024 16:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9DA417E019;
	Sun, 29 Sep 2024 16:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gvxRlCpN"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6EEF79FD
	for <netdev@vger.kernel.org>; Sun, 29 Sep 2024 16:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727628981; cv=none; b=tQXVXzLaQtD4V3B2qQM5TxSPoObIYQa/tGWlomBxhq80e4ej7BxyxoI9Pi4z9KnB0jkRTGLw6R6gIZMdxK5bDRdz2krjpRRy3U7kwrLiFH1Wi9ZwSbEBcC6H8WgNF/Gfvzx8+N0Eq/GQadw1doLKWDMWsZlQNSQooupjT0NBQCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727628981; c=relaxed/simple;
	bh=OuNHc8PIGaHQxuUXtKbA+OFDsOJlQHplpqTyjl6z6CQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VR4poFSkdoQaHR01TnV49cyfUKYbENht2K9UOwVH6Fm1injqooFMFTg0yMVZDDFb7yjBN1wsSZ02kUvNBR2OmkI2QTfB9wLtTQFhmTfb3cVK2tT2PIw9l2yf94XM/3v5oxsYAh3bwL5JAnjwQkjmLR6P7E5Hld19VfxG9cRcQ/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gvxRlCpN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727628977;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kqpozjXyhnvHlQRJu2I4WgyAmmMM5tqK0NqWHw3trQE=;
	b=gvxRlCpNpVZ/2muNJIXrtsPCkMWrzb0f30fzbR6/QAs9BVlLOBxh6MB9msoNcLkA6O5FEl
	acTAM6+5T9oTtivrfqQ6frPcHqzAORtKbbsOXF6zLFEjZxMA0PDbQeHLj0bWIsW0GCpn+U
	htMEbr3JngO63MMUVAJ+le02n3f2AoM=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-299-doUQnSjBMOqorRBNdJdMpw-1; Sun, 29 Sep 2024 12:56:16 -0400
X-MC-Unique: doUQnSjBMOqorRBNdJdMpw-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a8ff95023b6so291967166b.3
        for <netdev@vger.kernel.org>; Sun, 29 Sep 2024 09:56:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727628975; x=1728233775;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kqpozjXyhnvHlQRJu2I4WgyAmmMM5tqK0NqWHw3trQE=;
        b=lP1U/pYLtMUFYBLrGudtlJidxuR6WjJXAiMnZDbb9plcwifIgBpyBA8RqXzpP1S6CJ
         4duxgEBOrlTvBQysJEMJck+KGctfbLZZjsZfjAST9l4hX3t+7252icprjrwnX5XYhsYP
         /aUOlx6UsXxbSid8ZMXQVaRkWcq/fC5Mjbok5dlRVo9zLKRoAOtMV0be3qidEAtRvy09
         Tanb1T919Z6/sNKVMc5WtasjnAVnnFcl1dzqeu8W8XSQgbZ6qxQNk+24bKLFzScOZsIg
         pmpGfbuGFRVjETAhNVTI7L+XWr9O4Bk8ihYW/b1/8RQ2NGnqlje9VnUdTzi6Lga4Kt6j
         4Yqw==
X-Forwarded-Encrypted: i=1; AJvYcCXKQJzaqwSQQBpGFpuAuSLIlIdGmW8ceqESFfGULEg37TrfIz/dKCzIqjZBsFL0oAUYpJhF1bw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4hMuSOW3a6TOxa11HLK0s3k8XluoXH4kDL5qWPvBVLyw1TliJ
	idRnb4BofkSNtJ4KZjq/QcrPbzTkcXAskZbFd0wb2QZPxotB4EF5mkYPDy4+8wT6alk1x4fSG9D
	zGiQFVzqxNQIGfZhCLD2skzbMFAPeSRel0dHefubbqhtp837ZCFNDxg==
X-Received: by 2002:a17:907:3eaa:b0:a8a:9054:8391 with SMTP id a640c23a62f3a-a93c48f8884mr1026229066b.5.1727628975220;
        Sun, 29 Sep 2024 09:56:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEBabYhMMakXtMQtZ10IYuTuTjIcGwfv1lKDLcZNtfQ8gg556HasAqswG+Wg0TAOWoqjInzRQ==
X-Received: by 2002:a17:907:3eaa:b0:a8a:9054:8391 with SMTP id a640c23a62f3a-a93c48f8884mr1026226866b.5.1727628974679;
        Sun, 29 Sep 2024 09:56:14 -0700 (PDT)
Received: from redhat.com ([2a02:14f:17b:822e:847c:4023:a734:1389])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c2775995sm398955366b.41.2024.09.29.09.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2024 09:56:13 -0700 (PDT)
Date: Sun, 29 Sep 2024 12:56:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc: stefanha@redhat.com, Stefano Garzarella <sgarzare@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	kvm@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vhost/vsock: specify module version
Message-ID: <20240929125245-mutt-send-email-mst@kernel.org>
References: <20240926161641.189193-1-aleksandr.mikhalitsyn@canonical.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240926161641.189193-1-aleksandr.mikhalitsyn@canonical.com>

On Thu, Sep 26, 2024 at 06:16:40PM +0200, Alexander Mikhalitsyn wrote:
> Add an explicit MODULE_VERSION("0.0.1") specification
> for a vhost_vsock module. It is useful because it allows
> userspace to check if vhost_vsock is there when it is
> configured as a built-in.
> 
> Without this change, there is no /sys/module/vhost_vsock directory.
> 
> With this change:
> $ ls -la /sys/module/vhost_vsock/
> total 0
> drwxr-xr-x   2 root root    0 Sep 26 15:59 .
> drwxr-xr-x 100 root root    0 Sep 26 15:59 ..
> --w-------   1 root root 4096 Sep 26 15:59 uevent
> -r--r--r--   1 root root 4096 Sep 26 15:59 version
> 
> Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>


Why not check that the misc device is registered?
I'd rather not add a new UAPI until actually necessary.

> ---
>  drivers/vhost/vsock.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> index 802153e23073..287ea8e480b5 100644
> --- a/drivers/vhost/vsock.c
> +++ b/drivers/vhost/vsock.c
> @@ -956,6 +956,7 @@ static void __exit vhost_vsock_exit(void)
>  
>  module_init(vhost_vsock_init);
>  module_exit(vhost_vsock_exit);
> +MODULE_VERSION("0.0.1");
>  MODULE_LICENSE("GPL v2");
>  MODULE_AUTHOR("Asias He");
>  MODULE_DESCRIPTION("vhost transport for vsock ");
> -- 
> 2.34.1


