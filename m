Return-Path: <netdev+bounces-101431-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB328FE815
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 15:43:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DED8F1F2448F
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 13:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D21319642D;
	Thu,  6 Jun 2024 13:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lw2CXzxK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2938C195B2D
	for <netdev@vger.kernel.org>; Thu,  6 Jun 2024 13:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717681410; cv=none; b=oSh2EMLSK+rPccKe9XAvnxxy+5kJO6rWwQVt53TgB4YOsS7zPpJbwwiO4byyJVlritmyX9UpWFfprfe0Ljwiaz9XeHzMPelu8CTupf3k///iICXdoOufyBPeQanFYvmPzCXKtMzaRjYiKNQSoHuCSFVap1Kr3QosbN6KjsCXSIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717681410; c=relaxed/simple;
	bh=38x57V/nj/cw+/8ZbUjC39pLwNh+xsZzXRpoWA/1GQE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UcO54wZwcb2pLfhrRYJgzBagtdi6wRymA/t86OGVGynsUNTkbzvtVwgHcwsm+897hZQ6mbZEOxa0m1VKc14JIDPw9iMy7NXPTVrheSXlOKHHo2XRvsR0fVXes6aP6MbUMokKu9Sgh4ZcSoQijAS3CW+QnadL2Qj/26NVqR3npzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lw2CXzxK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FA0EC2BD10;
	Thu,  6 Jun 2024 13:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717681409;
	bh=38x57V/nj/cw+/8ZbUjC39pLwNh+xsZzXRpoWA/1GQE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lw2CXzxKp3hy4fkMFVHshnnfRLo0tCH3VN+kJlidhECK41ySaz/zG0QKT9mpgTlJp
	 EAYYW6mZB48oVUpxBy2SYbfGbSzDV4aDzlymop8qdNEx8RMKmG1H8ma4UtTb6oXS+f
	 Zd40MIXtGK/SaozlJC/9SBTNeE0yQiFoja2whwR9d74ovQ2G0Q/W/K0YI+T5CVkxf2
	 evm71G6ClTMF6RZbQhMLyQvUOC8lZvjkG00yQWQgRhLbOHU5xzAZ0gMZncgatuH3Yf
	 GI+H0Oxom5pexu49kKUBceB2W8OMFHEDEZZjjIzL2KHGLu0aUHvvgau7cxE2AZo5h6
	 udXLcfmA747Hg==
Date: Thu, 6 Jun 2024 06:43:28 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Michal Kubiak <michal.kubiak@intel.com>
Cc: Jacob Keller <jacob.e.keller@intel.com>, David Miller
 <davem@davemloft.net>, netdev <netdev@vger.kernel.org>, Wojciech Drewek
 <wojciech.drewek@intel.com>, George Kuruvinakunnel
 <george.kuruvinakunnel@intel.com>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>
Subject: Re: [PATCH net 4/8] i40e: Fix XDP program unloading while removing
 the driver
Message-ID: <20240606064328.70878e5f@kernel.org>
In-Reply-To: <ZmGJM1hHOX/dvSYY@localhost.localdomain>
References: <20240528-net-2024-05-28-intel-net-fixes-v1-0-dc8593d2bbc6@intel.com>
	<20240528-net-2024-05-28-intel-net-fixes-v1-4-dc8593d2bbc6@intel.com>
	<20240529185428.2fd13cd7@kernel.org>
	<778c9deb-1dc9-4eb6-88d6-eb28a3d0ebbd@intel.com>
	<ZmB9ctqbqSMdl5Qu@localhost.localdomain>
	<20240605122957.6b961023@kernel.org>
	<ZmGJM1hHOX/dvSYY@localhost.localdomain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 6 Jun 2024 12:02:27 +0200 Michal Kubiak wrote:
> > Apologizes for asking a question which can be answered by studying 
> > the code longer, but why do you need to rebuild internal data
> > structures for a device which is *down*. Unregistering or not.  
> 
> Excuse me, but I don't understand why we should assume that a device is
> *down* when that callback is being called?
> Maybe I didn't make it clear, but the ndo_bpf can be called every time
> when the userspace application wants to load or unload the XDP program.
> It can happen when a device is *up* and also when the link is *up*.

The patch was adding a special case for NETREG_UNREGISTERING,
at that point the device will be closed. Calling ndo_close is one
of the first things core does during unregistering.
Simplifying the handling for when the device is closed would be
better.

