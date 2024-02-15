Return-Path: <netdev+bounces-71962-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC5B6855BCC
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 08:45:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52353B227BD
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 07:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AFC4DDDC;
	Thu, 15 Feb 2024 07:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kCOcT8Ff"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56EDADDC4
	for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 07:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707983118; cv=none; b=rWNJLKOve9KcyCgjFOtzIYxTuHqDoK3R+cLtVD4itSMvyyV/CW7Pqcmxzcxo10WFX1QjId9kkl07jMefnRsGMWjNNZoP6QsWqpv7K2tT7sUJmbwR5yU4pl7vzJFAiFZBstOgICuJuXgS34OGA15JA9+f03LM0O0I066VbQBudCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707983118; c=relaxed/simple;
	bh=Y2FI1LTyUEGE3bmPL22IBmXnlYbOnsGKoUNTXDFWOY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SAQtVfyCMAyNFyPFV87WlxzMuBWygshhLVBrnqE2rybgHPPRVYGOAB+KfoTbo9VfU2Ez31ANmuwTx3VAHzUR3DVP1EWJlmY98sndHc/DtP2mZNNSExlJ66sgjBL/+VadO867UY3WBQ8lmL3HKAcgdrmpxO4G1dadMpC7h+RkbFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kCOcT8Ff; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48875C433C7;
	Thu, 15 Feb 2024 07:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707983117;
	bh=Y2FI1LTyUEGE3bmPL22IBmXnlYbOnsGKoUNTXDFWOY4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kCOcT8Ff3c0w5Dfn4ZXjUYm1PjmA6W7q+kSGYFLS32aCACUnU0w7NyW0qMUvZDs+w
	 WeFGyrIhb4xmYm212S+8HUpYGuLTeG+rpnw36NqRy1GAU/G5cN6ygMQ48EcJDXvV23
	 ExIfMUbmmb39b+24/IY0lUauQkmpm0uvHL52H1Mo=
Date: Thu, 15 Feb 2024 08:45:14 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Raju Rangoju <Raju.Rangoju@amd.com>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	Shyam-sundar.S-k@amd.com, Sudheesh Mavila <sudheesh.mavila@amd.com>
Subject: Re: [PATCH v5 net-next 3/5] amd-xgbe: add support for new XPCS
 routines
Message-ID: <2024021518-germinate-carol-12c2@gregkh>
References: <20240214154842.3577628-1-Raju.Rangoju@amd.com>
 <20240214154842.3577628-4-Raju.Rangoju@amd.com>
 <20240214172730.379344e5@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240214172730.379344e5@kernel.org>

On Wed, Feb 14, 2024 at 05:27:30PM -0800, Jakub Kicinski wrote:
> Hi Greg!
> 
> Would you be able to give us your "no" vs "whatever" on the license
> shenanigans below? First time I'm spotting this sort of a thing,
> although it looks like we already have copies of this exact text
> in the tree :(

Ugh, that's a mess:

> 
> On Wed, 14 Feb 2024 21:18:40 +0530 Raju Rangoju wrote:
> > + * AMD 10Gb Ethernet driver

First off, checkpatch should have complained about no SPDX line on this
file, so that's a big NACK from me for this patch to start with.  Just
don't do that.

second, this whole thing can be distilled down to a single "GPLv2-only"
spdx line.  Don't create special, custom, licenses like "modified BSD"
if you expect a file to be able to be merged into the kernel tree,
that's not ok.

AMD developers, please work with your lawyers to clean this all up, and
remove ALL of that boilerplate license text, all you need is one simple
SPDX line that describes the license.

Also, I will push back hard and say "no dual license files, UNLESS you
have a lawyer sign-off on the patch" as the issues involved in doing
that are non-trivial, and require work on the legal side of your company
to ensure that they work properly.  That is work your lawyer is signing
up to do, so they need to be responsible for it.

thanks,

greg k-h

