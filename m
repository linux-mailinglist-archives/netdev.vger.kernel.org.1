Return-Path: <netdev+bounces-225334-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EF06B92549
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 19:00:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5C3F7A6EB8
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 16:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBBB7313281;
	Mon, 22 Sep 2025 17:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NzLsFtFP"
X-Original-To: netdev@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E113FC2FB
	for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 17:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758560426; cv=none; b=oc7XT8T+guDj5Zmon6HxCIN4m8PaI8kR7brMBumnZlqkmNlDIEWO3iFatzA7YvJ1j4adhzOx8hlCcVDU59cN7E3Om+U3/sl26WogsPc4MOhg4MmDIE2LB0nuROk4TjUWH9JJOweDt8tWPUqfs9J3Yey30fy+s39Md0SseDOVE+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758560426; c=relaxed/simple;
	bh=Csb0a6IihihhDwasqq7I7sFrxpvSKgJ6Kv2FpAThuuY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nokJoZWTKSoBgySuItigxL/GPhHg0pPn4sb2MTIcM4/pR1KgbrpVxabUy6IHLpMEj7HKfLVJoKG1rfw6gM4O/j4NbdsdO7TfNvZm2FNtV+wTRx8s/McEYPPwkNHAmYZ+87zH5riA7PnvENbEXbkeAU8WixdmDXccJI8plaPfa+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NzLsFtFP; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758560423;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uHtRGMsCyWG+dVX/8FnR9lbs65QoxIQmjxOBC1AF1aw=;
	b=NzLsFtFP0/vOi2OgiPCbUXlJxY8OfyX5Vg4famTL0JTIl84HVOO5itcgtvJfi/Ao074uLB
	WwrvCxnTbexTYojkHwD7ZdWr0eDNjJvxxUzVM+CSHpYpXRN29IU2WBusXVXccAs0/1SwaQ
	bhfiFEtRE7Fo8WLCtdHHWKqbnNtypNo=
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
To: Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: netdev@vger.kernel.org
Subject: [PATCH net-next 4/4] selftests: drv-net: add HW timestamping tests
Date: Mon, 22 Sep 2025 16:51:18 +0000
Message-ID: <20250922165118.10057-5-vadim.fedorenko@linux.dev>
In-Reply-To: <20250922165118.10057-1-vadim.fedorenko@linux.dev>
References: <20250922165118.10057-1-vadim.fedorenko@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add simple tests to validate that the driver sets up timestamping
configuration according to what is reported in capabilities.

For RX timestamping we allow driver to fallback to wider scope for
timestamping if filter is applied. That actually means that driver
can enable ptpv2-event when it reports ptpv2-l4-event is supported,
but not vice versa.

Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
---
 .../selftests/drivers/net/hw/nic_timestamp.py | 75 +++++++++++++++++++
 1 file changed, 75 insertions(+)
 create mode 100755 tools/testing/selftests/drivers/net/hw/nic_timestamp.py

diff --git a/tools/testing/selftests/drivers/net/hw/nic_timestamp.py b/tools/testing/selftests/drivers/net/hw/nic_timestamp.py
new file mode 100755
index 000000000000..758d00c6f965
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/hw/nic_timestamp.py
@@ -0,0 +1,75 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+import datetime
+import random
+from lib.py import ksft_run, ksft_exit, ksft_ge, ksft_eq, KsftSkipEx
+from lib.py import NetDrvEnv, EthtoolFamily, NlError
+
+def _getHWTimeStampSupport(cfg):
+    tsinfo = cfg.ethnl.tsinfo_get({'header': {'dev-name': cfg.ifname}})
+    ctx = {}
+    tx = tsinfo.get('tx-types', {})
+    rx = tsinfo.get('rx-filters', {})
+
+    bits = tx.get('bits', {})
+    ctx['tx'] = bits.get('bit', [])
+    bits = rx.get('bits', {})
+    ctx['rx'] = bits.get('bit', [])
+    return ctx
+
+def _getHWTimeStampConfig(cfg):
+    try:
+        tscfg = cfg.ethnl.tsconfig_get({'header': {'dev-name': cfg.ifname}})
+    except NlError as e:
+        if e.error == errno.EOPNOTSUPP:
+            raise KsftSkipEx("timestamping configuration is not supported via netlink") from e
+        raise
+    return tscfg
+
+def _setHWTimeStampConfig(cfg, ts):
+    ts['header'] = {'dev-name': cfg.ifname}
+    try:
+        res = cfg.ethnl.tsconfig_set(ts)
+    except NlError as e:
+	    if e.error == errno.EOPNOTSUPP:
+	        raise KsftSkipEx("timestamping configuration is not supported via netlink") from e
+	    raise
+    return res
+
+def test_hwtstamp_tx(cfg):
+    orig_tscfg = _getHWTimeStampConfig(cfg)
+    ts = _getHWTimeStampSupport(cfg)
+    tx = ts['tx']
+    for t in tx:
+        tscfg = orig_tscfg
+        tscfg['tx-types']['bits']['bit'] = [t]
+        res = _setHWTimeStampConfig(cfg, tscfg)
+        ksft_eq(res['tx-types']['bits']['bit'], [t])
+    _setHWTimeStampConfig(cfg, orig_tscfg)
+
+def test_hwtstamp_rx(cfg):
+    orig_tscfg = _getHWTimeStampConfig(cfg)
+    ts = _getHWTimeStampSupport(cfg)
+    rx = ts['rx']
+    for r in rx:
+        tscfg = orig_tscfg
+        tscfg['rx-filters']['bits']['bit'] = [r]
+        res = _setHWTimeStampConfig(cfg, tscfg)
+        if res is None:
+            res = _getHWTimeStampConfig(cfg)
+        if r['index'] == 0 or r['index'] == 1:
+            ksft_eq(res['rx-filters']['bits']['bit'][0]['index'], r['index'])
+        else:
+            # the driver can fallback to some value which has higher coverage for timestamping
+            ksft_ge(res['rx-filters']['bits']['bit'][0]['index'], r['index'])
+    _setHWTimeStampConfig(cfg, orig_tscfg)
+
+def main() -> None:
+    with NetDrvEnv(__file__, nsim_test=False) as cfg:
+        cfg.ethnl = EthtoolFamily()
+        ksft_run([test_hwtstamp_tx, test_hwtstamp_rx], args=(cfg,))
+        ksft_exit()
+
+if __name__ == "__main__":
+    main()
-- 
2.47.3


