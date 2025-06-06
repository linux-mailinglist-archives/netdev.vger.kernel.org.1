Return-Path: <netdev+bounces-195457-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F5D2AD044A
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 16:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB1D17AB379
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 14:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A241A76BC;
	Fri,  6 Jun 2025 14:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S0y/zdVS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2980F17B50A;
	Fri,  6 Jun 2025 14:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749221745; cv=none; b=k4JrfnuDkrIu0WbKVJKUB9LlW8FVvbR5+rhboc1jRtQ0mLCbDqhazomgodoyBREzvK7/VB5mz/rMzMSXd0qf5/wzkseLWtFBimjGZHDgxDuyOzpfqzPDWMnV3lrjyAHGX4/lomJVNTjnzcxSaaj6ibiIvhSJyN7YKI0tQgvX1ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749221745; c=relaxed/simple;
	bh=L9/yg7FYVpcvI0YfTkdkZgBobhQMILGK8egVK8yFG2w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SDlYwq+KtvPYjv64x5T8cK2uiV0FPZUoCwhdc5WlSrVwtX9uW5aYEYARIka6BNeQJZDtl4dV5vq2Bk7FKhh7MnSGu+mDZ0u6QlKS0+tyEgbRGw9kau7ww5ja6amdzzwqb5MVLTxOzEp3H+Y2oM479RiiIwqqdvJ2w6HNrE3Sid4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S0y/zdVS; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-551efd86048so2345950e87.3;
        Fri, 06 Jun 2025 07:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749221740; x=1749826540; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9vEqxDPn0ZUq7X1FTJtTDzBWFl7WShO2WerhdN2+vTs=;
        b=S0y/zdVSsX+BIuiw04KolyZlTKAsgnxYFkl35jzQ5QrVOO3bfTWvGyeIR0MVmQZylK
         oFnWx+fNUVZEhk+O7PKWE7cGxqR0HgHXVvBM/dnBIyltDQg/WVJLc/JCxkHwH2iRgpCs
         kP0V4oxn+xZvzPK2rixvgctkF4n4HHONK3e/r3JYo4a7KV4u4f7ADT2tkhDtbuWxLbTE
         /HNqZ7eJ8vVXaD+1h+5ftCbOe0dt4TQme14TyXOEiQQHYV9gXpOroMvQs68G3zYLQy23
         +e8NQylRgQm9AwUMaYKLQcpENx7QQ0506Qts2SX3iWeV+MGdfDZJKbaU8vIh+VqYR75U
         aNHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749221740; x=1749826540;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9vEqxDPn0ZUq7X1FTJtTDzBWFl7WShO2WerhdN2+vTs=;
        b=kkn1ZeYNjuTplWzEiUvXaUbNYkRyX3/hI1RVVITprm78nh50QA2mjzX/SiNpBbahqQ
         okCpM51ZOnOJkoIYhJcp/v7nXM4yLlxg+ciTIxqfHOMKSGldLQBsJtGbYV/MuO4XzaL7
         mNYF/GurFXf5C/puIKDZPESuaobYAX+Pn+rwfKZPxwKsOZp9HZvaBICI/g6lcpfMh7xE
         dFzF95gUHxjFXeJrPsdz1Hcv+CAMLUhQrC2r5nu0zStSn6/6HNVHsJgAOq+6Nfc60l9K
         zfDe+segjFVcjxghfKkNUiMZGfTyycbJZ+6luifeLqF+6eQPJjT+xPGwrN67xgsD2YFx
         Qq/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVtMviv861IjmvtbkcOXZNtt6n/W8keTs27BrSPIQEunoYnUYAvrGkXwdvTWgVCQIG8WBRytPOOI6YotJU=@vger.kernel.org, AJvYcCXd5LBw0kQ4u2hmhaqKFClJ2mBe7vMTMj/XsFk7b0jHbxRdO5H3hNizVlcUnDECg2G+fpcnfMK5@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/CdToSSWgL1iHoTe43zDYoGL+a0yoIVmy3INaeVHmPumLrHec
	/xiSxV86RGJWyWd+hFIGDHimtvtUD3RgNXnTw/RR3ctD+hXxRufIHbpuy8XDxyNlsZfaxWtBBMp
	QcHVmpUzq489zpoo3RXOKedy5nizebRQ=
X-Gm-Gg: ASbGncseSBvfc8cDDy52AqcjTP7fwdhr8wCjour/qtI//8yLeBi1R0AVG2bQT0EVx3w
	XKDFfqm47RaSp1DP6Rnfpo+QMoyA88voT9lAHV2imfZCzXEMtNJlU/xHHRmjagtbCpa0VJu5lr5
	N7SaNzh+RRTFDq0U7t+ue5C6cfR37iuFt4Nstems0iGmDviWwmuKzXcWyM3bS3B+Ehko7S4WiiA
	dPvNA==
X-Google-Smtp-Source: AGHT+IFZWOEBNtk6rAy+hlSFXTHbia35W3Eb5q7wIpwrt+5TKHTVOh1XTS2ghbuZ6plcpgQrnD1VoNRTQQ+B8Al5/mQ=
X-Received: by 2002:a05:651c:1545:b0:32a:6c39:8938 with SMTP id
 38308e7fff4ca-32adfc821acmr9118621fa.13.1749221740202; Fri, 06 Jun 2025
 07:55:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250602135932.464194-1-pranav.tyagi03@gmail.com>
 <053507e4-14dc-48db-9464-f73f98c16b46@lunn.ch> <202506021057.3AB03F705@keescook>
 <25d96fc0-c54b-4f24-a62b-cf68bf6da1a9@lunn.ch>
In-Reply-To: <25d96fc0-c54b-4f24-a62b-cf68bf6da1a9@lunn.ch>
From: Pranav Tyagi <pranav.tyagi03@gmail.com>
Date: Fri, 6 Jun 2025 20:25:27 +0530
X-Gm-Features: AX0GCFvWsxNzpeHQ-45krsT9OQBs0Twpqds55CAANGDSlgC7gQxq8HsNVzgkPKQ
Message-ID: <CAH4c4jJRkeiCaRji9s1dXxWL538X=vXRyKgwcuAOLPNd-jv4VQ@mail.gmail.com>
Subject: Re: [PATCH] net: randomize layout of struct net_device
To: Andrew Lunn <andrew@lunn.ch>
Cc: Kees Cook <kees@kernel.org>, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 3, 2025 at 12:36=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Mon, Jun 02, 2025 at 11:03:18AM -0700, Kees Cook wrote:
> > On Mon, Jun 02, 2025 at 04:46:14PM +0200, Andrew Lunn wrote:
> > > On Mon, Jun 02, 2025 at 07:29:32PM +0530, Pranav Tyagi wrote:
> > > > Add __randomize_layout to struct net_device to support structure la=
yout
> > > > randomization if CONFIG_RANDSTRUCT is enabled else the macro expand=
s to
> > > > do nothing. This enhances kernel protection by making it harder to
> > > > predict the memory layout of this structure.
> > > >
> > > > Link: https://github.com/KSPP/linux/issues/188
> >
> > I would note that the TODO item in this Issue is "evaluate struct
> > net_device".
> >
> > > A dumb question i hope.
> > >
> > > As you can see from this comment, some time and effort has been put
> > > into the order of members in this structure so that those which are
> > > accessed on the TX fast path are in the same cache line, and those on
> > > the RX fast path are in the same cache line, and RX and TX fast paths
> > > are in different cache lines, etc.
> >
> > This is pretty well exactly one of the right questions to ask, and
> > should be detailed in the commit message. Mainly: a) how do we know it
> > will not break anything? b) why is net_device a struct that is likely
> > to be targeted by an attacker?
>
> For a), i doubt anything will break. The fact the structure has been
> optimised for performance implies that members have been moved around,
> and there are no comments in the structure saying don't move this,
> otherwise bad things will happen.
>
> There is a:
>
>         u8                      priv[] ____cacheline_aligned
>                                        __counted_by(priv_len);
>
> at the end, but i assume RANDSTRUCT knows about them and won't move it.
>
> As for b), i've no idea, not my area. There are a number of pointers
> to structures contains ops. Maybe if you can take over those pointers,
> point to something you can control, you can take control of the
> Program Counter?
>
> > > Does CONFIG_RANDSTRUCT understand this? It is safe to move members
> > > around within a cache line. And it is safe to move whole cache lines
> > > around. But it would be bad if the randomisation moved members betwee=
n
> > > cache lines, mixing up RX and TX fast path members, or spreading fast
> > > path members over more cache lines, etc.
> >
> > No, it'll move stuff all around. It's very much a security vs
> > performance trade-off, but the systems being built with it are happy to
> > take the hit.
>
> It would be interesting to look back at the work optimising this
> stricture to get a ball park figure how big a hit this is?
>
> I also think some benchmark numbers would be interesting. I would
> consider two different systems:
>
> 1) A small ARM/MIPS/RISC-V with 1G interfaces. The low amount of L1
> cache on these systems mean that cache misses are important. So
> spreading out the fast path members will be bad.
>
> 2) Desktop/Server class hardware, lots of cores, lots of cache, 10G,
> 40G or 100G interfaces. For these systems, i expect cache line
> bouncing is more of an issue, so Rx and Tx fast path members want to
> be kept in separate cache lines.
>
> > The basic details are in security/Kconfig.hardening in the "choice" fol=
lowing
> > the CC_HAS_RANDSTRUCT entry.
>
> So i see two settings here. It looks like RANDSTRUCT_PERFORMANCE
> should have minimal performance impact, so maybe this should be
> mentioned in the commit message, and the benchmarks performed both on
> full randomisation and with the performance setting.
>
> I would also suggest a comment is added to the top of
> Documentation/networking/net_cachelines/net_device.rst pointing out
> this assumed RANDSTRUCT is disabled, and the existing comment in
> struct net_device is also updated.
>
>         Andrew

Resending to the list=E2=80=94my previous reply was accidentally sent off-l=
ist.

Apologies for the delayed response, and thank you
all for the detailed feedback.

Regarding the concern about breaking functionality,
I did compile and boot the kernel successfully with
this change, and everything appeared to work as
expected during basic testing. However, I agree
that this is not a substitute for thorough
benchmarking.

You're absolutely right that applying
__randomize_layout to net_device will shuffle
structure fields and likely incur a performance
penalty. As mentioned, this is a trade-off that
targets hardening over performance. It's worth
noting that CONFIG_RANDSTRUCT has two options:
RANDSTRUCT_FULL and RANDSTRUCT_PERFORMANCE, with
the latter aiming to minimize the impact by only
shuffling less performance-critical members.

I=E2=80=99d appreciate guidance on which specific
benchmarking tests would be most appropriate to
quantify the performance impact. Based on your
suggestions, I plan to run benchmarks on a small
SoC (ARM/MIPS/RISC-V) with 1G NICs. However, I
currently don=E2=80=99t have access to high-end server
hardware with 10G/40G+ NICs, so I=E2=80=99ll start with the
systems I have and clearly note the limitations in
the revised commit message.

I=E2=80=99ll also update the commit message to reflect the
security vs performance trade-offs, mention
RANDSTRUCT_PERFORMANCE, and add a reference to
net_cachelines/net_device.rst to document the
assumption of structure layout.

Thanks again for the thoughtful review=E2=80=94I=E2=80=99ll revise
the patch accordingly.

Regards
Pranav Tyagi

