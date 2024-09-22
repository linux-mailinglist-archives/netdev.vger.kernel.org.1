Return-Path: <netdev+bounces-129184-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9CA297E264
	for <lists+netdev@lfdr.de>; Sun, 22 Sep 2024 18:12:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AE2C2811AA
	for <lists+netdev@lfdr.de>; Sun, 22 Sep 2024 16:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D371426C;
	Sun, 22 Sep 2024 16:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TTi9smHS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC0DEEDB
	for <netdev@vger.kernel.org>; Sun, 22 Sep 2024 16:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727021526; cv=none; b=Hi5Npb2ccWLEa/izm8pe2qjBl6/RFmXG2vX1L0s/UgOMCPW4BYtT2jscOH2nLPw+FUt2RcwL8+1f7zFQy2TQjY1htHa+70rsFR+61Ua4D6Dx1Ngs45PwFFzsU4MsL5ZGq6wq59TMj3imxF6MVYhIgZLtO/eA7eQh5xUjIQkDuDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727021526; c=relaxed/simple;
	bh=51l6XNUexh8/qlbrJv3BrjdxPtewTYNWQkCT5YXc6iM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LB1ptQ7h0IRJfdYoo5Ucuv4hLokPZiYHZLPh3H8wAbA7sSueMnKvf9Azdlbo0W15B98SINTCr8dBgbCP/4dGBJ7BVFWUD4FrI/R0bk9FoqRPt1jVL8v/arrCsP49u6LEg4PcS92XQRF8L8n5D1K/7BkKbuTx2A+iU41WfJJwcpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TTi9smHS; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5c26a52cf82so2284242a12.2
        for <netdev@vger.kernel.org>; Sun, 22 Sep 2024 09:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727021522; x=1727626322; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZScRIIj0rv/9Bd3qE2ut3bquV/pUYAID0m18B2cH0Hg=;
        b=TTi9smHSOI3d0KgHXQw24VWzFEjgnJ4iC8rFmYn+wCChH1PG5ZEOCo0lH/IGa53o/H
         6GhEF+4MFnCixcgYj8juZGMTSJeI0nIMfbzr/pSKBRRyoHPySE3B0P/9g4bEIcamKIpB
         TV1TpawWCjz1SG4Uqh/fsrODQ8nZn2fdUuSWZpE1FvZ91yHEplLIkHof4UTvwAhBvxZG
         TPMWCqbl2IlMiUr7c39//PrPjvNOQzhKCJf5mnT7EWPe9biEgNJG2qJU6j4mwn86ed1v
         Y0rc76N/diPFYUyvXM/Bf0ttF/wBK5QmG7+eWclTRnz+1STv8oPFoaT2n3Fx8CpCWfRo
         3iyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727021522; x=1727626322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZScRIIj0rv/9Bd3qE2ut3bquV/pUYAID0m18B2cH0Hg=;
        b=BasHhRXp0mWiskkFRe2lNsthEswnir6WRAZoj07qrTcNAUJlYp9OyM7eYOMD/mEToB
         Vp6zaMtFUK9sEIT9o5QSlYNbu+oWKgMXpPAMwADehy2BsXh8hyBeO+JZJj39o6Ir8DMj
         c5WRBkTPNCwHlqTyXrY/usFY4KZZHcxSgXFxG+0DzNogTcWyGJKX1tdAiLi73De5Gpp+
         INrtBejoU8yH8+il1EFTwhfmvN3dZ+UOvmAb3rV+g5WS5piqbSDRIl8RYwAylzAGgS7S
         F1z0XbZHKYGXEsMY/nvuhDa90j7dmxRDRVLFtCdevhkOEstomUYe+pVbDLFNiLReURoe
         ccng==
X-Forwarded-Encrypted: i=1; AJvYcCVbWUgDhSIVeIK+3Is5SsHezHd+qVaLZW2ZPPKDLPfB1wr385gzlLhObUIlJZOmhDmX9+6diKc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxzuz9k69PUmdC0mnEQULH/MBnp2gXl8R4kKjO1nCJc0rpLb0iw
	bDHk8fCDR5CUmtz6j0hklIz0+7GBoPbIKEqdUAkNTUpB9NNy2Sd57nVoL2Lx1Kn74wpPX06G7zJ
	kthFPRUm05OzIUf1bdoaQs27Rbrdq1rqYh/Y3
X-Google-Smtp-Source: AGHT+IEBBDd+e0s02cZWTCvVhg7H+5VDYTZaKO61q87uG4FaCjGDfAIb7LhgHE9AxU07Dhj1hFuBN+HkH88jWhjYRK0=
X-Received: by 2002:a05:6402:348c:b0:5c4:14ff:8a7 with SMTP id
 4fb4d7f45d1cf-5c464a3d154mr11335828a12.14.1727021522189; Sun, 22 Sep 2024
 09:12:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <00000000000055b6570622575dba@google.com> <20240917235027.218692-2-srikarananta01@gmail.com>
In-Reply-To: <20240917235027.218692-2-srikarananta01@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sun, 22 Sep 2024 18:11:48 +0200
Message-ID: <CANn89iLxa6V7BZSzmj5A979M2ZObj-CcDD_izeKqtRCZj-+pmQ@mail.gmail.com>
Subject: Re: [PATCH] net/ipv4: Fix circular deadlock in do_ip_setsockop
To: AnantaSrikar <srikarananta01@gmail.com>
Cc: syzbot+e4c27043b9315839452d@syzkaller.appspotmail.com, 
	alibuda@linux.alibaba.com, davem@davemloft.net, dsahern@kernel.org, 
	dust.li@linux.alibaba.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, schnelle@linux.ibm.com, 
	syzkaller-bugs@googlegroups.com, wenjia@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 18, 2024 at 1:51=E2=80=AFAM AnantaSrikar <srikarananta01@gmail.=
com> wrote:
>
> Fixed the circular lock dependency reported by syzkaller.
>
> Signed-off-by: AnantaSrikar <srikarananta01@gmail.com>
> Reported-by: syzbot+e4c27043b9315839452d@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3De4c27043b9315839452d
> Fixes: d2bafcf224f3 ("Merge tag 'cgroup-for-6.11-rc4-fixes' of git://git.=
kernel.org/pub/scm/linux/kernel/git/tj/cgroup")
> ---
>  net/ipv4/ip_sockglue.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
> index cf377377b52d..a8f46d1ba62b 100644
> --- a/net/ipv4/ip_sockglue.c
> +++ b/net/ipv4/ip_sockglue.c
> @@ -1073,9 +1073,11 @@ int do_ip_setsockopt(struct sock *sk, int level, i=
nt optname,
>         }
>
>         err =3D 0;
> +
> +       sockopt_lock_sock(sk);
> +
>         if (needs_rtnl)
>                 rtnl_lock();
> -       sockopt_lock_sock(sk);
>
>         switch (optname) {
>         case IP_OPTIONS:

I think you missed an earlier conversation about SMC being at fault here.

https://lore.kernel.org/netdev/CANn89iKcWmufo83xy-SwSrXYt6UpL2Pb+5pWuzyYjMv=
a5F8bBQ@mail.gmail.com/

