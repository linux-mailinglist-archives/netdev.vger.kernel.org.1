Return-Path: <netdev+bounces-30818-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 129297892B7
	for <lists+netdev@lfdr.de>; Sat, 26 Aug 2023 02:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE61928173E
	for <lists+netdev@lfdr.de>; Sat, 26 Aug 2023 00:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7A5537E;
	Sat, 26 Aug 2023 00:34:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22FA318D
	for <netdev@vger.kernel.org>; Sat, 26 Aug 2023 00:34:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F0EEC433C7;
	Sat, 26 Aug 2023 00:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693010071;
	bh=WsHqZIbqH7sNMSl0gOhXWhTfkCHMA3rvDRqf4adIg7c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YrgniW2NjA0FJOr+0tv89LoieYZCuQ9XD1rDjWCcoP8Z5ENT4SmA4pF1IRJwbNPIQ
	 60fzCnKAgCgxkOlSW/uBwdWA7E7Fcop6iYtLXzanY6d76miohH4I+pbm7vP0v4vhsK
	 yPbavf0EOFOLDvGA2wR1whTZCMd7DnzySmm3ypfU/htGJI8Jfs1QAfvZr9Xn0SjMiC
	 yVthDGiqNWrFlf0KrqTvnDHhmNn9zzviYEVIKmK1qjkks36edZUQZPGiDAXueUFV3F
	 VRUGKznN+0N4fvnERgM2temYJTHe+kcoFTVNA7HX9V3xqOZwjFFfJhg293U6+qGLfc
	 YPgsLgpA16iBA==
Date: Fri, 25 Aug 2023 17:34:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Zulkifli, Muhammad Husaini" <muhammad.husaini.zulkifli@intel.com>
Cc: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "davem@davemloft.net"
 <davem@davemloft.net>, "pabeni@redhat.com" <pabeni@redhat.com>,
 "edumazet@google.com" <edumazet@google.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "Neftin, Sasha" <sasha.neftin@intel.com>,
 "horms@kernel.org" <horms@kernel.org>, "bcreeley@amd.com"
 <bcreeley@amd.com>, Naama Meir <naamax.meir@linux.intel.com>
Subject: Re: [PATCH net v3 2/2] igc: Modify the tx-usecs coalesce setting
Message-ID: <20230825173429.2a2d0d9f@kernel.org>
In-Reply-To: <SJ1PR11MB6180835AA3B1C2CC9611B44AB8E3A@SJ1PR11MB6180.namprd11.prod.outlook.com>
References: <20230822221620.2988753-1-anthony.l.nguyen@intel.com>
	<20230822221620.2988753-3-anthony.l.nguyen@intel.com>
	<20230823191928.1a32aed7@kernel.org>
	<SJ1PR11MB6180CA2B18577F8D10E8490DB81DA@SJ1PR11MB6180.namprd11.prod.outlook.com>
	<20230824170022.5a055c55@kernel.org>
	<SJ1PR11MB6180835AA3B1C2CC9611B44AB8E3A@SJ1PR11MB6180.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 25 Aug 2023 03:44:35 +0000 Zulkifli, Muhammad Husaini wrote:
> > I see. Maybe it's better to combine the patches, they are a bit hard to review
> > in separation.  
> 
> IMHO, I would like to separate get and set function in different patch.
> Maybe I can add more details in commit message. Is it okay?

That's exactly what confused me. You made it sound like first patch is
only about GET but it actually also changes SET.

> > I was just thinking of something along the lines of:
> > 
> > if (adapter->flags & IGC_FLAG_QUEUE_PAIRS &&
> >     adapter->tx_itr_setting != adapter->rx_itr_setting)
> >    ... error ...
> > 
> > would that work?  
> 
> Thank you for the suggestion, but it appears that additional checking is required. 
> I tested it with the code below, and it appears to work.
> 
> 		/* convert to rate of irq's per second */
> 		if ((old_tx_itr != ec->tx_coalesce_usecs) && (old_rx_itr == ec->rx_coalesce_usecs)) {
> 			adapter->tx_itr_setting =
> 				igc_ethtool_coalesce_to_itr_setting(ec->tx_coalesce_usecs);
> 			adapter->rx_itr_setting = adapter->tx_itr_setting;
> 		} else if ((old_rx_itr != ec->rx_coalesce_usecs) && (old_tx_itr == ec->tx_coalesce_usecs)) {
> 			adapter->rx_itr_setting =
> 				igc_ethtool_coalesce_to_itr_setting(ec->rx_coalesce_usecs);
> 			adapter->tx_itr_setting = adapter->rx_itr_setting;
> 		} else {
> 			NL_SET_ERR_MSG_MOD(extack, "Unable to set both TX and RX due to Queue Pairs Flag");
> 			return -EINVAL;
> 		}

What if user space does:

  cmd = "ethtool -C eth0 "
  if rx_mismatch:
    cmd += "rx-usecs " + rxu + " "
  if tx_mismatch:
    cmd += "tx-usecs " + txu + " "
  system(cmd)

Why do you think that the auto-update of the other value matters 
so much? With a clear warning user should be able to figure
out that they need to set the values identically.

If you want to auto-update maybe only allow rx-usecs changes?

Basically:

  if (old_tx != ec->tx_coalesce_usecs) {
    NL_SET_ERR_MSG_MOD(extack, "Queue Pair mode enabled, both Rx and Tx coalescing controlled by rx-usecs");
   return -EINVAL;
  }
  rx_itr = tx_itr = logic(ec->tx_coalesce_usecs);


I hate these auto-magic changes, because I had to email support /
vendors in the past asking them "what does the device _actually_
do" / "what is the device capable of" due to the driver doing magic.
The API is fairly clear. If user wants rx and tx to be different,
and the device does not support that -- error.

