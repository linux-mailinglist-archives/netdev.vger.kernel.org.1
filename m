Return-Path: <netdev+bounces-153018-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B32FB9F6963
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 16:06:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 106D6189AC8A
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 15:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C68E51C5CCF;
	Wed, 18 Dec 2024 15:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LwtiVMox"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0860D35966
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 15:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734534198; cv=none; b=Cg+snipeQtbUgM7rGx0SoaC13zPLw2T+88WutogxU6uHwOWIeGZuJdIsOSJKPi98ow/lQ4wbb6bNz3Xp+69Sr/OvXuxC7z8QtzcfJW60i/Ke3vn9z//1kJOwVwcpnm+S9zspud+e3SJeHX5cUkBRWPU+Ximg+WPD3UL49bGLq4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734534198; c=relaxed/simple;
	bh=zFf9OcCPuC9U5YVeZ2HHqNCagmdJnJNo3sfU94ExjjQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NwtHpL86xlCrs5qc12DgW3OtZZjbd/HfekARv2FWi606X9oLBGv3kduFrGu7Noywdw9gduKlrSRSUc5AZqIxtPLvIj8uU43wukbL20NI79cYIdIgeC4SOxaIGcGcwRmI+FyYcLRBd0pfNGEBTmkmABIBQTgjlDNQtGfx+j+d8rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LwtiVMox; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5cec9609303so9174742a12.1
        for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 07:03:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734534195; x=1735138995; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X9yISal3LIZqGo5DXurOAVpzSZMbYmrPdakIw4/P9jA=;
        b=LwtiVMoxXA0gB8xjO0KhKzV//DP6P4jXW4Oq8anCCzNwz96kLkFiDTUfKIbu3bWtrB
         p3gNCSGGIOnqJXhBr8h8Sk/po/9fNVEp6qnXIPMpnQJ7CAPTRnlb9ZUtfWOHxmAIsa9b
         vgrygfTJT00o8iBEKoocx1bWHMb0jmXREZvVrQZQH7VOhImfHkZoEGHUgg34GEeSx5S2
         DIPzaxx3NmVSzHdgAKwuZw4O9ogVhfUpUoyxHFMiftGbXUObr7OOmodj1I733smPZbu+
         nYDl+28OP4GIzowCkh7Rs8mVtjBvwtpLlEdwvk7MYesEGyIVe8Rk2Bx83F6git/nsNd9
         TAQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734534195; x=1735138995;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X9yISal3LIZqGo5DXurOAVpzSZMbYmrPdakIw4/P9jA=;
        b=gJNkd/VmuwMjLRXflw2b4stGU37sMczZoVdD8fZ23GUmK3phae5MdW95fj4yqrro6c
         t0FsQoCv0Vzlm5TKhGXsk6t8t646p+3ISc14qWEFWubxWtB58yw6ed/G8nUeJSJcqcWi
         8VXn/tN+xjiIctYJ4b8CShLTt5g72MgOgFNwoIeTM406wd4Hx3HW0NVbtHJNElKA6XGA
         Eea95pTCanC2YfBJSF+FhvFkdw/qnxdJbe2N3vTxmWqogBxkg8FjggIuvZjr4KCDROqe
         iW+uwbUF55ur1hPbKohN4ZWQHh6XLz+7AedK0tus0rBDFFeiIiOlnxZRVfIxRtdLxivH
         i/bg==
X-Forwarded-Encrypted: i=1; AJvYcCVts5dPUiI817+5uhRdyZw+E/uX6oTCDLefSEyx/UyAx4l0oJIDmNoGBME27++VzWe2rc6FPnk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1nDs0UyvpeRewIFTFjfiJIMBDB1i0xbupTe7lQqDhKpH8JSzA
	k+MlKLQoweAKyJ/eKIOaY8c0vZafvj3Tu0MxwBGmM0gmyzB1oY1aJKftPUxO0Tr/BCVsfMhsV7r
	tELERW+OP7CDi9p7lEZ3IHHZlv0VEtRrJuqDR
X-Gm-Gg: ASbGncvWcAEzNQ9igqy6E328tgRadGY2ogtlWxZCevWh+RcUdXg/jpwXKLvNJEbx3vi
	b0OM6EGlYKuQYbOzDRuWTPfs5gyhO2t0IqRUDRYKlEXfAf0EirtCROVFkHT3DwMv1sTHQgkk=
X-Google-Smtp-Source: AGHT+IGlbMxcYr/+LyxevZyHY4pXZlEnMFerxZkoRfJmPOxtgP55jEGC/XPfsIveHXsIB2+D3GrRI0PH4TRON4L+4Kc=
X-Received: by 2002:a05:6402:34c2:b0:5d0:cfad:f6b with SMTP id
 4fb4d7f45d1cf-5d7ee3baa56mr3067548a12.11.1734534194949; Wed, 18 Dec 2024
 07:03:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241216075842.2394606-1-srasheed@marvell.com>
 <20241216075842.2394606-2-srasheed@marvell.com> <Z2A5dHOGhwCQ1KBI@lzaremba-mobl.ger.corp.intel.com>
 <Z2A9UmjW7rnCGiEu@lzaremba-mobl.ger.corp.intel.com> <BY3PR18MB4721712299EAB0ED37CCEEEFC73B2@BY3PR18MB4721.namprd18.prod.outlook.com>
 <Z2GvpzRDSTjkzFxO@lzaremba-mobl.ger.corp.intel.com> <CO1PR18MB472973A60723E9417FE1BB87C7042@CO1PR18MB4729.namprd18.prod.outlook.com>
 <Z2LNOLxy0H1JoTnd@lzaremba-mobl.ger.corp.intel.com> <CANn89iJXNYRNn7N9AHKr0jECxn0Lh6_CtKG7kk9xjqhbVjjkjQ@mail.gmail.com>
 <Z2Lg/LDjrB2hDJSO@lzaremba-mobl.ger.corp.intel.com>
In-Reply-To: <Z2Lg/LDjrB2hDJSO@lzaremba-mobl.ger.corp.intel.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 18 Dec 2024 16:03:02 +0100
Message-ID: <CANn89iJQ5sw3B81UZqJKWfLkp3uRpsV_wC1SyQMV=NM1ktsc7w@mail.gmail.com>
Subject: Re: [EXTERNAL] Re: [PATCH net v2 1/4] octeon_ep: fix race conditions
 in ndo_get_stats64
To: Larysa Zaremba <larysa.zaremba@intel.com>
Cc: Shinas Rasheed <srasheed@marvell.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Haseeb Gani <hgani@marvell.com>, 
	Sathesh B Edara <sedara@marvell.com>, Vimlesh Kumar <vimleshk@marvell.com>, 
	"thaller@redhat.com" <thaller@redhat.com>, "wizhao@redhat.com" <wizhao@redhat.com>, 
	"kheib@redhat.com" <kheib@redhat.com>, "konguyen@redhat.com" <konguyen@redhat.com>, 
	"horms@kernel.org" <horms@kernel.org>, "einstein.xue@synaxg.com" <einstein.xue@synaxg.com>, 
	Veerasenareddy Burru <vburru@marvell.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Abhijit Ayarekar <aayarekar@marvell.com>, Satananda Burla <sburla@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 18, 2024 at 3:49=E2=80=AFPM Larysa Zaremba <larysa.zaremba@inte=
l.com> wrote:
>
> On Wed, Dec 18, 2024 at 03:21:12PM +0100, Eric Dumazet wrote:
> > On Wed, Dec 18, 2024 at 2:25=E2=80=AFPM Larysa Zaremba <larysa.zaremba@=
intel.com> wrote:
> >
> > >
> > > It is hard to know without testing (but testing should not be hard). =
I think the
> > > phrase "Statistics must persist across routine operations like bringi=
ng the
> > > interface down and up." [0] implies that bringing the interface down =
may not
> > > necessarily prevent stats calls.
> >
> > Please don't  add workarounds to individual drivers.
> >
> > I think the core networking stack should handle the possible races.
> >
> > Most dev_get_stats() callers are correctly testing dev_isalive() or
> > are protected by RTNL.
> >
> > There are few nested cases that are not properly handled, the
> > following patch should take care of them.
> >
>
> I was under the impression that .ndo_stop() being called does not mean th=
e
> device stops being NETREG_REGISTERED, such link would be required to solv=
e the
> original problem  with your patch alone (though it is generally a good ch=
ange).
> Could you please explain this relation?
>

ndo_stop() being called must have no impact on statistics :

# ip -s link sh dev lo
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN
mode DEFAULT group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    RX:  bytes packets errors dropped  missed   mcast
       3473568   41352      0       0       0       0
    TX:  bytes packets errors dropped carrier collsns
       3473568   41352      0       0       0       0

# ip link set dev lo down  # would call ndo_stop() if loopback had one

# ip -s link sh dev lo
1: lo: <LOOPBACK> mtu 65536 qdisc noqueue state DOWN mode DEFAULT
group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    RX:  bytes packets errors dropped  missed   mcast
       3473568   41352      0       0       0       0
    TX:  bytes packets errors dropped carrier collsns
       3473568   41352      0       0       0       0


So perhaps the problem with this driver is that its ndo_stop() is
doing things it should not.

