Return-Path: <netdev+bounces-115111-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 583C8945328
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 21:14:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A91A4B237DD
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 19:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F40914A0AB;
	Thu,  1 Aug 2024 19:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z06/jntR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91AE114A0A3
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 19:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722539671; cv=none; b=UtGw59wrl8mPaSSrYamzRQ6K1QUiOZxyWVW2AwxU3nmLr24Xg0f1fpnI2DSYAuaNozqj/BbV8I6ZQF9Nw+fkQ+uJPUv+BAQBmXHL9cAF5QDEcgK/obNTXsf3nwxkbzCyRZ4W2vYYhuhA2T8NDizw6NMUUQe3D/mcR6E32z1DU7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722539671; c=relaxed/simple;
	bh=LO7YLV4jD7NJmmBvyb88qQM27tc0HkxP74MqQ38IT4Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gDiN02CWy7JaH/tG9wRriwP3ooGGMdrlDcseExIynGMHdZsDZYNZc0xqR19dcIMMNWPx6VSNXt2xMPAtEC2+78/Xg3Cbb780enBNRf+hn+NobN2CsqsISmKa/qsFAisFqZ6vhDijrrDUA9gQ2ECF50O2u5mssZQ/yejpwUGZzW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z06/jntR; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e0875f1e9edso5508306276.1
        for <netdev@vger.kernel.org>; Thu, 01 Aug 2024 12:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722539668; x=1723144468; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dmz6bLpOZ7W2fV9BbxB0qLCoBVySX7iAGWKS7t034iA=;
        b=Z06/jntRTCBrmmNtbTpHVkQYbvcqYLDrcu9umlIUdMdEtPZ6khAkZ+ZSdGso4gwdfX
         vC6Fp1JpriJtRRL4noe6h5IVdzSsFlrST5kV4/Yy8ETiXGEsX8LCljqE/Qljl9jyJaMw
         i1hHxhl7NQTV+RwgP1ywr5810jBEGBkQyEkC+fjQu+Si64NnJixuhMvnmzzQ0DqW+eX0
         BfW74UetURxAetTr27cnVGu5F2b7CDRhU9nJQp5u05l0LR7WK8OgDuqPWGVTY87YMVWu
         jDxvylZAVFqUS04Uq566lXCiYfyEbuTo4RxehKQpssn4iUOs+KTCy5DkeeHa2g620YSK
         Yu1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722539668; x=1723144468;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dmz6bLpOZ7W2fV9BbxB0qLCoBVySX7iAGWKS7t034iA=;
        b=Pu3YNAW9ektOfXPZsvgduUntpkt+1lcBFFwbtYFyNOgZA3p7MftcLr+R0VQYg2HEpQ
         Z9dYsK5uCJr2MpeaJAfBl+szpy8tl9sNSHBEqa6ucjYmycJeYQNuswkc2dX9ze7mONGR
         jXPkCcI33ehdcNGLk+N09oEoSBoeT4Mns0hOmVINhySIhdo5d9dc7UbIgWVZFl34QVVI
         twGlvi5WFkQX843IdkQObFProhcomm/LU9aMOt9D/B58AZ3r8AG/cnJLXXqYHSP71ajW
         Do85S5fUDEQq+9AIvMjizrDStJYrLv/LiKyGaDLe/gIFy/n0WA+FMqVzNFiuyAHqSb2u
         hgLA==
X-Gm-Message-State: AOJu0YxhNaJeXzaSBCxsL4YPxKziNWqAIy0YCbamF6+NMmKT4yoV3Xxs
	vDep9/OdzqXjzEiY1OkVUllS8o9UgFCg2UX+uXS9v+4xPcB1s0wJsHZu0+B4DXLa9KFSVi1+jN7
	3aWs3Bwx86ZkW1UzEnWgEjynGewg=
X-Google-Smtp-Source: AGHT+IE1YIKUQJDP6+mH1nMyf8hwRuHJRJtnk9SBmHM9J/otYju8XfQurVWcYBbaMS0S1radKFgKcMAJD3mf3tzq1BQ=
X-Received: by 2002:a05:6902:2b0f:b0:e0b:d018:c4d0 with SMTP id
 3f1490d57ef6-e0bde2f1864mr1454398276.17.1722539668294; Thu, 01 Aug 2024
 12:14:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240801-udp-gso-egress-from-tunnel-v2-0-9a2af2f15d8d@cloudflare.com>
 <20240801-udp-gso-egress-from-tunnel-v2-1-9a2af2f15d8d@cloudflare.com>
In-Reply-To: <20240801-udp-gso-egress-from-tunnel-v2-1-9a2af2f15d8d@cloudflare.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Thu, 1 Aug 2024 15:13:51 -0400
Message-ID: <CAF=yD-JaeHASZacOPk=k2gzpfY7OzMwDPr99FMfthMS0w9S7bA@mail.gmail.com>
Subject: Re: [PATCH net v2 1/2] gso: Skip bad offload detection when device
 supports requested GSO
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, kernel-team@cloudflare.com, 
	syzbot+e15b7e15b8a751a91d9a@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 1, 2024 at 10:09=E2=80=AFAM Jakub Sitnicki <jakub@cloudflare.co=
m> wrote:
>
> In commit 10154dbded6d ("udp: Allow GSO transmit from devices with no
> checksum offload") we have intentionally allowed UDP GSO packets marked
> CHECKSUM_NONE to pass to the GSO stack, so that they can be segmented and
> checksummed by a software fallback when the egress device lacks these
> features.
>
> What was not taken into consideration is that a CHECKSUM_NONE skb can be
> handed over to the GSO stack also when the egress device advertises the
> tx-udp-segmentation / NETIF_F_GSO_UDP_L4 feature.
>
> This can happen in two situations, which we detect in __ip_append_data()
> and __ip6_append_data():
>
> 1) when there are IPv6 extension headers present, or
> 2) when the tunnel device does not advertise checksum offload.
>
> Note that in the latter case we have a nonsensical device configuration.
> Device support for UDP segmentation offload requires checksum offload in
> hardware as well.
>
> Syzbot has discovered the first case, producing a warning as below:
>
>   ip6tnl0: caps=3D(0x00000006401d7869, 0x00000006401d7869)
>   WARNING: CPU: 0 PID: 5112 at net/core/dev.c:3293 skb_warn_bad_offload+0=
x166/0x1a0 net/core/dev.c:3291
>   Modules linked in:
>   CPU: 0 PID: 5112 Comm: syz-executor391 Not tainted 6.10.0-rc7-syzkaller=
-01603-g80ab5445da62 #0
>   Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS=
 Google 06/07/2024
>   RIP: 0010:skb_warn_bad_offload+0x166/0x1a0 net/core/dev.c:3291
>   [...]
>   Call Trace:
>    <TASK>
>    __skb_gso_segment+0x3be/0x4c0 net/core/gso.c:127
>    skb_gso_segment include/net/gso.h:83 [inline]
>    validate_xmit_skb+0x585/0x1120 net/core/dev.c:3661
>    __dev_queue_xmit+0x17a4/0x3e90 net/core/dev.c:4415
>    neigh_output include/net/neighbour.h:542 [inline]
>    ip6_finish_output2+0xffa/0x1680 net/ipv6/ip6_output.c:137
>    ip6_finish_output+0x41e/0x810 net/ipv6/ip6_output.c:222
>    ip6_send_skb+0x112/0x230 net/ipv6/ip6_output.c:1958
>    udp_v6_send_skb+0xbf5/0x1870 net/ipv6/udp.c:1292
>    udpv6_sendmsg+0x23b3/0x3270 net/ipv6/udp.c:1588
>    sock_sendmsg_nosec net/socket.c:730 [inline]
>    __sock_sendmsg+0xef/0x270 net/socket.c:745
>    ____sys_sendmsg+0x525/0x7d0 net/socket.c:2585
>    ___sys_sendmsg net/socket.c:2639 [inline]
>    __sys_sendmmsg+0x3b2/0x740 net/socket.c:2725
>    __do_sys_sendmmsg net/socket.c:2754 [inline]
>    __se_sys_sendmmsg net/socket.c:2751 [inline]
>    __x64_sys_sendmmsg+0xa0/0xb0 net/socket.c:2751
>    do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>    do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>    entry_SYSCALL_64_after_hwframe+0x77/0x7f
>    [...]
>    </TASK>
>
> We are hitting the bad offload warning because when an egress device is
> capable of handling segmentation offload requested by
> skb_shinfo(skb)->gso_type, the chain of gso_segment callbacks won't produ=
ce
> any segment skbs and return NULL. See the skb_gso_ok() branch in
> {__udp,tcp,sctp}_gso_segment helpers.
>
> To fix it, skip bad offload detection when gso_segment has returned
> nothing. We know that in such case the egress device supports the desired
> GSO offload, which implies that it can fill in L4 checksums. Hence we don=
't
> need to check the skb->ip_summed value, which reflects the egress device
> checksum capabilities.
>
> Fixes: 10154dbded6d ("udp: Allow GSO transmit from devices with no checks=
um offload")
> Reported-by: syzbot+e15b7e15b8a751a91d9a@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/000000000000e1609a061d5330ce@google.c=
om/
> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

It's a bit odd, in that the ip_summed =3D=3D CHECKSUM_NONE ends up just
being ignored and devices are trusted to always be able to checksum
offload when they can segment offload -- even when the device does not
advertise checksum offload.

I think we should have a follow-on that makes advertising
NETIF_F_GSO_UDP_L4 dependent on having at least one of the
NETIF_F_*_CSUM bits set (handwaving over what happens when only
advertising NETIF_F_IP_CSUM or NETIF_F_IPV6_CSUM).

