Return-Path: <netdev+bounces-159442-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34573A157C7
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 20:06:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 592931683C4
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 19:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 409EC1A76AE;
	Fri, 17 Jan 2025 19:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q0NScsu+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DF213541B
	for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 19:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737140803; cv=none; b=MN5IBoa0z+dl9ywP2kGgg0fNonBHxs9Si/kp+eCceWL037CvfpN7dkGqQh39i5OJqfIIKd4FOGSD0C+tnnJT5FpglPzUXtHSuZ9iH+LurslI6IspvibVV2hiI3uapAl4tzxgUc2PPWWAn8Yp9yZ5i6STwfb7pVs3+rU/+6MeoYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737140803; c=relaxed/simple;
	bh=uh+aeyzNevyMYPUyw+kYdzpwVui1vd+5cu1zFyrZKvU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OpBEjeMUU5S6t5GoV5jbtqCE2fPiOXrH8BneVVgj7pxY9S0fvkkjEoEEM1osFDir8qJukf+LuxZkbGFU/zyONmGlXTc6hity9D6S/w1ap/xWTOPSkIfkbIsgHnU8fCN8CbctzySGJpT4N3v0nWrE34aqOkT2147YKeEtoRRVWZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q0NScsu+; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5da135d3162so4048060a12.3
        for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 11:06:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737140800; x=1737745600; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=reAVrI/NnbVJ30h4bnDtc142qCfR4fbXDFFP6VL5JN4=;
        b=Q0NScsu+sZAz/GtCceo5sj8Jc/UMo74hATW/EHc0lGdI3Dr37+eod0dEhYczDZRyjU
         J9FeKnUmQeOOzJcOnwmhhE29HxAvDQHYlYUnlJDMGWqcNHFNvvoLNyVSM1EWxw9WYyul
         ovIdOPSsi1qP2XXZsGQRd6pDQ5xCre7fDmll8cLloFBWzzEyv0hXhpxzRiLLR0BF8wAl
         hWoIfHJHgBc6pv/RYzTh/7OzA00cjjZ4NJnW/c7c+g9+KmhcgnzMjKLiemYAFpvt6259
         AJ7s5YxidDamKQPpwj37+4+jdZnYKwLwjafwMjU9aytLl8fQ3QOdzDhx+YKMuZEiMdJX
         FraA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737140800; x=1737745600;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=reAVrI/NnbVJ30h4bnDtc142qCfR4fbXDFFP6VL5JN4=;
        b=mKdiUjF77FiDKctvqZy02nA22Bg12pfXrOK3e5KQBjBHDmEtf6RZsLM1qZ4cdGla9G
         I0YFk0pIkgHV3TuNMIEGGtvb+rywPv4uWyqIk2Yj+QAM0RLulgo1SuxLdPGV/LK7UYvJ
         TT3fiV1Oyp9T8imOoQAqRomop9LQ8yxfQJlcAX7+nDrJ9PNTDZynBs6d/taPWSoW1gmo
         bZiQaxOWd8u1/q7WeCz904s4WMWNKbnlSpL/ARk2xYYQYov9L9WwrA6y29V0ECKTWVxj
         U8ieQRUifXUte8Ql1aHiRPvTkJ3TlFsAjx733dvgZdv5QRHAYb3+LLFMqrSiVsyDHCln
         58ng==
X-Forwarded-Encrypted: i=1; AJvYcCUXDX59Y7wgzUHCgPRA3i716QP/jf3ErXrCZmzR7TI4PL1ZUka2UP0WylEAvcW09PB4c61OR4M=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywcw+NgFit0sMkPHei6PlIpnWtwn+HKmMLzo0IUz20nWXE/bx20
	oF1PANwKpz6083mI5vLBBIDjos1zq8ZtjVlfE0YUlDMAj0IHgTF3MIkzQKFTymVQXcLFHfzCLUT
	1Me/UqTfTZhV5Fq4MJkfO9bAK8twRo3AppbMX
X-Gm-Gg: ASbGncvYk2IaNx6LujJhAgNOBVUpyULZTdETIXq7fQ0rUsPN+ZeJK6D+n0fZ6iPYSIU
	BjgU30iTrUYdzsqVzVKOvYJ2a3kYpd6s1xh1LNA==
X-Google-Smtp-Source: AGHT+IHQGSkSb9BsHWYOIkxJhz11HPH87+EUnJbxhX7fre+rq+Qc337gQYJzsDL7VPRoD4PYPK+acCj1SlyRalwYXNg=
X-Received: by 2002:a05:6402:2110:b0:5da:c38:b1cf with SMTP id
 4fb4d7f45d1cf-5db7d2dc135mr3567837a12.3.1737140799606; Fri, 17 Jan 2025
 11:06:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250117173645.1107460-1-kory.maincent@bootlin.com>
In-Reply-To: <20250117173645.1107460-1-kory.maincent@bootlin.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 17 Jan 2025 20:06:28 +0100
X-Gm-Features: AbW1kvavJlDZF1Pz3BviOVpEJgww5zf4I6sMK5Dx0J8B5PCuKRoyLMJG8tMrb6Q
Message-ID: <CANn89i+PM5JLdN1meKH_moPe88F_=Nsb3in+g-ZK5tiH4PH5GA@mail.gmail.com>
Subject: Re: [PATCH net-next v2] net: phy: Fix suspicious rcu_dereference usage
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, thomas.petazzoni@bootlin.com, 
	Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 17, 2025 at 6:36=E2=80=AFPM Kory Maincent <kory.maincent@bootli=
n.com> wrote:
>
> The phy_detach function can be called with or without the rtnl lock held.
> When the rtnl lock is not held, using rtnl_dereference() triggers a
> warning due to the lack of lock context.
>
> Add an rcu_read_lock() to ensure the lock is acquired and to maintain
> synchronization.
>
> Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> Reported-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> Closes: https://lore.kernel.org/netdev/4c6419d8-c06b-495c-b987-d66c2e1ff8=
48@tuxon.dev/
> Fixes: 35f7cad1743e ("net: Add the possibility to support a selected hwts=
tamp in netdevice")
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> ---
>
> Changes in v2:
> - Add a missing ;
> ---
>  drivers/net/phy/phy_device.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index 5b34d39d1d52..3eeee7cba923 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c
> @@ -2001,12 +2001,14 @@ void phy_detach(struct phy_device *phydev)
>         if (dev) {
>                 struct hwtstamp_provider *hwprov;
>
> -               hwprov =3D rtnl_dereference(dev->hwprov);
> +               rcu_read_lock();
> +               hwprov =3D rcu_dereference(dev->hwprov);
>                 /* Disable timestamp if it is the one selected */
>                 if (hwprov && hwprov->phydev =3D=3D phydev) {
>                         rcu_assign_pointer(dev->hwprov, NULL);
>                         kfree_rcu(hwprov, rcu_head);
>                 }
> +               rcu_read_unlock();
>
>                 phydev->attached_dev->phydev =3D NULL;
>                 phydev->attached_dev =3D NULL;
> --
> 2.34.1
>

If not protected by RTNL, what prevents two threads from calling this
function at the same time,
thus attempting to kfree_rcu() the same pointer twice ?

