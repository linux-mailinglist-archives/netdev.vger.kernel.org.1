Return-Path: <netdev+bounces-100758-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4949B8FBE39
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 23:47:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8EB01F22199
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 21:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D41C14D28A;
	Tue,  4 Jun 2024 21:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="UKU81Jbi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF64614C588
	for <netdev@vger.kernel.org>; Tue,  4 Jun 2024 21:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717537663; cv=none; b=pfTeWg1EoUfrMn/RhsCzhB7/tFsrV+2QeXoFPlwAx4VZSWVcfuTyt778RTv+chcBMQEaRr5pHlYXuuGoKkRV2ipDsZ9x1+8eZBShU3Bx/9qtghMYPZbK3rhF8hRUf3zmJSR6pIx6FM7XTE2cw48ac1w91EAoyeiGK84v8lxLRIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717537663; c=relaxed/simple;
	bh=b1fwLs8L3PPzev26UBlSg8JhfZG8X2v0wz71kYRDvME=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=T0rH8o9nfun8vg5qR2P88o5+rD21Kp33RWLX5EEhyHustpT7g0u9v7KOw2iQP7ZNMj6Sd8G3Y+J8/0n0jPj+xiyUhUaQvEHIFtXmMX3Ul5WKaAynpMZnvVxBgnYEqozpQ0GO5NGQMGEriNciRAl1hTFETP1NGpqjuniaOKAIiic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=UKU81Jbi; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-43fbbd1eb0cso8493491cf.2
        for <netdev@vger.kernel.org>; Tue, 04 Jun 2024 14:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1717537659; x=1718142459; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tVAiho8NfA9+3WTngyAHQcgY5VXgLMOywVJbQtGO8Go=;
        b=UKU81Jbiw5f+GtDncQE5z605azvs7VkUKFM2w1+AW1Q6RmQNGLmCZqcQT8jgjWz5X+
         h9Sw6onf+FBcvHMXOEz9+gc6aVZyU2e074YNeCuI5bEmDPE1TJ84u1BZ8m8cGIvJYFQg
         alUcm/2fofQNObvKfbySGq1PPRzylqMSgnZwNZV58k5GAgszs7q7Zlnv+qkdwmuNd1I1
         g9ntHyucR4Q3HpIfHHbWzG0rWie6COshP/cQLUw9MdWM4B9OPhw6/oQbgL2swacReovA
         kghzkJkOw9VOdJEmkKW7A+ktJQ20/sQ3kDMuWnQUp0v1zGQaohYZ4BiLRVl1/4PbgQRj
         Nucg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717537659; x=1718142459;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tVAiho8NfA9+3WTngyAHQcgY5VXgLMOywVJbQtGO8Go=;
        b=eZzwGD6jpuevFwMq3an/6wwqDBrcLNCOlhbTXMGkHyeod4MW4H6onhd31J+vjDdk96
         95ckuWiL2+CqVt4vJcDN7y1w8H3ZF81kEIeQ1nPmmq/fY3Co/t6dy7fWwZZO8Pcy1YpD
         gW7MDCmUIYqeiJJl2TyEiygUxDBvCke8ZM7XvgI2bldOHeKO92HFPGF7fg6WxMObHPbH
         KV7pdBNeM5RArFv76CoF56FYb65f7ZP4ec+8OENhDvV8FDiRyOI8H6e0UPpZJi1WzW5s
         g2PWAvzbKKoDQnsUclC0o1qGg2mOpwCUM/yeJhgSw7Xb6z6ZSfgdwDxrgOUvdoQHgSYY
         E5lw==
X-Gm-Message-State: AOJu0YxAqn6nkOXmqJrCluWuW/z5sbBYg27LlzgdQujnvl2Bs3j+RiIV
	hqBji0Srt/Im1lTNU5PpsV4hBprzm6vL8UVAkQJGkgdG0NlHnlm7Pu23LS5tAuenay51adgqtD/
	TpZE=
X-Google-Smtp-Source: AGHT+IEOHx4XoXSQ6kFRU5GEomKxiyrOHwNRgManl23j4v38Hr1ojjv2nQJf3Igp3esuwYvpzpunBw==
X-Received: by 2002:a05:622a:1823:b0:43f:ee83:3362 with SMTP id d75a77b69052e-4402b6d6cd0mr7631391cf.61.1717537658447;
        Tue, 04 Jun 2024 14:47:38 -0700 (PDT)
Received: from debian.debian ([2a09:bac5:7a49:f9b::18e:1c])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43ff23c5ef2sm53183961cf.24.2024.06.04.14.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 14:47:37 -0700 (PDT)
Date: Tue, 4 Jun 2024 14:47:34 -0700
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
Subject: [RFC v3 net-next 0/7] net: pass receive socket to drop tracepoint
Message-ID: <cover.1717529533.git.yan@cloudflare.com>
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

V2->V3: fixed drop_monitor function signatures; fixed a few uninitialized sks;
Added a few missing report tags from test bots (also noticed by Dan
Carpenter and Simon Horman).

V1->V2: instead of using skb->cb, directly add the needed argument to
trace_kfree_skb tracepoint. Also renamed functions as Eric Dumazet
suggested.

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



