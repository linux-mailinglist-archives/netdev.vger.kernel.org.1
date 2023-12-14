Return-Path: <netdev+bounces-57280-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB20812BC9
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 10:37:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00ED1282205
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 09:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 264A62E85C;
	Thu, 14 Dec 2023 09:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XdqOKmAL"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDA1CE0
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 01:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702546627;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f1H0kKT3jccLGmQFqwXGxIScaEIaGvkzHt/VCZv3TM0=;
	b=XdqOKmALHQtLQT+cH4zHXrMZhrIrz/V60n5s+drzZhEplpyHMmNg3bD1F+95dM67aQYspU
	QiTj0t5hTvjOZB0N5zW7vMvV+b2cE6SxJgfI4AA9KMmQZMtdiydUMNehqKBSs/HGr214lJ
	N7qU2Mebqj4/H6okSfDZXOivb7fV6K0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-492-k-dQEwXlNS-wPcIygEYWjQ-1; Thu, 14 Dec 2023 04:37:05 -0500
X-MC-Unique: k-dQEwXlNS-wPcIygEYWjQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-40c5cf93e09so3595315e9.0
        for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 01:37:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702546624; x=1703151424;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f1H0kKT3jccLGmQFqwXGxIScaEIaGvkzHt/VCZv3TM0=;
        b=Kc6nsQFLH0MmoIBMH9ZZuxKAdNE6liFuZv8KT+3iGi002G2SF/8KwnZfZj3H8CuZGA
         pagKpJefUT0RkLEokeCTTnXUN8X7HUJMNhwdMF+rBq0PC7cJxSsPxfoRwNokrJcdrapg
         clsB4tbwdupeLNLzbWF+vaxicUIzia0nS83a7XbyBEdi2AHYoAFvm5ACmH5/EE9D6pEq
         MsVHmYJqgP1XdlIP08T5ZajLcHsoMYYVwUIBZbZO2xgzLBlmAPSrJlvvSgP4aepaA9Bf
         9bIq5pNsVC20WKMet8wToUs//JMAmUjIpFHdsArBRboHQKfKTNhHRB7U9GdTSOO6PtI5
         BP7g==
X-Gm-Message-State: AOJu0YywMPpe3Us59G/zGr7q+t0rOJ7lbZ6jObWv6orfogn9Hws1iC8Z
	yWxpAmDl7ldgWP3V1sREOqOlxzjhybtwit/cEzFV7zNZHaL/juFAm4K3EKxR7W/M2YU+mobDBUB
	LFrF35zzmipfCE7cP
X-Received: by 2002:a5d:4991:0:b0:336:433e:2d38 with SMTP id r17-20020a5d4991000000b00336433e2d38mr1460228wrq.0.1702546623938;
        Thu, 14 Dec 2023 01:37:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHzyUbq7Bs08VK6v9WSJtUEjarcwjd/7U9eu/zKNhixM3p+8B3mMJuIb308x6YGN29q0w+MlQ==
X-Received: by 2002:a5d:4991:0:b0:336:433e:2d38 with SMTP id r17-20020a5d4991000000b00336433e2d38mr1460212wrq.0.1702546623588;
        Thu, 14 Dec 2023 01:37:03 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-252-36.dyn.eolo.it. [146.241.252.36])
        by smtp.gmail.com with ESMTPSA id c4-20020adffb44000000b003362d0eefd3sm6117475wrs.20.2023.12.14.01.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 01:37:03 -0800 (PST)
Message-ID: <ebf480701cd22da00c89c5b1b00d31be95ff8e4d.camel@redhat.com>
Subject: Re: [PATCH] net: sysctl: fix edge case wrt. sysctl write access
From: Paolo Abeni <pabeni@redhat.com>
To: Maciej =?UTF-8?Q?=C5=BBenczykowski?= <maze@google.com>, Maciej
	=?UTF-8?Q?=C5=BBenczykowski?=
	 <zenczykowski@gmail.com>
Cc: Linux Network Development Mailing List <netdev@vger.kernel.org>,  "David
 S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Flavio Crisciani <fcrisciani@google.com>,
 "Theodore Y. Ts'o" <tytso@google.com>, "Eric W. Biederman"
 <ebiederm@xmission.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Thu, 14 Dec 2023 10:37:01 +0100
In-Reply-To: <20231210111033.1823491-1-maze@google.com>
References: <20231210111033.1823491-1-maze@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2023-12-10 at 03:10 -0800, Maciej =C5=BBenczykowski wrote:
> The clear intent of net_ctl_permissions() is that having CAP_NET_ADMIN
> grants write access to networking sysctls.
>=20
> However, it turns out there is an edge case where this is insufficient:
> inode_permission() has an additional check on HAS_UNMAPPED_ID(inode)
> which can return -EACCES and thus block *all* write access.
>=20
> Note: AFAICT this check is wrt. the uid/gid mapping that was
> active at the time the filesystem (ie. proc) was mounted.
>=20
> In order for this check to not fail, we need net_ctl_set_ownership()
> to set valid uid/gid.  It is not immediately clear what value
> to use, nor what values are guaranteed to work.
> It does make sense that /proc/sys/net appear to be owned by root
> from within the netns owning userns.  As such we only modify
> what happens if the code fails to map uid/gid 0.
> Currently the code just fails to do anything, which in practice
> results in using the zeroes of freshly allocated memory,
> and we thus end up with global root.
> With this change we instead use the uid/gid of the owning userns.
> While it is probably (?) theoretically possible for this to *also*
> be unmapped from the /proc filesystem's point of view, this seems
> much less likely to happen in practice.
>=20
> The old code is observed to fail in a relatively complex setup,
> within a global root created user namespace with selectively
> mapped uid/gids (not including global root) and /proc mounted
> afterwards (so this /proc mount does not have global root mapped).
> Within this user namespace another non privileged task creates
> a new user namespace, maps it's own uid/gid (but not uid/gid 0),
> and then creates a network namespace.  It cannot write to networking
> sysctls even though it does have CAP_NET_ADMIN.

I'm wondering if this specific scenario should be considered a setup=20
issue, and should be solved with a different configuration? I would
love to hear others opinions!

> This is because net_ctl_set_ownership fails to map uid/gid 0
> (because uid/gid 0 are *not* mapped in the owning 2nd level user_ns),
> and falls back to global root.
> But global root is not mapped in the 1st level user_ns,
> which was inherited by the /proc mount, and thus fails...
>=20
> Note: the uid/gid of networking sysctls is of purely superficial
> importance, outside of this UNMAPPED check, it does not actually
> affect access, and only affects display.
>=20
> Access is always based on whether you are *global* root uid
> (or have CAP_NET_ADMIN over the netns) for user write access bits
> (or are in *global* root gid for group write access bits).
>=20
> Cc: Flavio Crisciani <fcrisciani@google.com>
> Cc: "Theodore Y. Ts'o" <tytso@google.com>
> Cc: "Eric W. Biederman" <ebiederm@xmission.com>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Fixes: e79c6a4fc923 ("net: make net namespace sysctls belong to container=
's owner")
> Signed-off-by: Maciej =C5=BBenczykowski <maze@google.com>
> ---
>  net/sysctl_net.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
>=20
> diff --git a/net/sysctl_net.c b/net/sysctl_net.c
> index 051ed5f6fc93..ded399f380d9 100644
> --- a/net/sysctl_net.c
> +++ b/net/sysctl_net.c
> @@ -58,16 +58,11 @@ static void net_ctl_set_ownership(struct ctl_table_he=
ader *head,
>  				  kuid_t *uid, kgid_t *gid)
>  {
>  	struct net *net =3D container_of(head->set, struct net, sysctls);
> -	kuid_t ns_root_uid;
> -	kgid_t ns_root_gid;
> +	kuid_t ns_root_uid =3D make_kuid(net->user_ns, 0);
> +	kgid_t ns_root_gid =3D make_kgid(net->user_ns, 0);
> =20
> -	ns_root_uid =3D make_kuid(net->user_ns, 0);

As a fix I would prefer you would keep it minimal. e.g. just replace
the if with the ternary operator or just add an 'else' branch.

Cheers,

Paolo


