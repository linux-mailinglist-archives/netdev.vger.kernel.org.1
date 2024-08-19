Return-Path: <netdev+bounces-119744-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C039E956CED
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 16:15:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D494B1C22B93
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 14:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A6FD16CD01;
	Mon, 19 Aug 2024 14:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="JH/yp1GZ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30FFD16CD02;
	Mon, 19 Aug 2024 14:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724076841; cv=none; b=H1vHbZsR6jfvnYwIqOaSA+75qyYaaG0or9hUBffmrJgiPAEg7CEqZ9orJeBtSGG2/ZYmVZH7bfCBgOvAUmjnC8Nj4r0Eme+7OnwFQiYaF2Q511ob5uq1RkEwtORS76c4A4JScRJzKEzbLYtK6tQLE7flwOdAPwDOL3OVhAA932w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724076841; c=relaxed/simple;
	bh=VZKo56KSn5t2mKOtuhOOF1SygOnQ3/3D+wPXa9c6a6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D0XnLdBASanLj5MrW43IlzxAYjwhHr40Dq4ta5jpauygIhPLVFuFV1On9T8Hf3k/XSBtnovcDTjEpZ7107NwE3+H5iA6UNj9vtEMQ5qRJGJuSrrXPsqgzknHFWVXc+Ho7Vnj/8tQ6GUV0EXmWpJVRTgKbI6An2Rq9Nj+SNfE5pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=JH/yp1GZ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=bqC2FDC7jfocc9hQVLzfi29TBYMkOz0lxsMXOadrGwE=; b=JH/yp1GZ1ECxNsSYc36roiiayD
	UwbpxMuAKC3yjJReFwB0drNpW/amJSBB1FtIyPpZKIXAzhf1Pu33xvkEB+i54MtNd43lMQdwnL5v3
	Kv4PjqD+Gw1BONH31MO3R5PBMsPbjoo50fbenj+YIwWUl7XhKsPIrn2i3XvCjAw/hbmk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sg38i-0057Li-3P; Mon, 19 Aug 2024 16:13:44 +0200
Date: Mon, 19 Aug 2024 16:13:44 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Pieter <vtpieter@gmail.com>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Pieter Van Trappen <pieter.van.trappen@cern.ch>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net: dsa: microchip: add KSZ8
 change_tag_protocol support
Message-ID: <e4cbc2c4-366c-442b-983b-cdba71b9fb90@lunn.ch>
References: <20240819101238.1570176-1-vtpieter@gmail.com>
 <20240819101238.1570176-2-vtpieter@gmail.com>
 <20240819104112.gi2egnjbf3b67scu@skbuf>
 <CAHvy4ApydUb273oJRLLyfBKTNU1YHMBp261uRXJnLO05Hd0XKQ@mail.gmail.com>
 <90009327-df9d-4ed7-ac6c-be87065421ba@lunn.ch>
 <CAHvy4Aq0-9+Z9oCSSb=18GHduAfciAzritGb6yhNy1xvO8gNkg@mail.gmail.com>
 <9e5cc632-3058-46b2-8920-30c521eb1bbd@lunn.ch>
 <CAHvy4Aq=as=K48NZHt3Ek8Yg_AzyFdsmTe92b8SFobzUBM9JNA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHvy4Aq=as=K48NZHt3Ek8Yg_AzyFdsmTe92b8SFobzUBM9JNA@mail.gmail.com>

> Right so I'm managing it but I don't care from which port the packets
> originate, so I could disable the tagging in my case.

> My problem is that with tagging enabled, I cannot use the DSA conduit
> interface as a regular one to open sockets etc. I don't fully understand
> why I have to admit but it's documented here [1] and with wireshark I
> can see only control packets going through, the ingress data ones are
> not tagged and subsequently dropped by the switch with tagging enabled.
> 
> PS here are my iproute2 commands:
> ip link set lan1 up
> ip link set lan2 up
> ip link add br0 type bridge
> ip link set lan1 master br0
> ip link set lan2 master br0
> ip link set br0 up

So forget about the switch for the moment. Just think about having two
network interfaces. They could be intel e1000e, macb, whatever. You
would use the exact same commands above to setup a bridge so packets
would flow between them. This is all standard Linux networking,
nothing special. You would typically add an IPv4/IPv6 address on br0,
or run a DHCP client on it. lan1 and lan2 don't have IP addresses,
only the br0. Any sockets you open and don't bind to a specific
interface will make use of the IP addresses on the br0, since that is
the only interface with an IP address. The Linux software bridge will
determine which interface packets go out of, or perform flooding if
the destination MAC address is not know etc.

DSA does not change any of this. DSA just allows Linux to offload what
it is doing in software to the hardware. You use the same commands as
above. If you want to bind your socket to a local interface, you bind
it to br0, nothing different. The software bridge will still determine
the egress interface, and pass the frame to the hardware. The hardware
itself should be able to handle frames which ingress one port and
egress another, i.e. that bit of bridging has been offloaded to the
hardware.

The name 'conduit' is supposed to give you a clue. It is just a
conduit, nothing more. It is part of the plumbing to make DSA
work. But apart from ensuring it is up, you don't do anything with
it. You operate on lan1, lan2, and anything you build on top of those,
e.g. a bridge, bonds, vlan interfaces.

     Andrew

