Return-Path: <netdev+bounces-15843-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F5074A25E
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 18:40:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D6DF1C20DE7
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 16:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F813A945;
	Thu,  6 Jul 2023 16:40:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9528C9471
	for <netdev@vger.kernel.org>; Thu,  6 Jul 2023 16:40:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87C77C433C8;
	Thu,  6 Jul 2023 16:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688661644;
	bh=08kbGFWZj7/oCZ95GO60uih6wNoPa9yymBlaHKTdzSQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iju9vRK5EHW51RLA3WqFKbXZgyQ2i9EsaldUFMvuAfgd8r1tpH7k5+R0wVOKQVAFc
	 E1xnHMYRiZ1wTEcC6Q3sD8fxp+py2gVra8MwarMASeqAttEq8rpRz7d+Qy02223UyI
	 e+izhtAkKWITQ2eJhCSGEPmgD55EvsGv5W3/5P90rngQKO+C6YwKD+oJI8/HBDOdY6
	 /K4HvSS2E5hc1mxk5fYSY4kFILAIABJmHKDPgslWMB2qiF2IOkPEP+OXdloFtjbdvA
	 H+kq4oBmYvrmbTUwlXFpEjV8+H+zBbpJlaY5EqC3GeIeqUCpQGBXzGafyIJfgjVwBj
	 v1rtw3T5Z00DQ==
Date: Thu, 6 Jul 2023 19:40:39 +0300
From: Leon Romanovsky <leon@kernel.org>
To: "Zulkifli, Muhammad Husaini" <muhammad.husaini.zulkifli@intel.com>
Cc: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"Neftin, Sasha" <sasha.neftin@intel.com>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>,
	Tan Tee Min <tee.min.tan@linux.intel.com>,
	"Choong, Chwee Lin" <chwee.lin.choong@intel.com>,
	Naama Meir <naamax.meir@linux.intel.com>
Subject: Re: [PATCH net 3/6] igc: Fix TX Hang issue when QBV Gate is closed
Message-ID: <20230706164039.GV6455@unreal>
References: <20230705201905.49570-1-anthony.l.nguyen@intel.com>
 <20230705201905.49570-4-anthony.l.nguyen@intel.com>
 <20230706075621.GS6455@unreal>
 <SJ1PR11MB618043DE126BF5649BA1ED0DB82CA@SJ1PR11MB6180.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SJ1PR11MB618043DE126BF5649BA1ED0DB82CA@SJ1PR11MB6180.namprd11.prod.outlook.com>

On Thu, Jul 06, 2023 at 12:43:33PM +0000, Zulkifli, Muhammad Husaini wrote:
> Dear Leon,
> 
> Thanks for reviewing 😊
> Replied inline.
> 
> > -----Original Message-----
> > From: Leon Romanovsky <leon@kernel.org>
> > Sent: Thursday, 6 July, 2023 3:56 PM
> > To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
> > Cc: davem@davemloft.net; kuba@kernel.org; pabeni@redhat.com;
> > edumazet@google.com; netdev@vger.kernel.org; Zulkifli, Muhammad
> > Husaini <muhammad.husaini.zulkifli@intel.com>; Neftin, Sasha
> > <sasha.neftin@intel.com>; richardcochran@gmail.com; Tan Tee Min
> > <tee.min.tan@linux.intel.com>; Choong, Chwee Lin
> > <chwee.lin.choong@intel.com>; Naama Meir
> > <naamax.meir@linux.intel.com>
> > Subject: Re: [PATCH net 3/6] igc: Fix TX Hang issue when QBV Gate is closed
> > 
> > On Wed, Jul 05, 2023 at 01:19:02PM -0700, Tony Nguyen wrote:
> > > From: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
> > >
> > > If a user schedules a Gate Control List (GCL) to close one of the QBV
> > > gates while also transmitting a packet to that closed gate, TX Hang
> > > will be happen. HW would not drop any packet when the gate is closed
> > > and keep queuing up in HW TX FIFO until the gate is re-opened.
> > > This patch implements the solution to drop the packet for the closed
> > > gate.
> > >
> > > This patch will also reset the adapter to perform SW initialization
> > > for each 1st Gate Control List (GCL) to avoid hang.
> > > This is due to the HW design, where changing to TSN transmit mode
> > > requires SW initialization. Intel Discrete I225/6 transmit mode cannot
> > > be changed when in dynamic mode according to Software User Manual
> > > Section 7.5.2.1. Subsequent Gate Control List (GCL) operations will
> > > proceed without a reset, as they already are in TSN Mode.
> > >
> > > Step to reproduce:
> > >
> > > DUT:
> > > 1) Configure GCL List with certain gate close.
> > >
> > > BASE=$(date +%s%N)
> > > tc qdisc replace dev $IFACE parent root handle 100 taprio \
> > >     num_tc 4 \
> > >     map 0 1 2 3 3 3 3 3 3 3 3 3 3 3 3 3 \
> > >     queues 1@0 1@1 1@2 1@3 \
> > >     base-time $BASE \
> > >     sched-entry S 0x8 500000 \
> > >     sched-entry S 0x4 500000 \
> > >     flags 0x2
> > >
> > > 2) Transmit the packet to closed gate. You may use udp_tai application
> > > to transmit UDP packet to any of the closed gate.
> > >
> > > ./udp_tai -i <interface> -P 100000 -p 90 -c 1 -t <0/1> -u 30004
> > >
> > > Fixes: ec50a9d437f0 ("igc: Add support for taprio offloading")
> > > Co-developed-by: Tan Tee Min <tee.min.tan@linux.intel.com>
> > > Signed-off-by: Tan Tee Min <tee.min.tan@linux.intel.com>
> > > Tested-by: Chwee Lin Choong <chwee.lin.choong@intel.com>
> > > Signed-off-by: Muhammad Husaini Zulkifli
> > > <muhammad.husaini.zulkifli@intel.com>
> > > Tested-by: Naama Meir <naamax.meir@linux.intel.com>
> > > Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> > > ---
> > >  drivers/net/ethernet/intel/igc/igc.h      |  6 +++
> > >  drivers/net/ethernet/intel/igc/igc_main.c | 58
> > > +++++++++++++++++++++--  drivers/net/ethernet/intel/igc/igc_tsn.c  |
> > > 41 ++++++++++------
> > >  3 files changed, 87 insertions(+), 18 deletions(-)

<...>

> > > +static enum hrtimer_restart igc_qbv_scheduling_timer(struct hrtimer
> > > +*timer) {
> > > +	struct igc_adapter *adapter = container_of(timer, struct igc_adapter,
> > > +						   hrtimer);
> > > +	unsigned int i;
> > > +
> > > +	adapter->qbv_transition = true;
> > > +	for (i = 0; i < adapter->num_tx_queues; i++) {
> > > +		struct igc_ring *tx_ring = adapter->tx_ring[i];
> > > +
> > > +		if (tx_ring->admin_gate_closed) {
> > 
> > Doesn't asynchronic access to shared variable through hrtimer require some
> > sort of locking?
> 
> Yeah I agreed with you. However, IMHO, it should be saved without the lock. 
> These variables, admin_gate_closed and oper_gate_closed, were set during the transition 
> and setup/delete of the TC only. The qbv_transition flag has been used to protect the 
> operation when it is in qbv transition.

I have no idea what last sentence means, but igc_qbv_scheduling_timer()
and tx_ring are global function/variables and TC setup/delete can run in
parallel to them.

Thanks

