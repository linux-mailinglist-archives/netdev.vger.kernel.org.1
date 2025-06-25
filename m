Return-Path: <netdev+bounces-200999-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 163BCAE7B83
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 11:07:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42A991895B92
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 09:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4F8F285CBD;
	Wed, 25 Jun 2025 09:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eUztFy2h"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE6426B77F;
	Wed, 25 Jun 2025 09:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750842459; cv=none; b=RtQb4hjGfl+fPviuotmPZ4PmR4jhIst/IBAZxMz1jtBW8TKRi5raR9aikxkYZssp6EDXEpUvqj8FCqNjY1wT8d+V8jfeYobhXXilNTqJCYpDSWMeBugDUrRVWw8sm93VAVN5fHR4iCFGXR+ELD8XGL3mtLHGmX452VSpeKop464=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750842459; c=relaxed/simple;
	bh=Wm/Qm170JnmvLoFVbqubHllu4LDDa//IX18AMk/c+g8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IwFFForBVnhwUau6htvAD7EiCFz+ES5F3Na5zTiJegX4S09KZTjvuzzp8QgxpyMffeEJuPIodplpqbXLkATixs3EnOjjWy0Rqy6x/1m1ytSwefoaO7nevPDqUsamQWBVO+RPL2xQKCeetaxfzc/tO7c0WqLGZDaURl4b3IXomH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eUztFy2h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3E4BC4CEEA;
	Wed, 25 Jun 2025 09:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750842459;
	bh=Wm/Qm170JnmvLoFVbqubHllu4LDDa//IX18AMk/c+g8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eUztFy2hS2wfsb8j77f2PVF4wB4X8iJeV6TVrk5esjbRwDb2d/nWAX7Qvgkencf+1
	 LkOqcqQP36WgokaH0Rb4nb4VZPiyuLCttGVkE2+M9N07PTbboioekupa0qE8jXdssk
	 ZWgLsKI4swkfWT0iGJpXtkppL87YR/otVdn740n9gKoumV1qt1v3gw5nqZqxJW5NMj
	 oDKnzlGgCl7lJRkPWW7Cm+YretQ4cBy+ynGytnSY/GiKqs5QXvE5BthcpKF01dyyy3
	 EJDVL6rAeK3loyeOgI500rxCGxYwH3DzNyak48FD9mGzmqPI6NqObJF/wlirXSqxCG
	 PABnRRg0crxdQ==
Date: Wed, 25 Jun 2025 10:07:34 +0100
From: Simon Horman <horms@kernel.org>
To: Jamie Bainbridge <jamie.bainbridge@gmail.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Michal Schmidt <mschmidt@redhat.com>,
	Brett Creeley <brett.creeley@amd.com>,
	Ivan Vecera <ivecera@redhat.com>, intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net] i40e: When removing VF MAC filters, only check
 PF-set MAC
Message-ID: <20250625090734.GJ1562@horms.kernel.org>
References: <c856f16e6ab37286733174c0fcf12bc72b677096.1750807588.git.jamie.bainbridge@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c856f16e6ab37286733174c0fcf12bc72b677096.1750807588.git.jamie.bainbridge@gmail.com>

On Wed, Jun 25, 2025 at 09:29:18AM +1000, Jamie Bainbridge wrote:
> When the PF is processing an Admin Queue message to delete a VF's MACs
> from the MAC filter, we currently check if the PF set the MAC and if
> the VF is trusted.
> 
> This results in undesirable behaviour, where if a trusted VF with a
> PF-set MAC sets itself down (which sends an AQ message to delete the
> VF's MAC filters) then the VF MAC is erased from the interface.
> 
> This results in the VF losing its PF-set MAC which should not happen.
> 
> There is no need to check for trust at all, because an untrusted VF
> cannot change its own MAC. The only check needed is whether the PF set
> the MAC. If the PF set the MAC, then don't erase the MAC on link-down.
> 
> Resolve this by changing the deletion check only for PF-set MAC.
> 
> (the out-of-tree driver has also intentionally removed the check for VF
> trust here with OOT driver version 2.26.8, this changes the Linux kernel
> driver behaviour and comment to match the OOT driver behaviour)
> 
> Fixes: ea2a1cfc3b201 ("i40e: Fix VF MAC filter removal")
> Signed-off-by: Jamie Bainbridge <jamie.bainbridge@gmail.com>
> ---
> v2: Reword commit message as suggested by Simon Horman.

Thanks for the update.

Reviewed-by: Simon Horman <horms@kernel.org>

