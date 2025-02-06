Return-Path: <netdev+bounces-163308-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB95BA29E4A
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 02:23:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF6DF188862B
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 01:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA13914012;
	Thu,  6 Feb 2025 01:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ku/J/nJm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B355F55897
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 01:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738805006; cv=none; b=rbK2j15iY1PZ8/wnK8jyqLRvGB0648oty7WuNK4f+M5s7Lv3L4V+eX04yrkV/83gCJD0zyFnClmvWMbZUab500qhegMuNFPDQITa0aLkf/g0IZbH+RdFVsiORqF1bruuqI9W45KWRoGFasXCo0ABdHfIqrGqJQjJai5691xsXzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738805006; c=relaxed/simple;
	bh=4s00/Qhw5k6SeQl0jncyN3JyVzv77FmJyjRUimIx2/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hLiPfgupa4fn2gH4ub/jfrLgZ9jssXSAV/pnDA8IxjO1XImaIeHe06Gbik9LtnsJERm9X4jFkgi1R6KbQwBkFcyHxJA9gTEI8GfB1ioeAMNvIyN0H8qQxzdAK1VOVihbE/YlR1ZuzZSjfAwMx9KgO3MgtZqTaI5etBuaSKY0Ii8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ku/J/nJm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 078A9C4CED1;
	Thu,  6 Feb 2025 01:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738805006;
	bh=4s00/Qhw5k6SeQl0jncyN3JyVzv77FmJyjRUimIx2/Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ku/J/nJmQkYvvsPNxv7jzkuPy6W1u8XY2yFyy945EeE87zp9uCqhKCeIa0F7l7J/2
	 n+GiELuRQXN29H7+Sg+8GdIoiynZ2ngFpnIeAyrcCn4tbwVQ/EJjplkwMlGdM1vm7Y
	 bIJbBlX3BJqDL/CuORhxrZEtSJrWZXhsaKLcCuXggTRrxxq20GSaElEfzkrfxOvVyP
	 +2PNsIvl6evPphWc6lDR+D5LFOqiKdyry5WmLO4NvU8jd+g1DJYXGbJwzv4rF1q3QN
	 RUBlJt6U47C77NWRswOUNlTqQukxmtSL3VmkW1U78SLP/ucvxQ5d0/LEekOs8qdzeR
	 i7t8pMzf5jaZg==
Date: Wed, 5 Feb 2025 17:23:25 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: iAVF circular lock dependency due to netdev_lock
Message-ID: <20250205172325.5f7c8969@kernel.org>
In-Reply-To: <81562543-5ea1-4994-9503-90b5ff19b094@intel.com>
References: <81562543-5ea1-4994-9503-90b5ff19b094@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 5 Feb 2025 15:20:07 -0800 Jacob Keller wrote:
> This happens because the driver takes netdev_lock prior to acquiring its
> own adapter->crit_lock, but then it calls register_netdevice under the
> crit_lock. Since commit 5fda3f35349b ("net: make netdev_lock() protect
> netdev->reg_state"), the register_netdevice() function now acquires
> netdev_lock as part of its flow.
> 
> I can fix this by refactoring iavf to only take netdev_lock after
> acquiring its own crit_lock.. but that smells funny. It seems like a
> future change could require to take netdev_lock before calling into the
> driver routines somehow, making that ordering problematic.
> 
> I'm not sure how else to fix this... I briefly considered just removing
> crit_lock and relying solely on netdev_lock for synchronization, but
> that doesn't work because of the register_netdevice() taking the lock.
> 
> I guess I could do some funky stuff with unlocking but that seems ugly
> as well...
> 
> I'm not sure what we should do to fix this.

Not sure either, the locking in this driver is quite odd. Do you know
why it's registering the netdev from a workqueue, and what the entry
points to the driver are?

Normally before the netdev is registered it can't get called, so all 
the locking is moot. But IDK if we need to protect from some FW
interactions, maybe?

