Return-Path: <netdev+bounces-288341-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IPljCsE5B2ottwIAu9opvQ
	(envelope-from <netdev+bounces-288341-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 17:20:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DE7E95520D5
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 17:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B3F4E30794E5
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 15:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 531943CCA12;
	Fri, 15 May 2026 15:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=northecho-dev.20251104.gappssmtp.com header.i=@northecho-dev.20251104.gappssmtp.com header.b="eEILS7a0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86B03CB908
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 15:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778858174; cv=none; b=HxfkOvZwAxNqDPd7ife5cL/BnPaHXAYLIDnJMBNrpUD1ScYist0n7JcnTopWibes+XFzfaoAHlIup8x3Op/FkMDpkBXTvnwLp/I2p+GwHUUJfZ2vvymjfo0PRm26tmxwm6qbFJioWi1vO9gZzQYxWaUyN1+3sjrxAwDSxRxlGdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778858174; c=relaxed/simple;
	bh=8PmVyxQmnnEiS1KxO/fEeLK8LEKexDtIgCORnjyk6tQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gYN5Ay1Ra0zSCFqk4uwXiEJzQcTgvIJIXBtJl3pntU6xRoWD6cXsYUzHBDr5O+pHUoJSLykQvD+2Nvg1j4X5ztXkYS0PwqCFVN9AfMDQVZfEtd+dlUXm2IQMkxDqIEFSGzUgGyE33+B5FQxwA5f/zy5Ah3m08DlDmjH9BnBQsSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=northecho.dev; spf=none smtp.mailfrom=northecho.dev; dkim=pass (2048-bit key) header.d=northecho-dev.20251104.gappssmtp.com header.i=@northecho-dev.20251104.gappssmtp.com header.b=eEILS7a0; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=northecho.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=northecho.dev
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-651b71f5cffso1332359d50.2
        for <netdev@vger.kernel.org>; Fri, 15 May 2026 08:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=northecho-dev.20251104.gappssmtp.com; s=20251104; t=1778858172; x=1779462972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OKFizhLjRF18dIH2oJNICiOfhq8yOlJciPdatJOILtg=;
        b=eEILS7a0PD8Q9XvNQDnKKw1N97OdbdtPQ3RzGLXwj1ldbP3C/CVYZrCOp6i86i8ENu
         xRm7kWa0LHvblNAsASl32Tbmr5aAg8zxUdeMjfI0kPx+BmXHfwXu+sbprW3/xm1VfpNJ
         6hFuMMnHEyDuAAI9tz6B0bHaUIc25Iimk3jF4eyZZNUp5PfbEq+nhVjooz2lZ9/cuUYI
         rW/UkYHQJWFAuwNjrOueHdrXJUSD+AbJ1emiIJXOc4mSCWvton1YpTK+S+xDtpdFURox
         Zjw6EZuT40oE5ZZ6YRpOf8qEwuoZS8iVdRV1kHIZyiHQregM/pIEpFAXEf5scXbRrSys
         27uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778858172; x=1779462972;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OKFizhLjRF18dIH2oJNICiOfhq8yOlJciPdatJOILtg=;
        b=pLQoNU1yhT6nj9ftkmjMHv02LPuT+l+7ZWNQh03flIrSpLcTK/iQgXrsehjjytyE4q
         O6s6ffR0ULEgxbA6/SIz036ZlhUwYCTRY8Op8tvtelMODUTPtpt8ZxDnVaTqRLFz4wAI
         0lR8jM2zC1piSHQjEfKTZR948scOyM4/Va16Q/OOVSrv/Y+BM7mtKKaHvEwg1Dlssl/N
         SQ1wuRhs7MzvA0wF9KcNRQ0yjflirVO/0w4AU0pgcLpnjBfAWV1FtacDx8kqVoYXAE6Z
         /DYlxHEAqXauztOcvJUiUA7uegJfBpR0xnS+jEdpTMqR50XQkYFWw1EBnZkgFee79DyV
         HXuw==
X-Forwarded-Encrypted: i=1; AFNElJ/L63UJt+HEudfcwIzjnZobQFQPTxhuNiksgRRiXBsZcs/38PxtUtzTZrztKDxNriKJ1UGCHxk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb3rveolBHiZNVhAxdqkWY71LjzykltUsR8hyzfF3rYFWxiChf
	2079fwVUtxstFwXCf5FzqdlXBVjXiSrH3ewpK1YjjzkVTH6+i+kCswFeVKco6OV9zb8h
X-Gm-Gg: Acq92OGP+hrNZcSWbi/UUL5MPXFs65V0Stl77Ird5JxOcshUw2FqTVe8qAwtjRE/8V4
	MghVMKqx1x8SADr1LTc0Er/S/gUb9Eh6EtK7ptV5wQ733B5EQhVeRqPENToJzd2SAtmQzxSuXBt
	ArWaHb077QyiTj0roR+dOEPuPz+i9HBXaACKp0GPNST0ZoDlV3V48RjADpsMzabIuG8mHjBDNtC
	SL/ashcJaY0p8RrQSNtDV0pl65KvcuUDJGL40hK4oZ3N41u+i4oIDFjYxpUwk5QF6fTBw9815lR
	LW5bPXv/VByLebBYuX9htXxA99OYuXPA+xNdnTTBOEEqsHJERCrbc+F1OEvVWrlWbdSehQ1+9xS
	bRzPXXNZtB5tl8o7E5BWXmEttcEpDxNFC5X6t2OIxww8K9lJOn8R0MbBeLS8HSaqaOSp0kgxjDi
	36Bs9nofIyofLY8DxnM1m5wZ6e9/tJjAS2K75iWwKQp01bAL/uyb6oFjzudRLMK1I8qUL4hklWu
	uPzJ8NUCrQEy1U=
X-Received: by 2002:a05:690e:134c:b0:65c:27b5:414c with SMTP id 956f58d0204a3-65e2281c6c2mr2570464d50.5.1778858171353;
        Fri, 15 May 2026 08:16:11 -0700 (PDT)
Received: from kelso.tail8e61da.ts.net (99-10-92-174.lightspeed.rlghnc.sbcglobal.net. [99.10.92.174])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65e0d878cf2sm2724116d50.2.2026.05.15.08.16.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 08:16:10 -0700 (PDT)
From: Christopher Lusk <clusk@northecho.dev>
To: Jakub Kicinski <kuba@kernel.org>
Cc: John Fastabend <john.fastabend@gmail.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 0/2] net: tls: fix async BPF split record loss
Date: Fri, 15 May 2026 11:15:54 -0400
Message-ID: <20260515151556.189841-1-clusk@northecho.dev>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: DE7E95520D5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[northecho-dev.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-288341-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,queasysnail.net,davemloft.net,google.com,redhat.com,kernel.org,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[northecho.dev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[clusk@northecho.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[northecho-dev.20251104.gappssmtp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,northecho-dev.20251104.gappssmtp.com:dkim,northecho.dev:url,northecho.dev:mid]
X-Rspamd-Action: no action

This fixes a kTLS TX bug in the BPF sk_msg apply_bytes path when the
selected AEAD provider completes asynchronously.

tls_push_record() can split ctx->open_rec into the record being encrypted
and a remainder record. If tls_do_encryption() returns -EINPROGRESS, the
current code returns before reattaching the remainder. The peer observes a
truncated stream, and the orphaned tls_rec is leaked.

Patch 1 keeps the split remainder rooted on the async path and lets the BPF
verdict loop continue draining queued records while preserving the async
return signal. Patch 2 adds a regression selftest which compares the sync
and async providers for the same BPF apply_bytes split-record stream.

The selftest fails on the vulnerable tree with the async provider receiving
12916 bytes instead of 17312. It passes with this series:

  TAP version 13
  1..2
  ok 1 sync provider transmits split record
  ok 2 async provider transmits split record

This work is LLM-assisted. The static-analysis variant hunt and
async-boundary state-retention class sweep that surfaced this
candidate site at net/tls/tls_sw.c were performed using Codex
(gpt-5.5); the writeup, patch refinement, and this cover letter
were performed using Claude (claude-opus-4-7). Hardware validation
(QEMU/KVM kernel run, deterministic 17312 vs 12916 sync/async
byte-count delta, lifetime-probe linear-leak scaling) and operator
review at every external gate were human-driven. Methodology
context at https://northecho.dev/posts/codex-vs-claude-code-vuln-research/.

Sent to the public list per the security-bugs.rst exception for
findings trivial to discover via automated tooling, as interpreted
by the kernel security team for LLM-assisted reports (Willy Tarreau,
2026-05-14, IVPU thread).

Christopher Lusk (2):
  net: tls: preserve split open record on async encrypt
  selftests: net: add kTLS async split record regression

 net/tls/tls_sw.c                              |  29 +-
 tools/testing/selftests/net/Makefile          |   5 +
 .../selftests/net/ktls_async_split.bpf.c      |  24 ++
 .../testing/selftests/net/ktls_async_split.c  | 391 ++++++++++++++++++
 4 files changed, 441 insertions(+), 8 deletions(-)
 create mode 100644 tools/testing/selftests/net/ktls_async_split.bpf.c
 create mode 100644 tools/testing/selftests/net/ktls_async_split.c

-- 
2.54.0

