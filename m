Return-Path: <netdev+bounces-90898-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84A5B8B0A95
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 15:12:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DF2F28634D
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 13:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E276115B153;
	Wed, 24 Apr 2024 13:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u/dSisTi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608BD15B130
	for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 13:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713964371; cv=none; b=khbJStfbxuA+NQE/ys5x7yTkHrrDYVODPPzl6lRobsgS8XzUdo3xu/9axPZdSqk4AWGg9VEkbDY6D3532ECTSerFA8UluUH3z1mYz0SS5Abb6cMhi5TXAZqlaiGalJqp3XcBKR3GQPYyZxueQU4Y+cTWN42nvL/4JCIeBESrJGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713964371; c=relaxed/simple;
	bh=AH+BD4uZ08mjeaV6KCgf9KXDF+sTNfZe8fcxy+17BB0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eCFaVo7MWnxnAqS3A56tu9/xg+m89PHFq9WV3xswmOAAq/gbNfq4uA1Fr/F4neBAfarkcGi2y3VPF/spBKmtUbg1nQd6cFwbMfcsMlnk1jC4FLvrc4pBUcUtM0f+Jk99NyeA9ZL1KzvDQjC6xsfOpkCQPYwwZZyV/vNwpzN9U00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u/dSisTi; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5722eb4f852so12323a12.0
        for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 06:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713964368; x=1714569168; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9vByAQvRhAoyqBUiPvFD7qKi+2iLRQEgv8X/4n4QlHM=;
        b=u/dSisTiocxJ8AOcV1pehZ+5Elp04wM7QCsISjj2U/vH2Dpo/C25zByeYzvM3/1Co1
         +LlyOj3YBTcbwAvB3600Kz/RdFfP6bVX3xeGVFSYdCwcTk7K27vWqt43uPuJ5nWRHBPp
         AmcxURFv9QyJdSOHNKzEOYhRf2aXpc06Fcc5RKOj6bKlDGFpI+e7hYcpZIijRdNm3Iff
         LcWhvWbOOHlr8T4RqVd2FRVzRysQH5X8X63N1w0i2W+dOHgfEryMEo/q7MFiTF7ek7xE
         8C2zcuv3G2YCz79WCfuFajFWud7SeBCTjp+mimzdOI8Yyp5ZA78kvdiVCT4cMbbAtZKw
         oQYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713964368; x=1714569168;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9vByAQvRhAoyqBUiPvFD7qKi+2iLRQEgv8X/4n4QlHM=;
        b=GecHxfZrD9py4ETSwqMbwvdeiltRwV+LMBS3fmiXNyrhjexrlseCh5FWvFYbU2QWkK
         JEU6UUaqDxUANMgvIHViSb4691XiGOZlTIcO1/VfM5f3hqkIa+dmF5FyWnA08DBg2/b5
         uS2N1ZFNhnWPK6+MsVUxQy2pJL0XamrdCmBS8C9YsX0Hmfb+m3sks75r18p1+biLfAWZ
         uPBkXfPH2srtF9b/dytyWd1gVnXv4nrvGzFEm/7id5Fa27eWYJw0QcGoSWP0o7YkcYDJ
         KBwx1jSZByUrTUY1RiBHP6RZkZCv0vog+eCEJJxAXVwFHDwFcXb7LWpaKrammSBbOqLP
         11uA==
X-Forwarded-Encrypted: i=1; AJvYcCUwvSli1i51p81VWCP+bi8K4LdJdpQxm/ie6/MmpeKG2BTY89Jj7M9CmfLsQSSxFyN8ov8XYMd4NdjzPZnP4rgV6LLqlxmm
X-Gm-Message-State: AOJu0YwzGYXu47XFAGcoVixrKCdl8QGa/0s3C9oAGvo/hV2+ZdTEtzyf
	Z1kAJZucS11kwEnRbvRZefdD5vcPyFDN7Q7kQYsd1Bb75bTR52Kmpu/HVDc+S5ZXBgiNYKkqIn/
	Kl6Vf2EhFj34qJxctDXo847hs7lVE/2ETgsPd
X-Google-Smtp-Source: AGHT+IHN5zlAMjaXjQnUcDlW3ZF/vXnXVRWA14Fqku4qgraF8uT+ToLgO2ox/ZqwHucD2vCHXrvx89DZGPnuUFblbFE=
X-Received: by 2002:aa7:c302:0:b0:571:d9eb:a345 with SMTP id
 l2-20020aa7c302000000b00571d9eba345mr212381edq.4.1713964367472; Wed, 24 Apr
 2024 06:12:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424023549.21862-1-kuniyu@amazon.com>
In-Reply-To: <20240424023549.21862-1-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 24 Apr 2024 15:12:35 +0200
Message-ID: <CANn89iL0VnDLDijvhKW-XT=otqsy2DQp_iCv4ZJu1hGNAbwcZg@mail.gmail.com>
Subject: Re: [PATCH v2 net] nsh: Restore skb->{protocol,data,mac_header} for
 outer header in nsh_gso_segment().
To: Kuniyuki Iwashima <kuniyu@amazon.com>, Dong Chenchen <dongchenchen2@huawei.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Jiri Benc <jbenc@redhat.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	syzbot+42a0dc856239de4de60e@syzkaller.appspotmail.com, 
	syzbot+c298c9f0e46a3c86332b@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 4:36=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> syzbot triggered various splats (see [0] and links) by a crafted GSO
> packet of VIRTIO_NET_HDR_GSO_UDP layering the following protocols:
>
>   ETH_P_8021AD + ETH_P_NSH + ETH_P_IPV6 + IPPROTO_UDP
>
> NSH can encapsulate IPv4, IPv6, Ethernet, NSH, and MPLS.  As the inner
> protocol can be Ethernet, NSH GSO handler, nsh_gso_segment(), calls
> skb_mac_gso_segment() to invoke inner protocol GSO handlers.
>
> nsh_gso_segment() does the following for the original skb before
> calling skb_mac_gso_segment()
>
>   1. reset skb->network_header
>   2. save the original skb->{mac_heaeder,mac_len} in a local variable
>   3. pull the NSH header
>   4. resets skb->mac_header
>   5. set up skb->mac_len and skb->protocol for the inner protocol.
>
> and does the following for the segmented skb
>
>   6. set ntohs(ETH_P_NSH) to skb->protocol
>   7. push the NSH header
>   8. restore skb->mac_header
>   9. set skb->mac_header + mac_len to skb->network_header
>  10. restore skb->mac_len
>
> There are two problems in 6-7 and 8-9.
>
>   (a)
>   After 6 & 7, skb->data points to the NSH header, so the outer header
>   (ETH_P_8021AD in this case) is stripped when skb is sent out of netdev.
>
>   Also, if NSH is encapsulated by NSH + Ethernet (so NSH-Ethernet-NSH),
>   skb_pull() in the first nsh_gso_segment() will make skb->data point
>   to the middle of the outer NSH or Ethernet header because the Ethernet
>   header is not pulled by the second nsh_gso_segment().
>
>   (b)
>   While restoring skb->{mac_header,network_header} in 8 & 9,
>   nsh_gso_segment() does not assume that the data in the linear
>   buffer is shifted.
>
>   However, udp6_ufo_fragment() could shift the data and change
>   skb->mac_header accordingly as demonstrated by syzbot.
>
>   If this happens, even the restored skb->mac_header points to
>   the middle of the outer header.
>
> It seems nsh_gso_segment() has never worked with outer headers so far.
>
> At the end of nsh_gso_segment(), the outer header must be restored for
> the segmented skb, instead of the NSH header.
>
> To do that, let's calculate the outer header position relatively from
> the inner header and set skb->{data,mac_header,protocol} properly.
>
> [0]:
> BUG: KMSAN: uninit-value in ipvlan_process_outbound drivers/net/ipvlan/ip=
vlan_core.c:524 [inline]
> BUG: KMSAN: uninit-value in ipvlan_xmit_mode_l3 drivers/net/ipvlan/ipvlan=
_core.c:602 [inline]
> BUG: KMSAN: uninit-value in ipvlan_queue_xmit+0xf44/0x16b0 drivers/net/ip=
vlan/ipvlan_core.c:668
>  ipvlan_process_outbound drivers/net/ipvlan/ipvlan_core.c:524 [inline]
>  ipvlan_xmit_mode_l3 drivers/net/ipvlan/ipvlan_core.c:602 [inline]
>  ipvlan_queue_xmit+0xf44/0x16b0 drivers/net/ipvlan/ipvlan_core.c:668
>  ipvlan_start_xmit+0x5c/0x1a0 drivers/net/ipvlan/ipvlan_main.c:222
>  __netdev_start_xmit include/linux/netdevice.h:4989 [inline]
>  netdev_start_xmit include/linux/netdevice.h:5003 [inline]
>  xmit_one net/core/dev.c:3547 [inline]
>  dev_hard_start_xmit+0x244/0xa10 net/core/dev.c:3563
>  __dev_queue_xmit+0x33ed/0x51c0 net/core/dev.c:4351
>  dev_queue_xmit include/linux/netdevice.h:3171 [inline]
>  packet_xmit+0x9c/0x6b0 net/packet/af_packet.c:276
>  packet_snd net/packet/af_packet.c:3081 [inline]
>  packet_sendmsg+0x8aef/0x9f10 net/packet/af_packet.c:3113
>  sock_sendmsg_nosec net/socket.c:730 [inline]
>  __sock_sendmsg net/socket.c:745 [inline]
>  __sys_sendto+0x735/0xa10 net/socket.c:2191
>  __do_sys_sendto net/socket.c:2203 [inline]
>  __se_sys_sendto net/socket.c:2199 [inline]
>  __x64_sys_sendto+0x125/0x1c0 net/socket.c:2199
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x63/0x6b
>
> Uninit was created at:
>  slab_post_alloc_hook mm/slub.c:3819 [inline]
>  slab_alloc_node mm/slub.c:3860 [inline]
>  __do_kmalloc_node mm/slub.c:3980 [inline]
>  __kmalloc_node_track_caller+0x705/0x1000 mm/slub.c:4001
>  kmalloc_reserve+0x249/0x4a0 net/core/skbuff.c:582
>  __alloc_skb+0x352/0x790 net/core/skbuff.c:651
>  skb_segment+0x20aa/0x7080 net/core/skbuff.c:4647
>  udp6_ufo_fragment+0xcab/0x1150 net/ipv6/udp_offload.c:109
>  ipv6_gso_segment+0x14be/0x2ca0 net/ipv6/ip6_offload.c:152
>  skb_mac_gso_segment+0x3e8/0x760 net/core/gso.c:53
>  nsh_gso_segment+0x6f4/0xf70 net/nsh/nsh.c:108
>  skb_mac_gso_segment+0x3e8/0x760 net/core/gso.c:53
>  __skb_gso_segment+0x4b0/0x730 net/core/gso.c:124
>  skb_gso_segment include/net/gso.h:83 [inline]
>  validate_xmit_skb+0x107f/0x1930 net/core/dev.c:3628
>  __dev_queue_xmit+0x1f28/0x51c0 net/core/dev.c:4343
>  dev_queue_xmit include/linux/netdevice.h:3171 [inline]
>  packet_xmit+0x9c/0x6b0 net/packet/af_packet.c:276
>  packet_snd net/packet/af_packet.c:3081 [inline]
>  packet_sendmsg+0x8aef/0x9f10 net/packet/af_packet.c:3113
>  sock_sendmsg_nosec net/socket.c:730 [inline]
>  __sock_sendmsg net/socket.c:745 [inline]
>  __sys_sendto+0x735/0xa10 net/socket.c:2191
>  __do_sys_sendto net/socket.c:2203 [inline]
>  __se_sys_sendto net/socket.c:2199 [inline]
>  __x64_sys_sendto+0x125/0x1c0 net/socket.c:2199
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x63/0x6b
>
> CPU: 1 PID: 5101 Comm: syz-executor421 Not tainted 6.8.0-rc5-syzkaller-00=
297-gf2e367d6ad3b #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 01/25/2024
>
> Fixes: c411ed854584 ("nsh: add GSO support")
> Reported-and-tested-by: syzbot+42a0dc856239de4de60e@syzkaller.appspotmail=
.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D42a0dc856239de4de60e
> Reported-and-tested-by: syzbot+c298c9f0e46a3c86332b@syzkaller.appspotmail=
.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Dc298c9f0e46a3c86332b
> Link: https://lore.kernel.org/netdev/20240415222041.18537-1-kuniyu@amazon=
.com/
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
> v2: Fix issue in the NSH side
> v1: https://lore.kernel.org/netdev/20240415222041.18537-1-kuniyu@amazon.c=
om/
> ---
>  net/nsh/nsh.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/net/nsh/nsh.c b/net/nsh/nsh.c
> index f4a38bd6a7e0..bfb7758063f3 100644
> --- a/net/nsh/nsh.c
> +++ b/net/nsh/nsh.c
> @@ -77,13 +77,15 @@ EXPORT_SYMBOL_GPL(nsh_pop);
>  static struct sk_buff *nsh_gso_segment(struct sk_buff *skb,
>                                        netdev_features_t features)
>  {
> +       unsigned int outer_hlen, mac_len, nsh_len;
>         struct sk_buff *segs =3D ERR_PTR(-EINVAL);
>         u16 mac_offset =3D skb->mac_header;
> -       unsigned int nsh_len, mac_len;
> -       __be16 proto;
> +       __be16 outer_proto, proto;
>
>         skb_reset_network_header(skb);
>
> +       outer_proto =3D skb->protocol;
> +       outer_hlen =3D skb_mac_header_len(skb);
>         mac_len =3D skb->mac_len;
>
>         if (unlikely(!pskb_may_pull(skb, NSH_BASE_HDR_LEN)))
> @@ -113,10 +115,10 @@ static struct sk_buff *nsh_gso_segment(struct sk_bu=
ff *skb,
>         }
>
>         for (skb =3D segs; skb; skb =3D skb->next) {
> -               skb->protocol =3D htons(ETH_P_NSH);
> -               __skb_push(skb, nsh_len);
> -               skb->mac_header =3D mac_offset;
> -               skb->network_header =3D skb->mac_header + mac_len;
> +               skb->protocol =3D outer_proto;
> +               __skb_push(skb, nsh_len + outer_hlen);
> +               skb_reset_mac_header(skb);
> +               skb_set_network_header(skb, outer_hlen);
>                 skb->mac_len =3D mac_len;
>         }
>


Lets Cc Dong Chenchen <dongchenchen2@huawei.com>

Prior work here was :

commit c83b49383b595be50647f0c764a48c78b5f3c4f8
Author: Dong Chenchen <dongchenchen2@huawei.com>
Date:   Thu May 11 20:54:40 2023 +0800

    net: nsh: Use correct mac_offset to unwind gso skb in nsh_gso_segment()

