Return-Path: <netdev+bounces-226535-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05946BA1808
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 23:18:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D99CD741CF2
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 21:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D0E322A30;
	Thu, 25 Sep 2025 21:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BEgcTdVV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD62322A15
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 21:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758835019; cv=none; b=pgncP4eSZhG2bRUudHLDjANAqCql1ObJmOHw+Tcnpe1I+8y9lgggtjaTJPCqar3dXzQupmnEWR9+Uh4sSzvhLY+iiH6MYQYRw4el7wWJM4M7LiMqe7Xq86pSH2VrLT8oAbLlhTdlO9kseiZV2OOYmR/6XOkvjlf6yOvusxcTBdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758835019; c=relaxed/simple;
	bh=UR2g2L/dn248+KAjuC7/6A+sOSuT+cFn2zsAUhnx6Go=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kfg+pDnsaq7ii46267JPL/pTe6H3hp4Zb0D3Ihe+WETFul8mmZ650KHx8ZSqGw9/l+qmL0aElWMiwof4qDwHr5Fn/XnTG+W6D9fQdh8DJ7gfO2hMGdzMY+abq0jPDIxhB+De4x7s29JwITU8LtMOh6zv46gbcE6z1ChYYW7/eIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BEgcTdVV; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-71d603a269cso13759377b3.1
        for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 14:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758835017; x=1759439817; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7O4aK1TwScVZuzbSfRb2GDWE+wxfFzGH5C/YNiWtLSA=;
        b=BEgcTdVVhQCPDp2Mzv7TtwiSKzP82kNFzR4Hi/lFSA4fqZ/AbecHl7mEptU+HCLfAb
         vACi81Z8r54GblIezTVSl8a9sCnxs7BLga8/XB5Vsn/FFpZmI6yguWKmagmqjN2AN5gV
         c9f/QhpKXhjREZOJZ8l2PguvNSO/z6TNkgF5p9dLZ5Y8I/87Tydc0r9nh7uqL1JfPGIv
         gXQpT8DRA6fzscdzZUM+QTL0qN4bLLs3Fx/accJk0GIug7eigojCvHSaMpPKr25ow+XK
         dWjVe0Du6G/FLR3MgSAT++W9tCrIsA8xbJg4Ijn/rEDk2zMio8fJ6h+HxzNLhsf5+ltz
         sOFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758835017; x=1759439817;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7O4aK1TwScVZuzbSfRb2GDWE+wxfFzGH5C/YNiWtLSA=;
        b=qw8qJ8vEComkF4seMNLHtYwvW65K5KhK802Qi2xsmmOEgRcccdZHHV972R3D+QzYRl
         r6UlKBG/I5SvtHm3bqznQ1fbaTf+hYw8yqHab2PiEGWePXzekE4FVTDD3MOWsypnNzsZ
         sPnUW+h87rlvzonfU0ZovbXjP122Pe7nA4pRarymZXuC8Qbh7Uka8ujD52sXWp7RPYah
         hrZxVj3jsHkTEAwEnprpaHMPP8eKWhY7MKrkMNcIbwcUygoJDK4rZuDiisAZuCZjWiCX
         K1BBJLERt1RKKUO+KwBg93poEn8KGPkCVnUJAetjfioDbkSXkutgQFWwiG1arKpFaLtg
         CYAw==
X-Forwarded-Encrypted: i=1; AJvYcCXyhUkQe7G0LiKsSA1/rLUbt8zp8pz41wqBSvV5rBRQCfoeFeQsKU+hljCGdxRaexmw/KFWD9U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfO6fmFdKSuiKMKb6Y15CmETAnKV5ksvEosC4vTDPgoX+RFQ52
	FE3Uo8rjqmWsLYRKcLQ1RLJVS68p4zcVsmzl5fd3CmOsuMukzDGtgvpU
X-Gm-Gg: ASbGncuEqIU2vgBA67vhn3Aj5So+yLNUIEhSGsgsTQxH1WC1YYaxUXEqHNDi+lM6+1b
	6KIkztgqXAD4vFb33Vn3bh/U7zCm0sO+o6PaAJw5xxBhmD8LJAbImlE9RVdY+7CKZoi3NLE8Yb8
	CpGpw/phIOaeMTwHKnFwHYPqTEVc9MzJ5EcrOg3+R5pc9rMpBjgKYZajhTvi7wbzbU+vutxRIXL
	9FDSlilKRl25B4dEXAaCObvA5L9c5PkjBqig9O0Brb0E02l1ce42CRWnMlDy35s2UZgimafJJhC
	SPzQ//ZwbosbqXx8HS3Obw5M/tzj6+OfX+JjfkfC8Nd4cAMEzXNPgifbXkSVFUb8IqraPS4c5Bh
	DZMw1r6VnHHwW/aymwA9x
X-Google-Smtp-Source: AGHT+IGRzlyt8EOriw2alMhz6U5/DUT7KIrK/VXzyG7iQlFSifXMuchqhD1KYBpzmW3hoJqtKulNtw==
X-Received: by 2002:a05:690c:930c:20b0:729:a1ee:9bd8 with SMTP id 00721157ae682-76403422deamr47063577b3.36.1758835016863;
        Thu, 25 Sep 2025 14:16:56 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:13::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-765c91e01fesm7273867b3.70.2025.09.25.14.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 14:16:56 -0700 (PDT)
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
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next v2 6/8] selftests: drv-net: psp: add connection breaking tests
Date: Thu, 25 Sep 2025 14:16:42 -0700
Message-ID: <20250925211647.3450332-7-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250925211647.3450332-1-daniel.zahka@gmail.com>
References: <20250925211647.3450332-1-daniel.zahka@gmail.com>
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
 tools/testing/selftests/drivers/net/psp.py | 90 +++++++++++++++++++++-
 1 file changed, 89 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/psp.py b/tools/testing/selftests/drivers/net/psp.py
index b4d97a9a5fbc..f9647371b791 100755
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
@@ -99,6 +103,16 @@ def _check_data_rx(cfg, exp_len):
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
 #
 # Test cases
 #
@@ -324,6 +338,80 @@ def _data_basic_send(cfg, version, ipver):
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
@@ -374,7 +462,7 @@ def main() -> None:
 
                 if cfg.psp_dev_id is not None:
                     ksft_run(cases=cases, globs=globals(),
-                             case_pfx={"dev_", "assoc_"},
+                             case_pfx={"dev_", "data_", "assoc_"},
                              args=(cfg, ))
                 else:
                     ksft_pr("No PSP device found, skipping all tests")
-- 
2.47.3


