Return-Path: <netdev+bounces-226084-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4544DB9BC60
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 21:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 648EF4C41CB
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 19:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44AF2274668;
	Wed, 24 Sep 2025 19:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KFpkzvd+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F682727E7
	for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 19:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758743413; cv=none; b=W3tArzBmMfeaM/cDiV3+NFXVNbJXRM2BFhADW3jc/43eljLhFnKlKVgHOVkGS8nagTERxstbYutgnyZVu0IjC9D/ci20rfiuKnhvLToFDHNFqnQy8/1fO4NxSRXNYpwgOsVJeAXU/dRBbRTJ3xOZGm+l2P0Y4lpYylXsaD+olxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758743413; c=relaxed/simple;
	bh=xyY/CWdowdFduh9j11uI9ELUZbQgR/aqxTs+cL39umg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W9F8tOp2Ngx71IDdYuiRqdW4sa67NVxP6TALZFitn0FI0nXb+fL9PaOYY3rlUYfM+14ffDlNRog02rK/FzeSbgnI+F/+EKqh0D78JeQYEb9yAxZ0Rks2gHtKIyRSCy26oInvh5SJIiJJ4wEX/oACguqgPSdu3OIFreYygv7htV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KFpkzvd+; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-74f6974175dso3336367b3.3
        for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 12:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758743410; x=1759348210; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7TH1vfEXWnWsiAr3j7aLFTxu3EydcolCjA0DnJsa7c4=;
        b=KFpkzvd+A96f5P50fuiREOvHj9AUG9W14Vi3KX577Xd4Imys0wT3UjLFMxJzD1wj3V
         EsbCsECSdfUSHnMVfrABZ2WhqP3+tmi4qLb0kqetbO+IFneh4lPDMoIQ6ruop/CC1wOE
         CcX5f43l4AhPCAW35HYQlrnAk5Q28hBXPoXM5MZ1vqfRqBcfW4jbOi6RmAYpEVBCuzze
         XQenzqhBMOKxZ94RJG0V7VSQsrV0Y/JyE2OUOzZikP4T6Ngmv7KDD+saMo/dJ1p4vir/
         fzGeIaJe1xtF9mPbLuFaEcSgVORtx4O0nVIwTYLDDDYA4SRjWcIDCgfeJBXSVGbtQ49j
         Y9HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758743410; x=1759348210;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7TH1vfEXWnWsiAr3j7aLFTxu3EydcolCjA0DnJsa7c4=;
        b=bBxhYa/Ifi5jeMUEPXjZw2cWmFUMMmoxlEsz0lw7Qv/d1reQvA1A+YBFAffYwxgk8c
         OsJt8jqDunCHYRFhnVtKJMv6WRaYrjCckKnGbwT0PYtlXXTb9iBGurHPS2/Gd0vx88XK
         JwBy6fRQtr4Wmu14RctnMMF/am7F+6bYlaLD+LsyKYbjco/Au8FQjgUsylZ9H1xLrUJ7
         +dwHJP16mAREyUQAn4iNOX+6HKRqmJU1ogVGAVQjEQiPhFI9zZVjglUQmQ47i73FrCZF
         7zrSjOx4vTT7fr4bO6EMoy3K4kpW4X1+sLsrqu//K72aJy4yvpiR/LgpbJ8/VF7fHOBF
         EZHA==
X-Forwarded-Encrypted: i=1; AJvYcCVdaH5s/YrAwXgSCXz6kIsdwGkfKR+fEfoSdWGxmTWhpuRpAYZLfTVLajJQVT/CEyMTMuArOX8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOpqDaisQkWfR6JV68o4XatATMwRJdljzutm652O6G7FXlaRWB
	+JCSqHoV/UgJKEKKuxOT/zqFbFbPeHLQc5do17JmAJu/SrrztclUZWig
X-Gm-Gg: ASbGncunTblFgkbcW81eqE8c8evv8+3Ar1xDakHdN2vUP/qXlaelOA1Z/Xvi00czJ/7
	owCaED7vp2TP8rxI1dnCaRyTnTyhPrFlUOH0T3zeY2J2yuHGgRHcAPt7kswHGJ1LLmO9HTDYFXq
	fnL4Ke4/SEmwDBIkr4mcsv5wT6/QlrcX7DyHHfqm5tOxmwNzqFRKpad04CGCaTGIE60m3ya01Nc
	gwDCdPBNmKdxz8KioHUWfOjpmlf2wcWWEBmHhHfFYEWXUdWayoFhwGPCx3VRRZyPqxIBBOag2Vk
	6mYSHW/D6n8WA2PHq1OWrVzLG7ZNeSt6XaCNUZbj77IMeEqFrDI49/IcSnLqufvRCd/L1ZitdQy
	QBhd+Qv4qdCWAybMB/+s4
X-Google-Smtp-Source: AGHT+IGObg9uwpOhA4hYKB/MG64kxg3bRAKW6l6Jdp6SmHRUDddNRc4iUzWpjOHMaIo9zaQ1rxhO6Q==
X-Received: by 2002:a53:720b:0:b0:635:4ecc:fc27 with SMTP id 956f58d0204a3-6361a85c8aamr649873d50.47.1758743410542;
        Wed, 24 Sep 2025 12:50:10 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:74::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-74033a13435sm40609687b3.69.2025.09.24.12.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 12:50:09 -0700 (PDT)
From: Daniel Zahka <daniel.zahka@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Willem de Bruijn <willemb@google.com>,
	Breno Leitao <leitao@debian.org>,
	Petr Machata <petrm@nvidia.com>,
	Yuyang Huang <yuyanghuang@google.com>,
	Xiao Liang <shaw.leon@gmail.com>,
	Carolina Jubran <cjubran@nvidia.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	netdev@vger.kernel.org
Subject: [PATCH net-next 8/9] selftests: drv-net: psp: add test for auto-adjusting TCP MSS
Date: Wed, 24 Sep 2025 12:49:54 -0700
Message-ID: <20250924194959.2845473-9-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250924194959.2845473-1-daniel.zahka@gmail.com>
References: <20250924194959.2845473-1-daniel.zahka@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jakub Kicinski <kuba@kernel.org>

Test TCP MSS getting auto-adjusted. PSP adds an encapsulation overhead
of 40B per packet, when used in transport mode without any
virtualization cookie or other optional PSP header fields. The kernel
should adjust the MSS for a connection after PSP tx state is reached.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---
 tools/testing/selftests/drivers/net/psp.py | 50 ++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/psp.py b/tools/testing/selftests/drivers/net/psp.py
index 46e63b85be75..ee103b47568c 100755
--- a/tools/testing/selftests/drivers/net/psp.py
+++ b/tools/testing/selftests/drivers/net/psp.py
@@ -406,6 +406,43 @@ def data_send_disconnect(cfg):
         s.close()
 
 
+def _data_mss_adjust(cfg, ipver):
+    # First figure out what the MSS would be without any adjustments
+    s = _make_clr_conn(cfg, ipver)
+    s.send(b"0123456789abcdef" * 1024)
+    _check_data_rx(cfg, 16 * 1024)
+    mss = s.getsockopt(socket.IPPROTO_TCP, socket.TCP_MAXSEG)
+    _close_conn(cfg, s)
+
+    s = _make_psp_conn(cfg, 0, ipver)
+    try:
+        rx_assoc = cfg.pspnl.rx_assoc({"version": 0,
+                                     "dev-id": cfg.psp_dev_id,
+                                     "sock-fd": s.fileno()})
+        rx = rx_assoc['rx-key']
+        tx = _spi_xchg(s, rx)
+
+        rxmss = s.getsockopt(socket.IPPROTO_TCP, socket.TCP_MAXSEG)
+        ksft_eq(mss, rxmss)
+
+        cfg.pspnl.tx_assoc({"dev-id": cfg.psp_dev_id,
+                          "version": 0,
+                          "tx-key": tx,
+                          "sock-fd": s.fileno()})
+
+        txmss = s.getsockopt(socket.IPPROTO_TCP, socket.TCP_MAXSEG)
+        ksft_eq(mss, txmss + 40)
+
+        data_len = _send_careful(cfg, s, 100)
+        _check_data_rx(cfg, data_len)
+        _check_data_outq(s, 0)
+
+        txmss = s.getsockopt(socket.IPPROTO_TCP, socket.TCP_MAXSEG)
+        ksft_eq(mss, txmss + 40)
+    finally:
+        _close_psp_conn(cfg, s)
+
+
 def data_stale_key(cfg):
     """ Test send on a double-rotated key """
 
@@ -444,6 +481,15 @@ def psp_ip_ver_test_builder(name, test_func, psp_ver, ipver):
     return test_case
 
 
+def ipver_test_builder(name, test_func, ipver):
+    """Build test cases for each IP version"""
+    def test_case(cfg):
+        cfg.require_ipver(ipver)
+        test_case.__name__ = f"{name}_ip{ipver}"
+        test_func(cfg, ipver)
+    return test_case
+
+
 def main() -> None:
     with NetDrvEpEnv(__file__) as cfg:
         cfg.pspnl = PSPFamily()
@@ -481,6 +527,10 @@ def main() -> None:
                     for version in range(0, 4)
                     for ipver in ("4", "6")
                 ]
+                cases += [
+                    ipver_test_builder("data_mss_adjust", _data_mss_adjust, ipver)
+                    for ipver in ("4", "6")
+                ]
                 ksft_run(cases = cases, globs=globals(), case_pfx={"dev_", "data_", "assoc_"},
                          args=(cfg, ), skip_all=(cfg.psp_dev_id is None))
                 cfg.comm_sock.send(b"exit\0")
-- 
2.47.3


