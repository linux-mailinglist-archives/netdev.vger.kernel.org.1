Return-Path: <netdev+bounces-16539-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB68174DBD7
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 19:01:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16F9D1C20B50
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 17:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2956113AC8;
	Mon, 10 Jul 2023 17:01:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E919107B4
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 17:01:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB1A7C433C8;
	Mon, 10 Jul 2023 17:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689008472;
	bh=qbedC+CEZGGowsOX3QTR+AZn3qIyMt22m5TC4lpnFgU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sXSWTPT3Y707uL1JwXeMeRpMa5aZmuG9jl3GWnwWQjeeQJ1y97TVCmngtjfef4Ua0
	 JgTpNzQMf3tD++EZamcQ3nDy/ZAxvt8wyQphBt7DVs8FRQiFo4HZt2jZFK6K/cKzee
	 8RvARyERzAlP2Qj7w6niSsliTwBOgNFk1TB7Nk3X1ByQuCvNW+Af3ADn2fOpAoOhb7
	 stEM3DK12hWcITYaOriLxaTZkXkSu1xvIoF7pCgMZDdQX1owY2WwejljfIb/WHPKKU
	 HZ7FUVx1NJN58JDESVlkBoIFM/WzS0JWUzukcKGgXfTpjR45cfJKGjQhvFPSSFqUGi
	 qVLvWkqaHOrUA==
Date: Mon, 10 Jul 2023 10:01:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ilya Maximets <i.maximets@ovn.org>
Cc: Eric Garver <eric@garver.life>, Aaron Conole <aconole@redhat.com>,
 netdev@vger.kernel.org, dev@openvswitch.org, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "David S. Miller"
 <davem@davemloft.net>, Adrian Moreno <amorenoz@redhat.com>, Eelco Chaudron
 <echaudro@redhat.com>
Subject: Re: [ovs-dev] [PATCH net-next 2/2] net: openvswitch: add drop
 action
Message-ID: <20230710100110.52ce3d4c@kernel.org>
In-Reply-To: <096871e8-3c0b-d5d7-8e68-833ba26b3882@ovn.org>
References: <20230629203005.2137107-1-eric@garver.life>
	<20230629203005.2137107-3-eric@garver.life>
	<f7tr0plgpzb.fsf@redhat.com>
	<ZKbITj-FWGqRkwtr@egarver-thinkpadt14sgen1.remote.csb>
	<6060b37e-579a-76cb-b853-023cb1a25861@ovn.org>
	<20230707080025.7739e499@kernel.org>
	<eb01326d-5b30-2d58-f814-45cd436c581a@ovn.org>
	<dec509a4-3e36-e256-b8c0-74b7eed48345@ovn.org>
	<20230707150610.4e6e1a4d@kernel.org>
	<096871e8-3c0b-d5d7-8e68-833ba26b3882@ovn.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Jul 2023 18:51:19 +0200 Ilya Maximets wrote:
> Makes sense.  I wasn't sure that's a good solution from a kernel perspective
> either.  It's better than defining all these reasons, IMO, but it's not good
> enough to be considered acceptable, I agree.
> 
> How about we define just 2 reasons, e.g. OVS_DROP_REASON_EXPLICIT_ACTION and
> OVS_DROP_REASON_EXPLICIT_ACTION_WITH_ERROR (exact names can be different) ?
> One for an explicit drop action with a zero argument and one for an explicit
> drop with non-zero argument.
> 
> The exact reason for the error can be retrieved by other means, i.e by looking
> at the datapath flow dump or OVS logs/traces.
> 
> This way we can give a user who is catching packet drop traces a signal that
> there was something wrong with an OVS flow and they can look up exact details
> from the userspace / flow dump.
> 
> The point being, most of the flows will have a zero as a drop action argument,
> i.e. a regular explicit packet drop.  It will be hard to figure out which flow
> exactly we're hitting without looking at the full flow dump.  And if the value
> is non-zero, then it should be immediately obvious which flow is to blame from
> the dump, as we should not have a lot of such flows.
> 
> This would still allow us to avoid a maintenance burden of defining every case,
> which are fairly meaningless for the kernel itself, while having 99% of the
> information we may need.
> 
> Jakub, do you think this will be acceptable?

As far as I understand what you're proposing, yes :)

> Eric, Adrian, Aaron, do you see any problems with such implementation?
> 
> P.S. There is a plan to add more drop reasons for other places in openvswitch
>      module to catch more regular types of drops like memory issues or upcall
>      failures.  So, the drop reason subsystem can be extended later.
>      The explicit drop action is a bit of an odd case here.

If you have more than ~4 OvS specific reasons, I wonder if it still
makes sense to create a reason group/subsystem for OvS (a'la WiFi)?

