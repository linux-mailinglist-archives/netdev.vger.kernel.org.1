Return-Path: <netdev+bounces-248319-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 83605D06E55
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 03:57:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3BA00300D17D
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 02:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 680EB31AA8B;
	Fri,  9 Jan 2026 02:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="i3ks2Bu0"
X-Original-To: netdev@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B529D260565;
	Fri,  9 Jan 2026 02:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767927431; cv=none; b=UlzgYt7jhAPUmEK3M1oCPBc+qAsuM6HxbHAer/tSI4tK8ZtW/u3xTzXCJjlQNVzs6q2KVZtgIm6W2mJt/M0mv7zPiGCViStDsm9NE4EODeo9BkxFgTxEXoetkzWJHJ2SA1Krl40W2Huotg2eDtG6Qfewe76G8Z60g5VHobnEkfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767927431; c=relaxed/simple;
	bh=CN/L3nNVvQGANDXC93DVl+ZvdIIojNs/pL7BZr5B4v4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=G66jXyr5lLq79/TmxJ69JpVodO8D35aRrB59ACypdvjoX2U/sZ9XVnIC7FB/g9JjyaxJhepzYlnXqAe9KFjjXSHRGw+U0PELcghkSOhmSNz7MC99tDS6wqU31bSErrpXPx69d+uBz3jsLnIsjBr0psFJJdqMHvc3Z0Nd5hhGP2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=i3ks2Bu0; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1767927420; h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type;
	bh=mLCN/7znJ1LwVwaLJAu7IoQG/h0IkRBZiSPc05To2u0=;
	b=i3ks2Bu0AjXpzqOYcSe7tZ6zHM2xr4o4QCV1akqSnCQpAALPsu4baeRyYwmTvBMU8q7nc7tDF/g6G60ZHo3aXE7PHTkNytfF6JjIGMGbDxxVa5n6laS3qf0IO5pqrjKn08bMwuIvuN8zGHL/pXzJFbPZz3E9mdlD0JtBVNzMxUM=
Received: from 30.221.145.157(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0Wwef76b_1767927417 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 09 Jan 2026 10:56:58 +0800
Message-ID: <0afe19db-9c7f-4228-9fc2-f7b34c4bc227@linux.alibaba.com>
Date: Fri, 9 Jan 2026 10:56:56 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Wen Gu <guwen@linux.alibaba.com>
Subject: [RFC] Defining a home/maintenance model for non-NIC PHC devices using
 the /dev/ptpX API
To: Thomas Gleixner <tglx@linutronix.de>,
 Richard Cochran <richardcochran@gmail.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Dust Li <dust.li@linux.alibaba.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 David Woodhouse <dwmw2@infradead.org>, virtualization@lists.linux.dev,
 Nick Shi <nick.shi@broadcom.com>, Sven Schnelle <svens@linux.ibm.com>,
 Paolo Abeni <pabeni@redhat.com>, linux-clk@vger.kernel.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Hi all,

This is an RFC to discuss the appropriate upstream home and maintenance
model for a class of devices/drivers which expose a high-precision clock
to userspace via the existing PHC interface (/dev/ptpX + standard PTP_*
ioctls), but are not tied to a traditional NIC/IEEE1588 packet
timestamping pipeline.

Examples already in the tree include (non-exhaustive):

- drivers/ptp/ptp_kvm.c [1]
- drivers/ptp/ptp_vmw.c [2]
- drivers/ptp/ptp_s390.c [3]

There are also examples living in their respective subsystem (out of
scope for this RFC),
e.g. drivers/hv/hv_util.c [4] and drivers/virtio/virtio_rtc_ptp.c [5].

We (Alibaba Cloud) also posted a driver for a CIPU-provided high-precision
clock for review [6]. Based on existing in-tree precedent, we placed it
under drivers/ptp/ and sent it to the netdev list.

During review, concerns were raised that such "non-NIC / pure" PHC drivers
are not a good fit for netdev maintainership [7], since they are primarily
time/clock devices rather than networking protocol features.

As a result, I’m sending this RFC to align on a consistent upstream home
and maintainer model for this class of drivers, both for the existing ones
and future additions.

#
## Observation 1: PHC core/API are already not bound to NIC/IEEE1588
#

Although PHC support is original associated with NIC-based IEEE 1588
timestamping, the kernel tree already contains multiple non-NIC PHC
implementations (examples above), including long-standing and recently
added drivers. This reflects the reality that the PHC interface is no
longer tightly bound to NIC/IEEE1588 implementations.

This is enabled by the PHC interface's clean design, it provides a
well-scoped, layered abstraction that separates the userspace access
mechanism (/dev/ptpX + standard ioctl semantics) from the underlying
clock implementation and discipline method (NIC/IEEE1588 packet timestamping
pipeline, virtualization-provided clocks, platform/firmware time services,
etc.). The interface defines only generic clock-operation semantics, without
baking in assumptions about how the clock is produced or synchronized.

Because of this elegant decoupling, the PHC API naturally fits
"pure time source" devices as long as they can provide a stable, precise
hardware clock. In practice, PHC has effectively become Linux’s common
API for high-precision device clocks, rather than inherently bound to
an IEEE1588 NIC implementation.

#
## Observation 2: the PHC (/dev/ptpX) has an established userspace ecosystem
#

The PHC character device interface (/dev/ptpX + standard PTP_* ioctls) is
a mature, stable, and widely deployed userspace API for accessing
high-precision clocks on Linux. It is already the common interface consumed
by existing software stacks (e.g. chrony, and other applications built around
PHC devices)

Introducing a new clock type or a new userspace API (e.g. /dev/XXX) would
require widespread userspace changes, duplicated tooling, and long-term
fragmentation. This RFC is explicitly NOT proposing a new userspace API.

#
## Goal
#

Establish an appropriate upstream home and maintainer model for "pure time
source" PHC drivers. If they are not suitable to be maintained under netdev,
we need a clear place and maintainer(s) for them, and a consistent policy
for accepting new ones.

#
## Proposal
#

1. Reorganize drivers/ptp/ to make the interface/implementation split
    explicit,

    * drivers/ptp/core      : PTP core infrastructure and API.
                              (e.g. ptp_chardev.c, ptp_clock.c,
                               ptp_sysfs.c, etc.)

    * drivers/ptp/pure      : Non-network ("pure clock") implementation,
                              they are typically platform/architecture/
                              virtualization-provided time sources.
                              (e.g. ptp_kvm, ptp_vmw, ptp_vmclock,
                               ptp_s390, etc.)

    * drivers/ptp/*         : Network timestamping oriented implementation,
                              they primarily used together with IEEE1588
                              over the network.
                              (e.g. ptp_qoriq, ptp_pch, ptp_dp83640,
                               ptp_idt82p33 etc.)

2. Transition drivers/ptp/pure from netdev maintainership to
    clock/time maintainership (with an appropriate MAINTAINERS entry,
    e.g. PURE TIME PHC), since these PHC implementations are primarily
    clock devices and not network-oriented. New similar drivers can be
    added under drivers/ptp/pure as well.


Possible alternatives (please suggest others):

- Move/align "pure time source" PHC drivers under an existing
   timekeeping/clocksource/virt area, without changing the userspace API.


I’d like to drive this discussion towards consensus, and I’m happy to
adapt our series to match whatever direction is agreed upon.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a0e136d436ded817c0aade72efdefa56a00b4e5e
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7d10001e20e46ad6ad95622164686bc2cbfc9802
[3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2d7de7a3010d713fb89b7ba99e6fdc14475ad106
[4] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3716a49a81ba19dda7202633a68b28564ba95eb5
[5] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9a17125a18f9ae1e1233a8e2d919059445b9d6fd
[6] https://lore.kernel.org/netdev/20251030121314.56729-1-guwen@linux.alibaba.com/
[7] https://lore.kernel.org/netdev/20251127083610.6b66a728@kernel.org/

Thanks for any input.

Regards,
Wen Gu

