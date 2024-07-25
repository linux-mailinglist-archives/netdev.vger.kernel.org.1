Return-Path: <netdev+bounces-113046-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F7A493C7AA
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 19:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DC0B1C21F22
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 17:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC6A19DF76;
	Thu, 25 Jul 2024 17:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="O2jGFdIy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048B019D088
	for <netdev@vger.kernel.org>; Thu, 25 Jul 2024 17:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721928573; cv=none; b=j23DkG3AZn9eN4Dz7ET/pfo5CaAJCSlV8YSxtKnK9xit6D/r4Wx2uS/cuauRpcGF1pFF1+VS/nahXRGOt3ZTV+gG89k+TAi0LGqD+YI+EVcoZUaSylBOz88RSt15ywokGsTKTvejb4E4LIvKRnNhpJpW848XwoHVJntAjJtSXA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721928573; c=relaxed/simple;
	bh=N3FzGEoCIhOX3MFBjpVcDtNufAAiuEhtt2RKSDcX/g8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JxBJsd3LEmN8/G6GTG6DKtTM8s//06685z2E2YignI9eNrAzaCnmRf1ReJNhydrnxNo11/X0+Td1Y6ThVcfI1t0hgqHMsnowdGjhN1xJk8vXVZsPpxkCUcEF4ghmmCoSOiilwot/Dfh4vGLfKOaAx6q5P4TuhvvYX5c57s/kZq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=O2jGFdIy; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-70d23caf8ddso103348b3a.0
        for <netdev@vger.kernel.org>; Thu, 25 Jul 2024 10:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1721928570; x=1722533370; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NCayIjNrRvGhZM69uiC4OvAIpmWWFpkBAk0aaq4aSUc=;
        b=O2jGFdIyvpi1MpYCdZKrGZ0MiifPl3HGNTjFxylzbVMtUXnfEAKOZbddDzkQjHOWCd
         QwgA/uG1D+oOFYvDSGDw2pw1JLyHhXYV6OM813Xflb8x4dxT7FvwkOvcGHzN0zBtyS/0
         5S3iQrJWKYnDy1M+5Alc1RvROm+B5gW6Y43G8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721928570; x=1722533370;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NCayIjNrRvGhZM69uiC4OvAIpmWWFpkBAk0aaq4aSUc=;
        b=pKFYJZhD9kcff0W1CtoknmmRZQzyeFbp+XAdEwT38aSf6yt0M4J7J6KC+fwWnquPh4
         L4W1Bnhk+V/7PmgYmeKqohGXVWnU57M8PNu44RjTf+ue0lertYbEia6GhywOmd+RkiEk
         wFgATSbIN3rKuvxGVaPbjSwFdSlWY82gLHJ2PziNjFvpGTwE3gz955Zdy/B/9ZNTmwpi
         J0S5Y0F/be+88+2y7sR94S9JcW3v5kTr//egqpjqC39W9cP2vGgT/+UcG1MbQvwqLp/L
         D2PGE9iAvG0o8iLa8Nx5hRwP9xo3Wq3FLKdCk1iV5yNDELlURWgKOhwE1R8gOiomgrE8
         btmw==
X-Forwarded-Encrypted: i=1; AJvYcCWNORlO3k32FLkD4GL/LJSrWMnvLWN4M0w54z5+aFGO60HNbHOkXVWqsYAonsctGE7p4S65pmj1bBgLu1XnWNOefMkNmZA5
X-Gm-Message-State: AOJu0YxtnkShlfTxI5AUxnjaX7Zderm/DKCyIUCPCImMmCa92E+gGAo3
	vWE+Bh+DBpC4hmNvTY6f4ZnATrfjJetvKFSoRp3J0RZUU6kuo/wdESr06ZEXKUs=
X-Google-Smtp-Source: AGHT+IECBP9wZR8j26b0macyKUl4ggCAjT7AsfbXpSQ5VAO6+8FmebHqn7MrPbu8eT1i5p5fen8o5A==
X-Received: by 2002:a05:6a21:a4c1:b0:1c0:ede4:9a73 with SMTP id adf61e73a8af0-1c47b144bcemr3103021637.7.1721928570204;
        Thu, 25 Jul 2024 10:29:30 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead81168csm1376517b3a.112.2024.07.25.10.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 10:29:29 -0700 (PDT)
Date: Thu, 25 Jul 2024 10:29:27 -0700
From: Joe Damato <jdamato@fastly.com>
To: Cindy Lu <lulu@redhat.com>
Cc: dtatulea@nvidia.com, mst@redhat.com, jasowang@redhat.com,
	parav@nvidia.com, sgarzare@redhat.com, netdev@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATH v6 1/3] vdpa: support set mac address from vdpa tool
Message-ID: <ZqKLd9ZIJ4l5tAL8@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Cindy Lu <lulu@redhat.com>, dtatulea@nvidia.com, mst@redhat.com,
	jasowang@redhat.com, parav@nvidia.com, sgarzare@redhat.com,
	netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
References: <20240725013217.1124704-1-lulu@redhat.com>
 <20240725013217.1124704-2-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240725013217.1124704-2-lulu@redhat.com>

On Thu, Jul 25, 2024 at 09:31:02AM +0800, Cindy Lu wrote:
[...]
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index 8d391947eb8d..532cf3b52b26 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -1361,6 +1361,81 @@ static int vdpa_nl_cmd_dev_config_get_doit(struct sk_buff *skb, struct genl_info
>  	return err;
>  }
>  
> +static int vdpa_dev_net_device_attr_set(struct vdpa_device *vdev,
> +					struct genl_info *info)
> +{
> +	struct vdpa_dev_set_config set_config = {};
> +	const u8 *macaddr;
> +	struct vdpa_mgmt_dev *mdev = vdev->mdev;
> +	struct nlattr **nl_attrs = info->attrs;
> +	int err = -EINVAL;

Nit: IIRC networking code prefers reverse-xmas tree style and
macaddr above needs to be moved.

> +	down_write(&vdev->cf_lock);
> +	if (nl_attrs[VDPA_ATTR_DEV_NET_CFG_MACADDR]) {
> +		set_config.mask |= BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MACADDR);
> +		macaddr = nla_data(nl_attrs[VDPA_ATTR_DEV_NET_CFG_MACADDR]);
> +
> +		if (is_valid_ether_addr(macaddr)) {
> +			ether_addr_copy(set_config.net.mac, macaddr);
> +			memcpy(set_config.net.mac, macaddr, ETH_ALEN);
> +			if (mdev->ops->dev_set_attr) {
> +				err = mdev->ops->dev_set_attr(mdev, vdev,
> +							      &set_config);
> +			} else {
> +				NL_SET_ERR_MSG_FMT_MOD(
> +					info->extack,
> +					"device does not support changing the MAC address");
> +			}
> +		} else {
> +			NL_SET_ERR_MSG_FMT_MOD(info->extack,
> +					       "Invalid MAC address");
> +		}
> +	}
> +	up_write(&vdev->cf_lock);
> +	return err;
> +}

Nit: other code in this file has line breaks separating functions.
Probably good to add one here?


> +static int vdpa_nl_cmd_dev_attr_set_doit(struct sk_buff *skb,
> +					 struct genl_info *info)

Nit: Does the above pass ./scripts/checkpatch.pl --strict ? I am asking
because it seems like the alignment might be off?

> +{
> +	const char *name;
> +	int err = 0;
> +	struct device *dev;
> +	struct vdpa_device *vdev;
> +	u64 classes;

Nit: Same as above; I believe networking code is supposed to follow
reverse xmas tree order so these variables should be rearranged.

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
> +		NL_SET_ERR_MSG_MOD(info->extack, "unmanaged vdpa device");
> +		err = -EINVAL;
> +		goto mdev_err;
> +	}
> +	classes = vdpa_mgmtdev_get_classes(vdev->mdev, NULL);
> +	if (classes & BIT_ULL(VIRTIO_ID_NET)) {
> +		err = vdpa_dev_net_device_attr_set(vdev, info);
> +	} else {
> +		NL_SET_ERR_MSG_FMT_MOD(info->extack, "%s device not supported",
> +				       name);
> +	}
> +
> +mdev_err:
> +	put_device(dev);
> +dev_err:
> +	up_write(&vdpa_dev_lock);
> +	return err;
> +}

[...]

