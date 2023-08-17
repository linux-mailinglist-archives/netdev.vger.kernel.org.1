Return-Path: <netdev+bounces-28323-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE0B077F0C4
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 08:56:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99FA61C212C0
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 06:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30041137D;
	Thu, 17 Aug 2023 06:55:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D9CA5B
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 06:55:57 +0000 (UTC)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D4E1FF3
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 23:55:54 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R751e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0Vpyy4cV_1692255349;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0Vpyy4cV_1692255349)
          by smtp.aliyun-inc.com;
          Thu, 17 Aug 2023 14:55:50 +0800
Message-ID: <1692254912.6879-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net] net: do not allow gso_size to be set to GSO_BY_FRAGS
Date: Thu, 17 Aug 2023 14:48:32 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org,
 eric.dumazet@gmail.com,
 syzbot <syzkaller@googlegroups.com>,
 Xin Long <lucien.xin@gmail.com>,
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
 Willem de Bruijn <willemb@google.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 "David S . Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
References: <20230816142158.1779798-1-edumazet@google.com>
 <1692238784.742549-1-xuanzhuo@linux.alibaba.com>
 <CANn89iLNH2_kL8SeAdr84Am9nW4tgk0XQC37mEWkaCf8n6hf7w@mail.gmail.com>
In-Reply-To: <CANn89iLNH2_kL8SeAdr84Am9nW4tgk0XQC37mEWkaCf8n6hf7w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Thu, 17 Aug 2023 08:17:55 +0200, Eric Dumazet <edumazet@google.com> wrot=
e:
> On Thu, Aug 17, 2023 at 4:27=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibaba=
.com> wrote:
> >
> > On Wed, 16 Aug 2023 14:21:58 +0000, Eric Dumazet <edumazet@google.com> =
wrote:
> > > One missing check in virtio_net_hdr_to_skb() allowed
> > > syzbot to crash kernels again [1]
> > >
> > > Do not allow gso_size to be set to GSO_BY_FRAGS (0xffff),
> > > because this magic value is used by the kernel.
> > >
> > > [1]
> > > general protection fault, probably for non-canonical address 0xdffffc=
000000000e: 0000 [#1] PREEMPT SMP KASAN
> > > KASAN: null-ptr-deref in range [0x0000000000000070-0x0000000000000077]
> > > CPU: 0 PID: 5039 Comm: syz-executor401 Not tainted 6.5.0-rc5-next-202=
30809-syzkaller #0
> > > Hardware name: Google Google Compute Engine/Google Compute Engine, BI=
OS Google 07/26/2023
> > > RIP: 0010:skb_segment+0x1a52/0x3ef0 net/core/skbuff.c:4500
> > > Code: 00 00 00 e9 ab eb ff ff e8 6b 96 5d f9 48 8b 84 24 00 01 00 00 =
48 8d 78 70 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <0f> b6 04 0=
2 84 c0 74 08 3c 03 0f 8e ea 21 00 00 48 8b 84 24 00 01
> > > RSP: 0018:ffffc90003d3f1c8 EFLAGS: 00010202
> > > RAX: dffffc0000000000 RBX: 000000000001fffe RCX: 0000000000000000
> > > RDX: 000000000000000e RSI: ffffffff882a3115 RDI: 0000000000000070
> > > RBP: ffffc90003d3f378 R08: 0000000000000005 R09: 000000000000ffff
> > > R10: 000000000000ffff R11: 5ee4a93e456187d6 R12: 000000000001ffc6
> > > R13: dffffc0000000000 R14: 0000000000000008 R15: 000000000000ffff
> > > FS: 00005555563f2380(0000) GS:ffff8880b9800000(0000) knlGS:0000000000=
000000
> > > CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > CR2: 0000000020020000 CR3: 000000001626d000 CR4: 00000000003506f0
> > > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > Call Trace:
> > > <TASK>
> > > udp6_ufo_fragment+0x9d2/0xd50 net/ipv6/udp_offload.c:109
> > > ipv6_gso_segment+0x5c4/0x17b0 net/ipv6/ip6_offload.c:120
> > > skb_mac_gso_segment+0x292/0x610 net/core/gso.c:53
> > > __skb_gso_segment+0x339/0x710 net/core/gso.c:124
> > > skb_gso_segment include/net/gso.h:83 [inline]
> > > validate_xmit_skb+0x3a5/0xf10 net/core/dev.c:3625
> > > __dev_queue_xmit+0x8f0/0x3d60 net/core/dev.c:4329
> > > dev_queue_xmit include/linux/netdevice.h:3082 [inline]
> > > packet_xmit+0x257/0x380 net/packet/af_packet.c:276
> > > packet_snd net/packet/af_packet.c:3087 [inline]
> > > packet_sendmsg+0x24c7/0x5570 net/packet/af_packet.c:3119
> > > sock_sendmsg_nosec net/socket.c:727 [inline]
> > > sock_sendmsg+0xd9/0x180 net/socket.c:750
> > > ____sys_sendmsg+0x6ac/0x940 net/socket.c:2496
> > > ___sys_sendmsg+0x135/0x1d0 net/socket.c:2550
> > > __sys_sendmsg+0x117/0x1e0 net/socket.c:2579
> > > do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> > > do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
> > > entry_SYSCALL_64_after_hwframe+0x63/0xcd
> > > RIP: 0033:0x7ff27cdb34d9
> > >
> > > Fixes: 3953c46c3ac7 ("sk_buff: allow segmenting based on frag sizes")
> > > Reported-by: syzbot <syzkaller@googlegroups.com>
> > > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > > Cc: Xin Long <lucien.xin@gmail.com>
> > > Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
> > > Cc: Willem de Bruijn <willemb@google.com>
> > > Cc: "Michael S. Tsirkin" <mst@redhat.com>
> > > Cc: Jason Wang <jasowang@redhat.com>
> > > Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > ---
> > >  include/linux/virtio_net.h | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > >
> > > diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> > > index bdf8de2cdd935d31449b78e1b9c67fdcdc537bf2..7b4dd69555e497497460d=
cf5d72737fe5c09fd53 100644
> > > --- a/include/linux/virtio_net.h
> > > +++ b/include/linux/virtio_net.h
> > > @@ -155,6 +155,10 @@ static inline int virtio_net_hdr_to_skb(struct s=
k_buff *skb,
> > >               if (gso_type & SKB_GSO_UDP)
> > >                       nh_off -=3D thlen;
> > >
> > > +             /* Kernel has a special handling for GSO_BY_FRAGS. */
> > > +             if (gso_size =3D=3D GSO_BY_FRAGS)
> > > +                     return -EINVAL;
> > > +
> >
> >
> > I guess the crash happens when user sends packets via af_packet and gso=
 is set
> > to GSO_BY_FRAGS by user.
> >
> > But I wonder is 0xffff also an invalid value on the rx path?
> >
> > We know that this function virtio_net_hdr_to_skb is also used by the vi=
rtio-net
> > driver on the rx path. This change means that virtio-net devices should=
 not set
> > gso to 0xffff. But the virtio spec doesn't say that the rx gso value 0x=
ffff is
> > invalid.
> >
> > So I think we should not add check in this function.
>
>
> I think we do.
>
> Think about it, how gso_size =3D=3D 0xffff , or even 0xfff0 could be vali=
d ?
>
> We are not going to add more core in core network fast path, for
> something that can not happen with kernel stacks.
>
> It is time someone clarifies virtio_specs, because 0xffff is
> absolutely a no go, even before blamed commit.


So do you mean there are some limitations for the max value of gso_size?

But the merge mode of the virtio-net can receive big packets.

So what is the limitations?

Thanks.

