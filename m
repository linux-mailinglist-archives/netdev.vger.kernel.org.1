Return-Path: <netdev+bounces-251145-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A7EE8D3AD1E
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 15:54:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5292A3061DDF
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 14:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E41E135B120;
	Mon, 19 Jan 2026 14:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DO93/L8h"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE50313291;
	Mon, 19 Jan 2026 14:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768834129; cv=none; b=q1LYGEWklfMZPCvHOpUMncIhjSAZmZvIToY+hcacfzVb1MyYhxJTu7UYJ/8Ge0TnF7v3HxbHzi1i2cnDFa3QOPDSgf/YAM0/ruEAYAH367zk6QhYsZBC3+6NxxIjNGHSjvdlOC8gd9BEE0XCg6zk+xOOTpGPBInhitcpfToBbEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768834129; c=relaxed/simple;
	bh=1ATbY9s5yzxtnoP+yy0E0lx3gCwRzt0h+ETy1ner61s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s1AJNeWOtLjy6+uZStrMJrppn3GprOhIYMAFoUmQEIKFr6vCutUdWJLx5HwAqTFNwRyeK0LAHo9DBejgWRuEBIX44W3GwI1QL6R+IT5rvc0Rzf8CO8jbvBK7nN8l7MGEEtIkmiu6hOg2+xza0IrJ2lHboT/kC5PgzZp1rFYSNFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DO93/L8h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3D98C116C6;
	Mon, 19 Jan 2026 14:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768834129;
	bh=1ATbY9s5yzxtnoP+yy0E0lx3gCwRzt0h+ETy1ner61s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DO93/L8hXUobAdfLQOXZWcQTerOyK2jCQCGzG3z+iaMEg+Hi0CMVWpQM6vja/7SHZ
	 8Lk0hHOwTgD7bVIDKg1EdhBRmQsOlMZFbUr1fX4stxt7A+m/K1xKBrRWN3XjtWaHLl
	 lJxAI89Ab5t2xWDsVoCoHJhN0CH3sZM3kVJexlviDbfuNhfVDPZKRz8Si9XUpKWfhF
	 G+lSXq7BAuhhLtKRDaK2xtLUMla0N44echwGe5XtJSVj/0YNze9ASQbNjt+1fA9z95
	 nghEsOakch41JuzIMakgeVqswhuydkOnLJX113Bb9gmw1S82HVw5ob8Y/jw+N9m7yQ
	 FOtY7pnoaxitQ==
Date: Mon, 19 Jan 2026 20:18:29 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Wen Gu <guwen@linux.alibaba.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, 
	Richard Cochran <richardcochran@gmail.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Dust Li <dust.li@linux.alibaba.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, David Woodhouse <dwmw2@infradead.org>, 
	virtualization@lists.linux.dev, Nick Shi <nick.shi@broadcom.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Paolo Abeni <pabeni@redhat.com>, linux-clk@vger.kernel.org
Subject: Re: [RFC] Defining a home/maintenance model for non-NIC PHC devices
 using the /dev/ptpX API
Message-ID: <yg3ikpcwukvv6z6gf6zzkoxlgu37ihauqpm2pkhmxuz6hsxfcc@eaeqykdvkh5v>
References: <0afe19db-9c7f-4228-9fc2-f7b34c4bc227@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0afe19db-9c7f-4228-9fc2-f7b34c4bc227@linux.alibaba.com>

Hi Wen,

On Fri, Jan 09, 2026 at 10:56:56AM +0800, Wen Gu wrote:
> 
> Hi all,
> 
> This is an RFC to discuss the appropriate upstream home and maintenance
> model for a class of devices/drivers which expose a high-precision clock
> to userspace via the existing PHC interface (/dev/ptpX + standard PTP_*
> ioctls), but are not tied to a traditional NIC/IEEE1588 packet
> timestamping pipeline.
> 

Thanks for starting the discussion. I sent out an email just today on this
topic [1] and learned about this thread afterwards.

> Examples already in the tree include (non-exhaustive):
> 
> - drivers/ptp/ptp_kvm.c [1]
> - drivers/ptp/ptp_vmw.c [2]
> - drivers/ptp/ptp_s390.c [3]
> 
> There are also examples living in their respective subsystem (out of
> scope for this RFC),
> e.g. drivers/hv/hv_util.c [4] and drivers/virtio/virtio_rtc_ptp.c [5].
> 
> We (Alibaba Cloud) also posted a driver for a CIPU-provided high-precision
> clock for review [6]. Based on existing in-tree precedent, we placed it
> under drivers/ptp/ and sent it to the netdev list.
> 

Some Qcom MHI devices expose the high precision clock derived from GNSS/Cellular
network over the MHI registers and we recently sent out a series exposing them
as PHC [2]. Since this driver is closely tied with MHI bus, we added it as a
part of drivers/bus/mhi/.

> During review, concerns were raised that such "non-NIC / pure" PHC drivers
> are not a good fit for netdev maintainership [7], since they are primarily
> time/clock devices rather than networking protocol features.
> 
> As a result, I’m sending this RFC to align on a consistent upstream home
> and maintainer model for this class of drivers, both for the existing ones
> and future additions.
> 
> #
> ## Observation 1: PHC core/API are already not bound to NIC/IEEE1588
> #
> 
> Although PHC support is original associated with NIC-based IEEE 1588
> timestamping, the kernel tree already contains multiple non-NIC PHC
> implementations (examples above), including long-standing and recently
> added drivers. This reflects the reality that the PHC interface is no
> longer tightly bound to NIC/IEEE1588 implementations.
> 
> This is enabled by the PHC interface's clean design, it provides a
> well-scoped, layered abstraction that separates the userspace access
> mechanism (/dev/ptpX + standard ioctl semantics) from the underlying
> clock implementation and discipline method (NIC/IEEE1588 packet timestamping
> pipeline, virtualization-provided clocks, platform/firmware time services,
> etc.). The interface defines only generic clock-operation semantics, without
> baking in assumptions about how the clock is produced or synchronized.
> 
> Because of this elegant decoupling, the PHC API naturally fits
> "pure time source" devices as long as they can provide a stable, precise
> hardware clock. In practice, PHC has effectively become Linux’s common
> API for high-precision device clocks, rather than inherently bound to
> an IEEE1588 NIC implementation.
> 
> #
> ## Observation 2: the PHC (/dev/ptpX) has an established userspace ecosystem
> #
> 
> The PHC character device interface (/dev/ptpX + standard PTP_* ioctls) is
> a mature, stable, and widely deployed userspace API for accessing
> high-precision clocks on Linux. It is already the common interface consumed
> by existing software stacks (e.g. chrony, and other applications built around
> PHC devices)
> 
> Introducing a new clock type or a new userspace API (e.g. /dev/XXX) would
> require widespread userspace changes, duplicated tooling, and long-term
> fragmentation. This RFC is explicitly NOT proposing a new userspace API.
> 

+1

> #
> ## Goal
> #
> 
> Establish an appropriate upstream home and maintainer model for "pure time
> source" PHC drivers. If they are not suitable to be maintained under netdev,
> we need a clear place and maintainer(s) for them, and a consistent policy
> for accepting new ones.
> 
> #
> ## Proposal
> #
> 
> 1. Reorganize drivers/ptp/ to make the interface/implementation split
>    explicit,
> 
>    * drivers/ptp/core      : PTP core infrastructure and API.
>                              (e.g. ptp_chardev.c, ptp_clock.c,
>                               ptp_sysfs.c, etc.)
> 
>    * drivers/ptp/pure      : Non-network ("pure clock") implementation,
>                              they are typically platform/architecture/
>                              virtualization-provided time sources.
>                              (e.g. ptp_kvm, ptp_vmw, ptp_vmclock,
>                               ptp_s390, etc.)
> 
>    * drivers/ptp/*         : Network timestamping oriented implementation,
>                              they primarily used together with IEEE1588
>                              over the network.
>                              (e.g. ptp_qoriq, ptp_pch, ptp_dp83640,
>                               ptp_idt82p33 etc.)
> 
> 2. Transition drivers/ptp/pure from netdev maintainership to
>    clock/time maintainership (with an appropriate MAINTAINERS entry,
>    e.g. PURE TIME PHC), since these PHC implementations are primarily
>    clock devices and not network-oriented. New similar drivers can be
>    added under drivers/ptp/pure as well.
> 
> 
> Possible alternatives (please suggest others):
> 
> - Move/align "pure time source" PHC drivers under an existing
>   timekeeping/clocksource/virt area, without changing the userspace API.
> 
> 
> I’d like to drive this discussion towards consensus, and I’m happy to
> adapt our series to match whatever direction is agreed upon.
> 

If we get a consensus to move forward with exposing the device clocks as PHC, we
will respin the MHI driver and would love to get an ACK from the (new)
maintainers.

- Mani

[1] https://lore.kernel.org/all/vmwwnl3zv26lmmuqp2vqltg2fudalpc5jrw7k6ifg6l5cwlk3j@i7jm62zcsl67/
[2] https://lore.kernel.org/mhi/20250818-tsc_time_sync-v1-0-2747710693ba@oss.qualcomm.com/

-- 
மணிவண்ணன் சதாசிவம்

