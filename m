Return-Path: <netdev+bounces-175866-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D27A67CF1
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 20:19:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EDE93B22E2
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 19:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51BA31DDC21;
	Tue, 18 Mar 2025 19:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="D4/uCzke"
X-Original-To: netdev@vger.kernel.org
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53121D6193;
	Tue, 18 Mar 2025 19:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742325554; cv=pass; b=Mh7UNDrtTBpyLARbHZoplPtUi07A+AxU4PQscBVWijmfiaIoKcJtdVN23q4LbkOsnz0RYZQ5O1/o9xoQcx2zh733ZczCAXxSgap0Iy7X1gYLBh8yuF0Wm5Q2gjd6XlEymLdqGSqkcfvXxTeuchRKQkA6abAPt30eaK5y6cXCv3E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742325554; c=relaxed/simple;
	bh=KCvuZeSRzVL6HIUyVeDSxPh5Uvj6T4quooz/dGpaprI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JklutV97NrGpnrRdOcuqpVMtBS0LxGtZnYhaAKN1ERrCtxFO8U1v9B7Qu+HQpsKKTiAaMAlK8Ka9y3LcefVyjb4zMS29cLLmwAexM1dYYYeelCURqSNgm2TDDNL9Q19J6v/krOJpLP/Vk/hBlD8UL88x8WvSzHZ9mb+MGKpb5EI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=D4/uCzke; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Received: from [192.168.1.195] (unknown [IPv6:2a02:ed04:3581:2::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4ZHM8S20nzz49PyD;
	Tue, 18 Mar 2025 21:19:04 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1742325544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=T8IbGfuPNUV4MJzuWCCXErjsRG/ZPbGdqdOIvEhMFj8=;
	b=D4/uCzkejpELhm2FPfD+p4rOpS5QY5UCFc1mREJ6EABxB4PamMu6OYKDPXekYRA0ZZ32ST
	Ck1JM18GsaiI17Go/pR0c40/ZJIZuHZgxSvUoenNEBEFEq6FK9f0uPIu/KY51C4aRKigIU
	+aG4YF7T6iyz+WtE/apbjDkzvjAfo/li8OHzaV8ZnGsOQMYgX1wRPa7j6Kcb+T5e/cLtau
	hqGyTG5GxdshM2Hzr6JES0dv6RyHVnMYRZya+rzHz8pcT9Bic+KBmSZlNiBtTICXhDojRu
	ykfGr9nzsXh2ulRrHC435hfx15f3FfNmPKtwQgl9Q0TRfZYuBDg8OPhebuZZ6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1742325544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=T8IbGfuPNUV4MJzuWCCXErjsRG/ZPbGdqdOIvEhMFj8=;
	b=DKUsATf22071kMpUtHUiZjTURGB8sML3OSrIrI3gVvIlBI3++Ci7o92TJ+HtIOK6E/UbSt
	A01arzgwfAvG0I4+MrOcqDyQBNqOYQV99OMN5STs20WQLSXY6Ji6vHlt/Kxli+Z/ABaCH7
	TKpkpuyolz5H5QsOdwoUvCeUxpNJIXR1WY3aO/YXv79i1t+2c2vU5gMSr4OChWnyql0px1
	Nu1+0pO7ioEYUd/xf3fYl8LHGubF9ZbOtxqn3TgORP7Qq109oakDAf8rpSE5Ta52mq10gz
	9I/N+l0Y4f/qNx32xj0wzsPXbfRKD7zUhN8L4cNdz67+vbWHopm7hqq4ebWMGg==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1742325544; a=rsa-sha256;
	cv=none;
	b=rKmF0TLkqkgJDWzorJ5PnjKSqXUpklmmdrdcXxesEElTjC3CpZOsSGigzICsWZYSmeoHWP
	6sb8vbBz5i5TusXhvU52+W2YKaSCk8OThqjQZanczW7Vv0iPFyhQ90I89UpPLZNNdOs4dh
	OOwdbaZQMAAomoJcG12Q4pqpjxQJZSdjW8xGlcpkDZ7M0iwb2XyRBbN8glcFbP5GMxPAOx
	4h7J2Odtzc9k3nrOa1S/sHHnwj0x+BMbwYdodbzH619eiKGpK3ACIPynkHyH9Qryi7a7TQ
	Qt3fyxhqNrOWZG4QAMnUjsiJ1pY1+CZiOuifw1q5Q9zApSDonqspWXXehZd/1g==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
Message-ID: <f18907a858ff6040d53d41dafab9170a06622c1c.camel@iki.fi>
Subject: Re: [PATCH v4 0/5] net: Bluetooth: add TX timestamping for
 ISO/L2CAP/SCO
From: Pauli Virtanen <pav@iki.fi>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, netdev <netdev@vger.kernel.org>
Date: Tue, 18 Mar 2025 21:19:02 +0200
In-Reply-To: <CABBYNZJQc7x-b=_UQDjGbTVnY-iKASNzg=rTFXDRXyn_O+ohNQ@mail.gmail.com>
References: <cover.1739988644.git.pav@iki.fi>
	 <CAL+tcoAAj0p=4h+MBYaN0v-mKQLNau43Av7crF7CVXFEnVL=LQ@mail.gmail.com>
	 <CABBYNZJQc7x-b=_UQDjGbTVnY-iKASNzg=rTFXDRXyn_O+ohNQ@mail.gmail.com>
Autocrypt: addr=pav@iki.fi; prefer-encrypt=mutual;
 keydata=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
 bzyGkKh2h8XdrYhtDjw9LmrprPQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

ma, 2025-03-17 kello 13:50 -0400, Luiz Augusto von Dentz kirjoitti:
> Hi Pauli,
>=20
> On Wed, Feb 19, 2025 at 7:43=E2=80=AFPM Jason Xing <kerneljasonxing@gmail=
.com> wrote:
> >=20
> > On Thu, Feb 20, 2025 at 2:15=E2=80=AFAM Pauli Virtanen <pav@iki.fi> wro=
te:
> > >=20
> > > Add support for TX timestamping in Bluetooth ISO/L2CAP/SCO sockets.
> > >=20
> > > Add new COMPLETION timestamp type, to report a software timestamp whe=
n
> > > the hardware reports a packet completed. (Cc netdev for this)
> > >=20
> > > Previous discussions:
> > > https://lore.kernel.org/linux-bluetooth/cover.1739097311.git.pav@iki.=
fi/
> > > https://lore.kernel.org/all/6642c7f3427b5_20539c2949a@willemb.c.googl=
ers.com.notmuch/
> > > https://lore.kernel.org/all/cover.1710440392.git.pav@iki.fi/
[clip]
>
> We are sort of running out of time, if we want to be able to merge by
> the next merge window then it must be done this week.

It took a bit of time to get back to it, but v5 is sent now.

Note that it does not apply cleanly on bluetooth-next/master, as the
first commit is based on net-next since there have been some changes
there that need to be taken into account here:

commit e6116fc605574bb58c2016938ff24a7fbafe6e2a
Author: Willem de Bruijn <willemb@google.com>
Date:   Tue Feb 25 04:33:55 2025

    net: skb: free up one bit in tx_flags

commit aa290f93a4af662b8d2d9e9df65798f9f24cecf3
Author: Jason Xing <kerneljasonxing@gmail.com>
Date:   Thu Feb 20 09:29:33 2025

    net-timestamp: Prepare for isolating two modes of SO_TIMESTAMPING

--=20
Pauli Virtanen

