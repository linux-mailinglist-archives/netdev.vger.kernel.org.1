Return-Path: <netdev+bounces-102704-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 139AE90458B
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 22:11:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CD46B239A7
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 20:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205B914F135;
	Tue, 11 Jun 2024 20:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="EyShCcyP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4297F49B
	for <netdev@vger.kernel.org>; Tue, 11 Jun 2024 20:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718136687; cv=none; b=isq5r1M2HgxOVmUdNLJViowOZrk6Tyt9bH6tt5xGfYYFQ0UCF2bg6FwssaV/g8Qo158Enr5wHAjrRLjXH+uCaiEgUKVFUlrUsf7SWc1LWtR3DkD8Y/icgyzkH1qg6qaivEbX63EsEqF5Lt4FbFvFWWoWtLnZofzhWyUBx8nO+oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718136687; c=relaxed/simple;
	bh=cMK1CclC04MqeTJsWHlOEoNGqcBkfXz7uVhSatuhjZs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VVsniwkkCnFkd5nP91K503BfMwO96g9hTBIv04y/pln5LIWcF2qeZuJdVRXC+vkGlIlsvkhjrbCRcIKdUJopgWO22KoiO0nvIt/kal5d30Fky+ChAdmeTWRxAXWz4WTjnxlzyE6m246ZVNLHMLLsDZmF9q0caBaoaefdGImHHGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=EyShCcyP; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6f98178ceb3so894319a34.0
        for <netdev@vger.kernel.org>; Tue, 11 Jun 2024 13:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1718136684; x=1718741484; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qjr4bFDIJ+rHSyjjaa7KT8dWhd5ireGzkoHLGps+PSs=;
        b=EyShCcyPpRX4D/EoeHsgCuop8yzU60B1oo8qKOJ5mSbCZh8350MEnv6zzsPts9f68a
         3pRNsY0LpRlg5fKGMjUcLSAliMQa6Zq2qXY2jUU++A8o4esvK6OG4Ns3zbkR13iHL1/7
         8ZAv2a1MvhwGxVGci/lZRUvIxMV8BznrGENmPj1x51+5mcDlzDOamGESP/kLZvrlajJv
         mf0zz7LZrl/YOjqhvJxkvfbeMctO/3+GnTkNLJYobL7yTasyKiOCPDTTPw1gc7J1YsO/
         wPMYeJos7zQRftdkAtz4kvahO1l7ZXLsnB3D0c6nuajSnsq0H2IRyTddrgY8qC60aZJJ
         zJ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718136684; x=1718741484;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qjr4bFDIJ+rHSyjjaa7KT8dWhd5ireGzkoHLGps+PSs=;
        b=Fk4vKNqYlwSvRLdXX6vz1p8MbZY3Az5Roe9Ye2AxycZfa/1AI0PXtALGA5KpQmn17K
         IELf+e5s0laHHlDFamTeypRhXPd3eaPljCYCU28W86BcWNDwmTCuQG+EJ2PGWyiOsaBF
         qgrPN4uYbFELAEFPcZ8YDg4PXZvm4ck0ouK6hArJGbIJSjZq9mRxsWQsO7YrRemvWIoS
         PtyjjIeFJGOyKiG4X7ObzhMsN1Y9OiAQnjYaYOGKdkyK1Y0ZgBSnRqKB9b3HJXUPg3Aq
         ykQVUcJmXI7Q9qzl5E9pZ1cbDEhhnI8Jcf6xogHZcvEgy62NL3Pm8euTYkH93Fqn6m+Y
         qdkw==
X-Gm-Message-State: AOJu0YzYnN4UUDlHar0x5G1RIRWSWf1ERMYk/bBDv6vP08EbRSicVkOS
	YHyuPIQf8xkYlPj8ofyHV1dK2E0GfPMVrdfnPmW0hNqJTSGbYjG7sUzHKwLzdnpshi/YrGurObN
	4594=
X-Google-Smtp-Source: AGHT+IFz1Ms0snKjZtG9L+HNZ1t6P1akSp4QJpXcnWnIlLYJv61LFdwm5UM+mEJAFbBnr90b6HVUUw==
X-Received: by 2002:a05:6830:e82:b0:6ef:9ec1:2bf8 with SMTP id 46e09a7af769-6f9572dcbefmr13810482a34.23.1718136683902;
        Tue, 11 Jun 2024 13:11:23 -0700 (PDT)
Received: from debian.debian ([2a09:bac5:7a49:f9b::18e:1c])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-440c9fed96asm22522311cf.17.2024.06.11.13.11.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 13:11:23 -0700 (PDT)
Date: Tue, 11 Jun 2024 13:11:20 -0700
From: Yan Zhai <yan@cloudflare.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
	Abhishek Chauhan <quic_abchauha@quicinc.com>,
	Mina Almasry <almasrymina@google.com>,
	Florian Westphal <fw@strlen.de>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	David Howells <dhowells@redhat.com>, Jiri Pirko <jiri@resnulli.us>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Pavel Begunkov <asml.silence@gmail.com>,
	linux-kernel@vger.kernel.org, kernel-team@cloudflare.com,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Neil Horman <nhorman@tuxdriver.com>,
	linux-trace-kernel@vger.kernel.org,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH v4 net-next 0/7] net: pass receive socket to drop tracepoint
Message-ID: <cover.1718136376.git.yan@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

We set up our production packet drop monitoring around the kfree_skb
tracepoint. While this tracepoint is extremely valuable for diagnosing
critical problems, it also has some limitation with drops on the local
receive path: this tracepoint can only inspect the dropped skb itself,
but such skb might not carry enough information to:

1. determine in which netns/container this skb gets dropped
2. determine by which socket/service this skb oughts to be received

The 1st issue is because skb->dev is the only member field with valid
netns reference. But skb->dev can get cleared or reused. For example,
tcp_v4_rcv will clear skb->dev and in later processing it might be reused
for OFO tree.

The 2nd issue is because there is no reference on an skb that reliably
points to a receiving socket. skb->sk usually points to the local
sending socket, and it only points to a receive socket briefly after
early demux stage, yet the socket can get stolen later. For certain drop
reason like TCP OFO_MERGE, Zerowindow, UDP at PROTO_MEM error, etc, it
is hard to infer which receiving socket is impacted. This cannot be
overcome by simply looking at the packet header, because of
complications like sk lookup programs. In the past, single purpose
tracepoints like trace_udp_fail_queue_rcv_skb, trace_sock_rcvqueue_full,
etc are added as needed to provide more visibility. This could be
handled in a more generic way.

In this change set we propose a new 'sk_skb_reason_drop' call as a drop-in
replacement for kfree_skb_reason at various local input path. It accepts
an extra receiving socket argument. Both issues above can be resolved
via this new argument.

V3->V4: adjusted the TP_STRUCT field order to align better, suggested by
Steven Rostedt.

V2->V3: fixed drop_monitor function signatures; fixed a few uninitialized sks;
Added a few missing report tags from test bots (also noticed by Dan
Carpenter and Simon Horman).

V1->V2: instead of using skb->cb, directly add the needed argument to
trace_kfree_skb tracepoint. Also renamed functions as Eric Dumazet
suggested.

V3: https://lore.kernel.org/netdev/cover.1717529533.git.yan@cloudflare.com/
V2: https://lore.kernel.org/linux-kernel/cover.1717206060.git.yan@cloudflare.com/
V1: https://lore.kernel.org/netdev/cover.1717105215.git.yan@cloudflare.com/

Yan Zhai (7):
  net: add rx_sk to trace_kfree_skb
  net: introduce sk_skb_reason_drop function
  ping: use sk_skb_reason_drop to free rx packets
  net: raw: use sk_skb_reason_drop to free rx packets
  tcp: use sk_skb_reason_drop to free rx packets
  udp: use sk_skb_reason_drop to free rx packets
  af_packet: use sk_skb_reason_drop to free rx packets

 include/linux/skbuff.h     | 10 ++++++++--
 include/trace/events/skb.h | 11 +++++++----
 net/core/dev.c             |  2 +-
 net/core/drop_monitor.c    |  9 ++++++---
 net/core/skbuff.c          | 22 ++++++++++++----------
 net/ipv4/ping.c            |  2 +-
 net/ipv4/raw.c             |  4 ++--
 net/ipv4/syncookies.c      |  2 +-
 net/ipv4/tcp_input.c       |  2 +-
 net/ipv4/tcp_ipv4.c        |  6 +++---
 net/ipv4/udp.c             | 10 +++++-----
 net/ipv6/raw.c             |  8 ++++----
 net/ipv6/syncookies.c      |  2 +-
 net/ipv6/tcp_ipv6.c        |  6 +++---
 net/ipv6/udp.c             | 10 +++++-----
 net/packet/af_packet.c     | 10 +++++-----
 16 files changed, 65 insertions(+), 51 deletions(-)

-- 
2.30.2



