Return-Path: <netdev+bounces-168394-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD0DA3EC64
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 06:57:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 677CB3AFBE5
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 05:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0121FBEB0;
	Fri, 21 Feb 2025 05:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wpdm2Dgb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92C81FBEA4
	for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 05:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740117442; cv=none; b=P17HhT+cNX554ZQsYJnlzVDaSjr4Fb47/eASiWarA3Qvsbh4h4e0VKGP/OqV2WznbG5NURSyOzYdswIexK1Z2EWSVyRFoPUa/fO9aCV2bzciyAkUt4J3fXH45oP1LHoIe94924M+Mj4x1Q3MuqvKE2DjMlNGsZ2pieLDKUds/ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740117442; c=relaxed/simple;
	bh=ehpZZfbi2AF75flpipDr/7bESK6ftfSMA3zivtpaI78=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mvUWzpeQGNsnysNukam/wjpzYZq6WgTgUNY0BlLqXeXuE8ptK/CkzH3x884zS/JVWnvT0iZenvct4CBu4jscvU5XVrZMx3rkF28Jr4fFN27WQMKYXeqdnvBJxrgYjNQ+jMhmFKuwgkMANbJCS9lADoYenwdvdPgRP3V785+bKUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wpdm2Dgb; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e589c258663so2015277276.1
        for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 21:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740117440; x=1740722240; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hBewxCJLhSyYTZDz5rlN63USGkLSk86TbO+BwKjDqTs=;
        b=wpdm2Dgb6e4ovbQPUTKY79UCxXDTXps9lxUSD7PPVlTGh9iTIqGaSiwPOT60t8DDzS
         iK5QtyNd3ZwPKkamA6bDthenlEhBimUQrgF3mTC/zpMhZJCJPP3rENIdjSQjeLZJbOb3
         G6cbMU8riZTIv8+sfN25SuEozFaGqojNPupTHCeYr58XlPUfLi+KKktxHekdvnFSSrlw
         w7SJnvmZftjvLjO7crvYPAf+5ejQTTCTvM/kGdy7vIRyqbKWqVrOUbkA/yRTfL85GtjG
         1lsNQiqG6eVk63e+IxsRBmdHyty0EXuT0xzauyCVe4cyH/nKbE7l3s73vRrK3y5Kj8C9
         We4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740117440; x=1740722240;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hBewxCJLhSyYTZDz5rlN63USGkLSk86TbO+BwKjDqTs=;
        b=X8rSXWkCVSeeloq1vyo+chiN1rbbFMfkW3Kyn/C/ESzXitVXKg1HiniHTimGl0cEWb
         fDFy7r/qIGVk4gMixSXMwQ50v/f2jv7KkxEo0ea5hfn/PulFo9OlQMM3UNaz3uCta20y
         lIdmMto6gh9GAP4UTFFAXqQ74Ej26YWwFu1aHqx+1bpaW5W/lHUBvSs+oijPxE02rFgi
         dvoVkuQMXktW7SZTXUYro3YFSaVgWZ+hoYetOEn3ps1XIoFO1Z5WYcsq01x9VxpDtL28
         ds2QziZ4+2BV8uKWEKRUhxZKg2BApyYhAZj4gIc+MF1JwKj5PkLtdymf2R2YWYdJhal8
         c1jQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCnXO3oeTJU2mNRcO31i/R9uVZvXVT36h9xmoZI5/o8K+7eqHa2TtqB6/f26rA46IQ1sSPPpc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxllz6kv62U1Rf7uBE2BjSyZFuyoZc53mWhbFbga3S5J6qJb/c2
	HYEhdpqtQ7UQxwiZia6k0clCU+WKBS5ipTd0KqNFK9yhV3LoFCZ7BYUQhyM38n1aGCy0UgNYdM5
	aaZxh049y6MmHCDZbfamaDg5EVUlYuLaYd0D0
X-Gm-Gg: ASbGncsUaojEZcXoTB00PkvgQ4k28B4aa2dTonFGFN6cljJ2ZBi0ufUUSHWXuooBbrB
	5eQLw1JR+i5Ekzd3XGH6TwPvA2YLchZVH0hgIbc/NBXTtMW2X1ob+kM4ULRW/wAg6TVHu1UlDiw
	NGCf+vFLHz
X-Google-Smtp-Source: AGHT+IFGgmGLdhl/6umh45K26S9GZkhD9bYD2oQAzttgTTrWX5Gm7a98+2nxYrPQ33yycf1dwLxHOLwf9tCHMDrdVec=
X-Received: by 2002:a05:6902:260d:b0:e5d:b671:8fe4 with SMTP id
 3f1490d57ef6-e5e245b92f8mr1701103276.7.1740117439742; Thu, 20 Feb 2025
 21:57:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250219220255.v7.1.If6f14aa2512336173a53fc3552756cd8a332b0a3@changeid>
 <CADg1FFfCjXupCu3VaGprdVtQd3HFn3+rEANBCaJhSZQVkm9e4g@mail.gmail.com> <2025022100-garbage-cymbal-1cf2@gregkh>
In-Reply-To: <2025022100-garbage-cymbal-1cf2@gregkh>
From: Hsin-chen Chuang <chharry@google.com>
Date: Fri, 21 Feb 2025 13:56:53 +0800
X-Gm-Features: AWEUYZkaKtd9Ka_CJ7ZwAOSKumXyaF7yyb25pQiYedxpLC4hamOj3h32BsBEze8
Message-ID: <CADg1FFc=U0JqQKTieNfxdnKQyF29Ox_2UdUUcnVXx6iDfwVvfg@mail.gmail.com>
Subject: Re: [PATCH v7] Bluetooth: Fix possible race with userspace of sysfs isoc_alt
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com, 
	chromeos-bluetooth-upstreaming@chromium.org, 
	Hsin-chen Chuang <chharry@chromium.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Johan Hedberg <johan.hedberg@gmail.com>, Marcel Holtmann <marcel@holtmann.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Ying Hsu <yinghsu@chromium.org>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 1:47=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Fri, Feb 21, 2025 at 09:42:16AM +0800, Hsin-chen Chuang wrote:
> > On Wed, Feb 19, 2025 at 10:03=E2=80=AFPM Hsin-chen Chuang <chharry@goog=
le.com> wrote:
>
> <snip>
>
> > Hi Luiz and Greg,
> >
> > Friendly ping for review, thanks.
>
> A review in less than 2 days?  Please be reasonable here, remember, many
> of us get 1000+ emails a day to deal with.
>
> To help reduce our load, take the time and review other patches on the
> mailing lists.  You are doing that, right?  If not, why not?
>
> patience please.
>
> greg k-h

Got it. Take your time and thank you

--=20
Best Regards,
Hsin-chen

