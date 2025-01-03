Return-Path: <netdev+bounces-154870-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50563A002C3
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 03:34:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 818AE1883D4F
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 02:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22F2535D8;
	Fri,  3 Jan 2025 02:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="fWYWv9Qm"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5824C62;
	Fri,  3 Jan 2025 02:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735871671; cv=none; b=kQifFiDVx2aewW1SF51dFtyw9Ki+MB6+NVUbB/y5LSTWDod1LcplFvn5+lItIyeND+lwyWzB1e16GgjQShhZG2henJCdCwESkO+yCVUuNyqbw2blVFsAqOSQOtE6MPsPdT2c1vVnz0d5+fBuR21A+TxsApcOZUmxX3y2pkWJqL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735871671; c=relaxed/simple;
	bh=k4DKjaxylVD2Dy0qcgZQhL7qY15Od6kWOVUFe+F3dgU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ti1I601V+fyEvhGJ1MejvNMf0e4bElU0s5zRuJ0QY3ROcOFBOaSuWhgDZiVcefppWSS7EwRqwg/JtPdwKbedc2awXgXgCQBLdnyTLoXRpxa+ZL3wo4/XyCdfBNQ2HHArqDFyAY62HG7caUeJYBtEAzpJ2wokUX5FZ5dZFp1xM2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=fWYWv9Qm; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1735871298;
	bh=npwYGYBLEEb9ljEYtqpcdKTmoM+HqCHl2SO9CVvzdW0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=fWYWv9QmlNUkvtfL1SvL7xnUf9P2n4YPSDMEyx6sQBvGYzKNaGRHffQOq/WEUUaIv
	 4sUDNYf+zS49ft2EUP7TKm+/F2Z45tJlkZn1fR4o+2+XPi4egu1p5LWoYd6jnPU2WX
	 AY3G6/BfEQL6HcXIIK6IWw1q4YRV6PNu/le5G+0F0STKYEEBsmk2qgoPaOLIlVLE47
	 aGgTlBuhKBzIXKJUICjlT9aZWUGDXsN1+bymiFTE44Nry8JBvusnOuOTRW6OYVWTJY
	 gQiYfWf3udDY8BPm5FOCvCZjY9he8t/hXRMTz/1in5PGf8TaoZ/4TYLT2rd3Pr3jWa
	 XYm4+kLN8THXA==
Received: from pecola.lan (unknown [159.196.93.152])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 9FE157028E;
	Fri,  3 Jan 2025 10:28:17 +0800 (AWST)
Message-ID: <b0e373986f3dad8e79266b09b225d126af8ae981.camel@codeconstruct.com.au>
Subject: Re: [PATCH net] mctp i3c: fix MCTP I3C driver multi-thread issue
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: Leo Yang <leo.yang.sy0@gmail.com>, matt@codeconstruct.com.au, 
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org,  pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Leo Yang <Leo-Yang@quantatw.com>
Date: Fri, 03 Jan 2025 10:28:17 +0800
In-Reply-To: <20241226025319.1724209-1-Leo-Yang@quantatw.com>
References: <20241226025319.1724209-1-Leo-Yang@quantatw.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Leo,

> We found a timeout problem with the pldm command on our system.=C2=A0 The
> reason is that the MCTP-I3C driver has a race condition when receiving
> multiple-packet messages in multi-thread, resulting in a wrong packet
> order problem.
>=20
> We identified this problem by adding a debug message to the
> mctp_i3c_read function.

Mostly out of curiosity, could you share a little detail about what you
were observing with that read behaviour? Were the IBIs being handed by
different CPUs in that case?

I assume that you were seeing the netif_rx() out of sequence with the
skbs populated from i3c_device_do_priv_xfers(), is that right?

> Therefore, we try to solve this problem by adding a mutex to the
> mctp_i3c_read function.

Just to clarify the intent here, and if I'm correct with the assumption
above, it would be good to a comment on what this lock is serialising.
If you're re-rolling with Jakub's Fixes request, can you add a comment
too? Something like:

       /* ensure that we netif_rx() in the same order as the i3c reads */
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mutex_lock(&mi->lock);

Otherwise, all looks good. Thanks for the contribution!

Cheers,


Jeremy

