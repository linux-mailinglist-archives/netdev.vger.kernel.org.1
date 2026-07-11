Return-Path: <netdev+bounces-306786-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id h9pdMK8LUmoXLgMAu9opvQ
	(envelope-from <netdev+bounces-306786-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 11:23:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A0E7410AF
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 11:23:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Sbbxu1do;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306786-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306786-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2AE6C3028F00
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 09:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6141938655A;
	Sat, 11 Jul 2026 09:22:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18860384CD8
	for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 09:22:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783761764; cv=none; b=Y5upyB2O0sNqlhhWpzwV2Rn2MnbUzlY2ls5IvfTTUD6Y1eFERWJpttM7JmHjkUSzzhLteUumwau6ScwUuBkBOSMbBWtOMZAfyzR+daL0pbI6iOOBEnUXKVpPMat78cs0JAJd8PKg4PzgSi8zH4nNADbJMm7kyv2yOo7e9871ZTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783761764; c=relaxed/simple;
	bh=KaFnCEtWpUQbvvttXXEUPsyjrmRQVKjfPVashbeY9KY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=skuy6ASWB2sv5PmuwCUaToRXK7mRkOO/nzxPSeTEVZ8zFFieOGGWyTWRilo/QCTKeNRLv1dDdpZL9+f2JcuIiJ0GWluEDQFesxH+WFeup9W+3Re7lhqjrTRLLfK7f4R/Dr2weVRYz7yUfsNjgS/Wm/6sCgr1IJAIvf2w411o/Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sbbxu1do; arc=none smtp.client-ip=209.85.218.42
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c15ee037bc0so247448966b.3
        for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 02:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783761760; x=1784366560; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Pa9twGKOuhP6ETh34bn7Y+R+QhXkkYcG4vjp7TFaYQU=;
        b=Sbbxu1doKBYWY1W/kPNZIPqCb03J4ndGTRQfuOcyA7oIrR99hFycbx1SuSb1QfFyuz
         qFa4hpG7nQEQ3ta7uAUsjKGjvGIaukWeDG5ekvhH+JUkJAVmcRKM2PpwwkxJmjemKI+a
         d2KlEODy2JLLDhOpVj0kuE2RyVXDdDegBvWwV0QF5btZcFMnCBb5R0zaDao1q6zYoF0Z
         ScZOPiIfxsNntdFLmbS/4P1EdtkNNt+QVij+7X1ZIzl1IKPYRnV2cJVYSI0tSFs5ZweW
         WCBx9HmJ4z8v3xCKkjc2JZowsO5/VDhK6NG6T4DT8i5gb2tPzF1qkuksVQfbeQbs2Yud
         feGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783761760; x=1784366560;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Pa9twGKOuhP6ETh34bn7Y+R+QhXkkYcG4vjp7TFaYQU=;
        b=JnGx3a3SbmythgGwgTCxYybc6QqljgRBE5xXDpBT2CuPNtefOwS8SIvGWfTPq3jdns
         FXxD1oUVViSW2LWyGNQMpQwDSCcRtzCGZGR6P4/luTA8atdCjmgzsHejETbHL8bd1Kxu
         mL7GXYdy10QWGu6k9fBWV57ewf2LCz9Ebt8aV/e76f1H697wOxgTJ+yqcfX/2Koe5xzi
         V0LD0PRREgaJzY7JPVpMTgFQVxqRQ8uag6QyS60IMk+SJ7E5SjIyFOMaCarM+/xUHN2i
         wFARKnX17/aFkJC04pb3NYFUl5hBh5T9lOmMfQ2nbxThulffSNBKKXDkgzdV12pPN5Z3
         +8eA==
X-Forwarded-Encrypted: i=1; AHgh+RqQZZoQDeH6Wow6W/tq6K+uCVAB/80eT5nKQr8RgAdq0eyy8m8T1Uj069ErMhM0aQRzIXODD8I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy733MV2OrdUOinNtpKZ6xvniyJ/C42vvYuXZRx/fpN/EJUlV3v
	xc/xgVYwrDlQIgU+DnsGNvq55Y5sdXYuK1/rYAGavXj0owrNURbHR9YC
X-Gm-Gg: AfdE7cm8V/GsWG9P6f39b4u0gSZMOzH/NxbKhCeNNtpfaDJnrEKUc6P4Oco5MIuUDGt
	f8rCLpczZju9ONyWYT59XqYXpIkcWU3evJ/bLhE9rxQN6+bjpgzYhlobWa1Ja/UBbo9un64rfuJ
	wVPmMUOyAUOGjTH4jYI3sotESTOYo/B7rqH7ghgclrZYlq8aMxZICJ/hMV2thoPQ2Bwjhbjb+FS
	DjntQ/YD83UZkePMniiUObq+3t/efbFi+oI7kEkUvMwFS18Yed6QdxK2WeBbC5SLSAZDLv3SZ4u
	KBBORv3KIZS5IuvW6misCDo1gF5V9VnoIugAB7OyUaZhpdk32JCv9sY3lhmDSOeW4C24DxSQ69l
	7UkGacV/jmeAOjxRsFASzjYyb7BkuG2TSp2UoL346csVA1uewGxJN0lmsqVsVEKAjeENHfll+OZ
	i0u1YvhrvgUc80DJ2qNXKNUj2gQBQhpexxxEFSoxchq6ArvtmdxrzvnQf44QoVFlhf6+oO/H1p2
	j0E9hKjAtCGB1YaX/YVEVfxrQ2YEcSIW9TQYj8+1VW8XPvx3GLcQuLUWw==
X-Received: by 2002:a17:907:e102:b0:c12:696a:b217 with SMTP id a640c23a62f3a-c161e9428d2mr49840166b.25.1783761760393;
        Sat, 11 Jul 2026 02:22:40 -0700 (PDT)
Received: from 127.0.0.1localhost (82-132-221-54.dab.02.net. [82.132.221.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15d3859f69sm517493566b.27.2026.07.11.02.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 02:22:39 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org
Cc: io-uring@vger.kernel.org,
	asml.silence@gmail.com
Subject: [RFC 0/9] optimise zcrx refs cache bouncing
Date: Sat, 11 Jul 2026 10:22:10 +0100
Message-ID: <cover.1783619193.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-306786-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:io-uring@vger.kernel.org,m:asml.silence@gmail.com,m:asmlsilence@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[asmlsilence@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[asmlsilence@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 18A0E7410AF

zcrx works well when user space and NAPI run on the same CPU but loses a
chunk of performance otherwise. It's caused by cache bounces from
1) zcrx "user" refs, which track whether buffers are given to the user
2) niov refs, as zcrx bumps them on recv(), and hence
   skb_attempt_defer_free() doesn't help.

In this patchset, zcrx steals received skbs, delays their destruction
similar to skb_attempt_defer_free(), and processes them in
io_pp_zc_alloc_netmems(). This moves all aforementioned refs
modifications for the hot path to the NAPI context.

For the networking side the most interesting bits are patches 1 and 8,
and patch 6 around the call to tcp_read_sock_steal_skb(). I'm looking
to get opinions on whether tcp_read_sock_steal_skb() is fine or what
kind of helpers / API would work better.

Tested with liburing/examples/{zcrx + send-zerocopy},
200Gbit/s NICs, rx_page=4KB

before: MB/s=18948
CPU    %usr    %sys %iowait    %irq   %soft  %idle
  0    4.92   63.68    0.00    1.64    2.84  26.91
  7    0.00    0.00    0.00    0.30   89.50  10.20

after: MB/s=21034
CPU    %usr    %sys %iowait    %irq   %soft  %idle
  0    5.59   50.18    0.00    2.26    2.73  39.24
  7    0.00    0.00    0.00    0.20   87.49  12.31

Helps in a similar way to 32KB rx page size, and also improves numbers
when NAPI and user space run on the same CPU.

kernel:
url: https://github.com/isilence/linux/tree/zcrx/skb-stealing
git: https://github.com/isilence/linux.git zcrx/skb-stealing

liburing (can be used any other version):
url: https://github.com/isilence/liburing/tree/zcrx/test-skb-steal
git: https://github.com/isilence/liburing.git zcrx/test-skb-steal

Pavel Begunkov (9):
  net: allow __tcp_read_sock actors to steal skbs
  net: add provider specific net_iov field
  io_uring/zcrx: don't save/restore count for frag skbs
  io_uring/zcrx: split frag handling loop
  io_uring/zcrx: split io_zcrx_recv_frag()
  io_uring/zcrx: implement skb stealing
  io_uring/zcrx: don't lock for single producer ptr ring
  io_uring/zcrx: steal niov refs
  io_uring/zcrx: add rq_lock cache of "user" niov refs

 include/linux/net.h  |   1 +
 include/net/netmem.h |   1 +
 include/net/tcp.h    |  13 +++
 io_uring/zcrx.c      | 210 ++++++++++++++++++++++++++++++++++---------
 io_uring/zcrx.h      |   4 +
 net/ipv4/tcp.c       |  11 +++
 6 files changed, 200 insertions(+), 40 deletions(-)

-- 
2.54.0


