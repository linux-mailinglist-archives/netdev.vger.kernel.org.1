Return-Path: <netdev+bounces-251086-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F3AFD3AA0F
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 14:16:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3D74F30161D7
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 13:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2002366DD7;
	Mon, 19 Jan 2026 13:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CZBuxTvZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDED366DB8
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 13:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768828595; cv=pass; b=tE5R9Nd11TCIC2/BLmr45xaAucfM6vQIB8Y16FZmA505bLz6HqrKtZ1bkREK9i2wkGOV6yNHpW7gp8RJPj/B9TeUjf+vbvFFLoBDH6ODJQ2ZmjAQtlDYD6/OoMrc6jUBMSS9xJ8b+ZvU9O3QQw4daB5GBhdbsNed9hbqJUGJxdE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768828595; c=relaxed/simple;
	bh=HDgZzyCVwi6dTQrQdHlplTvT19WWgr0rTwBPV63gNaA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wasxc6pXUStsUdVUzfkhBdUQe7HRc9EMkP1QR566qUbenhJqaIuae7DPOTuFUdgJIWmO9ATCiUGzowGZ3D+iGJzz/nt9QCsUEUnXXGfHo/o0oR+Ihu2TMbNPsL/nBBJAWRNmg/KbWCTEdP8GILmnlbfGP+MH3guPktB925Rehuo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CZBuxTvZ; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-655afbca977so5051292a12.2
        for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 05:16:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768828592; cv=none;
        d=google.com; s=arc-20240605;
        b=S+dA9S4NsXliX04RLWScdirBrbC9oc79sjdf5kLv4Y9sGgraSmRBCBmqp45CSbz/vs
         3luuYbAUSKrIPg3G0wJ/dPsOJ3zcOtLVHKSDDYSXzHMKL/xiVSfoQ951PYzQ4t4j9VlT
         8lJcvweNTitOAV3dJ5Mt2qpKz4ChJkbC41oKauNAEVLFyscdFs13Xyt/ubZs/dSlQwkb
         gapbS43shy3sJJAFpXBboCBdgSqyiLCcUDYTvODkc+zruHNOiRddI2hagjllQnmM4qvg
         +lw06WED5beu/3Aj/e9pzSFdLvVQKXTLYSNV82TCXKzU7A7K2s9ZpLRsPKn2B0vnosN7
         aGKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IAc+TnrR7AyLva3poJVGcilw95QVmliW65exvyfTaYI=;
        fh=pwU4IO+Bh5nN0zcXqAFpudQHoa8Wdht2p3eNlmWunyQ=;
        b=h4N8QQxcEJJhzgu5TGfixh1x1xo4XCryB4rSo8Oi+xVX1TuwKe+xYVq7PjIXiDKAxH
         hhsbbIxFOsa0p1l8GcVPxOgsQLGcGJsQjWs5dJO1T3++jRRo1KAbeYKKhpk2G4RqHVou
         LI9Xt+VM+MflICzSJ3IieLH4CbNxVq5Q8qUiWnaJpRYjtnp9zWQ0tu1EAxyHQAULNsRA
         PDeglesQr6YRBcEftTgFI5da+c7WNZcvoVse5XHZ5G35D6jSqjsxOtlM6Dwh62z9S2Ko
         WnutSCsH8NFB5EE+40GuZUgTWA2mUavOfmlB7/0u0Wsp0ji81zOpl0Ubdn35TpCZVz1t
         ZYCQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768828592; x=1769433392; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IAc+TnrR7AyLva3poJVGcilw95QVmliW65exvyfTaYI=;
        b=CZBuxTvZ5ag+zmmjbyPQYyq84rZ79dRLa+W9dlZIB0uk2wrirGUUWEwQTrDxi/hf6G
         XBusCQgaL8UqHco3eCQ8JUYSMk8RS/5uToSr3bbeczVdm13SnRgMcFO6XJiV1mYhUt1b
         p9P+sv6sA+RPGt7Yj6fIRGgjvUtGcjOiLCwr+E/wJczCzgZmKIYSCRhruXy83Rsjxqlj
         85ghhzys15Skc6Yu8PPJhaqghgYtjYEqIcNEz6YLJc3DUkz/2LxPfAalAK5xjsK9bzE/
         dEwQGi9SbvPjjRjM6uz9LRuHVCutDMyuLE/cT6SFwGgrniz3wEoLW6Do8Z+kFZPMN4YG
         LfJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768828592; x=1769433392;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IAc+TnrR7AyLva3poJVGcilw95QVmliW65exvyfTaYI=;
        b=Lb0FPO188S/IGjwe30HvbZFMb410DIFXr5Ou2dkxhn/U1ZNwvg9wCmbn3a/B+5NwsD
         gAHx7am3kH0tdC0VH4/f+dBpeMQH5K8M1uHdIbr5OFbojO5cVli3/raqVaUlL8tAs2OL
         gH9A7BZX8hodY8q0+HasqX5tzru7+s02vXdy/akbOwJyqNTTlOoXK/+td9c02LPcLohV
         6jUNmvCFZF5wl0UloMXFAnQNXgPU2xZhn6AKIOZmKiAKqEil10Z/OdZ9rgkybgGx2OWx
         LPbdIfYECBHfUeCn3HQ39Llzw7HrozQtIAqJPe7pjJaOpUs3y+n1WcVOzIAsw/OAOj+e
         mg6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWvgZTvpEBwghr2EwfwRzV5jxRrcPoa0ogW3+/x0+cpkTof8E+0bnaakFBNa3JeOljGWBu3y70=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6U/KhaR9MNcILhBnSPNj/ZJKUuUqDDyUP3JYFVqQ4DwB4dTFU
	0gs/gx6QJw+2yd9FsCqDkzvQJyCqkhw2WG2t1mYcPWGXck3L/Bz0drburRiw398c50K1DoRf+og
	49u3fCRwXAumwdz7Beb3WBYLSCyQ8k6U=
X-Gm-Gg: AY/fxX6TyJ2VQfDmOYKir19ajIeCIwb7O4ccemQ1SFFxRnAUGLKpk59wq/cXq6sKp1+
	iBSNCWJnjADKMO/Djqck9iaQS8q6t3zP9cxjKFW8T/C6NEC4IxSVN1nNCWh+tx0xsUy/RC4jana
	L/0ZH8AHoZRL/AkfhNTUG4adPUy5bXlVB4+xH1xv3joOB78otAe986OrbraUU7tHi6A/uYWqWPH
	5J2EsaoZVINW9PczcvUZV1925s6Ko8kTPX0zLMtz1iKOojfTNkPF/XuOLDKAVE0J25REau6
X-Received: by 2002:a05:6402:210e:b0:64d:65d:2314 with SMTP id
 4fb4d7f45d1cf-65452ad66a6mr8335728a12.23.1768828591954; Mon, 19 Jan 2026
 05:16:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260118151450.776858-1-ap420073@gmail.com> <CANn89i+Zd2W_u665D=MExotaHtnnyqu8Z+LgfbDy2trmtqcAkw@mail.gmail.com>
In-Reply-To: <CANn89i+Zd2W_u665D=MExotaHtnnyqu8Z+LgfbDy2trmtqcAkw@mail.gmail.com>
From: Taehee Yoo <ap420073@gmail.com>
Date: Mon, 19 Jan 2026 22:16:19 +0900
X-Gm-Features: AZwV_QhCIwm8bHvGxgAOcsrXlHct4ndvTuoi11iKhYCLL0QT9KVopXRoEk_Jsbc
Message-ID: <CAMArcTU1nkAee2LNpv35nAGXbOipez4sNoMjz9AL622PCoOy8w@mail.gmail.com>
Subject: Re: [PATCH net] selftests: net: amt: wait longer for connection
 before sending packets
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	shuah@kernel.org, linux-kselftest@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2026 at 12:38=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
>

Hi Eric,
Thanks a lot for the review!

> On Sun, Jan 18, 2026 at 4:15=E2=80=AFPM Taehee Yoo <ap420073@gmail.com> w=
rote:
> >
> > There is a sleep 2 in send_mcast4() to wait for the connection to be
> > established between the gateway and the relay.
> >
> > However, some tests fail because packets are sometimes sent before the
> > connection is fully established.
> >
> > So, increase the waiting time to make the tests more reliable.
> >
> > Fixes: c08e8baea78e ("selftests: add amt interface selftest script")
> > Signed-off-by: Taehee Yoo <ap420073@gmail.com>
> > ---
> >  tools/testing/selftests/net/amt.sh | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/testing/selftests/net/amt.sh b/tools/testing/selftes=
ts/net/amt.sh
> > index 3ef209cacb8e..fe2497d9caff 100755
> > --- a/tools/testing/selftests/net/amt.sh
> > +++ b/tools/testing/selftests/net/amt.sh
> > @@ -246,7 +246,7 @@ test_ipv6_forward()
> >
> >  send_mcast4()
> >  {
> > -       sleep 2
> > +       sleep 5
>
> 1) Have you considered using wait_local_port_listen instead ?
>
> 2) What about send_mcast6() ?
>

Thanks, I've testing using use wait_local_port_listen instead of sleep,
it's working very well.
So, I will add the wait_local_port_listen() to send_mcast4() and replace
sleep with wait_local_port_listen in the send_mcast6() in the v2.
The sleep in send_mcast4() is still needed because of waiting for
establishment of amt tunnel.

Thanks a lot!
Taehee Yoo

> >         ip netns exec "${SOURCE}" bash -c \
> >                 'printf "%s %128s" 172.17.0.2 | nc -w 1 -u 239.0.0.1 40=
00' &
> >  }
> > --
> > 2.43.0
> >

