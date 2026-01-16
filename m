Return-Path: <netdev+bounces-250650-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B3ED3880D
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 21:57:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 96CF230178CD
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 20:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F20592F5473;
	Fri, 16 Jan 2026 20:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="PCfHEObY"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811372D595B;
	Fri, 16 Jan 2026 20:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768597046; cv=none; b=qQ4uowLrpqmJW5QC5MGitDnfvb9wbp7GPJUhumeAwi0XizPlo2Rc0Pb5ChXUdKUl11L6md1P+VyJvkQXxpTSDIHCmtCyBCHRr46iRcdE7hn4UEpIXoJ0ghUXC3gLPmqFKYF6pbXNK2UjIFKBTWvbsI/e6N6qEXqa+JSCwMUeDoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768597046; c=relaxed/simple;
	bh=XjTbnFZ/JDpcBcLK9JCRWNTy3RKDzfxWZAdFywPAsCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=euyrYyz7SbaM9Fdo1+pJ8RC8RorN+viKaqylAfr/uVYC+75C2wCk2FQuhregH8o6i31djwFlQmuVcN6e0LSWFfkz1QK7nuZ+ixhChXvgg8rucQOQGC4bIkhNE86lXtPgTs+I8I/9DfBfxwSJm4bIWZ5kBktbOM2TNlwOzPksxJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=PCfHEObY; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=54KFRrcEl1B0WjUdaGaFEHLkeLCSytYhQsdlx+jeMds=; b=PCfHEObYDtoy9FGBFKLOvCGSZ4
	s713vwKEJCVHDNFif/2c7SemENeLq34W4Lf9l0j7m79bYRwIf/nC9I8vFINXcHRYLzTDxnzxLij0p
	AwwYLcqo/OZHr+tJrB68RTMp/S/ygKnBhTPWoQ/G34FIwFtzmwV7ALsENs+DlxZ7G1KVPmjR69oj3
	JBLW2lp/B9eD3b+SUOSgfRCZSotA4jdhEco1pD1K/3ZXyMy407wpdy1aOgx+ExlPJPYG2kbv1wo/k
	8LRtbbx6PSA7U5hQvYdPIqdGljIcpu+Hft90cAyvrdG43bTl5KIxODVHiIJxKsSB625yAJN2l7Xha
	TMW5wlFA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33254)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vgqsY-000000002iR-47Ya;
	Fri, 16 Jan 2026 20:57:11 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vgqsT-000000003vq-3ny9;
	Fri, 16 Jan 2026 20:57:05 +0000
Date: Fri, 16 Jan 2026 20:57:05 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Tao Wang <tao03.wang@horizon.auto>, alexandre.torgue@foss.st.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	horms@kernel.org, kuba@kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, mcoquelin.stm32@gmail.com,
	netdev@vger.kernel.org, pabeni@redhat.com
Subject: Re: [PATCH net v2] net: stmmac: fix transmit queue timed out after
 resume
Message-ID: <aWqmIRFsHkQKkXF-@shell.armlinux.org.uk>
References: <20260115070853.116260-1-tao03.wang@horizon.auto>
 <aWjY7m96e87cBLUZ@shell.armlinux.org.uk>
 <aWlCs5lksxfgL6Gi@shell.armlinux.org.uk>
 <6a946edc-297e-469a-8d91-80430d88f3e5@bootlin.com>
 <51859704-57fd-4913-b09d-9ac58a57f185@bootlin.com>
 <aWmLWxVEBmFSVjvF@shell.armlinux.org.uk>
 <aWo_K0ocxs5kWcZT@shell.armlinux.org.uk>
 <aWp-lDunV9URYNRL@shell.armlinux.org.uk>
 <3a93c79e-f755-4642-a3b0-1cce7d0ea0ef@bootlin.com>
 <aWqP_hhX73x_8Qs1@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWqP_hhX73x_8Qs1@shell.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Jan 16, 2026 at 07:22:39PM +0000, Russell King (Oracle) wrote:
> Yes, because the receive DMA has stopped, which makes the FIFO between
> the MAC and MTL fill above the threshold for sending pause frames.
> 
> In order to stop the disruption to my network (because it basically
> causes *everything* to clog up) I've had to turn off pause autoneg,
> but that doesn't affect whether or not this happens.
> 
> It _may_ be worth testing whether adding a ndelay(500) into the
> receive processing path, thereby making it intentionally slow,
> allows you to reproduce the problem. If it does, then that confirms
> that we're missing something in the dwmac4 handling for RBU.

I notice that the iMX8MP TRM says similar about the RBU bit
(see 11.7.6.1.482.3 bit 7).

However, it does say that in ring mode, merely advancing the tail
pointer should be sufficient. I can write the tail pointer register
using devmem2, but the hardware never wakes up.

E.g.:

Channel 0 Current Application Receive Descriptor:
Value at address 0x0249114c: 0xfffff910

Channel 0 Rx Descriptor Tail Pointer:
Value at address 0x02491128: 0xfffff910

Value at address 0x02491128: 0xfffff910
Written 0xfffff940; readback 0xfffff940
Value at address 0x02491128: 0xfffff940
Written 0xfffff980; readback 0xfffff980

Value at address 0x0249114c: 0xfffff910

So, the hardware hasn't advanced. Here's the ring state:

			  RDES0     RDES1 RDES2 RDES3
401 [0x0000007ffffff910]: 0xffd63040 0x7f 0x0 0x81000000
402 [0x0000007ffffff920]: 0xffd64040 0x7f 0x0 0x81000000
403 [0x0000007ffffff930]: 0xffd3f040 0x7f 0x0 0x81000000
404 [0x0000007ffffff940]: 0xffeed040 0x7f 0x0 0x81000000
405 [0x0000007ffffff950]: 0xfff2f040 0x7f 0x0 0x81000000
406 [0x0000007ffffff960]: 0xffbee040 0x7f 0x0 0x81000000
407 [0x0000007ffffff970]: 0xffbef040 0x7f 0x0 0x81000000
408 [0x0000007ffffff980]: 0xffbf0040 0x7f 0x0 0x81000000

bit 31 of RDES3 is RDES3_OWN, which when set, means the dwmac core
has ownership of the buffer. Bit 24 means buffer 1 addresa valid
(stored in RDES0). So, if the iMX8MP information is correct, then
advancing 0x02491128 to point at the following descriptors should
"wake" the receive side, but it does not.

Other registers:

Queue 0 Receive Debug:
Value at address 0x02490d38: 0x002a0020

bit 0 = 0 (MTL Rx Queue Write Controller Active Status not detected)
bit 2:1 = 0 (Read controller Idle state)
bits 5:4 = 2 (Rx Queue fill-level above flow-control activate threshold)
bits 29:16 = 0x2a 42 packets in receive queue

Because the internal queue is above the flow-control activate
threshold, that causes the stmmac hardware to constantly spew pause
frames, and, as the stmmac receive side is essentially stuck and won't
make progress even when there are free buffers, the only way to release
this state is via a software reset of the entire core.

Why don't pause frames save us? Well, pause frames will only be sent
when the receive queue fills to the activate threshold, which can only
happen _after_ packets stop being transferred to the descriptor rings.
In other words, it can only happen when a RBU event has been detected,
which suspends the receiver - and it seems when that happens, it is
irrecoverable without soft-reset on Xavier.

Right now, I'm not sure what to think about this - I don't know whether
it's the hardware that's at fault, or whether there's an issue in the
driver. What I know for certain is what I've stated above, and the
fact that iperf3 -R has *extremely* detrimental effects on my *entire*
network.

The reason is... you connect two Netgear switches together, they use
flow control, and you have no way to turn that off... So, once stmmac
starts sending pause frames, the switches queue for that port fills,
and when further frames come in for that port, the switch sends pause
frames to the next switch behind which stops all traffic flow between
the two switches, severing the network. All the time that stmmac keeps
that up, so does the switch it is connected to.

If another machine happens to send a packet that needs to be queued on
the port that stmmac is connected to (e.g. broadcast or multicast)
then... that port starts sending pause frames back to that machine,
severing its network connection permanently while stmmac is spewing
pause frames.

Thus, the entire network goes down, on account of _one_ machine
repeatedly sending pause frames, preventing packet delivery.

While the idea of a lossless network _seems_ like a good idea, in
reality it gives an attacker who can get on a platform and take
control of the ethernet NIC the ability to completely screw an entire
network if flow control is enabled everywhere. I'm thinking at this
point... just say no to flow control, disable it everywhere one can.
Ethernet was designed to lose packets when it needs to, to ensure
fairness. Flow control destroys that fairness and results in networks
being severed.

"attacker" is maybe too strong - consider what happens if the kernel
crashes on a stmmac platform, so it can't receive packets anymore,
and the ring fills up, causing it to start spewing pause frames.
It's goodbye network!

I'm just rambling, but I think that point is justified.

Thoughts - should the kernel default to having flow control enabled
or disabled in light of this? Should this feature require explicit
administrative configuration given the severity of network disruption?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

