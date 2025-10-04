Return-Path: <netdev+bounces-227848-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 212E8BB8B92
	for <lists+netdev@lfdr.de>; Sat, 04 Oct 2025 11:28:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7EE1234704D
	for <lists+netdev@lfdr.de>; Sat,  4 Oct 2025 09:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F141425A2A5;
	Sat,  4 Oct 2025 09:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XFIjcC4P"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C796322A4DA;
	Sat,  4 Oct 2025 09:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759570116; cv=none; b=n4ohGTPnbXW7dzW4glAUmbQO/r6JZ8vWHMJ8auq2A57v7hcm8U8/fmtX+AkBL0oHLDVd3q5FDrnJ+1jRIiYzgP2SkCdBxLQ4KkfxqBSGx9XZrVFUM8NK8PSBvOu+1hSti5beHkZjVixBj/bz2Y1FVQLRw4oYOZT4Tbst+aWjWsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759570116; c=relaxed/simple;
	bh=tXSdGLKEgFkWWOgWzyr7SPiWmc6rtEPxhddbzExB3sY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BbPriHGPCRrHeCJzJnVD2/wVSFNHqJirKe9aSU2oiLE81W6CWJQqE5kVNAWrb5d8xRqtHefai43xFhwobL4Cw7G2NYq4v0HOLV4fD0IN7GK82S57cjdiAvrdL8NrbvelicZFvsvPZtT6MbsmYXZGM/1cYHgt3S64BIw5U8Cj04A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XFIjcC4P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D72F9C4CEF1;
	Sat,  4 Oct 2025 09:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759570116;
	bh=tXSdGLKEgFkWWOgWzyr7SPiWmc6rtEPxhddbzExB3sY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XFIjcC4P7wdEySIshhYn7XmL311iWKwUAsnj/Mz9zZdtsqr/i3sH3GyFL9X45qHOC
	 lOdgnPGa7HbXDHS4DupvYZwO5xJtIWEZNdfqz7k0QZC6iAeZzJI3ISw7RWf2yjOdy/
	 G3DP53ICpW+bw78oY5he2kKSPvI9uI07lCsHxWWG3VSXVfRF3rJisxBNLalt+4+SXj
	 arJXP28gjH0gPsXa7YJP8vfaU8UZ7whwzaB1szMMyVB6qJxkn5ZVDQbxHC6g/eIC7i
	 jEmBEQx9uB/K3DZ63Knt8sn/Nd6blSygL/VvGVR3CBJHNOXrAfjqKZ4XHSqp2a7xLF
	 osOuCEFr25qXw==
Date: Sat, 4 Oct 2025 10:28:31 +0100
From: Simon Horman <horms@kernel.org>
To: Daniel Machon <daniel.machon@microchip.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	UNGLinuxDriver@microchip.com,
	Steen Hegelund <steen.hegelund@microchip.com>,
	jacob.e.keller@intel.com, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: sparx5/lan969x: fix flooding configuration on
 bridge join/leave
Message-ID: <20251004092831.GA3060232@horms.kernel.org>
References: <20251003-fix-flood-fwd-v1-1-48eb478b2904@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251003-fix-flood-fwd-v1-1-48eb478b2904@microchip.com>

On Fri, Oct 03, 2025 at 02:35:59PM +0200, Daniel Machon wrote:
> The sparx5 driver programs UC/MC/BC flooding in sparx5_update_fwd() by
> unconditionally applying bridge_fwd_mask to all flood PGIDs. Any bridge
> topology change that triggers sparx5_update_fwd() (for example enslaving
> another port) therefore reinstalls flooding in hardware for already
> bridged ports, regardless of their per-port flood flags.
> 
> This results in clobbering of the flood masks, and desynchronization
> between software and hardware: the bridge still reports “flood off” for
> the port, but hardware has flooding enabled due to unconditional PGID
> reprogramming.
> 
> Steps to reproduce:
> 
>     $ ip link add br0 type bridge
>     $ ip link set br0 up
>     $ ip link set eth0 master br0
>     $ ip link set eth0 up
>     $ bridge link set dev eth0 flood off
>     $ ip link set eth1 master br0
>     $ ip link set eth1 up
> 
> At this point, flooding is silently re-enabled for eth0. Software still
> shows “flood off” for eth0, but hardware has flooding enabled.
> 
> To fix this, flooding is now set explicitly during bridge join/leave,
> through sparx5_port_attr_bridge_flags():
> 
>     On bridge join, UC/MC/BC flooding is enabled by default.
> 
>     On bridge leave, UC/MC/BC flooding is disabled.
> 
>     sparx5_update_fwd() no longer touches the flood PGIDs, clobbering
>     the flood masks, and desynchronizing software and hardware.
> 
>     Initialization of the flooding PGIDs have been moved to
>     sparx5_start(). This is required as flooding PGIDs defaults to
>     0x3fffffff in hardware and the initialization was previously handled
>     in sparx5_update_fwd(), which was removed.
> 
> With this change, user-configured flooding flags persist across bridge
> updates and are no longer overridden by sparx5_update_fwd().
> 
> Fixes: d6fce5141929 ("net: sparx5: add switching support")
> Signed-off-by: Daniel Machon <daniel.machon@microchip.com>

Reviewed-by: Simon Horman <horms@kernel.org>


