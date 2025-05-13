Return-Path: <netdev+bounces-190237-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E77CAB5D36
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 21:39:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5857A4A11DC
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 19:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E18572BFC9D;
	Tue, 13 May 2025 19:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q8vc8egW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B90A1F098A
	for <netdev@vger.kernel.org>; Tue, 13 May 2025 19:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747165164; cv=none; b=U77a89xpSCUqG9DHUxBMuZR3AxLIx6zziSDgbEZ8IyXA6LEqu0joTYyHouQcy8xdEk/b1/Xzzx1uRKzT24vrl92hNqo6VUHfEmxU/r8NtSvE/6qEIik6NdJsQ8ZROdqxSOgDEQxz7KB9ooJzn5r7F22HP/IFIMldFs5E7P8tAZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747165164; c=relaxed/simple;
	bh=ZCrQkBxPVVP0c03QPUTpRf29wLMI7t8O4o/rvTZlyFM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=j+ps6LXVcfXXAYOxJknkYcG13cG60xTHiB1hg/gQ4090tnbVbmY40M9fWHexKaAoVAjTaYzl8t331ZWLsIRGI9kOw4k5FfDUnt2KOQLgL5khsHhvIEQs/p5BYcJ1svZequOnVtrfN+WHbXTO8YJnpdqz0KPilOjZBr48IeG7qxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q8vc8egW; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-7c53e316734so1032159685a.2
        for <netdev@vger.kernel.org>; Tue, 13 May 2025 12:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747165162; x=1747769962; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=c4gU2N5uSThOA/N3MqqqbU0WuC3hMoQ3p6a+CorXxUg=;
        b=Q8vc8egW7Q03XWBBVGFK2nuPK+cG5eZkQpUiVqRKBvlizz28W66thzQ7RSDJdSPmzP
         o5LJGPqCqdBjKctOrOQUsIjn8NJfXFR3j3Slqm2q5NKCqZHsS1gW8RfBSvOjnMtRr6Jz
         bSTgM2I3rs8tGWzNlwveLTRtM9cNwz55RDO+Q2usPydRaOljhjYF+d32NTw/LUncLJ0S
         R7HMFWR7V5lRVYe51Tq/gaoKJcD8uQEFNpm0EEmvBzmw6iSk//i5918AFDJLS2+zHy2W
         Q1gSdbEJ0BxZn6NwnXLAfhXYzXkLPDY8Vg3p9WwHaWRVufe9uDnO6tq8m7rNuNpjoiQD
         jxiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747165162; x=1747769962;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c4gU2N5uSThOA/N3MqqqbU0WuC3hMoQ3p6a+CorXxUg=;
        b=BCqwLmSeHCuZdBjt525QkkDbOZb0fluxZJhttzYi29pwhy76jipqwTY/MPUK9zz7dK
         PggPrWrumRZ+1Jgx+knVhZLBhxPq1txlAaLH6NgRUovFHqRDFHeJ7bn31P+tshlJzXvL
         9xJNZGVQpfm4sNOwQyU2LPjAKCKOhkDc2KWREjBj+Du1QyrNpak16uH7CnaxzbVWhFmV
         XLO18qY4Np+dPwopVtZADJGCsVVtqphsSXKEHfwMauQiFLWouli0GYkD0L2JdwaLJyIL
         +yjPgISo/HKIZz0aXJ7TEQHmUB1xt5wpkguT9cOI533bkDmVG65sXU3jM83ZyENeFwUL
         v3IA==
X-Forwarded-Encrypted: i=1; AJvYcCVpNz176x/jUdufv8qNFlNgRx46QAEpia/rvDZ5M8o6/3RjHoj793+imaGRZRwyp7twgbqe/9s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFRqo533TENOfTdz4r0+1WsWO8fG/bSzTcR383aJxSxtF1/9QM
	zf9kcfp2hS64ot5q9ICq+/EExxb4tOSdv9hgEXTwfl/Um8Ou5kaF/nXbEwnLx9ytgX4NHfd7QyK
	ks10LZWQNzQ==
X-Google-Smtp-Source: AGHT+IEX7jDvEHy5VrVzhBXrC95210g1ia5cs/xBnNVHf/yL3u5m9+11hwVY0Is3cInwRPlFHi+C/VOrXkpASA==
X-Received: from qkaq14.prod.google.com ([2002:a05:620a:aa0e:b0:7ca:da19:5cca])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:1706:b0:7c5:5909:18e5 with SMTP id af79cd13be357-7cd287c48aemr88204585a.3.1747165161957;
 Tue, 13 May 2025 12:39:21 -0700 (PDT)
Date: Tue, 13 May 2025 19:39:08 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.1045.g170613ef41-goog
Message-ID: <20250513193919.1089692-1-edumazet@google.com>
Subject: [PATCH net-next 00/11] tcp: receive side improvements
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Rick Jones <jonesrick@google.com>, Wei Wang <weiwan@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

We have set tcp_rmem[2] to 15 MB for about 8 years at Google,
but had some issues for high speed flows on very small RTT.

TCP rx autotuning has a tendency to overestimate the RTT,
thus tp->rcvq_space.space and sk->sk_rcvbuf.

This makes TCP receive queues much bigger than necessary,
to a point cpu caches are evicted before application can
copy the data, on cpus using DDIO.

This series aims to fix this.

- First patch adds tcp_rcvbuf_grow() tracepoint, which was very
  convenient to study the various issues fixed in this series.

- Seven patches fix receiver autotune issues.

- Two patches fix sender side issues.

- Final patch increases tcp_rmem[2] so that TCP speed over WAN
  can meet modern needs.

Tested on a 200Gbit NIC, average max throughput of a single flow:

Before:
 73593 Mbit.

After:
 122514 Mbit.

Eric Dumazet (11):
  tcp: add tcp_rcvbuf_grow() tracepoint
  tcp: fix sk_rcvbuf overshoot
  tcp: adjust rcvbuf in presence of reorders
  tcp: add receive queue awareness in tcp_rcv_space_adjust()
  tcp: remove zero TCP TS samples for autotuning
  tcp: fix initial tp->rcvq_space.space value for passive TS enabled
    flows
  tcp: always seek for minimal rtt in tcp_rcv_rtt_update()
  tcp: skip big rtt sample if receive queue is not empty
  tcp: increase tcp_limit_output_bytes default value to 4MB
  tcp: always use tcp_limit_output_bytes limitation
  tcp: increase tcp_rmem[2] to 32 MB

 Documentation/networking/ip-sysctl.rst |   4 +-
 include/linux/tcp.h                    |   2 +-
 include/trace/events/tcp.h             |  73 ++++++++++++++++
 net/ipv4/tcp.c                         |   2 +-
 net/ipv4/tcp_input.c                   | 110 ++++++++++++-------------
 net/ipv4/tcp_ipv4.c                    |   4 +-
 net/ipv4/tcp_output.c                  |   5 +-
 7 files changed, 134 insertions(+), 66 deletions(-)

-- 
2.49.0.1045.g170613ef41-goog


