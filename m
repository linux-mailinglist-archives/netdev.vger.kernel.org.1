Return-Path: <netdev+bounces-127420-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1897697552D
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 16:22:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C17611F25057
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 14:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7AD319C549;
	Wed, 11 Sep 2024 14:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MwiWjVK0"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25288187336
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 14:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726064562; cv=none; b=qYOCi9LEva+9Hlsr6Tgeb4/7J8AoJdxnh4lW/b3hZyPb/zaXaZlCh0goa6c2b5ygtUMW22nx+I1vLm+ilRi90JooOoC20Mo4AMVRN0mVZJMrV7l+MXJfXzn1jNpxae+YnvRiusDzNr8eC3/Rkmkr4GgVeM+hdbgDHfDmiUL1g6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726064562; c=relaxed/simple;
	bh=NOmC9DGMX2GCfVvsOzIC4lI0hPnfqP52+SQnoC29Y8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=piUDxnzBR4gqj0axKSam6F+VpqRWg62EITobfp/Ya+C0lJHvdPWpMFFFpOs8QOxnpjjpdjLjLl98WR2EgMCinKWTz2b/de0kHL4Qu9veV5KwqvJpnHGVgh5UBYNQ+7xYTbKhDmJO4BQQtCJu+iHHJJogQQcocZ0BEhN6sXkCfw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MwiWjVK0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726064560;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KlwlpyR7s9PuNDsrnPWWnbsRUCrVHlg+jk+cktAZqCs=;
	b=MwiWjVK0bPZAGEdoZguJQsMzR6QjhF7vMe/Eh4C6gJsTdt4T3m4hpnXb48UllF99gVl65y
	EX6CiU5iFdCJ259R0P027Ax+TUpVJP+0uabCu6WiOm9A2FqxuO2PdjSTvDc3Pih6iJO2fM
	bulc2JlIkz076TTFOaa/LM7U+LjdWXo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-5SpnFkL7N6yKQ3vnayCYHQ-1; Wed, 11 Sep 2024 10:22:39 -0400
X-MC-Unique: 5SpnFkL7N6yKQ3vnayCYHQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42cb857fc7dso26668305e9.0
        for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 07:22:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726064557; x=1726669357;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KlwlpyR7s9PuNDsrnPWWnbsRUCrVHlg+jk+cktAZqCs=;
        b=RgwkFKY1RRSXfuo8yfv2HgRQ19Y3XTy2muFeAbrAdX8S3eNLJkhOgN8ejb6nbYzirQ
         URGuFBcEnJ+C34yxdzaubmTHX40eJ1Lgg9KrudZKzlf6sZ6WznsMh8R0KZkYGYcSpQs7
         JIWyCuMNSDPhN8fXmLY3X5PZWLr2lxDWFVMf/DKyYw0GBCzKLrCwE7H16f6SwJ/Nk2rh
         zr56pxK0RfjI7ACaEYgOxhP9Trg/IptY4b5uqYBrjDSmCFgVCv5pighEdlFDt2kaGXA6
         06qzCOu1zL0VOX8rbWX4gztCUghLq/gdG1I60m0hVpIyF06Z5noy77gzdmcv2Pq3/5oy
         Ygdg==
X-Forwarded-Encrypted: i=1; AJvYcCU7W/AbXf4B5oIvAGiZDA6syhyiBZ39zW4k4bv0avI+e1gsjKKwrkEEIMVBMattdvlkaxv0K34=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywske/4iIaK4l8YVq1i1j8nPcaO5Uz6EaJADstbJ+umn8ga84FH
	SRBzTkqAjvIm1bwvs44tAaRfIc6tImL/9IH6JU69z7yJlEppyghlGHTJESebJjqOB/KJOY+3jWK
	p5RakXCSxX4WRzAs52Sw6fnWPVrXp9b1Pxj28xRF2uNEdr4BqH7uySQ==
X-Received: by 2002:a05:600c:4715:b0:428:18d9:9963 with SMTP id 5b1f17b1804b1-42c9f9caad1mr136384325e9.22.1726064557463;
        Wed, 11 Sep 2024 07:22:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9m+J5t19nLZEF6LuLYy62fpUcnJkhDRp+iXgUVIJAMM0Awf3nAfjW/2/dTi9eKk32kN0jhQ==
X-Received: by 2002:a05:600c:4715:b0:428:18d9:9963 with SMTP id 5b1f17b1804b1-42c9f9caad1mr136384075e9.22.1726064556866;
        Wed, 11 Sep 2024 07:22:36 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:552:d9bb:9070:1995:8d82:f57f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3789564a279sm11805272f8f.9.2024.09.11.07.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 07:22:36 -0700 (PDT)
Date: Wed, 11 Sep 2024 10:22:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Darren Kenny <darren.kenny@oracle.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, virtualization@lists.linux.dev,
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Si-Wei Liu <si-wei.liu@oracle.com>
Subject: Re: [PATCH 0/3] Revert "virtio_net: rx enable premapped mode by
 default"
Message-ID: <20240911102106-mutt-send-email-mst@kernel.org>
References: <20240906123137.108741-1-xuanzhuo@linux.alibaba.com>
 <20240910081147-mutt-send-email-mst@kernel.org>
 <m2ed5qnui8.fsf@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m2ed5qnui8.fsf@oracle.com>

Thanks a lot!
Could you retest Xuan Zhuo original patch just to make sure it does
not fix the issue?

On Wed, Sep 11, 2024 at 03:18:55PM +0100, Darren Kenny wrote:
> For the record, I got a chance to test these changes and confirmed that
> they resolved the issue for me when applied on 6.11-rc7.
> 
> Tested-by: Darren Kenny <darren.kenny@oracle.com>
> 
> Thanks,
> 
> Darren.
> 
> PS - I'll try get to looking at the other potential fix when I have time.
> 
> On Tuesday, 2024-09-10 at 08:12:06 -04, Michael S. Tsirkin wrote:
> > On Fri, Sep 06, 2024 at 08:31:34PM +0800, Xuan Zhuo wrote:
> >> Regression: http://lore.kernel.org/all/8b20cc28-45a9-4643-8e87-ba164a540c0a@oracle.com
> >> 
> >> I still think that the patch can fix the problem, I hope Darren can re-test it
> >> or give me more info.
> >> 
> >>     http://lore.kernel.org/all/20240820071913.68004-1-xuanzhuo@linux.alibaba.com
> >> 
> >> If that can not work or Darren can not reply in time, Michael you can try this
> >> patch set.
> >
> > Just making sure netdev maintainers see this, this patch is for net.
> >
> >> Thanks.
> >> 
> >> Xuan Zhuo (3):
> >>   Revert "virtio_net: rx remove premapped failover code"
> >>   Revert "virtio_net: big mode skip the unmap check"
> >>   virtio_net: disable premapped mode by default
> >> 
> >>  drivers/net/virtio_net.c | 95 +++++++++++++++++++---------------------
> >>  1 file changed, 46 insertions(+), 49 deletions(-)
> >> 
> >> --
> >> 2.32.0.3.g01195cf9f


