Return-Path: <netdev+bounces-117771-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 408B694F1E7
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 17:42:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E010E1F21A3D
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 15:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5263183CD9;
	Mon, 12 Aug 2024 15:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eSUV/drT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF5C183CD4
	for <netdev@vger.kernel.org>; Mon, 12 Aug 2024 15:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723477320; cv=none; b=g4JlQVB2BVaIPWGr0ST1o+UYaeem8xVySigMqu0YfjaNx12S529J7QpbXmbSKkyKcQT7em4Hg0NHg40tb2lqJiHtNX6rc3AmsjKMQfIfoCMDf5RIgJzwhk/wixa4EGhiH5DAeCAegCL6hJl7/Bvxi8mNL5ICzEw9a4FO+JSjpNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723477320; c=relaxed/simple;
	bh=soxcSyPy20MVM8nbavBnK3ZZooeFuzD9+DZor+Z4jVM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W5E01eHZP9+kiG0ObYF/N7kRUbt5h7F9mDzIzDysWeSlLlgEgFIdAPrHe0E5d0n2/Rdq6hLZmEAJZ77UzQ3qqnw427GI8IvCXyd5bGXSfngph1lU+h9eMQVDzmnhIOzawnVRaneLyYwB8NnPPCsgr7B2ohlP38U2bZG3wYFHmO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eSUV/drT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9C68C32782;
	Mon, 12 Aug 2024 15:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723477320;
	bh=soxcSyPy20MVM8nbavBnK3ZZooeFuzD9+DZor+Z4jVM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eSUV/drTkcACKJPetIkMZlC3vkXWsZXwOjNT0yU5DXKzmLpBwGOe7G3O87HlplULF
	 01bF06GlSPIRm3Rsw8yxS4RkIOzrUt85y23W1qADQaMUmBkiO7YutYQ8gA2lLmDgM+
	 RD3k87/tbsmKPpiREAVCVSbbr48hRXmM7bjzaIIkaeRlczeGRArm2jYSa+43lIac1H
	 4uv8v8tm+1MqFfRtZTSWIIhRPEKjPFzYj71IMS7x0lN3D46WnRnbtJX0qdb4UFJ5C/
	 +rVGdi8PGSb702EhYgKrfeMNO9wUEi5p/93keRxFUui1DK8upVwbfnC4fIM2FAEeT7
	 2EGNIrmb90t+A==
Date: Mon, 12 Aug 2024 08:41:59 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Kyle Swenson <kyle.swenson@est.tech>, "o.rempel@pengutronix.de"
 <o.rempel@pengutronix.de>, "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "thomas.petazzoni@bootlin.com"
 <thomas.petazzoni@bootlin.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next v2] net: pse-pd: tps23881: Fix the device ID
 check
Message-ID: <20240812084159.79e5baf3@kernel.org>
In-Reply-To: <20240810234556.4e3e9442@kmaincent-XPS-13-7390>
References: <20240731154152.4020668-1-kyle.swenson@est.tech>
	<20240810234556.4e3e9442@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 10 Aug 2024 23:45:56 +0200 Kory Maincent wrote:
> > The DEVID register contains two pieces of information: the device ID in
> > the upper nibble, and the silicon revision number in the lower nibble.
> > The driver should work fine with any silicon revision, so let's mask
> > that out in the device ID check.
> > 
> > Fixes: 20e6d190ffe1 ("net: pse-pd: Add TI TPS23881 PSE controller driver")
> > Signed-off-by: Kyle Swenson <kyle.swenson@est.tech>  
> 
> Hello Kyle,
> 
> In net subsystem when you send a fix you should use net prefix instead
> of net-next. Jakub, does Kyle have to send a new patch or can you deal with
> it?
> 
> Thanks for your fix!
> 
> Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

Ah, I'm pretty sure I already applied this. kernel.org infra has been
quite unreliable lately. Commit 89108cb5c285 ("net: pse-pd: tps23881:
Fix the device ID check"), indeed in net.

