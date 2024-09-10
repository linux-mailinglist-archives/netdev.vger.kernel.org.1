Return-Path: <netdev+bounces-126970-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C4589736E7
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 14:12:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91D651C25474
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 12:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A280C18FDD5;
	Tue, 10 Sep 2024 12:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C+MQmLBy"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0975E1885BD
	for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 12:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725970337; cv=none; b=qSvQdYyR80V+R2AaBXXEh+FMBzSy76FjyyqT+6DRb+JJSAzTbIOqAEcLtU15u2qUXRXMlNFLqnVWYy+vzBGuXDm48azhtpnUoKMPhN7HoRTNBW1Uk+ROZYfJF+T3bbDrQydpf7qf0sa+WStmFCZOx2Uo5p9b/io2oqatRJ1XrK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725970337; c=relaxed/simple;
	bh=pBX6i4GvcaB8VT5K1Bc2rZrTRGqF+KtopvGd4NVH/UU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C0q/2LB+SrCLedgKXeHm0PV7+BVp4mlwWBPV67csntlPGLpLZwPIxtcTWvC+QyyY8mOX77dCnI6VkYZGVZPcUkmqfKC1dGwlgvc8LQWBTFN1DLufaWKCvuZ6+6oWWIR7/yZcoIyesh/DwEX7vSctcqmGtlM3QFaVp5bZOc/6Ep4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C+MQmLBy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725970334;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jxCLNeuG7VDBjUPWydTqLmY+hll6gx2EUflZYj+Ot6I=;
	b=C+MQmLByTc08t1FAfQz1RqqIH+18IS+RRlMIT6SjJiVIAxhCrsKLrPo95VQmGbseovnVtK
	bWytvwqJsyZczDqw2h+OvfQEohQi5Pb5Q/PxKw70CsuSJjF+4LwOgPJZ4wadDkrvkAivJ6
	iXh0iYEEWnEHsAViEiFcMcI0waN0Qbc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-400-Dx0a5POWOaCseld5XWLszw-1; Tue, 10 Sep 2024 08:12:13 -0400
X-MC-Unique: Dx0a5POWOaCseld5XWLszw-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-374c54e188dso3420787f8f.1
        for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 05:12:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725970332; x=1726575132;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jxCLNeuG7VDBjUPWydTqLmY+hll6gx2EUflZYj+Ot6I=;
        b=qRpIZr/pr3PsSgsh8nM2SlfHsf0PaEumANk4AgooNUE6W9c6+tXHuWH11uch6wzdD1
         RGf4Vy/AVAGJh2Tl4XuJ5hadlrUjhgVNK6bVmlujj8iKKr4DFsvXyTqZcJ0Q2TzqMR4g
         G+5oUqoAQDh0g18VYTYqMYNgqRCQUao10NgiQ7Vx+ZMQ0EOyfYxg+lqgEh6pDbkhCi+7
         bT2RVaaEzwoDbti0CKWG7aAnxNeIymoDYXsX1A8XVLDQvGnuMq2rLdK+b/yRCCShbfJ1
         3Gd8gNH47/7EBBiCKbEnDLNnXVtSkF07KYHhf9jR0zUidBx+JO3XTgWm5YBDxpqYuQlG
         yqWQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7WisnrABwxGhCFls9V6aYZlNYT4GTIhaGCDUNdtOb0ki0VEYg72o5weQFXzXd2Vxm8TC/J0s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoLPhaCcz6Ocn20utIAbNWS8OMiM3bwEerZyZfH/dJtKc2ARU9
	tHsAQ7nSP+aXcYNMAUnBJtpePU34q9W+Dzl0WjYujFvZE1Y0KVe5y2KBxaHNBRjFflYOXnCq1EN
	lnofj4GmmU1qkyVmOm6jS96MGyJrzRABJH59f8EIFQFE+Fka7ykTeug==
X-Received: by 2002:adf:e805:0:b0:378:8b56:4665 with SMTP id ffacd0b85a97d-378a8a5a250mr1813922f8f.24.1725970332099;
        Tue, 10 Sep 2024 05:12:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGmn/gKeqcT9UfHd0dzbWOJJz88lOVLahfI9N5q60XR38JEBFW338jR09cWZYWTndF5aL8i8w==
X-Received: by 2002:adf:e805:0:b0:378:8b56:4665 with SMTP id ffacd0b85a97d-378a8a5a250mr1813883f8f.24.1725970331478;
        Tue, 10 Sep 2024 05:12:11 -0700 (PDT)
Received: from redhat.com ([31.187.78.173])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3789564aef9sm8756786f8f.5.2024.09.10.05.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 05:12:10 -0700 (PDT)
Date: Tue, 10 Sep 2024 08:12:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Darren Kenny <darren.kenny@oracle.com>,
	Si-Wei Liu <si-wei.liu@oracle.com>
Subject: Re: [PATCH 0/3] Revert "virtio_net: rx enable premapped mode by
 default"
Message-ID: <20240910081147-mutt-send-email-mst@kernel.org>
References: <20240906123137.108741-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240906123137.108741-1-xuanzhuo@linux.alibaba.com>

On Fri, Sep 06, 2024 at 08:31:34PM +0800, Xuan Zhuo wrote:
> Regression: http://lore.kernel.org/all/8b20cc28-45a9-4643-8e87-ba164a540c0a@oracle.com
> 
> I still think that the patch can fix the problem, I hope Darren can re-test it
> or give me more info.
> 
>     http://lore.kernel.org/all/20240820071913.68004-1-xuanzhuo@linux.alibaba.com
> 
> If that can not work or Darren can not reply in time, Michael you can try this
> patch set.

Just making sure netdev maintainers see this, this patch is for net.

> Thanks.
> 
> Xuan Zhuo (3):
>   Revert "virtio_net: rx remove premapped failover code"
>   Revert "virtio_net: big mode skip the unmap check"
>   virtio_net: disable premapped mode by default
> 
>  drivers/net/virtio_net.c | 95 +++++++++++++++++++---------------------
>  1 file changed, 46 insertions(+), 49 deletions(-)
> 
> --
> 2.32.0.3.g01195cf9f


