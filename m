Return-Path: <netdev+bounces-207694-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E0B2B08454
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 07:38:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D9721A6519D
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 05:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66E54205E25;
	Thu, 17 Jul 2025 05:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="KPRJ2h0d"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD3B2AD16;
	Thu, 17 Jul 2025 05:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752730671; cv=none; b=cxNDLcD2fgh0D/FQF4qeqcnl+ruGZHVmmzsg36c7XyFBOJozVOJZcJ5pZQtL26ZeazW6VhPt0IBqY3inJ/SY7fPuYNcrKqFzKK6GNRunSVl005zw35gNKjeEt2La81zCDoN1LluT46PYlcFtIpYXqvPsqtI7lgje8pvCr0XNsdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752730671; c=relaxed/simple;
	bh=3r70ETmS7qEotHNsSCUihe0OJebvz7GjYPpeM9H9tvY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FEHK49reiPVZtvSeU92UqOrzEWMjdP2CGTAYshBFNiVc1qwN6GQDJv9Li2pggAbF8SmyopqtYEl5UXEAeem7oUZwIS9SV+W+G/acHJKHCKtyGjHApZZ85q5nspeWZIXcnAWv7RturFOc6SIYgdQ5i2qRzdAjWKoayovsDN1zJwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=KPRJ2h0d; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1752730660;
	bh=3r70ETmS7qEotHNsSCUihe0OJebvz7GjYPpeM9H9tvY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=KPRJ2h0d7w4TCaXJ/sxtIAjD5aXUGUBVp9kksarL5hjPdcZeso4R8sSoBeMXjbT1e
	 NqWtZFQlkPl65EJbeIvVQJrSCDe4eZYbW+pPDhJHXcEzKXVSAyQm+NHkcvazA4tZS9
	 qyygjEmAuSLzx25H4PUKI36kQPAoot5sXVphVD8kT9oVwEAdQFumN62LIe4cm2ASXS
	 XOiQZ5+ZvUuLohYJgKVXNg29TeFAVeuCFAC9GU4FqymszjIbbs5m2Xe9+UIUVr7AGz
	 uDTuZ9QXjhtB/dgbodHbR0q6EPya+t5J832sky5+9uxaq/BbYVNuMjQ8UrV/AMU/qr
	 85FbMbjn758mg==
Received: from [192.168.72.164] (210-10-213-150.per.static-ipl.aapt.com.au [210.10.213.150])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 8D85167B49;
	Thu, 17 Jul 2025 13:37:39 +0800 (AWST)
Message-ID: <7e8f741b24b1426ae71171dff253921315668bf1.camel@codeconstruct.com.au>
Subject: Re: [PATCH] net: mctp: Add MCTP PCIe VDM transport driver
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: YH Chung <yh_chung@aspeedtech.com>, "matt@codeconstruct.com.au"
 <matt@codeconstruct.com.au>, "andrew+netdev@lunn.ch"
 <andrew+netdev@lunn.ch>,  "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,  "kuba@kernel.org"
 <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, BMC-SW
 <BMC-SW@aspeedtech.com>
Cc: Khang D Nguyen <khangng@amperemail.onmicrosoft.com>
Date: Thu, 17 Jul 2025 13:37:39 +0800
In-Reply-To: <SEZPR06MB5763AD0FC90DD6AF334555DA9051A@SEZPR06MB5763.apcprd06.prod.outlook.com>
References: <20250714062544.2612693-1-yh_chung@aspeedtech.com>
	 <a01f2ed55c69fc22dac9c8e5c2e84b557346aa4d.camel@codeconstruct.com.au>
	 <SEZPR06MB57635C8B59C4B0C6053BC1C99054A@SEZPR06MB5763.apcprd06.prod.outlook.com>
	 <27c18b26e7de5e184245e610b456a497e717365d.camel@codeconstruct.com.au>
	 <SEZPR06MB5763AD0FC90DD6AF334555DA9051A@SEZPR06MB5763.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi YH,

> > Is that one driver (for both 2600 and 2700) or two?
> >=20
> It's written in one file to reuse common functions, but the behavior
> is slightly different depending on the hardware.

OK, but it's still the one driver (one struct platform_driver handling
multiple of_device_id matches), and there's only one instance where
you're interacting with the mctp_pcie_vdm API. So that would be a single
user of the proposed abstraction.

> > I'm still not convinced you need an abstraction layer specifically for =
VDM
> > transports, especially as you're forcing a specific driver model with t=
he deferral
> > of TX to a separate thread.
> >=20
> We followed the same implementation pattern as mctp-i2c and mctp-i3c,
> both of which also abstract the hardware layer via the existing
> i2c/i3c device interface and use a kernel thread for TX data.=20

You're combing two concepts there: the use of a workqueue for transmit,
and the use of a driver abstraction layer between the hardware and the
MCTP netdev.

Some existing MCTP transport drivers have the deferred TX via workqueue,
but none have an abstraction layer like you are proposing here.

In the case of I2C and I3C, we cannot transmit directly from the
->ndo_start_xmit() op, because i2c/i3c operations are done in a
sleepable context. Hence the requirement for the defer for those.

However, I would be surprised if transmitting via your platform PCIe VDM
interface would require blocking operations. From what I can see, it
can all be atomic for your driver. As you say:

> That said, I believe it's reasonable to remove the kernel thread and
> instead send the packet directly downward after we remove the route
> table part.
>
> Could you kindly help to share your thoughts on which approach might
> be preferable?

The direct approach would definitely be preferable, if possible.

Now, given:

 1) you don't need the routing table
 2) you probably don't need a workqueue
 3) there is only one driver using the proposed abstraction

- then it sounds like you don't need an abstraction layer at all. Just
implement your hardware driver to use the netdev operations directly, as
a self-contained drivers/net/mctp/mctp-pcie-aspeed.c.

> Would you recommend submitting both drivers together in the same patch
> series for review, or is it preferable to keep them separate?=20

I would recommend removing the abstraction altogether.

If, for some reason, we do end up needing it, I would prefer they they
be submitted together. This allows us to review against an actual
use-case.

> > OK, so we'd include the routing type in the lladdr data then.
> >=20
> Could you share if there's any preliminary prototype or idea for the
> format of the lladdr that core plans to implement, particularly
> regarding how the route type should be encoded or parsed?

Excellent question! I suspect we would want a four-byte representation,
being:

 [0]: routing type (bits 0:2, others reserved)
 [1]: segment (or 0 for non-flit mode)
 [2]: bus
 [3]: device / function

which assumes there is some value in combining formats between flit- and
non-flit modes. I am happy to adjust if there are better ideas.

Khang: any inputs from your side there?

Cheers,


Jeremy

