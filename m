Return-Path: <netdev+bounces-30474-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E06787840
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 20:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 591831C20EAD
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 18:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFA621548F;
	Thu, 24 Aug 2023 18:52:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566ED11CAF
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 18:52:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF58EC433C8;
	Thu, 24 Aug 2023 18:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692903120;
	bh=F9KFzp3RIyYz1hSGj9sFsAsINDZWmj2HmYc1rwDFU4E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hhf7ihMJj2jCYtSAQXqyoolpxtXAy2heKNfDoFZ7KjrJBXoX7XOCd8sHXM1E0Zf3r
	 0AXt9LJ1tugA4inWVs/Osc2lOuI//uHv6VyMD7fwIaFcTPOkR0g2CsrItdSrQ72bGT
	 0dnbvQe+Z8ApCaDcvozkOo5jAvzKrq/gF3JxtloXbrtQY+WBlPPhRMQI+V4Lr2FWW4
	 KfSXcfz/8wmt96q/MRtYE7+jXqvisnQ2htsRNdCSBXnRBRzOWOJU83GH+vWCiM49A8
	 ok2rX1mjCFytqaOIYgS9GE5CCSmCUDnLP+htNbNEndNA1wyjiolIy3PuES8q3Db1MZ
	 YHAYOZOowhedg==
Date: Thu, 24 Aug 2023 11:51:59 -0700
From: Saeed Mahameed <saeed@kernel.org>
To: "Nabil S. Alramli" <dev@nalramli.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
	saeedm@nvidia.com, tariqt@nvidia.com, linux-kernel@vger.kernel.org,
	leon@kernel.org, jdamato@fastly.com, nalramli@fastly.com
Subject: Re: [net-next RFC 0/1] mlx5: support per queue coalesce settings
Message-ID: <ZOemz1HLp95aGXXQ@x130>
References: <20230823223121.58676-1-dev@nalramli.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230823223121.58676-1-dev@nalramli.com>

On 23 Aug 18:31, Nabil S. Alramli wrote:
>Hello,
>
>I am Submitting this as an RFC to get feedback and to find out if the folks
>at Mellanox would accept this change.
>
>Currently, only gobal coalescing configuration queries or changes are
>supported in the `mlx5` driver. However, per-queue operations are not, and
>result in `EOPNOTSUPP` errors when attempted with `ethtool`. This patch
>adds support for per-queue coalesce operations, with a caveat described
>below.
>
>Here's an example use case:
>
>- An mlx5 NIC is configured with 8 queues, each queue has its IRQ pinned
>  to a unique CPU.
>- Two custom RSS contexts are created: context 1 and context 2. Each
>  context has a different set of queues where flows are distributed. For
>  example, context 1 may distribute flows to queues 0-3, and context 2 may
>  distribute flows to queues 4-7.
>- A series of ntuple filters are installed which direct matching flows to
>  RSS contexts. For example, perhaps port 80 is directed to context 1 and
>  port 443 to context 2.
>- Applications which receive network data associated with either context
>  are pinned to the CPUs where the queues in the matching context have
>  their IRQs pinned to maximize locality.
>
>The apps themselves, however, may have different requirements on latency vs
>CPU usage and so setting the per queue IRQ coalesce values would be very
>helpful.
>
>This patch would support this, with the caveat that DIM mode changes per
>queue are not supported. DIM mode can only be changed NIC-wide. This is
>because in the mlx5 driver, global operations that change the state of
>adaptive-ex or adaptive-tx require a reset. So in the case of per-queue, we
>reject such requests. This was done in the interest of simplicity for this
>RFC as setting the DIM mode per queue appears to require significant
>changes to mlx5 to be able to preserve the state of the indvidual channels
>through a reset.
>
>IMO, if a user is going to set per-queue coalesce settings it might be
>reasonable to assume that they will disable adaptive rx/tx NIC wide first
>and then go through and apply their desired per-queue settings.
>

DIM is already per channel, so I don't think it's that difficult to have
mix support of DIM and static config per channel. Yes the code will need
some refactoring, but with a quick glance at the code provided here, such
refactoring is already required IMO.

>Here's an example:
>
>$ ethtool --per-queue eth0 queue_mask 0x4 --show-coalesce
>Queue: 2
>Adaptive RX: on  TX: on
>stats-block-usecs: 0
>sample-interval: 0
>pkt-rate-low: 0
>pkt-rate-high: 0
>
>rx-usecs: 8
>rx-frames: 128
>...
>
>Now, let's try to set adaptive-rx off rx-usecs 16 for queue 2:
>
>$ sudo ethtool --per-queue eth0 queue_mask 0x4 --coalesce adaptive-rx off \
>  rx-usecs 16
>Cannot set device per queue parameters: Operation not supported
>
>This is not supported; adaptive-rx must be disabled NIC wide first:
>
>$ sudo ethtool -C eth0 adaptive-rx off
>
>And now, queue_mask 0x4 can be applied to set rx-usecs:
>
>$ sudo ethtool --per-queue eth0 queue_mask 0x4 --coalesce rx-usecs 16
>$ ethtool --per-queue eth0 queue_mask 0x4 --show-coalesce
>Queue: 2
>Adaptive RX: off  TX: on
>stats-block-usecs: 0
>sample-interval: 0
>pkt-rate-low: 0
>pkt-rate-high: 0
>
>rx-usecs: 16
>rx-frames: 32
>...
>
>Previously a global `struct mlx5e_params` stored the options in
>`struct mlx5e_priv.channels.params`. That was preserved, but a channel-
>specific instance was added as well, in `struct mlx5e_channel.params`.
>
>Note that setting global coalescing options will set the individual
>channel settings to the same values as well.
>
>Is Mellanox open to this change? What would be needed to get something like
>this accepted?
>

Sure, we just need to pass review and few testing cycles.

Thanks,
Saeed.


