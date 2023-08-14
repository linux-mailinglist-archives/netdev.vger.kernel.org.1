Return-Path: <netdev+bounces-27392-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B52A77BC98
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 17:13:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EEE31C209E3
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 15:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E58C2C6;
	Mon, 14 Aug 2023 15:13:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E945AC15A
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 15:13:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23D38C433C9;
	Mon, 14 Aug 2023 15:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692025998;
	bh=MYdR2D7rrLSEROerrYC7+jiqBmgHTY2w85tBa8Y7HJo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=quCiA7mAxaOJz8/2LGF9lU+M2gHQDZjEE5RMELpxD4RubLQczw1XCyZKauPRmdbBo
	 cQ7/CIIgGdmbPVdzy/FCkdl9ZKD5yPNjUxpZo+m5xYi7hsC4RWbS3TxG6u1cla6m+I
	 lh3xzVMzTAMYrGUZ2x8vrrMxg3ov3IwRS+X2G9zR9hLexheVVZ7YrXnIJ/0NVp38dk
	 8wry0TyiN4VC8kJas9lzkGqdi2xDlAWwdhW0P3jCiEvDqkKID8ZHW9R/XQsPAvtnJR
	 J8idRfe4bUmwVzZfivjMwmNXieJ4D0PDEfaN+SWsqQCFHFdXSdUqZlPh3aDDPYye9K
	 tS+jhcYXOy/nw==
Date: Mon, 14 Aug 2023 17:13:14 +0200
From: Simon Horman <horms@kernel.org>
To: Ruan Jinjie <ruanjinjie@huawei.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next] ethernet: rocker: Use is_broadcast_ether_addr()
 and is_multicast_ether_addr() instead of ether_addr_equal()
Message-ID: <ZNpEisA0RxM+xZPR@vergenet.net>
References: <20230814022948.2019698-1-ruanjinjie@huawei.com>
 <ZNncFhibJLTLr5Q6@vergenet.net>
 <9ba3395d-39d6-6562-ff22-876932847792@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9ba3395d-39d6-6562-ff22-876932847792@huawei.com>

On Mon, Aug 14, 2023 at 04:32:56PM +0800, Ruan Jinjie wrote:
> 
> 
> On 2023/8/14 15:47, Simon Horman wrote:
> > On Mon, Aug 14, 2023 at 10:29:48AM +0800, Ruan Jinjie wrote:
> >> Use is_broadcast_ether_addr() and is_multicast_ether_addr() instead of
> >> ether_addr_equal() to check if the ethernet address is broadcast
> >> and multicast address separately.
> >>
> >> Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
> > 
> > Hi,
> > 
> > Perhaps we could go for a more concise prefix and subject, as the current one
> > is rather long. Maybe something like:
> > 
> > Subject: [PATCH net-next]: rocker: Use helpers to check broadcast and multicast Ether addresses
> 
> Right！That is more concise.
> 
> > 
> >> ---
> >>  drivers/net/ethernet/rocker/rocker_ofdpa.c | 5 ++---
> >>  1 file changed, 2 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/net/ethernet/rocker/rocker_ofdpa.c b/drivers/net/ethernet/rocker/rocker_ofdpa.c
> >> index 826990459fa4..7f389f3adbf4 100644
> >> --- a/drivers/net/ethernet/rocker/rocker_ofdpa.c
> >> +++ b/drivers/net/ethernet/rocker/rocker_ofdpa.c
> >> @@ -208,7 +208,6 @@ static const u8 zero_mac[ETH_ALEN]   = { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 };
> >>  static const u8 ff_mac[ETH_ALEN]     = { 0xff, 0xff, 0xff, 0xff, 0xff, 0xff };
> >>  static const u8 ll_mac[ETH_ALEN]     = { 0x01, 0x80, 0xc2, 0x00, 0x00, 0x00 };
> >>  static const u8 ll_mask[ETH_ALEN]    = { 0xff, 0xff, 0xff, 0xff, 0xff, 0xf0 };
> >> -static const u8 mcast_mac[ETH_ALEN]  = { 0x01, 0x00, 0x00, 0x00, 0x00, 0x00 };
> >>  static const u8 ipv4_mcast[ETH_ALEN] = { 0x01, 0x00, 0x5e, 0x00, 0x00, 0x00 };
> >>  static const u8 ipv4_mask[ETH_ALEN]  = { 0xff, 0xff, 0xff, 0x80, 0x00, 0x00 };
> >>  static const u8 ipv6_mcast[ETH_ALEN] = { 0x33, 0x33, 0x00, 0x00, 0x00, 0x00 };
> >> @@ -939,7 +938,7 @@ static int ofdpa_flow_tbl_bridge(struct ofdpa_port *ofdpa_port,
> >>  	if (eth_dst_mask) {
> >>  		entry->key.bridge.has_eth_dst_mask = 1;
> >>  		ether_addr_copy(entry->key.bridge.eth_dst_mask, eth_dst_mask);
> >> -		if (!ether_addr_equal(eth_dst_mask, ff_mac))
> >> +		if (!is_broadcast_ether_addr(eth_dst_mask))
> > 
> > Probably it is ok, but is_broadcast_ether_addr()
> > covers a set of addresses that includes ff_mac.
> 
> I reconfirmed that they are equivalent, is_broadcast_ether_addr()
> requires all six bytes to be F.

Right, agreed.  Sorry for misunderstanding the implementation of
is_broadcast_ether_addr() when I checked earlier today.

> 
> > 
> >>  			wild = true;
> >>  	}
> >>  
> >> @@ -1012,7 +1011,7 @@ static int ofdpa_flow_tbl_acl(struct ofdpa_port *ofdpa_port, int flags,
> >>  
> >>  	priority = OFDPA_PRIORITY_ACL_NORMAL;
> >>  	if (eth_dst && eth_dst_mask) {
> >> -		if (ether_addr_equal(eth_dst_mask, mcast_mac))
> >> +		if (is_multicast_ether_addr(eth_dst_mask))
> > 
> > Likewise, is_multicast_ether_addr()
> > covers a set of addresses that includes mcast_mac.
> 
> They are not exactly equivalent，the address what the mcast_mac get is
> the subset of is_multicast_ether_addr().
> 
> > 
> >>  			priority = OFDPA_PRIORITY_ACL_DFLT;
> >>  		else if (is_link_local_ether_addr(eth_dst))
> >>  			priority = OFDPA_PRIORITY_ACL_CTRL;
> >> -- 
> >> 2.34.1
> >>
> >>
> 

