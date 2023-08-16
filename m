Return-Path: <netdev+bounces-27834-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CCC977D6F6
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 02:16:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B201E1C20E6D
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 00:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0393194;
	Wed, 16 Aug 2023 00:16:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B0518E
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 00:16:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93F36C433C8;
	Wed, 16 Aug 2023 00:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692145000;
	bh=9jDxjIYaWTgdaXt4KLg0RNynKVE687/E9yu7R92n20Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oUjBNZiuWawKJL8Z4MtNtqacNst9LR3N4uNY86PWSfbuGCX9rCzfherY6XxJz+S51
	 r4xgDOBltZHLu0Qep8/LkpLE25ma/FLDT2ZMXD9Bi8kHdg0vfJM7tljxkL/x3HBEe/
	 wCf7dB2wuoz8NzVAm1tpKffWOg//bvhgA2MvxFtrLuogwywgDvi/bzQtlutAS0u+PW
	 FXTvv5SvomVtW0X2VyvZXLn1uJujl8uG1Cn4U/8rR4F03XxwcYJ66uOWMG0xuG/yvZ
	 tu4H0985rMHpa4b8mmWxDgscF31UA+vqWN8gVg4rz42KpCOd0UF7p1IuJbyqKDUDPA
	 qe6Emi67goRMA==
Date: Tue, 15 Aug 2023 17:16:38 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Ahern <dsahern@kernel.org>
Cc: Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jesper
 Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Magnus Karlsson <magnus.karlsson@intel.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, sdf@google.com, Willem
 de Bruijn <willemb@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>
Subject: Re: [RFC PATCH v2 02/11] netdev: implement netlink api to bind
 dma-buf to netdevice
Message-ID: <20230815171638.4c057dcd@kernel.org>
In-Reply-To: <7dd4f5b0-0edf-391b-c8b4-3fa82046ab7c@kernel.org>
References: <20230810015751.3297321-1-almasrymina@google.com>
	<20230810015751.3297321-3-almasrymina@google.com>
	<7dd4f5b0-0edf-391b-c8b4-3fa82046ab7c@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 13 Aug 2023 19:10:35 -0600 David Ahern wrote:
> Also, this suggests that the Rx queue is unique to the flow. I do not
> recall a netdev API to create H/W queues on the fly (only a passing
> comment from Kuba), so how is the H/W queue (or queue set since a
> completion queue is needed as well) created for the flow?
> And in turn if it is unique to the flow, what deletes the queue if
> an app does not do a proper cleanup? If the queue sticks around,
> the dmabuf references stick around.

Let's start sketching out the design for queue config.
Without sliding into scope creep, hopefully.

Step one - I think we can decompose the problem into:
 A) flow steering
 B) object lifetime and permissions
 C) queue configuration (incl. potentially creating / destroying queues)

These come together into use scenarios like:
 #1 - partitioning for containers - when high perf containers share
      a machine each should get an RSS context on the physical NIC
      to have predictable traffic<>CPU placement, they may also have
      different preferences on how the queues are configured, maybe
      XDP, too?
 #2 - fancy page pools within the host (e.g. huge pages)
 #3 - very fancy page pools not within the host (Mina's work)
 #4 - XDP redirect target (allowing XDP_REDIRECT without installing XDP
      on the target)
 #5 - busy polling - admittedly a bit theoretical, I don't know of
      anyone busy polling in real life, but one of the problems today
      is that setting it up requires scraping random bits of info from
      sysfs and a lot of hoping.

Flow steering (A) is there today, to a sufficient extent, I think,
so we can defer on that. Sooner or later we should probably figure
out if we want to continue down the unruly path of TC offloads or
just give up and beef up ethtool.

I don't have a good sense of what a good model for cleanup and
permissions is (B). All I know is that if we need to tie things to
processes netlink can do it, and we shouldn't have to create our
own FS and special file descriptors...

And then there's (C) which is the main part to talk about.
The first step IMHO is to straighten out the configuration process.
Currently we do:

 user -> thin ethtool API --------------------> driver
                              netdev core <---'

By "straighten" I mean more of a:

 user -> thin ethtool API ---> netdev core ---> driver

flow. This means core maintains the full expected configuration,
queue count and their parameters and driver creates those queues
as instructed.

I'd imagine we'd need 4 basic ops:
 - queue_mem_alloc(dev, cfg) -> queue_mem
 - queue_mem_free(dev, cfg, queue_mem)
 - queue_start(dev, queue info, cfg, queue_mem) -> errno
 - queue_stop(dev, queue info, cfg)

The mem_alloc/mem_free takes care of the commonly missed requirement to
not take the datapath down until resources are allocated for new config.

Core then sets all the queues up after ndo_open, and tears down before
ndo_stop. In case of an ethtool -L / -G call or enabling / disabling XDP
core can handle the entire reconfiguration dance.

The cfg object needs to contain all queue configuration, including 
the page pool parameters.

If we have an abstract model of the configuration in the core we can
modify it much more easily, I hope. I mean - the configuration will be
somewhat detached from what's instantiated in the drivers.

I'd prefer to go as far as we can without introducing a driver callback
to "check if it can support a config change", and try to rely on
(static) capabilities instead. This allows more of the validation to
happen in the core and also lends itself naturally to exporting the
capabilities to the user.

Checking the use cases:

 #1 - partitioning for containers - storing the cfg in the core gives
      us a neat ability to allow users to set the configuration on RSS
      context
 #2, #3 - page pools - we can make page_pool_create take cfg and read whatever
      params we want from there, memory provider, descriptor count, recycling
      ring size etc. Also for header-data-split we may want different settings
      per queue so again cfg comes in handy
 #4 - XDP redirect target - we should spawn XDP TX queues independently from
      the XDP configuration

That's all I have thought up in terms of direction.
Does that make sense? What are the main gaps? Other proposals?

