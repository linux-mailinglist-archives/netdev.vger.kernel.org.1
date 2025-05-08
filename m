Return-Path: <netdev+bounces-188988-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC0C3AAFC30
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 15:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E3EA4E5746
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 13:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B3C22A4F6;
	Thu,  8 May 2025 13:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=goosey.org header.i=@goosey.org header.b="cDMfeDdR";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="mcqE8yiw"
X-Original-To: netdev@vger.kernel.org
Received: from e240-12.smtp-out.eu-north-1.amazonses.com (e240-12.smtp-out.eu-north-1.amazonses.com [23.251.240.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81851E4BE;
	Thu,  8 May 2025 13:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.251.240.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746712723; cv=none; b=V0HROXH4hMWJ+k9Z7Rg3khQBoRTrx0dsiGhoXe42FFlYBYbIH3x5pPhHGFEUbcc93GNa1F606tYDG7r8YOzWGXOPt0NupM20YLKXtrmEMaSR7znkG6J+8ei1zcJpJriJJ/TpiQwvKXpG49X6nxdFdpmONbe14AE8wxhAb36cWVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746712723; c=relaxed/simple;
	bh=swR6LXMLIHkJZt3RiNNB5m27sx+FlmfIn+NiM/f0xCo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=My5iGjED3kN9F65D1ql6JixMnNf0ZTba1LlhE+tiXJt8GNCOSC308yWVkQu7dmNWj8IP2WheHy31U+YGutOOs51WQhHg5mkuqFU6/ZjQTBXbt89MRR50c1a6P1qB2lgfh1WjL0POAjlMk8EZTYhEmxxuEKg4zyVex7vs2BSIbXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goosey.org; spf=pass smtp.mailfrom=eu-north-1.amazonses.com; dkim=pass (2048-bit key) header.d=goosey.org header.i=@goosey.org header.b=cDMfeDdR; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=mcqE8yiw; arc=none smtp.client-ip=23.251.240.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goosey.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eu-north-1.amazonses.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=iuunfi4kzpbzwuqjzrd5q2mr652n55fx; d=goosey.org; t=1746712719;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=swR6LXMLIHkJZt3RiNNB5m27sx+FlmfIn+NiM/f0xCo=;
	b=cDMfeDdRkL+wfS9yaet9dAwFeq5z5mc8elcRGBzgHP5jeCtLpCnKm322e9fny9HZ
	2q3/sd0NpOJvSaZiAy44txIIfDJ6OC8YTZlYSoA0uScSITk5Ki0UDe34yXr+W2QptI8
	U8+4Bofc3m25LcB++MD8j8zrGNc/E5LA1belnoJE/wG1RftVBFA8P2PAMqUEr5qlIEf
	skvl85p1NC6oLuDQXuE1ggArSPiQkpoyBJrBWxAkQhaywN4Tb+2S/sCANt1xfIb1LXI
	RsTJY2jvbljgHbhW6SkyiOgyRs7stvSUFCxyHFn6SAlU232RTBLYZ9K3QIzigYF9KFe
	glaJE6k3Lg==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=bw45wyq3hkghdoq32obql4uyexcghmc7; d=amazonses.com; t=1746712719;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding:Feedback-ID;
	bh=swR6LXMLIHkJZt3RiNNB5m27sx+FlmfIn+NiM/f0xCo=;
	b=mcqE8yiwczABIw3Pw1rcdzPbkE9e/AhzZi/QQEQC/m3jx0/kMKsb+CFJhkL9ZpC1
	HinvaJ68cvXtU/YE/orMpWRoNmTDejj9foCmU8HQkkLFcVvTkJq2EO+yz65op86qI5O
	2I62GTIG0vJqlTzHaoUJA6DyhPvjgrP0ZNODa9Ng=
X-Forwarded-Encrypted: i=1; AJvYcCUZDwvEGClHj369gFvauNVOAsws6Xd0Si7mDX28O00Q9TB/h6wx7CvDHT4rNqBWjMIVy3U/oqD8li2Ovqg=@vger.kernel.org, AJvYcCUqc5IYa7NhdEUym4GyOnOTbMLJlKRtwPwEO/vJ5KVmIFT3F1peErbqRGd4XsV4m9SbgoMDdVcl@vger.kernel.org
X-Gm-Message-State: AOJu0YyxH8tLzJYON5ZfhVZ2HLH1EZGOtuX3fxwQNJASmxqUGJxAtuEB
	BKEsVfgH1fRxxhO/Z+kVjdkiE2jGaOp3Qi5XJGPW0PcGqJFrY6ymmDwYp29yjW4IVMSzPCRjCIi
	ay1cCjh09wd4iX0RxkQ225WG02A4=
X-Google-Smtp-Source: AGHT+IGBWdGYmwc/QYdTSI/7IIJ1c3y+qU9AJImAnxEsKHk9w6eO1gPE0aarTPVJ1+tJasJ1xhkcRUNUA6V9BJOjAzs=
X-Received: by 2002:a17:90b:5105:b0:2ee:8427:4b02 with SMTP id
 98e67ed59e1d1-30b3a6d819emr5181653a91.28.1746712717263; Thu, 08 May 2025
 06:58:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <01100196adabd0d2-24bf9783-b3d5-4566-9f98-9eda0c1f4833-000000@eu-north-1.amazonses.com>
 <c18ef0d0-d716-4d04-9a01-59defc8bb56e@lunn.ch> <01100196afe6cdc1-41e8d610-06b8-4e6a-bc41-d01d9844df3b-000000@eu-north-1.amazonses.com>
 <2dce66e0-2a06-46bb-b1a2-cb5be1756fbd@lunn.ch>
In-Reply-To: <2dce66e0-2a06-46bb-b1a2-cb5be1756fbd@lunn.ch>
From: Ozgur Kara <ozgur@goosey.org>
Date: Thu, 8 May 2025 13:58:39 +0000
X-Gmail-Original-Message-ID: <CADvZ6EoE2kyP_BHc6PzrRgPYM03iEJUrgjLjLv3b3wBxQYhMtA@mail.gmail.com>
X-Gm-Features: ATxdqUHHg5Ow_BHya3Scuft-fx529yGlKMXvQAInKroM7akAltZleuei-m5iECQ
Message-ID: <01100196b030f17e-b1bb1f03-9450-43ea-a9b8-4e0dd2689657-000000@eu-north-1.amazonses.com>
Subject: Re: [PATCH] net: ethernet: Fixe issue in nvmem_get_mac_address()
 where invalid mac addresses
To: Andrew Lunn <andrew@lunn.ch>
Cc: Ozgur Kara <ozgur@goosey.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, 
	Nikolay Aleksandrov <razor@blackwall.org>, 
	Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Feedback-ID: ::1.eu-north-1.jZlAFvO9+f8tc21Z4t7ANdAU3Nw/ALd5VHiFFAqIVOg=:AmazonSES
X-SES-Outgoing: 2025.05.08-23.251.240.12

Andrew Lunn <andrew@lunn.ch>, 8 May 2025 Per, 16:49 tarihinde =C5=9Funu yaz=
d=C4=B1:
>
> On Thu, May 08, 2025 at 12:37:40PM +0000, Ozgur Kara wrote:
> > Andrew Lunn <andrew@lunn.ch>, 8 May 2025 Per, 15:01 tarihinde =C5=9Funu=
 yazd=C4=B1:
> > >
> > > On Thu, May 08, 2025 at 02:14:00AM +0000, Ozgur Kara wrote:
> > > > From: Ozgur Karatas <ozgur@goosey.org>
> > > >
> > > > it's necessary to log error returned from
> > > > fwnode_property_read_u8_array because there is no detailed informat=
ion
> > > > when addr returns an invalid mac address.
> > > >
> > > > kfree(mac) should actually be marked as kfree((void *)mac) because =
mac
> > > > pointer is of type const void * and type conversion is required so
> > > > data returned from nvmem_cell_read() is of same type.
> > >
> > > What warning do you see from the compiler?
> >
> > Hello Andrew,
> >
> > My compiler didnt give an error to this but we had to declare that
> > pointer would be used as a memory block not data and i added (void *)
> > because i was hoping that mac variable would use it to safely remove
> > const so expect a parameter of type void * avoid possible compiler
> > incompatibilities.
> > I guess, however if mac is a pointer of a different type (i guess)  we
> > use kfree(mac) without converting it to (void *) type compiler may
> > give an error.
>
> /**
>  * kfree - free previously allocated memory
>  * @object: pointer returned by kmalloc() or kmem_cache_alloc()
>  *
>  * If @object is NULL, no operation is performed.
>  */
> void kfree(const void *object)
> {
>
> So kfree() expects a const void *.
>
> int nvmem_get_mac_address(struct device *dev, void *addrbuf)
> {
>         struct nvmem_cell *cell;
>         const void *mac;
>
> mac is a const void *
>
> In general, casts should not be used, the indicate bad design. But the
> cast you are adding appears to be wrong, which is even worse.
>

Hello Andrew,

okay, now i understand so since mac is already of type const void *
and kfree() is already wait a parameter of type of const void * and
cast was also wrong.
I understand, I will review eth.c code better.

Regards

Ozgur

>         Andrew
>
>

