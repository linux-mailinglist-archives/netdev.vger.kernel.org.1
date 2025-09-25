Return-Path: <netdev+bounces-226540-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA309BA184D
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 23:21:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAC9E741CA8
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 21:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8872E8B6B;
	Thu, 25 Sep 2025 21:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FS/4Mnpa"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7069831BCA6
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 21:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758835259; cv=none; b=uHEgqKTcnqqZIlLwnOy8K7LuQ8Bmor2ycYPuV+2emRY7FrHcfMu+KyC1DN01nE0ndoXjj05c7vQrUq87PgXPvSpraVJGhypjpJzhgj9wOMaUKi1KE/uYCcdiubrAsS+5UMMXmaFLdFDsvCfnwhkQ+/Ys2CXcbMikoXCvEuCnAVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758835259; c=relaxed/simple;
	bh=F/lfsdyoROFd5M36/k6KcRcPVp6aiZdeNYsR5rM8xTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m7O1XiWx6TfzXgtPXZt2Y6rd/UKnpSHmgI1KqYSj8zjznH9pBkoYhJOouUiuQFdAWYzx9RPfoTy5seQelcPfLtjIly3t1vsj+rvir5VbPxj2YuMncZJTYsvY6ptGj5YT/w9wDmUCLx3U2muW/vWWUxRGrvyDITofyUNo66Hcz3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FS/4Mnpa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758835256;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=88zoVV1aX2IdFwOgFrkT9f/SnpSpDG0hDuK9RJ1HXEA=;
	b=FS/4Mnpaybm04giQmywAhV9dFc5TFCKrSJsURQrs6FcHPVRy12DqPrqP928pv0zVyHHG+i
	LrL6/hr602tjc6kq/2D+SD+apSMw9HzABz2HF18+JpL+Wk654aqkr29Hzgyo0BgKJ7m780
	N2qtM8+s+RIe147pYggQchxADS/wUl0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-52-rSHmzlyoOlGUbYp0qUlh7A-1; Thu, 25 Sep 2025 17:20:54 -0400
X-MC-Unique: rSHmzlyoOlGUbYp0qUlh7A-1
X-Mimecast-MFC-AGG-ID: rSHmzlyoOlGUbYp0qUlh7A_1758835254
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-41066f050a4so573978f8f.1
        for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 14:20:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758835254; x=1759440054;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=88zoVV1aX2IdFwOgFrkT9f/SnpSpDG0hDuK9RJ1HXEA=;
        b=QxRtcK3sRKnCAhVac6PT2qwCF6g0VIAKAObn98WuFYLisWRzT1X76g5JpxwxLK9mdT
         8aXWAEAikRcG/GP64bB3mw9u1ErI+OqlMerJ1JxqSodJ6Ovl5ftQcxSTKqE5V3LxEg+m
         LjsFM+U4SJBkO3tDwLNhxVAdewpIJzc+51w8kdU+hp5eBYfsF7KuQsyyk7XySU2yeUZd
         Ula0qe8D/dw3WQCbtgC1ONzjXfOe+AWlKJZIPN8GUuCTPhbXlH6G55ujT+5m1x+r7WHM
         fJnHss1j+4cHUXOt/nCCDW5hP6UTlhMZe9T4J87LC5J6afHXQ5gS0LLmRIpEYbHe6BlN
         JqwQ==
X-Gm-Message-State: AOJu0YyNcCHBxC6RYErIUETPkTquanJBKPpwwjPbXsfARLE9vRWtk8A2
	wVPv1Qw1CC/dXXue1iBktXGpomdfGD1VbgIFLpAQm7EGAUGuL1zpFi0LkwJgUl5/yEd8gbqq3OF
	sWlIbXqTDiRm63ofwznjYwIX5yxK7suvwwJxbUVWkpMydIMqy2RpKRBAfyA==
X-Gm-Gg: ASbGncsl6Rl1dUbxyIBU0iZVIQ5n77qZtvMVEovL9aZEgSSLTTMaluEVzvL2ZzMc0hb
	Jhqq/0ux81ocoY2CiXf7OKhLAEk+0G2qicw01cMDRXoQWLNVNGjy6qut0puPvoWBqFv9Ya1jx98
	w6qltZx+0paI2Gf+S8NLmIsk4JjeFjtaXCC37a9cI8IYbc+HCl8B6V1D1vjrPUxD5CSnHigJpSs
	f7pKAYqZ2ikVKU7qwxsPrAbEOczYvSRNkugl/ZEKWyTRMg1dPmIc5Nk1E2GVVOsLlkvVmunoRnC
	W1VuCN47QsuesfhcwLMMx3fxmRjSz4X9RQ==
X-Received: by 2002:a05:6000:615:b0:3f3:c137:680e with SMTP id ffacd0b85a97d-40e4ff19927mr4506725f8f.43.1758835253639;
        Thu, 25 Sep 2025 14:20:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgh5VC5yyfre4nkWgfsZ9zqcVRyYQ/TYsZXlD8u6iZ2B2i5N6PHpkQew+jpERiYfdRNBV7AA==
X-Received: by 2002:a05:6000:615:b0:3f3:c137:680e with SMTP id ffacd0b85a97d-40e4ff19927mr4506699f8f.43.1758835253277;
        Thu, 25 Sep 2025 14:20:53 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1538:2200:56d4:5975:4ce3:246f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e33be359dsm46129065e9.13.2025.09.25.14.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 14:20:52 -0700 (PDT)
Date: Thu, 25 Sep 2025 17:20:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dan Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, alex.williamson@redhat.com,
	pabeni@redhat.com, virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, shameerali.kolothum.thodi@huawei.com,
	jgg@ziepe.ca, kevin.tian@intel.com, kuba@kernel.org,
	andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net-next v3 08/11] virtio_net: Implement IPv4 ethtool
 flow rules
Message-ID: <20250925171936-mutt-send-email-mst@kernel.org>
References: <20250923141920.283862-1-danielj@nvidia.com>
 <20250923141920.283862-9-danielj@nvidia.com>
 <20250925164807-mutt-send-email-mst@kernel.org>
 <5518ba7f-80b4-43f1-a5c1-eb8298170e9a@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5518ba7f-80b4-43f1-a5c1-eb8298170e9a@nvidia.com>

On Thu, Sep 25, 2025 at 04:13:42PM -0500, Dan Jurgens wrote:
> On 9/25/25 3:53 PM, Michael S. Tsirkin wrote:
> > On Tue, Sep 23, 2025 at 09:19:17AM -0500, Daniel Jurgens wrote:
> >> Add support for IP_USER type rules from ethtool.
> >>
> >> +static
> >> +struct virtio_net_ff_selector *next_selector(struct virtio_net_ff_selector *sel)
> >> +{
> >> +	void *nextsel;
> >> +
> >> +	nextsel = (u8 *)sel + sizeof(struct virtio_net_ff_selector) +
> >> +		  sel->length;
> > 
> > you do not need this variable. and cast to void* looks cleaner imho.
> 
> It's cast to u8* so we do pointer arithmetic in bytes, which is not
> standard C on void*. GCC doesn't mind, but I thing Clang does.
> 
> I saw you had a similar comment on a subsequent too.>

it's a known C standard bug.

kernel does void* math everywhere.

Linus hath spoken on this ;)


> >> +
> >> +	return nextsel;
> >> +}
> >> +
> 


