Return-Path: <netdev+bounces-250911-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B39A6D398A1
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 18:52:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1B7EB30088A4
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 17:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BBF12FD68A;
	Sun, 18 Jan 2026 17:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LBCyL86U"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B542356A4
	for <netdev@vger.kernel.org>; Sun, 18 Jan 2026 17:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768758740; cv=none; b=aJPdtS3rxaYnt2qaBu4DhLCg/ClkEv7wRNEw519aBIKxpTnvaXqLw7jdHOiH0hOB0SbPhyeob7ziSzMyedZFBD14JAyQz1TWWGPb9jpfGaqDe5paDtRJX64cEHw4pesVdc1cGSOKjyr+YWSkMqBMqakB5o9kW+TCaAfZ5+quXa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768758740; c=relaxed/simple;
	bh=MOuVqo23n0E8mTJYERWPyLbIOukPssp+mVzANySagYA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=tUE2r+OaClR6YVgRheTib8dF10+fC0ZDj6jggchc9lae17nwowiXXvOxHzzqhBAtE17T1iLyRCHD3Mo98Uz5nXwqMfWYjAnLo8p1oibrmOyY/+P5/N9gOzldqGqaL+WdCxSYGFqXoNso4Minn6MGRDj4REyVj80UqaqdCjYWaY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LBCyL86U; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-78f92e123f5so47969697b3.2
        for <netdev@vger.kernel.org>; Sun, 18 Jan 2026 09:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768758738; x=1769363538; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0soLYoLD2HEfbC5aYG8vVqwAVSj2C6MMeQGZIYPijrU=;
        b=LBCyL86U6dpsv5G8O5/+y1hst38gDNZ60Mp287kBVd1XRg/kqsf5xu5czcr8ROs10e
         ISiFDXchqrm5gXu9JzYpiHyBVzT5NTadFVaykyqk1wzrT4BWa+RzefR7X5LDM15QTF08
         xMNGDToSuz75deGRa3OWSKwaCs5ANPZNwcrbyNRmVszNQikL2vtyt9kW/6pupo1P7nJG
         tEI+MKKPLsZCppDjTrAsPOHCb6lSgUqVmdxovg/I5xR24o06DN3tRgULg4+MBS39a3mh
         xh2tyHn9PTkQefCItI9n0PzNJILJn8iDPqOudTBc/ryP8GKnw6m3YF7A+NiTaZJNsbB7
         ddfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768758738; x=1769363538;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0soLYoLD2HEfbC5aYG8vVqwAVSj2C6MMeQGZIYPijrU=;
        b=tZhn+Cq2IUMcI337qntbSOQI+5CnMU9TnsIm9rKpGoMq1YnoMXvi9vivPvGmQ5Bh7/
         EzoEtI5WkfK97LJ9CJgIbL6mEI26wS3n4xLh83BQyxkHV6rp8AZovZe6DskfHMKkLHHU
         oH02W0DToI3jvz1f6UP/GPqVImIJf1aLK82d2emBQ4SI2oz0zaOFbjTT3hflRl2KY+/3
         B8stAPfsahyeEOSzIMYvSK1Q6L4QTxhnZ5l1Q5RekQtKcHWgTFQSHOMsDv5CiV/OhMKW
         9CKquDMhG310JJqsMp79HG8ptix3SBLFWEM3X1RVO2eO7eeTIwIl49ZEmktnbJczZIbD
         +I+w==
X-Forwarded-Encrypted: i=1; AJvYcCWTFXfFedgex66S0O6e3S1M1BAH1ea7Ga/3cpIu8z7OG0eWrQ5CjOTuHZI9ZjKA/jHQEZ+5nyY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZCj5bIwQRv4F0FfHrN+Q0bIPQIBqE3KOXfWE4iH3D0Rl5ALcC
	2dPxZSxntBp9SKF2qA/TZJFBlQ5z12LLGa8B32bzgsN1wr/DJkznX2Jtw2YdLladq50h73uGxiY
	tK3TS/VPH7sAygw==
X-Received: from yxse4.prod.google.com ([2002:a53:d804:0:b0:649:2245:becc])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690e:1506:b0:649:2589:fa04 with SMTP id 956f58d0204a3-6492589fe00mr3404265d50.1.1768758738259;
 Sun, 18 Jan 2026 09:52:18 -0800 (PST)
Date: Sun, 18 Jan 2026 17:52:12 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260118175215.2871535-1-edumazet@google.com>
Subject: [PATCH v2 net-next 0/3] gro: inline tcp6_gro_{receive,complete}
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

On some platforms, GRO stack is too deep and causes cpu stalls.

Decreasing call depths by one shows a 1.5 % gain on Zen2 cpus.
(32 RX queues, 100Gbit NIC, RFS enabled, tcp_rr with 128 threads and 10,000 flows)

We can go further by inlining ipv6_gro_{receive,complete}
and take care of IPv4 if there is interest.

Note: two temporary __always_inline will be replaced with
      inline_for_performance when available.

v2: dealt with udp6_gro_receive()/udp6_gro_complete()
    missing declarations (kernel test robot <lkp@intel.com>)
    for CONFIG_MITIGATION_RETPOLINE=n

Cumulative size increase for this series (of 3):

$ scripts/bloat-o-meter -t vmlinux.0 vmlinux.3
add/remove: 2/2 grow/shrink: 5/1 up/down: 1572/-471 (1101)
Function                                     old     new   delta
ipv6_gro_receive                            1069    1846    +777
ipv6_gro_complete                            433     733    +300
tcp6_check_fraglist_gro                        -     272    +272
tcp6_gro_complete                            227     306     +79
tcp4_gro_complete                            325     397     +72
ipv6_offload_init                            218     274     +56
__pfx_tcp6_check_fraglist_gro                  -      16     +16
__pfx___skb_incr_checksum_unnecessary         32       -     -32
__skb_incr_checksum_unnecessary              186       -    -186
tcp6_gro_receive                             959     706    -253
Total: Before=22592724, After=22593825, chg +0.00%

Eric Dumazet (3):
  net: always inline __skb_incr_checksum_unnecessary()
  gro: inline tcp6_gro_receive()
  gro: inline tcp6_gro_complete()

 include/linux/skbuff.h   |  2 +-
 include/net/gro.h        |  5 ++---
 include/net/tcp.h        |  2 --
 net/ipv6/Makefile        |  2 +-
 net/ipv6/ip6_offload.c   | 43 ++++++++++++++++++++--------------------
 net/ipv6/tcpv6_offload.c | 12 +++++------
 6 files changed, 31 insertions(+), 35 deletions(-)

-- 
2.52.0.457.g6b5491de43-goog


