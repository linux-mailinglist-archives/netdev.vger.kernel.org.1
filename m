Return-Path: <netdev+bounces-207183-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BC1DB06222
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 16:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B48017966F
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 14:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7CB71531E8;
	Tue, 15 Jul 2025 14:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MTkgAlj6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836972CA9
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 14:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752591040; cv=none; b=k7xrbH1m7oM5YKy2WwACNkeqdMJ9GmQ6rWuS9jYfDHtoe0LweZH4la5r+z0PeTIgctoAUZQx7nF7BGefVMLmwYXjYgC/5E+Pmuon7fthZZKIcX1CjTrPF5c0dqYWfzAPsnedjzNh9Srrkz65uYD8W0ye1QknbYvq475ETGNEu30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752591040; c=relaxed/simple;
	bh=7h18oun5bp56xVd3ctLSNlcCGxy7ZKnfxpKGivEbRZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JO6JLc42HRF9iH6T/ODV3HXxy9OvaVXpeROVpuGpqoUgJohOBXAvb6vxiMxR6yhA4JA8r1nuuDX3Tav7vBLs/bjVk4YGfvV0VZyluRumxWUNZcjKG1Yi1TE6bnx8xz8sPq5CW85RqY+CiLwpTq4DxxaRdNJtIItA1Cusdm2ze4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MTkgAlj6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7719CC4CEE3;
	Tue, 15 Jul 2025 14:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752591040;
	bh=7h18oun5bp56xVd3ctLSNlcCGxy7ZKnfxpKGivEbRZ0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MTkgAlj6t5nTH2YDP1opvrXXxpxBycv7pdytVUTBSGw9X60n4zUlLYAedEhsOqtDm
	 CN53+4R0Q2nQiTgIapAEAxOv+TldA67GA+zss0Klu3Po4Gw30qj7b5aqFz3vqwbsRy
	 YO4vHlFWu6mK47PO0WCySSDDiq3PXVca73PyybuDriiCqa0gf8ZOcPkKiFwcEJINd0
	 7JU0Gt1G7omhoIfORwL2oGU6EjyT4F71uQ7uSQrrMnSObp4Br3yMx9p8nsxRq9VXcw
	 OsRypoStZlGczZEvaOVCQ11la7SDKqGuPG2nk3Zk1tfmgsiXKbzUSRV3x4QljRoyLM
	 RtEfg9RCajfKw==
Date: Tue, 15 Jul 2025 07:50:38 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Gal Pressman <gal@nvidia.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 donald.hunter@gmail.com, shuah@kernel.org, kory.maincent@bootlin.com,
 maxime.chevallier@bootlin.com, sdf@fomichev.me, ecree.xilinx@gmail.com
Subject: Re: [PATCH net-next 10/11] ethtool: rss: support setting flow
 hashing fields
Message-ID: <20250715075038.6d37812a@kernel.org>
In-Reply-To: <7bfc8766-0f6f-4309-984e-24ef86f5c8e3@nvidia.com>
References: <20250711015303.3688717-1-kuba@kernel.org>
	<20250711015303.3688717-11-kuba@kernel.org>
	<2a4c0db9-d330-441f-bce1-937401657bfe@nvidia.com>
	<20250714092933.029a6847@kernel.org>
	<7bfc8766-0f6f-4309-984e-24ef86f5c8e3@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Jul 2025 13:27:51 +0300 Gal Pressman wrote:
> > IOCTL has two separate calls for this so there's no way to even try
> > to change both at once. I'll add "unlike IOCTL which has separate
> > calls" ?  
> 
> So it's different because you can use netlink directly to change both,
> but from userspace ethtool perspective there's no difference, right?
> It's still two commands.

Yup! The existing CLI will likely stay as is.

> Makes sense, thanks for the explanation.
> 
> >> Why not use mod?  
> > 
> > Because it's a difference driver-facing op.  
> 
> Why do we need to differentiate where the mod originated? We have a
> single return value.

Right, but if we only modified the indirection table there's no need 
to call the driver to update the hashing fields and vice versa.
To be clear this is just "an optimization", doesn't affect correctness
in any way.

