Return-Path: <netdev+bounces-233083-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BC0AAC0BFAD
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 07:44:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7F3B24EC193
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 06:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7BF02D5937;
	Mon, 27 Oct 2025 06:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="jGpULUo5"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A55723A98D;
	Mon, 27 Oct 2025 06:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761547330; cv=none; b=fr4peGHvHv9dyCBdiaLCvVY4mSntOhGU8TEKjj4vngcnctIoOPm01eNQ2mFEXkdC7kWqj2Waxq3pZoV+xMe+JtVfu7bdLgtHbA89/SiBNFiSrg0ZzsQD6hEUWCSeztzG7m5sPgYtvuGLGX3eM3jgW/KLr3x9+7zMuJM4ApryabU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761547330; c=relaxed/simple;
	bh=RZMk3Z2Ubja+UgFYdzBWNWwnLSK1IfVopnzGJIdkMnk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jHaNaArwHa1+36wV3FUxQ4bJTuB+F+qUjLsCALrXGqhWqW0NRTDrzWa5SyakSRiSoc7N8+84KUV8RPf8AhQtjziGhl5mN94jDdcjgyFkxrYl4PwfSUblytZ2RGh42P5MrBR7NLVXUKBaMQzt+PnYq7MS9c9Ij9xuAsd2lLO/eeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=jGpULUo5; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1761547320;
	bh=RZMk3Z2Ubja+UgFYdzBWNWwnLSK1IfVopnzGJIdkMnk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=jGpULUo5EaxMyyCKOSxYmVzFiHtShL38jAazQIawldmhhLnDD3nWcUIR8r0KB8iy9
	 XMi69c1oW+dkz6cxySX0NsVyW9iZiO+xNNX0msK2N4DUNBGP8Ge8x1uk1/Do3Gk9cy
	 Nl9DoPY1QQyNCLRGwcvpKQ1Ssl5gmy20t2X3BtgFdYWWMODHw0TJZjxYJ6+Q0lLCAM
	 ILkD8qhkshSLt+mof1iLUdlvexR1BVsaX4Umoe2wfNI5kxc4LPxZ1qi2Z9nrr7g8w3
	 lNKPwbmcRLdrcOnzISMvXM5Hi6YEOipAmNBc/qwMvInanMmuBgY/PwuxzvXI+I9RcH
	 PqRR5BQYpjS/w==
Received: from [192.168.72.160] (210-10-213-150.per.static-ipl.aapt.com.au [210.10.213.150])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 8CBF9641F5;
	Mon, 27 Oct 2025 14:41:59 +0800 (AWST)
Message-ID: <a24255faaf750bad30adefa24b510d0ccbaf37b0.camel@codeconstruct.com.au>
Subject: Re: [PATCH v2] net: mctp: Fix tx queue stall
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: Jinliang Wang <jinliangw@google.com>, Matt Johnston
	 <matt@codeconstruct.com.au>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 linux-kernel@vger.kernel.org
Date: Mon, 27 Oct 2025 14:41:59 +0800
In-Reply-To: <20251025054452.1220262-1-jinliangw@google.com>
References: <20251025053048.1215109-1-jinliangw@google.com>
	 <20251025054452.1220262-1-jinliangw@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Jinliang,

Thanks for the fix! A couple of comments on the metadata:

> Subject: [PATCH v2] net: mctp: Fix tx queue stall

You'll want to indicate that this is for net rather than net-next in
the subject prefix, so:

> Subject: [PATCH net v2] net: mctp: Fix tx queue stall

Then, since we're targeting net, we'll want a fixes tag too. I would
suggest:

Fixes: 0791c0327a6e ("net: mctp: Add MCTP USB transport driver")

- so we get appropriate backports. No need to reply to the original
message for subsequent versions either, a new thread is best.

Also, it's helpful to indicate changes between submitted versions,
under the '---' marker, which doesn't end up in the git commit.
Something like:

---
v3:
 - target net tree, add fixes tag

v2:
 - remove duplicate comment in commit message

---
 drivers/net/mctp/mctp-usb.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

> The tx queue can become permanently stuck in a stopped state due to a
> race condition between the URB submission path and its completion
> callback.
>=20
> The URB completion callback can run immediately after usb_submit_urb()
> returns, before the submitting function calls netif_stop_queue(). If
> this occurs, the queue state management becomes desynchronized, leading
> to a stall where the queue is never woken.
>=20
> Fix this by moving the netif_stop_queue() call to before submitting the
> URB. This closes the race window by ensuring the network stack is aware
> the queue is stopped before the URB completion can possibly run.

LGTM. With the changes above:

Acked-by: Jeremy Kerr <jk@codeconstruct.com.au>

Cheers,


Jeremy

