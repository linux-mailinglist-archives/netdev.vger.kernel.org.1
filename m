Return-Path: <netdev+bounces-229141-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BA70BD879F
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 11:38:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2937F4F86E9
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 09:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E82229993F;
	Tue, 14 Oct 2025 09:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C/knWoKt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24671EEA5F
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 09:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760434730; cv=none; b=jpIylAcHmEHZ4AkquJ7AmyRXACY+0NJK51vjp4LQi/kfBaZBACF9AnteBAWftkmhnSQ/BoaFFsmDlyk+Uq5saY0rPtXozr+Fr+tLUVFNV340FpKaAUgrC5Q7UsPsxNakzs5abVH7mFuai/4O2CnSEbZu7osJ2UIR+O2970Qr0wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760434730; c=relaxed/simple;
	bh=zgMtOXxrnwIkti4rt2g9+Bc53GIzVDtEqm3tT4XBPjI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fG5i8hrBra2r3VfeDw2bdC44FlgL+2NThO2YBGAmDXs34fuJJBP6wczslr3U/z6GkgJ4LFGrpNRcqoPBFepOiD42lA4YuPr0LzzAqlTAFhPUG/Drju1D8QNGD3W7KRLE2JriuFrg3w5x/cV/jSKF30WdhoAP5Qqxhm6O0y/ktCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C/knWoKt; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-78f58f4230cso58344356d6.1
        for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 02:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760434728; x=1761039528; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9WwxL5x/MgTev7a06YWnp5rhNsHi5hT6hKQWDK/kS00=;
        b=C/knWoKtz1C+CmgXNEZGdm1tD1fDtNgCP6jjVbAsMltgRz50nbbGJcBRPjW4UaNBgE
         QHzaAHbwMpePpkJhWgUQCsIAH59GcVxka1z/iQMGHtpQeOw+Yipb54kdzESelR7RRY34
         uJb+6/yyksZQL160BrqU3bfLKGq41LK5d6nYGxeXMijC/9QmA4zvtUFo2goW57wAm5aI
         AOTxnokB9cKW4GxADpbzmhh1lUY4Wj8Rrmqm/JVcD4tmqjqo9xPvtVXy5GOvMTX4xQdv
         jk3YsMdZF8+ukjFfo4Z0hdq3bA+R527uj4QIU/Left5wXL/kE9R6oddVB6IVtTFwqnUp
         XNNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760434728; x=1761039528;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9WwxL5x/MgTev7a06YWnp5rhNsHi5hT6hKQWDK/kS00=;
        b=oyyo5v+upz2SPjvtLCTzz5/F15XY4mIDaOhHzL4oR96z9XBiqMDKBODHMT03zT8wgd
         k1S6Kzhc/xOrGcNqVC5vVdcNNkZteBxozUyAS6YkGPi3jDuyiTQlLMrFh7xRqcL1VlfM
         f6B/2EpwH9SN4707+AMhJXkYaPMhXmVk9d7Cu7EsHFI1aqJK8nBFJaItcoYS9RQZChuE
         CB2dQxN3kcjJQFzHMxPq9KnPBCDOoikeNQrQX2I0BoxOKqLP+/5VhmMug40lv0zVB4FY
         F3eQLkWXnMkeTJf1anjoNbBsAReRUUvmm2lO5lt4NJRD+wit2T+KLRO76qgvh1yjRHGY
         Rshg==
X-Forwarded-Encrypted: i=1; AJvYcCU74G0zvW6ggexHtqE4aBdNeG+gs5lShSaVIemuRobaCPexDmdv4B/YdYHVV5cfMW8szk5YXsY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5IYMoW3BQW4yMxn6ySCDvnGItqMasLbz88T7PuUm6cqFElUA8
	U2h4t35lkFkl2Q0dVY0parqQ4vDst77v5cbwPTZEjn9Uo0nr36s7YUBg5bqL070JikrX4mgZECW
	QYl7zmmgWVrV3g8DZV3wqGtV9OhPsOXiKmqoEBmb+XOo8xVVeZ/nfOZVjd2A=
X-Gm-Gg: ASbGncsmR0xAAkrN78dCEc81TN5Esy+lgHk6G5wM4L89aOcngqO19aDUi6B9BMwxveR
	skwpN4qJvsujCov/nkcOqW9698RUV6QjEksETV6FuWU9koNQiaA4yoJehR3db2gD9+1TybJAz//
	GLFPFCAL4olUAePok2tPvkTwOk6SuUVCZnnyk5tqdIEk4gkDFfGCdNSKI7z5ef9pNpBvatGtxJY
	6iVPFsMeI1yqwvy1Aj5OQIm4z08W6AP1cvI9ztragEt3iUUM1RNog==
X-Google-Smtp-Source: AGHT+IFnva+ONeuCmtQwb9R0SYEOtLY5FGmJ1RKZop6vqYhdgd+RCRlh+8cHcmzb0iqfOFC5vNHOc+YetnOLhRgu4rU=
X-Received: by 2002:a05:622a:5595:b0:4c8:36ff:7930 with SMTP id
 d75a77b69052e-4e6ead5def1mr402069631cf.67.1760434727432; Tue, 14 Oct 2025
 02:38:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013145926.833198-1-edumazet@google.com> <3b20bfde-1a99-4018-a8d9-bb7323b33285@redhat.com>
 <CANn89iKu7jjnjc1QdUrvbetti2AGhKe0VR+srecrpJ2s-hfkKA@mail.gmail.com> <CANn89iL8YKZZQZSmg5WqrYVtyd2PanNXzTZ2Z0cObpv9_XSmoQ@mail.gmail.com>
In-Reply-To: <CANn89iL8YKZZQZSmg5WqrYVtyd2PanNXzTZ2Z0cObpv9_XSmoQ@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 14 Oct 2025 02:38:35 -0700
X-Gm-Features: AS18NWDL6JUShZgxaGGBgBRrDkcA2Lm8y_YII1k9jxmyIOrCi3zL-mtTbUmZjVE
Message-ID: <CANn89iKr8P7_qesQ1LVKibuETCEaP6mNC-yjmymmRvtzLibzfA@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: better handle TCP_TX_DELAY on established flows
To: Paolo Abeni <pabeni@redhat.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Willem de Bruijn <willemb@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 1:54=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Tue, Oct 14, 2025 at 1:29=E2=80=AFAM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > On Tue, Oct 14, 2025 at 1:22=E2=80=AFAM Paolo Abeni <pabeni@redhat.com>=
 wrote:
> > >
> > > On 10/13/25 4:59 PM, Eric Dumazet wrote:
> > > > Some applications uses TCP_TX_DELAY socket option after TCP flow
> > > > is established.
> > > >
> > > > Some metrics need to be updated, otherwise TCP might take time to
> > > > adapt to the new (emulated) RTT.
> > > >
> > > > This patch adjusts tp->srtt_us, tp->rtt_min, icsk_rto
> > > > and sk->sk_pacing_rate.
> > > >
> > > > This is best effort, and for instance icsk_rto is reset
> > > > without taking backoff into account.
> > > >
> > > > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > >
> > > The CI is consistently reporting pktdrill failures on top of this pat=
ch:
> > >
> > > # selftests: net/packetdrill: tcp_user_timeout_user-timeout-probe.pkt
> > > # TAP version 13
> > > # 1..2
> > > # tcp_user_timeout_user-timeout-probe.pkt:35: error in Python code
> > > # Traceback (most recent call last):
> > > #   File "/tmp/code_T7S7S4", line 202, in <module>
> > > #     assert tcpi_probes =3D=3D 6, tcpi_probes; \
> > > # AssertionError: 0
> > > # tcp_user_timeout_user-timeout-probe.pkt: error executing code:
> > > 'python3' returned non-zero status 1
> > >
> > > To be accurate, the patches batch under tests also includes:
> > >
> > > https://patchwork.kernel.org/project/netdevbpf/list/?series=3D1010780
> > >
> > > but the latter looks even more unlikely to cause the reported issues?=
!?
>
> Not sure, look at the packetdrill test "`tc qdisc delete dev tun0 root
> 2>/dev/null ; tc qdisc add dev tun0 root pfifo limit 0`"
>
> After "net: dev_queue_xmit() llist adoption" __dev_xmit_skb() might
> return NET_XMIT_SUCCESS instead of NET_XMIT_DROP
>
> __tcp_transmit_skb() has some code to detect NET_XMIT_DROP
> immediately, instead of relying on a timer.
>
> I can fix the 'single packet' case, but not the case of many packets
> being sent in //
>
> Note this issue was there already, for qdisc with TCQ_F_CAN_BYPASS :
> We were returning NET_XMIT_SUCCESS even if the driver had to drop the pac=
ket.
>
> Test is flaky even without the
> https://patchwork.kernel.org/project/netdevbpf/list/?series=3D1010780
> series.

Test flakiness can be fixed with

diff --git a/tools/testing/selftests/net/packetdrill/tcp_user_timeout_user-=
timeout-probe.pkt
b/tools/testing/selftests/net/packetdrill/tcp_user_timeout_user-timeout-pro=
be.pkt
index 183051ba0cae..71f7a75a733b 100644
--- a/tools/testing/selftests/net/packetdrill/tcp_user_timeout_user-timeout=
-probe.pkt
+++ b/tools/testing/selftests/net/packetdrill/tcp_user_timeout_user-timeout=
-probe.pkt
@@ -7,6 +7,8 @@
    +0 bind(3, ..., ...) =3D 0
    +0 listen(3, 1) =3D 0

+// install a pfifo qdisc
+   +0 `tc qdisc delete dev tun0 root 2>/dev/null ; tc qdisc add dev
tun0 root pfifo limit 10`

    +0 < S 0:0(0) win 0 <mss 1460>
    +0 > S. 0:0(0) ack 1 <mss 1460>
@@ -21,16 +23,18 @@
    +0 %{ assert tcpi_probes =3D=3D 0, tcpi_probes; \
          assert tcpi_backoff =3D=3D 0, tcpi_backoff }%

-// install a qdisc dropping all packets
-   +0 `tc qdisc delete dev tun0 root 2>/dev/null ; tc qdisc add dev
tun0 root pfifo limit 0`
+// Tune pfifo limit to 0. A single tc command is less disruptive in VM tes=
ts.
+   +0 `tc qdisc change dev tun0 root pfifo limit 0`
+
    +0 write(4, ..., 24) =3D 24
    // When qdisc is congested we retry every 500ms
    // (TCP_RESOURCE_PROBE_INTERVAL) and therefore
    // we retry 6 times before hitting 3s timeout.
    // First verify that the connection is alive:
-+3.250 write(4, ..., 24) =3D 24
++3 write(4, ..., 24) =3D 24
+
    // Now verify that shortly after that the socket is dead:
- +.100 write(4, ..., 24) =3D -1 ETIMEDOUT (Connection timed out)
++1 write(4, ..., 24) =3D -1 ETIMEDOUT (Connection timed out)

    +0 %{ assert tcpi_probes =3D=3D 6, tcpi_probes; \
          assert tcpi_backoff =3D=3D 0, tcpi_backoff }%

