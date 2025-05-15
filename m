Return-Path: <netdev+bounces-190706-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A1A5AB8529
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 13:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E52493ABB36
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 11:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14043297B62;
	Thu, 15 May 2025 11:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MZ/JivS6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D912222CB
	for <netdev@vger.kernel.org>; Thu, 15 May 2025 11:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747309597; cv=none; b=SSh3/VyCipPfT1hx3ujGi+aCXAVlu8TUwXUxj2zeuTmOXVkYedFHbtbNfBfaZtSmqFIpOtp5qZ24uGJO16g+4ptYSSFUBXawWvEGuXTfKRq4t3Ft7vonVbm1rhCwNHLVTlvnNqGYQDAMITaXcL+GIVR76VmxilVc8sv6E60BvIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747309597; c=relaxed/simple;
	bh=AP6Dp0p8NKjVUPvz2D4egauEQFFJpKeje2G/5dCJwiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hxu427YGtz8LMBAbj0kbHVNwcxOvvVLaVzoBIdB9SmSjpHJb7jvJAczRz9hr491lz0vUkSMDc6SEvFHcK1RslsWX/ng5+FdEkRLnllwMjzByKYSPdRQ2AfE+tI9mAY80uqVUkfita4GBD0vy1o2Hhl7TKkBlmqvFZZ9kph9mcJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MZ/JivS6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E480C4CEE7;
	Thu, 15 May 2025 11:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747309596;
	bh=AP6Dp0p8NKjVUPvz2D4egauEQFFJpKeje2G/5dCJwiY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MZ/JivS6nowEfo+rg1lmC3E+xZGHRpij4+9hC26bcTrSPcM8vSJYatKhOFY2tfdi1
	 GKP6g1qFBwd0AsWzNDN6CtbPjsjtUw8YArtr3p+SbV3MDTI0V8YznaOO5foQU/ywz0
	 YG2R/NQbnTa0+N5zNL89p6ZpPlA08+BOvO9ayvLLMQ0JG2puy5e6p/9lZ8jdG01DLl
	 KCDtrgwmBEP1mA49lrdFAey8pF13Fsv+HpKFTOU2ni1A6Hp1YYl5A69bNa6p0MHJbH
	 0sGcPDISsnBA2Z2K2XhAvVNa9pLNV3yF3o/rtCQYXvTptDqw5i8/Xp5GxQkGwOjtJu
	 j/eWADVd1+L4Q==
Date: Thu, 15 May 2025 12:46:32 +0100
From: Simon Horman <horms@kernel.org>
To: Michal Kubiak <michal.kubiak@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, maciej.fijalkowski@intel.com,
	aleksander.lobakin@intel.com, przemyslaw.kitszel@intel.com,
	dawid.osuchowski@linux.intel.com, jacob.e.keller@intel.com,
	jbrandeburg@cloudflare.com, netdev@vger.kernel.org
Subject: Re: [PATCH iwl-net v3 2/3] ice: create new Tx scheduler nodes for
 new queues only
Message-ID: <20250515114632.GV3339421@horms.kernel.org>
References: <20250513105529.241745-1-michal.kubiak@intel.com>
 <20250513105529.241745-3-michal.kubiak@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250513105529.241745-3-michal.kubiak@intel.com>

On Tue, May 13, 2025 at 12:55:28PM +0200, Michal Kubiak wrote:
> The current implementation of the Tx scheduler tree attempts
> to create nodes for all Tx queues, ignoring the fact that some
> queues may already exist in the tree. For example, if the VSI
> already has 128 Tx queues and the user requests for 16 new queues,
> the Tx scheduler will compute the tree for 272 queues (128 existing
> queues + 144 new queues), instead of 144 queues (128 existing queues
> and 16 new queues).
> Fix that by modifying the node count calculation algorithm to skip
> the queues that already exist in the tree.
> 
> Fixes: 5513b920a4f7 ("ice: Update Tx scheduler tree for VSI multi-Tx queue support")
> Reviewed-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Michal Kubiak <michal.kubiak@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


