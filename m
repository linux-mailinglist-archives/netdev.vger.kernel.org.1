Return-Path: <netdev+bounces-94110-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 276D98BE260
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 14:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25B51B23A1C
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 12:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8CB715B12B;
	Tue,  7 May 2024 12:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AgT2vZTb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05337158A2D;
	Tue,  7 May 2024 12:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715085782; cv=none; b=jjeOjkcDLumMY/tNO06GWDrujnvv6Cze4fwxF8QaRbdGTJ+oc0pBG+XicK0qsEbIViMGakPdxcpydo7/paljlcVoMEKiRgDwggAEuPbozK3Ys0oeifUFTzgT+qekWT2dKKWPYuwBv7B/ANkxIdFBXqcs+54Dh9tXKt3302knMwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715085782; c=relaxed/simple;
	bh=pQ0VyLEWPbTzv8ueT/SYA25grM78ReWuMdOeMbNrUDg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qrKCUkKjAQWylYT75GwZyZEkw5J9d6b8NMP51bGz1+gPfaQKkKZIdnITI+b1EljUIzn0n0ONClJlL0AxdhL1QIntnU042YzNAsMG6wXu0UlC2rlfP9eYkVYngDUfle5Bh1UHa9zxjfBa+DLk+Ok7MHYE5Rr6i6uZrs7P3fV1rVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AgT2vZTb; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-34d8f6cfe5bso2136927f8f.3;
        Tue, 07 May 2024 05:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715085779; x=1715690579; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UeeAUA+M1CrSeGLqCio6FXkyYBfV90EEN3G250oeFOA=;
        b=AgT2vZTb2uIjxuY7UvG1xtj1dcxwuDtSqq0xonzoR11Z7jelq6oe5iWv2yTyYqenrv
         /kK2edpOwdLgT0ohHRLyQy2E4W0XJ5VJF1sluCFv4X60owkl5fgXOmc620TRLG/nhmw7
         uHTajN7Hy7lqjxfMHDSQtEQoXLJnG3PHU+Na72rBgILztYd/VuO/x2YUtklk953E4ekX
         yXbKq+sE0AvgnZWFdmN9oGZp/XkZwb3AK0R6ZqJy9fSEBG/5ug7itGqvSvN1su9JiyVm
         +SWeopoir7y2xpIzCizi9dFCAq8jC3PXIJsSyvlLGeD2qm00TJxr9fKWghKuJX+vBQLn
         oUBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715085779; x=1715690579;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UeeAUA+M1CrSeGLqCio6FXkyYBfV90EEN3G250oeFOA=;
        b=wrzmaMKzS+jVbgNjnLkNq3/GqWHaXutd+eXeBGZ9Ti0vHmNcTjp90KwLQLsdnN+F69
         7QrVGf+8TY5+ekcfT4gjdrqTnhaJb8dhv27OExPfLLwgdWLf6gT3K4RFQbe4hEjYBABc
         gLIoWRIN3p/9ks95WjO2Dv+JAwHFQSjxh+mdeMAJn1ka2SxsiSUqTMbA2BCdvxGSB6yG
         KMmQyXjknO5YYX+KGr5m/u9XnMDtM1K6ZAQoOHrtJuX4dhTmFPOkdjrVzPqQMH0XsY/h
         dWD05NJlDVoHeiwhMw+j17O81rBBMcmPt8ZBkQRaU+L9Bs1jCcCLeuRIbDL/hdZikIlV
         U1EA==
X-Forwarded-Encrypted: i=1; AJvYcCX+uE6uyYCUpk/8Ij6F5qHDWIbwbDF3FxFYstHGglacgRW8XEnURLjfOPPq0cpDf5QKLrxO8WLuNu3Hc7hp+QZCwH3Y3eCMqkTg6FMi+7w0Vpeo31sSDyoJuow2PS0V58XZIHP3
X-Gm-Message-State: AOJu0Yy3SWnl5OmaxticlcFEW+9tEtAUe/Fj26FiHHg+3STrgV+huzYA
	Q1seyyvJXU0OfW+VcKpaaNNwL8nc5Rh18TT8ZUfDFlS/47guSQW7
X-Google-Smtp-Source: AGHT+IGCppBeEMOhD2xrR4PCOwGHoUpQx6Wz2LFnJVIyZ0e9u1sGi4E1te2Y5/irFZXNAMndMk5ROA==
X-Received: by 2002:a5d:5242:0:b0:347:d352:d5c2 with SMTP id k2-20020a5d5242000000b00347d352d5c2mr9870799wrc.13.1715085779100;
        Tue, 07 May 2024 05:42:59 -0700 (PDT)
Received: from localhost ([45.130.85.2])
        by smtp.gmail.com with ESMTPSA id b12-20020a5d4d8c000000b0034e65b8b43fsm10915955wru.8.2024.05.07.05.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 05:42:58 -0700 (PDT)
From: Leone Fernando <leone4fernando@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	willemb@google.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Leone Fernando <leone4fernando@gmail.com>
Subject: [PATCH net-next v2 0/4] net: route: improve route hinting
Date: Tue,  7 May 2024 14:42:25 +0200
Message-Id: <20240507124229.446802-1-leone4fernando@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In 2017, Paolo Abeni introduced the hinting mechanism [1] to the routing
sub-system. The hinting optimization improves performance by reusing
previously found dsts instead of looking them up for each skb.

This patch series introduces a generalized version of the hinting mechanism that
can "remember" a larger number of dsts. This reduces the number of dst
lookups for frequently encountered daddrs.

Before diving into the code and the benchmarking results, it's important
to address the deletion of the old route cache [2] and why
this solution is different. The original cache was complicated,
vulnerable to DOS attacks and had unstable performance.

The new input dst_cache is much simpler thanks to its lazy approach,
improving performance without the overhead of the removed cache
implementation. Instead of using timers and GC, the deletion of invalid
entries is performed lazily during their lookups.
The dsts are stored in a simple, lightweight, static hash table. This
keeps the lookup times fast yet stable, preventing DOS upon cache misses.
The new input dst_cache implementation is built over the existing
dst_cache code which supplies a fast lockless percpu behavior.

The measurement setup is comprised of 2 machines with mlx5 100Gbit NIC.
I sent small UDP packets with 5000 daddrs (10x of cache size) from one
machine to the other while also varying the saddr and the tos. I set
an iptables rule to drop the packets after routing. the receiving
machine's CPU (i9) was saturated. 

Thanks a lot to David Ahern for all the help and guidance!

I measured the rx PPS using ifpps and the per-queue PPS using ethtool -S.
These are the results:

Total PPS:
mainline              patched                   delta
  Kpps                  Kpps                      %
  6903                  8105                    17.41

Per-Queue PPS:
Queue          mainline         patched
  0             345775          411780
  1             345252          414387
  2             347724          407501
  3             346232          413456
  4             347271          412088
  5             346808          400910
  6             346243          406699
  7             346484          409104
  8             342731          404612
  9             344068          407558
  10            345832          409558
  11            346296          409935
  12            346900          399084
  13            345980          404513
  14            347244          405136
  15            346801          408752
  16            345984          410865
  17            346632          405752
  18            346064          407539
  19            344861          408364
 total          6921182         8157593

I also verified that the number of packets caught by the iptables rule
matches the measured PPS.

TCP throughput was not affected by the patch, below is iperf3 output:
       mainline                                     patched 
15.4 GBytes 13.2 Gbits/sec                  15.5 GBytes 13.2 Gbits/sec

[1] https://lore.kernel.org/netdev/cover.1574252982.git.pabeni@redhat.com/
[2] https://lore.kernel.org/netdev/20120720.142502.1144557295933737451.davem@davemloft.net/

v1->v2:
- fix bitwise cast warning
- improved measurements setup

v1:
- fix typo while allocating per-cpu cache
- while using dst from the dst_cache set IPSKB_DOREDIRECT correctly
- always compile dst_cache

RFC-v2:
- remove unnecessary macro
- move inline to .h file

RFC-v1: https://lore.kernel.org/netdev/d951b371-4138-4bda-a1c5-7606a28c81f0@gmail.com/
RFC-v2: https://lore.kernel.org/netdev/3a17c86d-08a5-46d2-8622-abc13d4a411e@gmail.com/

Leone Fernando (4):
  net: route: expire rt if the dst it holds is expired
  net: dst_cache: add input_dst_cache API
  net: route: always compile dst_cache
  net: route: replace route hints with input_dst_cache

 drivers/net/Kconfig        |   1 -
 include/net/dst_cache.h    |  68 +++++++++++++++++++
 include/net/dst_metadata.h |   2 -
 include/net/ip_tunnels.h   |   2 -
 include/net/route.h        |   6 +-
 net/Kconfig                |   4 --
 net/core/Makefile          |   3 +-
 net/core/dst.c             |   4 --
 net/core/dst_cache.c       | 132 +++++++++++++++++++++++++++++++++++++
 net/ipv4/Kconfig           |   1 -
 net/ipv4/ip_input.c        |  58 ++++++++--------
 net/ipv4/ip_tunnel_core.c  |   4 --
 net/ipv4/route.c           |  75 +++++++++++++++------
 net/ipv4/udp_tunnel_core.c |   4 --
 net/ipv6/Kconfig           |   4 --
 net/ipv6/ip6_udp_tunnel.c  |   4 --
 net/netfilter/nft_tunnel.c |   2 -
 net/openvswitch/Kconfig    |   1 -
 net/sched/act_tunnel_key.c |   2 -
 19 files changed, 291 insertions(+), 86 deletions(-)

-- 
2.34.1


