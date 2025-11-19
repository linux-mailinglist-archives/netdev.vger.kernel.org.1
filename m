Return-Path: <netdev+bounces-239880-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A74C6C6D87E
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 09:55:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 33DF34F76C0
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 08:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C09306D49;
	Wed, 19 Nov 2025 08:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H/ndBozK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD0C306B0F
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 08:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763542102; cv=none; b=XJJeMqcmhOOkrBGGFiGX/pR/qw3J4XJbWvWMM57DUAo2d38IKlOphjO/GZ+eYjz+JzlUkrw4E1Tr/MV/KG8lWoMfSaZ7Ow+WnmrqA7uePIFU1dRZsLUn13gvsylTRQVyFgm4rl/mQ++c70Cb4SVARxsv8h6ciVmtvcLW17jQ/4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763542102; c=relaxed/simple;
	bh=OjCMJ2f9i5wm/xrGMb9nZfJ/u7IKSMzWj7idQoWPbTM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=C1DkI4fgUiDk+ry+MeTRA+2peYhwcXI51pGRt0SLjXtES30H+Gy3kIdEAhzy6NAYfKLWF5Sz0W8bj7y+G4b5o+Y4Dj4sY3XTL4BEvwNxLheys5C4rDoqVjuSdC4omPs9AkXGaEASVTobZCJ/O25t7iysiVOw67vDH0FiWoomuUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H/ndBozK; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-88236bcdfc4so181604546d6.1
        for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 00:48:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763542098; x=1764146898; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OVDi4UPpAKB0PaxyeAKkTRROX+Z3xhAurLS3CgWOV3c=;
        b=H/ndBozKvt7DkM0u07L/ev7ILNNq9rMuEkyJKgF5hUgNLS7SWkY1G4zmpdgNW8wc9k
         kPi8Q+EsxoRUMLNTrdP+Z3yccdbDXxlWEGiQpXptWF4dA7Hphk13m0ne1R8omakaJE1d
         bSvXKJCqkJehX72ji0noAAt5HwO448d0rEki0bY65nOnfuL/rj/kSB8R4Hd02P28nUZ5
         kgXrTfMPReT1K1suky1zem5gDDiZosROjW/Ctw3/+ipJ1u/D7kjINJ49UiC2n8bcYoVz
         jJM+9zg2RtUqnz8VhOyjXs2Su5yBISTCtxroaSZ6PTx5bj6EDJhNqm02LSOOFCUgItvE
         46mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763542098; x=1764146898;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OVDi4UPpAKB0PaxyeAKkTRROX+Z3xhAurLS3CgWOV3c=;
        b=P+50fouaTMboBkiWDzYK6tLskOGzs7KvVz1/bUvWDA5sj5oiBF9syukOKjAIZwrXPM
         ChoalIlusH5J/jMTDTxJ9Ep2/Pi3gi5rbMzopzhw/ivG5HSwwbKmnaqwQydp2w2jS4OS
         /cZX7GA2qR1jineCFqvCkqX6sthVPavd5UAbrRmset+DUE4I6PLMMbFaZ0rJ59WKuUoI
         uQTf7+5BcXhnhAS5RtmD4+gDX5wvsaLX5o5K+mLkbqQRJaNM0knYmoMCLHgF0I1ZZYp2
         4LfOEjCDzNKo38ZcNpX0s3zqIPyrAZoVHLbvMzy+7i3PYo0GXO7jwkkMPK5t41epHOaO
         kBMg==
X-Forwarded-Encrypted: i=1; AJvYcCVSkT4dV47NI80G1hSvnoDZmuFnlOWqfONgmLQyCRwE2AhI7tDmyZx0C8XlsNOFQRGOAKJrmcQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgZ6tNjQQ84IdMWFXgVsVlJmlYkGF9AryKrl3zWhr2jHnI9tKR
	eXkVjpUtmlu/fEDtec9GIk/d+lFZfBZTUz5DXh2lF8H7i+7cvTzdEO71hzW8uUHTaEnroMvjx2B
	oIcCuR0Tx5hRy5w==
X-Google-Smtp-Source: AGHT+IGoezp6ZoN1D7166PtfOmG84CftAXx78Gc7q9eKDAE3hghVhWqg2KmD/f2+9fbE5EotN4wzbzRg6+xKpQ==
X-Received: from qvb12.prod.google.com ([2002:a05:6214:600c:b0:882:6bef:6a6c])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:2622:b0:880:3ce2:65ad with SMTP id 6a1803df08f44-88292658f3cmr280122916d6.41.1763542098323;
 Wed, 19 Nov 2025 00:48:18 -0800 (PST)
Date: Wed, 19 Nov 2025 08:48:13 +0000
In-Reply-To: <20251119084813.3684576-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251119084813.3684576-1-edumazet@google.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251119084813.3684576-3-edumazet@google.com>
Subject: [PATCH v2 net-next 2/2] tcp: add net.ipv4.tcp_rcvbuf_low_rtt
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Rick Jones <jonesrick@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

This is a follow up of commit aa251c84636c ("tcp: fix too slow
tcp_rcvbuf_grow() action") which brought again the issue that I tried
to fix in commit 65c5287892e9 ("tcp: fix sk_rcvbuf overshoot")

We also recently increased tcp_rmem[2] to 32 MB in commit 572be9bf9d0d
("tcp: increase tcp_rmem[2] to 32 MB")

Idea of this patch is to not let tcp_rcvbuf_grow() grow sk->sk_rcvbuf
too fast for small RTT flows. If sk->sk_rcvbuf is too big, this can
force NIC driver to not recycle pages from their page pool, and also
can cause cache evictions for DDIO enabled cpus/NIC, as receivers
are usually slower than senders.

Add net.ipv4.tcp_rcvbuf_low_rtt sysctl, set by default to 1000 usec (1 ms)

If RTT if smaller than the sysctl value, use the RTT/tcp_rcvbuf_low_rtt
ratio to control sk_rcvbuf inflation.

Tested:

Pair of hosts with a 200Gbit IDPF NIC. Using netperf/netserver

Client initiates 8 TCP bulk flows, asking netserver to use CPU #10 only.

super_netperf 8 -H server -T,10 -l 30

On server, use perf -e tcp:tcp_rcvbuf_grow while test is running.

Before:

sysctl -w net.ipv4.tcp_rcvbuf_low_rtt=1
perf record -a -e tcp:tcp_rcvbuf_grow sleep 30 ; perf script|tail -20|cut -c30-230
 1153.051201: tcp:tcp_rcvbuf_grow: time=398 rtt_us=382 copied=6905856 inq=180224 space=6115328 ooo=0 scaling_ratio=240 rcvbuf=27666235 rcv_ssthresh=25878235 window_clamp=25937095 rcv_wnd=25600000 famil
 1153.138752: tcp:tcp_rcvbuf_grow: time=446 rtt_us=413 copied=5529600 inq=180224 space=4505600 ooo=0 scaling_ratio=240 rcvbuf=23068672 rcv_ssthresh=21571860 window_clamp=21626880 rcv_wnd=21286912 famil
 1153.361484: tcp:tcp_rcvbuf_grow: time=415 rtt_us=380 copied=7061504 inq=204800 space=6725632 ooo=0 scaling_ratio=240 rcvbuf=27666235 rcv_ssthresh=25878235 window_clamp=25937095 rcv_wnd=25600000 famil
 1153.457642: tcp:tcp_rcvbuf_grow: time=483 rtt_us=421 copied=5885952 inq=720896 space=4407296 ooo=0 scaling_ratio=240 rcvbuf=23763511 rcv_ssthresh=22223271 window_clamp=22278291 rcv_wnd=21430272 famil
 1153.466002: tcp:tcp_rcvbuf_grow: time=308 rtt_us=281 copied=3244032 inq=180224 space=2883584 ooo=0 scaling_ratio=240 rcvbuf=44854314 rcv_ssthresh=41992059 window_clamp=42050919 rcv_wnd=41713664 famil
 1153.747792: tcp:tcp_rcvbuf_grow: time=394 rtt_us=332 copied=4460544 inq=585728 space=3063808 ooo=0 scaling_ratio=240 rcvbuf=44854314 rcv_ssthresh=41992059 window_clamp=42050919 rcv_wnd=41373696 famil
 1154.260747: tcp:tcp_rcvbuf_grow: time=652 rtt_us=226 copied=10977280 inq=737280 space=9486336 ooo=0 scaling_ratio=240 rcvbuf=31165538 rcv_ssthresh=29197743 window_clamp=29217691 rcv_wnd=28368896 fami
 1154.375019: tcp:tcp_rcvbuf_grow: time=461 rtt_us=443 copied=7573504 inq=507904 space=6856704 ooo=0 scaling_ratio=240 rcvbuf=27666235 rcv_ssthresh=25878235 window_clamp=25937095 rcv_wnd=25288704 famil
 1154.463072: tcp:tcp_rcvbuf_grow: time=494 rtt_us=408 copied=7983104 inq=200704 space=7065600 ooo=0 scaling_ratio=240 rcvbuf=27666235 rcv_ssthresh=25878235 window_clamp=25937095 rcv_wnd=25579520 famil
 1154.474658: tcp:tcp_rcvbuf_grow: time=507 rtt_us=459 copied=5586944 inq=540672 space=4718592 ooo=0 scaling_ratio=240 rcvbuf=17852266 rcv_ssthresh=16692999 window_clamp=16736499 rcv_wnd=16056320 famil
 1154.584657: tcp:tcp_rcvbuf_grow: time=494 rtt_us=427 copied=8126464 inq=204800 space=7782400 ooo=0 scaling_ratio=240 rcvbuf=27666235 rcv_ssthresh=25878235 window_clamp=25937095 rcv_wnd=25600000 famil
 1154.702117: tcp:tcp_rcvbuf_grow: time=480 rtt_us=406 copied=5734400 inq=180224 space=5349376 ooo=0 scaling_ratio=240 rcvbuf=23068672 rcv_ssthresh=21571860 window_clamp=21626880 rcv_wnd=21286912 famil
 1155.941595: tcp:tcp_rcvbuf_grow: time=717 rtt_us=670 copied=11042816 inq=3784704 space=7159808 ooo=0 scaling_ratio=240 rcvbuf=19581357 rcv_ssthresh=18333222 window_clamp=18357522 rcv_wnd=14614528 fam
 1156.384735: tcp:tcp_rcvbuf_grow: time=529 rtt_us=473 copied=9011200 inq=180224 space=7258112 ooo=0 scaling_ratio=240 rcvbuf=19581357 rcv_ssthresh=18333222 window_clamp=18357522 rcv_wnd=18018304 famil
 1157.821676: tcp:tcp_rcvbuf_grow: time=529 rtt_us=272 copied=8224768 inq=602112 space=6545408 ooo=0 scaling_ratio=240 rcvbuf=67000000 rcv_ssthresh=62793576 window_clamp=62812500 rcv_wnd=62115840 famil
 1158.906379: tcp:tcp_rcvbuf_grow: time=710 rtt_us=445 copied=11845632 inq=540672 space=10240000 ooo=0 scaling_ratio=240 rcvbuf=31165538 rcv_ssthresh=29205935 window_clamp=29217691 rcv_wnd=28536832 fam
 1164.600160: tcp:tcp_rcvbuf_grow: time=841 rtt_us=430 copied=12976128 inq=1290240 space=11304960 ooo=0 scaling_ratio=240 rcvbuf=31165538 rcv_ssthresh=29212591 window_clamp=29217691 rcv_wnd=27856896 fa
 1165.163572: tcp:tcp_rcvbuf_grow: time=845 rtt_us=800 copied=12632064 inq=540672 space=7921664 ooo=0 scaling_ratio=240 rcvbuf=27666235 rcv_ssthresh=25912795 window_clamp=25937095 rcv_wnd=25260032 fami
 1165.653464: tcp:tcp_rcvbuf_grow: time=388 rtt_us=309 copied=4493312 inq=180224 space=3874816 ooo=0 scaling_ratio=240 rcvbuf=44854314 rcv_ssthresh=41995899 window_clamp=42050919 rcv_wnd=41713664 famil
 1166.651211: tcp:tcp_rcvbuf_grow: time=556 rtt_us=553 copied=6328320 inq=540672 space=5554176 ooo=0 scaling_ratio=240 rcvbuf=23068672 rcv_ssthresh=21571860 window_clamp=21626880 rcv_wnd=20946944 famil

After:

sysctl -w net.ipv4.tcp_rcvbuf_low_rtt=1000
perf record -a -e tcp:tcp_rcvbuf_grow sleep 30 ; perf script|tail -20|cut -c30-230
 1457.053149: tcp:tcp_rcvbuf_grow: time=128 rtt_us=24 copied=1441792 inq=40960 space=1269760 ooo=0 scaling_ratio=240 rcvbuf=2960741 rcv_ssthresh=2605474 window_clamp=2775694 rcv_wnd=2568192 family=AF_I
 1458.000778: tcp:tcp_rcvbuf_grow: time=128 rtt_us=31 copied=1441792 inq=24576 space=1400832 ooo=0 scaling_ratio=240 rcvbuf=3060163 rcv_ssthresh=2810042 window_clamp=2868902 rcv_wnd=2674688 family=AF_I
 1458.088059: tcp:tcp_rcvbuf_grow: time=190 rtt_us=110 copied=3227648 inq=385024 space=2781184 ooo=0 scaling_ratio=240 rcvbuf=6728240 rcv_ssthresh=6252705 window_clamp=6307725 rcv_wnd=5799936 family=AF
 1458.148549: tcp:tcp_rcvbuf_grow: time=232 rtt_us=129 copied=3956736 inq=237568 space=2842624 ooo=0 scaling_ratio=240 rcvbuf=6731333 rcv_ssthresh=6252705 window_clamp=6310624 rcv_wnd=5918720 family=AF
 1458.466861: tcp:tcp_rcvbuf_grow: time=193 rtt_us=83 copied=2949120 inq=180224 space=2457600 ooo=0 scaling_ratio=240 rcvbuf=5751438 rcv_ssthresh=5357689 window_clamp=5391973 rcv_wnd=5054464 family=AF_
 1458.775476: tcp:tcp_rcvbuf_grow: time=257 rtt_us=127 copied=4304896 inq=352256 space=3346432 ooo=0 scaling_ratio=240 rcvbuf=8067131 rcv_ssthresh=7523275 window_clamp=7562935 rcv_wnd=7061504 family=AF
 1458.776631: tcp:tcp_rcvbuf_grow: time=200 rtt_us=96 copied=3260416 inq=143360 space=2768896 ooo=0 scaling_ratio=240 rcvbuf=6397256 rcv_ssthresh=5938567 window_clamp=5997427 rcv_wnd=5828608 family=AF_
 1459.707973: tcp:tcp_rcvbuf_grow: time=215 rtt_us=96 copied=2506752 inq=163840 space=1388544 ooo=0 scaling_ratio=240 rcvbuf=3068867 rcv_ssthresh=2768282 window_clamp=2877062 rcv_wnd=2555904 family=AF_
 1460.246494: tcp:tcp_rcvbuf_grow: time=231 rtt_us=80 copied=3756032 inq=204800 space=3117056 ooo=0 scaling_ratio=240 rcvbuf=7288091 rcv_ssthresh=6773725 window_clamp=6832585 rcv_wnd=6471680 family=AF_
 1460.714596: tcp:tcp_rcvbuf_grow: time=270 rtt_us=110 copied=4714496 inq=311296 space=3719168 ooo=0 scaling_ratio=240 rcvbuf=8957739 rcv_ssthresh=8339020 window_clamp=8397880 rcv_wnd=7933952 family=AF
 1462.029977: tcp:tcp_rcvbuf_grow: time=101 rtt_us=19 copied=1105920 inq=40960 space=1036288 ooo=0 scaling_ratio=240 rcvbuf=2338970 rcv_ssthresh=2091684 window_clamp=2192784 rcv_wnd=1986560 family=AF_I
 1462.802385: tcp:tcp_rcvbuf_grow: time=89 rtt_us=45 copied=1069056 inq=0 space=1064960 ooo=0 scaling_ratio=240 rcvbuf=2338970 rcv_ssthresh=2091684 window_clamp=2192784 rcv_wnd=2035712 family=AF_INET6
 1462.918648: tcp:tcp_rcvbuf_grow: time=105 rtt_us=33 copied=1441792 inq=180224 space=1069056 ooo=0 scaling_ratio=240 rcvbuf=2383282 rcv_ssthresh=2091684 window_clamp=2234326 rcv_wnd=1896448 family=AF_
 1463.222533: tcp:tcp_rcvbuf_grow: time=273 rtt_us=144 copied=4603904 inq=385024 space=3469312 ooo=0 scaling_ratio=240 rcvbuf=8422564 rcv_ssthresh=7891053 window_clamp=7896153 rcv_wnd=7409664 family=AF
 1466.519312: tcp:tcp_rcvbuf_grow: time=130 rtt_us=23 copied=1343488 inq=0 space=1261568 ooo=0 scaling_ratio=240 rcvbuf=2780158 rcv_ssthresh=2493778 window_clamp=2606398 rcv_wnd=2494464 family=AF_INET6
 1466.681003: tcp:tcp_rcvbuf_grow: time=128 rtt_us=21 copied=1441792 inq=12288 space=1343488 ooo=0 scaling_ratio=240 rcvbuf=2932027 rcv_ssthresh=2578555 window_clamp=2748775 rcv_wnd=2568192 family=AF_I
 1470.689959: tcp:tcp_rcvbuf_grow: time=255 rtt_us=122 copied=3932160 inq=204800 space=3551232 ooo=0 scaling_ratio=240 rcvbuf=8182038 rcv_ssthresh=7647384 window_clamp=7670660 rcv_wnd=7442432 family=AF
 1471.754154: tcp:tcp_rcvbuf_grow: time=188 rtt_us=95 copied=2138112 inq=577536 space=1429504 ooo=0 scaling_ratio=240 rcvbuf=3113650 rcv_ssthresh=2806426 window_clamp=2919046 rcv_wnd=2248704 family=AF_
 1476.813542: tcp:tcp_rcvbuf_grow: time=269 rtt_us=99 copied=3088384 inq=180224 space=2564096 ooo=0 scaling_ratio=240 rcvbuf=6219470 rcv_ssthresh=5771893 window_clamp=5830753 rcv_wnd=5509120 family=AF_
 1477.738309: tcp:tcp_rcvbuf_grow: time=166 rtt_us=54 copied=1777664 inq=180224 space=1417216 ooo=0 scaling_ratio=240 rcvbuf=3117118 rcv_ssthresh=2874958 window_clamp=2922298 rcv_wnd=2613248 family=AF_

We can see sk_rcvbuf values are much smaller, and that rtt_us (estimation of rtt
from a receiver point of view) is kept small, instead of being bloated.

No difference in throughput.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 Documentation/networking/ip-sysctl.rst         | 10 ++++++++++
 .../net_cachelines/netns_ipv4_sysctl.rst       |  1 +
 include/net/netns/ipv4.h                       |  1 +
 net/core/net_namespace.c                       |  2 ++
 net/ipv4/sysctl_net_ipv4.c                     |  9 +++++++++
 net/ipv4/tcp_input.c                           | 18 ++++++++++++++----
 net/ipv4/tcp_ipv4.c                            |  1 +
 7 files changed, 38 insertions(+), 4 deletions(-)

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index f4ad739a6b532914e4091c425828b329ee342bc6..bc9a01606daf5a3c86477d74fdc8565eb44fd508 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -673,6 +673,16 @@ tcp_moderate_rcvbuf - BOOLEAN
 
 	Default: 1 (enabled)
 
+tcp_rcvbuf_low_rtt - INTEGER
+	rcvbuf autotuning can over estimate final socket rcvbuf, which
+	can lead to cache trashing for high throughput flows.
+
+	For small RTT flows (below tcp_rcvbuf_low_rtt usecs), we can relax
+	rcvbuf growth: Few additional ms to reach the final (and smaller)
+	rcvbuf is a good tradeoff.
+
+	Default : 1000 (1 ms)
+
 tcp_mtu_probing - INTEGER
 	Controls TCP Packetization-Layer Path MTU Discovery.  Takes three
 	values:
diff --git a/Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst b/Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst
index 5d5d54fb6ab1b2697d06e0b0ba8c0a91b5dbd438..beaf1880a19bf4cfa578e162c571e09f7a9dffbe 100644
--- a/Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst
+++ b/Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst
@@ -103,6 +103,7 @@ u8                              sysctl_tcp_frto
 u8                              sysctl_tcp_nometrics_save                                                            TCP_LAST_ACK/tcp_update_metrics
 u8                              sysctl_tcp_no_ssthresh_metrics_save                                                  TCP_LAST_ACK/tcp_(update/init)_metrics
 u8                              sysctl_tcp_moderate_rcvbuf                                       read_mostly         tcp_rcvbuf_grow()
+u32                             sysctl_tcp_rcvbuf_low_rtt                                        read_mostly         tcp_rcvbuf_grow()
 u8                              sysctl_tcp_tso_win_divisor                   read_mostly                             tcp_tso_should_defer(tcp_write_xmit)
 u8                              sysctl_tcp_workaround_signed_windows                                                 tcp_select_window
 int                             sysctl_tcp_limit_output_bytes                read_mostly                             tcp_small_queue_check(tcp_write_xmit)
diff --git a/include/net/netns/ipv4.h b/include/net/netns/ipv4.h
index 11837d3ccc0ab6dbd6eaacc32536c912b3752202..2dbd46fc4734b78201818ecf6065237d475101ce 100644
--- a/include/net/netns/ipv4.h
+++ b/include/net/netns/ipv4.h
@@ -85,6 +85,7 @@ struct netns_ipv4 {
 	/* 3 bytes hole, try to pack */
 	int sysctl_tcp_reordering;
 	int sysctl_tcp_rmem[3];
+	int sysctl_tcp_rcvbuf_low_rtt;
 	__cacheline_group_end(netns_ipv4_read_rx);
 
 	struct inet_timewait_death_row tcp_death_row;
diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index c8adbbe014518602857b5f36b90da64333fbeafd..dfad7c03b80945d8be0444caa202f127ab3854e3 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -1227,6 +1227,8 @@ static void __init netns_ipv4_struct_check(void)
 	/* RX readonly hotpath cache line */
 	CACHELINE_ASSERT_GROUP_MEMBER(struct netns_ipv4, netns_ipv4_read_rx,
 				      sysctl_tcp_moderate_rcvbuf);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct netns_ipv4, netns_ipv4_read_rx,
+				      sysctl_tcp_rcvbuf_low_rtt);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct netns_ipv4, netns_ipv4_read_rx,
 				      sysctl_ip_early_demux);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct netns_ipv4, netns_ipv4_read_rx,
diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
index 35367f8e2da32f2c7de5a06164f5e47c8929c8f1..a1a50a5c80dc11eac19aa5c4d2ef0d48ab12a071 100644
--- a/net/ipv4/sysctl_net_ipv4.c
+++ b/net/ipv4/sysctl_net_ipv4.c
@@ -1342,6 +1342,15 @@ static struct ctl_table ipv4_net_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dou8vec_minmax,
 	},
+	{
+		.procname	= "tcp_rcvbuf_low_rtt",
+		.data		= &init_net.ipv4.sysctl_tcp_rcvbuf_low_rtt,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_INT_MAX,
+	},
 	{
 		.procname	= "tcp_tso_win_divisor",
 		.data		= &init_net.ipv4.sysctl_tcp_tso_win_divisor,
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 9df5d75156057e6ba6b64ff7a0517809e8d1d49a..198f8a0d37be04f78da9268a230c9494b50b672a 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -896,6 +896,7 @@ void tcp_rcvbuf_grow(struct sock *sk, u32 newval)
 	const struct net *net = sock_net(sk);
 	struct tcp_sock *tp = tcp_sk(sk);
 	u32 rcvwin, rcvbuf, cap, oldval;
+	u32 rtt_threshold, rtt_us;
 	u64 grow;
 
 	oldval = tp->rcvq_space.space;
@@ -908,10 +909,19 @@ void tcp_rcvbuf_grow(struct sock *sk, u32 newval)
 	/* DRS is always one RTT late. */
 	rcvwin = newval << 1;
 
-	/* slow start: allow the sender to double its rate. */
-	grow = (u64)rcvwin * (newval - oldval);
-	do_div(grow, oldval);
-	rcvwin += grow << 1;
+	rtt_us = tp->rcv_rtt_est.rtt_us >> 3;
+	rtt_threshold = READ_ONCE(net->ipv4.sysctl_tcp_rcvbuf_low_rtt);
+	if (rtt_us < rtt_threshold) {
+		/* For small RTT, we set @grow to rcvwin * rtt_us/rtt_threshold.
+		 * It might take few additional ms to reach 'line rate',
+		 * but will avoid sk_rcvbuf inflation and poor cache use.
+		 */
+		grow = div_u64((u64)rcvwin * rtt_us, rtt_threshold);
+	} else {
+		/* slow start: allow the sender to double its rate. */
+		grow = div_u64(((u64)rcvwin << 1) * (newval - oldval), oldval);
+	}
+	rcvwin += grow;
 
 	if (!RB_EMPTY_ROOT(&tp->out_of_order_queue))
 		rcvwin += TCP_SKB_CB(tp->ooo_last_skb)->end_seq - tp->rcv_nxt;
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 6fcaecb67284ecade97b623d955dbbe2cd02a831..e0bb8d9e2d9c8c4a49519655d627e6e4d1b1cbac 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -3566,6 +3566,7 @@ static int __net_init tcp_sk_init(struct net *net)
 	net->ipv4.sysctl_tcp_adv_win_scale = 1;
 	net->ipv4.sysctl_tcp_frto = 2;
 	net->ipv4.sysctl_tcp_moderate_rcvbuf = 1;
+	net->ipv4.sysctl_tcp_rcvbuf_low_rtt = USEC_PER_MSEC;
 	/* This limits the percentage of the congestion window which we
 	 * will allow a single TSO frame to consume.  Building TSO frames
 	 * which are too large can cause TCP streams to be bursty.
-- 
2.52.0.rc1.455.g30608eb744-goog


