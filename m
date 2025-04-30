Return-Path: <netdev+bounces-187003-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14028AA46FC
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 11:27:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55F353A8676
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 09:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CACDC220689;
	Wed, 30 Apr 2025 09:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Af1zBx5q"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E9123504D
	for <netdev@vger.kernel.org>; Wed, 30 Apr 2025 09:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746005245; cv=none; b=UifMSvTjxYkygWcvbhskfYW2z+gQRn2Uhy4mwhE9J88praXcgPS4kdSrtqgxsKJDDU2tJS3x30xo1B2sFhpD0o6DWeCCukkVilizZgRWqgdOIfFX9X4Qaf+auxTnBJDdsE+uaPaosoQinfTZD4HOjsBq5MNMlEkBYAf+5qXb3EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746005245; c=relaxed/simple;
	bh=BwKXXL3PYQFTRZW+aG7URAo/jaI2DLZtA1xxXzSK0Ks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fSolH9R+MeFeNSsaFA73mLuntFx8S+vbsszjqxeAZAepLkN/Ry7FqV9XCWEURA/yutP/AyHJA+FWwaEVta/ILG4DM/2+BBF1xfp2Tj0Rd23yHKDGgWn6srpAJ988lfbQAm7uuhTPv7QuIM3ut0Tt/jBgupDNhpFfGs9pVZfDDOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Af1zBx5q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746005243;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+/eUi8mcDR2dtcgh0sHngZgam7Zp8nuaOnXZ0TH4FZE=;
	b=Af1zBx5qFy4XzxnBfpls9GBJzq84EG7M0/B+Q00ikKrNIP7rHaLrvSbQKNvYq9hrc0pNRg
	JFfwFOYrmaqZDbb92aaHCTwU6U3WwWJLFUc4t21xqHSfUVQDCZeUTI255qUpwZAeJSQKwY
	ysGWX1aMfoKw+FNbH+rBjnWLldcmdj8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-F8dZRKn0M5qgV4-Q6L9mrQ-1; Wed, 30 Apr 2025 05:27:21 -0400
X-MC-Unique: F8dZRKn0M5qgV4-Q6L9mrQ-1
X-Mimecast-MFC-AGG-ID: F8dZRKn0M5qgV4-Q6L9mrQ_1746005241
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43cf172ffe1so39393165e9.3
        for <netdev@vger.kernel.org>; Wed, 30 Apr 2025 02:27:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746005240; x=1746610040;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+/eUi8mcDR2dtcgh0sHngZgam7Zp8nuaOnXZ0TH4FZE=;
        b=ZrNm611YWqeXy/b5PfztEjvTShv4SfJMEskl4ZSa4rKz6ieOWMrwyVm5TduEAi3g34
         qRs/+iVLGv6URMaDjD5ztgFzE5MPSa8ChEWM3p6MIj4tXyv5Hul2o7xMyKMoJgaLBmB1
         J3JriR054oS0us+FiwcbnMOOVU12nskl2oa7ZNXMmL0KMUApeZyoIvGl1Oz/xoBVp+i2
         ilDaw/QpE98HpDpravxbfd5O+g+2E4K6DVyyQqhUHg7wOUvv/fbxMP10JWFuCfJRIYeA
         qfzArKHlmacz0hPUf3GX2qnHKY5ZHlmH+vj73FIa4VnBLZpnyJn9h6VX6eR9KW5joEtO
         4bsA==
X-Forwarded-Encrypted: i=1; AJvYcCVLaqPj6XMD7Zx6dbvr17JP2MKB6bDJvWhdbcmsT3LcROx2M3njCBXI8OBjukagKsIUh2RNGRQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwB+SUfdWi8EumCYgFl+kJKQiuwOBvgk3KQwWjUx4SldYek+i2e
	3p2HRXPNxbSmPtcqH8bam/NRAaB5Z9VvEj5n2/1yf6rp64UX9X1GYzN31TPAiG4HTyVQKWpe+YB
	XDoMjef1Dw8BFbG8ZSDEHUZSORJpcbK0/QuQhzh7QP3TtnyF92zY/jA==
X-Gm-Gg: ASbGnctFeeBxnY61V5y5MJuQWMGm2UZQAIBgiHTkxrSk1QNZmuJts+Uen/3V451riQb
	Vh+uFWvhLWd1HyIbBGeizAMAdpM++y9aru0gEZTqCNujvJpN3oDecWke/1YtQAbUHu2zqr2poFH
	8p4Y7pTD5qp3h3sM1SZHop8J6TWA+kzmcy4i802p7EeTaPKsLK9cBvPjnUtjskh/yQeN5WOciyl
	Oi0j85f4Zsfe5EuIA5UhxoxOTHKmo2SdE2q1AC6sVOEo6stVlWsGU7Wbn2D9QIdQDTU6uLP0M5n
	gw0PNA==
X-Received: by 2002:a05:600c:1d82:b0:43c:efed:732d with SMTP id 5b1f17b1804b1-441b265a216mr24126285e9.16.1746005240418;
        Wed, 30 Apr 2025 02:27:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZ0vZyPaRC1RprvkAzVN5EJdqn5u6WSue/8vY8l9DR5pd+MaYPUw+ILcM4tYuviqNUNWk6TA==
X-Received: by 2002:a05:600c:1d82:b0:43c:efed:732d with SMTP id 5b1f17b1804b1-441b265a216mr24125915e9.16.1746005240038;
        Wed, 30 Apr 2025 02:27:20 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441ae3ee26fsm40134145e9.1.2025.04.30.02.27.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 02:27:19 -0700 (PDT)
Date: Wed, 30 Apr 2025 05:27:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Cindy Lu <lulu@redhat.com>, michael.christie@oracle.com,
	sgarzare@redhat.com, linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [PATCH v9 4/4] vhost: Add a KConfig knob to enable IOCTL
 VHOST_FORK_FROM_OWNER
Message-ID: <20250430052424-mutt-send-email-mst@kernel.org>
References: <20250421024457.112163-1-lulu@redhat.com>
 <20250421024457.112163-5-lulu@redhat.com>
 <CACGkMEt-ewTqeHDMq847WDEGiW+x-TEPG6GTDDUbayVmuiVvzg@mail.gmail.com>
 <CACGkMEte6Lobr+tFM9ZmrDWYOpMtN6Xy=rzvTy=YxSPkHaVdPA@mail.gmail.com>
 <CACGkMEstbCKdHahYE6cXXu1kvFxiVGoBw3sr4aGs4=MiDE4azg@mail.gmail.com>
 <20250429065044-mutt-send-email-mst@kernel.org>
 <CACGkMEteBReoezvqp0za98z7W3k_gHOeSpALBxRMhjvj_oXcOw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEteBReoezvqp0za98z7W3k_gHOeSpALBxRMhjvj_oXcOw@mail.gmail.com>

On Wed, Apr 30, 2025 at 11:34:49AM +0800, Jason Wang wrote:
> On Tue, Apr 29, 2025 at 6:56 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Tue, Apr 29, 2025 at 11:39:37AM +0800, Jason Wang wrote:
> > > On Mon, Apr 21, 2025 at 11:46 AM Jason Wang <jasowang@redhat.com> wrote:
> > > >
> > > > On Mon, Apr 21, 2025 at 11:45 AM Jason Wang <jasowang@redhat.com> wrote:
> > > > >
> > > > > On Mon, Apr 21, 2025 at 10:45 AM Cindy Lu <lulu@redhat.com> wrote:
> > > > > >
> > > > > > Introduce a new config knob `CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL`,
> > > > > > to control the availability of the `VHOST_FORK_FROM_OWNER` ioctl.
> > > > > > When CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL is set to n, the ioctl
> > > > > > is disabled, and any attempt to use it will result in failure.
> > > > >
> > > > > I think we need to describe why the default value was chosen to be false.
> > > > >
> > > > > What's more, should we document the implications here?
> > > > >
> > > > > inherit_owner was set to false: this means "legacy" userspace may
> > > >
> > > > I meant "true" actually.
> > >
> > > MIchael, I'd expect inherit_owner to be false. Otherwise legacy
> > > applications need to be modified in order to get the behaviour
> > > recovered which is an impossible taks.
> > >
> > > Any idea on this?
> > >
> > > Thanks

So, let's say we had a modparam? Enough for this customer?
WDYT?

-- 
MST


