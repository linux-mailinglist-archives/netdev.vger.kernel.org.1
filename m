Return-Path: <netdev+bounces-240264-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D6E01C71FD8
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 04:30:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 872642C556
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 03:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1088B2FD1CA;
	Thu, 20 Nov 2025 03:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="u07xJD/4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D2E29B20D
	for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 03:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763609426; cv=none; b=Y0O2TxgoEe5aqT2Nh1baeyPM5zQ6rY83SLh9uaZkK6gOlc845ZSpCIz3XrTs+AFTIJt27WHLlfXzYgdPAgnE7tduhEnSPxMSf+4becAHp+t+KwKMozjioCIo4AZFdcYjKfbcgUxO6+8byN2y77uj7ufPoKyVxkSuEuJqG6+Zovc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763609426; c=relaxed/simple;
	bh=gse6CQrZR5o+dCWzVSEOPuKdxSb9RPCLCV9xcx881Bk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dMN9mvrBJEHDb2J8Ih7FRZTNy+8iVVOiXmVosVqgKJkmESb8K+azYm90Pd/VLoKvu506UmxnHoMPJO5j3ZJiSkfNWc8UFAZtfYqpS/R2DsOdmb2c6jVIB4mqYaVjIQGC3KSmRcG+N5nSQTIvgLLPlnH7oaeaYz82e2P1t2E715s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=u07xJD/4; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-6574ace76dbso157976eaf.3
        for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 19:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1763609423; x=1764214223; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6yGkDY9Gz3qxcQO9P+o+Qi8S0NeuXxWQoJidPzE3fuQ=;
        b=u07xJD/4C/tGYpUer23q10wgJAGNQrn21xZ33+rX+zMh2hwcq/R1m4O+OdhOG0/Pzr
         B/zJE86vC0eBrNI7SVsQU55AQmVcgGdEYBfJeKAN8W3APljPgoRY4edwZ1k/1FxSEYYq
         Se3/Y97hywpn3Ov2TgRUISZHVauwb8jUo6FemobcckfBNgKEwkdNQRVdeCBcAEuanzGS
         XW2yzLI8L613Yw5uE3tTycp8f/a1lpWqoAi2q4nJjVwCEGqewJROcyGUBWrvIts38VTA
         cRicFt4fM257uDRJsNr2pQnFmJ14Tm4i8HIhVmsfxwvE+hTofCQrgGPjc7fWN/AxQaZc
         EnbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763609423; x=1764214223;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6yGkDY9Gz3qxcQO9P+o+Qi8S0NeuXxWQoJidPzE3fuQ=;
        b=eUHFY5Mpx3ZzEltC0Gp+DXHg3ApIpr21jNitOWNAFcbh9h/XD/ThBDeBz6AOk5SzcN
         A6b8EzEt7xNQ3M32GTEbmps/MPUMsiB5CTKa8tEzRou+DfZWk7u0oZhOAbI+QCDS3on+
         OFTRyeagGug+PTzOgsmvw8sYAfdPTf7kTtgS+mHObD+v22M+IiqHawuz8LEuKbBPzQvQ
         riEP/JSaCMPyC1WUmDGMNWdn0SnCYLqQ7Ew1tZoQ9K4usnfjtD/pgNBul+xkUxDEeIn8
         RzvP2EmhQXRJZOazoeINJEcfui1N6yF2C2bOyuMl6nMJTcAa1fvv4vMWARIFNsz12+My
         IpkA==
X-Gm-Message-State: AOJu0YxzpPVVELfw0IFOv+CAODj6dQi5qCCYFm723LjdXWfXjhU9awom
	IfDpgkHZJ0XuAZBVNyhw1A5BgAmsUpsbCvDE9Nyb7qqUgZvuZgaMj1gCmAS57kFQpGz2X3i5H4a
	W/lIb
X-Gm-Gg: ASbGncscfsU/DGYMIeE6vPXBfPWgoSs17h2zBk7gLjRRb6ua0IAeCoT1RFB2wPJL8be
	d53JHmK5bzm6sK632SyZI3OJlMByK7GDfnzNxSU17wHpNvD/PqdndYbkdG1eaXKRJ4jag6GgMEs
	tqGfXBvXGtxmHtu8MbwrpK/V3Vt9CZrHN6AuR5e2y9tAEO7kXCa1ZjyueY/XMlMEJD2m2SQQBpJ
	dAeg9ysyp+Ln6c1/18NKKRwCmlaJytYuhdmfk0jDUi73jD0gxslvEp7JoBJx0CsPLj+M7W9ffMy
	otUh2PouooiFK6Ah9/74idcG3VWkfbYafBqWgTO6S6dB4s0v2KS3Nn+6b6Ulwz8bxO7+/DGgnRf
	PzhUCfLSuxR98uK+Q71akII/mPBwzc0KCSPCQ6ik6IuCj4lt9RhVZ310cdp6/siNagLHykua6gZ
	NZnc1VzFei/1aAv4/vTdA2NFCTY41aKXX/phjy6dCV
X-Google-Smtp-Source: AGHT+IEh9gli6kvwQTPKyMD3Hy+KjVuyJPp9BNW508cVB4E2O7nWlaFKN0k2vs2g7zPnwSM4SOgoeg==
X-Received: by 2002:a05:6820:1c91:b0:654:faee:1077 with SMTP id 006d021491bc7-657849f10bbmr589509eaf.6.1763609423425;
        Wed, 19 Nov 2025 19:30:23 -0800 (PST)
Received: from localhost ([2a03:2880:12ff:9::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-65782b4c9f1sm455529eaf.11.2025.11.19.19.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 19:30:22 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH net-next v1 4/7] selftests/net: add rand_ifname() helper
Date: Wed, 19 Nov 2025 19:30:13 -0800
Message-ID: <20251120033016.3809474-5-dw@davidwei.uk>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251120033016.3809474-1-dw@davidwei.uk>
References: <20251120033016.3809474-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For upcoming netkit container datapath selftests I want to generate
randomised ifnames. Add a helper rand_ifname() to do this.

Signed-off-by: David Wei <dw@davidwei.uk>
---
 tools/testing/selftests/drivers/net/hw/lib/py/__init__.py | 5 +++--
 tools/testing/selftests/drivers/net/lib/py/__init__.py    | 5 +++--
 tools/testing/selftests/net/lib/py/__init__.py            | 5 +++--
 tools/testing/selftests/net/lib/py/utils.py               | 7 +++++++
 4 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py b/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
index 09f120be9075..f2f6d3eccc86 100644
--- a/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
+++ b/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
@@ -22,7 +22,8 @@ try:
         NlError, RtnlFamily, DevlinkFamily, PSPFamily
     from net.lib.py import CmdExitFailure
     from net.lib.py import bkg, cmd, bpftool, bpftrace, defer, ethtool, \
-        fd_read_timeout, ip, rand_port, wait_port_listen, wait_file
+        fd_read_timeout, ip, rand_port, wait_port_listen, wait_file, \
+        rand_ifname
     from net.lib.py import KsftSkipEx, KsftFailEx, KsftXfailEx
     from net.lib.py import ksft_disruptive, ksft_exit, ksft_pr, ksft_run, \
         ksft_setup
@@ -37,7 +38,7 @@ try:
                "CmdExitFailure",
                "bkg", "cmd", "bpftool", "bpftrace", "defer", "ethtool",
                "fd_read_timeout", "ip", "rand_port",
-               "wait_port_listen", "wait_file",
+               "wait_port_listen", "wait_file", "rand_ifname",
                "KsftSkipEx", "KsftFailEx", "KsftXfailEx",
                "ksft_disruptive", "ksft_exit", "ksft_pr", "ksft_run",
                "ksft_setup",
diff --git a/tools/testing/selftests/drivers/net/lib/py/__init__.py b/tools/testing/selftests/drivers/net/lib/py/__init__.py
index dde4e80811c7..8fb75725f558 100644
--- a/tools/testing/selftests/drivers/net/lib/py/__init__.py
+++ b/tools/testing/selftests/drivers/net/lib/py/__init__.py
@@ -22,7 +22,8 @@ try:
         NlError, RtnlFamily, DevlinkFamily, PSPFamily
     from net.lib.py import CmdExitFailure
     from net.lib.py import bkg, cmd, bpftool, bpftrace, defer, ethtool, \
-        fd_read_timeout, ip, rand_port, wait_port_listen, wait_file
+        fd_read_timeout, ip, rand_port, wait_port_listen, wait_file, \
+        rand_ifname
     from net.lib.py import KsftSkipEx, KsftFailEx, KsftXfailEx
     from net.lib.py import ksft_disruptive, ksft_exit, ksft_pr, ksft_run, \
         ksft_setup
@@ -35,7 +36,7 @@ try:
                "CmdExitFailure",
                "bkg", "cmd", "bpftool", "bpftrace", "defer", "ethtool",
                "fd_read_timeout", "ip", "rand_port",
-               "wait_port_listen", "wait_file",
+               "wait_port_listen", "wait_file", "rand_ifname",
                "KsftSkipEx", "KsftFailEx", "KsftXfailEx",
                "ksft_disruptive", "ksft_exit", "ksft_pr", "ksft_run",
                "ksft_setup",
diff --git a/tools/testing/selftests/net/lib/py/__init__.py b/tools/testing/selftests/net/lib/py/__init__.py
index 97b7cf2b20eb..f16cbc025bf2 100644
--- a/tools/testing/selftests/net/lib/py/__init__.py
+++ b/tools/testing/selftests/net/lib/py/__init__.py
@@ -12,7 +12,8 @@ from .ksft import KsftFailEx, KsftSkipEx, KsftXfailEx, ksft_pr, ksft_eq, \
 from .netns import NetNS, NetNSEnter
 from .nsim import NetdevSim, NetdevSimDev
 from .utils import CmdExitFailure, fd_read_timeout, cmd, bkg, defer, \
-    bpftool, ip, ethtool, bpftrace, rand_port, wait_port_listen, wait_file
+    bpftool, ip, ethtool, bpftrace, rand_port, wait_port_listen, wait_file, \
+    rand_ifname
 from .ynl import NlError, YnlFamily, EthtoolFamily, NetdevFamily, RtnlFamily, RtnlAddrFamily
 from .ynl import NetshaperFamily, DevlinkFamily, PSPFamily
 
@@ -25,7 +26,7 @@ __all__ = ["KSRC",
            "NetNS", "NetNSEnter",
            "CmdExitFailure", "fd_read_timeout", "cmd", "bkg", "defer",
            "bpftool", "ip", "ethtool", "bpftrace", "rand_port",
-           "wait_port_listen", "wait_file",
+           "wait_port_listen", "wait_file", "rand_ifname",
            "NetdevSim", "NetdevSimDev",
            "NetshaperFamily", "DevlinkFamily", "PSPFamily", "NlError",
            "YnlFamily", "EthtoolFamily", "NetdevFamily", "RtnlFamily",
diff --git a/tools/testing/selftests/net/lib/py/utils.py b/tools/testing/selftests/net/lib/py/utils.py
index cb40ecef9456..56546d796f6c 100644
--- a/tools/testing/selftests/net/lib/py/utils.py
+++ b/tools/testing/selftests/net/lib/py/utils.py
@@ -2,9 +2,11 @@
 
 import json as _json
 import os
+import random
 import re
 import select
 import socket
+import string
 import subprocess
 import time
 
@@ -238,6 +240,11 @@ def rand_port(stype=socket.SOCK_STREAM):
         return s.getsockname()[1]
 
 
+def rand_ifname():
+    dev = ''.join(random.choice(string.ascii_lowercase) for _ in range(6))
+    return dev + ''.join(random.choice(string.digits) for _ in range(2))
+
+
 def wait_port_listen(port, proto="tcp", ns=None, host=None, sleep=0.005, deadline=5):
     end = time.monotonic() + deadline
 
-- 
2.47.3


