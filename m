Return-Path: <netdev+bounces-261543-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uPkqI7aZoGlVlAQAu9opvQ
	(envelope-from <netdev+bounces-261543-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 20:06:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DC7C11AE2AC
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 20:06:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 86F8C32653DE
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 18:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD27A36215F;
	Thu, 26 Feb 2026 18:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="DPlwYU91"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C72F3290A9
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 18:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772131650; cv=none; b=Cj/fu3Yub7C3BONKj2zo+WZJGFn48erZHolQNEYPerSsK05+JdghHn6EZF7Zp1rm80uTV3W/CDMdzR7gfrcumLv/s+Tfqfgj2bvfuAQYoUkoDJNp/8ACVeA0zw6mnzr/iv/WcmVABh5k5TzjHQXdQx+kqcTDOnCSJeLDij0IWDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772131650; c=relaxed/simple;
	bh=o5gl4lvmo8nTD5aew6xv75adaez1vKzLC90tZuUkeGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ux8k78VTycF0XVfjYl35S/twI6j39DYb7xJcTk3j7mU/ehw+kEb6092DtuHgi0UksNfFTorLO+r/EQySGa+Fh3DTvU3tFKMy8WIzL2WyCze2TDDgteT0HOw1yfNpi/oqMxYssqnyrYVIIJfv9pVvmac/tiYKUBBlirZaY7I5qaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=DPlwYU91; arc=none smtp.client-ip=209.85.214.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-2ab077e3f32so5216025ad.3
        for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 10:47:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772131649; x=1772736449;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jafYfDMXlkNngqCFpdDSXM7Zpv6/tNdLZ8FA9C+kjOU=;
        b=dtEY5joXYmdeitl7X2oYpsPW0BP28lvqL0MB+kefKH6itKLVjtTOmm0YhzGTsjhxTJ
         4VSmMfhY9tXINRBQQOe8wtg24ybBmPOuWFPcbblVOU9+rdN5doEo445H2RCXHBCDzeWB
         0FLjDiX3pI2gokVLvnDYuWVzvIgWUwleqYyeK4Sl+7h++A8I6GXrz6wyFiXPXsByQLF0
         EazG4nBIOWFRjDeMtkwbKWE5/EHN883q5pPJmCzlzAtHh3J3GX2fIcnlF8f/mf/wgLIR
         MAsHC57SiUV1HRb3/ixsCmDJwq7CJwtHeIHfkovFXe0y0trb92fB+sLcSJDvd+Wdbd+5
         jLOg==
X-Forwarded-Encrypted: i=1; AJvYcCVa3f2/hIwxHH8jOow7b0ct3GHPP1d9FrnlzKkQVWK79XZ8iEWCDqGtv601HmHioQMk0fQTSc0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCtPu/m0KcfqLZ8RlGCOLoF4vJVxi9awQztMyWmDbRMquugt94
	G14kpeumTGyj4taZuo55yimvMdpVNPOT5dMDsT2/CrqAULqEI/5gqcaf6ZDrNya/oRPrdhSEkzt
	XhGLqRYkKTpZZ8qtcTZzKtVlyPi/6DCsA3hLDTNH76CqwtI8TBQQDV8GyF93mu5eL9FaTGJ2Gne
	Qz4BQ53ZqtXKGjjYp+0Lmq76VcXXITBh+5y8GBJrjW8GiJzl3ykO7jl5uO2IqSsGADzs/mR1rD5
	XoWHabZB2li
X-Gm-Gg: ATEYQzy09VdgERO37OScfFVpkbnsa8TkAofCiQxx6DHAMUM9ThDN3pHGk2zuqSS8s7P
	/mUkxpJ7mbcLhNu3Sl+R7kXFpftFcCZ/vGuwPvvSyM2ssoLw9b5Rx/kr9a83YVml86hbZK9i4PS
	Adj4k9rtHRAR19nqcnKBRSl4IuljtrRcctAAfEHwYHIr+XAbAfFLHKMdChfY363LEInLCEMG/RM
	Xr1HTPJPHiA6vmV8U6WB6I8WxRrjVqyzGc+FdHy8qj1vOXU4J4YxgaqqHBb/BWdnU37uphWjsjn
	ATGe/EsPWqqaof91imA6KqYGS61V3e7SDhldH+YoTSH+xUBiRB/4jP7xmrfYzJciLijBfACArqH
	iXbz94Excte5+vHhB1Gfk0O2MzfWbSWdeTdmEoZYXIVJok5xBQQRD/hZgtCqMKPZzv8xThsDjbN
	AG78QRe8ncgB/0X8Fo+gHaVv3SQhtZK6rm1IVCJO9FfyCst5yuNHYHN1xR+A==
X-Received: by 2002:a17:902:e743:b0:2a8:ff32:5f96 with SMTP id d9443c01a7336-2ade998d7c3mr40727085ad.13.1772131648517;
        Thu, 26 Feb 2026 10:47:28 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2adfb285e00sm3232655ad.23.2026.02.26.10.47.28
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Feb 2026 10:47:28 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8cb390a0c4eso1091724985a.1
        for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 10:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1772131647; x=1772736447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jafYfDMXlkNngqCFpdDSXM7Zpv6/tNdLZ8FA9C+kjOU=;
        b=DPlwYU91pHG2TRP+TouWPRpfSuo9C80R0NunXO5UE1Z3LC4rKwcLv5r8hpXC9AV5rc
         w60UZiEzzsmaqXnyCxJefJ1mM+AWND1ASYGpTpqDD+uK+bjsbkupRKEkVqRVA8KzvT0C
         H3SGu2SSPANPdbKgXREpqsa4rPj4k1Vrtzpmg=
X-Forwarded-Encrypted: i=1; AJvYcCXNHitFBfetFC9nhffGsEFdm49t26Gw+4Rei1TnkSOniYmSUq1xIx26Isw/Y+AH2UasmBqu/I4=@vger.kernel.org
X-Received: by 2002:a05:620a:710b:b0:8c7:c25:9e53 with SMTP id af79cd13be357-8cbbd04021bmr612525185a.59.1772131647465;
        Thu, 26 Feb 2026 10:47:27 -0800 (PST)
X-Received: by 2002:a05:620a:710b:b0:8c7:c25:9e53 with SMTP id af79cd13be357-8cbbd04021bmr612522385a.59.1772131646927;
        Thu, 26 Feb 2026 10:47:26 -0800 (PST)
Received: from lvnvda4076.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf6f5c41sm255721485a.24.2026.02.26.10.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 10:47:26 -0800 (PST)
From: Kiran Kella <kiran.kella@broadcom.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	daniel.zahka@gmail.com,
	willemb@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org
Cc: shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jayakrishnan.udayavarma@broadcom.com,
	ajit.khaparde@broadcom.com,
	akhilesh.samineni@broadcom.com,
	Kiran Kella <kiran.kella@broadcom.com>
Subject: [net-next, v3 2/2] selftests: drv-net: psp: add test for VLAN sub-interface
Date: Thu, 26 Feb 2026 10:46:54 -0800
Message-ID: <20260226184654.3180648-3-kiran.kella@broadcom.com>
X-Mailer: git-send-email 2.45.4
In-Reply-To: <20260226184654.3180648-1-kiran.kella@broadcom.com>
References: <20260226184654.3180648-1-kiran.kella@broadcom.com>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,gmail.com,redhat.com,lunn.ch];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261543-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kiran.kella@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcom.com:mid,broadcom.com:dkim,broadcom.com:email];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.996];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: DC7C11AE2AC
X-Rspamd-Action: no action

Add test to validate that the psp device information is propagated
properly from the lower device to the upper devices so that
the PSP transmit validation passes.

Signed-off-by: Kiran Kella <kiran.kella@broadcom.com>
Reviewed-by: Akhilesh Samineni <akhilesh.samineni@broadcom.com>
---
 tools/testing/selftests/drivers/net/config |  1 +
 tools/testing/selftests/drivers/net/psp.py | 81 +++++++++++++++++++++-
 2 files changed, 81 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/config b/tools/testing/selftests/drivers/net/config
index 77ccf83d87e0..e03676f1d993 100644
--- a/tools/testing/selftests/drivers/net/config
+++ b/tools/testing/selftests/drivers/net/config
@@ -3,6 +3,7 @@ CONFIG_DEBUG_INFO_BTF=y
 CONFIG_DEBUG_INFO_BTF_MODULES=n
 CONFIG_INET_PSP=y
 CONFIG_IPV6=y
+CONFIG_VLAN_8021Q=m
 CONFIG_NETCONSOLE=m
 CONFIG_NETCONSOLE_DYNAMIC=y
 CONFIG_NETCONSOLE_EXTENDED_LOG=y
diff --git a/tools/testing/selftests/drivers/net/psp.py b/tools/testing/selftests/drivers/net/psp.py
index 864d9fce1094..b3d00bb01816 100755
--- a/tools/testing/selftests/drivers/net/psp.py
+++ b/tools/testing/selftests/drivers/net/psp.py
@@ -9,6 +9,7 @@ import socket
 import struct
 import termios
 import time
+import types
 
 from lib.py import defer
 from lib.py import ksft_run, ksft_exit, ksft_pr
@@ -18,6 +19,7 @@ from lib.py import KsftSkipEx
 from lib.py import NetDrvEpEnv, PSPFamily, NlError
 from lib.py import bkg, rand_port, wait_port_listen
 
+from lib.py import cmd, ip
 
 def _get_outq(s):
     one = b'\0' * 4
@@ -570,6 +572,83 @@ def removal_device_bi(cfg):
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
+    _init_psp_dev(cfg)
+
+    try:
+        cmd("modprobe 8021q")
+    except Exception:
+        raise KsftSkipEx("VLAN (8021q) kernel module not available")
+
+    vlan_id = 100
+    local_ifname = f"{cfg.ifname}.{vlan_id}"
+    remote_ifname = f"{cfg.remote_ifname}.{vlan_id}"
+
+    # Create VLAN interface on LOCAL side
+    ip(f"link add link {cfg.ifname} name {local_ifname} type vlan id {vlan_id}")
+    defer(ip, f"link del {local_ifname}")
+    ip(f"addr add 192.0.2.21/24 dev {local_ifname}")
+    ip(f"-6 addr add 2001:db8::21/64 dev {local_ifname} nodad")
+    ip(f"link set {local_ifname} up")
+
+    # Create VLAN interface on REMOTE side
+    ip(f"link add link {cfg.remote_ifname} name {remote_ifname} "
+       f"type vlan id {vlan_id}", host=cfg.remote)
+    defer(ip, f"link del {remote_ifname}", host=cfg.remote)
+    ip(f"addr add 192.0.2.22/24 dev {remote_ifname}", host=cfg.remote)
+    ip(f"-6 addr add 2001:db8::22/64 dev {remote_ifname} nodad",
+       host=cfg.remote)
+    ip(f"link set {remote_ifname} up", host=cfg.remote)
+
+    local_ifindex = ip(f"-j link show {local_ifname}", json=True)[0]['ifindex']
+
+    vlan_cfg = types.SimpleNamespace(
+        ifname=local_ifname,
+        ifindex=local_ifindex,
+        remote_ifname=remote_ifname,
+        addr_v={"4": "192.0.2.21", "6": "2001:db8::21"},
+        remote_addr_v={"4": "192.0.2.22", "6": "2001:db8::22"},
+        addr="192.0.2.21",
+        remote_addr="192.0.2.22",
+        pspnl=cfg.pspnl,
+        psp_dev_id=cfg.psp_dev_id,
+        remote=cfg.remote,
+        comm_port=cfg.comm_port,
+        comm_sock=cfg.comm_sock,
+    )
+
+    s = _make_psp_conn(vlan_cfg, version=0)
+    defer(_close_psp_conn, vlan_cfg, s)
+
+    # Create PSP associations
+    # The socket's device is VLAN, but PSP device is on physical NIC
+    rx_assoc = vlan_cfg.pspnl.rx_assoc({
+        "version": 0,
+        "dev-id": vlan_cfg.psp_dev_id,  # PSP device on physical interface
+        "sock-fd": s.fileno()
+    })
+    rx = rx_assoc['rx-key']
+    tx = _spi_xchg(s, rx)
+
+    vlan_cfg.pspnl.tx_assoc({
+        "dev-id": vlan_cfg.psp_dev_id,
+        "version": 0,
+        "tx-key": tx,
+        "sock-fd": s.fileno()
+    })
+
+    # Send data through VLAN interface (VLAN-to-VLAN traffic!)
+    data_len = _send_careful(vlan_cfg, s, 100)
+    _check_data_rx(vlan_cfg, data_len)
 
 def psp_ip_ver_test_builder(name, test_func, psp_ver, ipver):
     """Build test cases for each combo of PSP version and IP version"""
@@ -624,7 +703,7 @@ def main() -> None:
                 ]
 
                 ksft_run(cases=cases, globs=globals(),
-                         case_pfx={"dev_", "data_", "assoc_", "removal_"},
+                         case_pfx={"dev_", "data_", "assoc_", "removal_", "vlan_"},
                          args=(cfg, ))
 
                 cfg.comm_sock.send(b"exit\0")
-- 
2.45.4


