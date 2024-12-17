Return-Path: <netdev+bounces-152552-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D469C9F48F5
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 11:34:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D0E9163349
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 10:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CCA31D5CFD;
	Tue, 17 Dec 2024 10:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z/GjuZnR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D841DF965
	for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 10:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734431676; cv=none; b=f65U2dOrwYERUWHGjHiSCRk6y96kLvjgSnO1S83RSOyBV4RvdlkD7HpdKXNOPBaOCRZXw5bXLVgFw2YepCi/1YDkXSS62tOdXM2Pho+w0540NzSlhwj8SU4OKjlK4zeEuhz6YRgwV2wO49+9fXcdCCVlZAwOTT0mTcwFqnDmifQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734431676; c=relaxed/simple;
	bh=MAXszgerXdYkSOU+1Tw2mqf3kkyjEl6YifdqkKrgt7Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SVtMS43MshnYC2ugjV6M7aCjk9Qxmp9P69OWrTSRKCleqXVk3tjhry8bC+As6lyyE2bMiVEBn3yxk2OVNcbDGEu1vXGSGxEg1m3FCRqoDQDDd1YgJrS1/DY2y4qBTCMnYrOeega0mDLceyQdYWJvHPn/zJY5xbpR+aYe8cctLYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z/GjuZnR; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4364a37a1d7so6302585e9.3
        for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 02:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734431673; x=1735036473; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ImZHv5GRZDTb0GI2TRV0LKgjTJY7/MGf7xwwWwZY4wA=;
        b=Z/GjuZnRa8qIP1ZCqhXkGJFpU9r0gL3TJAGpyCGth9yk4dcTjqikisz8Dc8HrJ3/9m
         YgyljTAUCt+uiT4ffQW+IFaIqqd6BPDAsVYqvJ+w/ywfNPiJ3ieF4a7LWt1oNH/uXKj+
         l+pdF5Rgs8JGl/Kd1gG8P33b9Wi4oaH5KAuAPf+xPF4y4IlP9ln49ZpSf+WSIuEZ6r7K
         SzjNe0rX542LBowVewEWcZm71vhgjyndbgCTzKGpRsYHg8BjYnecoyvxKtl6MxJFHRtm
         VfuMDgp6f3WOe0pF1tKvsyPVxKyiEPF7s5K9/MhMItkTu1eQ8zqUZyoqzdFlOxhMosiy
         Xg1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734431673; x=1735036473;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ImZHv5GRZDTb0GI2TRV0LKgjTJY7/MGf7xwwWwZY4wA=;
        b=KfQt15ZJEenNgKOn/5yn24w8/jqOiSxoLSW5Bubv0xh3p7QdS4AFvlIoyY+rfgwLX4
         lFM+x0jkix2acqYu+6+IGSdK0BnvULJy3ANUwNC/Mjp7VRM0sDV2fbzUsELQgir53Mlj
         YvCc7trHJU8k/xC238yL4UWlJbEM0EdPwz8qiituqdcFm6iktGitPNd2yP+Fh+i3V9QY
         aEi8TpjlaV0H5ej4BBgaMliMr6AgfzqDWMqwtVOjZguYkBceUvwXi31jZUx3pa5AWaR3
         G7AR2lbLWzkj+ROWsa6tQB0uHaoHU8eN5vtwwLXYAYzpyzeIGfTNjkBP2gWvO1rq5/kk
         lzyg==
X-Forwarded-Encrypted: i=1; AJvYcCXyE2s2//uAEB7f3A6yOyOVOXyIwSVwfy0FN0lu8gUXqqa4WOGVccX7DJrP2t1UX+v+b/9an6Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyE1vY1+uqAf8r9NTqN4z9XZFZS5DmArPh1tuFaUnRyeOhbWOfm
	XKZfr4Pny1Dn/6CpzdC1tbZtgV111q0kZmnN3nRl3X7fGqEcAdeQsJ31h0mq8G2o5kUDijIlL4L
	aUAlgFL0VYUBpFSFoq0U7NQdrOT0=
X-Gm-Gg: ASbGncvpVgHNpDx/hR7VFr9VLdjVfoddAjpOsJJveUpeFUcLBka0M8w0D/RFz4GKWCq
	rBOJnoNAP8hbbGCo1FeRCRwvIFReAk1mr28q+
X-Google-Smtp-Source: AGHT+IGe9N5wbTtNWkufWYUkMokfEqX0pcycyrx4C3ctYYEGbeq+n4jOJJu3PQZBDqWDboA6huHaZTnWWKHG93Kiv64=
X-Received: by 2002:a05:6000:1fae:b0:385:e013:73f0 with SMTP id
 ffacd0b85a97d-3888e0c23f8mr13668742f8f.59.1734431672589; Tue, 17 Dec 2024
 02:34:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241216110432.51488-1-kuniyu@amazon.com>
In-Reply-To: <20241216110432.51488-1-kuniyu@amazon.com>
From: Xiao Liang <shaw.leon@gmail.com>
Date: Tue, 17 Dec 2024 18:33:56 +0800
Message-ID: <CABAhCOTs+mBV0M-qEDRCNh51SX_8bFMj9-t45Zz7awcbmxEL1Q@mail.gmail.com>
Subject: Re: [PATCH v1 net] rtnetlink: Try the outer netns attribute in rtnl_get_peer_net().
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Cong Wang <cong.wang@bytedance.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 16, 2024 at 7:04=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> Xiao Liang reported that the cited commit changed netns handling
> in newlink() of netkit, veth, and vxcan.
>
> Before the patch, if we don't find a netns attribute in the peer
> device attributes, we tried to find another netns attribute in
> the outer netlink attributes by passing it to rtnl_link_get_net().
>
> Let's restore the original behaviour.
>
> Fixes: 48327566769a ("rtnetlink: fix double call of rtnl_link_get_net_ifl=
a()")
> Reported-by: Xiao Liang <shaw.leon@gmail.com>
> Closes: https://lore.kernel.org/netdev/CABAhCORBVVU8P6AHcEkENMj+gD2d3ce9t=
=3DA_o48E0yOQp8_wUQ@mail.gmail.com/#t
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
>  net/core/rtnetlink.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
> index ebcfc2debf1a..d9f959c619d9 100644
> --- a/net/core/rtnetlink.c
> +++ b/net/core/rtnetlink.c
> @@ -3819,6 +3819,7 @@ static int rtnl_newlink_create(struct sk_buff *skb,=
 struct ifinfomsg *ifm,
>  }
>
>  static struct net *rtnl_get_peer_net(const struct rtnl_link_ops *ops,
> +                                    struct nlattr *tbp[],
>                                      struct nlattr *data[],
>                                      struct netlink_ext_ack *extack)
>  {
> @@ -3826,7 +3827,7 @@ static struct net *rtnl_get_peer_net(const struct r=
tnl_link_ops *ops,
>         int err;
>
>         if (!data || !data[ops->peer_type])
> -               return NULL;
> +               return rtnl_link_get_net_ifla(tbp);
>
>         err =3D rtnl_nla_parse_ifinfomsg(tb, data[ops->peer_type], extack=
);
>         if (err < 0)
> @@ -3971,7 +3972,7 @@ static int rtnl_newlink(struct sk_buff *skb, struct=
 nlmsghdr *nlh,
>                 }
>
>                 if (ops->peer_type) {
> -                       peer_net =3D rtnl_get_peer_net(ops, data, extack)=
;
> +                       peer_net =3D rtnl_get_peer_net(ops, tb, data, ext=
ack);
>                         if (IS_ERR(peer_net)) {
>                                 ret =3D PTR_ERR(peer_net);
>                                 goto put_ops;
> --
> 2.39.5 (Apple Git-154)
>

Thanks. Tested on my environment, and it's back to the original
behavior now.

Tested-by: Xiao Liang <shaw.leon@gmail.com>

