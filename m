Return-Path: <netdev+bounces-292809-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GMdACOCRGGoMlQgAu9opvQ
	(envelope-from <netdev+bounces-292809-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 21:05:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 69BCA5F6D7E
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 21:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5F4943030E9D
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 18:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0FE8330B07;
	Thu, 28 May 2026 18:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tPmEL+fV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D7C332EC5
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 18:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779994785; cv=none; b=YX78O9fj3zpmmzoIMJHPiL9Jg8K1R9sghTrxnvBM07DczHesDAqervq/HS+8vX5PaX/6lGcQ3QFCG++Zmvn9tOxMTF8Rg/mgU8I6hZ4Nr1LGqJqu51mV8/yxyko22Z3wQudbTWWa2FVoz1BRmj2Vbmlah/n+XmTD5sfEsnGav84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779994785; c=relaxed/simple;
	bh=K+u3BaAhGcvOwP6Hri5H/3Q3PATtfO+X6e86JxPROrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VYSsCTklRtLc9Z0Knc6dtTVw0uUvKeyB/MnhEDNBkGT/Bvp3+ePMk7l+ZYPiM1CKbJaTJjTSY2H1VX6z5E2F4/BZf6HcnNB/xYTjuLZ/xzHsmdksjF+ZKPYXO98dlNB2Iry/obpwOnCSvvKmHqcx60PRLieCoawE5IBugwwYcV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tPmEL+fV; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-83975e992e1so5416076b3a.2
        for <netdev@vger.kernel.org>; Thu, 28 May 2026 11:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779994782; x=1780599582; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C2ZUBuHYLFWaBCKcO06WPiLzxJQqwEviAmU64GiN9ok=;
        b=tPmEL+fVHSrGRYBfCJcVg3KCj+ESdSPwsJ+dQSLrg/rIO2ss3m/6+ePSbybnXOxqs5
         i9rkUFw+8+PvxNJqwZn/Jz1r0EtOa4EGZ5PmranxCn7LpN9Lx1lgqPMF5i9Pl4gIEJyp
         tdacW7QZ9tIG2BM3SmfJ4y1RbXG2dReefH5XyHKS32tG62lo7jNDgIT/+ETT3eOBhOO0
         oZWyoPH20vz/i7TTo7GcN0WUiHLOpZ0L7RiYr+dPLilrw0GhZlD0MfHihql+nS0N6V2z
         QwGcofRsG1Z+fKDuuGyt7wBYw23r8bD1CahfGKDhF7Axr/dfA3jMJK5JAh3/HKu+IR5i
         fE+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779994782; x=1780599582;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C2ZUBuHYLFWaBCKcO06WPiLzxJQqwEviAmU64GiN9ok=;
        b=OE/0MOepj+1VMjmiNtm+LAj4jok4zDC6yrMlBuYYYOJheTLtaz6aWJSwObbxHRwDc3
         djLOsjGVYO1XuiqImGQ9FtID8TP8suri6DsPPq7XJGuMMby/ff5U82a5+UCm3KmpEb3x
         KyOvyRsEtxKsX/3mBWqkKffs+mcr24Z4DzSVBrtjlxcdY1hZOOEr2cKn3iKEpjfWKFeM
         Fkmkc0Vxmu1NsczQmV6eyAfpQL5DnD2oaqsLWdnv+OguzY3XO9iUfPPFqfwhVaVGWlLP
         dmbpWMx6OJIMf/u29W5yC6gpaOfz7auq5XZky0mzSCPGqolJJSBcMIYxSdQ3pnnVy7ZV
         NLZw==
X-Forwarded-Encrypted: i=1; AFNElJ9KJoL8sNPo95bu5tsgDrI1vlgZFRumv88eUO0LcTFhF9rDCsQ8SBJKrXydf/yfyYo22bx7cRk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yziljbk5L1kPXKL51QKMpMh4mztTzIv9qWG/2dMrHWfhzL+A5Nd
	12cSnpGgyGmHCB/BXTxSTkFCjeqrox8gj01xNfShCwvZzNtaTL98eblG/+vn5+wn0Q==
X-Gm-Gg: Acq92OGXZ6I3WNAepKe74znDIGgpbIqPxJvymxFPVryVVfx7bh8xdJTt/LWr7QtBp9i
	zmYVUdx6QdVtwZgwQWz4DXqiusRhzM+AebwPpkTL5hdQ6BXpinfT5LMGMN7hdb3BDzuafK/Z5xl
	xJ3O1qZl1hElfzWTwP/xyU56D9kyHX+R1EB75vuQk/YzsJJ39hSJLmiyhbkyO72j85abKmVvLkn
	t4zFDpqjyeTqk8Jpa3UkVzLauYRjPSrsyu+HrFkaziE+Oxm4H9UBFCXloKJ9vi9IV8yqEVABcBM
	G7uXnGKFkqOiBQqNBSoyg9P6XQ4FlJIG7TjdrlKa6uPNQICYcHAt8D9H6v6pw8ayxWvs3iQyJM2
	ZuiduCQxZteWYmDPGFOJh4/VyTRJmO9YmIwt/QYpgcFEKL2lmDIE05J4ysg2APqaSqnf78FVJ+w
	w14Um0WuAITZoZySYnpqOEmT42KdJK9Hepl2OMM/4/lj2AceomlY5inuE9dlA51JHnCVFrWLYv
X-Received: by 2002:a05:6a00:9099:b0:841:dc7d:306a with SMTP id d2e1a72fcca58-8420c4b6859mr239429b3a.25.1779994781790;
        Thu, 28 May 2026 11:59:41 -0700 (PDT)
Received: from google.com (56.149.168.34.bc.googleusercontent.com. [34.168.149.56])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-841d70bb654sm7090146b3a.29.2026.05.28.11.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 11:59:41 -0700 (PDT)
Date: Thu, 28 May 2026 18:59:38 +0000
From: David Matlack <dmatlack@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alex Williamson <alex@shazbot.org>, kvm@vger.kernel.org,
	Leon Romanovsky <leon@kernel.org>, linux-kselftest@vger.kernel.org,
	linux-rdma@vger.kernel.org, Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
	Shuah Khan <shuah@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	patches@lists.linux.dev
Subject: Re: [PATCH v2 07/11] vfio: selftests: Allow drivers to specify
 required region size
Message-ID: <ahiQmnWscsbWPqRo@google.com>
References: <0-v2-72e9640932fd+2c64-mlx5st_jgg@nvidia.com>
 <7-v2-72e9640932fd+2c64-mlx5st_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7-v2-72e9640932fd+2c64-mlx5st_jgg@nvidia.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292809-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmatlack@google.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 69BCA5F6D7E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-05-15 02:30 PM, Jason Gunthorpe wrote:
> Add a region_size field to struct vfio_pci_driver_ops so drivers can
> declare how much DMA-mapped region they need. The mlx5 driver will need
> ~18MB for firmware pages. Existing drivers pass in the sizeof their state
> struct. The core code will round up and minimize it to SZ_2M so as not to
> change any test behavior.
> 
> Assisted-by: Claude:claude-opus-4.6
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  tools/testing/selftests/vfio/lib/drivers/dsa/dsa.c         | 1 +
>  tools/testing/selftests/vfio/lib/drivers/ioat/ioat.c       | 1 +
>  .../selftests/vfio/lib/include/libvfio/vfio_pci_driver.h   | 6 ++++++
>  tools/testing/selftests/vfio/vfio_pci_driver_test.c        | 7 ++++++-
>  4 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/vfio/lib/drivers/dsa/dsa.c b/tools/testing/selftests/vfio/lib/drivers/dsa/dsa.c
> index 19d9630b24c23f..40b8541b588eee 100644
> --- a/tools/testing/selftests/vfio/lib/drivers/dsa/dsa.c
> +++ b/tools/testing/selftests/vfio/lib/drivers/dsa/dsa.c
> @@ -418,6 +418,7 @@ static void dsa_send_msi(struct vfio_pci_device *device)
>  
>  const struct vfio_pci_driver_ops dsa_ops = {
>  	.name = "dsa",
> +	.region_size = sizeof(struct dsa_state),
>  	.probe = dsa_probe,
>  	.init = dsa_init,
>  	.remove = dsa_remove,
> diff --git a/tools/testing/selftests/vfio/lib/drivers/ioat/ioat.c b/tools/testing/selftests/vfio/lib/drivers/ioat/ioat.c
> index a871b935542bad..c9b28365c5eb6b 100644
> --- a/tools/testing/selftests/vfio/lib/drivers/ioat/ioat.c
> +++ b/tools/testing/selftests/vfio/lib/drivers/ioat/ioat.c
> @@ -226,6 +226,7 @@ static void ioat_send_msi(struct vfio_pci_device *device)
>  
>  const struct vfio_pci_driver_ops ioat_ops = {
>  	.name = "ioat",
> +	.region_size = sizeof(struct ioat_state),
>  	.probe = ioat_probe,
>  	.init = ioat_init,
>  	.remove = ioat_remove,
> diff --git a/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_driver.h b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_driver.h
> index e5ada209b1d102..547369c5cff95a 100644
> --- a/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_driver.h
> +++ b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_driver.h
> @@ -9,6 +9,12 @@ struct vfio_pci_device;
>  struct vfio_pci_driver_ops {
>  	const char *name;
>  
> +	/*
> +	 * Size of the driver's state structure overlaid on
> +	 * device->driver.region.vaddr
> +	 */
> +	u64 region_size;
> +
>  	/**
>  	 * @probe() - Check if the driver supports the given device.
>  	 *
> diff --git a/tools/testing/selftests/vfio/vfio_pci_driver_test.c b/tools/testing/selftests/vfio/vfio_pci_driver_test.c
> index afa0480ddd9b2a..5a46800cde4c8d 100644
> --- a/tools/testing/selftests/vfio/vfio_pci_driver_test.c
> +++ b/tools/testing/selftests/vfio/vfio_pci_driver_test.c
> @@ -2,6 +2,7 @@
>  #include <sys/ioctl.h>
>  #include <sys/mman.h>
>  
> +#include <linux/log2.h>
>  #include <linux/sizes.h>
>  #include <linux/vfio.h>
>  
> @@ -80,7 +81,11 @@ FIXTURE_SETUP(vfio_pci_driver_test)
>  	driver = &self->device->driver;
>  
>  	region_setup(self->iommu, self->iova_allocator, &self->memcpy_region, SZ_1G);
> -	region_setup(self->iommu, self->iova_allocator, &driver->region, SZ_2M);
> +
> +	VFIO_ASSERT_NE(driver->ops->region_size, 0);
> +	region_setup(self->iommu, self->iova_allocator, &driver->region,
> +		     max_t(u64, roundup_pow_of_two(driver->ops->region_size),
> +			   SZ_2M));

We have some other upcoming tests that want to set up the driver region, so it
would be nice to move this into the library.

  * https://lore.kernel.org/kvm/20260511234802.2280368-17-vipinsh@google.com/
  * https://lore.kernel.org/kvm/20260421231557.1254270-8-jrhilke@google.com/

What about something like this?

diff --git a/tools/testing/selftests/vfio/lib/drivers/dsa/dsa.c b/tools/testing/selftests/vfio/lib/drivers/dsa/dsa.c
index 19d9630b24c2..40b8541b588e 100644
--- a/tools/testing/selftests/vfio/lib/drivers/dsa/dsa.c
+++ b/tools/testing/selftests/vfio/lib/drivers/dsa/dsa.c
@@ -418,6 +418,7 @@ static void dsa_send_msi(struct vfio_pci_device *device)

 const struct vfio_pci_driver_ops dsa_ops = {
        .name = "dsa",
+       .region_size = sizeof(struct dsa_state),
        .probe = dsa_probe,
        .init = dsa_init,
        .remove = dsa_remove,
diff --git a/tools/testing/selftests/vfio/lib/drivers/ioat/ioat.c b/tools/testing/selftests/vfio/lib/drivers/ioat/ioat.c
index a871b935542b..c9b28365c5eb 100644
--- a/tools/testing/selftests/vfio/lib/drivers/ioat/ioat.c
+++ b/tools/testing/selftests/vfio/lib/drivers/ioat/ioat.c
@@ -226,6 +226,7 @@ static void ioat_send_msi(struct vfio_pci_device *device)

 const struct vfio_pci_driver_ops ioat_ops = {
        .name = "ioat",
+       .region_size = sizeof(struct ioat_state),
        .probe = ioat_probe,
        .init = ioat_init,
        .remove = ioat_remove,
diff --git a/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_driver.h b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_driver.h
index e5ada209b1d1..547369c5cff9 100644
--- a/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_driver.h
+++ b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_driver.h
@@ -9,6 +9,12 @@ struct vfio_pci_device;
 struct vfio_pci_driver_ops {
        const char *name;

+       /*
+        * Size of the driver's state structure overlaid on
+        * device->driver.region.vaddr
+        */
+       u64 region_size;
+
        /**
         * @probe() - Check if the driver supports the given device.
         *
diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_driver.c b/tools/testing/selftests/vfio/lib/vfio_pci_driver.c
index 6827f4a6febe..c70c22b1a86c 100644
--- a/tools/testing/selftests/vfio/lib/vfio_pci_driver.c
+++ b/tools/testing/selftests/vfio/lib/vfio_pci_driver.c
@@ -28,6 +28,9 @@ void vfio_pci_driver_probe(struct vfio_pci_device *device)
                        continue;

                device->driver.ops = ops;
+
+               VFIO_ASSERT_NE(ops->region_size, 0);
+               device->driver.region.size = roundup(ops->region_size, getpagesize());
        }
 }

diff --git a/tools/testing/selftests/vfio/vfio_pci_driver_test.c b/tools/testing/selftests/vfio/vfio_pci_driver_test.c
index afa0480ddd9b..36d977542274 100644
--- a/tools/testing/selftests/vfio/vfio_pci_driver_test.c
+++ b/tools/testing/selftests/vfio/vfio_pci_driver_test.c
@@ -80,7 +80,7 @@ FIXTURE_SETUP(vfio_pci_driver_test)
        driver = &self->device->driver;

        region_setup(self->iommu, self->iova_allocator, &self->memcpy_region, SZ_1G);
-       region_setup(self->iommu, self->iova_allocator, &driver->region, SZ_2M);
+       region_setup(self->iommu, self->iova_allocator, &driver->region, driver->region.size);

        /* Any IOVA that doesn't overlap memcpy_region and driver->region. */
        self->unmapped_iova = iova_allocator_alloc(self->iova_allocator, SZ_1G);

>  
>  	/* Any IOVA that doesn't overlap memcpy_region and driver->region. */
>  	self->unmapped_iova = iova_allocator_alloc(self->iova_allocator, SZ_1G);
> -- 
> 2.43.0
> 

