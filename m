Return-Path: <netdev+bounces-135045-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E8FF99BF3F
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 06:57:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A228282E78
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 04:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A895FB8D;
	Mon, 14 Oct 2024 04:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gJizudvS"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870414A1C
	for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 04:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728881874; cv=none; b=Ku1xfMad+ROfvW+wezwUKABGB/qKMZbwzN1p8MlCyQXJaFR7mdDjhcT/zDYcEvlBOo7Q4G+wM0ATAF7vkna70rQ0T3yBwbJAy2p3vHDBVJQ97trwnwidIgjDhMvKSdU3wvdPClfpf5FmFtDTsUTwLQe8Txl+aAapJTd+McfwpRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728881874; c=relaxed/simple;
	bh=XTX+OYWTvegQz4+v0ZFkHfZzljt0DOpIst10jFFEJps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A0BicaJuXNjXg6uQcoL4DSipvNMLV0oLM+RcwrwQv30M9xCMHwOnDJMi6WMmP6kcSH0FpuBo/5kEGLE9d0kX0dEOZaG6NU5Rsh4VN7D3JXJgX22k2frQrfbhyTFa0itO14XtQ4gIS0OLZaRxH9hXDxrl36P4v9/OMv0SWKzPqro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gJizudvS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728881871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NNfw05JeqCiaE0aPXcBAetAKovvsf7rX91wGjBumb7E=;
	b=gJizudvSu++VFAn+jaLZW3512tqZ0b809E0Ws2UVmqjET4Zu/EKHO2foW7nFXzDQDcvIgz
	lj4juBJQgJ2GlUXp7ncA/ECEllksVu8+IkE/X+XZgeCjahh4dvZ9+92gF0pxScLNpG+Fyl
	7S1lFcdZAZDnLMnuDcAFikbFPYgsdds=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20-zTt7kecDNDWkW89Dd7RB1w-1; Mon, 14 Oct 2024 00:57:49 -0400
X-MC-Unique: zTt7kecDNDWkW89Dd7RB1w-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5c95ac2d13bso1446141a12.2
        for <netdev@vger.kernel.org>; Sun, 13 Oct 2024 21:57:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728881869; x=1729486669;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NNfw05JeqCiaE0aPXcBAetAKovvsf7rX91wGjBumb7E=;
        b=DMtxVYvWQfjXt4/iJBYlnplyTaXAnYXnK0UF5EG50Mxns3i6Cxf0SXdbQFS2gpApxR
         xzcQpgIjIHP3CIsJLelCOeyXP/1Z22slK1YaWCvDr3kCG5r91PDOmEOz+ldOpdFD8gy3
         59nBbKAQWPqxDGeEkKzFd2k82f0KKjeGRsGgphMnp8hMGJ78wsUF+BPUR+O3n2jaN85F
         9FFF0DCQ5sYmuXAsD86HFzBzt57kkWTNVvC+kjrHgjEmbZKHPGV5/Zgf64e93/gKT0CC
         hg5GDhtupFk69jeg35bAEYDuY45id1aN/5O2qGLrJSTb1u2DIJjMOOZCMw3feIJeJF21
         FNtQ==
X-Gm-Message-State: AOJu0YyszX0M0ZjndXrblAJ2elnEbAsYfEIUBhQHCduhGFnQ3nCf/MhI
	OcHpPHbYKuCrDrCivH9bkKlCnN+gdrluOQ0GrPwB0Ystx5VGFBZbzsdSxzWPZrOyzPIjnc9cSZW
	v0ZRoqBsdmC8+xMGC0bQB/GbbjGA1z54vBH8drr/izV6WM2mxdyhf5Q==
X-Received: by 2002:a50:cb88:0:b0:5c9:5a96:2863 with SMTP id 4fb4d7f45d1cf-5c95ac1582emr4347116a12.13.1728881868671;
        Sun, 13 Oct 2024 21:57:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEg1zgGKPYY2qUjDast+zBLcsCYUTRpyjjjgmslaW62xyjr0N9eWzmfPPhE/J3MFikwUsQyCQ==
X-Received: by 2002:a50:cb88:0:b0:5c9:5a96:2863 with SMTP id 4fb4d7f45d1cf-5c95ac1582emr4347104a12.13.1728881868323;
        Sun, 13 Oct 2024 21:57:48 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1ec:d16c:2d5b:a55d:7fda:5330])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c937267272sm4425344a12.75.2024.10.13.21.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Oct 2024 21:57:46 -0700 (PDT)
Date: Mon, 14 Oct 2024 00:57:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev,
	Darren Kenny <darren.kenny@oracle.com>,
	Si-Wei Liu <si-wei.liu@oracle.com>
Subject: Re: [PATCH 0/5] virtio_net: enable premapped mode by default
Message-ID: <20241014005529-mutt-send-email-mst@kernel.org>
References: <20241014031234.7659-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241014031234.7659-1-xuanzhuo@linux.alibaba.com>

On Mon, Oct 14, 2024 at 11:12:29AM +0800, Xuan Zhuo wrote:
> In the last linux version, we disabled this feature to fix the
> regress[1].
> 
> The patch set is try to fix the problem and re-enable it.
> 
> More info: http://lore.kernel.org/all/20240820071913.68004-1-xuanzhuo@linux.alibaba.com
> 
> Thanks.
> 
> [1]: http://lore.kernel.org/all/8b20cc28-45a9-4643-8e87-ba164a540c0a@oracle.com

Darren, you previously reported crashes with a patch very similar to 1/5.
Can you please test this patchset and report whether they
are still observed?
If yes, any data on how to reproduce would be very benefitial for Xuan
Zhuo.


> Xuan Zhuo (5):
>   virtio-net: fix overflow inside virtnet_rq_alloc
>   virtio_net: introduce vi->mode
>   virtio_net: big mode skip the unmap check
>   virtio_net: enable premapped mode for merge and small by default
>   virtio_net: rx remove premapped failover code
> 
>  drivers/net/virtio_net.c | 168 ++++++++++++++++++++++++---------------
>  1 file changed, 105 insertions(+), 63 deletions(-)
> 
> --
> 2.32.0.3.g01195cf9f


