Return-Path: <netdev+bounces-268454-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wHFsJW/6uGkumgEAu9opvQ
	(envelope-from <netdev+bounces-268454-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 07:53:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 416FB2A47C4
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 07:53:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B9D453041A60
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 06:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0CE347FC8;
	Tue, 17 Mar 2026 06:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MTteQ1J8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331B1347526
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 06:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773730310; cv=none; b=A6JU3lg7HIUhbtQ4cYsTV1K+RZvO6DV1k/1gTO0xM7yAQE3EvaOnTiwKWhPSLzJ1b8/hjiu7i/S7C6cA9lK+ZMvL+TanhH9vFXWXatS9+YB8NMdQm1HzekHmAmB8k5kJOiP4Ir5+SG/u01b8A84oRPVEydcIerT4FYmG1SWA0XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773730310; c=relaxed/simple;
	bh=lQepeT2k5Fl+bQiBTdo/2RKQeJqwOuJNKIE68wRejzg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mGR89Lhj0roINcecD70YG9aO3+JL4+SH75qzOITK/3TPW19ugf8eIvSU5eVEer/YlJSDRJ6wFuHXUXiAWhanZG0o1D/RO1AyFjOp1G6QO2ZZf3hN49t3FtZQSvfGbqzaAXd565pJPuC1HfUYUqpYhSKaqqbVbQVvw4mKdCkQM/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MTteQ1J8; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7d756f2a06dso399180a34.1
        for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 23:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773730308; x=1774335108; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qtZywvH13a+APguVp2Hp2i8RvJD5haTPVdtJ4uElfYY=;
        b=MTteQ1J8C1UOOsadyvZkzxhhzWq4e6J80QNolx6BDnVMOryMC/iakMZhAsbr9AZumZ
         OJoQg2+wmr2QiZIliQxAkkLhk6vDG7ZmMsBkdWNQ1kW4pVKUm3FStSk17n/7FApNdFpz
         /bOs00J3L02OcsDt9FJ9CrOXUZOs2QSGaPTQXO3RGgjkfmr8n0i8aAZg6ySeqcdK+AWp
         EI7QfbhB4/PHw+ac86fnXaWlMZeV45QR7H+8v/I+noAOGOB/7gHcM1S0UmyVf+6vyqhe
         59JS9cBTNeK1LvnpvGOOR69v7j0pNUmjyOtTmeCykXOtRMSv4thDgQkDTy+2RQDJ6LFf
         Liwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773730308; x=1774335108;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qtZywvH13a+APguVp2Hp2i8RvJD5haTPVdtJ4uElfYY=;
        b=HJN+uUwd2zGl2+kVOV+p0PloetEdRAH2r3gJuygWAE0HJLx+HSxQ3eGzpgjPGHiwbB
         uOsh7zL3Hm0ctlbj1FmfNwB8pgenm59L0JjuFJsXIGa220IUN0RoXJw9efqG2QWiYh4E
         Yfq2U04RxQ1PgN8/+3treyygT6XhgFfocy+hCyfOupI6+ZLEamoOev0pcKutdi44AvkB
         0fYHxyuAQyN3UMME48SeNp75MVU+s0/wz3kQmXkiO96nXTys2NXX9oj9LPKloog97Gjm
         UyD/fyb8c+XGnPFy9f6v+yHF4FTTUUMzakLbVj8wCEFzVfgCTQIfcBTYlIi1Wv/9pr6a
         INUw==
X-Gm-Message-State: AOJu0YzdEG3giYVsWs7q9Roq2QsnmDEvOJ9PfM2JQ+zOguviZzTs1pGM
	uCD8fwywPXjtl6hN+Vvu7jjEUPFCi4LRwuTrbITb0/NMrCBeGcqaS7rlt78uYyEKht4=
X-Gm-Gg: ATEYQzyFMx1NltYKZqekUTT4CYaR7bY4PtTzwRFphHSYw+lhj0IGqdwgvPbABZubq2l
	WNIU6aDIvI1MuhYmmfSkx60v1y8VvcctXkmQ6uX2Gk4NZ2J469Kwy69vIsLPMsGc1cs+wTL4gkq
	6Vr4erI2xL41lCsR251ltbdHZuq02wuYT31U4AgADJ97ck39J3CmEVuQNn/m2xy//HlD4HtFgpM
	JsDWG5zbzimBLvx5AevYQEFl0JLJQx9cmsTSbsFq1GmmVqfAWy4Vi0K/Wtz5akTeTS7ejTu5bq3
	ipG6uEJ8VuZpumJWJYNx4JvPx6QhYkK/h4n2amf6I+mVMVGnIZogM4F6ggVV6E+R2IAbeoGUu6M
	i0J2lhom4Bl8/Ye4mqWmwHYqH5llMmlEJ4GiYsWQf2EcDA69WOBO7KWE4o5I2PmqKkoVgnE1u3X
	LFj64LmNduFKFfgh/whk4TkXdA19nOt+bj/rgsy93viVGUt57BlgEYD1dFIsDSYMteiFFqS0tXZ
	7QaVPWHp1dhWQJj8dfk3Vx+lcOoH87Hyee6tQZSAw==
X-Received: by 2002:a05:6830:3d95:b0:7d7:45b7:ed8a with SMTP id 46e09a7af769-7d7bb6c0f7cmr936737a34.5.1773730307840;
        Mon, 16 Mar 2026 23:51:47 -0700 (PDT)
Received: from Atwell-Laptop.. (108-212-132-20.lightspeed.irvnca.sbcglobal.net. [108.212.132.20])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d76ae68a4bsm14058432a34.19.2026.03.16.23.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 23:51:47 -0700 (PDT)
From: Wesley Atwell <atwellwea@gmail.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	kuniyu@google.com,
	ncardwell@google.com,
	pabeni@redhat.com,
	shuah@kernel.org,
	Wesley Atwell <atwellwea@gmail.com>
Subject: [PATCH net-next 0/3] tcp: fix scaled no-shrink rwnd quantization slack
Date: Tue, 17 Mar 2026 00:51:34 -0600
Message-ID: <20260317065137.1533226-1-atwellwea@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,kernel.org,google.com,redhat.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-268454-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[atwellwea@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 416FB2A47C4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

this is a new, narrow series for one specific receive-window problem in
the scaled no-shrink path.

The earlier larger receive-window accounting series tried to address
multiple cases at once: quantization slack, live scaling-ratio drift,
retracted windows, repair state, MPTCP state, and extra test plumbing.
Review on that version was useful, but it also made clear that the
series was trying to carry more mechanism than the currently proven
problem justified.

This repost keeps only the part with a clear fail-before/pass-after
story today, and it keeps the stored receive-window state representable
so later no-shrink decisions continue to reason from a right edge the
peer could actually have seen on the wire.

Problem
=======

In the scaled no-shrink path, __tcp_select_window() rounds free_space up
to the receive-window scale quantum:

  window = ALIGN(free_space, 1 << tp->rx_opt.rcv_wscale);

When free_space sits just below the next quantum, that can expose fresh
sender-visible credit that is not actually backed by the current receive
memory state.

That is not just a presentation artifact. Later hard admission can still
reject data which is within the sender-visible offer.

A narrower first rework that stored raw free_space would not have been
safe either. Later no-shrink preservation derives the current offer from

  tp->rcv_wup + tp->rcv_wnd - tp->rcv_nxt

so the stored window still needs to remain representable in scaled
units.

Approach
========

Instead of rounding larger raw windows up in the scaled no-shrink path,
keep only the cases we actually need:

  - relax one unrelated packetdrill test which was pinning an
    incidental advertised window
  - keep tp->rcv_wnd representable in scaled units by rounding larger
    windows down to the scale quantum
  - preserve only the small non-zero case that would otherwise scale
    away to zero
  - rely on the existing tcp_select_window() no-shrink preservation
    logic for already-exposed credit

That removes the larger-window quantization slack from rounding
free_space up, while preserving the small non-zero case needed to avoid
scaling away to zero.

Tests
=====

The packetdrill reproducer exercises both the immediate quantization
case and a follow-on ACK after a small OOO receive-memory change.
Before the TCP change, it fails on the first outbound packet with the
advertised window one scaled unit too large:

  expected: win 84
    actual: win 85

After the TCP change, the reproducer passes and the follow-on ACK also
stays at 84.

Series layout
=============

  1/3 selftests: packetdrill: stop pinning rwnd in tcp_ooo_rcv_mss
  2/3 tcp: keep scaled no-shrink window representable
  3/3 selftests: packetdrill: cover scaled rwnd quantization slack

Thanks,
Wesley Atwell

---
 net/ipv4/tcp_output.c                              | 16 +++++---
 .../selftests/net/packetdrill/tcp_ooo_rcv_mss.pkt |  8 ++--
 .../packetdrill/tcp_rcv_quantization_credit.pkt   | 45 ++++++++++++++++++++++
 3 files changed, 61 insertions(+), 8 deletions(-)

-- 
2.43.0

