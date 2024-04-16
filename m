Return-Path: <netdev+bounces-88356-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E358A6D52
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 16:07:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F10F32816A6
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 14:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8767912C534;
	Tue, 16 Apr 2024 14:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vOCo3gk0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Q5IXnJrP"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C87F12C485
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 14:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713276421; cv=none; b=MyKoQx7dNRFqSEj0WH1Q8YmPxOlK+MgkGh6oq24g0PC9UZMrNG4IiwanWymntzb4vCH7KmnzlBtFfg3HWyfiQng89m5i/3zvN4bsLdaYWPSl3mch3CQ3pUyOIJBZWF0fUBFoBj8V+RsdiOiihprl99+8Lni/jEu598VzEnotSOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713276421; c=relaxed/simple;
	bh=sx7r29DmXh6gGC9ku7ZNaJ9vE6D8AbIaHgHm/uwwXFs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=o75wBNBSs+mM9vyYvIFE1iD9SzOHajWGJKlz1tDeTRKKi5YVgtrEcpmdIHQfFT6sW391sv+ejQmk+kJ5Xk1JacAkFkGAl6hkifGSMsivU/uoySoMlH7gJgk8ruHiRfTXD9YpjpFhA0G6Lb2DnPJvl+Pa6oa9za9zzd1be33RAXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vOCo3gk0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Q5IXnJrP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713276411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+J9P2ULNkyUwgvpEdf0Gep794Rg7+MINnBkDkinXNUQ=;
	b=vOCo3gk03i2s2/ACNfZ8RH1vBt+vz15GsQrmoXKgT8pyqSLqueMk+ZRIcr8Gj1uJVtRINx
	08HYPThnstuT6SYiT+pePQSGVLAYvlQWwY4FgTr0QXBy4Y6U4WPuCjd5XNapR6ESLVOOCQ
	e/mzORvCSzpJRyMA7+G943QwtmmxZazNqs/5jgj8LffGfMAa4DaTwr8HxHctya489LcX+q
	eWiXbyPjFr8vZUfUdnuNTCru6fNaDkeMHjvJ5v2AF5z5+3Ke9ZIKihSzsVsTTgIaDMdJHv
	PHC2/p5KmRhFRth3YzikjR7vIbBsLmABk6MtVD01tml3u2quHDMSeS1XHkfi4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713276411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+J9P2ULNkyUwgvpEdf0Gep794Rg7+MINnBkDkinXNUQ=;
	b=Q5IXnJrP2NxOay1V1W+0xr3gFUCCVYBCJO7FA8D6FmJCbXxBwXP0mkWoyZgkY8RKkA/KQz
	5GezuL39/ULv6qCA==
To: Lukas Wunner <lukas@wunner.de>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Jesse Brandeburg
 <jesse.brandeburg@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, Roman Lozko
 <lozko.roma@gmail.com>, Heiner Kallweit <hkallweit1@gmail.com>, Andrew
 Lunn <andrew@lunn.ch>, Sasha Neftin <sasha.neftin@intel.com>
Subject: Re: [PATCH net] igc: Fix LED-related deadlock on driver unbind
In-Reply-To: <2f1be6b1cf2b3346929b0049f2ac7d7d79acb5c9.1713188539.git.lukas@wunner.de>
References: <2f1be6b1cf2b3346929b0049f2ac7d7d79acb5c9.1713188539.git.lukas@wunner.de>
Date: Tue, 16 Apr 2024 16:06:49 +0200
Message-ID: <87plupe70m.fsf@kurt.kurt.home>
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

On Mon Apr 15 2024, Lukas Wunner wrote:
> Roman reports a deadlock on unplug of a Thunderbolt docking station
> containing an Intel I225 Ethernet adapter.
>
> The root cause is that led_classdev's for LEDs on the adapter are
> registered such that they're device-managed by the netdev.  That
> results in recursive acquisition of the rtnl_lock() mutex on unplug:
>
> When the driver calls unregister_netdev(), it acquires rtnl_lock(),
> then frees the device-managed resources.  Upon unregistering the LEDs,
> netdev_trig_deactivate() invokes unregister_netdevice_notifier(),
> which tries to acquire rtnl_lock() again.
>
> Avoid by using non-device-managed LED registration.
>
> Stack trace for posterity:
>
>   schedule+0x6e/0xf0
>   schedule_preempt_disabled+0x15/0x20
>   __mutex_lock+0x2a0/0x750
>   unregister_netdevice_notifier+0x40/0x150
>   netdev_trig_deactivate+0x1f/0x60 [ledtrig_netdev]
>   led_trigger_set+0x102/0x330
>   led_classdev_unregister+0x4b/0x110
>   release_nodes+0x3d/0xb0
>   devres_release_all+0x8b/0xc0
>   device_del+0x34f/0x3c0
>   unregister_netdevice_many_notify+0x80b/0xaf0
>   unregister_netdev+0x7c/0xd0
>   igc_remove+0xd8/0x1e0 [igc]
>   pci_device_remove+0x3f/0xb0
>
> Fixes: ea578703b03d ("igc: Add support for LEDs on i225/i226")
> Reported-by: Roman Lozko <lozko.roma@gmail.com>
> Closes: https://lore.kernel.org/r/CAEhC_B=ksywxCG_+aQqXUrGEgKq+4mqnSV8EBHOKbC3-Obj9+Q@mail.gmail.com/
> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>

I think, the first SoB has to be yours, because you are the patch
author. In fact, my SoB is not required at all.

However, feel free to add:

Reviewed-by: Kurt Kanzenbach <kurt@linutronix.de>
Tested-by: Kurt Kanzenbach <kurt@linutronix.de> # Intel i225

Thanks,
Kurt

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmYehfkTHGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzgphAD/9ltXyXjzN1q3F45uzk/J9xVD1M+yCM
lppwpQGGZrFVuI0wjOnTYdmGXMUC6xD+bUrm6+21zo+V6xd06Kvq1igO/mUDU/dz
7fAlEWKWjB0cg7QG1g0oC09xJSviTOoTXT9DDktsR9EaEVFz89UzLysYcdoPeTVa
m3pP8NSt9fhzCTkZbx09wAZeOCJrQLORfA3LMKaLnbh3JX12Slmh80qyrP7QtYcQ
oGT3KCURaycGzDh3Pa8eZSwx70Xnncx4+/Q2DyYMrlUoMHorJ0pIrxiGI0dnXm1L
NWF/3zhCCwNMqynmrbDK+WvWpwWhx/oKE++x3snZKIEZ8T1CZNke5pjMW8ysPSp2
ZnPYVE9+QdjzKnW7JpcEJQVDAuB4Id5D2qhNR02DJdXgu7ZpbJn2nm+gKuCPWMJF
pvVYktL8heufp/eae4nTTG/TV5I1qjtJEgTafFvk1mAaBJ8bOtn7AfPoh8jttrjj
HRRjsoZjITAu+oBPVZTATN5mM61I318IX/8KsKOgVQq35kZa8H2Q3YSATFw0NBHl
rUrMDDp8e5y0cdk2rFtGTqUZcIj6RPO+xR4HG7h/ZH9Zuqr6B/9Quo+v97uD8GZk
1JPDGqHErU/DD5LJjlEZSkQWAtBVQ2iMDEFYlnBWHU21qC+cqQrh9HWtBCw/KZJj
mLc1tBCTMJu3+w==
=pxWU
-----END PGP SIGNATURE-----
--=-=-=--

