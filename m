Return-Path: <netdev+bounces-54810-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4697C80854B
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 11:16:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01DB3283FD5
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 10:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 836BD3528E;
	Thu,  7 Dec 2023 10:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="DdhJ5TaD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D786A121
	for <netdev@vger.kernel.org>; Thu,  7 Dec 2023 02:16:42 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-db539ab8e02so893000276.0
        for <netdev@vger.kernel.org>; Thu, 07 Dec 2023 02:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1701944202; x=1702549002; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wl3vsdTMIewUjqb5GYkMtfnxr3WN+EeBQt8gPRPpdY8=;
        b=DdhJ5TaDmj107XOmjYFlc+4qPDD22GvR++dUhrVkD/qUqSJ76fKL1pG+5FiE2b7wdF
         x6LI39sdvu7/kfdxz9w7wkJ2wMZDvu6u6CEL3G5Vgs0OSa4oK8mEsYPs3TUZLym7IfmV
         bBKOMxWoJU0xiVzg0YoncWFPj5G5JFDzhNIgoGIrNyMmoeySgtWABpxyhPo354WF+zIC
         OiVJwmu+MHVpr5sShXMLzBf6rbqgDA1+uQ/Ddf4spfYx9Ajz3+TZJ4V9VDNG0AxytRtd
         XAXyfTAshaJCnbX5yGjNfvXw8kkSgktl5FwzHghH4iSZNjA/UJhnHh7HCTKPytX4y1lr
         keKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701944202; x=1702549002;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wl3vsdTMIewUjqb5GYkMtfnxr3WN+EeBQt8gPRPpdY8=;
        b=mPeaHSj5V7cbze7UEprkUuPZid3acBxU6SxP2YZTYRXufozqNfl1mr+iMBXzilRLh1
         GBgBbV2NOdQWWHJUYMUC4WhjZ/4QnMZjkoy/WFrpY6iDvKil4lFUb0dpCwo5DFN7LS2g
         pMWUmTZM64lmasECuVa+bf1Zc7Dg+s6FYytTjHnitrD6FFt+ePm4dZW/fVcQhoE7+wBp
         9mPTly4JPxU/thmuL0gEVNfwQYEKfiy3PmsKq3pPZ/kJY/dTCTJ9EpFWOuKod+ILhcKL
         yzFacGzEVngawe6oMuxSGUft9qbOJxvd1iOimAftzWSgKO1wHG1rdSvEC7IxFffG6fBf
         YzeQ==
X-Gm-Message-State: AOJu0YzGLRtJ+UfO9dFAZTzAofHu8z9yohbcauQFqOPh26LGGUZP0ztU
	+xUPkB4VxdI2OI0AvWLleRfuVLBQrp/cf6Vm+uDjyg==
X-Google-Smtp-Source: AGHT+IHdD4xjsAyFxaDDEnawZw4tiACBr2JO4mMzsaPx97ALv7jqwWSlJP5+2wriKFC3wYgPQrlkpdAmHtScaMVaguM=
X-Received: by 2002:a25:c0cf:0:b0:db5:4dc8:60e9 with SMTP id
 c198-20020a25c0cf000000b00db54dc860e9mr1912023ybf.0.1701944202071; Thu, 07
 Dec 2023 02:16:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231206213102.1824398-1-idosch@nvidia.com> <20231206213102.1824398-2-idosch@nvidia.com>
In-Reply-To: <20231206213102.1824398-2-idosch@nvidia.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 7 Dec 2023 05:16:30 -0500
Message-ID: <CAM0EoMmPEQ5nETLt8OkADQR+ACgHCOShp6gEA1DK+jR7mK-gNA@mail.gmail.com>
Subject: Re: [PATCH net 1/2] psample: Require 'CAP_NET_ADMIN' when joining
 "packets" group
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, edumazet@google.com, nhorman@tuxdriver.com, 
	yotam.gi@gmail.com, jiri@resnulli.us, johannes@sipsolutions.net, 
	jacob.e.keller@intel.com, horms@kernel.org, andriy.shevchenko@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 6, 2023 at 4:33=E2=80=AFPM Ido Schimmel <idosch@nvidia.com> wro=
te:
>
> The "psample" generic netlink family notifies sampled packets over the
> "packets" multicast group. This is problematic since by default generic
> netlink allows non-root users to listen to these notifications.
>
> Fix by marking the group with the 'GENL_UNS_ADMIN_PERM' flag. This will
> prevent non-root users or root without the 'CAP_NET_ADMIN' capability
> (in the user namespace owning the network namespace) from joining the
> group.
>

Out of curiosity, shouldnt reading/getting also be disallowed then?
Traditionally both listening and reading has been allowed without root
for most netlink endpoints...
IOW, if i cant listen but am able to dump, isnt whatever "security
hole" still in play even after this change?

cheers,
jamal



> Tested using [1].
>
> Before:
>
>  # capsh -- -c ./psample_repo
>  # capsh --drop=3Dcap_net_admin -- -c ./psample_repo
>
> After:
>
>  # capsh -- -c ./psample_repo
>  # capsh --drop=3Dcap_net_admin -- -c ./psample_repo
>  Failed to join "packets" multicast group
>
> [1]
>  $ cat psample.c
>  #include <stdio.h>
>  #include <netlink/genl/ctrl.h>
>  #include <netlink/genl/genl.h>
>  #include <netlink/socket.h>
>
>  int join_grp(struct nl_sock *sk, const char *grp_name)
>  {
>         int grp, err;
>
>         grp =3D genl_ctrl_resolve_grp(sk, "psample", grp_name);
>         if (grp < 0) {
>                 fprintf(stderr, "Failed to resolve \"%s\" multicast group=
\n",
>                         grp_name);
>                 return grp;
>         }
>
>         err =3D nl_socket_add_memberships(sk, grp, NFNLGRP_NONE);
>         if (err) {
>                 fprintf(stderr, "Failed to join \"%s\" multicast group\n"=
,
>                         grp_name);
>                 return err;
>         }
>
>         return 0;
>  }
>
>  int main(int argc, char **argv)
>  {
>         struct nl_sock *sk;
>         int err;
>
>         sk =3D nl_socket_alloc();
>         if (!sk) {
>                 fprintf(stderr, "Failed to allocate socket\n");
>                 return -1;
>         }
>
>         err =3D genl_connect(sk);
>         if (err) {
>                 fprintf(stderr, "Failed to connect socket\n");
>                 return err;
>         }
>
>         err =3D join_grp(sk, "config");
>         if (err)
>                 return err;
>
>         err =3D join_grp(sk, "packets");
>         if (err)
>                 return err;
>
>         return 0;
>  }
>  $ gcc -I/usr/include/libnl3 -lnl-3 -lnl-genl-3 -o psample_repo psample.c
>
> Fixes: 6ae0a6286171 ("net: Introduce psample, a new genetlink channel for=
 packet sampling")
> Reported-by: "The UK's National Cyber Security Centre (NCSC)" <security@n=
csc.gov.uk>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  net/psample/psample.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/net/psample/psample.c b/net/psample/psample.c
> index 81a794e36f53..c34e902855db 100644
> --- a/net/psample/psample.c
> +++ b/net/psample/psample.c
> @@ -31,7 +31,8 @@ enum psample_nl_multicast_groups {
>
>  static const struct genl_multicast_group psample_nl_mcgrps[] =3D {
>         [PSAMPLE_NL_MCGRP_CONFIG] =3D { .name =3D PSAMPLE_NL_MCGRP_CONFIG=
_NAME },
> -       [PSAMPLE_NL_MCGRP_SAMPLE] =3D { .name =3D PSAMPLE_NL_MCGRP_SAMPLE=
_NAME },
> +       [PSAMPLE_NL_MCGRP_SAMPLE] =3D { .name =3D PSAMPLE_NL_MCGRP_SAMPLE=
_NAME,
> +                                     .flags =3D GENL_UNS_ADMIN_PERM },
>  };
>
>  static struct genl_family psample_nl_family __ro_after_init;
> --
> 2.40.1
>

