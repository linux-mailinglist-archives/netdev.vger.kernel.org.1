Return-Path: <netdev+bounces-118342-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C8099514EC
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 09:01:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F4B51C24F7E
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 07:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A781913A3F7;
	Wed, 14 Aug 2024 07:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SqvL1tO2"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276494430
	for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 07:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723618815; cv=none; b=nxQIW3jb/ESXlN93tbOK8drtPfk2Su/iDzVVREcsxQGN7rdC2dBaPFSVrO7ZC0hei6ZU3Le6lVzmGC8zFro9UXl6bD2Mz8a/jcHasdyQzxhqIv9YZg3D2qRyppZGuXJByjqF8mOc8440VIMvhEhxFTp70yau5SGUas5bvVyFSow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723618815; c=relaxed/simple;
	bh=P07S/sz++xvSKCCgINNJ4f7IaTa3C8tbQxkg3d0eXV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iZGe/uK8H2uffo+2nqj4b7YkiKFS8L+vYViauJiqFUHK9Bq2meN6LqnM7tx3EpKp97YoaHmVRLAHb/VV/2UUbwMTt9rNVyNAOIw5iwWbmDxXyXOIPZ/1QCEj3BhAAS8++cNzTsVD56mFmvTqkqClMbP5sR6q3ftk/MYKjuBqaYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SqvL1tO2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723618813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KbworbXyEObZ56AD2569t8EG6Xuo9H5MtG4Kac2AzcI=;
	b=SqvL1tO2MuumoOGktvNj0HetZ0uFf0wN6k0GpD5zf6DL9nikRSDoVjmjjtSuz8Av21qdVN
	xKx8mmL51xfoi/YwTsXSca24f2G4JBZoTeUeFvhl0OpFig0PimInc/wDC0qJK3t4n3ted6
	AuyBzM9k2+cG1xLWtrM1h3jU5sje2Io=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-491-FFbbHfPVPbKRVe0Fa1i_OA-1; Wed, 14 Aug 2024 03:00:10 -0400
X-MC-Unique: FFbbHfPVPbKRVe0Fa1i_OA-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-53214baf2aaso2093497e87.2
        for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 00:00:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723618808; x=1724223608;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KbworbXyEObZ56AD2569t8EG6Xuo9H5MtG4Kac2AzcI=;
        b=FDV+q6B7GgQfziHT8VmNxvhrjMxp4d13tb+RudPI4zPIR3zVPOrZCw4DjGhy1G87+O
         6IiJcUfqL5qMGlGMZkpK2KJsH7YiLPAV8r19YXti4/9xI7hidJwRH9Z6ChiNiL4Hxg+7
         oDZfmXL6L4TvEtbaWTfglnvVx0Sz9GI9qWyE1UkVz7MxAmTvgrbML5ENff117OSHRK6D
         8ewKf9m0bcdsCqoEPdOmzU8Gu8lVYiJIkmMwPdTzQG8uXr9BM6FPUnBpHV/JdYsnETSn
         agTTqnb2gC8RhDfwmi2KshvrdG2FLHN8sJF/i1jqXPt0/rFiSrpVZUEm6eZvpT6SHv+u
         Nc+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXnFD3TEe4X1xAkKByrVjPUNcQisAwtjmFnTMRTGS4QaHTlTirmQOmUF0Xhcf4NuRz3RxBWXJBIJRwhHERoxN+WXvmX3G0d
X-Gm-Message-State: AOJu0YwHgw1Slgcasr6zxxME03PM5Z+3LXsyx1plzSDPMdhXGUz0YvW+
	P/m3Vt75YL7pel7oGGpLouiNfj0uqJJTrH5zlInV+HDGKrAnWaZ/ihVq9nFZ0kajLTtul3OIuKW
	186wDDpb3LpgWyg3nfsY9sphwtcbV7vuXHmqWtI4j28PEA3B7xQUkGA==
X-Received: by 2002:a05:6512:3191:b0:52c:a20e:4da4 with SMTP id 2adb3069b0e04-532edbc05f7mr1408765e87.57.1723618808510;
        Wed, 14 Aug 2024 00:00:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFsgPLZfbEeDzMU1Cf2AWqexIhDGUtlzIFV4zWpd7PEPzd/Fad6OXEe36f7DkG6dU3SfVJrrA==
X-Received: by 2002:a05:6512:3191:b0:52c:a20e:4da4 with SMTP id 2adb3069b0e04-532edbc05f7mr1408709e87.57.1723618807737;
        Wed, 14 Aug 2024 00:00:07 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:346:dcde:9c09:aa95:551d:d374])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80f3fa69cesm137227766b.57.2024.08.14.00.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 00:00:07 -0700 (PDT)
Date: Wed, 14 Aug 2024 03:00:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Si-Wei Liu <si-wei.liu@oracle.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org,
	Jason Wang <jasowang@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev,
	Darren Kenny <darren.kenny@oracle.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: Re: [PATCH net-next v5 1/4] virtio_ring: enable premapped mode
 whatever use_dma_api
Message-ID: <20240814025926-mutt-send-email-mst@kernel.org>
References: <20240511031404.30903-1-xuanzhuo@linux.alibaba.com>
 <20240511031404.30903-2-xuanzhuo@linux.alibaba.com>
 <8b20cc28-45a9-4643-8e87-ba164a540c0a@oracle.com>
 <20240813154458-mutt-send-email-mst@kernel.org>
 <3a6bc28d-dc53-430f-b308-b639276bdc39@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3a6bc28d-dc53-430f-b308-b639276bdc39@oracle.com>

On Tue, Aug 13, 2024 at 08:39:53PM -0700, Si-Wei Liu wrote:
> Hi Michael,
> 
> I'll look for someone else from Oracle to help you on this, as the relevant
> team already did verify internally that reverting all 4 patches from this
> series could help address the regression. Just reverting one single commit
> won't help.
> 
>   9719f039d328 virtio_net: remove the misleading comment
>   defd28aa5acb virtio_net: rx remove premapped failover code
>   a377ae542d8d virtio_net: big mode skip the unmap check
>   f9dac92ba908 virtio_ring: enable premapped mode whatever use_dma_api
> 
> In case I fail to get someone to help, could you work with Darren (cc'ed)
> directly? He could reach out to the corresponding team in Oracle to help
> with testing.
> 
> Thanks,
> -Siwei
> 

OK, I posted an untested revert for your testing:

Message-ID: <20240511031404.30903-1-xuanzhuo@linux.alibaba.com>



> On 8/13/2024 12:46 PM, Michael S. Tsirkin wrote:
> > Want to post a patchset to revert?
> > 


