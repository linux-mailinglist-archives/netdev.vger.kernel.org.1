Return-Path: <netdev+bounces-290228-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0C0LCyh1DmqE+wUAu9opvQ
	(envelope-from <netdev+bounces-290228-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 04:59:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 969ED59E3F6
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 04:59:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0BEBD302FE8F
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 02:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A7763822A6;
	Thu, 21 May 2026 02:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=northecho-dev.20251104.gappssmtp.com header.i=@northecho-dev.20251104.gappssmtp.com header.b="cYe92JE9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B2F368D52
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 02:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779332372; cv=none; b=ctnIWbfggUR3KiMZzXAp6qEvWJay9v8i++Aau0UEDBUIY+yABuJNyMXDMK+cnMz83PSMS9fvq1YJmTFxMCjWUbGAsK5OlG9sInuoqj4npbDUs6n/9Dd8Wp5XnoDRK0qBvF7JrMW3z6tgg71Wpg8Qxf/JLth1R2COs5raLuemr8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779332372; c=relaxed/simple;
	bh=SzXfkIfY5nT6XTJMo7kSDB18r4QbXHUNY3qQrByfAUk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kvUgW1jZC6pNpyiXrGMEKLZDUPqVxwobBaugV39Er3MIP9ofJAkmTSHuDBesNFEoSNQ9MdoGMQkVK96PvcEEnu2Hkz/oGVGI9ZvFY9Uq6i/KblA2IZfzCU6rs6a3GUux2JDXxKZznmI6E71QMXrepOV1r/T7ZUpYwYdSOK8omlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=northecho.dev; spf=none smtp.mailfrom=northecho.dev; dkim=pass (2048-bit key) header.d=northecho-dev.20251104.gappssmtp.com header.i=@northecho-dev.20251104.gappssmtp.com header.b=cYe92JE9; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=northecho.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=northecho.dev
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-651b71f5cffso636626d50.2
        for <netdev@vger.kernel.org>; Wed, 20 May 2026 19:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=northecho-dev.20251104.gappssmtp.com; s=20251104; t=1779332369; x=1779937169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WPHH7NKYNQc2juIfrHQQIsBoYOBJaS924Jc2tnnxbtQ=;
        b=cYe92JE9oIgyilzRaXBYdeLKspUgroAO074kz6nT87uF39eYzYt8Rbgoc9xqHDDiCm
         8p35rh/O5qXzhfkzi4yoKMMn6mgRxWjy5Md/eTNd7aBSOhKfYTp0N7wBvUHm6tJS6cFe
         EVRbXE5uomiGkw9u7wJILnei/4MhkccwP+3VOf1KHAFr/RASx1o+cWGPLmr9jUNks08t
         BnqWNPthFGGdXlMbi85iLTkECxVMktnlhQaHPozC9PetrpuWM3twFI23i7WRmPWQQ6Iq
         i7XEeBAvT6f6WY4i2iAHzkQqrxLAsHABneslMEsH0iW3L8s1i6K8glTI88z3EyQ4p62f
         0uAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779332369; x=1779937169;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WPHH7NKYNQc2juIfrHQQIsBoYOBJaS924Jc2tnnxbtQ=;
        b=Y9JxcJca/8mCqOCsRzwyGUy6KU45k4QSeGC6FM/5RJfZ23xkj09FCtZUGxodc2oFHL
         wuBn59y/wzaUZRO8opXvEBueUVt1gthOMUcZdJ0X0ytcREWRodt+7b/7ol+iPW4+LeCa
         ytwuk2g3gMxnP7JYp85ur3fPmB8pMoVUzkIkKKt7RONu+Ln06xzKP9RN/jKoh6oF4vmY
         rui2LaqZuNqxQFmuBb2sNok6+8MJna/1/uH4CJoVmctGcRxMpYPgdF+AzBCM3K771IdT
         HVzWqNKvZAXGia3IB/BBg13mFRo9a9rZei3emV8LNjukcOaW1yblmoM9Xr8sbrd+yjkN
         LdbA==
X-Forwarded-Encrypted: i=1; AFNElJ8pR/NnyeYWuqFazmx1N89Sb/EOgtsmFEeXXohxZmdtf9g7QCiW3AtJAbRoSbyCJ2Kb4gUyUDU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzckSZ+5S5MGnFffyP1pg/E+kJF2pgAOpcnzp10uxVop1QJmKZB
	ZknreT4yjZLEZQ1TjU3G8O4tnymcCxv+oXkS9IE/HISG/juk2ckcEe+Qc3CgvcvBUw5F
X-Gm-Gg: Acq92OHWhIrnYyfKAGUq3nunG+1NgvIWlE6+ZR8ekx+ruDP0/o8qMSUDr5f8+Y7q6BR
	W1w7AwPTJZL/EB4E2vXXOC9NCV4jdtZBPe675OzkRq+n1jHXRT+RjwLvqeA9u+2qyBcbVZd+58z
	fI0VB7X9nv8vXmayMLw+1ViCrE04srgAgyDrYgNzOuUYediSDC20hI+YEGsRKnAGU/OIth5pzG6
	CI/VGIwYMvRPOuyFwWTKIV+8z0LgxjAuyOGW54sfxDhS5CO8NvZbg6tgaNkkuCxsbppfSBvyXys
	b0pXgmnFyBkaFu4Ag7YDGfKO4rTusSknUOI7NM2KAM6d1YDQMu3Gpu9QN+e2GPes9El8BAU6Izi
	5BK/2GUoMgNTuioS/EyoumhGMHGh4VKMLg1asQ/kyNZqpX9x3r5+7dzqH7HB3US4gzs8a8SJ4s7
	ipHu6JlI3HKO4j1FtztoTbaAgL4X9MnPT/3H2FF1A/jUyO4lumsiXGynokJeM9vWs+sQr6FjWOt
	HkZOO6bUz/1GhTbSZtCe0+COQ==
X-Received: by 2002:a05:690e:4144:b0:65c:27b5:414c with SMTP id 956f58d0204a3-65eae175db1mr577751d50.5.1779332368618;
        Wed, 20 May 2026 19:59:28 -0700 (PDT)
Received: from kelso.tail8e61da.ts.net (99-10-92-174.lightspeed.rlghnc.sbcglobal.net. [99.10.92.174])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65e0d86c850sm10092743d50.1.2026.05.20.19.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 19:59:27 -0700 (PDT)
From: Christopher Lusk <clusk@northecho.dev>
To: Jakub Kicinski <kuba@kernel.org>
Cc: John Fastabend <john.fastabend@gmail.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2 0/2] net: tls: fix async split record handling
Date: Wed, 20 May 2026 22:58:38 -0400
Message-ID: <20260521025840.976378-1-clusk@northecho.dev>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[northecho-dev.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-290228-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,queasysnail.net,davemloft.net,google.com,redhat.com,kernel.org,iogearbox.net,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[northecho.dev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[northecho.dev:mid,sashiko.dev:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,northecho-dev.20251104.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 969ED59E3F6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When BPF sk_msg apply_bytes splits an open kTLS TX record and the
selected AEAD provider completes asynchronously, tls_push_record()
currently returns -EINPROGRESS before reattaching the split remainder.
The peer can receive a truncated stream and the detached tls_rec
remainder is leaked.

Patch 1 keeps the split remainder rooted before returning
-EINPROGRESS, continues the BPF verdict drain loop after queueing an
async record, and waits for already-queued async encryption if a later
verdict iteration must return a hard error. That last part addresses
the return-value masking issue reported by Sashiko on v1.

Patch 2 adds a selftest covering the sync and async providers for the
split-record path. v2 also checks the BPF program fd before attaching
the selftest program.

This report and patch were prepared with AI assistance. The generated
analysis was checked against the current source, the reproducer was run
against vulnerable and fixed kernels, and the fix was runtime-validated
on QEMU/KVM with a KASAN+LOCKDEP-instrumented kernel against net base
5db89c995. The pass-then-drop BPF probe that exercises Finding 1's
failure mode ran clean (no KASAN report, no lockdep splat).

v1:
https://lore.kernel.org/all/20260515151556.189841-1-clusk@northecho.dev/

Sashiko review:
https://sashiko.dev/#/patchset/20260515151556.189841-1-clusk@northecho.dev

John Fastabend reply on v1 (confirmed Sashiko's return-value masking
finding is a legitimate concern; this v2 is the response):
https://lore.kernel.org/all/huduxtn6parzgiaf5cyiyrrvjjvx6jsdedowvrd4nkwmuyeind@j6migjgofh2i/

Changes since v1:
- Preserve the later hard error from bpf_exec_tx_verdict() after waiting
  for any earlier async encryption queued in the same verdict drain loop.
- Flush completed async records after that local wait.
- Check bpf_program__fd() before bpf_prog_attach() in the selftest.
- Leave the __SK_REDIRECT socket-lock-drop finding out of this series;
  it appears pre-existing and should be handled separately if maintainers
  want to pursue it.

Christopher Lusk (2):
  net: tls: preserve split open record on async encrypt
  selftests: net: add kTLS async split record regression

 net/tls/tls_sw.c                              |  40 +-
 tools/testing/selftests/net/Makefile          |   5 +
 .../selftests/net/ktls_async_split.bpf.c      |  24 ++
 .../testing/selftests/net/ktls_async_split.c  | 393 ++++++++++++++++++
 4 files changed, 454 insertions(+), 8 deletions(-)
 create mode 100644 tools/testing/selftests/net/ktls_async_split.bpf.c
 create mode 100644 tools/testing/selftests/net/ktls_async_split.c

-- 
2.54.0

