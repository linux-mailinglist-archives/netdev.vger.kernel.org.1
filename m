Return-Path: <netdev+bounces-226083-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF09B9BC59
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 21:51:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AD731887146
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 19:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 843762741C0;
	Wed, 24 Sep 2025 19:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ceEA3T/k"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33A426F47D
	for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 19:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758743412; cv=none; b=X1iAx84T5BUmI1RrATLAWZTllnKMqeecmgOYzGUvIJmPsoz96R03e8O58Xe6N0JGS45+XouyfuBd/KsAaXG1bScJ6UaFNmHgpRoBvozMFva5cnttrRgOg/O4hhHtasOojNfsl8uLYuOy2ZwGVF0GGZUEWulpmzeA232hiJ1Qx80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758743412; c=relaxed/simple;
	bh=FEc2amaTMMohaWNUpKkvPfvntz7+3LRcqKJRMiJmm94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y8qKiIyjG2PdAOVHF1Um0NxtuiumaCz1XsuXzMlgFniaetRctdiRNAXNwIsCKAJAggoNTB1CHeRDhtANBFwbO2JZ4MBEKCDQ2LyWOhU+ceapVZ9+mNzgDGV9SjRg0Q3/JkTvcwsmwLEw/iNu/SAJftkJWD9PrFj4b9hLUbLRGaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ceEA3T/k; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-eb37d80cc16so252875276.1
        for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 12:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758743409; x=1759348209; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eUozvurQblkelZKyzctbbcT5cWTMh7YsGcemQn2DgfM=;
        b=ceEA3T/kc7WshECn+2+VkFMp0Dd6++GIcJ2euvFyr2fijV75ejQCpMW20Ml5pEgmSh
         YyZAm4Klf5CW9cmtZO2PB7VglcTnqQweyJSYXVaj/23H5CURRV8VDlnXke5c+PQTH7pA
         jbCbXgQcfMOsErAioHaYJk2m5Ik/q6IMe791fJjorVR2zC782PMIqI1jAAq2e2Oa413D
         evQHfbaFecdCOA7bAm13NVKvqV0CHs2Aze2tRzPzhHgad7USqreDWTDcfZ1BIICSByE2
         a2DP3h8/HljtgAMvqSaz/9TQAXsCeY5Q4XedHdkjw6RDA3nUtz2joYbju/pdB9c3tWvP
         DwAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758743409; x=1759348209;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eUozvurQblkelZKyzctbbcT5cWTMh7YsGcemQn2DgfM=;
        b=UiP+SUTZj8FGNnRk85rMKZirABqT2hsWzIHjdzU/OdG90J/JW+pNBc8XjmOGTZ11Tl
         flm4Er8s3oDT9CQcod4XzLKdsa+ltHZwP4nA9BFDRrwHtkKyC5z7c1JCMA17S3o3GS8j
         ba931MW9jw+TuF0N/d3gVQP46RdmL/MN8ZmUcZVnXXCVHHNeGhN6LXH9LOjX9gV0Q0LC
         OQ21YncQXHnBG8XOa0e5c0EwcSQrmgb9QBdhtC8eEH4S695LSAF9q7T6gKDYhNSy6NDS
         NzRIbXXkWWj44JYiqE7SDvELl5/kKVajOB+hsZuKLXmv3FGcQdvLG6Fj3THqz070EhL/
         HXjA==
X-Forwarded-Encrypted: i=1; AJvYcCW6OnNkMMJd2pfGMNqThgWdAg3hJD8UkLbXOXWTnSpg8kzDN6WIyJeaD1NK73bNP2gWFOde6hI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx59ovXMkZOMha31bvcHLeMyjuC065jOuj8l6Z4pB87XDw97u3j
	SvI/BF3E08l7LN0VnIlVAT90ImP1Sb/5TeFs2GSGSsWqP/JcDqNxkRCP
X-Gm-Gg: ASbGnct74I7RC0KXJse/hyjELljq7b9gFq9IxamM9xAZT+SWdKUq+5UOKsgD070hAoR
	qrqw63ENxSra3X9n+LNGnN9ibWFbD1zKcTx/pDNSn7O2g2a334SwbCPxAV68R7ROYsSuDaTjGKU
	P5WLSJXNQLMGerhcvyTMG6DIiYtsLo0veu8n9T6dGcJxO7cpGKL9lc3tv3TVl4GUJxhyln2bAz0
	cb4tfUN/+3WpkpwpfNhY/9bpvZERRwmUzcSxyoqSQkOFkRWb9iMUnZEsYCcCGUsUBz059FxbGjG
	pr1czBfaERngSE5GG8wUmi7z0s4PNOP8t0SVpXRTm8ai0SAjKvAigLnS/4vDo+oA2b99m6RuQkH
	uiQIaCQ/RR6cp6O0keNAW/Xt1Otonu9k=
X-Google-Smtp-Source: AGHT+IGdpWtPP1R8eYbIHvJ0x+yPGiDEeJ05rcZ5s1b1U6yRFWNbUWKyKULekt0l+jjTrpora5f6PQ==
X-Received: by 2002:a53:a441:0:b0:633:b6b5:ef2c with SMTP id 956f58d0204a3-6361a7fca28mr669815d50.27.1758743409272;
        Wed, 24 Sep 2025 12:50:09 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:3::])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-eb366bc5ff1sm1521980276.6.2025.09.24.12.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 12:50:08 -0700 (PDT)
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
Subject: [PATCH net-next 7/9] selftests: drv-net: psp: add connection breaking tests
Date: Wed, 24 Sep 2025 12:49:53 -0700
Message-ID: <20250924194959.2845473-8-daniel.zahka@gmail.com>
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

Add test checking conditions which lead to connections breaking.
Using bad key or connection gets stuck if device key is rotated
twice.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---
 tools/testing/selftests/drivers/net/psp.py | 111 +++++++++++++++++++++
 1 file changed, 111 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/psp.py b/tools/testing/selftests/drivers/net/psp.py
index 1c504975b07d..46e63b85be75 100755
--- a/tools/testing/selftests/drivers/net/psp.py
+++ b/tools/testing/selftests/drivers/net/psp.py
@@ -15,6 +15,10 @@ from lib.py import NetDrvEpEnv, PSPFamily, NlError
 from lib.py import bkg, rand_port, wait_port_listen
 
 
+class PSPExceptShortIO(Exception):
+    pass
+
+
 def _get_outq(s):
     one = b'\0' * 4
     outq = fcntl.ioctl(s.fileno(), termios.TIOCOUTQ, one)
@@ -89,6 +93,18 @@ def _send_careful(cfg, s, rounds):
     return len(data) * rounds
 
 
+def _recv_careful(s, target, rounds=100):
+    data = b''
+    for _ in range(rounds):
+        try:
+            data += s.recv(target - len(data), socket.MSG_DONTWAIT)
+            if len(data) == target:
+                return data
+        except BlockingIOError:
+            time.sleep(0.001)
+    raise PSPExceptShortIO(target, len(data), data)
+
+
 def _check_data_rx(cfg, exp_len):
     read_len = -1
     for _ in range(30):
@@ -99,6 +115,27 @@ def _check_data_rx(cfg, exp_len):
         time.sleep(0.01)
     ksft_eq(read_len, exp_len)
 
+
+def _check_data_outq(s, exp_len, force_wait=False):
+    outq = 0
+    for _ in range(10):
+        outq = _get_outq(s)
+        if not force_wait and outq == exp_len:
+            break
+        time.sleep(0.01)
+    ksft_eq(outq, exp_len)
+
+
+def _req_echo(cfg, s, expect_fail=False):
+    _send_with_ack(cfg, b'data echo\0')
+    try:
+        _recv_careful(s, 5)
+        if expect_fail:
+            raise Exception("Received unexpected echo reply")
+    except PSPExceptShortIO:
+        if not expect_fail:
+            raise
+
 #
 # Test cases
 #
@@ -324,6 +361,80 @@ def _data_basic_send(cfg, version, ipver):
     _close_psp_conn(cfg, s)
 
 
+def __bad_xfer_do(cfg, s, tx, version='hdr0-aes-gcm-128'):
+    # Make sure we accept the ACK for the SPI before we seal with the bad assoc
+    _check_data_outq(s, 0)
+
+    cfg.pspnl.tx_assoc({"dev-id": cfg.psp_dev_id,
+                        "version": version,
+                        "tx-key": tx,
+                        "sock-fd": s.fileno()})
+
+    data_len = _send_careful(cfg, s, 20)
+    _check_data_outq(s, data_len, force_wait=True)
+    _check_data_rx(cfg, 0)
+    _close_psp_conn(cfg, s)
+
+
+def data_send_bad_key(cfg):
+    """ Test send data with bad key """
+    s = _make_psp_conn(cfg)
+
+    rx_assoc = cfg.pspnl.rx_assoc({"version": 0,
+                                   "dev-id": cfg.psp_dev_id,
+                                   "sock-fd": s.fileno()})
+    rx = rx_assoc['rx-key']
+    tx = _spi_xchg(s, rx)
+    tx['key'] = (tx['key'][0] ^ 0xff).to_bytes(1, 'little') + tx['key'][1:]
+    __bad_xfer_do(cfg, s, tx)
+
+
+def data_send_disconnect(cfg):
+    """ Test socket close after sending data """
+    with _make_psp_conn(cfg) as s:
+        assoc = cfg.pspnl.rx_assoc({"version": 0,
+                                  "sock-fd": s.fileno()})
+        tx = _spi_xchg(s, assoc['rx-key'])
+        cfg.pspnl.tx_assoc({"version": 0,
+                          "tx-key": tx,
+                          "sock-fd": s.fileno()})
+
+        data_len = _send_careful(cfg, s, 100)
+        _check_data_rx(cfg, data_len)
+
+        s.shutdown(socket.SHUT_RDWR)
+        s.close()
+
+
+def data_stale_key(cfg):
+    """ Test send on a double-rotated key """
+
+    s = _make_psp_conn(cfg)
+    try:
+        rx_assoc = cfg.pspnl.rx_assoc({"version": 0,
+                                     "dev-id": cfg.psp_dev_id,
+                                     "sock-fd": s.fileno()})
+        rx = rx_assoc['rx-key']
+        tx = _spi_xchg(s, rx)
+
+        cfg.pspnl.tx_assoc({"dev-id": cfg.psp_dev_id,
+                          "version": 0,
+                          "tx-key": tx,
+                          "sock-fd": s.fileno()})
+
+        data_len = _send_careful(cfg, s, 100)
+        _check_data_rx(cfg, data_len)
+        _check_data_outq(s, 0)
+
+        cfg.pspnl.key_rotate({"id": cfg.psp_dev_id})
+        cfg.pspnl.key_rotate({"id": cfg.psp_dev_id})
+
+        s.send(b'0123456789' * 200)
+        _check_data_outq(s, 2000, force_wait=True)
+    finally:
+        _close_psp_conn(cfg, s)
+
+
 def psp_ip_ver_test_builder(name, test_func, psp_ver, ipver):
     """Build test cases for each combo of PSP version and IP version"""
     def test_case(cfg):
-- 
2.47.3


