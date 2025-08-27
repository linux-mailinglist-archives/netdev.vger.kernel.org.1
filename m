Return-Path: <netdev+bounces-217129-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A432B37718
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 03:38:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E2817C37FC
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 01:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F0531FBEA2;
	Wed, 27 Aug 2025 01:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="dWKkA+4x"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4E61F9F73;
	Wed, 27 Aug 2025 01:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756258637; cv=none; b=H32GJW+siyA8/KNXTf1j/ZrkgwcTmyp5TV0lyaF8L9K721IdHn4XFGFSniiYFV8oZagAGg5V/cdxMa6msBHmt35a7KR8qflm/6RxMYB+lYLjHKRj+rnAu0eQ4sbng4VSNxv+wQLRZOBgDRN5TA+E/nWP+cRNHIa+AjF089MlpNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756258637; c=relaxed/simple;
	bh=qieCpC4qKgHe/LUKPcyqId76dvfn1MSxURgqm1C2HYY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aCiGaIOV8S9EcGagUy+Uoq7SjhGyJe9272VZZR3vkIKf+t85MrkeHgJnAYhI+HOhYhXHbxYupJw2+EEyJLQZaZXBvrjMdQleAAcn6teVL52gPakPTOR/YfhZ2gtvzH61IDmiaiP9p3g/AusC6t7qtm5JI6Zvnju7hJkm6RTlCJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=dWKkA+4x; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1756258626;
	bh=hmEypw3ibVYz9avq0Z0wnujG0VUx9zY5LohNPbzGV8s=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=dWKkA+4xRrRfKm9DCisGrAVA1clImwiPlC878nnBOZpwFaOJvWveBz0w1JFMAE9e3
	 1OsQlJhbNAj1jDvs66Lw6e4GfWoMIrCnzkhe+SC9jdvkzEbdhiCjZWv0C80mT6PwiW
	 NFzU01KU5WKd+atsyBiCWq7kLwUymnWciJag+YCYi9F/gGRTK5vDAg9vhe7Pdmn1uN
	 W1mgT//F6/gHLOrqLo6U85p6Cg3+Xk03FPe+IdZnlQVPP2v0WSvyPzY1OBVs+oqzlc
	 Tl7Y+HVoM/70utYe1qXzZzTaK2932Lr2MoNscKNMmDRF6mIoHrq+KxGZ5id0MGMLjT
	 ieSYYsLw/cs1Q==
Received: from pecola.lan (unknown [159.196.93.152])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id DF2576B49E;
	Wed, 27 Aug 2025 09:37:05 +0800 (AWST)
Message-ID: <9b66a22a2fe689a993d9ff83baf8b7bbecbb8c90.camel@codeconstruct.com.au>
Subject: Re: [PATCH net-next v25 1/1] mctp pcc: Implement MCTP over PCC
 Transport
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: Adam Young <admiyo@amperemail.onmicrosoft.com>, 
 admiyo@os.amperecomputing.com, Matt Johnston <matt@codeconstruct.com.au>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Sudeep Holla
	 <sudeep.holla@arm.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Huisong Li <lihuisong@huawei.com>
Date: Wed, 27 Aug 2025 09:37:05 +0800
In-Reply-To: <d15313f4-46d1-4096-bdf1-783afd8e439d@amperemail.onmicrosoft.com>
References: <20250819205159.347561-1-admiyo@os.amperecomputing.com>
	 <20250819205159.347561-2-admiyo@os.amperecomputing.com>
	 <88a67cc10907926204a478c58e361cb6706a939a.camel@codeconstruct.com.au>
	 <d15313f4-46d1-4096-bdf1-783afd8e439d@amperemail.onmicrosoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Adam,

> In addition to the below comment, I am removing the additional lock on
> the skb lists and using the internal one for all operations.=C2=A0 It lea=
ds
> to leaner and cleaner code.

Ok, neat!

Just be careful with locking as you're iterating the queues. Your
current approach of doing the drain under one lock acquire is probably
the best, if you can do the same with the queue-internal locking.

> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mctp_pcc_ndev->inbox.chan-=
>rx_alloc =3D mctp_pcc_rx_alloc;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mctp_pcc_ndev->outbox.chan=
->manage_writes =3D true;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* There is no clean way t=
o pass the MTU to the callback function
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * used for registration, =
so set the values ahead of time.
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > For my own clarity, what's "the callback function used for
> > registration"?
>=20
>=20
> Actually, this is not longer true: we can do it in ndo_open, and it
> is clean.=C2=A0 Removed the comment.

OK, The current patch *does* do it in ndo_open though, hence my
confusion.

From your other reply:

> > > +static int mctp_pcc_ndo_open(struct net_device *ndev)
> > > +{
> > > +       struct mctp_pcc_ndev *mctp_pcc_ndev =3D
> > > +           netdev_priv(ndev);
> > > +       struct mctp_pcc_mailbox *outbox =3D
> > > +           &mctp_pcc_ndev->outbox;
> > > +       struct mctp_pcc_mailbox *inbox =3D
> > > +           &mctp_pcc_ndev->inbox;
> > Minor: I don't think these need wrapping?
>=20
> The outbox and inbox lines are longer than the mctp_pcc_ndev line, and
> they depend on it.  This ordering and wrapping passes the xmas  tree
> check and keeps assignment with declaration.

If you need a specific ordering for actual correctness, no need to
force that into a reverse-christmas-tree. Spacing requirements like that
are secondary.

The only remaining query I had was the TX flow control. You're returning
NETDEV_TX_BUSY while the queues are still running, so are likely to get
repeated TX in a loop there.

Cheers,


Jeremy

