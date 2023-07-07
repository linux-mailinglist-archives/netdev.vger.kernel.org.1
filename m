Return-Path: <netdev+bounces-16154-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A2474B960
	for <lists+netdev@lfdr.de>; Sat,  8 Jul 2023 00:06:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE5A21C210A2
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 22:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C5E17ACF;
	Fri,  7 Jul 2023 22:06:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D7D17ABD
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 22:06:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6706C433C7;
	Fri,  7 Jul 2023 22:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688767571;
	bh=m7M18wmYfky6G/6gZW+kWbwnYE6PpDqzH+6un7fY2/Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qGdWGIwh2fEfV2NPI7p9PmLMeA20Q/vUxxreZ5s4fg+AYPswV8FsNnnJjKqXhiBrm
	 LRmY1bO4TOr/qKExYlkwNYdNuOFkv3IULA9CEUfBR4JOlr88lblL/KejVwBptRrUb3
	 nbTzShIQr7NiJGQ9lYERqOG5yoJHsuOIDcFbnQODnhLucpNvexlDWSG1wciC/tM4as
	 eLhg82BjM8oDRW12O652ex27BOKTDo8X3aJPLwZ24mL3iGHsSN/fYIiCf28grM/NQL
	 u3tx93lLKXHUONkQSF4KWDTK/C9Ty20ecTDQJ7Ux9T+sZDs+jbZpg8bsL0tpt9tWne
	 KtAMNwAbj9lYw==
Date: Fri, 7 Jul 2023 15:06:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ilya Maximets <i.maximets@ovn.org>
Cc: Eric Garver <eric@garver.life>, Aaron Conole <aconole@redhat.com>,
 netdev@vger.kernel.org, dev@openvswitch.org, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "David S. Miller"
 <davem@davemloft.net>, Adrian Moreno <amorenoz@redhat.com>, Eelco Chaudron
 <echaudro@redhat.com>
Subject: Re: [ovs-dev] [PATCH net-next 2/2] net: openvswitch: add drop
 action
Message-ID: <20230707150610.4e6e1a4d@kernel.org>
In-Reply-To: <dec509a4-3e36-e256-b8c0-74b7eed48345@ovn.org>
References: <20230629203005.2137107-1-eric@garver.life>
	<20230629203005.2137107-3-eric@garver.life>
	<f7tr0plgpzb.fsf@redhat.com>
	<ZKbITj-FWGqRkwtr@egarver-thinkpadt14sgen1.remote.csb>
	<6060b37e-579a-76cb-b853-023cb1a25861@ovn.org>
	<20230707080025.7739e499@kernel.org>
	<eb01326d-5b30-2d58-f814-45cd436c581a@ovn.org>
	<dec509a4-3e36-e256-b8c0-74b7eed48345@ovn.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 7 Jul 2023 18:04:36 +0200 Ilya Maximets wrote:
> >> That already exists, right? Johannes added it in the last release for WiFi.  
> > 
> > I'm not sure.  The SKB_DROP_REASON_SUBSYS_MAC80211_UNUSABLE behaves similarly
> > to that on a surface.  However, looking closer, any value that can be passed
> > into ieee80211_rx_handlers_result() and ends up in the kfree_skb_reason() is
> > kind of defined in net/mac80211/drop.h, unless I'm missing something (very
> > possible, because I don't really know wifi code).
> > 
> > The difference, I guess, is that for openvswitch values will be provided by
> > the userpsace application via netlink interface.  It'll be just a number not
> > defined anywhere in the kernel.  Only the subsystem itself will be defined
> > in order to occupy the range.  Garbage in, same garbage out, from the kernel's
> > perspective.  
> 
> To be clear, I think, not defining them in this particular case is better.
> Definition of every reason that userspace can come up with will add extra
> uAPI maintenance cost/issues with no practical benefits.  Values are not
> going to be used for anything outside reporting a drop reason and subsystem
> offset is not part of uAPI anyway.

Ah, I see. No, please don't stuff user space defined values into 
the drop reason. The reasons are for debugging the kernel stack 
itself. IOW it'd be abuse not reuse.

