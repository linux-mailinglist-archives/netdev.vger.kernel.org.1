Return-Path: <netdev+bounces-250563-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 80FF7D33368
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 16:34:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BD5A03032FEC
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 15:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB3C31AAA7;
	Fri, 16 Jan 2026 15:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lKzZ5RLO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFEE51FDE31
	for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 15:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768577402; cv=none; b=UKMeizRyE4fLUnWuVD9YcV3vlYdQAuWDab71Cmw4yBzlgVF4QF9/U2G/wjCUKSMBXHuw6l8cZ2WcP7LWvwyyw9aUBprAQysLBlWSSOHvwC0leQcIdtv2tujAYwWXpfxhR85f7mNS7lH2Amn7BVWlaA24oMcnYZFzOV2yJQ1F+uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768577402; c=relaxed/simple;
	bh=u78gbfknKgUAV9P7ejArxR/7TsMcM8wTCdf5pkUKJ6E=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=MtxvoQtZc7pkKNPKWm5T2qyo4LD3gTALhYRwpTEvGwIRJc+ywAGz3BcMR+jX63tPiJbvUJHIPMqha6AKjboUK+qF3LLt/MWQWTvUOhQ0ndtyWVUT81T9n5c91YIk843y0ghMA1REjFFA3/slyUGDqevbaJwIaGClY0sQRt6hlJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lKzZ5RLO; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-8c6a87029b6so184486485a.1
        for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 07:30:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768577400; x=1769182200; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KIJ0W64zTwUBs8BchOZNV0rt4rNhOQ8fi/ods/8mkwA=;
        b=lKzZ5RLOGb0YT3Mp/WDJhJsEhT+gGcNdmI3G0OHra/hOKL89G1zD9rWd1FSnO8fC8x
         rHPJ/CfUHZgpoMvuad3TKFmUxVzsFxQy1x8skUqcP6+e3WX61PglGYg8FKvNEYQA++vP
         vva3lxGh6A0KTuUo1PiORebvVjSqfZphQ3NS41fObuTccva2UG0YX4i/Bh/asAU3vQPZ
         Ox74krmuStgPsM25oBElFMcIWZ/PTmKFQDGmtwAaVxbh2Ig4IUqM6rHuN05nMN/QehBj
         qYp62N3FnLzR6SlBgETHEfbT4aIHkwwi6zzYeA0n2NlvO53ld/nfuCk/KdvTrsuwwu1Y
         INSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768577400; x=1769182200;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KIJ0W64zTwUBs8BchOZNV0rt4rNhOQ8fi/ods/8mkwA=;
        b=i1uADLXpzUW/3cusMuJ1fPUN0Ho0u9Y4RACVzjm2I7bgeQqwFaJEMBdfcAyiUWpB4e
         jr5Tp6F0Br4SYIt7REf1IN9O3nZ1xOd0jDv3WnOovMgZilqeYbuViP1Xnu9oRD531Kl0
         M+waYPyV1eZthbUTHB/eXbQ0kWTEpt6Ss623kRatjgXo106pJUn/geNOopvixXMDyvij
         p2+5BtlYi6WF/nqmZXF95KPJAU8z+9OleHIpqcczK9UgvcjKgJlr5dd/p/IADDwSVwyy
         TS7Ricg5gcLmQ6009WunuWV8xii+uJkO51SOdjsxwHOquQwE7BKAYQSBHjTdKcTGOd1O
         UJCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWD5IsAYPlivXC932Mz7Qzv6Fi3iYGroILOwi+0G92kOweAseiZeZzjcqQ44KQa+6ZuH63si2o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy99bZKQhATYC/YnFsory4JgMKtcBKHOUV9C7ScfkYFvVmREYk
	H3+1OMOg3wSyLCqBdOvWKhGBlhslmkQDSkxe6U1NGqz2mh7kaKRkb9uBvv1g7q2V/EcboCMYdK6
	SzOlWx18zvLQ6jg==
X-Received: from qvop10.prod.google.com ([2002:a0c:faca:0:b0:886:4425:88b1])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:7014:b0:8b2:ea2b:923c with SMTP id af79cd13be357-8c6a66e90afmr447242885a.14.1768577399643;
 Fri, 16 Jan 2026 07:29:59 -0800 (PST)
Date: Fri, 16 Jan 2026 15:29:54 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260116152957.1825626-1-edumazet@google.com>
Subject: [PATCH net-next 0/3] gro: inline tcp6_gro_{receive,complete}
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	Willem de Bruijn <willemb@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

On some platforms, GRO stack is too deep and causes cpu stalls.

Decreasing call depths by one shows a 1.5 % gain on Zen 2 cpus.
(32 RX queues, 100Gbit NIC, RFS enabled, tcp_rr with 128 threads and 10,000 flows)

We can go further by inlining ipv6_gro_{receive,complete}
and take care of IPv4 if there is interest.

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
 include/net/tcp.h        |  2 --
 net/ipv6/Makefile        |  2 +-
 net/ipv6/ip6_offload.c   | 43 ++++++++++++++++++++--------------------
 net/ipv6/tcpv6_offload.c | 12 +++++------
 5 files changed, 29 insertions(+), 32 deletions(-)

-- 
2.52.0.457.g6b5491de43-goog


