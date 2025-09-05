Return-Path: <netdev+bounces-220479-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D67B46492
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 22:27:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A94547C1C97
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 20:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA94727E7FC;
	Fri,  5 Sep 2025 20:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qc0EqQe+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECB52798E3
	for <netdev@vger.kernel.org>; Fri,  5 Sep 2025 20:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757104062; cv=none; b=DEiQpD6eiYV7TYA5K5R5yjqGBiqb1iuSoLmGW7clA7K0cLZRTAVMoFILJvgucujFlosSzGozFw2HHMLIBcZs4T2F/WWrtMDLkoixNgh++Op8fGbwzdK6KNJycvxFIEl9zOqFjrmymFMo1nVOYoSUeNXgNMIEM3viRcYn8w5o1rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757104062; c=relaxed/simple;
	bh=HMuotU9oaqaKiX+Mfem+55B9TLwJEll44kc3+Qk8w4c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a7nI1+8hshcPqOLhEQcsKpsy30vJ6l99xGSlzyml7vMarQiZIVPrqcgwg/hH88+GgLP7zn/V/9M8bfRAJz3GAnje8hQcvCt9++ZlJXDHFjrM56rcPmL2YyliqQaiasPvhknhNsGHX41LE1HHQAaiyLA8xNoYQilN92yyShCL4iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qc0EqQe+; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4b350971a2eso10701cf.1
        for <netdev@vger.kernel.org>; Fri, 05 Sep 2025 13:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757104060; x=1757708860; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XnOSyH9gVwIP7L51PyZbW30kMGoAG/Gr8tTNYNRdOAg=;
        b=qc0EqQe+j8pPqszXzJfuTeZpu22juDkphJWP2rEEu4hKp2C+J+VPUfYqNG0J2sRMK1
         J9IbR2Ql2Y43RZ8uWp/tJ7B/iGn/xYe+o0Tnoyk59o1J/LXR0RpdtsNhj3wWCgjJYCNC
         LMzZHB0CnvnQD2ZcMeN0UiveOjsA8+0LlpD4PWsXu0ErBXdrYgtdyznLyJYzrvxw8hHu
         rI5Ba3xEOZxVS9KCIIK9kiRFCCJpWQ9zWCsmHwfn0SP0TGkkxQhbXRgts2QOLEEg0QTc
         FcRydOJ7oNsv/BkEdb8RJDmaK7GluSizKNrsHh3Az3dHgQ/0CH8i7yr77GgcKIujY/af
         K+7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757104060; x=1757708860;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XnOSyH9gVwIP7L51PyZbW30kMGoAG/Gr8tTNYNRdOAg=;
        b=lYvtNRCr3a/3R3wszgonNUjMZQjDr5+P8u0f0vpBWFRufQkhaMkWJTfeog4UyzgSGp
         ft4K00DQK+M0nWC5lqaNkXAj1jPeRUkbA/TvpESj9awCRlNUzF907RGyflLVK2P/0z8k
         0FHud/VnaQbzXfk3ZnBRAjpX5sJim3vibEB2c+HwNKRtFHy+muypW4jvxcvP/cOyZSUv
         fwAYEKjEIXF/8G7RbBB///sHjSr6rQmiRvut6mgVvm5eZFUqAFIrwm/C5QOyrsPk7dlh
         OyQI5bZzk39vqVL90n3ocYF3p3OeiQsc2qVjKyDu8TiT4Cf+l/f4dmwjWa0yJ39YByjI
         IRow==
X-Forwarded-Encrypted: i=1; AJvYcCVSCDnsPerk/ofg78nBJDHphKc7W7W9Dj2wmGuGwXAg8FlqYajoaYPMj9PZzu/SX0TXgz++m64=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJEHxWPCskB/yuuJID5IwAN5LygHykiToLjqSNwNc9AAos1Xs3
	O3jbVXfrNKMc27kYtZmUT2q8wqzCIGQfwopvpSYXyuLLDoqVyo2ZHc0ouUiqmXl7uctzYC/6gmY
	Q59nhGWIn4N2bxcuFQFZX8vxhocNsjxfnPF18jhzE4KF0W6XkYW1J4BOKvhM=
X-Gm-Gg: ASbGncuROlT/eI8DihRnYW+Vh+k4hZHlaGhnORVQVDZn1uUvnLbcP7L+r4JPouN9gXO
	RkBO0SLB2oZpkqYka63w1UFbhcr6NjrMQKLlNc2td1yc01mrZ2rLHxdGXeRazNlt36BV7DRBzQ1
	H5vvUjxPO6YoYQbX7o36PlJLB4u4DpPWpWCm2YaQYu8bAdv4NhW7fKitDbC6odmAOuQY9EBb6Mc
	iVh8ARFZD2wHnQ=
X-Google-Smtp-Source: AGHT+IGb0MXJP0PPpNgaFvJB25jLD6SvEl/0d/GriZPhi0Fy43Tde7ezxgHRokpkLdf68vDraY1xpX2xAzWehJRs/dU=
X-Received: by 2002:ac8:7c53:0:b0:4b0:f1f3:db94 with SMTP id
 d75a77b69052e-4b5f71c0111mr741891cf.5.1757104059628; Fri, 05 Sep 2025
 13:27:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250904182710.1586473-1-sdf@fomichev.me> <CAHS8izOSq+mYmP58eNqC5WFTvXxh+s8gRSrTv6YQdq6jn41pMw@mail.gmail.com>
 <aLsAP-UgtINNwIMJ@mini-arch>
In-Reply-To: <aLsAP-UgtINNwIMJ@mini-arch>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 5 Sep 2025 13:27:24 -0700
X-Gm-Features: Ac12FXxNO4qBPz9G8i4siY2NgdPBP8JaFKGrZdh40tif6ilU7toruzJdzZ84m08
Message-ID: <CAHS8izNR8OSZA-F8d9s4GeRSJsnJKwW1nVc+wv01h8yo=V=6fQ@mail.gmail.com>
Subject: Re: [PATCH net-next] selftests: ncdevmem: don't retry EFAULT
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	andrew+netdev@lunn.ch, shuah@kernel.org, joe@dama.to, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 5, 2025 at 8:22=E2=80=AFAM Stanislav Fomichev <stfomichev@gmail=
.com> wrote:
>
> On 09/04, Mina Almasry wrote:
> > On Thu, Sep 4, 2025 at 11:27=E2=80=AFAM Stanislav Fomichev <sdf@fomiche=
v.me> wrote:
> > >
> > > devmem test fails on NIPA. Most likely we get skb(s) with readable
> > > frags (why?)
> >
> > I would expect if we get readable frags that the frags land in the
> > host buffer we provide ncdevmem and we actually hit this error:
> >
> > ```
> >   1                 if (!is_devmem) {
> >   0                         pr_err("flow steering error");
> >   1                         goto err_close_client;
> >   2                 }
> > ```
> >
> > which as it says, should be root caused in a flow steering error. I
> > don't know what would cause an EFAULT off the top of my head.
>
> Yea, I don't understand what happens :-( I'm thinking of doing the
> following as well:
>
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 40b774b4f587..0c18a8c7965f 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -2820,7 +2820,7 @@ static int tcp_recvmsg_locked(struct sock *sk, stru=
ct msghdr *msg, size_t len,
>                                                          used);
>                                 if (err <=3D 0) {
>                                         if (!copied)
> -                                               copied =3D -EFAULT;
> +                                               copied =3D err;
>
>                                         break;
>                                 }
>
> Should give us more info for the devmem case... LMK if you don't like
> it. If I don't hear from you in a couple of days, I'll send it out..

Hmm, the other code paths overwrite the error to EFAULT; I don't know
if that's significant in some way. But seems fine to me, I don't see
why not do this, other than maybe potentional confusion with recvmsg
returning an error not documented here:

https://linux.die.net/man/2/recvmsg

But that seems a minor point.


--=20
Thanks,
Mina

