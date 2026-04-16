Return-Path: <netdev+bounces-279143-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WNIOA5dA4WmaqgAAu9opvQ
	(envelope-from <netdev+bounces-279143-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 22:03:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 62B3B4146DB
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 22:03:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 50D3430309BF
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 20:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 856843ED113;
	Thu, 16 Apr 2026 20:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m0UowJjM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303DF38C2A0
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 20:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776369809; cv=none; b=QuGfraI0iKdj3QlHXRenrcLLCbVpAOESFRZw3RVmnhVoRJrLc40OykJKNJTbkViydtDiFZLVmrKC1KZOSla8xhCL7XEIWcsGnZem3U0xGxMZozOPmy1Fp6bj9UOiLBHRhH/t8gcHCrEo6gwLDwmwm+fsaBEjVu+FX9+Qm9UXfqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776369809; c=relaxed/simple;
	bh=EtVOIq8cnDetfMNsnt8YDdwv9mHMyXbznxI5M1B9Kjo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=osUp9Lxe+WAoF6mwraBTJFbKW9Q6NqL9fDnlPpwW7hRhLOhC7tlYq+J8NsUbcmnI3XeBMvXF5ZvrbgtPUgvrOGeb/AAVBdo2eSQ3qQnP/oI7aRXcpVr6qWBCbnl6nRmpU4LJOwcLOwSiy41fytao0jYnhBIhCRLmZiRs9aLRD08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m0UowJjM; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-50e2592ea3bso16159781cf.2
        for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 13:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776369801; x=1776974601; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7N+C6PwVkoOxeOUld4+lmHfn5jNpx73a+XYhyW/IGKA=;
        b=m0UowJjMj6sNEmsCVrfI/MALYYhBSaiBJpLFApHZV8LpcPD0xOVjQb5PqjOkyId5en
         hnw0PTnIXP3J69S+o8mq8uiqLyHIqanDBDA+NgSwRWeKv2/mIRbSLXi7I+dqBpZ9NnUO
         /wLJuCv1LHaVJXV4Iga1NoZ7FyQKfDxgbnh3hPQ6ixeD9gMLNrnvrEr8WMADoMOp+lpc
         5bBMccMcSIuUO5BX8N9eMinGbMEKg8HiSkmPYV+iZ8YATRtOfWrRkgv5FzD0bQtWview
         RHxEzyjS5NvNczr8cCnH4r2ygZD/0t5Y8+NAio/SWATxsUbVdqhoC4T+ZwNMu4iBQGit
         rg5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776369801; x=1776974601;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7N+C6PwVkoOxeOUld4+lmHfn5jNpx73a+XYhyW/IGKA=;
        b=sJa9xct1f9x5MhvQk5XSSZZdSH8B1WrWU9UbQNVv3bbhoAE+GkGS8YbdaRjc6hoJGe
         nLQqo3fe7UeoQGeLItu8CIazYcrzCyk8AQ4EcbmRKjl0fIsCKF35IvC8XHQipSL4FavX
         N3TWz4YHKwkQdmsahGd3CGmkMiV9q9+WhhOgVAvUkf6lVZZGSeGWLotz+/8OxiwQ/lcT
         15seKXcTHcngsXTUgny7m/bqdipVS3qIWmtCnc6Wc4c+3MTdiKrdp31IenLvw5QyFVFK
         j36LkLt0oJVEZW4HOAiReeQHNioe9fLO/OmGQRTtuDle2RNsQJnuXi1jm3Zhe9qTfwfy
         SRLQ==
X-Forwarded-Encrypted: i=1; AFNElJ8nopCaH80Ty8wHidqabZYWPrAc55Xv0vDVoK4iHMfmatl6U3keTH6Ah+PQ/1brUsiObgQxe+0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrUvDzwL7ZtU3pqcGmDX0+DcrV268J/NJq34YHfHnnjaRjzIVH
	wivV5q5pJ2w5f2Yvyt7MbDi2geXZFaqEg+IvPsws2siLYeoHTL67T8M09zohFmgLxZ41GRFEZxJ
	q7hvwj6Ct7v3jXQ==
X-Received: from qtnh16.prod.google.com ([2002:ac8:5150:0:b0:506:5989:d4b9])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:112:b0:50d:74f9:894b with SMTP id d75a77b69052e-50e349540d7mr9399501cf.23.1776369800782;
 Thu, 16 Apr 2026 13:03:20 -0700 (PDT)
Date: Thu, 16 Apr 2026 20:03:05 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.rc1.513.gad8abe7a5a-goog
Message-ID: <20260416200319.3608680-1-edumazet@google.com>
Subject: [PATCH net 00/14] tcp: take care of tcp_get_timestamping_opt_stats() races
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279143-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 62B3B4146DB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

tcp_get_timestamping_opt_stats() does not own the socket lock,
this is intentional.

It calls tcp_get_info_chrono_stats() while other threads could
change chrono fields in tcp_chrono_set(). It also reads many
tcp socket fields that can be modified by other cpus/threads.

I do not think we need coherent TCP socket state snapshot
in tcp_get_timestamping_opt_stats().

Add READ_ONCE()/WRITE_ONCE() or data_race() annotations.

Note that icsk_ca_state is a bitfield, thus not covered
in this series.

Eric Dumazet (14):
  tcp: annotate data-races in tcp_get_info_chrono_stats()
  tcp: add data-race annotations around tp->data_segs_out and
    tp->total_retrans
  tcp: add data-races annotations around tp->reordering, tp->snd_cwnd
  tcp: annotate data-races around tp->snd_ssthresh
  tcp: annotate data-races around tp->delivered and tp->delivered_ce
  tcp: add data-race annotations for TCP_NLA_SNDQ_SIZE
  tcp: annotate data-races around tp->bytes_sent
  tcp: annotate data-races around tp->bytes_retrans
  tcp: annotate data-races around tp->dsack_dups
  tcp: annotate data-races around tp->reord_seen
  tcp: annotate data-races around tp->srtt_us
  tcp: annotate data-races around tp->timeout_rehash
  tcp: annotate data-races around (tp->write_seq - tp->snd_nxt)
  tcp: annotate data-races around tp->plb_rehash

 include/net/tcp.h       | 12 +++++---
 include/net/tcp_ecn.h   |  2 +-
 net/core/filter.c       |  2 +-
 net/ipv4/tcp.c          | 64 ++++++++++++++++++++++++-----------------
 net/ipv4/tcp_bbr.c      |  6 ++--
 net/ipv4/tcp_bic.c      |  2 +-
 net/ipv4/tcp_cdg.c      |  4 +--
 net/ipv4/tcp_cubic.c    |  6 ++--
 net/ipv4/tcp_dctcp.c    |  2 +-
 net/ipv4/tcp_input.c    | 42 ++++++++++++++-------------
 net/ipv4/tcp_metrics.c  |  6 ++--
 net/ipv4/tcp_nv.c       |  4 +--
 net/ipv4/tcp_output.c   | 19 ++++++------
 net/ipv4/tcp_plb.c      |  2 +-
 net/ipv4/tcp_timer.c    |  2 +-
 net/ipv4/tcp_vegas.c    |  9 +++---
 net/ipv4/tcp_westwood.c |  4 +--
 net/ipv4/tcp_yeah.c     |  3 +-
 18 files changed, 107 insertions(+), 84 deletions(-)

-- 
2.54.0.rc1.513.gad8abe7a5a-goog


