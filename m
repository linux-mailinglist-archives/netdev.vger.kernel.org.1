Return-Path: <netdev+bounces-165722-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B0AA333EF
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 01:21:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 315651679C6
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 00:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8BB1EB39;
	Thu, 13 Feb 2025 00:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="jtht8LwA"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4806B8BEE;
	Thu, 13 Feb 2025 00:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739406069; cv=none; b=ZNy5nzw7JqIRkldd00XK8TneesPviCN/Ygg3p9O9v4oFNQZfRTkWsmghx6wOLmb91AGUdII2UeeEt79tSXzj5sasgk4lE4lb1R18VwvAXtXwm+SNNXsKQxukK+Ak8+u88PtDSWrW+qvkID4xR2ugTXjkcCdaVVjsG9nL1QZJ+4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739406069; c=relaxed/simple;
	bh=jnRRalYsfx7z1FMzhIoHU7Ms/KER3HC5c+11l6mllmM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DVDY1EXriTzL1wJDTgGL/jGnkS5RZaUupEgScWGDXwMHFo0P4NJmeLMW/+sq2XH3quYWVUkyiMzFk5WGDCC+fCr0oUDn+96sPMuFlxvGGJ7iStpoid/AdqADIRBPLOfuUvH3PyUdXqUH3wtvfMSG9nG3j5omAC6rmrQRuru9Zec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=jtht8LwA; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1739406062;
	bh=jnRRalYsfx7z1FMzhIoHU7Ms/KER3HC5c+11l6mllmM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=jtht8LwAMfpecc9QULdps43dmB2r9suxd0Al+T+TcRwf+jWzxNINzQjWb7ANfiPym
	 nYWEb3NrG5KPb7Nq/hEZUHiQsJX6ZOQWZNrqslozedBLb6+RlwoPj9rdp1UnhU3+RX
	 MBZqp9p8n3mTFAiW2svDTgNF2e2h8/A7grImi4ukZ3O+AFOLkEmTmMhNH5kGOVgrSS
	 Lw0YoAVJOYKHd0egB4JEn/vQjZns5tY2kDJDn224NuWa/pMlrfRWQYl0cqtF+F1wit
	 /2bJhstEdhGGsG5HagLr4OSVsFV7hnzcsBXe339aFQjMC0wat3wyyaFgAHQQ1/qDb8
	 nsAGBIjOKWvoQ==
Received: from [192.168.68.112] (203-173-7-184.dyn.iinet.net.au [203.173.7.184])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 880B57576E;
	Thu, 13 Feb 2025 08:20:59 +0800 (AWST)
Message-ID: <f649fc0f8491ab666b3c10f74e3dc18da6c20f0a.camel@codeconstruct.com.au>
Subject: Re: [PATCH] soc: aspeed: Add NULL pointer check in
 aspeed_lpc_enable_snoop()
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Chenyuan Yang <chenyuan0y@gmail.com>, joel@jms.id.au, 
	richardcochran@gmail.com
Cc: linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Date: Thu, 13 Feb 2025 10:50:59 +1030
In-Reply-To: <20250212212556.2667-1-chenyuan0y@gmail.com>
References: <20250212212556.2667-1-chenyuan0y@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Chenyuan,

On Wed, 2025-02-12 at 15:25 -0600, Chenyuan Yang wrote:
> lpc_snoop->chan[channel].miscdev.name could be NULL, thus,
> a pointer check is added to prevent potential NULL pointer
> dereference.
> This is similar to the fix in commit 3027e7b15b02
> ("ice: Fix some null pointer dereference issues in ice_ptp.c").
>=20
> This issue is found by our static analysis tool.
>=20
> Signed-off-by: Chenyuan Yang <chenyuan0y@gmail.com>
> ---
> =C2=A0drivers/soc/aspeed/aspeed-lpc-snoop.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/soc/aspeed/aspeed-lpc-snoop.c
> b/drivers/soc/aspeed/aspeed-lpc-snoop.c
> index 9ab5ba9cf1d6..376b3a910797 100644
> --- a/drivers/soc/aspeed/aspeed-lpc-snoop.c
> +++ b/drivers/soc/aspeed/aspeed-lpc-snoop.c
> @@ -200,6 +200,8 @@ static int aspeed_lpc_enable_snoop(struct
> aspeed_lpc_snoop *lpc_snoop,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0lpc_snoop->chan[channel].=
miscdev.minor =3D MISC_DYNAMIC_MINOR;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0lpc_snoop->chan[channel].=
miscdev.name =3D
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0devm_kasprintf(dev, GFP_KERNEL, "%s%d", DEVICE_NAME=
,
> channel);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!lpc_snoop->chan[channel].=
miscdev.name)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0return -ENOMEM;

This introduces yet another place where the driver leaks resources in
an error path (in this case, the channel kfifo). The misc device also
gets leaked later on. It would be nice to address those first so that
handling this error can take the appropriate cleanup path.

Andrew

