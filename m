Return-Path: <netdev+bounces-207062-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2170B057D1
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 12:29:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BE0617255F
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 10:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472412D8763;
	Tue, 15 Jul 2025 10:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M7ur0yzL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8992D839E;
	Tue, 15 Jul 2025 10:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752575389; cv=none; b=HRoCvV2U13/EXmX/rpxOYX25fVsSGHlpMsSSl8EQCLjyZBZZ1MUQ11V61twF/dGf7gZuzN/ZbOUXD+UKIlpZzU68kLpfoQVpEM+u7A1RGdvo4a/BVLN1dcjpp1CzO0nqZqogq1GI0JPAD0nSxMJVwLjI4lH6oTOvRlV+w25rpWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752575389; c=relaxed/simple;
	bh=3aFKmLvJV73jrRTWvkPEDT+E5ohdcZ4PTEwPUee1yYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kfUX1YJX4Ybw5o97CZGXEanGkYmGxmSU6Dxp3ZFegRVdmPpNnRw91r0st0QkVfsXj683e5PBmhk5Bi/UNituCNO6EVNG8oYRMGznJfieIDm0HR/Juo0DPZus2zoJXb8HqXc5a788ynwsKvIibKLJaktL1RpLtHS3oI6XERafLXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M7ur0yzL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE1DEC4CEE3;
	Tue, 15 Jul 2025 10:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752575388;
	bh=3aFKmLvJV73jrRTWvkPEDT+E5ohdcZ4PTEwPUee1yYU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M7ur0yzLo75Zh5bH8PrEOM5HipEOrZz8M14+bYILfExsKyNiUVwKvFEnjm3tVPYkK
	 JasfYEyfwjpRCCnPyRmbsIt3bzsMAWoAlmGZG8hjdcTM8Xzpc/LBDhyd5yY/voBQf0
	 D317EUTCMV8Dzka9bc/9diUWOV1wZr0YI+ooLZegPumJ6SZnMbsL/cKWjB030PfmHB
	 4UN9rLS9F2RiTQFVP91TlI6FSSDhpDEdP2msPvHD6Mzcv/QLj9dDVQ6wqvJMM+bdSi
	 gLFuH59LP8cNnyriIgoES5KnlGvcqpZmm3/y1P3x+bk/4caS07exdomLzwPuOLOWAE
	 Hwhrm/iiKDpNw==
Date: Tue, 15 Jul 2025 11:29:43 +0100
From: Simon Horman <horms@kernel.org>
To: "MITTAL, HIMANSHU" <h-mittal1@ti.com>
Cc: pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
	davem@davemloft.net, andrew+netdev@lunn.ch,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, srk@ti.com,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Roger Quadros <rogerq@kernel.org>, danishanwar@ti.com,
	m-malladi@ti.com, pratheesh@ti.com, prajith@ti.com
Subject: Re: [PATCH net v2] net: ti: icssg-prueth: Fix buffer allocation for
 ICSSG
Message-ID: <20250715102943.GU721198@horms.kernel.org>
References: <20250710131250.1294278-1-h-mittal1@ti.com>
 <20250711144323.GV721198@horms.kernel.org>
 <b626dc40-e05b-40e0-b300-45ced82d2f97@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b626dc40-e05b-40e0-b300-45ced82d2f97@ti.com>

On Tue, Jul 15, 2025 at 12:37:45PM +0530, MITTAL, HIMANSHU wrote:

...

> > > +-----+-----------------------------------------------+
> > > |     |       SLICE 0       |        SLICE 1          |
> > > |     +------------+----------+------------+----------+
> > > |     | Start addr | End addr | Start addr | End addr |
> > > +-----+------------+----------+------------+----------+
> > > | EXP | 70024000   | 70028000 | 7002C000   | 70030000 | <-- Overlapping
> > Thanks for the detailed explanation with these tables.
> > It is very helpful. I follow both the existing and new mappings
> > with their help. Except for one thing.
> > 
> > It's not clear how EXP was set to the values on the line above.
> > Probably I'm missing something very obvious.
> > Could you help me out here?
> 
> The root cause for this issue is that, buffer configuration for Express
> Frames
> in function: prueth_fw_offload_buffer_setup() is missing.
> 
> 
> Details:
> The driver implements two distinct buffer configuration functions that are
> invoked
> based on the driver state and ICSSG firmware:-
> prueth_fw_offload_buffer_setup()
> - prueth_emac_buffer_setup()
> 
> During initialization, the driver creates standard network interfaces
> (netdevs) and
> configures buffers via prueth_emac_buffer_setup(). This function properly
> allocates
> and configures all required memory regions including:
> - LI buffers
> - Express packet buffers
> - Preemptible packet buffers
> 
> However, when the driver transitions to an offload mode (switch/HSR/PRP),
> buffer reconfiguration is handled by prueth_fw_offload_buffer_setup().
> This function does not reconfigure the buffer regions required for Express
> packets,
> leading to incorrect buffer allocation.

Thanks for your patience, I see that now :)

I'm sorry to drag this out, but I do think it would be useful to add
information above the lines of the above to the patch description.

> > > | PRE | 70030000   | 70033800 | 70034000   | 70037800 |
> > > +-----+------------+----------+------------+----------+
> > > 
> > > +---------------------+----------+----------+
> > > |                     | SLICE 0  |  SLICE 1 |
> > > +---------------------+----------+----------+
> > > | Default Drop Offset | 00000000 | 00000000 |     <-- Field not configured
> > > +---------------------+----------+----------+
> > ...

-- 
pw-bot: changes-requested

