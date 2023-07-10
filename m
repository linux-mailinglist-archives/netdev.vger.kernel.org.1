Return-Path: <netdev+bounces-16574-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0204E74DDB4
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 21:02:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFA8D280E0B
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 19:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C720314A9B;
	Mon, 10 Jul 2023 19:02:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DF714A98
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 19:02:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2951C433C8;
	Mon, 10 Jul 2023 19:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689015723;
	bh=SAZwUzO5MUU0x2L5/VjF0Qb+/jQNxfxn6RQzRG2D5Ys=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mHm2nQ8iHi/jbpY2XE7geWmEn9HMd5uVvMjMiRaVu/MeKgGrDxrYD17eu3oHTOmrB
	 8PKlz/dbOmBpQjK3+neF6z6ipX+YjDo0EhWn0G29XYJugf9CApee7AVaj8tkUNPBog
	 Y9WzoM3pH0rxBCYC951YzILi+Y9RtnGUJOEyus6PR9s1Npn4JlXTG/fFycVM+ymQep
	 eGKPKCdyQm3DrTYlNlm5ioov5+Us1EEG/eFYIin/yZ4ajwcQVUZa1D5deroiwQJgXC
	 +vUykPNanfXAdrGrM4QQegeXXvKyTjRvj5nCSXlMazTs/eOAJwcL/j7Kjd4fPkOkqy
	 bnSYG5WZxYy9g==
Date: Mon, 10 Jul 2023 12:02:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ilya Maximets <i.maximets@ovn.org>
Cc: Eric Garver <eric@garver.life>, Aaron Conole <aconole@redhat.com>,
 netdev@vger.kernel.org, dev@openvswitch.org, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "David S. Miller"
 <davem@davemloft.net>, Adrian Moreno <amorenoz@redhat.com>, Eelco Chaudron
 <echaudro@redhat.com>
Subject: Re: [ovs-dev] [PATCH net-next 2/2] net: openvswitch: add drop
 action
Message-ID: <20230710120201.7905cac5@kernel.org>
In-Reply-To: <a2df3e56-ca0c-a1ff-dd79-6e6b12568da9@ovn.org>
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
	<20230710100110.52ce3d4c@kernel.org>
	<a2df3e56-ca0c-a1ff-dd79-6e6b12568da9@ovn.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Jul 2023 20:39:11 +0200 Ilya Maximets wrote:
> > As far as I understand what you're proposing, yes :)  
> 
> OK.  Just to spell it all out:
> 
> Userspace will install a flow with an OVS_FLOW_CMD_NEW:
> 
>   match:ip,tcp,... actions:something,something,drop(0)
>   match:ip,udp,... actions:something,something,drop(42)
> 
> drop() here represents the OVS_ACTION_ATTR_DROP.
> 
> Then, in net/openvswitch/actions.c:do_execute_actions(), while executing
> these actions:
> 
>   case OVS_ACTION_ATTR_DROP:
>       kfree_skb_reason(skb, nla_get_u32(a) ? OVS_DROP_ACTION_WITH_ERROR
>                                            : OVS_DROP_ACTION);
> 
> Users can enable traces and catch the OVS_DROP_ACTION_WITH_ERROR.
> Later they can dump flows with OVS_FLOW_CMD_GET and see that the
> error value was 42.

nod

> >> Eric, Adrian, Aaron, do you see any problems with such implementation?
> >>
> >> P.S. There is a plan to add more drop reasons for other places in openvswitch
> >>      module to catch more regular types of drops like memory issues or upcall
> >>      failures.  So, the drop reason subsystem can be extended later.
> >>      The explicit drop action is a bit of an odd case here.  
> > 
> > If you have more than ~4 OvS specific reasons, I wonder if it still
> > makes sense to create a reason group/subsystem for OvS (a'la WiFi)?  
> 
> I believe, we will easily have more than 4 OVS-specific reasons.  A few
> from the top of my head:
>   - upcall failure (failed to send a packet to userspace)
>   - reached the limit for deferred actions
>   - reached the recursion limit
> 
> So, creation of a reason group/subsystem seems reasonable to me.

SG.

