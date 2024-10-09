Return-Path: <netdev+bounces-133576-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A95E99656C
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 11:31:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8992928196B
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 09:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E83190497;
	Wed,  9 Oct 2024 09:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SYGRcJEC"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C48919006A
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 09:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728466185; cv=none; b=PjXtYr2YdLts4ifz10deKPWDnva36K1UOFsG9Kevw2TXv4aGn/OG1E1q8NmxsXX5T+iauoTxgM04zmZjei+Jb8+S5IZS4uD/Y3cp4OE7RIWCQmXK0jP4PSiEIpqBq5nSpFJ9y2/q2ohDwrMdTI+6cP3mwpzw6BF1OCe+lU98ReE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728466185; c=relaxed/simple;
	bh=jv4yr89ODSW3N4ld/yynLf7Urvvt49R+EFqjpMQbhU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CXba8AYo5ySV0Mblvu5A2DKZovZBnXVO5FDgsuoSleBPaxp8EmSBZUYaKj45WXIHr6/vimZWUPS8wJK08PaJfwMMOpCNf0kepaiAeBgUaOjOAaypGfx4v6JtdTV5SkH3PEp0zcbTzDh+hgbDXiRFPQ4J2Q9PNCAm4PzyTdlrqXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SYGRcJEC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728466182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S8lB9GVRxRia3sQO6QFobcvy8nr5iOlkWYV84jG88n8=;
	b=SYGRcJECkXreGiq7lRA43/DSLdfSNNDcFW8vDtSDghc/EhOB/Ydw0L3gWqUc5+CiDRYV/r
	Low/1/c9svuVP5/L+99+M+Mvad9h8wG2Ix8ZZqZhw/18K1uEOyu+YBnaNR2iyFu1vqDM+V
	YuQ9liBaHYOlAGeOzu//gL7Nz2p9V2s=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-314-VXGMQa7IMa2gKpyzSO5rcQ-1; Wed, 09 Oct 2024 05:29:41 -0400
X-MC-Unique: VXGMQa7IMa2gKpyzSO5rcQ-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-37d325e2b47so729896f8f.1
        for <netdev@vger.kernel.org>; Wed, 09 Oct 2024 02:29:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728466180; x=1729070980;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S8lB9GVRxRia3sQO6QFobcvy8nr5iOlkWYV84jG88n8=;
        b=TSYPtYObV2HCujomuaPDNTtItoB0Gm5/d/VXkEsSRd/jA0YUSUZy3+4lyvHkBHJ9vp
         ogNr/JnXulT/IZCQJWyc9aZr7nO9mkavRX3Ow4pn3wJdFuaEerJGmLatvrdNL02jQSE5
         dNq/5tBWSE9bwjZitO9/yDYP3ajSeR9qYn1nWcmVkiTYsxTQUPASclte2Vn55Mab2Gcf
         QYkWVTVnQfzGgP/dIJC1ftGE0Zc4rJhdcgU40tziD44H2loeHRVWqaDBptjM/TB+xYWQ
         Z2g58LQc0U4n04CXjj0YbevwqhQCrnyV2dWitysoC9kLi1hs7fey69VjjM2l4fQ9X4q3
         fhvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUisIefL0CBIMqEC04hcQMvTwvvUVGZdWtI86t0Z3UVIBgDywu9MXNTZ+jpjpk0BguagdhvrNI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtXrZqm/sDBvCw0Uk4SAYo6HmjdbyguMYSxl9jvAHTJVr2KYQm
	Bubsk0tgIOg83Ah4p38YHtHzNhuMLfODCsP8FuMZJLBZ++5et4R7KYuaWSjtTnz7v1YjitzhI8f
	Rj0MK6M3dfX4OJaxOHUXYyxLQuuJaQ052sxu3MtPQmNRQHL8gHuTVBA==
X-Received: by 2002:adf:e652:0:b0:374:c8cc:1bb1 with SMTP id ffacd0b85a97d-37d3ab30fefmr994188f8f.39.1728466180292;
        Wed, 09 Oct 2024 02:29:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbh/uRYFnr/6tynUNs9C7u8f52PxXdACVOsZocGPPTKpy2x5pkgDOD0J6lJtVLs9VBFm3e7g==
X-Received: by 2002:adf:e652:0:b0:374:c8cc:1bb1 with SMTP id ffacd0b85a97d-37d3ab30fefmr994176f8f.39.1728466179933;
        Wed, 09 Oct 2024 02:29:39 -0700 (PDT)
Received: from redhat.com ([2a02:14f:17d:fb13:fd72:22f:64e2:b824])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d16920195sm9900451f8f.50.2024.10.09.02.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 02:29:39 -0700 (PDT)
Date: Wed, 9 Oct 2024 05:29:35 -0400
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
Message-ID: <20241009052843-mutt-send-email-mst@kernel.org>
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
> 
> Thanks.

It's been a month - were you going to post patches fixing bugs in premap
and then re-enabling this?

Thanks!


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
> 


