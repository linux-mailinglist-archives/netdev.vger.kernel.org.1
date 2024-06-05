Return-Path: <netdev+bounces-101119-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A20F8FD675
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 21:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94E71283ACA
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 19:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C34313C9C7;
	Wed,  5 Jun 2024 19:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OmsecQ+n"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6F879F0
	for <netdev@vger.kernel.org>; Wed,  5 Jun 2024 19:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717615799; cv=none; b=EljM5JgZmYgK/aYk63xmPNMyuNhLmTXJ/XRN7xUvCs2EGLHCMciT91tOU6qluHzcNWQVDA+PdP8i1KM1htpF+UHLctjuq1WSdEo4rd/DlhKgPW8dr/hdaSQc/O3D2U9dsHZYpblKVpYocoLE5YzNiNEPm8ujpYrcHg0i79latEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717615799; c=relaxed/simple;
	bh=MeUn48pMUQGJ90ZygjFVjnYHWBC+sZKSPSBqsOIJQ1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IaZ3LhnVgRsYn/KODLd+Iqhe9/8oBVmciqgtRRAZLe/63/LZAcRIlWhSBcOS+bLodA77vHJnye+8en50J3l8fJCBFfaoIwNowj+Cvw60lVTi/t/kNaPj4P+OUfotmbd5et3vepUDEDbNLi6GZBrAlY4C7ehIvvNEWoglgMMfhtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OmsecQ+n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48235C2BD11;
	Wed,  5 Jun 2024 19:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717615798;
	bh=MeUn48pMUQGJ90ZygjFVjnYHWBC+sZKSPSBqsOIJQ1Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OmsecQ+nsyq1S78UxBqu3YA2kIwjdojCNNOH5w+/kZsGyE3eRy4Mrwj3ct668Lwtw
	 xqU6ggrfgCGXGkAw8+6QBBTmkHI56sigX4FfbWstvRrvf1/CIf9xHYcyW3U8cavosa
	 tETblWHSxz1rYa4PcmC3ZWdTSkaEJ6ZtuaDXjDc8rnsxa/UU84jz6H9D2hC9PhEg7G
	 luDG9fTuy6dx+Jog80ysH5JzCyEBXyq9RGO6bFtqxFGCBtxRUMSxqAC9fvlfeHtWRp
	 4LoymJP53X/FL7rwmdOd9K4KJDIce7In8oJB8UfXfdsKwx1zRBkKuQGQiiScXZLMkD
	 H0q5zXhouv6XQ==
Date: Wed, 5 Jun 2024 12:29:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Michal Kubiak <michal.kubiak@intel.com>
Cc: Jacob Keller <jacob.e.keller@intel.com>, David Miller
 <davem@davemloft.net>, netdev <netdev@vger.kernel.org>, Wojciech Drewek
 <wojciech.drewek@intel.com>, George Kuruvinakunnel
 <george.kuruvinakunnel@intel.com>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>
Subject: Re: [PATCH net 4/8] i40e: Fix XDP program unloading while removing
 the driver
Message-ID: <20240605122957.6b961023@kernel.org>
In-Reply-To: <ZmB9ctqbqSMdl5Qu@localhost.localdomain>
References: <20240528-net-2024-05-28-intel-net-fixes-v1-0-dc8593d2bbc6@intel.com>
	<20240528-net-2024-05-28-intel-net-fixes-v1-4-dc8593d2bbc6@intel.com>
	<20240529185428.2fd13cd7@kernel.org>
	<778c9deb-1dc9-4eb6-88d6-eb28a3d0ebbd@intel.com>
	<ZmB9ctqbqSMdl5Qu@localhost.localdomain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 5 Jun 2024 17:00:02 +0200 Michal Kubiak wrote:
> I am afraid checking for NULL won't be enough here.
> Normally, when ndo_bpf is called from the user space application, that
> callback can be called with NULL too (when the user just wants to unload
> the XDP program). In such a case, apart from calling bpf_prog_put(), we
> have to rebuild our internal data structures (queues, pointers, counters
> etc.) to restore the i40e driver working back in normal mode (with no
> XDP program).

Apologizes for asking a question which can be answered by studying 
the code longer, but why do you need to rebuild internal data
structures for a device which is *down*. Unregistering or not.

