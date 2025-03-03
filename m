Return-Path: <netdev+bounces-171376-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F27C8A4CC04
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 20:34:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1857C1895133
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 19:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4A72217F40;
	Mon,  3 Mar 2025 19:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TYHHtQX7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uGVKn/W0"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24C01C8604
	for <netdev@vger.kernel.org>; Mon,  3 Mar 2025 19:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741030437; cv=none; b=hSNxN+qfA5+ilsdNN9WWAbzuO7tCBpAPIabgrtHmYTOQn6oHI4VZN/vYvsy52WptCybFpbwq4O3UarF943TdWYqm3sLYd0CVVOoU6ysmiriqgkgEsjPhwMtjTyimH7lYM850WGAz3odsjQHt17xnKv9d3Ve23eCSYtuPunJ299g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741030437; c=relaxed/simple;
	bh=hK9QSodsHJBAZy9PcEK0To7lervRaEEYuDb9t9UZ6j8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nRYq5ygYu3bdSZvRj7ZN54wgAAnYfukfaQEboZHCxUnF/9IvcN1PEmDA7hB4jZNyVYRp0pgRxENHIgXc9mkJjOd223s2NeHlD83qf5lmcAZWOEevHvWOtJYakbWxuJpKBMdjehp2XRPKAH6jYoVxCa/LmFyE1kosphsaLN40YTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TYHHtQX7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uGVKn/W0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741030431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wxNqpazITCXSaafW8rMhKx9ozaM1LUV97HxHvYXmOIk=;
	b=TYHHtQX7/DP5npqgDK2njNJYMLG3sA0tKGkfCH0ZlohkEXcrixBL5CGD6UOSlIgV9fr2MB
	hY+IcQm+LS/OOHsRIP+FYBOs2ozYP8h3nIKvAT+FMPwAZQ88WihGm6oAY3A4ssVm/nF3QJ
	k6sxNd2SFQrEcjuWovbMF37iBzwO0SsJQFbpQbgJu5Hd2c9R9IUx9UG6F9OANNaQzNdN7s
	sGYnEsrZkwrzdLUZ5vBAn+Sb5csOVaF0MDkQQe6SzfZEJVoppOe6QG0ghMGPta9pznME/G
	E1RNfdwqjEsT/TAQeYZ758DWs27N+7ly3me5rk18qcwv3Ov9VErGity84n4s4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741030431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wxNqpazITCXSaafW8rMhKx9ozaM1LUV97HxHvYXmOIk=;
	b=uGVKn/W0VCmqa3c8MdLTeOQU7bDOjJMWRElkQ9Qxnc/I0oo6A5wpVj/v/tM2BbB++41wf3
	3Tq7gX7Js1W+2PAQ==
To: Wojtek Wasko <wwasko@nvidia.com>, netdev@vger.kernel.org
Cc: richardcochran@gmail.com, vadim.fedorenko@linux.dev, kuba@kernel.org,
 horms@kernel.org, anna-maria@linutronix.de, frederic@kernel.org,
 pabeni@redhat.com
Subject: Re: [PATCH net-next v4 2/3] ptp: Add PHC file mode checks. Allow RO
 adjtime() without FMODE_WRITE.
In-Reply-To: <20250303161345.3053496-3-wwasko@nvidia.com>
References: <20250303161345.3053496-1-wwasko@nvidia.com>
 <20250303161345.3053496-3-wwasko@nvidia.com>
Date: Mon, 03 Mar 2025 20:33:51 +0100
Message-ID: <87v7spc3j4.ffs@tglx>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 03 2025 at 18:13, Wojtek Wasko wrote:
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
> Additionally, POSIX layer requires WRITE permission even for readonly
> adjtime() calls which are used in PTP layer to return current frequency
> offset applied to the PHC.
>
> Add permission checks for functions that modify the state of a PTP
> device. Continue enforcing permission checks for POSIX clock operations
> (settime, adjtime) in the POSIX layer. Only require WRITE access for
> dynamic clocks adjtime() if any flags are set in the modes field.
>
> [1] https://lists.nwtime.org/sympa/arc/linuxptp-users/2024-01/msg00036.ht=
ml
>
> Changes in v4:
> - Require FMODE_WRITE in ajtime() only for calls modifying the clock in
>   any way.
>
> Acked-by: Richard Cochran <richardcochran@gmail.com>
> Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> Signed-off-by: Wojtek Wasko <wwasko@nvidia.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

