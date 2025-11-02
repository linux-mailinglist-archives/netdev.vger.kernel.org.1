Return-Path: <netdev+bounces-234882-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1321CC288E4
	for <lists+netdev@lfdr.de>; Sun, 02 Nov 2025 01:31:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A681F3B7D4B
	for <lists+netdev@lfdr.de>; Sun,  2 Nov 2025 00:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 645F012CDBE;
	Sun,  2 Nov 2025 00:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="hb4LFYO8"
X-Original-To: netdev@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E8629A2;
	Sun,  2 Nov 2025 00:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762043461; cv=none; b=SuU3aPGVr4VjOyS+pz7Zx+02xp/lpw1lyc99DCEnBfV/K6Ub/2gdnZ0aTffQaoLcJTE0DTyOxgAHUesuiJVlPHc5SRv3aXQW2qY8XCwbDC+AHCQ7jWpPTOB7QzV+MlaABMcXwITwJiuFAXvPjr4sLvh2IEifPcExBLctiGMbKKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762043461; c=relaxed/simple;
	bh=svWNgZCtOjso/oW4IU8AjB0f/EKUwcTrDzXQT6w5yd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lG2XPJpG5GnsrVo4/qWriXGMC4M/UcqqwseJbEV4btd2JOu2zQRP0VjqYU8tULY1MDRO+t7xFWItGP9WCCQWDp2j2Q4rZTYKLq4DKlxZHj4BMkFYufKfaoM0BgF9CTcdM9fVwGT6Y4nsqegfLpB64yGMQ2yfd28+I8Vc/iw4ttM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=hb4LFYO8; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (82-203-160-149.bb.dnainternet.fi [82.203.160.149])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id 2C6711118;
	Sun,  2 Nov 2025 01:29:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1762043344;
	bh=svWNgZCtOjso/oW4IU8AjB0f/EKUwcTrDzXQT6w5yd4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hb4LFYO8jCYLvGpe7YVbC2qXUNIoNFojN2fIQmy0cKSJ0HPrZ5+ixKw1oNxT1SwIC
	 v4Ss/TyZEkKnD4VeEs24LF3pUENpRzDcasVRh31FFk+VhhmiS/7r9TAu247UgBrJ4i
	 vDPQcMVVJhYC3xNMRXVbsIw6ay3v+jXJLXGSZ/aA=
Date: Sun, 2 Nov 2025 02:30:42 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Stanimir Varbanov <svarbanov@suse.de>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rpi-kernel@lists.infradead.org,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrea della Porta <andrea.porta@suse.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Phil Elwell <phil@raspberrypi.com>,
	Jonathan Bell <jonathan@raspberrypi.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>
Subject: Re: [PATCH v2 0/5] dd ethernet support for RPi5
Message-ID: <20251102003042.GJ797@pendragon.ideasonboard.com>
References: <20250822093440.53941-1-svarbanov@suse.de>
 <20251031114518.GA17287@pendragon.ideasonboard.com>
 <eef9a83f-6103-4ab2-927c-921dd9a6a5b3@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <eef9a83f-6103-4ab2-927c-921dd9a6a5b3@suse.de>

On Fri, Oct 31, 2025 at 05:35:32PM +0200, Stanimir Varbanov wrote:
> On 10/31/25 1:45 PM, Laurent Pinchart wrote:
> > On Fri, Aug 22, 2025 at 12:34:35PM +0300, Stanimir Varbanov wrote:
> >> Hello,
> >>
> >> Changes in v2:
> >>  - In 1/5 updates according to review comments (Nicolas)
> >>  - In 1/5 added Fixes tag (Nicolas)
> >>  - Added Reviewed-by and Acked-by tags.
> >>
> >> v1 can found at [1].
> >>
> >> Comments are welcome!
> > 
> > I'm very happy to see support for Raspberry Pi 5 progressing fast
> > upstream.
> > 
> > I've tested the latest mainline kernel (v6.18-rc3) that includes this
> > series (except for 1/5 that is replaced by
> > https://lore.kernel.org/all/20250820-macb-fixes-v4-0-23c399429164@bootlin.com/
> > as far as I understand). The ethernet controller is successfully
> > detected, and so is the PHY. Link status seems to work fine too, but
> > data doesn't seem to go through when the kernel tries to get a DHCP
> > address (for NFS root). Here's the end of the kernel log (with the
> > messages related to the USB controller stripped out):
> > 
> > [    0.896779] rp1_pci 0002:01:00.0: assign IRQ: got 27
> > [    0.896809] rp1_pci 0002:01:00.0: enabling device (0000 -> 0002)
> > [    0.896840] rp1_pci 0002:01:00.0: enabling bus mastering
> > [    0.931874] macb 1f00100000.ethernet: invalid hw address, using random
> > [    0.944448] macb 1f00100000.ethernet eth0: Cadence GEM rev 0x00070109 at 0x1f00100000 irq 95 (da:2e:6d:9d:52:a4)
> > [    0.989067] macb 1f00100000.ethernet eth0: PHY [1f00100000.ethernet-ffffffff:01] driver [Broadcom BCM54210E] (irq=POLL)
> > [    0.989272] macb 1f00100000.ethernet eth0: configuring for phy/rgmii-id link mode
> > [    0.991271] macb 1f00100000.ethernet: gem-ptp-timer ptp clock registered.
> > [    4.039490] macb 1f00100000.ethernet eth0: Link is Up - 1Gbps/Full - flow control tx
> > [    4.062589] Sending DHCP requests .....
> > [   40.902771] macb 1f00100000.ethernet eth0: Link is Down
> > [   43.975334] macb 1f00100000.ethernet eth0: Link is Up - 1Gbps/Full - flow control tx
> > 
> > I've tried porting patches to drivers/net/phy/broadcom.c from the
> > Raspberry Pi kernel to specifically support the BCM54213PE PHY (which is
> > otherwise identified as a BCM54210E), but they didn't seem to help.
> > 
> > What's the status of ethernet support on the Pi 5, is it supposed to
> > work upstream, or are there pieces still missing ?
> 
> We have this [1] patch queued up, could you give it a try please.
> 
> [1] https://www.spinics.net/lists/kernel/msg5889475.html

It fixes the issue, thank you ! I've sent a patch to add an ethernet0
alias (https://lore.kernel.org/all/20251102002901.467-1-laurent.pinchart@ideasonboard.com),
with that I get working ethernet with a stable MAC address.

-- 
Regards,

Laurent Pinchart

