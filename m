Return-Path: <netdev+bounces-219420-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06506B412F2
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 05:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A30851B633E7
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 03:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C92651DE4CE;
	Wed,  3 Sep 2025 03:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="Icy85zbs"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5EB542048;
	Wed,  3 Sep 2025 03:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756870295; cv=none; b=TCIG0brfgCUdjW5MaQ+QTySEX3C0QmsF4VQDgPHsnCuVtcNWshQYpMlAHlv0R8HZzr9wR9YQBEctkprfOOW7AuIapEhzNdpG17k1w4i7lz1KR+eDWCRDrGuMj2RPNlbIEEwvuEtmngFSJHwl/UQ6ms6PjZRnWRcnaNq7W121d2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756870295; c=relaxed/simple;
	bh=4d9mLeW3Q+EUZn/A4+IBvHiKSklhOVboTTlUHZHeDG4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RnoyzgZeyM1l/5vAtILTB9dWkBU+kjVxh9I15hz8ZpG3uttoRgvmLwwQte5oRsPD3/7919CUQYFzXqsvzRN4vaw7ZJ+kK9SMcISQqkPRGVoY6JanbBl9QDGX0Vc+syk8Hz8q1mSyeRi/ku/Z1SI6HRxNCYr9DWiEOMCvNPenln8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=Icy85zbs; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1756870291;
	bh=oVaQkSdSvcCdDKN3m7ueTdePXOwfRyJ398Y5h6mLEpo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Icy85zbsNn3V5cPMdb3x6rJpqF01YsmfFsDV6WhLKau5qsl1F1JaifyKC76k8RIEV
	 /XxZWidYP/y2VL6QnstbUHHUr6H4ZEye8i3NEEDgntM4cK/CUtyMgaUQVMx1GicytA
	 Q1KyjQdHFeZhtVBZa2MORbonGYMgO9bLl+2aLRlrsSPIcRZUOvS+EUaI8x93z96VQ9
	 UTEAVypj2gBJCNkvr15zILIyalt/ODyKP7jpnoL/1eUiKew+xhj/hTRbU8Tlf2RZAJ
	 HcEbPLgC73WbsW61Aoo406ccvX6glLnTHBFxjhCTfM8h5OAJaZ1AHCQcuVyKdklrca
	 rTAyArEe7ZHTQ==
Received: from pecola.lan (unknown [159.196.93.152])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 5930369374;
	Wed,  3 Sep 2025 11:31:30 +0800 (AWST)
Message-ID: <a0be916bc2e1736279362b91dbda932f60ac378c.camel@codeconstruct.com.au>
Subject: Re: [PATCH net-next v27 1/1] mctp pcc: Implement MCTP over PCC
 Transport
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: Adam Young <admiyo@amperemail.onmicrosoft.com>, Adam Young
 <admiyo@os.amperecomputing.com>, Matt Johnston <matt@codeconstruct.com.au>,
  Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Sudeep Holla
	 <sudeep.holla@arm.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Huisong Li <lihuisong@huawei.com>
Date: Wed, 03 Sep 2025 11:31:30 +0800
In-Reply-To: <958f555a-1187-44ef-95df-c93474888208@amperemail.onmicrosoft.com>
References: <20250828043331.247636-1-admiyo@os.amperecomputing.com>
	 <20250828043331.247636-2-admiyo@os.amperecomputing.com>
	 <eb156195ce9a0f9c0f2c6bc46c7dcdaf6e83c96d.camel@codeconstruct.com.au>
	 <e28eeb4f-98a4-4db6-af96-c576019d3af1@amperemail.onmicrosoft.com>
	 <c22e5f4dc6d496cec2c5645eac5f43aa448d0c48.camel@codeconstruct.com.au>
	 <3d30c216-e49e-4d85-8f1b-581306033909@amperemail.onmicrosoft.com>
	 <958f555a-1187-44ef-95df-c93474888208@amperemail.onmicrosoft.com>
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

> Without the wrapping I get:
> WARNING: Violation(s) in mctp-pcc.c
> Line 275
> =C2=A0=C2=A0=C2=A0=C2=A0 struct mctp_pcc_ndev *mctp_pcc_ndev =3D netdev_p=
riv(ndev);
> =C2=A0=C2=A0=C2=A0=C2=A0 struct mctp_pcc_mailbox *outbox =3D &mctp_pcc_nd=
ev->outbox;
>=20
> I could move the initialization of outbox, but that seems wrong. The=20
> wrapping is the least bad option here.

You're kind-of tricking your RCT checker there, by introducing this
unnecessary wrap - and the results are not RCT. I wouldn't call that the
best option.

The netdev docs say this:

    If there are dependencies between the variables preventing the ordering
    move the initialization out of line.

But I think this is a fairly legitimate case of breaking RCT for better
readability, and preserving variable-initiness. We have exactly this,
intentionally, in existing code, eg.:

    static void mctp_usb_out_complete(struct urb *urb)
    {
            struct sk_buff *skb =3D urb->context;
            struct net_device *netdev =3D skb->dev;
            int status;

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/dri=
vers/net/mctp/mctp-usb.c#n38

- which triggers no checkpatch/NIPA warnings.

The wrapping in the middle of declarations seem odd for a non-80-col
line.

I would suggest either out-of-line, or slightly-broken RCT, over the
checker-workaround format. However, I would not reject a patch on this
choice of style alone :D

Cheers,


Jeremy

