Return-Path: <netdev+bounces-299101-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /TOyFWLtLWqPmwQAu9opvQ
	(envelope-from <netdev+bounces-299101-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 01:53:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EAE2680104
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 01:53:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=NeUpxtOa;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299101-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299101-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 34AE63001CF4
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 23:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00DD0375AD0;
	Sat, 13 Jun 2026 23:53:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D622C279329
	for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 23:52:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781394779; cv=none; b=BrJPYEePtF0gZ3v94keCBAFO8B9plUeJ1IK8Kk9yKbodLpPr0a/whr8Gc4LY4DZ5eA/F5Q31wHpVPxbUxc7PhrcVwhWQQ2UOIYfQaHHgJ9U806JqT6fnkxoiqBL8Z+1VLcoGqfSxt/PG+bDjS8f0PT2IWbLdJHcU6C7WP7SBjZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781394779; c=relaxed/simple;
	bh=CFQoP88oa6bYc0ibzkJ82qFNDHK4L8olyb1eOcPbRmo=;
	h=Message-ID:From:Date:Subject:To:Cc; b=W4E4/nwm4AXViIGEBMPGzIeuTYvLRRHFvGgPzwarXhV1gah1DxFyS+c8OsfiL9L5nK3pF6VJ0yVNsfy0EFqDqfTRwvDHmZ0M+EqdBb1qoCOetMDgCrDil+OI/Qi7Dzi2qqNuxjZmIv74Dal0BRdUVLS5ELIAOIX61sndOy7n9E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NeUpxtOa; arc=none smtp.client-ip=209.85.214.179
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2c0c1e0b0faso13326065ad.0
        for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 16:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781394778; x=1781999578; darn=vger.kernel.org;
        h=cc:to:subject:date:from:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zK4mML80EwVGL6lWczcuu1KIJZUvXPEYaU6eVFtltBg=;
        b=NeUpxtOa1Lt1eNeVHZrx8cjAg+f0gSUyxEfngUkIi8oJdt/8ReZSvlwTWzpuXEDLJN
         TWjrpZaTlM8aUYdXUIH3Ch1l2i1ClC5LpoyXGH081/C7OISmtYI3TcsKEybeQRiwGPBP
         7t79BmKI4/4KNPKQIn8FolvaqVshBiqZbeH5ybFWQK/fd48gye2R1D1ibqJSR8HVix5x
         ZrP1DdGa45yNBiuFBAKdiStxqII0ZevGCSHp25QttJwx6/FPgOSypI+WYMOKK5MioN46
         V2MBEPiydlihCqpwkX0oU4fZ94hx72jcBOB4E9CoT2g9Ssiqw8gLOppDrTlTUc01gXye
         ozag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781394778; x=1781999578;
        h=cc:to:subject:date:from:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zK4mML80EwVGL6lWczcuu1KIJZUvXPEYaU6eVFtltBg=;
        b=hFK81ukoYREvLBNUrr31nl6jQy+ny5rQuryvAoABGKI00SZc+G51plh4m3LCmfpyJG
         rYXJwxFGJgaVbS0iyuhGpAuwE9QNo3Uk+eplizWSBnJa3C2dCp7W8re1w/GcEm5op7/y
         BdltUgq3lfOM8sDSLtqYbqlRnlBa4/c0FjvepnhBY5EQC29CgWurXlh1XVnAU9sHbBFP
         2FpVeQnLX+cXnsQVSw5WxiN9GNlkYdzcEzJEgKnbFm67jS1Tb7/LTyFrDTPUr7Sm+nGt
         Gh8SQmF74cO1lcU5j5Dy9hl+OHJBLSGi/GWkZppe3UmQEh9pFVx6OMS52vuPkSq4jRIi
         EErQ==
X-Gm-Message-State: AOJu0YwaakPB3DB/kazNH0yuW6bLgbQf3RPJaPZuhkoQZKuH0YMY69ZF
	b9HiD7U+sZ3iM+IXVPR/G83ho2+8esnUjmGFhykDaj6e5Xz/8uW6dqCCo1p1lPYFkzQ=
X-Gm-Gg: Acq92OHh2LTzuI8qKrKWe9hGiQDVgpCjTdWOo9rquBDGHVhLttlfzgSpwL2BA4iJW8u
	ertlSonFZk8bpawpu29i/UclqL8TBsFv07lYRkmr/IfElAvvd5pMYf/4tBwnX8xWoaOgdG1vNWY
	VTR84IKu7FHFTlrxWsA/qLkH75U8HhIVs+117lLeAaucsxlHLbXNqwIH3hjjJI9to6eOdYSV4mN
	OGe6Z4sREuK6dy2T2fcvLDbfiPaKH1y9shEXF7FaHoVazbrx0JTVu/l/gPjq2dOzdM6CCaFA+Br
	HufzhTLdWKSf7Q7EBL5SStBKszfxJokQFJ9r4zn1H7IS4Q/yrzRBnBtiykO5SMfmEYorJZWd5n7
	DmOon1nvfwJm7VkxL5hawAi1w5YrygvBIRsgr8K4Z84ujNjNp9XSGUs+RIynBTZCl8SHpIdTBZm
	baJI7x/sriQ/moYGr0
X-Received: by 2002:a17:902:da2d:b0:2c4:d55:eb88 with SMTP id d9443c01a7336-2c410cd169dmr91771305ad.4.1781394778226;
        Sat, 13 Jun 2026 16:52:58 -0700 (PDT)
Received: from [127.0.1.1] ([47.253.114.73])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c4328a4c1fsm58185565ad.53.2026.06.13.16.52.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2026 16:52:57 -0700 (PDT)
Message-ID: <6a2ded59.63d39acb.391892.7632@mx.google.com>
From: "Wayen.Yan" <win847@gmail.com>
Date: Sun, 14 Jun 2026 07:52:39 +0800
Subject: [PATCH] net: airoha: Fix MODULE_LICENSE to match SPDX GPL-2.0-only
 identifier
To: netdev@vger.kernel.org
Cc: lorenzo@kernel.org, horms@kernel.org, pabeni@redhat.com, kuba@kernel.org, edumazet@google.com, andrew+netdev@lunn.ch, angelogioacchino.delregno@collabora.com, matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,google.com,lunn.ch,collabora.com,gmail.com,lists.infradead.org];
	TAGGED_FROM(0.00)[bounces-299101-lists,netdev=lfdr.de];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:lorenzo@kernel.org,m:horms@kernel.org,m:pabeni@redhat.com,m:kuba@kernel.org,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:angelogioacchino.delregno@collabora.com,m:matthias.bgg@gmail.com,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:andrew@lunn.ch,m:matthiasbgg@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[win847@gmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[win847@gmail.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mx.google.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3EAE2680104

Both airoha_eth.c and airoha_npu.c declare SPDX-License-Identifier:
GPL-2.0-only but use MODULE_LICENSE("GPL"), which the kernel module
loader interprets as GPL-2.0+ (any GPL version). This mismatch causes
license compliance tools (FOSSology, ScanCode, etc.) to misidentify
the effective license as more permissive than intended.

Replace MODULE_LICENSE("GPL") with MODULE_LICENSE("GPL v2") to
align with the GPL-2.0-only SPDX identifier. Per include/linux/module.h,
"GPL v2" maps to GPL-2.0-only, matching the source files' declared
license.

Fixes: 23020f049327 ("net: airoha: Introduce ethernet support for EN7581 SoC")
Signed-off-by: Wayen <win847@gmail.com>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 2 +-
 drivers/net/ethernet/airoha/airoha_npu.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 31cdb11cd7..960727957e 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -3333,6 +3333,6 @@ static struct platform_driver airoha_driver = {
 };
 module_platform_driver(airoha_driver);
 
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Lorenzo Bianconi <lorenzo@kernel.org>");
 MODULE_DESCRIPTION("Ethernet driver for Airoha SoC");
diff --git a/drivers/net/ethernet/airoha/airoha_npu.c b/drivers/net/ethernet/airoha/airoha_npu.c
index 17dbdc8325..870d61fdd9 100644
--- a/drivers/net/ethernet/airoha/airoha_npu.c
+++ b/drivers/net/ethernet/airoha/airoha_npu.c
@@ -826,6 +826,6 @@ MODULE_FIRMWARE(NPU_EN7581_7996_FIRMWARE_DATA);
 MODULE_FIRMWARE(NPU_EN7581_7996_FIRMWARE_RV32);
 MODULE_FIRMWARE(NPU_AN7583_FIRMWARE_DATA);
 MODULE_FIRMWARE(NPU_AN7583_FIRMWARE_RV32);
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Lorenzo Bianconi <lorenzo@kernel.org>");
 MODULE_DESCRIPTION("Airoha Network Processor Unit driver");
-- 
2.51.0



