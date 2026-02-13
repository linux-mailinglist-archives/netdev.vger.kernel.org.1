Return-Path: <netdev+bounces-258579-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WDCCCcvWjmmhFQEAu9opvQ
	(envelope-from <netdev+bounces-258579-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 08:46:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A482133AFF
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 08:46:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3D58C30A8CA2
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 07:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72EB1311977;
	Fri, 13 Feb 2026 07:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Mac4LHoU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f225.google.com (mail-pf1-f225.google.com [209.85.210.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16BA131195D
	for <netdev@vger.kernel.org>; Fri, 13 Feb 2026 07:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770968743; cv=none; b=T9+rXyB2Daqx66DgBaB36Xzq3zMc7fxRrqB0o+PwwCRTwv4wYr4KpIgBprsHxv9VnupmIEpgWMlgurSoIKCHVq/se1D25J+thDj1NKdflOCQtOfASStCazGJtzWtf+QGgf6+T1L7Aoj61EOu49SDw+qCZqnBh0Dok0KWbj6HYWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770968743; c=relaxed/simple;
	bh=B8pKtQPFdTwJXlDtgNGXqc3gHOD+BWHl5j/fDq+v90A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WHAyFJv4CIhFSmprH8RTeRaB2yQ5H0MaQrbK7UgMP8GhZsuviJrds4FvrpuJJXjYaRuX7V+zlwK73kMxhnw/Wz8Mk4ouRGDu8vvnqddkbZIVkIjqE9JLpGdn5sAlVnhDQ1t72MHfQUMeU5JPCouctHNdKikl9Q5wNcMiuq7Cz7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Mac4LHoU; arc=none smtp.client-ip=209.85.210.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f225.google.com with SMTP id d2e1a72fcca58-8230f8f27cfso399477b3a.0
        for <netdev@vger.kernel.org>; Thu, 12 Feb 2026 23:45:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770968741; x=1771573541;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PRALV8S5SycwE1cozmsAcF2ZCcAdV2ORqka9l/U6rP0=;
        b=IbQG6vZRHwo8b/61TC56GmADWlMwUcjtQL7BZUpZ45KVnKDB+DVHcsO6hIsFQOO+v4
         /hKATWkdrvzNa0kDyhvWu+rv+HX93aZ1n0kAA7+o6irqPM0WLi9ZbRmEOjujKvbl5bRt
         TVpO5Idmgb78amYgtuhCYka+hbj9/gqRdAIy+OQahqX2GaPEzhts7nfmpQ2X0ruXubim
         deNq8Cz+uZKvNsB7UDLnCEDtTtOCDgmbuFf0Rv2m8q9l8VY2bAm+/f5KP7YLUXnqEp+l
         2Go0rF4rCX6xuWtOqRA1OBkix7teHwC4T/ycTqoqqk1+YyxMwdbDtYmmR5leKs/0YH8z
         JnWQ==
X-Gm-Message-State: AOJu0Yyvm4XK4lYJOAubuLeAxT6i0HVCR6D+tZF9dMvtzASWQb0t+3Gj
	mptwvhF0mMm0u3V9r2jlzU0BllX84TPVgDHve7dYuCrAvEX+mc/Tis8yf+qDn5NmJQ8SDwpKPye
	QX4ESpLgAjvHJ+seZs+Fv0F6/d88pSGjVEQlJfZO6jk9v/l6GUUO2cZWgcFpgAusZeEF+rDWvvx
	7fMW7PSNsYBB4GhLjvYPFxjMboLmBZ9s6GsNE64oHdz9cqbv8WAa5oX8E+VV/pTb20jJqIDG6VX
	mdoE6m8dJc=
X-Gm-Gg: AZuq6aIqaiSQvRV5N6LK0+8DLxaXqNpClg6/upH/798tnlcbzgD6YsriEmj/ls/QReP
	iY/45zmjgle5cpeOTr7PmoIbAgFQy0LWoz14RLlTAqBU1lZW5FhiXLRun2WLSpdnV7Aw6dnLCeX
	fHUmCogyD0/hti2JWBU2ib1D4YuWvS8v/0S2YWslroj8iO+QEyz9ruQUTqFV6wwy4LgsVc0HDDI
	Y522rqLwQ0SX1YU/8Cp7UrpQdZuSPBGPVOKsXOHyUueClDMhN1BbSNUCh8c2zdGasA7+hoxxSt/
	nUMgrLoiP0RO3WMhm26NetWmc/rthIIOytCnDtLPZ60bYf7wCZx1XLr433e4B+UtJ+y2xsu8JOC
	IhgUu7jybW+q8Sb+x1CVrfwsiLGwkmg4QseuIfPJDsUxWvLr5/qyzRykiWkVvQ+7AAQM10VvOHb
	1Lt51TgcRNgjLSC6mGCUehBuauK3by6v6pK51kvb8pgxt+3exbSocywBptqxw=
X-Received: by 2002:a05:6a20:d524:b0:394:625f:c56c with SMTP id adf61e73a8af0-3946c80bcebmr1038394637.19.1770968741228;
        Thu, 12 Feb 2026 23:45:41 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-103.dlp.protect.broadcom.com. [144.49.247.103])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-35662f4d736sm1484162a91.5.2026.02.12.23.45.40
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Feb 2026 23:45:41 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-896ff58f17aso33971616d6.2
        for <netdev@vger.kernel.org>; Thu, 12 Feb 2026 23:45:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1770968739; x=1771573539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PRALV8S5SycwE1cozmsAcF2ZCcAdV2ORqka9l/U6rP0=;
        b=Mac4LHoU9m++DYg1j7Q5pQ2Krm+z8+YWcbDF3M5eOyXU8NUpxsbM9CaAmLBY2nmJwY
         s6lKVpDi8WsfEq9F57Ji7Jf3rYhyHlW3PLkr7Codgqqv9hgCaS00g2dbPWiYTbN8ZHja
         LoD9JJVvIRBFydRk9v4Du96r7dSzaFiPbD7UI=
X-Received: by 2002:a05:6214:1c42:b0:892:69de:236e with SMTP id 6a1803df08f44-897360d3dd5mr11372036d6.22.1770968739341;
        Thu, 12 Feb 2026 23:45:39 -0800 (PST)
X-Received: by 2002:a05:6214:1c42:b0:892:69de:236e with SMTP id 6a1803df08f44-897360d3dd5mr11371876d6.22.1770968738876;
        Thu, 12 Feb 2026 23:45:38 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50684b6b56bsm58882201cf.17.2026.02.12.23.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 23:45:38 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: [PATCH net v3 4/4] selftests: drv-net: rss_ctx: test RSS contexts persist after ifdown/up
Date: Thu, 12 Feb 2026 23:45:03 -0800
Message-ID: <20260213074503.2302046-5-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.45.4
In-Reply-To: <20260213074503.2302046-1-michael.chan@broadcom.com>
References: <20260213074503.2302046-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	TAGGED_FROM(0.00)[bounces-258579-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michael.chan@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,broadcom.com:mid,broadcom.com:dkim,broadcom.com:email,lib.py:url,rss_ctx.py:url];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 8A482133AFF
X-Rspamd-Action: no action

From: Pavan Chebbi <pavan.chebbi@broadcom.com>

Add a test to verify that RSS contexts persist across interface
down/up along with their associated Ntuple filters. Another test
that creates contexts/rules keeping interface down and test their
persistence is also added.

Tested on bnxt_en:

 TAP version 13
 1..1
 # timeout set to 0
 # selftests: drivers/net/hw: rss_ctx.py
 # TAP version 13
 # 1..2
 # ok 1 rss_ctx.test_rss_context_persist_create_and_ifdown
 # ok 2 rss_ctx.test_rss_context_persist_ifdown_and_create # SKIP Create context not supported with interface down
 # # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:1 error:0

Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
v3: More improvements suggested by Jakub:
1. Used defer() and exec() for the if up
2. Wait for carrier before trying the ping to start traffic tests
3. Replace manual subprocess.run() ping loop with cmd()
4. Fixed all ruff and pylint warnings in the newly added code

v2: Many improvements suggested by Jakub:
https://lore.kernel.org/netdev/20260206052930.1882740-5-michael.chan@broadcom.com/
1. simplified the tests to have only 2 contexts, use one of the contexts
to test ntuple filters' persistence also 
2. used @ksft_disruptive for the test
3. used netlink API to get rss contexts

v1: https://lore.kernel.org/netdev/20260129061646.1417185-5-michael.chan@broadcom.com/
---
 .../selftests/drivers/net/hw/rss_ctx.py       | 100 +++++++++++++++++-
 1 file changed, 98 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/rss_ctx.py b/tools/testing/selftests/drivers/net/hw/rss_ctx.py
index ed7e405682f0..b9b7527c2c6b 100755
--- a/tools/testing/selftests/drivers/net/hw/rss_ctx.py
+++ b/tools/testing/selftests/drivers/net/hw/rss_ctx.py
@@ -4,13 +4,15 @@
 import datetime
 import random
 import re
+import time
 from lib.py import ksft_run, ksft_pr, ksft_exit
 from lib.py import ksft_eq, ksft_ne, ksft_ge, ksft_in, ksft_lt, ksft_true, ksft_raises
 from lib.py import NetDrvEpEnv
 from lib.py import EthtoolFamily, NetdevFamily
 from lib.py import KsftSkipEx, KsftFailEx
+from lib.py import ksft_disruptive
 from lib.py import rand_port
-from lib.py import ethtool, ip, defer, GenerateTraffic, CmdExitFailure
+from lib.py import cmd, ethtool, ip, defer, GenerateTraffic, CmdExitFailure, wait_file
 
 
 def _rss_key_str(key):
@@ -809,6 +811,98 @@ def test_rss_default_context_rule(cfg):
                           'noise' : (0, 1) })
 
 
+@ksft_disruptive
+def test_rss_context_persist_ifupdown(cfg, pre_down=False):
+    """
+    Test that RSS contexts and their associated ntuple filters persist across
+    an interface down/up cycle.
+
+    """
+
+    require_ntuple(cfg)
+
+    qcnt = len(_get_rx_cnts(cfg))
+    if qcnt < 6:
+        try:
+            ethtool(f"-L {cfg.ifname} combined 6")
+            defer(ethtool, f"-L {cfg.ifname} combined {qcnt}")
+        except Exception as exc:
+            raise KsftSkipEx("Not enough queues for the test") from exc
+
+    ethtool(f"-X {cfg.ifname} equal 2")
+    defer(ethtool, f"-X {cfg.ifname} default")
+
+    ifup = defer(ip, f"link set dev {cfg.ifname} up")
+    if pre_down:
+        ip(f"link set dev {cfg.ifname} down")
+
+    try:
+        ctx1_id = ethtool_create(cfg, "-X", "context new start 2 equal 2")
+        defer(ethtool, f"-X {cfg.ifname} context {ctx1_id} delete")
+    except CmdExitFailure as exc:
+        raise KsftSkipEx("Create context not supported with interface down") from exc
+
+    ctx2_id = ethtool_create(cfg, "-X", "context new start 4 equal 2")
+    defer(ethtool, f"-X {cfg.ifname} context {ctx2_id} delete")
+
+    port_ctx2 = rand_port()
+    flow = f"flow-type tcp{cfg.addr_ipver} dst-ip {cfg.addr} dst-port {port_ctx2} context {ctx2_id}"
+    ntuple_id = ethtool_create(cfg, "-N", flow)
+    defer(ethtool, f"-N {cfg.ifname} delete {ntuple_id}")
+
+    if not pre_down:
+        ip(f"link set dev {cfg.ifname} down")
+    ifup.exec()
+
+    wait_file(f"/sys/class/net/{cfg.ifname}/carrier",
+        lambda x: x.strip() == "1", deadline=20)
+
+    remote_addr = cfg.remote_addr_v[cfg.addr_ipver]
+    for _ in range(10):
+        if cmd(f"ping -c 1 -W 1 {remote_addr}", fail=False).ret == 0:
+            break
+        time.sleep(1)
+    else:
+        raise KsftSkipEx("Cannot reach remote host after interface up")
+
+    ctxs = cfg.ethnl.rss_get({'header': {'dev-name': cfg.ifname}}, dump=True)
+
+    data1 = [c for c in ctxs if c.get('context') == ctx1_id]
+    ksft_eq(len(data1), 1, f"Context {ctx1_id} should persist after ifup")
+
+    data2 = [c for c in ctxs if c.get('context') == ctx2_id]
+    ksft_eq(len(data2), 1, f"Context {ctx2_id} should persist after ifup")
+
+    _ntuple_rule_check(cfg, ntuple_id, ctx2_id)
+
+    cnts = _get_rx_cnts(cfg)
+    GenerateTraffic(cfg).wait_pkts_and_stop(20000)
+    cnts = _get_rx_cnts(cfg, prev=cnts)
+
+    main_traffic = sum(cnts[0:2])
+    ksft_ge(main_traffic, 18000, f"Main context traffic distribution: {cnts}")
+    ksft_lt(sum(cnts[2:6]), 500, f"Other context queues should be mostly empty: {cnts}")
+
+    _send_traffic_check(cfg, port_ctx2, f"context {ctx2_id}",
+                        {'target': (4, 5),
+                         'noise': (0, 1),
+                         'empty': (2, 3)})
+
+
+def test_rss_context_persist_create_and_ifdown(cfg):
+    """
+    Create RSS contexts then cycle the interface down and up.
+    """
+    test_rss_context_persist_ifupdown(cfg, pre_down=False)
+
+
+def test_rss_context_persist_ifdown_and_create(cfg):
+    """
+    Bring interface down first, then create RSS contexts and bring up.
+    """
+    test_rss_context_persist_ifupdown(cfg, pre_down=True)
+
+
 def main() -> None:
     with NetDrvEpEnv(__file__, nsim_test=False) as cfg:
         cfg.context_cnt = None
@@ -823,7 +917,9 @@ def main() -> None:
                   test_rss_context_out_of_order, test_rss_context4_create_with_cfg,
                   test_flow_add_context_missing,
                   test_delete_rss_context_busy, test_rss_ntuple_addition,
-                  test_rss_default_context_rule],
+                  test_rss_default_context_rule,
+                  test_rss_context_persist_create_and_ifdown,
+                  test_rss_context_persist_ifdown_and_create],
                  args=(cfg, ))
     ksft_exit()
 
-- 
2.51.0


