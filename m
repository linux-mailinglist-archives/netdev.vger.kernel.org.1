Return-Path: <netdev+bounces-67292-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D1F842A37
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 17:59:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6EF7B239C2
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 16:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8398128378;
	Tue, 30 Jan 2024 16:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qyYRTy97"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FDE1272C4
	for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 16:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706633955; cv=none; b=jC5WO/I0sWdbptoYwkaFLMGlHe3jUWWEV6f/5FrlB3xBxSH7uI8z0Ax9QC8u1D6mT53tcN/C+fNyWgb5VP8AcQVQG1FLkLV/x/hJExo/Agvxh+wfCTDIBdrjBDNTU8DEUrQsj6Rm32+W1k27i1E9pD94L6lUHhT1R2yP4mOsSJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706633955; c=relaxed/simple;
	bh=Mj4Da6LVU0PiZoyN5sVh+aLJRNPeMl2eDUdxts+TfF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iFialkVfOQwiwS4h+1ZKrIPQJaO/ilIRlpfBrWMpO7ARUo4FD48Vh8pu2wzH7fD8tSXjbGUsAD4lGPQQB4MswdSL0Y3MFLmEvD693zDCXNxflwAMEe/NzIO75cQKgzh011tfSgVnmiFJA0zkLIB0kGIAn1AhsSbVzI4lNib3NR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qyYRTy97; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB936C433F1;
	Tue, 30 Jan 2024 16:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706633955;
	bh=Mj4Da6LVU0PiZoyN5sVh+aLJRNPeMl2eDUdxts+TfF4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qyYRTy97yA0ElaYGqojUuk3mlUDhWZhcIySYGJESaENSt4XOC8lnxh7Ui1fZMybEp
	 XtCpZPmaB4Kd3CY556ia274mQysyFbea87plkvlHi5PEpX4n98p2S2zffgUTV4meaU
	 Qqiwwj6eZC9M+UoVe+PeAHryhH4DHMIPF795QLRPyE9EPl+IsDNfmXtDz9oqBi8kRd
	 +3fAQQ0Iy+W4oG+PJxBQm2te4uWW1mrd2A7vbVjy7qAPx2XeG4v46+IcUzou/4h3fe
	 07+kGQ5jyoGR1rWzsfv2l/gxyL4/tPI7Vb11XJxmlD+Zj/3z4WmcuU9lLC++X/J//g
	 xoEQuRTNWlwRw==
Date: Tue, 30 Jan 2024 10:59:13 -0600
From: Seth Forshee <sforshee@kernel.org>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>, netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org
Subject: Re: [Intel-wired-lan] i40e XDP program stops transmitting after link
 down/up
Message-ID: <Zbkq4cVJ1rEPda8i@do-x1extreme>
References: <ZbkE7Ep1N1Ou17sA@do-x1extreme>
 <47eea378-6b76-46a7-b70e-52bc61f5e9f0@molgen.mpg.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <47eea378-6b76-46a7-b70e-52bc61f5e9f0@molgen.mpg.de>

On Tue, Jan 30, 2024 at 05:14:23PM +0100, Paul Menzel wrote:
> Dear Seth,
> 
> 
> Thank you for bring this up.
> 
> Am 30.01.24 um 15:17 schrieb Seth Forshee:
> > I got a inquiry from a colleague about a behavior he's seeing with i40e
> > but not with other NICs. The interfaces are bonded with a XDP
> > load-balancer program attached to them. After 'ip link set ethX down; ip
> > link set ethX up' on one of the interfaces the XDP program on that
> > interface is no longer transmitting packets. He found that tx starts
> > again after running 'sudo ethtool -t ethX'.
> > 
> > There's a 'i40e 0000:d8:00.1: VSI seid 391 XDP Tx ring 0 disable
> > timeout' message in dmesg when disabling the interface. I've included
> > the relevant portions from dmesg below.
> > 
> > This was first observed with a 6.1 kernel, but we've confirmed that the
> > behavior is the same in 6.7. I realize the firmware is pretty old, so
> > far our attempts to update the NVM have failed.
> 
> Does that mean, the problem didn’t happen before Linux 6.1? If so, if you
> have the reproducer and the time, bisecting the issue is normally the
> fastest way to solve the issue.

No, sorry, I should have worded that better. I meant that they were
using 6.1 when they noticed the issue, not that kernels before 6.1 did
not have that issue. We've also tried a 5.15 kernel build now and still
see the issue there, we haven't tested anything older than that.

Thanks,
Seth

