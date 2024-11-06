Return-Path: <netdev+bounces-142193-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60C969BDB7A
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 02:54:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FED32849C7
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 01:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DBD518C011;
	Wed,  6 Nov 2024 01:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XzEDivC5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124626BFCA;
	Wed,  6 Nov 2024 01:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730858056; cv=none; b=MkhBc7qr7s1/ikcpTejMvb8dvjjMHX+56FhQgT/1ptZuE3jJjK8pw1c8E8bdArJXEPddB5wRa1ajzJgpGTBovp5tGZUwamULvSeCVjqDQWQiBN8EVrVmJUJPHVCe9lHy9vXC6xbFJR+Im1PcWSeRdX4naCc1UvK4P8VpIVepoeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730858056; c=relaxed/simple;
	bh=rEl5+/OVz3kpLjNrN+e36IZX2U5ZNK+h6eVl+LZGakU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PLZlE/HC7m0I3sNnOFyojI+Go0Y4wTwTXsJnDvxID+xY7ONxq8IGDvo81mVyeSPxOiCFfDoP1PcobDD3btjOPSvU3YfTDXnkUeC0zSV38JgrYTxnyRPG0K+yVFsm+W3AInY67kBQtkHAM1bBpaskHJmYQyu463fReyRo+2njDXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XzEDivC5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C70B4C4CECF;
	Wed,  6 Nov 2024 01:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730858055;
	bh=rEl5+/OVz3kpLjNrN+e36IZX2U5ZNK+h6eVl+LZGakU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XzEDivC5rp/8TTRdZfv/Ci2uqPYaOVTIdD+l2cQEGcVRGceK3y0fLCaYvvmUDMfOe
	 TpmH1wz4PQY17ZDfbopnVoz1Dt1TBkqhOUrvQiPWBhuHD6SDApSQawS9oY+dqStdiG
	 M6HbXxdVg18DuowqALTjgGdECbMm1E9C5buoUIOWBTNJiCxLeQxLeLskRlgrZCfqB3
	 MEgcLPOrR3Upqc/XVisZVSNn8jS7xU3imx7VC6yhquHet7PoJyuZgNBRGTVWiZ7Jjw
	 I4r6u+erfinjjFCZiPDyPOQ7+NSwggrsaVeOLp3Rlx8rm1zdKQptbz93y6nugnm0/W
	 3Rbyp1ydDoSrQ==
Date: Tue, 5 Nov 2024 17:54:13 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Wander Lairson Costa <wander@redhat.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, Steven
 Rostedt <rostedt@goodmis.org>, intel-wired-lan@lists.osuosl.org (moderated
 list:INTEL ETHERNET DRIVERS), netdev@vger.kernel.org (open list:NETWORKING
 DRIVERS), linux-kernel@vger.kernel.org (open list),
 linux-rt-devel@lists.linux.dev (open list:Real-time Linux
 (PREEMPT_RT):Keyword:PREEMPT_RT), tglx@linutronix.de
Subject: Re: [PATCH] Revert "igb: Disable threaded IRQ for igb_msix_other"
Message-ID: <20241105175413.55ea58f2@kernel.org>
In-Reply-To: <20241104124050.22290-1-wander@redhat.com>
References: <20241104124050.22290-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  4 Nov 2024 09:40:50 -0300 Wander Lairson Costa wrote:
> This reverts commit 338c4d3902feb5be49bfda530a72c7ab860e2c9f.
> 
> Sebastian noticed the ISR indirectly acquires spin_locks, which are
> sleeping locks under PREEMPT_RT, which leads to kernel splats.
> 
> Signed-off-by: Wander Lairson Costa <wander@redhat.com>
> Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Please resend with the reverted commit added as a Fixes tag.
Also - your sign off should be the last tag.
-- 
pw-bot: au

