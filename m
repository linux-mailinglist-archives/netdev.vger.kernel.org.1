Return-Path: <netdev+bounces-159768-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50F9CA16C6D
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 13:34:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6737F3A68CA
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 12:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA411DF98B;
	Mon, 20 Jan 2025 12:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dauUP1e/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF8D1B86F7
	for <netdev@vger.kernel.org>; Mon, 20 Jan 2025 12:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737376492; cv=none; b=k+qbLA/NBsj76OetNNLXIvqeCxgKPCOsEP++8aSycMaikqZl3n+5XT87iq2bIQh/jslXVl4ZBNM+0loBUS1MoiBL3802Xsnww7zpNvfN9TQufy7XMxX9C18lGoZ+OOMzaUsyoYVEyhrMDS1AkE9EiG64hrgTQmjFm338jU3USdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737376492; c=relaxed/simple;
	bh=S5dbYIn8C7MW1zqsEkDwDlBCyjLh6QsBPaBcGUerkss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lsb3++13intOXZ99Z7aIgPkBUaBtcUdNNLW93aHjRCARH9IJW5M8eWSCclfSUEd7Qsqx8J74AypM6Pton4zHCqTW8LRMTCuthDo1u3iyjMD9dw2CE0AZZYqSfIXVkYt02fWXoxVfvfUoc04s7pG0HxN4GTTt9ZbOmHIQsVr0QSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dauUP1e/; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5d9f0a6ad83so9062294a12.2
        for <netdev@vger.kernel.org>; Mon, 20 Jan 2025 04:34:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737376489; x=1737981289; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CBjy5TlL0SShdrVU0AM4bPo0jZ4tej0LGUonzg506AA=;
        b=dauUP1e/Ch8KJP9gn86QkUDEXZlac1pSXZEr7XtADQqkWrD8xjiXJv0iN/1OwGgJj9
         F/q4M+t3fcMypfKmKAEAPjSMLn++wjnFQK6HVqMUQipSKVVle0trAgxbwv0ZhaYHEjDz
         lSpdxCw54//yKKu3wolTzrAmdCOnTVcRFEk9d39Lm1XBXPFkc/25DR8rpD8F3ii3ictR
         w36RjSorMpvJLPh1jTnnhfm2TdG+TSs6oJRCEE7hDGgXqFVh10lzlGvzZaKqksRFC2AI
         A7auyxK5E2vE8+m3HeVjLCtP4zgL8oYpNWdx6DN7fODydYNE0pAWgi9rec/oxpqQaHdd
         RXGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737376489; x=1737981289;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CBjy5TlL0SShdrVU0AM4bPo0jZ4tej0LGUonzg506AA=;
        b=jOathmZ3Op42hwtDt2n0CS2AZQmUX+JYCryYwqJkRZ++eTFXdaNWmXX2hftsZWDkYd
         YOrbPP8j3bsiLGJGKhr1NI5So6qlnot6toHqGcw8G98yaHfc9lO7bkPIVzga3mtPn38W
         swaJkNg540f0sBKo5D4pfChlVzgDMb+eu7piJjZAyCKVHV2k7iFObl74A85GBNIKoMXZ
         edQS1hAWkNfYAyT/7LKAyCiDa7jQLf8wBFFY5+PzyXb5tGviW+3mHPjwpj1yZTub/Lsp
         V0I55oNYmg5XQ9f1/kVLp2rTM+zs/AHrQ3LGwhrQkgOlgQoIMv9mNlIDTHLwB8Y4gVnc
         vj3g==
X-Gm-Message-State: AOJu0Ywqp2z+3ZtPWU+gOZlrsfMFMOp8NP04K2tIGjO+dDwHIY901VI0
	0FP3uWk87IDs3hy2MlBI8Rc4TAKyYxKKv/dUTslXwsiHrEB1iAA7Hh2WoS23K0CwhLYqIB771AJ
	piR27Rb3cJwRX5zmw2k+H1hfD3sk55CEA7Ket
X-Gm-Gg: ASbGncsg2xmD3fcl6O9GbVycyn5CqQOuuKOdT6hKFCHuHR+JoxklBJz6sLHk5bAcuwz
	Nsbww8qSChV3CMQtaydaTtc8XHhW7Ndcc9r6pQT8WMeI+fwEmpw==
X-Google-Smtp-Source: AGHT+IEbMHsILLG2QgmXFBFU6p1wb2UaDzxPfVeIqFjP9D6M7Q5xY3qyEnHvQrI/Cf02aYwGdk4ppdYnKI82Yhq/Gfo=
X-Received: by 2002:a05:6402:42c4:b0:5da:d16:738b with SMTP id
 4fb4d7f45d1cf-5db7d2e83a8mr12002827a12.4.1737376489312; Mon, 20 Jan 2025
 04:34:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250117192859.28252-1-dzq.aishenghu0@gmail.com> <CAFmV8Nc=5Yd-ZA-MqKmTMWcz+LLC8p7YG-nbfge_WAaHcp4G8A@mail.gmail.com>
In-Reply-To: <CAFmV8Nc=5Yd-ZA-MqKmTMWcz+LLC8p7YG-nbfge_WAaHcp4G8A@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 20 Jan 2025 13:34:38 +0100
X-Gm-Features: AbW1kva07VXFmicYcpEWtEgP_DdBx-npMkCm-kgNoq2CM-ONnag6cv8s7k16kQQ
Message-ID: <CANn89iL355opLJTJUFmiuy7GW5mu9NmihN-xoAtV2=RFVMO3qg@mail.gmail.com>
Subject: Re: [RFC PATCH] tcp: fill the one wscale sized window to trigger zero
 window advertising
To: Zhongqiu Duan <dzq.aishenghu0@gmail.com>
Cc: netdev@vger.kernel.org, Jason Xing <kerneljasonxing@gmail.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 20, 2025 at 1:30=E2=80=AFPM Zhongqiu Duan <dzq.aishenghu0@gmail=
.com> wrote:
>
> On Sat, Jan 18, 2025 at 3:29=E2=80=AFAM Zhongqiu Duan <dzq.aishenghu0@gma=
il.com> wrote:
> >
> > If the rcvbuf of a slow receiver is full, the packet will be dropped
> > because tcp_try_rmem_schedule() cannot schedule more memory for it.
> > Usually the scaled window size is not MSS aligned. If the receiver
> > advertised a one wscale sized window is in (MSS, 2*MSS), and GSO/TSO is
> > disabled, we need at least two packets to fill it. But the receiver wil=
l
> > not ACK the first one, and also do not offer a zero window since we nev=
er
> > shrink the offered window.
> > The sender waits for the ACK because the send window is not enough for
> > another MSS sized packet, tcp_snd_wnd_test() will return false, and
> > starts the TLP and then the retransmission timer for the first packet
> > until it is ACKed.
> > It may take a long time to resume transmission from retransmission afte=
r
> > the receiver clears the rcvbuf, depends on the times of retransmissions=
.
> >
> > This issue should be rare today as GSO/TSO is a common technology,
> > especially after 0a6b2a1dc2a2 ("tcp: switch to GSO being always on") or
> > commit d0d598ca86bd ("net: remove sk_route_forced_caps").
> > We can reproduce it by reverting commit 0a6b2a1dc2a2 and disabling hw
> > GSO/TSO from nic using ethtool (a). Or enabling MD5SIG (b).
> >
> > Force split a large packet and send it to fill the window so that the
> > receiver can offer a zero window if he want.
> >
> > Reproduce:
> >
> > 1. Set a large number for net.core.rmem_max on the RECV side to provide
> >    a large wscale value of 11, which will provide a 2048 window larger
> >    than the normal MSS 1448.
> >    Set a slightly lower value for net.ipv4.tcp_rmem on the RECV side to
> >    quickly trigger the problem. (optional)
> >
> >    sysctl net.core.rmem_max=3D67108864
> >    sysctl net.ipv4.tcp_rmem=3D"4096 131072 262144"
> >
> > 2. (a) Build customized kernel with 0a6b2a1dc2a2 reverted and disabling
> >    the GSO/TSO of nic on the SEND side.
> >    (b) Or setup the xfrm tunnel with esp proto and aead rfc4106(gcm(aes=
))
> >    algo. (Namespace and veth is okay, helper xfrm.sh is at the end.)
>
> Sorry, I mixed up some things in the test environment. So the xfrm setup
> is completely unnecessary in this reproduce. Just preparing an MD5SIG
> enabled tcp tool is enough for method (b).
>
> It's easy to reproduce in distros, what we should do is make a slightly
> large wscale and make sure that the GSO is disabled in sk_setup_caps().

Please provide a packetdrill test.

I am sorry, I am seeing too many suspect reports these days, with
vague descriptions.

