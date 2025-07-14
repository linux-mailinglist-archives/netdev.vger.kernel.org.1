Return-Path: <netdev+bounces-206585-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E68E6B03958
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 10:23:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5502E17CCBC
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 08:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C2723ABB7;
	Mon, 14 Jul 2025 08:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="afSN2k+r"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD528238C24;
	Mon, 14 Jul 2025 08:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752481323; cv=none; b=m3EG0UtZdMNlqYA3w5dEA2Vo9Tt15qtIebKjD0KyBMD0lEDGvNY4NwsVEu0Ec5K3NhwA/OzrpWxghsEdQEh4yEcJJ0DjBP2Ddvhec5KVNjRc3soi94FMeaM9qtrpOWAglfV8pQM/Gk6DC5FqP0r4cTnR9RN8st35/C+fP0d2K9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752481323; c=relaxed/simple;
	bh=bkejVvLDnniEBE/OfO+mGbvZJ0Ofy31YLZpWO7e3vLk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PBH5STwJ2nDMdaEQVCKMJM40w+hA+H1etIm0U917fvBrcvTg5+3zmFgN77gLe7TwxFekct3rjGXZt2I8MzUkX9m+zEJ9f9l5ojffKwCBBfsBtGQEF8m4zLNMW00rj6ADg8dzuR2yAQmR7AkFdHX0iPgpg/w8nIMhM1KxgZYGGcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=afSN2k+r; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1752481312;
	bh=bkejVvLDnniEBE/OfO+mGbvZJ0Ofy31YLZpWO7e3vLk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=afSN2k+rBvt490RaS2wJwSoIJEbD/JYvJeaMezWIkqVWXQQGZI7a0ijHj/I0u9TgI
	 TdBSJHkKk9PxaaVxtCpzEpSR+kmXP1UeKfgvNnZPKE5Cj3CJ21mGxBzgOm9/WVd/D4
	 831kG0qmnXglemGPXsI0Wq8Qyo/KpOrbLmwyck423bgQ0vM1lFuLGESeSqausdq2HF
	 0pVX9Nxz3YEb2exPMd9u3nKPVtgixm9qrGl3TnavQSqXAKfSqkYG9tumTNjLBc3a0B
	 /MNjKsfzIB0A4efA08AaOxElcn4ezbkgcVZcsyMvJvqQ7Rbdit+xubx+Z2I+EKcDag
	 EIQNvHN27Mvhw==
Received: from [192.168.72.164] (210-10-213-150.per.static-ipl.aapt.com.au [210.10.213.150])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 265DC6B4BE;
	Mon, 14 Jul 2025 16:21:51 +0800 (AWST)
Message-ID: <883a07de53bf3c84ce255456891133da9443d2b1.camel@codeconstruct.com.au>
Subject: Re: [PATCH net-next v22 2/2] mctp pcc: Implement MCTP over PCC
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
Date: Mon, 14 Jul 2025 16:21:50 +0800
In-Reply-To: <30bcce6d-9a50-4fb8-ab7c-8ae36eb99d74@amperemail.onmicrosoft.com>
References: <20250710191209.737167-1-admiyo@os.amperecomputing.com>
	 <20250710191209.737167-3-admiyo@os.amperecomputing.com>
	 <e64da89fdd2c72afaa62f02449db9b144e02b743.camel@codeconstruct.com.au>
	 <30bcce6d-9a50-4fb8-ab7c-8ae36eb99d74@amperemail.onmicrosoft.com>
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
> If the sk_buff allocation fails, the logic falls back to the old code,=
=20
> which passes on a null buffer. There is logic there with notifying the=
=20
> sender that I don't want to skip or modify.

OK, so this will happen if we didn't allocate a buffer in the first
place - we'd still get a completion occurring. Let me know if my
understanding is incorrect.
>=20

> > I think the issue is that the mbox API is using the void * buffer
> > as both the data to transfer, and the callback context, so we can't
> > stash useful context across the completion?
>=20
> Correct, the SK_buff is a structure=C2=A0 that points to a buffer, and
> what gets to the send_data function is the buffer itself. That buffer
> has no pointer back to the sk_buff.

OK, that's a bit unfortunate. Might be good to see if you can add a
context pointer to the mailbox request, in which you could stuff the
skb pointer. USB does this for the transfer completions: there are
members on the transfer (the struct urb) for both a context and buffer
pointer.

Of course, that is more a mailbox API change, so you may want to
consider that as a separate thing later.

> The NETDEV_TX_BUSY is correct, as it means resend the packet, and we=20
> don't have any reference to it.

OK, you may want to have the tx queue stopped at that point then, if
you have some facility to re-start it when the mailbox ring buffer has
space.

Cheers,


Jeremy

