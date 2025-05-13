Return-Path: <netdev+bounces-190238-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EFCBAB5D37
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 21:39:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23A0D4A0D3F
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 19:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C344A2BF994;
	Tue, 13 May 2025 19:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Tc6aLngN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f74.google.com (mail-vs1-f74.google.com [209.85.217.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A799524E01D
	for <netdev@vger.kernel.org>; Tue, 13 May 2025 19:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747165166; cv=none; b=OPS/zpKdo5dLg31NkB5E/TTerW2FYzSzWQtjBkEyr7iUFjRdfeECwyPvMnl1Pvp7xG3Fb10eZSbjSir73maydyH7H2RhFJqS5YUjhJD2vtsGhdf0IVxxRL3r361nqoe/2qoH3NDQAL8Y4rdzUgPT/HZ9RVYxq9VUIsV/vQagAzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747165166; c=relaxed/simple;
	bh=oFBwrMBk+v3NAGZ9X1WmZx6zzF1SVO6CbHvd2klrqWc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ud7BatBrSkzYMxY8FTBo1z8776c9v2CF1IwWK3FOexfSv2G02MW/Q4h5UOuntdrsVT/XXE3p4fy1zmTxHMhr9f+9dTLQvp7u885p3Lz/hhb/IbHGX1xlcOJmoqAjct1ycGVtPq0agq2jyrnf3w7voeHa7zodB4v3slzz3tUzSPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Tc6aLngN; arc=none smtp.client-ip=209.85.217.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-vs1-f74.google.com with SMTP id ada2fe7eead31-4ddb3a63272so183104137.0
        for <netdev@vger.kernel.org>; Tue, 13 May 2025 12:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747165163; x=1747769963; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tMslMMdSY7A+FrhclgJoskh0UA1uz4+82Wnmf/AkVnQ=;
        b=Tc6aLngNCFogWk3dPSR4piVZhyznwKOzHMuc40i2iKi581pQBqGG0GCzLH1me4ncdi
         xnhfPOrkFDTIjAxRNg1Y5229JhcikrKgsI4ba26KYtF8tvCnQm8KWSJDTNJLPJNs/p+M
         FiD08YEaf11GouxZxEzYWCyM/yKLF3wxRLycI73sPAWvk06arUsot1c2lh3DStH9d+dd
         aLi91CcQj1RfqGSRnoliczmZNkearRu75JH3OzPdzL6pdnOZa+lRdJme8BheHgCU3tbI
         V96UG1xn5M0GtCp8OY+f1FYjHRFwWpTAU0coKa/VGvu7UlMaoRGWqOgeC2fBlTTbJRag
         zgYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747165163; x=1747769963;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tMslMMdSY7A+FrhclgJoskh0UA1uz4+82Wnmf/AkVnQ=;
        b=Og3JpHjRKvTCe19aEcbTpu9F2juO/0KRSIWODwMuFUiKEEYxIKFjb+JGjPHXInsmUs
         hug5A46YI1SRsWvsrqWwNnbRRWYNcIqGudUfEFdjMDXmHq/JddA40Yz/yNINPYKsi3gJ
         ax/AtPnoKAwH6FWs2SpAEdKixHAZvSTLXHPgUx1eN4dGra4f8E+cWgwzXH8/RADvgWI9
         Y3/LXJM5yKfAC17d+ACbN4sGbg9pcMPHEIMzfo/hx88d8VfkTwpV7Poe1SvsIzGuc5+E
         3psAKQyhxJTEaB+D7UE7uqBXHeJAFXAPnJRY6hgKmljTFhJTpATyd/PzPctRiZx5Jtmb
         VNsQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTfqeeTvv56kPFYdtQ7iQ/PmcyUicWp1WaQsxMRhMgGn2I5vtvoRz9gBR4XomKCVTgF6wfE1Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRO1ve8BqwcHQeVtsWLrRTfYIfKTbTW3lAlFkICH/Wrj+dGGnV
	0GRZaqT7eWF1BA6AxH1xRhIsthFRtD9J5NOHCxN+JFZ+t4iuaXAZCmqDsyXVg5zp80a31tkNWfW
	N0cw4HE8E/w==
X-Google-Smtp-Source: AGHT+IGwWxKH1noY5w3rQDUigtvY1Gy62vy9Bmh8QrL3s9rHPEfk0Dfutjd8a5OBBT/RXs8r87RbUkR+PzU1dg==
X-Received: from vsbhz17.prod.google.com ([2002:a05:6102:4a91:b0:4dd:b6bf:1913])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6102:3e25:b0:4cb:644f:fc51 with SMTP id ada2fe7eead31-4df7d93533dmr921449137.9.1747165163466;
 Tue, 13 May 2025 12:39:23 -0700 (PDT)
Date: Tue, 13 May 2025 19:39:09 +0000
In-Reply-To: <20250513193919.1089692-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250513193919.1089692-1-edumazet@google.com>
X-Mailer: git-send-email 2.49.0.1045.g170613ef41-goog
Message-ID: <20250513193919.1089692-2-edumazet@google.com>
Subject: [PATCH net-next 01/11] tcp: add tcp_rcvbuf_grow() tracepoint
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Rick Jones <jonesrick@google.com>, Wei Wang <weiwan@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Provide a new tracepoint to better understand
tcp_rcv_space_adjust() (currently broken) behavior.

Call it only when tcp_rcv_space_adjust() has a chance
to make a change.

I chose to leave trace_tcp_rcv_space_adjust() as is,
because commit 6163849d289b ("net: introduce a new tracepoint
for tcp_rcv_space_adjust") intent was to get it called after
each data delivery to user space.

Tested:

Pair of hosts in the same rack. Ideally, sk->sk_rcvbuf should be kept small.

echo "4096 131072 33554432" >/proc/sys/net/ipv4/tcp_rmem
./netserver
perf record -C10 -e tcp:tcp_rcvbuf_grow sleep 30

<launch from client : netperf -H server -T,10>

Trace for a TS enabled TCP flow (with standard ms granularity)

perf script // We can see that sk_rcvbuf is growing very fast to tcp_mem[2]
  260.500397: tcp:tcp_rcvbuf_grow: time=291 rtt_us=274 copied=110592 inq=0 space=41080 ooo=0 scaling_ratio=230 rcvbuf=131072 ...
  260.501333: tcp:tcp_rcvbuf_grow: time=555 rtt_us=364 copied=333824 inq=0 space=110592 ooo=0 scaling_ratio=230 rcvbuf=1399144 ...
  260.501664: tcp:tcp_rcvbuf_grow: time=331 rtt_us=330 copied=798720 inq=0 space=333824 ooo=0 scaling_ratio=230 rcvbuf=4110551 ...
  260.502003: tcp:tcp_rcvbuf_grow: time=340 rtt_us=330 copied=1040384 inq=49152 space=798720 ooo=0 scaling_ratio=230 rcvbuf=7006410 ...
  260.502483: tcp:tcp_rcvbuf_grow: time=479 rtt_us=330 copied=2658304 inq=49152 space=1040384 ooo=0 scaling_ratio=230 rcvbuf=7006410 ...
  260.502899: tcp:tcp_rcvbuf_grow: time=416 rtt_us=413 copied=4026368 inq=147456 space=2658304 ooo=0 scaling_ratio=230 rcvbuf=24622616 ...
  260.504233: tcp:tcp_rcvbuf_grow: time=493 rtt_us=487 copied=4800512 inq=196608 space=4026368 ooo=0 scaling_ratio=230 rcvbuf=24622616 ...
  260.504792: tcp:tcp_rcvbuf_grow: time=559 rtt_us=551 copied=5672960 inq=49152 space=4800512 ooo=0 scaling_ratio=230 rcvbuf=24622616 ...
  260.506614: tcp:tcp_rcvbuf_grow: time=610 rtt_us=607 copied=6688768 inq=180224 space=5672960 ooo=0 scaling_ratio=230 rcvbuf=24622616 ...
  260.507280: tcp:tcp_rcvbuf_grow: time=666 rtt_us=656 copied=6868992 inq=49152 space=6688768 ooo=0 scaling_ratio=230 rcvbuf=24622616 ...
  260.507979: tcp:tcp_rcvbuf_grow: time=699 rtt_us=699 copied=7000064 inq=0 space=6868992 ooo=0 scaling_ratio=230 rcvbuf=24622616 ...
  260.508681: tcp:tcp_rcvbuf_grow: time=703 rtt_us=699 copied=7208960 inq=0 space=7000064 ooo=0 scaling_ratio=230 rcvbuf=24622616 ...
  260.509426: tcp:tcp_rcvbuf_grow: time=744 rtt_us=737 copied=7569408 inq=0 space=7208960 ooo=0 scaling_ratio=230 rcvbuf=24622616 ...
  260.510213: tcp:tcp_rcvbuf_grow: time=787 rtt_us=770 copied=7880704 inq=49152 space=7569408 ooo=0 scaling_ratio=230 rcvbuf=24622616 ...
  260.511013: tcp:tcp_rcvbuf_grow: time=801 rtt_us=798 copied=8339456 inq=0 space=7880704 ooo=0 scaling_ratio=230 rcvbuf=24622616 ...
  260.511860: tcp:tcp_rcvbuf_grow: time=847 rtt_us=824 copied=8601600 inq=49152 space=8339456 ooo=0 scaling_ratio=230 rcvbuf=24622616 ...
  260.512710: tcp:tcp_rcvbuf_grow: time=850 rtt_us=846 copied=8814592 inq=65536 space=8601600 ooo=0 scaling_ratio=230 rcvbuf=24622616 ...
  260.514428: tcp:tcp_rcvbuf_grow: time=871 rtt_us=865 copied=8855552 inq=49152 space=8814592 ooo=0 scaling_ratio=230 rcvbuf=24622616 ...
  260.515333: tcp:tcp_rcvbuf_grow: time=905 rtt_us=882 copied=9228288 inq=49152 space=8855552 ooo=0 scaling_ratio=230 rcvbuf=24622616 ...
  260.516237: tcp:tcp_rcvbuf_grow: time=905 rtt_us=896 copied=9371648 inq=49152 space=9228288 ooo=0 scaling_ratio=230 rcvbuf=24622616 ...
  260.517149: tcp:tcp_rcvbuf_grow: time=911 rtt_us=909 copied=9543680 inq=49152 space=9371648 ooo=0 scaling_ratio=230 rcvbuf=24622616 ...
  260.518070: tcp:tcp_rcvbuf_grow: time=921 rtt_us=921 copied=9793536 inq=0 space=9543680 ooo=0 scaling_ratio=230 rcvbuf=24622616 ...
  260.520895: tcp:tcp_rcvbuf_grow: time=948 rtt_us=947 copied=10203136 inq=114688 space=9793536 ooo=0 scaling_ratio=230 rcvbuf=24622616 ...
  260.521853: tcp:tcp_rcvbuf_grow: time=959 rtt_us=954 copied=10293248 inq=57344 space=10203136 ooo=0 scaling_ratio=230 rcvbuf=24691992 ...
  260.522818: tcp:tcp_rcvbuf_grow: time=964 rtt_us=959 copied=10330112 inq=0 space=10293248 ooo=0 scaling_ratio=230 rcvbuf=24691992 ...
  260.524760: tcp:tcp_rcvbuf_grow: time=979 rtt_us=969 copied=10633216 inq=49152 space=10330112 ooo=0 scaling_ratio=230 rcvbuf=24691992 ...
  260.526709: tcp:tcp_rcvbuf_grow: time=975 rtt_us=973 copied=12013568 inq=163840 space=10633216 ooo=0 scaling_ratio=230 rcvbuf=25136755 ...
  260.527694: tcp:tcp_rcvbuf_grow: time=985 rtt_us=976 copied=12025856 inq=32768 space=12013568 ooo=0 scaling_ratio=230 rcvbuf=33554432 ...
  260.530655: tcp:tcp_rcvbuf_grow: time=991 rtt_us=986 copied=12050432 inq=98304 space=12025856 ooo=0 scaling_ratio=230 rcvbuf=33554432 ...
  260.533626: tcp:tcp_rcvbuf_grow: time=993 rtt_us=989 copied=12124160 inq=0 space=12050432 ooo=0 scaling_ratio=230 rcvbuf=33554432 ...
  260.538606: tcp:tcp_rcvbuf_grow: time=1000 rtt_us=994 copied=12222464 inq=49152 space=12124160 ooo=0 scaling_ratio=230 rcvbuf=33554432 ...
  260.545605: tcp:tcp_rcvbuf_grow: time=1005 rtt_us=998 copied=12263424 inq=81920 space=12222464 ooo=0 scaling_ratio=230 rcvbuf=33554432 ...
  260.553626: tcp:tcp_rcvbuf_grow: time=1005 rtt_us=999 copied=12320768 inq=12288 space=12263424 ooo=0 scaling_ratio=230 rcvbuf=33554432 ...
  260.589749: tcp:tcp_rcvbuf_grow: time=1001 rtt_us=1000 copied=12398592 inq=16384 space=12320768 ooo=0 scaling_ratio=230 rcvbuf=33554432 ...
  260.806577: tcp:tcp_rcvbuf_grow: time=1010 rtt_us=1000 copied=12402688 inq=32768 space=12398592 ooo=0 scaling_ratio=230 rcvbuf=33554432 ...
  261.002386: tcp:tcp_rcvbuf_grow: time=1002 rtt_us=1000 copied=12419072 inq=98304 space=12402688 ooo=0 scaling_ratio=230 rcvbuf=33554432 ...
  261.803432: tcp:tcp_rcvbuf_grow: time=1013 rtt_us=1000 copied=12468224 inq=49152 space=12419072 ooo=0 scaling_ratio=230 rcvbuf=33554432 ...
  261.829533: tcp:tcp_rcvbuf_grow: time=1004 rtt_us=1000 copied=12615680 inq=0 space=12468224 ooo=0 scaling_ratio=230 rcvbuf=33554432 ...
  265.505435: tcp:tcp_rcvbuf_grow: time=1007 rtt_us=1000 copied=12632064 inq=32768 space=12615680 ooo=0 scaling_ratio=230 rcvbuf=33554432 ...

We also see rtt_us going gradually to 1000 usec, causing massive overshoot.

Trace for a usec TS enabled TCP flow (us granularity)

perf script // We can see that sk_rcvbuf is growing to a smaller value,
               thanks to tight rtt_us values.
 1509.273955: tcp:tcp_rcvbuf_grow: time=396 rtt_us=377 copied=110592 inq=0 space=41080 ooo=0 scaling_ratio=230 rcvbuf=131072 ...
 1509.274366: tcp:tcp_rcvbuf_grow: time=412 rtt_us=365 copied=129024 inq=0 space=110592 ooo=0 scaling_ratio=230 rcvbuf=1399144 ...
 1509.274738: tcp:tcp_rcvbuf_grow: time=372 rtt_us=355 copied=194560 inq=0 space=129024 ooo=0 scaling_ratio=230 rcvbuf=1399144 ...
 1509.275020: tcp:tcp_rcvbuf_grow: time=282 rtt_us=257 copied=401408 inq=0 space=194560 ooo=0 scaling_ratio=230 rcvbuf=1399144 ...
 1509.275190: tcp:tcp_rcvbuf_grow: time=170 rtt_us=144 copied=741376 inq=229376 space=401408 ooo=0 scaling_ratio=230 rcvbuf=3021625 ...
 1509.275300: tcp:tcp_rcvbuf_grow: time=110 rtt_us=110 copied=1146880 inq=65536 space=741376 ooo=0 scaling_ratio=230 rcvbuf=4642390 ...
 1509.275449: tcp:tcp_rcvbuf_grow: time=149 rtt_us=106 copied=1310720 inq=737280 space=1146880 ooo=0 scaling_ratio=230 rcvbuf=5498637 ...
 1509.275560: tcp:tcp_rcvbuf_grow: time=111 rtt_us=107 copied=1388544 inq=430080 space=1310720 ooo=0 scaling_ratio=230 rcvbuf=5498637 ...
 1509.275674: tcp:tcp_rcvbuf_grow: time=114 rtt_us=113 copied=1495040 inq=421888 space=1388544 ooo=0 scaling_ratio=230 rcvbuf=5498637 ...
 1509.275800: tcp:tcp_rcvbuf_grow: time=126 rtt_us=126 copied=1572864 inq=77824 space=1495040 ooo=0 scaling_ratio=230 rcvbuf=5498637 ...
 1509.275968: tcp:tcp_rcvbuf_grow: time=168 rtt_us=161 copied=1863680 inq=172032 space=1572864 ooo=0 scaling_ratio=230 rcvbuf=5498637 ...
 1509.276129: tcp:tcp_rcvbuf_grow: time=161 rtt_us=161 copied=1941504 inq=204800 space=1863680 ooo=0 scaling_ratio=230 rcvbuf=5782790 ...
 1509.276288: tcp:tcp_rcvbuf_grow: time=159 rtt_us=158 copied=1990656 inq=131072 space=1941504 ooo=0 scaling_ratio=230 rcvbuf=5782790 ...
 1509.276900: tcp:tcp_rcvbuf_grow: time=228 rtt_us=226 copied=2883584 inq=266240 space=1990656 ooo=0 scaling_ratio=230 rcvbuf=5782790 ...
 1509.277819: tcp:tcp_rcvbuf_grow: time=242 rtt_us=236 copied=3022848 inq=0 space=2883584 ooo=0 scaling_ratio=230 rcvbuf=12316197 ...
 1509.278072: tcp:tcp_rcvbuf_grow: time=253 rtt_us=247 copied=3055616 inq=49152 space=3022848 ooo=0 scaling_ratio=230 rcvbuf=12316197 ...
 1509.279560: tcp:tcp_rcvbuf_grow: time=268 rtt_us=264 copied=3133440 inq=180224 space=3055616 ooo=0 scaling_ratio=230 rcvbuf=12316197 ...
 1509.279833: tcp:tcp_rcvbuf_grow: time=274 rtt_us=270 copied=3424256 inq=0 space=3133440 ooo=0 scaling_ratio=230 rcvbuf=12316197 ...
 1509.282187: tcp:tcp_rcvbuf_grow: time=277 rtt_us=273 copied=3465216 inq=180224 space=3424256 ooo=0 scaling_ratio=230 rcvbuf=12316197 ...
 1509.284685: tcp:tcp_rcvbuf_grow: time=292 rtt_us=292 copied=3481600 inq=147456 space=3465216 ooo=0 scaling_ratio=230 rcvbuf=12316197 ...
 1509.284983: tcp:tcp_rcvbuf_grow: time=297 rtt_us=295 copied=3702784 inq=45056 space=3481600 ooo=0 scaling_ratio=230 rcvbuf=12316197 ...
 1509.285596: tcp:tcp_rcvbuf_grow: time=311 rtt_us=310 copied=3723264 inq=40960 space=3702784 ooo=0 scaling_ratio=230 rcvbuf=12316197 ...
 1509.285909: tcp:tcp_rcvbuf_grow: time=313 rtt_us=304 copied=3846144 inq=196608 space=3723264 ooo=0 scaling_ratio=230 rcvbuf=12316197 ...
 1509.291654: tcp:tcp_rcvbuf_grow: time=322 rtt_us=311 copied=3960832 inq=49152 space=3846144 ooo=0 scaling_ratio=230 rcvbuf=12316197 ...
 1509.291986: tcp:tcp_rcvbuf_grow: time=333 rtt_us=330 copied=4075520 inq=360448 space=3960832 ooo=0 scaling_ratio=230 rcvbuf=12316197 ...
 1509.292319: tcp:tcp_rcvbuf_grow: time=332 rtt_us=332 copied=4079616 inq=65536 space=4075520 ooo=0 scaling_ratio=230 rcvbuf=12316197 ...
 1509.292666: tcp:tcp_rcvbuf_grow: time=348 rtt_us=347 copied=4177920 inq=212992 space=4079616 ooo=0 scaling_ratio=230 rcvbuf=12316197 ...
 1509.293015: tcp:tcp_rcvbuf_grow: time=349 rtt_us=345 copied=4276224 inq=262144 space=4177920 ooo=0 scaling_ratio=230 rcvbuf=12316197 ...
 1509.293371: tcp:tcp_rcvbuf_grow: time=356 rtt_us=346 copied=4415488 inq=49152 space=4276224 ooo=0 scaling_ratio=230 rcvbuf=12316197 ...
 1509.515798: tcp:tcp_rcvbuf_grow: time=424 rtt_us=411 copied=4833280 inq=81920 space=4415488 ooo=0 scaling_ratio=230 rcvbuf=12316197 ...

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Wei Wang <weiwan@google.com>
Reviewed-by: Neal Cardwell <ncardwell@google.com>
---
 include/trace/events/tcp.h | 73 ++++++++++++++++++++++++++++++++++++++
 net/ipv4/tcp_input.c       |  2 ++
 2 files changed, 75 insertions(+)

diff --git a/include/trace/events/tcp.h b/include/trace/events/tcp.h
index 53e878fa14d14ee1f6d072bfdd8179cd8b995d6f..006c2116c8f611c2caa401528af8cd11e6a7b703 100644
--- a/include/trace/events/tcp.h
+++ b/include/trace/events/tcp.h
@@ -213,6 +213,79 @@ DEFINE_EVENT(tcp_event_sk, tcp_rcv_space_adjust,
 	TP_ARGS(sk)
 );
 
+TRACE_EVENT(tcp_rcvbuf_grow,
+
+	TP_PROTO(struct sock *sk, int time),
+
+	TP_ARGS(sk, time),
+
+	TP_STRUCT__entry(
+		__field(int, time)
+		__field(__u32, rtt_us)
+		__field(__u32, copied)
+		__field(__u32, inq)
+		__field(__u32, space)
+		__field(__u32, ooo_space)
+		__field(__u32, rcvbuf)
+		__field(__u8, scaling_ratio)
+		__field(__u16, sport)
+		__field(__u16, dport)
+		__field(__u16, family)
+		__array(__u8, saddr, 4)
+		__array(__u8, daddr, 4)
+		__array(__u8, saddr_v6, 16)
+		__array(__u8, daddr_v6, 16)
+		__field(const void *, skaddr)
+		__field(__u64, sock_cookie)
+	),
+
+	TP_fast_assign(
+		struct inet_sock *inet = inet_sk(sk);
+		struct tcp_sock *tp = tcp_sk(sk);
+		__be32 *p32;
+
+		__entry->time = time;
+		__entry->rtt_us = tp->rcv_rtt_est.rtt_us >> 3;
+		__entry->copied = tp->copied_seq - tp->rcvq_space.seq;
+		__entry->inq = tp->rcv_nxt - tp->copied_seq;
+		__entry->space = tp->rcvq_space.space;
+		__entry->ooo_space = RB_EMPTY_ROOT(&tp->out_of_order_queue) ? 0 :
+				     TCP_SKB_CB(tp->ooo_last_skb)->end_seq -
+				     tp->rcv_nxt;
+
+		__entry->rcvbuf = sk->sk_rcvbuf;
+		__entry->scaling_ratio = tp->scaling_ratio;
+		__entry->sport = ntohs(inet->inet_sport);
+		__entry->dport = ntohs(inet->inet_dport);
+		__entry->family = sk->sk_family;
+
+		p32 = (__be32 *) __entry->saddr;
+		*p32 = inet->inet_saddr;
+
+		p32 = (__be32 *) __entry->daddr;
+		*p32 = inet->inet_daddr;
+
+		TP_STORE_ADDRS(__entry, inet->inet_saddr, inet->inet_daddr,
+			       sk->sk_v6_rcv_saddr, sk->sk_v6_daddr);
+
+		__entry->skaddr = sk;
+		__entry->sock_cookie = sock_gen_cookie(sk);
+	),
+
+	TP_printk("time=%u rtt_us=%u copied=%u inq=%u space=%u ooo=%u scaling_ratio=%u rcvbuf=%u "
+		  "family=%s sport=%hu dport=%hu saddr=%pI4 daddr=%pI4 "
+		  "saddrv6=%pI6c daddrv6=%pI6c skaddr=%p sock_cookie=%llx",
+		  __entry->time, __entry->rtt_us, __entry->copied,
+		  __entry->inq, __entry->space, __entry->ooo_space,
+		  __entry->scaling_ratio, __entry->rcvbuf,
+		  show_family_name(__entry->family),
+		  __entry->sport, __entry->dport,
+		  __entry->saddr, __entry->daddr,
+		  __entry->saddr_v6, __entry->daddr_v6,
+		  __entry->skaddr,
+		  __entry->sock_cookie)
+);
+
 TRACE_EVENT(tcp_retransmit_synack,
 
 	TP_PROTO(const struct sock *sk, const struct request_sock *req),
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index a35018e2d0ba27b14d0b59d3728f7181b1a51161..88beb6d0f7b5981e65937a6727a1111fd341335b 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -769,6 +769,8 @@ void tcp_rcv_space_adjust(struct sock *sk)
 	if (copied <= tp->rcvq_space.space)
 		goto new_measure;
 
+	trace_tcp_rcvbuf_grow(sk, time);
+
 	/* A bit of theory :
 	 * copied = bytes received in previous RTT, our base window
 	 * To cope with packet losses, we need a 2x factor
-- 
2.49.0.1045.g170613ef41-goog


