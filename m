Return-Path: <netdev+bounces-49300-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 953967F1912
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 17:48:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59E0E282421
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 16:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED74E1DFFE;
	Mon, 20 Nov 2023 16:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fm9ZPrOZ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F8193
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 08:48:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700498909;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KLPyDiGqLeECXSStH2gVuJse65gqtB6W1htx28GfPLs=;
	b=fm9ZPrOZ7gEfdFEW/03nopQYxNN87tZRRykCXTxd3ocQ1fpw+AEYvyYb28UuRuSzPXvKJC
	0uQcR7ZG09S2eTTEjQPnGXnUjhXlMAIwlLuxHbedSKm8ke+2oLqa2m7kZ3fjWSnOMMp+ZQ
	iWtqn1uQHAVpwHwOSdHDLp0rdlfLHQ8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-83-kmT4iM4UOkGrFmLDW2ZkSQ-1; Mon, 20 Nov 2023 11:48:25 -0500
X-MC-Unique: kmT4iM4UOkGrFmLDW2ZkSQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C3E3C811E7D;
	Mon, 20 Nov 2023 16:48:24 +0000 (UTC)
Received: from localhost.localdomain (ovpn-0-7.rdu2.redhat.com [10.22.0.7])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 75E622026D68;
	Mon, 20 Nov 2023 16:48:23 +0000 (UTC)
Message-ID: <d089926c25a2c5e4593dbe6db9250843badc9771.camel@redhat.com>
Subject: Re: question on random MAC in usbnet
From: Dan Williams <dcbw@redhat.com>
To: David Laight <David.Laight@ACULAB.COM>, =?ISO-8859-1?Q?=27Bj=F8rn?=
 Mork' <bjorn@mork.no>, Oliver Neukum <oneukum@suse.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, USB list
	 <linux-usb@vger.kernel.org>
Date: Mon, 20 Nov 2023 10:48:22 -0600
In-Reply-To: <64dfec9e75a744cf8e7f50807140ba9a@AcuMS.aculab.com>
References: <53b66aee-c4ad-4aec-b59f-94649323bcd6@suse.com>
	 <87zfzeexy8.fsf@miraculix.mork.no>
	 <64dfec9e75a744cf8e7f50807140ba9a@AcuMS.aculab.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

On Sun, 2023-11-19 at 11:09 +0000, David Laight wrote:
> From: Bj=C3=B8rn Mork
> > Sent: 16 November 2023 11:32
> ...
> > > Do you think that behavior should be changed to using
> > > a separate random MAC for each device that requires it?
> >=20
> > I'm in favour.
> >=20
> > I could be wrong, but I don't expect anything to break if we did
> > that.
> > The current static address comes from eth_random_addr() in any
> > case, so
> > the end result as seen from the mini drivers should be identical.=C2=A0
> > The
> > difference will be seen in userspace and surrounding equipment, And
> > those should be for the better.
>=20
> It might cause grief when a USB device 'bounces' [1].
> At the moment it will pick up the same 'random' MAC address.
> But afterwards it will change.

Can that be achieved with userspace helpers too? They can match against
USB device details (or just use a static MAC for everything like the
driver does today) and set that on the device before anything else in
userspace starts using it.

Dan

>=20
> So you might want to save the MAC on device removal and
> re-use it on the next insert.
>=20
> [1] We ended up putting the USB interface inside a 'bond'
> in order to stop the interface everything was using
> randomly disappearing due to common-mode noise on the
> USB data lines causing a disconnect.
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0David
>=20
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes,
> MK1 1PT, UK
> Registration No: 1397386 (Wales)


