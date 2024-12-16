Return-Path: <netdev+bounces-152145-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C6AE9F2E25
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 11:25:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C5741637B6
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 10:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A00202F8C;
	Mon, 16 Dec 2024 10:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JfflVtcO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F891B4F3A
	for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 10:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734344721; cv=none; b=DvP29Z4R3vtWJNKjBlywwHpl4Gc+P2VCM2TVAgfcCM4/4dOweLDJG6OIa5cwK9EbDlHDMqvvDqLdnTZBHeKnop2EEkQOO2alfkT/2+d0r612sdfSQkLTwYtZ5RQf5t3QQRNbyF9khRaFcPNcluq8wosTmAOwF8I1nOox6Vg2NLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734344721; c=relaxed/simple;
	bh=lnHUL37wy+rFC3+HX8WQSV1bTm9KWLWQtMLIBtfOTQ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D2R3FpOPnuaGTeZw+c+QiZ9Q2G5Fay+w9biDWSG5ykT3tr6LZZkN077Jh0+mqiHLfLQ133/venbv0E/pJVaygg1+i0VloM8AGgfo3oBNZYIyzoRFiPGK9vIM1NjunS/HHoIm/+Ka0pPwYU3GLoBk1qDGHlhah8OvYredKkoYm8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JfflVtcO; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4361e89b6daso26566385e9.3
        for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 02:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734344717; x=1734949517; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H61SiUG2NMy0rcPjrn75KMUjzuqI/UPm//5dCsWjPrE=;
        b=JfflVtcOXwtXaKJAW1Fbg+XEXtG/HFPTNNiynzzku7HjN9y2UuoF0ASXm2/qaMOj8O
         uQWodFm7gnyivlpUqcoQg6BCALCJXFev5BBObSlIuIqTP59uLEd/QeQR3hvS7yLggkRb
         Be+FB5ahZn77K9nhsmKB3EF0eJ9OHtK7dpbPkZk4/BQFtD5Bl/f7cJnctABHRzOJeveT
         1czJhVt38/bIhn91Yl4cYkBisQQpQxc/9iwAzru0MSFfzy1Hr20cJ5zfnBv1Xs6mV8Ab
         Vu3M4kBJtgAibxRmvhn9TO/JvkRgJZACenewRzb+3ANyrlvg9FYj/mZ6+lOJ0PF5CAzw
         TVKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734344717; x=1734949517;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H61SiUG2NMy0rcPjrn75KMUjzuqI/UPm//5dCsWjPrE=;
        b=u/K753HPjfBe//pb7Ey1Kklcg8GeVSVCoguJcgTS/7xvJf/SfWgTJ4lDFAq1znMXlC
         zaPcGHVqX2FMuSDVFV+287MHLk2pbqh1AtrEUTcv+NSCAYD6/7C3I8kWy42lOEwuXRRy
         OyXDCa9/zDYO7bd9K6PYd3sXvp76P8S6BJkuAHJ+V5H99ESGhcs65bsMhTL3UXZXQLRq
         MCbl44ViBtIoFyuxlGaeC7SPSXxFdZFFjFEiaGfppq1mm99HFGKrHCcWbPb/H5vcRvn4
         gaaxviwFyjOA8rayv2eXMPbQ0Hte8vwzL4JffhgPIc4QLNvxZkgPwbHZaLjgsOzLfCij
         R2cw==
X-Gm-Message-State: AOJu0Yyc1qTYf3Ly7y0hTBuEFyvcfD7QIVoLTHUN1X7SeDY2B7VG8LOm
	LCUsgzKHipTrbXOOVgAPOfmG1rCdqMj5UORO5WDFg67wuKa+lfP5K/c4fZ4bMoyrC16YpJOoawV
	aoAxSy+Z47eLJtbkMf+VTbWzlsACbN+K3JtQ=
X-Gm-Gg: ASbGncunQV6j3l0lWiGfY/KhqAC8wCdUEF4mjMIsCofJ7/wnahtApyXVUiwc+6b+fh0
	vd2E60jrSpuM2vkQOSVn4aSL11tXr1N50FsT8C/I=
X-Google-Smtp-Source: AGHT+IEFXFhSSZSrdw0587br8S/8V+gouaA0AhLuI5smfgxvZrCpUW/LMLHa1oZMplTdDpd8JTR/30USIbAVVWGFXrQ=
X-Received: by 2002:a05:600c:510f:b0:434:fae4:1630 with SMTP id
 5b1f17b1804b1-4362aaa0036mr87323855e9.28.1734344716405; Mon, 16 Dec 2024
 02:25:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241129063112.763095-1-xiyou.wangcong@gmail.com> <20241129212519.825567-1-xiyou.wangcong@gmail.com>
In-Reply-To: <20241129212519.825567-1-xiyou.wangcong@gmail.com>
From: Xiao Liang <shaw.leon@gmail.com>
Date: Mon, 16 Dec 2024 18:24:39 +0800
Message-ID: <CABAhCORBVVU8P6AHcEkENMj+gD2d3ce9t=A_o48E0yOQp8_wUQ@mail.gmail.com>
Subject: Re: [Patch net v2] rtnetlink: fix double call of rtnl_link_get_net_ifla()
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: netdev@vger.kernel.org, Cong Wang <cong.wang@bytedance.com>, 
	syzbot+21ba4d5adff0b6a7cfc6@syzkaller.appspotmail.com, 
	Kuniyuki Iwashima <kuniyu@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 16, 2024 at 4:53=E2=80=AFPM Cong Wang <xiyou.wangcong@gmail.com=
> wrote:
>
> From: Cong Wang <cong.wang@bytedance.com>
>
> Currently rtnl_link_get_net_ifla() gets called twice when we create
> peer devices, once in rtnl_add_peer_net() and once in each ->newlink()
> implementation.
>
> This looks safer, however, it leads to a classic Time-of-Check to
> Time-of-Use (TOCTOU) bug since IFLA_NET_NS_PID is very dynamic. And
> because of the lack of checking error pointer of the second call, it
> also leads to a kernel crash as reported by syzbot.
>
> Fix this by getting rid of the second call, which already becomes
> redudant after Kuniyuki's work. We have to propagate the result of the
> first rtnl_link_get_net_ifla() down to each ->newlink().
>
> Reported-by: syzbot+21ba4d5adff0b6a7cfc6@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D21ba4d5adff0b6a7cfc6
> Fixes: 0eb87b02a705 ("veth: Set VETH_INFO_PEER to veth_link_ops.peer_type=
.")
> Fixes: 6b84e558e95d ("vxcan: Set VXCAN_INFO_PEER to vxcan_link_ops.peer_t=
ype.")
> Fixes: fefd5d082172 ("netkit: Set IFLA_NETKIT_PEER_INFO to netkit_link_op=
s.peer_type.")
> Cc: Kuniyuki Iwashima <kuniyu@amazon.com>
> Signed-off-by: Cong Wang <cong.wang@bytedance.com>
> ---
>  drivers/net/can/vxcan.c | 10 ++--------
>  drivers/net/netkit.c    | 11 +++--------
>  drivers/net/veth.c      | 12 +++--------
>  net/core/rtnetlink.c    | 44 +++++++++++++++++++++--------------------
>  4 files changed, 31 insertions(+), 46 deletions(-)
>
> diff --git a/drivers/net/can/vxcan.c b/drivers/net/can/vxcan.c
> index da7c72105fb6..ca8811941085 100644
> --- a/drivers/net/can/vxcan.c
> +++ b/drivers/net/can/vxcan.c
> @@ -172,13 +172,12 @@ static void vxcan_setup(struct net_device *dev)
>  /* forward declaration for rtnl_create_link() */
>  static struct rtnl_link_ops vxcan_link_ops;
>
> -static int vxcan_newlink(struct net *net, struct net_device *dev,
> +static int vxcan_newlink(struct net *peer_net, struct net_device *dev,
>                          struct nlattr *tb[], struct nlattr *data[],
>                          struct netlink_ext_ack *extack)
>  {
>         struct vxcan_priv *priv;
>         struct net_device *peer;
> -       struct net *peer_net;
>
>         struct nlattr *peer_tb[IFLA_MAX + 1], **tbp =3D tb;
>         char ifname[IFNAMSIZ];
> @@ -203,20 +202,15 @@ static int vxcan_newlink(struct net *net, struct ne=
t_device *dev,
>                 name_assign_type =3D NET_NAME_ENUM;
>         }
>
> -       peer_net =3D rtnl_link_get_net(net, tbp);
>         peer =3D rtnl_create_link(peer_net, ifname, name_assign_type,
>                                 &vxcan_link_ops, tbp, extack);
> -       if (IS_ERR(peer)) {
> -               put_net(peer_net);
> +       if (IS_ERR(peer))
>                 return PTR_ERR(peer);
> -       }
>
>         if (ifmp && dev->ifindex)
>                 peer->ifindex =3D ifmp->ifi_index;
>
>         err =3D register_netdevice(peer);
> -       put_net(peer_net);
> -       peer_net =3D NULL;
>         if (err < 0) {
>                 free_netdev(peer);
>                 return err;
> diff --git a/drivers/net/netkit.c b/drivers/net/netkit.c
> index bb07725d1c72..c1d881dc6409 100644
> --- a/drivers/net/netkit.c
> +++ b/drivers/net/netkit.c
> @@ -327,7 +327,7 @@ static int netkit_validate(struct nlattr *tb[], struc=
t nlattr *data[],
>
>  static struct rtnl_link_ops netkit_link_ops;
>
> -static int netkit_new_link(struct net *src_net, struct net_device *dev,
> +static int netkit_new_link(struct net *peer_net, struct net_device *dev,
>                            struct nlattr *tb[], struct nlattr *data[],
>                            struct netlink_ext_ack *extack)
>  {
> @@ -342,7 +342,6 @@ static int netkit_new_link(struct net *src_net, struc=
t net_device *dev,
>         struct net_device *peer;
>         char ifname[IFNAMSIZ];
>         struct netkit *nk;
> -       struct net *net;
>         int err;
>
>         if (data) {
> @@ -385,13 +384,10 @@ static int netkit_new_link(struct net *src_net, str=
uct net_device *dev,
>             (tb[IFLA_ADDRESS] || tbp[IFLA_ADDRESS]))
>                 return -EOPNOTSUPP;
>
> -       net =3D rtnl_link_get_net(src_net, tbp);
> -       peer =3D rtnl_create_link(net, ifname, ifname_assign_type,
> +       peer =3D rtnl_create_link(peer_net, ifname, ifname_assign_type,
>                                 &netkit_link_ops, tbp, extack);
> -       if (IS_ERR(peer)) {
> -               put_net(net);
> +       if (IS_ERR(peer))
>                 return PTR_ERR(peer);
> -       }
>
>         netif_inherit_tso_max(peer, dev);
>
> @@ -408,7 +404,6 @@ static int netkit_new_link(struct net *src_net, struc=
t net_device *dev,
>         bpf_mprog_bundle_init(&nk->bundle);
>
>         err =3D register_netdevice(peer);
> -       put_net(net);
>         if (err < 0)
>                 goto err_register_peer;
>         netif_carrier_off(peer);
> diff --git a/drivers/net/veth.c b/drivers/net/veth.c
> index 0d6d0d749d44..07ebb800edf1 100644
> --- a/drivers/net/veth.c
> +++ b/drivers/net/veth.c
> @@ -1765,7 +1765,7 @@ static int veth_init_queues(struct net_device *dev,=
 struct nlattr *tb[])
>         return 0;
>  }
>
> -static int veth_newlink(struct net *src_net, struct net_device *dev,
> +static int veth_newlink(struct net *peer_net, struct net_device *dev,
>                         struct nlattr *tb[], struct nlattr *data[],
>                         struct netlink_ext_ack *extack)
>  {
> @@ -1776,7 +1776,6 @@ static int veth_newlink(struct net *src_net, struct=
 net_device *dev,
>         struct nlattr *peer_tb[IFLA_MAX + 1], **tbp;
>         unsigned char name_assign_type;
>         struct ifinfomsg *ifmp;
> -       struct net *net;
>
>         /*
>          * create and register peer first
> @@ -1800,13 +1799,10 @@ static int veth_newlink(struct net *src_net, stru=
ct net_device *dev,
>                 name_assign_type =3D NET_NAME_ENUM;
>         }
>
> -       net =3D rtnl_link_get_net(src_net, tbp);
> -       peer =3D rtnl_create_link(net, ifname, name_assign_type,
> +       peer =3D rtnl_create_link(peer_net, ifname, name_assign_type,
>                                 &veth_link_ops, tbp, extack);
> -       if (IS_ERR(peer)) {
> -               put_net(net);
> +       if (IS_ERR(peer))
>                 return PTR_ERR(peer);
> -       }
>
>         if (!ifmp || !tbp[IFLA_ADDRESS])
>                 eth_hw_addr_random(peer);
> @@ -1817,8 +1813,6 @@ static int veth_newlink(struct net *src_net, struct=
 net_device *dev,
>         netif_inherit_tso_max(peer, dev);
>
>         err =3D register_netdevice(peer);
> -       put_net(net);
> -       net =3D NULL;
>         if (err < 0)
>                 goto err_register_peer;
>
> diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
> index 58df76fe408a..ab5f201bf0ab 100644
> --- a/net/core/rtnetlink.c
> +++ b/net/core/rtnetlink.c
> @@ -3746,6 +3746,7 @@ static int rtnl_group_changelink(const struct sk_bu=
ff *skb,
>  static int rtnl_newlink_create(struct sk_buff *skb, struct ifinfomsg *if=
m,
>                                const struct rtnl_link_ops *ops,
>                                struct net *tgt_net, struct net *link_net,
> +                              struct net *peer_net,
>                                const struct nlmsghdr *nlh,
>                                struct nlattr **tb, struct nlattr **data,
>                                struct netlink_ext_ack *extack)
> @@ -3776,8 +3777,13 @@ static int rtnl_newlink_create(struct sk_buff *skb=
, struct ifinfomsg *ifm,
>
>         dev->ifindex =3D ifm->ifi_index;
>
> +       if (link_net)
> +               net =3D link_net;
> +       if (peer_net)
> +               net =3D peer_net;
> +
>         if (ops->newlink)
> -               err =3D ops->newlink(link_net ? : net, dev, tb, data, ext=
ack);
> +               err =3D ops->newlink(net, dev, tb, data, extack);
>         else
>                 err =3D register_netdevice(dev);
>         if (err < 0) {
> @@ -3812,40 +3818,33 @@ static int rtnl_newlink_create(struct sk_buff *sk=
b, struct ifinfomsg *ifm,
>         goto out;
>  }
>
> -static int rtnl_add_peer_net(struct rtnl_nets *rtnl_nets,
> -                            const struct rtnl_link_ops *ops,
> -                            struct nlattr *data[],
> -                            struct netlink_ext_ack *extack)
> +static struct net *rtnl_get_peer_net(const struct rtnl_link_ops *ops,
> +                                    struct nlattr *data[],
> +                                    struct netlink_ext_ack *extack)
>  {
>         struct nlattr *tb[IFLA_MAX + 1];
> -       struct net *net;
>         int err;
>
>         if (!data || !data[ops->peer_type])
> -               return 0;
> +               return NULL;

I was adding some tests about the link netns stuff, and found
a behavior change. Prior to this patch, veth, vxcan and netkit
were trying the outer tb if peer info was not set. But returning
NULL here skips this part of logic. Say if we have:

    ip link add netns ns1 foo type veth

The peer link is changed from ns1 to current netns.

Thanks.

>
>         err =3D rtnl_nla_parse_ifinfomsg(tb, data[ops->peer_type], extack=
);
>         if (err < 0)
> -               return err;
> +               return ERR_PTR(err);
>
>         if (ops->validate) {
>                 err =3D ops->validate(tb, NULL, extack);
>                 if (err < 0)
> -                       return err;
> +                       return ERR_PTR(err);
>         }
>
> -       net =3D rtnl_link_get_net_ifla(tb);
> -       if (IS_ERR(net))
> -               return PTR_ERR(net);
> -       if (net)
> -               rtnl_nets_add(rtnl_nets, net);
> -
> -       return 0;
> +       return rtnl_link_get_net_ifla(tb);
>  }
>
>  static int __rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
>                           const struct rtnl_link_ops *ops,
>                           struct net *tgt_net, struct net *link_net,
> +                         struct net *peer_net,
>                           struct rtnl_newlink_tbs *tbs,
>                           struct nlattr **data,
>                           struct netlink_ext_ack *extack)
> @@ -3894,14 +3893,15 @@ static int __rtnl_newlink(struct sk_buff *skb, st=
ruct nlmsghdr *nlh,
>                 return -EOPNOTSUPP;
>         }
>
> -       return rtnl_newlink_create(skb, ifm, ops, tgt_net, link_net, nlh,=
 tb, data, extack);
> +       return rtnl_newlink_create(skb, ifm, ops, tgt_net, link_net, peer=
_net, nlh,
> +                                  tb, data, extack);
>  }
>
>  static int rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
>                         struct netlink_ext_ack *extack)
>  {
> +       struct net *tgt_net, *link_net =3D NULL, *peer_net =3D NULL;
>         struct nlattr **tb, **linkinfo, **data =3D NULL;
> -       struct net *tgt_net, *link_net =3D NULL;
>         struct rtnl_link_ops *ops =3D NULL;
>         struct rtnl_newlink_tbs *tbs;
>         struct rtnl_nets rtnl_nets;
> @@ -3971,9 +3971,11 @@ static int rtnl_newlink(struct sk_buff *skb, struc=
t nlmsghdr *nlh,
>                 }
>
>                 if (ops->peer_type) {
> -                       ret =3D rtnl_add_peer_net(&rtnl_nets, ops, data, =
extack);
> -                       if (ret < 0)
> +                       peer_net =3D rtnl_get_peer_net(ops, data, extack)=
;
> +                       if (IS_ERR(peer_net))
>                                 goto put_ops;
> +                       if (peer_net)
> +                               rtnl_nets_add(&rtnl_nets, peer_net);
>                 }
>         }
>
> @@ -4004,7 +4006,7 @@ static int rtnl_newlink(struct sk_buff *skb, struct=
 nlmsghdr *nlh,
>         }
>
>         rtnl_nets_lock(&rtnl_nets);
> -       ret =3D __rtnl_newlink(skb, nlh, ops, tgt_net, link_net, tbs, dat=
a, extack);
> +       ret =3D __rtnl_newlink(skb, nlh, ops, tgt_net, link_net, peer_net=
, tbs, data, extack);
>         rtnl_nets_unlock(&rtnl_nets);
>
>  put_net:
> --
> 2.34.1
>
>

