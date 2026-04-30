Return-Path: <netdev+bounces-282863-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CPsEDJNZ82lfzwEAu9opvQ
	(envelope-from <netdev+bounces-282863-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 15:30:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CEBAF4A37A1
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 15:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C22863051BE8
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 13:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B3EC4266BC;
	Thu, 30 Apr 2026 13:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UVEZ26iL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B0C426D05
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 13:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777555710; cv=none; b=qR4kyzORJu6XQMzbx5+02ClA/Oy3bQqPTjZ7uegcuswm8/wCJP3YB70GkVAC7lM0QMB6+1bI8AT7X+ocN+TWYQRRo1Q0dKIY+efjaohRoY2j2nv7pSqGK/Df+YLxHl7xD0fIzyiX5gjevelhmsNK56mJQ3EGaXuyrOzoHzRAmX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777555710; c=relaxed/simple;
	bh=gB7P3eJLm7f6gdrmg5tjypKWSxIGKIEJjikDtq+N/PI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bq/5Gg8Jr/fzu7YbX8vOak7xYTeRNaBBU1hji7DV2pIXO1ywGHRlQBvftZ0KQsAm30SjnnHSyQoTeOqeTMngWDOFqfL6mxWr+e6FZbZ426NrPalerab/KaspQKpBRMh+6bskT3f1mUVVpXEHX9HwUcFOemOOkXhjooYL2kCPZ3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UVEZ26iL; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-79827d28fc4so9363267b3.1
        for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 06:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777555708; x=1778160508; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8/f7yMoR7muS6QO32XzrM5AFad/LSJYKKcs2Y+rabA8=;
        b=UVEZ26iLtjQEPQJ4/4cQ6g1KShD3BKIUrbaPQdI52cIHQJljV+wfddJS2saXneEMtD
         mdbBbXBt5po24KMjChpV5x2UnJjmRGBSrFhxy+8ZG++eJhQKWtiGdZ5hrmtXU8F9YQ6c
         kyyV8TBaTY8FECimCBKQEaIUu6C74Ljq3WiLF7ywEJL7ObCWVE0mokYjJ7HsdS4wGBou
         QLUA3xvCpuINcdIFs+IkrbyFV7DsF4KVRnrz02aInFPKI8EAwtf61Qt8RV+P3He5LJc3
         Oi9DvltCOldQAb2VFCLg9zqOaQg3OofmGzonDXpZeKiteVWTwnPd+csis/SnHEp2sKJr
         oDEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777555708; x=1778160508;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8/f7yMoR7muS6QO32XzrM5AFad/LSJYKKcs2Y+rabA8=;
        b=nG2g0MtxlAcK7E3aHaIRacOsZufNmsZvcKlxm3WI67dMiGUTvKiTECGXvYV14oIbWm
         60kmoiyMNaCZw7N+IDSD3yNeb8FU334+zgvO4ZV1H1U6krwb73IRlcA5lFjx4ze9aCwP
         aikYerMbPZkR964fJBJwePvX4+vVd4Z4wZrsqWvMuSIlV3T0US1NdHIljJl49wXKtcfb
         4FEGXdnPIuDd66LqJdKhCJAyGawAoTRJDGZYbVL1ttda+KPkC1oO5PS3g6PjRv+M0Of7
         mXevRfW/pLS+dgjg1/soOP31UIZf+y5gL5h8f77UKJwLC1cZXzMTvyEng7zxOIUL4Qzb
         RXPQ==
X-Gm-Message-State: AOJu0Yx/37PSKz23aPbm2RaAlH8SQ9xvnG5EQOJEFqL8sV6z0ZbukjZn
	8BPN5pYC5ZPKGdvYvZFz2KNRHvVPDyI2tMHZbrg3A5naHOEuSXNe1u2gbH0mSw==
X-Gm-Gg: AeBDies1vjytOWgOydW7j71Gzhpey7PpmYD7aP8/YbqsOExgmuRNZdxFvvgFpRnVGzB
	ozDKACiFG9C1dsyfdfcAfaPG2qnt6rZLrPUTwdLxCrvGJ+EZeDUZpHrkt1kOmpIif9kEzGn+DSr
	+fMiqbiVxqfPqQT3ItRF2wxeZ51dEkAAFPdtFVzCiNX/GFGYNam8yzPWnU2/T6Vnxl1+Zyrt0Hd
	7Dy+5exUMwgkrkq0B1j+HQvv0vdaTSoANlP0rk6cp+eRrMyCdgHS67x7Wsod/Sk3CyTn+vlD1mT
	PBeLl7Xxf+DMiTgtu6sCiZzLTcIXg3eL6WDYKTF/UQj9R6Of2ERvP+VDKFl2Jgd4tJE3H7jIQZO
	IuoJg2dwnRCPRdvFq7puQ7fky6ZhrhJo+jdJMnXLrVMEgfxDWZ/IKRB7gE1Y5CkT+2SeV3btOV/
	0N+7rzUqc6e3Fw3792770Eai10/rEphsS0Y4sxlONREiKtKkBijLJEaakl2t3A2/+/EKdJSISgg
	1ItA719euOLsiS2A6Cm7Zv3cqag/5Vwg/q17Q==
X-Received: by 2002:a05:690c:7:b0:7b7:29e4:7dd2 with SMTP id 00721157ae682-7bd548fe510mr23600947b3.40.1777555707597;
        Thu, 30 Apr 2026 06:28:27 -0700 (PDT)
Received: from willemb.c.googlers.com.com (172.235.85.34.bc.googleusercontent.com. [34.85.235.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd54b332fcsm8592957b3.16.2026.04.30.06.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 06:28:26 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-kselftest@vger.kernel.org,
	shuah@kernel.org,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v6 2/3] selftests: net: py: add tc utility
Date: Thu, 30 Apr 2026 09:28:05 -0400
Message-ID: <20260430132820.1944517-3-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
In-Reply-To: <20260430132820.1944517-1-willemdebruijn.kernel@gmail.com>
References: <20260430132820.1944517-1-willemdebruijn.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CEBAF4A37A1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282863-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lib.py:url]

From: Willem de Bruijn <willemb@google.com>

Add a wrapper similar to existing ip, ethtool, ... commands.

Tc takes a slightly different syntax. Account for that.

The first user is the next patch in this series, converting so_txtime
to drv-net. Pacing offload is supported by selected qdiscs only.

Signed-off-by: Willem de Bruijn <willemb@google.com>
---
 .../testing/selftests/drivers/net/lib/py/__init__.py |  5 +++--
 tools/testing/selftests/net/lib/py/__init__.py       |  4 ++--
 tools/testing/selftests/net/lib/py/utils.py          | 12 +++++++++++-
 3 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/lib/py/__init__.py b/tools/testing/selftests/drivers/net/lib/py/__init__.py
index 2b5ec0505672..09aac4ce67bc 100644
--- a/tools/testing/selftests/drivers/net/lib/py/__init__.py
+++ b/tools/testing/selftests/drivers/net/lib/py/__init__.py
@@ -23,7 +23,8 @@ try:
         NlError, RtnlFamily, DevlinkFamily, PSPFamily, Netlink
     from net.lib.py import CmdExitFailure
     from net.lib.py import bkg, cmd, bpftool, bpftrace, defer, ethtool, \
-        fd_read_timeout, ip, rand_port, rand_ports, wait_port_listen, wait_file
+        fd_read_timeout, ip, rand_port, rand_ports, tc, wait_port_listen, \
+        wait_file
     from net.lib.py import bpf_map_set, bpf_map_dump, bpf_prog_map_ids
     from net.lib.py import KsftSkipEx, KsftFailEx, KsftXfailEx
     from net.lib.py import ksft_disruptive, ksft_exit, ksft_pr, ksft_run, \
@@ -36,7 +37,7 @@ try:
                "NlError", "RtnlFamily", "DevlinkFamily", "PSPFamily", "Netlink",
                "CmdExitFailure",
                "bkg", "cmd", "bpftool", "bpftrace", "defer", "ethtool",
-               "fd_read_timeout", "ip", "rand_port", "rand_ports",
+               "fd_read_timeout", "ip", "rand_port", "rand_ports", "tc",
                "wait_port_listen", "wait_file",
                "bpf_map_set", "bpf_map_dump", "bpf_prog_map_ids",
                "KsftSkipEx", "KsftFailEx", "KsftXfailEx",
diff --git a/tools/testing/selftests/net/lib/py/__init__.py b/tools/testing/selftests/net/lib/py/__init__.py
index 7c81d86a7e97..64a8c1ed4950 100644
--- a/tools/testing/selftests/net/lib/py/__init__.py
+++ b/tools/testing/selftests/net/lib/py/__init__.py
@@ -14,7 +14,7 @@ from .netns import NetNS, NetNSEnter
 from .nsim import NetdevSim, NetdevSimDev
 from .utils import CmdExitFailure, fd_read_timeout, cmd, bkg, defer, \
     bpftool, ip, ethtool, bpftrace, rand_port, rand_ports, wait_port_listen, \
-    wait_file, tool
+    wait_file, tool, tc
 from .bpf import bpf_map_set, bpf_map_dump, bpf_prog_map_ids
 from .ynl import NlError, NlctrlFamily, YnlFamily, \
     EthtoolFamily, NetdevFamily, RtnlFamily, RtnlAddrFamily
@@ -29,7 +29,7 @@ __all__ = ["KSRC",
            "NetNS", "NetNSEnter",
            "CmdExitFailure", "fd_read_timeout", "cmd", "bkg", "defer",
            "bpftool", "ip", "ethtool", "bpftrace", "rand_port", "rand_ports",
-           "wait_port_listen", "wait_file", "tool",
+           "wait_port_listen", "wait_file", "tool", "tc",
            "bpf_map_set", "bpf_map_dump", "bpf_prog_map_ids",
            "NetdevSim", "NetdevSimDev",
            "NetshaperFamily", "DevlinkFamily", "PSPFamily", "NlError",
diff --git a/tools/testing/selftests/net/lib/py/utils.py b/tools/testing/selftests/net/lib/py/utils.py
index ef31c0ba47fc..165adf33e1b5 100644
--- a/tools/testing/selftests/net/lib/py/utils.py
+++ b/tools/testing/selftests/net/lib/py/utils.py
@@ -224,7 +224,10 @@ class defer:
 def tool(name, args, json=None, ns=None, host=None):
     cmd_str = name + ' '
     if json:
-        cmd_str += '--json '
+        if name == 'tc':
+            cmd_str += '-json '
+        else:
+            cmd_str += '--json '
     cmd_str += args
     cmd_obj = cmd(cmd_str, ns=ns, host=host)
     if json:
@@ -242,6 +245,13 @@ def ip(args, json=None, ns=None, host=None):
     return tool('ip', args, json=json, host=host)
 
 
+def tc(args, json=None, ns=None, host=None):
+    """ Helper to call tc with standard set of optional args. """
+    if ns:
+        args = f'-netns {ns} ' + args
+    return tool('tc', args, json=json, host=host)
+
+
 def ethtool(args, json=None, ns=None, host=None):
     return tool('ethtool', args, json=json, ns=ns, host=host)
 
-- 
2.54.0.545.g6539524ca2-goog


