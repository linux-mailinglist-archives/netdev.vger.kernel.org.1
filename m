Return-Path: <netdev+bounces-76467-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 245B686DD44
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 09:41:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0B9CB27988
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 08:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4288869E10;
	Fri,  1 Mar 2024 08:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LqU91kwL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8196A032
	for <netdev@vger.kernel.org>; Fri,  1 Mar 2024 08:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709282432; cv=none; b=e9AHyl8rnt/OEgv5kOIlxf+4087hPLSTIrocvbXr6tiABLe4x2WMePxeS7Qmw9mzXP+thqoGHyNk8tOqOiH5/q5TE4TZL7sMioYHuOdJgvkR4CQ8HYSy6mIoVC2iKubOXJ6e0+U1quz+yB+XciJSbtTYp9FrVg1Yk3unZQiyFg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709282432; c=relaxed/simple;
	bh=YmjqDEuE+ucTlyOEn97WNwABeDm1S8XqUBSA6j/6BxY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ONDuqwqUbGT0OnsFtwKx4wyBx0L4nRjauKxjnRMY3T4cIaRB3BSaNnB3Xr9x1LaVqvnjxKcylFLzrC6eUN18xwArXhjBCGIvgOAIAONQfti0vpytufOTbLXsSqsFUwMXnGoEFCYajIHoweexjKT9vbg3/aaxontCo0hHMJ6ndlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LqU91kwL; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5654ef0c61fso8776a12.0
        for <netdev@vger.kernel.org>; Fri, 01 Mar 2024 00:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709282429; x=1709887229; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=925OyXWRRaptp93EX6m+BBrH1KaXjkusqTB+FdiRcXo=;
        b=LqU91kwLoLzQ7eS3o+di4e1fyzvbV9hVouViLMW6YXq0NXDJUqzhxTmvcKf2QqMY0N
         /lUWgrzUsOrx6CLknKotOi/P/AVNA+9xqpRASzdC5rjjOqhEYbxsz6IfcHdnxNZdtXaz
         /zn73BvJBiTKmjmm0/dNclk5JSdLZG/3Xa2cob3UQqesETgJItVQrXWpFF5Mnwitnk8a
         ngpBeB7IlgjYsxhxJGkoJ4Q9u0hnFc40ovVE69irfwi2MrKLC7iIhfv0aU3M05Pe7dgj
         +uhxuDH6Q6B/KT+dDYKqdsgO3Z5al+PPcpg4OBsM1AiK9ZR5BTYjGkEdkrVOA9O1rNsl
         gcHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709282429; x=1709887229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=925OyXWRRaptp93EX6m+BBrH1KaXjkusqTB+FdiRcXo=;
        b=B4Q6Jw3tGG1hFL1/x22E24BJv1tBDrTRWsl9RV2C1HFa4bMWHal4njLdGaUCcZB6tY
         9RCvHehuV+FSbtN09FbUoI7TF9O2ZE4zejimbbCy8ni4SOxCKgs+oQ9BspJDfpc4sfPF
         G24NApzg2Y6+lEbVkkT6TI/L6/B3mk+nSuEzLmkPtE0zWOKVmJ9qEmoSEgV+khzkIkll
         kJk7CRglbKxYuPpGlLo3URt+1w4EK30TwKyngJdW46WMqTLv1AEEmVjtwMkKNuu8AKIj
         m77bULyaqqs99m5lOYmxZoOFhyVnWsK40yrZMnF1SqsUqUtEgQEqc54Z5rnthJJK+Ml8
         r2ug==
X-Forwarded-Encrypted: i=1; AJvYcCWn3PO1pz+S0GKxo+cfDHMmIhrPQGSYQong5PUgb2cQTHUH3kjgmxy4glxvmMi1tmLhxqvjjqhk5WxzeiHGA+700ab+RoqT
X-Gm-Message-State: AOJu0Yy7Tb5CE+p5lBmeNf0IU2p2YMUDZbQCiC0MOXJUJXF+wMDw/qmO
	8rRA2BUbxkozMpm0pHRGfTJfnpgQnrqolRxyZOpoKUqZz8Hl/0EEOHrqZgBxICIDi7w0HQjyWiX
	Bf6DPrLt8jrdAyY+qLlshqk6IszV8KNPdE0jW
X-Google-Smtp-Source: AGHT+IF6Tjghz+QnVNiYeTrgy2b7s4s+pk45BEZxvsMgizkO/JcCOYuG6JVTTlhvEplRcYw5jpURH9Z6znNp58UWIRM=
X-Received: by 2002:a05:6402:350e:b0:563:f48a:aa03 with SMTP id
 b14-20020a056402350e00b00563f48aaa03mr117474edd.2.1709282428426; Fri, 01 Mar
 2024 00:40:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301012845.2951053-1-kuba@kernel.org> <20240301012845.2951053-4-kuba@kernel.org>
In-Reply-To: <20240301012845.2951053-4-kuba@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 1 Mar 2024 09:40:17 +0100
Message-ID: <CANn89iLD0C3An_RUMt8W0d2PiJhXaSGAUsUhyhTg1Qa+50HC+g@mail.gmail.com>
Subject: Re: [PATCH net-next 3/3] genetlink: fit NLMSG_DONE into same read()
 as families
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, pabeni@redhat.com, 
	johannes@sipsolutions.net, fw@strlen.de, pablo@netfilter.org, 
	idosch@nvidia.com, jiri@resnulli.us
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 1, 2024 at 2:31=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> Make sure ctrl_fill_info() returns sensible error codes and
> propagate them out to netlink core. Let netlink core decide
> when to return skb->len and when to treat the exit as an
> error. Netlink core does better job at it, if we always
> return skb->len the core doesn't know when we're done
> dumping and NLMSG_DONE ends up in a separate read().
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: jiri@resnulli.us
> ---
>  net/netlink/genetlink.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/net/netlink/genetlink.c b/net/netlink/genetlink.c
> index 50ec599a5cff..70379ecfb6ed 100644
> --- a/net/netlink/genetlink.c
> +++ b/net/netlink/genetlink.c
> @@ -1232,7 +1232,7 @@ static int ctrl_fill_info(const struct genl_family =
*family, u32 portid, u32 seq,
>
>         hdr =3D genlmsg_put(skb, portid, seq, &genl_ctrl, flags, cmd);
>         if (hdr =3D=3D NULL)
> -               return -1;
> +               return -EMSGSIZE;
>
>         if (nla_put_string(skb, CTRL_ATTR_FAMILY_NAME, family->name) ||
>             nla_put_u16(skb, CTRL_ATTR_FAMILY_ID, family->id) ||
> @@ -1355,6 +1355,7 @@ static int ctrl_dumpfamily(struct sk_buff *skb, str=
uct netlink_callback *cb)
>         struct net *net =3D sock_net(skb->sk);
>         int fams_to_skip =3D cb->args[0];
>         unsigned int id;
> +       int err;

Don't we have to initialize err to 0 ?

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks !

>
>         idr_for_each_entry(&genl_fam_idr, rt, id) {
>                 if (!rt->netnsok && !net_eq(net, &init_net))
> @@ -1363,16 +1364,17 @@ static int ctrl_dumpfamily(struct sk_buff *skb, s=
truct netlink_callback *cb)
>                 if (n++ < fams_to_skip)
>                         continue;
>
> -               if (ctrl_fill_info(rt, NETLINK_CB(cb->skb).portid,
> -                                  cb->nlh->nlmsg_seq, NLM_F_MULTI,
> -                                  skb, CTRL_CMD_NEWFAMILY) < 0) {
> +               err =3D ctrl_fill_info(rt, NETLINK_CB(cb->skb).portid,
> +                                    cb->nlh->nlmsg_seq, NLM_F_MULTI,
> +                                    skb, CTRL_CMD_NEWFAMILY);
> +               if (err) {
>                         n--;
>                         break;
>                 }
>         }
>
>         cb->args[0] =3D n;
> -       return skb->len;
> +       return err;
>  }
>
>  static struct sk_buff *ctrl_build_family_msg(const struct genl_family *f=
amily,
> --
> 2.43.2
>

