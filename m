Return-Path: <netdev+bounces-248845-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B83D0F9EB
	for <lists+netdev@lfdr.de>; Sun, 11 Jan 2026 20:14:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C962830281B6
	for <lists+netdev@lfdr.de>; Sun, 11 Jan 2026 19:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421D2352C25;
	Sun, 11 Jan 2026 19:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YwZEnLcV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD9B50097D
	for <netdev@vger.kernel.org>; Sun, 11 Jan 2026 19:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768158878; cv=pass; b=V1Z7VR2MqPypYmIGKG2jcA/qXP03XE0mGF+J6XIOQ6v9fHjyTdFSEe+jsNDyGsDhxORWTUF8JmHOWN4MC7ihNhNw/SZUtTIrfnhjppz502nhIZ9kDBKvQ9Eqy5TqhfjZInidFBuUWmW1CLdEyZODXup+QskQvnZOxYgrLM+fkiY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768158878; c=relaxed/simple;
	bh=k6AlMVy9ciJTJpdV8gMWZ1nSB+n2ZPly1UT3btHq6go=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JyjpXPhzq8AvIsThtTEZWfh9bc9QFQXDLP4FJFNI0wawldbY+LK2+lKnW/QICypJpxO7XwRAK48txcqSXov7y9utCeEBOOHGfGYXwLDuktr/rysGNwmrtoGR+HAfI/frHYjiP7XaP1CIAkMdSdSFRAzWnXVS737t2Tu6MrGAyZw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YwZEnLcV; arc=pass smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-59b6935a784so3674e87.1
        for <netdev@vger.kernel.org>; Sun, 11 Jan 2026 11:14:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768158875; cv=none;
        d=google.com; s=arc-20240605;
        b=I2YZikNlDiKzHsqztyL9u2U3JrzvM0blZtPLdeMgO3hpWTElZhOgktN+93dXOJabgW
         ZvQqO0eXkBPcz1NTRK+or3bDxJYCXpC5o7/VNVyLyvJDyDodXDYztnfLAoaV8IyVSlb2
         draUsrOp0XGjsJFHJHaR67qXUgxj7AUNH67bBDNuv2OzNIKlRo2IpOqg5aEYLv6jz177
         sSfp12CIsXNlaqaVrPIb+NUifC8Qk9H9ihXgLwCSzoO8xF6CLJqFHg017aWFHSqWFhWe
         HBORoot0rbgL2IwT/uzJTYXMMJ3QOn64TPCZkqSffb45kUEk3qmXzZtzKiaf6V0K0c2p
         WUDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=k6AlMVy9ciJTJpdV8gMWZ1nSB+n2ZPly1UT3btHq6go=;
        fh=YxYLnady+oR64nG194DzTwfSIe7L+cPC8MvqelNu8/4=;
        b=ET0i2CTaS/N+vgXW+h7AMR8tZG5MiegRM4ek0y60+4nvNAWqpuoCVYXhxAg2ZKqVGd
         2tS1743xYSHeR9uwZKcELGs3j555pEbB+6eU5+pykXUjr2f6KB+tAKzIHo+gBuINV2g5
         vtsCHuDcyhDqeVrY9ERGRqG8etURHj8tpUjJ4vce2eiKYT/JBG9ijYheTjNgQRMPdjk8
         1XxYyoa+l/n+WofQ8jE8L7kQUHyfX47+OfckspZZPV92QNp6rT3vY/efPxwVlYEVBU+2
         JRBeRvSQIpEB7bNaThJF9IYxSbvF4QeJaNuTMDwZgthx5ObtSarT3yV7HaV2iX1LWLoN
         0mgg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768158875; x=1768763675; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k6AlMVy9ciJTJpdV8gMWZ1nSB+n2ZPly1UT3btHq6go=;
        b=YwZEnLcVqIzSeKspGBMgiQsamdY9J47OeszZkd17u2WGJZ2R3NDdnM1klKlKJ2hXCE
         dPl6Ja0ECKfJjKRjJCffz3Elfr1InkHly4OLGUNy5JQZoFDnHx5dqyDZckTk6S5co+tJ
         KunFm1p6UejfZGc/Mo+sXI8QO7UFESS9QVbkBgn0PsfnHG7vSWMjSpdTm/yuTPv1S22q
         yAOaG46N94oZrqFUPi8G41iiyr98rN5EDw7/sMKzBdWb3lhV4xOv/N4nTm3QEBg1T96B
         hkbOF+ukA7Lpg2ISpyXm9zR/eM2RqZIzhDy6r6UhK9ONN5oRQbW+RXDgZvZFelre5jve
         0fLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768158875; x=1768763675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k6AlMVy9ciJTJpdV8gMWZ1nSB+n2ZPly1UT3btHq6go=;
        b=aysKFpK2cg3aZjfcevI2/mBbUhqBhCIIlowI30gUnjvqrEDil2mXu0kJ7OZur+xM6/
         hHLHQMnLvgcLj2HBArwvW59z4h+f5zwSzw7mqBoNtBFDgFzJLRMKey+ozNAg/Y7fzf08
         dQ6YWMPzxm8d7JFWEysqzWUvpoDydJPawjuEr8swGZMiit4JOD3/0RA4IA9QbJxz0/vW
         qfXvIOgWoLjbXbqgFTkaj+/cSRjcOuEIdEAhUjum/nkdVcwDN8Jkwt9ORrMwZjz8X8Pk
         S+Jztebi+MpuTqEjCzZDuV+BadqQfdSnBgO4WZFZuib7zgw9DvjWKq282NVMTdyaWXBp
         wHLw==
X-Forwarded-Encrypted: i=1; AJvYcCUpnDTqCoSzSJf1tEifJcbjwq4pGQ5XexuIys68dx9iIY5xQO0aB31EviwvOIHZwiC9iB2XQZI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnDKqtlqque1jPEVjbdPDqXYsvLA7U8iLYswFdDvhCyMOWQuAL
	v+zmEUWPtIhD9wcyY/BET3Rxq22Vu8+1Zry6tmCK0R970Ieb+3GHlQ7BoHz1qT/81OaIQ7VNn5G
	wMOtKRnAFetsCh2YumjmxkewRYsC2Caety38YFlsX
X-Gm-Gg: AY/fxX7KF80QHKjWFqNYFfcU9IZZM83fGx+RtEZhkyIgpMaxO47PCiA/IzCWLeINRMU
	Ys9IkTKq56DjKsHGh2fCb3nnVLue2uTcSluwsxAd159mSLURlt1LC2wzj3879dh5uS3+hTEyYhp
	543mzLj4gM3QFiFKU8eRYQgkXh/wkn6ZWdR05REhaUER5Iw+g1gdiFVjZEw3JjXR8nBmVqZ+7Bg
	UExuqM72R0semWF3dgLIydmYhIT2B87obDnwxF+1w16n0m+DiG7nm/c9IOyRo7rxQa0a+v2u0Eq
	xOq3/A==
X-Received: by 2002:ac2:5392:0:b0:59b:9403:c67f with SMTP id
 2adb3069b0e04-59b9403c7fdmr1298e87.14.1768158874137; Sun, 11 Jan 2026
 11:14:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260109-scratch-bobbyeshleman-devmem-tcp-token-upstream-v9-0-8042930d00d7@meta.com>
 <20260109-scratch-bobbyeshleman-devmem-tcp-token-upstream-v9-4-8042930d00d7@meta.com>
In-Reply-To: <20260109-scratch-bobbyeshleman-devmem-tcp-token-upstream-v9-4-8042930d00d7@meta.com>
From: Mina Almasry <almasrymina@google.com>
Date: Sun, 11 Jan 2026 11:14:21 -0800
X-Gm-Features: AZwV_Qjc9N7obQhSR7tfjDnibSqsWsISSF4YswjnxYBiVBax_pCtfSgtAahmfw0
Message-ID: <CAHS8izP=udLS2E2ZCvY4dGu3=L+SnPVQePsh=hNaM=3gy=YtHw@mail.gmail.com>
Subject: Re: [PATCH net-next v9 4/5] net: devmem: document NETDEV_A_DMABUF_AUTORELEASE
 netlink attribute
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, 
	Neal Cardwell <ncardwell@google.com>, David Ahern <dsahern@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>, 
	Donald Hunter <donald.hunter@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	asml.silence@gmail.com, matttbe@kernel.org, skhawaja@google.com, 
	Bobby Eshleman <bobbyeshleman@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 9, 2026 at 6:19=E2=80=AFPM Bobby Eshleman <bobbyeshleman@gmail.=
com> wrote:
>
> From: Bobby Eshleman <bobbyeshleman@meta.com>
>
> Update devmem.rst documentation to describe the autorelease netlink
> attribute used during RX dmabuf binding.
>
> The autorelease attribute is specified at bind-time via the netlink API
> (NETDEV_CMD_BIND_RX) and controls what happens to outstanding tokens
> when the socket closes.
>
> Document the two token release modes (automatic vs manual), how to
> configure the binding for autorelease, the perf benefits, new caveats
> and restrictions, and the way the mode is enforced system-wide.
>
> Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>

Reviewed-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina

