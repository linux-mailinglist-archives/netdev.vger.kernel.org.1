Return-Path: <netdev+bounces-28780-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F16780ACC
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 13:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9B2C1C215E1
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 11:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD74182AE;
	Fri, 18 Aug 2023 11:10:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266C8A52
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 11:10:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2ACAC433C8;
	Fri, 18 Aug 2023 11:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692357054;
	bh=HJaXRubxIvbP+l4GHVJmmhqaMfZV1Uj0kJn5sh14ksE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UVFZTZMf0is92iq/5XJqfu7w6Kh1Vbno6CGN+Oz+QuF8efsP5S68bqfkzOwlbkQpf
	 7/WvY7mNuTngri7e9QFo5UFytb7KpiORm+IdDhi1ByR5mozV+IL5djjwyPhL34JQQa
	 D9vRr6ImojkBzPwGROulWUwcLgCeId2SEGE4FagyTp8YSBoBP/tmoz8AFzQvTR6xcg
	 fO61nhiAksrKHLc8JapX9OXrbzFHLaYPe76nAYY/K4EfylkHiVblY58nYikw6PjUW/
	 d1nhDsy7xYOA6k1hrAY+KS6NvpOeOHsRoXAsz0S93Cuv371j12GVup+YF3c+w6EwfH
	 o/7uf13iaWy2w==
Date: Fri, 18 Aug 2023 14:10:49 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
	netdev@vger.kernel.org, jacob.e.keller@intel.com, horms@kernel.org,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: Re: [PATCH net-next v3 2/5] ice: configure FW logging
Message-ID: <20230818111049.GY22185@unreal>
References: <20230815165750.2789609-1-anthony.l.nguyen@intel.com>
 <20230815165750.2789609-3-anthony.l.nguyen@intel.com>
 <20230815183854.GU22185@unreal>
 <c865cde7-fe13-c158-673a-a0acd200b667@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c865cde7-fe13-c158-673a-a0acd200b667@intel.com>

On Thu, Aug 17, 2023 at 02:25:34PM -0700, Paul M Stillwell Jr wrote:
> On 8/15/2023 11:38 AM, Leon Romanovsky wrote:
> > On Tue, Aug 15, 2023 at 09:57:47AM -0700, Tony Nguyen wrote:
> > > From: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
> > > 
> > > Users want the ability to debug FW issues by retrieving the
> > > FW logs from the E8xx devices. Use debugfs to allow the user to
> > > read/write the FW log configuration by adding a 'fwlog/modules' file.
> > > Reading the file will show either the currently running configuration or
> > > the next configuration (if the user has changed the configuration).
> > > Writing to the file will update the configuration, but NOT enable the
> > > configuration (that is a separate command).
> > > 
> > > To see the status of FW logging then read the 'fwlog/modules' file like
> > > this:
> > > 
> > > cat /sys/kernel/debug/ice/0000\:18\:00.0/fwlog/modules
> > > 
> > > To change the configuration of FW logging then write to the 'fwlog/modules'
> > > file like this:
> > > 
> > > echo DCB NORMAL > /sys/kernel/debug/ice/0000\:18\:00.0/fwlog/modules
> > > 
> > > The format to change the configuration is
> > > 
> > > echo <fwlog_module> <fwlog_level> > /sys/kernel/debug/ice/<pci device
> > 
> > This line is truncated, it is not clear where you are writing.
> 
> Good catch, I don't know how I missed this... Will fix
> 
> > And more general question, a long time ago, netdev had a policy of
> > not-allowing writing to debugfs, was it changed?
> > 
> 
> I had this same thought and it seems like there were 2 concerns in the past

Maybe, I'm not enough time in netdev world to know the history.

> 
> 1. Having a single file that was read/write with lots of commands going
> through it
> 2. Having code in the driver to parse the text from the commands that was
> error/security prone
> 
> We have addressed this in 2 ways:
> 1. Split the commands into multiple files that have a single purpose
> 2. Use kernel parsing functions for anything where we *have* to pass text to
> decode
> 
> > > 
> > > where
> > > 
> > > * fwlog_level is a name as described below. Each level includes the
> > >    messages from the previous/lower level
> > > 
> > >        * NONE
> > >        *	ERROR
> > >        *	WARNING
> > >        *	NORMAL
> > >        *	VERBOSE
> > > 
> > > * fwlog_event is a name that represents the module to receive events for.
> > >    The module names are
> > > 
> > >        *	GENERAL
> > >        *	CTRL
> > >        *	LINK
> > >        *	LINK_TOPO
> > >        *	DNL
> > >        *	I2C
> > >        *	SDP
> > >        *	MDIO
> > >        *	ADMINQ
> > >        *	HDMA
> > >        *	LLDP
> > >        *	DCBX
> > >        *	DCB
> > >        *	XLR
> > >        *	NVM
> > >        *	AUTH
> > >        *	VPD
> > >        *	IOSF
> > >        *	PARSER
> > >        *	SW
> > >        *	SCHEDULER
> > >        *	TXQ
> > >        *	RSVD
> > >        *	POST
> > >        *	WATCHDOG
> > >        *	TASK_DISPATCH
> > >        *	MNG
> > >        *	SYNCE
> > >        *	HEALTH
> > >        *	TSDRV
> > >        *	PFREG
> > >        *	MDLVER
> > >        *	ALL
> > > 
> > > The name ALL is special and specifies setting all of the modules to the
> > > specified fwlog_level.
> > > 
> > > If the NVM supports FW logging then the file 'fwlog' will be created
> > > under the PCI device ID for the ice driver. If the file does not exist
> > > then either the NVM doesn't support FW logging or debugfs is not enabled
> > > on the system.
> > > 
> > > In addition to configuring the modules, the user can also configure the
> > > number of log messages (resolution) to include in a single Admin Receive
> > > Queue (ARQ) event.The range is 1-128 (1 means push every log message, 128
> > > means push only when the max AQ command buffer is full). The suggested
> > > value is 10.
> > > 
> > > To see/change the resolution the user can read/write the
> > > 'fwlog/resolution' file. An example changing the value to 50 is
> > > 
> > > echo 50 > /sys/kernel/debug/ice/0000\:18\:00.0/fwlog/resolution
> > > 
> > > Signed-off-by: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
> > > Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
> > > Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> > > ---
> > >   drivers/net/ethernet/intel/ice/Makefile       |   4 +-
> > >   drivers/net/ethernet/intel/ice/ice.h          |  18 +
> > >   .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  80 ++++
> > >   drivers/net/ethernet/intel/ice/ice_common.c   |   5 +
> > >   drivers/net/ethernet/intel/ice/ice_debugfs.c  | 450 ++++++++++++++++++
> > >   drivers/net/ethernet/intel/ice/ice_fwlog.c    | 231 +++++++++
> > >   drivers/net/ethernet/intel/ice/ice_fwlog.h    |  55 +++
> > >   drivers/net/ethernet/intel/ice/ice_main.c     |  21 +
> > >   drivers/net/ethernet/intel/ice/ice_type.h     |   4 +
> > >   9 files changed, 867 insertions(+), 1 deletion(-)
> > >   create mode 100644 drivers/net/ethernet/intel/ice/ice_debugfs.c
> > >   create mode 100644 drivers/net/ethernet/intel/ice/ice_fwlog.c
> > >   create mode 100644 drivers/net/ethernet/intel/ice/ice_fwlog.h
> > > 
> > > diff --git a/drivers/net/ethernet/intel/ice/Makefile b/drivers/net/ethernet/intel/ice/Makefile
> > > index 960277d78e09..d43a59e5f8ee 100644
> > > --- a/drivers/net/ethernet/intel/ice/Makefile
> > > +++ b/drivers/net/ethernet/intel/ice/Makefile
> > > @@ -34,7 +34,8 @@ ice-y := ice_main.o	\
> > >   	 ice_lag.o	\
> > >   	 ice_ethtool.o  \
> > >   	 ice_repr.o	\
> > > -	 ice_tc_lib.o
> > > +	 ice_tc_lib.o	\
> > > +	 ice_fwlog.o
> > >   ice-$(CONFIG_PCI_IOV) +=	\
> > >   	ice_sriov.o		\
> > >   	ice_virtchnl.o		\
> > > @@ -49,3 +50,4 @@ ice-$(CONFIG_RFS_ACCEL) += ice_arfs.o
> > >   ice-$(CONFIG_XDP_SOCKETS) += ice_xsk.o
> > >   ice-$(CONFIG_ICE_SWITCHDEV) += ice_eswitch.o ice_eswitch_br.o
> > >   ice-$(CONFIG_GNSS) += ice_gnss.o
> > > +ice-$(CONFIG_DEBUG_FS) += ice_debugfs.o
> > > diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
> > > index 5ac0ad12f9f1..e6dd9f6f9eee 100644
> > > --- a/drivers/net/ethernet/intel/ice/ice.h
> > > +++ b/drivers/net/ethernet/intel/ice/ice.h
> > > @@ -556,6 +556,8 @@ struct ice_pf {
> > >   	struct ice_vsi_stats **vsi_stats;
> > >   	struct ice_sw *first_sw;	/* first switch created by firmware */
> > >   	u16 eswitch_mode;		/* current mode of eswitch */
> > > +	struct dentry *ice_debugfs_pf;
> > > +	struct dentry *ice_debugfs_pf_fwlog;
> > >   	struct ice_vfs vfs;
> > >   	DECLARE_BITMAP(features, ICE_F_MAX);
> > >   	DECLARE_BITMAP(state, ICE_STATE_NBITS);
> > > @@ -861,6 +863,22 @@ static inline bool ice_is_adq_active(struct ice_pf *pf)
> > >   	return false;
> > >   }
> > > +#ifdef CONFIG_DEBUG_FS
> > 
> > There is no need in this CONFIG_DEBUG_FS and code should be written
> > without debugfs stubs.
> > 
> 
> I don't understand this comment... If the kernel is configured *without*
> debugfs, won't the kernel fail to compile due to missing functions if we
> don't do this?

It will work fine, see include/linux/debugfs.h.

> 
> > > +void ice_debugfs_fwlog_init(struct ice_pf *pf);
> > > +void ice_debugfs_init(void);
> > > +void ice_debugfs_exit(void);
> > > +void ice_pf_fwlog_update_module(struct ice_pf *pf, int log_level, int module);
> > > +#else
> > > +static inline void ice_debugfs_fwlog_init(struct ice_pf *pf) { }
> > > +static inline void ice_debugfs_init(void) { }
> > > +static inline void ice_debugfs_exit(void) { }
> > > +static void
> > > +ice_pf_fwlog_update_module(struct ice_pf *pf, int log_level, int module)
> > > +{
> > > +	return -EOPNOTSUPP;
> > > +}
> > > +#endif /* CONFIG_DEBUG_FS */
> > 
> > Thanks
> 

