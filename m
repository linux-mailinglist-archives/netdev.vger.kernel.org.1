Return-Path: <netdev+bounces-206205-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92985B02192
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 18:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EEC83BBE5C
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 16:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B3332EF29A;
	Fri, 11 Jul 2025 16:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="PPJorQH0"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D51319AD8B
	for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 16:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752250798; cv=none; b=CHyMINlqPNliX27wrwO504sri4OjwC4QjHYBxsuNDLMXh4Qf7rmcr+WX6tpn70sJaw/zJRj9+Zvuz3e1DXO/heDVmoOvhxz1Twwcc+Ad2BX7pn44KeC56KYudf2xNT25tOcl6IHeDSlVTBnI0gmAMVv+xszFYC5kGWtUm4G8mNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752250798; c=relaxed/simple;
	bh=P7qYpq7UOW3ybcVP/n3HjT1raVCxUeyhzEdJyYA9+UE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UJQulera9L9LW4gIOzoaAWAoPLbHdRAZSM0BPJz2ArUmN9CX9WP++/LP9jvaBzNnHKn4aMPRjfpw4K6Un9IeVXZ8ONFoZ+Q4C0HvPxtsZmCxI1zhUe9I5DCD5qbShyyxH/XO6YBPEcwrHMY5tk8/xGkqw0o/04cducxyXrhryOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=PPJorQH0; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BDwfMj022565;
	Fri, 11 Jul 2025 09:19:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=f14GAw/Pws17OQArmsQ3tBR/N
	En5VoXyDIZUN3AH9IE=; b=PPJorQH04w1OGyLG9yG9M4p2AIlNAw1eHt6rwwKbC
	jH5u3DiG63L8x1Fm/sMyqjeeRDl1zmAcaYkHojYgn8TGKWPnkfXRL3jSYsVS5Qio
	EdVCfKvskQ+xac/P1y5VdgMzXT+ZKGjFzxXvlSqp5I2XUBmIXBacIN61349xnyxt
	PrlGVE5CP3uAYQVuQj2Q9LYOXsH2zO0TVmxyhiYO2S/KIpflUt2zhuEwtQsiGHHi
	CRAo1fW+3B16vgDJFkOJjCAz4OA2Vu5wHFF6rlQbOGIpHRE03CgmzcgsXbHujmC6
	HvbGavRdukCTHBQMg9nyuwezIl67ut8tcfmAUXiuDMBQQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 47u3y6r9fu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Jul 2025 09:19:46 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 11 Jul 2025 09:19:30 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 11 Jul 2025 09:19:30 -0700
Received: from ff87d1e86a04 (unknown [10.193.79.61])
	by maili.marvell.com (Postfix) with SMTP id 0B8453F7043;
	Fri, 11 Jul 2025 09:19:27 -0700 (PDT)
Date: Fri, 11 Jul 2025 16:19:26 +0000
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: Saeed Mahameed <saeed@kernel.org>
CC: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
        Saeed
 Mahameed <saeedm@nvidia.com>, <netdev@vger.kernel.org>,
        Tariq Toukan
	<tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>,
        Leon Romanovsky
	<leonro@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
        Simon Horman
	<horms@kernel.org>
Subject: Re: [PATCH net-next V6 02/13] net/mlx5: Implement cqe_compress_type
 via devlink params
Message-ID: <aHE5jmIOD0hOdWec@ff87d1e86a04>
References: <20250709030456.1290841-1-saeed@kernel.org>
 <20250709030456.1290841-3-saeed@kernel.org>
 <aG4xBBL_pDavpV9R@28e4571372ae>
 <aG9U_jh6GOIxtfG2@x130>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aG9U_jh6GOIxtfG2@x130>
X-Proofpoint-ORIG-GUID: x86RXVV9IGKljvK2OnOpEg4vMTlBy9S0
X-Proofpoint-GUID: x86RXVV9IGKljvK2OnOpEg4vMTlBy9S0
X-Authority-Analysis: v=2.4 cv=Mr5S63ae c=1 sm=1 tr=0 ts=687139a2 cx=c_pps a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=Ikd4Dj_1AAAA:8 a=_8DuhP9GWoK-wNOio8UA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDExOSBTYWx0ZWRfX/iDJFw+NMiAR gmX+C73yikYaJO2CAsg7nCC+IUvlux5twVwwT8OXJq+Cjo8AHq19o5FGXP3DxolB4v9tHkrxRwQ m1qixsxCmxb/poBdpP12HVuyo3XjqShVwUB6Xe0lSO0CwWNx861In1y+kFm+HbLzSGxD8onEeX9
 sB+emdxtc7YySrfOlN9NFZxyWbBo5TLVB/hN0oY7UcbjssXzFqWLMdV7jdjk0MEZFXJwFsbap5T LOjS+pb/6kcol7ha08/1x6UutIH0X4u7hBu1E7yEJCVLc+1pMQVAKa+l9I6aQwGV7vVRvvFWzB7 NfzQ316aJ+6TWujCp/DB9WIStDZwunFd45naLxiJqfrduRGRnkEMj3n9QPXc5lbYui3vqV3aiTg
 n4tEhU4XLn/Yw6MPVpvBKu6IZL3KCbPIyrBSdCahDf6anLSDqEx5PiiuHKiV+TeSGANKDwsi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_04,2025-07-09_01,2025-03-28_01

On 2025-07-10 at 05:51:58, Saeed Mahameed (saeed@kernel.org) wrote:
> On 09 Jul 09:06, Subbaraya Sundeep wrote:
> > Hi Saeed,
> > 
> > On 2025-07-09 at 03:04:44, Saeed Mahameed (saeed@kernel.org) wrote:
> > > From: Saeed Mahameed <saeedm@nvidia.com>
> > > 
> > > Selects which algorithm should be used by the NIC in order to decide rate of
> > > CQE compression dependeng on PCIe bus conditions.
> > > 
> > > Supported values:
> > > 
> > > 1) balanced, merges fewer CQEs, resulting in a moderate compression ratio
> > >    but maintaining a balance between bandwidth savings and performance
> > > 2) aggressive, merges more CQEs into a single entry, achieving a higher
> > >    compression rate and maximizing performance, particularly under high
> > >    traffic loads.
> > > 
> > > Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
> > > Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> > > ---
> > >  Documentation/networking/devlink/mlx5.rst     |   9 +
> > >  .../net/ethernet/mellanox/mlx5/core/Makefile  |   2 +-
> > >  .../net/ethernet/mellanox/mlx5/core/devlink.c |   8 +
> > >  .../net/ethernet/mellanox/mlx5/core/devlink.h |   1 +
> > >  .../mellanox/mlx5/core/lib/nv_param.c         | 245 ++++++++++++++++++
> > >  .../mellanox/mlx5/core/lib/nv_param.h         |  14 +
> > >  include/linux/mlx5/driver.h                   |   1 +
> > >  7 files changed, 279 insertions(+), 1 deletion(-)
> > >  create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/lib/nv_param.c
> > >  create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/lib/nv_param.h
> > > 
> > > diff --git a/Documentation/networking/devlink/mlx5.rst b/Documentation/networking/devlink/mlx5.rst
> > > index 7febe0aecd53..417e5cdcd35d 100644
> > > --- a/Documentation/networking/devlink/mlx5.rst
> > > +++ b/Documentation/networking/devlink/mlx5.rst
> > > @@ -117,6 +117,15 @@ parameters.
> > >       - driverinit
> > >       - Control the size (in packets) of the hairpin queues.
> > > 
> > > +   * - ``cqe_compress_type``
> > > +     - string
> > > +     - permanent
> > > +     - Configure which algorithm should be used by the NIC in order to decide
> > > +       rate of CQE compression dependeng on PCIe bus conditions.
typo -> depending
> > > +
> > > +       * ``balanced`` : Merges fewer CQEs, resulting in a moderate compression ratio but maintaining a balance between bandwidth savings and performance
> > > +       * ``aggressive`` : Merges more CQEs into a single entry, achieving a higher compression rate and maximizing performance, particularly under high traffic loads
> > > +
> > I think it is better to have this cqe param from ethtool.
> > I remember Jakub suggested to implement cqe-size in ethtool when I
> > submitted with devlink initially. Do you think this HW feature may become
> > common for other NICs too in future?
> > 
> 
> I don't think we should be using ehttool to set permanent NV global HCA
> configs :/, as the series suggests, these are permanent device parameters
> that are preserved on power cycles, hence "permanent devlink param".
> 
> "balanced and aggressive" currently the two different ASIC implementation
> for cqe compression in ConnectX chips to accommodate different kinds of
> servers/topologies and PCI connections. I don't see how this could be
> common for other vendors and if others would agree on the same naming..
> 
Got it.

Thanks,
Sundeep

> > Thanks,
> > Sundeep
> > 
> > >  The ``mlx5`` driver supports reloading via ``DEVLINK_CMD_RELOAD``
> > > 
> > >  Info versions
> > > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/Makefile b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
> > > index d292e6a9e22c..26c824e13c45 100644
> > > --- a/drivers/net/ethernet/mellanox/mlx5/core/Makefile
> > > +++ b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
> > > @@ -17,7 +17,7 @@ mlx5_core-y :=	main.o cmd.o debugfs.o fw.o eq.o uar.o pagealloc.o \
> > >  		fs_counters.o fs_ft_pool.o rl.o lag/debugfs.o lag/lag.o dev.o events.o wq.o lib/gid.o \
> > >  		lib/devcom.o lib/pci_vsc.o lib/dm.o lib/fs_ttc.o diag/fs_tracepoint.o \
> > >  		diag/fw_tracer.o diag/crdump.o devlink.o diag/rsc_dump.o diag/reporter_vnic.o \
> > > -		fw_reset.o qos.o lib/tout.o lib/aso.o wc.o fs_pool.o
> > > +		fw_reset.o qos.o lib/tout.o lib/aso.o wc.o fs_pool.o lib/nv_param.o
> > > 
> > >  #
> > >  # Netdev basic
> > > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
> > > index 3ffa3fbacd16..18347b44d611 100644
> > > --- a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
> > > +++ b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
> > > @@ -10,6 +10,7 @@
> > >  #include "esw/qos.h"
> > >  #include "sf/dev/dev.h"
> > >  #include "sf/sf.h"
> > > +#include "lib/nv_param.h"
> > > 
> > >  static int mlx5_devlink_flash_update(struct devlink *devlink,
> > >  				     struct devlink_flash_update_params *params,
> > > @@ -895,8 +896,14 @@ int mlx5_devlink_params_register(struct devlink *devlink)
> > >  	if (err)
> > >  		goto max_uc_list_err;
> > > 
> > > +	err = mlx5_nv_param_register_dl_params(devlink);
> > > +	if (err)
> > > +		goto nv_param_err;
> > > +
> > >  	return 0;
> > > 
> > > +nv_param_err:
> > > +	mlx5_devlink_max_uc_list_params_unregister(devlink);
> > >  max_uc_list_err:
> > >  	mlx5_devlink_auxdev_params_unregister(devlink);
> > >  auxdev_reg_err:
> > > @@ -907,6 +914,7 @@ int mlx5_devlink_params_register(struct devlink *devlink)
> > > 
> > >  void mlx5_devlink_params_unregister(struct devlink *devlink)
> > >  {
> > > +	mlx5_nv_param_unregister_dl_params(devlink);
> > >  	mlx5_devlink_max_uc_list_params_unregister(devlink);
> > >  	mlx5_devlink_auxdev_params_unregister(devlink);
> > >  	devl_params_unregister(devlink, mlx5_devlink_params,
> > > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/devlink.h b/drivers/net/ethernet/mellanox/mlx5/core/devlink.h
> > > index 961f75da6227..74bcdfa70361 100644
> > > --- a/drivers/net/ethernet/mellanox/mlx5/core/devlink.h
> > > +++ b/drivers/net/ethernet/mellanox/mlx5/core/devlink.h
> > > @@ -22,6 +22,7 @@ enum mlx5_devlink_param_id {
> > >  	MLX5_DEVLINK_PARAM_ID_ESW_MULTIPORT,
> > >  	MLX5_DEVLINK_PARAM_ID_HAIRPIN_NUM_QUEUES,
> > >  	MLX5_DEVLINK_PARAM_ID_HAIRPIN_QUEUE_SIZE,
> > > +	MLX5_DEVLINK_PARAM_ID_CQE_COMPRESSION_TYPE
> > >  };
> > > 
> > >  struct mlx5_trap_ctx {
> > > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/nv_param.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/nv_param.c
> > > new file mode 100644
> > > index 000000000000..20a39483be04
> > > --- /dev/null
> > > +++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/nv_param.c
> > > @@ -0,0 +1,245 @@
> > > +// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
> > > +/* Copyright (c) 2024, NVIDIA CORPORATION & AFFILIATES. All rights reserved. */
> > > +
> > > +#include "nv_param.h"
> > > +#include "mlx5_core.h"
> > > +
> > > +enum {
> > > +	MLX5_CLASS_0_CTRL_ID_NV_SW_OFFLOAD_CONFIG             = 0x10a,
> > > +};
> > > +
> > > +struct mlx5_ifc_configuration_item_type_class_global_bits {
> > > +	u8         type_class[0x8];
> > > +	u8         parameter_index[0x18];
> > > +};
> > > +
> > > +union mlx5_ifc_config_item_type_auto_bits {
> > > +	struct mlx5_ifc_configuration_item_type_class_global_bits
> > > +				configuration_item_type_class_global;
> > > +	u8 reserved_at_0[0x20];
> > > +};
> > > +
> > > +struct mlx5_ifc_config_item_bits {
> > > +	u8         valid[0x2];
> > > +	u8         priority[0x2];
> > > +	u8         header_type[0x2];
> > > +	u8         ovr_en[0x1];
> > > +	u8         rd_en[0x1];
> > > +	u8         access_mode[0x2];
> > > +	u8         reserved_at_a[0x1];
> > > +	u8         writer_id[0x5];
> > > +	u8         version[0x4];
> > > +	u8         reserved_at_14[0x2];
> > > +	u8         host_id_valid[0x1];
> > > +	u8         length[0x9];
> > > +
> > > +	union mlx5_ifc_config_item_type_auto_bits type;
> > > +
> > > +	u8         reserved_at_40[0x10];
> > > +	u8         crc16[0x10];
> > > +};
> > > +
> > > +struct mlx5_ifc_mnvda_reg_bits {
> > > +	struct mlx5_ifc_config_item_bits configuration_item_header;
> > > +
> > > +	u8         configuration_item_data[64][0x20];
> > > +};
> > > +
> > > +struct mlx5_ifc_nv_sw_offload_conf_bits {
> > > +	u8         ip_over_vxlan_port[0x10];
> > > +	u8         tunnel_ecn_copy_offload_disable[0x1];
> > > +	u8         pci_atomic_mode[0x3];
> > > +	u8         sr_enable[0x1];
> > > +	u8         ptp_cyc2realtime[0x1];
> > > +	u8         vector_calc_disable[0x1];
> > > +	u8         uctx_en[0x1];
> > > +	u8         prio_tag_required_en[0x1];
> > > +	u8         esw_fdb_ipv4_ttl_modify_enable[0x1];
> > > +	u8         mkey_by_name[0x1];
> > > +	u8         ip_over_vxlan_en[0x1];
> > > +	u8         one_qp_per_recovery[0x1];
> > > +	u8         cqe_compression[0x3];
> > > +	u8         tunnel_udp_entropy_proto_disable[0x1];
> > > +	u8         reserved_at_21[0x1];
> > > +	u8         ar_enable[0x1];
> > > +	u8         log_max_outstanding_wqe[0x5];
> > > +	u8         vf_migration[0x2];
> > > +	u8         log_tx_psn_win[0x6];
> > > +	u8         lro_log_timeout3[0x4];
> > > +	u8         lro_log_timeout2[0x4];
> > > +	u8         lro_log_timeout1[0x4];
> > > +	u8         lro_log_timeout0[0x4];
> > > +};
> > > +
> > > +#define MNVDA_HDR_SZ \
> > > +	(MLX5_ST_SZ_BYTES(mnvda_reg) - \
> > > +	 MLX5_BYTE_OFF(mnvda_reg, configuration_item_data))
> > > +
> > > +#define MLX5_SET_CFG_ITEM_TYPE(_cls_name, _mnvda_ptr, _field, _val) \
> > > +	MLX5_SET(mnvda_reg, _mnvda_ptr, \
> > > +		 configuration_item_header.type.configuration_item_type_class_##_cls_name._field, \
> > > +		 _val)
> > > +
> > > +#define MLX5_SET_CFG_HDR_LEN(_mnvda_ptr, _cls_name) \
> > > +	MLX5_SET(mnvda_reg, _mnvda_ptr, configuration_item_header.length, \
> > > +		 MLX5_ST_SZ_BYTES(_cls_name))
> > > +
> > > +#define MLX5_GET_CFG_HDR_LEN(_mnvda_ptr) \
> > > +	MLX5_GET(mnvda_reg, _mnvda_ptr, configuration_item_header.length)
> > > +
> > > +static int mlx5_nv_param_read(struct mlx5_core_dev *dev, void *mnvda,
> > > +			      size_t len)
> > > +{
> > > +	u32 param_idx, type_class;
> > > +	u32 header_len;
> > > +	void *cls_ptr;
> > > +	int err;
> > > +
> > > +	if (WARN_ON(len > MLX5_ST_SZ_BYTES(mnvda_reg)) || len < MNVDA_HDR_SZ)
> > > +		return -EINVAL; /* A caller bug */
> > > +
> > > +	err = mlx5_core_access_reg(dev, mnvda, len, mnvda, len, MLX5_REG_MNVDA,
> > > +				   0, 0);
> > > +	if (!err)
> > > +		return 0;
> > > +
> > > +	cls_ptr = MLX5_ADDR_OF(mnvda_reg, mnvda,
> > > +			       configuration_item_header.type.configuration_item_type_class_global);
> > > +
> > > +	type_class = MLX5_GET(configuration_item_type_class_global, cls_ptr,
> > > +			      type_class);
> > > +	param_idx = MLX5_GET(configuration_item_type_class_global, cls_ptr,
> > > +			     parameter_index);
> > > +	header_len = MLX5_GET_CFG_HDR_LEN(mnvda);
> > > +
> > > +	mlx5_core_warn(dev, "Failed to read mnvda reg: type_class 0x%x, param_idx 0x%x, header_len %u, err %d\n",
> > > +		       type_class, param_idx, header_len, err);
> > > +
> > > +	return -EOPNOTSUPP;
> > > +}
> > > +
> > > +static int mlx5_nv_param_write(struct mlx5_core_dev *dev, void *mnvda,
> > > +			       size_t len)
> > > +{
> > > +	if (WARN_ON(len > MLX5_ST_SZ_BYTES(mnvda_reg)) || len < MNVDA_HDR_SZ)
> > > +		return -EINVAL;
> > > +
> > > +	if (WARN_ON(MLX5_GET_CFG_HDR_LEN(mnvda) == 0))
> > > +		return -EINVAL;
> > > +
> > > +	return mlx5_core_access_reg(dev, mnvda, len, mnvda, len, MLX5_REG_MNVDA,
> > > +				    0, 1);
> > > +}
> > > +
> > > +static int
> > > +mlx5_nv_param_read_sw_offload_conf(struct mlx5_core_dev *dev, void *mnvda,
> > > +				   size_t len)
> > > +{
> > > +	MLX5_SET_CFG_ITEM_TYPE(global, mnvda, type_class, 0);
> > > +	MLX5_SET_CFG_ITEM_TYPE(global, mnvda, parameter_index,
> > > +			       MLX5_CLASS_0_CTRL_ID_NV_SW_OFFLOAD_CONFIG);
> > > +	MLX5_SET_CFG_HDR_LEN(mnvda, nv_sw_offload_conf);
> > > +
> > > +	return mlx5_nv_param_read(dev, mnvda, len);
> > > +}
> > > +
> > > +static const char *const
> > > +	cqe_compress_str[] = { "balanced", "aggressive" };
> > > +
> > > +static int
> > > +mlx5_nv_param_devlink_cqe_compress_get(struct devlink *devlink, u32 id,
> > > +				       struct devlink_param_gset_ctx *ctx)
> > > +{
> > > +	struct mlx5_core_dev *dev = devlink_priv(devlink);
> > > +	u32 mnvda[MLX5_ST_SZ_DW(mnvda_reg)] = {};
> > > +	u8 value = U8_MAX;
> > > +	void *data;
> > > +	int err;
> > > +
> > > +	err = mlx5_nv_param_read_sw_offload_conf(dev, mnvda, sizeof(mnvda));
> > > +	if (err)
> > > +		return err;
> > > +
> > > +	data = MLX5_ADDR_OF(mnvda_reg, mnvda, configuration_item_data);
> > > +	value = MLX5_GET(nv_sw_offload_conf, data, cqe_compression);
> > > +
> > > +	if (value >= ARRAY_SIZE(cqe_compress_str))
> > > +		return -EOPNOTSUPP;
> > > +
> > > +	strscpy(ctx->val.vstr, cqe_compress_str[value], sizeof(ctx->val.vstr));
> > > +	return 0;
> > > +}
> > > +
> > > +static int
> > > +mlx5_nv_param_devlink_cqe_compress_validate(struct devlink *devlink, u32 id,
> > > +					    union devlink_param_value val,
> > > +					    struct netlink_ext_ack *extack)
> > > +{
> > > +	int i;
> > > +
> > > +	for (i = 0; i < ARRAY_SIZE(cqe_compress_str); i++) {
> > > +		if (!strcmp(val.vstr, cqe_compress_str[i]))
> > > +			return 0;
> > > +	}
> > > +
> > > +	NL_SET_ERR_MSG_MOD(extack,
> > > +			   "Invalid value, supported values are balanced/aggressive");
> > > +	return -EOPNOTSUPP;
> > > +}
> > > +
> > > +static int
> > > +mlx5_nv_param_devlink_cqe_compress_set(struct devlink *devlink, u32 id,
> > > +				       struct devlink_param_gset_ctx *ctx,
> > > +				       struct netlink_ext_ack *extack)
> > > +{
> > > +	struct mlx5_core_dev *dev = devlink_priv(devlink);
> > > +	u32 mnvda[MLX5_ST_SZ_DW(mnvda_reg)] = {};
> > > +	int err = 0;
> > > +	void *data;
> > > +	u8 value;
> > > +
> > > +	if (!strcmp(ctx->val.vstr, "aggressive"))
> > > +		value = 1;
> > > +	else /* balanced: can't be anything else already validated above */
> > > +		value = 0;
> > > +
> > > +	err = mlx5_nv_param_read_sw_offload_conf(dev, mnvda, sizeof(mnvda));
> > > +	if (err) {
> > > +		NL_SET_ERR_MSG_MOD(extack,
> > > +				   "Failed to read sw_offload_conf mnvda reg");
> > > +		return err;
> > > +	}
> > > +
> > > +	data = MLX5_ADDR_OF(mnvda_reg, mnvda, configuration_item_data);
> > > +	MLX5_SET(nv_sw_offload_conf, data, cqe_compression, value);
> > > +
> > > +	return mlx5_nv_param_write(dev, mnvda, sizeof(mnvda));
> > > +}
> > > +
> > > +static const struct devlink_param mlx5_nv_param_devlink_params[] = {
> > > +	DEVLINK_PARAM_DRIVER(MLX5_DEVLINK_PARAM_ID_CQE_COMPRESSION_TYPE,
> > > +			     "cqe_compress_type", DEVLINK_PARAM_TYPE_STRING,
> > > +			     BIT(DEVLINK_PARAM_CMODE_PERMANENT),
> > > +			     mlx5_nv_param_devlink_cqe_compress_get,
> > > +			     mlx5_nv_param_devlink_cqe_compress_set,
> > > +			     mlx5_nv_param_devlink_cqe_compress_validate),
> > > +};
> > > +
> > > +int mlx5_nv_param_register_dl_params(struct devlink *devlink)
> > > +{
> > > +	if (!mlx5_core_is_pf(devlink_priv(devlink)))
> > > +		return 0;
> > > +
> > > +	return devl_params_register(devlink, mlx5_nv_param_devlink_params,
> > > +				    ARRAY_SIZE(mlx5_nv_param_devlink_params));
> > > +}
> > > +
> > > +void mlx5_nv_param_unregister_dl_params(struct devlink *devlink)
> > > +{
> > > +	if (!mlx5_core_is_pf(devlink_priv(devlink)))
> > > +		return;
> > > +
> > > +	devl_params_unregister(devlink, mlx5_nv_param_devlink_params,
> > > +			       ARRAY_SIZE(mlx5_nv_param_devlink_params));
> > > +}
> > > +
> > > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/nv_param.h b/drivers/net/ethernet/mellanox/mlx5/core/lib/nv_param.h
> > > new file mode 100644
> > > index 000000000000..9f4922ff7745
> > > --- /dev/null
> > > +++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/nv_param.h
> > > @@ -0,0 +1,14 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
> > > +/* Copyright (c) 2024, NVIDIA CORPORATION & AFFILIATES. All rights reserved. */
> > > +
> > > +#ifndef __MLX5_NV_PARAM_H
> > > +#define __MLX5_NV_PARAM_H
> > > +
> > > +#include <linux/mlx5/driver.h>
> > > +#include "devlink.h"
> > > +
> > > +int mlx5_nv_param_register_dl_params(struct devlink *devlink);
> > > +void mlx5_nv_param_unregister_dl_params(struct devlink *devlink);
> > > +
> > > +#endif
> > > +
> > > diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
> > > index e6ba8f4f4bd1..96ce152e739f 100644
> > > --- a/include/linux/mlx5/driver.h
> > > +++ b/include/linux/mlx5/driver.h
> > > @@ -135,6 +135,7 @@ enum {
> > >  	MLX5_REG_MTCAP		 = 0x9009,
> > >  	MLX5_REG_MTMP		 = 0x900A,
> > >  	MLX5_REG_MCIA		 = 0x9014,
> > > +	MLX5_REG_MNVDA		 = 0x9024,
> > >  	MLX5_REG_MFRL		 = 0x9028,
> > >  	MLX5_REG_MLCR		 = 0x902b,
> > >  	MLX5_REG_MRTC		 = 0x902d,
> > > --
> > > 2.50.0
> > > 

