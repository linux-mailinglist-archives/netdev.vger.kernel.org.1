Return-Path: <netdev+bounces-153725-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 805929F96A5
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 17:35:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 005801884EBF
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 16:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D45219A9A;
	Fri, 20 Dec 2024 16:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UacXoMUh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0F4219A66
	for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 16:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734712435; cv=none; b=nHoyMPQBTGn5a0SAVjCeYc0Q2gn5pkWv6eXNJoZhfkcRhrqenuS76BdyvMGn5rtDs10z5WAa7gJWUDOAQh79tRgi1kgcKsOUkw+1FtPI/lj7dI0hIGcki4LtklQuZ8B9xVrndFI7Ah/lMNQcyn4JEZdTgNRFy6tldjMOm9a+UWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734712435; c=relaxed/simple;
	bh=1kGU6egwkuzhglcqvh7xKay5WLUx2cchusisAF8ds3E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ITJzdSqjfILce9jFM7lxI/e07p0gZFDSybP8MyThm4o28yM9mbzJ4UmjVcg2gqlvgH08uadKdtLCDoX6VutkJFZyPKVZeDn5SpL6jVipDd7oFkfn443fDWU/nZJxe+i0Ik38TMEBJBjELhcTlygJ5+G/J6CQq7bkSStwJxKCHJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UacXoMUh; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5d3e829ff44so5739561a12.0
        for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 08:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734712432; x=1735317232; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1kGU6egwkuzhglcqvh7xKay5WLUx2cchusisAF8ds3E=;
        b=UacXoMUhOvVjB9+oZDeHLqARg3dzP/biwBi19bMzb1an0JE2IJnRJ2rUHkfve+Vn90
         xOcTnUpU4dhF1B9XcTCar6qXXQ/BympAtZ0z6OgflUa6pfOP6AyuDLergOgQBXEc69Ij
         KjsksRmEq2LjpDGyXULd/tpGy8gXBi6aIImp5YZav+feMuNOemRbHwBxX5rzqbcPpNwu
         2JHx6HWSrg66Rtq8Zmcl1zwee7ZVsweUr/6dQMH52y0CYFkNVAJvQR2sxcIOTHZuGTTJ
         YwndfVGYuenZo3zasJ3JXZjbmwLhmsnwq4UhsbKjmaMxNDCxnsXuw8dvYxlUjsE5U6ZQ
         l3rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734712432; x=1735317232;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1kGU6egwkuzhglcqvh7xKay5WLUx2cchusisAF8ds3E=;
        b=M1PKLLPeLr4yPbp65Eifps/oOoU6NGZfxQfA8seBfGRJKqkLM6Thn4XT3Q76QfOpS3
         0oJpCpExiqU49z6BACRaBxcyWekHy7Mrru01jkIE+bAlJA3vvAAszIj8W6R7ypf5ZiXS
         8WB+9lsK3Ky/Nkpbda0+EfvojnbOmDgXlc7W7k4QMTAZhtkc2RfKWSydRbUuLOk4q6Qw
         D9vofpvmZXS2lwBzAXghOxqqtJqLq80CBPHkA9cLyuqWEJzlw+Hiw/D6DvtqKGveUrj7
         xhG3X54a4cIC2lqCDkeM5F8jMkKC6Z9uvaSZDtMp3Q/8eub7m8z/MBrFx7UgGGqdgEf3
         2vpw==
X-Forwarded-Encrypted: i=1; AJvYcCV7wtGhzXGtX8ejrXRgjaM0R6EUdjD8FVgrPqfmjCDax4RPz/EmHyLo97mbHde2qgfSSbquEkQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj04ejEZd5oXgzmKybl+0yBt2jWQ8E1Fbv4gJmlFi/kPUxRhC8
	s/UbBK0MA/5Pb9IEDAlooOj5FKfyssZREnAHAKfj4n6qua3ho5ipKUHw02oyZlJqX5bKW7FrSk4
	RUFdR2s45o+iA9FXmxyteEiYV5eGwLQkf0Sn3
X-Gm-Gg: ASbGncskYuYe319n/qHFGwUDKn4ahP9GW5dWAs30gw6EiOLB5QMa0soaX9VNYl+SRjX
	ca9DNQJ5fqy3Aw8TN/6lQIOouu5/YTXcbyVBw3g==
X-Google-Smtp-Source: AGHT+IEn85XwxIOd07ptRDetwMHk8igd6GDxq/plvtdpDoK72zGLsUPGGlA0Fh+K4R5bUBDmUb0Txn7cJUGS/r9nW7o=
X-Received: by 2002:a17:907:704:b0:aa5:b8dd:fec4 with SMTP id
 a640c23a62f3a-aac080fe63emr726019366b.4.1734712432014; Fri, 20 Dec 2024
 08:33:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241220083741.175329-1-kory.maincent@bootlin.com>
In-Reply-To: <20241220083741.175329-1-kory.maincent@bootlin.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 20 Dec 2024 17:33:41 +0100
Message-ID: <CANn89iK0VdrCV7Hk=vjT4t3v=OJZXnKaOiMuTN_=ZDzDEuCzvQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2] net: ethtool: Fix suspicious rcu_dereference usage
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+a344326c05c98ba19682@syzkaller.appspotmail.com, 
	thomas.petazzoni@bootlin.com, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 20, 2024 at 9:37=E2=80=AFAM Kory Maincent <kory.maincent@bootli=
n.com> wrote:
>
> The __ethtool_get_ts_info function can be called with or without the
> rtnl lock held. When the rtnl lock is not held, using rtnl_dereference()
> triggers a warning due to the lack of lock context.
>
> Add an rcu_read_lock() to ensure the lock is acquired and to maintain
> synchronization.
>
> Reported-by: syzbot+a344326c05c98ba19682@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/676147f8.050a0220.37aaf.0154.GAE@g=
oogle.com/
> Fixes: b9e3f7dc9ed9 ("net: ethtool: tsinfo: Enhance tsinfo to support sev=
eral hwtstamp by net topology")
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

