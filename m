Return-Path: <netdev+bounces-217591-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C86F0B39213
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 05:05:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 937F2461492
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 03:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E465260585;
	Thu, 28 Aug 2025 03:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ORH8CR5s"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980B014EC73
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 03:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756350350; cv=none; b=Ug3ZWcmtmmImhxNiwO34uWoc3KNzo25YYjAd5vn69lXmFpgNseAwv/d91TwvGfk2IMqveF0hOpoksjQLMymcd0jLo3fW3JThrD0R3xehpaiY3vMdALzapQemgTDTv3TKNBIgKTkOhMRQQe8J8xx6PHW5mDt33lv/GJU0sFEgQhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756350350; c=relaxed/simple;
	bh=CidSD1n9rlERIzk9DkKyrAwnCi69XYWnZbq6R3cCO4U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NSnyYjpz2ldbLP3i9CNe8IcFdiOsHWDQS/3YQ9bdDXYH+ZCreX0jZSDE4QAOfuANohPpUD0z8F17ciZWl/xpipxDwzaiNke6iDQZQUsB/RFz3Ytr2xeUV34/r+SLfEHg77eeWC3OsqbCuFRGgBk+YBKlyyUSY1crzaftBinnEiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ORH8CR5s; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3252c3b048cso439621a91.2
        for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 20:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756350349; x=1756955149; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rnSBEhSr/X/xb8bRg4tAGhyIlVt7y4Lpl82rzeetB8A=;
        b=ORH8CR5sf+y6OSU7pNj4rkSvvQ0VSBVsU3v/rRTBfPhMONPNwQkzu5c3l/LuCG/ii9
         eIJGoxP2UmHS7qxhHuMOLJiy2YUE/WrNvjfPD4ruCrFkfJA6RRRffLV0TeOm7NObn1Kl
         ESJHLORBBGdIoqCKNNoUzkP+Hy/9sppmbpKgHNkn+dFHPZ/+W5g3RhlIfA9/FwUZsaH0
         1v6j/HdvDUZd3X0moc5d8uuG5rNDeSBfJo7I8n3HJnVmWcaJXKlJiRxkOBBwMa4gSqoj
         Va8PLUPNA7dEvQHlA8T0Mh+iMxZIXNfFb+5XzY7b2PAPXFs1qUZY67FKbTbRF30A6Zlb
         XxtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756350349; x=1756955149;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rnSBEhSr/X/xb8bRg4tAGhyIlVt7y4Lpl82rzeetB8A=;
        b=Ru8zerJAAYu/iWW8Mo/ofUIr1KymJ1EsswAGXH3MlXP9PDXm9JNnYG2HKR63CIh7s1
         kQnHC27rPOltJwWpnyr3Ytl7XD1DP3CayTs4GulRzIpBtGwk3WFqH1fRmYWa2L9p33/8
         2sf7knieEX1FvOr0L5rvW8QbS0I5a9UmjRL9dFYwljobljGOvyyzhRXmMLGjnGojSaFs
         /8jfzp2pa3xO38v6FmIvPvmvZhtIRgERhxvazdgivrhNBKPGSLeJwiIUiRnKIEmLsE46
         lxtQSGeLcnUR/7YXJD8Lh6LLuVSWpthPcYVMkFc5sCtOaDWj7MWUdycCys4KkN6KG+i3
         FMmg==
X-Forwarded-Encrypted: i=1; AJvYcCURp8zgCLas11U36KiuQCoIxpdW/V5NqbC+whsODNAn22/TESxgl7V9fHhMtsBiHl+1tpvpAAQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxQUYGHsk7ds3t/dQm7m1CoVtPoHQRp8wO1X+S19ScdwiCDwVY
	DrRK8+9uuxQWX8r7b19Ix238abLZYAK1xgRMFxE2lXfKNx5rdEj+L0gKIpvceh/QIYSsQe72JDw
	S3eNQq1VVcI4lfD/5RY/V4HlHoVbT6XHloT2POZck
X-Gm-Gg: ASbGncvOKSK9f/P5aMth9jVk0vMGVtJBBKO/iGnYR7Q27c+AbBdUncH+ML4VsDrYJsn
	UbqhwZJI8xBJgwsJJExc4/B5RKk9KvnSdtFTJGuY6FI7Li0Q3W0GAbYuNyWHmtKvTl/bWWocrgg
	TjHIMvaSOHRe9r6RWs+WxLB5ype1FUlkQYyI4g1Hz/2uvKUb4QRW0ZnjYOEcs0wRgYD8KSGIEte
	JHxkJKsSwleP/2mFA0nNLtMzVBI4FKq0uZzOymhz/fQcEP+kL5NqA7n4O7urNKo7k8UNjeIPT+I
	soIXKxRSepF2Sg==
X-Google-Smtp-Source: AGHT+IHSGFxIBDgJh3c2Z2bWu/Rbr63RbZilO9FwNnrGztx4tdK7grXntwVYLujsiRnkLWfr8RIu5BTbiy3va2w4Mtw=
X-Received: by 2002:a17:90b:5443:b0:311:f99e:7f57 with SMTP id
 98e67ed59e1d1-3251774b90fmr28750696a91.23.1756350348714; Wed, 27 Aug 2025
 20:05:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827233108.3768855-1-kuniyu@google.com> <87ace089-0d1b-474b-aa9d-aed1e83062bc@lunn.ch>
In-Reply-To: <87ace089-0d1b-474b-aa9d-aed1e83062bc@lunn.ch>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 27 Aug 2025 20:05:37 -0700
X-Gm-Features: Ac12FXymkiM1Yfm2E-kYoLAi6XgPXlscnU5RuIhFMyNd9WTo_8Ps9WQJQsz-D-o
Message-ID: <CAAVpQUB4VOZLkF1QE3nN7Rp3dRai_VXpVZU4X9nMNU+rcJLOeg@mail.gmail.com>
Subject: Re: [PATCH v1 net] net: usb: rtl8150: Fix uninit-value access in set_carrier().
To: Andrew Lunn <andrew@lunn.ch>
Cc: Petko Manolov <petkan@nucleusys.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, linux-usb@vger.kernel.org, 
	syzbot+b4d5d8faea6996fd55e3@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2025 at 5:57=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Wed, Aug 27, 2025 at 11:31:02PM +0000, Kuniyuki Iwashima wrote:
> > syzbot reported set_carrier() accesses an uninitialised local var. [0]
> >
> > get_registers() is a wrapper of usb_control_msg_recv(), which copies
> > data to the passed buffer only when it returns 0.
> >
> > Let's check the retval before accessing tmp in set_carrier().
>
>         do {
>                 get_registers(dev, PHYCNT, 1, data);
>         } while ((data[0] & PHY_GO) && (i++ < MII_TIMEOUT));
>
>         if (i <=3D MII_TIMEOUT) {
>                 get_registers(dev, PHYDAT, 2, data);
>                 *reg =3D data[0] | (data[1] << 8);
>
>
>
>         /* Get the CR contents. */
>         get_registers(dev, CR, 1, &cr);
>         /* Set the WEPROM bit (eeprom write enable). */
>         cr |=3D 0x20;
>         set_registers(dev, CR, 1, &cr);
>
>
>         do {
>                 get_registers(dev, CR, 1, &data);
>         } while ((data & 0x10) && --i);
>
> Don't these also have the same problem?

Exactly, will fix other places.

Thanks!

