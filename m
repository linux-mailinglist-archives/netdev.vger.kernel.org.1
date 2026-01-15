Return-Path: <netdev+bounces-250230-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA43D254AF
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 16:23:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6C9F630AAE0F
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 15:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4989C3AE6F3;
	Thu, 15 Jan 2026 15:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p+40vPcZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B0D3ACEE1;
	Thu, 15 Jan 2026 15:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768490312; cv=none; b=bH0j4qwf6H4MBqSRmuExltswHaaV3PinAyBFIc7eDLWORf5Q4l9EE4udV9Tgpg/3lvHeFXm9VsQ5OZlbUHWZtbVklTNkX1WZsdzrq7w227EKJLZ6rg5Gu+RsF/9EzgnwTm9MjAmGxLdc8cI4dxX14MjxEo8jSBVwhO+9IVptzbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768490312; c=relaxed/simple;
	bh=tnpsywHE5eQehgwsiTgSIg1hMX70Ml+yH71IO/JtgXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fzu2WoewSQwx3G9gYKe9gmwhWpVcUEheYawyVMXKuZCWW4pzLEuk0qPpDe0Rxt7+MGMnIhmeYA+cqPGHlND25N4i+jqK7PMRadHeS0hBaJjYCAQVySKGcV/vgHvbZ6ZSGVBk/b4DUwKv9ank2mG3NP4Wz4V5OjiFrKfwBGYjlrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p+40vPcZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E29EC116D0;
	Thu, 15 Jan 2026 15:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768490311;
	bh=tnpsywHE5eQehgwsiTgSIg1hMX70Ml+yH71IO/JtgXU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p+40vPcZ68hiY9xP3RqBzt/QCsI94dJDKI+1hRXeNEivGPsRdWXd2sIFM/65wyAdG
	 KJfXJNAX2ZVUQKWTXGXXt+ozEuByhWCoXSkl3Nh0iVMLltT3BzCznwoyfFl5qibpQX
	 O3giP88jqMf2ihi8r4U+E4eAwCFjLUXSDjq3+vni5D4wOZRIn2UqKphXVBPT6dSht+
	 U3Vmdbt/g4I1YUjaYAIFD4G4fRwNWe7HG0S2XcxynJe7YivJurD67wjAI/6OU4RaYz
	 i8LJUXNlk6FSq8Lb9jI3H/VAEjsZS66R6cxMwc0ZnBH5G8Th6nIiIwhuk4uydDok8I
	 MkafwK+LVR9kw==
Date: Thu, 15 Jan 2026 15:18:26 +0000
From: Lee Jones <lee@kernel.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 07/15] mfd: core: add ability for cells to probe
 on a custom parent OF node
Message-ID: <20260115151826.GH2842980@google.com>
References: <20251120153622.p6sy77coa3de6srw@skbuf>
 <20251121120646.GB1117685@google.com>
 <20251121170308.tntvl2mcp2qwx6qz@skbuf>
 <20251215155028.GF9275@google.com>
 <20251216002955.bgjy52s4stn2eo4r@skbuf>
 <20251216091831.GG9275@google.com>
 <20251216162447.erl5cuxlj7yd3ktv@skbuf>
 <20260109103105.GE1118061@google.com>
 <20260109121432.lu2o22iijd4i57qq@skbuf>
 <20260115093538.o5ghqb6j6dzledyw@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260115093538.o5ghqb6j6dzledyw@skbuf>

On Thu, 15 Jan 2026, Vladimir Oltean wrote:

> Hi Lee,
> 
> On Fri, Jan 09, 2026 at 02:14:32PM +0200, Vladimir Oltean wrote:
> > > When I've thought about replacing the existing occurrences of the MFD
> > > API being used outside of drivers/mfd, I have often thought of a
> > > platform_add_device_simple() call which I believe would do what most
> > > people of these use-cases actually want.
> > 
> > Would this platform_add_device_simple() share or duplicate code with
> > mfd_add_devices()? Why not just liberalize mfd_add_devices() (the
> > simplest solution)?
> 
> Sorry to nag you, but I would like to have a clear image of which way
> this patch set needs to be heading for v2. My understanding is that
> you're pushing for platform_device_add() while not completely rejecting
> that MFD could be the correct model for this switch's sub-devices.

Sorry, lots on.  I'll go take a look now.

-- 
Lee Jones [李琼斯]

