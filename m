Return-Path: <netdev+bounces-62894-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B98E829B19
	for <lists+netdev@lfdr.de>; Wed, 10 Jan 2024 14:19:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDDD51F25A04
	for <lists+netdev@lfdr.de>; Wed, 10 Jan 2024 13:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504E3487A4;
	Wed, 10 Jan 2024 13:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xr++cHrC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D0848CC0
	for <netdev@vger.kernel.org>; Wed, 10 Jan 2024 13:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-55818b7053eso8577a12.0
        for <netdev@vger.kernel.org>; Wed, 10 Jan 2024 05:19:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704892782; x=1705497582; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zcuZSATt3D9i3sz2m/7ESdTYVVlDzAh2DZuioh5b1go=;
        b=Xr++cHrCfY2nmGSmBlHPXPutbvIeIZdtQAlIjdP8OkDl/XYCRHa688FNx6MCv52vvk
         0Y7EQwCYS/4BAvj8ZWO/meOIiZTS6UHnikoYsW0bAMHD0JxwnWAsT/hP2EXS/sXFRMQh
         WBE3X8u3UXF53stoZlZGv8cPpgBhNoHcANBXyJCsxRiy5od2wvbUMZ5Pm8b671gwRPs1
         cvNDaqATXg07oYvBhI3u65si5dTIbO2PvC2ADR/gMMADV0hNAkVHX/BVNR41V4jp/nup
         BFI326rO5IyO8Ut9W0eI0wJK4aXDrfY1vHjdUmMVgti7fiUaNarqc76wxSurr8vMTPXh
         utiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704892782; x=1705497582;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zcuZSATt3D9i3sz2m/7ESdTYVVlDzAh2DZuioh5b1go=;
        b=frsUWTb4W4EghQRzkQPg3MXFVVkZoFKUqtkv+Fw9MH+pcoihf8UnnCINyGuHlNQ6aj
         JbxeGTRTvRsRYkI9JzqVwLfzXrgVowNp0rQachBM4YMdWKweSJmSTHSznLkDTIi91tNX
         CYcgNbi5BPqPfkyNW1sIVh7nU6WcEkRHnUEC2X5gTCx1MPGEWGIZ+iXPWFB6NniwVHOC
         g/gk2+5DpF1HaewHUyFdIHb0/ElhBzKv9g4G8VioMyaHzFrxnjiz09ebMkY+rdDwjhDQ
         q7q75mm73qVbbPRSL9RrteDll8uHyJt9qiW7nnlMiHfH2KSuBDR5z8RFhoYV5UJvpuEG
         JmZw==
X-Gm-Message-State: AOJu0YwaOAyH/a3NEraVUp+S1zLfItUvYa22UqCf4QTIfSb5JWVJJzHf
	V6JO6JGbqsIaB3P6uhXMjG2sVevDxTGZ4N+hcqaov1ArKeRw
X-Google-Smtp-Source: AGHT+IHJdzRVQ/HNy+Y8ND4FKtirTIDvgGHGQ+lw68pOah+nb9egtkyQeJgtFA8fm/ASpg2iVQjSXGMdCy2GdGEqAcA=
X-Received: by 2002:a50:d650:0:b0:557:24d:6135 with SMTP id
 c16-20020a50d650000000b00557024d6135mr15481edj.4.1704892781683; Wed, 10 Jan
 2024 05:19:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240110003354.2796778-1-vladimir.oltean@nxp.com>
In-Reply-To: <20240110003354.2796778-1-vladimir.oltean@nxp.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 10 Jan 2024 14:19:27 +0100
Message-ID: <CANn89iK20iBqPvMv6xrjPK4ybVKx9VKAUXZJQJHVzLxVFg+RAA@mail.gmail.com>
Subject: Re: [PATCH net] net: dsa: fix netdev_priv() dereference before check
 on non-DSA netdevice events
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>, 
	Florian Fainelli <f.fainelli@gmail.com>, Dan Carpenter <dan.carpenter@oracle.com>, 
	syzbot+d81bcd883824180500c8@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 1:34=E2=80=AFAM Vladimir Oltean <vladimir.oltean@nx=
p.com> wrote:
>
> After the blamed commit, we started doing this dereference for every
> NETDEV_CHANGEUPPER and NETDEV_PRECHANGEUPPER event in the system.
>
> static inline struct dsa_port *dsa_user_to_port(const struct net_device *=
dev)
> {
>         struct dsa_user_priv *p =3D netdev_priv(dev);
>
>         return p->dp;
> }

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks for the fix !

