Return-Path: <netdev+bounces-82920-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49886890312
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 16:29:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2DF628E0EB
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 15:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D08D12F38B;
	Thu, 28 Mar 2024 15:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hk1xQsRX"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CD812DDAB
	for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 15:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711639783; cv=none; b=SyaPswZP5oiV90utJeBR6IJJ0QUlY+fGhq/taWP9rwzZ2bx8OxwuRyW+BEtqCgxXzosWhK3WC5hEQvOt8YVCukaxAnR4T0Dk5FcORv41pRg5tBlGtiE1NJLU/RbVXzVaSjXfIViQFjIyZsCCJd7FF9FnmyjP8r9R5bxVufevggI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711639783; c=relaxed/simple;
	bh=voIPKnnuckDMQ9h4aFGjLZTBZsbN8bJ7CERH7xqJ/IY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o87T6SsendG+e4OWzb5YksEStNf0Q5K2FPNldfeW7tjDZeplgEYs81hTFdx+8K5poVhv2rBR3/4HeUhN6mFdQPr8ds5jcCbqxduKkD0AUwTLpSx78YQSsR4vnmrfQ6eIzvYbSS1WxzKhqyUYjPXUWaMTJHBBmeCJ2HiPb09Aq30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hk1xQsRX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711639780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CjLVRkd8oCaxXYk4LSR3ZhKWdvfAa5k0uQlVbiPFJzI=;
	b=Hk1xQsRXh5UX2uRptTxLmIWCeKRp6IgNoJFdmU1plfMpuAR/6ln8QPG/XsQZwhw09DiGvH
	OgGg4iy0UqNQNi1q0yXhbVpZwo/xu35A+6m142bMPl8+JISikLy9RG9j0PwVAbyy6BfIe7
	SrgqQBdBhUFg+g3p2PLnXYTCV4X4ux0=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-5-SpzeEYV3Nsa-oR04NgQTqg-1; Thu, 28 Mar 2024 11:29:38 -0400
X-MC-Unique: SpzeEYV3Nsa-oR04NgQTqg-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a4df17773a5so78267666b.1
        for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 08:29:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711639776; x=1712244576;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CjLVRkd8oCaxXYk4LSR3ZhKWdvfAa5k0uQlVbiPFJzI=;
        b=ajqFjof5EztQwfjPR1Pa2PwusjDFBCD2G8fDXKtWg+1oDMsMXM7WyYu8U74yyrXk4u
         Rb6a4rtcdRdm9uVYCRc3cMFUdtwyL3EGBRnQBBKdw0k2NjsISTy+ptkY8xt85xWk7ILd
         bk8S2tqPFSEv0dX1ElLi4q+arqHnvyo40QPATEytKAqIHgNsUtp7OOxz5aHada+evefQ
         T/ePh9wUX0jOR54mwA0nbNWYH7r0fA2d+9YdSM3rsaOnP4KurP9tamPXhsODphKKrlgl
         FJij8k9FR365R75dDBKRHT3nq5ax+/ue5K1Jd6DLfa3FMVqqjY7T9BZN19Tk6KgJjxcm
         7YDQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4lzDocDz6xaT3oYF5omf45jWU1CNcIRnYmhc3Mf1X/ITe2KDBAM0za6o14rz6S+zAgBGL4NVK3phU5Gs+NCDY9QYAzxX6
X-Gm-Message-State: AOJu0YzXLDDo+L0tQ45I1i7Qq2wIPgvH/gloUx2BOFPtQy9i2TC/zEXl
	5FMMyex03M6BEQrAS7Orxo2CNCgQp47aMIFccV25DnXq1zujeInXlaF5U204E9PRpll3yGge0iM
	VXo95MGbWN/tr2plU505hkNTV5s21Oh2HNxUR86EmEyN5eYYupmtG2g==
X-Received: by 2002:a17:906:dfc7:b0:a4d:d356:fd69 with SMTP id jt7-20020a170906dfc700b00a4dd356fd69mr1961316ejc.12.1711639776570;
        Thu, 28 Mar 2024 08:29:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCOeBfBT7xqbRmO+gVOJGi/tsSh711gxkYEEZnWavEz7DxOhNBf8COs0bAblMQ5OZm98QKfA==
X-Received: by 2002:a17:906:dfc7:b0:a4d:d356:fd69 with SMTP id jt7-20020a170906dfc700b00a4dd356fd69mr1961301ejc.12.1711639776081;
        Thu, 28 Mar 2024 08:29:36 -0700 (PDT)
Received: from redhat.com ([2.52.20.36])
        by smtp.gmail.com with ESMTPSA id dr3-20020a170907720300b00a4a38d10801sm871680ejc.35.2024.03.28.08.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 08:29:35 -0700 (PDT)
Date: Thu, 28 Mar 2024 11:29:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Simon Horman <horms@kernel.org>
Cc: Daniel Jurgens <danielj@nvidia.com>, netdev@vger.kernel.org,
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	virtualization@lists.linux.dev, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	jiri@nvidia.com
Subject: Re: [PATCH net-next 2/4] virtio_net: Remove command data from
 control_buf
Message-ID: <20240328112856-mutt-send-email-mst@kernel.org>
References: <20240325214912.323749-1-danielj@nvidia.com>
 <20240325214912.323749-3-danielj@nvidia.com>
 <20240328133516.GK403975@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328133516.GK403975@kernel.org>

On Thu, Mar 28, 2024 at 01:35:16PM +0000, Simon Horman wrote:
> On Mon, Mar 25, 2024 at 04:49:09PM -0500, Daniel Jurgens wrote:
> > Allocate memory for the data when it's used. Ideally the could be on the
> > stack, but we can't DMA stack memory. With this change only the header
> > and status memory are shared between commands, which will allow using a
> > tighter lock than RTNL.
> > 
> > Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
> > Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> 
> ...
> 
> > @@ -3893,10 +3925,16 @@ static int virtnet_restore_up(struct virtio_device *vdev)
> >  
> >  static int virtnet_set_guest_offloads(struct virtnet_info *vi, u64 offloads)
> >  {
> > +	u64 *_offloads __free(kfree) = NULL;
> >  	struct scatterlist sg;
> > -	vi->ctrl->offloads = cpu_to_virtio64(vi->vdev, offloads);
> >  
> > -	sg_init_one(&sg, &vi->ctrl->offloads, sizeof(vi->ctrl->offloads));
> > +	_offloads = kzalloc(sizeof(*_offloads), GFP_KERNEL);
> > +	if (!_offloads)
> > +		return -ENOMEM;
> > +
> > +	*_offloads = cpu_to_virtio64(vi->vdev, offloads);
> 
> Hi Daniel,
> 
> There is a type mismatch between *_offloads and cpu_to_virtio64
> which is flagged by Sparse as follows:
> 
>  .../virtio_net.c:3978:20: warning: incorrect type in assignment (different base types)
>  .../virtio_net.c:3978:20:    expected unsigned long long [usertype]
>  .../virtio_net.c:3978:20:    got restricted __virtio64
> 
> I think this can be addressed by changing the type of *_offloads to
> __virtio64 *.


Yes pls, endian-ness is easier to get right 1st time than fix
afterwards.

> > +
> > +	sg_init_one(&sg, _offloads, sizeof(*_offloads));
> >  
> >  	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_GUEST_OFFLOADS,
> >  				  VIRTIO_NET_CTRL_GUEST_OFFLOADS_SET, &sg)) {
> > -- 
> > 2.42.0
> > 
> > 


