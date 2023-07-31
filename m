Return-Path: <netdev+bounces-22774-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0725276925A
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 11:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED8D91C2098F
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 09:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E8917AAF;
	Mon, 31 Jul 2023 09:52:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DB463A2
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 09:52:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F469C433C9;
	Mon, 31 Jul 2023 09:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690797144;
	bh=ZZaLyBm5ZDUCTizepLmPHUXNvZJng/oLcottkSvLjAQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lBCZta+nBeq8pMk/k1dcjNLyGGS31sRQq/hg4CxDkmfKf7PisowNGpN3gnApRv5HZ
	 7fPsnQ94cBwf4kD3SsccxgweYR63r3fgB+eT+1nAeUp/W4+dNJV3zRtCJvoDdFq8rh
	 5S+38ZwwIz6WO4p8SIcBeW8GkT9y0NygAiigObgb0BIVpD+pxmW8LdqiP4Sn98u9wo
	 7HToIL5oSpgQuWwqxcdFXUeuPSNH5fsEVXjTFRW/MwCiNQ5urdo/WH1WFmR5DnfKNS
	 EYVwwJIMeFEEjn7k42UFLtoMxPD55Sd4EYl9KhgDW67WuUo/1axgW8A2hw/J15KOxA
	 2c1agwlPQ3Jcg==
Date: Mon, 31 Jul 2023 11:52:19 +0200
From: Simon Horman <horms@kernel.org>
To: Ido Schimmel <idosch@idosch.org>
Cc: Vlad Buslov <vladbu@nvidia.com>, davem@davemloft.net, kuba@kernel.org,
	edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org,
	amir.hanania@intel.com, jeffrey.t.kirsher@intel.com,
	john.fastabend@gmail.com
Subject: Re: [PATCH net] vlan: Fix VLAN 0 memory leak
Message-ID: <ZMeEU/Aqq0ljY8NE@kernel.org>
References: <20230728163152.682078-1-vladbu@nvidia.com>
 <ZMaCB/Pek5c4baCn@shredder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZMaCB/Pek5c4baCn@shredder>

On Sun, Jul 30, 2023 at 06:30:15PM +0300, Ido Schimmel wrote:
> On Fri, Jul 28, 2023 at 06:31:52PM +0200, Vlad Buslov wrote:
> > The referenced commit intended to fix memleak of VLAN 0 that is implicitly
> > created on devices with NETIF_F_HW_VLAN_CTAG_FILTER feature. However, it
> > doesn't take into account that the feature can be re-set during the
> > netdevice lifetime which will cause memory leak if feature is disabled
> > during the device deletion as illustrated by [0]. Fix the leak by
> > unconditionally deleting VLAN 0 on NETDEV_DOWN event.
> 
> Specifically, what happens is:
> 
> > 
> > [0]:
> > > modprobe 8021q
> > > ip l set dev eth2 up
> 
> VID 0 is created with reference count of 1
> 
> > > ethtool -k eth2 | grep rx-vlan-filter
> > rx-vlan-filter: on
> > > ethtool -K eth2 rx-vlan-filter off
> > > ip l set dev eth2 down
> 
> Reference count is not dropped because the feature is off
> 
> > > ip l set dev eth2 up
> 
> Reference count is not increased because the feature is off. It could
> have been increased if this line was preceded by:
> 
> ethtool -K eth2 rx-vlan-filter on
> 
> > > modprobe -r mlx5_ib
> > > modprobe -r mlx5_core
> 
> Reference count is not dropped during NETDEV_DOWN because the feature is
> off and NETDEV_UNREGISTER only dismantles upper VLAN devices, resulting
> in VID 0 being leaked.

Thanks Ido and Vlad,

perhaps it would be worth including the information added
by Ido above in the patch description. Not a hard requirement
from my side, just an idea.

