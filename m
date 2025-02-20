Return-Path: <netdev+bounces-168029-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C89A3D27E
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 08:43:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3F0717626F
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 07:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 947C81E98FF;
	Thu, 20 Feb 2025 07:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DCWP6Gkj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eFtH6ofc"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9FC1E379B
	for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 07:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740037406; cv=none; b=XduoE2rLNAm1uHOxl+WTJfWVNquzk0Bfpc/NGf36Ri029KyTIc9pgkmK50JMOFlXH/Riey6iNlbELcrH88Q7x35D86+3WdAI6rzqdvZvmKynaTTlvlRgkdiOa4h/koamCExKsP7yOjH2TdGG0WCmRJ88BqbPi8QRME48pAsaQHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740037406; c=relaxed/simple;
	bh=CTz+cknRw924Sj7lk/e07hnncvFSP8juw2Kjw1on74Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lvIdM7r8VTT/XBXjQ6vvx1A+kEEiVdWLLqBDyYg7qqSnKfNYSk4ATC4BRo5A5TvAnX3TF0t2yURYiOcubUafi3ovINveTXIbDij2Av3HQBpVX4CLpl+eueK3b33lWExQRp9qEdWrX0+d7+mtopsRqOpLtwp7ZYlw/bte8aPLKVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DCWP6Gkj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eFtH6ofc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740037403;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+GUdpt8jhU+TwWR+P33hZ1i5Nhkvg3D+KzIr80lF0vg=;
	b=DCWP6Gkj2wv4t0s4z5TXd73C9Ok50CoO83r2gFBSuITxQAHohW1GiGxX+AZU+GvIMWzh9v
	GD4wMfn9Hp9HZTrnVlyYT1JVKltylsvlId9KckYzHulx5W956XZChT5tzQ15VjryIaR3Yd
	bmkm8fZfmR3/q1NYGTJee/q0icTp11JOThfFF5oeyLnPKsM3dJJEjJRvi0dkHEkOjTb09/
	9+9nZYcJp89/U+2i251lLgdvURB4U5p7czQwlf2yh8GDJeWUno1Pkt/cgvMnIeYd5DOrM4
	7d22xoXQ+vjYgdAXIx2zGx3ENhWiDCNCedHD26QGHOyUo5bWVOjMTBRK3lRU6g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740037403;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+GUdpt8jhU+TwWR+P33hZ1i5Nhkvg3D+KzIr80lF0vg=;
	b=eFtH6ofciVdzfJu35L/cYP3qLbLkSSoARAOhGOMdeqLPI2eer/Tcp2ElcbNFF+AtO2u+ps
	D994bcRrhXiU7oAQ==
To: Joe Damato <jdamato@fastly.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Gerhard Engleder <gerhard@engleder-embedded.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: Re: [PATCH iwl-next v2 2/4] igb: Link queues to NAPI instances
In-Reply-To: <Z7YbBQqT4wOtmbgC@LQ3V64L9R2>
References: <20250217-igb_irq-v2-0-4cb502049ac2@linutronix.de>
 <20250217-igb_irq-v2-2-4cb502049ac2@linutronix.de>
 <Z7T4Cpv80pWF45tc@LQ3V64L9R2> <875xl62xgy.fsf@kurt.kurt.home>
 <Z7YbBQqT4wOtmbgC@LQ3V64L9R2>
Date: Thu, 20 Feb 2025 08:43:21 +0100
Message-ID: <87eczt3vty.fsf@kurt.kurt.home>
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

On Wed Feb 19 2025, Joe Damato wrote:
> On Wed, Feb 19, 2025 at 08:41:01AM +0100, Kurt Kanzenbach wrote:
>> On Tue Feb 18 2025, Joe Damato wrote:
>> > On Mon, Feb 17, 2025 at 12:31:22PM +0100, Kurt Kanzenbach wrote:
>> >> Link queues to NAPI instances via netdev-genl API. This is required t=
o use
>> >> XDP/ZC busy polling. See commit 5ef44b3cb43b ("xsk: Bring back busy p=
olling
>> >> support") for details.
>> >>=20
>> >> This also allows users to query the info with netlink:
>> >>=20
>> >> |$ ./tools/net/ynl/pyynl/cli.py --spec Documentation/netlink/specs/ne=
tdev.yaml \
>> >> |                               --dump queue-get --json=3D'{"ifindex"=
: 2}'
>> >> |[{'id': 0, 'ifindex': 2, 'napi-id': 8201, 'type': 'rx'},
>> >> | {'id': 1, 'ifindex': 2, 'napi-id': 8202, 'type': 'rx'},
>> >> | {'id': 2, 'ifindex': 2, 'napi-id': 8203, 'type': 'rx'},
>> >> | {'id': 3, 'ifindex': 2, 'napi-id': 8204, 'type': 'rx'},
>> >> | {'id': 0, 'ifindex': 2, 'napi-id': 8201, 'type': 'tx'},
>> >> | {'id': 1, 'ifindex': 2, 'napi-id': 8202, 'type': 'tx'},
>> >> | {'id': 2, 'ifindex': 2, 'napi-id': 8203, 'type': 'tx'},
>> >> | {'id': 3, 'ifindex': 2, 'napi-id': 8204, 'type': 'tx'}]
>> >>=20
>> >> Add rtnl locking to PCI error handlers, because netif_queue_set_napi()
>> >> requires the lock held.
>> >>=20
>> >> While at __igb_open() use RCT coding style.
>> >>=20
>> >> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
>> >> ---
>> >>  drivers/net/ethernet/intel/igb/igb.h      |  2 ++
>> >>  drivers/net/ethernet/intel/igb/igb_main.c | 43 +++++++++++++++++++++=
++++++----
>> >>  drivers/net/ethernet/intel/igb/igb_xsk.c  |  2 ++
>> >>  3 files changed, 42 insertions(+), 5 deletions(-)
>> >
>> > [...]
>> >
>> >> @@ -9737,16 +9765,21 @@ static void igb_io_resume(struct pci_dev *pde=
v)
>> >>  	struct net_device *netdev =3D pci_get_drvdata(pdev);
>> >>  	struct igb_adapter *adapter =3D netdev_priv(netdev);
>> >>=20=20
>> >> +	rtnl_lock();
>> >>  	if (netif_running(netdev)) {
>> >>  		if (!test_bit(__IGB_DOWN, &adapter->state)) {
>> >>  			dev_dbg(&pdev->dev, "Resuming from non-fatal error, do nothing.\n=
");
>> >> +			rtnl_unlock();
>> >>  			return;
>> >>  		}
>> >> +
>> >>  		if (igb_up(adapter)) {
>> >>  			dev_err(&pdev->dev, "igb_up failed after reset\n");
>> >> +			rtnl_unlock();
>> >>  			return;
>> >>  		}
>> >>  	}
>> >> +	rtnl_unlock();
>> >
>> > Does RTNL need to be held when calling netif_running()? If not, you
>> > could probably reduce the size of the section under the lock a bit?
>>=20
>> All the other instances in the driver guard the netif_running(), too.
>
> OK, I spent a bit of time tracing through the paths in the igb
> source. I think the v1 feedback I sent identified all the RTNL
> paths, but:=20
>   - I am not an igb expert
>   - I don't have a device to test this on

Intel i210 is one of the supported cards by igb driver. These are
relatively cheap (20-30 Euro/$) and easy to get hands on.

>   - It is certainly possible I missed a path in my v1 analysis
>
> The above said, as far as I can tell this patch seems fine, so:
>
> Acked-by: Joe Damato <jdamato@fastly.com>

Thanks.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAme23RkTHGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzgvXLEACgiiZAfSNYnZuoEzryEsQTOC9/WhN6
nt4RQFcL/mEZ/+ONkTU1+4kB7nqCrQMbVO0GbfvWRwvxt7FQ8oRGMe64s+A9duTr
vmEjlqvRL76zsu4dPXfhKFfILKmNA3GKV7hjp+c+zUOW+ZHpUJRrTMHn8pFMyCtE
cGIyrI+CRPwd3nQtZ5nSKbyK1UjS/61il/m3FsmXIaQMWlrZcsFKxyA5Eu2ntPGF
nTxEd6vFDOCb2VYZsfRLDa24lb4Lhvw3pkd64wHyDJaN2JuotS8PpggxVOvaeHPq
gGelHpwnaVEADFuq9LnjFQ5tG/AwLaMy3lnfV7g4GSYNjJKJEgOYKKAjcYXD0THP
84beKLXuD2syGDjBMmAQkBmrTE8/SBX5/tgX9PGEup+z0E5JRzrx1ccOErKOba3x
0F6QHjb1WohZjEl/mfdKa/QIWbDY/ac1X++0ZXSkr5Bc72zCSlGeFuQIhqFeCtRp
h0g/G0uTgGZPq/+RNEaT8yQXz3EsKbAVP0j6j6G5jPcnELMASttHg4Dz+AQlwbe9
H/tbYtYcWPB3ACZcBdhs/Qx9OD53SiYdQRjZKw20/Zef/t9guERQDyTEJu5etuzv
K+VYYfz0WPe2iNpy/MKq6YY2Cz0GcHh6JKnhAW1JEJUFKU2gMGLoW9cyChNp/3NM
llPXwcxsdYafvA==
=m2YC
-----END PGP SIGNATURE-----
--=-=-=--

