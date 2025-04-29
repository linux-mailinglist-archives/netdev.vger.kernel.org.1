Return-Path: <netdev+bounces-186651-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5076AA0146
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 06:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC5DF16974B
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 04:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42226270EC8;
	Tue, 29 Apr 2025 04:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="TnBwMGIW"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EAB9270EB3;
	Tue, 29 Apr 2025 04:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745899711; cv=none; b=S7UOxzciOwF2L7d9MOtR7sOyt4b6CK4PGFn4nN7cNRZFvyEHb41MHsIc/r6duaGZPhA9j3rCizDUcyUaHgtdWwkfYLbzN6rl3L9FTE0Ji49sqOiNf6mE+3bQKk19EilX79adPPhM+WlxZxHSZXQf7STfAcYL3K0L6+K+heIPYwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745899711; c=relaxed/simple;
	bh=/6SbwFGaIGJYp1bM141cJ0NASTjd0wU7ITA/Ybycy9k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=q2gyozgMyRRFMJ35dy04NDcm+IFZPceCUTfj7KPK3AjhzHPIugy0GPdq9Fc7S7R32QOpmg2Zy8S0vx87WGThOfvFmgQoJ5qWDYWEkIfRlSbLwsvHm79fLbLzRz8njAQ1TSSytNvBpxtjeEW4sP3Ix2AK66ypyb4r3EDsPvUd6po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=TnBwMGIW; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1745899706;
	bh=78fe1AmPBykWQw2YACNo5j4kpf/GLlS9wjHBhSz3CtM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=TnBwMGIWfmAkjNatWNrJfEyKsE/B773vPquIwWqDy0uRCt5xUdufK6Piw69IHSlic
	 W/gJYO3Xsi8rLkRrNctBSWgLBXq7ZnIe6tRfdgr5FGHS3eYZTzhC4XLgfVqyc6hooy
	 TPgbV1C72u2wgsekmKEq5dAKhvQkP+I9N7ZgcjANVKCuuT57CY0Z1vo/cy7HlYIFe9
	 Nsw7efjPuo+Vf/v4RRFCTkJFldd2Nu7nViM9WdLUDOPJ6asfEjqzUelb1cP2Wz4EG2
	 WI3jB6bgLL9gyswry+k5wxFt3kEwQP+CdRiR5MqQlQbYhr2wsXxjSpzl5R0HyU/x07
	 HPnGtxTCINoMQ==
Received: from [192.168.72.171] (210-10-213-150.per.static-ipl.aapt.com.au [210.10.213.150])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 117E67F93A;
	Tue, 29 Apr 2025 12:08:25 +0800 (AWST)
Message-ID: <9d62e4a57f66cc8462ee1f5ee3491d5f46c650ce.camel@codeconstruct.com.au>
Subject: Re: [PATCH net-next v20 1/1] mctp pcc: Implement MCTP over PCC
 Transport
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: Adam Young <admiyo@amperemail.onmicrosoft.com>, Jonathan Cameron
	 <Jonathan.Cameron@huawei.com>, admiyo@os.amperecomputing.com
Cc: Matt Johnston <matt@codeconstruct.com.au>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,  Sudeep Holla <sudeep.holla@arm.com>, Huisong
 Li <lihuisong@huawei.com>
Date: Tue, 29 Apr 2025 12:08:24 +0800
In-Reply-To: <a12dee5c-2d59-4941-84b5-ae8bffcedd6c@amperemail.onmicrosoft.com>
References: <20250423220142.635223-1-admiyo@os.amperecomputing.com>
	 <20250423220142.635223-2-admiyo@os.amperecomputing.com>
	 <20250424105752.00007396@huawei.com>
	 <a12dee5c-2d59-4941-84b5-ae8bffcedd6c@amperemail.onmicrosoft.com>
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
> I get a compilation error when I try that:
>=20
> drivers/net/mctp/mctp-pcc.c: In function =E2=80=98mctp_pcc_client_rx_call=
back=E2=80=99:
> drivers/net/mctp/mctp-pcc.c:80:30: error: invalid type argument of unary=
=20
> =E2=80=98*=E2=80=99 (have =E2=80=98struct mctp_pcc_hdr=E2=80=99)
> =C2=A0=C2=A0=C2=A0 80 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 sizeof(*mctp_pcc_hdr));
>=20
>=20
> Maybe a compiler flag difference?


In the rx path, `mctp_pcc_hdr` is the struct itself, just drop the
dereference for the push:

    skb_pull(skb, sizeof(mctp_pcc_hdr));

But on tx, mctp_pcc_hdr is a pointer, so:

    mctp_pcc_hdr =3D skb_push(skb, sizeof(*mctp_pcc_hdr));

Cheers,


Jeremy

