Return-Path: <netdev+bounces-129251-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0080997E800
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 10:58:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 361F6B21A97
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 08:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A222194137;
	Mon, 23 Sep 2024 08:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IQMa2awP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9A71940B5
	for <netdev@vger.kernel.org>; Mon, 23 Sep 2024 08:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727081873; cv=none; b=uxRORE8MMMINn0BorleVTGf5Ass3mKr/Zwa6w2EHv5D67CHrgVFTKG2bw//7SyXTMdqdSAq/+p3O/AVq+YRI7QMirol7jI4v6+AfkmYhJeulGsZvvN0nqwmaAkW4SIpBojIrg7psqv/+M1hZi6iOUoE8AmKeE3Ee/sEMOlzFqW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727081873; c=relaxed/simple;
	bh=YQLVJWieLc9zhq7jmy4TnD6AHo1rVXcY0n4zS46y+yM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XDZpoU4jI/oX/4wtl+4w3UWcvZiqWSqdsxU21O+GQQCg2r4x+hDJSSbgSxTzj5LQPNwhyXp+3WL+HQHeM1E5kx6cRjktz2JTxReQFelcs/6LQ4B5XLwbXrvUNacxXQGBx4QWQQVmjA56MGNLsoo+dvoF3R+VLMpdxBjXrA3Y+Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IQMa2awP; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a9018103214so594326366b.3
        for <netdev@vger.kernel.org>; Mon, 23 Sep 2024 01:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727081869; x=1727686669; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nyM4DmjzVCW3YthPxYZVDbKycspXMq2IxqBbSvHv/5w=;
        b=IQMa2awP/P+SZp+yMneEi9n88tMfNjwPsrJDu6qsfO0K3BB4KgD+HtFGn0waBCnS/3
         v1Om2MoNeUSPx+pvpq4ciGMOY0n9Md3WuHz1R4AaoYWUG4YvWfXTNLh6cLHqE/HoOw9Z
         vUBcnzCJO10dpDEZEQcmCl3Fc+JE5V+Zuvx88/gkoWfrTH1Fu8tED0nQO/IaU4EWOJPA
         s1efXGPROAsMZ0IbTkumfp+JFxLY3hAYTfpSjBgSiKWF5h0GeBC0joz9Z6YEyoHTK+ed
         UN66MaGDJAdLT/qiVxIbBd+tfLG7Zspp47vZzB8DbxxgLLlxhbroQGvlpKICNfadliuP
         cCUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727081869; x=1727686669;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nyM4DmjzVCW3YthPxYZVDbKycspXMq2IxqBbSvHv/5w=;
        b=QfQhVcPPCscSXuUEPXo8i87tfHq8pi0E9eKDCHvGYBHBXiA43qjBymGk/tvNKUdl2h
         H874I8LfS6Y93bdPzJoFaf8px28tV+pepdm1knCsZZY74QQ+XP7EKtOWJbPO0S7dYixy
         2LwZ2ECG6rRz0Rjla0Z9KMW2n41kiB/9edPgntopKP56E0nvcF+pea6qEnBdLBIMkg0O
         6UT3XFgZ1mPm+NxrOUALH8rUi6IM49Ckg1y+AdeXVw2SjR1yBspCm3HS5Rr8ZIrZr5iQ
         g8Zc02p8B6aPVWmgo6I2IsQ4mdMDbyDtwm71RCwiIKkuOMWI5C9C9p2BBlGDBKZxHGW+
         B+YQ==
X-Gm-Message-State: AOJu0YwsnEur+iMpV4DYeCQRdkd247ILRqPeIq7BbdconItUY8yZ+FNh
	y9+qWd+cAvP/VwPt7NHmwmMGAyfJZvrrfF+kIUb+DdaVWToUaueWRSwcIFS2tylRAugKSStmA+C
	muPp+dl7goE+BFhT4nMCcIEG1NNrsxmuLIvkk
X-Google-Smtp-Source: AGHT+IFBPfRX57lRyRY6QWrqTAVc830bow6tdsOH6p/OCZ0hm+eQY5vQFVbDFlUHINDv5XT+RQbV9caB6pOLUDNz2nA=
X-Received: by 2002:a17:907:9450:b0:a8d:7b7d:8c39 with SMTP id
 a640c23a62f3a-a90d59266demr1116511566b.43.1727081868591; Mon, 23 Sep 2024
 01:57:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240921215410.638664-1-littlesmilingcloud@gmail.com>
 <CANn89iKP3VPExdyZt+eLFk3rE5=6yRckTPySfh5MvcEqPNm6aA@mail.gmail.com> <ZvB8stjbrXoez86t@dau-work-pc.sunlink.ru>
In-Reply-To: <ZvB8stjbrXoez86t@dau-work-pc.sunlink.ru>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 23 Sep 2024 10:57:34 +0200
Message-ID: <CANn89iJoMcxe6xAOE=QGfqmOa1p+_ssSr_2y4KUJr-Qap3xk0Q@mail.gmail.com>
Subject: Re: [RFC PATCH net] ipv4: ip_gre: Fix drops of small packets in ipgre_xmit
To: Anton Danilov <littlesmilingcloud@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Suman Ghosh <sumang@marvell.com>, Shigeru Yoshida <syoshida@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 22, 2024 at 10:23=E2=80=AFPM Anton Danilov
<littlesmilingcloud@gmail.com> wrote:
>
> On Sun, Sep 22, 2024 at 12:20:03PM +0200, Eric Dumazet wrote:
>
> Hi Eric,
>
> > Please provide a real selftest, because in this particular example,
> > the path taken by the packets should not reach the
> > pskb_network_may_pull(skb, pull_len)),
> > because dev->header_ops should be NULL ?
>
> I sincerely apologize for providing an inaccurate example of the commands
> needed to reproduce the issue. I understand that this may have caused
> confusion, and I'm truly sorry for any inconvenience.
>
> Here are the correct commands and their results.
>
>
>   ip l add name mgre0 type gre local 192.168.71.177 remote 0.0.0.0 ikey 1=
.9.8.4 okey 1.9.8.4
>   ip l s mtu 1400 dev mgre0
>   ip a add 192.168.13.1/24 dev mgre0
>   ip l s up dev mgre0
>   ip n add 192.168.13.2 lladdr 192.168.69.50 dev mgre0

This looks much better. I was hoping that we could capture this in a
new test (added in tools/testing/selftests/net)

Please also move the buggy "tnl_params =3D (const struct iphdr
*)skb->data;" line as in :

diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
index 5f6fd382af38a32d9e22633cdb2e9fd01f1795e4..f1f31ebfc7934467fd10776c3cb=
221f9cff9f9dd
100644
--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -662,11 +662,11 @@ static netdev_tx_t ipgre_xmit(struct sk_buff *skb,
                if (skb_cow_head(skb, 0))
                        goto free_skb;

-               tnl_params =3D (const struct iphdr *)skb->data;
-
-               if (!pskb_network_may_pull(skb, pull_len))
+               if (!pskb_may_pull(skb, pull_len))
                        goto free_skb;

+               tnl_params =3D (const struct iphdr *)skb->data;
+
                /* ip_tunnel_xmit() needs skb->data pointing to gre header.=
 */
                skb_pull(skb, pull_len);
                skb_reset_mac_header(skb);


>
>
>   ip -s -s -d l ls dev mgre0
>     19: mgre0@NONE: <NOARP,UP,LOWER_UP> mtu 1400 qdisc noqueue state UNKN=
OWN mode DEFAULT group default qlen 1000
>         link/gre 192.168.71.177 brd 0.0.0.0 promiscuity 0  allmulti 0 min=
mtu 0 maxmtu 0
>         gre remote any local 192.168.71.177 ttl inherit ikey 1.9.8.4 okey=
 1.9.8.4 \
>           addrgenmode eui64 numtxqueues 1 numrxqueues 1 gso_max_size 6553=
6 gso_max_segs 65535 \
>           tso_max_size 65536 tso_max_segs 65535 gro_max_size 65536
>
>         RX:  bytes packets errors dropped  missed   mcast
>                  0       0      0       0       0       0
>         RX errors:  length    crc   frame    fifo overrun
>                          0      0       0       0       0
>         TX:  bytes packets errors dropped carrier collsns
>                  0       0      0       0       0       0
>         TX errors: aborted   fifo  window heartbt transns
>                          0      0       0       0       0
>
>
>   ping -n -c 10 -s 1374 192.168.13.2
>     PING 192.168.13.2 (192.168.13.2) 1374(1402) bytes of data.
>
>     --- 192.168.13.2 ping statistics ---
>     10 packets transmitted, 0 received, 100% packet loss, time 9237ms
>
>
>   ip -s -s -d l ls dev mgre0
>     19: mgre0@NONE: <NOARP,UP,LOWER_UP> mtu 1400 qdisc noqueue state UNKN=
OWN mode DEFAULT group default qlen 1000
>         link/gre 192.168.71.177 brd 0.0.0.0 promiscuity 1  allmulti 0 min=
mtu 0 maxmtu 0
>         gre remote any local 192.168.71.177 ttl inherit ikey 1.9.8.4 okey=
 1.9.8.4 \
>           addrgenmode eui64 numtxqueues 1 numrxqueues 1 gso_max_size 6553=
6 gso_max_segs 65535 \
>           tso_max_size 65536 tso_max_segs 65535 gro_max_size 65536
>
>         RX:  bytes packets errors dropped  missed   mcast
>                  0       0      0       0       0       0
>         RX errors:  length    crc   frame    fifo overrun
>                          0      0       0       0       0
>         TX:  bytes packets errors dropped carrier collsns
>              13960      10      0      10       0       0
>         TX errors: aborted   fifo  window heartbt transns
>                      0      0       0       0       0
>
>
>   tcpdump -vni mgre0
>     tcpdump: listening on mgre0, link-type LINUX_SLL (Linux cooked v1), s=
napshot length 262144 bytes
>     21:51:19.481523 IP (tos 0x0, ttl 64, id 52595, offset 0, flags [+], p=
roto ICMP (1), length 1396)
>         192.168.13.1 > 192.168.13.2: ICMP echo request, id 63847, seq 1, =
length 1376
>     21:51:19.481547 IP (tos 0x0, ttl 64, id 52595, offset 1376, flags [no=
ne], proto ICMP (1), length 26)
>         192.168.13.1 > 192.168.13.2: ip-proto-1
>     21:51:20.526751 IP (tos 0x0, ttl 64, id 53374, offset 0, flags [+], p=
roto ICMP (1), length 1396)
>         192.168.13.1 > 192.168.13.2: ICMP echo request, id 63847, seq 2, =
length 1376
>     21:51:20.526773 IP (tos 0x0, ttl 64, id 53374, offset 1376, flags [no=
ne], proto ICMP (1), length 26)
>         192.168.13.1 > 192.168.13.2: ip-proto-1
>     21:51:21.550751 IP (tos 0x0, ttl 64, id 54124, offset 0, flags [+], p=
roto ICMP (1), length 1396)
>         192.168.13.1 > 192.168.13.2: ICMP echo request, id 63847, seq 3, =
length 1376
>     21:51:21.550775 IP (tos 0x0, ttl 64, id 54124, offset 1376, flags [no=
ne], proto ICMP (1), length 26)
>         192.168.13.1 > 192.168.13.2: ip-proto-1
>     21:51:22.574748 IP (tos 0x0, ttl 64, id 55109, offset 0, flags [+], p=
roto ICMP (1), length 1396)
>         192.168.13.1 > 192.168.13.2: ICMP echo request, id 63847, seq 4, =
length 1376
>     21:51:22.574766 IP (tos 0x0, ttl 64, id 55109, offset 1376, flags [no=
ne], proto ICMP (1), length 26)
>         192.168.13.1 > 192.168.13.2: ip-proto-1
>     21:51:23.598748 IP (tos 0x0, ttl 64, id 56011, offset 0, flags [+], p=
roto ICMP (1), length 1396)
>         192.168.13.1 > 192.168.13.2: ICMP echo request, id 63847, seq 5, =
length 1376
>     21:51:23.598771 IP (tos 0x0, ttl 64, id 56011, offset 1376, flags [no=
ne], proto ICMP (1), length 26)
>         192.168.13.1 > 192.168.13.2: ip-proto-1
>     21:51:24.622758 IP (tos 0x0, ttl 64, id 57009, offset 0, flags [+], p=
roto ICMP (1), length 1396)
>         192.168.13.1 > 192.168.13.2: ICMP echo request, id 63847, seq 6, =
length 1376
>     21:51:24.622783 IP (tos 0x0, ttl 64, id 57009, offset 1376, flags [no=
ne], proto ICMP (1), length 26)
>         192.168.13.1 > 192.168.13.2: ip-proto-1
>     21:51:25.646748 IP (tos 0x0, ttl 64, id 57277, offset 0, flags [+], p=
roto ICMP (1), length 1396)
>         192.168.13.1 > 192.168.13.2: ICMP echo request, id 63847, seq 7, =
length 1376
>     21:51:25.646775 IP (tos 0x0, ttl 64, id 57277, offset 1376, flags [no=
ne], proto ICMP (1), length 26)
>         192.168.13.1 > 192.168.13.2: ip-proto-1
>     21:51:26.670750 IP (tos 0x0, ttl 64, id 57869, offset 0, flags [+], p=
roto ICMP (1), length 1396)
>         192.168.13.1 > 192.168.13.2: ICMP echo request, id 63847, seq 8, =
length 1376
>     21:51:26.670773 IP (tos 0x0, ttl 64, id 57869, offset 1376, flags [no=
ne], proto ICMP (1), length 26)
>         192.168.13.1 > 192.168.13.2: ip-proto-1
>     21:51:27.694751 IP (tos 0x0, ttl 64, id 58317, offset 0, flags [+], p=
roto ICMP (1), length 1396)
>         192.168.13.1 > 192.168.13.2: ICMP echo request, id 63847, seq 9, =
length 1376
>     21:51:27.694774 IP (tos 0x0, ttl 64, id 58317, offset 1376, flags [no=
ne], proto ICMP (1), length 26)
>         192.168.13.1 > 192.168.13.2: ip-proto-1
>     21:51:28.718751 IP (tos 0x0, ttl 64, id 58558, offset 0, flags [+], p=
roto ICMP (1), length 1396)
>         192.168.13.1 > 192.168.13.2: ICMP echo request, id 63847, seq 10,=
 length 1376
>     21:51:28.718775 IP (tos 0x0, ttl 64, id 58558, offset 1376, flags [no=
ne], proto ICMP (1), length 26)
>         192.168.13.1 > 192.168.13.2: ip-proto-1
>
>
>   tcpdump -vni enp11s0.100 'ip proto 47'
>     tcpdump: listening on enp11s0.100, link-type EN10MB (Ethernet), snaps=
hot length 262144 bytes
>     21:51:19.481696 IP (tos 0x0, ttl 64, id 32563, offset 0, flags [DF], =
proto GRE (47), length 1424)
>         192.168.71.177 > 192.168.69.50: GREv0, Flags [key present], key=
=3D0x1090804, length 1404
>         IP (tos 0x0, ttl 64, id 52595, offset 0, flags [+], proto ICMP (1=
), length 1396)
>         192.168.13.1 > 192.168.13.2: ICMP echo request, id 63847, seq 1, =
length 1376
>     21:51:20.526767 IP (tos 0x0, ttl 64, id 33363, offset 0, flags [DF], =
proto GRE (47), length 1424)
>         192.168.71.177 > 192.168.69.50: GREv0, Flags [key present], key=
=3D0x1090804, length 1404
>         IP (tos 0x0, ttl 64, id 53374, offset 0, flags [+], proto ICMP (1=
), length 1396)
>         192.168.13.1 > 192.168.13.2: ICMP echo request, id 63847, seq 2, =
length 1376
>     21:51:21.550768 IP (tos 0x0, ttl 64, id 34260, offset 0, flags [DF], =
proto GRE (47), length 1424)
>         192.168.71.177 > 192.168.69.50: GREv0, Flags [key present], key=
=3D0x1090804, length 1404
>         IP (tos 0x0, ttl 64, id 54124, offset 0, flags [+], proto ICMP (1=
), length 1396)
>         192.168.13.1 > 192.168.13.2: ICMP echo request, id 63847, seq 3, =
length 1376
>     21:51:22.574761 IP (tos 0x0, ttl 64, id 34922, offset 0, flags [DF], =
proto GRE (47), length 1424)
>         192.168.71.177 > 192.168.69.50: GREv0, Flags [key present], key=
=3D0x1090804, length 1404
>         IP (tos 0x0, ttl 64, id 55109, offset 0, flags [+], proto ICMP (1=
), length 1396)
>         192.168.13.1 > 192.168.13.2: ICMP echo request, id 63847, seq 4, =
length 1376
>     21:51:23.598764 IP (tos 0x0, ttl 64, id 35042, offset 0, flags [DF], =
proto GRE (47), length 1424)
>         192.168.71.177 > 192.168.69.50: GREv0, Flags [key present], key=
=3D0x1090804, length 1404
>         IP (tos 0x0, ttl 64, id 56011, offset 0, flags [+], proto ICMP (1=
), length 1396)
>         192.168.13.1 > 192.168.13.2: ICMP echo request, id 63847, seq 5, =
length 1376
>     21:51:24.622775 IP (tos 0x0, ttl 64, id 36024, offset 0, flags [DF], =
proto GRE (47), length 1424)
>         192.168.71.177 > 192.168.69.50: GREv0, Flags [key present], key=
=3D0x1090804, length 1404
>         IP (tos 0x0, ttl 64, id 57009, offset 0, flags [+], proto ICMP (1=
), length 1396)
>         192.168.13.1 > 192.168.13.2: ICMP echo request, id 63847, seq 6, =
length 1376
>     21:51:25.646766 IP (tos 0x0, ttl 64, id 36133, offset 0, flags [DF], =
proto GRE (47), length 1424)
>         192.168.71.177 > 192.168.69.50: GREv0, Flags [key present], key=
=3D0x1090804, length 1404
>         IP (tos 0x0, ttl 64, id 57277, offset 0, flags [+], proto ICMP (1=
), length 1396)
>         192.168.13.1 > 192.168.13.2: ICMP echo request, id 63847, seq 7, =
length 1376
>     21:51:26.670766 IP (tos 0x0, ttl 64, id 36417, offset 0, flags [DF], =
proto GRE (47), length 1424)
>         192.168.71.177 > 192.168.69.50: GREv0, Flags [key present], key=
=3D0x1090804, length 1404
>         IP (tos 0x0, ttl 64, id 57869, offset 0, flags [+], proto ICMP (1=
), length 1396)
>         192.168.13.1 > 192.168.13.2: ICMP echo request, id 63847, seq 8, =
length 1376
>     21:51:27.694767 IP (tos 0x0, ttl 64, id 37006, offset 0, flags [DF], =
proto GRE (47), length 1424)
>         192.168.71.177 > 192.168.69.50: GREv0, Flags [key present], key=
=3D0x1090804, length 1404
>         IP (tos 0x0, ttl 64, id 58317, offset 0, flags [+], proto ICMP (1=
), length 1396)
>         192.168.13.1 > 192.168.13.2: ICMP echo request, id 63847, seq 9, =
length 1376
>     21:51:28.718767 IP (tos 0x0, ttl 64, id 37825, offset 0, flags [DF], =
proto GRE (47), length 1424)
>         192.168.71.177 > 192.168.69.50: GREv0, Flags [key present], key=
=3D0x1090804, length 1404
>         IP (tos 0x0, ttl 64, id 58558, offset 0, flags [+], proto ICMP (1=
), length 1396)
>         192.168.13.1 > 192.168.13.2: ICMP echo request, id 63847, seq 10,=
 length 1376
>
>
>   ping -n -c 10 -s 1376 192.168.13.2
>     PING 192.168.13.2 (192.168.13.2) 1376(1404) bytes of data.
>
>     --- 192.168.13.2 ping statistics ---
>     10 packets transmitted, 0 received, 100% packet loss, time 9198ms
>
>
>   ip -s -s -d l ls dev mgre0
>     19: mgre0@NONE: <NOARP,UP,LOWER_UP> mtu 1400 qdisc noqueue state UNKN=
OWN mode DEFAULT group default qlen 1000
>         link/gre 192.168.71.177 brd 0.0.0.0 promiscuity 0  allmulti 0 min=
mtu 0 maxmtu 0
>         gre remote any local 192.168.71.177 ttl inherit ikey 1.9.8.4 okey=
 1.9.8.4 addrgenmode eui64 numtxqueues 1 numrxqueues 1 gso_max_size 65536 g=
so_max_segs 65535 tso_max_size 65536 tso_max_segs 65535 gro_max_size 65536
>         RX:  bytes packets errors dropped  missed   mcast
>                  0       0      0       0       0       0
>         RX errors:  length    crc   frame    fifo overrun
>                          0      0       0       0       0
>         TX:  bytes packets errors dropped carrier collsns
>              28200      30      0      10       0       0
>         TX errors: aborted   fifo  window heartbt transns
>                          0      0       0       0       0
>
>
>   tcpdump -vni mgre0
>     tcpdump: listening on mgre0, link-type LINUX_SLL (Linux cooked v1), s=
napshot length 262144 bytes
>     22:01:34.176810 IP (tos 0x0, ttl 64, id 40388, offset 0, flags [+], p=
roto ICMP (1), length 1396)
>         192.168.13.1 > 192.168.13.2: ICMP echo request, id 54476, seq 1, =
length 1376
>     22:01:34.176830 IP (tos 0x0, ttl 64, id 40388, offset 1376, flags [no=
ne], proto ICMP (1), length 28)
>         192.168.13.1 > 192.168.13.2: ip-proto-1
>     22:01:35.183742 IP (tos 0x0, ttl 64, id 40516, offset 0, flags [+], p=
roto ICMP (1), length 1396)
>         192.168.13.1 > 192.168.13.2: ICMP echo request, id 54476, seq 2, =
length 1376
>     22:01:35.183765 IP (tos 0x0, ttl 64, id 40516, offset 1376, flags [no=
ne], proto ICMP (1), length 28)
>         192.168.13.1 > 192.168.13.2: ip-proto-1
>     22:01:36.207750 IP (tos 0x0, ttl 64, id 40684, offset 0, flags [+], p=
roto ICMP (1), length 1396)
>         192.168.13.1 > 192.168.13.2: ICMP echo request, id 54476, seq 3, =
length 1376
>     22:01:36.207774 IP (tos 0x0, ttl 64, id 40684, offset 1376, flags [no=
ne], proto ICMP (1), length 28)
>         192.168.13.1 > 192.168.13.2: ip-proto-1
>     22:01:37.230738 IP (tos 0x0, ttl 64, id 41578, offset 0, flags [+], p=
roto ICMP (1), length 1396)
>         192.168.13.1 > 192.168.13.2: ICMP echo request, id 54476, seq 4, =
length 1376
>     22:01:37.230756 IP (tos 0x0, ttl 64, id 41578, offset 1376, flags [no=
ne], proto ICMP (1), length 28)
>         192.168.13.1 > 192.168.13.2: ip-proto-1
>     22:01:38.254761 IP (tos 0x0, ttl 64, id 42099, offset 0, flags [+], p=
roto ICMP (1), length 1396)
>         192.168.13.1 > 192.168.13.2: ICMP echo request, id 54476, seq 5, =
length 1376
>     22:01:38.254789 IP (tos 0x0, ttl 64, id 42099, offset 1376, flags [no=
ne], proto ICMP (1), length 28)
>         192.168.13.1 > 192.168.13.2: ip-proto-1
>     22:01:39.278748 IP (tos 0x0, ttl 64, id 42506, offset 0, flags [+], p=
roto ICMP (1), length 1396)
>         192.168.13.1 > 192.168.13.2: ICMP echo request, id 54476, seq 6, =
length 1376
>     22:01:39.278771 IP (tos 0x0, ttl 64, id 42506, offset 1376, flags [no=
ne], proto ICMP (1), length 28)
>         192.168.13.1 > 192.168.13.2: ip-proto-1
>     22:01:40.302738 IP (tos 0x0, ttl 64, id 42527, offset 0, flags [+], p=
roto ICMP (1), length 1396)
>         192.168.13.1 > 192.168.13.2: ICMP echo request, id 54476, seq 7, =
length 1376
>     22:01:40.302754 IP (tos 0x0, ttl 64, id 42527, offset 1376, flags [no=
ne], proto ICMP (1), length 28)
>         192.168.13.1 > 192.168.13.2: ip-proto-1
>     22:01:41.326733 IP (tos 0x0, ttl 64, id 42989, offset 0, flags [+], p=
roto ICMP (1), length 1396)
>         192.168.13.1 > 192.168.13.2: ICMP echo request, id 54476, seq 8, =
length 1376
>     22:01:41.326749 IP (tos 0x0, ttl 64, id 42989, offset 1376, flags [no=
ne], proto ICMP (1), length 28)
>         192.168.13.1 > 192.168.13.2: ip-proto-1
>     22:01:42.350750 IP (tos 0x0, ttl 64, id 43576, offset 0, flags [+], p=
roto ICMP (1), length 1396)
>         192.168.13.1 > 192.168.13.2: ICMP echo request, id 54476, seq 9, =
length 1376
>     22:01:42.350773 IP (tos 0x0, ttl 64, id 43576, offset 1376, flags [no=
ne], proto ICMP (1), length 28)
>         192.168.13.1 > 192.168.13.2: ip-proto-1
>     22:01:43.374743 IP (tos 0x0, ttl 64, id 44118, offset 0, flags [+], p=
roto ICMP (1), length 1396)
>         192.168.13.1 > 192.168.13.2: ICMP echo request, id 54476, seq 10,=
 length 1376
>     22:01:43.374762 IP (tos 0x0, ttl 64, id 44118, offset 1376, flags [no=
ne], proto ICMP (1), length 28)
>         192.168.13.1 > 192.168.13.2: ip-proto-1
>
>
>   tcpdump -vni enp11s0.100 'ip proto 47'
>     tcpdump: listening on enp11s0.100, link-type EN10MB (Ethernet), snaps=
hot length 262144 bytes
>     22:01:34.176825 IP (tos 0x0, ttl 64, id 5066, offset 0, flags [DF], p=
roto GRE (47), length 1424)
>         192.168.71.177 > 192.168.69.50: GREv0, Flags [key present], key=
=3D0x1090804, length 1404
>         IP (tos 0x0, ttl 64, id 40388, offset 0, flags [+], proto ICMP (1=
), length 1396)
>         192.168.13.1 > 192.168.13.2: ICMP echo request, id 54476, seq 1, =
length 1376
>     22:01:34.176832 IP (tos 0x0, ttl 64, id 5067, offset 0, flags [DF], p=
roto GRE (47), length 56)
>         192.168.71.177 > 192.168.69.50: GREv0, Flags [key present], key=
=3D0x1090804, length 36
>         IP (tos 0x0, ttl 64, id 40388, offset 1376, flags [none], proto I=
CMP (1), length 28)
>         192.168.13.1 > 192.168.13.2: ip-proto-1
>     22:01:35.183758 IP (tos 0x0, ttl 64, id 5567, offset 0, flags [DF], p=
roto GRE (47), length 1424)
>         192.168.71.177 > 192.168.69.50: GREv0, Flags [key present], key=
=3D0x1090804, length 1404
>         IP (tos 0x0, ttl 64, id 40516, offset 0, flags [+], proto ICMP (1=
), length 1396)
>         192.168.13.1 > 192.168.13.2: ICMP echo request, id 54476, seq 2, =
length 1376
>     22:01:35.183768 IP (tos 0x0, ttl 64, id 5568, offset 0, flags [DF], p=
roto GRE (47), length 56)
>         192.168.71.177 > 192.168.69.50: GREv0, Flags [key present], key=
=3D0x1090804, length 36
>         IP (tos 0x0, ttl 64, id 40516, offset 1376, flags [none], proto I=
CMP (1), length 28)
>         192.168.13.1 > 192.168.13.2: ip-proto-1
>     22:01:36.207767 IP (tos 0x0, ttl 64, id 5741, offset 0, flags [DF], p=
roto GRE (47), length 1424)
>         192.168.71.177 > 192.168.69.50: GREv0, Flags [key present], key=
=3D0x1090804, length 1404
>         IP (tos 0x0, ttl 64, id 40684, offset 0, flags [+], proto ICMP (1=
), length 1396)
>         192.168.13.1 > 192.168.13.2: ICMP echo request, id 54476, seq 3, =
length 1376
>     22:01:36.207778 IP (tos 0x0, ttl 64, id 5742, offset 0, flags [DF], p=
roto GRE (47), length 56)
>         192.168.71.177 > 192.168.69.50: GREv0, Flags [key present], key=
=3D0x1090804, length 36
>         IP (tos 0x0, ttl 64, id 40684, offset 1376, flags [none], proto I=
CMP (1), length 28)
>         192.168.13.1 > 192.168.13.2: ip-proto-1
>     22:01:37.230751 IP (tos 0x0, ttl 64, id 5785, offset 0, flags [DF], p=
roto GRE (47), length 1424)
>         192.168.71.177 > 192.168.69.50: GREv0, Flags [key present], key=
=3D0x1090804, length 1404
>         IP (tos 0x0, ttl 64, id 41578, offset 0, flags [+], proto ICMP (1=
), length 1396)
>         192.168.13.1 > 192.168.13.2: ICMP echo request, id 54476, seq 4, =
length 1376
>     22:01:37.230758 IP (tos 0x0, ttl 64, id 5786, offset 0, flags [DF], p=
roto GRE (47), length 56)
>         192.168.71.177 > 192.168.69.50: GREv0, Flags [key present], key=
=3D0x1090804, length 36
>         IP (tos 0x0, ttl 64, id 41578, offset 1376, flags [none], proto I=
CMP (1), length 28)
>         192.168.13.1 > 192.168.13.2: ip-proto-1
>     22:01:38.254780 IP (tos 0x0, ttl 64, id 5937, offset 0, flags [DF], p=
roto GRE (47), length 1424)
>         192.168.71.177 > 192.168.69.50: GREv0, Flags [key present], key=
=3D0x1090804, length 1404
>         IP (tos 0x0, ttl 64, id 42099, offset 0, flags [+], proto ICMP (1=
), length 1396)
>         192.168.13.1 > 192.168.13.2: ICMP echo request, id 54476, seq 5, =
length 1376
>     22:01:38.254795 IP (tos 0x0, ttl 64, id 5938, offset 0, flags [DF], p=
roto GRE (47), length 56)
>         192.168.71.177 > 192.168.69.50: GREv0, Flags [key present], key=
=3D0x1090804, length 36
>         IP (tos 0x0, ttl 64, id 42099, offset 1376, flags [none], proto I=
CMP (1), length 28)
>         192.168.13.1 > 192.168.13.2: ip-proto-1
>     22:01:39.278764 IP (tos 0x0, ttl 64, id 6876, offset 0, flags [DF], p=
roto GRE (47), length 1424)
>         192.168.71.177 > 192.168.69.50: GREv0, Flags [key present], key=
=3D0x1090804, length 1404
>         IP (tos 0x0, ttl 64, id 42506, offset 0, flags [+], proto ICMP (1=
), length 1396)
>         192.168.13.1 > 192.168.13.2: ICMP echo request, id 54476, seq 6, =
length 1376
>     22:01:39.278775 IP (tos 0x0, ttl 64, id 6877, offset 0, flags [DF], p=
roto GRE (47), length 56)
>         192.168.71.177 > 192.168.69.50: GREv0, Flags [key present], key=
=3D0x1090804, length 36
>         IP (tos 0x0, ttl 64, id 42506, offset 1376, flags [none], proto I=
CMP (1), length 28)
>         192.168.13.1 > 192.168.13.2: ip-proto-1
>     22:01:40.302749 IP (tos 0x0, ttl 64, id 7410, offset 0, flags [DF], p=
roto GRE (47), length 1424)
>         192.168.71.177 > 192.168.69.50: GREv0, Flags [key present], key=
=3D0x1090804, length 1404
>         IP (tos 0x0, ttl 64, id 42527, offset 0, flags [+], proto ICMP (1=
), length 1396)
>         192.168.13.1 > 192.168.13.2: ICMP echo request, id 54476, seq 7, =
length 1376
>     22:01:40.302757 IP (tos 0x0, ttl 64, id 7411, offset 0, flags [DF], p=
roto GRE (47), length 56)
>         192.168.71.177 > 192.168.69.50: GREv0, Flags [key present], key=
=3D0x1090804, length 36
>         IP (tos 0x0, ttl 64, id 42527, offset 1376, flags [none], proto I=
CMP (1), length 28)
>         192.168.13.1 > 192.168.13.2: ip-proto-1
>     22:01:41.326744 IP (tos 0x0, ttl 64, id 7913, offset 0, flags [DF], p=
roto GRE (47), length 1424)
>         192.168.71.177 > 192.168.69.50: GREv0, Flags [key present], key=
=3D0x1090804, length 1404
>         IP (tos 0x0, ttl 64, id 42989, offset 0, flags [+], proto ICMP (1=
), length 1396)
>         192.168.13.1 > 192.168.13.2: ICMP echo request, id 54476, seq 8, =
length 1376
>     22:01:41.326753 IP (tos 0x0, ttl 64, id 7914, offset 0, flags [DF], p=
roto GRE (47), length 56)
>         192.168.71.177 > 192.168.69.50: GREv0, Flags [key present], key=
=3D0x1090804, length 36
>         IP (tos 0x0, ttl 64, id 42989, offset 1376, flags [none], proto I=
CMP (1), length 28)
>         192.168.13.1 > 192.168.13.2: ip-proto-1
>     22:01:42.350766 IP (tos 0x0, ttl 64, id 8422, offset 0, flags [DF], p=
roto GRE (47), length 1424)
>         192.168.71.177 > 192.168.69.50: GREv0, Flags [key present], key=
=3D0x1090804, length 1404
>         IP (tos 0x0, ttl 64, id 43576, offset 0, flags [+], proto ICMP (1=
), length 1396)
>         192.168.13.1 > 192.168.13.2: ICMP echo request, id 54476, seq 9, =
length 1376
>     22:01:42.350776 IP (tos 0x0, ttl 64, id 8423, offset 0, flags [DF], p=
roto GRE (47), length 56)
>         192.168.71.177 > 192.168.69.50: GREv0, Flags [key present], key=
=3D0x1090804, length 36
>         IP (tos 0x0, ttl 64, id 43576, offset 1376, flags [none], proto I=
CMP (1), length 28)
>         192.168.13.1 > 192.168.13.2: ip-proto-1
>     22:01:43.374756 IP (tos 0x0, ttl 64, id 9410, offset 0, flags [DF], p=
roto GRE (47), length 1424)
>         192.168.71.177 > 192.168.69.50: GREv0, Flags [key present], key=
=3D0x1090804, length 1404
>         IP (tos 0x0, ttl 64, id 44118, offset 0, flags [+], proto ICMP (1=
), length 1396)
>         192.168.13.1 > 192.168.13.2: ICMP echo request, id 54476, seq 10,=
 length 1376
>     22:01:43.374766 IP (tos 0x0, ttl 64, id 9411, offset 0, flags [DF], p=
roto GRE (47), length 56)
>         192.168.71.177 > 192.168.69.50: GREv0, Flags [key present], key=
=3D0x1090804, length 36
>         IP (tos 0x0, ttl 64, id 44118, offset 1376, flags [none], proto I=
CMP (1), length 28)
>         192.168.13.1 > 192.168.13.2: ip-proto-1
>

