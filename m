Return-Path: <netdev+bounces-163874-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B32AAA2BE5F
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 09:49:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C21AB188ABA1
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 08:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E43FB1CEE90;
	Fri,  7 Feb 2025 08:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="YEyriK5V"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389301B394E;
	Fri,  7 Feb 2025 08:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738918150; cv=none; b=RPDqY0X7ufyIFRwsn2Hjb/7f3zyFgY8M6g2+5kcROsgCX6sBrPa/HxtprDw2yd93Exii9zno66+y6etDDojlxHuwInb7YU5E2F3yGcjrxkIpF1hw/iz78DiHx6Sm14imXSH4J9RydTPH2jCqBZ1SUO+wsd3BrdsDORBOFHfNegE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738918150; c=relaxed/simple;
	bh=DaehB5s+3DapVlxbY6d6Ddob96P+2DCDzUtr8IJ4V1A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WnkAtu7RMY4xEea1j6JqYEdWZmIsu7AwCnxJlkRrJUd3t6ctliK+Igs69Dc0Wr9zCd5hzQmq3acU6C/N22uVmr57ZlNW9k0DOR2CpcTING0CH1UGPrTknUcNMZNsJ9XZQpG415RHja9JEpVk7leK3bVqFu/8WUN6aIHAUhvh4YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=YEyriK5V; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1738918146;
	bh=Fyc2Hox2s7T4XngXVpwqBNJWgDVSp3VIyMwvuKVepOs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=YEyriK5VpTI72Gwg1JywZ+voseVKaYMrEyrVSiPUVe+SjCYdHdPvMLqKd2VecHZga
	 bPyewAAWpmGVXPaXyuJ/8aHuGgknXymqJmtsfFqq8UtWP4v1GyztcvCingRwpxHp0d
	 /OwkBIv3ebBGFiZY0K7VUVGiaOF0YBNJZO58MemBEFcqw/+ace67oovWIuHgEBthFb
	 JLZtNvA5aaxPGX1vN1F4bg1aDYZUyN7H2EwbfSzmOCbpWe9CkfA0GFmv02d7wUd7uZ
	 b3rEHevE8e4GB+kkpAwHsXgLPykdsc+U6OZ0p49bbUmdQ2OQvKTc9Bx0Gn92EMqUUW
	 TN7OF80vrOzhw==
Received: from pecola.lan (unknown [159.196.93.152])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 32ACD74A66;
	Fri,  7 Feb 2025 16:49:05 +0800 (AWST)
Message-ID: <912d59eb611448ed9da16ef82b79f77d6fa0c654.camel@codeconstruct.com.au>
Subject: Re: [PATCH net-next 2/2] net: mctp: Add MCTP USB transport driver
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Matt Johnston <matt@codeconstruct.com.au>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-usb@vger.kernel.org,  Santosh Puranik <spuranik@nvidia.com>
Date: Fri, 07 Feb 2025 16:49:05 +0800
In-Reply-To: <2025020657-unsubtly-imbecile-faf4@gregkh>
References: <20250206-dev-mctp-usb-v1-0-81453fe26a61@codeconstruct.com.au>
	 <20250206-dev-mctp-usb-v1-2-81453fe26a61@codeconstruct.com.au>
	 <2025020657-unsubtly-imbecile-faf4@gregkh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Greg,

Just a check here:

> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0dev_err(&mctp_usb->usbdev->dev, "%s: urb status: %d\n"=
,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0__func=
__, status);
>=20
> This could flood the logs, are you sure you need it at dev_err()
> level?
>=20
> And __func__ is redundant, it's present in dev_*() calls already.

am I missing something then?

   [  146.130170] usb 2-1: short packet (hdr) 6

emitted from:

    dev_dbg(&mctp_usb->usbdev->dev,
            "short packet (hdr) %d\n",
            hdr->len);

Seems like we get the driver name, but not the function.

I'm happy to remove the __func__ output either way, but I will also
make the logs a little more descriptive for context, if we don't have
func data.

Cheers,


Jeremy

