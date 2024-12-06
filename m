Return-Path: <netdev+bounces-149608-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB309E6721
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 07:00:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 500FA188481C
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 06:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B35117A5BD;
	Fri,  6 Dec 2024 06:00:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from stargate.chelsio.com (stargate.chelsio.com [12.32.117.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5BAECF
	for <netdev@vger.kernel.org>; Fri,  6 Dec 2024 06:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=12.32.117.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733464836; cv=none; b=oU8+c1cVkwl6JpRagVhPwLHVg5CiMlI00ani3F8v7PYmBtwpUMZ2EIM7tsTEIyymL63TUiW488xgOJNVQZCdBijzH9AC4gXUuvRxis7ttcT/yhVYUd+tlGC0osH8CZNFVaB1Jl98zYA88E0XkeJCYWQh0VB9Xmx361KOT3KsOtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733464836; c=relaxed/simple;
	bh=1QiYbf2qfw8cpXP9QP/7qrvEjdEh5XuFYfRgPPMA768=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V/8MT97ig2anV6nc9WiUc7eyT0mIftBDXZJ60xDNJeY+sb+9JyY1sBxO1iU0nzCxNhUJQQ3KDgjbwJnjkAXe11ruM98w/pb9THKLOY5RTG30ydXyOIH/eTO7JUhxQ4LkXd/OiDVdCF5E6J2r6ZW+ssjv282rD2XFnN0I0gGRp3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=chelsio.com; spf=pass smtp.mailfrom=chelsio.com; arc=none smtp.client-ip=12.32.117.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=chelsio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chelsio.com
Received: from localhost (anumula.asicdesigners.com [10.193.191.65])
	by stargate.chelsio.com (8.14.7/8.14.7) with ESMTP id 4B660C3B023492;
	Thu, 5 Dec 2024 22:00:13 -0800
Date: Fri, 6 Dec 2024 01:00:12 -0500
From: Anumula Murali Mohan Reddy <anumula@chelsio.com>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: bharat@chelsio.com, netdev@vger.kernel.org, davem@davemloft.net,
        kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch
Subject: Re: [PATCH net] cxgb4: use port number to set mac addr
Message-ID: <Z1KS7JOtChxB6EbR@chelsio.com>
References: <20241203144149.92032-1-anumula@chelsio.com>
 <Z1AwgqSRsHxWgLn+@mev-dev.igk.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1AwgqSRsHxWgLn+@mev-dev.igk.intel.com>

O Wednesday, December 12/04/24, 2024 at 16:05:46 +0530, Michal Swiatkowski wrote:
> On Tue, Dec 03, 2024 at 08:11:49PM +0530, Anumula Murali Mohan Reddy wrote:
> > t4_set_vf_mac_acl() uses pf to set mac addr, but t4vf_get_vf_mac_acl()
> > uses port number to get mac addr, this leads to error when an attempt
> > to set MAC address on VF's of PF2 and PF3.
> > This patch fixes the issue by using port number to set mac address.
> > 
> > Signed-off-by: Anumula Murali Mohan Reddy <anumula@chelsio.com>
> > Signed-off-by: Potnuri Bharat Teja <bharat@chelsio.com>
> > ---
> >  drivers/net/ethernet/chelsio/cxgb4/cxgb4.h      | 2 +-
> >  drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c | 2 +-
> >  drivers/net/ethernet/chelsio/cxgb4/t4_hw.c      | 5 +++--
> >  3 files changed, 5 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4.h b/drivers/net/ethernet/chelsio/cxgb4/cxgb4.h
> > index 75bd69ff61a8..c7c2c15a1815 100644
> > --- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4.h
> > +++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4.h
> > @@ -2076,7 +2076,7 @@ void t4_idma_monitor(struct adapter *adapter,
> >  		     struct sge_idma_monitor_state *idma,
> >  		     int hz, int ticks);
> >  int t4_set_vf_mac_acl(struct adapter *adapter, unsigned int vf,
> > -		      unsigned int naddr, u8 *addr);
> > +		      u8 start, unsigned int naddr, u8 *addr);
> >  void t4_tp_pio_read(struct adapter *adap, u32 *buff, u32 nregs,
> >  		    u32 start_index, bool sleep_ok);
> >  void t4_tp_tm_pio_read(struct adapter *adap, u32 *buff, u32 nregs,
> > diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
> > index 97a261d5357e..bc3af0054406 100644
> > --- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
> > +++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
> > @@ -3234,7 +3234,7 @@ static int cxgb4_mgmt_set_vf_mac(struct net_device *dev, int vf, u8 *mac)
> >  
> >  	dev_info(pi->adapter->pdev_dev,
> >  		 "Setting MAC %pM on VF %d\n", mac, vf);
> > -	ret = t4_set_vf_mac_acl(adap, vf + 1, 1, mac);
> > +	ret = t4_set_vf_mac_acl(adap, vf + 1, pi->lport, 1, mac);
> >  	if (!ret)
> >  		ether_addr_copy(adap->vfinfo[vf].vf_mac_addr, mac);
> >  	return ret;
> > diff --git a/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c b/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c
> > index 76de55306c4d..175bf9b13058 100644
> > --- a/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c
> > +++ b/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c
> > @@ -10215,11 +10215,12 @@ int t4_load_cfg(struct adapter *adap, const u8 *cfg_data, unsigned int size)
> >   *	t4_set_vf_mac_acl - Set MAC address for the specified VF
> >   *	@adapter: The adapter
> >   *	@vf: one of the VFs instantiated by the specified PF
> > + *	@start: The start port id associated with specified VF
> >   *	@naddr: the number of MAC addresses
> >   *	@addr: the MAC address(es) to be set to the specified VF
> >   */
> >  int t4_set_vf_mac_acl(struct adapter *adapter, unsigned int vf,
> > -		      unsigned int naddr, u8 *addr)
> > +		      u8 start, unsigned int naddr, u8 *addr)
> >  {
> >  	struct fw_acl_mac_cmd cmd;
> >  
> > @@ -10234,7 +10235,7 @@ int t4_set_vf_mac_acl(struct adapter *adapter, unsigned int vf,
> >  	cmd.en_to_len16 = cpu_to_be32((unsigned int)FW_LEN16(cmd));
> >  	cmd.nmac = naddr;
> >  
> > -	switch (adapter->pf) {
> > +	switch (start) {
> >  	case 3:
> >  		memcpy(cmd.macaddr3, addr, sizeof(cmd.macaddr3));
> You can use ether_addr_copy().
> 
> Beside that and fixes tag:
> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> 
> >  		break;
> > -- 
> > 2.39.3
there are multiple instances where memcpy needs to be replaced. I will
send a separate patch to replace memcpy with ethr_addr_copy().

Thanks

