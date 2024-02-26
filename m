Return-Path: <netdev+bounces-75013-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F85867BD6
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 17:25:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD732B2B1F8
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 16:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D6612DDAA;
	Mon, 26 Feb 2024 16:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MnMS42SB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C0E12D761
	for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 16:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708964093; cv=none; b=HIzV9YtTbtzoQijLon856Vd4+BKn3cOGnPZYOrV5N56q9Fo7Ly/EfvtNXlG26tl4k8pV4hYQdWrkfaj8ei0OfR+yxMZQH0Pn60KCUKlomQw0z3WWmqKQY4mKYBv6JVgLCUulaqQ64+Zs3iJITefrw+It9KXAkMVf2rPutkOY2DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708964093; c=relaxed/simple;
	bh=xh5KjY4jAKIj7qPdFFcg3B1Re6FuPuBpqaSd8z/9SJM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NcOut4Ff7AQ+NjrUv9rwvnlR5nPMNTXnSkk/j6hPuVEweSA0XblO7nwnCtWQGc11l/Cl8TdR0VI8xbeMfyhjC3tCkJehfarMCXI83ktTrC6GZAhLntEjUGsCRhoSgNkAWHXS3MIgUHEBnAyseCx2pAzSgFPL2FLIeNd4IUMU/Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MnMS42SB; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-565223fd7d9so16667a12.1
        for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 08:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708964090; x=1709568890; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UIA8O1Un68b1a2JQUZ8a1UzMBTFG1hv7u95Nr9d0sbU=;
        b=MnMS42SBfxh20xoL4wgvxw74iPDSA2DsjILxGj2H96lKZYvXmuelF2udHmi7gQnF2U
         wWURLbHT+i5dRidzy7zd6zXgba4bRLiZZek35jEMle3pp3I5PgqyFzK5w0F+JV4EcafY
         0aFJb4rJ0ee8NpLhRaETkrhchVZbIslTeBek6i1/Q4C1gvCzGDps37llWMaJ8JHXq/nb
         MMjKkxWfnBvJLCCR9TbzIsIVAhqgJXGoi+U5GhQB2u5JaUj4OdCGOjjXnOj3WzspZOki
         eUe36oPoeMbPIOSK+v+7/6+OlirttxOLJnicLgtpBMiRKo7iU9/LPGagzErNKnsHaZoj
         7v+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708964090; x=1709568890;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UIA8O1Un68b1a2JQUZ8a1UzMBTFG1hv7u95Nr9d0sbU=;
        b=n2RvpmlkUBRePvsZNQP3xH8j0bl/kaD+WesClZUF8hkrENKtmn6kDvtFdh29Dk5yyq
         wwlOJZPR8pPxdKCK3f16jajb67EGiBOeqb3bfKniXqd1u+rTcH/VcfDSxx7TrWBPQqfg
         jz4+47dCpjYY9CU0qgxR7Xrq8rI3jE2R59NGIDxAJB6VgmcUBlFXFGgwD2KLvCEXhZL4
         297z0ufmVLsvtP9Fcx00I3OKAM+V2Iak6Xp4QKMziKNjVVAjRWk3vFjY9aYAfkIe8qlD
         1IiZT1J8/OOF/qhpJVXhJ5hvMDbuYw3ACUxMHMK26/ai4Kc4heqlZnIcbj8df++qGGgM
         vE3g==
X-Forwarded-Encrypted: i=1; AJvYcCXViRRG6aRAdOp2PFZeSfq5knLT4pIXomurRG1HhQSPFcAkfGT0Fk9agNoHICT7TQvCNvC6RHBir8znh1o8GSV7mLf2iAzo
X-Gm-Message-State: AOJu0YxXSGMwWx0s5TKZduwkInMaKTH+dL4BE2NDFvGxDUrm0sR5Vgxm
	R9A7a4Kt5MOI6HNjZ5xNNSY6mxWv8MpHdZnWg4JPsBXEbEuFQ430bV0tUfuUB1njLXB5Qfkite3
	tECgzmnx9ueYhYXFOxs3BfDwA0nvAzbkJP1Tu
X-Google-Smtp-Source: AGHT+IEtLLSkiGKIce+VPbZU+ShLp2mLpqy3JEUnq75HG2XSp6qQQEd2E5GRLPqCLkPh44HDDjlPTCB8NSCpZEyl9/o=
X-Received: by 2002:a50:8a88:0:b0:566:2c0:a9d6 with SMTP id
 j8-20020a508a88000000b0056602c0a9d6mr148611edj.3.1708964089812; Mon, 26 Feb
 2024 08:14:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240226155055.1141336-1-edumazet@google.com> <20240226155055.1141336-3-edumazet@google.com>
 <Zdy3tnU-QZUda0HI@nanopsycho>
In-Reply-To: <Zdy3tnU-QZUda0HI@nanopsycho>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 26 Feb 2024 17:14:36 +0100
Message-ID: <CANn89iKM1yJ-uUtZ+uRkVdir8vbck8593RAxZt7fzNvFHU5W_Q@mail.gmail.com>
Subject: Re: [PATCH net-next 02/13] ipv6: annotate data-races around cnf.disable_ipv6
To: Jiri Pirko <jiri@resnulli.us>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 5:09=E2=80=AFPM Jiri Pirko <jiri@resnulli.us> wrote=
:
>
> Mon, Feb 26, 2024 at 04:50:44PM CET, edumazet@google.com wrote:
> >disable_ipv6 is read locklessly, add appropriate READ_ONCE()
> >and WRITE_ONCE() annotations.
> >
> >Signed-off-by: Eric Dumazet <edumazet@google.com>
> >---
> > net/ipv6/addrconf.c   | 12 ++++++------
> > net/ipv6/ip6_input.c  |  4 ++--
> > net/ipv6/ip6_output.c |  2 +-
> > 3 files changed, 9 insertions(+), 9 deletions(-)
> >
> >diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
> >index a280614b37652deee0d1f3c70ba1b41b01cc7d91..0d7746b113cc65303b5c2ec2=
23b3331c3598ded6 100644
> >--- a/net/ipv6/addrconf.c
> >+++ b/net/ipv6/addrconf.c
> >@@ -4214,7 +4214,7 @@ static void addrconf_dad_work(struct work_struct *=
w)
> >                       if (!ipv6_generate_eui64(addr.s6_addr + 8, idev->=
dev) &&
> >                           ipv6_addr_equal(&ifp->addr, &addr)) {
> >                               /* DAD failed for link-local based on MAC=
 */
> >-                              idev->cnf.disable_ipv6 =3D 1;
> >+                              WRITE_ONCE(idev->cnf.disable_ipv6, 1);
> >
> >                               pr_info("%s: IPv6 being disabled!\n",
> >                                       ifp->idev->dev->name);
> >@@ -6388,7 +6388,8 @@ static void addrconf_disable_change(struct net *ne=
t, __s32 newf)
> >               idev =3D __in6_dev_get(dev);
> >               if (idev) {
> >                       int changed =3D (!idev->cnf.disable_ipv6) ^ (!new=
f);
> >-                      idev->cnf.disable_ipv6 =3D newf;
> >+
> >+                      WRITE_ONCE(idev->cnf.disable_ipv6, newf);
> >                       if (changed)
> >                               dev_disable_change(idev);
> >               }
> >@@ -6397,15 +6398,14 @@ static void addrconf_disable_change(struct net *=
net, __s32 newf)
> >
> > static int addrconf_disable_ipv6(struct ctl_table *table, int *p, int n=
ewf)
> > {
> >-      struct net *net;
> >+      struct net *net =3D (struct net *)table->extra2;
>
> How is this related to the rest of the patch and why is it okay to
> access table->extra2 without holding rtnl mutex?

table->extra2 is immutable, it can be fetched before grabbing RTNL.
Everything that can be done before acquiring RTNL is a win under RTNL press=
ure.

I had a followup minor patch, but the patch series was already too big.

We do not need to grab rtnl when changing net->ipv6.devconf_dflt->disable_i=
pv6

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 08b4728733e3ed16d139d2bd4b50328552b3c27f..befe2709acdffdce8c6a3304df8=
dec598246a682
100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -6398,17 +6398,16 @@ static int addrconf_disable_ipv6(struct
ctl_table *table, int *p, int newf)
        struct net *net =3D (struct net *)table->extra2;
        int old;

+       if (p =3D=3D &net->ipv6.devconf_dflt->disable_ipv6) {
+               WRITE_ONCE(*p, newf);
+               return 0;
+       }
        if (!rtnl_trylock())
                return restart_syscall();

        old =3D *p;
        WRITE_ONCE(*p, newf);

-       if (p =3D=3D &net->ipv6.devconf_dflt->disable_ipv6) {
-               rtnl_unlock();
-               return 0;
-       }
-
        if (p =3D=3D &net->ipv6.devconf_all->disable_ipv6) {
                WRITE_ONCE(net->ipv6.devconf_dflt->disable_ipv6, newf);
                addrconf_disable_change(net, newf);

