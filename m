Return-Path: <netdev+bounces-214868-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C3E9B2B924
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 08:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEDFA62767B
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 06:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBAC72690D5;
	Tue, 19 Aug 2025 06:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZGCq7qCf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SdkPN5lA"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1871863E
	for <netdev@vger.kernel.org>; Tue, 19 Aug 2025 06:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755583770; cv=none; b=OsxdMuIjxNCr/phm+5T8xSEnYhsXN8D+Jij1EntAci2lqP6s5rhoIeBKbNRiO1trrwFgLhC059kfo7n2tiTz/2lbqs+3/v2NjAhYaE1D7hl5whtbU7WHxzc5Uxv2ZjAwLDWj5KGIqb9kS3A3mgegUONFV8UX2ysquVzmdIw1wuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755583770; c=relaxed/simple;
	bh=rL+TrUW6tiyvddHWQRgJrjB30uAutfdbI4yIw0BN8hQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=J2h2MVzmVuaygC3NnHD0Dpt9AQ3EoNSSHcaDKmkssGnz3snZGo0fyUcJkiISnfktnm8RFYdAQVSYFyeukt26fgoZzV1l6le0LYtVm8RUGVpAY/QFNGU8H82WzGLcrRXnLMi5/QTm+grjql0LNyIStX6J3QXXMyC0qDzysWqwy6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZGCq7qCf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SdkPN5lA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755583766;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rL+TrUW6tiyvddHWQRgJrjB30uAutfdbI4yIw0BN8hQ=;
	b=ZGCq7qCfzC5H3GygyPZRbiTCwyFLWcjdY2GuCVTSeKzsFHLFi7TnN2rA4bRkAEQYHEWwx2
	Sfa9Xe29n0OaffTVuC9J6MUc67waFR1yW/pkPD6SAYohfACHVFENHKtoFJUj3Tw1jwJWC0
	8AYmBdbwddYzJ0w6lzjwNX07k/tMJrnsyulDzM8WbTMqCmUXTihkn+dQK6hLAb8sZ9V3Ax
	lVnVn14sqyaxE+72Iw7hO6am1JCWDyRrJdihxn8jcTxYsCZm0sf5bWue+IFqtBvic41CgV
	ChDG7IP/Ijw6260Hi/ammf/N/MVPo9J3DnLZTDrsaosc892S5+FbG5nupgmt9g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755583766;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rL+TrUW6tiyvddHWQRgJrjB30uAutfdbI4yIw0BN8hQ=;
	b=SdkPN5lASqNdoU8R88W/4y657SDrKUFPVaiX6qrGSBu6g8zZKUVSj7+sEnbKFPZte733Tl
	zP6HS2zQ2xQOF9Ag==
To: Miroslav Lichvar <mlichvar@redhat.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, Vinicius
 Costa Gomes <vinicius.gomes@intel.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org
Subject: Re: [Intel-wired-lan] [PATCH iwl-next] igb: Retrieve Tx timestamp
 directly from interrupt
In-Reply-To: <aKMbekefL4mJ23kW@localhost>
References: <20250815-igb_irq_ts-v1-1-8c6fc0353422@linutronix.de>
 <aKMbekefL4mJ23kW@localhost>
Date: Tue, 19 Aug 2025 08:09:25 +0200
Message-ID: <87y0rf4zca.fsf@jax.kurt.home>
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

On Mon Aug 18 2025, Miroslav Lichvar wrote:
> On Fri, Aug 15, 2025 at 08:50:23AM +0200, Kurt Kanzenbach wrote:
>> Retrieve Tx timestamp directly from interrupt handler.
>>=20
>> The current implementation uses schedule_work() which is executed by the
>> system work queue to retrieve Tx timestamps. This increases latency and =
can
>> lead to timeouts in case of heavy system load.
>>=20
>> Therefore, fetch the timestamp directly from the interrupt handler.
>>=20
>> The work queue code stays for the Intel 82576. Tested on Intel i210.
>
> I tested this patch on 6.17-rc1 with an Intel I350 card on a NTP
> server (chrony 4.4), measuring packet rates and TX timestamp accuracy
> with ntpperf. While the HW TX timestamping seems more reliable at some
> lower request rates, there seems to be about 40% drop in the overall
> performance of the server in how much requests it can handle (falling
> back to SW timestamps when HW timestamp is missed). Is this expected
> or something to be considered?=20

Thanks for testing! Nope, this is not really expected. Let me see if I
can reproduce your results and see where that comes from.

Thanks,
Kurt

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmikFRUTHGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzgl5/D/4ys9G0jrCyeLj8q6rsiY9vFRfVcq5L
pLBED0b1dmwg5Wu0sxbioJFb5I/e/qZAWH9p1z5FfWXPKQjtt8zGijaklIOtDt5/
MI1DwU/F/jfQMOa8DnPsrEEHKoYgultJ74ZTnGHjtQW2GqKbHUl48NGjA+8dk6Eu
fHzZKWFmQ9/2RdeIK0DjQDgqiBkZ8N7b0Tvm+eD0DWHltlK8AE7qNvaY5ydSbzEc
Jl9gLVp1Zu4OBn4wM0dYfBYsxWqZak5Xdd2MCnoLaZX1yeJFEfHiof1Jgl8Svdlu
wZ8AOS20/Xi0XvKbdd5T80fK9EAlMrJpRPSQJoLSourKoRwKodZQIKxHv0403oCj
Xt1MVry9zq6IRA4mKUdcD2j/xWwIdBrkE9swZ5py1m5W4EmiGYojgE2DwCcJd4Z1
yxXPp/HzFZ3NmOfEhdjcljDUcBEZNim+qlgtFK0Diiz8TndLfFeaUE/zyEyQcMrQ
ctI7dj/dlxt+V52fFcgYMh1ZEasa7bbmC1LNpys61MC1Vnp8z9NDL8S7dRUlTgM5
q+qxor9pOg7SEc5h5HqEWvQn/SZ82lnGX/GZ0M0Tgasm7c0jyX73Qe/63/P5EP62
n2yK2Timo8yN4lGt7B+vWxyBiAvgUeBYq3baklTVPYPlP1+Vw8HI2BQf089pTPXY
1a91IQJQaNwNuQ==
=Lz+0
-----END PGP SIGNATURE-----
--=-=-=--

