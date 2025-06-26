Return-Path: <netdev+bounces-201624-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E02AEA1FE
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 17:09:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F58216BBCE
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 15:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4E22F0E42;
	Thu, 26 Jun 2025 14:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YXkGXsjq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EADE02F0E3B
	for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 14:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750949567; cv=none; b=jCzLmlxBs+pG6RP/uuwBvDnUjwK5GwfC88ehagJGGBpuI8GC9z2OCk50F3cgsIhhMrDy80Im36K3WEg45T5kBYCu7aUPa7th8a0mE1J8W8M5AVNP2hs1j/Xm+STdVeXjl2Z00a125lR/OlSzSn5jun8aIq9povuuCQ13St6Ykos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750949567; c=relaxed/simple;
	bh=biROWf9+JA3pXhyRyxNUya9hFniFj06ka8P4QiJiHrk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u2QoGxKLSqah2tdmhL3LBonylWH/cPJytuKfGd0D9anu44RLH7jJk0rqkmoCw/TFg+pKG0+85mcGiGVTOfVqvFfaA469XF9mbOMSOsFb8JQh14oGN1jWy5aUn1F0JM58sih4Y6cglAIUglDsj4Ct8Z0kOVdmG2B+rS6NqMMqxuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YXkGXsjq; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4a5851764e1so21119211cf.2
        for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 07:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750949565; x=1751554365; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=90kbgEpP1fwf1mNnxRbeI9lZ/Q528GNQCAff1uOAksQ=;
        b=YXkGXsjq+5XtY0wHTNyC/N+iLCzGE5p1B4kxdrA+M2moYCiFNy0mZ65AhzIVRZxxbW
         ktZubRFAk6RYgFIWo4JIYTM6dQX2AP0721ZtYlbhg6QbgZNhki6I9vd3h5I1AHsDjUL9
         vU4e6sxVMyUvyTCYy6yVfrLc/QfNH/bxJqVjo9T9xOZJG6j2tGGp12ZY8PVJ5tGGdldc
         nsthzvXAEXQ5Y3fFhlvx3azbOg79Y5lfbtEsfPMJ7w4Ooq3muOWh8xLMSiGE2/+ODh2B
         0Y8P2VTAQNj9TZeBXReUiEWozCmlyZ5q/S6XgR/cAh0PGOMWCWf2+fUreCxnf0KFIF8I
         ZPPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750949565; x=1751554365;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=90kbgEpP1fwf1mNnxRbeI9lZ/Q528GNQCAff1uOAksQ=;
        b=UvrVXo5yjoj3renLyCaUvwPD15h0j7SnEZ0WvhV2skvrjn61aJK4LdxnU0tILHn+cc
         CfmEHDxTz+p6IQH8COaTJT2btmRKsbEoyYyRiE7uSFXjOBXsrY3xFoDchGLxbBbHlUys
         nr4uaWVqlsUZpCDGN6BuxvCR5na+EXskZJsQeWARThfioQwmeobakOr3TYAzRfOLOnIj
         h+LgXOzN94S1WgAYl2qTSPOzoQcij5nyBcNAnCxCraq1jRaF0lG9Sw/vJnywt5vdU/Us
         tkqan+V4RqtyXuYCWPYGf0P3NB0Jf0ca4FEXALFhnAnTNzevBZUZccsxy2rW7Cx1+5f3
         z8+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVBptkQMCps11FgMOhhWraUDQ5lPBk4HgtY0AQYnqN2HtLxY906rXkajkdVtBwblwt+/jpaoyA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxioTFTXKv+UG8CRt+kp14lCf68jPDp9EU338MwcAZrUA4fzLpI
	ulSTEBBvQ+p8W3FzEmAeNbE/KMYYbUxL52dxfATFqj5rnUvIV+ugO/9+wZkkjtWDmEs5EjEgEhq
	Btnm5Iv+/JrfVjyjBPyvI0/26baOfuT43lK4ZsWiB
X-Gm-Gg: ASbGncvMA0iEA9srCtQxCnpU1WkumqOUQNyULApvk+l83eZlDH4igAQDcqxpzyQJKvn
	M76GyrFgA4q7V0gFRxwGDpfcflJLldgxdDgwHtACXDeTUHOfK/zqeK0y0W8hAI/fbs66x1KQBer
	JmqELM/pSL5dJmf/73lPF3y7e0ryZ+c2HzzANqmTq9mn8=
X-Google-Smtp-Source: AGHT+IFrONe8ai1KHA9yZ64+7dPD2H5kVerCLy0iFAt1hAW9TrclCkUgghPCaBCw1ZfC/CgFE5x7eVu7tYWYIwiHKSc=
X-Received: by 2002:ac8:7f0f:0:b0:4a2:719b:1231 with SMTP id
 d75a77b69052e-4a7c080a450mr129187801cf.35.1750949564367; Thu, 26 Jun 2025
 07:52:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624202616.526600-1-kuni1840@gmail.com> <20250624202616.526600-14-kuni1840@gmail.com>
In-Reply-To: <20250624202616.526600-14-kuni1840@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 26 Jun 2025 07:52:32 -0700
X-Gm-Features: Ac12FXx95IavfJboF_MczwTXM4U0IXtrdYdiquqL6KwXNRLNjvRfm7IwIQp2dsw
Message-ID: <CANn89iJs9Z1PgRUTik63tLwTJATVMzZGe0Cpg1MNwCW0F2Mihg@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 13/15] ipv6: anycast: Unify two error paths in ipv6_sock_ac_join().
To: Kuniyuki Iwashima <kuni1840@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 24, 2025 at 1:26=E2=80=AFPM Kuniyuki Iwashima <kuni1840@gmail.c=
om> wrote:
>
> From: Kuniyuki Iwashima <kuniyu@google.com>
>
> The next patch will replace __dev_get_by_index() and __dev_get_by_flags()
> to RCU + refcount version.
>
> Then, we will need to call dev_put() in some error paths.
>
> Let's unify two error paths to make the next patch cleaner.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---
>  net/ipv6/anycast.c | 22 ++++++++++++++--------
>  1 file changed, 14 insertions(+), 8 deletions(-)
>
> diff --git a/net/ipv6/anycast.c b/net/ipv6/anycast.c
> index 8440e7b27f6d..e0a1f9d7622c 100644
> --- a/net/ipv6/anycast.c
> +++ b/net/ipv6/anycast.c
> @@ -67,12 +67,11 @@ static u32 inet6_acaddr_hash(const struct net *net,
>  int ipv6_sock_ac_join(struct sock *sk, int ifindex, const struct in6_add=
r *addr)
>  {
>         struct ipv6_pinfo *np =3D inet6_sk(sk);
> +       struct ipv6_ac_socklist *pac =3D NULL;
> +       struct net *net =3D sock_net(sk);
>         struct net_device *dev =3D NULL;
>         struct inet6_dev *idev;
> -       struct ipv6_ac_socklist *pac;
> -       struct net *net =3D sock_net(sk);
> -       int     ishost =3D !net->ipv6.devconf_all->forwarding;
> -       int     err =3D 0;
> +       int err =3D 0, ishost;
>
>         ASSERT_RTNL();
>
> @@ -84,15 +83,22 @@ int ipv6_sock_ac_join(struct sock *sk, int ifindex, c=
onst struct in6_addr *addr)
>         if (ifindex)
>                 dev =3D __dev_get_by_index(net, ifindex);
>
> -       if (ipv6_chk_addr_and_flags(net, addr, dev, true, 0, IFA_F_TENTAT=
IVE))
> -               return -EINVAL;
> +       if (ipv6_chk_addr_and_flags(net, addr, dev, true, 0, IFA_F_TENTAT=
IVE)) {
> +               err =3D -EINVAL;
> +               goto error;
> +       }
>
>         pac =3D sock_kmalloc(sk, sizeof(struct ipv6_ac_socklist), GFP_KER=
NEL);
> -       if (!pac)
> -               return -ENOMEM;
> +       if (!pac) {
> +               err =3D -ENOMEM;
> +               goto error;
> +       }
> +
>         pac->acl_next =3D NULL;
>         pac->acl_addr =3D *addr;
>
> +       ishost =3D !net->ipv6.devconf_all->forwarding;

RTNL will no longer protect this read, you should add a READ_ONCE()

Other than that :

Reviewed-by: Eric Dumazet <edumazet@google.com>

