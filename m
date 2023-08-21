Return-Path: <netdev+bounces-29441-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 125D578342B
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 23:02:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF4891C20909
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 21:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5484811CAB;
	Mon, 21 Aug 2023 21:02:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8044C9E
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 21:02:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AF61C433C7;
	Mon, 21 Aug 2023 21:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692651727;
	bh=gB2ytj3wFcjOc7INZ/jOObKGQyEl+qPZEUtXpCWGRnk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gFJBYbf3Ad/ZYPHvxcB4P34kM2LlcHRd2+lplCl+ODFEhFQ+D04GoYD7u2+/2ld9l
	 x84X+Ujzr51lI1JQEUd9oD5NcBK6BvSy9/qW+uVWs1l4LBIauuy1lHIDmgeELBg710
	 1KXHyynwojVxk7QxtNi+JBZMIDZOqsPVja5M7qi5g1ym6myWEiwLKhH77um6vWl8yZ
	 z3rQG++nCimlhKGvOsJWvfI81hsGO2dtXfxC1jsRLn8oEmf1gBzX+9TG0s5xmvhFiO
	 K3N8LKR4yWxD8VDXjRjc9ms81p8gQHV4yI9nEoWa4edPoB3LN9KWor4t4XmadYIbsk
	 vPzA5QCQy4/aA==
Date: Mon, 21 Aug 2023 14:02:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Linga, Pavan Kumar" <pavan.kumar.linga@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, <davem@davemloft.net>,
 <pabeni@redhat.com>, <edumazet@google.com>, <netdev@vger.kernel.org>, Alan
 Brady <alan.brady@intel.com>, <emil.s.tantilov@intel.com>,
 <jesse.brandeburg@intel.com>, <sridhar.samudrala@intel.com>,
 <shiraz.saleem@intel.com>, <sindhu.devale@intel.com>, <willemb@google.com>,
 <decot@google.com>, <andrew@lunn.ch>, <leon@kernel.org>, <mst@redhat.com>,
 <simon.horman@corigine.com>, <shannon.nelson@amd.com>,
 <stephen@networkplumber.org>, Alice Michael <alice.michael@intel.com>,
 Joshua Hay <joshua.a.hay@intel.com>, Phani Burra <phani.r.burra@intel.com>
Subject: Re: [PATCH net-next v5 14/15] idpf: add ethtool callbacks
Message-ID: <20230821140205.4d3bc797@kernel.org>
In-Reply-To: <b12c2182-484f-249f-1fd6-8cc8fafb1c6a@intel.com>
References: <20230816004305.216136-1-anthony.l.nguyen@intel.com>
	<20230816004305.216136-15-anthony.l.nguyen@intel.com>
	<20230818115824.446d1ea7@kernel.org>
	<b12c2182-484f-249f-1fd6-8cc8fafb1c6a@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 21 Aug 2023 13:41:15 -0700 Linga, Pavan Kumar wrote:
> On 8/18/2023 11:58 AM, Jakub Kicinski wrote:
> > On Tue, 15 Aug 2023 17:43:04 -0700 Tony Nguyen wrote:  
> >> +static u32 idpf_get_rxfh_indir_size(struct net_device *netdev)
> >> +{
> >> +	struct idpf_vport *vport = idpf_netdev_to_vport(netdev);
> >> +	struct idpf_vport_user_config_data *user_config;
> >> +
> >> +	if (!vport)
> >> +		return -EINVAL;  
> > 
> > defensive programming? how do we have a netdev and no vport?
> 
> During a hardware reset, the control plane will reinitialize its vport 
> configuration along with the hardware resources which in turn requires 
> the driver to reallocate the vports as well. For this reason the vports 
> will be freed, but the netdev will be preserved.

HW reset path should take appropriate locks so that the normal control
path can't be exposed to transient errors.

User space will 100% not know what to do with a GET reporting EINVAL.

> >> +	dev = &vport->adapter->pdev->dev;
> >> +	if (!(ch->combined_count || (ch->rx_count && ch->tx_count))) {
> >> +		dev_err(dev, "Please specify at least 1 Rx and 1 Tx channel\n");  
> > 
> > The error msg doesn't seem to fit the second part of the condition.
> >
> 
> The negation part is to the complete check which means it takes 0 
> [tx|rx]_count into consideration.

Ah, missed the negation. In that case I think the check is not needed,
pretty sure core checks this.

> >> +		return -EINVAL;
> >> +	}
> >> +
> >> +	num_req_tx_q = ch->combined_count + ch->tx_count;
> >> +	num_req_rx_q = ch->combined_count + ch->rx_count;
> >> +
> >> +	dev = &vport->adapter->pdev->dev;
> >> +	/* It's possible to specify number of queues that exceeds max in a way
> >> +	 * that stack won't catch for us, this should catch that.
> >> +	 */  
> > 
> > How, tho?
> 
> If the user tries to pass the combined along with the txq or rxq values, 
> then it is possbile to cross the max supported values. So the following 
> checks are needed to protect those cases. Core checks the max values for 
> the individual arguments but not the combined + [tx|rx].

I see, please add something along those lines to the comment.

