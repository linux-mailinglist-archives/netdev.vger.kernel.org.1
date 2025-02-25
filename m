Return-Path: <netdev+bounces-169369-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EF752A43938
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 10:20:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62DB07A05CB
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 09:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92323263C7C;
	Tue, 25 Feb 2025 09:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MsCAJDir"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5EEB263C77
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 09:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740474911; cv=none; b=bQZ2WOmEoh+DPu8E/zXIboQ/zsA8KppUns0SWebYQ3fgT2eZxzW3MPN8oYu4x9N36rY7UXGMAtHajkkfAMaWkW8KK1uouJl1eWCE5AogAUsoT9fbM/NJFAJ/XXjys0JSavAxRnCOzjAyLnC/y78GKm54YoDVeDxcv42Ng7Sv4TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740474911; c=relaxed/simple;
	bh=fHGpW80fYUJHEoegs7hdiagul4opbNfZJrlcvH16f+k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=muPmt4Zl6912Uo8Be0Z/H+sISJ4n/hZvNSsAjiA0ac4Qn1xNz2RXZFvBqPOQPwkwXgGw+R0DXxpQBgZT6EBxxa9kE3PhsO4WNIBpMoHOQO7KJk2d9ZByx4iyQGuL8eMJvLIp6rGDGyh7Tegui1aQpi/hCBbJqPouz20xwdKG6zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MsCAJDir; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740474908;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5mY0Y8NDtCq9U6kZXa7z7cTNd5hZ8Jf2lYO6g2P04nc=;
	b=MsCAJDira7fBdWqqIboShoJUxzfqpXAG7ElCMPF/xP2oRROfTeO3MrdvKzSEmcNVB576LF
	znW5PjWuLu9gBINYkw8KiNGv/0zkOqEl6ed+oS8hCBN1duR3R9mR6ygeaGIGYHQTScPi3n
	NgVP9SpcFNZ0m7n8YBAyhKdNYP0idQc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-56-AKSD8451PT2MzGxO4odTjA-1; Tue, 25 Feb 2025 04:15:07 -0500
X-MC-Unique: AKSD8451PT2MzGxO4odTjA-1
X-Mimecast-MFC-AGG-ID: AKSD8451PT2MzGxO4odTjA_1740474906
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4398a60b61fso26978425e9.0
        for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 01:15:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740474906; x=1741079706;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5mY0Y8NDtCq9U6kZXa7z7cTNd5hZ8Jf2lYO6g2P04nc=;
        b=OQ0ag+nw6ch4o1RPhj70ncA0oDPguM0Wli7Wqfc8LZ5xPNgQkYeaWHDwlaxrI/Y7fi
         Gt1KIFX82yBdTXGG5HvkNVAbiDHzoiZWpFMCe7+LNJoZzrCB3yglISqcovIIaA9UrhGk
         R3i0cFW0V5RDGNvnBERz//QpemvEOOTix84zf/XQZlFOfZhEZ8mP4F0MZi9kZ3qz4XSX
         Pke45y0m0nC+Emq4bgh5+GSv/kBwldjoQiYWmx797OJh6mHZZjlP5dVraSk4FOSC2OZL
         tWeXHcbFSivgG2nW4fM67fjrKcOkt7J49J+O3pa8VTIQyMFrTjDyTV8k5Gc9wWB1VFO4
         XYgQ==
X-Gm-Message-State: AOJu0YwOD9yjoB7DyPwGtL3cFPhRjt8bsmGzjI0Qk04GvRZZbclyW1EQ
	u6m7DjUS1ZGwqsQKFHRS9bqjzXe3/RfQouIkPYZE0JT8X0PHDKK2fd86e4LRLc8VuQuZ14czse2
	z7QaAXGhGxRnGrb0no9KI4SRzJ4l56TQH5j+bQr/CawUeoY9/o4JAlPy5GAJVjQ==
X-Gm-Gg: ASbGncvBnMpUjm6+FJ74C+eD5yq4gA1YlSosFdc99v8Dhp7/qYzBdeOSK859sesk1Z/
	fyUVa1S3aS2oUvCaTcUQLglaDjJeU5o5lXSstqSWQ0IJ4GpxtlrNamM/9HUU+xTDUTrvx4LzocZ
	nI2KINy1BIUwmsU1HxZe0gmFpjJQjiKMGLIx/EDnQgD/6cGi/jPZi1pbpd5r/dOsqiA4sgSSO4K
	vNTvfOJM2h2YBEgSeNcBd2XyPB3Hus4vgfwsNXPLwC04KDQko4AcTzVBlIBXj9q67uwDkDU8oGU
	psJ7r3J9SemLbhiy7/xx6PNZoXaEaaG1+w3WA/WsPQ==
X-Received: by 2002:a05:600c:1546:b0:439:9946:af60 with SMTP id 5b1f17b1804b1-43ab0f72b03mr17377045e9.25.1740474905740;
        Tue, 25 Feb 2025 01:15:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFv74YgG8Iolf174w9Y9ybHGXlvSToIfrToEGjP2c4/7Rl0aROxWh/UMKakDjj4UqxbgXB2bQ==
X-Received: by 2002:a05:600c:1546:b0:439:9946:af60 with SMTP id 5b1f17b1804b1-43ab0f72b03mr17376785e9.25.1740474905347;
        Tue, 25 Feb 2025 01:15:05 -0800 (PST)
Received: from [10.32.64.164] (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ab1532f0asm18718845e9.4.2025.02.25.01.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 01:15:04 -0800 (PST)
Message-ID: <7df6e1846ed6932c789a913c6a10aa8df5e26519.camel@redhat.com>
Subject: Re: [PATCH net-next v3 2/4] stmmac: loongson: Remove surplus loop
From: Philipp Stanner <pstanner@redhat.com>
To: Yanteng Si <si.yanteng@linux.dev>, Philipp Stanner <phasta@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Huacai Chen <chenhuacai@kernel.org>,
 Yinggang Gu <guyinggang@loongson.cn>, Feiyang Chen
 <chenfeiyang@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>, Qing
 Zhang <zhangqing@loongson.cn>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Tue, 25 Feb 2025 10:15:03 +0100
In-Reply-To: <437d4fad-6cd4-4f90-a1bb-07193d015cad@linux.dev>
References: <20250224135321.36603-2-phasta@kernel.org>
	 <20250224135321.36603-4-phasta@kernel.org>
	 <437d4fad-6cd4-4f90-a1bb-07193d015cad@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-02-25 at 17:06 +0800, Yanteng Si wrote:
>=20
> =E5=9C=A8 2/24/25 9:53 PM, Philipp Stanner =E5=86=99=E9=81=93:
> > loongson_dwmac_probe() contains a loop which doesn't have an
> > effect,
> > because it tries to call pcim_iomap_regions() with the same
> > parameters
> > several times. The break statement at the loop's end furthermore
> > ensures
> > that the loop only runs once anyways.
> >=20
> > Remove the surplus loop.
> >=20
> > Signed-off-by: Philipp Stanner <phasta@kernel.org>
>=20
> It seems that the fix-tag has been forgotten, next two patches as
> well.

Not forgotten, I just think that patches 2-4 are code improvements, not
bug fixes.

The issue in patch 1 would cause actual misbehavior (a useless debug
information print in case of a resource collision), whereas 2-4 are
just ugly code, but not actual bugs: the loop always just runs once;
and unmapping the PCI resources manually is valid, but obviously
unnecessary.

Agreed?

P.

>=20
>=20
> Reviewed-by: Yanteng Si <si.yanteng@linux.dev>
>=20
> Thanks,
> Yanteng
>=20
> > ---
> > =C2=A0 drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c | 11 +++---=
-
> > ----
> > =C2=A0 1 file changed, 3 insertions(+), 8 deletions(-)
> >=20
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> > b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> > index 73a6715a93e6..e3cacd085b3f 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> > @@ -554,14 +554,9 @@ static int loongson_dwmac_probe(struct pci_dev
> > *pdev, const struct pci_device_id
> > =C2=A0=C2=A0	pci_set_master(pdev);
> > =C2=A0=20
> > =C2=A0=C2=A0	/* Get the base address of device */
> > -	for (i =3D 0; i < PCI_STD_NUM_BARS; i++) {
> > -		if (pci_resource_len(pdev, i) =3D=3D 0)
> > -			continue;
> > -		ret =3D pcim_iomap_regions(pdev, BIT(0),
> > DRIVER_NAME);
> > -		if (ret)
> > -			goto err_disable_device;
> > -		break;
> > -	}
> > +	ret =3D pcim_iomap_regions(pdev, BIT(0), DRIVER_NAME);
> > +	if (ret)
> > +		goto err_disable_device;
> > =C2=A0=20
> > =C2=A0=C2=A0	memset(&res, 0, sizeof(res));
> > =C2=A0=C2=A0	res.addr =3D pcim_iomap_table(pdev)[0];


