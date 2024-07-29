Return-Path: <netdev+bounces-113677-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB3593F8AF
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 16:50:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC2681F2283A
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 14:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A280015574C;
	Mon, 29 Jul 2024 14:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hiK2xihB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0928D1534EC
	for <netdev@vger.kernel.org>; Mon, 29 Jul 2024 14:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722264577; cv=none; b=ObIoYlxMX6GS+erZsXjJWizhLM8L3fukn/1hAyYnR0LUvpLQmyD/ahoIxUwt3LO3QwuWbzkElWWZYorMHTAt2XR/6mWGqYJCKezY7wcOOFKan0VanUSF24kH/GKb3aWWZMS38XYGp+sX9XsnGGaf2KmDILxcSeivLUARkKPtYR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722264577; c=relaxed/simple;
	bh=++WSlZjLNBPQnFpDSEBh69vxCtXUzVS0ttuuyBKh2jY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FkHwngVqfgT/W0YWzbeqoCnerw4FhKaah3jLnlZWT5acapqxyr7yDIQNyCcXDMH2AFLCJo2juqi62rWsp5SDS4oFL8YnbmWRG6SxsjVxAEgDmKqSem0GhA+UPXW/xSHXaYMBw21oGo6SOBLEQ15utbySMh1US5A57a7n1a0rxi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hiK2xihB; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-45029af1408so181181cf.1
        for <netdev@vger.kernel.org>; Mon, 29 Jul 2024 07:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722264575; x=1722869375; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=++WSlZjLNBPQnFpDSEBh69vxCtXUzVS0ttuuyBKh2jY=;
        b=hiK2xihB3M+gpI3u30th0ct3QUinMpyZYvY0INrYc2Z3ZNq3yVT+7p4W5qY+Ey/KM+
         Omfol961YzkQrvwjBJuV+afsS6bI8NoXlAXv/9J7BENjaMcUzCKIAjWmDpP5SUAXsaGZ
         Xgte1d8ZFRyHPs8vyAC7psTb9JwHuDucneeBDEfdcxrk0CmaBuCodiWT14g5gU+jlg1d
         O0nocxb3Y1E/hvgDLcbR1LPsvgRuiGT4j1CKZYxWa83MEl1F193NPbgrLfOIOaz1AQGG
         7wWPw95QTq5cZ9yU1hp1+jG55mGbbxTnqPmoRK7QzP0LHoFQEA/I+EVJ/WCZ8lmBsJs7
         YwxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722264575; x=1722869375;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=++WSlZjLNBPQnFpDSEBh69vxCtXUzVS0ttuuyBKh2jY=;
        b=IuK0/08Z42QxuZO60fFJr6W6+J69op/UGdwHbv+FyYKVCSQmi20fvKuAILzY3jBQuz
         pT8OfI847v0ZxWCaAHbuSBstHYhA6TIXaMegOO/Kd2OyFGSaBJcyv8bZGAGuT5lSnQ0w
         Yk3jwjKfzRHkPzvcECh9kKUZdviWXfQ7Rt6B/kDjun6z4QppFYxOpAH7iyRhbh0I0rCD
         Qw48JT9jZXIQtB5ADKWtHw1woRrUAHjfoBzM71ZU4TMr/51/gtmsoR0blk6K5sLaJWNj
         o1pT/KHp35yRMTu51TCitM5Bmd+V8hN56Ob86hVMDFboQoAN1QR5zfcbLgmn1Y+BnL/S
         CqIg==
X-Forwarded-Encrypted: i=1; AJvYcCWjO8hDeu0qd9SX2leUU/kvShBxouEMKvSFOzUryteZlSGwNBeALgKTAo8a2H+uce28FRydkWi9QAYUqsDicm8ECCS0SeW+
X-Gm-Message-State: AOJu0YwbWOiADwZHBvF02Czc2n2xDFxM3TRocztYbIqHMij3gOMqrqMn
	8wq0FVSXZ3G0fMOhCyXdNOq+9t1GI0Pqyponw56RVggdHA5hLZp1rpGPmxOgFB5TYtYkhvTxnqj
	/1Kd5Cwj6doW5WH3QD4loQKiDcdAiqKSl+88i
X-Google-Smtp-Source: AGHT+IFKuRi4OWWF6S6gDlbmR4lb5fZS89aXg/cHCQglb0SGwchdz6/trtsfoJeAoYgRpe5UhrXlaUildjNIq1I4MK0=
X-Received: by 2002:a05:622a:148:b0:44f:e2c1:cc75 with SMTP id
 d75a77b69052e-450329b7529mr10831cf.8.1722264574631; Mon, 29 Jul 2024 07:49:34
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240726010629.111077-1-prohr@google.com> <20240726102318.GN97837@kernel.org>
 <20240728071746.GB1625564@kernel.org>
In-Reply-To: <20240728071746.GB1625564@kernel.org>
From: Patrick Rohr <prohr@google.com>
Date: Mon, 29 Jul 2024 07:49:18 -0700
Message-ID: <CANLD9C0hbOUEmh=Qx6f7nTRD0frkPYq_ki4rbF115e2+sFNPiw@mail.gmail.com>
Subject: Re: [PATCH net-next] Add support for PIO p flag
To: Simon Horman <horms@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Linux Network Development Mailing List <netdev@vger.kernel.org>, =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>, 
	Lorenzo Colitti <lorenzo@google.com>, David Lamparter <equinox@opensourcerouting.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 28, 2024 at 12:17=E2=80=AFAM Simon Horman <horms@kernel.org> wr=
ote:
>
> On Fri, Jul 26, 2024 at 11:23:18AM +0100, Simon Horman wrote:
> > On Thu, Jul 25, 2024 at 06:06:29PM -0700, Patrick Rohr wrote:
> > > draft-ietf-6man-pio-pflag is adding a new flag to the Prefix Informat=
ion
> > > Option to signal the pd-per-device addressing mechanism.
> > >
> > > When accept_pio_pflag is enabled, the presence of the p-flag will cau=
se
> > > an a flag in the same PIO to be ignored.
> > >
> > > An automated test has been added in Android (r.android.com/3195335) t=
o
> > > go along with this change.
> > >
> > > Cc: Maciej =C5=BBenczykowski <maze@google.com>
> > > Cc: Lorenzo Colitti <lorenzo@google.com>
> > > Cc: David Lamparter <equinox@opensourcerouting.org>
> > > Signed-off-by: Patrick Rohr <prohr@google.com>
> >
> > Hi Patrick,
> >
> > This is not a full review, and as per the form letter below,
> > net-next is closed, so you'd be best to repost.
> > But I will offer some very minor review in the meantime.
> >
> > Firstly, please seed the CC list for Networking patches
> > using get_maintainers.pl --git-min-percent 25 this.patch
> >
> > Secondly, as noted inline, there are two cases of
> > mixed of tabs and spaces used for indenting in this patch.
> >
> > ## Form letter - net-next-closed
> >
> > The merge window for v6.11 has begun and therefore net-next is closed
> > for new drivers, features, code refactoring and optimizations.
> > We are currently accepting bug fixes only.
> >
> > Please repost when net-next reopens after 15th July
>
> Sorry, I'm not sure why I wrote the 15th, I meant the 29th.
>
> >
> > RFC patches sent for review only are welcome at any time.
> >
> > See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.htm=
l#development-cycle
>
> ...

Thank you, Simon! I will follow up with a v2 when the branch reopens.

