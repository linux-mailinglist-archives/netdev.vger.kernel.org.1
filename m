Return-Path: <netdev+bounces-251792-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iImGFzOCcGktYAAAu9opvQ
	(envelope-from <netdev+bounces-251792-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 08:37:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0299752E3C
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 08:37:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 285224C263B
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 07:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55594378D95;
	Wed, 21 Jan 2026 07:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="YWBKm4d0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f225.google.com (mail-dy1-f225.google.com [74.125.82.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3BE445107F
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 07:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768980971; cv=none; b=i+ND3oGRBRlxjLkZtsKhMY3HM0KxffGABkCuHf7JoLCY3OSuKbKWvHgEqdK0+xYMvW78IPVdF0Rd6oe+WaXgXEze+ms9YKc97C5bEv1nG92/TFteg7J3xJAr590DR6pmZPzlLFt4eoAEYNVnlRHtTztE7WpWg9NIMO1zrzwgilQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768980971; c=relaxed/simple;
	bh=eGIsvV3k8nobm8gxsUjvfDtP/GdTxHyAPFyisoAEnvM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XShrIJZBspi715pimv61O0EnLquxoFHJLMJsSz9lMSvAKM2qNMAez4lW+z9dENnYNQImXQ2nRq0QzDr6RmRo+zqVjzJrV7V8qOLS+Q36o7RgCmSmY12fsi/ltHV8tSP65KU2PIksizZLLymvzXJPzxxjv79dPHGlkvqvqcWeydY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=YWBKm4d0; arc=none smtp.client-ip=74.125.82.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-dy1-f225.google.com with SMTP id 5a478bee46e88-2b4520f6b32so8642905eec.0
        for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 23:36:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768980969; x=1769585769;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZFRs/2/xUWr64s2Em1Um+RwUgbyhXVk/kopd42Lfxvw=;
        b=bfZdpWRfXvIbxk4ZKXT+24RC55LFLYXVKww99SQwRrA4rrYgnWQTvuDHlaeuJHOsJa
         qDFy5EZHX2RMnXSrX6vJ22dRQ6j6SSU9CmKBe8u2ma89IP85yaAKgKqJo6A2fDDabSkv
         FFzejRxUPigRF7DPi4MHn2L41yVcbKB7L7V7TnGz3HCraWGCZwzhxuak6Dyt5PU6UeXX
         bwbJdNn4d1PTUNcxRntYgBPmq1tD5aqYVHZjVxlcMiqjOZe2MTHhhzJiWftwrwuwYIHN
         kIKLS/rOkEUIAIk62nRZAj6ikG7vALLWds1ynPocLgWGLRWFDzJmo2q6V1GNyTgWPIf5
         j5SA==
X-Gm-Message-State: AOJu0Yx2vVojXENSojbwg0p/DxQ43dfGmSZBun5YtP+zVhaY1Qbb0gEk
	ekJ1Sq9W1eImqckvntlKIu4gqsoRLfdqxfa5AuNuIJEnoNkpf6Rk+QArcfV5bHg3kK+X+PBIapq
	lRg3hSliZHUVayt//isSsCAV2P05PMGcBYWXGWD6aTfTsQ0e9zdaDpx4EBm+f+emM6jQiNGlIkz
	Vbeeq+BtGjTdhJAF1aA1kqRj7bKO8CMsOvR5baJ2BAWmmATTs0HxsH9/Yjf7nx96isj+rBFWVA3
	CNFeRYUrw==
X-Gm-Gg: AZuq6aJ9QUEnvGShJ8kF/C5dbgJESllCDLwgbWuhzOkl+V1Jm3o4qIX80IKXx/Ot6D5
	5ha2KqW+LGqYRLnyBd1e0E0l/S66Y1j5j33fR6y87c71IDpjLiTj78ckv2y51eLLGeBUgWu1kOC
	LdRN+CSbzG/aDeMjsV2jOFzxh5nx9bKXL78I677kdogYxA0MiYq4LcGo2Fw3Su1E++l9noZzfm4
	yeown7QCK0FPF3oJGm7bQvqJIh4Vsts6KufUgrsZVLv7FrF33go/WbkoK4PopdqXYbVtgx0L+J/
	N4ch4OLQk5Tw6NA8a4IhtK+iknSihEr4alP1SjiqfThCZuZFNQGCD7RLXDsrjqDd+DPCNiCBOM0
	7SXVLiGMHAuKuiCSDCccaWCLfu24w/I4aToipW4iK8Yzg7pJK5csjfH1V7WdD+aBZff+wPoo2V3
	4BpocX3meOuUr2vCmQG759isYoec9swCdT9u/w1ebX/dM=
X-Received: by 2002:a05:7300:2302:b0:2b0:4902:c55c with SMTP id 5a478bee46e88-2b6fd61e647mr2986217eec.18.1768980968654;
        Tue, 20 Jan 2026 23:36:08 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-72.dlp.protect.broadcom.com. [144.49.247.72])
        by smtp-relay.gmail.com with ESMTPS id a92af1059eb24-1244ac45d6asm3166208c88.1.2026.01.20.23.36.08
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Jan 2026 23:36:08 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-890587d4e87so182114316d6.0
        for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 23:36:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1768980967; x=1769585767; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZFRs/2/xUWr64s2Em1Um+RwUgbyhXVk/kopd42Lfxvw=;
        b=YWBKm4d0y/tDWooA7J1vV9Tf5Zj6hKGcGciAMoig0BXwb4ofZhYbrZFLklsn3vz/UQ
         U5vAw2cCgYjsBjlOpL8KsF3rfkpNuXCaRkMyMX4C9Iqj8i6KKaKQqix/zzwmvi9Keh6F
         NrMy/Dr1yh1XGQMRmbxSShirRA8d0KY12FrhQ=
X-Received: by 2002:ad4:596a:0:b0:894:60a9:d45a with SMTP id 6a1803df08f44-894638f5e6fmr51128456d6.48.1768980967387;
        Tue, 20 Jan 2026 23:36:07 -0800 (PST)
X-Received: by 2002:ad4:596a:0:b0:894:60a9:d45a with SMTP id 6a1803df08f44-894638f5e6fmr51128316d6.48.1768980967000;
        Tue, 20 Jan 2026 23:36:07 -0800 (PST)
Received: from lvnvda4076.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-894592ba642sm51439736d6.57.2026.01.20.23.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 23:36:06 -0800 (PST)
From: Kiran Kella <kiran.kella@broadcom.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jayakrishnan.udayavarma@broadcom.com,
	ajit.khaparde@broadcom.com,
	akhilesh.samineni@broadcom.com,
	Kiran Kella <kiran.kella@broadcom.com>
Subject: [net-next 2/2] selftests: drv-net: psp: add test for VLAN sub-interface
Date: Tue, 20 Jan 2026 23:35:17 -0800
Message-ID: <20260121073517.3323332-3-kiran.kella@broadcom.com>
X-Mailer: git-send-email 2.45.4
In-Reply-To: <20260121073517.3323332-1-kiran.kella@broadcom.com>
References: <20260121073517.3323332-1-kiran.kella@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-251792-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:email,broadcom.com:dkim,broadcom.com:mid,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_NEQ_ENVFROM(0.00)[kiran.kella@broadcom.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[broadcom.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DMARC_POLICY_ALLOW(0.00)[broadcom.com,reject];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 0299752E3C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add test to validate that the psp device information is propagated
properly from the lower device to the upper devices so that
the PSP transmit validation passes.

Signed-off-by: Kiran Kella <kiran.kella@broadcom.com>
Reviewed-by: Akhilesh Samineni <akhilesh.samineni@broadcom.com>
---
 tools/testing/selftests/drivers/net/psp.py | 117 ++++++++++++++++++++-
 1 file changed, 115 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/psp.py b/tools/testing/selftests/drivers/net/psp.py
index 528a421ecf76..b0373d6b4998 100755
--- a/tools/testing/selftests/drivers/net/psp.py
+++ b/tools/testing/selftests/drivers/net/psp.py
@@ -17,7 +17,7 @@ from lib.py import ksft_not_none
 from lib.py import KsftSkipEx
 from lib.py import NetDrvEpEnv, PSPFamily, NlError
 from lib.py import bkg, rand_port, wait_port_listen
-
+from lib.py import ip
 
 def _get_outq(s):
     one = b'\0' * 4
@@ -568,6 +568,119 @@ def removal_device_bi(cfg):
     finally:
         _close_conn(cfg, s)
 
+def vlan_basic_send(cfg):
+    """
+    Test PSP over VLAN-to-VLAN traffic
+
+    Network topology:
+      Local VLAN (nsim0.100) <---> Remote VLAN (nsim1.100)
+           |                            |
+      Local Physical (nsim0) <---> Remote Physical (nsim1)
+          [PSP configured here]
+    """
+    cfg.require_nsim()
+    _init_psp_dev(cfg)
+
+    # Store original interface names and addresses
+    orig_local_ifname = cfg.ifname
+    orig_local_ifindex = cfg.ifindex
+    orig_remote_ifname = cfg.remote_ifname
+    orig_local_addr_v4 = cfg.addr_v["4"]
+    orig_local_addr_v6 = cfg.addr_v["6"]
+    orig_remote_addr_v4 = cfg.remote_addr_v["4"]
+    orig_remote_addr_v6 = cfg.remote_addr_v["6"]
+
+    # VLAN configuration
+    vlan_id = 100
+    local_vlan_ifname = f"{orig_local_ifname}.{vlan_id}"
+    remote_vlan_ifname = f"{orig_remote_ifname}.{vlan_id}"
+
+    local_vlan_addr_v4 = "192.0.2.21"
+    remote_vlan_addr_v4 = "192.0.2.22"
+    local_vlan_addr_v6 = "2001:db8::21"
+    remote_vlan_addr_v6 = "2001:db8::22"
+
+    try:
+        # Create VLAN interface on LOCAL side
+        ip(f"link add link {orig_local_ifname} name {local_vlan_ifname} type vlan id {vlan_id}")
+        ip(f"addr add {local_vlan_addr_v4}/24 dev {local_vlan_ifname}")
+        ip(f"-6 addr add {local_vlan_addr_v6}/64 dev {local_vlan_ifname} nodad")
+        ip(f"link set {local_vlan_ifname} up")
+
+        # Create VLAN interface on REMOTE side
+        ip(f"link add link {orig_remote_ifname} name {remote_vlan_ifname} type vlan id {vlan_id}", host=cfg.remote)
+        ip(f"addr add {remote_vlan_addr_v4}/24 dev {remote_vlan_ifname}", host=cfg.remote)
+        ip(f"-6 addr add {remote_vlan_addr_v6}/64 dev {remote_vlan_ifname} nodad", host=cfg.remote)
+        ip(f"link set {remote_vlan_ifname} up", host=cfg.remote)
+
+        # Get VLAN interface indices
+        local_vlan_info = ip(f"-j link show {local_vlan_ifname}", json=True)[0]
+        local_vlan_ifindex = local_vlan_info['ifindex']
+
+        remote_vlan_info = ip(f"-j link show {remote_vlan_ifname}", json=True, host=cfg.remote)[0]
+        remote_vlan_ifindex = remote_vlan_info['ifindex']
+
+        # Temporarily switch cfg to use VLAN interfaces
+        # The PSP device is still on the physical interface, but
+        # the socket will be bound to the VLAN interface
+        cfg.ifname = local_vlan_ifname
+        cfg.ifindex = local_vlan_ifindex
+        cfg.remote_ifname = remote_vlan_ifname
+        cfg.addr_v["4"] = local_vlan_addr_v4
+        cfg.addr_v["6"] = local_vlan_addr_v6
+        cfg.remote_addr_v["4"] = remote_vlan_addr_v4
+        cfg.remote_addr_v["6"] = remote_vlan_addr_v6
+        cfg.addr = local_vlan_addr_v4
+        cfg.remote_addr = remote_vlan_addr_v4
+
+        s = _make_psp_conn(cfg, version=0)
+
+        try:
+            # Create PSP associations
+            # The socket's device is VLAN, but PSP device is on physical NIC
+            rx_assoc = cfg.pspnl.rx_assoc({
+                "version": 0,
+                "dev-id": cfg.psp_dev_id,  # PSP device on physical interface
+                "sock-fd": s.fileno()
+            })
+            rx = rx_assoc['rx-key']
+            tx = _spi_xchg(s, rx)
+
+            cfg.pspnl.tx_assoc({
+                "dev-id": cfg.psp_dev_id,
+                "version": 0,
+                "tx-key": tx,
+                "sock-fd": s.fileno()
+            })
+
+            # Send data through VLAN interface (VLAN-to-VLAN traffic!)
+            data_len = _send_careful(cfg, s, 100)
+            _check_data_rx(cfg, data_len)
+
+        finally:
+            _close_psp_conn(cfg, s)
+
+    finally:
+        # Restore original interface configuration
+        cfg.ifname = orig_local_ifname
+        cfg.ifindex = orig_local_ifindex
+        cfg.remote_ifname = orig_remote_ifname
+        cfg.addr_v["4"] = orig_local_addr_v4
+        cfg.addr_v["6"] = orig_local_addr_v6
+        cfg.remote_addr_v["4"] = orig_remote_addr_v4
+        cfg.remote_addr_v["6"] = orig_remote_addr_v6
+        cfg.addr = orig_local_addr_v4
+        cfg.remote_addr = orig_remote_addr_v4
+
+        # Clean up VLAN interfaces
+        try:
+            ip(f"link del {local_vlan_ifname}")
+        except Exception:
+            pass
+        try:
+            ip(f"link del {remote_vlan_ifname}", host=cfg.remote)
+        except Exception:
+            pass
 
 def psp_ip_ver_test_builder(name, test_func, psp_ver, ipver):
     """Build test cases for each combo of PSP version and IP version"""
@@ -622,7 +735,7 @@ def main() -> None:
                 ]
 
                 ksft_run(cases=cases, globs=globals(),
-                         case_pfx={"dev_", "data_", "assoc_", "removal_"},
+                         case_pfx={"dev_", "data_", "assoc_", "removal_", "vlan_"},
                          args=(cfg, ))
 
                 cfg.comm_sock.send(b"exit\0")
-- 
2.45.4


