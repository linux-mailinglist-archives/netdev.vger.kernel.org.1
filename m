Return-Path: <netdev+bounces-304233-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UkeKK4WaRmqKZwsAu9opvQ
	(envelope-from <netdev+bounces-304233-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 19:06:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6633D6FAFAF
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 19:06:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="le4km5A/";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304233-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304233-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 35EFE3118A01
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 16:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C80339844;
	Thu,  2 Jul 2026 16:49:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C285131AAAF
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 16:49:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783010994; cv=none; b=ekM2l2ylNOo3Q0p/KReJlaeXdTYx24x1fHkutqVI4sfRCXkFlQPOmOvKqerT3eCsmlOd5ORrGFHM8+gNvmzSv/n3yRt6q7y0XtnQaVGpaKVvIEZCxKP5ztphPtHwxxt2JT/eyhmDtwTRkHF5/xeY2dGdkCL2Fc9u93YY+EE+uzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783010994; c=relaxed/simple;
	bh=sPgWrTCY+vkZ4Gu64MngNcsm8uvJ0Nl9FCs6LietbxA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KMhDeyGMmxj/o20IooMhh5kcTVOrrfdh6oMA6JN0XA2Mm+0cSrFTUm742vTTDfE58ytIQ+ANZNDFXb8/mcZkptoNXT06pGhjrzW1LCeraM/77isGZArTfdo4HRqx/wzTC4r472VA4ROb1HShfoZQcTQp73eIX6RuglV2Q9gDg2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=le4km5A/; arc=none smtp.client-ip=209.85.216.46
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-380d9481551so1124044a91.0
        for <netdev@vger.kernel.org>; Thu, 02 Jul 2026 09:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783010992; x=1783615792; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UL82nmL+ZYrOnxFf3+CmZbPnfwIy2jc8o3jqsy8jewg=;
        b=le4km5A/8/51mcYXEVTq/Ouz6bMupBaJnrZCTiDx89qgevg9edtFPB5x7EoKquyQaF
         PXBmo5FxLqNLjkVI2cKGs8HYScDHB9iZFSppA8GYUFEh2ao2QXp9uWKz0sZOaBJ8VlUA
         vLrmPg/nb2+GAsQN9RCL63SQRkYNmXbB73LxPZe9DLg1f3slQWPP4lv2AJyNheeaERhX
         he07ftx+lDb2g5l13eVgVpAVXd9d+EXX9+iJ2c9t+uvgw8JRmRyLVLvzqTO7a2PxCmzM
         MCUsco0iQhlrnYa53pwBVbVvf3g7TzSEuYM1ZwnPJk6f6QDi0Lnxbzq5n6v8tqo43XJO
         xvTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783010992; x=1783615792;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UL82nmL+ZYrOnxFf3+CmZbPnfwIy2jc8o3jqsy8jewg=;
        b=o9Vg0FpUjxycnSrgsvg3CF+R9T9PcrM6NuZ1MUWt1jwbn+s+5S/XkxZaK0y2c2QAZq
         wAx09qr+TyRMYe//HI1vab1SttAxTCFdyYT0+ygoBqOVA3TjuBMLYIYJkSCFiTl6Fyvh
         4TM7k7QceUKdpGJEUuV4TxtemPxydQ1UHKBpPZ+fchSCOR5cIQn6Jfq4wzxaqAU030fT
         NuPSa6DeUUBCKH9fQBEcaldnTZ1ILu/vYe1PYCQs0pjleGYuV0iHk0ZP2rjz+fYsDMhx
         qCKLhWoKOKGBBZq+XQDTEYBDbvNQK+gq9r1J7/QagEZRRMiBn2EIU40ypxQrURACINSC
         P7HQ==
X-Forwarded-Encrypted: i=1; AHgh+RpnfUU3cC42VX2XbynuPhc8zY/ybqk5hmhUBy3Vddfw/36RVSphp0UclbY4EHIpCD27P20/L5w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwagS8HIBZrBUIRFNLNQyKHkdJ/IcQmtmsC7TXMLCa0kCoRxVvP
	7NOo+Kn/4uPxnb7dE5vye35daRFN7NOtKpQKaqOuiDT+WY5PmXE2/Afp
X-Gm-Gg: AfdE7cn0H1XG71UIxdfS0IAKK5viG1xwNK1n1B1tHvn02jlXF4Df9QQ8CX9BWqZNRjC
	0YQYKiEn/mglG82B/pZsg0IrtgnU78JrlqCkzl95AsL9VR0G2vT7HLfmh8ZuZSYqyJEXuyAVDz8
	A0ztdershrxFOZ83R3FGv4Zc47WF7DDosGHJjL6lWOiVmXMGtj+RKxp/ZKcIcJ7cGxjlRSI607q
	Wx/DFjMuZay+4ksgCrDfQLBZEf1xUVd+/WneBm+ovkM2SbLWJP1xQhIqVd4CknKfEQBcNcoPowU
	u9DcphQDeQkHZ/XL26Wgec07I8TZugfpcWEJPP1pOoAwjDkovwuVeCnASGpvU2NUibyCgSa6icB
	oIUqGTPKwADoGh5L7YpFlmXBrvx8kzd618q8bCyueEs1fG9Ben664g6zKony+ajBLVdbL0qqFkA
	GzWy8/Pwn+C8uhsVxO
X-Received: by 2002:a17:90b:3f8c:b0:381:854:dba4 with SMTP id 98e67ed59e1d1-3810854e536mr1296176a91.20.1783010991890;
        Thu, 02 Jul 2026 09:49:51 -0700 (PDT)
Received: from localhost ([2620:10d:c090:500::369e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0bb80f5csm16318471eec.15.2026.07.02.09.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 09:49:51 -0700 (PDT)
From: Zinc Lim <limzhineng2@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>
Cc: zinclim@meta.com,
	Zinc Lim <limzhineng2@gmail.com>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] selftests: drv-net: rss_ctx: Add retries to test_rss_context_overlap to reduce flakes
Date: Thu,  2 Jul 2026 09:49:31 -0700
Message-ID: <20260702164932.2832916-1-limzhineng2@gmail.com>
X-Mailer: git-send-email 2.53.0
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[meta.com,gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-304233-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:shuah@kernel.org,m:zinclim@meta.com,m:limzhineng2@gmail.com,m:netdev@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[limzhineng2@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[limzhineng2@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6633D6FAFAF

Similar to commit 690043b95c18 ("selftests: drv-net: rss: Add
retries to test_rss_key_indir to reduce flakes"), implement the
retry mechanism for test_rss_context_overlap. This gives the test
more attempts to distribute the flow evenly, as the chance of
flow skewing to one queue is high.

Example failures:

 # Check failed 5288 < 7000 traffic on main context (1/2): [2727, 2561, 8961, 6648]
not ok 1 rss_ctx.test_rss_context_overlap

 # Check failed 6710 < 7000 traffic on main context (2/2): [9280, 5217, 5358, 1352]
not ok 1 rss_ctx.test_rss_context_overlap

Ran test_rss_context_overlap and test_rss_context_overlap2
over 1,000 consecutive runs with no failures.

Signed-off-by: Zinc Lim <limzhineng2@gmail.com>
---
 tools/testing/selftests/drivers/net/hw/rss_ctx.py | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/rss_ctx.py b/tools/testing/selftests/drivers/net/hw/rss_ctx.py
index f36f76d6ca59..5b25fa89c629 100755
--- a/tools/testing/selftests/drivers/net/hw/rss_ctx.py
+++ b/tools/testing/selftests/drivers/net/hw/rss_ctx.py
@@ -651,9 +651,14 @@ def test_rss_context_overlap(cfg, other_ctx=0):
         ntuple = defer(ethtool, f"-N {cfg.ifname} delete {ntuple_id}")
 
     # Test the main context
-    cnts = _get_rx_cnts(cfg)
-    GenerateTraffic(cfg, port=port).wait_pkts_and_stop(20000)
-    cnts = _get_rx_cnts(cfg, prev=cnts)
+    attempts = 3
+    for attempt in range(attempts):
+        cnts = _get_rx_cnts(cfg)
+        GenerateTraffic(cfg, port=port).wait_pkts_and_stop(20000)
+        cnts = _get_rx_cnts(cfg, prev=cnts)
+        if sum(cnts[:2]) >= 7000 and sum(cnts[2:4]) >= 7000:
+            break
+        ksft_pr(f"Skewed queue distribution, attempt {attempt + 1}/{attempts}: " + str(cnts))
 
     ksft_ge(sum(cnts[ :4]), 20000, "traffic on main context: " + str(cnts))
     ksft_ge(sum(cnts[ :2]),  7000, "traffic on main context (1/2): " + str(cnts))
-- 
2.53.0-Meta


