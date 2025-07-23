Return-Path: <netdev+bounces-209254-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8375B0ECE7
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 10:14:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AE3C1886315
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 08:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA59F2797AD;
	Wed, 23 Jul 2025 08:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HYilHJs3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29A3182D3;
	Wed, 23 Jul 2025 08:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753258442; cv=none; b=H2SCwocyhEKXKJD5wEVARJsdU5ibYQpjYXTbjVkmJTsfrVT+DBCYJcOFpjhzj66BGEXSSdIzr81tFBmdIIfFICwkvvjw2dlntW3hGhNuunLohn9xeRPIzLDA9QPb9OPFLITnQIN54BrJ8BTJa0DPWOcCgT8h0QXDlWG8dDfTmpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753258442; c=relaxed/simple;
	bh=qeKqZqAhMV1fB+a75jUMSKcJMpZvyxlRjnCdZh1vOuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gk+hUyoJTLjd15WY38gnYVw+QCI/JFYPbpSsumEea4nGYpEMxCt0EmVgdkOaNLQdzfXf1zDqo/ROvhnP0VOI0qzBq6ckSYRvdYRv9jcIb5ZXXAamI74zh2zRGTC3A2OueGQxlryHNIL2ExVHgyTMyhIT9CfkPLIL4iFDj5feyTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HYilHJs3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5FFFC4CEE7;
	Wed, 23 Jul 2025 08:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753258441;
	bh=qeKqZqAhMV1fB+a75jUMSKcJMpZvyxlRjnCdZh1vOuI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HYilHJs3hXC/SulBh6ytsuj620LusH3SCvPIZqWdTUzNUppiytZyTyQUWLZT/H0ma
	 bGcQvgsrUVrRlPtyBdb+Xv16p+S0KaupUr8GuTBNhkKuR3Wfe7/Z8lcqhVuwhq2mtE
	 s9RXvHI3210SU0aN8kmBpqYBDUkOaPNg40V/7HWlT8wla9PsxZzT46fdWaeuJ8dHlv
	 VR4hsfO5yetBNuyWVSjVGvOf5Ah4IfvC6GLyMQhIt7GQocAQGMasXfJXJWDaC0BitP
	 eRN7JOPssACXeV4q0Vd7pQy7wTuHxiNZUyZit8S0ViXvTWkcVqYDJ6XQBH867ndzFq
	 G0JYH7soBw0tA==
Date: Wed, 23 Jul 2025 11:13:56 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Dave Ertman <david.m.ertman@intel.com>,
	Saravana Kannan <saravanak@google.com>,
	linux-kernel@vger.kernel.org, Michal Simek <michal.simek@amd.com>,
	linux-arm-kernel@lists.infradead.org,
	Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH net v2 1/4] auxiliary: Support hexadecimal ids
Message-ID: <20250723081356.GM402218@unreal>
References: <2025071637-doubling-subject-25de@gregkh>
 <719ff2ee-67e3-4df1-9cec-2d9587c681be@linux.dev>
 <2025071747-icing-issuing-b62a@gregkh>
 <5d8205e1-b384-446b-822a-b5737ea7bd6c@linux.dev>
 <2025071736-viscous-entertain-ff6c@gregkh>
 <03e04d98-e5eb-41c0-8407-23cccd578dbe@linux.dev>
 <2025071726-ramp-friend-a3e5@gregkh>
 <5ee4bac4-957b-481a-8608-15886da458c2@linux.dev>
 <20250720081705.GE402218@unreal>
 <e4b5e4fa-45c4-4b67-b8f1-7d9ff9f8654f@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4b5e4fa-45c4-4b67-b8f1-7d9ff9f8654f@linux.dev>

On Mon, Jul 21, 2025 at 10:29:32AM -0400, Sean Anderson wrote:
> On 7/20/25 04:17, Leon Romanovsky wrote:
> > On Thu, Jul 17, 2025 at 01:12:08PM -0400, Sean Anderson wrote:
> >> On 7/17/25 12:33, Greg Kroah-Hartman wrote:
> > 
> > <...>
> > 
> >> Anyway, if you really think ids should be random or whatever, why not
> >> just ida_alloc one in axiliary_device_init and ignore whatever's
> >> provided? I'd say around half the auxiliary drivers just use 0 (or some
> >> other constant), which is just as deterministic as using the device
> >> address.
> > 
> > I would say that auxiliary bus is not right fit for such devices. This
> > bus was introduced for more complex devices, like the one who has their
> > own ida_alloc logic.
> 
> I'd say that around 2/3 of the auxiliary drivers that have non-constant
> ids use ida_alloc solely for the auxiliary bus and for no other purpose.
> I don't think that's the kind of complexity you're referring to.
> 
> >> Another third use ida_alloc (or xa_alloc) so all that could be
> >> removed.
> > 
> > These ID numbers need to be per-device.
> 
> Why? They are arbitrary with no semantic meaning, right?

Yes, officially there is no meaning, and this is how we would like to
keep it.

Right now, they are very correlated with with their respective PCI function number.
Is it important? No, however it doesn't mean that we should proactively harm user
experience just because we can do it.

[leonro@c ~]$ l /sys/bus/auxiliary/devices/
,,,
rwxrwxrwx 1 root root 0 Jul 21 15:25 mlx5_core.rdma.0 -> ../../../devices/pci0000:00/0000:00:02.7/0000:0
8:00.0/mlx5_core.rdma.0
lrwxrwxrwx 1 root root 0 Jul 21 15:25 mlx5_core.rdma.1 -> ../../../devices/pci0000:00/0000:00:02.7/0000:0
8:00.1/mlx5_core.rdma
...

Thanks

> 
> --Sean
> 

