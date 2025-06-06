Return-Path: <netdev+bounces-195430-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D158AAD0286
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 14:49:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A013E1718AA
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 12:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A28CA288502;
	Fri,  6 Jun 2025 12:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nUHEkFSQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF1C2882C3
	for <netdev@vger.kernel.org>; Fri,  6 Jun 2025 12:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749214184; cv=none; b=iELBBbiVyVSB2kfogxHDyvSpdO6iCQDR/2FSD7WX8ZR+af1piezt/jWzgbGOn2Bh5C2CRmhN/kiuEYHDwAN3dRSlfwFmzxDnSJw/6eLVgP6XL/B34nAtyh+UN36e5zdhI5JgRG6ZnSljYYPfpmIliG3AQ4tlEJpfxsFhjnt00uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749214184; c=relaxed/simple;
	bh=qa+YPeb+eRNsWZdnWE9oqfhqUThmfef7mJq5ZAVHUc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qYNNdGN9I0LPEO6werwgat8IxETBN2qE91wAxtmzklVYb1eqEIyi90jXm9822K2Slr+EV/UssHSWU/SVgHyjD9/rBsWUR89WD5Vxc/BTsWCIXek4sCn/tIfEcSk0iIXBP3RH5rECmYSD0Ui07HMM47xUCu3nMOYRmKidczogE0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nUHEkFSQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AC20C4CEEB;
	Fri,  6 Jun 2025 12:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749214183;
	bh=qa+YPeb+eRNsWZdnWE9oqfhqUThmfef7mJq5ZAVHUc8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nUHEkFSQjSEydDWEH5VNp5wwi7H+aVhHE/MxLx4IindMtheOm/1Q8N/KTlDwBxnsi
	 oklGxeAsEsduwyadEI8ll+lEQFMIxV70u+Czu1qM9u+uGapSB11/EJ2wwfJt1LewYk
	 RgZM5m3yZtY7doOGyhp6JavAmS9WMkM1W4OI5QJK7NDIMbnyj277Sf9P2MIcovKrAS
	 VRGv/KqMfhuX3Gjo3duwzLCHb/5lDWcd8vAitKHHeUcfqcmYFp4QflUIHHF7WgTwgj
	 pU/iKCeEK4u+Tcvmcv8YglGBVj8YGEksTwbHtECAR0Guvk24eS3VlaN+oCwQnLMeko
	 l+8llu8hFQ/2w==
Date: Fri, 6 Jun 2025 13:49:39 +0100
From: Simon Horman <horms@kernel.org>
To: Karol Kolacinski <karol.kolacinski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	richardcochran@gmail.com, Milena Olech <milena.olech@intel.com>
Subject: Re: [PATCH iwl-next 3/4] ice: use spin_lock for sideband queue send
 queue
Message-ID: <20250606124939.GA120308@horms.kernel.org>
References: <20250520110823.1937981-6-karol.kolacinski@intel.com>
 <20250520110823.1937981-9-karol.kolacinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250520110823.1937981-9-karol.kolacinski@intel.com>

On Tue, May 20, 2025 at 01:06:28PM +0200, Karol Kolacinski wrote:
> Sideband queue is a HW queue and has much faster completion time than
> other queues.
> 
> With <5 us for read on average it is possible to use spin_lock to be
> able to read/write sideband queue messages in the interrupt top half.
> 
> Add send queue lock/unlock operations and assign them based on the queue
> type. Use ice_sq_spin_lock/unlock for sideband queue and
> ice_sq_mutex_lock/unlock for other queues.
> 
> Reviewed-by: Milena Olech <milena.olech@intel.com>
> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>

...

> +/**
> + * ice_sq_spin_lock - Call spin_lock_irqsave for union ice_sq_lock
> + * @lock: lock handle
> + */
> +static void ice_sq_spin_lock(union ice_sq_lock *lock)
> +	__acquires(&lock->sq_spinlock)
> +{
> +	spin_lock_irqsave(&lock->sq_spinlock, lock->sq_flags);
> +}
> +
> +/**
> + * ice_sq_spin_unlock - Call spin_unlock_irqrestore for union ice_sq_lock
> + * @lock: lock handle
> + */
> +static void ice_sq_spin_unlock(union ice_sq_lock *lock)
> +	__releases(&lock->sq_spinlock)
> +{
> +	spin_unlock_irqrestore(&lock->sq_spinlock, lock->sq_flags);
> +}
> +
> +/**
> + * ice_sq_mutex_lock - Call mutex_lock for union ice_sq_lock
> + * @lock: lock handle
> + */
> +static void ice_sq_mutex_lock(union ice_sq_lock *lock)
> +	__acquires(&lock->sq_mutex)
> +{
> +	mutex_lock(&lock->sq_mutex);
> +}
> +
> +/**
> + * ice_sq_mutex_unlock - Call mutex_unlock for union ice_sq_lock
> + * @lock: lock handle
> + */
> +static void ice_sq_mutex_unlock(union ice_sq_lock *lock)
> +	__releases(&lock->sq_mutex)
> +{
> +	mutex_unlock(&lock->sq_mutex);
> +}

Sparse seems unhappy about the annotations on the mutex functions above,
but curiously happy with those for the corresponding spinlock functions.
I am unsure why.

  .../ice_controlq.c:803:13: warning: context imbalance in 'ice_sq_mutex_lock' - wrong count at exit
  .../ice_controlq.c:813:13: warning: context imbalance in 'ice_sq_mutex_unlock' - wrong count at exit


> +
> +static struct ice_sq_ops ice_spin_ops = {
> +	.lock = ice_sq_spin_lock,
> +	.unlock = ice_sq_spin_unlock,
> +};
> +
> +static struct ice_sq_ops ice_mutex_ops = {
> +	.lock = ice_sq_mutex_lock,
> +	.unlock = ice_sq_mutex_unlock,
> +};
> +

...

