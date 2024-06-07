Return-Path: <netdev+bounces-101876-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A13739005B2
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 15:55:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54FBC1F255FC
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 13:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C321953AA;
	Fri,  7 Jun 2024 13:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SRaIZ4cL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0GuEBcVR"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7DE188CAD;
	Fri,  7 Jun 2024 13:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717768518; cv=none; b=m19NgZ902NZ0gqkyKmotgh0FRs4VrjwsVtf0pHNsEMYa/ZEg5cRNfqw2zKdyAkTvHofJSKynz5Y7hFelY4x/s3iVixdAidhES159i2BKB5M02q6T3mohUoWOpqrWwufb7jVxH8UeHavOCA+//28c8A6VilSP+3GhnSLGFPSGDhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717768518; c=relaxed/simple;
	bh=MpGPHSF59x5sfLf51SEu8OM1/zIpfxVdvnp7NS10R64=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BiLmUAnO3ybleW9RQdZsxSOpdmvOPmsp84RMDGCA0ZbxpUEOEZMjATc0Am7yRefvlFhdcEsvAKgv3Eb/H4xSJE9GvtijGs1R4csBay1SzmH4fufrcvIbtwepbyOPTkEH/62ftzXlDCCedwAzQZJzde59Eoupt6j9CwDrCIlLPhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SRaIZ4cL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0GuEBcVR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717768504;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a5TFPo8LFoQlHtTGJ0fO8j3vVvVYoqqauiwFRzKUJEI=;
	b=SRaIZ4cLKtg8sxove6CR7eHic/rlgNK1XRrEhdiQ32xXjJjN8e3WW+wyW+vwnw/S1wf1Gw
	8b0/naQekhSYmzdNCIqrVMoqMcRapurCCK2o4Lv+yj9hm/17/9+2h8rDsdaQksLoMjE3pl
	JP4e2FWevW198JxkWG2oolpxHo1eF7gN5CjmbjrpHNnLZiILaGgq3qF6ZwVQkju0pxJ6zp
	FQauAxc4BYHR5XIBo1WAAAc43tDxbHXXr6NILy5aQHtxdNNUnphyxoQdSNA2eY/RE1YyLq
	vZI4ZCYj0AE6g7+/n5wjO17bfqTMHDLHCXjRWCkqY77rard5EdpnuH/kiJ9nKg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717768504;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a5TFPo8LFoQlHtTGJ0fO8j3vVvVYoqqauiwFRzKUJEI=;
	b=0GuEBcVR3G2ikuUk5jZsMQ8QElmbCLMuZwyUgTwWd/OQfe3cgT/2Z0zzHb/6Sj5zK/w6yg
	78b3JjUWmuvvD/CA==
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Daniel Bristot de Oliveira
 <bristot@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Daniel Borkmann
 <daniel@iogearbox.net>, Eric Dumazet <edumazet@google.com>, Frederic
 Weisbecker <frederic@kernel.org>, Ingo Molnar <mingo@redhat.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Peter
 Zijlstra <peterz@infradead.org>, Waiman Long <longman@redhat.com>, Will
 Deacon <will@kernel.org>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>
Subject: Re: [PATCH v5 net-next 01/15] locking/local_lock: Introduce guard
 definition for local_lock.
In-Reply-To: <20240607070427.1379327-2-bigeasy@linutronix.de>
References: <20240607070427.1379327-1-bigeasy@linutronix.de>
 <20240607070427.1379327-2-bigeasy@linutronix.de>
Date: Fri, 07 Jun 2024 15:55:03 +0200
Message-ID: <878qzg26yw.ffs@tglx>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Jun 07 2024 at 08:53, Sebastian Andrzej Siewior wrote:

> Introduce lock guard definition for local_lock_t. There are no users
> yet.
>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  include/linux/local_lock.h | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/include/linux/local_lock.h b/include/linux/local_lock.h
> index e55010fa73296..82366a37f4474 100644
> --- a/include/linux/local_lock.h
> +++ b/include/linux/local_lock.h
> @@ -51,4 +51,15 @@
>  #define local_unlock_irqrestore(lock, flags)			\
>  	__local_unlock_irqrestore(lock, flags)
>  
> +DEFINE_GUARD(local_lock, local_lock_t __percpu*,
> +	     local_lock(_T),
> +	     local_unlock(_T))
> +DEFINE_GUARD(local_lock_irq, local_lock_t __percpu*,
> +	     local_lock_irq(_T),
> +	     local_unlock_irq(_T))
> +DEFINE_LOCK_GUARD_1(local_lock_irqsave, local_lock_t __percpu,
> +		    local_lock_irqsave(_T->lock, _T->flags),
> +		    local_unlock_irqrestore(_T->lock, _T->flags),
> +		    unsigned long flags)
> +
>  #endif

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

