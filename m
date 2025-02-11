Return-Path: <netdev+bounces-165211-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E9CA30FA7
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 16:25:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B67BD16885E
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 15:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 016B4252911;
	Tue, 11 Feb 2025 15:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ehGsACWA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0219317C91;
	Tue, 11 Feb 2025 15:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739287440; cv=none; b=ACyUI9006fnrAVV7LNUATaHPMnQjvpyoHU6aFX0OORPs7KRn9bXYYOpPTV1XapLDtraKWm4U0WFVGSwFGy7/7EvjFcXqqCO6ecIYt437e9m5Fvmzjif94OLDa6HoNQETp3TD2DiDmMzzAxs5LCccdcwN6OZyo1x3/Ppa0U2uqGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739287440; c=relaxed/simple;
	bh=H1xKmezaBdAidOpTEiSoGqS7WaJ/qDo0mBoZhJet940=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cpnOKuO03wvN6CQDHozr5PjVYbTLFzefiqcTPdX2Ldpij3rAw0t35WGqCendc/a3kW9VEKnvqOGJbIeC5md7BSEU8jocJxCdcfg3ZA2V1PAhX51oQ6EpkjHZP+8xKpDRA3AJ1eUycedMpf3HVtYub8tuMsmoTYbapHNXH/EUpL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ehGsACWA; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5dbf7d45853so970794a12.1;
        Tue, 11 Feb 2025 07:23:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739287437; x=1739892237; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TfFLB0aRgyMGCoBIUBjhG503RBKGIEKuJDOLhFsP+lY=;
        b=ehGsACWAestWW83DAid9nDgrpI4K+GnZL29CeCv8Z7cI+d4A8Xksn7JbNmeNb/fLr5
         e7rPYLgDMzaM1yTk8UbS95lGvFpALpyZhu4CM3o42hUgG2pz06Un0EUp5VWc1ltub+70
         9fZThkksnOYrXCu2T7iA+yYrbWpSow4VSeNagPTNoWcStIAUKpb3BC6BYLgnyVfmiqMU
         zqmtjnJjHCtbS4CvYCeJKIKL6tnCb1ZN/ycJIotQRQX89ByZdQGhy1Dp633RX47xhJkw
         0eneKD8AH8ehBC2ZhqHAEOvPEungPSCaHXzaHTJl/GWPCwvwvt7tVEegKQaxrvP23/Dk
         vc9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739287437; x=1739892237;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TfFLB0aRgyMGCoBIUBjhG503RBKGIEKuJDOLhFsP+lY=;
        b=wfXNM6aZOWOaggxqAa61NZhvaE9ri2CFJun2pcqpRIucMx+BCNPhVMHXhL41gAEaYs
         dXDohVYeXxF2zVJwkIFUXKk+qO/CPPCIcKuA+D+KiSVeFMdcU6T/CP0bp8d7ZkSz/fst
         XhajZ1ie+IX+cy6sIEC8TsIHbbMQxBcJQILB2iFUegRLt/UMpAPV7QBxdUZxKwKv3lC/
         9bg9RtsLcqEE7H5AKpq+enFHta+VT1+oi+xZ0Fpk0xWVQhiGmCDclDceWGd6zBtndG3H
         pPMWIfs2VvuLWsVF/Ix/ITD58Ia02uB1gxexFYchlt0RAW+5oc6fOX2D9FurkKx0jD1Y
         dZEw==
X-Forwarded-Encrypted: i=1; AJvYcCWFAJ/X4KUiqXo7ttisfO3a6pXzaorSYMIGKHuyf0gdno+PURR1Z+X+eQznwrhMlSYdR8y+J1DgucFP0B4=@vger.kernel.org, AJvYcCXPj4qqSb6bDT26SMtdYEnDHDzca5Moc64kvYR5OB0yvASsOm4dnDFpV+WxWGK11YVZXiCn0/Bl@vger.kernel.org
X-Gm-Message-State: AOJu0YxjbDAu1IKfm4qpJ+yL/Z2qYhLZpbjJD3Lz66XN8Tmpymu5GAw7
	3CkMcap5us0zwNM7xklTg/8jTL5HzLz/xkKGkCwP52itLADSKqFk
X-Gm-Gg: ASbGncu/71AyTawnf9iuzEXiMuyVxxmH6j/388Ppw9B5SCQBliaRuaqkDFf6t7pKDRG
	9CNDiPh6DHFf/xzy2m2wE+sjuNIQLh7xyeYbyQLGHZcaVdZJV+o5Hqav+u3MsMFx2eYc5WG7cqZ
	g5CeP6cm+i/aG9/O1aeSA9084McW2tyIBjJr2Z4+z4vTH7IS07a7zlw/EekH0qH0gXxgp8IuN6G
	rffRQil8Y0S08EQgVeiYHI6ynPzJ1WahzENLKmzoJa8MMBJlcftDJ4ZlEWz+sA5JqCR65oGlV2v
	kdg=
X-Google-Smtp-Source: AGHT+IGfgQvmCBTuL56yTUN1bB/5cmIW5aT0ggSkkmWOgbrbCQtiiquOiYlsHayw/lc0Ex0O8k9/yg==
X-Received: by 2002:a05:6402:2681:b0:5cf:cc32:82f2 with SMTP id 4fb4d7f45d1cf-5dea0be3fb7mr1003190a12.5.1739287436922;
        Tue, 11 Feb 2025 07:23:56 -0800 (PST)
Received: from skbuf ([86.127.124.81])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5de6e1bd66dsm5082082a12.0.2025.02.11.07.23.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 07:23:56 -0800 (PST)
Date: Tue, 11 Feb 2025 17:23:53 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: Eric Woudstra <ericwouds@gmail.com>, Petr Machata <petrm@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Nikolay Aleksandrov <razor@blackwall.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, amcohen@nvidia.com
Subject: Re: [RFC PATCH v1 net-next] net: mlxsw_sp: Use
 switchdev_handle_port_obj_add_foreign() for vxlan
Message-ID: <20250211152353.5szhbv7kdlf6bca3@skbuf>
References: <20250208141518.191782-1-ericwouds@gmail.com>
 <Z6mhQL-b58L5xkK4@shredder>
 <20250210152246.4ajumdchwhvbarik@skbuf>
 <Z6tfT6r2NjLQJkrw@shredder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6tfT6r2NjLQJkrw@shredder>

On Tue, Feb 11, 2025 at 04:31:43PM +0200, Ido Schimmel wrote:
> On Mon, Feb 10, 2025 at 05:22:46PM +0200, Vladimir Oltean wrote:
> > On Mon, Feb 10, 2025 at 08:48:32AM +0200, Ido Schimmel wrote:
> > > On Sat, Feb 08, 2025 at 03:15:18PM +0100, Eric Woudstra wrote:
> > > > Sending as RFC as I do not own this hardware. This code is not tested.
> > > > 
> > > > Vladimir found this part of the spectrum switchdev, while looking at
> > > > another issue here:
> > > > 
> > > > https://lore.kernel.org/all/20250207220408.zipucrmm2yafj4wu@skbuf/
> > > > 
> > > > As vxlan seems a foreign port, wouldn't it be better to use
> > > > switchdev_handle_port_obj_add_foreign() ?
> > > 
> > > Thanks for the patch, but the VXLAN port is not foreign to the other
> > > switch ports. That is, forwarding between these ports and VXLAN happens
> > > in hardware. And yes, switchdev_bridge_port_offload() does need to be
> > > called for the VXLAN port so that it's assigned the same hardware domain
> > > as the other ports.
> > 
> > Thanks, this is useful. I'm not providing a patch yet because there are
> > still things I don't understand.
> > 
> > Have you seen any of the typical problems associated with the software
> > bridge thinking vxlan isn't part of the same hwdom as the ingress
> > physical port, and, say, flooding packets twice to vxlan, when the
> > switch had already forwarded a copy of the packet? In almost 4 years
> > since commit 2f5dc00f7a3e ("net: bridge: switchdev: let drivers inform
> > which bridge ports are offloaded"), I would have expected such issues
> > would have been noticed?
> 
> I'm aware of one report from QA that is on my list. They configured a
> VXLAN tunnel that floods packets to two remote VTEPs:
> 
> 00:00:00:00:00:00 dev vx100 dst 1.1.1.2
> 00:00:00:00:00:00 dev vx100 dst 1.1.1.3
> 
> The underlay routes used to forward the VXLAN encapsulated traffic are:
> 
> 1.1.1.2 via 10.0.0.2 dev swp13
> 1.1.1.3 via 10.0.0.6 dev swp15
> 
> But they made sure not to configure 10.0.0.6 at the other end. What
> happens is that traffic for 1.1.1.2 is correctly forwarded in hardware,
> but traffic for 1.1.1.3 encounters a neighbour miss and trapped to
> the CPU which then forwards it again to 1.1.1.2.
> 
> Putting the VXLAN device in the same hardware domain as the other switch
> ports should solve this "double forwarding" scenario.

Let me see if I understand what you are saying based on the code (please
bear with me, VXLAN tunnels are way outside of my area).

So in this case, the packet hits a neighbor miss in the VXLAN underlay
and reaches the CPU through the
MLXSW_SP_TRAP_EXCEPTION(UNRESOLVED_NEIGH, L3_EXCEPTIONS) trap. That is
defined to call mlxsw_sp_rx_mark_listener(), which sets
skb->offload_fwd_mark = 1 (aka packet was forwarded in L2) but not
skb->offload_l3_fwd_mark (aka packet was not forwarded in L3).
This corresponds to expected reality: neighbor miss packets should not
re-enter the bridge forwarding path in the overlay towards the VXLAN.

Yet they still do, because although skb->offload_fwd_mark is correctly
set, it only skips software forwarding towards other physical (and/or
LAG) mlxsw bridge ports.

If my understanding is correct, then yes, I agree that making the hwdomain
of the vxlan tunnel coincide with that of the other bridge ports should
suppress this packet.

> > Do we require a Fixes: tag for this?
> 
> It's not strictly a regression (never worked) and it's not that critical
> IMO, so I prefer targeting net-next.

Yes, I agree. Before that commit, the bridge would look by itself at the
bridge port, recursively searching for lower interfaces until something
returned something positively in dev_get_port_parent_id(). Which was a
limiting model. If anything, solving the "double forwarding of vxlan exception
packets" issue would have required an alternative switchdev bridge port
offloading model anyway, like the explicit one that exists now, which is
more flexible.

> > And then, switchdev_bridge_port_offload() has a brport_dev argument,
> > which would pretty clearly be passed as vxlan_dev by
> > mlxsw_sp_bridge_8021d_vxlan_join() and
> > mlxsw_sp_bridge_vlan_aware_vxlan_join(), but it also has one other
> > "struct net_device *dev" argument, on which br_switchdev_port_offload()
> > wants to call dev_get_port_parent_id(), to see what hwdom (what other
> > bridge ports) to associate it to.
> 
> Right.
> 
> > Usually we use the mlxsw_sp_port->dev as the second argument, but which
> > port to use here? Any random port that's under the bridge, or is there a
> > specific one for the vxlan that should be used?
> 
> Any random port is fine as they all share the same parent ID.
> 
> BTW, I asked Amit (Cced) to look into this as there might be some issues
> with ARP suppression that will make it a bit more complicated to patch.
> Are you OK with that or do you want the authorship? We can put any tag
> you choose. I am asking so that it won't appear like I am trying to
> discredit you.

It is completely fine for Amit to take a look at this, I could really do
without yet another thing that is completely over my head :)

Just one indication from my side on how I would approach things:

Because spectrum bridge ports come and go, and the vxlan tunnel bridge
port may stay, its hwdom may change over time (depending on how many
cards there are plugged in the system). Also, it probably won't work to
combine spectrum bridge ports spanning multiple cards in the same
bridge. For those reasons, br_switchdev_port_offload() supports multiple
calls made to the same vxlan_dev, and behind the scenes, it will just
bump the net_bridge_port->offload_count.

Thinking a bit more, I think you want exactly that: a vxlan bridge port
needs to have an offload_count equal to the number of other spectrum
ports in the same bridge. This way, it only stops being offloaded when
there are no spectrum ports left (and the offload_count drops to 0).
But this needs handling from both directions: when a vxlan joins a
bridge with spectrum ports, and when a spectrum port joins a bridge with
vxlan tunnels. Plus every leave operation having to call
br_switchdev_port_unoffload(), for things to stay balanced.

Probably there are tons of other restrictions to be aware of, but I just
wanted to say this, because in the previous email we talked about "just
any random port" and it seems like it actually needs to be "all ports".

