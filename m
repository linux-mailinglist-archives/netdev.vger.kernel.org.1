Return-Path: <netdev+bounces-249076-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 369AFD13A6F
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 16:28:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7B13B30146FA
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 15:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB922BDC0E;
	Mon, 12 Jan 2026 15:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XE0nQV7/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58EA42ECE93
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 15:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768231513; cv=none; b=he4SzWbxoaUhPfKCZzGrUeI1plNnHktI7DiHB/vxb/j33YQ8K4YyF4hVxZQcVjwHEJWP+Hyk+HfiPDB0LYyEiaVG3Iy0mSAgcgLo/PqD0sQZ/UTWrFr0IOekSlBvFlEKys14/b5kMXI+clsNKX2eANhsw3NgTzldsNGjgjHjE1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768231513; c=relaxed/simple;
	bh=G+QKTgrO5OlCXYY/EENsxiNETp32880BvkH1cycCoZ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eI6IGAi8nWxdTNXmQ/5Hs65PUwhA04li8KkNSbreq7yaoISZ0FTcDzsH15ro7DVFhyuQ0BBj1iDixkenVcLwbk9l0vX6OXFBsYPzgh+gLnfGDZse8jLPeyliYndlmZJWpgQTisAiAlekjKLwJIo5fEWpugcp41E7Llbz7pgeT+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XE0nQV7/; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8bb6a27d390so413280085a.3
        for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 07:25:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768231508; x=1768836308; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dP8prt4HxXfbI5zAdFH56oyn0DYwTOjEaHSkf+B3Fq8=;
        b=XE0nQV7/C7Ai5wFZUigb05rennpTaTsIaGsoe2WjEWPMrE25PHlUCzplmjkkt2eDK0
         l7g3Ijb8YPlHjvqljslg610ItsNLMP+dXLq4sYGeCKrgvMZ0ayYbhdw8d4SmpDmo7018
         hk4z3TOlxij0YV965SVxpsP/X6eX9BvjLBosiZT/7RivjUcD+7SSACfVzxszpYsVUvCn
         MxnwwyE2KbujlWnUNegEj/40vF5BVbt1KaEXdrrJwdRnEAl1NGKYhohEvR0hSh7nGs6J
         9gZiOxBtYgY+61MmoqWCQGWpdgghieLQEXzZZSHSkX8TkFJCQM34h5UugbFYb3Rw8s1Q
         bFVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768231508; x=1768836308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dP8prt4HxXfbI5zAdFH56oyn0DYwTOjEaHSkf+B3Fq8=;
        b=KKBOFuVtoWB9BHroEQ/f5ProVUWxLtF+FITvSHID1RWfiKvPcyYcbsQBrQ8Xht4eOH
         cgvJgnV3v4gvFtRBdIeQ584PE50vubyNnC2tNCZQ2qtEvnfJV92FIXU/vMEqCKArzwKm
         4Y2+Y+3qL8aoHDJqN5qmndFw76Bis3HXhjx8lMt06k/lQjq41UXuagglLM5uIkCv0M7u
         vQWAmoUnNDbVnrQiSgEhYBiSKkJaNECBkdP0S1kd9nP7CS98bd+BaBkK0Wup/zXt9V9V
         zN/L+zK3abWV95j83+Vk6VjKp1Ebn7RfZk03PerTmkvmmwW/YMLWfkVCjzc48dDh6ICA
         YLiQ==
X-Forwarded-Encrypted: i=1; AJvYcCXuSZU7yvw4MkQUcpe4uigAqz6zyQ55m4bpTW4ZrAb/eeAGyCE5xoefNC62DKL1cVfhpLVgxkw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvPu6x/OWvJxak1/lafbbmuOHqwy8SFILxDH+5LM/o0nVUefs0
	BSJXgaxwgDk6+NUnPLw3h1XH0KlBTRYBYd0B/Gism2+ArY/JMBK7iGsR6dZlBFIH08hJChLnN2R
	8v+tmjmkUPQCS3UCoKVUgLOm6iWwE2SLPHnEFVp3ttbPTlYjCmtYPRPkZGEk=
X-Gm-Gg: AY/fxX7HoXWc6rLu0YYqVfaiYBvqj5C+jAhc9QdJ8O7QlDYEo9BAS2yZyqElkb3DKKG
	9oGS4F5SNoe7VGDVbsRXF10gUO/3jwO6kpIP5ygO66Z76u1Fbx1obChFj7hbrE4gc6KLuBpZLOK
	PHGyRqY+azle/19uVV+6rE0MejEHwU7YwcdoXmtVwQz63TheB+Wyn9B4W8EQApuEdQujUQntWOn
	Z5Y2qn2XE4G+eh/y/ebUHcwskGi2og6IY6CTRWse+QeVfxQ60TzyK04ba3yETZZ1BwT6xI=
X-Google-Smtp-Source: AGHT+IEm/Fo7vXHK4ipDjW7O93vuNhoMuHbsKsQZ4lPr82qabGxtkIMfgK0+q58j65IeODrcAEWNprOkZ/ta4PlFZTU=
X-Received: by 2002:a05:622a:7506:b0:4d8:531e:f896 with SMTP id
 d75a77b69052e-4ffc9f5e44emr113082171cf.27.1768231507786; Mon, 12 Jan 2026
 07:25:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260106144529.1424886-1-edumazet@google.com> <20260106095648.07a870f1@kernel.org>
 <CANn89iJnXg892OU13PeJMGvBKw90fJdqDaAmJ867Rptsm0zgNA@mail.gmail.com>
 <aV4ddkDATvo9lBHi@strlen.de> <CANn89iKkThtD7VAN3OaOmC9=Ekiu2u-0TJ1BJaD+g7LCg9ARVQ@mail.gmail.com>
 <aWT-CTaKuup9OYvo@horms.kernel.org>
In-Reply-To: <aWT-CTaKuup9OYvo@horms.kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 12 Jan 2026 16:24:56 +0100
X-Gm-Features: AZwV_QhGQdMum-EaKjRQR53JOpEpHAKEdy-tclvc2tVjXR2b0g5KYvwJiH1nTa0
Message-ID: <CANn89i+95R86QaE=o4MxZSKr6ju3f44npMa7B27fgTGkVf6Z5w@mail.gmail.com>
Subject: Re: [PATCH v2 net] ip6_gre: use skb_vlan_inet_prepare() instead of pskb_inet_may_pull()
To: Simon Horman <horms@kernel.org>
Cc: Florian Westphal <fw@strlen.de>, Jakub Kicinski <kuba@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, syzbot+6023ea32e206eef7920a@syzkaller.appspotmail.com, 
	Mazin Al Haddad <mazin@getstate.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 12, 2026 at 2:58=E2=80=AFPM Simon Horman <horms@kernel.org> wro=
te:
>
> On Wed, Jan 07, 2026 at 10:01:22AM +0100, Eric Dumazet wrote:
> > On Wed, Jan 7, 2026 at 9:46=E2=80=AFAM Florian Westphal <fw@strlen.de> =
wrote:
> > >
> > > Eric Dumazet <edumazet@google.com> wrote:
> > > > On Tue, Jan 6, 2026 at 6:56=E2=80=AFPM Jakub Kicinski <kuba@kernel.=
org> wrote:
> > > > >
> > > > > On Tue,  6 Jan 2026 14:45:29 +0000 Eric Dumazet wrote:
> > > > > > v2: invert the conditions (Jakub)
> > > > >
> > > > > Thanks! Much better now, but still failing
> > > > > tools/testing/selftests/net/gre_gso.sh
> > > > >
> > > > > TAP version 13
> > > > > 1..1
> > > > > # timeout set to 3600
> > > > > # selftests: net: gre_gso.sh
> > > > > # 2.16 [+2.16]     TEST: GREv6/v4 - copy file w/ TSO             =
                      [ OK ]
> > > > > # 3.16 [+1.01] 2026/01/06 10:32:57 socat[20546] W exiting on sign=
al 15
> > > > > # 3.17 [+0.01] 2026/01/06 10:32:57 socat[20546] W exiting on sign=
al 15
> > > > > # 3.17 [+0.00]     TEST: GREv6/v4 - copy file w/ GSO             =
                      [FAIL]
> > > > > # 3.18 [+0.01] 2026/01/06 10:32:57 socat[20533] W exiting on sign=
al 15
> > > > > # 3.19 [+0.00]     TEST: GREv6/v6 - copy file w/ TSO             =
                      [ OK ]
> > > > > # 4.19 [+1.00] 2026/01/06 10:32:59 socat[20559] W exiting on sign=
al 15
> > > > > # 4.19 [+0.01]     TEST: GREv6/v6 - copy file w/ GSO             =
                      [FAIL]
> > > > > # 4.20 [+0.01] 2026/01/06 10:32:59 socat[20549] W exiting on sign=
al 15
> > > > > # 4.22 [+0.02] 2026/01/06 10:32:59 socat[20560] W exiting on sign=
al 15
> > > > > # 4.23 [+0.01]
> > > > > # 4.23 [+0.00] Tests passed:   2
> > > > > # 4.23 [+0.00] Tests failed:   2
> > > > > not ok 1 selftests: net: gre_gso.sh # exit=3D1
> > > > >
> > > > > https://netdev-ctrl.bots.linux.dev/logs/vmksft/net/results/461862=
/65-gre-gso-sh/stdout
> > > >
> > > > For some reason I am unable to run this test from a virtme-ng insta=
nce.
> > > >
> > > > I guess I wlll not make a new version of this patch, maybe Florian =
can
> > > > take over.
> > >
> > > Its failing because nhoff is moved by 14 bytes, test passes after doi=
ng:
> > >
> > > -       if (skb_vlan_inet_prepare(skb, false))
> > > +       if (skb_vlan_inet_prepare(skb, true))
> >
> > Thanks Florian.
> >
> > I finally understood that my virtme-ng problem with this test is that
> > on my platform, /proc/sys/net/core/fb_tunnels_only_for_init_net was
> > set to 2
> >
> > Tests have a hidden dependency against this sysctl.
>
> Should unhide it by making the tests check or set this value?
>
> It seems like a lot of time was lost on this already.

Or we could change iproute2 to no longer rely on the default devices.

2029  execve("/bin/ip", ["ip", "tunnel", "add", "gre1", "mode",
"ip6gre", "local", "fe80::782c:82ff:fe5d:68cc", "remote",
"fe80::8827:efff:feaf:1d87", "dev", "veth0"], 0x56329212d6e0 /* 12
vars */) =3D 0
2029  setsockopt(4, SOL_NETLINK, NETLINK_EXT_ACK, [1], 4) =3D 0
2029  bind(4, {sa_family=3DAF_NETLINK, nl_pid=3D0, nl_groups=3D00000000}, 1=
2) =3D 0
2029  getsockname(4, {sa_family=3DAF_NETLINK, nl_pid=3D-2025971371,
nl_groups=3D00000000}, [12]) =3D 0
2029  sendmsg(4, {msg_name=3D{sa_family=3DAF_NETLINK, nl_pid=3D0,
nl_groups=3D00000000}, msg_namelen=3D12,
msg_iov=3D[{iov_base=3D[{nlmsg_len=3D52, nlmsg_type=3DRTM_GETLINK,
nlmsg_flags=3DNLM_F_REQUEST, nlmsg_seq=3D1768231049, nlmsg_pid=3D0},
{ifi_family=3DAF_UNSPEC, ifi_type=3DARPHRD_NETROM, ifi_index=3D0,
ifi_flags=3D0, ifi_change=3D0}, [[{nla_len=3D8, nla_type=3DIFLA_EXT_MASK},
RTEXT_FILTER_VF|RTEXT_FILTER_SKIP_STATS], [{nla_len=3D10,
nla_type=3DIFLA_IFNAME}, "veth0"]]], iov_len=3D52}], msg_iovlen=3D1,
msg_controllen=3D0, msg_flags=3D0}, 0) =3D 52
2029  recvmsg(4, {msg_name=3D{sa_family=3DAF_NETLINK, nl_pid=3D0,
nl_groups=3D00000000}, msg_namelen=3D12, msg_iov=3D[{iov_base=3DNULL,
iov_len=3D0}], msg_iovlen=3D1, msg_controllen=3D0, msg_flags=3DMSG_TRUNC},
MSG_PEEK|MSG_TRUNC) =3D 832
2029  recvmsg(4, {msg_name=3D{sa_family=3DAF_NETLINK, nl_pid=3D0,
nl_groups=3D00000000}, msg_namelen=3D12,
msg_iov=3D[{iov_base=3D[{nlmsg_len=3D832, nlmsg_type=3DRTM_NEWLINK,
nlmsg_flags=3D0, nlmsg_seq=3D1768231049, nlmsg_pid=3D-2025971371},
{ifi_family=3DAF_UNSPEC, ifi_type=3DARPHRD_ETHER,
ifi_index=3Dif_nametoindex("veth0"),
ifi_flags=3DIFF_UP|IFF_BROADCAST|IFF_RUNNING|IFF_MULTICAST|IFF_LOWER_UP,
ifi_change=3D0}, [[{nla_len=3D10, nla_type=3DIFLA_IFNAME}, "veth0"],
[{nla_len=3D8, nla_type=3DIFLA_TXQLEN}, 1000], [{nla_len=3D5,
nla_type=3DIFLA_OPERSTATE}, 6], [{nla_len=3D5, nla_type=3DIFLA_LINKMODE},
0], [{nla_len=3D5, nla_type=3DIFLA_NETNS_IMMUTABLE}, 0], [{nla_len=3D8,
nla_type=3DIFLA_MTU}, 1500], [{nla_len=3D8, nla_type=3DIFLA_MIN_MTU}, 68],
[{nla_len=3D8, nla_type=3DIFLA_MAX_MTU}, 65535], [{nla_len=3D8,
nla_type=3DIFLA_GROUP}, 0], [{nla_len=3D8, nla_type=3DIFLA_PROMISCUITY}, 0]=
,
[{nla_len=3D8, nla_type=3DIFLA_ALLMULTI}, 0], [{nla_len=3D8,
nla_type=3DIFLA_NUM_TX_QUEUES}, 8], [{nla_len=3D8,
nla_type=3DIFLA_GSO_MAX_SEGS}, 65535], [{nla_len=3D8,
nla_type=3DIFLA_GSO_MAX_SIZE}, 65536], [{nla_len=3D8,
nla_type=3DIFLA_GRO_MAX_SIZE}, 65536], [{nla_len=3D8,
nla_type=3DIFLA_GSO_IPV4_MAX_SIZE}, 65536], [{nla_len=3D8,
nla_type=3DIFLA_GRO_IPV4_MAX_SIZE}, 65536], [{nla_len=3D8,
nla_type=3DIFLA_TSO_MAX_SIZE}, 524280], [{nla_len=3D8,
nla_type=3DIFLA_TSO_MAX_SEGS}, 65535], [{nla_len=3D8,
nla_type=3DIFLA_MAX_PACING_OFFLOAD_HORIZON}, "\x00\x00\x00\x00"],
[{nla_len=3D8, nla_type=3DIFLA_NUM_RX_QUEUES}, 8], [{nla_len=3D5,
nla_type=3DIFLA_CARRIER}, 1], [{nla_len=3D8,
nla_type=3DIFLA_CARRIER_CHANGES}, 2], [{nla_len=3D8,
nla_type=3DIFLA_CARRIER_UP_COUNT}, 1], [{nla_len=3D8,
nla_type=3DIFLA_CARRIER_DOWN_COUNT}, 1], [{nla_len=3D6, nla_type=3D0x44 /*
IFLA_??? */}, "\x00\x00"], [{nla_len=3D6, nla_type=3D0x45 /* IFLA_??? */},
"\x00\x00"], [{nla_len=3D5, nla_type=3DIFLA_PROTO_DOWN}, 0], [{nla_len=3D10=
,
nla_type=3DIFLA_ADDRESS}, 16:ad:38:9c:d2:4b], [{nla_len=3D10,
nla_type=3DIFLA_BROADCAST}, ff:ff:ff:ff:ff:ff], [{nla_len=3D12,
nla_type=3DIFLA_XDP}, [{nla_len=3D5, nla_type=3DIFLA_XDP_ATTACHED},
XDP_ATTACHED_NONE]], [{nla_len=3D16, nla_type=3DIFLA_LINKINFO},
[{nla_len=3D9, nla_type=3DIFLA_INFO_KIND}, "veth"]], ...]],
iov_len=3D32768}], msg_iovlen=3D1, msg_controllen=3D0, msg_flags=3D0}, 0) =
=3D
832
2029  close(4)                          =3D 0
2029  socket(AF_INET6, SOCK_DGRAM, IPPROTO_IP) =3D 4
2029  ioctl(4, _IOC(_IOC_NONE, 0x89, 0xf1, 0), 0x7fff4a526580) =3D -1
ENODEV (No such device)
2029  write(2, "add tunnel \"ip6gre0\" failed: No "..., 44) =3D 44
2029  close(4)                          =3D 0
2029  exit_group(1)                     =3D ?

