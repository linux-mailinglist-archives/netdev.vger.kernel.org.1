Return-Path: <netdev+bounces-70841-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44022850BA7
	for <lists+netdev@lfdr.de>; Sun, 11 Feb 2024 22:36:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A92711F215B7
	for <lists+netdev@lfdr.de>; Sun, 11 Feb 2024 21:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B0C5F47D;
	Sun, 11 Feb 2024 21:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dIzbvet1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6E55381E
	for <netdev@vger.kernel.org>; Sun, 11 Feb 2024 21:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707687358; cv=none; b=C2itdWgg29iXHUFtg6T8pychcnVxJF3nMfLJf0paY+IKId4UCF0zsu1D2PvkeRMtNof8itVY5Eq1iPqjj7yxxayBPzhGd03tG0y3ReH4f9esh7/hkeJ26KYvSnZGrI0QH+6g6cngfq32VqxVTobBDymy6S/YYSEjJrIytAfBzt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707687358; c=relaxed/simple;
	bh=Et5UggLWqim907h2pvCcuUFqh2aCkorybMXvYefEiYY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yhx4J/x9Fy1bwnGhT2KLW9BconmhEPQ2sH4cC3sag5aW2x+4Yw/ZylbnPSwMTpEyprgCHzjmhUTKJd8bQygDPTxsunvFFu9R33iIXXyWGPGXhNxAriXNF7JbMJZXjmFM3FQap2p85eSiWIxrBrwiLzpzaxeWGk68ec0teuXmDcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dIzbvet1; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-560530f4e21so7998a12.1
        for <netdev@vger.kernel.org>; Sun, 11 Feb 2024 13:35:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707687355; x=1708292155; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B8O5CdfUJ2Su7L+BLobZ+SnuKAdxWcJmIL0L2VgCzo8=;
        b=dIzbvet1aVn472Je58j/FRv+SexzVDIJLrf5UE/HMC3WVC/1HHk9dVJX7ojXDoNlg4
         5kvoUBp6TRCC41ZjJXl6D/NNGs+kzuRluVedh/ElegqpJzJbjrnadykCttef0mKleCGI
         GIIf4AoLbGHvrnbDlxDeOkm66S2I135U1mMUMUbe1GV7RchZrCxsGyuvPAAwVlc4iaGF
         dyx77qNLTDCTysHCHOKAsRCsjrIe/Uq22IDAvVEbvZOrldzvYGuajj6CsOyXhPEjXYkw
         0HJuJ/87NT3l2kQDR35qL0jfEQrulH+hnTbU4YPPXAUKdG7mOxhQuhG29Wo0G1fMru7P
         sl2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707687355; x=1708292155;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B8O5CdfUJ2Su7L+BLobZ+SnuKAdxWcJmIL0L2VgCzo8=;
        b=XVawsFZOohOl8Mx5zSA75Z40F00M2CH9R2DzbrKA2cYbKo4q03U1SH0lgkyTupxP1A
         apCwYqL0oeYDkg9X0tz/3q7DzTD6US1izpaicF2wL3tFDlt9OcTP4MzQ9ziEzhjUa796
         IWL3PNKciQC4H222jOixP+dKdp0Pc+cauTCIeerfo49uJAHYdEIhoZH9ltfMY1XvcNCq
         YyjEVGjBY8wzspoJNLabGDzfas0C5a4HsSVS6DReOhp8HWTyIc6N6i4x7Thlwy8crteo
         lAphKIi4PgSOa1GIyZMwJvvgA81y+3sh+R/ve82Cr7U+6AoH10taxvGmRG/6QcsAdkGl
         FpFA==
X-Forwarded-Encrypted: i=1; AJvYcCVy6EG+5M4TfpdIaxXvAUQecA+OJe/XXwcbyXei6rOibAFJNvapLHvhz1P5DJj2W1200EDt3a8Cd4BhDLHRIEo9tgtGXdSi
X-Gm-Message-State: AOJu0Yxk125FMcki88HhDdKMv3olZNQS3mhR192N++Z78kM9TAOJw/TC
	+kyRmBNgcf336RiekAHYRUsXq/N5one0jLq2cZFjT9mGZ9g+qenYZIwIVHMfCa9Y2CQauLM8keo
	kFVVC2kTni/iKSBkh78Otpu2TiQWSR65Qu2m50tbJLA2qUtxjOw==
X-Google-Smtp-Source: AGHT+IFo2lqqJR2L9yTFsUPbzVOcyTFYWqx9d5mbQMDK+YpBHeGF+FEwTMUJ79SE+3y0Jj71VBQMOB5huh/QM8wzdGQ=
X-Received: by 2002:a50:d483:0:b0:560:1a1:eb8d with SMTP id
 s3-20020a50d483000000b0056001a1eb8dmr131657edi.7.1707687354483; Sun, 11 Feb
 2024 13:35:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209145615.3708207-1-edumazet@google.com> <20240209145615.3708207-3-edumazet@google.com>
 <20240209142441.6c56435b@kernel.org> <CANn89iKMEWTMkUaBvY1DqPwff0p5yFEG4nNDqZrtQBO3y8FFwA@mail.gmail.com>
 <ZckR-XOsULLI9EHc@shredder>
In-Reply-To: <ZckR-XOsULLI9EHc@shredder>
From: Eric Dumazet <edumazet@google.com>
Date: Sun, 11 Feb 2024 22:35:40 +0100
Message-ID: <CANn89iLtS3hG5BBHSi0yR_VPuG0p-Sdq+DigXah6MB54zxdw1g@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] rtnetlink: use xarray iterator to implement rtnl_dump_ifinfo()
To: Ido Schimmel <idosch@idosch.org>
Cc: Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 11, 2024 at 7:29=E2=80=AFPM Ido Schimmel <idosch@idosch.org> wr=
ote:
>

>
> I was looking into that in the past because of another rtnetlink dump
> handler. See merge commit f8d3e0dc4b3a ("Merge branch
> 'nexthop-nexthop-dump-fixes'") and commit 913f60cacda7 ("nexthop: Fix
> infinite nexthop dump when using maximum nexthop ID").
>
> Basically, rtnetlink dump handlers always return a positive value if
> some entries were filled in the skb to signal that more information
> needs to be dumped, even if the dump is complete. I suspect this was
> done to ensure that appending the NLMSG_DONE message will not fail, but
> Jason fixed it in 2017 in commit 0642840b8bb0 ("af_netlink: ensure that
> NLMSG_DONE never fails in dumps").
>
> You can see that the dump is split across two buffers with only a single
> netdev configured:
>
> # strace -e sendto,recvmsg ip l
> sendto(3, [{nlmsg_len=3D40, nlmsg_type=3D0x12 /* NLMSG_??? */, nlmsg_flag=
s=3DNLM_F_REQUEST|0x300, nlmsg_seq=3D1707673609, nlmsg_pid=3D0}, "\x11\x00\=
x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x08\x00\x1d\x00\x01=
\x00\x00\x00"], 40, 0, NULL, 0) =3D 40
> recvmsg(3, {msg_name=3D{sa_family=3DAF_NETLINK, nl_pid=3D0, nl_groups=3D0=
0000000}, msg_namelen=3D12, msg_iov=3D[{iov_base=3DNULL, iov_len=3D0}], msg=
_iovlen=3D1, msg_controllen=3D0, msg_flags=3DMSG_TRUNC}, MSG_PEEK|MSG_TRUNC=
) =3D 764
> recvmsg(3, {msg_name=3D{sa_family=3DAF_NETLINK, nl_pid=3D0, nl_groups=3D0=
0000000}, msg_namelen=3D12, msg_iov=3D[{iov_base=3D[{nlmsg_len=3D764, nlmsg=
_type=3D0x10 /* NLMSG_??? */, nlmsg_flags=3DNLM_F_MULTI, nlmsg_seq=3D170767=
3609, nlmsg_pid=3D565}, "\x00\x00\x04\x03\x01\x00\x00\x00\x49\x00\x01\x00\x=
00\x00\x00\x00\x07\x00\x03\x00\x6c\x6f\x00\x00\x08\x00\x0d\x00\xe8\x03\x00\=
x00"...], iov_len=3D32768}], msg_iovlen=3D1, msg_controllen=3D0, msg_flags=
=3D0}, 0) =3D 764
> recvmsg(3, {msg_name=3D{sa_family=3DAF_NETLINK, nl_pid=3D0, nl_groups=3D0=
0000000}, msg_namelen=3D12, msg_iov=3D[{iov_base=3DNULL, iov_len=3D0}], msg=
_iovlen=3D1, msg_controllen=3D0, msg_flags=3DMSG_TRUNC}, MSG_PEEK|MSG_TRUNC=
) =3D 20
> recvmsg(3, {msg_name=3D{sa_family=3DAF_NETLINK, nl_pid=3D0, nl_groups=3D0=
0000000}, msg_namelen=3D12, msg_iov=3D[{iov_base=3D[{nlmsg_len=3D20, nlmsg_=
type=3DNLMSG_DONE, nlmsg_flags=3DNLM_F_MULTI, nlmsg_seq=3D1707673609, nlmsg=
_pid=3D565}, 0], iov_len=3D32768}], msg_iovlen=3D1, msg_controllen=3D0, msg=
_flags=3D0}, 0) =3D 20
> 1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mode =
DEFAULT group default qlen 1000
>     link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
> +++ exited with 0 +++
>
> The fake sentinel ('last_dev->ifindex + 1') is needed so that in the
> second invocation of the dump handler it will not fill anything and then
> return zero to signal that the dump is complete.
>
> The following diff avoids this inefficiency and returns zero when the
> dump is complete:
>
> diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
> index 31f433950c8d..4efd571a6a3f 100644
> --- a/net/core/rtnetlink.c
> +++ b/net/core/rtnetlink.c
> @@ -2267,17 +2267,15 @@ static int rtnl_dump_ifinfo(struct sk_buff *skb, =
struct netlink_callback *cb)
>
>                         if (err < 0) {
>                                 if (likely(skb->len))
> -                                       goto out;
> -
> -                               goto out_err;
> +                                       err =3D skb->len;
> +                               goto out;
>                         }
>  cont:
>                         idx++;
>                 }
>         }
> +
>  out:
> -       err =3D skb->len;
> -out_err:
>         cb->args[1] =3D idx;
>         cb->args[0] =3D h;
>         cb->seq =3D tgt_net->dev_base_seq;
>
> You can see that both messages (RTM_NEWLINK and NLMSG_DONE) are dumped
> in a single buffer with this patch:
>
> # strace -e sendto,recvmsg ip l
> sendto(3, [{nlmsg_len=3D40, nlmsg_type=3D0x12 /* NLMSG_??? */, nlmsg_flag=
s=3DNLM_F_REQUEST|0x300, nlmsg_seq=3D1707674313, nlmsg_pid=3D0}, "\x11\x00\=
x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x08\x00\x1d\x00\x01=
\x00\x00\x00"], 40, 0, NULL, 0) =3D 40
> recvmsg(3, {msg_name=3D{sa_family=3DAF_NETLINK, nl_pid=3D0, nl_groups=3D0=
0000000}, msg_namelen=3D12, msg_iov=3D[{iov_base=3DNULL, iov_len=3D0}], msg=
_iovlen=3D1, msg_controllen=3D0, msg_flags=3DMSG_TRUNC}, MSG_PEEK|MSG_TRUNC=
) =3D 784
> recvmsg(3, {msg_name=3D{sa_family=3DAF_NETLINK, nl_pid=3D0, nl_groups=3D0=
0000000}, msg_namelen=3D12, msg_iov=3D[{iov_base=3D[[{nlmsg_len=3D764, nlms=
g_type=3D0x10 /* NLMSG_??? */, nlmsg_flags=3DNLM_F_MULTI, nlmsg_seq=3D17076=
74313, nlmsg_pid=3D570}, "\x00\x00\x04\x03\x01\x00\x00\x00\x49\x00\x01\x00\=
x00\x00\x00\x00\x07\x00\x03\x00\x6c\x6f\x00\x00\x08\x00\x0d\x00\xe8\x03\x00=
\x00"...], [{nlmsg_len=3D20, nlmsg_type=3DNLMSG_DONE, nlmsg_flags=3DNLM_F_M=
ULTI, nlmsg_seq=3D1707674313, nlmsg_pid=3D570}, 0]], iov_len=3D32768}], msg=
_iovlen=3D1, msg_controllen=3D0, msg_flags=3D0}, 0) =3D 784
> 1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mode =
DEFAULT group default qlen 1000
>     link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
> +++ exited with 0 +++
>
> And then it's possible to apply your patch with Jakub's suggestion:
>
> diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
> index 4efd571a6a3f..dba13b31c58b 100644
> --- a/net/core/rtnetlink.c
> +++ b/net/core/rtnetlink.c
> @@ -2188,25 +2188,22 @@ static int rtnl_valid_dump_ifinfo_req(const struc=
t nlmsghdr *nlh,
>
>  static int rtnl_dump_ifinfo(struct sk_buff *skb, struct netlink_callback=
 *cb)
>  {
> +       const struct rtnl_link_ops *kind_ops =3D NULL;
>         struct netlink_ext_ack *extack =3D cb->extack;
>         const struct nlmsghdr *nlh =3D cb->nlh;
>         struct net *net =3D sock_net(skb->sk);
> -       struct net *tgt_net =3D net;
> -       int h, s_h;
> -       int idx =3D 0, s_idx;
> -       struct net_device *dev;
> -       struct hlist_head *head;
> +       unsigned int flags =3D NLM_F_MULTI;
>         struct nlattr *tb[IFLA_MAX+1];
> +       struct {
> +               unsigned long ifindex;
> +       } *ctx =3D (void *)cb->ctx;
> +       struct net *tgt_net =3D net;
>         u32 ext_filter_mask =3D 0;
> -       const struct rtnl_link_ops *kind_ops =3D NULL;
> -       unsigned int flags =3D NLM_F_MULTI;
> +       struct net_device *dev;
>         int master_idx =3D 0;
>         int netnsid =3D -1;
>         int err, i;
>
> -       s_h =3D cb->args[0];
> -       s_idx =3D cb->args[1];
> -
>         err =3D rtnl_valid_dump_ifinfo_req(nlh, cb->strict_check, tb, ext=
ack);
>         if (err < 0) {
>                 if (cb->strict_check)
> @@ -2250,34 +2247,22 @@ static int rtnl_dump_ifinfo(struct sk_buff *skb, =
struct netlink_callback *cb)
>                 flags |=3D NLM_F_DUMP_FILTERED;
>
>  walk_entries:
> -       for (h =3D s_h; h < NETDEV_HASHENTRIES; h++, s_idx =3D 0) {
> -               idx =3D 0;
> -               head =3D &tgt_net->dev_index_head[h];
> -               hlist_for_each_entry(dev, head, index_hlist) {
> -                       if (link_dump_filtered(dev, master_idx, kind_ops)=
)
> -                               goto cont;
> -                       if (idx < s_idx)
> -                               goto cont;
> -                       err =3D rtnl_fill_ifinfo(skb, dev, net,
> -                                              RTM_NEWLINK,
> -                                              NETLINK_CB(cb->skb).portid=
,
> -                                              nlh->nlmsg_seq, 0, flags,
> -                                              ext_filter_mask, 0, NULL, =
0,
> -                                              netnsid, GFP_KERNEL);
> -
> -                       if (err < 0) {
> -                               if (likely(skb->len))
> -                                       err =3D skb->len;
> -                               goto out;
> -                       }
> -cont:
> -                       idx++;
> +       err =3D 0;
> +       for_each_netdev_dump(tgt_net, dev, ctx->ifindex) {
> +               if (link_dump_filtered(dev, master_idx, kind_ops))
> +                       continue;
> +               err =3D rtnl_fill_ifinfo(skb, dev, net, RTM_NEWLINK,
> +                                      NETLINK_CB(cb->skb).portid,
> +                                      nlh->nlmsg_seq, 0, flags,
> +                                      ext_filter_mask, 0, NULL, 0,
> +                                      netnsid, GFP_KERNEL);
> +
> +               if (err < 0) {
> +                       if (likely(skb->len))
> +                               err =3D skb->len;
> +                       break;
>                 }
>         }
> -
> -out:
> -       cb->args[1] =3D idx;
> -       cb->args[0] =3D h;
>         cb->seq =3D tgt_net->dev_base_seq;
>         nl_dump_check_consistent(cb, nlmsg_hdr(skb));
>         if (netnsid >=3D 0)
>
> And it will not hang:
>
> # strace -e sendto,recvmsg ip l
> sendto(3, [{nlmsg_len=3D40, nlmsg_type=3D0x12 /* NLMSG_??? */, nlmsg_flag=
s=3DNLM_F_REQUEST|0x300, nlmsg_seq=3D1707675119, nlmsg_pid=3D0}, "\x11\x00\=
x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x08\x00\x1d\x00\x01=
\x00\x00\x00"], 40, 0, NULL, 0) =3D 40
> recvmsg(3, {msg_name=3D{sa_family=3DAF_NETLINK, nl_pid=3D0, nl_groups=3D0=
0000000}, msg_namelen=3D12, msg_iov=3D[{iov_base=3DNULL, iov_len=3D0}], msg=
_iovlen=3D1, msg_controllen=3D0, msg_flags=3DMSG_TRUNC}, MSG_PEEK|MSG_TRUNC=
) =3D 784
> recvmsg(3, {msg_name=3D{sa_family=3DAF_NETLINK, nl_pid=3D0, nl_groups=3D0=
0000000}, msg_namelen=3D12, msg_iov=3D[{iov_base=3D[[{nlmsg_len=3D764, nlms=
g_type=3D0x10 /* NLMSG_??? */, nlmsg_flags=3DNLM_F_MULTI, nlmsg_seq=3D17076=
75119, nlmsg_pid=3D564}, "\x00\x00\x04\x03\x01\x00\x00\x00\x49\x00\x01\x00\=
x00\x00\x00\x00\x07\x00\x03\x00\x6c\x6f\x00\x00\x08\x00\x0d\x00\xe8\x03\x00=
\x00"...], [{nlmsg_len=3D20, nlmsg_type=3DNLMSG_DONE, nlmsg_flags=3DNLM_F_M=
ULTI, nlmsg_seq=3D1707675119, nlmsg_pid=3D564}, 0]], iov_len=3D32768}], msg=
_iovlen=3D1, msg_controllen=3D0, msg_flags=3D0}, 0) =3D 784
> 1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mode =
DEFAULT group default qlen 1000
>     link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
> +++ exited with 0 +++

Excellent, thanks for helping me on this ;)

I am sending a V2 right away.

