Return-Path: <netdev+bounces-237555-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C51BC4D18E
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 11:38:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AF39423D9F
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 10:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C908534CFC3;
	Tue, 11 Nov 2025 10:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bi0zUZRu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B37F34CFA6
	for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 10:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762856998; cv=none; b=VmLPfbkdyViGk+9Ki5F+UP29OWIz0JpdSFiYdz0LmHBOcUNTJyJbaPqEW+m+utUDPEctQeyDMr3cFV/L/z2weCudzZ17uyw7KpXngp2xv3lUlK5U8OLdU+QkBwG8RxhaMReF4as0pGgFXiE3Hh+9d7873Sx0PC3xLpAx3QnwyUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762856998; c=relaxed/simple;
	bh=JpT5+Q52uFzIEER8lnGSXWYhh/xPIlMmBmAdHm4bm/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ImLOPJQ2tbF3SdnjDg7zLHC/AHp5fDd4JHFd5aPKRMRa0OJK3xOquiQ+QvdYPtBmqCW4tt4gSb3radTS/fUeJdh3FeZ02M8Cqs/xzWdeIzhoAQFSJx7/HtBLguTTYBQn3/T5nBH0ILqfq9mp+95aL5a83DHLLbbghTBYgV21N9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bi0zUZRu; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-42b2cff817aso426690f8f.0
        for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 02:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762856995; x=1763461795; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RFutPZPVcfe1PqaSlwPzNed0vfcXYkJ75DHHS7eesdE=;
        b=bi0zUZRuEPj3GTFlcW3pWJvM9vNMMsZ/L+L5UsKgknKl6FPzxUwgTGALnVztTtoAzB
         qoZVEA1o307Q3US8Q4zMWwcdAXi+e9+aalLqmmgfAv8/V5rvBl4FYVVWm6YbroIc4QHm
         9v4pHT/5TgAf5i/K10+LhqHEachzg8bV0CPZPTENodkNU/uVJdQA7S90kHGiMsK/tWha
         qnxyO0YldmzGR6t+t6lR2JKFF00nWyjxma+XZYa0B0y+Q7gHLLOKmPSU1EH1IiaHaZqB
         /A39ZSpCMzFHiXYfV/7w+oyzV+YMeXSjHnhWYfvbJPv7122YzJAqVD7JxN8DszbHAzI7
         0YMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762856995; x=1763461795;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RFutPZPVcfe1PqaSlwPzNed0vfcXYkJ75DHHS7eesdE=;
        b=RA0gJ+TtYmqxzqYr1sO7X2VdKHJNnaIQlUzs9oBSZeR/F059K18+uPlsHJ1op+oe4z
         9IRpfSPNPmtLARjAvgTzJl4dM7IYaSe8QcdI42Uvu3ffpj328e7NW/wHdetc3XHJ/1oN
         IbHlRZWxrif/TKfXGZ6C0R53wSgjiT5Y1P1euKrC/xG/v+5BrCb7uVtcojnjU3Fbdwuv
         bsVEQJ1F7EOkpvII/TcJzO+UQe1VzU9He8llh+ihP0IHBZo8GHPsjabOVetz4nNnYcI/
         0ONhT6RO7WwPZjX2tzoX5BdAdria7qJuKG4/Dd1p7vF5kW2QE75VTBolceYg6YcZywHY
         SzHw==
X-Forwarded-Encrypted: i=1; AJvYcCWZkyJYUtfYYvDQF3pAbL1AbXQd8vCmie9eLM1+I53NACwsvpNG7geZaQgZfAWkL2JtYng0uoA=@vger.kernel.org
X-Gm-Message-State: AOJu0YySGcbs4PvPrDnBu+8hg1K3xmAQEKP9bbPLPpJz1dRsxGUIyYPq
	mlJH6m0LBU93QUZuRZt1V6WeO2ld+dxdrKO1A72ossZ2Vb6kwpfZrlWb
X-Gm-Gg: ASbGncseG2Z8yJYskYkzW89TSrfeQE4YFQlpPhON5HyfaG6WHsWWlGcoj4+1ivxVtTb
	fjtjK8r+d65iep08qdaLiDK9nsPQ9vgTa3Uutp+vKqmN5LsifmiiW6j2c5Ix1QlXJTGLQdBkCuq
	nsTJGmzMGSj9PA/dhCpLsOMlJDMtOowsB3kPiTf/vJoXXlYTC/7aLcSQEduiwT92tvnUMGiNS+0
	nnmKOtrBQzM9YTMNr55V5S7aA5Ae4pd9Wd1AHUmTEqF6lulLRNqWa3wVeFHXZZ4SPcCdD1yZVAD
	z0UN5qs8AyCedQvzvvdLFOhd7ufXDkgHDNy0OhSfH1fgi3S2hOyXWWMLS9AvxINwfFLAeW7Jzp9
	DeZKBdQcEquZaKtd0ikzzwWIOOsXO30WOnkAVpe/Gz4m/sX+53Tk1B57bMqEXy3p1gUx8HUaUD6
	95REs=
X-Google-Smtp-Source: AGHT+IGut5UdtaPg5QbZcWX7MUocWV29lStqS7ui1MJFm9Kz4cjLkWJMGOfw9rr3hhx6QpVtMAEIjA==
X-Received: by 2002:a05:6000:26cf:b0:42b:2deb:829 with SMTP id ffacd0b85a97d-42b4285611amr1239922f8f.3.1762856994563;
        Tue, 11 Nov 2025 02:29:54 -0800 (PST)
Received: from skbuf ([2a02:2f04:d00b:be00:7a51:464b:5aed:5e38])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42ac67921c3sm27760824f8f.40.2025.11.11.02.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 02:29:53 -0800 (PST)
Date: Tue, 11 Nov 2025 12:29:51 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Jonas Gorski <jonas.gorski@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC net-next 0/3] net: dsa: deny unsupported 8021q uppers
 on bridge ports
Message-ID: <20251111102951.lkexwdk5btdqdt46@skbuf>
References: <20251110214443.342103-1-jonas.gorski@gmail.com>
 <20251110230124.7pzmkhrkxvtgzh5k@skbuf>
 <CAOiHx==ymTyVbs7UmNH28UgxcfnMQBtt6qA=ZnKvEF3QLe_z8w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOiHx==ymTyVbs7UmNH28UgxcfnMQBtt6qA=ZnKvEF3QLe_z8w@mail.gmail.com>

On Tue, Nov 11, 2025 at 10:53:00AM +0100, Jonas Gorski wrote:
> Hi Vladimir,
> 
> On Tue, Nov 11, 2025 at 12:01 AM Vladimir Oltean <olteanv@gmail.com> wrote:
> >
> > Hi Jonas,
> >
> > On Mon, Nov 10, 2025 at 10:44:40PM +0100, Jonas Gorski wrote:
> > > Documentation/networking/switchdev.rst is quite strict on how VLAN
> > > uppers on bridged ports should work:
> > >
> > > - with VLAN filtering turned off, the bridge will process all ingress traffic
> > >   for the port, except for the traffic tagged with a VLAN ID destined for a
> > >   VLAN upper. (...)
> > >
> > > - with VLAN filtering turned on, these VLAN devices can be created as long as
> > >   the bridge does not have an existing VLAN entry with the same VID on any
> > >   bridge port. (...)
> > >
> > > Presumably with VLAN filtering on, the bridge should also not process
> > > (i.e. forward) traffic destined for a VLAN upper.
> > >
> > > But currently, there is no way to tell dsa drivers that a VLAN on a
> > > bridged port is for a VLAN upper and should not be processed by the
> > > bridge.
> >
> > You say this as if it mattered. We can add a distinguishing mechanism
> > (for example we can pass a struct dsa_db to .port_vlan_add(), set to
> > DSA_DB_PORT for VLAN RX filtering and DSA_DB_BRIDGE for bridge VLANs),
> > but the premise was that drivers don't need to care, because HW won't do
> > anything useful with that information.
> 
> It matters in the case of VLAN uppers on bridged ports. It does not
> matter for VLAN uppers on standalone ports.

Ok, and what would a driver do with the info that a port_vlan_add() call
came from 8021q and not from the bridge?

> > > Both adding a VLAN to a bridge port and adding a VLAN upper to a bridged
> > > port will call dsa_switch_ops::port_vlan_add(), with no way for the
> > > driver to know which is which. But even so, most devices likely would
> > > not support configuring forwarding per VLAN.
> >
> > Yes, this is why the status quo is that DSA tries to ensure that VLAN
> > uppers do not cause ports to forward packets between each other.
> > You are not really changing the status quo in any way, just fixing some
> > bugs where that didn't happen effectively. Perhaps you could make that a
> > bit more clear.
> 
> Right, I'm trying to prevent situations where the forwarding will
> happen despite not being supposed to happen.
> 
> > > So in order to prevent the configuration of configurations with
> > > unintended forwarding between ports:
> > >
> > > * deny configuring more than one VLAN upper on bridged ports per VLAN on
> > >   VLAN filtering bridges
> > > * deny configuring any VLAN uppers on bridged ports on VLAN non
> > >   filtering bridges
> > > * And consequently, disallow disabling filtering as long as there are
> > >   any VLAN uppers configured on bridged ports
> >
> > First bullet makes some sense, bullets 2 and 3 not so much.
> >
> > The first bullet makes just "some" sense because I don't understand why
> > limit to just bridged ports. We should extend to all NETIF_F_HW_VLAN_CTAG_FILTER
> > ports as per the dsa_user_manage_vlan_filtering() definitions.
> 
> Standalone ports are isolated from each other, so the configured VLAN
> uppers do not matter for forwarding. They will (should) never forward
> traffic to other ports, regardless of any VLAN (filtering)
> configuration on the bridge, so there is no issue here (pending
> correct programming of the switch). Usually isolation trumps any VLAN
> memberships.

So we would hope, that standalone ports are completely isolated from
each other, but unless drivers implement ds->fdb_isolation, that isn't a
given fact. Forwarding might be prevented, but FDB lookups might still
take place, so when you have this setup:

swp1.100     br0
 |         /     \
swp1     swp2    swp3  (bridge vlan add dev swp3 vid 100 master)

and you ping station 00:01:02:03:04:05 from swp1.100, you'd expect it
goes out the wire on swp1. But if swp3 had previously learned 00:01:02:03:04:05,
I wouldn't be surprised if the switch tried to forward it in that
direction instead (failing of course, but dropping the packet in that
process). We would be saved if the tagger's xmit() would force the
packet to bypass FDB lookup, but that isn't a given either...

As I'm saying, swp1 can have NETIF_F_HW_VLAN_CTAG_FILTER set due to any
of the quirks described in dsa_user_manage_vlan_filtering().

It might be a moot point because I haven't verified what are the drivers
which fulfill all conditions for this to be a practical problem. It might
as well be the empty set. For example, sja1105 fulfills them all, but
sja1105_prechangeupper() rejects all 8021q uppers so it is not affected.

> This is purely about unintended/forbidden forwarding between bridged ports.
> 
> > Bullets 2 and 3 don't make sense because it isn't explained how VLAN
> > non-filtering bridge ports could gain the NETIF_F_HW_VLAN_CTAG_FILTER
> > feature required for them to see RX filtering VLANs programmed to
> > hardware in the first place.
> 
> Let me try with an example:
> 
> let's say we have swp1 - swp4, standalone.
> 
> allowed forward destinations for all are the cpu port, no filtering.
> 
> now we create a bridge between swp2 and swp3.
> 
> now swp2 may also forward to swp3, and swp3 to swp2.
> 
> swp1 and swp4 may still only forward to cpu (and this doesn't change
> here. We can ignore them).
> 
> Bullet point 1:
> 
> If vlan_filtering is enabled, swp2 and swp3 will only forward configured VLANs.
> 
> swp2 and swp3 will have NETIF_F_HW_VLAN_CTAG_FILTER (as VLAN filtering
> is enabled on these ports).
> 
> If we enable VID 10 on both ports, the driver will be called with
> port_vlan_add(.. vid = 10), and they forward VLAN 10 between each
> other.
> If we instead create uppers for VID 10 for both ports, the driver will
> be called with port_vlan_add(... vid = 10) (as
> NETIF_F_HW_VLAN_CTAG_FILTER is is set), and they forward VLAN 10
> between each other (oops).

I didn't contest that, and the bridged port example is clear. I just
said I don't think you're seeing the picture broadly enough on this
bullet point. I may be wrong though - just want to clarify what I'm
saying.

> Bullet point 2:
> 
> If vlan_filtering is disabled, swp2 and swp3 forward any VID between each other.
> 
> swp2 and swp3 won't have NETIF_F_HW_VLAN_CTAG_FILTER (as vlan
> filtering is disabled on these ports).
> 
> If we now create an upper for VID 10 on swp2, then VLAN 10 should not
> be forwarded to swp3 anymore (as VLAN 10 is now "consumed" by the host
> on this port).
> 
> But since there is no port_vlan_add() call due to filtering disabled
> (NETIF_F_HW_VLAN_CTAG_FILTER not set), the dsa driver does not know
> that the forwarding should be inhibited between these ports, and VLAN
> 10 is still forwarded from swp2 to swp3 (oops).

Is this the behaviour with veth bridge ports (that VID 10 packets are
trapped as opposed to bridged)? I need a software-based reference to
clearly understand the gap vs DSA's hardware offload.  I don't think
there's any test for that, but it is good to have one.

> Bullet point 3:
> And since having uppers on a bridged ports on a non-filtering bridge
> does not inhibit forwarding at all, we cannot allow disabling
> filtering as long as VLAN uppers on bridged ports exist.
> 
> Does this now make it clearer what situations I am talking about?
> 
> The easy way is to disallow these configurations, which is what I try
> to attempt (explicitly allowed by switchdev.rst).
> 
> One other more expensive options are making bridge ports with VLAN
> uppers (or more than one upper for a VLAN) standalone and disable
> forwarding, and only do forwarding in software.
> 
> Or add the above mentioned DSA_DB_PORT for vlan uppers on (bridged)
> ports, regardless of filtering being enabled, and then let the dsa
> driver handle forwarding per VLAN.

But you still won't get ndo_vlan_rx_add_vid() calls from the 8021q layer
if you're under a VLAN-unaware bridge, so it doesn't help case #2.
You'd have to remove the ndo_vlan_rx_add_vid() handling and manually
track CHANGEUPPER events from 8021q interfaces.

> This may or may not be possible, depending on the hardware. One
> workaround I can think of is to enable a VLAN membership violation
> trap and then remove the port from the VLAN. But this also has the
> potential to pull a lot of traffic to the cpu. And requires drivers to
> be adapted to handle it. And would require filtering, which may get
> complicated for the non-filtering bridge case.

