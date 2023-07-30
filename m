Return-Path: <netdev+bounces-22620-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D80E76853A
	for <lists+netdev@lfdr.de>; Sun, 30 Jul 2023 14:12:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B882A281834
	for <lists+netdev@lfdr.de>; Sun, 30 Jul 2023 12:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D5D31FA4;
	Sun, 30 Jul 2023 12:12:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E4917C7
	for <netdev@vger.kernel.org>; Sun, 30 Jul 2023 12:12:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05168C433C8;
	Sun, 30 Jul 2023 12:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690719160;
	bh=30hP26QIotzwpSrm1s0WESZxVcArCm7cZz8z8kTCgsM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jtjso80udY7BZgbMKRBGwNkxqO2/AQLLDjt+SVh650vaMV7rMPHCD8JRWUbvlKyR0
	 kW2hrjDumtgZdW5haxo9Of7rf5uyuoE390Kpdy6MnkXPqtFWvtDDPtNTFOgpgfw37s
	 GOv36yjlMk4GcNKrT2ptCSlM+59w1Ub4fS9Cb7yArb9yxj0eWrYYUbkH+ZxVc/Ji4N
	 5G5jrxME9gWxUN3QA1aPontPGQPz9awEHdT8LP7GH4zG7blfcj2ykjmw26vfzZYqlZ
	 Y82jGdbJjagYSDK6sI3i02gBK4fUfz9u9pUhF0dg2D58zpFwQ1zEbzNoAE+TCX+uvC
	 tGDEBx6vxDqTw==
Date: Sun, 30 Jul 2023 15:12:36 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	vladimir.oltean@nxp.com, claudiu.manoil@nxp.com,
	alexandre.belloni@bootlin.com, andrew@lunn.ch, f.fainelli@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, olteanv@gmail.com, michael.chan@broadcom.com,
	rajur@chelsio.com, yisen.zhuang@huawei.com, salil.mehta@huawei.com,
	jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
	sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
	hkelam@marvell.com, taras.chornyi@plvision.eu, saeedm@nvidia.com,
	idosch@nvidia.com, petrm@nvidia.com, horatiu.vultur@microchip.com,
	lars.povlsen@microchip.com, Steen.Hegelund@microchip.com,
	daniel.machon@microchip.com, simon.horman@corigine.com,
	aelior@marvell.com, manishc@marvell.com, ecree.xilinx@gmail.com,
	habetsm.xilinx@gmail.com, peppe.cavallaro@st.com,
	alexandre.torgue@foss.st.com, joabreu@synopsys.com,
	mcoquelin.stm32@gmail.com, pablo@netfilter.org,
	kadlec@netfilter.org, fw@strlen.de
Subject: Re: [PATCH v1 net-next] dissector: Use 64bits for used_keys
Message-ID: <20230730121236.GC94048@unreal>
References: <20230727062814.2054345-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230727062814.2054345-1-rkannoth@marvell.com>

On Thu, Jul 27, 2023 at 11:58:14AM +0530, Ratheesh Kannoth wrote:
> As 32bit of dissectory->used_keys are exhausted,
> increase the size to 64bits.
> 
> This is base changes for ESP/AH flow dissector patch.
> 
> Please find patch and discussions at
> https://lore.kernel.org/netdev/ZMDNjD46BvZ5zp5I@corigine.com/T/#t
> 
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
> --
> ChangeLog
> 
> v0 -> v1: Fix errors reported by kernel test robot
> ---
>  drivers/net/dsa/ocelot/felix_vsc9959.c        |  8 +--
>  drivers/net/dsa/sja1105/sja1105_flower.c      |  8 +--
>  drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c  |  6 +-
>  .../ethernet/chelsio/cxgb4/cxgb4_tc_flower.c  | 18 ++---
>  .../freescale/dpaa2/dpaa2-switch-flower.c     | 22 +++---
>  .../net/ethernet/freescale/enetc/enetc_qos.c  |  8 +--
>  .../hisilicon/hns3/hns3pf/hclge_main.c        | 16 ++---
>  drivers/net/ethernet/intel/i40e/i40e_main.c   | 18 ++---
>  drivers/net/ethernet/intel/iavf/iavf_main.c   | 18 ++---
>  drivers/net/ethernet/intel/ice/ice_tc_lib.c   | 44 ++++++------
>  drivers/net/ethernet/intel/igb/igb_main.c     |  8 +--
>  .../ethernet/marvell/octeontx2/nic/otx2_tc.c  | 18 ++---
>  .../marvell/prestera/prestera_flower.c        | 20 +++---
>  .../mellanox/mlx5/core/en/tc/ct_fs_smfs.c     | 25 ++++---
>  .../net/ethernet/mellanox/mlx5/core/en_tc.c   | 44 ++++++------
>  .../ethernet/mellanox/mlxsw/spectrum_flower.c | 22 +++---
>  .../microchip/lan966x/lan966x_tc_flower.c     |  4 +-
>  .../microchip/sparx5/sparx5_tc_flower.c       |  4 +-
>  drivers/net/ethernet/microchip/vcap/vcap_tc.c | 18 ++---
>  drivers/net/ethernet/microchip/vcap/vcap_tc.h |  2 +-
>  drivers/net/ethernet/mscc/ocelot_flower.c     | 28 ++++----
>  .../ethernet/netronome/nfp/flower/conntrack.c | 43 ++++++------
>  .../ethernet/netronome/nfp/flower/offload.c   | 64 +++++++++---------
>  .../net/ethernet/qlogic/qede/qede_filter.c    | 12 ++--
>  drivers/net/ethernet/sfc/tc.c                 | 67 ++++++++++---------
>  .../stmicro/stmmac/stmmac_selftests.c         |  6 +-
>  drivers/net/ethernet/ti/am65-cpsw-qos.c       |  6 +-
>  drivers/net/ethernet/ti/cpsw_priv.c           |  6 +-
>  include/net/flow_dissector.h                  |  5 +-
>  net/core/flow_dissector.c                     |  2 +-
>  net/ethtool/ioctl.c                           | 16 ++---
>  net/netfilter/nf_flow_table_offload.c         | 22 +++---
>  net/netfilter/nf_tables_offload.c             | 13 ++--
>  net/netfilter/nft_cmp.c                       |  2 +-
>  34 files changed, 317 insertions(+), 306 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

