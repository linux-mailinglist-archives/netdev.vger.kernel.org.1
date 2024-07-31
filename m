Return-Path: <netdev+bounces-114716-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56B0194397B
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 01:47:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C0811C219D4
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 23:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 929D614B097;
	Wed, 31 Jul 2024 23:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XDqZut6W"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C57F16D9D9
	for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 23:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722469638; cv=none; b=pw5e9yi2+dP21vaheGqM4iOTlAJ3A2xCDbYRHSH9P4QQhVrsb0YGjQbSktbt+rZlhUcDQfF71TZGxuGqNh0cJoUnS4WyrYxqqN8xJXxJpAEwG8w5clcfJm3Cmh0CKzOghUBnKKuJgRu02zs/LHttfklOovusToG3ecZ0ha32/8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722469638; c=relaxed/simple;
	bh=wOo7tBxu6FaBLoulBbGXaFqyq47V+UBc1sue2gyl0hQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nx6SKSKQBqtB07w6cE3jM+njHszrjlCttFTL9krlo50YtdH2ThNEH1ARXQEzeBCotAiPW6Eqep3sGi5irG2+xQnajZBkuB5YQEXEZf05j5VO8YGu9RqHem3qWNVd3TnZFnE7UHVeRejJaqR4v9Qe3G1pI2Wb8NflUARAPNuEkBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XDqZut6W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6E4DC116B1;
	Wed, 31 Jul 2024 23:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722469638;
	bh=wOo7tBxu6FaBLoulBbGXaFqyq47V+UBc1sue2gyl0hQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XDqZut6W0ZLReuvOzEexNagIs2nsj4J8AP0IU87PDU330gME5gqU86LGNYx6mrGWK
	 Ajr6vQGvZXqeaJLoOsCsSyIfxOR2tJ49gehCvgBS3uu4QG5aFBTPN1ov5RfrLuVWgT
	 ORQLX4ytgpiX1xfVNZJHcCVBGEzdC6JMrp/gE+LQGxoPzVdhymrTQ5spNnYK8vviT+
	 s2wYfZK9fa6cLGyWBzKChfPUUUxQXGxWA2AJ3CYFhJhQo3ioOPl7+eV89VPfuk2wso
	 jBrY3SKqcAHtCdooDs3yLMtnD/shpAMoDZLRhiFC6/JJjdhycse+mX2tVbBqLWXTah
	 hhmJvMElq6t7Q==
Date: Wed, 31 Jul 2024 16:47:16 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jacob Keller <jacob.e.keller@intel.com>, Wojciech Drewek
 <wojciech.drewek@intel.com>
Cc: <netdev@vger.kernel.org>, <edumazet@google.com>,
 <anthony.l.nguyen@intel.com>, <simon.horman@corigine.com>,
 <intel-wired-lan@lists.osuosl.org>, <pabeni@redhat.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next] ice: Implement ethtool reset
 support
Message-ID: <20240731164716.63f3b5b7@kernel.org>
In-Reply-To: <c0213cae-5e63-4fd7-81e7-37803806bde4@intel.com>
References: <20240730105121.78985-1-wojciech.drewek@intel.com>
	<20240730065835.191bd1de@kernel.org>
	<c0213cae-5e63-4fd7-81e7-37803806bde4@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 31 Jul 2024 14:08:20 +0200 Wojciech Drewek wrote:
> Quick summary our reset types:
> PF reset reinitialize the resources/data path for PF and its VFs.
> It has no impact on other PF/VFs.
> Core Reset reinitialize all functions and shared parts of the
> device except PHY/MAC units, EMP and PCI Interface.
> Global Reset is Core Reset + PHY/MAC units reset (including External PHY)
> Because Global Reset is a extended Core it makes sense to map it to all.
> PF reset mapping makes sense to me since it is dedicated to a single physical function.

On Wed, 31 Jul 2024 09:48:07 -0700 Jacob Keller wrote:
> PF reset only affects the single PCI function, and does not affect the
> whole adapter. I don't know how it relates to PCIe resets precisely.
> 
> CORE reset affects the whole adapter, and the other functions are
> notified of the impending reset via their miscellaneous interrupt vector
> in combination with some hardware registers.
> 
> GLOBAL reset is similar to the CORE reset, (in that it affects the
> entire device), but it is more invasive in the hardware. I cannot
> remember offhand the differences between CORE and GLOBAL.
> 
> There is also an EMP reset, which is the only reset that completely
> reloads the EMP firmware. It is currently used by the device flash
> update logic, via devlink reload and is only available if the new
> firmware image can be reloaded without issue. (Reloading when the new
> firmware could impact PCIe config space is likely to produce undesirable
> behavior because the PCIe config space is not reloaded except by power
> cycling, so you end up with some weird mismatches.)

Note that the reset is controlled using individual bits which can be
combined:

	ETH_RESET_MGMT		= 1 << 0,	/* Management processor */
	ETH_RESET_IRQ		= 1 << 1,	/* Interrupt requester */
	ETH_RESET_DMA		= 1 << 2,	/* DMA engine */
	ETH_RESET_FILTER	= 1 << 3,	/* Filtering/flow direction */
	ETH_RESET_OFFLOAD	= 1 << 4,	/* Protocol offload */
	ETH_RESET_MAC		= 1 << 5,	/* Media access controller */
	ETH_RESET_PHY		= 1 << 6,	/* Transceiver/PHY */
	ETH_RESET_RAM		= 1 << 7,	/* RAM shared between
						 * multiple components */
	ETH_RESET_AP		= 1 << 8,	/* Application processor */

	ETH_RESET_DEDICATED	= 0x0000ffff,	/* All components dedicated to
						 * this interface */
	ETH_RESET_ALL		= 0xffffffff,	/* All components used by this
						 * interface, even if shared */

Note that ethtool CLI defines "shared" version of all bits as bits
shifted up by 16. And it is forward compatible (accepts raw "flags")
if we need to define new bits.

I guess in your case EMP == MGMT? So if these resets don't reset EMP
I presume we shouldn't use any option that includes MGMT..

Could you express your resets in the correct combination of these bits
instead of picking a single one?

