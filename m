Return-Path: <netdev+bounces-271297-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sHtuCzH6wmlXngQAu9opvQ
	(envelope-from <netdev+bounces-271297-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 21:55:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B213F31C921
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 21:55:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ACCDC30416FC
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 20:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0169735A925;
	Tue, 24 Mar 2026 20:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xd1kvhRj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99EAF35A38A
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 20:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774385591; cv=none; b=uYfdK/8OWVGVOhC10ZoXKcExQcMZ4ta36XYfYg5QL/pKwSdDvh2aIu/zG0eSZs3ZrqaiffeVo3oz85uw9Ztq9j32yBla7utAtgpG9Q6uj2NltOcVqpvXLAT37AR8U7hAhPV/mDQoXbFrIRU71UQmhfzTYQ5cUpgQGSLjQgVuRmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774385591; c=relaxed/simple;
	bh=R0mrHTGbw4Ix7XXgHgOG4FbxSqBpU9OPj78Ihtveh44=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uv+1K4LErAzB3NXLWqy3B5Lt1srHm6m0hiQrLh/XwQ6YVcdQo3Qd66eJRXHWpnQIfGhKoHg9HRtk9lPsVqMTYY6sJujnZAspMB3H6hpw32UoH8nVm2EatPlg9rp3Zi3+nAdvx4tmiduWdoOo9cL/cq06VyjkxZuhM++tIhjfYj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xd1kvhRj; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7d7fdb922a5so3390841a34.3
        for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 13:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774385589; x=1774990389; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mxUsUi/VC6SYiOs+1SMSLid4Prb4oKr5DoI5DWzEhbg=;
        b=Xd1kvhRjt6w4qA8UpvQFQioCFbzbay+KjCP62M09ss21RMhNip9v3uqHhAsI8OyJjW
         XGh96Xzo7ROihX3A7rFHs8FN9QQOdMvoX+l52F4xGl+iKyT2HEW7kXhncn3RL++1HZLA
         VUmLMJ6Oy4Vz54FHyg3ygXkEvPr8AaHLzV0GW2NO+toFuwXv2VDcxLnVR3IiCgEiMhr7
         Sa/LLiYfjeYN5wSJMyjXkijdLpzlyM8hQvESF65KS+ciV4r1iD9cJFqcdKqeMKLSpIkj
         aRdkXKmu2c8BzPkK+KDwjm0ZJ15LFtapWgtFwlRTYlc4GMG4d5IG1bnf8Vka7QfjrAZ/
         VtOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774385589; x=1774990389;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mxUsUi/VC6SYiOs+1SMSLid4Prb4oKr5DoI5DWzEhbg=;
        b=GpaxPeJxkWPnlyU9HVi4UR+rXfBOAZPHuBsNavEWUJ0AoQ/PeNwSvrcAzFIzrpeEeo
         IRgdMnAuedif9QaxrRgqkS536Y2YjIpcjOM3hLb4F3Z/5oavcrOLEXTU6YOHC6GmJdNy
         OQsGQc0+Pw++eRKT7G9SYSQymc5gOZJb//p3sq3y+cClovNZ3qIjKCht417PEs+eJdKQ
         ghITvX4+ppQUtiX61CLGkGCg/m5OqfVhopHAp6HV7e0hEQJPNna7XanYhyAtqKYgMAj5
         +JK43Ik87c8dY+YMtkJPLxOt0qw27WBu48KSYqjJlXULmLolPV23ndmPZQSU47qrYv7B
         ORYg==
X-Gm-Message-State: AOJu0YwEs5P15U4Vkm76lQ5OQzO5N0YTEnNwYZ6zlxxAUdtQUcR2uyxm
	j8PH4FCNtpAYiBxddpsyRr9w0YWsFitQ6JODnf7szWxr/p+FKp58fRyYYucQZtt/
X-Gm-Gg: ATEYQzyM7EBbdBtSfG002gtr442yezDdmu2F7Ch3W30Ul0giQboah5FSbLfNSBCauhw
	GcL3ViVsSso+3zZAUGLbbYtQhcqWbrilJvOAvkEW5W3HAb8iYvEp7oDFWY7aK3TwUlOWGS3VPAo
	b8B02Aek5SyErX2kbqGhAs1aPl44IajorkGxXv9lVDqm4n8WxMQnC6wuO5Nx3VzbGlz2zIU6/me
	ZVrs4cZxXnWRLh4b4KfkGiiujq9RG68zjC/o7+7zgMSDWVYjQbshVC+ysR7eRltLeRBjJjg8rFY
	HhIl5dbIZ3kXYkYiOh0xr5xpn447slrlI5ZKL6wh954Mv2QxTwObeOQk8Zz1/7nWuE6V932vYEK
	dORvq7VQzk7kK0BaVJrgsWzh3NER/XRXrXSkWPfSQh8VOMXlTbBKmNwcN94VDdbffSuXMKavvGB
	ITyF/N2B1IhuHoZCJvEylCE3RQSjd09OPrjin0F1to1XSxM4jHnN/85PDIe1brUk6cfGURfVWs/
	0VqWRfTli0//dHgOjRDK4lbufrsWI0LBfUUWQho2w==
X-Received: by 2002:a05:6820:4d05:b0:67c:2d5e:e9dd with SMTP id 006d021491bc7-67dff512746mr703832eaf.41.1774385589422;
        Tue, 24 Mar 2026 13:53:09 -0700 (PDT)
Received: from Atwell-Laptop.. (108-212-132-20.lightspeed.irvnca.sbcglobal.net. [108.212.132.20])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-67c252c91d0sm9125161eaf.5.2026.03.24.13.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 13:53:09 -0700 (PDT)
From: Wesley Atwell <atwellwea@gmail.com>
To: netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	David Ahern <dsahern@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Simon Baatz <gmbnomis@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wesley Atwell <atwellwea@gmail.com>
Subject: [PATCH net-next v3 0/3] tcp: fix scaled no-shrink rwnd quantization slack
Date: Tue, 24 Mar 2026 14:52:58 -0600
Message-ID: <20260324205301.1361608-1-atwellwea@gmail.com>
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
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[google.com,kernel.org,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-271297-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
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
X-Rspamd-Queue-Id: B213F31C921
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

This v3 addresses the follow-up review on v2.

Eric pointed out that 1/3 does not need the added packetdrill comment
and that 2/3 compared signed free_space against an unsigned
granularity.

This revision drops the extra in-file comment from 1/3 and keeps
the scaled-window granularity in int space in 2/3 so the comparison
stays type-safe. The overall approach and reproducer remain unchanged
from v2.

Simon was right that the original 3/3 only showed the explicit
rcv_ssthresh-limited ALIGN-up behavior. For v2, 3/3 was replaced with
an OOO-memory-based reproducer that first grows rcv_ssthresh with
in-order data and then drives raw backed free_space below
rcv_ssthresh without advancing rcv_nxt. In the instrumented
old-behavior run that shaped this test, the critical ACK reached
free_space=86190, rcv_ssthresh=86286, and still advertised 87040
(85 << 10). With 2/3 applied, the same ACK stays at 84.

That follow-up also clarified why the broader 2/3 change is required.
A narrower variant that preserved the old rcv_ssthresh-limited ALIGN-up
behavior was not sufficient: earlier ACKs still stored 85 in tp->rcv_wnd,
and tcp_select_window() later preserved that extra unit because shrinking
was disallowed. Keeping tp->rcv_wnd representable across the scaled
no-shrink path is what lets later ACKs settle at the correct
wire-visible edge.

Problem
=======

In the scaled no-shrink path, __tcp_select_window() rounds free_space up
to the receive-window scale quantum:

  window = ALIGN(free_space, 1 << tp->rx_opt.rcv_wscale);

When raw backed free_space sits just below the next quantum, that can
expose fresh sender-visible credit that is not actually backed by the
current receive-memory state.

Approach
========

This repost keeps the part with a clear fail-before/pass-after case:

  - relax one unrelated packetdrill test which was pinning an
    incidental advertised window
  - keep tp->rcv_wnd representable in scaled units by rounding larger
    windows down to the scale quantum
  - preserve only the small non-zero case that would otherwise scale
    away to zero; changing that longstanding non-zero-to-zero behavior
    would be a separate change from the bug proven here
  - prove the actual raw-free_space case with a packetdrill sequence
    that reaches free_space < rcv_ssthresh without changing SO_RCVBUF
    after the handshake

Tests
=====

Local validation included:
- git diff --check
- checkpatch on the touched diff
- /home/wes/nipa/local/vmksft dirty --tests
  'net/packetdrill:tcp_ooo_rcv_mss.pkt
   net/packetdrill:tcp_rcv_quantization_credit.pkt'
  passes in run 20260324-202158-4929 for ipv4, ipv6, and
  ipv4-mapped-ipv6
- the same quantization packetdrill fails on HEAD without 2/3 with:

    expected: win 84
      actual: win 85

Changes in v3
=============

- drop the unnecessary explanatory packetdrill comment from 1/3
- keep 2/3 granularity in signed int space to avoid the free_space
  signed/unsigned comparison bug Eric pointed out
- keep 3/3 unchanged

Series layout
=============

  1/3 selftests: packetdrill: stop pinning rwnd in tcp_ooo_rcv_mss
  2/3 tcp: keep scaled no-shrink window representable
  3/3 selftests: packetdrill: cover scaled rwnd quantization slack

Thanks,
Wesley Atwell

---
 net/ipv4/tcp_output.c                              | 16 +++++++++++-----
 .../selftests/net/packetdrill/tcp_ooo_rcv_mss.pkt |  5 ++---
 .../packetdrill/tcp_rcv_quantization_credit.pkt   | 62 ++++++++++++++++++++++
 3 files changed, 75 insertions(+), 8 deletions(-)
 base-commit: 5446b8691eb8278f10deca92048fad84ffd1e4d5

-- 
2.43.0

