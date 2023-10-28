Return-Path: <netdev+bounces-44997-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65CA27DA656
	for <lists+netdev@lfdr.de>; Sat, 28 Oct 2023 12:09:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D3011C209CA
	for <lists+netdev@lfdr.de>; Sat, 28 Oct 2023 10:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45D96D295;
	Sat, 28 Oct 2023 10:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IitLcnK5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="U5qWYXKZ"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E335128F4
	for <netdev@vger.kernel.org>; Sat, 28 Oct 2023 10:09:22 +0000 (UTC)
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 501A9E5
	for <netdev@vger.kernel.org>; Sat, 28 Oct 2023 03:09:21 -0700 (PDT)
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1698487759;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/eThjMyxxADdAuiED1QlrJIwp0kdinX2KFks4H+LMO8=;
	b=IitLcnK5iA+9pdX0bTbNhXSOfEwt4duFlbgW75If/Nnb+AGY6uz6QuXtA1o3YX7aJ47JO4
	cUJQLcenamKIGTKQwbZnuKoS3acgwsSeBYdfpZAYkpcicc+A1T4aEgl0u0RrITfEjhizuH
	+74kRgcgsLngkWWxgQC7GreE7XJT6fG40NRId1Mm6rgFSDK+dQ9IlIi3aWRh+eA0E6fJ7f
	9+CnBKRp6K94x5D/8k1YipCHSwuxdoSGQ/1kyb9hsZJrNSE/mcXaiYXXhmqqvIwRgbhmad
	emWNzl3/7h0M3Cs9efn3T54IFdOaWUvRKwAgHA7y6acbfUiAkVCJsoiF6u4Eig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1698487759;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/eThjMyxxADdAuiED1QlrJIwp0kdinX2KFks4H+LMO8=;
	b=U5qWYXKZPyXkI4oz5fZWwmseutH+AUUlMFVPqkxH2AC0DFbySm58Q7F9084jE/H11o/bbH
	pl1Ar71NwqpHKTCQ==
To: Florian Bezdeka <florian.bezdeka@siemens.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH net-next] net/core: Enable socket busy polling on -RT
In-Reply-To: <d085757ed5607e82b1cd09d10d4c9f73bbdf3154.camel@siemens.com>
References: <20230523111518.21512-1-kurt@linutronix.de>
 <d085757ed5607e82b1cd09d10d4c9f73bbdf3154.camel@siemens.com>
Date: Sat, 28 Oct 2023 12:09:18 +0200
Message-ID: <87zg033vox.fsf@kurt>
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

Hi Florian,

On Fri Oct 27 2023, Florian Bezdeka wrote:
> On Tue, 2023-05-23 at 13:15 +0200, Kurt Kanzenbach wrote:
>> Busy polling is currently not allowed on PREEMPT_RT, because it disables
>> preemption while invoking the NAPI callback. It is not possible to acqui=
re
>> sleeping locks with disabled preemption. For details see commit
>> 20ab39d13e2e ("net/core: disable NET_RX_BUSY_POLL on PREEMPT_RT").
>
> Is that something that we could consider as Bug-Fix for 6.1 and request
> a backport, or would you consider that as new feature?

IMO it is in category "never worked". Hence it is not stable material.

>
>>=20
>> However, strict cyclic and/or low latency network applications may prefe=
r busy
>> polling e.g., using AF_XDP instead of interrupt driven communication.
>>=20
>> The preempt_disable() is used in order to prevent the poll_owner and NAP=
I owner
>> to be preempted while owning the resource to ensure progress. Netpoll pe=
rforms
>> busy polling in order to acquire the lock. NAPI is locked by setting the
>> NAPIF_STATE_SCHED flag. There is no busy polling if the flag is set and =
the
>> "owner" is preempted. Worst case is that the task owning NAPI gets preem=
pted and
>> NAPI processing stalls.  This is can be prevented by properly prioritisi=
ng the
>> tasks within the system.
>>=20
>> Allow RX_BUSY_POLL on PREEMPT_RT if NETPOLL is disabled. Don't disable
>> preemption on PREEMPT_RT within the busy poll loop.
>>=20
>> Tested on x86 hardware with v6.1-RT and v6.3-RT on Intel i225 (igc) with
>> AF_XDP/ZC sockets configured to run in busy polling mode.
>
> That is exactly our use case as well and we would like to have it in
> 6.1. Any (technical) reasons that prevent a backport?

There is no technical reason which prevents a backport to v6.1. In fact,
we're using this with v6.1-RT LTS.

Thanks,
Kurt

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmU83c4THGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzgsZ4EACs8uV1M7Ek6AH0iXDAg2zq/eFoVUOl
zfSOVQtix5yDRKJROJraM65htBJOoOJjRpZMs9GHSYRq7Nod3+UdDHZWWyc5C3ag
WMUZGBR4Ur2jzxiE7tzgy+X4FZpC7WIRqC7v6N8C22iXZArBbb+D2t2B00X7L/Tw
JGUJpiTGfupl/GvxlpjFnSbrCRyDwAW7mWqSUANvviswnNDmWFuKqviu+d3RzB99
R7Nv2NSSl8AZg6OY3CGFntE9o9A6da/nw6npj2b+qTvgezrQ+981/AAusl7ZWzih
kokw18eJUYTRpmk8rzE6Xaek0GpxObIuEMtfvdx1rMocmPYeaLZyz1uZMaFu0Lok
lVi+7IdysELWS6Gs6cuzIWrkLLBREjUxmNPeoCHUutJh+q/dbq+EV+2JGMHr3LnG
d/XiCHW8XeLPq7XVlUd0Ayu1bDtRQWHvsqhTQUaWfKy/BmqhqR4PDSALu3fNLKq9
n3yVQCt0t2WTKXnntXDV7Rlr1KOpJDMnsdagxmSZcrke3PSdhjHkemJsyUR8YIY7
hpfK4Dczjd1wCiiEgTN8UrUkirsEJMe+YTUFc/HW1RxU+PlI9XUQE25cT/FnqiRK
Jqe3o7vd/yKc5JiLuEFSq02ACYlf8COJX2YXk9ZykjUVjBrgXceM99gTb7dMZdum
5bRUQs688uLQAA==
=Z/FS
-----END PGP SIGNATURE-----
--=-=-=--

