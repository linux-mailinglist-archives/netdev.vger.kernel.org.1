Return-Path: <netdev+bounces-260666-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2BiPJZ0rnmmVTwQAu9opvQ
	(envelope-from <netdev+bounces-260666-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 23:52:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F33B318DB2A
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 23:52:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF67131006E1
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 22:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD1EB34C145;
	Tue, 24 Feb 2026 22:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O1CdwjPI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F4F34D4FA
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 22:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771973225; cv=none; b=fRKhhlM3tWPVbhMLowuu4AEfEnfPhoYUnItBJPUg2hyViF2HZ2EE90u0x9Z+fRD87ukseu5wR1gvEhLC6AZwsHsTMDKm5LlYMg29HQYCgVJmfan8EO7f4c/8omYoll2bFyQzMijtic6dbuE/1KqMQ1XS+sUeNT6/60O9KH+DDbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771973225; c=relaxed/simple;
	bh=kALg13wZu04r2k8eCA7cv7uYIYixHQ2BbgkbO8nYIXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S+5wa66projDwY35hhAtuZQPOUVjLOEx5zAoO+cRQ/oYFaYt0hqn2gb0m/HKjDg9a78Da0JaAI9VvwAdjlorK+CDJSS0kqgTqWjfkXOmeLVW6mhi6/cZa2tOF3eYTxiHZ6FZyltwEOZhoCCwn3uwWpWOaYg6eJwmzLZQotyUIEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O1CdwjPI; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7d4be7c4ebeso3846661a34.1
        for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 14:47:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771973222; x=1772578022; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=csuXz/5RrsjgkIQ/6OJbBlQAwM7ZWgpZ3ivhYSSPtBs=;
        b=O1CdwjPI9pnnk2LvXZ2uW+tY/C3TDx4KhO/gMZE5pyUNRxyevIbJ7kDKsGXRmDRS7/
         SejXWz1t2bOUxFqbshN7k2fbAgcsFf8TP5calsqmm8hkxzGwSZlqpJf7rgcdlwxEhMXy
         bNwiLqKIBmr8E4l+bYHDn4KlAMFDUMrujJdQ1hr3TiRJWQoRnUqlEpBf+dPC2OIbSCza
         LSTgP/j8pV+6eZug03wV0ZbLZI7Sh2ZviiZ25UnJI1LWNgy5MVgxwc1A+nYzyLdGjxEL
         KE/f2wI10Qcs3CLKWm/qPhyJh+ivqJIb2qYNiXMmlPPtka8VyGIscU2qh7U4mPFk9OVa
         P7XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771973222; x=1772578022;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=csuXz/5RrsjgkIQ/6OJbBlQAwM7ZWgpZ3ivhYSSPtBs=;
        b=aq+j878nkl7QiOa2wlBrEABpIyA38Y6nXeIP+TgItK3+2q8eVbjLWBOy9xhzcoQWtQ
         llXyEQXA2ErpxDBMHdmkSaO338su5RETxzM004uYs+RJ8FdW1RwwszZb9TTBl6yaeddK
         vt+52v259E3nLXtR3lKrm95R409e6j+oTvG2DHjdKmoqo0p8jI9Rm0u8fS0wbw0wXV/N
         0RcwRMqvYk8NOsUI1Fgzyb/rhGX7yPZ7JDmgwB4Yr9tD3yOeiQZxhQ345Fq6zCQVOuVE
         82NfnGGyhUn56PWuYvBpysgsD06leZaOWT80Je/Yks8eRSGPeWpSGnEdKOUBm804Fsnt
         dHYA==
X-Forwarded-Encrypted: i=1; AJvYcCVwPC0LtrzN86g3Rr/jDh2NKEleULxCqyE/KAaFNnGWxTV4owqGzmlBnDTvl3BNKJnFPhD/X2E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVNqqfKnUByhCWFMzPdLekOLtwa4DTArv7l71eFtt/59oZ5PA7
	g8JABkHN5dcX0C7ZjfHDp1Db5fQA/zktzbURh5MyJuyfZaBHJfCtF19M
X-Gm-Gg: AZuq6aJigJXMl1G3g4/howKpj22H/FkdUxRGpqzia3Hj5fz45aMEcRlIJ5R7GKdx/lK
	lHasJz4l8VCpLcidsFMDvzJtOeZtvIbVPFEGwl63ggubwr4Im5WrboE7bDqodemtcwX9AhfJyYs
	KmrYBXW6ee2nS/2uoLfvgn1rdzs6iipeVL6v0Ny53FjY/nsRNnk0Th+AUBwjJWq78/AwI+dLzCn
	/u201kAW95Q7/c9nCO/qn0yY1yYu5XUZdhCH8ItsCp8uWgiURZFjCLD+7Q+FTyQuFzYFc6UYJ+A
	VvRLmgLagnSM+xAjds8OEqx8g+EpS8kDbmFdZNbfKo81Kh2gUvsueV67JabuOdPh8RPGohseaMF
	vuD9Ec+MSK1ELcunC8jZYgiUDWu7Gxswfwafv/ELCNP8KtqqXVHoNzODeXvV4juqJzPC4NbiLEG
	TtB7eaP0zdrs4OHYnPEeFMYBnK6jMT7CNDeSRbs7M=
X-Received: by 2002:a05:6830:6aa3:b0:7cf:d1e2:d386 with SMTP id 46e09a7af769-7d52bf51c6cmr10256909a34.33.1771973222081;
        Tue, 24 Feb 2026 14:47:02 -0800 (PST)
Received: from localhost ([2a03:2880:12ff:1::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d52cf78503sm10903924a34.3.2026.02.24.14.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 14:47:01 -0800 (PST)
From: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>
To: "David S . Miller" <davem@davemloft.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Daniel Zahka <daniel.zahka@gmail.com>,
	Carolina Jubran <cjubran@nvidia.com>,
	Gal Pressman <gal@nvidia.com>,
	David Wei <dw@davidwei.uk>,
	Mohsin Bashir <mohsin.bashr@gmail.com>,
	Nimrod Oren <noren@nvidia.com>,
	Breno Leitao <leitao@debian.org>,
	Petr Machata <petrm@nvidia.com>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next 1/2] selftests: net: py: Add rand_ports helper method
Date: Tue, 24 Feb 2026 14:46:58 -0800
Message-ID: <20260224224659.1507082-2-dimitri.daskalakis1@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260224224659.1507082-1-dimitri.daskalakis1@gmail.com>
References: <20260224224659.1507082-1-dimitri.daskalakis1@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-260666-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,google.com,kernel.org,redhat.com,fomichev.me,gmail.com,nvidia.com,davidwei.uk,debian.org,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[dimitridaskalakis1@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.979];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lib.py:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F33B318DB2A
X-Rspamd-Action: no action

Certain tests need a unique set of ports. Successive calls to the
existing rand_port method may return a duplicate port, resulting in test
flakiness. The new helper keeps sockets open while building a list of
ephemeral ports, thus the kernel enforces their uniqueness.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>
---
 .../drivers/net/hw/lib/py/__init__.py         |  5 ++--
 .../selftests/drivers/net/lib/py/__init__.py  |  4 ++--
 .../testing/selftests/net/lib/py/__init__.py  |  5 ++--
 tools/testing/selftests/net/lib/py/utils.py   | 24 ++++++++++++++++---
 4 files changed, 29 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py b/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
index d5d247eca6b7..1971577d47e9 100644
--- a/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
+++ b/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
@@ -22,7 +22,8 @@ try:
         NlError, RtnlFamily, DevlinkFamily, PSPFamily
     from net.lib.py import CmdExitFailure
     from net.lib.py import bkg, cmd, bpftool, bpftrace, defer, ethtool, \
-        fd_read_timeout, ip, rand_port, wait_port_listen, wait_file, tool
+        fd_read_timeout, ip, rand_port, rand_ports, wait_port_listen, \
+        wait_file, tool
     from net.lib.py import KsftSkipEx, KsftFailEx, KsftXfailEx
     from net.lib.py import ksft_disruptive, ksft_exit, ksft_pr, ksft_run, \
         ksft_setup, ksft_variants, KsftNamedVariant
@@ -36,7 +37,7 @@ try:
                "NlError", "RtnlFamily", "DevlinkFamily", "PSPFamily",
                "CmdExitFailure",
                "bkg", "cmd", "bpftool", "bpftrace", "defer", "ethtool",
-               "fd_read_timeout", "ip", "rand_port",
+               "fd_read_timeout", "ip", "rand_port", "rand_ports",
                "wait_port_listen", "wait_file", "tool",
                "KsftSkipEx", "KsftFailEx", "KsftXfailEx",
                "ksft_disruptive", "ksft_exit", "ksft_pr", "ksft_run",
diff --git a/tools/testing/selftests/drivers/net/lib/py/__init__.py b/tools/testing/selftests/drivers/net/lib/py/__init__.py
index 8b75faa9af6d..5872d114f142 100644
--- a/tools/testing/selftests/drivers/net/lib/py/__init__.py
+++ b/tools/testing/selftests/drivers/net/lib/py/__init__.py
@@ -22,7 +22,7 @@ try:
         NlError, RtnlFamily, DevlinkFamily, PSPFamily
     from net.lib.py import CmdExitFailure
     from net.lib.py import bkg, cmd, bpftool, bpftrace, defer, ethtool, \
-        fd_read_timeout, ip, rand_port, wait_port_listen, wait_file
+        fd_read_timeout, ip, rand_port, rand_ports, wait_port_listen, wait_file
     from net.lib.py import KsftSkipEx, KsftFailEx, KsftXfailEx
     from net.lib.py import ksft_disruptive, ksft_exit, ksft_pr, ksft_run, \
         ksft_setup, ksft_variants, KsftNamedVariant
@@ -34,7 +34,7 @@ try:
                "NlError", "RtnlFamily", "DevlinkFamily", "PSPFamily",
                "CmdExitFailure",
                "bkg", "cmd", "bpftool", "bpftrace", "defer", "ethtool",
-               "fd_read_timeout", "ip", "rand_port",
+               "fd_read_timeout", "ip", "rand_port", "rand_ports",
                "wait_port_listen", "wait_file",
                "KsftSkipEx", "KsftFailEx", "KsftXfailEx",
                "ksft_disruptive", "ksft_exit", "ksft_pr", "ksft_run",
diff --git a/tools/testing/selftests/net/lib/py/__init__.py b/tools/testing/selftests/net/lib/py/__init__.py
index f528b67639de..a584e7f806a4 100644
--- a/tools/testing/selftests/net/lib/py/__init__.py
+++ b/tools/testing/selftests/net/lib/py/__init__.py
@@ -13,7 +13,8 @@ from .ksft import KsftFailEx, KsftSkipEx, KsftXfailEx, ksft_pr, ksft_eq, \
 from .netns import NetNS, NetNSEnter
 from .nsim import NetdevSim, NetdevSimDev
 from .utils import CmdExitFailure, fd_read_timeout, cmd, bkg, defer, \
-    bpftool, ip, ethtool, bpftrace, rand_port, wait_port_listen, wait_file, tool
+    bpftool, ip, ethtool, bpftrace, rand_port, rand_ports, wait_port_listen, \
+    wait_file, tool
 from .ynl import NlError, YnlFamily, EthtoolFamily, NetdevFamily, RtnlFamily, RtnlAddrFamily
 from .ynl import NetshaperFamily, DevlinkFamily, PSPFamily
 
@@ -25,7 +26,7 @@ __all__ = ["KSRC",
            "ksft_run", "ksft_exit", "ksft_variants", "KsftNamedVariant",
            "NetNS", "NetNSEnter",
            "CmdExitFailure", "fd_read_timeout", "cmd", "bkg", "defer",
-           "bpftool", "ip", "ethtool", "bpftrace", "rand_port",
+           "bpftool", "ip", "ethtool", "bpftrace", "rand_port", "rand_ports",
            "wait_port_listen", "wait_file", "tool",
            "NetdevSim", "NetdevSimDev",
            "NetshaperFamily", "DevlinkFamily", "PSPFamily", "NlError",
diff --git a/tools/testing/selftests/net/lib/py/utils.py b/tools/testing/selftests/net/lib/py/utils.py
index 85884f3e827b..487350fb957c 100644
--- a/tools/testing/selftests/net/lib/py/utils.py
+++ b/tools/testing/selftests/net/lib/py/utils.py
@@ -263,9 +263,27 @@ def rand_port(stype=socket.SOCK_STREAM):
     """
     Get a random unprivileged port.
     """
-    with socket.socket(socket.AF_INET6, stype) as s:
-        s.bind(("", 0))
-        return s.getsockname()[1]
+    return rand_ports(1, stype)[0]
+
+
+def rand_ports(count, stype=socket.SOCK_STREAM):
+    """
+    Get a unique set of random unprivileged ports.
+    """
+    sockets = []
+    ports = []
+
+    try:
+        for _ in range(count):
+            s = socket.socket(socket.AF_INET6, stype)
+            sockets.append(s)
+            s.bind(("", 0))
+            ports.append(s.getsockname()[1])
+    finally:
+        for s in sockets:
+            s.close()
+
+    return ports
 
 
 def wait_port_listen(port, proto="tcp", ns=None, host=None, sleep=0.005, deadline=5):
-- 
2.47.3


