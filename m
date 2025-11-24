Return-Path: <netdev+bounces-241243-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F307C81F9E
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 18:50:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C21CB3A9964
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 17:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C332C0287;
	Mon, 24 Nov 2025 17:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C/VvTzU3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E8EF4F1
	for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 17:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764006617; cv=none; b=pktTDJdYhDIpqAyo91AKDiGKgOLqFApLdc6XYIZYjwyEwJIK88pjQVVTHdL8U55SaVemAPqZ3LYkFyOhrvStqqfK2bw7+uxLfiaj9G0Z1Y4nyP/d0U/uPBQIDe3jwy+HCJ1chP5h9cwGg5IGIK2mDQohn7XCznC73lRdWv9ju+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764006617; c=relaxed/simple;
	bh=+yYPC8KsCo8fPjR43wM9pYhgrEnInORTQoD2780troQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=c1J71DPp9l2W+fBSV7sLdNbNAEIowv1+/Fc+ap0JiO0hczaUCj+DdG7sV1NJqK4QIIc+99ZniMcnpRGRbA1ZgSNre+XHMEZq6DfuPGPVhLFBp5IT6n7S8UfbGYiSyD8MWUqVc95JEas6rVRY2CWVRt9TjbcLzM1X0J7LY6sCIBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C/VvTzU3; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-8b30b6abb7bso1209417885a.1
        for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 09:50:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764006614; x=1764611414; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=47uBwxT/cO53bOeTBvLnfNPxhQaXOvEG8FHb8QH09Xg=;
        b=C/VvTzU3NC2SQWB5QhvqxNJw0XV4D3hLdr2gW7CxfsMphvULAQu9oUfHCEvTYAMZdq
         YeDbrwUWgION85zlJ3ZMB/PeTrRjfYu8GQQsP86jF5+8Ar3VBfUF7NmUreypKfaIdz9+
         14Q0GgRv99YhYbE/yGjE/TkKV1F0ylwhQk/2rg1VmIFVNJ/O8WuJb3ZKjS5/GEfA3onC
         jN4B3rZ/GXm/C9EHadKkXdYlpdjlPCwVA0eXQEA3MawMpScTKhwUb0tgV4GyPDcC9LSc
         MH8rFGatgeUQ6iJqWX3WON17CVVYPB9B/HL9LO877qRcI1hkx4dL33oUYR3B5rK7YOIQ
         w9IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764006614; x=1764611414;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=47uBwxT/cO53bOeTBvLnfNPxhQaXOvEG8FHb8QH09Xg=;
        b=H7LO1CokjS/ETOqoLNU0JoFw2u62Z/1pye/vcA33nzINRp9fd4glUxc9C6jwgNaQcL
         246SEEvCXwrM7anpNm6ny7wgzxB24jOOWw8QrYSc17TLmq8WAmZ+ctncHf48bMagUREb
         wGJwPrZ2g8FVKoZPL01Jmn5kIbuGq9PeKkZbpzU3kb5ujKecpPC1vqDpo3MYZC0sm45X
         WR1VMyfRGrkMJK4cCsFRfkiWLW6/EeG9h70IAPc6YRzPIAOWvZXvn6km/tU0IUZJiEVW
         hER3iqQ3vl6NSvWPmtTUblef/jXI3eSTppeJ2zj4VnFQy9PAnZfk27ZZNJyqhwIQW6f2
         neIg==
X-Forwarded-Encrypted: i=1; AJvYcCUdlFc0DYa3BSyTR1jRHA7pyaGmPcf0FPKbk3lKwrc4r1tuE4o20mPR9sZjfxDBzV6etzlQzdo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm2StuPrdPWmze7GunR8ey0sh6LcV181YIADNcRjvWdEdjUs1d
	L/mVtWPChtxIg3ck952IAx89M/6krjT+fmKf8++JAGELzLWccBWcmGwO1ri6EHRRYUPJfZtqb8e
	S340NITaLmzGQ2w==
X-Google-Smtp-Source: AGHT+IHn0v/E2u/Lfar4h1MWnoe4q8sPWcsehwmaS6Ne9EDaqqlp6tgYkT1O9Dk2SHL3lLgT0ca+37eC26K/YA==
X-Received: from qknor9.prod.google.com ([2002:a05:620a:6189:b0:8b2:44f9:8e0a])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:4506:b0:8b2:5df1:9341 with SMTP id af79cd13be357-8b33d5f8f25mr1700963985a.75.1764006614495;
 Mon, 24 Nov 2025 09:50:14 -0800 (PST)
Date: Mon, 24 Nov 2025 17:50:09 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.460.gd25c4c69ec-goog
Message-ID: <20251124175013.1473655-1-edumazet@google.com>
Subject: [PATCH net-next 0/4] tcp: provide better locality for retransmit timer
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

TCP stack uses three timers per flow, currently spread this way:

- sk->sk_timer : keepalive timer
- icsk->icsk_retransmit_timer : retransmit timer
- icsk->icsk_delack_timer : delayed ack timer

This series moves the retransmit timer to sk->sk_timer location,
to increase data locality in TX paths.

keepalive timers are not often used, this change should be neutral for them.

After the series we have following fields:

- sk->tcp_retransmit_timer : retransmit timer, in sock_write_tx group
- icsk->icsk_delack_timer : delayed ack timer
- icsk->icsk_keepalive_timer : keepalive timer

Moving icsk_delack_timer in a beter location would also be welcomed.

Eric Dumazet (4):
  tcp: rename icsk_timeout() to tcp_timeout_expires()
  net: move sk_dst_pending_confirm and sk_pacing_status to sock_read_tx
    group
  tcp: introduce icsk->icsk_keepalive_timer
  tcp: remove icsk->icsk_retransmit_timer

 .../net_cachelines/inet_connection_sock.rst   |  2 +-
 include/net/inet_connection_sock.h            | 20 ++++++++------
 include/net/sock.h                            | 13 ++++++---
 net/core/sock.c                               |  4 +--
 net/ipv4/inet_connection_sock.c               | 12 ++++-----
 net/ipv4/inet_diag.c                          |  8 +++---
 net/ipv4/tcp_ipv4.c                           |  8 +++---
 net/ipv4/tcp_timer.c                          | 23 ++++++++--------
 net/ipv6/tcp_ipv6.c                           |  8 +++---
 net/mptcp/protocol.c                          | 27 +++++++++----------
 net/mptcp/protocol.h                          |  2 +-
 .../selftests/bpf/progs/bpf_iter_tcp4.c       |  8 +++---
 .../selftests/bpf/progs/bpf_iter_tcp6.c       |  8 +++---
 13 files changed, 74 insertions(+), 69 deletions(-)

-- 
2.52.0.460.gd25c4c69ec-goog


