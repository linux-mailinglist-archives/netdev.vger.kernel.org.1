Return-Path: <netdev+bounces-159530-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0024A15B27
	for <lists+netdev@lfdr.de>; Sat, 18 Jan 2025 04:07:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C08CD7A3C31
	for <lists+netdev@lfdr.de>; Sat, 18 Jan 2025 03:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E90753B1A2;
	Sat, 18 Jan 2025 03:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fN8uy/Nf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C233B784;
	Sat, 18 Jan 2025 03:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737169641; cv=none; b=BtxxoO8NvQR8t40/H7pyFIYbBTXY7iwu26G1fDDybD7EWAUBWgHBeGcHkKRE9GkG0uN30zTqFh3HL2KZp8X3li5aC2Rbs+MIaVRbm4++CB6QUMOBeTxVVOeAD1hDu3VwKFZs2KFIoNUVuMlsx8E4WyCK8hr/HyZJVm4uMlDYVcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737169641; c=relaxed/simple;
	bh=tFzMVYZaHsd7mAtWh0Fp9sk5vaNncunp345pZGZU/8g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lHNPwt9hfeN4xmkjd8AxO3OJmKaTBp/9EmhxUMhffqkJYbcXVyUjPo0HsXRirvgGxfu2W9ObFwLO0IcT/cuH+dgUboLmFdYGqAKaPNz6L+qpY0apzo4GkwYdskUt7bto5Aw8SG3GI4+BqUgkA5QCjJDMULFCdh650diWHSwVCA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fN8uy/Nf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9A03C4CED1;
	Sat, 18 Jan 2025 03:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737169641;
	bh=tFzMVYZaHsd7mAtWh0Fp9sk5vaNncunp345pZGZU/8g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fN8uy/Nfl9iy4H1CB/GYSwAIhw6CscvageUxasUMeJWq4DBcBFsi2/GeQMsVgzs9M
	 Qo8OGrabchDhAg3O9PtdlnIs9SKOPn5+mfMiK4Gnn4slArt926UKNRRzLoHnWpVyyP
	 hQaWVww+fUS9I9V6SHuN0UZhydIPXZGrfXG0/q8tuuHfLEaVZr81bMPn55xlGJKxIV
	 9zPGXOJ/khS0GLbbf7RVYas+rcZtq9WruNts3iSDMGgII1doLBsgU3f6muT61xIkeW
	 W8uXbtIyub+k8bLMx0tceiDgxwaGbVEJK8X3u6DWBT15i7Fugc19M3qcBAJFiVf+1t
	 VKAyDO0Zy7KzA==
Date: Fri, 17 Jan 2025 19:07:20 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Eric Dumazet <edumazet@google.com>, "David S. Miller"
 <davem@davemloft.net>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Claudiu Beznea
 <claudiu.beznea.uj@bp.renesas.com>, thomas.petazzoni@bootlin.com, Andrew
 Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v2] net: phy: Fix suspicious rcu_dereference
 usage
Message-ID: <20250117190720.1bb02d71@kernel.org>
In-Reply-To: <20250117231659.31a4b7fa@kmaincent-XPS-13-7390>
References: <20250117173645.1107460-1-kory.maincent@bootlin.com>
	<CANn89i+PM5JLdN1meKH_moPe88F_=Nsb3in+g-ZK5tiH4PH5GA@mail.gmail.com>
	<20250117231659.31a4b7fa@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 17 Jan 2025 23:16:59 +0100 Kory Maincent wrote:
> > If not protected by RTNL, what prevents two threads from calling this
> > function at the same time,
> > thus attempting to kfree_rcu() the same pointer twice ?  
> 
> I don't think this function can be called simultaneously from two threads,
> if this were the case we would have already seen several issues with the phydev
> pointer. But maybe I am wrong.
> 
> The rcu_lock here is to prevent concurrent dev->hwprov pointer modification done
> under rtnl_lock in net/ethtool/tsconfig.c.

I could also be wrong, but I don't recall being told that suspend path
can't race with anything else. So I think ravb should probably take
rtnl_lock or some such when its shutting itself down.. ?

If I'm wrong I think we should mention this is from suspend and
add Claudiu's stack trace to the commit msg.
-- 
pw-bot: cr

