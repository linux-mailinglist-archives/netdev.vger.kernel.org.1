Return-Path: <netdev+bounces-44114-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97AB67D653D
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 10:35:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DD67281C17
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 08:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA99617725;
	Wed, 25 Oct 2023 08:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KNnlEW2Z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD22F1F60B
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 08:35:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FC45C433C7;
	Wed, 25 Oct 2023 08:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698222911;
	bh=1S2yiLysaUFjqYfPWpycMGksr8a+HstiXzxymMTdaEc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KNnlEW2ZjUAxbOYcTvzEMN5+Tq9do+CeY89SM3Yqxl4eUFpWlbbjj0TAv/bFU6zUs
	 Gljv7Zu5sWCq4D2dvqmZS3Ktgo7JOYog7a4ghWIw/VrPuPhV1utFtIS3LeTn8zclFn
	 0lRm+PqlVgkUE/w4q66Dw7Ei6PJTDanGhMxqyrBLrArAA5Zz4qzmfQOZjQixqs3tFz
	 8GbZV/Cgtdxm+5gCNHCOg1twZxlt8p9UnPZ9oqVqM/cQ0oMhsgUG7S5mnSbjjGBGx6
	 G8ls+DeVilbN1yNOwNVcCpkLMjCSBQLym46EmciIg9lB9UkwruwkpPfSGlxIUOCBIC
	 84pvp1tbtcOJg==
Date: Wed, 25 Oct 2023 11:35:07 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Qing Huang <qing.huang@oracle.com>
Cc: George Kennedy <george.kennedy@oracle.com>,
	"jgg@ziepe.ca" <jgg@ziepe.ca>,
	"sd@queasysnail.net" <sd@queasysnail.net>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Tom Hromatka <tom.hromatka@oracle.com>,
	Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: Re: [PATCH v2] mlx5: fix init stage error handling to avoid double
 free of same QP and UAF
Message-ID: <20231025083507.GB2950466@unreal>
References: <1698170518-4006-1-git-send-email-george.kennedy@oracle.com>
 <SJ0PR10MB54855B65988473FE7642E8F6E9DEA@SJ0PR10MB5485.namprd10.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ0PR10MB54855B65988473FE7642E8F6E9DEA@SJ0PR10MB5485.namprd10.prod.outlook.com>

On Wed, Oct 25, 2023 at 12:15:36AM +0000, Qing Huang wrote:
> 
> > -----Original Message-----
> > From: George Kennedy <george.kennedy@oracle.com>
> > Sent: Tuesday, October 24, 2023 11:02 AM
> > To: leon@kernel.org; jgg@ziepe.ca; sd@queasysnail.net; linux-
> > rdma@vger.kernel.org; linux-kernel@vger.kernel.org; netdev@vger.kernel.org
> > Cc: George Kennedy <george.kennedy@oracle.com>; Tom Hromatka
> > <tom.hromatka@oracle.com>; Harshit Mogalapalli
> > <harshit.m.mogalapalli@oracle.com>
> > Subject: [PATCH v2] mlx5: fix init stage error handling to avoid double free of
> > same QP and UAF
> > 
> > In the unlikely event that workqueue allocation fails and returns NULL in
> > mlx5_mkey_cache_init(), delete the call to
> > mlx5r_umr_resource_cleanup() (which frees the QP) in
> > mlx5_ib_stage_post_ib_reg_umr_init().  This will avoid attempted double free of
> > the same QP when __mlx5_ib_add() does its cleanup.
> > 
> 
> 
> Hi George,
> 
> There seems no cleanup function defined for this stage:
> 
>         STAGE_CREATE(MLX5_IB_STAGE_POST_IB_REG_UMR,
>                      mlx5_ib_stage_post_ib_reg_umr_init,
>                      NULL),
> 
> Do you know where __mlx5_ib_add() does the double free call after the allocation failure?

It is done in MLX5_IB_STAGE_PRE_IB_REG_UMR. Unfortunately, we have
asymmetric init/release flow for UMRs.

Thanks

> 
> Regards,
> Qing
> 
> > Syzkaller reported a UAF in ib_destroy_qp_user
> > 
> > workqueue: Failed to create a rescuer kthread for wq "mkey_cache": -EINTR
> > infiniband mlx5_0: mlx5_mkey_cache_init:981:(pid 1642):
> > failed to create work queue
> > infiniband mlx5_0: mlx5_ib_stage_post_ib_reg_umr_init:4075:(pid 1642):
> > mr cache init failed -12
> > ==================================================================
> > BUG: KASAN: slab-use-after-free in ib_destroy_qp_user
> > (drivers/infiniband/core/verbs.c:2073)
> > Read of size 8 at addr ffff88810da310a8 by task repro_upstream/1642
> > 
> > Call Trace:
> > <TASK>
> > kasan_report (mm/kasan/report.c:590)
> > ib_destroy_qp_user (drivers/infiniband/core/verbs.c:2073)
> > mlx5r_umr_resource_cleanup (drivers/infiniband/hw/mlx5/umr.c:198)
> > __mlx5_ib_add (drivers/infiniband/hw/mlx5/main.c:4178)
> > mlx5r_probe (drivers/infiniband/hw/mlx5/main.c:4402)
> > ...
> > </TASK>
> > 
> > Allocated by task 1642:
> > __kmalloc (./include/linux/kasan.h:198 mm/slab_common.c:1026
> > mm/slab_common.c:1039)
> > create_qp (./include/linux/slab.h:603 ./include/linux/slab.h:720
> > ./include/rdma/ib_verbs.h:2795 drivers/infiniband/core/verbs.c:1209)
> > ib_create_qp_kernel (drivers/infiniband/core/verbs.c:1347)
> > mlx5r_umr_resource_init (drivers/infiniband/hw/mlx5/umr.c:164)
> > mlx5_ib_stage_post_ib_reg_umr_init (drivers/infiniband/hw/mlx5/main.c:4070)
> > __mlx5_ib_add (drivers/infiniband/hw/mlx5/main.c:4168)
> > mlx5r_probe (drivers/infiniband/hw/mlx5/main.c:4402)
> > ...
> > 
> > Freed by task 1642:
> > __kmem_cache_free (mm/slub.c:1826 mm/slub.c:3809 mm/slub.c:3822)
> > ib_destroy_qp_user (drivers/infiniband/core/verbs.c:2112)
> > mlx5r_umr_resource_cleanup (drivers/infiniband/hw/mlx5/umr.c:198)
> > mlx5_ib_stage_post_ib_reg_umr_init (drivers/infiniband/hw/mlx5/main.c:4076
> > drivers/infiniband/hw/mlx5/main.c:4065)
> > __mlx5_ib_add (drivers/infiniband/hw/mlx5/main.c:4168)
> > mlx5r_probe (drivers/infiniband/hw/mlx5/main.c:4402)
> > ...
> > 
> > The buggy address belongs to the object at ffff88810da31000 which belongs to
> > the cache kmalloc-2k of size 2048 The buggy address is located 168 bytes inside
> > of freed 2048-byte region [ffff88810da31000, ffff88810da31800)
> > 
> > The buggy address belongs to the physical page:
> > page:000000003b5e469d refcount:1 mapcount:0 mapping:0000000000000000
> > index:0x0 pfn:0x10da30
> > head:000000003b5e469d order:3 entire_mapcount:0 nr_pages_mapped:0
> > pincount:0
> > flags: 0x17ffffc0000840(slab|head|node=0|zone=2|lastcpupid=0x1fffff)
> > page_type: 0xffffffff()
> > raw: 0017ffffc0000840 ffff888100042f00 ffffea0004180800
> > dead000000000002
> > raw: 0000000000000000 0000000000080008 00000001ffffffff
> > 0000000000000000 page dumped because: kasan: bad access detected
> > 
> > Memory state around the buggy address:
> > ffff88810da30f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> > ffff88810da31000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> > >ffff88810da31080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> > 			      ^
> > ffff88810da31100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> > ffff88810da31180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> > ==================================================================
> > Disabling lock debugging due to kernel taint
> > 
> > Fixes: 04876c12c19e ("RDMA/mlx5: Move init and cleanup of UMR to umr.c")
> > Reported-by: syzkaller <syzkaller@googlegroups.com>
> > Suggested-by: Leon Romanovsky <leon@kernel.org>
> > Signed-off-by: George Kennedy <george.kennedy@oracle.com>
> > ---
> > v2: went with fix suggested by: Leon Romanovsky <leon@kernel.org>
> > 
> >  drivers/infiniband/hw/mlx5/main.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> > 
> > diff --git a/drivers/infiniband/hw/mlx5/main.c
> > b/drivers/infiniband/hw/mlx5/main.c
> > index 555629b7..5d963ab 100644
> > --- a/drivers/infiniband/hw/mlx5/main.c
> > +++ b/drivers/infiniband/hw/mlx5/main.c
> > @@ -4071,10 +4071,8 @@ static int
> > mlx5_ib_stage_post_ib_reg_umr_init(struct mlx5_ib_dev *dev)
> >  		return ret;
> > 
> >  	ret = mlx5_mkey_cache_init(dev);
> > -	if (ret) {
> > +	if (ret)
> >  		mlx5_ib_warn(dev, "mr cache init failed %d\n", ret);
> > -		mlx5r_umr_resource_cleanup(dev);
> > -	}
> >  	return ret;
> >  }
> > 
> > --
> > 1.8.3.1
> 

