Return-Path: <netdev+bounces-131705-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D560898F4F4
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 19:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 133861C220D1
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 17:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F4F419B3F9;
	Thu,  3 Oct 2024 17:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0RaiNPX9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23E01A706F
	for <netdev@vger.kernel.org>; Thu,  3 Oct 2024 17:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727975780; cv=none; b=gYGo6fB2Le+sWSIDz41Aie3Vyn7mUgViS1WB64YXJSgiRB6uG11+LG+KL1mWipTwe7AMoHdQ8ZDe/Y/RNJ/P31vhV1e+1qxTuBrxPoQmi8WgBNwKL66H2iih8o3KthfWoBuPKSnR642HspVQOaXfY/uvf7n40pspteIPI76es5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727975780; c=relaxed/simple;
	bh=oBWAOxTJg0yaB5zjKAtG0+tumBmdEJ4QO3UVHRcx0hk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xj0OJO4bhsISMntkIXa5Fyuba3syUajE6A9BEE1p+IoumY19YoR10tZOqPluFTaIpOnbTE6ylpm2DIkijWwyN0p+Zvd+lI/Xm8p72ho/CDlQXN79+uD5fFXRBkf8m0sa0vSATRRSHktjRgJ3hFRetHWTGuWQiEhqHPKYyEJQAvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0RaiNPX9; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-45b4e638a9aso11111cf.1
        for <netdev@vger.kernel.org>; Thu, 03 Oct 2024 10:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727975778; x=1728580578; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oBWAOxTJg0yaB5zjKAtG0+tumBmdEJ4QO3UVHRcx0hk=;
        b=0RaiNPX9M4YbkDDQp14kMfSrJX7Ai56EzX+6YyEnxWIf+NJTJYBnthSylhCEQ0xqAY
         n8J2RA7adTy+UAi2COtcl8r4Sx5s5ON72w+0+gAtlrxXQMyZRBNsBtlhiOLswLpQo1on
         uRCCZTA6ecTPQ1TmdgobgdUsveI0DsP2kJ4eOtAcxBhdQbHpC627Ir4yiuRVY4Nn8GeL
         RxCpE9W6lf/HFndD+ltLi5W+BK+4NjboPJZ+lv9gNgDbZ8EnibCz8+JJBdrOVwgaFCog
         l8UMBqCJ8lIlE/+hV3nC0FpWf8+vgVZuYecksWPzrJlWrka5qCS6w45NNQ8eYkY3pvVE
         Be2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727975778; x=1728580578;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oBWAOxTJg0yaB5zjKAtG0+tumBmdEJ4QO3UVHRcx0hk=;
        b=MRT8Blf2tZmg3zObkAgHVJGDOVXaErtEM1Xw/jNUIsPuQJ90bQZoa7MC0Tv3ftEAJ8
         nkjXo62rKlnuAcKQ/fInrvBsmh34LiQoNkqHfcJ0+GPmD4ntnbLwmfurn0WEAQmQaqsC
         19f2vh5nAEDJrhEY4WtWGh57Fj7squdcFpSfSYjQ3jYE0mlbXt3Xj3clXO0Bcq5u19kb
         x+yK9upb/NlH4IYrHKpYs/XDeYJtQr52qhp3cmh5vF1mQV8yesugXgga5Jbcviji+2kk
         0lM/87xdBV5e0jdAAbeFSilmvumCduwKtFqiZPzyHL5U2AiV8xXba1B7GeRBS5/6mEZU
         1tZw==
X-Forwarded-Encrypted: i=1; AJvYcCU7ZIY9f3XuUcek5V+6wToVBnWK8C9i/r4LzwKDXwPSpjCxFGDLId+BhvU5D6wNFqDM+4AP+qQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/vBF2oMSLMIhFP/6bCBfpZbunci1b3vAiFK45HoZcOQLH9j+y
	6v3LKKjZTW6Jyq5UgobaZKJshL/MWIVAqfGocBXvrBuNeelGvmZlijfYLuj4Q53iMLAdGU3HLCh
	1Mm8HFTnNvVn4w3EQYQwwVLDYagS7kGGJNGyv
X-Google-Smtp-Source: AGHT+IERggIh9ieU04M0Hc3tYG++OpoHrXo3ZgF/tzKNG/XWHSRUdsjeyJIACvSyaSCcDy0C9liUjh/YZVVjGfFkKrY=
X-Received: by 2002:a05:622a:56c8:b0:458:1587:3b79 with SMTP id
 d75a77b69052e-45d8e2a441amr4128661cf.26.1727975777650; Thu, 03 Oct 2024
 10:16:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240930171753.2572922-1-sdf@fomichev.me> <20240930171753.2572922-7-sdf@fomichev.me>
 <CAHS8izP-Dtvjgq009iXSpijsePb6VOF-52dj=U+r4KjxikHeow@mail.gmail.com> <Zv7KsD3L1AicrjRJ@mini-arch>
In-Reply-To: <Zv7KsD3L1AicrjRJ@mini-arch>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 3 Oct 2024 10:16:03 -0700
Message-ID: <CAHS8izObANcJKXQ216xUvrORn3LA1Fzpu2kCOoZ3fRtq=_Oyww@mail.gmail.com>
Subject: Re: [PATCH net-next v2 06/12] selftests: ncdevmem: Switch to AF_INET6
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 3, 2024 at 9:47=E2=80=AFAM Stanislav Fomichev <stfomichev@gmail=
.com> wrote:
>
> On 10/03, Mina Almasry wrote:
> > On Mon, Sep 30, 2024 at 10:18=E2=80=AFAM Stanislav Fomichev <sdf@fomich=
ev.me> wrote:
> > >
> > > Use dualstack socket to support both v4 and v6. v4-mapped-v6 address
> > > can be used to do v4.
> > >
> >
> > The network on test machines I can run ncdevmem on are ipv4 only, and
> > ipv6 support is not possible for my test setup at all. Probably a mega
> > noob question, but are these changes going to regress such networks?
> > Or does the dualstack support handle ipv4 networks seamlessly?
> >
> > If such regression is there, maybe we can add a -6 flag that enables
> > ipv6 support similar to how other binaries like nc do it?
>
> As long as your kernel is compiled with IPv6 (which all kernel in the
> past 10+ years do) and you don't toggle net.ipv6.bindv6only sysctl to 1
> (which defaults to 0 and afaik, none of the distros change it to 1),
> AF_INET6 should properly support both v4 and v6 even if you don't have an=
y
> v6 environment setup.

Thank you for the details!

Reviewed-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina

