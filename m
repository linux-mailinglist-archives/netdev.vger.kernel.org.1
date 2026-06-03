Return-Path: <netdev+bounces-294883-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id d1QeGmd8IGrQ4AAAu9opvQ
	(envelope-from <netdev+bounces-294883-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 21:11:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AFD5563AC53
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 21:11:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=ZPDdKGTm;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294883-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294883-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 06ACD3059009
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 19:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2761F3290D0;
	Wed,  3 Jun 2026 19:02:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7891313535
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 19:02:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780513371; cv=none; b=DPWcCkJaAK4IRj4uGqWKemVKSHfFMHBnQrsZLXRQ/F7/twJms7FnzwiQ72LXoCEJMsEunp4rDnTKzma9ZDo1PbgOHqRTCV9aFlIN9ZBWq/18Ae6LSu3fOcR9+AUwnXyUXejxza2GgiCqnknsIwL5vyqPEaLRMf8tK8NkX3N3FzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780513371; c=relaxed/simple;
	bh=NrWA9b/vdpafPcNn28QdKsys9t/shOLi7eTYLoaJlMY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RFIgbJUr6dW95aGF3cOCjhm5Ug0cE5d8lUDrRMRUKYl9t2pMF4IZCm3hpj9bz28mju0wK+KndQoULmDSks2MzJ6UyVsRcBOplteLFfzF6HTnok5RvH1yTLYle+jxgt5xvummocrI6K3KtNNxhih1gleNmGzf8rB+i6gGP14xTi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZPDdKGTm; arc=none smtp.client-ip=209.85.128.171
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-7e87602f26aso13473617b3.1
        for <netdev@vger.kernel.org>; Wed, 03 Jun 2026 12:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780513369; x=1781118169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=31SxK4fP+71fOfnYmycGPePs/i0qkE+P837JeBio4E8=;
        b=ZPDdKGTm37irktC4h157wybFG1AEuOC+YNdtS538f4Rc6WhHrS4ULdYnT6HSqvXBWb
         tSALroiUuI+yizNkKEjoS5K3hcfy47kwtfObS09PugzIW1ARvAy1TP0V0rn5wFxfaTXb
         8h8r+cyuhar8tRakMMRAuuDzGmzgXxu9xfgmKUhNvC36MzJ0irhc/f6VJO8Zq9sdKALs
         u/E1ASunhdC9UyzcnLpAsRXMV89mHkjVZORQsrD4Gz5UplNv7Xgh8DXPlBe4XuKAF4yo
         /IaZjsHn77/Q2V0Osjhq5OhujLBnm55dijQd5PI+lF7M8+7kzEUcVg2Tocw1wZxa5Aa0
         Tnxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780513369; x=1781118169;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=31SxK4fP+71fOfnYmycGPePs/i0qkE+P837JeBio4E8=;
        b=QIbtgeoxkx8fQSnC8OfxEUiDjLKZQQ1YoYvs+mS0FW1x69uLGUpTlhcFyCVBy/YzON
         AUjKj6L2FHm7b0Ws4mpCHNgYWT7WebSvTTlSpdogL8BnzKZv56JGc9E0fsQnsCHheeTi
         p/33kc00OT+0yVrksQAhR3+kaAT+ebrLgPCN9BOPhgH2XUHjCHWTJL9TSXqgX1bnD2rG
         rJi0K5TakUiaW+mAKjgKtpLgQ40a/aAZ9B2QYIKQESJHlmIc52GEeTxmWdLJsUWYIt6N
         BcYsd5+d/unchzv6OmDDN+TRQdYowTloL5rE2GRQD8I3Nav0vUp0DOApKkB4LZY/GA/K
         Ajeg==
X-Gm-Message-State: AOJu0YxlMYtJY0PLldzysLIFwbBV1pJjDoHcoiq8DD471x4tOjdl76wI
	8pcR3vnyR2yFam74aU5mol7XLT1NCOxNX7iXKnvRST7jRpqPuCP2NSKDdM0k0Q==
X-Gm-Gg: Acq92OHOgsXWqVnlde5dr3ITHmkvjBrE10fjToJ4BYQOG05It/XM8FwL2rkIiUbIaOG
	lhNCySl6SxCxMmUgDN8JZ5SQQ9tNHQs3GeLlMoeBopkrMLh6WKa676Vww+K8KX/ZYZEWgO255E9
	oaOUAsIl9HsB50ZxR2uLFD5ts/x79/6YCxdvHGfHysWQR7vJ5AzL0YbKzrnYOJiKxDpIssNpqr/
	spBA30VKi+y/+XfAfVUOZ5PWyXJ27nyGzytuer4WI9XoyzvfQZlfaCnQOF64eTuDtadCf73UrpF
	8EbNFde5pvMsIoM3TUgcIBOFD1Hxt/aiBr3BTi3SlWvJtVwbm2r0bAFT2YVOoAcn+1VdaVLPaPE
	ukkMBxiKLUYqpFsIaAFFL3PJTfsvVmq8Wo9dVflpqT/pyAnlbivTo5+y+6/n85smM4y0rj+3UBs
	7oDZx6eIaFVO0DEpfqsRoUMvaNd24Y0Gi/U+eUzVr48Ilx8fUooUHiTRrF9JL1dkPueXbJsM7Hw
	q/U0ZuYlze6EH6sJB74xMFjfjB0N8dEPikvExMF
X-Received: by 2002:a05:690c:e372:b0:79a:b49a:cb4e with SMTP id 00721157ae682-7eb8ae8f419mr6408837b3.6.1780513368951;
        Wed, 03 Jun 2026 12:02:48 -0700 (PDT)
Received: from willemb.c.googlers.com.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7ea20ea8186sm22350467b3.4.2026.06.03.12.02.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 12:02:47 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next 0/3] SO_TXTIME improvements
Date: Wed,  3 Jun 2026 15:01:27 -0400
Message-ID: <20260603190243.2789335-1-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-294883-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:davem@davemloft.net,m:kuba@kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:willemb@google.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AFD5563AC53

From: Willem de Bruijn <willemb@google.com>

FQ targets monotonic timestamps as generated by the TCP stack.

But SO_TXTIME was later added, which can send skbs with timestamps
against other clocks. It is now possible to detect these through skb
tstamp_type.

Make FQ robust by converting these timestamps for use in FQ (patch 2).

This also requires testing against out-of-bounds values. Prefer to do
this at the source, when parsing SCM_TXTIME (patch 1). But, tests in
the hot path are still needed, to handle BPF sources.

Extend the so_txtime selftest to handle this new case (patch 3).

The last patch would have a conflict in net. This is not stable
material, fine to go to net-next only.

Willem de Bruijn (3):
  net: ensure SCM_TXTIME delivery time is no older than system boot
  net_sched: sch_fq: convert skb->tstamp if not monotonic
  selftests: drv-net: extend so_txtime with FQ with other clocks

 net/core/sock.c                               | 32 +++++++++++++-
 net/sched/sch_fq.c                            | 43 ++++++++++++++++---
 .../selftests/drivers/net/so_txtime.py        | 18 ++++++--
 3 files changed, 83 insertions(+), 10 deletions(-)

-- 
2.54.0.1032.g2f8565e1d1-goog


