Return-Path: <netdev+bounces-15195-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A043374617C
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 19:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0BA41C209ED
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 17:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72786101F5;
	Mon,  3 Jul 2023 17:35:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6831C107A3
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 17:35:29 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE550E5D
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 10:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ZF3s4GJ7V6b9aZery9Kgtcaj0G5yw4lkJ9Z6Cbki4aQ=; b=1FHRBGrek9jd3murQ/Wcqc/YM6
	DOl1R6Sp/qzzEeS4Rf0zqhIxshJYzWJAsRn0kxVGA9j/e3xRpZ7sFg57wnbxcM+UXVZtKWO/VDs5S
	nnLNkYgJCXJ7gMoZhhQrXhE85F2GiL84LoLi2XJcpICtj/o+LWWBzKara5FXw0PW+E38=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qGNSB-000V2T-Hf; Mon, 03 Jul 2023 19:35:11 +0200
Date: Mon, 3 Jul 2023 19:35:11 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Fernando Eckhardt Valle (FIPT)" <fevalle@ipt.br>
Cc: "davem@davemloft.net" <davem@davemloft.net>,
	"jesse.brandeburg@intel.com" <jesse.brandeburg@intel.com>,
	"anthony.l.nguyen@intel.com" <anthony.l.nguyen@intel.com>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH] igc: enable Mac Address Passthrough in Lenovo
 Thunderbolt 4 Docks
Message-ID: <ca34e1ad-1170-4398-beb6-28559a270908@lunn.ch>
References: <20230605185407.5072-1-fevalle@ipt.br>
 <09c32c5a-73b4-456f-97f9-685820f3ba25@lunn.ch>
 <CPVP152MB50534DFBCF085A15E2FD37AAD84DA@CPVP152MB5053.LAMP152.PROD.OUTLOOK.COM>
 <91983414-8df7-4cc0-9465-328d47024bcc@lunn.ch>
 <CPVP152MB5053FD7163C5C4205DB3A800D829A@CPVP152MB5053.LAMP152.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CPVP152MB5053FD7163C5C4205DB3A800D829A@CPVP152MB5053.LAMP152.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 03, 2023 at 04:58:42PM +0000, Fernando Eckhardt Valle (FIPT) wrote:
> 
>     MAC address passthrought seems in general to be a big collection of
>     vendor hacks which in general are broken in most corner cases, and
>     even in the middle cases. What really needs to happen is that the
>     vendors get together and standardize on one solution, and make sure
>     they involved the kernel developers in the design.
> 
>     O.K, so why is the kernel involved? It sounds like userspace should be
>     solving this. It is easy for userspace to get a notification when the
>     dock pops into existence. It can then walk the tree of devices and
>     find that the IGC is in a dock, its the first dock, not the 42nd dock
>     in a long chain. User space also has access to the BIOS version so it
>     knows the BIOS will at some point execute this proprietary extension
>     and copy the MAC address to one of the docks, maybe even the correct
>     one in the chain of 42. It can wait 1 seconds, and then down/up the
>     interface?
> 
> I've been thinking about creating a user space application for mac address
> passthrough. I thought about creating a udev rule for it, but some questions
> seemed quite complicated. For example, some ThinkPad laptops don't have a
> network device but have a mac address specifically for mac address passthrough.

Where is it stored? In an ACPI table? Can you get at it via dmidecode
and friends? Or vpddecode?

> My idea for a udev rule would be to copy the mac address from the laptop's
> network device, but since there is no network device, I'm not sure how I would
> make that copy because there is no network device in /sys/class/net to copy
> from.

I udev rule is the start. You want a trigger when a network device
pops into existence.

You then need some sort of code to walk up the device tree and detect
the dock. So want some sort of database of IDs to identify docks.

And you need some sort of code which continues walking up the tree to
determine if this is the first dock.

And you need another database, probably based on BIOS Machine
Type/Model data which tells you how to find the MAC address.

And then some glue to combine all the parts.

> Other vendors, like Realtek, have mac address passthrough implemented in the
> module code (for example, in r8152.c), and I think this makes it easier for
> different vendors (like Dell, Lenovo, etc.) to make mac address passthrough
> work for more people.

And because they did not think about it properly, it often goes
wrong. We have had problems reported of a USB-Ethernet dongle getting
the same MAC address as the dock, etc. The ethernet driver has too
small a view of the world to know if is really should have the pass
through MAC address.

Also, vendors tend to think of themselves and nobody else. So each
vendor does it differently and each get it wrong in their own way.  So
this really needs to be solved in a vendor agnostic way, e.g. the
collection of databases i suggested. Maybe even a submission to the
ACPI standards for where to store this MAC address.

	Andrew

