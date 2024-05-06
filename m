Return-Path: <netdev+bounces-93733-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 628AC8BCFDF
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 16:18:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D070B250BE
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 14:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27DB213D297;
	Mon,  6 May 2024 14:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="AaGsmMzv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C0D81211
	for <netdev@vger.kernel.org>; Mon,  6 May 2024 14:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715005065; cv=none; b=EYEG8haMr7uEt0uDqzRApNL/7N5KBURH66G3Xd3N2ggTiF8hfPrjgK+GwEE6RFWWkBDpfAehXsafBqqU2uUXe8yCoHxt5ZkeTX1+oIFpoepASjcCCaKx/O9xs5QP2WUQ0qmm5PjW7qBLcp4AuvSn13z/amypjrz3taRm1+57LQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715005065; c=relaxed/simple;
	bh=nxK7n6/gLFVbdhAFMU4fQA/TACh6BFrjN5LxPYPmQd8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A0PGOhFA9eIsMZlmQwfINgQT8lJbIcG8u+Y7L9mt2Yl3G7AExI+6JqQFp5mMmXL/ZS1wa2+Lr6xct/3LDy94Cm2KX1sg0fQG99yVrcC4fC4u+0PnoqwyHTKhuPqITElgNxju1MgZkg0lvN5tkuhfr3IftUZbaUxyezmE2pKIvsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=AaGsmMzv; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 30DEA3F22B
	for <netdev@vger.kernel.org>; Mon,  6 May 2024 14:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1715005061;
	bh=qt4r3TK8PsAuXlNC2kzf8tL+5tJoUDJM+8uBLU+uv4c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=AaGsmMzv8cFRFdP53kxn2BuR9743L3GhyRZKNZGVQySR6ZGF0S6Im/EIzDK5MbXrP
	 BkdWYbvYvmqdS0OVqUXO+cYG4MREKoYoZWJD9QwMNI0EsQH3LCwlmw6mruiCx6Fy8/
	 IUhJUp8KyP2z7i4/JIAE0QKqYIElHvoR3CSpxgvPxEHinZKGLW4wU3FyhYionLBt3O
	 smrglrckXF2KevO6P4vfjCwzAarcG0dOv0JL2PqRuXTFzI0TymNz7at3WEgu35Votr
	 kzcNE1pU/am+Ub8bWKDeWxnjhDLpTbkWK86WEoNk12ei0Lur65jbN5l6DX0N90mxax
	 zisWJT3GHK/5w==
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-6f0446eaee7so2067523a34.2
        for <netdev@vger.kernel.org>; Mon, 06 May 2024 07:17:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715005059; x=1715609859;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qt4r3TK8PsAuXlNC2kzf8tL+5tJoUDJM+8uBLU+uv4c=;
        b=oLJEtWsjoPtXZfAtxzNlRUhD5hJBJ26Lzblp9wM5oJoiquWRP1lLIsykOwzYZby9uJ
         xXB1N3KGb4+lgx/ALiIZiNEZZpwZmyGqmWpKFYr2jLNapm2M9PvplOBRllFV9ufRG0MY
         yFsha6tJzM1lmug6K0MuZXloKMA0Ai8kNSJw4nyVcW8eTxINa0OtdjleBKEPthnSdAeD
         uAdlCIJl4cQs86+bKCWUPSUzByXnCCjSf+WDI3L3j+geqtM6zGrKhJZ6y6XpcSMMf8d2
         yHsm4/yeEEF9wG7PyC+1Ucza8sGQ7vCs3RCtk8xw/thOAdDX0sXnDE3eLtgM6YuBJp9u
         XhLA==
X-Forwarded-Encrypted: i=1; AJvYcCVAUkWkJMYn8Y98F1aW7gwqa8GNaRCqlQC9u4a7x1XfjdEJOwzvNlpuaoZIW4AiOdvO3SlMlp9nTr2DC6XxVrZZa6wNreIi
X-Gm-Message-State: AOJu0YxuvmN4oE2nBynjUqdCKe6aHMcmSP2El0+z9VjYhP6Q/sD5+ZB7
	t8wkAAyDJcxpxYuhPIIBz7Q+0IoQBj3L5yr1Re/enxn+8rzkqKJ3W8w99ZqbD4KaFQtJ90u9REK
	qrEdSW49cDK0tJ8Uhu8ieZS8DH0KazLODfBPgKF1eVP1mcWhPAbIjkK+MdDb8VjkZgfgalWo/yy
	/fTq/BuT6e6AzbFg+o2wRYRYs5946VQJO7hy6OqYXYsXprB+8M6/4H0uE=
X-Received: by 2002:a9d:6942:0:b0:6ee:ca2:523 with SMTP id p2-20020a9d6942000000b006ee0ca20523mr11510931oto.26.1715005059707;
        Mon, 06 May 2024 07:17:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG4+Q0Cv21uAqcyJ796m3+Z5LSXZzNUgpHYK3KMhn6ZmyOGxu+l9IER9gjG/5nJNA6UEvVOU2NZXkM92K1VP/8=
X-Received: by 2002:a9d:6942:0:b0:6ee:ca2:523 with SMTP id p2-20020a9d6942000000b006ee0ca20523mr11510912oto.26.1715005059317;
 Mon, 06 May 2024 07:17:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240418145743.248109-1-aleksandr.mikhalitsyn@canonical.com>
 <20240418145743.248109-2-aleksandr.mikhalitsyn@canonical.com> <8e70d6d3-6852-7b84-81b3-5d1a798f224f@ssi.bg>
In-Reply-To: <8e70d6d3-6852-7b84-81b3-5d1a798f224f@ssi.bg>
From: Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date: Mon, 6 May 2024 16:17:28 +0200
Message-ID: <CAEivzxe3Rw26mG-rfEFah7xwLnpf_RjHEp+MZV6bnDm73nLi_A@mail.gmail.com>
Subject: Re: [PATCH net-next v3 2/2] ipvs: allow some sysctls in non-init user namespaces
To: Julian Anastasov <ja@ssi.bg>
Cc: horms@verge.net.au, netdev@vger.kernel.org, lvs-devel@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	=?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@stgraber.org>, 
	Christian Brauner <brauner@kernel.org>, Pablo Neira Ayuso <pablo@netfilter.org>, 
	Jozsef Kadlecsik <kadlec@netfilter.org>, Florian Westphal <fw@strlen.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 3, 2024 at 3:06=E2=80=AFPM Julian Anastasov <ja@ssi.bg> wrote:>
>
>         Hello,
>
> On Thu, 18 Apr 2024, Alexander Mikhalitsyn wrote:
>
> > Let's make all IPVS sysctls writtable even when
> > network namespace is owned by non-initial user namespace.
> >
> > Let's make a few sysctls to be read-only for non-privileged users:
> > - sync_qlen_max
> > - sync_sock_size
> > - run_estimation
> > - est_cpulist
> > - est_nice
> >
> > I'm trying to be conservative with this to prevent
> > introducing any security issues in there. Maybe,
> > we can allow more sysctls to be writable, but let's
> > do this on-demand and when we see real use-case.
> >
> > This patch is motivated by user request in the LXC
> > project [1]. Having this can help with running some
> > Kubernetes [2] or Docker Swarm [3] workloads inside the system
> > containers.
> >
> > Link: https://github.com/lxc/lxc/issues/4278 [1]
> > Link: https://github.com/kubernetes/kubernetes/blob/b722d017a34b300a228=
4b890448e5a605f21d01e/pkg/proxy/ipvs/proxier.go#L103 [2]
> > Link: https://github.com/moby/libnetwork/blob/3797618f9a38372e8107d8c06=
f6ae199e1133ae8/osl/namespace_linux.go#L682 [3]
> >
> > Cc: St=C3=A9phane Graber <stgraber@stgraber.org>
> > Cc: Christian Brauner <brauner@kernel.org>
> > Cc: Julian Anastasov <ja@ssi.bg>
> > Cc: Simon Horman <horms@verge.net.au>
> > Cc: Pablo Neira Ayuso <pablo@netfilter.org>
> > Cc: Jozsef Kadlecsik <kadlec@netfilter.org>
> > Cc: Florian Westphal <fw@strlen.de>
> > Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.c=
om>
> > ---
> >  net/netfilter/ipvs/ip_vs_ctl.c | 21 +++++++++++++++------
> >  1 file changed, 15 insertions(+), 6 deletions(-)
> >
> > diff --git a/net/netfilter/ipvs/ip_vs_ctl.c b/net/netfilter/ipvs/ip_vs_=
ctl.c
> > index 32be24f0d4e4..c3ba71aa2654 100644
> > --- a/net/netfilter/ipvs/ip_vs_ctl.c
> > +++ b/net/netfilter/ipvs/ip_vs_ctl.c
>
> ...
>
> > @@ -4284,12 +4285,6 @@ static int __net_init ip_vs_control_net_init_sys=
ctl(struct netns_ipvs *ipvs)
> >               tbl =3D kmemdup(vs_vars, sizeof(vs_vars), GFP_KERNEL);
> >               if (tbl =3D=3D NULL)
> >                       return -ENOMEM;
> > -
> > -             /* Don't export sysctls to unprivileged users */
> > -             if (net->user_ns !=3D &init_user_ns) {
> > -                     tbl[0].procname =3D NULL;
> > -                     ctl_table_size =3D 0;
> > -             }
> >       } else
> >               tbl =3D vs_vars;
> >       /* Initialize sysctl defaults */
>
>         Sorry but you have to send v4 because above if-block was
> changed with net-next commit 635470eb0aa7 from today...

Dear Julian,

sorry about the delay with v4 (just rebased it on top of net-next).

Have just sent it
https://lore.kernel.org/all/20240506141444.145946-1-aleksandr.mikhalitsyn@c=
anonical.com

Kind regards,
Alex

>
> Regards
>
> --
> Julian Anastasov <ja@ssi.bg>

