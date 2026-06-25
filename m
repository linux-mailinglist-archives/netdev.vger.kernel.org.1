Return-Path: <netdev+bounces-302062-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KLZoGGtwPWqp3AgAu9opvQ
	(envelope-from <netdev+bounces-302062-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 20:16:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 885E96C8212
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 20:16:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=uYvgCGwt;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302062-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302062-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CF5E7302307E
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 18:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0221330276A;
	Thu, 25 Jun 2026 18:16:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B282A221DB6
	for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 18:16:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782411365; cv=none; b=UCmnsOQS3tMZ48PJX3cfslZxuz7EVtnEvIbRfGFmmlEz5zgNdv70WsJdto06R1YyXdRdNQpKDZjZTP2wMytQS3xf4pxzZYawvBXMsY6Cbkw20fIm3NP+Fnd+UV6Vum1sqi46EjvokfwiGBdSTx7zwmjTfDzNQ4DGi1bK65Tlzeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782411365; c=relaxed/simple;
	bh=R4zMRsC5dgEt3GQ1wY+GOgTcL+mtlusQkycwEbXBb0s=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=VmdpX1wsEjQbSeemKIw9sBL+RI9k1NGlHX3NkdTUtxivzNVno6o+/qOBvwHqJyiYf7Qu96FBC7oT62Oryr4/cIJ3vbt2eOwfqdG7m1bOn0Y7qgJBsqfLYarADgX54FgWu2vkK6hXXvZtEH7WO94xlAOxNyPT3WN7undCnSnJqig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uYvgCGwt; arc=none smtp.client-ip=209.85.216.73
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-37e09f9c4dbso100906a91.0
        for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 11:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782411364; x=1783016164; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Hbt4jAxuO3yIsMnFSQ/zOto2meD/sUjo/A+mTkmLM7Y=;
        b=uYvgCGwt85R1MSPJg9ffGwiyALwqY/ladzGbWwfSFILpgyLHrrkfcuTXzGLzTTnnd3
         Hk+wYStyrKokFa7eGH6722hearuTQVLF6uY9fHVMOi0b2X1nnAFBQcqZYhQzMgTzKnIe
         0qrVQadYPxE9YkBcKqD0Po8aNZMdiUYfBXr72TM3LGvoCp1Lf0ehQPx/gbLDQRjRA2M7
         V4nlN0jC22keZCOHTcnE3yjKoQaNf5XfYUtGMWjY8xcSDWFm5C40kUVwPGlH2yMdbNx6
         unlIguNHENRUahx7hMGGh2v/Ts63ehEwRvJ0TtXPb93vc9oUw6UXrSMYs0VhOFCPss6F
         g4Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782411364; x=1783016164;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hbt4jAxuO3yIsMnFSQ/zOto2meD/sUjo/A+mTkmLM7Y=;
        b=PlSLt28HDVhWY/RQfL7iek841xyRsq0mITht0o3a4Uq/1BKeylZWQlI6VxnvxNL8Hs
         tSNDvtNlTdS3Jo67GS/aysFOXBrhpmFMpH+FT/7U6KGjRejQd3MsQ5PAPHE1En06iJPT
         hwHiVrdjtTjtg9w2eHjdFX7bkdVPB6MajZiV39Pkf42Xg/59R2Kql3fcxqPCOJb3lhg8
         m6l7LmtGSeLzSuj5zHWcnhz/hsarze5z4fMncP/mFPZTxUoNsJaboIwUDp1Gjn+YkTQB
         n9Cw+Eh9wfjyrp47mdk13PvNMjWo8Vy8lBJ5ctbAeLvPr7aVTrTQumvkrfLBLu/GeAdS
         zGCQ==
X-Forwarded-Encrypted: i=1; AHgh+RpzGbmPbXg1aPvN0K25X5ogJw494io5RMP0kJYZYv7rvdRDJvjFeqFuWquRuQ7MEEmGeL/EDTI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqjV7u0LzpTijuGcBYJDAi1GFtVHRKVuLaVpy4BSmfpsNNwOb1
	1LifOq0X4A95/NYO2Z4HldVkvC+2ToJzXWt9b4BfEKCvHz25NTbHMMBZBhmmfIUZKWfsRatDBLb
	FTuLhhrEn8tNgs2Xg/Q==
X-Received: from pjqa10.prod.google.com ([2002:a17:90a:a50a:b0:36b:a5eb:cb3c])
 (user=tjmercier job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3509:b0:36b:b1f4:e0ac with SMTP id 98e67ed59e1d1-37dfa25191amr3459010a91.14.1782411363681;
 Thu, 25 Jun 2026 11:16:03 -0700 (PDT)
Date: Thu, 25 Jun 2026 11:15:55 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260625181557.1086105-1-tjmercier@google.com>
Subject: [PATCH] selftests: Open /dev/udmabuf O_RDONLY
From: "T.J. Mercier" <tjmercier@google.com>
To: kraxel@redhat.com, vivek.kasireddy@intel.com, 
	Shuah Khan <shuah@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: "T.J. Mercier" <tjmercier@google.com>, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:kraxel@redhat.com,m:vivek.kasireddy@intel.com,m:shuah@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:tjmercier@google.com,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[tjmercier@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-302062-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[google.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tjmercier@google.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 885E96C8212

Write permissions on the /dev/udmabuf device file are not required to
issue ioctls and allocate udmabufs. Applications should be opening this
file as O_RDONLY. The BPF dmabuf_iter selftest already does this. [1]

Remove the write access mode from the drivers/dma-buf/udmabuf.c and
drivers/net/hw/ncdevmem.c selftests.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/testing/selftests/bpf/prog_tests/dmabuf_iter.c?h=v7.1#n49

Signed-off-by: T.J. Mercier <tjmercier@google.com>
---
 tools/testing/selftests/drivers/dma-buf/udmabuf.c | 2 +-
 tools/testing/selftests/drivers/net/hw/ncdevmem.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/drivers/dma-buf/udmabuf.c b/tools/testing/selftests/drivers/dma-buf/udmabuf.c
index d78aec662586..ced0b95c876c 100644
--- a/tools/testing/selftests/drivers/dma-buf/udmabuf.c
+++ b/tools/testing/selftests/drivers/dma-buf/udmabuf.c
@@ -140,7 +140,7 @@ int main(int argc, char *argv[])
 	ksft_print_header();
 	ksft_set_plan(7);
 
-	devfd = open("/dev/udmabuf", O_RDWR);
+	devfd = open("/dev/udmabuf", O_RDONLY);
 	if (devfd < 0) {
 		ksft_print_msg(
 			"%s: [skip,no-udmabuf: Unable to access DMA buffer device file]\n",
diff --git a/tools/testing/selftests/drivers/net/hw/ncdevmem.c b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
index e098d6534c3c..8114a29692fd 100644
--- a/tools/testing/selftests/drivers/net/hw/ncdevmem.c
+++ b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
@@ -149,7 +149,7 @@ static struct memory_buffer *udmabuf_alloc(size_t size)
 
 	ctx->size = size;
 
-	ctx->devfd = open("/dev/udmabuf", O_RDWR);
+	ctx->devfd = open("/dev/udmabuf", O_RDONLY);
 	if (ctx->devfd < 0) {
 		pr_err("[skip,no-udmabuf: Unable to access DMA buffer device file]");
 		goto err_free_ctx;
-- 
2.55.0.rc0.799.gd6f94ed593-goog


