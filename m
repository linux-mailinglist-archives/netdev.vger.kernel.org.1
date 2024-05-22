Return-Path: <netdev+bounces-97603-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D018CC487
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 17:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8370C1C21BE2
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 15:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35C313E03E;
	Wed, 22 May 2024 15:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="TtrNXMGS"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90EAA7D3F6;
	Wed, 22 May 2024 15:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716393219; cv=none; b=PopDoGgiHIgs1sTck57RrXE/+ovgEyZik3kQG0JpTCGBimv+P9/N9XMDhpwx67Zu0mDnfzmXJiQ6/9hh9Fm7o1veS7bX9UGLm4ws4sLi0kmF7uqHJOHhRo974Slg5RLKBoDcqsirvWfLezfE8+rvTqufUCLJM6wvN9tEm6jB4ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716393219; c=relaxed/simple;
	bh=WUg7cWo8ckg1ReqpxXpypAGfoa4UdjEWcL6ggvPK+mU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UYoVzy+MvdfM4YqBlpCIRo0oYquKv53dCJSDu7nB6Npp67jwyrVDtUggsqnlFgB2imtpudNCIJQeFQnkLpdhWbYhmXsUhPFUkU2FN9KcSby/nbK8FlywFEbc/EreqZctrUoGFrXGBkthnWrjPMVuOuW0t9J3IPfhsooUFhnzASM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=TtrNXMGS; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=j5KF2SIwMMUsmBk9Du88oWOyPQVZe4acFlw2uIjhA8E=; b=TtrNXMGSZXxbfjvZlyb7UD1p1e
	gCVzFts2eOx/Jq2AbgyFBjnQAWjQusdyLYU50yJvV6yF1uRE+OXSK44q4lrXEU5P65Hyjora0ePgl
	Au5h9RUqLdXvzlJLCJ6KaawHvgIYPxRpLSYJ7Z1TiqGGEFWdqKshpV2nbVkh+0BFGPJs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s9oHS-00FphM-GL; Wed, 22 May 2024 17:53:30 +0200
Date: Wed, 22 May 2024 17:53:30 +0200
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
Message-ID: <0ec88b78-a9d3-4934-96cb-083b2abf7e2b@lunn.ch>
References: <20240517075302.7653-1-justinlai0215@realtek.com>
 <20240517075302.7653-2-justinlai0215@realtek.com>
 <d840e007-c819-42df-bc71-536328d4f5d7@lunn.ch>
 <e5d7a77511f746bdb0b38b6174ef5de4@realtek.com>
 <97e30c5f-1656-46d0-b06c-3607a90ec96f@lunn.ch>
 <f9133a36bbae41138c3080f8f6282bfd@realtek.com>
 <7aab03ba-d8ed-4c9c-8bfd-b2bbed0a922d@lunn.ch>
 <5270598ca3fc4712ac46600fcc844d73@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5270598ca3fc4712ac46600fcc844d73@realtek.com>

> Thank you very much for your clear reply.
> 
> As I mentioned, it works like a NIC connected to an Ethernet Switch, not a
> Management port.
> The packets from this GMAC are routed according to switch rules such as
> ACL, L2, .... and it does not control packet forwarding through any special
> header or descriptor. In this case, we have our switch tool which is used 
> for provisioning these rules in advance. Once the switch boots up, the 
> rules will be configured into the switch after the initialization. With this 
> driver and the provisioning by our switch tool, it can make switch forward 
> the frame as what you want. So it's not a DSA like device.

How does spanning tree work? You need to send bridge PDUs out specific
ports. Or do you not support STP and your network must never have
loops otherwise it dies in a broadcast storm? That does not sound very
reliable.

There are other protocols which require sending packets out specific
ports. Are they simply not supported?

> In another case, we do have other function which is used for controlling 
> the switch registers instead of sending packets from the switch ports.
> At the meanwhile, we are investigating how to implement the function to
> Integrate into switchdev.

In general, we don't support configuration of hardware from user
space, which is what your switch tool sounds like. We will want to see
a switchdev driver of some form.

It might be you need to use VLAN overlays, using
net/dsa/tag_8021q.c. Each port of the switch is given a dedicated
VLAN, and the switch needs to add/strip the VLAN header. Its not
great, but it does allow 'simple' switches to have basic functionality
if they are missing header/dma descriptor support for selecting ports.

	Andrew

