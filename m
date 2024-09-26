Return-Path: <netdev+bounces-129997-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB6A9877FD
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 18:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24412B24651
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 16:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D108714F9EA;
	Thu, 26 Sep 2024 16:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z5+XV4aY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3B513A24D
	for <netdev@vger.kernel.org>; Thu, 26 Sep 2024 16:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727369920; cv=none; b=Ldgr29S22b55Eb0q9YzHhO3rPzgzVqfCSYMqAPujk4OhjkrGTzGn6mWay5KcCEfH4ehOkg256pvjiTWmoS73cLTu22Jeyeja3LbBIfJopxoaKgnBox5z3Gi0SNYERgKeGa+gEGIf34KT+/Y2NpjtGYxZ4ehWVXtJ7LJfvaEqewY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727369920; c=relaxed/simple;
	bh=fVaxTmB4NV1OCXRKB3OMFq8Iq8+ZzilHjMWGLJ0TWn4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=uNL5T8vB7Iuj5tPz4Dvbma2lSm0w16CumhJq9E6187bYCK5QIhySe13MnFlYP3DLa+KQsXPs7eDcUR/8TA2fPd5yIYIL7EWceoMYBwuO4rURanEIAtPzPuGfSwvkJILNybzkXzrd5s6HT1oK/jDPqlTh0Uv8HSl06ELouuSayOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z5+XV4aY; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e25cba4c68eso1842220276.3
        for <netdev@vger.kernel.org>; Thu, 26 Sep 2024 09:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727369918; x=1727974718; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GXlUBHTWY+cVrHWhG3FhnsD2YW3smZYGjUjPKSjnIA8=;
        b=Z5+XV4aYGH833aOiqj3xbpHiCMZBzIH7weEgEhwKNkoV8t8X/1CBxgHdTsh/I8/Lcz
         wnzJJnDh3QsEspQMXDOYGfPD3W5/jvUxOg6QFR3QWp6SeIJgZXgJCAAHymiBb7qD15D7
         MxXzus6Vo/zb7oDf0enN7hDDVo3INy+DirRxaVbPoFySv2WCTQZCP68uLRt+/fi/WJAy
         fHAC7zz28yv7vFb9O+9i+rbhrDhr6f7n2rvDQ4B5mbrwJ1d5h9mXc2BqlCvo/MpdiEGd
         mBlqxqWvpk9bxhk/3jAr4mpt9UR1ZwDfDnvAi4ebBxToa+4N/PUhjH3YEZ/Rocv6iKo3
         uCyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727369918; x=1727974718;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GXlUBHTWY+cVrHWhG3FhnsD2YW3smZYGjUjPKSjnIA8=;
        b=P/M0FwlRKlGkwN3YiFvbHzyQxzlFq4pYGiz/ywmzxbWHOt2gHxZqNK56gFIpvYMBhv
         UmkL+aHdlM094Cag9TwrXhzRE3yFjJmf7MYwGIReWnDcyNYK318GBe8eHPXbaPqaubt4
         H/m6c1+EqT0Yrp+Pf86ms/tmQPLYZ3izV2bNOEDFFs+P/FRJ8N9PF6SZ9XRb2lYEOtTt
         8ESGDt2v1h+pOllxURsBN1Aj6Yim7Oy37YpxuUHyLNMxpXNPhB/g1TYh93ZUWVeTzvPw
         eIuooLafwDI4lwxCxEUsWliMVZ3LFDZ6uB+kTrjsGqwX3uPbGH9d3IysCktZYGGzdczR
         fqEg==
X-Gm-Message-State: AOJu0YyqZuS3gvrMIdny8mkJAfMEGvythVjnY50Vgr84tRaL4B8invqQ
	50DrumSqxHSwm0agwJJi3liSn5Zb43N9NLWEcWIFWcLFeicwNy5KVJl4WmSu/MtIGqNSk/Ja2nj
	VI/J5iganaw==
X-Google-Smtp-Source: AGHT+IGbq5iv88FiXTmyKjeMCkr8Qb1ox0yVZ+YbO4rq4frJkBVuVNmyUu/KU7QLea+MyDFR5L0HdJjYvmAGvQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:f7:ea0b:ac12:11d6])
 (user=edumazet job=sendgmr) by 2002:a5b:a01:0:b0:e02:c06f:1db8 with SMTP id
 3f1490d57ef6-e2604b2b153mr40276.4.1727369917869; Thu, 26 Sep 2024 09:58:37
 -0700 (PDT)
Date: Thu, 26 Sep 2024 16:58:36 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Message-ID: <20240926165836.3797406-1-edumazet@google.com>
Subject: [PATCH net] net: test for not too small csum_start in virtio_net_hdr_to_skb()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Willem de Bruijn <willemb@google.com>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

syzbot was able to trigger this warning [1], after injecting a
malicious packet through af_packet, setting skb->csum_start and thus
the transport header to an incorrect value.

We can at least make sure the transport header is after
the end of the network header (with a estimated minimal size).

[1]
[   67.873027] skb len=3D4096 headroom=3D16 headlen=3D14 tailroom=3D0
mac=3D(-1,-1) mac_len=3D0 net=3D(16,-6) trans=3D10
shinfo(txflags=3D0 nr_frags=3D1 gso(size=3D0 type=3D0 segs=3D0))
csum(0xa start=3D10 offset=3D0 ip_summed=3D3 complete_sw=3D0 valid=3D0 leve=
l=3D0)
hash(0x0 sw=3D0 l4=3D0) proto=3D0x0800 pkttype=3D0 iif=3D0
priority=3D0x0 mark=3D0x0 alloc_cpu=3D10 vlan_all=3D0x0
encapsulation=3D0 inner(proto=3D0x0000, mac=3D0, net=3D0, trans=3D0)
[   67.877172] dev name=3Dveth0_vlan feat=3D0x000061164fdd09e9
[   67.877764] sk family=3D17 type=3D3 proto=3D0
[   67.878279] skb linear:   00000000: 00 00 10 00 00 00 00 00 0f 00 00 00 =
08 00
[   67.879128] skb frag:     00000000: 0e 00 07 00 00 00 28 00 08 80 1c 00 =
04 00 00 02
[   67.879877] skb frag:     00000010: 00 00 00 00 00 00 00 00 00 00 00 00 =
00 00 00 00
[   67.880647] skb frag:     00000020: 00 00 02 00 00 00 08 00 1b 00 00 00 =
00 00 00 00
[   67.881156] skb frag:     00000030: 00 00 00 00 00 00 00 00 00 00 00 00 =
00 00 00 00
[   67.881753] skb frag:     00000040: 00 00 00 00 00 00 00 00 00 00 00 00 =
00 00 00 00
[   67.882173] skb frag:     00000050: 00 00 00 00 00 00 00 00 00 00 00 00 =
00 00 00 00
[   67.882790] skb frag:     00000060: 00 00 00 00 00 00 00 00 00 00 00 00 =
00 00 00 00
[   67.883171] skb frag:     00000070: 00 00 00 00 00 00 00 00 00 00 00 00 =
00 00 00 00
[   67.883733] skb frag:     00000080: 00 00 00 00 00 00 00 00 00 00 00 00 =
00 00 00 00
[   67.884206] skb frag:     00000090: 00 00 00 00 00 00 00 00 00 00 69 70 =
76 6c 61 6e
[   67.884704] skb frag:     000000a0: 31 00 00 00 00 00 00 00 00 00 2b 00 =
00 00 00 00
[   67.885139] skb frag:     000000b0: 00 00 00 00 00 00 00 00 00 00 00 00 =
00 00 00 00
[   67.885677] skb frag:     000000c0: 00 00 00 00 00 00 00 00 00 00 00 00 =
00 00 00 00
[   67.886042] skb frag:     000000d0: 00 00 00 00 00 00 00 00 00 00 00 00 =
00 00 00 00
[   67.886408] skb frag:     000000e0: 00 00 00 00 00 00 00 00 00 00 00 00 =
00 00 00 00
[   67.887020] skb frag:     000000f0: 00 00 00 00 00 00 00 00 00 00 00 00 =
00 00 00 00
[   67.887384] skb frag:     00000100: 00 00
[   67.887878] ------------[ cut here ]------------
[   67.887908] offset (-6) >=3D skb_headlen() (14)
[   67.888445] WARNING: CPU: 10 PID: 2088 at net/core/dev.c:3332 skb_checks=
um_help (net/core/dev.c:3332 (discriminator 2))
[   67.889353] Modules linked in: macsec macvtap macvlan hsr wireguard curv=
e25519_x86_64 libcurve25519_generic libchacha20poly1305 chacha_x86_64 libch=
acha poly1305_x86_64 dummy bridge sr_mod cdrom evdev pcspkr i2c_piix4 9pnet=
_virtio 9p 9pnet netfs
[   67.890111] CPU: 10 UID: 0 PID: 2088 Comm: b363492833 Not tainted 6.11.0=
-virtme #1011
[   67.890183] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.16.3-debian-1.16.3-2 04/01/2014
[   67.890309] RIP: 0010:skb_checksum_help (net/core/dev.c:3332 (discrimina=
tor 2))
[   67.891043] Call Trace:
[   67.891173]  <TASK>
[   67.891274] ? __warn (kernel/panic.c:741)
[   67.891320] ? skb_checksum_help (net/core/dev.c:3332 (discriminator 2))
[   67.891333] ? report_bug (lib/bug.c:180 lib/bug.c:219)
[   67.891348] ? handle_bug (arch/x86/kernel/traps.c:239)
[   67.891363] ? exc_invalid_op (arch/x86/kernel/traps.c:260 (discriminator=
 1))
[   67.891372] ? asm_exc_invalid_op (./arch/x86/include/asm/idtentry.h:621)
[   67.891388] ? skb_checksum_help (net/core/dev.c:3332 (discriminator 2))
[   67.891399] ? skb_checksum_help (net/core/dev.c:3332 (discriminator 2))
[   67.891416] ip_do_fragment (net/ipv4/ip_output.c:777 (discriminator 1))
[   67.891448] ? __ip_local_out (./include/linux/skbuff.h:1146 ./include/ne=
t/l3mdev.h:196 ./include/net/l3mdev.h:213 net/ipv4/ip_output.c:113)
[   67.891459] ? __pfx_ip_finish_output2 (net/ipv4/ip_output.c:200)
[   67.891470] ? ip_route_output_flow (./arch/x86/include/asm/preempt.h:84 =
(discriminator 13) ./include/linux/rcupdate.h:96 (discriminator 13) ./inclu=
de/linux/rcupdate.h:871 (discriminator 13) net/ipv4/route.c:2625 (discrimin=
ator 13) ./include/net/route.h:141 (discriminator 13) net/ipv4/route.c:2852=
 (discriminator 13))
[   67.891484] ipvlan_process_v4_outbound (drivers/net/ipvlan/ipvlan_core.c=
:445 (discriminator 1))
[   67.891581] ipvlan_queue_xmit (drivers/net/ipvlan/ipvlan_core.c:542 driv=
ers/net/ipvlan/ipvlan_core.c:604 drivers/net/ipvlan/ipvlan_core.c:670)
[   67.891596] ipvlan_start_xmit (drivers/net/ipvlan/ipvlan_main.c:227)
[   67.891607] dev_hard_start_xmit (./include/linux/netdevice.h:4916 ./incl=
ude/linux/netdevice.h:4925 net/core/dev.c:3588 net/core/dev.c:3604)
[   67.891620] __dev_queue_xmit (net/core/dev.h:168 (discriminator 25) net/=
core/dev.c:4425 (discriminator 25))
[   67.891630] ? skb_copy_bits (./include/linux/uaccess.h:233 (discriminato=
r 1) ./include/linux/uaccess.h:260 (discriminator 1) ./include/linux/highme=
m-internal.h:230 (discriminator 1) net/core/skbuff.c:3018 (discriminator 1)=
)
[   67.891645] ? __pskb_pull_tail (net/core/skbuff.c:2848 (discriminator 4)=
)
[   67.891655] ? skb_partial_csum_set (net/core/skbuff.c:5657)
[   67.891666] ? virtio_net_hdr_to_skb.constprop.0 (./include/linux/skbuff.=
h:2791 (discriminator 3) ./include/linux/skbuff.h:2799 (discriminator 3) ./=
include/linux/virtio_net.h:109 (discriminator 3))
[   67.891684] packet_sendmsg (net/packet/af_packet.c:3145 (discriminator 1=
) net/packet/af_packet.c:3177 (discriminator 1))
[   67.891700] ? _raw_spin_lock_bh (./arch/x86/include/asm/atomic.h:107 (di=
scriminator 4) ./include/linux/atomic/atomic-arch-fallback.h:2170 (discrimi=
nator 4) ./include/linux/atomic/atomic-instrumented.h:1302 (discriminator 4=
) ./include/asm-generic/qspinlock.h:111 (discriminator 4) ./include/linux/s=
pinlock.h:187 (discriminator 4) ./include/linux/spinlock_api_smp.h:127 (dis=
criminator 4) kernel/locking/spinlock.c:178 (discriminator 4))
[   67.891716] __sys_sendto (net/socket.c:730 (discriminator 1) net/socket.=
c:745 (discriminator 1) net/socket.c:2210 (discriminator 1))
[   67.891734] ? do_sock_setsockopt (net/socket.c:2335)
[   67.891747] ? __sys_setsockopt (./include/linux/file.h:34 net/socket.c:2=
355)
[   67.891761] __x64_sys_sendto (net/socket.c:2222 (discriminator 1) net/so=
cket.c:2218 (discriminator 1) net/socket.c:2218 (discriminator 1))
[   67.891772] do_syscall_64 (arch/x86/entry/common.c:52 (discriminator 1) =
arch/x86/entry/common.c:83 (discriminator 1))
[   67.891785] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:13=
0)

Fixes: 9181d6f8a2bb ("net: add more sanity check in virtio_net_hdr_to_skb()=
")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/virtio_net.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
index 276ca543ef44d862d095243073da4fdad88bb889..02a9f4dc594d02372a6c1850cd6=
00eff9d000d8d 100644
--- a/include/linux/virtio_net.h
+++ b/include/linux/virtio_net.h
@@ -103,8 +103,10 @@ static inline int virtio_net_hdr_to_skb(struct sk_buff=
 *skb,
=20
 		if (!skb_partial_csum_set(skb, start, off))
 			return -EINVAL;
+		if (skb_transport_offset(skb) < nh_min_len)
+			return -EINVAL;
=20
-		nh_min_len =3D max_t(u32, nh_min_len, skb_transport_offset(skb));
+		nh_min_len =3D skb_transport_offset(skb);
 		p_off =3D nh_min_len + thlen;
 		if (!pskb_may_pull(skb, p_off))
 			return -EINVAL;
--=20
2.46.1.824.gd892dcdcdd-goog


