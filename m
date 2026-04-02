Return-Path: <netdev+bounces-274358-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yAMbIynnzWmuiwYAu9opvQ
	(envelope-from <netdev+bounces-274358-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 05:48:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AB6A3833F3
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 05:48:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC747300DDFF
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 03:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01B7035979;
	Thu,  2 Apr 2026 03:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P7VkyG8g"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC2313FEE
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 03:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775101283; cv=none; b=nTM1r0oM64sbZ4rxdrqaxbzMVOgnxMYfukD29Cgq1gWXBHiEPfKt8OKsbp+szqSwZKxxZiILwiKPXLbTj4CbxMv3nlE5PNp5ikx2JKgMoHyAd/kTF1qB/aLyuD7cdV5Uz9X7oTEeqdZFh+2XrX5BeYznWuvaVSwwnYcl8Xj7xXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775101283; c=relaxed/simple;
	bh=AgtIA8XWuKpG74yfh+NlqmfGMcYWkD6MGsK6ieJWn40=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pUw9gtTLH0QYdANdmpxucW1EhXFdI6UU2XZ4JGSLC8aF7LNIYReXpNZuSdt7dyLeJBOcxEu3zbiv+gWyDHEFKd52N4OMNKhwMf8zCkq2LKGS8JQCANGxr52f1QjwATX2PpAKMC5NhAcvLz2SxJcCw+HhNgmlFZN1n6BSt3mP4uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P7VkyG8g; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ab232cc803so1610125ad.3
        for <netdev@vger.kernel.org>; Wed, 01 Apr 2026 20:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775101282; x=1775706082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WyBuDOfFWqt1pL9OY9FIAUE2TSjg17kkHvUPr80bywo=;
        b=P7VkyG8g/Vny/kMpOgXDyIbm1KxMH1CKTiuIdF2wIiUilkvDURNo3h5isPDL/Xz0F9
         KsBFD0Se8tGvGIAxIFfOeV6Om3wDS7egDy+T4Ix17zH2gM14m4BpyuDXT2IKduRs1UtF
         e90PkFbAWXbht3IeXvlXOt5fpCUIUf16VOwzJ/fmZkc2eVy/KHfN4fgvXmDIxCmOjuEz
         RHn/UN8UIpo4M0PZdCGzjIYQ0yIjjk0hiwlXXI9meIcQYPT8X5+WNQGlN6moQkZDLBPp
         DUkfb5oKvczO0HjQfaDjhamc7rUDCFyyty8S7IEqftf9sIl+pIPyYIFfXDsVi1KQV2TB
         EZEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775101282; x=1775706082;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WyBuDOfFWqt1pL9OY9FIAUE2TSjg17kkHvUPr80bywo=;
        b=tJvyD2ADyh4KUXSN9+apQZ9KCwcS+7kBRLVHreXRUJF+3qQ5iJhYvD2No5aVSoxwM4
         UsRMNUxO1VMOvqVCHv5EQGAc2OeNnAwYHmxAlWEQLYsndvErPPICoO1CRVohQRvlYAez
         bVBVdJxDilQak12giOqekgyUEngXrsHtR/pQQRI73wnuVpceyNvVtwc1p0Z4d0APeWdp
         Re6eIZEncujn/U/oyALIG51LxfKYFYpb9oRqPUOqDEC2cb2M/mcLUmfBg/p8Um3MyWn7
         BC/Ne5iDsjK7j9lAEwx3WB0eG7NNqMUqu9FPjEGYhNqy834+a8/4i1ECodfKfr1ILspi
         Zp0A==
X-Gm-Message-State: AOJu0YyKdwHTXG/2zjtTUkTydlEXI7hWqueIcZeJ3DLYKIlLTOOcjYTa
	y3xH2Yfbp7kPri4f1H3qCQrWXQBbAGIbspDrhsyoJSzR3uY6c0FYCKNt
X-Gm-Gg: ATEYQzzFbjv0LPnSYUEAsMaAB8WhL7vo23VI0T+DFHAff7pPKgUmSIcWZdX2yjSh9oh
	VLy4xZJNJJEMZE7gxpbQO+QX+XdnI9c+SUT+7pdfAB9RDXamH9OtNxpD3liIHfwsAJ+VPGnFj0a
	YKvaSf9fR2xz+MODlQ3K06m+NtymflWZIugrqgSqBuqPrUBTrmquP6hO7HXKop7S+xfMfX9pdtK
	EUVhD4AqLHC6WOQSUFKSlYgypEoYXNQ4J8xT7MoLftveL85ATf2TqGvRESw9a/BbzhNiV998YVo
	gGquayhBN8X9+Ky8CC3Z4b11dyWfN4yXiDqZg0p2rBe5RYmBgYrFsM0zd8Ppa1wZ+OM//NkKQaE
	qzIY5mc99TAmpM58LxAALCJ8h/3Z2Tgpp2AVcJzYKsCXjRjPfrkWJDTliVzxu5iRyvPDsRajF+Q
	gEUY8haUvpcYzHDhOHKjk0bpN8X9KsPqmgzVc98nRkRUSB7dUsJ7TrY4h753YsjzTq7gWFjw==
X-Received: by 2002:a17:903:3d0e:b0:2ae:825b:49a5 with SMTP id d9443c01a7336-2b2699a3e06mr59365825ad.0.1775101281913;
        Wed, 01 Apr 2026 20:41:21 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b274757fa7sm12047385ad.21.2026.04.01.20.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 20:41:20 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH v4 net-next] net: advance skb_defer_disable_key check in napi_consume_skb
Date: Thu,  2 Apr 2026 11:41:14 +0800
Message-Id: <20260402034114.65766-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274358-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 0AB6A3833F3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jason Xing <kernelxing@tencent.com>

When net.core.skb_defer_max is adjusted to zero, napi_consume_skb()
shouldn't go into that deeper in skb_attempt_defer_free() because it adds
an additional pair of local_bh_enable/disable() which is evidently not
needed. Advancing the check of the static key saves more cycles and
benefits non defer case.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
v4
Link: https://lore.kernel.org/all/20260401033211.44463-1-kerneljasonxing@gmail.com/
1. add the missing header file.
Since a new sysctl might not be preferrable, I deicded to apply the
current minimum patch to handle it. If in the future we receive some
reports about this point, we will then consider it one more time.

v3
Link: https://lore.kernel.org/all/20260327153347.98647-1-kerneljasonxing@gmail.com/
1. use a simpler approach to avoid adding a new sysctl. This is the
   minimum change to improvement defer_max 0 case.

V2
Link: https://lore.kernel.org/all/20260326144249.97213-1-kerneljasonxing@gmail.com/
1. reuse proc_do_static_key() (Eric)
2. add doc (Stan)
---
 net/core/skbuff.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 3d6978dd0aa8..4045d7c484a1 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -94,6 +94,7 @@
 
 #include "dev.h"
 #include "devmem.h"
+#include "net-sysfs.h"
 #include "netmem_priv.h"
 #include "sock_destructor.h"
 
@@ -1519,7 +1520,8 @@ void napi_consume_skb(struct sk_buff *skb, int budget)
 
 	DEBUG_NET_WARN_ON_ONCE(!in_softirq());
 
-	if (skb->alloc_cpu != smp_processor_id() && !skb_shared(skb)) {
+	if (!static_branch_unlikely(&skb_defer_disable_key) &&
+	    skb->alloc_cpu != smp_processor_id() && !skb_shared(skb)) {
 		skb_release_head_state(skb);
 		return skb_attempt_defer_free(skb);
 	}
-- 
2.41.3


