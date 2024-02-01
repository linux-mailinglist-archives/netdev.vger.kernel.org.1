Return-Path: <netdev+bounces-68008-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23CDE84595C
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 14:53:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D012028E7F7
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 13:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE1455CDF9;
	Thu,  1 Feb 2024 13:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dlhPWdiC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vKmhuTm8"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A67162142
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 13:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706795566; cv=none; b=J8V+ZhPq+thGtMofPDuycvipjPIRb/WnQtP3H5/lyZgrWiRfNZYac28K85oBouJjS46Y0kkCtH/q5Hp1rEmqH9fWIiv47sI631asDJYL1afnlKK4gvj4qIw1KRixPWNiXgZAyhKVwqdfFE+f0bY856PW5HuPiqjBCwjpG6z3soQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706795566; c=relaxed/simple;
	bh=ZO/j1j+9+A7qCam99/oB4Ql7Kg/x1VdfoAEYRYpx2Jk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fPNKs/7fg0sIhO5EhgAxe0hTFJi2gqiMq5kSfiVKDV+boJzp6KrIRykpYGb4p2yGf9FzGsQQNmXX4UfPRoiPn/RQ59eBCxRkplbnzjv9YKAnlAKgvf8CpiPgMRPeXDd2px+rviRHXsEUuLBVOnvNGSlApDrlupOTNUgMtK+uV6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dlhPWdiC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vKmhuTm8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706795563;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OogcyfdpfTs2059FyNWKDfxdIMwy/Wf0EdjSpwPuYeE=;
	b=dlhPWdiCX0eaW2qNQyddeSpThyxY92nMpXXL/5IKXzLU3RFYpG7gCCumDyqE3HeT1unFKn
	oqBh57oY+KsFVd1TsLlBp+k14+L5qaeSCt5TRyy/AtiamWMP7N0SEkmCsz7mGSsbii19hH
	FUvOvfj4mCooZ+fcoGDjMpge1wR02I9eXF09cFWFhN/lz6SlCectKN06JdeCDED/7+2B0K
	IjLiXeqvG7+uXYg+QwiYH+9UsRNiWRHIJNhYtDNu9YJRXa36+hKnL8uFU76Em4kS1tIptw
	Vng+XGCLGA8g1Hq9rwNK1BT/DHroWg5DLKBJzuvcAjqgn+twT5S64MaPuNdKMQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706795563;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OogcyfdpfTs2059FyNWKDfxdIMwy/Wf0EdjSpwPuYeE=;
	b=vKmhuTm8LPRD4Pbbmw+xL2YJER7/u+Fy4uX1bbib+SSz36wARLM0OhQy8PeF46EpD+3lAG
	Qr/7R7IQ9Gz/aTCQ==
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Vinicius Costa Gomes
 <vinicius.gomes@intel.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH iwl-next v2] igc: Add support for LEDs on i225/i226
In-Reply-To: <3629e504-4c22-4222-b218-32c9945ff77e@lunn.ch>
References: <20240201125946.44431-1-kurt@linutronix.de>
 <3629e504-4c22-4222-b218-32c9945ff77e@lunn.ch>
Date: Thu, 01 Feb 2024 14:52:41 +0100
Message-ID: <87wmro70ly.fsf@kurt.kurt.home>
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

On Thu Feb 01 2024, Andrew Lunn wrote:
> On Thu, Feb 01, 2024 at 01:59:46PM +0100, Kurt Kanzenbach wrote:
>> Add support for LEDs on i225/i226. The LEDs can be controlled via sysfs
>> from user space using the netdev trigger. The LEDs are named as
>> igc-<bus><device>-<led> to be easily identified.
>>=20
>> Offloading link speed is supported. Other modes are simulated in software
>> by using on/off. Tested on Intel i225.
>>=20
>> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
>> ---
>>=20
>> Changes since v1:
>>=20
>>  * Add brightness_set() to allow software control (Andrew)
>>  * Remove offloading of activity, because the software control is more f=
lexible
>
> Please could you expand on that. Activity is quite expensive in
> software, since it needs to get the statistics every 50ms and then
> control the LED. So if activity can be offloaded, it should
> be. Sometimes the hardware can only offload a subset of activity
> indications, which is fine. It should implement those it can, and
> leave the rest to software.

Activity can be offloaded to HW only with Tx and Rx combined. Individual
Rx or Tx activity is not supported. But sure, when a user selects Rx and
Tx it can be offloaded, if it's too expensive doing it in software.

Thanks,
Kurt

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmW7oikTHGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzgo05EACnxY2U5Iw6L1XYr4uU+ERxEyZ6f582
8Ro2QsR+RDgq0R4mEXRM2t1bb/665o6yEqCuk/rLVK6bIigowuUtyznqkZ/bXUtr
a09pa2o8gB5skWueeTVZh2HwWrEIFuHAa2gs5kR+dokEAO4rDupGZjrX52l46I8F
6A/w51tbM5vrGqdOwsKcw+nk1BPyhd+zNHSHIJaQICx6fSQ5BwMEcijcbKa8xlyV
RhFSkFlyoESrk9oghfZUiwRHokFwmM7Z+F9GvbRzj5htCEyxZC7PhPu1Hhte3iE7
Efk4fa8lYsvrctwO+3h7CsigY7qidjO9W5tRtkUBfLA4Qy8uTk7+5YAvhGhnZOpE
d0wM7nLSjjK09DS7BVPQfQsAbGJQy/HBNt1xx3MqFFA/tnZ78pM0h9YGjw8euJxO
R1p2Cp4P8bNklmnFpAErI9hU32mGDN+7cL6/IOBvuZeXL4UX4gpuUtyoT7rmx4Fo
8pkCuIyeEM1DvrLDqfsPZOkPF/PHhieOmMwrqAVJXejdjk+YBDdSpZzfrUE6DwZs
Kd86lO/8WY4ja2PjZpuZvZDapufU/QQhLy9i6fHo/wtBhVknlV4fRa7rXp7GtvS1
huNrznEGYYFeMC6p8rbrm5sPmYjQq7KoopfA6mDWvCAS57mbx+F9fMCjvxSY+CTv
ThPsezdBBIWvrg==
=ZhtF
-----END PGP SIGNATURE-----
--=-=-=--

