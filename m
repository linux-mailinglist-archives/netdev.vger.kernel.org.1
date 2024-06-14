Return-Path: <netdev+bounces-103503-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D84908607
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 10:19:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCD75B212AE
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 08:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AEDA18307E;
	Fri, 14 Jun 2024 08:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QmLSGaHW"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51F4149C44
	for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 08:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718353135; cv=none; b=rrBCHn0Xx32IA+oAOAh2QAbr9NS5Nj9Cw2KR89+liTreICLuR+LhOFBUOw/T1VC5vjWUXMs3J8h7RZK4Xzqv4ssQx0B2Euwuoc4ZxlFE3ivWUkAZjhtHCLJe7wgvIw/MBZhxMWoARfm5cBvAhMwP2ck8n4OvTvbRNmbtmRZwtzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718353135; c=relaxed/simple;
	bh=vHbWI1fgikBeglG6cLpRlyipFzW0uVvi9xgjNoaTgnI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Sxl5FuQHhuiWHzzFxL0PwiezCHa9lq6RMw3ZqviyDB3VVh988irsNzc6Al77pxnne9FO7hL/eGO45dk+bHRbYFg0PK3Juch53aH/HkhSb4+QZgXRduRvn+k+yB33XIjYqKBjY80hDNUDv9VTncujZnlL0S8dlUWu4tnhMLkbnUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QmLSGaHW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718353132;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=HQALQbVExWflhKtpbFR5K9ctJeKb5Y/FFSLv5vUKGSY=;
	b=QmLSGaHWjl3e4bw2qbQ5vxIDQpjDlpd3Dss7xc9wHRssa79f1o4z/PQiG57jRd4dL1JigF
	hyBolOe22LdETpcpuf1fR+lLRpZz4DRCIjaKqhivklk1TF2w8SYulMlwtrE5qUkhN1xTF1
	qAJ/5Z1zuwWQ8/3c926JjoVgpebj2Is=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-117-2uWPgE19MzWBUVBuO7nBjg-1; Fri, 14 Jun 2024 04:18:51 -0400
X-MC-Unique: 2uWPgE19MzWBUVBuO7nBjg-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-35f2ae13e4eso303636f8f.2
        for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 01:18:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718353130; x=1718957930;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HQALQbVExWflhKtpbFR5K9ctJeKb5Y/FFSLv5vUKGSY=;
        b=HQX69GuVSbM81RSWF2Fb1MQufmuTV/rh8bBDYbJd9n72dGu7Ja0l1bB5jz/VTrVCsI
         scdp7i5vo3rpWWT7Q+MZvxhT0dU81MjAhcAJAfLtRURZbUcO7TzEwiGM3T9PwthojJq2
         XmK8RsUqehLePltHuTmYMaCTDv67RMgmH0s9C7U9+tGG62y6SO9jeVH1wgPVdMHsQOSN
         3fgwUN9ATkbrMeEjnXoA2byEbIF7lu/HYih/uuZycL5dXtvuWWgtSIEsrIW/aO78I8Z6
         Qi3FxWLTCBqxUc9/AiTGxpQ8Uze5kDBoB3lCKUBW4/IJWCEfEMvxnVcw6RKO2IDeRV5J
         7sag==
X-Forwarded-Encrypted: i=1; AJvYcCW7CHR6wLJn1J8FZZjbjsx01upZWhD0cQrxW2bvmhYjoBTfgxX5Y2HdC5iQ/Zp6+tHmFTFmWqNf4yZFkQhyYv0qfowd8gwl
X-Gm-Message-State: AOJu0YxyoQK9mvDcE5Tk+8m1+IA2AtgnKfBx1A9Zovda6i8DVWa3QOJb
	MQ/gBzn/r7uLvGG1Uy1yYQHtJ4UYz4VWD2uHxgRM2VHyUbfUA0NHRfUwl0FbRZ4Rmek/13+DymS
	ZjobVnUhXhUT4xXrgGBb8XSATDe0SebcYNOSU3jyiCcdKLxfwv49Zvg==
X-Received: by 2002:a05:600c:1ca7:b0:423:445:4aaf with SMTP id 5b1f17b1804b1-423047d6db3mr15182355e9.0.1718353129911;
        Fri, 14 Jun 2024 01:18:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFauQeUPQFQIvZN0vBHK4i6LNbOZkgTwwM5ezjPOyqm72WuIRvn5lKDQmsVAx8f90nCqmz39w==
X-Received: by 2002:a05:600c:1ca7:b0:423:445:4aaf with SMTP id 5b1f17b1804b1-423047d6db3mr15182145e9.0.1718353129492;
        Fri, 14 Jun 2024 01:18:49 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3341:b083:7210:de1e:fd05:fa25:40db])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422f6127d6dsm50844985e9.26.2024.06.14.01.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 01:18:49 -0700 (PDT)
Message-ID: <fbf2be8d31579d1c9305fd961751fc6f0a4b4556.camel@redhat.com>
Subject: Re: [PATCH next-next] net: phy: realtek: add support for rtl8224
 2.5Gbps PHY
From: Paolo Abeni <pabeni@redhat.com>
To: Marek =?ISO-8859-1?Q?Beh=FAn?= <kabel@kernel.org>, Chris Packham
	 <Chris.Packham@alliedtelesis.co.nz>
Cc: "andrew@lunn.ch" <andrew@lunn.ch>, "hkallweit1@gmail.com"
 <hkallweit1@gmail.com>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>, 
 "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
 <edumazet@google.com>,  "kuba@kernel.org" <kuba@kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "ericwouds@gmail.com" <ericwouds@gmail.com>
Date: Fri, 14 Jun 2024 10:18:47 +0200
In-Reply-To: <20240612090707.7da3fc01@dellmb>
References: <20240611053415.2111723-1-chris.packham@alliedtelesis.co.nz>
	 <c3d699a1-2f24-41c5-b0a7-65db025eedbc@alliedtelesis.co.nz>
	 <20240612090707.7da3fc01@dellmb>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=mQINBGISiDUBEAC5uMdJicjm3ZlWQJG4u2EU1EhWUSx8IZLUTmEE8zmjPJFSYDcjtfGcbzLPb63BvX7FADmTOkO7gwtDgm501XnQaZgBUnCOUT8qv5MkKsFH20h1XJyqjPeGM55YFAXc+a4WD0YyO5M0+KhDeRLoildeRna1ey944VlZ6Inf67zMYw9vfE5XozBtytFIrRyGEWkQwkjaYhr1cGM8ia24QQVQid3P7SPkR78kJmrT32sGk+TdR4YnZzBvVaojX4AroZrrAQVdOLQWR+w4w1mONfJvahNdjq73tKv51nIpu4SAC1Zmnm3x4u9r22mbMDr0uWqDqwhsvkanYmn4umDKc1ZkBnDIbbumd40x9CKgG6ogVlLYeJa9WyfVMOHDF6f0wRjFjxVoPO6p/ZDkuEa67KCpJnXNYipLJ3MYhdKWBZw0xc3LKiKc+nMfQlo76T/qHMDfRMaMhk+L8gWc3ZlRQFG0/Pd1pdQEiRuvfM5DUXDo/YOZLV0NfRFU9SmtIPhbdm9cV8Hf8mUwubihiJB/9zPvVq8xfiVbdT0sPzBtxW0fXwrbFxYAOFvT0UC2MjlIsukjmXOUJtdZqBE3v3Jf7VnjNVj9P58+MOx9iYo8jl3fNd7biyQWdPDfYk9ncK8km4skfZQIoUVqrWqGDJjHO1W9CQLAxkfOeHrmG29PK9tHIwARAQABtB9QYW9sbyBBYmVuaSA8cGFiZW5pQHJlZGhhdC5jb20+iQJSBBMBCAA8FiEEg1AjqC77wbdLX2LbKSR5jcyPE6QFAmISiDUCGwMFCwkIBwIDIgIBBhUKCQgLAgQWAgMBAh4HAheAAAoJECkkeY3MjxOkJSYQAJcc6MTsuFxYdYZkeWjW//zbD3ApRHzpNlHLVSuJqHr9/aDS+tyszgS8jj9MiqALzgq4iZbg
 7ZxN9ZsDL38qVIuFkSpgMZCiUHdxBC11J8nbBSLlpnc924UAyr5XrGA99 6Wl5I4Km3128GY6iAkH54pZpOmpoUyBjcxbJWHstzmvyiXrjA2sMzYjt3Xkqp0cJfIEekOi75wnNPofEEJg28XPcFrpkMUFFvB4Aqrdc2yyR8Y36rbw18sIX3dJdomIP3dL7LoJi9mfUKOnr86Z0xltgcLPGYoCiUZMlXyWgB2IPmmcMP2jLJrusICjZxLYJJLofEjznAJSUEwB/3rlvFrSYvkKkVmfnfro5XEr5nStVTECxfy7RTtltwih85LlZEHP8eJWMUDj3P4Q9CWNgz2pWr1t68QuPHWaA+PrXyasDlcRpRXHZCOcvsKhAaCOG8TzCrutOZ5NxdfXTe3f1jVIEab7lNgr+7HiNVS+UPRzmvBc73DAyToKQBn9kC4jh9HoWyYTepjdcxnio0crmara+/HEyRZDQeOzSexf85I4dwxcdPKXv0fmLtxrN57Ae82bHuRlfeTuDG3x3vl/Bjx4O7Lb+oN2BLTmgpYq7V1WJPUwikZg8M+nvDNcsOoWGbU417PbHHn3N7yS0lLGoCCWyrK1OY0QM4EVsL3TjOfUtCNQYW9sbyBBYmVuaSA8cGFvbG8uYWJlbmlAZ21haWwuY29tPokCUgQTAQgAPBYhBINQI6gu+8G3S19i2ykkeY3MjxOkBQJiEoitAhsDBQsJCAcCAyICAQYVCgkICwIEFgIDAQIeBwIXgAAKCRApJHmNzI8TpBzHD/45pUctaCnhee1vkQnmStAYvHmwrWwIEH1lzDMDCpJQHTUQOOJWDAZOFnE/67bxSS81Wie0OKW2jvg1ylmpBA0gPpnzIExQmfP72cQ1TBoeVColVT6Io35BINn+ymM7c0Bn8RvngSEpr3jBtqvvWXjvtnJ5/HbOVQCg62NC6ewosoKJPWpGXMJ9SKsVIOUHsmoWK60spzeiJoSmAwm3zTJQnM5kRh2q
 iWjoCy8L35zPqR5TV+f5WR5hTVCqmLHSgm1jxwKhPg9L+GfuE4d0SWd84y GeOB3sSxlhWsuTj1K6K3MO9srD9hr0puqjO9sAizd0BJP8ucf/AACfrgmzIqZXCfVS7jJ/M+0ic+j1Si3yY8wYPEi3dvbVC0zsoGj9n1R7B7L9c3g1pZ4L9ui428vnPiMnDN3jh9OsdaXeWLvSvTylYvw9q0DEXVQTv4/OkcoMrfEkfbXbtZ3PRlAiddSZA5BDEkkm6P9KA2YAuooi1OD9d4MW8LFAeEicvHG+TPO6jtKTacdXDRe611EfRwTjBs19HmabSUfFcumL6BlVyceIoSqXFe5jOfGpbBevTZtg4kTSHqymGb6ra6sKs+/9aJiONs5NXY7iacZ55qG3Ib1cpQTps9bQILnqpwL2VTaH9TPGWwMY3Nc2VEc08zsLrXnA/yZKqZ1YzSY9MGXWYLkCDQRiEog1ARAAyXMKL+x1lDvLZVQjSUIVlaWswc0nV5y2EzBdbdZZCP3ysGC+s+n7xtq0o1wOvSvaG9h5q7sYZs+AKbuUbeZPu0bPWKoO02i00yVoSgWnEqDbyNeiSW+vI+VdiXITV83lG6pS+pAoTZlRROkpb5xo0gQ5ZeYok8MrkEmJbsPjdoKUJDBFTwrRnaDOfb+Qx1D22PlAZpdKiNtwbNZWiwEQFm6mHkIVSTUe2zSemoqYX4QQRvbmuMyPIbwbdNWlItukjHsffuPivLF/XsI1gDV67S1cVnQbBgrpFDxN62USwewXkNl+ndwa+15wgJFyq4Sd+RSMTPDzDQPFovyDfA/jxN2SK1Lizam6o+LBmvhIxwZOfdYH8bdYCoSpqcKLJVG3qVcTwbhGJr3kpRcBRz39Ml6iZhJyI3pEoX3bJTlR5Pr1Kjpx13qGydSMos94CIYWAKhegI06aTdvvuiigBwjngo/Rk5S+iEGR5KmTqGyp27o6YxZy6D4NIc6PKUzhIUxfvuHNvfu
 sD2W1U7eyLdm/jCgticGDsRtweytsgCSYfbz0gdgUuL3EBYN3JLbAU+UZpy v/fyD4cHDWaizNy/KmOI6FFjvVh4LRCpGTGDVPHsQXaqvzUybaMb7HSfmBBzZqqfVbq9n5FqPjAgD2lJ0rkzb9XnVXHgr6bmMRlaTlBMAEQEAAYkCNgQYAQgAIBYhBINQI6gu+8G3S19i2ykkeY3MjxOkBQJiEog1AhsMAAoJECkkeY3MjxOkY1YQAKdGjHyIdOWSjM8DPLdGJaPgJdugHZowaoyCxffilMGXqc8axBtmYjUIoXurpl+f+a7S0tQhXjGUt09zKlNXxGcebL5TEPFqgJTHN/77ayLslMTtZVYHE2FiIxkvW48yDjZUlefmphGpfpoXe4nRBNto1mMB9Pb9vR47EjNBZCtWWbwJTIEUwHP2Z5fV9nMx9Zw2BhwrfnODnzI8xRWVqk7/5R+FJvl7s3nY4F+svKGD9QHYmxfd8Gx42PZc/qkeCjUORaOf1fsYyChTtJI4iNm6iWbD9HK5LTMzwl0n0lL7CEsBsCJ97i2swm1DQiY1ZJ95G2Nz5PjNRSiymIw9/neTvUT8VJJhzRl3Nb/EmO/qeahfiG7zTpqSn2dEl+AwbcwQrbAhTPzuHIcoLZYV0xDWzAibUnn7pSrQKja+b8kHD9WF+m7dPlRVY7soqEYXylyCOXr5516upH8vVBmqweCIxXSWqPAhQq8d3hB/Ww2A0H0PBTN1REVw8pRLNApEA7C2nX6RW0XmA53PIQvAP0EAakWsqHoKZ5WdpeOcH9iVlUQhRgemQSkhfNaP9LqR1XKujlTuUTpoyT3xwAzkmSxN1nABoutHEO/N87fpIbpbZaIdinF7b9srwUvDOKsywfs5HMiUZhLKoZzCcU/AEFjQsPTATACGsWf3JYPnWxL9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-06-12 at 09:07 +0200, Marek Beh=C3=BAn wrote:
> On Tue, 11 Jun 2024 20:42:43 +0000
> Chris Packham <Chris.Packham@alliedtelesis.co.nz> wrote:
>=20
> > +cc Eric W and Marek.
> >=20
> > On 11/06/24 17:34, Chris Packham wrote:
> > > The Realtek RTL8224 PHY is a 2.5Gbps capable PHY. It only uses the
> > > clause 45 MDIO interface and can leverage the support that has alread=
y
> > > been added for the other 822x PHYs.
> > >=20
> > > Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> > > ---
> > >=20
> > > Notes:
> > >      I'm currently testing this on an older kernel because the board =
I'm
> > >      using has a SOC/DSA switch that has a driver in openwrt for Linu=
x 5.15.
> > >      I have tried to selectively back port the bits I need from the o=
ther
> > >      rtl822x work so this should be all that is required for the rtl8=
224.
> > >     =20
> > >      There's quite a lot that would need forward porting get a workin=
g system
> > >      against a current kernel so hopefully this is small enough that =
it can
> > >      land while I'm trying to figure out how to untangle all the othe=
r bits.
> > >     =20
> > >      One thing that may appear lacking is the lack of rate_matching s=
upport.
> > >      According to the documentation I have know the interface used on=
 the
> > >      RTL8224 is (q)uxsgmii so no rate matching is required. As I'm st=
ill
> > >      trying to get things completely working that may change if I get=
 new
> > >      information.
> > >=20
> > >   drivers/net/phy/realtek.c | 8 ++++++++
> > >   1 file changed, 8 insertions(+)
> > >=20
> > > diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
> > > index 7ab41f95dae5..2174893c974f 100644
> > > --- a/drivers/net/phy/realtek.c
> > > +++ b/drivers/net/phy/realtek.c
> > > @@ -1317,6 +1317,14 @@ static struct phy_driver realtek_drvs[] =3D {
> > >   		.resume         =3D rtlgen_resume,
> > >   		.read_page      =3D rtl821x_read_page,
> > >   		.write_page     =3D rtl821x_write_page,
> > > +	}, {
> > > +		PHY_ID_MATCH_EXACT(0x001ccad0),
> > > +		.name		=3D "RTL8224 2.5Gbps PHY",
> > > +		.get_features   =3D rtl822x_c45_get_features,
> > > +		.config_aneg    =3D rtl822x_c45_config_aneg,
> > > +		.read_status    =3D rtl822x_c45_read_status,
> > > +		.suspend        =3D genphy_c45_pma_suspend,
> > > +		.resume         =3D rtlgen_c45_resume,
> > >   	}, {
> > >   		PHY_ID_MATCH_EXACT(0x001cc961),
> > >   		.name		=3D "RTL8366RB Gigabit Ethernet" =20
>=20
> Don't you need rtl822xb_config_init for serdes configuration?

Marek, I read the above as you would prefer to have such support
included from the beginning, as such I'm looking forward a new version
of this patch.

Please raise a hand if I read too much in your reply.

Thanks!

Paolo


