Return-Path: <netdev+bounces-216191-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C1DB3276C
	for <lists+netdev@lfdr.de>; Sat, 23 Aug 2025 09:29:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A0A65A1241
	for <lists+netdev@lfdr.de>; Sat, 23 Aug 2025 07:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C5D1E2853;
	Sat, 23 Aug 2025 07:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KZSRQajT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="x3FYBhyQ"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30FE913B5AE
	for <netdev@vger.kernel.org>; Sat, 23 Aug 2025 07:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755934182; cv=none; b=GX1UUyZ5SlcYX02IfbDMfaLEByuANcGZqDCwMoKkKceF+kU4fRiWm4FTqB61dWcKcof8w1t1JyU/xuakHJRH+8f+0zLTFOROl1MNF5puN73iZqlJlybMPhXrBiEpOjWovUgdxR337EbVp/AKrlH6QYm2EefOvm5VnGPWU+46hOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755934182; c=relaxed/simple;
	bh=CSisTzb0ZEcZoCDPrrYFo9jVwbhzmh4wyCpSwiEUlkA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uUbpr9fLePZ6SkIHjSXXlfOQnwtiMLE8banlC567EbQBBG9XuYEGv7XfqPKuHob8Jc5IR+fOlFZN23a5J+DWYQQ4TPgXuQ/vtjPJU40bMczuDB7VuKHj1Wd2ujCRZIXA2CaXFe13wqDQxkdQ2oGPlGC6QrgHUUu+PHKseP9Zx48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KZSRQajT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=x3FYBhyQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755934178;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dmrEX6c/xt+zlzACoXvBPVdXWpJelV17DivxJDQC/t8=;
	b=KZSRQajTnvzW0clRD9RUz1/IrSo5Pbgo5ru0LFaHRnbZJqViAA3L4KZb88KfMJrKK2Rq3g
	79m9I4NGkmve3uvvxTIXoDdHFFEVrZk75WwA5vcE+mW96VWbVsN2gojWHInHIcO4xZuPC7
	Z5ur+8T/o0giuKb0D8j15Loi055fcu4KjLtzmLubi9XZzizeQ9cE06XAvfSPygVzeqp0dT
	YRkoa0FkpIZpZPdgYjUfLVjjvA26TJ5yN2LD9Irth7iivKm2lviJp4WXEzWJAxUZdrGmSd
	jJRCLU6HIbJYbe0xuDvS2SP8xlmGac5Uu0axl2yGwMijxJl9jJ1BS24GVnSJvg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755934178;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dmrEX6c/xt+zlzACoXvBPVdXWpJelV17DivxJDQC/t8=;
	b=x3FYBhyQyClhx66lvIleZcRz2eckqypt2oe3JAizqoGgUlibfO5aEcDE5ozNuj6zubAvsB
	rdGnloBobHqDINDQ==
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, Vinicius
 Costa Gomes <vinicius.gomes@intel.com>, Paul Menzel
 <pmenzel@molgen.mpg.de>, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Miroslav Lichvar <mlichvar@redhat.com>, Jacob Keller
 <jacob.e.keller@intel.com>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH iwl-next v2] igb: Convert Tx timestamping to PTP aux worker
In-Reply-To: <20250822075200.L8_GUnk_@linutronix.de>
References: <20250822-igb_irq_ts-v2-1-1ac37078a7a4@linutronix.de>
 <20250822075200.L8_GUnk_@linutronix.de>
Date: Sat, 23 Aug 2025 09:29:36 +0200
Message-ID: <87ldna7axr.fsf@jax.kurt.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri Aug 22 2025, Sebastian Andrzej Siewior wrote:
> On 2025-08-22 09:28:10 [+0200], Kurt Kanzenbach wrote:
>> The current implementation uses schedule_work() which is executed by the
>> system work queue to retrieve Tx timestamps. This increases latency and =
can
>> lead to timeouts in case of heavy system load.
>>=20
>> Therefore, switch to the PTP aux worker which can be prioritized and pin=
ned
>> according to use case. Tested on Intel i210.
>>=20
>> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
>> ---
>> Changes in v2:
>> - Switch from IRQ to PTP aux worker due to NTP performance regression (M=
iroslav)
>> - Link to v1: https://lore.kernel.org/r/20250815-igb_irq_ts-v1-1-8c6fc03=
53422@linutronix.de
>
> For the i210 it makes sense to read it directly from IRQ avoiding the
> context switch and the delay resulting for it. For the e1000_82576 it
> makes sense to avoid the system workqueue and use a dedicated thread
> which is not CPU bound and could prioritized/ isolated further if
> needed.
> I don't understand *why* reading the TS in IRQ is causing this packet
> loss.

Me neither. I thought it could be the irqoff time. On my test systems
the TS IRQ takes about ~16us with reading the timestamp. In the
kworker/ptp aux thread scenario it takes about ~6us IRQ time + ~10us run
time for the threads. All of that looks reasonable to me.

Also I couldn't really see a performance degradation with ntpperf. In my
tests the IRQ variant reached an equal or higher rate. But sometimes I
get 'Could not send requests at rate X'. No idea what that means.

Anyway, this patch is basically a compromise. It works for Miroslav and
my use case.

> This is also what the igc does and the performance improved
> 	afa141583d827 ("igc: Retrieve TX timestamp during interrupt handling")
>
> and here it causes the opposite?

As said above, I'm out of ideas here.

Thanks,
Kurt

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmipbeETHGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzgoTREACTR0YHHDXeAfhog0YtHT7jucGWdCID
r99TTpdEJfQQvBSvDG1oSeDFEhBJRqHhv0BpuRKxiiCVB28K5eZM0rlDcf/434DG
7e96GevAI/FzEePC3nsUxAV3aF1fHlBjYXkOp62fFYIXmlRCH01rLrhsEaj6d7oy
aCzNILFGm0Q7RRsp53WrgMujZ/yszFMmKsTDA5ehkfvGWbF+3QnoIhnx28VZL47S
irzeiRkAMvEue+n/jii/osRibm6tKdfnAO3vfB3X3yfiMDee5HqkJxK+898XuHGg
a/nU4FQbMVNeLSulap0lyvyrYjygn8PbD1slg5W5HWsDd6sLOToTW7oiqDMIyDhx
MSlvOy52C6IpP1hgx/HEaDATN+vask736P/ouEZ8Bl8gCPQdMgqGVarYYHBC0Ibe
XNO2+0GDmkLImmM9uITafocQDQuHGlNHquOuw2y6xNS+47NUr6luxLvtK8bPBBnc
u9JLDESmWYFStLDzt/JneezAFgWkQTsShtlwlRyG/nzKE8PMDZTnXyxEh+cHyu5T
Kq54TvNPDk+Xhaz1NYd/vvjCoprpvvxX5mt05zoNjdODOdizk471TyohZjMyUAC8
jD+NZKDxPrgfgmIrG0uGPrRYLEHgcInOnwbTDM2AdABB3+5imulSSyGZQAmpO0O1
/Vh/6CzJb0qECg==
=4JqL
-----END PGP SIGNATURE-----
--=-=-=--

