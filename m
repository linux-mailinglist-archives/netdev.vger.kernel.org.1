Return-Path: <netdev+bounces-167098-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E45A38D44
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 21:24:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9727C3AD32B
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 20:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40A1225798;
	Mon, 17 Feb 2025 20:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2Cnxybkw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5O7GjtX3"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C27219A8A
	for <netdev@vger.kernel.org>; Mon, 17 Feb 2025 20:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739823867; cv=none; b=SycCREwFDBU4HjRgNW/yDwCSHIIEYTPcDWrFADqfPasDryB6g4VnU8RdnrnIc8vhCx5Gvv3F0UXroTiW4xnnRyFCr3mwTbok0fu4dJxaK7+eN9/YGJNthlCY7E8phoNZs9DgqVC2+MJzOZkvyEWFmFb9gq/pkTNBFb4+pdZQW2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739823867; c=relaxed/simple;
	bh=DmPAGsAiPNKbu4pZ3DKY7uu3GbWftCQw0aslqqsGGOg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hMxuV0/09UT/fKyy7wTNjTxbIhwCwNQAiQMIQzNy0kdepaawcg9ho58po1mcgAzlKJftjyMu37rfE/OsHo9h2mdiKdGffAft8+pLTjBOiIVnIECTMINTPv2IDmXPKKwjV/YiLJH9rudVMlZc7glAu0A7oZzLxwjcViPprptsUf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2Cnxybkw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5O7GjtX3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739823864;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DmPAGsAiPNKbu4pZ3DKY7uu3GbWftCQw0aslqqsGGOg=;
	b=2CnxybkwVSlehUcA5VFcRQgeYBaavsRh5BvvNDR3b6+ORHu929trB2h4/j+FuqTKBbodVd
	XhEgmKEtGxL2IaOG3BJbULNZqvCrly8stYt/QITKxNpdaA5IcKuY9U04WG8sSxxbOFiJox
	lcCMDnFgIGXozWNwx+02+pU84raEXTaQ8LH9A8wLBjXIhsraU6vtE972cgQ20kS06S68EM
	lmev3h7/Ti5iL8AEcpA1FjVjX8Sg5BFKXy2K1ex0Q+dIDOb4dBapsp+Z00cjRoYRPv9HVH
	Thsltlfprqr8U07WuqYZnM4LpOrf6fEOyiiAHC5G5kp5Rm0nuypMf/4PIH1TzA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739823864;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DmPAGsAiPNKbu4pZ3DKY7uu3GbWftCQw0aslqqsGGOg=;
	b=5O7GjtX3/TbMBJKm5D/bLTvcSreJk6f160yqJPB3z14I0RfgdwUswh+kA2i6l4XsiS/V7p
	2Irmr/zizsEY9EBQ==
To: Wojtek Wasko <wwasko@nvidia.com>, netdev@vger.kernel.org
Cc: richardcochran@gmail.com, vadim.fedorenko@linux.dev, kuba@kernel.org,
 horms@kernel.org, anna-maria@linutronix.de, frederic@kernel.org,
 pabeni@redhat.com
Subject: Re: [PATCH net-next v3 2/3] ptp: Add file permission checks on PHCs
In-Reply-To: <20250217095005.1453413-3-wwasko@nvidia.com>
References: <20250217095005.1453413-1-wwasko@nvidia.com>
 <20250217095005.1453413-3-wwasko@nvidia.com>
Date: Mon, 17 Feb 2025 21:24:23 +0100
Message-ID: <87cyfgjp54.ffs@tglx>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 17 2025 at 11:50, Wojtek Wasko wrote:

> Many devices implement highly accurate clocks, which the kernel manages
> as PTP Hardware Clocks (PHCs). Userspace applications rely on these
> clocks to timestamp events, trace workload execution, correlate
> timescales across devices, and keep various clocks in sync.
>
> The kernel=E2=80=99s current implementation of PTP clocks does not enforc=
e file
> permissions checks for most device operations except for POSIX clock
> operations, where file mode is verified in the POSIX layer before
> forwarding the call to the PTP subsystem. Consequently, it is common
> practice to not give unprivileged userspace applications any access to
> PTP clocks whatsoever by giving the PTP chardevs 600 permissions. An
> example of users running into this limitation is documented in [1].
>
> Add permission checks for functions that modify the state of a PTP
> device. Continue enforcing permission checks for POSIX clock operations
> (settime, adjtime) in the POSIX layer. One limitation remains: querying
> the adjusted frequency of a PTP device (using adjtime() with an empty
> modes field) is not supported for chardevs opened without WRITE
> permissions, as the POSIX layer mandates WRITE access for any adjtime
> operation.

That's a fixable problem, no?

