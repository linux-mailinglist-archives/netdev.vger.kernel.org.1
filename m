Return-Path: <netdev+bounces-265750-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8FTLNQcxr2kYPgIAu9opvQ
	(envelope-from <netdev+bounces-265750-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 21:43:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 458AA241076
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 21:43:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 37A92302E335
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 20:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3CDA34D4CA;
	Mon,  9 Mar 2026 20:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SpHq76zv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C016836894E
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 20:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773088937; cv=none; b=IfYJHnjs0QiPcBxg+44R5iqFMGqIyjL9Bv38AnSdtEB+b/G0g60PW4KpytHpS8CmByTODHkSGNRXRyVZshwjm2tkkKKHVd9hdOtrvt8B4XuHz8KpMe2gzdMK27+LaAMKicYfCcpPwPyhIB6dpm/k6sYYloerLsAmeY3XyDwC7Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773088937; c=relaxed/simple;
	bh=i2jgWiH8GIFlWr+HHc4CTYH7jDEMT5sLA5f88ZPEB20=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZddwwowBm8oU/56NpMNFSv/O7Ld4BAf3U3eXGFwQTTGZ43zI1lfloZLl6gnnNfCWgoGbWOkgoK8E07HRRXN1TeNEn9sr7Uvhn7+4w/avcDlSFW4wVYLjLPNgl4hs0upDJY6mMzFQ9gT0741bh5ufdCke3WjhHqkB6Q2ce85Hzkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SpHq76zv; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ae88e16485so17954015ad.0
        for <netdev@vger.kernel.org>; Mon, 09 Mar 2026 13:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773088936; x=1773693736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HVfEy5APGf95FFLNoCWNdKxa5MIc0G6RQdiGr8r8l4Y=;
        b=SpHq76zvLKZmDd+ERhcYUT6np78QZ8FQ+pAHXXqrMwlojZUBrnwD5lmC5lh9eAO9xY
         CQzvB9+KUkw17k2PfsLAdm0bvA9m7JKOMcW94UFKqjGlO50wkRPWwOga3xo1fVYnDpYx
         pYVjjnYdNTdqrmGI/D2mWevqBZn6ib6xVI5wAJP1Bthb6n1cg3Wm8NXEtXdH7VnOHRqH
         CDHTuATRJrH9k39Qiz/m6ieL7P+FKCTsxxItTwsZ3pDVkNcsJNvIRXAUthQ7GtqqBFbd
         lb4OA9LX4zaW1adc6tPZVq+B1M00USjiGc+MCb9+GCU5Yh6kvQFQ7AnblQvPs4POHyyY
         9gIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773088936; x=1773693736;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HVfEy5APGf95FFLNoCWNdKxa5MIc0G6RQdiGr8r8l4Y=;
        b=uYjHKTLq1cRMm853WqxPiicpDFt7aduLZzlvRWcLfOFon9u5K72WpSka9omKiaVJie
         FpLFjpO1NCtzAee6RrNxsSC/Dc86sSRK+T+SPM+1aKlsocHB8MXcwrwjHndcqyntl/44
         h7zUdApkrusfJl2DAlnjvRYK2c0/hHjqMhYlFftA0wFbmBpcY4crX4KgxyPjZVWlILGq
         nwjolXxKYBSIYW+F+PN5maaeaVjerATGssZkCWU4OycVdcdPBMv1EGyjsuRBxf7swC+s
         btvUkxIeLUip+xfzYWazqK5xj5BaFcD8fSSazOpqheRacAY07tVlrIZH1rlbNFvtbTay
         gadg==
X-Forwarded-Encrypted: i=1; AJvYcCWYboHpxWIYRguM7uQ27XHLpQW5yCe+/BaFEvry0+nxrWFmDIsBvXNcrfdFEFTyvNdipmIRFRI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOEHUgMlzdAa+JCNSSkXy1s5eztpBixuN+MG2ALIuSmFJH73xd
	SX0ypyeM9rM1ngl1twTpXUKqk65iaWs8ZuGCpk6sqjZWE3Lqe08RVFo6
X-Gm-Gg: ATEYQzyBNeqGyMYmgZcTRvlobg2W9UnEY8FyFhN75hsrzgUAk4CGVPEEzv0tf1v/ufD
	I/sYvstM1sIgh19QV9HnWPwJay2cAIx3MdeNV58XIZIrXoHa/2QlQyNyppYMxkMnARnvvNx21Kk
	WgiQDsFavi8WH2R8lzEPsKt5iKonU/WkSgz1V3CRwo2dTxSHlyVFKt/EiUgzwO4QK1/tXhVhuB7
	XxCpUPH1DKaVG2V50LLmpMri8XVTYDJs9d3jMan+v2FcvhzV6h2vXxNTgh35E1BGvsDXb7gX5dt
	/0Y/lky/QNV7sSip/RCyeuknI+5REnu0KxdUtpI3PiGQhKRbULCdzStkr+sPWH+U5ZZLVPTwTqy
	RhnsAFEGz+LcYb4EcKtyZaKCXWDHC7buKEC7o/3nfDGYafqkjwOk+U/XgaWLJsNeethzwBapopk
	pNCmR7HW1HS6jDRy/WU+YhKDvoopaH
X-Received: by 2002:a17:903:41ca:b0:2ae:5848:bada with SMTP id d9443c01a7336-2ae82418e5bmr127912605ad.10.1773088936150;
        Mon, 09 Mar 2026 13:42:16 -0700 (PDT)
Received: from localhost ([2a03:2880:7ff:1c::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae840b2d97sm133318085ad.84.2026.03.09.13.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 13:42:15 -0700 (PDT)
From: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>
To: "David S . Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Nimrod Oren <noren@nvidia.com>,
	Gal Pressman <gal@nvidia.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next] selftests: drv-net: rss: Add retries to test_rss_key_indir to reduce flakes
Date: Mon,  9 Mar 2026 13:42:15 -0700
Message-ID: <20260309204215.2110486-1-dimitri.daskalakis1@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 458AA241076
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-265750-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dimitridaskalakis1@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

The test generates 16 flows, and verifies that traffic is distributed
across two queues via the NICs RSS indirection table. The likelihood of the
flows skewing to a single queue is high, so we retry sending traffic up to
3 times.

Alternatively, we could increase the number of generated flows. But
debug kernels may struggle to ramp this many flows.

During manual testing, the test passed for 10,000 consecutive runs.

Signed-off-by: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 .../selftests/drivers/net/hw/rss_ctx.py       | 29 +++++++++++++++----
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/rss_ctx.py b/tools/testing/selftests/drivers/net/hw/rss_ctx.py
index d7cb30306368..51f4e7bc3e5d 100755
--- a/tools/testing/selftests/drivers/net/hw/rss_ctx.py
+++ b/tools/testing/selftests/drivers/net/hw/rss_ctx.py
@@ -166,9 +166,17 @@ def test_rss_key_indir(cfg):
     ksft_eq(1, max(data['rss-indirection-table']))
 
     # Check we only get traffic on the first 2 queues
-    cnts = _get_rx_cnts(cfg)
-    GenerateTraffic(cfg).wait_pkts_and_stop(20000)
-    cnts = _get_rx_cnts(cfg, prev=cnts)
+
+    # Retry a few times in case the flows skew to a single queue.
+    attempts = 3
+    for attempt in range(attempts):
+        cnts = _get_rx_cnts(cfg)
+        GenerateTraffic(cfg).wait_pkts_and_stop(20000)
+        cnts = _get_rx_cnts(cfg, prev=cnts)
+        if cnts[0] >= 5000 and cnts[1] >= 5000:
+            break
+        ksft_pr(f"Skewed queue distribution, attempt {attempt + 1}/{attempts}: " + str(cnts))
+
     # 2 queues, 20k packets, must be at least 5k per queue
     ksft_ge(cnts[0], 5000, "traffic on main context (1/2): " + str(cnts))
     ksft_ge(cnts[1], 5000, "traffic on main context (2/2): " + str(cnts))
@@ -178,9 +186,18 @@ def test_rss_key_indir(cfg):
     # Restore, and check traffic gets spread again
     reset_indir.exec()
 
-    cnts = _get_rx_cnts(cfg)
-    GenerateTraffic(cfg).wait_pkts_and_stop(20000)
-    cnts = _get_rx_cnts(cfg, prev=cnts)
+    for attempt in range(attempts):
+        cnts = _get_rx_cnts(cfg)
+        GenerateTraffic(cfg).wait_pkts_and_stop(20000)
+        cnts = _get_rx_cnts(cfg, prev=cnts)
+        if qcnt > 4:
+            if sum(cnts[:2]) < sum(cnts[2:]):
+                break
+        else:
+            if cnts[2] >= 3500:
+                break
+        ksft_pr(f"Skewed queue distribution, attempt {attempt + 1}/{attempts}: " + str(cnts))
+
     if qcnt > 4:
         # First two queues get less traffic than all the rest
         ksft_lt(sum(cnts[:2]), sum(cnts[2:]),
-- 
2.52.0


