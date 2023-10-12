Return-Path: <netdev+bounces-40558-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDFC47C7A99
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 01:48:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 165EB1C209E0
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 23:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD7E2B5F9;
	Thu, 12 Oct 2023 23:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NKMEaBmp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F636EA6
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 23:48:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AD67C433C8;
	Thu, 12 Oct 2023 23:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697154534;
	bh=IvzT/fingfti1utCmgBF6Owx37moTwHEQGHxB6m3InQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NKMEaBmpbmP+ORhplx5q5kYBazizbtF2EXa2JhFmbij/EvOI0tW2p/ciHdfTVCgNa
	 0I7geaElNq6XyTIF05xxYlgRP87vCHUdTwUuYgJVepOFzQxVK9xhAEZcblKEYFlp4W
	 QnJjKuLJLvrhz5MSM7nMTBHsJBxrym57WPvYr0FdzW1J/BIPRQct0PDtITZiSN/eD4
	 8xHY1AKR741H5Ld7oDhN+w2qRPaRqjyir8PrCWzbLJPU93Yg02UYGAGEVUoM+Y+0rK
	 p0uQ3WHvJAg/6bNp6MOct7NpJ0BqL1ayVKqjVUCiFoTRcRkNQP8YTKfLe+Wlgj61K5
	 aedu6i/hv3vCg==
Date: Thu, 12 Oct 2023 16:48:53 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Nambiar, Amritha" <amritha.nambiar@intel.com>
Cc: <netdev@vger.kernel.org>, <sridhar.samudrala@intel.com>
Subject: Re: [net-next PATCH v4 04/10] netdev-genl: Add netlink framework
 functions for queue
Message-ID: <20231012164853.7882fa86@kernel.org>
In-Reply-To: <fe26f9b6-ff3d-441d-887d-9f65d44f06d0@intel.com>
References: <169658340079.3683.13049063254569592908.stgit@anambiarhost.jf.intel.com>
	<169658369951.3683.3529038539593903265.stgit@anambiarhost.jf.intel.com>
	<20231010192555.3126ca42@kernel.org>
	<fe26f9b6-ff3d-441d-887d-9f65d44f06d0@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Oct 2023 16:54:00 -0700 Nambiar, Amritha wrote:
> >> +static int netdev_nl_queue_validate(struct net_device *netdev, u32 q_id,
> >> +				    u32 q_type)
> >> +{
> >> +	switch (q_type) {
> >> +	case NETDEV_QUEUE_TYPE_RX:
> >> +		if (q_id >= netdev->real_num_rx_queues)
> >> +			return -EINVAL;
> >> +		return 0;
> >> +	case NETDEV_QUEUE_TYPE_TX:
> >> +		if (q_id >= netdev->real_num_tx_queues)
> >> +			return -EINVAL;
> >> +		return 0;
> >> +	default:
> >> +		return -EOPNOTSUPP;  
> > 
> > Doesn't the netlink policy prevent this already?  
> 
> For this, should I be using "checks: max:" as an attribute property for 
> the 'queue-id' attribute in the yaml. If so, not sure how I can give a 
> custom value (not hard-coded) for max.
> Or should I include a pre-doit hook.

Weird, I was convinced that if you specify enum by default the code gen
will automatically generate the range check to make sure that the value
is within the enum..

Looks like it does, this is the policy, right?

+static const struct nla_policy netdev_queue_get_do_nl_policy[NETDEV_A_QUEUE_QUEUE_TYPE + 1] = {
+	[NETDEV_A_QUEUE_IFINDEX] = NLA_POLICY_MIN(NLA_U32, 1),
+	[NETDEV_A_QUEUE_QUEUE_TYPE] = NLA_POLICY_MAX(NLA_U32, 1),
 	                              ^^^^^^^^^^^^^^^^^^^^^^^^^^^

