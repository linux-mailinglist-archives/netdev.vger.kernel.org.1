Return-Path: <netdev+bounces-291564-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SA9PO2hOFWpMUQcAu9opvQ
	(envelope-from <netdev+bounces-291564-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 09:40:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EE8E95D1CB3
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 09:40:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EE5C2300EC43
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 07:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8F23CC7CE;
	Tue, 26 May 2026 07:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="JtjTg5IY"
X-Original-To: netdev@vger.kernel.org
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011ED3CC7C7
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 07:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779781168; cv=none; b=jz4FvpwP9Bs5Ai/tDe1MKCKtgW15bT5Hu7JELFUQyURV66PxK7BvGnRKoQwh72fQBswmpxNkqqt89Y81jJLdqz0ZE+uQ68JHdqTNoKiHi5S3dPJl4M0P1iZRjsqoj3iTtXKMK6kWD0bwPbkhrfBjDidyKAWRnMXSk/SK4gBMvms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779781168; c=relaxed/simple;
	bh=QXUB4koQJ6aAx9nBR/nI3YHGS5rYPl82ofS/Ingrzas=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bwlOifVdRpaG+2Vjm7eFXAt0ArDWkWh1GRlLvfOS6K9PYSGyNTejZZYXaWxBZ421NsCT+VdBwNZx7tFyjwNC2Oi5EjuTP2PXOLmoxGgpBBeLgifQaKCz3Abcy7oqjgi6eMHL41i2vQDov5Kufa1nPKaaflplX6ViwLLGJI5i7YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=JtjTg5IY; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Received: by dvalin.narfation.org (Postfix) id A520C1FE2A;
	Tue, 26 May 2026 07:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1779780610;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NvBuL1voqSEN0oLWaKKw+NjOufd3aAtSPxxpVUGOPIQ=;
	b=JtjTg5IY5niVsR9IQBrb0/h/cOAmb0mBqCv0HPtFh+KU4iuBaSingsT5CFBe3Zr0EqjbJ3
	1BqyK3Tmmn6iuUkfiEMxzSTNuXZ/amCyAeMiiYu8CAsEX9WI1VVu1dvu/kdjOqgpulq+8Z
	sjY1NS2arWDN7DZRWtwjRArZi5XOBno=
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org,
 Soowan Park <swan2718@snu.ac.kr>
Cc: marek.lindner@mailbox.org, sw@simonwunderlich.de, antonio@mandelbit.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, Soowan Park <swan2718@snu.ac.kr>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] batman-adv: fix DAT purge use-after-free on teardown
Date: Tue, 26 May 2026 09:30:07 +0200
Message-ID: <14018241.uLZWGnKmhe@ripper>
In-Reply-To: <20260526064835.2233822-1-swan2718@snu.ac.kr>
References: <20260526064835.2233822-1-swan2718@snu.ac.kr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3046581.e9J7NaK4W3";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[narfation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[narfation.org:s=20121];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291564-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sven@narfation.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[narfation.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,narfation.org:dkim]
X-Rspamd-Queue-Id: EE8E95D1CB3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--nextPart3046581.e9J7NaK4W3
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 26 May 2026 09:30:07 +0200
Message-ID: <14018241.uLZWGnKmhe@ripper>
In-Reply-To: <20260526064835.2233822-1-swan2718@snu.ac.kr>
References: <20260526064835.2233822-1-swan2718@snu.ac.kr>
MIME-Version: 1.0

On Tuesday, 26 May 2026 08:48:35 CEST Soowan Park wrote:
> batadv_dat_purge() is a periodic delayed work that re-queues itself via
> batadv_dat_start_timer() at the end of each run. When the mesh interface
> is torn down, batadv_dat_free() calls cancel_delayed_work_sync() to stop
> the purge work before freeing the DAT hash table.
>=20
> However, cancel_delayed_work_sync() leaves the work in an enabled state.
> If the purge work is currently executing and re-queues itself before
> cancel_delayed_work_sync() internally marks it for cancellation, the
> newly queued work escapes cancellation. This re-queued work then fires
> after batadv_dat_hash_free() has already freed the hash table but before
> the pointer is set to NULL, causing __batadv_dat_purge() to operate on a
> dangling pointer that passes the NULL check, and spin indefinitely on a
> spinlock in freed memory.


You are talking about a re-queue by batadv_dat_start_timer(). This only=20
happens when the DAT gets initialized or via the worker (batadv_dat_purge)=
=20
itself. How can the worker which is cancelled (with sync) re-queue itself?=
=20
Isn't this breaking a guarantee of cancel_delayed_work_sync() or did I=20
misunderstand this part of the documentation?


"This is cancel_work_sync() for delayed works." [1]

"Cancel work and wait for its execution to finish. This function can be use=
d=20
even if the work re-queues itself or migrates to another workqueue. On retu=
rn=20
from this function, work is guaranteed to be not pending or executing on an=
y=20
CPU as long as there aren=E2=80=99t racing enqueues." [2]

(the part "This function can be used even if the work re-queues itself" is
the important part here).


> Replace cancel_delayed_work_sync() with disable_delayed_work_sync(),
> which additionally disables the work so that any concurrent
> queue_delayed_work() call from the running batadv_dat_purge() is
> silently rejected. This guarantees no re-queued work can fire after
> disable_delayed_work_sync() returns.

I have no problem with using "disabled_*" everywhere (I even have a pending=
=20
patchset to use it - just to avoid problems with code changes in the future=
).=20
But since this is a fix which I don't get in the moment, I would like to=20
understand the problem you are describing better before applying it.

Regards,
	Sven


[1] https://www.kernel.org/doc/html/v7.0/core-api/workqueue.html#c.cancel_d=
elayed_work_sync
[2] https://www.kernel.org/doc/html/v7.0/core-api/workqueue.html#c.cancel_w=
ork_sync
--nextPart3046581.e9J7NaK4W3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCahVL/wAKCRBND3cr0xT1
y38WAPwLlc/180rzpcmO7N4qmYg2RQ8w5oxAKnvdfgyknBNaKwEA8cOumQjNSrey
d3jt9GblIoJWiBGN3V2wgfsHvDwVWAI=
=KaNu
-----END PGP SIGNATURE-----

--nextPart3046581.e9J7NaK4W3--




