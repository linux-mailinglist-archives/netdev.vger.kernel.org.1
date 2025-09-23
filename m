Return-Path: <netdev+bounces-225696-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C525EB970AB
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 19:34:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 971B02A86D3
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 17:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3087A2848BA;
	Tue, 23 Sep 2025 17:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VnMLb6b6"
X-Original-To: netdev@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03856280004
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 17:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758648816; cv=none; b=k4JAMN4lbaVbQb1zZT8/cCXcXMTgxVW/BReVRgGvot9UCo+YUaH0IGsbreh3XwEadcWlgKspweLG1RZR3esoeTAVs8GqlYmKWI1N7/Rt4vXBeBzqVoatz+5bfpw8uWHay70wujaQSXAKu7HATKfNu4DqfOvHzeKuBjDq+IW8gUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758648816; c=relaxed/simple;
	bh=t8tFtEZJvtBOLUErqQQnfAKS8nP8iDORpIz7MH4VBl0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CRMudFk+Q+C9gax2d+A299kWMi+EH+7DWmUSTwnmqQlW40Pr8dBQ3I1knsf0BRESHqCix2XiW6ViPm868acMP7tsx86x6rtw0nXQsGpW9glylfmh+bHmlf99lAA43+Xo5YWqToB9704JAdnUF22HLovcqJB1fOJ5AY1ZFYd53B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VnMLb6b6; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758648810;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G/f4HT9bHkrwVRsKb4cAIjb01fhCBksFUxoxys5JbyY=;
	b=VnMLb6b6MewEW4gFv+7Y30MgU2vB0ZMDEwf7n61zaId3vQgr2X4+gMI0NtBTa5nF6AAo44
	yVDAtyahzb0XbnVModpAwGPixNlSjmCHu52/1iqNLDF4fGtwkV7Q2nRIAnfu0xSqEjA/1K
	lPdQ5X7hTVkBfDwwHYpJh6Sim5dHa48=
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
Subject: [PATCH net-next v2 4/4] selftests: drv-net: add HW timestamping tests
Date: Tue, 23 Sep 2025 17:33:10 +0000
Message-ID: <20250923173310.139623-5-vadim.fedorenko@linux.dev>
In-Reply-To: <20250923173310.139623-1-vadim.fedorenko@linux.dev>
References: <20250923173310.139623-1-vadim.fedorenko@linux.dev>
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
 .../testing/selftests/drivers/net/hw/Makefile |   1 +
 .../selftests/drivers/net/hw/nic_timestamp.py | 113 ++++++++++++++++++
 2 files changed, 114 insertions(+)
 create mode 100755 tools/testing/selftests/drivers/net/hw/nic_timestamp.py

diff --git a/tools/testing/selftests/drivers/net/hw/Makefile b/tools/testing/selftests/drivers/net/hw/Makefile
index 5159fd34cb33..ee09a40d532c 100644
--- a/tools/testing/selftests/drivers/net/hw/Makefile
+++ b/tools/testing/selftests/drivers/net/hw/Makefile
@@ -15,6 +15,7 @@ TEST_PROGS = \
 	iou-zcrx.py \
 	irq.py \
 	loopback.sh \
+	nic_timestamp.py \
 	pp_alloc_fail.py \
 	rss_api.py \
 	rss_ctx.py \
diff --git a/tools/testing/selftests/drivers/net/hw/nic_timestamp.py b/tools/testing/selftests/drivers/net/hw/nic_timestamp.py
new file mode 100755
index 000000000000..8e81a2a9d109
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/hw/nic_timestamp.py
@@ -0,0 +1,113 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+"""
+Tests related to configuration of HW timestamping
+"""
+
+import errno
+from lib.py import ksft_run, ksft_exit, ksft_ge, ksft_eq, KsftSkipEx
+from lib.py import NetDrvEnv, EthtoolFamily, NlError
+
+
+def __get_hwtimestamp_support(cfg):
+    """ Retrive supported configuration information """
+
+    try:
+        tsinfo = cfg.ethnl.tsinfo_get({'header': {'dev-name': cfg.ifname}})
+    except NlError as e:
+        if e.error == errno.EOPNOTSUPP:
+            raise KsftSkipEx("timestamping configuration is not supported") from e
+        raise
+
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
+
+def __get_hwtimestamp_config(cfg):
+    """ Retrive current TS configuration information """
+
+    try:
+        tscfg = cfg.ethnl.tsconfig_get({'header': {'dev-name': cfg.ifname}})
+    except NlError as e:
+        if e.error == errno.EOPNOTSUPP:
+            raise KsftSkipEx("timestamping configuration is not supported via netlink") from e
+        raise
+    return tscfg
+
+
+def __set_hwtimestamp_config(cfg, ts):
+    """ Setup new TS configuration information """
+
+    ts['header'] = {'dev-name': cfg.ifname}
+    try:
+        res = cfg.ethnl.tsconfig_set(ts)
+    except NlError as e:
+        if e.error == errno.EOPNOTSUPP:
+            raise KsftSkipEx("timestamping configuration is not supported via netlink") from e
+        raise
+    return res
+
+
+def test_hwtstamp_tx(cfg):
+    """
+    Test TX timestamp configuration.
+    The driver should apply provided config and report back proper state.
+    """
+
+    orig_tscfg = __get_hwtimestamp_config(cfg)
+    ts = __get_hwtimestamp_support(cfg)
+    tx = ts['tx']
+    for t in tx:
+        tscfg = orig_tscfg
+        tscfg['tx-types']['bits']['bit'] = [t]
+        res = __set_hwtimestamp_config(cfg, tscfg)
+        if res is None:
+            res = __get_hwtimestamp_config(cfg)
+        ksft_eq(res['tx-types']['bits']['bit'], [t])
+    __set_hwtimestamp_config(cfg, orig_tscfg)
+
+
+def test_hwtstamp_rx(cfg):
+    """
+    Test RX timestamp configuration.
+    The filter configuration is taken from the list of supported filters.
+    The driver should apply the config without error and report back proper state.
+    Some extension of the timestamping scope is allowed for PTP filters.
+    """
+
+    orig_tscfg = __get_hwtimestamp_config(cfg)
+    ts = __get_hwtimestamp_support(cfg)
+    rx = ts['rx']
+    for r in rx:
+        tscfg = orig_tscfg
+        tscfg['rx-filters']['bits']['bit'] = [r]
+        res = __set_hwtimestamp_config(cfg, tscfg)
+        if res is None:
+            res = __get_hwtimestamp_config(cfg)
+        if r['index'] == 0 or r['index'] == 1:
+            ksft_eq(res['rx-filters']['bits']['bit'][0]['index'], r['index'])
+        else:
+            # the driver can fallback to some value which has higher coverage for timestamping
+            ksft_ge(res['rx-filters']['bits']['bit'][0]['index'], r['index'])
+    __set_hwtimestamp_config(cfg, orig_tscfg)
+
+
+def main() -> None:
+    """ Ksft boiler plate main """
+
+    with NetDrvEnv(__file__, nsim_test=False) as cfg:
+        cfg.ethnl = EthtoolFamily()
+        ksft_run([test_hwtstamp_tx, test_hwtstamp_rx], args=(cfg,))
+        ksft_exit()
+
+
+if __name__ == "__main__":
+    main()
-- 
2.47.3


