Return-Path: <netdev+bounces-148909-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B4AB9E361F
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 10:03:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF528280C47
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 09:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B158D18D649;
	Wed,  4 Dec 2024 09:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kCY89UIE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3142500C8
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 09:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733303009; cv=none; b=Nl60fp+4GYx1oohhfzJMxzcEP6+pW3rMh85vbb8KxZrg64rrOPCF3l6DGZWLCKDD1nf/u6FWr4sBz/A3kjy8TUjmBp6Is4Jm4Y6xMJ51ctj8jl7z+mqpIjX/eCUx6c/FyrxFTT2uThK3TMgiLcvtiG7+aXvPtA+BAPrrLRQnlcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733303009; c=relaxed/simple;
	bh=U3exSd67Bg0H9ndMzrzeN58hbc4uyawb1SjPIXhFQhw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LNQCrGNOpMDYkhiYa0x/+QOQ3cWz/9hwqbowYX+OMsvl59PzgjXiiPqOP9NkMi98kGQTMto5p1NTEu6VmLNcT4X3StMvqTXYVwqJiBfe4R6iqeTvDVXKgFhZwGIkf9rdd9hGP0b17X5qataopr2kAwt1/7j0X593DDHLK4xdn6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kCY89UIE; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aa549f2fa32so968555266b.0
        for <netdev@vger.kernel.org>; Wed, 04 Dec 2024 01:03:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733303006; x=1733907806; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IPA5toiVxXUHE/tQE67BPR/az6YfNeLKTCP+d7Cb8Pk=;
        b=kCY89UIEQ7c16O3AioqYeIqc3PQYq8ocLFqRyb33ihA8rT5yjmOdTpDCKx2Gw+O8Mu
         u4/eOyWn6niQhcZZqMZEhuL8RThPlstoTJmaRxSiAaLTdScoraciYng79bVHjrTNX2+Y
         JkCxXAiBhCs28NBSkM9yeAaXCKjQcSFTe83ogxAzIPu/y5xRRJPRfStWjnKc7pLwmghT
         qi8j7e2zvPTUGgiANq2RUP+8k9mXMyC4vgFSULGwnQwopK6B5b5EnfRawPqSm1C9T2Vj
         j1A5Rob3z7j5SlUYTjqDheIXwjwevLdSZMekKFuvuyLV2eR735Ua1LSP6vGn+H400YFw
         1TkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733303006; x=1733907806;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IPA5toiVxXUHE/tQE67BPR/az6YfNeLKTCP+d7Cb8Pk=;
        b=N0kcPuVZrjVy7j07g8HG1eCEhU0Q4Dl4qqGop0Ikf8k1pkBBfq8nj/szIgMIXZj474
         iGWyrNa3SvuthDL72vItvp0H6Y9ZaiUjwi/iyyXRSgB9XJLUWK4z/S0KMbtGTBadGIT6
         G06xo7EvyZgDNFU0RdF8gyVlP4hugMG3RAD7CZBh7D0BHlU0OZr/S7zT9B5rEfRPez8b
         1JCOpBRca3OLNKu6eh1WocO9xiBAPDscC+N5KIbsOk8fw0CiSaIGLUhgPymGxf/SxESq
         RMuK2ymTf83pjzGqd3wjumLIbaetkC1TbqQpBAT/ot2Mw1EjmKeN7cRf2Z6QZYsgW0ts
         Ppmw==
X-Forwarded-Encrypted: i=1; AJvYcCVWaGathfb9XtOjn/5kFvrm00djIJtHhUU6wWqpaip9z9pnCKvF9FZhP2RCQnY+S1YcNifdj1I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeNo0C7f0mcSUNTqwvU0DApBwLGZHMOPsK4ZVRz76RxyenKAIt
	wi88c9qdVnnry7aWX/cMeJFJ67MtLLxYn9EoCn2EKzD64omkpk3EGDtNDrHr9F2Z0WKhr+HRArz
	PixWa4sgPsnjj7ZL0UKMqNm8I+hbj7t95jlAQ
X-Gm-Gg: ASbGncseRJSW4/FvKMkUW5g9YpnNgH2o+LIeUhGBVbs+kIh9tiQOQuzIk3NqJaw4s3g
	KDFm39DTrbsLalHepr8MxZsBk/gIW3ujs
X-Google-Smtp-Source: AGHT+IHSBFbQAqAfBoEnqan6Som7MtDbq8ZIromdhALOi+EDSTwgyJ1nfgSILZGTHRjmNzRqZ1cLZdoRE5X7gWrynWc=
X-Received: by 2002:a17:906:6a18:b0:a9e:c267:78c5 with SMTP id
 a640c23a62f3a-aa5f7f19e62mr569963566b.55.1733303005354; Wed, 04 Dec 2024
 01:03:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20241203081005epcas2p247b3d05bc767b1a50ba85c4433657295@epcas2p2.samsung.com>
 <20241203081247.1533534-1-youngmin.nam@samsung.com> <CANn89iK+7CKO31=3EvNo6-raUzyibwRRN8HkNXeqzuP9q8k_tA@mail.gmail.com>
 <Z0/HyztKs8UFBOa0@perf>
In-Reply-To: <Z0/HyztKs8UFBOa0@perf>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 4 Dec 2024 10:03:14 +0100
Message-ID: <CANn89iLSMKNsmtvD=d+_3CNBbDhBQ+41R_tesVUYO50S72-YWg@mail.gmail.com>
Subject: Re: [PATCH] tcp: check socket state before calling WARN_ON
To: Youngmin Nam <youngmin.nam@samsung.com>
Cc: Neal Cardwell <ncardwell@google.com>, davem@davemloft.net, dsahern@kernel.org, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, dujeong.lee@samsung.com, 
	guo88.liu@samsung.com, yiwang.cai@samsung.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, joonki.min@samsung.com, hajun.sung@samsung.com, 
	d7271.choe@samsung.com, sw.ju@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 4:05=E2=80=AFAM Youngmin Nam <youngmin.nam@samsung.c=
om> wrote:
>
> Hi Eric.
> Thanks for looking at this issue.
>
> On Tue, Dec 03, 2024 at 12:07:05PM +0100, Eric Dumazet wrote:
> > On Tue, Dec 3, 2024 at 9:10=E2=80=AFAM Youngmin Nam <youngmin.nam@samsu=
ng.com> wrote:
> > >
> > > We encountered the following WARNINGs
> > > in tcp_sacktag_write_queue()/tcp_fastretrans_alert()
> > > which triggered a kernel panic due to panic_on_warn.
> > >
> > > case 1.
> > > ------------[ cut here ]------------
> > > WARNING: CPU: 4 PID: 453 at net/ipv4/tcp_input.c:2026
> > > Call trace:
> > >  tcp_sacktag_write_queue+0xae8/0xb60
> > >  tcp_ack+0x4ec/0x12b8
> > >  tcp_rcv_state_process+0x22c/0xd38
> > >  tcp_v4_do_rcv+0x220/0x300
> > >  tcp_v4_rcv+0xa5c/0xbb4
> > >  ip_protocol_deliver_rcu+0x198/0x34c
> > >  ip_local_deliver_finish+0x94/0xc4
> > >  ip_local_deliver+0x74/0x10c
> > >  ip_rcv+0xa0/0x13c
> > > Kernel panic - not syncing: kernel: panic_on_warn set ...
> > >
> > > case 2.
> > > ------------[ cut here ]------------
> > > WARNING: CPU: 0 PID: 648 at net/ipv4/tcp_input.c:3004
> > > Call trace:
> > >  tcp_fastretrans_alert+0x8ac/0xa74
> > >  tcp_ack+0x904/0x12b8
> > >  tcp_rcv_state_process+0x22c/0xd38
> > >  tcp_v4_do_rcv+0x220/0x300
> > >  tcp_v4_rcv+0xa5c/0xbb4
> > >  ip_protocol_deliver_rcu+0x198/0x34c
> > >  ip_local_deliver_finish+0x94/0xc4
> > >  ip_local_deliver+0x74/0x10c
> > >  ip_rcv+0xa0/0x13c
> > > Kernel panic - not syncing: kernel: panic_on_warn set ...
> > >
> >
> > I have not seen these warnings firing. Neal, have you seen this in the =
past ?
> >
> > Please provide the kernel version (this must be a pristine LTS one).
> We are running Android kernel for Android mobile device which is based on=
 LTS kernel 6.6-30.
> But we've seen this issue since kernel 5.15 LTS.
>
> > and symbolized stack traces using scripts/decode_stacktrace.sh
> Unfortunately, we don't have the matched vmlinux right now. So we need to=
 rebuild and reproduce.
> >
> > If this warning was easy to trigger, please provide a packetdrill test =
?
> I'm not sure if we can run packetdrill test on Android device. Anyway let=
 me check.
>
> FYI, Here are more detailed logs.
>
> Case 1.
> [26496.422651]I[4:  napi/wlan0-33:  467] ------------[ cut here ]--------=
----
> [26496.422665]I[4:  napi/wlan0-33:  467] WARNING: CPU: 4 PID: 467 at net/=
ipv4/tcp_input.c:2026 tcp_sacktag_write_queue+0xae8/0xb60
> [26496.423420]I[4:  napi/wlan0-33:  467] CPU: 4 PID: 467 Comm: napi/wlan0=
-33 Tainted: G S         OE      6.6.30-android15-8-geeceb2c9cdf1-ab2024093=
0.125201-4k #1 a1c80b36942fa6e9575b2544032a7536ed502804
> [26496.423427]I[4:  napi/wlan0-33:  467] Hardware name: Samsung ERD9955 b=
oard based on S5E9955 (DT)
> [26496.423432]I[4:  napi/wlan0-33:  467] pstate: 83400005 (Nzcv daif +PAN=
 -UAO +TCO +DIT -SSBS BTYPE=3D--)
> [26496.423438]I[4:  napi/wlan0-33:  467] pc : tcp_sacktag_write_queue+0xa=
e8/0xb60
> [26496.423446]I[4:  napi/wlan0-33:  467] lr : tcp_ack+0x4ec/0x12b8
> [26496.423455]I[4:  napi/wlan0-33:  467] sp : ffffffc096b8b690
> [26496.423458]I[4:  napi/wlan0-33:  467] x29: ffffffc096b8b710 x28: 00000=
00000008001 x27: 000000005526d635
> [26496.423469]I[4:  napi/wlan0-33:  467] x26: ffffff8a19079684 x25: 00000=
0005526dbfd x24: 0000000000000001
> [26496.423480]I[4:  napi/wlan0-33:  467] x23: 000000000000000a x22: fffff=
f88e5f5b680 x21: 000000005526dbc9
> [26496.423489]I[4:  napi/wlan0-33:  467] x20: ffffff8a19078d80 x19: fffff=
f88e9f4193e x18: ffffffd083114c80
> [26496.423499]I[4:  napi/wlan0-33:  467] x17: 00000000529c6ef0 x16: 00000=
0000000ff8b x15: 0000000000000000
> [26496.423508]I[4:  napi/wlan0-33:  467] x14: 0000000000000001 x13: 00000=
00000000001 x12: 0000000000000000
> [26496.423517]I[4:  napi/wlan0-33:  467] x11: 0000000000000000 x10: 00000=
00000000001 x9 : 00000000fffffffd
> [26496.423526]I[4:  napi/wlan0-33:  467] x8 : 0000000000000001 x7 : 00000=
00000000000 x6 : ffffffd081ec0bc4
> [26496.423536]I[4:  napi/wlan0-33:  467] x5 : 0000000000000000 x4 : 00000=
00000000000 x3 : ffffffc096b8b818
> [26496.423545]I[4:  napi/wlan0-33:  467] x2 : 000000005526d635 x1 : fffff=
f88e5f5b680 x0 : ffffff8a19078d80
> [26496.423555]I[4:  napi/wlan0-33:  467] Call trace:
> [26496.423558]I[4:  napi/wlan0-33:  467]  tcp_sacktag_write_queue+0xae8/0=
xb60
> [26496.423566]I[4:  napi/wlan0-33:  467]  tcp_ack+0x4ec/0x12b8
> [26496.423573]I[4:  napi/wlan0-33:  467]  tcp_rcv_state_process+0x22c/0xd=
38
> [26496.423580]I[4:  napi/wlan0-33:  467]  tcp_v4_do_rcv+0x220/0x300
> [26496.423590]I[4:  napi/wlan0-33:  467]  tcp_v4_rcv+0xa5c/0xbb4
> [26496.423596]I[4:  napi/wlan0-33:  467]  ip_protocol_deliver_rcu+0x198/0=
x34c
> [26496.423607]I[4:  napi/wlan0-33:  467]  ip_local_deliver_finish+0x94/0x=
c4
> [26496.423614]I[4:  napi/wlan0-33:  467]  ip_local_deliver+0x74/0x10c
> [26496.423620]I[4:  napi/wlan0-33:  467]  ip_rcv+0xa0/0x13c
> [26496.423625]I[4:  napi/wlan0-33:  467]  __netif_receive_skb_core+0xe14/=
0x1104
> [26496.423642]I[4:  napi/wlan0-33:  467]  __netif_receive_skb_list_core+0=
xb8/0x2dc
> [26496.423649]I[4:  napi/wlan0-33:  467]  netif_receive_skb_list_internal=
+0x234/0x320
> [26496.423655]I[4:  napi/wlan0-33:  467]  napi_complete_done+0xb4/0x1a0
> [26496.423660]I[4:  napi/wlan0-33:  467]  slsi_rx_netif_napi_poll+0x22c/0=
x258 [scsc_wlan 16ac2100e65b7c78ce863cecc238b39b162dbe82]
> [26496.423822]I[4:  napi/wlan0-33:  467]  __napi_poll+0x5c/0x238
> [26496.423829]I[4:  napi/wlan0-33:  467]  napi_threaded_poll+0x110/0x204
> [26496.423836]I[4:  napi/wlan0-33:  467]  kthread+0x114/0x138
> [26496.423845]I[4:  napi/wlan0-33:  467]  ret_from_fork+0x10/0x20
> [26496.423856]I[4:  napi/wlan0-33:  467] Kernel panic - not syncing: kern=
el: panic_on_warn set ..
>
> Case 2.
> [ 1843.463330]I[0: surfaceflinger:  648] ------------[ cut here ]--------=
----
> [ 1843.463355]I[0: surfaceflinger:  648] WARNING: CPU: 0 PID: 648 at net/=
ipv4/tcp_input.c:3004 tcp_fastretrans_alert+0x8ac/0xa74
> [ 1843.464508]I[0: surfaceflinger:  648] CPU: 0 PID: 648 Comm: surfacefli=
nger Tainted: G S         OE      6.6.30-android15-8-geeceb2c9cdf1-ab202410=
17.075836-4k #1 de751202c2c5ab3ec352a00ae470fc5e907bdcfe
> [ 1843.464520]I[0: surfaceflinger:  648] Hardware name: Samsung ERD8855 b=
oard based on S5E8855 (DT)
> [ 1843.464527]I[0: surfaceflinger:  648] pstate: 23400005 (nzCv daif +PAN=
 -UAO +TCO +DIT -SSBS BTYPE=3D--)
> [ 1843.464535]I[0: surfaceflinger:  648] pc : tcp_fastretrans_alert+0x8ac=
/0xa74
> [ 1843.464548]I[0: surfaceflinger:  648] lr : tcp_ack+0x904/0x12b8
> [ 1843.464556]I[0: surfaceflinger:  648] sp : ffffffc0800036e0
> [ 1843.464561]I[0: surfaceflinger:  648] x29: ffffffc0800036e0 x28: 00000=
00000008005 x27: 000000001bc05562
> [ 1843.464579]I[0: surfaceflinger:  648] x26: ffffff890418a3c4 x25: 00000=
00000000000 x24: 000000000000cd02
> [ 1843.464595]I[0: surfaceflinger:  648] x23: 000000001bc05562 x22: 00000=
00000000000 x21: ffffffc080003800
> [ 1843.464611]I[0: surfaceflinger:  648] x20: ffffffc08000378c x19: fffff=
f8904189ac0 x18: 0000000000000000
> [ 1843.464627]I[0: surfaceflinger:  648] x17: 00000000529c6ef0 x16: 00000=
0000000ff8b x15: 0000000000000001
> [ 1843.464642]I[0: surfaceflinger:  648] x14: 0000000000000001 x13: 00000=
00000000001 x12: 0000000000000000
> [ 1843.464658]I[0: surfaceflinger:  648] x11: ffffff883e9c9540 x10: 00000=
00000000001 x9 : 0000000000000001
> [ 1843.464673]I[0: surfaceflinger:  648] x8 : 0000000000000000 x7 : 00000=
00000000000 x6 : ffffffd081ec0bc4
> [ 1843.464689]I[0: surfaceflinger:  648] x5 : 0000000000000000 x4 : fffff=
fc08000378c x3 : ffffffc080003800
> [ 1843.464704]I[0: surfaceflinger:  648] x2 : 0000000000000000 x1 : 00000=
0001bc05562 x0 : ffffff8904189ac0
> [ 1843.464720]I[0: surfaceflinger:  648] Call trace:
> [ 1843.464725]I[0: surfaceflinger:  648]  tcp_fastretrans_alert+0x8ac/0xa=
74
> [ 1843.464735]I[0: surfaceflinger:  648]  tcp_ack+0x904/0x12b8
> [ 1843.464743]I[0: surfaceflinger:  648]  tcp_rcv_state_process+0x22c/0xd=
38
> [ 1843.464751]I[0: surfaceflinger:  648]  tcp_v4_do_rcv+0x220/0x300
> [ 1843.464760]I[0: surfaceflinger:  648]  tcp_v4_rcv+0xa5c/0xbb4
> [ 1843.464767]I[0: surfaceflinger:  648]  ip_protocol_deliver_rcu+0x198/0=
x34c
> [ 1843.464776]I[0: surfaceflinger:  648]  ip_local_deliver_finish+0x94/0x=
c4
> [ 1843.464784]I[0: surfaceflinger:  648]  ip_local_deliver+0x74/0x10c
> [ 1843.464791]I[0: surfaceflinger:  648]  ip_rcv+0xa0/0x13c
> [ 1843.464799]I[0: surfaceflinger:  648]  __netif_receive_skb_core+0xe14/=
0x1104
> [ 1843.464810]I[0: surfaceflinger:  648]  __netif_receive_skb+0x40/0x124
> [ 1843.464818]I[0: surfaceflinger:  648]  netif_receive_skb+0x7c/0x234
> [ 1843.464825]I[0: surfaceflinger:  648]  slsi_rx_data_deliver_skb+0x1e0/=
0xdbc [scsc_wlan 12b378a8d5cf5e6cd833136fc49079d43751bd28]
> [ 1843.465025]I[0: surfaceflinger:  648]  slsi_ba_process_complete+0x70/0=
xa4 [scsc_wlan 12b378a8d5cf5e6cd833136fc49079d43751bd28]
> [ 1843.465219]I[0: surfaceflinger:  648]  slsi_ba_aging_timeout_handler+0=
x324/0x354 [scsc_wlan 12b378a8d5cf5e6cd833136fc49079d43751bd28]
> [ 1843.465410]I[0: surfaceflinger:  648]  call_timer_fn+0xd0/0x360
> [ 1843.465423]I[0: surfaceflinger:  648]  __run_timers+0x1b4/0x268
> [ 1843.465432]I[0: surfaceflinger:  648]  run_timer_softirq+0x24/0x4c
> [ 1843.465440]I[0: surfaceflinger:  648]  __do_softirq+0x158/0x45c
> [ 1843.465448]I[0: surfaceflinger:  648]  ____do_softirq+0x10/0x20
> [ 1843.465455]I[0: surfaceflinger:  648]  call_on_irq_stack+0x3c/0x74
> [ 1843.465463]I[0: surfaceflinger:  648]  do_softirq_own_stack+0x1c/0x2c
> [ 1843.465470]I[0: surfaceflinger:  648]  __irq_exit_rcu+0x54/0xb4
> [ 1843.465480]I[0: surfaceflinger:  648]  irq_exit_rcu+0x10/0x1c
> [ 1843.465489]I[0: surfaceflinger:  648]  el0_interrupt+0x54/0xe0
> [ 1843.465499]I[0: surfaceflinger:  648]  __el0_irq_handler_common+0x18/0=
x28
> [ 1843.465508]I[0: surfaceflinger:  648]  el0t_64_irq_handler+0x10/0x1c
> [ 1843.465516]I[0: surfaceflinger:  648]  el0t_64_irq+0x1a8/0x1ac
> [ 1843.465525]I[0: surfaceflinger:  648] Kernel panic - not syncing: kern=
el: panic_on_warn set ...
>
> > > When we check the socket state value at the time of the issue,
> > > it was 0x4.
> > >
> > > skc_state =3D 0x4,
> > >
> > > This is "TCP_FIN_WAIT1" and which means the device closed its socket.
> > >
> > > enum {
> > >         TCP_ESTABLISHED =3D 1,
> > >         TCP_SYN_SENT,
> > >         TCP_SYN_RECV,
> > >         TCP_FIN_WAIT1,
> > >
> > > And also this means tp->packets_out was initialized as 0
> > > by tcp_write_queue_purge().
> >
> > What stack trace leads to this tcp_write_queue_purge() exactly ?
> I couldn't find the exact call stack to this.
> But I just thought that the function would be called based on ramdump sna=
pshot.
>
> (*(struct tcp_sock *)(0xFFFFFF800467AB00)).packets_out =3D 0
> (*(struct inet_connection_sock *)0xFFFFFF800467AB00).icsk_backoff =3D 0

TCP_FIN_WAIT1 is set whenever the application does a shutdown(fd, SHUT_WR);

This means that all bytes in the send queue and retransmit queue
should be kept, and will eventually be sent.

 tcp_write_queue_purge() must not be called until we receive some
valid RST packet or fatal timeout.

6.6.30 is old, LTS 6.6.63 has some TCP changes that might br related.

$ git log --oneline v6.6.30..v6.6.63 -- net/ipv4/tcp*c
229dfdc36f31a8d47433438bc0e6e1662c4ab404 tcp: fix mptcp DSS corruption
due to large pmtu xmit
2daffbd861de532172079dceef5c0f36a26eee14 tcp: fix TFO SYN_RECV to not
zero retrans_stamp with retransmits out
718c49f840ef4e451bf44a8a62aae89ebdd5a687 tcp: new TCP_INFO stats for RTO ev=
ents
04dce9a120502aea4ca66eebf501f404a22cd493 tcp: fix tcp_enter_recovery()
to zero retrans_stamp when it's safe
e676ca60ad2a6fdeb718b5e7a337a8fb1591d45f tcp: fix to allow timestamp
undo if no retransmits were sent
5cce1c07bf8972d3ab94c25aa9fb6170f99082e0 tcp: avoid reusing FIN_WAIT2
when trying to find port in connect() process
4fe707a2978929b498d3730d77a6ab103881420d tcp: process the 3rd ACK with
sk_socket for TFO/MPTCP
9fd29738377c10749cb292510ebc202988ea0a31 tcp: Don't drop SYN+ACK for
simultaneous connect().
c8219a27fa43a2cbf99f5176f6dddfe73e7a24ae tcp_bpf: fix return value of
tcp_bpf_sendmsg()
69f397e60c3be615c32142682d62fc0b6d5d5d67 net: remove NULL-pointer net
parameter in ip_metrics_convert
f0974e6bc385f0e53034af17abbb86ac0246ef1c tcp: do not export tcp_twsk_purge(=
)
99580ae890ec8bd98b21a2a9c6668f8f1555b62e tcp: prevent concurrent
execution of tcp_sk_exit_batch
7348061662c7149b81e38e545d5dd6bd427bec81 tcp/dccp: do not care about
families in inet_twsk_purge()
227355ad4e4a6da5435451b3cc7f3ed9091288fa tcp: Update window clamping condit=
ion
77100f2e8412dbb84b3e7f1b947c9531cb509492 tcp_metrics: optimize
tcp_metrics_flush_all()
6772c4868a8e7ad5305957cdb834ce881793acb7 net: drop bad gso csum_start
and offset in virtio_net_hdr
1cfdc250b3d210acd5a4a47337b654e04693cf7f tcp: Adjust clamping window
for applications specifying SO_RCVBUF
f9fef23a81db9adc1773979fabf921eba679d5e7 tcp: annotate data-races
around tp->window_clamp
44aa1e461ccd1c2e49cffad5e75e1b944ec590ef tcp: fix races in tcp_v[46]_err()
bc4f9c2ccd68afec3a8395d08fd329af2022c7e8 tcp: fix race in tcp_write_err()
ecc6836d63513fb4857a7525608d7fdd0c837cb3 tcp: add tcp_done_with_error() hel=
per
dfcdd7f89e401d2c6616be90c76c2fac3fa98fde tcp: avoid too many retransmit pac=
kets
b75f281bddebdcf363884f0d53c562366e9ead99 tcp: use signed arithmetic in
tcp_rtx_probe0_timed_out()
124886cf20599024eb33608a2c3608b7abf3839b tcp: fix incorrect undo
caused by DSACK of TLP retransmit
8c2debdd170e395934ac0e039748576dfde14e99 tcp_metrics: validate source
addr length
8a7fc2362d6d234befde681ea4fb6c45c1789ed5 UPSTREAM: tcp: fix DSACK undo
in fast recovery to call tcp_try_to_open()
b4b26d23a1e2bc188cec8592e111d68d83b9031f tcp: fix
tcp_rcv_fastopen_synack() to enter TCP_CA_Loss for failed TFO
fdae4d139f4778b20a40c60705c53f5f146459b5 Fix race for duplicate reqsk
on identical SYN
250fad18b0c959b137ad745428fb411f1ac1bbc6 tcp: clear tp->retrans_stamp
in tcp_rcv_fastopen_synack()
acdf17546ef8ee73c94e442e3f4b933e42c3dfac tcp: count CLOSE-WAIT sockets
for TCP_MIB_CURRESTAB
50569d12945f86fa4b321c4b1c3005874dbaa0f1 net: tls: fix marking packets
as decrypted
02261d3f9dc7d1d7be7d778f839e3404ab99034c tcp: Fix shift-out-of-bounds
in dctcp_update_alpha().
00bb933578acd88395bf6e770cacdbe2d6a0be86 tcp: avoid premature drops in
tcp_add_backlog()
6e48faad92be13166184d21506e4e54c79c13adc tcp: Use
refcount_inc_not_zero() in tcp_twsk_unique().
f47d0d32fa94e815fdd78b8b88684873e67939f4 tcp: defer
shutdown(SEND_SHUTDOWN) for TCP_SYN_RECV sockets

