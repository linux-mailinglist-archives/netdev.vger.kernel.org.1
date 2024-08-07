Return-Path: <netdev+bounces-116491-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15BFB94A90B
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 15:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFEE21F28819
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 13:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890A7200125;
	Wed,  7 Aug 2024 13:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JNDVHnTe"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE73200108
	for <netdev@vger.kernel.org>; Wed,  7 Aug 2024 13:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723038700; cv=none; b=jdMJiCRiIjUv4wncwp/XHYzo81WtfIX8Ky8z/CNP76W02QbtTj97Beh4cR2pC3S0N8iTlN3g3f84Cfc2whiy64kqWuxNVqQsY3XQm7vt5YgDkl5uGumBEh9cxB9K8Dx5As1uAB8WvxZaa5mf8v28qVyd60fdIykvH2C1CIMn7X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723038700; c=relaxed/simple;
	bh=BGi0niil7ZhDHyq+NZ6JdNNg1TfEYTESPyfrYYgGC6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZlG0Cg6S+eZS21s0EhPB1xelyRAZLuXrJnK35kVKwGzb/Cn28ny5SPvfDlUduwAKuxXmXlJ34aRNrvkJBcF80/+9hQytd9R1SOI5Tg+SoyhE+MSrgdelDyeCMdsRjm7R88LHoGOuVT8u5B8U2V5wu1WUlOFldVWJuCzLws3dmjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JNDVHnTe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723038697;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VeN30O0br2KcNUsWMzAJND3zzsH9WsTjuBPNWdcC/qM=;
	b=JNDVHnTeRKgdUZ7jtH/JNlWTRMshuB0fJM7mPxlHtLvr61YhllKXW1aX6Cgb3SnmYMVZWc
	dmFKrTVN3tN2aLNgjO1/n9OFY9UaN2+GLgDZYb50ZDIbyXY4mf4L995qQqwzQGg6Ul/CAT
	Xj8UVVOB/UUfQDFluSTvtdAax4iSdPw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-454-MFiZayObMamx82iHtJR9-w-1; Wed, 07 Aug 2024 09:51:36 -0400
X-MC-Unique: MFiZayObMamx82iHtJR9-w-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4280c0b3017so13342235e9.1
        for <netdev@vger.kernel.org>; Wed, 07 Aug 2024 06:51:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723038695; x=1723643495;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VeN30O0br2KcNUsWMzAJND3zzsH9WsTjuBPNWdcC/qM=;
        b=G8ye0augTzJWLSKuBFJeXG2ZeGfNZqVfd1vnYWMteOu6ILxC7SdHgrU0Oly4wa9qOT
         +GuBIv7vhF9kZb4YfhQcTNVOm+P7TNzn+l+n3JaKrZpbF/LKWhfCmoP5pwYNuuhaeHuF
         6symAb1Z0/mMiSkO+zkVWNIYM9Mcv8zV2gFHQCfTTK6duUETfY49C77HpSwGFmCoac66
         Vns8hX/5O0qw5tNblGgjbpAltyHL1GUdoOjK49cGoFtUHcADItRR9CDQw3X6+8VLOEDd
         gLbr5Bs11WjnTSiMAHlgAGlsvCpP3dvW2VbaQEfc7WnP9xPVuZssk092Urm8q9mIjWAe
         VZHg==
X-Forwarded-Encrypted: i=1; AJvYcCXJLYmA+Pj1Kg6GmrENdAL8qwTrDU8Acl74/bKOFSEO+HoWSJrbV1fWkOffMrAo+ePoEOROm8dGJHeFe0T4CbmA4nncOrwl
X-Gm-Message-State: AOJu0YwDHUDA5Hgo3rRhX45ecpqFH1J/VC1A1KBPUbWtWqEhgekthBy6
	gmkxMzOU1z0ScpMQ8LWYUhiS7NuU1JLb961f08rgeXisnxu/O2UB1ni5c9g0tcKd8z2hMi5I8gT
	vicz9krh+VRN6gdiWQgncCbPsyuum5+kz9ScjNT6ROK/n+i55ttGeZQ==
X-Received: by 2002:a05:600c:4f12:b0:425:7974:2266 with SMTP id 5b1f17b1804b1-428e6b7c13amr127656885e9.24.1723038694929;
        Wed, 07 Aug 2024 06:51:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhVFXgTXOjAYJDRv4mghT8BBwotFekv1SrhkpxYI+/Pu124Fj0jnbNi/dHqZyErUwSt44fSg==
X-Received: by 2002:a05:600c:4f12:b0:425:7974:2266 with SMTP id 5b1f17b1804b1-428e6b7c13amr127656675e9.24.1723038694161;
        Wed, 07 Aug 2024 06:51:34 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f4:efe1:812e:e83a:2c34:ce60])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429059713adsm30818505e9.11.2024.08.07.06.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 06:51:33 -0700 (PDT)
Date: Wed, 7 Aug 2024 09:51:30 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	inux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next V6 0/4] virtio-net: synchronize op/admin state
Message-ID: <20240807095118-mutt-send-email-mst@kernel.org>
References: <20240806022224.71779-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240806022224.71779-1-jasowang@redhat.com>

On Tue, Aug 06, 2024 at 10:22:20AM +0800, Jason Wang wrote:
> Hi All:
> 
> This series tries to synchronize the operstate with the admin state
> which allows the lower virtio-net to propagate the link status to the
> upper devices like macvlan.
> 
> This is done by toggling carrier during ndo_open/stop while doing
> other necessary serialization about the carrier settings during probe.
> 
> While at it, also fix a race between probe and ndo_set_features as we
> didn't initalize the guest offload setting under rtnl lock.


Acked-by: Michael S. Tsirkin <mst@redhat.com>

> Changes since V5:
> 
> - Fix sevreal typos
> - Include a new patch to synchronize probe with ndo_set_features
> 
> Changes since V4:
> 
> - do not update settings during ndo_open()
> - do not try to canel config noticiation during probe() as core make
>   sure the config notificaiton won't be triggered before probe is
>   done.
> - Tweak sevreal comments.
> 
> Changes since V3:
> 
> - when driver tries to enable config interrupt, check pending
>   interrupt and execute the nofitication change callback if necessary
> - do not unconditonally trigger the config space read
> - do not set LINK_UP flag in ndo_open/close but depends on the
>   notification change
> - disable config change notification until ndo_open()
> - read the link status under the rtnl_lock() to prevent a race with
>   ndo_open()
> 
> Changes since V2:
> 
> - introduce config_driver_disabled and helpers
> - schedule config change work unconditionally
> 
> Thanks
> 
> Jason Wang (4):
>   virtio: rename virtio_config_enabled to virtio_config_core_enabled
>   virtio: allow driver to disable the configure change notification
>   virtio-net: synchronize operstate with admin state on up/down
>   virtio-net: synchronize probe with ndo_set_features
> 
>  drivers/net/virtio_net.c | 78 +++++++++++++++++++++++++---------------
>  drivers/virtio/virtio.c  | 59 +++++++++++++++++++++++-------
>  include/linux/virtio.h   | 11 ++++--
>  3 files changed, 105 insertions(+), 43 deletions(-)
> 
> -- 
> 2.31.1


