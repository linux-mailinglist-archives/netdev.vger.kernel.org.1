Return-Path: <netdev+bounces-241310-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C2986C82A57
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 23:28:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F250834A97A
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 22:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2CBB257448;
	Mon, 24 Nov 2025 22:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CQUReWhK";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="g0r1o8rD"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C122938D
	for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 22:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764023283; cv=none; b=ByAY4pXPFlBhCUBFWNi5pnU5eTJaB8rwOokvCwsyUqWeBDOyxg5wbkPRdk3uXzFLxL6Za6y0VN2sUQBY0dM+5A+bKdStYeBOVn3hmynLu7TtiZtbP2W0NVVuPuVGFjejziYNfGCmHIEw2kdD9JlKTKapo5ZnepJV6iCTeAc5+jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764023283; c=relaxed/simple;
	bh=O9s1c+Soea+oLRUDpv8yyvhGXWT6wRd+L4jrFY5ezLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cz2/CSmsna5jjbu4R8hIWocsNLsSttKjVxZ7AHuGpyZnQTfPFnZx7E+b3U6sbqNUHf5AzvuNJ4N75hqNcJII26FNd75IOcN10Zz3YzSUD0JEKp3OYHjYjOP5UDqIrwqihXqbP7mtWIu+/bIoZmxFPnpThpKEPwXtAE/chzG0AzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CQUReWhK; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=g0r1o8rD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764023280;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HXYvmDv4kppfCO9Fqm1r8b7arvwMaa5NeNnEMmc451k=;
	b=CQUReWhK2aB3nhf0qc3/mj1RBbru1mF7/4FktcfXfidKUU0UPK1s8evbIW7WXaRmsWbz4c
	G1CyYh0dDxayRGwcrR3tXSK6mSx33wBgk6eRVszIv9fSlVET2QLLLnRGPyA/kUUqmDCAV2
	ugjk0gZYO9zcU4KnC+RHM2vfEKXlMU4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-126-mFZ2T7jSOIm0Rz6C7gglrg-1; Mon, 24 Nov 2025 17:27:59 -0500
X-MC-Unique: mFZ2T7jSOIm0Rz6C7gglrg-1
X-Mimecast-MFC-AGG-ID: mFZ2T7jSOIm0Rz6C7gglrg_1764023278
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4779b3749a8so41675145e9.1
        for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 14:27:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764023278; x=1764628078; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HXYvmDv4kppfCO9Fqm1r8b7arvwMaa5NeNnEMmc451k=;
        b=g0r1o8rDArTyEeqBWJ+F8Krtn5BlE/h8HPnZxDSaFNwYSYTILVmtIpjvginM6higmh
         O2kBnFk3GLo/EXa/l2D0L4ioE+sHEKBdSllz/uxfbrPz0hiPSWcdMM+tD4vnRcaBhV3q
         28kL21dLJSAWcgYe+Xkyrs6b2Hs0GOKhTCNu4CWdo3gT8AsJzcQ4Ry0W7Baze86IXhLt
         esdLF6Zebz1hl4QkSlTpFeixyahN2ymlbELripmNXLtonSwOMZ9YFqOeDqSMWeBaf3w/
         PW9J4/vVA9jgP3YGQXCmro4EJqyaOnMf4GF753nJGJWpH/v+TDRnLCf91P9zcW9VleNP
         bbJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764023278; x=1764628078;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HXYvmDv4kppfCO9Fqm1r8b7arvwMaa5NeNnEMmc451k=;
        b=Bx4ULsZ4cSnG0vettJlrXrXlKarUlpW2vZUhF7mfBqiBXVSl+iKqAH+9tsABSlKCw5
         dIjk/vFS1B4tuMC4wgKn8gx33713mgwuPgYDOB1fjv/jqYTiVcR0zMhFYhw9zxBabIM2
         sDgT14yweayYA1RLwtHNXQqDENJPiRnyBF3I6Le/XbFQ4Yg06ycJqCX/V/3W4RO7m88a
         cRTTmtcrUd8TZb7m32VUyRqOsACeysai5JBORtnpu9qJJB7kV679fzNyx0sw1oOuvEYj
         QKxJBGrIItywOQmc8tj3m6DssEfjVgehUMqrzJ+bCl9gtq6zg1HvzCIXXAKLdf87aq8T
         B1uA==
X-Gm-Message-State: AOJu0Yxkv6R+cB5fWT4RpAODuKJMXSa3A+V7OfKQg/k7GeftDVGYh9Dw
	Ed5ynW2PK22jIWErLqgB5m05lmzAnXPIIBmoSR04RLfPBnvVWouwErcuEGENSFRWTyW4mr5iAkR
	ZNOEblAoaN6arJpS0+TIOtswN8gNONi61BgdkYbxizlzUTM98jozXcsiGmQ==
X-Gm-Gg: ASbGnctBo0/JDr8yisOW2UKPVIGfFqpP9l1aRWrS10B28VuWwsYU4d4GdQKTY27Uu+P
	uH9Jdj+eYp60c26nMPNgA2EroDiq7i0XjDzMC71Y2PnBrgS2HPCeh6hNKTQ1QzwwEquSSCFACOU
	MSOLUKQ4a+V0E9v6SXUjfVT7UYzZwmuu6intXopgpPg5mQeugtQP3UKUYrTL6ZsZDEbsQq1RxrW
	y2cv6VGDsWJmWdiMb6ce99cQbm349XGvbRlNYJNm7ktXLyvgA1bu/GFKBD3sC4d5QTTJh5aWt4s
	pakYlK7+Yzm2D5Xgr6wnAH8o8dBBT1Z/uIqLKk52cxpWLz6OsiJilIfK5AQNRapYXAn53lBinSg
	0M3tyJfsVEDosAAJ4ncf5WgURBINXxw==
X-Received: by 2002:a05:600c:4ed2:b0:477:55ce:f3c3 with SMTP id 5b1f17b1804b1-477c0162dd6mr120031855e9.5.1764023277677;
        Mon, 24 Nov 2025 14:27:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHpTgqYDwaYD+BIeuP2f0AMJc9Y14bFXs/8liPK6xpoY32LV1hSFbbSC8y4H3DaRF62vzWtrw==
X-Received: by 2002:a05:600c:4ed2:b0:477:55ce:f3c3 with SMTP id 5b1f17b1804b1-477c0162dd6mr120031735e9.5.1764023277302;
        Mon, 24 Nov 2025 14:27:57 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477bf3558d5sm217203125e9.1.2025.11.24.14.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 14:27:56 -0800 (PST)
Date: Mon, 24 Nov 2025 17:27:53 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dan Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
	virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, jgg@ziepe.ca, kevin.tian@intel.com,
	kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net-next v12 03/12] virtio: Expose generic device
 capability operations
Message-ID: <20251124172646-mutt-send-email-mst@kernel.org>
References: <20251119191524.4572-1-danielj@nvidia.com>
 <20251119191524.4572-4-danielj@nvidia.com>
 <20251124152548-mutt-send-email-mst@kernel.org>
 <29fa4996-38e3-4146-81d3-f8b188e047e9@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29fa4996-38e3-4146-81d3-f8b188e047e9@nvidia.com>

On Mon, Nov 24, 2025 at 04:24:37PM -0600, Dan Jurgens wrote:
> On 11/24/25 2:30 PM, Michael S. Tsirkin wrote:
> > On Wed, Nov 19, 2025 at 01:15:14PM -0600, Daniel Jurgens wrote:
> >> Currently querying and setting capabilities is restricted to a single
> >> capability and contained within the virtio PCI driver. However, each
> >> device type has generic and device specific capabilities, that may be
> >> queried and set. In subsequent patches virtio_net will query and set
> >> flow filter capabilities.
> >>
> >> This changes the size of virtio_admin_cmd_query_cap_id_result. It's safe
> >> to do because this data is written by DMA, so a newer controller can't
> >> overrun the size on an older kernel.
> >>
> >> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
> >> Reviewed-by: Parav Pandit <parav@nvidia.com>
> >> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> >>
> >> ---
> >> v4: Moved this logic from virtio_pci_modern to new file
> >>     virtio_admin_commands.
> >>
> >> v12:
> >>   - Removed uapi virtio_pci include in virtio_admin.h. MST
> >>   - Added virtio_pci uapi include to virtio_admin_commands.c
> >>   - Put () around cap in macro. MST
> >>   - Removed nonsense comment above VIRTIO_ADMIN_MAX_CAP. MST
> >>   - +1 VIRTIO_ADMIN_MAX_CAP when calculating array size. MST
> >>   - Updated commit message
> >> ---
> >>  drivers/virtio/Makefile                |  2 +-
> >>  drivers/virtio/virtio_admin_commands.c | 91 ++++++++++++++++++++++++++
> >>  include/linux/virtio_admin.h           | 80 ++++++++++++++++++++++
> >>  include/uapi/linux/virtio_pci.h        |  6 +-
> >>  4 files changed, 176 insertions(+), 3 deletions(-)
> >>  create mode 100644 drivers/virtio/virtio_admin_commands.c
> >>  create mode 100644 include/linux/virtio_admin.h
> >>
> >> diff --git a/drivers/virtio/Makefile b/drivers/virtio/Makefile
> >> index eefcfe90d6b8..2b4a204dde33 100644
> >> --- a/drivers/virtio/Makefile
> >> +++ b/drivers/virtio/Makefile
> >> @@ -1,5 +1,5 @@
> >>  # SPDX-License-Identifier: GPL-2.0
> >> -obj-$(CONFIG_VIRTIO) += virtio.o virtio_ring.o
> >> +obj-$(CONFIG_VIRTIO) += virtio.o virtio_ring.o virtio_admin_commands.o
> >>  obj-$(CONFIG_VIRTIO_ANCHOR) += virtio_anchor.o
> >>  obj-$(CONFIG_VIRTIO_PCI_LIB) += virtio_pci_modern_dev.o
> >>  obj-$(CONFIG_VIRTIO_PCI_LIB_LEGACY) += virtio_pci_legacy_dev.o
> >> diff --git a/drivers/virtio/virtio_admin_commands.c b/drivers/virtio/virtio_admin_commands.c
> >> new file mode 100644
> >> index 000000000000..a2254e71e8dc
> >> --- /dev/null
> >> +++ b/drivers/virtio/virtio_admin_commands.c
> >> @@ -0,0 +1,91 @@
> >> +// SPDX-License-Identifier: GPL-2.0-only
> >> +
> >> +#include <linux/virtio.h>
> >> +#include <linux/virtio_config.h>
> >> +#include <linux/virtio_admin.h>
> >> +#include <uapi/linux/virtio_pci.h>
> >> +
> >> +int virtio_admin_cap_id_list_query(struct virtio_device *vdev,
> >> +				   struct virtio_admin_cmd_query_cap_id_result *data)
> >> +{
> >> +	struct virtio_admin_cmd cmd = {};
> >> +	struct scatterlist result_sg;
> >> +
> >> +	if (!vdev->config->admin_cmd_exec)
> >> +		return -EOPNOTSUPP;
> >> +
> >> +	sg_init_one(&result_sg, data, sizeof(*data));
> >> +	cmd.opcode = cpu_to_le16(VIRTIO_ADMIN_CMD_CAP_ID_LIST_QUERY);
> >> +	cmd.group_type = cpu_to_le16(VIRTIO_ADMIN_GROUP_TYPE_SELF);
> >> +	cmd.result_sg = &result_sg;
> >> +
> >> +	return vdev->config->admin_cmd_exec(vdev, &cmd);
> >> +}
> >> +EXPORT_SYMBOL_GPL(virtio_admin_cap_id_list_query);
> >> +
> >> +int virtio_admin_cap_get(struct virtio_device *vdev,
> >> +			 u16 id,
> >> +			 void *caps,
> >> +			 size_t cap_size)
> > 
> > 
> > I still don't get why cap_size needs to be as large as size_t.
> > 
> > if you don't care what's it size is, just say "unsigned".
> > or u8 as a hint to users it's a small value.
> 
> The size is small for net flow filters, but this is supposed to be a
> generic interface for future uses as well. Why limit it?

because your implementation
makes assumptions - if you want it to be truly generic then you need to handle
weird corner cases such as integer overflow when you add these things.


> 
> > 
> >> +{
> >> +	struct virtio_admin_cmd_cap_get_data *data;
> >> +	struct virtio_admin_cmd cmd = {};
> >> +	struct scatterlist result_sg;
> >> +	struct scatterlist data_sg;
> >> +	int err;
> >> +
> >> +	if (!vdev->config->admin_cmd_exec)
> >> +		return -EOPNOTSUPP;
> >> +
> >> +	data = kzalloc(sizeof(*data), GFP_KERNEL);
> > 
> > uses kzalloc without including linux/slab.h
> > 
> > 
> > 
> >> +	if (!data)
> >> +		return -ENOMEM;
> >> +


