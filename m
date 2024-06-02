Return-Path: <netdev+bounces-99966-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 086738D73B0
	for <lists+netdev@lfdr.de>; Sun,  2 Jun 2024 06:06:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1254DB20C41
	for <lists+netdev@lfdr.de>; Sun,  2 Jun 2024 04:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D4F0AD21;
	Sun,  2 Jun 2024 04:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="fsrG2+YR"
X-Original-To: netdev@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7085F6FCC;
	Sun,  2 Jun 2024 04:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717301190; cv=none; b=ClyeF8nB0WoQqHtENZjDqWJ6oaZpNoPOphiPxn7vwqM/RAsXBdRS94yTUUJ3JnprhAnwcCtN7Ct0lWDF8pTkUoRu3B9FPZDUJBDA1gjG89XX5GloNp1LhNV6McuU+yaGJ0B/YIehk5uzXVaufdWkoV/RC5TOZ7l/s3U2vgovsDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717301190; c=relaxed/simple;
	bh=Xf0U4wXUP2PjDt3LsUFe7SpGewNofam3QpvCe+XxYa4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UwaeOTUOm4SfmrnuPiOsjdlOUu6bxn8xCQwlg2sMLi6oJqj9/o5HnXvBe+DdNWZUE+AckkVhH5CFDUxxuE3GQ17JXTSBZULN33vrhUCN0luNKuaNfpPHF1ObV5fSMvoHQ9neNB9ElYJ4I3nLDfBs8o56wGV2srg869mfu5kmHCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=fsrG2+YR; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 452467MF007102;
	Sat, 1 Jun 2024 23:06:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1717301167;
	bh=zzYf66IbG8V5Tv5NXVelD+LVqDrloVRIi83uOV2ZLn4=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=fsrG2+YROwRg5oL0xvTbK+NlFi71RinNkxuZTS3nW/m2QBObT/9hiOpZW1kAHaHDW
	 IqVABjo7Qq3rVMgYL46yWCnxTZoo6XRYvkiHpWkz/p+6PdEk4bZ3BBvCuWmhh5oc+r
	 5fYJHpjPgDAyXy9m5xaGhjBtJDRXephbuqXJoCYU=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 452467K2102764
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 1 Jun 2024 23:06:07 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 1
 Jun 2024 23:06:06 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 1 Jun 2024 23:06:06 -0500
Received: from localhost (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 452466jK007178;
	Sat, 1 Jun 2024 23:06:06 -0500
Date: Sun, 2 Jun 2024 09:36:05 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <corbet@lwn.net>, <rogerq@kernel.org>, <danishanwar@ti.com>,
        <vladimir.oltean@nxp.com>, <netdev@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <vigneshr@ti.com>,
        <misael.lopez@ti.com>, <srk@ti.com>
Subject: Re: [RFC PATCH net-next 01/28] docs: networking: ti: add driver doc
 for CPSW Proxy Client
Message-ID: <6e520ad0-0f9b-4fee-87fe-44477b01912b@ti.com>
References: <20240518124234.2671651-1-s-vadapalli@ti.com>
 <20240518124234.2671651-2-s-vadapalli@ti.com>
 <642c8217-49fe-4c54-8d62-9550202c02c9@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <642c8217-49fe-4c54-8d62-9550202c02c9@lunn.ch>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On Sun, May 19, 2024 at 05:31:16PM +0200, Andrew Lunn wrote:

Andrew,

I have spent time going through your feedback, trying to understand your
suggestions. This email is the complete reply corresponding to my earlier
reply at:
https://lore.kernel.org/r/0b0c1b07-756e-439e-bfc5-53824fd2a61c@ti.com/
which was simply meant to serve as an acknowledgement that I have seen
your email.

> On Sat, May 18, 2024 at 06:12:07PM +0530, Siddharth Vadapalli wrote:
> > The CPSW Proxy Client driver interfaces with Ethernet Switch Firmware on
> > a remote core to enable Ethernet functionality for applications running
> > on Linux. The Ethernet Switch Firmware (EthFw) is in control of the CPSW
> > Ethernet Switch on the SoC and acts as the Server, offering services to
> > Clients running on various cores.
> 
> I'm not sure we as a community what this architecture. We want Linux
> to be driving the hardware, not firmware. So expect linux to be
> running the server.

Due to the use-case requirements, Linux cannot be the server. Some of
the requirements are:
1. Fast startup and configuration of CPSW independent of Linux and Other
OS running on any of the cores on the SoC. The configuration of CPSW has
to be performed in parallel while the Bootloader starts Linux.
2. CPSW has to be functional and configurable even when Linux has been
suspended. One of the non-Linux Clients happens to be the AUTOSAR Client
which continues exchanging network data via CPSW even when Linux has
been suspended. So the server has to be functional even then, in order
to cater to the AUTOSAR Client's requests to configure CPSW. CPSW's
configuration is not static in the sense that it gets programmed and
will no longer be modified. Therefore the server has to be functional at
all times to update CPSW's configuration based on the demands of any of
the Clients.

For more details about the Ethernet Switch Firmware (EthFw) and the set
of Clients running on remote cores, please refer:
https://software-dl.ti.com/jacinto7/esd/processor-sdk-rtos-jacinto7/09_02_00_05/exports/docs/ethfw/docs/user_guide/ethfw_c_ug_top.html#ethfw_remote_clients

> 
> > +The "am65-cpsw-nuss.c" driver in Linux at:
> > +drivers/net/ethernet/ti/am65-cpsw-nuss.c
> > +provides Ethernet functionality for applications on Linux.
> > +It also handles both the control-path and data-path, namely:
> > +Control => Configuration of the CPSW Peripheral
> > +Data => Configuration of the DMA Channels to transmit/receive data
> 
> So nuss is capable of controlling the hardware. nuss has an upper
> interface which is switchdev, and a lower interface which somehow acts
> on the hardware, maybe invoking RPCs into the firmware?

There are no RPCs used by the "am65-cpsw-nuss.c" driver. It assumes that
it is the only user of CPSW Ethernet Switch. It doesn't interface with
any firmware. Based on the switchdev framework, it receives commands
from userspace which it then uses to directly write to CPSW's registers.

> 
> So it is not too big a step to put the server functionality in Linux,
> on top of the nuss driver.

Maybe it isn't a big step but it doesn't help with the use-case that I
have described above. For that reason, while it might be a "good to have"
feature, it is not solving the problem.

> 
> Now take a step backwards. This concept of a switch with different
> CPUs attached to it is nothing special.
> 
> Some Marvell switches have a Z80 connected to a dedicated port of the
> switch. You can run applications on that Z80. Those applications might
> be as simple as spanning tree, so you can have a white box 8 port
> ethernet switch without needing an external CPU. But there is an SDK,
> you could run any sort of application on the Z80.
> 
> The microchip LAN996x switch has a Cortex A7 CPU, but also a PCIe
> interface. Linux can control the switch via the PCIe interface, but
> there could also be applications running on the Cortex.
> 
> Look at the Broadcom BCM89586M:
> https://docs.broadcom.com/doc/89586M-PB
> 
> It is similar to the microchip device, an M7 CPU, and a PCIe
> interface. It seems like a Linux host could be controlling the switch
> via PCIe, and applications running on the M7.
> 
> I expect there are more examples, but you get the idea.

I have gone through the examples above. All of them are referring to the
Hardware Capabilities of the Ethernet Switch, which aren't applicable to
the CPSW Ethernet Switch. I am listing why each of them isn't applicable:
1. Marvel Z80 Switch:
I assume that you are referring to:
https://wiki.espressobin.net/tiki-index.php?page=Topaz+Switch
with the "Integrated 200MHz Z80 microprocessor". CPSW doesn't have an
embedded microprocessor dedicated to programming it. The closest it
could get to the Z80 is the external R5 Core running EthFw as far as
configuring the Switch is concerned. But how does it handle the use-case
where there are applications running simultaneously on different cores,
all of which require Ethernet Functionality with the same Ethernet
Switch, in a dynamic manner?
2. Microchip LAN996x:
CPSW doesn't have a PCIe interface.
3. Broadcom BCM89586M:
Again, CPSW doesn't have a PCIe interface.

An important point to note is that all applications you have mentioned
are running on a single core. The current framework being proposed to
solve the problem is for the use-case where there are applications
running across various cores with different criticality (not all
applications may be running all the time, Linux for example will be
suspended as well).

> 
> A completely different angle to look at is VF/PF and eswitches. A
> server style CPU running virtual machines, a VM getting a VF passed
> through to it. This is not something i know much about, so we might
> need to pull in some data centre specialists. But we have a different
> CPU, a virtual CPU, making use of part of the switch. Its the same
> concept really.

CPSW doesn't support SR-IOV. However, if you are referring to modelling
CPSW as an SR-IOV capable Ethernet Switch by having EthFw pose as the
Driver for the "Virtual" Physical Function of CPSW, with each Client
Driver mapping to one of the modelled "Virtual" Virtual Functions
exposed by EthFw, then yes, I will spend time looking at how that could
be implemented. The term "Virtual" has been added in the previous
sentence to clarify that CPSW isn't truly SR-IOV capable and we are
simply making it look that way via EthFw. Even in SR-IOV, the
communicatoin between PF and VF drivers happens via Hardware Mailbox
which means RPMsg is coming back into the picture. The current
implementation also is using RPMsg to exchange control information
between EthFw and all the Clients.

> 
> My main point is, please start with an abstract view of the problem. A
> lot of the solution should be generic, it can be applied to all these
> devices. And then there probably needs to be a small part which is
> specific to TI devices. It could be parts of the solutions already
> exist, e.g. VF/PF have port represents, which might be a useful
> concept here as well. Switchdev exists and provides a generic
> interface for configuring switches...

The summary of the problem statement is:
We require a framework in which the Ethernet Switch (CPSW) has to be
shared across the applications running on different cores of the SoC.
Since CPSW doesn't have an Integrated Processor, some core on the SoC
has to act as the Central Entity which is responsible for arbitrating
configuration requests from various cores and performing the appropriate
configuration of CPSW. Additionally, apart from performing configuration
of CPSW, the Central Entity is also responsible for allocating resources
to different cores, including DMA Channels/Flows (There are 8 TX DMA
Channels which have to be split across different cores to allow each
core to send traffic to CPSW for example). CPSW should be functional
even when some of the Clients (including Linux) might be suspended for
Low Power use-case. The forwarding path of CPSW should be functional
within 100s of milliseconds after the Bootloader stage.

Kindly share your feedback on possible implementations to address the
problem summarized above. Thank you for sharing your valuable feedback
so far on this series.

Regards,
Siddharth.

