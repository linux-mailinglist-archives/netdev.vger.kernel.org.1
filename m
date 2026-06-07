Return-Path: <netdev+bounces-296176-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jqnvJaPiJGoSBAIAu9opvQ
	(envelope-from <netdev+bounces-296176-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 05:16:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 024CA64EBB7
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 05:16:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=asu.edu header.s=google header.b=cYbNqnSD;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296176-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-296176-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=asu.edu;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DDE8D300E3DE
	for <lists+netdev@lfdr.de>; Sun,  7 Jun 2026 03:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B73282F29;
	Sun,  7 Jun 2026 03:16:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D93B175A95
	for <netdev@vger.kernel.org>; Sun,  7 Jun 2026 03:16:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780802207; cv=none; b=OlEu92iG2ceCeiA4/6LcxAEKCkDnyEMB4EUWUJ4LChUF+s3907p/lkt5OlAuHzNHQUgk1gDAShu14QQephaVlqCn8FY3kTjwPnKNqeAaaYzVJRxZgqapOI5ouCUU3s9AH42HdUOgL+W0SMWcV8cR+YQkbktkle7gn8NpkAcD5w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780802207; c=relaxed/simple;
	bh=ID+fiRqyDGZiu3ulVgi5EQgOeQ1Va9q8bcqANPdSEk8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sVwOmEMLO3CLueaQBHXfi0WBchuF+otQqVG+TneZ3AuWOokoArsCCMKlRKOdh744rksWIUUIOrOqd2PvpeUSXVikp7zxlOYB+tnYDnx5d2wSW14fJccmxq3PXjrFa8K+0AUnXCR6StXekczHrst6MN6ofiaCU1WrrLYcVYaI/po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=cYbNqnSD; arc=none smtp.client-ip=74.125.82.47
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-1370417c01cso4366778c88.1
        for <netdev@vger.kernel.org>; Sat, 06 Jun 2026 20:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1780802205; x=1781407005; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l/GX/LbUXcx0AtAzEsXZvm9jj9Ypv36Pw9XvwgWsk5c=;
        b=cYbNqnSDhkslzo9p92uaQm+zMnmgcdnQpSR0m/UNAH7KPFAQ2PMzyzG5JtMVm2MUi1
         vnWpJw0BIPlblBzuJkzkds4Qf3Gpv+Vh/gsv1bpuTNvxdEPv6SzIq/kP+Jp+jFafRqcv
         KQc1cUTr79U19v99irGAk30L78b4+gL4OmMUnSbb5/YUHLsx6pLlEHxjRTImohVcNy1L
         2wTE83oALPPxfYaBsliY5mkM5HpxSgGzeFB0doLjMEyXgtOH6DVFEV4N9RVyQOK6a+za
         nLIxHC6bqLM24QhM69q4k1Hu7TSWjyJHR6lMEqnKgbUaejuwmv1cE8KJYldT5xzNhfzm
         Yb5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780802205; x=1781407005;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l/GX/LbUXcx0AtAzEsXZvm9jj9Ypv36Pw9XvwgWsk5c=;
        b=UCYDdL9aseTqu6YZBJPfX/FE3LKvBUab3TrePdiCu0HAFEnFEyStV6vH02Dx1R0Zhe
         crPyCuALipr5HvhFgaeuEh8Jr46QuLPiiNrkkNgVLZM2eVcNiuB5TKzlRMxZfAYxTspN
         AeKtkENQwEprXhf3w2w9keRhpK6c/pptdd688Rhp0tBjuxDCEISuZ1ByCLD+ezQpzWVM
         /rIORZeixPVFEFp6sNcSRzekX535UnE/yBrQ+3UhrpzLkK+u+FApJScCuNMm+1TKnXux
         ELanDVO4RiZ0o5A1fk0Rnsh9VcR+U64Tqf36YlMxayA5R5Ut2bMK26A3Zlk8/zTWfjmh
         0B7g==
X-Gm-Message-State: AOJu0YyQUpavKqaAWHYJq6eDVEL+qpvrvVv5I9XCOQIb1gGotObG7F0K
	qoGMvzfw2iI5JNhU1t7aFSYdVE8Dp1q/Yhc05A0IPXikpBGo7P24hVDM532f4q3d9j5O0dHjQUS
	I+XY=
X-Gm-Gg: Acq92OHQgiQ04wO6IxgDZMcvP9MkMhHA5+Mxn/jyq7LbkpYS0YgcFPwk38iv54Zo6hm
	kXSdrvU2KVI8qTQHJnG3+5SrbUBtiHuULbR8umbimJlWeUPN0DmT2Di0E4Phy53iR1WlxzkL3iu
	g9spSxtl2QDgkG/j9wkzfoCSLpUeuRkaQP+AWY3zRxSGLCKBLzWQq+Q2AW8nw3Ua7wDa2BRsai3
	uFFLtnGL52lDMxszB/2rfVVf73fhKtjqII/ryJFX7AkH27X+q7dkYPgqEsJpMIw6HlirC5SO9wi
	/RLvRpkIV+E4eg9k7GVK36OkZdJhVlmUCGDSu9qkANPegxw7vC6xyk99B8SgnE9Sn/aWeD3S4Jf
	rRzfhvoz9KbJ/Ii19iP4b5zXjcmqSnyG+BZSQQ9PfqQbcv4iiARMAajoEor6aAh3opI2u+36SyN
	a4Ssdhb2yKWIL8uw==
X-Received: by 2002:a05:7022:4399:b0:138:51c:c5aa with SMTP id a92af1059eb24-138066e1021mr4703629c88.27.1780802205031;
        Sat, 06 Jun 2026 20:16:45 -0700 (PDT)
Received: from p1.. ([2607:fb90:ec89:73c:51:affc:e26:bac8])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137f553ab33sm8968950c88.10.2026.06.06.20.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 20:16:44 -0700 (PDT)
From: Xiang Mei <xmei5@asu.edu>
To: netdev@vger.kernel.org,
	davem@davemloft.net
Cc: yotam.gi@gmail.com,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	bestswngs@gmail.com,
	Xiang Mei <xmei5@asu.edu>
Subject: [PATCH net] psample: zero the netlink attribute padding in PSAMPLE_ATTR_DATA
Date: Sat,  6 Jun 2026 20:16:40 -0700
Message-ID: <20260607031640.2743713-1-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[asu.edu,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[asu.edu:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,google.com,kernel.org,redhat.com,asu.edu];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-296176-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:davem@davemloft.net,m:yotam.gi@gmail.com,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:bestswngs@gmail.com,m:xmei5@asu.edu,m:yotamgi@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[asu.edu:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,asu.edu:mid,asu.edu:dkim,asu.edu:from_mime,asu.edu:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 024CA64EBB7

psample_sample_packet() open-codes the PSAMPLE_ATTR_DATA attribute.
It reserves nla_total_size(data_len) bytes via skb_put() but only writes
NLA_HDRLEN + data_len of them, so when data_len is not a multiple of 4 the
up to 3 trailing alignment-padding bytes are left uninitialised.  The skb
head comes from kmalloc_reserve(), which does not zero memory, so those
bytes hold stale slab contents that are then broadcast to all listeners on
the PSAMPLE_NL_MCGRP_SAMPLE multicast group, leaking kernel heap memory to
userspace.

Zero the trailing padding after the payload copy.

Fixes: 6ae0a6286171 ("net: Introduce psample, a new genetlink channel for packet sampling")
Reported-by: Weiming Shi <bestswngs@gmail.com>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Xiang Mei <xmei5@asu.edu>
---
 net/psample/psample.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/psample/psample.c b/net/psample/psample.c
index 7763662036fb..26220dca0f12 100644
--- a/net/psample/psample.c
+++ b/net/psample/psample.c
@@ -485,6 +485,9 @@ void psample_sample_packet(struct psample_group *group,
 
 		if (skb_copy_bits(skb, 0, nla_data(nla), data_len))
 			goto error;
+
+		memset((unsigned char *)nla + nla->nla_len, 0,
+		       nla_padlen(data_len));
 	}
 
 #ifdef CONFIG_INET
-- 
2.43.0


