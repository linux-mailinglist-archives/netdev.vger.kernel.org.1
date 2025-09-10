Return-Path: <netdev+bounces-221675-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D06B518D8
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 16:07:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7ACE188BD54
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 14:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D2FF3218AF;
	Wed, 10 Sep 2025 14:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XsCiK84Q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F752D1F4A
	for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 14:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757513066; cv=none; b=Jgfr1skoD7xJqShJy8YyKZuimU8A/NyYyCvBjggVVHv/eOE19FAIjaK/mU4EtfMm3kJFD/4ge2m1xUgimLfv1aFqVRzk83Gx8Np23bN7zcseWQae49QiWN/OAgQivVUFFqAfJSQYyZabVuz4TBbD6FgphKsgKhyZVf1aKJcI4Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757513066; c=relaxed/simple;
	bh=hnkE5ws+Y7Sz5Z8rOOEgDXYKE3Ksd1N0H8xQlwvp9vA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lVqzKfV8rinrwLXJvRVx/1F28IsFXUN9k9vFvx7cbgEgP550qEMF9BZ593KxsozUyV3oCgSjHCKqDc4gFjvRY0I3xXvKLv/2pn2PRfzghFoMLlIHzb6MxVUqmfO+0dT+eun26aYZ2t1ODBMH4ic9HPzcP80jLAhx1KCn7uU+FGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XsCiK84Q; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4b600575a54so25280581cf.3
        for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 07:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757513064; x=1758117864; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wZxTcd4w8teArmJQkcEMWpOhKDkunR89B3LxRhXaljE=;
        b=XsCiK84QQZizxvdE6v5/mAG9wYFLcc5xTJ+4kJrIs6V95B5FxGClPpFJinu4K9vh8I
         WncbLjWe1rP76U1ytldVwmV94TOtPPFI5k/QDYMebLDlaY4a5uB5fOcFWb5ErHv/DaN/
         GFU2p2X9ji8fCovMYZ0AG76HtuprAwQI1vs7cHIi6umIQXKJMYfs132U0lJUVz9J/r0P
         R+6Gq704G2FWFqLGZc6/GL/iXE2i4UJVCEyJp0tYNi5BkQP2kJ1Th5FBFnOAkSBIHbk0
         Jo7yGo2l55P4G3neZJRaoc8pNNzAjtvZC4pucgxectQDUBk+8x6wz3UyyHli/sT93gAz
         aygw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757513064; x=1758117864;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wZxTcd4w8teArmJQkcEMWpOhKDkunR89B3LxRhXaljE=;
        b=Prk0Ips2nWf1iZTxdwaaGFBdxzkSTzyn7XerFnDbhGdSjoMf+KRQJIbfqy+x7WacuP
         K3htaaIFA1NWYsRXJHWWpDHbaTNdEG08OjK6kupR9GVdpBbhmsEGi7E1FqQW+9MtLkTe
         Vo3eL9qRGeunvrKeqqHfBzPcrAQkU1YHGSbWacX6umbTlWvWXyFj6xb1UO9ChhCq/NJu
         am4zpsEPuZ+ZxGnn7L/4qzxFxolmPYWitcYdsuRzh+meycNyJQd97KKAuo91saNP8ww2
         9Xm4ZTy+YdeZVJjcDKNihLDIf5a7XeU+kU1fmLoJpMVis5LGV/5CeRi0ZeEbUcYTYuC4
         X8Hw==
X-Forwarded-Encrypted: i=1; AJvYcCWzDhNxFOVd4t7taG8J3U22eHTUv+65zVOyORhNkwaep8mmyIUBwJ3FihFrjNYR8xgFocwUUPo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYN0+qjxGkitW0lgTsnuceF4ZSgh4aDQxgdlfpg6eSHhDrhysy
	iERMlX6b/91f0zIIZYr1rxwyp/n5LxXalkniGSJIn0nNpKVjWUwvQCqL4InGyHYbwFSkZbnYMsd
	b+yHv2fkqdA/xJF51dFGCYGZCtGT8swYu1JKYZ0Ui
X-Gm-Gg: ASbGncvYEMvX55GfGRvLvS9V0v6xL1uUmMMTQ1+3QlYsPpw/qqyN+xn6rT5b2YJwRMd
	kLtLC8vh6W/yd/ALdf3WGv2pfokLJHY8SzTvGgHlt6v5mc1lL5sMzY0DPt64OGYFBuYGX2UBKWZ
	fyzGTkn1R0FEwMaSc9O3X6dYRKqNkn6SNbwQnb0rJUnpaT9RhmcUL4UPXKBrApN590jHnf1vAFg
	S1YNorOMCZ148lyxCIMWK5S
X-Google-Smtp-Source: AGHT+IFxaUVTb/vJtdUbM8G8/Iz0bbRq8OjzMiV0xBB/Py/J9WyTJORBqkbOaNFMomu73ltfyN0EE3tghbuWR+s9nxI=
X-Received: by 2002:a05:622a:1808:b0:4b3:61b:58f7 with SMTP id
 d75a77b69052e-4b5f848ce23mr167804181cf.73.1757513063181; Wed, 10 Sep 2025
 07:04:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <DU0PR07MB91623D4146367CDEABC5E381F80EA@DU0PR07MB9162.eurprd07.prod.outlook.com>
 <CANn89iKy+jvfifGQX8EBomWmhzQnn7j7q39uqd23NX0vvk1nFQ@mail.gmail.com> <CADVnQykpRGLzri3nDu9dJmXNUBqz-Q0YsqY-B_r4Pj0VOg44ZA@mail.gmail.com>
In-Reply-To: <CADVnQykpRGLzri3nDu9dJmXNUBqz-Q0YsqY-B_r4Pj0VOg44ZA@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 10 Sep 2025 07:04:11 -0700
X-Gm-Features: Ac12FXwybpfcZl0c1iXcz0GtYLGiS4KU4z9PTU6y1yLXrfpBknn19_493oxGeSg
Message-ID: <CANn89iJLjyzn_=E7fHXJGM1Geg_3WnVTsqVfxGAu-QAyBByHAQ@mail.gmail.com>
Subject: Re: TCP connection/socket gets stuck - Customer requests are dropped
 with SocketTimeoutException
To: Neal Cardwell <ncardwell@google.com>
Cc: Ramakant Badolia <Ramakant.Badolia@tomtom.com>, "kuniyu@google.com" <kuniyu@google.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Ozan Sengul <Ozan.Sengul@tomtom.com>, 
	Raja Sekhar Pula Venkata <RAJASEKHAR.PULAVENKATA@tomtom.com>, 
	Jean-Christophe Duberga <Jean-Christophe.Duberga@tomtom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 6:58=E2=80=AFAM Neal Cardwell <ncardwell@google.com=
> wrote:
>
> On Wed, Sep 10, 2025 at 6:16=E2=80=AFAM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > On Wed, Sep 10, 2025 at 1:49=E2=80=AFAM Ramakant Badolia
> > <Ramakant.Badolia@tomtom.com> wrote:
> > >
> > > Hi Linux TCP Maintainers,
> > >
> > > I am writing to get insight on this bug report - https://bugzilla.ker=
nel.org/show_bug.cgi?id=3D219221
> > > Unfortunately, we at TomTom have also been stuck with this issue for =
the last two months and our customer requests are getting dropped intermitt=
ently several times a day.
> > >
> > > Currently we are using Linux version 5.14.0-570.37.1.el9_6.x86_64 whi=
ch is causing this issue.
> > >
> > > As reported in https://bugzilla.kernel.org/show_bug.cgi?id=3D219221, =
we don't have possibility to rollback to previous working version.
> > >
> > > I want to check if you acknowledged this bug and what solution was pr=
ovided? Which version should we switch to in order to have this fixed?
> > >
> >
> > No idea. This might be a question for Redhat support ?
> >
> > I do not think you shared a pcap with us ?
>
> Looks like the bug report at
> https://bugzilla.kernel.org/show_bug.cgi?id=3D219221 posted a working
> and non-working ("not working TCP connection PCAP file"
> non-working_tcp_packets.pcap) pcap file, though there was only a text
> update for the working case.

This was a one year old report/pcap, I was assuming Ramakant Badolia
had maybe a different issue.

What I saw in it was a suspicious/tiny initial RWIN of  585 bytes in a
SYNACK, of less than one MSS...

 00:00:02.896476 IP 10.51.51.211.57738 > 10.51.51.75.31421: Flags [S],
seq 3801883815, win 64240, options [mss 1460,nop,wscale
8,nop,nop,sackOK], length 0
 00:00:00.000065 IP 10.51.51.75.31421 > 10.51.51.211.57738: Flags
[S.], seq 1230473431, ack 3801883816, win 585, options [mss
1460,nop,nop,sackOK,nop,wscale 0], length 0

Thus my recommendation against tiny and non functional SO_RCVBUF.

