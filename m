Return-Path: <netdev+bounces-102798-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B2E8904C79
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 09:13:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 902951C22ADC
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 07:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4E5E16C688;
	Wed, 12 Jun 2024 07:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UmtWoIxV"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A724167DA4
	for <netdev@vger.kernel.org>; Wed, 12 Jun 2024 07:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718176378; cv=none; b=c1HJMrPzFYFIzZXVrMMHAxpDUxr7VNsScJ5F2yk8XtXJW2U7NFwAW+eHVrEx8HoN06hGvj9H+P47GxqRzkwngYCaJ8QPsXWtnE5W6+j9Sz08XTXzeplTiHvZ3fsRHGj1wrduGLk2BEtS0pNSMorlLwESEYwN6LPDMzMEisMqX48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718176378; c=relaxed/simple;
	bh=FJ9BTeEbejPctTmHZIUK+28zrcodhwdsqUv2ldy1WOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lU3s42BMwBZyda4/FH4uxmAT27XgXvf1P0705QXm4M0RcNFDtl1FTL42t9S69KsGYNBcwpT6N8oIrqNcVkQt4p6EgWyhRlZfDaRILgBs8kSnAnxymgeipaTOlY1MYumpa0rRdRRUnNkiTThgvd7quMxpD28cS8EJo2aBJ0yZZwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UmtWoIxV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718176375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0AdGqhESB7FcgdEdVmtQDKt7grmbOEq0F0SyTtNx6No=;
	b=UmtWoIxVF1/JS1X2UzSDurRwRpp/e65Zxu9bfvdaViq8pNfwxS03wf1hUGiUf/S0UNlSp9
	3u3FoQzFtI31UPcfMIld/SJ9yyWqaZX68QX/FuZqF+HWIJjTw/62VnKyHYZHoPUKGnin8r
	YEQiXrz0yFxcNBcIfUhqPoRDzWDMHy8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-258-Blp1TfghNVicUvuaMkRaNw-1; Wed, 12 Jun 2024 03:12:53 -0400
X-MC-Unique: Blp1TfghNVicUvuaMkRaNw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4212e2a3a1bso48543845e9.3
        for <netdev@vger.kernel.org>; Wed, 12 Jun 2024 00:12:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718176372; x=1718781172;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0AdGqhESB7FcgdEdVmtQDKt7grmbOEq0F0SyTtNx6No=;
        b=ap7tHpO/JLdSzXBc++sD/Elxl16r7hye+RzFjlb1xKLC5PBWbmXLum1YgYNa8gRqpN
         yumz6vGiNN1EsXX4DCaVhwRfYcR6w6s9OQrpU4aokD7Hgf+3Gb30HkE/6afmtCCx/s/Y
         hj7CCK5jjJJIWdvKA03rhEMii6R1vW5QcSXPk0bj8zBs/gn2rZqiujWMhnQT9+7sItON
         rDUbPq0gDoivDNPof9d6HdHvn3sl1mF1tAL/fqM5yL/SnY+sx9wqxe83rbrpj+SgmMmU
         mAhD16cKaRjNuq2UErAmvHAYKLVxtZ8z6E3jPwdlssHbCLXaRgE/IgFpEkbqly/Pt6K3
         ZXmw==
X-Forwarded-Encrypted: i=1; AJvYcCXrVz+4tssJlr3yb+N38X5b8LN+Fctvk5k6+p6P/Gp5FNV5uxsuNzcrzr6uD6ZIM/joRn2HBoHRz38QpXtZVXdGCxDa6CDM
X-Gm-Message-State: AOJu0YzXca6oP9Bpe+//A1sv3gq2k6acicSsScfI/yNYRTmdW4rAgpLg
	U2sga645ph22vzgtErKFrN0Wjy6Cz3Ox+NvjGVE//YSwvhJ66Bc3HcsXn0QHgXT3ILXzcHvJMSE
	QxDmVk1mYircH3vMvKFFV96E+gnVzF+8MujjJUczK4P5UsWDa1vcIEQ==
X-Received: by 2002:a05:600c:3552:b0:421:7be5:f318 with SMTP id 5b1f17b1804b1-422867c0408mr7204715e9.33.1718176371845;
        Wed, 12 Jun 2024 00:12:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGphusi1X4I6zrV9eu6daKqPEPomJK6FFUdfburgBDZrRG2/0lanC4F2ufq6sccZD88eQM6rQ==
X-Received: by 2002:a05:600c:3552:b0:421:7be5:f318 with SMTP id 5b1f17b1804b1-422867c0408mr7204415e9.33.1718176371029;
        Wed, 12 Jun 2024 00:12:51 -0700 (PDT)
Received: from redhat.com ([2a02:14f:178:39eb:4161:d39d:43e6:41f8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422874de5d5sm13703115e9.33.2024.06.12.00.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 00:12:50 -0700 (PDT)
Date: Wed, 12 Jun 2024 03:12:47 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: dtatulea@nvidia.com, jasowang@redhat.com,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH 1/2] vdpa: support set mac address from vdpa tool
Message-ID: <20240612014143-mutt-send-email-mst@kernel.org>
References: <20240611053239.516996-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611053239.516996-1-lulu@redhat.com>

On Tue, Jun 11, 2024 at 01:32:32PM +0800, Cindy Lu wrote:
> Add new UAPI to support the mac address from vdpa tool

The patch does not do what commit log says.
Instead there's an internal API to set mac and
a UAPI to write into config space.

> Function vdpa_nl_cmd_dev_config_set_doit() will get the
> MAC address from the vdpa tool and then set it to the device.
> 
> The usage is: vdpa dev set name vdpa_name mac **:**:**:**:**:**
> 
> Here is sample:
> root@L1# vdpa -jp dev config show vdpa0
> {
>     "config": {
>         "vdpa0": {
>             "mac": "82:4d:e9:5d:d7:e6",
>             "link ": "up",
>             "link_announce ": false,
>             "mtu": 1500
>         }
>     }
> }
> 
> root@L1# vdpa dev set name vdpa0 mac 00:11:22:33:44:55
> 
> root@L1# vdpa -jp dev config show vdpa0
> {
>     "config": {
>         "vdpa0": {
>             "mac": "00:11:22:33:44:55",
>             "link ": "up",
>             "link_announce ": false,
>             "mtu": 1500
>         }
>     }
> }
> 
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  drivers/vdpa/vdpa.c       | 71 +++++++++++++++++++++++++++++++++++++++
>  include/linux/vdpa.h      |  2 ++
>  include/uapi/linux/vdpa.h |  1 +
>  3 files changed, 74 insertions(+)
> 
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index a7612e0783b3..347ae6e7749d 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -1149,6 +1149,72 @@ static int vdpa_nl_cmd_dev_config_get_doit(struct sk_buff *skb, struct genl_info
>  	return err;
>  }
>  
> +static int vdpa_nl_cmd_dev_config_set_doit(struct sk_buff *skb,
> +					   struct genl_info *info)
> +{
> +	struct vdpa_dev_set_config set_config = {};
> +	struct nlattr **nl_attrs = info->attrs;
> +	struct vdpa_mgmt_dev *mdev;
> +	const u8 *macaddr;
> +	const char *name;
> +	int err = 0;
> +	struct device *dev;
> +	struct vdpa_device *vdev;
> +
> +	if (!info->attrs[VDPA_ATTR_DEV_NAME])
> +		return -EINVAL;
> +
> +	name = nla_data(info->attrs[VDPA_ATTR_DEV_NAME]);
> +
> +	down_write(&vdpa_dev_lock);
> +	dev = bus_find_device(&vdpa_bus, NULL, name, vdpa_name_match);
> +	if (!dev) {
> +		NL_SET_ERR_MSG_MOD(info->extack, "device not found");
> +		err = -ENODEV;
> +		goto dev_err;
> +	}
> +	vdev = container_of(dev, struct vdpa_device, dev);
> +	if (!vdev->mdev) {
> +		NL_SET_ERR_MSG_MOD(
> +			info->extack,
> +			"Fail to find the specified management device");
> +		err = -EINVAL;
> +		goto mdev_err;
> +	}
> +	mdev = vdev->mdev;
> +	if (nl_attrs[VDPA_ATTR_DEV_NET_CFG_MACADDR]) {
> +		if (!(mdev->supported_features & BIT_ULL(VIRTIO_NET_F_MAC))) {


Seems to poke at a device without even making sure it's a network
device.

> +			NL_SET_ERR_MSG_FMT_MOD(
> +				info->extack,
> +				"Missing features 0x%llx for provided attributes",
> +				BIT_ULL(VIRTIO_NET_F_MAC));
> +			err = -EINVAL;
> +			goto mdev_err;
> +		}
> +		macaddr = nla_data(nl_attrs[VDPA_ATTR_DEV_NET_CFG_MACADDR]);
> +		memcpy(set_config.net.mac, macaddr, ETH_ALEN);
> +		set_config.mask |= BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MACADDR);
> +		if (mdev->ops->set_mac) {
> +			err = mdev->ops->set_mac(mdev, vdev, &set_config);
> +		} else {
> +			NL_SET_ERR_MSG_FMT_MOD(
> +				info->extack,
> +				"%s device not support set mac address ", name);
> +		}
> +
> +	} else {
> +		NL_SET_ERR_MSG_FMT_MOD(info->extack,
> +				       "%s device not support this config ",
> +				       name);
> +	}
> +
> +mdev_err:
> +	put_device(dev);
> +dev_err:
> +	up_write(&vdpa_dev_lock);
> +	return err;
> +}
> +
>  static int vdpa_dev_config_dump(struct device *dev, void *data)
>  {
>  	struct vdpa_device *vdev = container_of(dev, struct vdpa_device, dev);
> @@ -1285,6 +1351,11 @@ static const struct genl_ops vdpa_nl_ops[] = {
>  		.doit = vdpa_nl_cmd_dev_stats_get_doit,
>  		.flags = GENL_ADMIN_PERM,
>  	},
> +	{
> +		.cmd = VDPA_CMD_DEV_CONFIG_SET,
> +		.doit = vdpa_nl_cmd_dev_config_set_doit,
> +		.flags = GENL_ADMIN_PERM,
> +	},
>  };
>  
>  static struct genl_family vdpa_nl_family __ro_after_init = {
> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> index db15ac07f8a6..c97f4f1da753 100644
> --- a/include/linux/vdpa.h
> +++ b/include/linux/vdpa.h
> @@ -581,6 +581,8 @@ struct vdpa_mgmtdev_ops {
>  	int (*dev_add)(struct vdpa_mgmt_dev *mdev, const char *name,
>  		       const struct vdpa_dev_set_config *config);
>  	void (*dev_del)(struct vdpa_mgmt_dev *mdev, struct vdpa_device *dev);
> +	int (*set_mac)(struct vdpa_mgmt_dev *mdev, struct vdpa_device *dev,
> +		       const struct vdpa_dev_set_config *config);


Well, now vdpa_mgmtdev_ops which was completely generic is growing
a net specific interface. Which begs a question - how is this
going to work with other device types?

>  };
>  
>  /**
> diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h
> index 54b649ab0f22..53f249fb26bc 100644
> --- a/include/uapi/linux/vdpa.h
> +++ b/include/uapi/linux/vdpa.h
> @@ -19,6 +19,7 @@ enum vdpa_command {
>  	VDPA_CMD_DEV_GET,		/* can dump */
>  	VDPA_CMD_DEV_CONFIG_GET,	/* can dump */
>  	VDPA_CMD_DEV_VSTATS_GET,
> +	VDPA_CMD_DEV_CONFIG_SET,
>  };
>  
>  enum vdpa_attr {
> -- 
> 2.45.0


