Return-Path: <netdev+bounces-179919-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4A6EA7EE6F
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 22:06:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F54516B516
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 20:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 999F721B1AA;
	Mon,  7 Apr 2025 19:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="0RDm7DR7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB9621B9F7
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 19:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744055789; cv=none; b=An9eE0Nsqwpl6bCFJ6lAIScoSx2RHfxzzOHbw023R2Hm4qoTsNLhwqTcQ7yvkISgJ09QlVSH8dtEhCuFCrt8rFCIvvTQIUg/NdACr/S76jAjC3TjZ3gAUa2LFmiaJrhTBdu6iAws8V2oILRzQzi7jXf3zbBlRiJSl3r2T3Kd+ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744055789; c=relaxed/simple;
	bh=vZczen8sZQ58OTS/uXGCR9+q3QFexyMu8q1ko9rFzMg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YY1m5wSU4es1IoAsvvwy2KZL+DlFpop0BQe06Xn+/NEpBwgISKUOg4vdR6I85JtF33Ezy42ghIrvPLJOTmUg3iAwR7/qlUgmyoH/W9EMTtZipV2z4TPO9s3eCG9vjEwlfQFImmeR/flTlwEEspYhR77zzZt9g0QJ09ZJO2VYCYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=0RDm7DR7; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-22548a28d0cso65924835ad.3
        for <netdev@vger.kernel.org>; Mon, 07 Apr 2025 12:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1744055787; x=1744660587; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Op29psY/9lPB9GJwxpOGVvo3J4ePmM6GB/+Rn+OKR38=;
        b=0RDm7DR7xQ9AVpCfHjEuwE+k131dfJFYqXDwnJ3yUKpd+9Qn+DUxlF3l17ouUwUZ7a
         1cl+0LQtdZQEdqzdnVtGjkd+Tsq1VoWM5vNhtJhag+bBOhIgJUNmmKeFMiiPvpWWoW/9
         /mG+MdRTxHwwA+s2XG5nTBYssSqMXcdPS/qoFI8DtDBvtH6TbW6ao5tLYxeMqcASLo3R
         +RaHR0OipG+/dvElevSCEqqWT7yB4zYBQst4YJQlKc2EEX/UtVLmJw1VUemT/573Mr9K
         Y9rV43rrcECeLDkuPLBeRw8vI+zIPfwzv3P7YChAvX/z6v1LomVeKQJo4REsWVQFHEz7
         e3cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744055787; x=1744660587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Op29psY/9lPB9GJwxpOGVvo3J4ePmM6GB/+Rn+OKR38=;
        b=h/b/+s7kCHT0IxzN2AVU16v0MhR6ZaGn0nKU4AOW5xps26qqDLZCvpEz3e24nSXzK6
         jchlq/EaUYHu5iZlEm9n4x5VpQp3jIjn05nA0m55dHUaxJSQf6LAFgY1gl4a5wSjs6B6
         x0AfnL6pmXO/G7CeVdoXg9+jKTLg3EoS7e/xPmlxbvqGOAB7Rkq5EntOeyaEhOrUgQIX
         HXODpROeUiekGoEPkhYZfGKE9kNg9vTsA82PozSGl2SLby5PK7rtCL6NE7dJBQJwvlOB
         ZRJEb/FOGH55H7gIHrfm5ihcIoggAsj49nvOVv9hvXD+BGHYXJ+0o7Lvvw8q+P+WbVp3
         3c0g==
X-Forwarded-Encrypted: i=1; AJvYcCWwZgH9g9HbJAI6KjXtRmR3YZu4NJt2iMka9pM5U5aSgl+S40d9EZaBQMuCa3riH+W4Dn7rPG4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzU+S7ObxmD7Li2BcsoQ5m2MHxawR9XtvXSJHsBNbguenpTQWtS
	9iqRwBBYg+IHI9E4+xZrSdCb3rxZbPlu+7XtJHTljfEKItWBJ2ojhp9QvAZQ1X4iWPtl97+UtCE
	+EAJx3KdI08tkcx6De25JZCUsRhJaMkKabKe3
X-Gm-Gg: ASbGnctjeby0b4Lus7iz01KFbtIKbeUlrl+di1Nf6wNE+CbafgNrx+zUeNTTJIcn95i
	3m1AS8rFTSf7xXCYMsjahCAWcV1Glj98WuuMWkfTNgNXfrqeUdDxjrgsxz9XoFGWHA+ua86dq8L
	CvrZbWhGDM/SE262BiSBHTWzRUnQ==
X-Google-Smtp-Source: AGHT+IEVO08Lp71/L7iX2yXym2sEoAP+4Fjnmdjk+WLFRrxvyL/28SeF0PBuXPyupIUprg9zpRz6MtludW+cYHVgbx0=
X-Received: by 2002:a17:903:2301:b0:229:1cef:4c83 with SMTP id
 d9443c01a7336-22a8a84b3cemr197110675ad.4.1744055787096; Mon, 07 Apr 2025
 12:56:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250407112923.20029-1-toke@redhat.com>
In-Reply-To: <20250407112923.20029-1-toke@redhat.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 7 Apr 2025 15:56:15 -0400
X-Gm-Features: ATxdqUGv_znJGwYNWvSEG1MgpSSeYBPNQYwYsJABC6rxy6YQzJwAr7h91C2kBLM
Message-ID: <CAM0EoM=oC0kPOEcNdng8cmHHGA_kTL+y0mAcwTDXuLfiJhsjyg@mail.gmail.com>
Subject: Re: [RFC PATCH net] tc: Return an error if filters try to attach too
 many actions
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	Ilya Maximets <i.maximets@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 7, 2025 at 7:29=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen <to=
ke@redhat.com> wrote:
>
> While developing the fix for the buffer sizing issue in [0], I noticed
> that the kernel will happily accept a long list of actions for a filter,
> and then just silently truncate that list down to a maximum of 32
> actions.
>
> That seems less than ideal, so this patch changes the action parsing to
> return an error message and refuse to create the filter in this case.
> This results in an error like:
>
>  # ip link add type veth
>  # tc qdisc replace dev veth0 root handle 1: fq_codel
>  # tc -echo filter add dev veth0 parent 1: u32 match u32 0 0 $(for i in $=
(seq 33); do echo action pedit munge ip dport set 22; done)
> Error: Only 32 actions supported per filter.
> We have an error talking to the kernel
>
> Instead of just creating a filter with 32 actions and dropping the last
> one.
>
> Sending as an RFC as this is obviously a change in UAPI. But seeing as
> creating more than 32 filters has never actually *worked*, it could be
> argued that the change is not likely to break any existing workflows.
> But, well, OTOH: https://xkcd.com/1172/
>
> So what do people think? Worth the risk for saner behaviour?
>

I dont know anyone using that many actions per filter, but given it's
a uapi i am more inclined to keep it.
How about just removing the "return -EINVAL" then it becomes a
warning? It would need a 2-3 line change to iproute2 to recognize the
extack with positive ACK from the kernel.

cheers,
jamal


> [0] https://lore.kernel.org/r/20250407105542.16601-1-toke@redhat.com
>
> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> ---
>  net/sched/act_api.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/net/sched/act_api.c b/net/sched/act_api.c
> index 839790043256..057e20cef375 100644
> --- a/net/sched/act_api.c
> +++ b/net/sched/act_api.c
> @@ -1461,17 +1461,29 @@ int tcf_action_init(struct net *net, struct tcf_p=
roto *tp, struct nlattr *nla,
>                     struct netlink_ext_ack *extack)
>  {
>         struct tc_action_ops *ops[TCA_ACT_MAX_PRIO] =3D {};
> -       struct nlattr *tb[TCA_ACT_MAX_PRIO + 1];
> +       struct nlattr *tb[TCA_ACT_MAX_PRIO + 2];
>         struct tc_action *act;
>         size_t sz =3D 0;
>         int err;
>         int i;
>
> -       err =3D nla_parse_nested_deprecated(tb, TCA_ACT_MAX_PRIO, nla, NU=
LL,
> +       err =3D nla_parse_nested_deprecated(tb, TCA_ACT_MAX_PRIO + 1, nla=
, NULL,
>                                           extack);
>         if (err < 0)
>                 return err;
>
> +       /* The nested attributes are parsed as types, but they are really=
 an
> +        * array of actions. So we parse one more than we can handle, and=
 return
> +        * an error if the last one is set (as that indicates that the re=
quest
> +        * contained more than the maximum number of actions).
> +        */
> +       if (tb[TCA_ACT_MAX_PRIO + 1]) {
> +               NL_SET_ERR_MSG_FMT(extack,
> +                                  "Only %d actions supported per filter"=
,
> +                                  TCA_ACT_MAX_PRIO);
> +               return -EINVAL;
> +       }
> +
>         for (i =3D 1; i <=3D TCA_ACT_MAX_PRIO && tb[i]; i++) {
>                 struct tc_action_ops *a_o;
>
> --
> 2.49.0
>

