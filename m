Return-Path: <netdev+bounces-153442-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC6DE9F7FF0
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 17:36:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE7A97A2681
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 16:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15AB9227571;
	Thu, 19 Dec 2024 16:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qUud6Rhi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DBB226183
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 16:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734626129; cv=none; b=Jsx42zbJzRzmLDI3F3TktiDqQaCGU6FG2+zQSzMEF5zAhf4Q6/kzFg1MWONXOi04kfDIxUQHhk4LSb53DSZqzSS2Jf8Swo4hPXAttSgsla4R1QR3sX+0EddBA1Lh4SrJcWq+o/Xzet02J7QGm00x4SXWATI4YLTMwXzBamLSTv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734626129; c=relaxed/simple;
	bh=ufubeb29FHDElC8yaPtF6jskbkriWBTvwYhBfAr9oYI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EhIqFkbZ/ZZruscOfbOyuFCxhLVDK+6V85Tf0Opns2X+OU8f39hNPhlkt4KhzcyfDtdyovA1B3W5V02+d4EoDq1BvM7IpGzmFV8eLTiVGdFN0D52hmZrOAwdnccc5+TYEl2HnW0GW1Ao173x5kXkfb6HhNk8G9DUvj4JmOfuvcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qUud6Rhi; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5d7e3f1fdafso1892975a12.0
        for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 08:35:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734626125; x=1735230925; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ufubeb29FHDElC8yaPtF6jskbkriWBTvwYhBfAr9oYI=;
        b=qUud6RhiyQPHk85JWM9HzsixYwcMqJ3t9QrlbvyG1CK+P2IhJyBW1dFG5OGi+bSn8x
         rzL/JZkhyh83anISxhP6tdU1tErCuxKQIssV/p++0DTMLCU6M9jE1gX4g2Klb4XJARfN
         8tyWA291oUrum8jAhyeKfD42Io/Z+LiK06GA7Vti/JhsFjdR4qAbg6fPsOeRrbseFdqt
         SleCBRC3HNLgv64njccUhqXR3Z6uqqSMXT2P/jmybUIldw5draZRPC1VQMJrI7Dt2Cbc
         PJp7x7IvI8XZybvU+5YVtPGjipQonzI6bNs3d8ulgVWlpM5xVOhpu/++jJ3u+QEPRbrA
         FuhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734626125; x=1735230925;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ufubeb29FHDElC8yaPtF6jskbkriWBTvwYhBfAr9oYI=;
        b=Fw2I/iBQV+kRJ0jfFacjwJb8v46ZicqASUBhMhwIA4Z3djSONvtdihDSi5U2H2CalZ
         17it8bjzrwlJ+RKnzOGU1bubjU+st36M83k68YfWuVYQfsUHPQ8eh14J3zPrCp6fMi2T
         fkMkU/ATam0+YsUv3Upl08NTUsGNoP4NKImxRLTFCdc8CE6ZMd6Z0UsFxKILVViyaekg
         s1mUYlDmxFpP/wtklokFzBJQJKOivVPN8P0gIRrfP4/Rh0R3lzGrWUkynBOspFOlyYEc
         9euyqYhpcwhyIiQLFCfecE3gZ5Q0TH2H/IYc4/PdTJ+8qaZiUDGPz116Dn27C2oQrtT4
         Muzw==
X-Forwarded-Encrypted: i=1; AJvYcCVxU3nMCXPhBZmtr7wvHXMeZ0ybKyvU3itdR8pwp742VYyHD4ztNrz9ilxG1bjgkCAqoPD92XQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRAVk6vtz1OLsS7PyF+GWrRqTDnGmodFORiospcAd0R18Yy2ay
	FHJP8SJvbp44iJyyMNuzt7iAocKhFA8xMNNQ8mP7a7RMYFiq8Mt5TZh+5J3RJTBIsa2O18LKQme
	54PaFAH3UMjQ/n2vKZNsnA0dCjnMLf+aCJjB+5KRvHAijETuy6JqL
X-Gm-Gg: ASbGncvX7+pay07dMuuePYF+INl3dLUyUUppV9lI5+XbnD+Z3N2R8GD3yVBIDwPJTmT
	9+mgbsvfNWYio9AyRtIJmCH9I9aW0w4CqjhJIX5y/Wd8/co6W6I1r/vSl6Az9OOObAu1BFKhd
X-Google-Smtp-Source: AGHT+IHVKRu1dHHdnlsKwYbT6ev7Not+pSkED6sSLoeOJVonVDXzScZ4y9vJ5r0sMqyzqXx9n7lHBE+w4e4VWq/mRao=
X-Received: by 2002:a05:6402:40cf:b0:5d0:c098:69 with SMTP id
 4fb4d7f45d1cf-5d7ee3e4aeamr7563626a12.16.1734626125372; Thu, 19 Dec 2024
 08:35:25 -0800 (PST)
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
 <Z2Lg/LDjrB2hDJSO@lzaremba-mobl.ger.corp.intel.com> <CANn89iJQ5sw3B81UZqJKWfLkp3uRpsV_wC1SyQMV=NM1ktsc7w@mail.gmail.com>
 <BY3PR18MB472105E5D09B8FE018DBFC15C7052@BY3PR18MB4721.namprd18.prod.outlook.com>
 <CANn89iJ-vz8dfrHv2QChiQWUk14bQJfykTTYLMmOuHejgii4nA@mail.gmail.com> <CO1PR18MB472962C9345E15B8F1988E25C7062@CO1PR18MB4729.namprd18.prod.outlook.com>
In-Reply-To: <CO1PR18MB472962C9345E15B8F1988E25C7062@CO1PR18MB4729.namprd18.prod.outlook.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 19 Dec 2024 17:35:14 +0100
Message-ID: <CANn89iKDN=Ocfgthm2ws5mPqDVFyZpQrYzEB39x1YHCGNSGwFw@mail.gmail.com>
Subject: Re: [EXTERNAL] Re: [PATCH net v2 1/4] octeon_ep: fix race conditions
 in ndo_get_stats64
To: Shinas Rasheed <srasheed@marvell.com>
Cc: Larysa Zaremba <larysa.zaremba@intel.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
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

On Thu, Dec 19, 2024 at 5:28=E2=80=AFPM Shinas Rasheed <srasheed@marvell.co=
m> wrote:
>
> Hi Eric,
>
> > On Wed, Dec 18, 2024 at 4:25=E2=80=AFPM Shinas Rasheed <srasheed@marvel=
l.com>
> > wrote:
> >
> > > Hi Eric,
> > >
> > > This patch is not a workaround. In some setups, we were seeing races =
with
> > regards
> > > to resource freeing between ndo_stop() and ndo_get_stats(). Hence to =
sync
> > with the view of
> > > resources, a synchronize_net() is called in ndo_stop(). Please let me=
 know if
> > you see anything wrong here.
> >
> > We do not add a synchronize_net() without a very strong explanation
> > (details, not a weak sentence in the changelog).
> >
> > Where is the opposite barrier in your patch ?
> >
> > I am saying you do not need this, unless you can show evidence.
> >
> > If your ndo_get_stats() needs to call netif_running(), this would be
> > the fix IMO.
>
> The synchronize_net() is supposed to sync all previous calls of ndo_get_s=
tats() and wait for their completion before closing the device.
> Again this seems to be the v2 of this patch. In the v3, I have provided t=
he warn log as well in the commit message for reference, in answer to
> the changelog comment for more clarification.
>
> As I stated, this is needed because ndo_stop() races with ndo_get_stats()=
, and a 'lock' or a similar mechanism seems required to alleviate this.
> Fixes in the same vein seem to be common, as I do see other drivers utili=
zing a lock mechanism while retrieving statistics to resolve the same
> (ie; race with resource destruction in ndo_stop()). So, just to state, I'=
m not trying to do anything new
> here.

A precise lock is better, it is easy to grep, if really other drivers
were not able to fix this in a different way.

A synchronize_net() without explicit details is very very weak.

>
> Can we please comment further on the v3 of this patch? https://lore.kerne=
l.org/all/20241218115111.2407958-1-srasheed@marvell.com/
>
> Thanks a lot for your time and comments

I tried to say that adding a synchronize_net() call in ndo_stop() was
not needed.

I do not particularly care for this driver, my concern is that
copy/pasting is going to happen.

