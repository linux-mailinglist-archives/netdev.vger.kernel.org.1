Return-Path: <netdev+bounces-88998-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B278A92C9
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 08:09:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F933280D95
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 06:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C905C5FEED;
	Thu, 18 Apr 2024 06:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dNFCN+eh"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696D1282F4
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 06:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713420566; cv=none; b=IZOj5m7VOO7etRe6hRALuXnzdmLOQ/HEb5ERtInWZk27NolPjegfiQWqUJLPEXZzUKQbxFWurnKV0l+yD177R+uY/aGR/SidHTYzgcvess3DdgqSIpadfvTrnzsgeTLjum83w/2QsT8IT3zI0zazbNfDbJBOCgwZC7NkyvDBV0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713420566; c=relaxed/simple;
	bh=GNh+VuNzvsRb/wOJoe/wrB+bC4lFliOIDgQ1UmO/juM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uUjLf5ekSYadcdoqQs/gKZcngQASk7klE5cuEGkxVQGzKudGx3IOOD7OfbnIZmykPcMVg9Zv9H/TUYjmjnXIgmT+KASjElJ+/z6Nx6KL2w+gxhJuIlFiwpP7c+oaw9645w3DVURe83NQy7qTUC0MbrcE41TC54+QdJE8bJrU+EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dNFCN+eh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713420564;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GNh+VuNzvsRb/wOJoe/wrB+bC4lFliOIDgQ1UmO/juM=;
	b=dNFCN+ehPP+USAWDnWimrnKsMEqgrhmsyT/y+W4IAdoTadbjMcBq2cmRLuHt4dysk6/Zgi
	fjYr+OXuVxAxEDFtS6DKNljvCTszZFJKKln2iOOQTIuAx7lgcw8C3v4SdCmKEW6JuNCkC4
	IT0BksVMn55GLtoiaB9c6ugqNqIAz54=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543-cJur1JXLNbuu_Zxm75iLHg-1; Thu, 18 Apr 2024 02:09:22 -0400
X-MC-Unique: cJur1JXLNbuu_Zxm75iLHg-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-6ef9edf9910so986096b3a.1
        for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 23:09:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713420562; x=1714025362;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GNh+VuNzvsRb/wOJoe/wrB+bC4lFliOIDgQ1UmO/juM=;
        b=FvL7lNJbthX9hfqjySLUjSkWjcdGN0AmuimJ+DeNaO0sVpaEIv1bBKGUmgZAf5FRlm
         D+WGiMp/VksRInXUH+pdtr33vJ9NS+sOquHPa5+34uMx0tM614q01L8EWeGTj56SkbvV
         kCy/tbGrpVCd9nAz3t3PsYtVL/AgvEsFXFt0VbuKHuIFB8N0xYthd8yWC4JSESgPuVd6
         9ET8QWPkKwEXKidtuUzJVIb1+er7MMX42bkmJMkmZmvI16RI7/tn5QKlXedhgxLsX/P+
         Gx9P37zeIRUaWfnliKUMR0ZzNNN267o88KNompk4mhQlBK6WeWqtNY86/U3Er2K5QiGp
         mcpA==
X-Forwarded-Encrypted: i=1; AJvYcCXSQKJGOdop4obdiZrwrGnzBpqXumv51tv3g8J8swfU1Ux9BXQLRtGxKUVuaRlRnyKnGx04fy86QVql46G7R5TP00SIP6Et
X-Gm-Message-State: AOJu0YxyFkJ/crkyHdDoOivE4cZt/xbzRcbo7a5QF1WBnL0Tf92iF0DN
	uZ23corIuzbzgz8+VMOCisExOupXsdJ2+TWDfqAoHPgM2khjUiZdStZq/ue9CJVeSdChyc1KD3W
	KMEKxueK3/6nbMHd1ez5952HOtQYIGhRSZewFFPuhAQPoFwaBSJbJd5LFoRl01k3qMX6ejshZex
	wQAFEFVRkoftlBZi8trXH/wysaBbnB
X-Received: by 2002:a05:6a00:1804:b0:6ea:8b0c:584 with SMTP id y4-20020a056a00180400b006ea8b0c0584mr2437372pfa.9.1713420561777;
        Wed, 17 Apr 2024 23:09:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4PuWAAI2IJNnqNjFq7oH4FtTLkvSea/kyne1VD2dr00iqkn8rtuNOFi3+3bHz+qXVRWU9xXnO6/bB2lAJ6gA=
X-Received: by 2002:a05:6a00:1804:b0:6ea:8b0c:584 with SMTP id
 y4-20020a056a00180400b006ea8b0c0584mr2437356pfa.9.1713420561452; Wed, 17 Apr
 2024 23:09:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411025127.51945-1-xuanzhuo@linux.alibaba.com> <20240411025127.51945-3-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240411025127.51945-3-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 18 Apr 2024 14:09:10 +0800
Message-ID: <CACGkMEvkbJ2j6J=nxfh3FNQRhNBa0Wr6Kyz=6r458edgxo65RA@mail.gmail.com>
Subject: Re: [PATCH vhost 2/6] virtio_ring: enable premapped mode whatever use_dma_api
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 10:51=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibaba.=
com> wrote:
>
> Now, we have virtio DMA APIs, the driver can be the premapped
> mode whatever the virtio core uses dma api or not.
>
> So remove the limit of checking use_dma_api from
> virtqueue_set_dma_premapped().
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


