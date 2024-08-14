Return-Path: <netdev+bounces-118406-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E4639517EB
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 11:44:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB88F1F2312D
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 09:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D496166F3B;
	Wed, 14 Aug 2024 09:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rcj2f1Mv"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3631166F3F
	for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 09:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723628645; cv=none; b=V0pfWcJiG9fE1puXZW5n9kABAVDld5R700fT8Catv7XF5RNYwdzYxYqr7Wb5yPmtCEyEYIJJ4cPTSRLtZFp+4UPc+bvrfqFQckUyYk3Y3KWfKyEd6Iy06Zx/Xm8KmPt1bIq52oFRcx68Qi5DZGeIdErJk+1A630e0BIKQNNSRgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723628645; c=relaxed/simple;
	bh=bDX0W0YcHfz6UrXy8uYh9/2NpWe0JqnGzLjCtVJFHL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f/Usg4MuFMlpYBaUm5um6crrVnkE0fdx24cpD40SC1jD7pB7+Msh9eXbUb3CLKiaB75xWwHFpM2nqmEHqlRttIm44nysuKwBTMQ1fUPoGN9xN+Pfq6edQGCq4+OiAx+TO29sDeLIkMC8koSb+u/m6QxzndNxPKFDPCazNQEKaoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rcj2f1Mv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723628642;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+elik60oxPmXl+HwPhEYp0jss+bQ52uuhXHHXAgMsXQ=;
	b=Rcj2f1MvhZB0SAPQ0QkaOM8ZaAmogswKVVpUGITj7kIec9JEjfo354pnItXPNPNgurMOT6
	iGbjqVMMJCiy0p4gDGazNAs+R2M/nGbIoagRQQh0GdqrOHyXCIuVNrFKCo8lNI2wg7BzZk
	g2rWCdWc5+A11uPPdvGTSYEJo7nxxf8=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-sJTzAkxdOzGudMMsvCoIUQ-1; Wed, 14 Aug 2024 05:43:59 -0400
X-MC-Unique: sJTzAkxdOzGudMMsvCoIUQ-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a7a9761bf6dso539073666b.3
        for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 02:43:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723628639; x=1724233439;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+elik60oxPmXl+HwPhEYp0jss+bQ52uuhXHHXAgMsXQ=;
        b=AJ+ZYQcnv/Jub6q3tMbPmjJHurGi5Pidt4y40bjYo8mPPqw/jLP9C7MGGUMJRdU+9Q
         AWQjS/ICSb5KegNKmHEM6Y50sUcsTIogiJw2BEoKO8rUNm/fniR3an3o0vpjmXVrRe5Z
         CI8rpdWN/mfqH2pJtRKVPyA3CORW37P5/QhLWagUdKZ5yO4Jjfmz6JfhQK2BbQHu6oiQ
         i/JAtaDFg/7+VICGbrmgODW3mkuzk/LhJk7l2UtbF7pDm91A6T2V/6j3uY0of66Vz2W2
         Iu3fmnt6SRJcKnaDcr+q7qVn72PnPP6xzT3kzq0a6PaRnfmTh8vd8GPpKzRlIv+tsDl5
         6lNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVL4SIPE6tCglX/czfwkzx1N7WobSa4cDVUtVkxMlfVEcUQdyXPsmSWEx7QzG0g6SH5dT2SJ0TEzmJ2XSYsr22jIbPkaz8d
X-Gm-Message-State: AOJu0YwzJOwE1cKqzo4qi2al8sW03QDWJ3+bxi+422i1f1qnwaf+0SkJ
	LCwDTnAuzJHBOvh2yKP+3yA/h2FR4SbcbvBu3OcgJnhrKdedphuKi3ymbMdXwmeah47A8hS4xPD
	8jK01n1lqQ8OTfvMLoul/zI7ZwunR6rgxvgC5wpTEekzk25UWWhnefg==
X-Received: by 2002:a17:907:7e95:b0:a77:db36:1ccf with SMTP id a640c23a62f3a-a83670913a4mr157848666b.42.1723628638688;
        Wed, 14 Aug 2024 02:43:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqgSyfSPfgnA5rfz+Si+DMzLKsMw6jiA0HIHLtzrsRJoI+UE3pbGrO6gcYuSOHr66pPBiDBA==
X-Received: by 2002:a17:907:7e95:b0:a77:db36:1ccf with SMTP id a640c23a62f3a-a83670913a4mr157844566b.42.1723628637900;
        Wed, 14 Aug 2024 02:43:57 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:346:dcde:9c09:aa95:551d:d374])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80f418260esm150658566b.197.2024.08.14.02.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 02:43:57 -0700 (PDT)
Date: Wed, 14 Aug 2024 05:43:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	virtualization@lists.linux.dev, ast@kernel.org,
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
	dave.taht@gmail.com, kerneljasonxing@gmail.com,
	hengqi@linux.alibaba.com
Subject: Re: [PATCH net-next v3] virtio_net: add support for Byte Queue Limits
Message-ID: <20240814053637-mutt-send-email-mst@kernel.org>
References: <20240618144456.1688998-1-jiri@resnulli.us>
 <CGME20240812145727eucas1p22360b410908e41aeafa7c9f09d52ca14@eucas1p2.samsung.com>
 <cabe5701-6e25-4a15-b711-924034044331@samsung.com>
 <Zro8l2aPwgmMLlbW@nanopsycho.orion>
 <e632e378-d019-4de7-8f13-07c572ab37a9@samsung.com>
 <Zrxhpa4fkVlMPf3Z@nanopsycho.orion>
 <ZrxoC_jCc00MzD-o@nanopsycho.orion>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrxoC_jCc00MzD-o@nanopsycho.orion>

On Wed, Aug 14, 2024 at 10:17:15AM +0200, Jiri Pirko wrote:
> >diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> >index 3f10c72743e9..c6af18948092 100644
> >--- a/drivers/net/virtio_net.c
> >+++ b/drivers/net/virtio_net.c
> >@@ -2867,8 +2867,8 @@ static int virtnet_enable_queue_pair(struct virtnet_info *vi, int qp_index)
> > 	if (err < 0)
> > 		goto err_xdp_reg_mem_model;
> > 
> >-	virtnet_napi_enable(vi->rq[qp_index].vq, &vi->rq[qp_index].napi);
> > 	netdev_tx_reset_queue(netdev_get_tx_queue(vi->dev, qp_index));
> >+	virtnet_napi_enable(vi->rq[qp_index].vq, &vi->rq[qp_index].napi);
> > 	virtnet_napi_tx_enable(vi, vi->sq[qp_index].vq, &vi->sq[qp_index].napi);
> 
> Hmm, I have to look at this a bit more. I think this might be accidental
> fix. The thing is, napi can be triggered even if it is disabled:
> 
>        ->__local_bh_enable_ip()
>          -> net_rx_action()
>            -> __napi_poll()
> 
> Here __napi_poll() calls napi_is_scheduled() and calls virtnet_poll_tx()
> in case napi is scheduled. napi_is_scheduled() checks NAPI_STATE_SCHED
> bit in napi state.
> 
> However, this bit is set previously by netif_napi_add_weight().

It's actually set in napi_disable too, isn't it?

> 
> >
> > > ...
> >
> >Best regards
> >-- 
> >Marek Szyprowski, PhD
> >Samsung R&D Institute Poland
> >
> 
> 
> > 
> > 	return 0;
> >
> >
> >Will submit the patch in a jiff. Thanks!
> >
> >
> >
> >>
> >>Best regards
> >>-- 
> >>Marek Szyprowski, PhD
> >>Samsung R&D Institute Poland
> >>


