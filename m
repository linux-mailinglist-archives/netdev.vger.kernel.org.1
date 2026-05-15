Return-Path: <netdev+bounces-288301-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Fe5FLcSB2rgrQIAu9opvQ
	(envelope-from <netdev+bounces-288301-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 14:33:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E70DA54FA4F
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 14:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B571A300D37C
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 12:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADE8838F254;
	Fri, 15 May 2026 12:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FdJB+61B"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241BD379C30
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 12:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778848237; cv=none; b=bS73Y/5tnAoq7BMD+mSlnqJG5o2V8RlCH7tDBSYWEiYQFfplt6l3rqY1ISVHv/hDJOkKTi0dv4kid/k2aJUkqoaxtSDZZEIUc71RikiR3geTbTgDKnvOs3hxI3RMNvtwOFqd/+bdQS4OfKAsOJ8fX0+fjoU0nwfGQOWohM2AIZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778848237; c=relaxed/simple;
	bh=3wRVXuclZWvyljwdr0/MSGcvXxEyp1AnqKVoCQXr9Vk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Wcf8lnDeD6arohr79y2sZGZWsjcSQR8cWjpIpz6ynSaGZu5I8Ap12Jt7MiWP90pnbDn9dgBG4dLqVwm6xN/WTXYNqW7dquDqaehfca508LGwFT7UFmZal0UlOjm5kBdV3t1b6EU+vWjNIbISqoNDR2D8Y078Dpb2iPywlspuMW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FdJB+61B; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2b45cb89f7eso58345785ad.0
        for <netdev@vger.kernel.org>; Fri, 15 May 2026 05:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778848234; x=1779453034; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X8qDEDsbaFNXQ9XrhS0ZZeE5kY7v1dYSpQA3+agn7yM=;
        b=FdJB+61BR3K2Vmle/GEGk9VpQ1UA1Z0u5RpBqlQrdI+idNLY+sJ4tHaAeZNjFTTs/c
         jcq73VI20ICbvl6e+Z+UAfpiX8Wo/INWaSc+5aSDmyFZhpH918hs/0YFioIKeGSJnTuc
         BVQ+ejcnM2+BaLE8egFq1a+re4iM6gh/Olc6rvNtAKkJvKsi7N2yPajpFb/r3n5lIsYC
         bcYuZOVbpq3C4NQARMifs+3omi7YeUimrji7tZA8zVrCRdZ9sH7gvRiUhGLRrF/bCLLq
         GhO/qtTeE8zLs5v6k7BBAffhtLX4cYznBp3bFZWVnq5QgjWc7CyzfJa9lzJ9dtTWHEkN
         8cIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778848234; x=1779453034;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X8qDEDsbaFNXQ9XrhS0ZZeE5kY7v1dYSpQA3+agn7yM=;
        b=R71998rLHcLc/jfltfxP1bvNkXewh/9uwGjIkayT+XdFSyN4oxhZe26A1hdTOAbpAN
         NxDyGIMP/jFmoy4RqoOiPhByubb/3n////3lL3852dHqnJKI8loAXeXkuc9D0xh3uMen
         e65nG5LYwVb5DzFqKrAsyJI1MPNGlsCKSNnsTbRMHjqo7EjOhdafyDUgUN3jC/2MZ4VA
         QlN6D/NoaDUxePW2gaNyvFUC1pZH9MeD41Qv2nw0u02GdywsgzyFtfG6omtQsa1038IR
         lbmGts1+f2kvtnD3SDZCv+ROVgjSCSw8U9y0hkn5wqxUq4Q/Hc81Xqg5hE+Ue0yYQs+9
         fITQ==
X-Forwarded-Encrypted: i=1; AFNElJ8AzIxqLFcFJhvVUHAnK18QI6Ac3BRZjf0lMrVZZINqFv4OqIwjH7Ug1iO/Nr/Cl+SnB/T8ltU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjLq4JmHUnLwV7XC7LLRL6uT/w0YPCM62UbIIvRZhJwAtConJW
	OENqhd9S5QrRIAJCx2b7O3b2hWA/gflejbe14ZgSRjX3HXZs9Zi9QAo0
X-Gm-Gg: Acq92OHGeVo8cfAWDlDD/JAuVHVUL2GSxFYbBrRRmLKBHFlCja5yhB0tCE4WOa6NxDP
	Pa5NQW9SaaSjVf/CsAyZl9HE3OIP86vmZO78HrxfJFmsPFdJcS8+aSh8JtWx+OQWLihpU8u07Ax
	UxEq/k0Cd6aH8macWgFCeU04RrTPYIBxoGPqY5Y1Y/nEKNlK6aV5vklumSDT/ac5XW44dt8mT5v
	LnXB6ljsEJ6FiMffW855W5k2xSVGKdyYTuNXm6nHj/Vm7vfVH4MORRQDqGKd/dwIqbsxREINzET
	xcWBYp0c/rRMLtA/dz3QcjD7g+lujGx9UYETSwyc6b44WFPli6KvWcbauzATcVAGrajqXl0gL1G
	3m30fRStAPoeGR2U61B0isqWA77CCGlPeivkJaLeAMfF97d6UtBI7rZzmyNqQ8jtHFdkK5p3xSx
	RS1Z418KHBWKyOR+Vi8JH7kbVqgW/8jkQb9APklRgMftQETcnlqJAQ/Mw52eWTi942+gQBM1KwC
	9hrQTaiVjSlI8+fwTaSTbBh9PsxwEw2paKku7W2bfqShiCtLyeZ
X-Received: by 2002:a17:903:2a87:b0:2ba:4eee:6c1e with SMTP id d9443c01a7336-2bd7e8214d5mr41764845ad.15.1778848234272;
        Fri, 15 May 2026 05:30:34 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([2408:8207:1923:2c20:a48a:1116:aa2d:1122])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5cfe492asm60348885ad.48.2026.05.15.05.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 05:30:33 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bjorn@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com,
	sdf@fomichev.me,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net v2 0/5] xsk: fix meta and publish of cq issues
Date: Fri, 15 May 2026 20:30:13 +0800
Message-Id: <20260515123018.80147-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E70DA54FA4F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288301-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,intel.com,gmail.com,fomichev.me,iogearbox.net,lunn.ch];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

From: Jason Xing <kernelxing@tencent.com>

The series is the product of previous review from sashiko[1].

1) META
patch 1: address TOCTOU around metadata.

2) PUBLISH of CQ
patch 2: make sure xsk_addr->addrs[] can be published to cq when
         overflow occurs.
patch 3: keep cleaning up the continuation descs (more than 17) and
         publish its address when overflow occurs.
patch 4: like patch 3, but only handles the invalid descs cases.

[1]: https://lore.kernel.org/all/20260502200722.53960-1-kerneljasonxing@gmail.com/

---
V2
Link: https://lore.kernel.org/all/20260510012310.88570-1-kerneljasonxing@gmail.com/
1. adjust selftests (Jakub)
2. add READ_ONCE in patch 1 (Stan)


Jason Xing (5):
  xsk: cache csum_start/csum_offset to fix TOCTOU in xsk_skb_metadata()
  xsk: fix buffer leak in xsk_drop_skb() for AF_XDP multi-buffer Tx
  xsk: drain continuation descs after overflow in xsk_build_skb()
  xsk: drain continuation descs on invalid descriptor in
    __xsk_generic_xmit()
  selftests/xsk: fix multi-buffer invalid desc tests for drain_cont

 include/net/xdp_sock.h                        |  1 +
 net/xdp/xsk.c                                 | 48 +++++++++++++++----
 .../selftests/bpf/prog_tests/test_xsk.c       | 45 +++++++++--------
 3 files changed, 64 insertions(+), 30 deletions(-)

-- 
2.41.3


