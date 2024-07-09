Return-Path: <netdev+bounces-110136-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 045F492B137
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 09:35:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 361B41C20D34
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 07:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B00D142E78;
	Tue,  9 Jul 2024 07:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VerlCW4B"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19A8482E2
	for <netdev@vger.kernel.org>; Tue,  9 Jul 2024 07:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720510511; cv=none; b=B9gBAm02bXsKNSDbV1ISCP6mJJD9l+dJw+eEs7ClLvYqCrvv3wkxzu4ZpM5ktfWdA7Q5anoGz3n/xVHOaZoXsX7zxwVomvf51bd0XnnrlVN+IbpUerm1GmW7YLm0epVNPzVWJg9g7pEI7xeaAfwfkMP3OopUq6vKOCLu+tj6v9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720510511; c=relaxed/simple;
	bh=DdRhbICaef9j8HkGlMP5Bgg0eQtDwpCDC9yQaq+5/6o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VNmX/Z0kkxPns6xB1Z1KDJc2by2ohoz/r76KmYTlRlFscPoxu2nJDwzQhdGhrhdzgsrPxYBDGMFvnlYE7WIWKLx06bajnMFOgsJqUh9kEa4zqJQs7CXBfzlvA5TamxinflEJS5HzAOxEDhZrh8n5CAwpm2aykx4Ih0FDnhdN8NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VerlCW4B; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720510509;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EIqC2mqFe9C8xKJMg5ba5cK9RsFhYLPxtTQe6Ed06hU=;
	b=VerlCW4BpO2V6xM4rUWVeZktEk9+kwHOE9Wd291p773K2o0zg+LNqC3+WsUfyaqS1npD7K
	vThnoaJ980nTNJ2w9zeuGfQVkaYXE7pmPSMduFfZQUe1jvLrCl62qPrg5wN0s1FE134YVs
	57aBiVJZ1HC72N0jXsHDUOCpi4jNLxc=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-ixTzXSaONZmHQgTs2wsNBA-1; Tue, 09 Jul 2024 03:35:07 -0400
X-MC-Unique: ixTzXSaONZmHQgTs2wsNBA-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-58e847f01f7so4032469a12.1
        for <netdev@vger.kernel.org>; Tue, 09 Jul 2024 00:35:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720510506; x=1721115306;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EIqC2mqFe9C8xKJMg5ba5cK9RsFhYLPxtTQe6Ed06hU=;
        b=TjGKxGhWOue1bU/+bkm/S559sl2j6jE4MRGPEGHAo+AL6hd+97TlaV8VG4mUOmLBsc
         DsbjFsdA/0qP9gJdiCia5cG2cbDSzyzuhseroZVSR8FpmBZUyLOQ+zYR7UzepdtXEJ+c
         xi3IqiydoWgC0X65o++u1DY6kHMfVDHpK9I5Gqf/fYhaR15GbQ7zbLMVYZ1kRyaKjeSA
         argHw5fnFkP/yPpQEfgU+EjnK9QtI3tIM8gwdl3icMoc+KHLNIQQoMsgV+dRJTYmbtnX
         0kQmZf2jp4HGnpYPMfbcDMpQAikul/hewfiDz2HHSUNtLZAXRjaEehWnsVJ4bHUzSpde
         aW9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVBYB8LNFXRfSXkaDWO4MbMcLMQZJfMUpurwkYnJM+aLDZCJItIKkmwUBR2g4bY3bIFvCrumoYOSyhYpXlCibcLsew87Miz
X-Gm-Message-State: AOJu0YyhlJu1IvcECj+wn/uygPlEcJAD5jfX42wqrZNmvrUkqPkf0HmX
	4xW07lISt9Mw1ZsagKELuwfN5OhdCN1dtt+OGv/iqt5kXa7Xpxk53L8wNqu75Q3kdlrzI7qeSuc
	S36ypw9PDAU4+XZyxn5L1qhvj/rryxmNk5yANtZXVV7Ld/n64izvSE2wHFwwvswB3jASotqYnlH
	IFZWY2DVKXdvlD75QA7URVANnJdIhH
X-Received: by 2002:a05:6402:2742:b0:57c:610a:6e7f with SMTP id 4fb4d7f45d1cf-594baf8719fmr1467712a12.11.1720510506315;
        Tue, 09 Jul 2024 00:35:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEprGNtKtwZjWwZDrHR9spCqEFHlNDxGO/hw7rYsSyBxth5QJJ9oylIOl12jUvsQu4A55DuFRtIjAqAaxCAus8=
X-Received: by 2002:a05:6402:2742:b0:57c:610a:6e7f with SMTP id
 4fb4d7f45d1cf-594baf8719fmr1467693a12.11.1720510505896; Tue, 09 Jul 2024
 00:35:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240708065549.89422-1-lulu@redhat.com> <20240708072603-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240708072603-mutt-send-email-mst@kernel.org>
From: Cindy Lu <lulu@redhat.com>
Date: Tue, 9 Jul 2024 15:34:28 +0800
Message-ID: <CACLfguU2OakNJPO6pR6V7D4SV0-VvC=okqDcwutMPztTUweMZA@mail.gmail.com>
Subject: Re: [PATCH] vdpa/mlx5: Add the support of set mac address
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: dtatulea@nvidia.com, jasowang@redhat.com, parav@nvidia.com, 
	sgarzare@redhat.com, netdev@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 8 Jul 2024 at 19:26, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Mon, Jul 08, 2024 at 02:55:49PM +0800, Cindy Lu wrote:
> > Add the function to support setting the MAC address.
> > For vdpa/mlx5, the function will use mlx5_mpfs_add_mac
> > to set the mac address
> >
> > Tested in ConnectX-6 Dx device
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
>
> Is this on top of your other patchset?
>
yes, Will send a new version of these patch
Thanks
cindy
> > ---
> >  drivers/vdpa/mlx5/net/mlx5_vnet.c | 23 +++++++++++++++++++++++
> >  1 file changed, 23 insertions(+)
> >
> > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > index 26ba7da6b410..f78701386690 100644
> > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > @@ -3616,10 +3616,33 @@ static void mlx5_vdpa_dev_del(struct vdpa_mgmt_dev *v_mdev, struct vdpa_device *
> >       destroy_workqueue(wq);
> >       mgtdev->ndev = NULL;
> >  }
> > +static int mlx5_vdpa_set_attr_mac(struct vdpa_mgmt_dev *v_mdev,
> > +                               struct vdpa_device *dev,
> > +                               const struct vdpa_dev_set_config *add_config)
> > +{
> > +     struct mlx5_vdpa_dev *mvdev = to_mvdev(dev);
> > +     struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
> > +     struct mlx5_core_dev *mdev = mvdev->mdev;
> > +     struct virtio_net_config *config = &ndev->config;
> > +     int err;
> > +     struct mlx5_core_dev *pfmdev;
> > +
> > +     if (add_config->mask & (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR)) {
> > +             if (!is_zero_ether_addr(add_config->net.mac)) {
> > +                     memcpy(config->mac, add_config->net.mac, ETH_ALEN);
> > +                     pfmdev = pci_get_drvdata(pci_physfn(mdev->pdev));
> > +                     err = mlx5_mpfs_add_mac(pfmdev, config->mac);
> > +                     if (err)
> > +                             return -1;
> > +             }
> > +     }
> > +     return 0;
> > +}
> >
> >  static const struct vdpa_mgmtdev_ops mdev_ops = {
> >       .dev_add = mlx5_vdpa_dev_add,
> >       .dev_del = mlx5_vdpa_dev_del,
> > +     .dev_set_attr = mlx5_vdpa_set_attr_mac,
> >  };
> >
> >  static struct virtio_device_id id_table[] = {
> > --
> > 2.45.0
>


