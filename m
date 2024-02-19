Return-Path: <netdev+bounces-72952-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC95E85A545
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 15:02:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E5CC1F21F73
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 14:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F72C36AF8;
	Mon, 19 Feb 2024 14:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a1gL2Xyw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE6931759
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 14:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708351360; cv=none; b=SwCAfcSxfjKW3QEbIbZXoK+56XfJfjx8MlZo3PgC+WJEKzLJpqNXKF7aSuzUmIpVsDjO8cjoRIXdY9MsXaJkEucg5aVk7oLxFBeQYh4YKx2vOl1lBnqDqjSxoZxQrqy/ZfDyJDpviWsBt5lR1NuKCiqsX/XHPLCRzg7iSQxy8T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708351360; c=relaxed/simple;
	bh=HXMVypSHIEDdrhpYywFE6bDoQ2YgxnqcdLzy5pO8kBY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PtmoZcY2QHqW7bdWZbmkp/CjORMydqKm/4lKqfiw0fZZsp9rKQWcdmAq9TkEQUpWYbQpJ0rdtT6guvNQ8AiAW4j2BkuK/1eXM/vQlEMViPP0Q4Lh9aAtEI4Ufov3x5BoruPk/lkKWsqV5aePeIwgp1338Vc8eNXOg0Wm5OJNZ/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a1gL2Xyw; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-41265e39b8bso6926385e9.2
        for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 06:02:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708351357; x=1708956157; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wxQ2G2ZSMlMlBUzvWD0qotOMWCkfxBUg6tFE0Q+NBAg=;
        b=a1gL2XywHBEJIXfho1Q4rrzZuRf5wLb2XxCF9WAyskzSJmS2vyoJxe2G4Q/8WwvBv5
         bnHy/o07sdQ/05DNGRlMsHtLx0ruJcVjAQsljw0U3o/31hZhUHDc5BJGJYOxlTE2rNMp
         NpcNHm/6VuMrC9PobcsAUzWyEfU1yO3WpxzVTfn1Tgi3Nsxr2xp1jyErf+87diPVTac+
         HR9U+TbKuIJNU6CDe0pv55YPV1M0kDz9xlgme75JrsbfGn+aDIACR+mw+X+qzRXatkNj
         Keaosx6CF3UCFZ/5xadXR3j0M42SfPFlUvW51n005YHPJUehSTXV2mxOJrNjSg9KdStb
         RN5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708351357; x=1708956157;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wxQ2G2ZSMlMlBUzvWD0qotOMWCkfxBUg6tFE0Q+NBAg=;
        b=JdQjieqGQMgTmAiWLqgQ1RPPbiwR5JUzPtCmI2aLRdFXY4+fFx/ESzGJGXcmGUtbxL
         dxm8urJTVGZgmWVJklV5Ww5PdgAGA4nkdzIXiCEXdwad7Px8uMfuHc06YT6/wB7HFzGR
         LWaRJPfmabt42a+Wqam0RSubJzy+Kuq81Ozoz56Td//KzKE8HCzX4UMco/NuDvoe5zCX
         dl4TfpkEYVdwXuAW18+XBwaAmTyDvWRNlSh3YNqnXcE6UQhJn+A460jwIU8alU0GiXXr
         D8x0voEwV4OntjfSED6dJKzjMctEIx4JtPDN7Wcej8GD4MLRsIcIBZhYik+gAM901hkh
         KWrQ==
X-Gm-Message-State: AOJu0Yx7NijYQnfOKD+pVs2+yfUq7SKwK1+6OAu7SSQOklJUkxcDFHUn
	wTkRb2zlYLeV3opZJgmsHUfEXNp86K3hb5E1XFMjL1IZIbBUuaL1+BUwGo2oF6wvrV1NlTCBJGs
	+umJMtCYa56Yq9TGeXJN9PjBsyKc=
X-Google-Smtp-Source: AGHT+IG0gcUCtxL7Z4gNd7cfpII0Xf8aXmZ7ZkqInCUqEXJBx9c/1UNNdBvAZYqXWTz/r/+U2EdnhPJLIk8MpXvKaYI=
X-Received: by 2002:a05:600c:4f49:b0:412:5652:1395 with SMTP id
 m9-20020a05600c4f4900b0041256521395mr4704433wmq.25.1708351356405; Mon, 19 Feb
 2024 06:02:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1BAA689A-D44E-4122-9AD8-25F6D024377E@ifi.uio.no>
 <CAA93jw6di-ypNHH0kz70mhYitT_wsbpZR4gMbSx7FEpSvHx3qg@mail.gmail.com>
 <B4827A61-6324-40BB-9BDE-3A87DEABB65C@ifi.uio.no> <CAA93jw5vFc6i8GebrXCXmtNaFU03=WkD6K83hgepLQzvHCj6Vg@mail.gmail.com>
 <CADVnQynGsNmPbXkdhy71AnpvfoBwhLi5qWwVJZQK5LiiA3V_rg@mail.gmail.com> <DE7C9FBC-8E67-408B-A1A3-3FE04FC71F51@ifi.uio.no>
In-Reply-To: <DE7C9FBC-8E67-408B-A1A3-3FE04FC71F51@ifi.uio.no>
From: Dave Taht <dave.taht@gmail.com>
Date: Mon, 19 Feb 2024 09:02:24 -0500
Message-ID: <CAA93jw6ycxsz4XvkE3F=MnLvFrBW66buNpCHOwPEn40x5JkpJw@mail.gmail.com>
Subject: Re: [Bloat] Trying to *really* understand Linux pacing
To: Michael Welzl <michawe@ifi.uio.no>
Cc: Linux Kernel Network Developers <netdev@vger.kernel.org>, bloat@lists.bufferbloat.net, 
	BBR Development <bbr-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

also your investigation showed me a probably bug in cake's
gso-splitting. thanks!

However, after capturing the how as you just have, deeper
understanding the effects on the network itself of this stuff would be
great.

On Mon, Feb 19, 2024 at 8:54=E2=80=AFAM Michael Welzl via Bloat
<bloat@lists.bufferbloat.net> wrote:
>
> Dear all,
>
> I=E2=80=99m now finally done updating the document, based on inputs from =
various folks in this round - most notably Neal, who went to great lengths =
to help me understand what I saw in my tests (thank you!).  Now the descrip=
tion should be mostly correct (I hope) and pretty complete, and it also inc=
ludes TSO / GSO.
>
> Comments are still welcome if anyone sees a mistake or something:
> https://docs.google.com/document/d/1-uXnPDcVBKmg5krkG5wYBgaA2yLSFK_kZa7xG=
DWc7XU/edit?usp=3Dsharing
>
> Several people have in the meanwhile told me that this is useful for the =
community. I=E2=80=99m glad to hear that!  I really only started this for m=
yself, just to understand what=E2=80=99s going on. Now I believe I do=E2=80=
=A6 but hey, if this helps others too, this is great!   So, please feel fre=
e to forward this.
>
> Cheers,
> Michael
>
>
> On 7 Feb 2024, at 21:13, Neal Cardwell <ncardwell@google.com> wrote:
>
> Thanks, Michael, for the nice doc! This is really nice for the Linux netw=
orking community to have. I posted a few comments.
>
> thanks,
> neal
>
>
>
> _______________________________________________
> Bloat mailing list
> Bloat@lists.bufferbloat.net
> https://lists.bufferbloat.net/listinfo/bloat



--=20
40 years of net history, a couple songs:
https://www.youtube.com/watch?v=3DD9RGX6QFm5E
Dave T=C3=A4ht CSO, LibreQos

