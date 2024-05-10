Return-Path: <netdev+bounces-95394-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE2C88C2281
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 12:53:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CE4A1C210E7
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 10:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E80AD16C873;
	Fri, 10 May 2024 10:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GbbtysMj"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B66C16C691
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 10:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715338381; cv=none; b=EKP8dEM8w2dnO41O3RIfkq2Gsy2GfH5Id5tyLk7ZgEdA0gWF6kFLH7+JnTIapc1Mvf5I5vDLZj0pO+ygmfj4oevwTvnu30peoPklWB+WzLylgp9mPrR/Pa2BSBSgOL+U4qcWDwkl9dfS7pkSzsEsvbQcUbh/7jjJJZTDjyIsUKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715338381; c=relaxed/simple;
	bh=ocV1iitruywNeS3LsDx+ECd6GmmCgzJALrmUamG6X/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=urNTBLyiNRNDGWpcEjYFRLtRDD3Qgxtqj1mXVAGVVea5xRe3TmqBqgAPkU3Xx0Bnn+uUgpMGAYX/sBI8kTXpMge0q99BK3q45wJdpJRojqKK7ZOLKu7KSaKXtBYfXMMxVOjhULydn23TnO2/7X1j/esrdi+IH8mLBMsN6DrpRck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GbbtysMj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715338379;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=87j9es5GKBqYf1Oh12DDQjpVqARqFQ5m4FHRLb5iAAw=;
	b=GbbtysMjS+TQrITABEY+9Gqo0iAO4srrhlAd0IVTB62eoEgDB+uaqIaRSqHELEO0DuRCxk
	ANy13wHI0o/nL/v+2jygSLK0S5h5qj3Xpg2rZYftpRFWz59etvIrb2QyhRu02GLxTPTQBi
	kfDlkXUKmoWDhFIt8stOjiCkaKMS2Ew=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-482-Kb3_20oLNZufKA3_Eb1Kvw-1; Fri, 10 May 2024 06:52:57 -0400
X-MC-Unique: Kb3_20oLNZufKA3_Eb1Kvw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-41c01902e60so9703225e9.3
        for <netdev@vger.kernel.org>; Fri, 10 May 2024 03:52:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715338376; x=1715943176;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=87j9es5GKBqYf1Oh12DDQjpVqARqFQ5m4FHRLb5iAAw=;
        b=O/anpgUQQHqXENuUgpr3ZIyRArvEApN4ThA70o1prQeVO45jXbMCnhnd42Yavj9D18
         TtjM9YO3ftR2H4YIJS7HbZ85OFeK/IYe9KHGsvHIS2SZKfdrOoQydUZvbdR0p7Dd1pXG
         RRWfZvEkEt+/AQSb2cGRaE1uif16M7qV/osCksZLhQGYR6FE7BX3bk8nyi1j+GK/Kk4T
         gZ33LjnZz+8Vr6ASrJJymg4BvF8VuGce1hvxq8/Ncffc6z5o+dqP7/ORpiVX9i+IYSwr
         Kmzlttw1gfOvu9VSeNqQkpy2xTOkHCOAnbKnYEUnvPmTA4c3T1kPDTvEqBvchKnnX35c
         Z2dA==
X-Gm-Message-State: AOJu0Yy+inIS7ZuvOsjfHsgpkteLph8EIAARv9yp+y9w2ABx5N2cjgpY
	9liGk4l3xwYvP5deYDEInP+bdHyVE5yj150ptlUCRF3WUpcLAs/Y6mDeQbSXafihiGrmeBTBTbM
	kSjSJv/95xoN0Im10DTMnfoR6DExIpBJON9cuLKfdCRKOA7XoUGQSDQ==
X-Received: by 2002:a05:600c:1389:b0:41f:f053:edb4 with SMTP id 5b1f17b1804b1-41ff053ef30mr13398385e9.23.1715338376478;
        Fri, 10 May 2024 03:52:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQo8edf9Bbxrqhzc4y+CNPbsI1HGEi8VtkoHr3pgGLi1CN21Bn41Wng4Rd6DNLwV3eJ3w/LA==
X-Received: by 2002:a05:600c:1389:b0:41f:f053:edb4 with SMTP id 5b1f17b1804b1-41ff053ef30mr13398205e9.23.1715338375927;
        Fri, 10 May 2024 03:52:55 -0700 (PDT)
Received: from redhat.com ([2a06:c701:7408:4800:68b:bbd9:73c8:fb50])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fccfe1527sm57995985e9.44.2024.05.10.03.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 03:52:55 -0700 (PDT)
Date: Fri, 10 May 2024 06:52:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev,
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
	john.fastabend@gmail.com
Subject: Re: [patch net-next] virtio_net: add support for Byte Queue Limits
Message-ID: <20240510065121-mutt-send-email-mst@kernel.org>
References: <20240509114615.317450-1-jiri@resnulli.us>
 <20240509084050-mutt-send-email-mst@kernel.org>
 <ZjzQTFq5lJIoeSqM@nanopsycho.orion>
 <20240509102643-mutt-send-email-mst@kernel.org>
 <Zj3425_gSqHByw-R@nanopsycho.orion>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zj3425_gSqHByw-R@nanopsycho.orion>

On Fri, May 10, 2024 at 12:37:15PM +0200, Jiri Pirko wrote:
> Thu, May 09, 2024 at 04:28:12PM CEST, mst@redhat.com wrote:
> >On Thu, May 09, 2024 at 03:31:56PM +0200, Jiri Pirko wrote:
> >> Thu, May 09, 2024 at 02:41:39PM CEST, mst@redhat.com wrote:
> >> >On Thu, May 09, 2024 at 01:46:15PM +0200, Jiri Pirko wrote:
> >> >> From: Jiri Pirko <jiri@nvidia.com>
> >> >> 
> >> >> Add support for Byte Queue Limits (BQL).
> >> >> 
> >> >> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> >> >
> >> >Can we get more detail on the benefits you observe etc?
> >> >Thanks!
> >> 
> >> More info about the BQL in general is here:
> >> https://lwn.net/Articles/469652/
> >
> >I know about BQL in general. We discussed BQL for virtio in the past
> >mostly I got the feedback from net core maintainers that it likely won't
> >benefit virtio.
> 
> Do you have some link to that, or is it this thread:
> https://lore.kernel.org/netdev/21384cb5-99a6-7431-1039-b356521e1bc3@redhat.com/


A quick search on lore turned up this, for example:
https://lore.kernel.org/all/a11eee78-b2a1-3dbc-4821-b5f4bfaae819@gmail.com/




> I don't see why virtio should be any different from other
> drivers/devices that benefit from bql. HOL blocking is the same here are
> everywhere.
> 
> >
> >So I'm asking, what kind of benefit do you observe?
> 
> I don't have measurements at hand, will attach them to v2.
> 
> Thanks!
> 
> >
> >-- 
> >MST
> >


