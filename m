Return-Path: <netdev+bounces-50925-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A947F785F
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 16:55:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D79D01C20901
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 15:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 437C93174E;
	Fri, 24 Nov 2023 15:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="tYHgIhoD"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EB1B1998
	for <netdev@vger.kernel.org>; Fri, 24 Nov 2023 07:55:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=AaKoz6OyAylKJMf/IKhJ2rpExhUfIYbMyM2ZY0FEE9I=; b=tYHgIhoDHqBuVbiZ1eYULu+IzE
	H1URR3neM8X5RAnpalLW3U4eIe2V7NrNdmPDNezHoYNDdL/sL59Y+95wct1Dyh6SFMRI5QtpqW6wP
	Cwj37zZ3FHOm73tSptfa6gCOo3oQeDiAuhMJAM+lt3qoYtP13XhtMqM4J4ihxQy6VZbk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1r6YWD-0016zq-US; Fri, 24 Nov 2023 16:55:01 +0100
Date: Fri, 24 Nov 2023 16:55:01 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Greg Ungerer <gerg@kernel.org>
Cc: rmk+kernel@armlinux.org.uk, hkallweit1@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: Re: [PATCHv2 2/2] net: dsa: mv88e6xxx: fix marvell 6350 probe crash
Message-ID: <e65845e6-0312-4617-89dd-fca45f2b7170@lunn.ch>
References: <20231124041529.3450079-1-gerg@kernel.org>
 <20231124041529.3450079-2-gerg@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231124041529.3450079-2-gerg@kernel.org>

On Fri, Nov 24, 2023 at 02:15:29PM +1000, Greg Ungerer wrote:
> As of commit b92143d4420f ("net: dsa: mv88e6xxx: add infrastructure for
> phylink_pcs") probing of a Marvell 88e6350 switch causes a NULL pointer
> de-reference like this example:
> 
>     ...
>     mv88e6085 d0072004.mdio-mii:11: switch 0x3710 detected: Marvell 88E6350, revision 2
>     8<--- cut here ---
>     Unable to handle kernel NULL pointer dereference at virtual address 00000000 when read
>     [00000000] *pgd=00000000
>     Internal error: Oops: 5 [#1] ARM
>     Modules linked in:
>     CPU: 0 PID: 8 Comm: kworker/u2:0 Not tainted 6.7.0-rc2-dirty #26
>     Hardware name: Marvell Armada 370/XP (Device Tree)
>     Workqueue: events_unbound deferred_probe_work_func
>     PC is at mv88e6xxx_port_setup+0x1c/0x44
>     LR is at dsa_port_devlink_setup+0x74/0x154
>     pc : [<c057ea24>]    lr : [<c0819598>]    psr: a0000013
>     sp : c184fce0  ip : c542b8f4  fp : 00000000
>     r10: 00000001  r9 : c542a540  r8 : c542bc00
>     r7 : c542b838  r6 : c5244580  r5 : 00000005  r4 : c5244580
>     r3 : 00000000  r2 : c542b840  r1 : 00000005  r0 : c1a02040
>     ...
> 
> The Marvell 6350 switch has no SERDES interface and so has no
> corresponding pcs_ops defined for it. But during probing a call is made
> to mv88e6xxx_port_setup() which unconditionally expects pcs_ops to exist -
> though the presence of the pcs_ops->pcs_init function is optional.
> 
> Modify code to check for pcs_ops first, before checking for and calling
> pcs_ops->pcs_init. Modify checking and use of pcs_ops->pcs_teardown
> which may potentially suffer the same problem.
> 
> Fixes: b92143d4420f ("net: dsa: mv88e6xxx: add infrastructure for phylink_pcs")
> Signed-off-by: Greg Ungerer <gerg@kernel.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

