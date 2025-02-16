Return-Path: <netdev+bounces-166761-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E8BA37364
	for <lists+netdev@lfdr.de>; Sun, 16 Feb 2025 10:38:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DC3616FAAA
	for <lists+netdev@lfdr.de>; Sun, 16 Feb 2025 09:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D735188012;
	Sun, 16 Feb 2025 09:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hZhvk2Bv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299FE290F
	for <netdev@vger.kernel.org>; Sun, 16 Feb 2025 09:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739698623; cv=none; b=faLutJ/T/V4XobAfOoMUUUzcUqBXkAwOyO0ag5gNQrxPR2ixXK5ljNj4fX8pSOXFMNWriSJEaz1i6ZokYoss92VragqSnmaBxbNh4J11m3He2qRLpjwYq163DjMA7XTDaWWbUc9vqj3KK+qei0Woi1LlGmRxvdJyKYOWC7S7dR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739698623; c=relaxed/simple;
	bh=C/a2Xo494AXYieH5GYzXOn+umJoH8gBVl476a06NTa0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t/mX5cejHg6rcVSwKlqaoeE4bn/oKg1TCHFFtRzGaR4UAVq2UHqddgq6IPjpdWirKkqqNJ/3cU5euAw3JFGtk+rkPDsYlVK/RkG4wdfjfPbY9WdEqUtOMU2T20oeueVXhma1io5BwedVE3W70bjS8IXAw20COLt+zYx0/jQVT6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hZhvk2Bv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 770FFC4CEDD;
	Sun, 16 Feb 2025 09:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739698622;
	bh=C/a2Xo494AXYieH5GYzXOn+umJoH8gBVl476a06NTa0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hZhvk2BvlFtXYj3YtY/j/8N0dUwRemZ4ixTYQjLWsndKbEdXxnC8Mat1zfeXyT3XT
	 Dpmw0a0/5FbtXvgB5hboiAmAhnUMbXGXTX8O5HqMacuQG97g9UtF69D4T64VySNi49
	 5or5BlMxkOWZ+rt/SdVufb283tIP6M54vW6pmao8LW+sTYkzO5UUBaSxKdybQQ4ZPl
	 DItzH/LsDYLbk9vO48q7zfKi6kzIN3b9wsR8SkbBW6mGlMpCIegIZcv9kDD7ffQwjD
	 jpJgCGYdFw4z4j7tB1/t4QDQnyRpPouTZmi7X/8E3nqNFIl+iMAg78OmffEzGyJWdi
	 tMwosZUG3ldVQ==
Date: Sun, 16 Feb 2025 09:36:58 +0000
From: Simon Horman <horms@kernel.org>
To: "Tantilov, Emil S" <emil.s.tantilov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	decot@google.com, willemb@google.com, anthony.l.nguyen@intel.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, madhu.chittim@intel.com
Subject: Re: [Intel-wired-lan] [PATCH iwl-net] idpf: check error for
 register_netdev() on init
Message-ID: <20250216093658.GB1615191@kernel.org>
References: <20250211023851.21090-1-emil.s.tantilov@intel.com>
 <20250212182111.GH1615191@kernel.org>
 <00ecb5e5-00b9-4c30-a29a-37c9f268b389@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00ecb5e5-00b9-4c30-a29a-37c9f268b389@intel.com>

On Thu, Feb 13, 2025 at 12:39:03PM -0800, Tantilov, Emil S wrote:
> On 2/12/2025 10:21 AM, Simon Horman wrote:
> > On Mon, Feb 10, 2025 at 06:38:51PM -0800, Emil Tantilov wrote:
> > > Current init logic ignores the error code from register_netdev(),
> > > which will cause WARN_ON() on attempt to unregister it, if there was one,
> > > and there is no info for the user that the creation of the netdev failed.
> > > 
> > > WARNING: CPU: 89 PID: 6902 at net/core/dev.c:11512 unregister_netdevice_many_notify+0x211/0x1a10
> > > ...
> > > [ 3707.563641]  unregister_netdev+0x1c/0x30
> > > [ 3707.563656]  idpf_vport_dealloc+0x5cf/0xce0 [idpf]
> > > [ 3707.563684]  idpf_deinit_task+0xef/0x160 [idpf]
> > > [ 3707.563712]  idpf_vc_core_deinit+0x84/0x320 [idpf]
> > > [ 3707.563739]  idpf_remove+0xbf/0x780 [idpf]
> > > [ 3707.563769]  pci_device_remove+0xab/0x1e0
> > > [ 3707.563786]  device_release_driver_internal+0x371/0x530
> > > [ 3707.563803]  driver_detach+0xbf/0x180
> > > [ 3707.563816]  bus_remove_driver+0x11b/0x2a0
> > > [ 3707.563829]  pci_unregister_driver+0x2a/0x250
> > > 
> > > Introduce an error check and log the vport number and error code.
> > > On removal make sure to check VPORT_REG_NETDEV flag prior to calling
> > > unregister and free on the netdev.
> > > 
> > > Add local variables for idx, vport_config and netdev for readability.
> > > 
> > > Fixes: 0fe45467a104 ("idpf: add create vport and netdev configuration")
> > > Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
> > > Suggested-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> > > Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
> > > ---
> > >   drivers/net/ethernet/intel/idpf/idpf_lib.c | 27 ++++++++++++++--------
> > >   1 file changed, 18 insertions(+), 9 deletions(-)
> > > 
> > > diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
> > 
> > ...
> > 
> > > @@ -1536,12 +1540,17 @@ void idpf_init_task(struct work_struct *work)
> > >   	}
> > >   	for (index = 0; index < adapter->max_vports; index++) {
> > > -		if (adapter->netdevs[index] &&
> > > -		    !test_bit(IDPF_VPORT_REG_NETDEV,
> > > -			      adapter->vport_config[index]->flags)) {
> > > -			register_netdev(adapter->netdevs[index]);
> > > -			set_bit(IDPF_VPORT_REG_NETDEV,
> > > -				adapter->vport_config[index]->flags);
> > > +		struct idpf_vport_config *vport_config = adapter->vport_config[index];
> > > +		struct net_device *netdev = adapter->netdevs[index];
> > > +
> > > +		if (netdev && !test_bit(IDPF_VPORT_REG_NETDEV, vport_config->flags)) {
> > > +			err = register_netdev(netdev);
> > > +			if (err) {
> > > +				dev_err(&pdev->dev, "failed to register netdev for vport %d: %pe\n",
> > > +					index, ERR_PTR(err));
> > > +				continue;
> > > +			}
> > > +			set_bit(IDPF_VPORT_REG_NETDEV, vport_config->flags);
> > >   		}
> > >   	}
> > 
> > Hi Emil,
> > 
> > I'm wondering if we could reduce indentation and lines longer
> > than 80 characters in the above like this (completely untested!):
> I was mostly trying to focus on the fix itself, since this patch is -net
> bound. The >80 line came about from the introduction of the local netdev and
> it seemed cleaner to keep it in one line. I can just split the check as in
> the original code.
> 
> > 
> > 
> > 	for (index = 0; index < adapter->max_vports; index++) {
> > 		struct idpf_vport_config *vport_config = adapter->vport_config[index];
> > 		struct net_device *netdev = adapter->netdevs[index];
> > 
> > 		if (!netdev ||
> > 		    test_bit(IDPF_VPORT_REG_NETDEV, vport_config->flags))
> > 		    continue;
> Again, because its mainly to add the error checking I am not sure if its OK
> to re-shuffle the logic.
> 
> > 
> > 		err = register_netdev(netdev);
> > 		if (err) {
> > 			dev_err(&pdev->dev, "failed to register netdev for vport %d: %pe\n",
> > 				index, ERR_PTR(err));
> > 			continue;
> > 		}
> > 		set_bit(IDPF_VPORT_REG_NETDEV, vport_config->flags);
> > 	}
> 
> Don't mind re-spinning (and testing) v2 with the proposed change, if it's
> not infringing on the guidelines for submission to -net.

Thanks,

I see your point about not wanting to change logic for a -net patch.

My feeling is that the change is trivial enough to fit within -net
boundaries. But if you think there is any risk of it regressing
then feel free to go with your original version.


