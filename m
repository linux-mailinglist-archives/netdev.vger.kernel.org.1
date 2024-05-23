Return-Path: <netdev+bounces-97792-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B2188CD3E8
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 15:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 169552852AE
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 13:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 804C814A4EC;
	Thu, 23 May 2024 13:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="kwHW8QLQ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FFF813BAE2;
	Thu, 23 May 2024 13:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716470378; cv=none; b=slIFeQ05CW5QCdwvajpCgtdYGth6JU8lLoERYnTvls7eo5hKlroi+G7WYFOMSdIJ890OqZODnS8yCj/fEccQnObRH2fk/jcQyUn2gY3FvjBu6ePl9ctWb9pr7IEwjh77TmSY12VbMGf6AKSQNEpxzsW/+zIHK3H/Gm8Zgwt43p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716470378; c=relaxed/simple;
	bh=jyxo9p4uVhwZUAylTa6buVEfnCjBkMepgy3hN7Xyyks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RlRTa2t1YKMRZexO2qiUsyOd+iKW5J+2kH4j7lMyYDvRzZ0+flRP5eJ+4JSQAjo+A3jPRHvIoPcoTalDNHth5BvPE3jcmtlBo2oizwQGUALnJ05qFFq0eJvcEinql+VluI7M+/nXWrvThfV1agnUS+0iDxV81XK+1BGJN9HyYng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=kwHW8QLQ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=kSyNDjDZ0dzFM+bYy7w8Y6dF6a+vjfjExuRSY5VdsbM=; b=kwHW8QLQdbuUICTR7zapd6XwzK
	LRw67GDL6zRWUp6qB73AA7z5Lyb1oK8rYoZyF2WmbzlAqYnbQl1QL7wCdAYesx2WAW6r6lqBT8pzi
	qCEIW7P5FT0x8PDDlasLA32RFOFgBkpeGElT4CIVDcbb2RYPvI9NKCuMXzvuIuphi4jE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sA8Ly-00FtVH-0i; Thu, 23 May 2024 15:19:30 +0200
Date: Thu, 23 May 2024 15:19:30 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Larry Chiu <larry.chiu@realtek.com>
Cc: Justin Lai <justinlai0215@realtek.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"jiri@resnulli.us" <jiri@resnulli.us>,
	"horms@kernel.org" <horms@kernel.org>,
	Ping-Ke Shih <pkshih@realtek.com>
Subject: Re: [PATCH net-next v19 01/13] rtase: Add pci table supported in
 this module
Message-ID: <8c6ad434-ba3a-4acf-9b10-9dff8efd4ee5@lunn.ch>
References: <20240517075302.7653-1-justinlai0215@realtek.com>
 <20240517075302.7653-2-justinlai0215@realtek.com>
 <d840e007-c819-42df-bc71-536328d4f5d7@lunn.ch>
 <e5d7a77511f746bdb0b38b6174ef5de4@realtek.com>
 <97e30c5f-1656-46d0-b06c-3607a90ec96f@lunn.ch>
 <f9133a36bbae41138c3080f8f6282bfd@realtek.com>
 <7aab03ba-d8ed-4c9c-8bfd-b2bbed0a922d@lunn.ch>
 <5270598ca3fc4712ac46600fcc844d73@realtek.com>
 <0ec88b78-a9d3-4934-96cb-083b2abf7e2b@lunn.ch>
 <48072595c9c344fea9c268fd81e4d06e@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48072595c9c344fea9c268fd81e4d06e@realtek.com>

On Thu, May 23, 2024 at 06:29:55AM +0000, Larry Chiu wrote:
> 
> > > Thank you very much for your clear reply.
> > >
> > > As I mentioned, it works like a NIC connected to an Ethernet Switch, not a
> > > Management port.
> > > The packets from this GMAC are routed according to switch rules such as
> > > ACL, L2, .... and it does not control packet forwarding through any special
> > > header or descriptor. In this case, we have our switch tool which is used
> > > for provisioning these rules in advance. Once the switch boots up, the
> > > rules will be configured into the switch after the initialization. With this
> > > driver and the provisioning by our switch tool, it can make switch forward
> > > the frame as what you want. So it's not a DSA like device.
> > 
> > How does spanning tree work? You need to send bridge PDUs out specific
> > ports. Or do you not support STP and your network must never have
> > loops otherwise it dies in a broadcast storm? That does not sound very
> > reliable.
> > 
> > There are other protocols which require sending packets out specific
> > ports. Are they simply not supported?
> > 
> This port is not a CPU port, nor a management port, and therefore does not 
> manage any protocols of the switch. These protocols are implemented by the
> CPU inside the Ethernet switch core.

So STP is on the switch CPU. Linux will run PTP as a leaf node, and
rely on the switch also running PTP to manage PTP between the upstream
port and the downstream port towards linux. IGMP snooping runs on the
switch, and needs to listen to IGMP joins Linux sends out, etc.

Do you have Linux running on the switch CPU? So you can reuse all the
existing networking code and applications like ptp4l, or have the
re-invented it all?

> This driver just service the transmit/receive packets for one port in the RTL90xx
> with PCIe interface. Other programs that the switch needs to execute are
> managed by the CPU inside the switch core.

So you are following the 40 year old model, a cable to an external
device. Just be aware, it is an external device. Your interface to it
is SNMP, telnet, http. It is very unlikely a kernel driver will be
allowed to communicate with the switch.

	Andrew

