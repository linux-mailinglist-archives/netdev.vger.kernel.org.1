Return-Path: <netdev+bounces-80479-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 727E187F089
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 20:47:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28FA21F225A4
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 19:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE7556B7F;
	Mon, 18 Mar 2024 19:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W4U760Vc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84CE56B77
	for <netdev@vger.kernel.org>; Mon, 18 Mar 2024 19:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710791219; cv=none; b=jEMcUlytN1KhR2OD3GkeWydhA9fSQ/fw0tiEpGhMbiedmt/c4Mz32QTL8Yap0Nv+HhYZkhs7wzz6n/HYg3a4HlbBJT5z2zzCROJS6FySp4LW5ePRRVbXe7bQsvfnqln/n26korXi2DL+BMRQYklbHmw4OrXrAHWSflcUSjqlhTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710791219; c=relaxed/simple;
	bh=Hr6cQ/wbflmJjOX76ou5m4nWii96H+JyPqWxiLKG/VY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I0dYzrVToOArdwsUQ6fM01Rb6C/fQ14bIU6CS7nZNbBsaqvHJ9/hLtcMZZvhv9FQ4/jGkCJ2u5S9hLxDMLYatCUW+w1ZnOUBSllhEpZkeSBsYBVv/J67eriaTSZSsEDoMmooh8fNF27t/DivpVTid1a9i1BcpC0fqq6nuQghtJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W4U760Vc; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-568d160155aso2470a12.1
        for <netdev@vger.kernel.org>; Mon, 18 Mar 2024 12:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710791216; x=1711396016; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ma3C4PV+wA5L6sBZD8pU388eAyrZYQpBA1CelpJ7Ffc=;
        b=W4U760VchDuH+ljdIUblWDKqv3RFJ9Et/wMFfGFHB0LbshLBXsdlyU4HYKU7dMfVSS
         0L3c12kBr0+Jo39TnwvNRgyBCKvwKgzpC/W0RTnY3qs/pbWufaoE0ZuU+J6OxezyDfiX
         LUCyP+N5o23h8vn2OS/7ts/93XEQ/PigPAImeziCW9mtUnmJOVNVQlrUtQTvnFHTAA5/
         xl+H+oY6cUv5ExnAmFimkDH2rHQsAg2gRFC/BUXT66qLT7rYIYlRfr6bYXGKlx0R9Z8T
         jUR0EkYP6vlOqRr5kwPYC2YRlT8Ust75vxWlWBGD0lWh1fvKIlkLdEujILCyaCAc13a7
         pXnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710791216; x=1711396016;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ma3C4PV+wA5L6sBZD8pU388eAyrZYQpBA1CelpJ7Ffc=;
        b=XDohJgmk28wriueTlO1dvNntWuAreavUV6r1KHIsufm/uHkF75Up/AvM4XsSBp7eaY
         z1yWXhrGJh8bU909x/orQPAISbYgxFHsjmSzgECS/Li/GjE5ox8I2SwmAI1BoyiA/Wyt
         36MrbQ7KMBlfW+3fqyDbYNpxKrERyNtXC6rWK5kLf8beoGOXxSQGBax5pAXpAqhqpJ6M
         Z1Doi2HYTzVcujdkbc28cSaEYsS1a0jxJY2LgoJAUFTthiJmO+bHqpc3FhCeyKMavBvj
         cGca24lTK1n4d93HO9RiR+8Ae8HNhG5qVcYnpDB7HjKofRO2WTSG3CZFYHQLefxC877a
         ADxg==
X-Forwarded-Encrypted: i=1; AJvYcCWoKtz/nFd3vcEV3qHWkDQKq9wkvGwMsLyT/+2yNR60XwmiR3fBNrffLZzrtwMNXOWO5TN9CyfmD7t/+b8gVidfG0ltVuCx
X-Gm-Message-State: AOJu0YxFBmKvVJPVC4VETdYn13qGT6C9k0tB3hYLVuD02jF/M2DUKHT5
	tyAk2acwZypi3dg1PsJyNS2YVEwvj5mZMpm9jl4+TuMY3QOZxl2FhzXblGPg1MUZFZ233v4zhIN
	KIVS+r9aCdE+E0gdKaDgQryRY1hlK12hyUQxK
X-Google-Smtp-Source: AGHT+IHyVYIr21j8k1vWtEz6qdV3FxwRwASwNDoMKk7mwrEqIFhJyvt+omCVlt8R1BssOLMz62x2zoLrI4mEclIU5zU=
X-Received: by 2002:a50:ee04:0:b0:568:c280:64e9 with SMTP id
 g4-20020a50ee04000000b00568c28064e9mr48841eds.4.1710791215782; Mon, 18 Mar
 2024 12:46:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZfiWjOWDs2osFAnX@cy-server>
In-Reply-To: <ZfiWjOWDs2osFAnX@cy-server>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 18 Mar 2024 20:46:44 +0100
Message-ID: <CANn89iKjdynvAddoWrQ-Akm=fQeHD9Ww=rAwfGCmYMDSRk6iJw@mail.gmail.com>
Subject: Re: [net/sched] Question about possible misuse checksum in tcf_csum_ipv6_icmp()
To: Chenyuan Yang <chenyuan0y@gmail.com>
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, zzjas98@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2024 at 8:31=E2=80=AFPM Chenyuan Yang <chenyuan0y@gmail.com=
> wrote:
>
> Dear TC subsystem maintainers,
>
> We are curious whether the function `tcf_csum_ipv6_icmp()` would have a m=
isuse of `csum_partial()` leading to an out-of-bounds access.
>
> The function `tcf_csum_ipv6_icmp` is https://elixir.bootlin.com/linux/v6.=
8/source/net/sched/act_csum.c#L183 and the relevant code is
> ```
> static int tcf_csum_ipv6_icmp(struct sk_buff *skb, unsigned int ihl,
>                               unsigned int ipl)
> {
>   ...
>         ip6h =3D ipv6_hdr(skb);
>         icmp6h->icmp6_cksum =3D 0;
>         skb->csum =3D csum_partial(icmp6h, ipl - ihl, 0);
>         icmp6h->icmp6_cksum =3D csum_ipv6_magic(&ip6h->saddr, &ip6h->dadd=
r,
>                                               ipl - ihl, IPPROTO_ICMPV6,
>                                               skb->csum);
>   ...
> }
> ```
>
> Based on this patch: https://lore.kernel.org/netdev/20240201083817.12774-=
1-atenart@kernel.org/T/, it seems that the `skb` here for ICMPv6 could be n=
on-linear, and `csum_partial` is not suitable for non-linear SKBs, which co=
uld lead to an out-of-bound access. The correct approach is to use `skb_che=
cksum` which properly handles non-linear SKBs.
>
> Based on the above information, a possible fix would be
> ```
> -       skb->csum =3D csum_partial(icmp6h, ipl - ihl, 0);
> +       skb->csum =3D skb_checksum(skb, skb_transport_offset(skb), ipl - =
ihl, 0);
> ```

Why would this code be an issue only in  tcf_csum_ipv6_icmp(), and not
in other functions ?

It seems we have proper pskb_may_pull() calls.

If you have a syzbot/syzkaller trace, please share it.

