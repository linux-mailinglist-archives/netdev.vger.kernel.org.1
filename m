Return-Path: <netdev+bounces-198506-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C405ADC753
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 11:59:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE5363A4327
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 09:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03063293474;
	Tue, 17 Jun 2025 09:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0TjXq9ws"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1BF27380D
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 09:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750154379; cv=none; b=uzTLeOdsLpAqvtXx4y2YDSCkT3oKi3QNRvoMWxbl3xMl815ev2aAkGUbHuTfK+vO2s9LLBRDSJyS1saou1Hv6s3rDeq8wU0RuazilEGlv12x146hQzFGSpTgSfcP/XAV32+yX4CptGO0IGXhQldL7DzXWNZpqtCe50Y6Y+KmfHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750154379; c=relaxed/simple;
	bh=T11Yz+QUum6W/Sp7RvfgeObytTx3A4fLEIOKNpWe1W0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pPTglzCNd363fSClxBAcPV7tQvSmotbpFTJAmGa+YbUstTuaGh0G6hVj+JrJpEd/ntkOk1Y14UDWT3V7SoT/shOC6ytU4yJIuCAu0h2Ml+dWsxvREap3Jdm/nQC6L9vnoxVnHfbPZrC+Ypiy4cdJvkNAKa0p2xBcl7OUNGI/i6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0TjXq9ws; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-311d5fdf1f0so5167039a91.1
        for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 02:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750154377; x=1750759177; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T11Yz+QUum6W/Sp7RvfgeObytTx3A4fLEIOKNpWe1W0=;
        b=0TjXq9wsqHxffuRU1c2RR3tmQWMF3rgMBTSDAo9A/RLJjl0o6leFDXIaZdZtjY1xU0
         RShNNws1gi6oJK/iG1MnJMBfexe4U28MD1AhI2ZbxliYTZ0FMQxxP6F8hDSnvp8YT3AE
         iZCXg6bqiczFP9ms8kUlOCQ6J/fYs2ALe58KBZBV/QhPRqrs8iwdvhvXgX9lDhWQEqga
         EjhzdnNnx+1+X2T5Cx0VAdmZ5c+IqTJONdibdkyxozeNKAVNjJ9BCphcORfcz1xRrxNu
         wg+GYtQDp6udbBNvZLfXj21lGHzYfrZOZDXFhHep/4JL/cuQAG2iMnpBqlYijnou7H0X
         DCGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750154377; x=1750759177;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T11Yz+QUum6W/Sp7RvfgeObytTx3A4fLEIOKNpWe1W0=;
        b=tBFqPNekLEMuBhhEskHmrn+Xc6trsNGoO5aBn3HkS9ILIRn7LkugqVLeuTLH2Cd8df
         bWahF4e7t/3tLvLSnK+M1Sxw96BrNP5zKvuNAYbc6AbmZl6jX40K98v5c4k9pQfaHHNm
         Gz3VP1Gd0iPJyUOOawrUIMpXaDBvWiTVxA+Gj9jDkqVCIhhf34UVujLhwMvlGw2ty1v1
         0fylRfDGllWkxs+/ULN6qylGpeqTfLLVFVunRF/8WKJHxIbMefQ67tDDtoocJrS/q4Ev
         TrW3Yy2suoGWKY8wcj72mcyXHZZBgT0GFoWYpcmMuFfnq9JyAyA9LeDeSKS3JxsH5gqq
         4yZg==
X-Forwarded-Encrypted: i=1; AJvYcCXFTRLoRFuSI8+pbN473BBWN6xHNQCcgQszyn/y9WRLu2O1fplTsq8aVzeQBtAkbH2pRPNaAxs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz86Y5V1cKjBPajvTkctEKdu9xwI8Eg5zPSP85uQkDk2xLfV0NW
	KKCqt5nQk3eJp36MJpvWH8nLcJ6mMRIdif5dXfjsKbNLXmnDOL73S/UgvEy0xgN7nc4LDmHzU+7
	5AYOPHWNpMpoARVhxd0ZSntS5dluZtQ5aa96CtvFE
X-Gm-Gg: ASbGncvzYRJ9Pw0rmDY7Vl3CXJI8JPYvd6Rjv9IizeFvcWwRtSBcmYNBeFb1CvYUXK7
	U6/da9oZCWcct2xKqDZKN9jVj86RSYZy7VOYSA0GfT25XHad1vjfQ0aYCWEZNACQAS/h77seh/C
	bzwyIhS2K/ljabERp/foQc6/vqRbWjJu3LSZvb8vdv5iQlt7zukIn59ZXuVp5YIGy+TMR+u9LM
X-Google-Smtp-Source: AGHT+IHNeTT68NvBOK6LqdXHKIzzjhA446o1WLmbvK+HGnNpsJHS6OxLDqwqwuxWZSw59pGNsBTCbNKTHvryBpKg8jQ=
X-Received: by 2002:a17:90b:3a4b:b0:313:5d2f:54f8 with SMTP id
 98e67ed59e1d1-313f1e22fc8mr22826886a91.33.1750154377458; Tue, 17 Jun 2025
 02:59:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6850d3bd.a70a0220.395abc.01fa.GAE@google.com> <CANp29Y68ZaQnb0R2fZSLjcCxiOE3uZyW4b7wLEYMAycF0WHNUg@mail.gmail.com>
 <97d6493279ab5c63e8844e8b0f349b2528d2832b.camel@sipsolutions.net>
 <CANp29Y5+W426u0jUz0PT=zVde+QqSD9H1fLpTuaKSzCLrt5FcA@mail.gmail.com> <49456d11ed8d4ff3adc71286b17dc657a6db131b.camel@sipsolutions.net>
In-Reply-To: <49456d11ed8d4ff3adc71286b17dc657a6db131b.camel@sipsolutions.net>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Tue, 17 Jun 2025 11:59:24 +0200
X-Gm-Features: AX0GCFtZpFbzd7aS93ErUYuYC0VlHJTlAFEcYitrHyt4jKcV8u_uptKDLdvv-rk
Message-ID: <CANp29Y4hwwLhju3=AVeNuGt-yCwR_Rey1ML_Tkc5sTFzu55yUw@mail.gmail.com>
Subject: Re: [syzbot] [wireless?] WARNING: net/mac80211/tx.c:LINE at
 __ieee80211_beacon_get, CPU: syz.NUM.NUM/NUM
To: Johannes Berg <johannes@sipsolutions.net>
Cc: syzbot <syzbot+468656785707b0e995df@syzkaller.appspotmail.com>, 
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 17, 2025 at 11:50=E2=80=AFAM Johannes Berg
<johannes@sipsolutions.net> wrote:
>
> On Tue, 2025-06-17 at 11:48 +0200, Aleksandr Nogikh wrote:
> > On Tue, Jun 17, 2025 at 11:43=E2=80=AFAM Johannes Berg
> > <johannes@sipsolutions.net> wrote:
> > >
> > > On Tue, 2025-06-17 at 11:34 +0200, Aleksandr Nogikh wrote:
> > > > #syz dup: WARNING in __ieee80211_beacon_get
> > > >
> > >
> > > Not just this one :)
> > >
> > > https://lore.kernel.org/linux-wireless/20250617104902.146e10919be1.I8=
5f352ca4a2dce6f556e5ff45ceaa5f3769cb5ce@changeid/
> > >
> >
> > Ah, interesting :)
> >
> > FWIW, in this particular case, syzbot sent the duplicate report
> > because the WARNING format has somewhat changed in the latest
> > linux-next. So before we updated syzbot's parsing rules, it had
> > managed to re-report quite a few duplicates.
>
> Right, I had noticed that, but then I looked and the old counter is
> already at well over 100k so I decided to finally look at it again ;-)

Nice! So re-reporting things is not always that bad ;)
Thanks for looking into the problem!

>
> This is a really long-standing problem that we discussed a few times in
> the past I think, and basically the system is loaded enough that the
> hwsim hrtimer can fire on time and pull the beacon, but the workqueues
> are overloaded and cannot do the necessary work within the ~100ms beacon
> interval ...
>
> Should be rare in practice, but a WARN_ON() that doesn't say anything
> about what's going on doesn't help anyway.

That sounds totally reasonable indeed.

>
> johannes

