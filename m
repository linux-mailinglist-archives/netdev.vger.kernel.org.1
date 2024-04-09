Return-Path: <netdev+bounces-86168-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F4489DC54
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 16:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 975E0284574
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 14:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8597B8C11;
	Tue,  9 Apr 2024 14:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K2LyBp1n"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0210101EC
	for <netdev@vger.kernel.org>; Tue,  9 Apr 2024 14:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712673030; cv=none; b=EaWPDEcgbHy9aqE2FWc5aXzFSwM3VW/5M63c7QbyPyqj6frPWutEKdyDuJs38SDwurA+ZrOyIxWzI1Bn7BS5TgvDtKmMe0mUBLlfomEf0eVeAr0flUsSAfsCpBBjTZiXepNjl0QLpIRNNYblQPt5WrNqcl+XdbY2ml80CWCIoCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712673030; c=relaxed/simple;
	bh=aqIQUXApUw7WOKs1PDyCLHofAiyJL+TZfUQ7ScTUBms=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=diKXhBNwduKc3o+pZS7lx8HBtPqphm0ijAig5F7UAHxCNu/K9rCrFktkHM9o7Pe1NjhYkmhei9L03vKEeLTkh4G+kGcjFJUXn5SUnAYTBD5HM0BwYzB73ZDPocxBwj2JraI4UK0VqonUvpOk5tVnLqG+6EFA6NuhQ2I8lAdi2YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K2LyBp1n; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712673027;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=GNuKt0S0ibBnZ98zxu8iSf/FUwkv0427ArtM4h+hkk0=;
	b=K2LyBp1n1mn4LU9m/2Kmtp7Kfx7cjHV08WMIwh9yPyZUG01miqE2cPf09tOu7VzOqfBLe5
	ZJda4Ml2kYikXTfdmh6wO1xyjb8HoeBSjKcynXGtWjiAMDX2ht+09Z92pCRBXk+mgxRXAm
	m9Q7D+pJt1B4pKqVDPSe9ufWq7g5s7o=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-335-puMRFm76Oz6q329KMgM-0A-1; Tue, 09 Apr 2024 10:30:24 -0400
X-MC-Unique: puMRFm76Oz6q329KMgM-0A-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-78d68cc5e1aso13590685a.1
        for <netdev@vger.kernel.org>; Tue, 09 Apr 2024 07:30:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712673024; x=1713277824;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GNuKt0S0ibBnZ98zxu8iSf/FUwkv0427ArtM4h+hkk0=;
        b=Xv8lMVLZ/vNnESH7x41SNlliVucFBQicn+jWs2x97RXJ0JzeUhsalBn3vSVd3qniq4
         bE7J7tNL31anBETtOcozhMFHNGTePp+wfwIXFjEDj2Wc1O6p8Y0uWLshSx/qFpWmkUcV
         rzMTg7Yu2ykE/LUr+ThNSoCJ6Im7hajtPK23bvs3SRfIkacddfu8R4oDMq3zaEZFDI9A
         gfzIqeBtrKPGAnNn7venUEWIPVd1xoPVCLlIlWnF78Cy+xV3hiiNiWTiK3Nx7XEQoF56
         JtQqZ0ZkFfeiVe+IcaYI0glSAQqtubBacrLZwD7IMp2SKO1qLPFlalfZAX2yIRfKTVO4
         11tw==
X-Forwarded-Encrypted: i=1; AJvYcCX9RD47huySWWo+hUXBbedU9gdPCwXfwVFuq133qccrVEwZ7eN/B8RWs8J0kQ+gWr5/eCidSntMcKwhjUZnyVNOpZ56IfAs
X-Gm-Message-State: AOJu0YzBcNhHQt1kgmAdViAhaMUUyO2M9rzjcsQhIKvkOE24JQVi3SF+
	YhYW6yNvVVUb9J86484tq+ypwZKUR0O8pEGF1eR73oVN1LwIekY8B16Ib9MCfZDCYHgm0T8pYss
	onLAZHHko3hSkW0LfKa6INC4t6cGmOfLZ37bcaMTzM8cVBWHFuLGHUg==
X-Received: by 2002:a05:620a:319e:b0:78d:5fd5:9254 with SMTP id bi30-20020a05620a319e00b0078d5fd59254mr10032294qkb.5.1712673023933;
        Tue, 09 Apr 2024 07:30:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGuMLshbaGPjI2oWhMdsHxyCbfL/dq7jkkTCgafk6UaNBhThlVddcfJAK7iYDCOs3rogiGrJg==
X-Received: by 2002:a05:620a:319e:b0:78d:5fd5:9254 with SMTP id bi30-20020a05620a319e00b0078d5fd59254mr10032246qkb.5.1712673023436;
        Tue, 09 Apr 2024 07:30:23 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-244-144.dyn.eolo.it. [146.241.244.144])
        by smtp.gmail.com with ESMTPSA id l1-20020ae9f001000000b0078a751b6c99sm4111067qkg.132.2024.04.09.07.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 07:30:23 -0700 (PDT)
Message-ID: <8ff2275b53a542acf8c5a42b77621cbdc747e4a4.camel@redhat.com>
Subject: Re: [PATCH net-next v6 02/10] eth: Move IPv4/IPv6 multicast address
 bases to their own symbols
From: Paolo Abeni <pabeni@redhat.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>, Diogo Ivo
	 <diogo.ivo@siemens.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
 netdev@vger.kernel.org, andrew@lunn.ch, danishanwar@ti.com,
 rogerq@kernel.org,  vigneshr@ti.com, jan.kiszka@siemens.com
Date: Tue, 09 Apr 2024 16:30:20 +0200
In-Reply-To: <f0b22f81-2de1-47f0-8cc9-f89c7a055867@intel.com>
References: <20240403104821.283832-1-diogo.ivo@siemens.com>
	 <20240403104821.283832-3-diogo.ivo@siemens.com>
	 <03660271-c04c-4872-8483-b3a1bfa568ef@intel.com>
	 <e00f2f63-5917-47b4-a84d-075843af21a2@siemens.com>
	 <f0b22f81-2de1-47f0-8cc9-f89c7a055867@intel.com>
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

On Tue, 2024-04-09 at 13:00 +0200, Alexander Lobakin wrote:
> From: Diogo Ivo <diogo.ivo@siemens.com>
> Date: Tue, 9 Apr 2024 11:20:21 +0100
>=20
> > On 4/9/24 10:07 AM, Alexander Lobakin wrote:
> > > From: Diogo Ivo <diogo.ivo@siemens.com>
> > > Date: Wed,=C2=A0 3 Apr 2024 11:48:12 +0100
> > >=20
> > > > As these addresses can be useful outside of checking if an address
> > > > is a multicast address (for example in device drivers) make them
> > > > accessible to users of etherdevice.h to avoid code duplication.
> > > >=20
> > > > Signed-off-by: Diogo Ivo <diogo.ivo@siemens.com>
> > > > Reviewed-by: MD Danish Anwar <danishanwar@ti.com>
> > > > ---
> > > > Changes in v5:
> > > > =C2=A0 - Added Reviewed-by tag from Danish
> > > >=20
> > > > =C2=A0 include/linux/etherdevice.h | 12 ++++++++----
> > > > =C2=A0 1 file changed, 8 insertions(+), 4 deletions(-)
> > > >=20
> > > > diff --git a/include/linux/etherdevice.h b/include/linux/etherdevic=
e.h
> > > > index 224645f17c33..8d6daf828427 100644
> > > > --- a/include/linux/etherdevice.h
> > > > +++ b/include/linux/etherdevice.h
> > > > @@ -71,6 +71,12 @@ static const u8 eth_reserved_addr_base[ETH_ALEN]
> > > > __aligned(2) =3D
> > > > =C2=A0 { 0x01, 0x80, 0xc2, 0x00, 0x00, 0x00 };
> > > > =C2=A0 #define eth_stp_addr eth_reserved_addr_base
> > > > =C2=A0 +static const u8 eth_ipv4_mcast_addr_base[ETH_ALEN] __aligne=
d(2) =3D
> > > > +{ 0x01, 0x00, 0x5e, 0x00, 0x00, 0x00 };
> > > > +
> > > > +static const u8 eth_ipv6_mcast_addr_base[ETH_ALEN] __aligned(2) =
=3D
> > > > +{ 0x33, 0x33, 0x00, 0x00, 0x00, 0x00 };
> > >=20
> > > I see this is applied already, but I don't like static symbols in hea=
der
> > > files. This will make a local copy of every used symbol each time it'=
s
> > > referenced.
> > > We usually make such symbols global consts and export them. Could you
> > > please send a follow-up?
> >=20
> > I forgot to ask, should this exporting happen in
> > include/linux/etherdevice.h?
>=20
> In etherdevice.h, you do
>=20
> const u8 eth_ipv4_mcast_addr_base[ETH_ALEN];
> const u8 eth_ipv6_mcast_addr_base[ETH_ALEN];
>=20
> Then, somewhere in, I guess, net/ethernet/eth.c, you do
>=20
> const u8 eth_ipv4_mcast_addr_base[ETH_ALEN] __aligned(2) =3D {
> 	0x01, 0x00, 0x5e, 0x00, 0x00, 0x00
> };
> EXPORT_SYMBOL(eth_ipv4_mcast_addr_base);
>=20
> const u8 eth_ipv6_mcast_addr_base[ETH_ALEN] __aligned(2) =3D {
> 	0x33, 0x33, 0x00, 0x00, 0x00, 0x00
> };
> EXPORT_SYMBOL(eth_ipv6_mcast_addr_base);

I think it would be good moving even eth_reserved_addr_base into eth.c

Thanks!

Paolo


