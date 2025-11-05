Return-Path: <netdev+bounces-235650-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC0BC33803
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 01:46:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 53FDF34E520
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 00:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B03C2356BE;
	Wed,  5 Nov 2025 00:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="neNr4G/3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F123E2248A4;
	Wed,  5 Nov 2025 00:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762303587; cv=none; b=irwi6EDRsf5LZErQXCioq2ICiKG435tKxDh8L5kL1si05Kx1bdY2uExF7v6TbvMjy9bmEX/EUCZbjLoJprFtZ+FagFSCntY2Cd5pdLSNdqPeMec4HO6HrH6eehIak1iDowhmwXkepGV4zVtynJiEP44Id0E61eg67DZtL8gWFCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762303587; c=relaxed/simple;
	bh=G1qE+NBXsBrA+U0uG2/XGZHXF86wPuRDqBOaulVkZ1U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tPE52t6ZetOmx08LAm8EcInD6lABa1m3/lNkQClgMf4lXbL/DfBjnitF0hl7IY37ha+U9+B6gf7C07w8HVtEji9ivAAnLiREQj5WhITzb9NUXwX1GAtb1bghkqBBUjiWJKnDv1M4iIbvV48EsICEZ+zm4TtHLt+qvB02RcPO6oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=neNr4G/3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF8F6C4CEF7;
	Wed,  5 Nov 2025 00:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762303586;
	bh=G1qE+NBXsBrA+U0uG2/XGZHXF86wPuRDqBOaulVkZ1U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=neNr4G/3p9hi1E2mihHt2QTBLObs9Qs8DChjrtVngtDdrdKnj6GyevpqpG3FKJmW8
	 b2w2K6VRMr3zEjQpGGItGO/nhscg81ks+iOh/Vtb72RZ8gv635z0wlqwFPL/DdEEy2
	 cwnKD0VBUNcAzDJVOA0A1w3N1GKsuav7hN2bY+GBUeXngX8oO8yypVDQciNOvqasHx
	 5VAU+V9RerP4roO7PM9Y5AZqVb1yEx6LxfiM5L7R6uDWcd0pH+p69CW/nR52v37dSd
	 tZdr81DX+yIeseTcTQ7abuLAarpU8JLjQoTyuukbNPKlcFq3djt40IbnUPHTrz04Ne
	 q+9lXwXkfXuww==
Date: Tue, 4 Nov 2025 16:46:25 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: I Viswanath <viswanathiyyappan@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, sdf@fomichev.me, kuniyu@google.com, ahmed.zaki@intel.com,
 aleksander.lobakin@intel.com, jacob.e.keller@intel.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev,
 david.hunter.linux@gmail.com, khalid@kernel.org
Subject: Re: [RFC/RFT PATCH net-next v3 1/2] net: Add ndo_write_rx_config
 and helper structs and functions:
Message-ID: <20251104164625.5a18db43@kernel.org>
In-Reply-To: <CAPrAcgPD0ZPNPOivpX=69qC88-AAeW+Jy=oy-6+PP8jDxzNabA@mail.gmail.com>
References: <20251028174222.1739954-1-viswanathiyyappan@gmail.com>
	<20251028174222.1739954-2-viswanathiyyappan@gmail.com>
	<20251030192018.28dcd830@kernel.org>
	<CAPrAcgPD0ZPNPOivpX=69qC88-AAeW+Jy=oy-6+PP8jDxzNabA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 4 Nov 2025 22:13:49 +0530 I Viswanath wrote:
> On Fri, 31 Oct 2025 at 07:50, Jakub Kicinski <kuba@kernel.org> wrote:
> > The driver you picked is relatively trivial, advanced drivers need
> > to sync longer lists of mcast / ucast addresses. Bulk of the complexity
> > is in keeping those lists. Simple
> >
> >         *rx_config = *(config_ptr);
> >
> > assignment is not enough.  
> 
> Apologies, I had the wrong mental model of the snapshot.
> 
> From what I understand, the snapshot should look something like
> 
> struct netif_rx_config {
>     char *uc_addrs; // of size uc_count * dev->addr_len
>     char *mc_addrs; // of size mc_count * dev->addr_len
>     int uc_count;
>     int mc_count;
>     bool multi_en, promisc_en, vlan_en;
>     void *device_specific_config;
> }
> Correct me if I have missed anything
> 
> Does the following pseudocode/skeleton make sense?
> 
> update_config() will be called at end of set_rx_mode()
> 
> read_config() is execute_write_rx_config() and do_io() is
> dev->netdev_ops->ndo_write_rx_config() named that way
> for consistency (since read/update)
> 
> atomic_t cfg_in_use = ATOMIC_INIT(false);
> atomic_t cfg_update_pending = ATOMIC_INIT(false);
> 
> struct netif_rx_config *active, *staged;
> 
> void update_config()
> {
>     int was_config_pending = atomic_xchg(&cfg_update_pending, false);
> 
>     // If prepare_config fails, it leaves staged untouched
>     // So, we check for and apply if pending update
>     int rc = prepare_config(&staged);
>     if (rc && !was_config_pending)
>         return;
> 
>     if (atomic_read(&cfg_in_use)) {
>         atomic_set(&cfg_update_pending, true);
>         return;
>     }
>     swap(active, staged);
> }
> 
> void read_config()
> {
>     atomic_set(&cfg_in_use, true);
>     do_io(active);
>     atomic_set(&cfg_in_use, false);
> 
>     // To account for the edge case where update_config() is called
>     // during the execution of read_config() and there are no subsequent
>     // calls to update_config()
>     if (atomic_xchg(&cfg_update_pending, false))
>         swap(active, staged);
> }

I wouldn't use atomic flags. IIRC ndo_set_rx_mode is called under
netif_addr_lock_bh(), so we can reuse that lock, have update_config()
assume ownership of the pending config and update it directly.
And read_config() (which IIUC runs from a wq) can take that lock
briefly, and swap which config is pending.

> >The driver needs to know old and new entries
> > and send ADD/DEL commands to FW. Converting virtio_net would be better,
> > but it does one huge dump which is also not representative of most
> > advanced NICs.  
> 
> We can definitely do this in prepare_config()
> Speaking of which, How big can uc_count and mc_count be?
> 
> Would krealloc(buffer, uc_count * dev->addr_len, GFP_ATOMIC) be a good idea?

Not sure about the max value but I'd think low thousands is probably 
a good target. IOW yes, I think one linear buffer may be a concern.
I'd think order 1 allocation may be fine tho..

> Well, virtio-net does kmalloc((uc_count + mc_count) * ETH_ALEN) + ...,
> GFP_ATOMIC),
> so this shouldn't introduce any new failures for virtio-net

Right but IDK if virtio is used on systems with the same sort of scale
as a large physical function driver..

> > Let's only allocate any extra state if driver has the NDO
> > We need to shut down sooner, some time between ndo_stop and ndo_uninit  
> 
> Would it make sense to move init (if ndo exists) and cleanup to
> __dev_open and __dev_close?

Yes, indeed.

