Return-Path: <netdev+bounces-23934-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C485B76E314
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 10:29:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E94E281F5A
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 08:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F91B14F8B;
	Thu,  3 Aug 2023 08:29:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0388F4F
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 08:29:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD0CAC433C7;
	Thu,  3 Aug 2023 08:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691051340;
	bh=oZ7UXI6jDjaUy2oIbNV8s1eUqa5XVQxIUZMcNTD4msQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n9FmrG/CNl5iIWVefeSS0+9fO5mGho2xlZQ4SeWfa8U5eum5dXPmqLQSV1rFSGfTB
	 w9HVMxZEiVD1/gTiGnMgF/y9L8stSkQBbq1Qryr2Ht017rrQzzZ4QIBLU5CoKEE4ja
	 GACKTQIcqDMxNhyPVT8mxgZBP62xaGjSu0PuBS7FIpE2KwFy3QzTf73MIQEYAbGHDB
	 QdKme3HkOd7h18MlcyNA2/rLaK9fjyC/s575HUiGh0cRmPE4dUNRfbkSfIECaOmllA
	 vHTxgY5vjESGxPkymRcwuP0pyv6VS+gbhUndNOwB89Y0xK9wxA+Nbe/yOtLpZRB6KO
	 hUytJCSej7FdQ==
Date: Thu, 3 Aug 2023 10:28:55 +0200
From: Simon Horman <horms@kernel.org>
To: Brett Creeley <brett.creeley@amd.com>
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, alex.williamson@redhat.com,
	jgg@nvidia.com, yishaih@nvidia.com,
	shameerali.kolothum.thodi@huawei.com, kevin.tian@intel.com,
	simon.horman@corigine.com, shannon.nelson@amd.com
Subject: Re: [PATCH v13 vfio 0/7] pds-vfio-pci driver
Message-ID: <ZMtlR/IlHjGGdMTl@kernel.org>
References: <20230725214025.9288-1-brett.creeley@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725214025.9288-1-brett.creeley@amd.com>

On Tue, Jul 25, 2023 at 02:40:18PM -0700, Brett Creeley wrote:
> This is a patchset for a new vendor specific VFIO driver
> (pds-vfio-pci) for use with the AMD/Pensando Distributed Services
> Card (DSC). This driver makes use of the pds_core driver.
> 
> This driver will use the pds_core device's adminq as the VFIO
> control path to the DSC. In order to make adminq calls, the VFIO
> instance makes use of functions exported by the pds_core driver.
> 
> In order to receive events from pds_core, the pds-vfio-pci driver
> registers to a private notifier. This is needed for various events
> that come from the device.
> 
> An ASCII diagram of a VFIO instance looks something like this and can
> be used with the VFIO subsystem to provide the VF device VFIO and live
> migration support.
> 
>                                .------.  .-----------------------.
>                                | QEMU |--|  VM  .-------------.  |
>                                '......'  |      |   Eth VF    |  |
>                                   |      |      .-------------.  |
>                                   |      |      |  SR-IOV VF  |  |
>                                   |      |      '-------------'  |
>                                   |      '------------||---------'
>                                .--------------.       ||
>                                |/dev/<vfio_fd>|       ||
>                                '--------------'       ||
> Host Userspace                         |              ||
> ===================================================   ||
> Host Kernel                            |              ||
>                                   .--------.          ||
>                                   |vfio-pci|          ||
>                                   '--------'          ||
>        .------------------.           ||              ||
>        |   | exported API |<----+     ||              ||
>        |   '--------------|     |     ||              ||
>        |                  |    .--------------.       ||
>        |     pds_core     |--->| pds-vfio-pci |       ||
>        '------------------' |  '--------------'       ||
>                ||           |         ||              ||
>              09:00.0     notifier    09:00.1          ||
> == PCI ===============================================||=====
>                ||                     ||              ||
>           .----------.          .----------.          ||
>     ,-----|    PF    |----------|    VF    |-------------------,
>     |     '----------'         |'----------'         VF        |
>     |                     DSC  |                 data/control  |
>     |                          |                     path      |
>     -----------------------------------------------------------
> 
> The pds-vfio-pci driver is targeted to reside in drivers/vfio/pci/pds.
> It makes use of and introduces new files in the common include/linux/pds
> include directory.
> 
> Note: This series is based on the latest linux-next tree. I did not base
> it on the Alex Williamson's vfio/next because it has not yet pulled in
> the latest changes which include the pds_vdpa driver. The pds_vdpa
> driver has conflicts with the pds-vfio-pci driver that needed to be
> resolved, which is why this series is based on the latest linux-next
> tree.

For series,

Reviewed-by: Simon Horman <horms@kernel.org>



