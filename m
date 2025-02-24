Return-Path: <netdev+bounces-169191-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B2C8EA42EBF
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 22:13:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 530D17A5983
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 21:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1668E19E971;
	Mon, 24 Feb 2025 21:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n0x0Q5d1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCA7198822
	for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 21:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740431606; cv=none; b=bqlGrpHHcNRIk6p8mNZiRfYYSQX6vKs8JYxhxoDFfujKYbpj6Q682F1PHlwZnP5H+V9mkWDk9H5IRIqGV9OozrppLgeEPJJOZnhC/vSsaXQwzvAuZtvF8XUY0J0/NxCS8YOmsaWIpg+CFN/8yrLgTR6uFfdRUTWMwg9my3oRfXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740431606; c=relaxed/simple;
	bh=yIkyN74xT9n2NC/XATEXj+NKgxtiIEYT8qxKAPXv4U4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lrS7YqxzOjusD2PvbnuUTO2W7f8vnrRzjIsmjV/kb3Ag8XyaTUOC28mLxabOrDmxdii+fLkOtjURoinn+oBpkWprGn33dVbKebGyQ40wYqhSpiw85KhRPRv0lw8e1hX7RnJ8lBjtwJh3h9foEs//9I0xHId2WKwf5X0IjrfTPOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n0x0Q5d1; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-471fa3b19bcso61541cf.0
        for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 13:13:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740431602; x=1741036402; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n5XyGiIfOeLYx8PLIwoJeWXAVj+0Asi1hss3HqOkiz4=;
        b=n0x0Q5d1b+XoIQj4NNM2G07Wi+pgRP8QGAIC2qWDp20OT3H28MTI5h86Uo9yJWzDB5
         oFWVwJrwPfFUWDVzV5LC0sGHeOBbkHlW7xMMFt+mLXcxMUWA8Whkslb93In95C5uie0o
         PsrRIMsV6/UiBw59ecOrETzt/x721MYKOhEjjRSqT/8d3E4ot8AeB241IrftsddI7gJQ
         /Bv0uTmNEGzlnqzTJjU5mZ/9Guzg1ScEu17/D7/5Z8zho3nQ1zBMhle9hri6bbJoLNCK
         lQkqmLSoGF9G4MTpQ9b61kKU5W8AMSRQJj2lYXZwpk5GZp2ISPSDscpBt867IC1nKsIL
         TMHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740431602; x=1741036402;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n5XyGiIfOeLYx8PLIwoJeWXAVj+0Asi1hss3HqOkiz4=;
        b=LwFCETogch7QWGUfum0UHvN/CvPZ0VxADlmCKrv7in/2egyM1VzNoFPya+GgnNneMQ
         BjLQ7k7kKA4dkeozBf8HDDtHgPFDF6Q40eJMWerpRdX2ZQdEk/tPOyFvyg3xLeZNxeF8
         GstNgcw3aIEVTPIVIBSSzcy4Wjf2p1hvS+pWWKxR2YD/dXl+c6OltGynSm48OzT9126R
         a/IJaU9yrm6rK6JdytXjeOdub1DszN3Gm+1tXnGMiUm/FY8z66IIHxMV39/cUMc/R9qw
         mlBwhIT1a6cuypetQZczJZNSwVtL8xJKW9s+eS7FWc3a0AQPfEKlGjce73thnrunMAia
         fXnA==
X-Forwarded-Encrypted: i=1; AJvYcCW1vdSa9cb3zAkTFEhImMAh+yv5G1TFrUB/DFa/KNbqlEXdE6kX9tPraDKQEkywkvjw7q7KRW0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKuSzIwTDBKOBUGkzMoqtdy6StihKjeV0MVY1gGJMBIxbQYlZx
	LrL06Roua7GlYk5O//zkg5etdWRzwrASLNbtp/J+zug7bdM3ysD4i5Miu3h1GVTYcBvyjRFk+lZ
	2ZmFHr698tm/QwjwscktfcYwq0yOohPpeZwGB
X-Gm-Gg: ASbGnctRps9eRe1AUCCs9RwOpNCNNh8fTB+41bJtciNpYAurcd7zUgiUeOKC1o0ABJo
	6duqogVxJZZgj8h/N76oPGsS15VfipD1P3x5hpLa6RcdWZmkY1FyB54mye0PAzoeZ3D2cJflqhW
	vwRrdDGcR7AymDU+iGYz7kX2BNNVTfXpFkX2PpOq33
X-Google-Smtp-Source: AGHT+IEUGBW4TzWKX0MuH339KSwRL0HpQc7QQy0byfwdBJ0sawsjMqr16k0OXwmViLAGTJFgRWw9c7vkpl+q4NjvNCs=
X-Received: by 2002:a05:622a:314:b0:46c:77a0:7714 with SMTP id
 d75a77b69052e-47376fcaed9mr1267281cf.21.1740431601948; Mon, 24 Feb 2025
 13:13:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADVnQynUspJL4e3UnZTKps9WmgnE-0ngQnQmn=8gjSmyg4fQ5A@mail.gmail.com>
 <20241203181839.7d0ed41c@kernel.org> <Z0/O1ivIwiVVNRf0@perf>
 <CANn89iKms_9EX+wArf1FK7Cy3-Cr_ryX+MJ2YC8yt1xmvpY=Uw@mail.gmail.com>
 <009e01db4620$f08f42e0$d1adc8a0$@samsung.com> <CADVnQykPo35mQ1y16WD3zppENCeOi+2Ea_2m-AjUQVPc9SXm4g@mail.gmail.com>
 <Z4nl0h1IZ5R/KDEc@perf> <CADVnQykZYT+CTWD3Ss46aGHPp5KtKMYqKjLxEmd5DDgdG3gfDA@mail.gmail.com>
 <CGME20250120001504epcas2p1d766c193256b4b7f79d19f61d76d697d@epcas2p1.samsung.com>
 <Z42WaFf9+oNkoBKJ@perf> <Z6BSXCRw/9Ne1eO1@perf>
In-Reply-To: <Z6BSXCRw/9Ne1eO1@perf>
From: Neal Cardwell <ncardwell@google.com>
Date: Mon, 24 Feb 2025 16:13:05 -0500
X-Gm-Features: AQ5f1JrZQk5g8Ex2DpkHmfBhTAi2a9StkK9lijpuDq_eb6CpDsyXv9pSH8oS38U
Message-ID: <CADVnQykpHsN1rPJobKVfFGwtAJ9qwPrwG21HiunHqfykxyPD1g@mail.gmail.com>
Subject: Re: [PATCH] tcp: check socket state before calling WARN_ON
To: Youngmin Nam <youngmin.nam@samsung.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net, 
	dsahern@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	guo88.liu@samsung.com, yiwang.cai@samsung.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, joonki.min@samsung.com, hajun.sung@samsung.com, 
	d7271.choe@samsung.com, sw.ju@samsung.com, 
	"Dujeong.lee" <dujeong.lee@samsung.com>, Yuchung Cheng <ycheng@google.com>, Kevin Yang <yyd@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 3, 2025 at 12:17=E2=80=AFAM Youngmin Nam <youngmin.nam@samsung.=
com> wrote:
>
> > Hi Neal,
> > Thank you for looking into this issue.
> > When we first encountered this issue, we also suspected that tcp_write_=
queue_purge() was being called.
> > We can provide any information you would like to inspect.

Thanks again for raising this issue, and providing all that data!

I've come up with a reproducer for this issue, and an explanation for
why this has only been seen on Android so far, and a theory about a
related socket leak issue, and a proposed fix for the WARN and the
socket leak.

Here is the scenario:

+ user process A has a socket in TCP_ESTABLISHED

+ user process A calls close(fd)

+ socket calls __tcp_close() and tcp_close_state() decides to enter
TCP_FIN_WAIT1 and send a FIN

+ FIN is lost and retransmitted, making the state:
---
 tp->packets_out =3D 1
 tp->sacked_out =3D 0
 tp->lost_out =3D 1
 tp->retrans_out =3D 1
---

+ someone invokes "ss" to --kill the socket using the functionality in
(1e64e298b8 "net: diag: Support destroying TCP sockets")

  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3Dc1e64e298b8cad309091b95d8436a0255c84f54a

 (note: this was added for Android, so would not be surprising to have
this inet_diag --kill run on Android)

+ the ss --kill causes a call to tcp_abort()

+ tcp_abort() calls tcp_write_queue_purge()

+ tcp_write_queue_purge() sets packets_out=3D0 but leaves lost_out=3D1,
retrans_out=3D1

+ tcp_sock still exists in TCP_FIN_WAIT1 but now with an inconsistent state

+ ACK arrives and causes a WARN_ON from tcp_verify_left_out():

#define tcp_verify_left_out(tp) WARN_ON(tcp_left_out(tp) > tp->packets_out)

because the state has:

 ---
 tcp_left_out(tp) =3D sacked_out + lost_out =3D 1
  tp->packets_out =3D 0
---

because the state is:

---
 tp->packets_out =3D 0
 tp->sacked_out =3D 0
 tp->lost_out =3D 1
 tp->retrans_out =3D 1
---

I guess perhaps one fix would be to just have tcp_write_queue_purge()
zero out those other fields:

---
 tp->sacked_out =3D 0
 tp->lost_out =3D 0
 tp->retrans_out =3D 0
---

However, there is a related and worse problem. Because this killed
socket has tp->packets_out, the next time the RTO timer fires,
tcp_retransmit_timer() notices !tp->packets_out is true, so it short
circuits and returns without setting another RTO timer or checking to
see if the socket should be deleted. So the tcp_sock is now sitting in
memory with no timer set to delete it. So we could leak a socket this
way. So AFAICT to fix this socket leak problem, perhaps we want a
patch like the following (not tested yet), so that we delete all
killed sockets immediately, whether they are SOCK_DEAD (orphans for
which the user already called close() or not) :

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 28cf19317b6c2..a266078b8ec8c 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -5563,15 +5563,12 @@ int tcp_abort(struct sock *sk, int err)
        local_bh_disable();
        bh_lock_sock(sk);

-       if (!sock_flag(sk, SOCK_DEAD)) {
-               if (tcp_need_reset(sk->sk_state))
-                       tcp_send_active_reset(sk, GFP_ATOMIC);
-               tcp_done_with_error(sk, err);
-       }
+       if (tcp_need_reset(sk->sk_state))
+               tcp_send_active_reset(sk, GFP_ATOMIC);
+       tcp_done_with_error(sk, err);

        bh_unlock_sock(sk);
        local_bh_enable();
-       tcp_write_queue_purge(sk);
        release_sock(sk);
        return 0;
 }
---

Here is a packetdrill script that reproduces a scenario similar to that:

---  gtests/net/tcp/inet_diag/inet-diag-fin-wait-1-retrans-kill.pkt
// Test SOCK_DESTROY on TCP_FIN_WAIT1 sockets
// We use the "ss" socket statistics tool, which uses inet_diag sockets.

// ss -K can be slow
--tolerance_usecs=3D15000

// Set up config.
`../common/defaults.sh`

    0 socket(..., SOCK_STREAM, IPPROTO_TCP) =3D 3
   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) =3D 0
   +0 fcntl(3, F_SETFL, O_RDWR|O_NONBLOCK) =3D 0
   +0 bind(3, ..., ...) =3D 0
   +0 listen(3, 1) =3D 0

   +0 < S 0:0(0) win 32792 <mss 1000,sackOK,nop,nop,nop,wscale 2>
   +0 > S. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
  +.1 < . 1:1(0) ack 1 win 32890

   +0 accept(3, ..., ...) =3D 4

// Send 4 data segments.
   +0 write(4, ..., 4000) =3D 4000
   +0 > P. 1:4001(4000) ack 1

   +0 close(4) =3D 0
   +0 > F. 4001:4001(0) ack 1

// In TCP_FIN_WAIT1 now...

// Send FIN as a TLP probe at 2*srtt:
+.200 > F. 4001:4001(0) ack 1

// Retransmit head.
+.300 > . 1:1001(1000) ack 1
   +0 `ss -tinmo src :8080`

// Test what happens when we ss --kill a socket in TCP_FIN_WAIT1.
// ss --kill is scary! Don't mess with the filter or risk killing many flow=
s!
   +0 `ss -t --kill -n src :8080 `

   +0 `echo check what is left...; ss -tinmo src :8080`

// An ACK arrives that carries a SACK block and
// makes us call tcp_verify_left_out(tp) to WARN about the inconsistency:
+.010 < . 1:1(0) ack 1 win 32890 <sack 1001:2001,nop,nop>

   +0 `echo after SACK; ss -tinmo src :8080`
---

That script triggers one of the warning cases mentioned in the netdev
email thread (see below).

Note that when I extend the packetdrill script above to expect another
RTO retransmission, that retransmission never happens, which AFAICT
supports my theory about the socket leak issue.

best regards,
neal

---
ps: here is the warning triggered by the packetdrill script above

[412967.317794] ------------[ cut here ]------------
[412967.317801] WARNING: CPU: 109 PID: 865840 at
net/ipv4/tcp_input.c:2141 tcp_sacktag_write_queue+0xb6f/0xb90
[412967.317805] Modules linked in: dummy act_mirred sch_netem ifb
bridge stp llc vfat fat i2c_mux_pca954x i2c_mux gq sha3_generic
spi_lewisburg_pch spidev cdc_acm google_bmc_lpc google_bmc_mailbox
xhci_pci xhci_hcd i2c_iimc
[412967.317818] CPU: 109 PID: 865840 Comm: packetdrill Kdump: loaded
Tainted: G S               N 5.10.0-smp-1300.91.890.1 #6
[412967.317820] Hardware name: Google LLC Indus/Indus_QC_00, BIOS
30.60.4 02/23/2023
[412967.317821] RIP: 0010:tcp_sacktag_write_queue+0xb6f/0xb90
[412967.317824] Code: 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc 0f
0b 41 83 be b0 06 00 00 00 79 a0 0f 0b eb 9c 0f 0b 41 8b 86 d0 06 00
00 eb 9c <0f> 0b eb b3 0f 0b e9 ac fe ff ff b8 ff ff ff ff e9 39 ff ff
ff e8
[412967.317826] RSP: 0018:ffff999ff84b9770 EFLAGS: 00010286
[412967.317827] RAX: 0000000000000001 RBX: 0000000000000001 RCX:
0000000000000005
[412967.317828] RDX: 00000000fffffffc RSI: ffff99a04bd7d200 RDI:
ffff99a07956e1c8
[412967.317830] RBP: ffff999ff84b9830 R08: ffff99a04bd7d200 R09:
00000000f82c8a14
[412967.317831] R10: ffff999f8b67dc54 R11: ffff999f8b67dc00 R12:
0000000000000054
[412967.317832] R13: 0000000000000001 R14: ffff99a07956e040 R15:
0000000000000014
[412967.317833] FS:  00007f4cf48dc740(0000) GS:ffff99cebfc80000(0000)
knlGS:0000000000000000
[412967.317834] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[412967.317835] CR2: 00000000085e9480 CR3: 000000309df36006 CR4:
00000000007726f0
[412967.317836] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[412967.317837] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400
[412967.317838] PKRU: 55555554
[412967.317839] Call Trace:
[412967.317845]  ? tcp_sacktag_write_queue+0xb6f/0xb90
[412967.317848]  ? __warn+0x195/0x2a0
[412967.317853]  ? tcp_sacktag_write_queue+0xb6f/0xb90
[412967.317869]  ? report_bug+0xe6/0x150
[412967.317872]  ? handle_bug+0x4c/0x90
[412967.317878]  ? exc_invalid_op+0x3a/0x110
[412967.317881]  ? asm_exc_invalid_op+0x12/0x20
[412967.317885]  ? tcp_sacktag_write_queue+0xb6f/0xb90
[412967.317889]  tcp_ack+0x5c8/0x1a90
[412967.317893]  ? prep_new_page+0x81/0xe0
[412967.317897]  ? prep_new_page+0x41/0xe0
[412967.317900]  ? get_page_from_freelist+0x1556/0x15b0
[412967.317904]  tcp_rcv_state_process+0x2cd/0xe00
[412967.317908]  tcp_v4_do_rcv+0x2ac/0x370
[412967.317913]  tcp_v4_rcv+0x9b8/0xab0
[412967.317916]  ip_protocol_deliver_rcu+0x71/0x110
[412967.317921]  ip_local_deliver+0xa8/0x130
[412967.317925]  ? inet_rtm_getroute+0x191/0x910
[412967.317928]  ? ip_local_deliver+0x130/0x130
[412967.317931]  ip_rcv+0x41/0xd0
[412967.317934]  ? ip_rcv_core+0x300/0x300
[412967.317937]  __netif_receive_skb+0x9e/0x160
[412967.317942]  netif_receive_skb+0x2c/0x130
[412967.317945]  tun_rx_batched+0x17b/0x1e0
[412967.317950]  tun_get_user+0xe39/0xff0
[412967.317953]  ? __switch_to_asm+0x3a/0x60
[412967.317958]  tun_chr_write_iter+0x57/0x80
[412967.317961]  do_iter_readv_writev+0x143/0x180
[412967.317967]  do_iter_write+0x8b/0x1d0
[412967.317970]  vfs_writev+0x96/0x130
[412967.317974]  do_writev+0x6b/0x100
[412967.317978]  do_syscall_64+0x6d/0xa0
[412967.317981]  entry_SYSCALL_64_after_hwframe+0x67/0xd1
[412967.317985] RIP: 0033:0x7f4cf4a10885

