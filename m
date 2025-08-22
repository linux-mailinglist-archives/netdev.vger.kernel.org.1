Return-Path: <netdev+bounces-215971-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1496AB312B4
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 11:17:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3C3756556C
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 09:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A6AF1531C1;
	Fri, 22 Aug 2025 09:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NAlEdtYb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D01A137750
	for <netdev@vger.kernel.org>; Fri, 22 Aug 2025 09:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755854251; cv=none; b=aOr4q/wt93u/zSwauB1D2zI+LqJtWUMkkfa8gk7IUgb2bE/s2TdtGNBtAbyjezN8Yfiz1QDD9JQ0lBlzcONNy92QOVPPOY9lmorJRpJTVOQfYH59KnvDP+sDOpafHuATUDkcFj4LTGcYFkGoTMZCSHtqBu8LbKXLIN8ul9rD4QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755854251; c=relaxed/simple;
	bh=GCjhRfFf8n1mqTUGI0KtP+L2OhFy9XYhIkoHLSPDug0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=bBFUFLbE8XUV2rjd84EKsoRkx71i0DfZd7kENW3V2LcOMnVIZjfnAl5xN3YDhr2DFjgHFjRBlHKKYsID9v2PK4gqvA+Xw3xwcVys2fHDAKmdBevyfyJ64i7S8Onb+TxNYlW+uoXp3lD7YECB8diVrXz7eIB2VNoBYm14Un82Y7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NAlEdtYb; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-70d7c7e9709so50396096d6.3
        for <netdev@vger.kernel.org>; Fri, 22 Aug 2025 02:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755854249; x=1756459049; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=I/HbqLZYB/0SC7ABea9pboFHw4jdC2t89hunkTNtFTs=;
        b=NAlEdtYbYUhYL1NByEPbFzudiZS7EbT2C0EPkp/TrGUcMI4wlLeOaNchMAvgth541E
         nfg4EL+2PRw0BwHUqyePMij8QcXSnpIbNyEgbRwJd11vbswd/U7dMROieMZ3nw8PvkS1
         z0jA0YEb23WIQN8FZy/KzOqubBzfLtkCkYd9XO7VsG4Ia/wtfGbxyR9k4NjQhcmvFjlt
         3mVzF9oFhhtYmf+t0xpKnKHleDE//moPYmHk7iC0W9YRJVMt1QjDJm9wpuZnT0rzJ+5k
         1ikaMAdId7/C5Qj7sNO48S5VG+uSJyrb/oq2UA6c+P4jhrvYUBl2eh9oKh+XH6/3KaMT
         SBKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755854249; x=1756459049;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I/HbqLZYB/0SC7ABea9pboFHw4jdC2t89hunkTNtFTs=;
        b=Ci8DQMa0wHbrILX3rwpZyYwF71LRt//3YFqVbhlxcsyoWDn+w4WsnFDypZG9s+Of79
         j0gjYQ0IhKO0zXiV3BI87uA2VUtHMtisHBmMXHhCGXYtDFPZiQMKto44Knj+4S0STZAv
         tiUmrkD/m/AmSukyWQ9m0IWQ8HheqQB0fNdHyoPpk/CrqAVitUQ7jof2e6pxjW6e8dlf
         pTDScujyyysDgY2vd2IC3PR6I4gdkUJyS7LrTtYc3AZtA5pyLc/QjwrrwpGzGWj2TRAb
         dbXDnKyZScHGc1M3qIEyWhygkXULOCDCT1fVhlazZEKD0V5BM+EHlwOKKhdk3gSxLcwA
         jcyg==
X-Forwarded-Encrypted: i=1; AJvYcCUjnzK+Hg5AyzzFbFzq/c3QjrrZifEiSeYjI2VQW8QMrg3yoS6rhow3vq9InhacKPMU+kQNUDc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2If6T3HwBCz+uHgAtOL7iNFlX4G4d3BFuqrEXMqAVtdkBeHB3
	43u1dzG7wpgQcHuMtsY6ZL3NSj8a/0rTEgNCJpNxsSCu6DfAlWvcv1CpQsqs+SsK0oR3QVNTLUC
	bhNdzHmUSDRL6Mw==
X-Google-Smtp-Source: AGHT+IEcxVw+HBU77GHn8TPh7n4mu8wztPp2M772LQ4D93zaX1vmQ92aJJyf9YTjTeXRP+qedZAVlxnpswOsPA==
X-Received: from qvnz3.prod.google.com ([2002:a0c:e983:0:b0:70d:827f:4410])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:2262:b0:707:56a4:5b56 with SMTP id 6a1803df08f44-70d9732b46amr24211756d6.40.1755854248873;
 Fri, 22 Aug 2025 02:17:28 -0700 (PDT)
Date: Fri, 22 Aug 2025 09:17:24 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.rc2.233.g662b1ed5c5-goog
Message-ID: <20250822091727.835869-1-edumazet@google.com>
Subject: [PATCH net-next 0/2] tcp: annotate data-races around icsk_retransmits
 and icsk_probes_out
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

icsk->icsk_retransmits is read locklessly from inet_sk_diag_fill(),
tcp_get_timestamping_opt_stats, get_tcp4_sock() and get_tcp6_sock().

icsk->icsk_probes_out is read locklessly from inet_sk_diag_fill(),
get_tcp4_sock() and get_tcp6_sock().

Add corresponding READ_ONCE()/WRITE_ONCE() annotations.

Eric Dumazet (2):
  tcp: annotate data-races around icsk->icsk_retransmits
  tcp: annotate data-races around icsk->icsk_probes_out

 net/ipv4/inet_diag.c  | 6 +++---
 net/ipv4/tcp.c        | 5 +++--
 net/ipv4/tcp_input.c  | 8 ++++----
 net/ipv4/tcp_ipv4.c   | 4 ++--
 net/ipv4/tcp_output.c | 6 +++---
 net/ipv4/tcp_timer.c  | 6 +++---
 net/ipv6/tcp_ipv6.c   | 4 ++--
 net/mptcp/protocol.c  | 3 ++-
 8 files changed, 22 insertions(+), 20 deletions(-)

-- 
2.51.0.rc2.233.g662b1ed5c5-goog


