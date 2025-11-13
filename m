Return-Path: <netdev+bounces-238502-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E625C59EA2
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 21:12:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE2453A9F31
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 20:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B6062FD1D9;
	Thu, 13 Nov 2025 20:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Whuuq4ZB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83242877F2
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 20:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763064738; cv=none; b=u5/OCrO18kM1Yy40iNACWK6ZZdhH5dQnAuNkxZiW+wrhjV7bWa7zH/E/B+Kp2FsWXsde3eKMR4p6EmtrCNGJJkrjPM/dgrMdRCYL7z1fcBBayuS0Zy4UeF2P17VVDX0K+LV/olPBZyAlAd5GH3sMJxPU+HyVMU8zYLPHNXkfwT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763064738; c=relaxed/simple;
	bh=61Ou9tzDLPykm65PvGOrqZRbK8+lpqilaDopIRGr7FA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CRtFtuREiemF4lGLDa1+exQe05uVwRLDGPCMXx9UEsbk36v88Xt8Cs+l5ESodVaffPloJopYcKjM2VoVb4mGSqbIiuS8e51YLPzGnM4vTFUu+7K/b3D3E/bENhKlUffYi13pAmm2PSCUAgFdS/i4IWOo5fx/tTc6dQn0fY38mNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Whuuq4ZB; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4ed9d230e6dso16083371cf.1
        for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 12:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763064735; x=1763669535; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=61Ou9tzDLPykm65PvGOrqZRbK8+lpqilaDopIRGr7FA=;
        b=Whuuq4ZBt/jD5f0v4KDekiTTXwGKLkiUTWU81aOXEqlDzDjk2tw36KiCq4uL5YMNVJ
         yAdW+ipop4re+dTPmN8Y+Cbnp6Cwiqc+CFErLXyzhpVfNCyibA/eGtncXYYWcJFm9TVJ
         OSRJKCF/XuBAVdBGdNzcfm0ygjy9vH4W3FohrhW01EH1U/OhxyX2Z7qGza0SwxS0fr9i
         ktabj2vjJfhJ+UiNgyiD3sKIcwlJ460u8WUqq/dPXpG4Djp6xveh/MmghvgqRha/npak
         q5/7EbbtkNVDaR34angJwVEN2lfEWAwqAmj/IIO4D7550KXrXRQyHbuAg03Tgkzes11m
         UJhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763064735; x=1763669535;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=61Ou9tzDLPykm65PvGOrqZRbK8+lpqilaDopIRGr7FA=;
        b=hbXDe0zVOVGdMVSLXm2f4YCatNaZjxATtzVSuYkHmoRm48sbvv3zPj1WNAfZ+Tlmqn
         l0dTHycxqfR/hi+UUG1RIPr2Kv3vnyIYORJrnT0RnFRG97BMjvN42h5ITX4PMNuFqKf5
         CHvFktg8nDXADcMoWV9zFHLF2DOgJEowgBT8RB+rx0JrjS8TI3hOEvtGErx+na6FvKyz
         KIc6nZo/Vbj3Pz8Z+1vupE+TA6fWCLLTk6WuXC64aLPZv47gD6PeEm4633+lvgxwDvFr
         ru7nmT/P1JvGWNkrD5e05b63kGFiDJ/wjT1mQlsMAFOdeiSQzelXc3o0Et8DZDrkLGml
         IKtQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJde4FLEOrldLezO3oB+H0CjP2W5N+DoguwDUYg0OONV+bltElFMMMfhC2F5rQccAOUqJyk1I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk2dq10cmCBGHGYX69WroG/VLSB+5yV29kQ3gvUm1xKV2UO+Vf
	V21JbB9WYjKVdTdYB9WLPOGkjRVNqkt3VLWmYh/5A0sfbNvaErUFiZHaS8zIR/8+St1AuxSOg+D
	k6vh9XSZ0M0ZHMtGUVpDIqTKVfc7YEcgMn0vSDuI1
X-Gm-Gg: ASbGncs+pdlCeMsmc6r0k7rtwx/O1f028JIcyEk5aYqzjAHZd//9B+PnbNrdApxY0tm
	HoJGJHZDbu+s2M7EofdJmi+mWpnIptVUGJa+SUWqd6r8xxJfbAw8BTKgnk7BL1JfxgmMOicdymu
	mZZIAuzFLCSPxMpCO2YFuJVCGAbjOSw9DnAq5xE9qePXCYirzwIS2W5NDzdgZFxkW2Pba7USBiV
	pUu1Zvh/6NB8uqmf6MZ6a1AnFX/v2iPTZDzfDS04g6i8DQHMLwFIdZKBnGxE3xgSd3v7Z6J
X-Google-Smtp-Source: AGHT+IGJsFWyxOTfz/Y7ceQbgQMvhn+eIXmgYRkb0M4Br0sLFcyWPjn8NGbxwC4is1WGRHf0Ak2CDRjERe1VfRX4994=
X-Received: by 2002:ac8:59cf:0:b0:4e8:b446:c01b with SMTP id
 d75a77b69052e-4edf212eb18mr13902431cf.61.1763064734879; Thu, 13 Nov 2025
 12:12:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251113154545.594580-1-edumazet@google.com> <c6020af6-83d0-46c9-aad9-2187b7f07cbe@intel.com>
 <CANn89iJzcb_XO9oCApKYfRxsMMmg7BHukRDqWTca3ZLQ8HT0iQ@mail.gmail.com> <20251113200329.37529418@pumpkin>
In-Reply-To: <20251113200329.37529418@pumpkin>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 13 Nov 2025 12:12:03 -0800
X-Gm-Features: AWmQ_bnZ3bqVHcAukdSz_ZOlUT6S1k5V5nP4EAKk-GUhOzGTObM1qXrwpLB7o54
Message-ID: <CANn89i+BmgKAoJzd9C_BKCDLCTMrmBXp6Yc+n-kYaWRS1_yxYQ@mail.gmail.com>
Subject: Re: [PATCH] x86_64: inline csum_ipv6_magic()
To: David Laight <david.laight.linux@gmail.com>
Cc: Dave Hansen <dave.hansen@intel.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H . Peter Anvin" <hpa@zytor.com>, "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, linux-kernel <linux-kernel@vger.kernel.org>, 
	Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	Eric Dumazet <eric.dumazet@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 12:03=E2=80=AFPM David Laight
<david.laight.linux@gmail.com> wrote:
>
> On Thu, 13 Nov 2025 10:18:08 -0800
> Eric Dumazet <edumazet@google.com> wrote:
>
> > On Thu, Nov 13, 2025 at 8:26=E2=80=AFAM Dave Hansen <dave.hansen@intel.=
com> wrote:
> > >
> > > On 11/13/25 07:45, Eric Dumazet wrote:
> > > > Inline this small helper.
> > > >
> > > > This reduces register pressure, as saddr and daddr are often
> > > > back to back in memory.
> > > >
> > > > For instance code inlined in tcp6_gro_receive() will look like:
> > >
> > > Could you please double check what the code growth is for this across
> > > the tree? There are 80-ish users of csum_ipv6_magic().
> >
> > Hi Dave
> >
> > Sure (allyesconfig build)
>
> Does't allyesconfig pull in all the KASAN stuff as well.
> Which makes it fairly useless for normal build tests.

This is why I added a more standard build.

I do not think we have a "make allyesconfig_but_no_debug_stuff"

BTW, inlining rb_first() also saves 744 bytes.

