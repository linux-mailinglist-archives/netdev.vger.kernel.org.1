Return-Path: <netdev+bounces-243864-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F0542CA8B85
	for <lists+netdev@lfdr.de>; Fri, 05 Dec 2025 19:01:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E2C830053DD
	for <lists+netdev@lfdr.de>; Fri,  5 Dec 2025 17:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2382A23C516;
	Fri,  5 Dec 2025 17:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W9aV+sGc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B063E1D9A5F
	for <netdev@vger.kernel.org>; Fri,  5 Dec 2025 17:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764957369; cv=none; b=cfx43UEgB3lLnBcgpFonoATlATzEpkgMFZJpfo13tgFwe3sSaeBQltMXL+6KdHvucTG3IsCGChGu3hnsZFr8aszOiz5kwN1sVySXbkpIUJCtLsD1RDW8AMeIPalYccEg90B8WOZPPraxIDMeRFhoJ6JhjL+cvdy8vnP4sDEH7kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764957369; c=relaxed/simple;
	bh=cT+okyoUrHTXA45Is0Pw9F6TxfbUti+FzziBF41Y2dc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TTZd9Bda9vkGx9i8yanA308GpgsEOxfCwJvpUAxtSqRNGH02U3bKkRcQDKiFG1dCFFib/VPx5ZmCG9sZGx56PVJDJmwtyK1ZRkDeyX/AKw41qacoX3FJWuh8ZxBZK90vax9pZrfqicFxCd+qHV0S/bnVBY/3xTExhqhwx7mSW64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W9aV+sGc; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2953e415b27so27485485ad.2
        for <netdev@vger.kernel.org>; Fri, 05 Dec 2025 09:56:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764957367; x=1765562167; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1ZlkRLK2kR7jmdSrjUTkpoX3kF+r/9UBuu/w/fSD0EY=;
        b=W9aV+sGczy519i1x2Pwh62V+43tJ1dPNrr0llLdd8N2KFtACMUBmtfjrvhqw/F/5be
         l3PczTqWnkxVvE21OjNXE3GqjeNgNm4fryvqdlyxQsnXmh91vfJxiZ0+Ogz8q4W2fWTC
         iINph9TUWa6QExTgIMDd8AO9oLDjwE5hU0Mk0WZoI7o9revZO6MBWkz+mjSTm5jyT+yf
         DTPA6jtiNwHPyqBX7kVvLqO6ezSIQE58VBMHu8r97OQxyuJH503MkYvEAF5PDUicQz+y
         Q5tCp0eyDGjTUdoTpVIFMWCY1NYyljUVBi9r0qVGTW+MEpg11n1p1QGA0MnnUFn/nM5Y
         T/AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764957367; x=1765562167;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ZlkRLK2kR7jmdSrjUTkpoX3kF+r/9UBuu/w/fSD0EY=;
        b=ojoHPAxoKMidririsFZ2kPAzxdYL3wb/O0E2ioTF1MHwMMv65W6RP+TXph7GbHuHwD
         3epeu4yymnSU/3ag6u298EHqFyaiiBhtJ0OwBY7RS5mit7GZDganOWXing8zdOptfKOb
         +ABKeqaYjFCmDTdmc8tUYPXnyngk1es+uDiIQZ40qUIihf0LZNArO9BtseinMTk/mjhK
         iZfAqkm4SwOoWDae4sL3gWsDbF+s0rDTNhVCQWVbSwfgvnLXdgqGyPbWsLIVJsw9EnsV
         73e+8Aqt5U7YzMHkLNldz7nT/7FsJi7NrbT31/vqlxEq9k0TRSMwJNrFXmw4FCosCsue
         jzDA==
X-Forwarded-Encrypted: i=1; AJvYcCWUifyJeOPFdTtfoN1eh9/vYWxTpTZWtHRqaAddmacu/j9eyzkVm+GZMtpQwP1aGOZGl5mzU3g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYtU0GLoSKFlCIjUgSamB2TnuliVWM1X7JZfNo0o9R7KhgtiCC
	v0gmmrVsKLIrQiF5QUEg+K5aVgog0LoUrOFKVlSCd7Py6Pc8HdOCg5Gs
X-Gm-Gg: ASbGncuKEyD0Bo8kEaS9K3nVT3Yt7d5KGy1wf1Yjx0RQhu7k2xV8lQPzEYEDPUg7H+/
	KsX0L2LozVOUBN+EBgcYXjSD3GVGA8Qr9znk+7I+E9bQjgDn59Bwocj/fPAdToqLGWvTnJN/uRC
	51e8lfSECK2VNX8fHCKJng4e0HBzeP/TWFMpqsLOskg0xzW1nVLxiPgFJMEql5hkh5w+BBhWAA1
	2U76XMlzGVbdSQQpFUUB0xLUe2BeluxKw8Z8nR/Ox7jN39OyiXHG+23xbvZh/7d4kX3FPyVmTuD
	Z+Q/5qlP1h7MN4PCHzZIN+McrkFlSFwQVDYPtadn3TrGPvQYPKPgKJRx8DSHOCynKtvBxTs2SjH
	phjZRiow6nSaqBFBYPXzx5Pr0qSD6+C+NlNAjn8kdtllwBI7mHs8E58DPFG/8tnE4Z+D0LXw3if
	l6sD+z6wncO4Bfn47GjHh6ZITuKUOqh5haFtNKauKBmA==
X-Google-Smtp-Source: AGHT+IEMZtS5OhVis+tAJNWxbgTpnD1LDhwjU9539YkWmdypSP2a1B96Klyjr09ref54U4oS9Qg8wA==
X-Received: by 2002:a17:902:f790:b0:295:596f:8507 with SMTP id d9443c01a7336-29d9f51abe1mr89758185ad.0.1764957367074;
        Fri, 05 Dec 2025 09:56:07 -0800 (PST)
Received: from localhost.localdomain ([2401:4900:8839:f626:f539:b6d1:1913:1426])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29dae4d3b5dsm54459245ad.40.2025.12.05.09.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 09:56:06 -0800 (PST)
Received: (nullmailer pid 619889 invoked by uid 1000);
	Fri, 05 Dec 2025 17:53:27 -0000
From: Kathara Sasikumar <katharasasikumar007@gmail.com>
To: alex.aring@gmail.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, david.hunter.linux@gmail.com, linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, shuah@kernel.org, skhan@linuxfoundation.org, katharasasikumar007@gmail.com
Subject: [PATCH] net: 6lowpan: replace sprintf() with scnprintf() in debugfs
Date: Fri,  5 Dec 2025 17:53:24 +0000
Message-ID: <20251205175324.619870-1-katharasasikumar007@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sprintf() does not perform bounds checking on the destination buffer and
is deprecated in the kernel as documented in
Documentation/process/deprecated.rst.

Replace it with scnprintf() to ensure the write stays within bounds.

No functional change intended.

Signed-off-by: Kathara Sasikumar <katharasasikumar007@gmail.com>
---
 net/6lowpan/debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/6lowpan/debugfs.c b/net/6lowpan/debugfs.c
index 600b9563bfc5..d45ace484143 100644
--- a/net/6lowpan/debugfs.c
+++ b/net/6lowpan/debugfs.c
@@ -173,7 +173,7 @@ static void lowpan_dev_debugfs_ctx_init(struct net_device *dev,
 	if (WARN_ON_ONCE(id >= LOWPAN_IPHC_CTX_TABLE_SIZE))
 		return;
 
-	sprintf(buf, "%d", id);
+	scnprintf(buf, sizeof(buf), "%d", id);
 
 	root = debugfs_create_dir(buf, ctx);
 
-- 
2.51.0


