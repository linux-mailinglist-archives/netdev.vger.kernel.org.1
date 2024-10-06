Return-Path: <netdev+bounces-132527-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B56F99206D
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 20:26:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B94ABB218D3
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 18:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C04C189912;
	Sun,  6 Oct 2024 18:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q91aauTT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E249C155C8C
	for <netdev@vger.kernel.org>; Sun,  6 Oct 2024 18:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728239138; cv=none; b=ZAUCUVE4OXKd41kflfd3k4BitpIMVh96vUK1P33FwRtqspE6oX8fvmuFWkBxBxLkG/ElJeCdIYye6+zj9BsTHc2w2YPwnqOtwmzKp8kCnhsF7zf80rU+mjFaUBBLoPrXFbHfu8UbLsVbx+4c4AYNVZB+ZaIZtsYEavwQ+babziY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728239138; c=relaxed/simple;
	bh=GOXuA667/KvfNcTRufrKjU1HrvuRDedhckFL/ph6J2s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UHnbuAzATbGygNXj6ZfIFGe13juGNFDQTeQWIuGdqlfbSKZpwLRxJT+1aoOAl5oQvcfFjOOI95D/iKBA7rPIRMX1iehQf/V+pOAsOcpzrIdIq0rmaO2haBHSeROj9K8jjuDOW7kmGNI7dzwLaLViygExYiQrNWqen7Oh8YVzXnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q91aauTT; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-83493f2dda4so153935239f.1
        for <netdev@vger.kernel.org>; Sun, 06 Oct 2024 11:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728239136; x=1728843936; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EOZ/WTGAoOT4W2R2w6YskYNJvK7COpKZCbaU7/u/Lis=;
        b=Q91aauTTqYrdbmcQd7sX8S3KVyqik+B3yCRMF43qOYgDGER0Ebc7LcoLrFE70dL/if
         +jdxGGTexylwfKYPQIg9NM+deYMgfrpDjDagjTrvjhx1worrRtkWw0XMbIXhLF8s8FJ4
         zF+gNEwQ4357qrDi1csTKjLTYj3xylggAiFIY7DwB26hRH2+KW3/tE5ZduHF4sc2Qx9z
         f7gH0Uj+GTVtBzF5FJF/rqSH6928WNAkjYjeNCldGL7Kt72ETgSjC023ql0vx3M74A4g
         BBYjCB7XC3aD58JvcYEBzWykvizhA8TOs/p6odeSf8fveh4WW+D9xrY8YC1FZlR2+w9j
         LLdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728239136; x=1728843936;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EOZ/WTGAoOT4W2R2w6YskYNJvK7COpKZCbaU7/u/Lis=;
        b=jl/UAj/mPVRLfwj+ZDRCnkCUww06IMD9ge77DjNIZBUDlHYUgQyobMpaFdbBrd9z+D
         qDHmT8y/RqLqUbKO3KQLqHyuxys3QA1wLUa53SoCD3HHttM9W3rMkmLuKEtgdcAFGFT+
         OFeLEptfGw53SubQl/oi80J5TGJkkn7V+Gb4ZTNcT+yfvcxWpdBgCAcHAbNWH9+xJEDr
         eRiI32QCWete/QetTuHCe2fZdxNKy0sh2cFWGuDuTnuGKDfKr5uBjAmXRAszpYd23EYg
         hPzq20Gwh9ew5sf3sXVBSRZVGPQEDUM5we3HdlsClN7QzmHmxtB+CDXD9jLdBih/E9z6
         J07g==
X-Forwarded-Encrypted: i=1; AJvYcCWmcDM0ziZixefejI62nJF6dIbXwxAxwTGxUChAuZpWPxPldoMYDi0uMctNE9w/A/l5C964WVE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZCtqc1F33Kg7Kc4XNPdMQHwoNW9ETMujML8y236NVwzuuRIAe
	z1EZ1T1i/tn5I/gen4UNLyIEmKwVv96KeoHNsNXegEeW9h7vtSS7qb7+aILXeSqnrlcz7DFHpKj
	iQK5e+JA3YwDTMzCHXAmOf2/pq6g=
X-Google-Smtp-Source: AGHT+IEINzYP1FuOFzBoJpNRmt/M9CzfUbSf02E/HgWVgKnCgerNVT10nHARx2Jfmk32fshAM8xS/IwDLBkuH+Xy9ZU=
X-Received: by 2002:a05:6e02:148b:b0:395:e85e:f2fa with SMTP id
 e9e14a558f8ab-3a375c3a577mr72028535ab.1.1728239135981; Sun, 06 Oct 2024
 11:25:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240930180916.GA24637@incl> <CANn89iJQDWEyTC5Xc77PEXyxbbvKjm=exb5jKB0-O3ZzZ=W1Hg@mail.gmail.com>
 <20241001152609.GA24007@incl> <CADvbK_cmi_ppJyPwmh77dHgkm=Lh52vtEWddwSAFNhZpmmev6Q@mail.gmail.com>
 <20241003170126.GA20362@incl>
In-Reply-To: <20241003170126.GA20362@incl>
From: Xin Long <lucien.xin@gmail.com>
Date: Sun, 6 Oct 2024 14:25:25 -0400
Message-ID: <CADvbK_e_Etot3nzMC=FEt-cqoWfnER4SVOC5dOm6aH43iME1iA@mail.gmail.com>
Subject: Re: [RFC PATCH] ipv6: route: release reference of dsts cached in sockets
To: Jiri Wiesner <jwiesner@suse.de>
Cc: Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 3, 2024 at 1:01=E2=80=AFPM Jiri Wiesner <jwiesner@suse.de> wrot=
e:
>
> On Wed, Oct 02, 2024 at 04:27:55PM -0400, Xin Long wrote:
> > On Tue, Oct 1, 2024 at 11:26=E2=80=AFAM Jiri Wiesner <jwiesner@suse.de>=
 wrote:
> > > I am afraid this patch is misguided. I would still like to find the s=
ource of the dst leak but I am also running out of time which the customer =
is willing to invest into investigating this issue.
> > Is your kernel including this commit?
> >
> > commit 28044fc1d4953b07acec0da4d2fc4784c57ea6fb
> > Author: Joanne Koong <joannelkoong@gmail.com>
> > Date:   Mon Aug 22 11:10:21 2022 -0700
> >
> >     net: Add a bhash2 table hashed by port and address
> >
> > After this commit, it seems in tcp_v6_connect(), the 'goto failure'
> > may cause a dst leak.:
> >
> >         dst =3D ip6_dst_lookup_flow(net, sk, &fl6, final_p);
> >         ...
> >         if (!saddr) {
> >                 saddr =3D &fl6.saddr;
> >
> >                 err =3D inet_bhash2_update_saddr(sk, saddr, AF_INET6);
> >                 if (err)
> >                         goto failure; <---
> >         }
> >         ...
> >         ip6_dst_store(sk, dst, NULL, NULL);
>
> Thanks for pointing this out. 28044fc1d495 seems to be an interesting com=
mit as far as the number of Fixes is concerned. The commit was not backport=
ed to the 5.14-based SLES kernels, for which the unbalaced refcount bug was=
 reported. The commit is part of the 6.4-based SLES kernels so I will have =
to see if all the patches with Fixes tags have been backported.
> J.
Hi, Jiri,

We recently also encountered this

  'unregister_netdevice: waiting for lo to become free. Usage count =3D X'

problem on our customer env after backporting

  Commit 92f1655aa2b22 ("net: fix __dst_negative_advice() race"). [1]

The commit looks correct to me, so I guess it may uncover some existing
issues.

As it took a very long time to get reproduced on our customer env, which
made it impossible to debug. Also the issue existed even after
disabling IPv6.

It seems much easier to reproduce it on your customer env. So I'm wondering

- Was the testing on your customer env related to IPv6 ?
- Does the issue still exist after reverting the commit [1] ?

Thanks.

