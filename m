Return-Path: <netdev+bounces-118584-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 968B0952280
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 21:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 175521F23718
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 19:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1AF81BE254;
	Wed, 14 Aug 2024 19:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D3P2JAD2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2BBB679
	for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 19:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723662707; cv=none; b=VmJBX7tn9pep+cg8CxXBWk95hcMZ7S/q3lm2l2c03CZZEwh120dWOySnjbRsqkVDU/AGg+qvkxkNShn15e5Oeu0E/uW8L8wG0NQqzDJYdadkyf3gru939yA91kbMAYOi5RGGQtBDjo22gAPFCP9o0iO9YQ9pLdaLDh/wjvNCiWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723662707; c=relaxed/simple;
	bh=VcmlmTXDV4KXDOB1h9BS0wkwd7KF9mO8IUQjqM61JtI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F8SZOsM+0+CMYBBE2dGX6A0a2nRDA1dAGQy2nv9t+wHY810up+C1bzM+1AJRefo7roVNSmZZS98CEPSPjGsiT04DW1cyWDMjZ/6+sN5+kHj2HRgQQ0Q/kTBDQYuvD9XMvsGOXJ7y6xf3JmmZUpsrxFhp+dhH0wPp2AldxKHGsDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D3P2JAD2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3665C116B1;
	Wed, 14 Aug 2024 19:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723662707;
	bh=VcmlmTXDV4KXDOB1h9BS0wkwd7KF9mO8IUQjqM61JtI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=D3P2JAD2j1598XvxGC0/Wo58CAHH5Eeo3dPv/EeuY4hfes9k+xpZ1tgLqHn0fzi4z
	 qd59NvjGGDwG2ngV+mOTNcaKqpwiL/EOaMPA+/4UilH6drxbRSLgl0QHlKyJkq/Eft
	 9BZdEJmwJiYWmwQo+VDNvGr8aHYu4pUdlTVvPB2LeUadsbQHD1CNfeVY1Ahp5TCwWk
	 NXlhjQnZhoNOcbKOHMNTJ0ry3EZb/IjzSo7bjKC1FI52IGcW/Pfq8zG/P/V45B/VkJ
	 IJ2eJyreUluVPOWbekfVREOMfFVIjgaoQACun6Jwz2nEy4SagyvGLt6AH6forS2YEP
	 KDpXtxyXvvFRA==
Date: Wed, 14 Aug 2024 12:11:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "Michael S. Tsirkin"
 <mst@redhat.com>
Cc: "Arinzon, David" <darinzon@amazon.com>, David Miller
 <davem@davemloft.net>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 "Woodhouse, David" <dwmw@amazon.co.uk>, "Machulsky, Zorik"
 <zorik@amazon.com>, "Matushevsky, Alexander" <matua@amazon.com>, "Bshara,
 Saeed" <saeedb@amazon.com>, "Wilson, Matt" <msw@amazon.com>, "Liguori,
 Anthony" <aliguori@amazon.com>, "Bshara, Nafea" <nafea@amazon.com>,
 "Belgazal, Netanel" <netanel@amazon.com>, "Saidi, Ali"
 <alisaidi@amazon.com>, "Herrenschmidt, Benjamin" <benh@amazon.com>,
 "Kiyanovski, Arthur" <akiyano@amazon.com>, "Dagan, Noam"
 <ndagan@amazon.com>, "Agroskin, Shay" <shayagr@amazon.com>, "Itzko, Shahar"
 <itzko@amazon.com>, "Abboud, Osama" <osamaabb@amazon.com>, "Ostrovsky,
 Evgeny" <evostrov@amazon.com>, "Tabachnik, Ofir" <ofirt@amazon.com>,
 "Beider, Ron" <rbeider@amazon.com>, "Chauskin, Igor" <igorch@amazon.com>,
 "Bernstein, Amit" <amitbern@amazon.com>, Parav Pandit <parav@nvidia.com>,
 Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v1 net-next 2/2] net: ena: Extend customer metrics
 reporting support
Message-ID: <20240814121145.37202722@kernel.org>
In-Reply-To: <8aea0fda1e48485291312a4451aa5d7c@amazon.com>
References: <20240811100711.12921-1-darinzon@amazon.com>
	<20240811100711.12921-3-darinzon@amazon.com>
	<20240812185852.46940666@kernel.org>
	<9ea916b482fb4eb3ace2ca2fe62abd64@amazon.com>
	<20240813081010.02742f87@kernel.org>
	<8aea0fda1e48485291312a4451aa5d7c@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 Aug 2024 15:31:49 +0000 Arinzon, David wrote:
> I've looked into the definition of the metrics under question
> 
> Based on AWS documentation (https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/monitoring-network-performance-ena.html)
> 
> bw_in_allowance_exceeded: The number of packets queued or dropped because the inbound aggregate bandwidth exceeded the maximum for the instance.
> bw_out_allowance_exceeded: The number of packets queued or dropped because the outbound aggregate bandwidth exceeded the maximum for the instance.
> 
> Based on the netlink spec (https://docs.kernel.org/next/networking/netlink_spec/netdev.html)
> 
> rx-hw-drop-ratelimits (uint)
> doc: Number of the packets dropped by the device due to the received packets bitrate exceeding the device rate limit.
> tx-hw-drop-ratelimits (uint)
> doc: Number of the packets dropped by the device due to the transmit packets bitrate exceeding the device rate limit.
> 
> The AWS metrics are counting for packets dropped or queued (delayed, but are sent/received with a delay), a change in these metrics is an indication to customers to check their applications and workloads due to risk of exceeding limits.
> There's no distinction between dropped and queued in these metrics, therefore, they do not match the ratelimits in the netlink spec.
> In case there will be a separation of these metrics in the future to dropped and queued, we'll be able to add the support for hw-drop-ratelimits.

Xuan, Michael, the virtio spec calls out drops due to b/w limit being
exceeded, but AWS people say their NICs also count packets buffered
but not dropped towards a similar metric.

I presume the virtio spec is supposed to cover the same use cases.
Have the stats been approved? Is it reasonable to extend the definition
of the "exceeded" stats in the virtio spec to cover what AWS specifies? 
Looks like PR is still open:
https://github.com/oasis-tcs/virtio-spec/issues/180

