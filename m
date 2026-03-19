Return-Path: <netdev+bounces-269296-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +OnjAit4u2lvkgIAu9opvQ
	(envelope-from <netdev+bounces-269296-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 05:14:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F41D2C5D6A
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 05:14:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B2E2330101F4
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 04:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C9753019D7;
	Thu, 19 Mar 2026 04:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="txSMVbTa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B1654723
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 04:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773893672; cv=none; b=VfoLGotreQPKGqJWUcRVmT2Kyx8FMEOjgUnPMlk07XvspC4b3R0rrocir0MI0FCqYuDBk+eLwnlwGr+hKxCQumT8lGMU+wZodToDIGy7OhHVSSX42n8+gxzWQ1OMs/N7/YNy+kfErfic6YYczEGdtGWf1uHDgzSiUTiDBCHGeqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773893672; c=relaxed/simple;
	bh=4OXejzhu08kOdqh8Lj1Meg6AIKJ/btz774AdmYSMS60=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=MXIwYljjj/NHTxXYDtBa8ffpDrGhBU4zpSzrVOzICAEBsq82SwmfL9uzsARL+whJ69XAWiaREV5fv1yOtBgvd7zR28mfIlOipaU0gfHGPiabeg2Qb5PqUlitkNPXnvjKQlibnag/NcWQXSOzOAjDGmrxwA2bbpENifw4ur0dOcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=txSMVbTa; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c7424d91b2dso304261a12.1
        for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 21:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773893671; x=1774498471; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UgGrzTHUNbcPOTwytSFM4xn7OfyGm4MNHjPOzMj9QmE=;
        b=txSMVbTajlyn4GrGk+ObuDrfWfmTs8wjNXojsiP+bPyxfcRi86UBYUrW2lZr3QNw5R
         OjoaamT0WsOaxioE5W5QHy25pzgWQ+9ShCBLZgQ6fF2+iNEVt7rwM6NYA7zBPUPOOe6o
         KJt5py/TjvhQC56McwJFp9oMkzAaAk2ZQ7SOQIRJdDOQvVuan3KUuKePoeM+3o4q7CcG
         btd5rszNyxAIQRssHFcHBAHgIS8jazylIU2rXPE+ki+O/dcQuXSUfunVogUkKhyvpHn1
         w+fh1EfDgyZABwmNNDM9AdUSUCJaDmxpJ34IZIWzvYZiVTeRaAFQA2Pp7Gx/fzr55kRx
         P7lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773893671; x=1774498471;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UgGrzTHUNbcPOTwytSFM4xn7OfyGm4MNHjPOzMj9QmE=;
        b=bnMT5H3BnAjtt/bEU1eywaFFpHdNpZoOLsQrjVDFiFV3UMJ31dTsXzpCH41fLybV47
         DIjAN1zHHiuVk6KGqcJ7NLFdlAJS1CeMc5E1rd+ukIKEqjqtuj4TnBEsrYukydAyAFyc
         pYzW/wfHdNKjOkqEEmMRg1vpWgd9e7stot0DkQE7fsZy0RiXqS08N1W9OG/pAvAqnLPJ
         Bu+jAJD3VU5Jloq3q6VPbdo6HaNzxDxwXEqOvY5/dsWXqrU4uQ19piTKrsVjgALZNGJD
         I/Z9Vc2+uIYNuNCBHPiTHDx1uM0i88l5c3zrbitvmemrOpezH2Ws49gX4hrd1LRQY52l
         /dMg==
X-Forwarded-Encrypted: i=1; AJvYcCXldFztfyyqSMDQkEknWyIyyEhAYgd+j2wL0YCQnX5PUQogBDd/3biEBY9Vw5yLehH0Yc+Cyhc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7Attj0GOd9Y+oXHpWjNnjpTWM8DPkmRp5HVslt3e3idkuSH3p
	2djuhxFflHEowCL3t2DLBMXEH7mEEE0HymJ2B+yX8nMv1Faz8PwqzGrLMc9eIvyWoUCGHsVidLC
	LzX7eXw==
X-Received: from pgdg6.prod.google.com ([2002:a05:6a02:51c6:b0:c73:7d8e:b5dc])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:394b:b0:398:759d:23e
 with SMTP id adf61e73a8af0-39b99f606c9mr5300385637.32.1773893670463; Wed, 18
 Mar 2026 21:14:30 -0700 (PDT)
Date: Thu, 19 Mar 2026 04:13:49 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
Message-ID: <20260319041427.1528743-1-kuniyu@google.com>
Subject: [PATCH v5 net 0/3] ipv6: Fix two GC issues with permanent routes.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: David Ahern <dsahern@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Kui-Feng Lee <thinker.li@gmail.com>, Xin Long <lucien.xin@gmail.com>, 
	Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,google.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269296-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.739];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 9F41D2C5D6A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Patch 1 fixes the unbounded growth of tb6_gc_hlist due to
permanent routes whose exception routes have all expired.

Patch 2 fixes an issue where exception routes tied to
permanent routes are not properly aged.

Patch 3 is a selftest for the issue fixed by Patch 2.


Changes:
  v5:
    Add selftest

  v4: https://lore.kernel.org/netdev/20260311052954.1224278-1-kuniyu@google.com/
    Patch 2: s/,/;/ for fib6_gc_args initialisation

  v3: https://lore.kernel.org/netdev/20260309180804.3471287-1-kuniyu@google.com/
    Patch 2: Use IS_ENABLED()

  v2: https://lore.kernel.org/netdev/20260308032304.1841198-1-kuniyu@google.com/
    Patch 2: Fix build failure when CONFIG_IPV6=n (no net->ipv6 definition)

  v1: https://lore.kernel.org/netdev/20260307024709.718395-1-kuniyu@google.com/


Kuniyuki Iwashima (3):
  ipv6: Remove permanent routes from tb6_gc_hlist when all exceptions
    expire.
  ipv6: Don't remove permanent routes with exceptions from tb6_gc_hlist.
  selftest: net: Add GC test for temporary routes with exceptions.

 include/net/ip6_fib.h                    | 19 +++++++-
 net/ipv6/addrconf.c                      |  4 +-
 net/ipv6/ip6_fib.c                       | 15 +++++-
 net/ipv6/route.c                         |  2 +-
 tools/testing/selftests/net/fib_tests.sh | 61 ++++++++++++++++++++++--
 5 files changed, 92 insertions(+), 9 deletions(-)

-- 
2.53.0.851.ga537e3e6e9-goog


