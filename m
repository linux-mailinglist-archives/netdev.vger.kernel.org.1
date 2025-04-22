Return-Path: <netdev+bounces-184675-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E31A96D48
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 15:46:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6269917C79A
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 13:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75C6A28150D;
	Tue, 22 Apr 2025 13:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TcGkpDav"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1FD27CCF3
	for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 13:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745329568; cv=none; b=SujP2mfX5KcgfOW3VDWg6oInNBjJi37Zx27/d8yiai48OvfE8yBvGkL1npg0OkUVTl7FGzcwC+6O2DW7nYnCyHbJ/g+nfbRSJ06bATOfyxq6r4Vv4MEIheX7PePh4jzakPjj/FkENY13xbTTvrN2ULzBOeVzJQeGhQzYLvz7uwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745329568; c=relaxed/simple;
	bh=/28bbrd+BiKbMHtPd1h52hCg8uYfjd0/OaBPvTeuaP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iY8Pv5E0prpGuJOt+KlCFFI7dJSrGvjyhGAMtD6D+qn6/2KOtY4UbYtcQLxe50Nzw+PATro5MhDwlE9J9OOWiCAVmHMXGB0Yy4fu3det4Lu9NfYENeAsEjIQcNClDNg3yAmfISMpzppoiyZ6k+GFAXebAHtbTiakV786a3rPwgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TcGkpDav; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745329565;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Hr43FBt5Kf90a/anZXagBnPduPdmPMmZnfi9PtbkADQ=;
	b=TcGkpDavVxGnpgtld31nykuE7SymF5IFcSwAYMnsDjgBUFKiIn0pGkJhpFUjg/3k/+Fn+0
	i3gKBAF7tyiW6HeoDDDQa8GKz1DrxR0zr6cy6KxxHLgaMmmjMcSU8lNFbT0Bpy2tQOZGxb
	fdh68nw775Layxe2Gp5cc1ueubX0xwo=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-135-fkEWqGImPueQMLr_rUXnCA-1; Tue, 22 Apr 2025 09:46:03 -0400
X-MC-Unique: fkEWqGImPueQMLr_rUXnCA-1
X-Mimecast-MFC-AGG-ID: fkEWqGImPueQMLr_rUXnCA_1745329563
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-ac3d175fe71so133990266b.0
        for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 06:46:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745329562; x=1745934362;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hr43FBt5Kf90a/anZXagBnPduPdmPMmZnfi9PtbkADQ=;
        b=YgAmPzjKZmfqfye69w0j+Eg0NV3TaV2sCB/zHB217ZNo7PgD7qcspKfDqv6sZUmfn0
         5DLXczDCy22NEWVzrBADW48x6757NkO79SoE2joK0yqn2/V6gXsXNgYrKGTKiNhhdzwV
         HoGnWKEARQsjE4mTkzo370+s+yJZVCUPekLyn6dm/fW8VwYI3UoJiI3CBPvu696WDcuv
         b419hRGAVYRfMuN4qPhVaZV566f7UieVBI65XFKRCHQj9IeTpSBVuYtyLrTDZ0czyTW/
         aIUfvLFnffvSFALiDo7ZffYsBXRllZ22hoJftTppY2HJ/uT2OroXu9rpkSxM0NmpbWCQ
         tvAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWoWRm9QkZW+MO6dEcwpO+gTJRiOfJYrOErMHRToH+X+11xW5kw9NpT19PxbvYgLkakW1AEN3k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6W3pzY3Atf7nGR2qCmIORpZCYHO9pB/Dqe8yZxBwt0PoFaaEh
	ZE8nKYPt46oQ9gqGY6F0a6XPimw9PKLurkAmxfqOpLDHkSNkyy0h38s3VxX46SdotfcNt95MW2M
	yqKAULoKzUzGNW4KryCbUcG0+chTo6DBNc4oJ6vOUKPMwsJmnYLicNg==
X-Gm-Gg: ASbGnctTiBhjQeYPPTlg2SKFJNPI2aihpQP4PzQFh4GBqYi3/4wN0n91TX5YYYXOukf
	yzimu9EqOoBuCzYhTkUIsOPTNdKNZJOVpPUSwxlPSHgFldByCQA5QhF8nEfcZNA3aL6WhVJE5iu
	HfAtB+H+KEbv9me67Mb4Xx+4LQFzs8OwbX+fr1oKhF9rE40sq86cQ4FUmW4BLI3qm+4l6CMWXED
	NqvBt1Vqvwva6mpsWu8nrGpweCJIzsYel6nHIWLOWr1xBnSN0lu/hx0FV/t4gjYmx8ZiptvRofq
	6wHIyONPp3+/nPjK
X-Received: by 2002:a17:907:3f96:b0:aca:b45a:7c86 with SMTP id a640c23a62f3a-acb74aa9323mr1458679366b.1.1745329562506;
        Tue, 22 Apr 2025 06:46:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEr+SdKMSl5/dVJr+La2Ltp5evEokv1RwOavIWfnmNE1377Mp9Jz6N1IVAbz5B+i9vkXcgT3A==
X-Received: by 2002:a17:907:3f96:b0:aca:b45a:7c86 with SMTP id a640c23a62f3a-acb74aa9323mr1458675766b.1.1745329561899;
        Tue, 22 Apr 2025 06:46:01 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.218.81])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acb6ec502bcsm663384966b.66.2025.04.22.06.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 06:46:01 -0700 (PDT)
Date: Tue, 22 Apr 2025 15:45:56 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, michael.christie@oracle.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v9 3/4] vhost: add VHOST_FORK_FROM_OWNER ioctl and
 validate inherit_owner
Message-ID: <zd4njyzxo6jnmrthhsgo26t7t44tjfkkd7aghzd237s2h5pwf6@nmwhp43dvlj6>
References: <20250421024457.112163-1-lulu@redhat.com>
 <20250421024457.112163-4-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250421024457.112163-4-lulu@redhat.com>

On Mon, Apr 21, 2025 at 10:44:09AM +0800, Cindy Lu wrote:
>Add a new UAPI to configure the vhost device to use the kthread mode.
>The userspace application can use IOCTL VHOST_FORK_FROM_OWNER
>to choose between owner and kthread mode if necessary.
>This setting must be applied before VHOST_SET_OWNER, as the worker
>will be created in the VHOST_SET_OWNER function.
>
>In addition, the VHOST_NEW_WORKER requires the inherit_owner
>setting to be true. So we need to add a check for this.
>
>Signed-off-by: Cindy Lu <lulu@redhat.com>
>---
> drivers/vhost/vhost.c      | 29 +++++++++++++++++++++++++++--
> include/uapi/linux/vhost.h | 16 ++++++++++++++++
> 2 files changed, 43 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>index be97028a8baf..fb0c7fb43f78 100644
>--- a/drivers/vhost/vhost.c
>+++ b/drivers/vhost/vhost.c
>@@ -1018,6 +1018,13 @@ long vhost_worker_ioctl(struct vhost_dev *dev, unsigned int ioctl,
> 	switch (ioctl) {
> 	/* dev worker ioctls */
> 	case VHOST_NEW_WORKER:
>+		/*
>+		 * vhost_tasks will account for worker threads under the parent's
>+		 * NPROC value but kthreads do not. To avoid userspace overflowing
>+		 * the system with worker threads inherit_owner must be true.
>+		 */
>+		if (!dev->inherit_owner)
>+			return -EFAULT;
> 		ret = vhost_new_worker(dev, &state);
> 		if (!ret && copy_to_user(argp, &state, sizeof(state)))
> 			ret = -EFAULT;
>@@ -1134,7 +1141,7 @@ void vhost_dev_reset_owner(struct vhost_dev *dev, struct vhost_iotlb *umem)
> 	int i;
>
> 	vhost_dev_cleanup(dev);
>-

nit: I'd avoid removing this empty line, it helps while reading code.

>+	dev->inherit_owner = true;
> 	dev->umem = umem;
> 	/* We don't need VQ locks below since vhost_dev_cleanup makes sure
> 	 * VQs aren't running.
>@@ -2287,7 +2294,25 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *argp)
> 		r = vhost_dev_set_owner(d);
> 		goto done;
> 	}
>-
>+	if (ioctl == VHOST_FORK_FROM_OWNER) {
>+		u8 inherit_owner;
>+		/*inherit_owner can only be modified before owner is set*/
>+		if (vhost_dev_has_owner(d)) {
>+			r = -EBUSY;
>+			goto done;
>+		}
>+		if (copy_from_user(&inherit_owner, argp, sizeof(u8))) {
>+			r = -EFAULT;
>+			goto done;
>+		}
>+		if (inherit_owner > 1) {
>+			r = -EINVAL;
>+			goto done;
>+		}
>+		d->inherit_owner = (bool)inherit_owner;
>+		r = 0;
>+		goto done;
>+	}

Ditto, an empty like should help to separate to the next step.

> 	/* You must be the owner to do anything else */
> 	r = vhost_dev_check_owner(d);
> 	if (r)
>diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
>index b95dd84eef2d..1ae0917bfeca 100644
>--- a/include/uapi/linux/vhost.h
>+++ b/include/uapi/linux/vhost.h
>@@ -235,4 +235,20 @@
>  */
> #define VHOST_VDPA_GET_VRING_SIZE	_IOWR(VHOST_VIRTIO, 0x82,	\
> 					      struct vhost_vring_state)
>+
>+/**
>+ * VHOST_FORK_FROM_OWNER - Set the inherit_owner flag for the vhost device,
>+ * This ioctl must called before VHOST_SET_OWNER.

Shoud we mention that this IOCTL is only supported if 
CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL is y?

>+ *
>+ * @param inherit_owner: An 8-bit value that determines the vhost thread mode
>+ *
>+ * When inherit_owner is set to 1(default value):
>+ *   - Vhost will create tasks similar to processes forked from the owner,
>+ *     inheriting all of the owner's attributes.
>+ *
>+ * When inherit_owner is set to 0:
>+ *   - Vhost will create tasks as kernel thread.
>+ */
>+#define VHOST_FORK_FROM_OWNER _IOW(VHOST_VIRTIO, 0x83, __u8)
>+
> #endif
>-- 
>2.45.0
>


