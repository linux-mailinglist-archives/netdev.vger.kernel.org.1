Return-Path: <netdev+bounces-27768-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E533B77D1FE
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 20:39:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 980B928162A
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 18:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA4A17FE8;
	Tue, 15 Aug 2023 18:39:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3E31803E
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 18:38:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBC89C43391;
	Tue, 15 Aug 2023 18:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692124738;
	bh=GtgY/aXAa6uNs7EkEs5mmuLoVTutx8iU7TSLrdA6hlw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L3vqGFvb2uChidm31EjuX7cAaN1Xfseblu+EZNPmGnE6p6zlVFyYrJu+qJu+aYPdM
	 hJ42DVatbkV6OguD7wQTfPGaq7T1WnY7JGogadOqgebkFoxULMJeP//F33QvdTWY4T
	 CCfwEtPNmCnxrpw2eHUhowSlDSoSNywEijXPYjMf/o8cquKvvTSLarOwQQFED2tQej
	 z0wsnTwt1oTzPkmCgEdwK/iTMMdnbzS0CxbmP441qx4v2TtcB6m3hWKBdzypjcUzTr
	 Rcvh9ftyjF+fKp3gJoQI8YuZX7HZgepNwtTn+L+fqyooznzI+Rab3LEOWILHU7JrjJ
	 8GAbDT7QBZ2BA==
Date: Tue, 15 Aug 2023 21:38:54 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, netdev@vger.kernel.org,
	Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>,
	jacob.e.keller@intel.com, horms@kernel.org,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: Re: [PATCH net-next v3 2/5] ice: configure FW logging
Message-ID: <20230815183854.GU22185@unreal>
References: <20230815165750.2789609-1-anthony.l.nguyen@intel.com>
 <20230815165750.2789609-3-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230815165750.2789609-3-anthony.l.nguyen@intel.com>

On Tue, Aug 15, 2023 at 09:57:47AM -0700, Tony Nguyen wrote:
> From: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
> 
> Users want the ability to debug FW issues by retrieving the
> FW logs from the E8xx devices. Use debugfs to allow the user to
> read/write the FW log configuration by adding a 'fwlog/modules' file.
> Reading the file will show either the currently running configuration or
> the next configuration (if the user has changed the configuration).
> Writing to the file will update the configuration, but NOT enable the
> configuration (that is a separate command).
> 
> To see the status of FW logging then read the 'fwlog/modules' file like
> this:
> 
> cat /sys/kernel/debug/ice/0000\:18\:00.0/fwlog/modules
> 
> To change the configuration of FW logging then write to the 'fwlog/modules'
> file like this:
> 
> echo DCB NORMAL > /sys/kernel/debug/ice/0000\:18\:00.0/fwlog/modules
> 
> The format to change the configuration is
> 
> echo <fwlog_module> <fwlog_level> > /sys/kernel/debug/ice/<pci device

This line is truncated, it is not clear where you are writing.
And more general question, a long time ago, netdev had a policy of
not-allowing writing to debugfs, was it changed?

> 
> where
> 
> * fwlog_level is a name as described below. Each level includes the
>   messages from the previous/lower level
> 
>       * NONE
>       *	ERROR
>       *	WARNING
>       *	NORMAL
>       *	VERBOSE
> 
> * fwlog_event is a name that represents the module to receive events for.
>   The module names are
> 
>       *	GENERAL
>       *	CTRL
>       *	LINK
>       *	LINK_TOPO
>       *	DNL
>       *	I2C
>       *	SDP
>       *	MDIO
>       *	ADMINQ
>       *	HDMA
>       *	LLDP
>       *	DCBX
>       *	DCB
>       *	XLR
>       *	NVM
>       *	AUTH
>       *	VPD
>       *	IOSF
>       *	PARSER
>       *	SW
>       *	SCHEDULER
>       *	TXQ
>       *	RSVD
>       *	POST
>       *	WATCHDOG
>       *	TASK_DISPATCH
>       *	MNG
>       *	SYNCE
>       *	HEALTH
>       *	TSDRV
>       *	PFREG
>       *	MDLVER
>       *	ALL
> 
> The name ALL is special and specifies setting all of the modules to the
> specified fwlog_level.
> 
> If the NVM supports FW logging then the file 'fwlog' will be created
> under the PCI device ID for the ice driver. If the file does not exist
> then either the NVM doesn't support FW logging or debugfs is not enabled
> on the system.
> 
> In addition to configuring the modules, the user can also configure the
> number of log messages (resolution) to include in a single Admin Receive
> Queue (ARQ) event.The range is 1-128 (1 means push every log message, 128
> means push only when the max AQ command buffer is full). The suggested
> value is 10.
> 
> To see/change the resolution the user can read/write the
> 'fwlog/resolution' file. An example changing the value to 50 is
> 
> echo 50 > /sys/kernel/debug/ice/0000\:18\:00.0/fwlog/resolution
> 
> Signed-off-by: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
> Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/Makefile       |   4 +-
>  drivers/net/ethernet/intel/ice/ice.h          |  18 +
>  .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  80 ++++
>  drivers/net/ethernet/intel/ice/ice_common.c   |   5 +
>  drivers/net/ethernet/intel/ice/ice_debugfs.c  | 450 ++++++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_fwlog.c    | 231 +++++++++
>  drivers/net/ethernet/intel/ice/ice_fwlog.h    |  55 +++
>  drivers/net/ethernet/intel/ice/ice_main.c     |  21 +
>  drivers/net/ethernet/intel/ice/ice_type.h     |   4 +
>  9 files changed, 867 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/net/ethernet/intel/ice/ice_debugfs.c
>  create mode 100644 drivers/net/ethernet/intel/ice/ice_fwlog.c
>  create mode 100644 drivers/net/ethernet/intel/ice/ice_fwlog.h
> 
> diff --git a/drivers/net/ethernet/intel/ice/Makefile b/drivers/net/ethernet/intel/ice/Makefile
> index 960277d78e09..d43a59e5f8ee 100644
> --- a/drivers/net/ethernet/intel/ice/Makefile
> +++ b/drivers/net/ethernet/intel/ice/Makefile
> @@ -34,7 +34,8 @@ ice-y := ice_main.o	\
>  	 ice_lag.o	\
>  	 ice_ethtool.o  \
>  	 ice_repr.o	\
> -	 ice_tc_lib.o
> +	 ice_tc_lib.o	\
> +	 ice_fwlog.o
>  ice-$(CONFIG_PCI_IOV) +=	\
>  	ice_sriov.o		\
>  	ice_virtchnl.o		\
> @@ -49,3 +50,4 @@ ice-$(CONFIG_RFS_ACCEL) += ice_arfs.o
>  ice-$(CONFIG_XDP_SOCKETS) += ice_xsk.o
>  ice-$(CONFIG_ICE_SWITCHDEV) += ice_eswitch.o ice_eswitch_br.o
>  ice-$(CONFIG_GNSS) += ice_gnss.o
> +ice-$(CONFIG_DEBUG_FS) += ice_debugfs.o
> diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
> index 5ac0ad12f9f1..e6dd9f6f9eee 100644
> --- a/drivers/net/ethernet/intel/ice/ice.h
> +++ b/drivers/net/ethernet/intel/ice/ice.h
> @@ -556,6 +556,8 @@ struct ice_pf {
>  	struct ice_vsi_stats **vsi_stats;
>  	struct ice_sw *first_sw;	/* first switch created by firmware */
>  	u16 eswitch_mode;		/* current mode of eswitch */
> +	struct dentry *ice_debugfs_pf;
> +	struct dentry *ice_debugfs_pf_fwlog;
>  	struct ice_vfs vfs;
>  	DECLARE_BITMAP(features, ICE_F_MAX);
>  	DECLARE_BITMAP(state, ICE_STATE_NBITS);
> @@ -861,6 +863,22 @@ static inline bool ice_is_adq_active(struct ice_pf *pf)
>  	return false;
>  }
>  
> +#ifdef CONFIG_DEBUG_FS

There is no need in this CONFIG_DEBUG_FS and code should be written
without debugfs stubs.

> +void ice_debugfs_fwlog_init(struct ice_pf *pf);
> +void ice_debugfs_init(void);
> +void ice_debugfs_exit(void);
> +void ice_pf_fwlog_update_module(struct ice_pf *pf, int log_level, int module);
> +#else
> +static inline void ice_debugfs_fwlog_init(struct ice_pf *pf) { }
> +static inline void ice_debugfs_init(void) { }
> +static inline void ice_debugfs_exit(void) { }
> +static void
> +ice_pf_fwlog_update_module(struct ice_pf *pf, int log_level, int module)
> +{
> +	return -EOPNOTSUPP;
> +}
> +#endif /* CONFIG_DEBUG_FS */

Thanks

