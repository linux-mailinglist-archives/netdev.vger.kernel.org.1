Return-Path: <netdev+bounces-112577-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE6F939FF5
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 13:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D515282AE1
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 11:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B24152170;
	Tue, 23 Jul 2024 11:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e5Sivuk+"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DCC1514F0
	for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 11:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721734161; cv=none; b=BTmYUOA6KqGepfeSBawnSmDhMlpew151wIRxkC5Ckw5VuapFFJCw3bgfmUAY4VrCLLCtmdTIWETm26gUVd49sAiP+KuVIx7OAMzkg0zpjOgJOXW2wrmbftPK9yfDt01etYhnWrhD5U8he1PJkRSYNY8kPlgAcKCfhxFJwIDSQrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721734161; c=relaxed/simple;
	bh=ywiEz9lNEQ9WmelnvEr3eWbFdDAiCBnoLZvMkLA1J4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=czg+ey+uRbADXgbBlSdSiYNjZLwSi1ce1z2r9iaaglVHh4tnWvN7dE4JZAre4k5MtXxxsPMpeuYY+SR8eArm3V4Lr4UrH8XjD0nSYo/6w8oXXYOQhD8BZn+gxmnGCyqE4Nzn+fN0R5QSoc+d3e9eJ3WBH75cY/7UR7E+wSIgRY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e5Sivuk+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721734157;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s7jCTUnDItxD8cjWWIIoCSjBuZfVeWntboTVzts3D7o=;
	b=e5Sivuk+nWDQ0HAb/BI0zSBSRfWxO6KoYZV1tP64ES3MI2IwcNp/SLk8lhGICnn62Zt6Qi
	eI1JKSSznUclq5WDRE8DOgnJWkYpOWj1V3iclN2pvqn26fROBqKMPdlqpYTQSXqLyozPve
	+QneSasEGWNsKrIdj8yO5Fh0/nov2sU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-536-erMMg4stOfa9fCal-8ojGQ-1; Tue, 23 Jul 2024 07:29:16 -0400
X-MC-Unique: erMMg4stOfa9fCal-8ojGQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4279c75c44dso38722255e9.2
        for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 04:29:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721734155; x=1722338955;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s7jCTUnDItxD8cjWWIIoCSjBuZfVeWntboTVzts3D7o=;
        b=MFhXVGcwZ7kD5XvOM3g01WfaXrp9Ly8WXCkPUWA+MKeje7ek4zHWP5rpyO/zYnKRVq
         xvQnZDtQa0pCjKB2Okl667ruvo25GqKhaEyPpBuI8WaypSU/vuxHkRGDaOswwH/1A9Q0
         LjO3/Bc+oG9yoM4zmPPO7eUkwTIdshVoXjPTu3lYN7PMjvMzpTMqkhJdo+S5+5/TkLEP
         FYkbOz+RvOkKRw2v5NPBFdEunu05a88KAyHSVvcadhBighNFv8Ae2pHy4ZTYQcdfxG6O
         pJa6Tk1Pap/8rLCESv129DXKLOZ2DqSKd1YeEMHX3f+ApdBWnTCk5UX8kTNRLc7otU66
         qNxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUg7JGhuUVnCV8lgoYcrOyzIWjFBzTEP1j8jWvO42VQAUbl5sJbApRqYsBqfZtwQnew2beDS0Xf4o2vtrKiQ+fpyzZgSPdj
X-Gm-Message-State: AOJu0YwfRh8U7juSRINjLrHczhPGQtYGejRlT9gx+ObTmKM63MrTYDi/
	8QT7NcZuZh1gtS3JUWDHTTJ0e476Uz8Ddrc/H59qibYJkUM24c5JCXwmM/DLI7GQaIumql4ONg+
	Qx9G4TVqadpunAGh7mHFV+bBSyleaQsv6X9IS7Sr5Hf4SzNNM/Usagw==
X-Received: by 2002:a05:600c:198a:b0:426:5ef5:bcb1 with SMTP id 5b1f17b1804b1-427dc516030mr62453885e9.6.1721734155393;
        Tue, 23 Jul 2024 04:29:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEy8f4+JM8Dv9qpEpAG+F85IIgy6v0jInHBiNNS5aGKN9kSnvuaOCv+YAidUy3L2q08C0jGsg==
X-Received: by 2002:a05:600c:198a:b0:426:5ef5:bcb1 with SMTP id 5b1f17b1804b1-427dc516030mr62453655e9.6.1721734154739;
        Tue, 23 Jul 2024 04:29:14 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:440:9c9a:ffee:509d:1766:aa7f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d2a95530sm187309455e9.45.2024.07.23.04.29.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 04:29:14 -0700 (PDT)
Date: Tue, 23 Jul 2024 07:29:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: Parav Pandit <parav@nvidia.com>,
	"sgarzare@redhat.com" <sgarzare@redhat.com>,
	"virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"lulu@redhat.com" <lulu@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"jasowang@redhat.com" <jasowang@redhat.com>
Subject: Re: [PATH v5 3/3] vdpa/mlx5: Add the support of set mac address
Message-ID: <20240723072712-mutt-send-email-mst@kernel.org>
References: <20240723054047.1059994-1-lulu@redhat.com>
 <20240723054047.1059994-4-lulu@redhat.com>
 <d8031e518cf47c57c31b903cb9613692bbff7d0d.camel@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8031e518cf47c57c31b903cb9613692bbff7d0d.camel@nvidia.com>

On Tue, Jul 23, 2024 at 07:49:44AM +0000, Dragos Tatulea wrote:
> On Tue, 2024-07-23 at 13:39 +0800, Cindy Lu wrote:
> > Add the function to support setting the MAC address.
> > For vdpa/mlx5, the function will use mlx5_mpfs_add_mac
> > to set the mac address
> > 
> > Tested in ConnectX-6 Dx device
> > 
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
> >  drivers/vdpa/mlx5/net/mlx5_vnet.c | 28 ++++++++++++++++++++++++++++
> >  1 file changed, 28 insertions(+)
> > 
> > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > index ecfc16151d61..7fce952d650f 100644
> > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > @@ -3785,10 +3785,38 @@ static void mlx5_vdpa_dev_del(struct vdpa_mgmt_dev *v_mdev, struct vdpa_device *
> >  	destroy_workqueue(wq);
> >  	mgtdev->ndev = NULL;
> >  }
> > +static int mlx5_vdpa_set_attr(struct vdpa_mgmt_dev *v_mdev,
> > +			      struct vdpa_device *dev,
> > +			      const struct vdpa_dev_set_config *add_config)
> > +{
> > +	struct virtio_net_config *config;
> > +	struct mlx5_core_dev *pfmdev;
> > +	struct mlx5_vdpa_dev *mvdev;
> > +	struct mlx5_vdpa_net *ndev;
> > +	struct mlx5_core_dev *mdev;
> > +	int err = -EINVAL;
> > +
> > +	mvdev = to_mvdev(dev);
> > +	ndev = to_mlx5_vdpa_ndev(mvdev);
> > +	mdev = mvdev->mdev;
> > +	config = &ndev->config;
> > +
> > +	down_write(&ndev->reslock);
> > +	if (add_config->mask & (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR)) {
> > +		pfmdev = pci_get_drvdata(pci_physfn(mdev->pdev));
> > +		err = mlx5_mpfs_add_mac(pfmdev, config->mac);
> > +		if (0 == err)
> if (!err) would be nicer. Not a deal breaker though.

	yes, no yodda style please. It, I can not stand.


> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> 
> > +			memcpy(config->mac, add_config->net.mac, ETH_ALEN);
> > +	}
> > +
> > +	up_write(&ndev->reslock);
> > +	return err;
> > +}
> >  
> >  static const struct vdpa_mgmtdev_ops mdev_ops = {
> >  	.dev_add = mlx5_vdpa_dev_add,
> >  	.dev_del = mlx5_vdpa_dev_del,
> > +	.dev_set_attr = mlx5_vdpa_set_attr,
> >  };
> >  
> >  static struct virtio_device_id id_table[] = {
> 


