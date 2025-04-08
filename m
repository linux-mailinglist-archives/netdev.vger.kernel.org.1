Return-Path: <netdev+bounces-180077-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C8BDA7F756
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 10:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AF6F3AE193
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 08:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A87C263C74;
	Tue,  8 Apr 2025 08:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fIIoJFUd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B962420459F
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 08:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744099884; cv=none; b=hSi8TvKlzgjYaPH4iJsALMlEJ8qivbHzHQvBsQKlTbybpq/p/vyawCdyta/2YiFcyevzhptYSrTdrzfOfyhCLChXT7M6BYXPFhZFM+Fr1IkO0kt+Y/ZpDkEDSKTpjl0oLJAHscP+glLDM5g0LKJ8ZuTsCsEZbkT15B9CaFBcUow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744099884; c=relaxed/simple;
	bh=HNeRbYF4/v2655du+OhPlrYqgFpc4HO0WwSrHFA5Wvk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bYA9v18GTvy7RPVKP1uBOf4lP1R77jBKBrUhMz1UkWUtZwI1Jku47E4Alw/ozLKYuOI5dcjczeJu9BsGkYKCev2rZVSGEhHnK+cEomFKw6OjE0EdwwAMeC+Uk9jOO6FeohFh3VDi52hUg+TcvFOzHbr3lzLsXiVnybY5cGwDbRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fIIoJFUd; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2295d78b45cso67782685ad.0
        for <netdev@vger.kernel.org>; Tue, 08 Apr 2025 01:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744099881; x=1744704681; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HNeRbYF4/v2655du+OhPlrYqgFpc4HO0WwSrHFA5Wvk=;
        b=fIIoJFUdoObj6pLnLKymgmHqDL1Kn+AYCSRTQyNUsdbRbH1Z24unMEj8egSOgIlQ4w
         MwUjlWuYlKj2prZlIJQI/FHgbLjcXCYwWt3AfuLgErb/zm/YoDxSFFXJoVyNnqFfURlN
         0v3Avb+D7sLQf1IYh6VXeX/lyAOSmaqI+xAFjhbkoNYRTShz3DWE2d4w7nMeikKESUx2
         VaRtB1MpBTNd3szxMp9I1321TGWYD6Xw/63Kd8AnYeR0jfWmq8rKKyvl7RAJmMFtC1u8
         8XM/S8dpGFa1Gw/9RJ70E0Y8+0c5V7Ivik/4ZPpFtgaoBA7HagD2aPfdUuqdIy17I0RM
         DWLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744099881; x=1744704681;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HNeRbYF4/v2655du+OhPlrYqgFpc4HO0WwSrHFA5Wvk=;
        b=XBNLCcswswdrptAxb8d4iy6obATcXj1PfF0GEWk3xYLQsX+LvCyVrj7VWw6nPDRAmS
         qx1acsW2fVitPvJzXg+gz8K6YbiERKeS2mopWDPcAQbVodhUn11YccEmkPgF/ERg3nVb
         MJq5VrGAT4el9LPnm3PP8YmB4/3vomWaXS1rd+9hrtY3yqrPBQovKWh+SENAhJAn2DD3
         2sQSPyFDVgZYL5TPbCeH0sA1dJ/k92Rfsqs6hSUfAYr328RcFLCpJP7AI0kct+x9bqLh
         2g+0zn8x735VfmEj9eQHfiV4RKunJ0se0mYpD6tSD4PUrGG8Y+ipaa6QiOfPely4i0qb
         qBhg==
X-Forwarded-Encrypted: i=1; AJvYcCWbeqhehVN/hBVZBFXWryOuxxhyRWgEZcXlLqy4Fs9ciKTOwFNEycBZkixECtIysMjnq0rvHy8=@vger.kernel.org
X-Gm-Message-State: AOJu0YypGpOzTx5od3GKWqkYGrsEeUKpt51EhgpYCeGZANV0oYunNCeh
	O9ttulVfgTVavKTTgUSUs+WftRWqBMURdAJAhqDXgyewbrV0dAXnuUXkbMDL2mNaR7EM1/zD4dy
	91HWUdUdi6NilsIqWA6CqyN0HnVOzAUojayzf
X-Gm-Gg: ASbGnctpRNpj9b9uq240hDBqr/XBJf+9EwTkaWIqQ+DoopdqxsG7vzZ6UEs4AyQ9JNu
	kTI4jOy0wVFyja0Xvl/X7hUyXRTWpYZrjBN66H4oWBMMB+IEwUPdUxNFOIKva01ACM9t7K5KOr2
	w51vrYj45fte7HjHTGnp/WSB85oNb0lqnkKJCDN3G+DVCGqbka/mN8N+zy
X-Google-Smtp-Source: AGHT+IFQWcX8la3mf3erxygnc0Yxk6VdfJlO+R1O7xgLJNRsvV6Nb+bNzo3lRucwwrpQVJHAsLqHfIHBTUxDqrFrZkE=
X-Received: by 2002:a17:903:1cb:b0:21f:7a8b:d675 with SMTP id
 d9443c01a7336-22a8a0428b8mr221441315ad.4.1744099880739; Tue, 08 Apr 2025
 01:11:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z_PfCosPB7GS4DJl@mini-arch> <20250407161308.19286-1-kuniyu@amazon.com>
In-Reply-To: <20250407161308.19286-1-kuniyu@amazon.com>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Tue, 8 Apr 2025 10:11:09 +0200
X-Gm-Features: ATxdqUEJdhoVuF1kE17SFFqgm4y9d22GopYGugK8_wlLPzMs2KTVHWjwqJHr5p4
Message-ID: <CANp29Y5RjJD3FK8zciRL92f0+tXEaZ=DbzSF3JrnVRGyDmag2A@mail.gmail.com>
Subject: Re: [syzbot] [net?] WARNING: bad unlock balance in do_setlink
To: Kuniyuki Iwashima <kuniyu@amazon.com>, Dmitry Vyukov <dvyukov@google.com>
Cc: stfomichev@gmail.com, andrew@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, horms@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	sdf@fomichev.me, syzbot+45016fe295243a7882d3@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 7, 2025 at 6:13=E2=80=AFPM 'Kuniyuki Iwashima' via syzkaller-bu=
gs
<syzkaller-bugs@googlegroups.com> wrote:
>
> From: Stanislav Fomichev <stfomichev@gmail.com>
> Date: Mon, 7 Apr 2025 07:19:54 -0700
> > On 04/07, syzbot wrote:
> > > Hello,
> > >
> > > syzbot has tested the proposed patch but the reproducer is still trig=
gering an issue:
> > > unregister_netdevice: waiting for DEV to become free
> > >
> > > unregister_netdevice: waiting for batadv0 to become free. Usage count=
 =3D 3
> >
> > So it does fix the lock unbalance issue, but now there is a hang?
>
> I think this is an orthogonal issue.
>
> I saw this in another report as well.
> https://lore.kernel.org/netdev/67f208ea.050a0220.0a13.025b.GAE@google.com=
/
>
> syzbot may want to find a better way to filter this kind of noise.
>

Syzbot treats this message as a problem worthy of reporting since a
long time (Cc'd Dmitry who may remember the context):
https://github.com/google/syzkaller/commit/7a67784ca8bdc3b26cce2f0ec9a40d2d=
d9ec9396

Since v6.15-rc1, we do observe it happen at least 10x more often than
before, both during fuzzing and while processing #syz test commands:
https://syzkaller.appspot.com/bug?extid=3D881d65229ca4f9ae8c84

--=20
Aleksandr

