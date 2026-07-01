Return-Path: <netdev+bounces-303803-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XY6TDlBpRWoj/goAu9opvQ
	(envelope-from <netdev+bounces-303803-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 21:24:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 906726F0D4A
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 21:23:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=v1uxoo+B;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303803-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303803-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0C52A3034B34
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 19:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB083DE427;
	Wed,  1 Jul 2026 19:22:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5337617C203
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 19:22:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782933734; cv=none; b=C7T/6FUzG5bqQi7DPkMCDG39I6d06+a9xrznkzq8Po5dNQ7N7WxHfw0amrDvo/1ptKjZMf+jtO3D6FOtX/blTVmfZQszVTzFlQA5/Ju/OLKaX0AARoh6AmSsoVn7+rmRV5dJAyQ6RoF0h+JFk3MxEdWN+8GrFHu9qHfpVWXH88U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782933734; c=relaxed/simple;
	bh=JhnW51DmCRFybSnLbK3Q4pdM6DCF2s30FmXO1t7q5aQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=rMt5KAbCi2L3F32WZpPXWAdShwpTMMpLtCpqq0dSRKGL6NUoM9SPI5EQDH60Dr2Lge8qyouU01oKm/egWUtocbgK/Xjfq5yRE4HhdWwfnxs05nH95MfYrZLfnOEy5StsFFKiIXv+QXxKRWSNnXx093ND1cBlxqQApS9oTk57nQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v1uxoo+B; arc=none smtp.client-ip=209.85.210.201
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-8479586724eso987915b3a.2
        for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 12:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782933733; x=1783538533; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ujCabrnr2B8RujS0oeOv8POuubqI2CZlXpFMlH3f0oQ=;
        b=v1uxoo+Bu6qbzhYAaSfNZ9UgnocuaokAhFDh0jwe5kXWbV2zZsU14FNP817/TIZ04w
         fBYBmq2mjVOcrvFTQZ5rogBdwtQjRvC3MlnTcQ4VClp96LvvJKUuCWZOFqnqAlFBAXQ4
         uVBDgHtulnPHPx8PdTP8vDU5nCb9zTp/jhnmpemBdT5Vgdvw3DcwK/z8x5HEc3IAJ71Q
         s7nz9ghy1lSg4Av7qX9zPsq7kosKtYtxOG1f2CDH52WGTL1YvCxB9PHcpepSqPCEPkeS
         r5JQvg7bQKKi8Sv7hDQ8CYcoQ7yBTppN0UKX2M4pMWTw5xvfQ4jLpI0EoPaN426Lu0zp
         mPTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782933733; x=1783538533;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ujCabrnr2B8RujS0oeOv8POuubqI2CZlXpFMlH3f0oQ=;
        b=fl0vAAKmXaMBNZ8SEf8JGFBEP7diLZZul8q6zt+D7g0Q/AKYmFHvPkbDG1dVzzu80X
         Hh9HVQDmaz906ihoWTGEGclmeHJM7kX/dhGTfFkm8dkg0ZHu4ZAKUzWm/wkPZf7LG+eB
         FnsGXrkCKBaIgv4OXEk+Ma4nIcJQT/3PeqIIwoZGuBl2Q6ZKZ/ZZSRJCwGCzuqtkYwGo
         MQ+QtR5IiCFhrg/OwUHqEqjVk3IPVzqO/UeYCyhuUY2XwtAciqvvTeXRjqdVkwiWwAWG
         VPSZSY+VhlwphXqO6YFCCWLxIuR3a5HgEP8FJH1IKjnqxgUbXiDKv6wrNGKBVPkvtQEm
         UbbA==
X-Forwarded-Encrypted: i=1; AHgh+RqganGQejfnh5FBsda+zZpAYhmMPWx3PTkD6JH2rytk5AVdVjsByd2wioOckF54snMJphjU7Qc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVUmPJOtWhIYCXftUQ/OY14xi2WRo26YMI4lnhCjwWhPZZw/OF
	550A0Giqmr6Tr/VuGrYpsunBn5HN5SdHaJJKwhPr/9ZJxkG/WqHK8K2aaDFgr5ElnWiOvrLNI+Q
	Vwh6YsiH4LpwofQIWWw==
X-Received: from pfbjw34.prod.google.com ([2002:a05:6a00:92a2:b0:847:90c9:183f])
 (user=tjmercier job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:3d43:b0:845:e4d6:bd2b with SMTP id d2e1a72fcca58-847c519386emr1793601b3a.48.1782933732340;
 Wed, 01 Jul 2026 12:22:12 -0700 (PDT)
Date: Wed,  1 Jul 2026 12:22:08 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260701192210.2997769-1-tjmercier@google.com>
Subject: [PATCH v2] selftests: Open /dev/udmabuf O_RDONLY
From: "T.J. Mercier" <tjmercier@google.com>
To: kraxel@redhat.com, vivek.kasireddy@intel.com, kuba@kernel.org, 
	Shuah Khan <shuah@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[tjmercier@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS(0.00)[m:kraxel@redhat.com,m:vivek.kasireddy@intel.com,m:kuba@kernel.org,m:shuah@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:tjmercier@google.com,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-303803-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[google.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tjmercier@google.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 906726F0D4A

Write permissions on the /dev/udmabuf device file are not required to
issue ioctls and allocate udmabufs. Applications should be opening this
file as O_RDONLY. The BPF dmabuf_iter selftest already does this. [1]

Users are pointing to these selftests as examples of how use udmabuf,
and encountering permission errors on systems where write permissions
are not available on /dev/udmabuf. Apply the principle of least
privilege to selftests which use udmabuf by removing the write access
mode from drivers/dma-buf/udmabuf.c and drivers/net/hw/ncdevmem.c.

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

base-commit: fbb7ad31ab376c5101b2ac7205fad0344fd2de60
-- 
2.55.0.rc0.799.gd6f94ed593-goog


