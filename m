Return-Path: <netdev+bounces-105064-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D8BF90F867
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 23:19:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FDE41C20C80
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 21:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F38717C6EB;
	Wed, 19 Jun 2024 21:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZJQPZkB3"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D245433B9
	for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 21:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718831964; cv=none; b=EDF5VRIekCSeG0w1DT28dN6/OcpGtwK3BfAfkfWu3bTEOoVu8kHi4qg/QILdTeqlrJxLHstZUqFWV6MEb7WB7F6tiCiO+3oELs8wLYL07hNYCWH8VSVKxecwgkAS/dWynrU2G5tEqOIgV0pu6xMZbgvQgE3LROpzUgT5Fqf+zrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718831964; c=relaxed/simple;
	bh=1Ce8gcRoTKYSWpgEWUBkg5anrDwkybwW1A6fHT7RRIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d8ew5kcZVVQim6lizChAPi/5iIJAYYD+qvsEhMiXfIWjz/8srmznqInep6kuSYqzQlSN24Euk8D1TaD2PeDj9+7pmz45FpLXXJkitamBQAiZ6HU+CV89vVBqL0OQwEZupxTDSINp6XmWv37SMK5h7KjfQsErsDqbeYpeWx5z7Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZJQPZkB3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718831962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pyA5CudA7O0PgaW118fS8b02IgMtRvyv3vvcJOCw90A=;
	b=ZJQPZkB3hWEBulARQQpQBWXP+qzqpy3dlN1knLhrnu3iUL/rg26nmR/rYazx6e49b9bhsS
	F7HjmpliL2xfhtCWzS0BAjgN5MWkqU4Ad7A7EqlvgJ0P7OqPO60HL/XLRj+bJoAPEeCLcx
	LaDNAYaCLaTbQa6hchxrOyL6UBPw8cM=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-522-ycwh1UpRPmKv-WFhf4d3Rg-1; Wed, 19 Jun 2024 17:19:20 -0400
X-MC-Unique: ycwh1UpRPmKv-WFhf4d3Rg-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a6f381ea95dso24078566b.0
        for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 14:19:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718831959; x=1719436759;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pyA5CudA7O0PgaW118fS8b02IgMtRvyv3vvcJOCw90A=;
        b=CllwH1xPnm04Cw4Q/DV5xnSi4tXxSZ2g2Ymy30WwTJ/P9NFzwJYoMoXzpkmt7M4Vdq
         uWsX+v9H/R8kvG9fkwBpKU5kbjxNBSFj4rxV7w6yAdQMCFGuXaROKhPs7gHGmL/YeH89
         r1+C3DM1Bkfw/Biiv8JptNk4EjLkYuJIk+ICIM998mkMRKTJkdVn5r6w3lsyTQoM8wD6
         G4STqYC+wmBo6/3VG+yrPbQ1bKA1uhAxdIy1CI2rBl5YSCorJIOLGvrSuS6OZebKW4z+
         sV2KKoP4A+q8vo43RBgxTZRlzHxd39ME4vNan+cla2iH3dquRoGlv9DcpwiqlZWJFPNW
         QRaQ==
X-Gm-Message-State: AOJu0YzUIF5bezqbwJhZR83LKjWT0bA7HImISis/QfCNtw0u5AF8zbhv
	GwxLmNXbQg/W+uUgIkpgaXzV5t8JU8H1lyZ/j/QBJToKvn1FWxo7tI8VxFkDjzGyeuQ1dBd8D/D
	dreHTX5wga7aMdRt9BBstlr8LQeroAVABBnkRjvnQXWn2Nx0n9U7uLQ==
X-Received: by 2002:a17:907:d042:b0:a6f:9550:c0ee with SMTP id a640c23a62f3a-a6fa430f3f1mr279054566b.18.1718831959626;
        Wed, 19 Jun 2024 14:19:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsWpQfosd6XLXCX0/v81p8K+m9L7egl97NzLkFQEGBLzQrVHcJPuTz69VY7zbV8VWIpHPdFQ==
X-Received: by 2002:a17:907:d042:b0:a6f:9550:c0ee with SMTP id a640c23a62f3a-a6fa430f3f1mr279053166b.18.1718831959121;
        Wed, 19 Jun 2024 14:19:19 -0700 (PDT)
Received: from redhat.com ([2.52.146.100])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f6ac22e57sm562749866b.177.2024.06.19.14.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 14:19:18 -0700 (PDT)
Date: Wed, 19 Jun 2024 17:19:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v4 2/5] virtio_net: enable irq for the control vq
Message-ID: <20240619171708-mutt-send-email-mst@kernel.org>
References: <20240619161908.82348-1-hengqi@linux.alibaba.com>
 <20240619161908.82348-3-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240619161908.82348-3-hengqi@linux.alibaba.com>

On Thu, Jun 20, 2024 at 12:19:05AM +0800, Heng Qi wrote:
> @@ -5312,7 +5315,7 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
>  
>  	/* Parameters for control virtqueue, if any */
>  	if (vi->has_cvq) {
> -		callbacks[total_vqs - 1] = NULL;
> +		callbacks[total_vqs - 1] = virtnet_cvq_done;
>  		names[total_vqs - 1] = "control";
>  	}
>  

If the # of MSIX vectors is exactly for data path VQs,
this will cause irq sharing between VQs which will degrade
performance significantly.

So no, you can not just do it unconditionally.

The correct fix probably requires virtio core/API extensions.

-- 
MST


