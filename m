Return-Path: <netdev+bounces-103094-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2887C90648C
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 09:00:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EFA2284F73
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 06:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B042013848F;
	Thu, 13 Jun 2024 06:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f5EgefON"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC4F137C44
	for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 06:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718261983; cv=none; b=Xsc1ZkkZ1EycbI5BJyARaSy2N7nu9vjQfXbG4I6+qfvK8BSgRsi/iCKOgDitwmM7uXYu1jzkhBYk16EBjz1Z3kgL+WnRRYn75a5TVHf86c/q7qzohqqunn0OLDh1DKZ05Df8322V/HG1Pu0yxhoEok7Wlu3hSgQHqAQCKojLqVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718261983; c=relaxed/simple;
	bh=pJwjntH5QMkuPUwNOFSmpR3KkB6NULCVjIIWybM6pWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g/aBeJxdx6k0VU+HD4hQIdU63fEalLCaa9CekdasPkUgOi48vIzH2FC2nDASYVQOIn5C3ARlXeSlkE+VZn2PSFAf4dmJ16r7iVMuYgy7cQQF3y/otVlJ/RlKX1Ia1WqJd62Cb+BnvuiwjPYfgx2TJuasK0JCshfzzjmAohYL/NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f5EgefON; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718261981;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=drA76IDECayT317ZaKBjGX9PcBu+0gorkvMz8yjsoxU=;
	b=f5EgefONps62rBo5pUFPiFLzm/ZE0EfF3NKzdHFm3+c5rMoT1Z+UlR4jELEQJW1RkESUHi
	unkZDXeV1e+peAZfwBm97yd+VNqjesGZThjmVMuE+c7XBlyuGKEW8SBKuo6TQCpX5OHCiT
	irOoWCc4BrYz1fbNa2yDigv1ck+jDQI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-GHWNTv63NcKPMq4vpZEQqA-1; Thu, 13 Jun 2024 02:59:36 -0400
X-MC-Unique: GHWNTv63NcKPMq4vpZEQqA-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-35f218c9950so396454f8f.0
        for <netdev@vger.kernel.org>; Wed, 12 Jun 2024 23:59:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718261974; x=1718866774;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=drA76IDECayT317ZaKBjGX9PcBu+0gorkvMz8yjsoxU=;
        b=wx8EjUpmEEsv115S9NURVYxwXlDwAlj95axfXJhlZL/gJ7VIiJRDKfBKVyFf7FrXRE
         yADn92E7424atZrzBhimDVuxu/FPMVPFfqHNKV6dWzk8CyF60+VpAFXhf1g7Kq0KCKXa
         8B/rj/XlTXL9OtDKKL/0VG/Fr2aQgdVeaoWoObNzvqXTGPwiz+axAG45mAY2kBEYnh9I
         ne8vixxoUxQ8v1QBhoTyXdAGS1F1h0W0wUxw+gzwgGJ9IjNb0wMTjW2cl0c6NQmP359d
         d4dPmaGmVCyQdKMKv1yVhzvUzwvbUPWLpuyrWfVHietNLc+3KuNZEs066PwSaLZwRPGm
         C36w==
X-Forwarded-Encrypted: i=1; AJvYcCVwn6RerjLYV3oDVqnOVWmhXhg/+wRxzNrrGqfzB0QM+aHOTFu3u1zO//ZoEq55KPLGF5JrMBFF5ywAOXgUOcN+mccLCvJ9
X-Gm-Message-State: AOJu0Yx7DWY2cWpfNKCg7wnr+hrega2iPChpMWH8VwofUUUS619F9Oo3
	xE6SB59x071nepCsrnHDNsNjyENbMs10GhjzQUMFkiByxYNf9/Bz3XqdRATMk5jPmqUUxsxwMNR
	uC+j51BJPmDveq0bLh8PGzgxX3hy6qmEopTOK/Nm8SS0WvEcmexgr4g==
X-Received: by 2002:adf:fc4a:0:b0:35f:1c26:b68d with SMTP id ffacd0b85a97d-35fe89433c6mr2681765f8f.60.1718261973680;
        Wed, 12 Jun 2024 23:59:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGTGddEYi8s6Uj9O8LtEdStBWBMju/uoZiQ7uYD8Sqxu92RawWDLo3ZDwPwDowpIYg8Keq/wg==
X-Received: by 2002:adf:fc4a:0:b0:35f:1c26:b68d with SMTP id ffacd0b85a97d-35fe89433c6mr2681752f8f.60.1718261973066;
        Wed, 12 Jun 2024 23:59:33 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:341:5539:9b1a:2e49:4aac:204e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-360750f22e8sm779696f8f.80.2024.06.12.23.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 23:59:32 -0700 (PDT)
Date: Thu, 13 Jun 2024 02:59:29 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: dtatulea@nvidia.com, jasowang@redhat.com,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH 1/2] vdpa: support set mac address from vdpa tool
Message-ID: <20240613025548-mutt-send-email-mst@kernel.org>
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



I think actually the idea of allowing provisioning
by specifying config of the device is actually valid.
However
- the name SET_CONFIG makes people think this allows
  writing even when e.g. device is assigned to guest
- having the internal api be mac specific is weird

Shouldn't config be an attribute maybe, not a new command?


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


