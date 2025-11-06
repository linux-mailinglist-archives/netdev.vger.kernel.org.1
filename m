Return-Path: <netdev+bounces-236106-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A288EC387C9
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 01:34:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0FF4034ECD0
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 00:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1683A3EA8D;
	Thu,  6 Nov 2025 00:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hLrUz1vs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50E839FD9
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 00:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762389243; cv=none; b=jXnAI+DpL5IeO09OAn4Iyefd8y5pk/UU9qXmLch+DIagoMshlvWyhKNVAWdHMhzwPKYnGgMgXioAvIuEYH5+qnc9nKCerLV3J9De14NDLopHkFQ09RSJcLdDXs6q8XNqLAfy4bG9FAi0CvAMw8nD2iox2e7elAnXNJFcPXrXvb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762389243; c=relaxed/simple;
	bh=jWie/sX9F0VnqzMndxe6f0tGf9o7K+2XuThG+NEXD3k=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Rf/T+SlYsJQV5+kM8DsKAV+ILqr8Cu2GuCB8cyRjDuwYMn0m6KKaIe0xv/0UyiPby7VnTdFfakIrEeuARCD25gdYoNxXqDAX9v1NL8B/+UycBnYl52WHOKh9/CVeJbcqU7TtG44nLvuElxeyGVir8EHiYCtgoW+BPs9ZzipXwnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hLrUz1vs; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-341aec498fdso484978a91.2
        for <netdev@vger.kernel.org>; Wed, 05 Nov 2025 16:34:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762389241; x=1762994041; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Wf7QLv7ql+fdwsWvFKEi6Pih+umvWmkW+CCV19CuMOM=;
        b=hLrUz1vsIrsQ1ayw1Ct5Ouc6aLQhQXjZfyuLNEi+uTSPrIowwP/Xc7VMTrLJ5cez6H
         xY1PIfeaJ86Nzp2x6lSC6IZDstJAdU2dPYMYnQ2i5Fr8WrV01kMnzxbVJB/xdlReADiX
         jSc+b9kArp2nT0va/IIKyIhGrd5yKYmC40snaHntVSLw12JTXGX3Opdh1ZXCA4TUQrAH
         DUPlZHnvyyVzyBRDkjae0pX+YzAxt+aR38YsaHEIPqv5UlcQ+HhaEsafOma2qRZBQpH2
         8WnLoCEsFFePM+w2tFGDeuH+JKgItYpuYZN9moFv5Kk2wrxVOl3JMVIS+An3O1+GtRzX
         nMYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762389241; x=1762994041;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wf7QLv7ql+fdwsWvFKEi6Pih+umvWmkW+CCV19CuMOM=;
        b=wXMg/aONeUDVaOmh2q6fyHJq3fHEhMIhuH9Z0AwVR2NUK9dfr2j92g1hiGjvTrkY32
         vDm+Ch289Z3Xwn4Pxaj/qpoE/NwLQ77Zm/4TqQfm48hrmMK14k8paZmU2N+7m7Sv2PCX
         AQ4VmgFxGcBRpaftKxBBT9wSnZp1MywPZOh2a4H77RSl9lClr2iGa5VvLjdF1yt4IV4y
         R30d5EnLx5lBqMv3BvD4zmGjhFfOPVwrW7CnVZMM1NrFd5SI3YLcqNSG8FkalRYNQMSq
         dxpX3d02UaQB9YBdka0StLdqXnmrwqoNlfHXdaTv88v7qRcYSW/VpUdT+BNmU2xFlJ5C
         vu8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXlVNYpuogj9+VL5zzD+sCv3CT7NIPPFau49/h70okc56G1Nsiup5Q2RRK41SoQ4gijSzzvTsM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/Yb26Smf6wlIWSWO7IkyxJwZApUQb39hPOA64RSlXLqmA4QxB
	7Hhk+6TSrcnHkr17p7m0ZakkmKnGbD11k7zrpJEDjGvBo1A8bHh+UGOqWwgjUoJxwpHTYtwd596
	4BZiEAQ==
X-Google-Smtp-Source: AGHT+IFhjE+M0YvA3iBWrhx/6oVmqddL6TK4B75XdGZtQUtqyscl+p45qQxKj3paPdO4PJJEfgFhayyS8IQ=
X-Received: from pjbfa3.prod.google.com ([2002:a17:90a:f0c3:b0:340:3e18:b5c])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3555:b0:341:c964:126c
 with SMTP id 98e67ed59e1d1-341c9641796mr1525532a91.34.1762389240943; Wed, 05
 Nov 2025 16:34:00 -0800 (PST)
Date: Thu,  6 Nov 2025 00:32:39 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.2.1026.g39e6a42477-goog
Message-ID: <20251106003357.273403-1-kuniyu@google.com>
Subject: [PATCH v1 net-next 0/6] tcp: Clean up SYN+ACK RTO code and apply max RTO.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Yuchung Cheng <ycheng@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Patch 1 - 4 are misc cleanup.

Patch 5 applies max RTO to non-TFO SYN+ACK.

Patch 6 adds a test for max RTO of SYN+ACK.


Kuniyuki Iwashima (6):
  tcp: Call tcp_syn_ack_timeout() directly.
  tcp: Remove timeout arg from reqsk_queue_hash_req().
  tcp: Remove redundant init for req->num_timeout.
  tcp: Remove timeout arg from reqsk_timeout().
  tcp: Apply max RTO to non-TFO SYN+ACK.
  selftest: packetdrill: Add max RTO test for SYN+ACK.

 include/net/inet_connection_sock.h            | 11 +---
 include/net/request_sock.h                    |  1 -
 include/net/tcp.h                             |  8 +++
 net/ipv4/inet_connection_sock.c               | 19 ++++---
 net/ipv4/tcp_input.c                          | 14 ++---
 net/ipv4/tcp_ipv4.c                           |  1 -
 net/ipv4/tcp_minisocks.c                      |  5 +-
 net/ipv4/tcp_timer.c                          |  3 +-
 net/ipv6/tcp_ipv6.c                           |  1 -
 .../packetdrill/tcp_rto_synack_rto_max.pkt    | 54 +++++++++++++++++++
 10 files changed, 81 insertions(+), 36 deletions(-)
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_rto_synack_rto_max.pkt

-- 
2.51.2.1026.g39e6a42477-goog


