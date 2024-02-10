Return-Path: <netdev+bounces-70754-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB54850420
	for <lists+netdev@lfdr.de>; Sat, 10 Feb 2024 12:23:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0764D1F23713
	for <lists+netdev@lfdr.de>; Sat, 10 Feb 2024 11:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00C5836AF8;
	Sat, 10 Feb 2024 11:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vRhqlTOg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B28026AFC
	for <netdev@vger.kernel.org>; Sat, 10 Feb 2024 11:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707564229; cv=none; b=C008AYsaXGk4YPc5R+4SBBChuu8KaOyHRIXYQdBIzQMv3CHH9fn0aZkzPfwFRgKH1yY5bfRBnkwO2VL8GqtQCEk4aJif0hVPdw5uAYcY+U1+aWRtG9NJ7QjSAQ6QKj6ibQYCF84ZpRzADnxCaNy5IgvfaEFnsSIa2lDCPNatNA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707564229; c=relaxed/simple;
	bh=8mdnz7FX6AVFA0ProEu+Lf/dfpSPsIM2GcVaAfuYYF8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WCrOq/IOzr4OaKvoqlrKKkhOZmxGCIkeqeK6LJjKc0nDkEn2ED8HEVpQQP9CRn1VUqlkcen/NF/wxrnBmPjNzMWkYaF5qolW2+wQrojq0srmxtJ8hFtGjeVCRN+/AHttTM9+FFTIAZw9mkKtce4gqbWDndYOO7rac/LriF8fauk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vRhqlTOg; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-560530f4e21so5341a12.1
        for <netdev@vger.kernel.org>; Sat, 10 Feb 2024 03:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707564226; x=1708169026; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jFtfnV6I0Tzk95X/IdElhDoh1fpTv6s23bNo+1GCp4c=;
        b=vRhqlTOggWelQAlxFmiyp/ltK8VaBSeEJ6v5Zeqq9fX8NQ9y7LtG9IcH2RUivfj7VH
         ULHstNldS/apjSbSlrsc2ZgNnBQUvalLlTyXioViVAlUOfI5wL6krH2klYvUPu14xgiI
         qWF+v1TxZLL+nCKc1xMmJxAaKDFiUpF0/XItusXd9C5GKmXKWlDEpQ2HdFQ1qcdXnJjP
         RIL12YTeuI11GC3Esr34j6onf+nr5kAzhGQQJNobHumjs8KJC+TUMiNi9B4Eu9LQCJnb
         BIf5yMz8i2Hkw5+PjEFJy8uGkAIem/7Boe3SMMO1MqTu9uVRxvA3qNZLGemsK2qypQy7
         cNVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707564226; x=1708169026;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jFtfnV6I0Tzk95X/IdElhDoh1fpTv6s23bNo+1GCp4c=;
        b=s+MfiXa5MaViOLkzerbbndRBcPizcAGptbwW8xEKuYnIuIQgaRVn8tWp7ZfZCD2Ml7
         k1CrVKCxi+bwN95RGyMujb/SEqld1SoJtukGzymu/boldaDA5Q+tAVfafeAQNO9ICMkU
         jJnnM7vhm2Hi1lo+JrOHvAAYxPzoQYAtqqZz/xbiF1jAOSSkfxW2Ae24lKjZItwzv8dZ
         6KpxXpWiCiJJtugAMgOSvyWWi/yM2zqGyFOlGi9fb6J03R24Tqq5tZ6yW9jNsWj/KCD0
         l4DWG/588c9rckX/PTelp+iSmt70wtqNAJPTQJ9eZ/7JGFO9KvrbTKsGHzag26fr0VOL
         BQbQ==
X-Forwarded-Encrypted: i=1; AJvYcCXL/Pilt+/MNM+JMiytPTchJi14eH4BUyq6iRtNn88FRuxSOaHX5vpccusB/cmOz47wNxEDTAHwcL6qmAZPs1JQmjRZyhU8
X-Gm-Message-State: AOJu0Yz/tBU8TJWQnD9Q3bnTH1Y4FDDm8JWKZNNNW29xu5pQs8QLQT0n
	8OE18CwDjnhJaa6RVhJSuPAK5nCAngRDcga8O2jUDnVqAjx/YnE25JQpbVRUakCd11BBYvdUj1/
	GSDMwDrsm5qFljusKyZHFpvvx7494sqmhQ6i2
X-Google-Smtp-Source: AGHT+IHG0njHQd/AdJgZoYMLhqVfm9VH7dVdpqF1lFjF8p//rHhZ6+RpV0LlS8SCZF1XJsAG32GDAorJtu/60y7JqhY=
X-Received: by 2002:a50:8e58:0:b0:55f:cb23:1f1b with SMTP id
 24-20020a508e58000000b0055fcb231f1bmr61706edx.0.1707564226149; Sat, 10 Feb
 2024 03:23:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209145615.3708207-1-edumazet@google.com> <20240209145615.3708207-3-edumazet@google.com>
 <20240209142441.6c56435b@kernel.org>
In-Reply-To: <20240209142441.6c56435b@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 10 Feb 2024 12:23:30 +0100
Message-ID: <CANn89iKMEWTMkUaBvY1DqPwff0p5yFEG4nNDqZrtQBO3y8FFwA@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] rtnetlink: use xarray iterator to implement rtnl_dump_ifinfo()
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 9, 2024 at 11:24=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Fri,  9 Feb 2024 14:56:15 +0000 Eric Dumazet wrote:
> > +     unsigned long ifindex =3D cb->args[0];
>
> [snip]
>
> > +     for_each_netdev_dump(tgt_net, dev, ifindex) {
> > +             if (link_dump_filtered(dev, master_idx, kind_ops))
> > +                     continue;
> > +             err =3D rtnl_fill_ifinfo(skb, dev, net, RTM_NEWLINK,
> > +                                    NETLINK_CB(cb->skb).portid,
> > +                                    nlh->nlmsg_seq, 0, flags,
> > +                                    ext_filter_mask, 0, NULL, 0,
> > +                                    netnsid, GFP_KERNEL);
> > +
> > +             if (err < 0)
> > +                     break;
> > +             cb->args[0] =3D ifindex + 1;
>
> Perhaps we can cast the context buffer onto something typed and use
> it directly? I think it's a tiny bit less error prone:
>
>         struct {
>                 unsigned long ifindex;
>         } *ctx =3D (void *)cb->ctx;
>
> Then we can:
>
>         for_each_netdev_dump(tgt_net, dev, ctx->ifindex)
>                                            ^^^^^^^^^^^^
>
> and not need to worry about saving the ifindex back to cb before
> exiting.

Hi Jakub

I tried something like that (adding a common structure for future
conversions), but this was not working properly.

Unfortunately we only can save the ifindex back to cb->XXXX only after
 rtnl_fill_ifinfo() was a success.

For instance, after applying the following diff to my patch, we have a
bug, because iip link loops on the last device.

We need to set cb->args[0] to  last_dev->ifindex + 1 to end the dump.

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 68a224bbf1dd6118526329782362a4bfc192d6b1..7f562d6e40ebf5329e9c0b1c7ad=
d81c461683907
100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -2192,9 +2192,11 @@ static int rtnl_dump_ifinfo(struct sk_buff
*skb, struct netlink_callback *cb)
        struct netlink_ext_ack *extack =3D cb->extack;
        const struct nlmsghdr *nlh =3D cb->nlh;
        struct net *net =3D sock_net(skb->sk);
-       unsigned long ifindex =3D cb->args[0];
        unsigned int flags =3D NLM_F_MULTI;
        struct nlattr *tb[IFLA_MAX+1];
+       struct {
+               unsigned long ifindex;
+       } *ctx =3D (void *)cb->ctx;
        struct net *tgt_net =3D net;
        u32 ext_filter_mask =3D 0;
        struct net_device *dev;
@@ -2246,7 +2248,7 @@ static int rtnl_dump_ifinfo(struct sk_buff *skb,
struct netlink_callback *cb)

 walk_entries:
        err =3D skb->len;
-       for_each_netdev_dump(tgt_net, dev, ifindex) {
+       for_each_netdev_dump(tgt_net, dev, ctx->ifindex) {
                if (link_dump_filtered(dev, master_idx, kind_ops))
                        continue;
                err =3D rtnl_fill_ifinfo(skb, dev, net, RTM_NEWLINK,
@@ -2257,7 +2259,6 @@ static int rtnl_dump_ifinfo(struct sk_buff *skb,
struct netlink_callback *cb)

                if (err < 0)
                        break;
-               cb->args[0] =3D ifindex + 1;
        }
        cb->seq =3D tgt_net->dev_base_seq;
        nl_dump_check_consistent(cb, nlmsg_hdr(skb));

