Return-Path: <netdev+bounces-231471-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BA3B9BF9685
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 01:59:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8E0374F3D02
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 23:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E15D242D8B;
	Tue, 21 Oct 2025 23:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h/mw2CFt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04DB121019C;
	Tue, 21 Oct 2025 23:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761090752; cv=none; b=GZ2dXewO7z75suRLRVB6ew9aQl3ghZdsEyTyuhHRYVx+lnT/qWrPeowt/biHnWsL3BPSbX9nw2NNlUqh8KewM653AJIM3whocORyBps2ViytmeQPR+LAjPxlngQpgrsg4EV+Z+YmHzD01VgjDj3pCAijzpCds7pJFZS+315veoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761090752; c=relaxed/simple;
	bh=ODw5GOX3PmEJ7dwaSWuCqf64HN9Wh+HC/oIRywtWbqc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q6ty9iKcO3WhYJnuhgkinCJuPFpbiaozXDtNDLdqq5YMzLgRwQLrmmQh/pH84tAINyd5Sw54B2ridEBzMm2pidJFaTtDdctsTuphW/zdXROlHjeg1liPfYbkBPPRUpjVS+41eeW8TLNvDdYDbDHS9j4X11E4jj6buboluEBa4rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h/mw2CFt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 002CFC4CEF1;
	Tue, 21 Oct 2025 23:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761090751;
	bh=ODw5GOX3PmEJ7dwaSWuCqf64HN9Wh+HC/oIRywtWbqc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=h/mw2CFtD5og9xtSlO3QOmo/W9AdssFMBkQWtBD+4xzvyG31Z5BvdNZNPuo5PnGF3
	 E8LESzBzdHM0MHqVeCPTePiJleVa3Jg7AC767KLmGFgqZwG1Ei04B+0L75m1Jl2663
	 9H78k1MLHGZ8SA93ofzSWU5z3sav10qBShGHSNxAybh8CwUYAzNQajEXjOmZuG7/an
	 5etsQu6Hd/Ohf348cvd04Ki8e2LThbeXQeGRlvIiHzch3p2qJYnNfzJ8BzV2wSo2hQ
	 T5UhYWVFj167cbtvQ9esvJ6t7xuwl65EhTiDyJnE9L5NanUIwGuzfW1RdGUvJ/WTfz
	 5bbcr4DE+gOpg==
Date: Tue, 21 Oct 2025 16:52:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: andrew@lunn.ch, Horatiu Vultur <horatiu.vultur@microchip.com>,
 hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, richardcochran@gmail.com, vladimir.oltean@nxp.com,
 vadim.fedorenko@linux.dev, rmk+kernel@armlinux.org.uk,
 christophe.jaillet@wanadoo.fr, rosenp@gmail.com,
 steen.hegelund@microchip.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v4 2/2] phy: mscc: Fix PTP for VSC8574 and VSC8572
Message-ID: <20251021165230.1a702ffd@kernel.org>
In-Reply-To: <09b90c94-4b55-4b9f-a23b-e2bd920545bf@redhat.com>
References: <20251017064819.3048793-1-horatiu.vultur@microchip.com>
	<20251017064819.3048793-3-horatiu.vultur@microchip.com>
	<20251020165346.276cd17e@kernel.org>
	<09b90c94-4b55-4b9f-a23b-e2bd920545bf@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 21 Oct 2025 11:07:20 +0200 Paolo Abeni wrote:
> On 10/21/25 1:53 AM, Jakub Kicinski wrote:
> > On Fri, 17 Oct 2025 08:48:19 +0200 Horatiu Vultur wrote:  
> >> For VSC8574 and VSC8572, the PTP initialization is incomplete. It is
> >> missing the first part but it makes the second part. Meaning that the
> >> ptp_clock_register() is never called.
> >>
> >> There is no crash without the first part when enabling PTP but this is
> >> unexpected because some PHys have PTP functionality exposed by the
> >> driver and some don't even though they share the same PTP clock PTP.  
> > 
> > I'm tempted to queue this to net-next, sounds like a "never worked 
> > in an obvious way" case.  I'd appreciate a second opinion.. Andrew?  
> 
> FTR, I agree with the above, as (out of sheer ignorance) I think/fear
> the first patch can potentially cause regressions.

Thanks, let's rephrase the commits message on patch 1 (per Russell's
comments) and get this reposted for net-next (without the Fixes tag).

