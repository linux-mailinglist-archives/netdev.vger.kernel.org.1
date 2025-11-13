Return-Path: <netdev+bounces-238500-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B3538C59E54
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 21:03:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 721534E1CB8
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 20:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F27C32417F2;
	Thu, 13 Nov 2025 20:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D1XdgUdp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41AD5126BF7
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 20:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763064214; cv=none; b=D219o74TETr8P3keN9LU+GapALgT7MwfTnHKOUCNwRfewchp3773nBEcfCOdOKoLnH04wr8nm1NOtmlRBURCasN4lKMpXb0ZGNlUUIHcukT8Lcf7FHDI6QSdwMN4dNwx7p3Rk1LQpzxuXeAPsXcxTPo/6KWENBy+wrGaln+87mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763064214; c=relaxed/simple;
	bh=czxOFEk2EoFH7TxmVeqYp0bb1SQy5T9pfO5E1MZiwpM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=opoCPFdD+cw0N85WaeTGZUB+6/x+b4FuEcmRKEh2qqYpmzb4nOhxzcQzXsC8p6l7Ok4xxJk3JTVVpqX8HIONZ+8swjOD5FXug5LrbYese9PoQr3otMNtWF0em/C2Wy+fziJYA4DgQgIZL+/tqY7q0vyZs0ZJnFXx31lhMDnB2/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D1XdgUdp; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-42b387483bbso1007901f8f.1
        for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 12:03:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763064211; x=1763669011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ye0E4RBw+o1LJoKzt94uHbmdN/ak/lXrx9F0LU4xd90=;
        b=D1XdgUdpla8pyi3MgBNo7059dB5u1vOQJJDM+vDgOb9eKR4JTcDP6ZiOsE03/RjxTJ
         Dy4u0Wx+xYDNTLx12reOae2yHRhxwgmTmRLYRqxI3aRRxjwVJoEPkvFPYelmBbEk+mGz
         TEqEiM2MZ4LuCm3XRl2tr5OZ7wlXz4iBeE6GA9BG2dbcwPxNbSNwbJeW+B1fWlrgJVqA
         YEesVlzgh06OlrC/j02RSONVeYdMPloqpuFMQX03djcIGLcQQ4xKR6UQWd40LornRLIv
         MkQyw3WLHlkNoFxJx368nBRRqh6GGxGINc2HBEFDSQy2FWDZbbttpfvdBkcQeHNnEB6k
         w3Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763064211; x=1763669011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ye0E4RBw+o1LJoKzt94uHbmdN/ak/lXrx9F0LU4xd90=;
        b=WYs5RaKKYdg8WFIbrjB1XtXhUAGP1tMZGFExh0+C0plmbG/OEkZJjDwnFCR6ltYOpB
         MPjEn79DBqt2qdJy5cSk1ephUKXZfuS9cHA8JIMBBCWs+tKr3WBE4HDNI79loCKzw4N1
         Trs2sDJxQVPULgp6UpPOhA0ibvivQ2GwcvL/zXVGHd6uEuXZEIO2P/91tKHLVwtd0hc0
         1W0SFAq+vKioxRdidGStx2OjRy/6RAt+ODKP2vhPshWCQAP44enmcMGty1DEWbvL/wj9
         V44IjTot08jj6XVWdZbzbfGddupVZaIjPzFgh+GaOOOO9+8c0QORfNMgjtQONQew+1bV
         bp5g==
X-Forwarded-Encrypted: i=1; AJvYcCXsJtIb9A9GQes7qIhWxHGg/9gaXyt7tvmOp00XFXp2vo47SVVwR/lxS8h+bMCHQdviUSsnkfg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyjvb+ifziAyjUEhbWAnTYWmNqPM52LvCo41wVJdkWCTU3Dj86c
	tWDjHCzcajeLjwvFysl10F7JRaWp7KkC3szdxiCn4dWaXe6zKrKM4q2z
X-Gm-Gg: ASbGncs+QKYj9Yhqy3vyeJxMzSaK8GPXPE3i/nrNfqDwsViF1ACC6Kve7SWQpZ90LI/
	Y3v5J3W6BIuMdEci8zzlFsA/wNf0D+9LdiDCLdbauOum2j6kHprzhDCDR8j1Klufw3RoixfOFHQ
	jXslOB08HT8wv7medmGBCrHAg+XcnIKoO5mmuNmG8VCJXfOYDm0GT3njKqv10coDPhla1SyxmQG
	+5Ui98vnG5ysKOT0TDdf3cVUvxjRHWkcpgQax3jyD961+jIuNiVLvGslh6Lgz5WycuxoYfymPK0
	xu1iOeteIcU2mFOpxvgvP7rV1lP5SzbDYIu01ASrPOt6Jkp6Mt7JpZdReC+DMfi7qPS62Yw5BnP
	fxAzB2kH14w2dZPQbHv3XC0kVHAxyGH89LyWnjZ3oYP6DE8+3SdExwn+7xAKPQMC4/pRVpYX7qp
	9Yz03D7laS4uDI2DTQsHWLlH1CvJfNLFW7lt5dE/YCQyy3ZU5Wh76BtC1eQOfQtp4=
X-Google-Smtp-Source: AGHT+IFJCxRkCERJrK76whAyAd5LSDmi++u8d9NDykfWgzS3IQ2FvgGAjE1h2z5NE2gfLBWZucX9+A==
X-Received: by 2002:a5d:5d13:0:b0:42b:3ec3:fec3 with SMTP id ffacd0b85a97d-42b59399a79mr566112f8f.62.1763064211437;
        Thu, 13 Nov 2025 12:03:31 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53e7b14bsm5484906f8f.9.2025.11.13.12.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 12:03:30 -0800 (PST)
Date: Thu, 13 Nov 2025 20:03:29 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Eric Dumazet <edumazet@google.com>
Cc: Dave Hansen <dave.hansen@intel.com>, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H . Peter Anvin" <hpa@zytor.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, linux-kernel <linux-kernel@vger.kernel.org>, Simon
 Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
 netdev@vger.kernel.org, Eric Dumazet <eric.dumazet@gmail.com>
Subject: Re: [PATCH] x86_64: inline csum_ipv6_magic()
Message-ID: <20251113200329.37529418@pumpkin>
In-Reply-To: <CANn89iJzcb_XO9oCApKYfRxsMMmg7BHukRDqWTca3ZLQ8HT0iQ@mail.gmail.com>
References: <20251113154545.594580-1-edumazet@google.com>
	<c6020af6-83d0-46c9-aad9-2187b7f07cbe@intel.com>
	<CANn89iJzcb_XO9oCApKYfRxsMMmg7BHukRDqWTca3ZLQ8HT0iQ@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 13 Nov 2025 10:18:08 -0800
Eric Dumazet <edumazet@google.com> wrote:

> On Thu, Nov 13, 2025 at 8:26=E2=80=AFAM Dave Hansen <dave.hansen@intel.co=
m> wrote:
> >
> > On 11/13/25 07:45, Eric Dumazet wrote: =20
> > > Inline this small helper.
> > >
> > > This reduces register pressure, as saddr and daddr are often
> > > back to back in memory.
> > >
> > > For instance code inlined in tcp6_gro_receive() will look like: =20
> >
> > Could you please double check what the code growth is for this across
> > the tree? There are 80-ish users of csum_ipv6_magic(). =20
>=20
> Hi Dave
>=20
> Sure (allyesconfig build)

Does't allyesconfig pull in all the KASAN stuff as well.
Which makes it fairly useless for normal build tests.

	David

