Return-Path: <netdev+bounces-166466-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EAEBA36131
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 16:14:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 496CF16BBCC
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 15:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD21266583;
	Fri, 14 Feb 2025 15:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AwhMLxYl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C593595C
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 15:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739546076; cv=none; b=lyMKYr1972SsVdd84LbU80CdLFmnoPn6lVaZjeBn8AFDUkZmcU13Fyk2FGPZN39SZ6GmNnxv3xjBhdpat91ne5vHLHL73nb7THGu85POxP4/te3CW43NaURRlQZpBila1/xcd38+JxKY7Dxb9VX3YITzGBVn0TZqfFt1FxkTXqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739546076; c=relaxed/simple;
	bh=NBJNgn3AlLLb4Ld17GM2TREsk6uTzeBBy2ujaupVIH4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rbHRLCKvQHIR5HvFghAbX3fdz5ESna7/fzOsVETzX79iAFud8lJJ4+WqA/oCIHjuy2+x+iSFYgkB2KmPbqwjh7GFdQh84BHAY4xGH42Qiwmre6dEnaFJvaEiq3RF//KLQVQWkIio5+2mhtmK+3nex6YGPP6MtZqoznPwRMtiQUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AwhMLxYl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B996C4CED1;
	Fri, 14 Feb 2025 15:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739546076;
	bh=NBJNgn3AlLLb4Ld17GM2TREsk6uTzeBBy2ujaupVIH4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AwhMLxYlxT1+zXZ62PSqG3agv+l7k97Ho7JcMUajuHcY+b2Hg/YnZmijbTO/wXyjS
	 63EO5hTLDtGfYH75qcUPih1+YddrsasCC0MHF4/Z+/3d7neNo422eKcdL3kec+TN1S
	 QG5063sG+/ZUGsZ6OqaNN/KStvAwuYNtmQhSAZK+VrbyAkT0JNmH5wgNCsHbt0LmKY
	 s1dCnvQAEqdpHaF8nQgZir6tbo6FKlI7rzCUxbFtqq4Q7gpBoOAtv/QuqxODDnFcse
	 OMTx/8AhjViihjCNZnEFKIq98B3bfRt5nQEBWTDT3tuHJ+HCDcwyCSn4ONNCIhzcmz
	 PiXOfuyi3/huw==
Date: Fri, 14 Feb 2025 07:14:35 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: "Berg, Benjamin" <benjamin.berg@intel.com>, "netdev@vger.kernel.org" 
 <netdev@vger.kernel.org>
Subject: Re: [TEST] kunit/cfg80211-ie-generation flaking ?
Message-ID: <20250214071435.47d69038@kernel.org>
In-Reply-To: <2f46c4a25fbfbc4ae6d8352426a6316a50bfa103.camel@sipsolutions.net>
References: <20250213093709.79de1a25@kernel.org>
	<dd9fa04ea86c2486d6faba1eff20560375c140b6.camel@sipsolutions.net>
	<20250213104618.07d9a5fe@kernel.org>
	<2f46c4a25fbfbc4ae6d8352426a6316a50bfa103.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Feb 2025 20:03:04 +0100 Johannes Berg wrote:
> > Oh, that's annoying :( Thanks for investigating.
> > I think the CI runs when the machine is overloaded by builds.
> > I'll add some safety for that.  
> 
> It almost feels like it shouldn't matter - couldn't qemu just kind of
> 'pause' the VM when the serial port isn't keeping up? I think you're
> using qemu? But I guess I could also see why that might not be something
> you want in other use cases...
> 
> Not sure, but it really seems more related to the output (buffering)
> than anything else.
> 
> Are you using the tools/testing/kunit/kunit.py script?

Yes. We do set:

Environment=PYTHONUNBUFFERED=true

So that the logs reach journald without a huge delay.
I guess it disturbs the kunit wrapper.

