Return-Path: <netdev+bounces-276324-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aPmJLYYB1mlsAAgAu9opvQ
	(envelope-from <netdev+bounces-276324-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 09:19:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3017F3B8075
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 09:19:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 00A83300B3F9
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 07:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC0073803C6;
	Wed,  8 Apr 2026 07:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UNJmFyJV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8B9377EBC
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 07:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775632755; cv=none; b=XZhdLgF3+nVp0ovCjIrL61UWRVcoQUYciFFWsc4RHLgtvOsyktnCZ+k43flPjjF1Hnt23K907NQQnbS3kCYUmHonppOLNL17Hoj+toPJfjL6nkEEl9Loh5AElZVcGG0qh3mi96Jyyn3jQ728APp/my98M49qwOF1RGo1XZezGVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775632755; c=relaxed/simple;
	bh=KXH5WS6Q40ibpj4kE0d1HhMaWRjL85bzTmnYQmsoq8Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=XYVgJ2R3Ec8o7n3hpG2bVYGGXpWaj7dbLm71G6Y8x8uGd1uA4jpqUCFkx8Xb9m7TB7IcnR33SNMya+WmEzPrVZ25Kz5/zc626b/W5PQD+ATCAgu183DVYsG8t+OZPAdW6j1IUS6CsCnpm9ZMKDJWsXMwv98pB48QLaa6yuLuIWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UNJmFyJV; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-35c238f1063so3610130a91.1
        for <netdev@vger.kernel.org>; Wed, 08 Apr 2026 00:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775632753; x=1776237553; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hjlYOd9XXvId1/7XLc+lCyUWcW3FTaMcLCVtuzeeaQQ=;
        b=UNJmFyJVCLDf4wPkPBBMn/eDPxeolQOIwz4Fq70YmC9KSZHULG/6N0fU39ZSkpN9PO
         Rgk9Q3pKhVQTg5aL8DGSesmucpkWMBPgQ8b/WeiBRUaQuwiIHfcr6CymlX/MxRfF/sQQ
         XRdLGlF/l3vN6E+LvlW2KRQNqHFLZrf2nkfDGCdxT7j5nBC8O4GnGTG+lo/OwQIFW37P
         KLb24izmXRAgWW7l2IW6IlIM0x1W/V9hnclL6P85bdd3QCezVeTgVrWyAMmg9N6LAqG3
         K1aDXsdkSBt9z6RLL4DKOmG6P2l/GlI5KY0JexxuZKb9vhr9qU1IesrrElE1MSgvM0cN
         U1AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775632753; x=1776237553;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hjlYOd9XXvId1/7XLc+lCyUWcW3FTaMcLCVtuzeeaQQ=;
        b=QSGBtFk0dn7fuoZZ1e+zNHQzpZ0URo0LuO8Y/cGC9PSubEzuXRS8+GIOLz+wPBbRWp
         xWF2bEO1p7xUaBTdmMnbvL64fNULX8JXwxeK45WjKnd0jR4Bk/iP1X9AqcfXhWATHNrx
         Q1hKvyrYfm/RdHfAiyY9TnewPLN2Cmalxnb9Yb7A/OKjQeZRfY4MWtINogvhKShUuiDK
         JTIkhp8MSqrIhiD6apv0t53ReBVYcw2L1kEFdixLkwWka2EN6uIP+sZNQ4cWaXq7JH/x
         2vDm9stVe/0X4r52m+zJ1GAS1exxfY+AKcC9ZLDtLI8X3xipA3URlj1Nx+/seS1JyGhM
         4wlw==
X-Gm-Message-State: AOJu0Yzuv0UPkbC/bDwccbc232f6dgt1YwWsdbD3vaxANTlydVyPXu02
	1MmU3VBAZf9/BM5dzBlFyL08Xx4kQK05qCT1W/pbN6AlifkSE9kXGNIp
X-Gm-Gg: AeBDietmJOf/Z9zpPvIDqWcHD0ahD7SGqy/XZ75UaF5CxcIu2wSrAvl/mNQboEYKk3V
	+o0jyAKp7wEVHMga9bHVzU/Y9l1vdeLOu9HY1bSPDIKspjc+opJK+cEJaZLyD0/9+HbgjctRovW
	FIhCP/ST2YZor8PFrfXIEfHbJm9s0o2DxMUz/kES8GQx3fMHW8Ie7Gs2g8OpfIvLV9PmSCiU1jC
	sSkf2mySc6w/gFuFDkTmp1dOOHYlFkLCxl0hir3aycf+nmG+hsDnQkhWH8iw9rP3nRUudzUbJpE
	YjaBes9bmxEppRALI9dMwY+NJ6sukl2+AM0Q6XFPUKxWJeU+X5E+Fgm3mw9mjidY8k+Mo9xtq/i
	jolad5LTuksK5dSx9UfLJPolzTq/X3itum6hafd4yf0lnffTphi8U+Bc3cA9Az4vxQ2MEyRb1JY
	0ckkS+WNAaxZs5xlvpKsODz1LtVW1q4UqluX3zxRJxC1jboPvj
X-Received: by 2002:a17:90b:6cd:b0:35b:8d89:719a with SMTP id 98e67ed59e1d1-35de6970260mr18566223a91.15.1775632752601;
        Wed, 08 Apr 2026 00:19:12 -0700 (PDT)
Received: from 1.0.0.127.in-addr.arpa ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2749a3af9sm183424555ad.63.2026.04.08.00.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 00:19:12 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
Date: Wed, 08 Apr 2026 15:19:05 +0800
Subject: [PATCH net-next] tools: ynl: tests: fix leading space on Makefile
 target
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260408-ynl_makefile-v1-1-f9624acc2ad9@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2M0QpAQBQFf0X32dYSkl+RtDi44dLuJpJ/t3mcq
 ZmHHCzDURU9ZHGy410CJHFE/WxkguIhMKU6LXSmS3XL2m5mwcgrFJBn2nRlAhgKyWGDv/5dTQK
 vBJen5n0/4zAYaWgAAAA=
X-Change-ID: 20260408-ynl_makefile-ee540ab81eea
To: Donald Hunter <donald.hunter@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Hangbin Liu <liuhangbin@gmail.com>
X-Mailer: b4 0.14.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-276324-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,davemloft.net,google.com,redhat.com];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liuhangbin@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3017F3B8075
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The ../generated/protos.a rule had a spurious leading space before the
target name. In make, target rules must start at column 0; only recipe
lines are indented with a tab. The extra space caused make to misparse
the rule.

Remove the leading space to match the style of the adjacent
../lib/ynl.a rule.

Fixes: e0aa0c61758f ("tools: ynl: move samples to tests")
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 tools/net/ynl/tests/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/net/ynl/tests/Makefile b/tools/net/ynl/tests/Makefile
index 2a02958c7039..9215e84cca05 100644
--- a/tools/net/ynl/tests/Makefile
+++ b/tools/net/ynl/tests/Makefile
@@ -50,7 +50,7 @@ all: $(TEST_GEN_PROGS) $(TEST_GEN_FILES)
 ../lib/ynl.a:
 	@$(MAKE) -C ../lib
 
- ../generated/protos.a:
+../generated/protos.a:
 	@$(MAKE) -C ../generated
 
 $(TEST_GEN_PROGS) $(TEST_GEN_FILES): %: %.c ../lib/ynl.a ../generated/protos.a

---
base-commit: e65d8b6f3092398efd7c74e722cb7a516d9a0d6d
change-id: 20260408-ynl_makefile-ee540ab81eea

Best regards,
-- 
Hangbin Liu <liuhangbin@gmail.com>


