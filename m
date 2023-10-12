Return-Path: <netdev+bounces-40344-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD0E97C6D76
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 13:56:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 226ED1C20C94
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 11:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B2BF24A1C;
	Thu, 12 Oct 2023 11:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FUVAYTt7"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FD6250E7
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 11:56:19 +0000 (UTC)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35AD355BE
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 04:56:16 -0700 (PDT)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39CBnkIP028706;
	Thu, 12 Oct 2023 11:56:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=GqAMSfIzPncVlE5A+/Fl9nXKJ6Xv9ePH+MMJ216ingI=;
 b=FUVAYTt7zFrF8wLGnqA7XqxX0TnqiYad+FW9lauaM7b8nEj1hXv6jVOBhCHheKqMRdsh
 Hg4kXLZIkENYf0EEJww/HUyYpvt3637oe5jNXCX5Gm/CTXves+RrrBo7uQ4Y90RbYrz+
 HkIeeut5wL6FD8aZv3Bc0p0MNQMXMGOMBcjWo2FxAe65JzwoXZZxUhwOCWe8N92L+rDf
 J20ddxdbjGBhmfVnQJrMrtkAKnutz14kZUD2nGzNAOkTx7xgKzzxzqliHHIIH3upB9Nk
 Js6QdY23VXQZfhePw04I3kjAoWY1wmXmY9QB2q6l/gnz1+qViNfvtuJ/1Mn1dDeGjrKU pw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tpg93074u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Oct 2023 11:56:08 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39CBoBAe030721;
	Thu, 12 Oct 2023 11:56:07 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tpg93072y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Oct 2023 11:56:07 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39C9mjPP025883;
	Thu, 12 Oct 2023 11:51:22 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tkjnnq7hr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Oct 2023 11:51:21 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39CBpJD615139386
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Oct 2023 11:51:19 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CFCDF20043;
	Thu, 12 Oct 2023 11:51:19 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 07B1620040;
	Thu, 12 Oct 2023 11:51:19 +0000 (GMT)
Received: from [9.171.78.5] (unknown [9.171.78.5])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 12 Oct 2023 11:51:18 +0000 (GMT)
Message-ID: <f93947daffa56e4cdf380ad644e78bcee1ad4183.camel@linux.ibm.com>
Subject: Re: [RFC PATCH net] net/mlx5: Perform DMA operations cleanup before
 pci_disable_device()
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: Saeed Mahameed <saeed@kernel.org>,
        "David S. Miller"
 <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org,
        Tariq Toukan
	 <tariqt@nvidia.com>, Shay Drory <shayd@nvidia.com>,
        Moshe Shemesh
	 <moshe@nvidia.com>, Leon Romanovsky <leon@kernel.org>
Date: Thu, 12 Oct 2023 13:51:18 +0200
In-Reply-To: <20231011184511.19818-1-saeed@kernel.org>
References: <20231011184511.19818-1-saeed@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: y47LSMhgB3yl_CQ13HycWaKmP_zdOX3J
X-Proofpoint-ORIG-GUID: ZLrLIKAQr5boxsUvf4cfMH_xhfBwFXSZ
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-12_05,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 phishscore=0 malwarescore=0 clxscore=1011 mlxscore=0 priorityscore=1501
 impostorscore=0 suspectscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310120097
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, 2023-10-11 at 11:45 -0700, Saeed Mahameed wrote:
> From: Shay Drory <shayd@nvidia.com>
>=20
> The cited patch change mlx5 driver so that during probe, DMA
> operations were performed before pci_enable_device() and during
> teardown, DMA operations were performed after pci_disable_device().
> DMA operations require PCI to be enabled. Hence, The above leads to
> the following oops in PPC systems[2].
>=20
> Fix it by performing the DMA operations during probe, after
> pci_enable_device() and during teardown, before pci_disable_device().
>=20
> This also fixes a problem reported by Niklas Schnelle [1]
>=20
> [1] https://lore.kernel.org/lkml/20231011-mlx5_init_fix-v3-1-787ffb9183c6=
@linux.ibm.com/
>=20
> [2]
> Oops: Kernel access of bad area, sig: 11 [#1]
> LE PAGE_SIZE=3D64K MMU=3DRadix SMP NR_CPUS=3D2048 NUMA pSeries
> Modules linked in: xt_MASQUERADE nf_conntrack_netlink
> nfnetlink xfrm_user iptable_nat xt_addrtype xt_conntrack nf_nat
> nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 netconsole rpcsec_gss_krb5
> auth_rpcgss oid_registry overlay rpcrdma rdma_ucm ib_iser ib_umad
> rdma_cm ib_ipoib iw_cm libiscsi scsi_transport_iscsi ib_cm ib_uverbs
> ib_core mlx5_core(-) ptp pps_core fuse vmx_crypto crc32c_vpmsum [last
> unloaded: mlx5_ib]
> CPU: 1 PID: 8937 Comm: modprobe Not tainted 6.5.0-rc3_for_upstream_min_de=
bug_2023_07_31_16_02 #1
> Hardware name: IBM pSeries (emulated by qemu) POWER9 (raw) 0x4e1202 0xf00=
0005 of:SLOF,HEAD hv:linux,kvm pSeries
> NIP:  c000000000423388 LR: c0000000001e733c CTR: c0000000001e4720
> REGS: c0000000055636d0 TRAP: 0380   Not tainted (6.5.0-rc3_for_upstream_m=
in_debug_2023_07_31_16_02)
> MSR:  8000000000009033  CR: 24008884  XER: 20040000
> CFAR: c0000000001e7338 IRQMASK: 0
> NIP [c000000000423388] __free_pages+0x28/0x160
> LR [c0000000001e733c] dma_direct_free+0xac/0x190
> Call Trace:
> [c000000005563970] [5deadbeef0000100] 0x5deadbeef0000100 (unreliable)
> [c0000000055639b0] [c0000000003d46cc] kfree+0x7c/0x150
> [c000000005563a40] [c0000000001e47c8] dma_free_attrs+0xa8/0x1a0
> [c000000005563aa0] [c008000000d0064c] mlx5_cmd_cleanup+0xa4/0x100 [mlx5_c=
ore]
> [c000000005563ad0] [c008000000cf629c] mlx5_mdev_uninit+0xf4/0x140 [mlx5_c=
ore]
> [c000000005563b00] [c008000000cf6448] remove_one+0x160/0x1d0 [mlx5_core]
> [c000000005563b40] [c000000000958540] pci_device_remove+0x60/0x110
> [c000000005563b80] [c000000000a35e80] device_remove+0x70/0xd0
> [c000000005563bb0] [c000000000a37a38] device_release_driver_internal+0x2a=
8/0x330
> [c000000005563c00] [c000000000a37b8c] driver_detach+0x8c/0x160
> [c000000005563c40] [c000000000a35350] bus_remove_driver+0x90/0x110
> [c000000005563c80] [c000000000a38948] driver_unregister+0x48/0x90
> [c000000005563cf0] [c000000000957e38] pci_unregister_driver+0x38/0x150
> [c000000005563d40] [c008000000eb6140] mlx5_cleanup+0x38/0x90 [mlx5_core]
>=20
> Fixes: 06cd555f73ca ("net/mlx5: split mlx5_cmd_init() to probe and reload=
 routines")
> Signed-off-by: Shay Drory <shayd@nvidia.com>
> Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
> Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
> Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
> CC: Leon Romanovsky <leon@kernel.org>
> CC: Niklas Schnelle <schnelle@linux.ibm.com>
>=20
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/cmd.c | 62 ++++++++-----------
>  1 file changed, 27 insertions(+), 35 deletions(-)


I can confirm that this indeed fixes the problem I was seeing. I also
tested hot unplug and re-plug as well as some smoke tests with the
devices at hand across multiple ConnectX generations.
So feel free to add my:

Tested-by: Niklas Schnelle <schnelle@linux.ibm.com>

>=20
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c b/drivers/net/=
ethernet/mellanox/mlx5/core/cmd.c
> index afb348579577..dd36d9cba62f 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
> @@ -2186,52 +2186,23 @@ static u16 cmdif_rev(struct mlx5_core_dev *dev)
>=20
>  int mlx5_cmd_init(struct mlx5_core_dev *dev)
>  {
> -	int size =3D sizeof(struct mlx5_cmd_prot_block);
> -	int align =3D roundup_pow_of_two(size);
>  	struct mlx5_cmd *cmd =3D &dev->cmd;
> -	u32 cmd_l;
> -	int err;
> -
> -	cmd->pool =3D dma_pool_create("mlx5_cmd", mlx5_core_dma_dev(dev), size,=
 align, 0);
> -	if (!cmd->pool)
> -		return -ENOMEM;
>=20
> -	err =3D alloc_cmd_page(dev, cmd);
> -	if (err)
> -		goto err_free_pool;
> -
> -	cmd_l =3D (u32)(cmd->dma);
> -	if (cmd_l & 0xfff) {
> -		mlx5_core_err(dev, "invalid command queue address\n");
> -		err =3D -ENOMEM;
> -		goto err_cmd_page;
> -	}
>  	cmd->checksum_disabled =3D 1;
>=20
>  	spin_lock_init(&cmd->alloc_lock);
>  	spin_lock_init(&cmd->token_lock);
>=20
> -	create_msg_cache(dev);
> -
>  	set_wqname(dev);
>  	cmd->wq =3D create_singlethread_workqueue(cmd->wq_name);
>  	if (!cmd->wq) {
>  		mlx5_core_err(dev, "failed to create command workqueue\n");
> -		err =3D -ENOMEM;
> -		goto err_cache;
> +		return -ENOMEM;
>  	}
>=20
>  	mlx5_cmdif_debugfs_init(dev);
>=20
>  	return 0;
> -
> -err_cache:
> -	destroy_msg_cache(dev);
> -err_cmd_page:
> -	free_cmd_page(dev, cmd);
> -err_free_pool:
> -	dma_pool_destroy(cmd->pool);
> -	return err;
>  }

I like that this leaves mlx5_cmd_init() simpler.

>=20
>  void mlx5_cmd_cleanup(struct mlx5_core_dev *dev)
> @@ -2240,15 +2211,15 @@ void mlx5_cmd_cleanup(struct mlx5_core_dev *dev)
>=20
>  	mlx5_cmdif_debugfs_cleanup(dev);
>  	destroy_workqueue(cmd->wq);
> -	destroy_msg_cache(dev);
> -	free_cmd_page(dev, cmd);
> -	dma_pool_destroy(cmd->pool);
>  }
>=20
>  int mlx5_cmd_enable(struct mlx5_core_dev *dev)
>  {
> +	int size =3D sizeof(struct mlx5_cmd_prot_block);
> +	int align =3D roundup_pow_of_two(size);
>  	struct mlx5_cmd *cmd =3D &dev->cmd;
>  	u32 cmd_h, cmd_l;
> +	int err;
>=20
>  	memset(&cmd->vars, 0, sizeof(cmd->vars));
>  	cmd->vars.cmdif_rev =3D cmdif_rev(dev);
> @@ -2281,10 +2252,21 @@ int mlx5_cmd_enable(struct mlx5_core_dev *dev)
>  	sema_init(&cmd->vars.pages_sem, 1);
>  	sema_init(&cmd->vars.throttle_sem, DIV_ROUND_UP(cmd->vars.max_reg_cmds,=
 2));
>=20
> +	cmd->pool =3D dma_pool_create("mlx5_cmd", mlx5_core_dma_dev(dev), size,=
 align, 0);
> +	if (!cmd->pool)
> +		return -ENOMEM;
> +
> +	err =3D alloc_cmd_page(dev, cmd);
> +	if (err)
> +		goto err_free_pool;
> +
>  	cmd_h =3D (u32)((u64)(cmd->dma) >> 32);
>  	cmd_l =3D (u32)(cmd->dma);
> -	if (WARN_ON(cmd_l & 0xfff))
> -		return -EINVAL;
> +	if (cmd_l & 0xfff) {
> +		mlx5_core_err(dev, "invalid command queue address\n");
> +		err =3D -ENOMEM;
> +		goto err_cmd_page;
> +	}
>=20
>  	iowrite32be(cmd_h, &dev->iseg->cmdq_addr_h);
>  	iowrite32be(cmd_l, &dev->iseg->cmdq_addr_l_sz);
> @@ -2297,16 +2279,26 @@ int mlx5_cmd_enable(struct mlx5_core_dev *dev)
>  	cmd->mode =3D CMD_MODE_POLLING;
>  	cmd->allowed_opcode =3D CMD_ALLOWED_OPCODE_ALL;
>=20
> +	create_msg_cache(dev);
>  	create_debugfs_files(dev);
>=20
>  	return 0;
> +
> +err_cmd_page:
> +	free_cmd_page(dev, cmd);
> +err_free_pool:
> +	dma_pool_destroy(cmd->pool);
> +	return err;
>  }
>=20
>  void mlx5_cmd_disable(struct mlx5_core_dev *dev)
>  {
>  	struct mlx5_cmd *cmd =3D &dev->cmd;
>=20
> +	destroy_msg_cache(dev);
>  	clean_debug_files(dev);
> +	free_cmd_page(dev, cmd);
> +	dma_pool_destroy(cmd->pool);
>  	flush_workqueue(cmd->wq);
>  }

I do like that this tears down the DMA stuff before
pci_disable_device() I don't think this fixes a problem on s390x but to
me it's the more natural order. That said, are we sure that the
flush_workqueue() won't still need DMA and cmd page?

>=20
> --
> 2.41.0
>=20


