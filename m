Return-Path: <netdev+bounces-200980-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21538AE79D0
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 10:19:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8839B164DEA
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 08:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5711E1FCFF8;
	Wed, 25 Jun 2025 08:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tA4ZKE/U";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XY970qlQ"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A1B3594E;
	Wed, 25 Jun 2025 08:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750839582; cv=none; b=I8Acrwxu4MQe2+nqQ16rXEsTk00tzMT/+gIvPSVBj72iNw6KJhQCc1r06iB0YdFRCqMPVxlVVCfrFZIJ8t3zTssS8PU1oPDJ4iQfzGMIKJqf5kvBDck20H3cuMWXEhKXWFPwdqNwQBJChe1P6+OmWQh7QyxFps7HMPDvRJkYQ5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750839582; c=relaxed/simple;
	bh=16aWqNKmoqZ7N+hUoLW3zWsloeGrZc5zfK7pvbKOgOM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CkzFMYQwY5vUNbpkesVOfcA1d+ZSoBvz7lsEvh4Hjwq43N44+xClNx0IrOidhzJ9TnQlCCdn2v7KVPlnvTFnF6K8koWQ4YI3zs4sZA52Ff4gKQZY5p2nm9H9eb54emFcdmzEAxXqX3pLSvRn5qw8eRpKQxALC0BMvBf+gP9SaLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tA4ZKE/U; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XY970qlQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750839572;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8WeX6Ff7ZzvVAy0/XInX41qrqklcove/vGha5dJn4s4=;
	b=tA4ZKE/UDXhBBa7OC7zsL5ZxL+DIJpQ5lPZ81IKyqsRRg6JhNEZ8TiL2GM+HuXmtGpsT6M
	GcclnOMnuCmxc97ALT/u9yGpzbkdnKedlbVc4GPKAGIcMh2PkLZRPPH02pCJHf5bfvhPiJ
	mKf0XMrJZCrrf0h6HWcnsCqWhfiKTh6me8lcmI9gVSiHYwHF0OsB3DcmOfmb4rhLXAtoEu
	zc03U2mjBVt8+mZ5OINZ1Wxd+YF2+C8qSic2g1ky3BdRDT/XebMJ9o0FKx8GGQm5Il37DP
	8WrStx4q8M3jsg7fg14hoOO0xLYb8irBa+8q1REONYx9tXtYp8PTj3mp1/lNOg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750839572;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8WeX6Ff7ZzvVAy0/XInX41qrqklcove/vGha5dJn4s4=;
	b=XY970qlQnhbdUx1F7pPg8TNTCZODw2kL+scMxIV5YnO6cxGgaC0MAMcdQMEQSePhrJ4/zI
	Ibbe03xr3jdWI4DQ==
To: Paolo Abeni <pabeni@redhat.com>, LKML <linux-kernel@vger.kernel.org>
Cc: Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org
Subject: Re: [patch 08/13] ptp: Split out PTP_PIN_GETFUNC ioctl code
In-Reply-To: <87zfdxmf7h.ffs@tglx>
References: <20250620130144.351492917@linutronix.de>
 <20250620131944.218487429@linutronix.de>
 <caef5686-961d-43aa-8141-c9c90ada2307@redhat.com> <87zfdxmf7h.ffs@tglx>
Date: Wed, 25 Jun 2025 10:19:31 +0200
Message-ID: <87wm90mdws.ffs@tglx>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Jun 24 2025 at 15:39, Thomas Gleixner wrote:
> On Tue, Jun 24 2025 at 11:22, Paolo Abeni wrote:
>>> +	if (cmd == PTP_PIN_GETFUNC2 && !mem_is_zero(pd.rsv, sizeof(pd.rsv)))
>>> +		return -EINVAL;
>>> +	else
>>> +		memset(pd.rsv, 0, sizeof(pd.rsv));
>>
>> Minor nit: I personally find the 'else' statement after return
>> counter-intuitive and dropping it would save an additional LoC.
>
> Of course ...

But second thoughts. The actual logic here is:

	if (cmd == PTP_PIN_GETFUNC2) {
		if (!mem_is_zero(pd.rsv, sizeof(pd.rsv)))
			return -EINVAL;
	} else {
		memset(pd.rsv, 0, sizeof(pd.rsv));
	}

because PTP_PIN_GETFUNC did not mandate the reserved fields to be zero,
which means the reserved fields can never be used with that opcode.

But as it stands today, pd.rsv is not used at all in that function and
pd is fully overwritten via pd = pd->ops_config[] later. So the memset
is completely useless right now and can go away completely.

Thanks,

        tglx



