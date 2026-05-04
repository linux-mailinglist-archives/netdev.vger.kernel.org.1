Return-Path: <netdev+bounces-283972-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MC/zEVHa+GnG2QIAu9opvQ
	(envelope-from <netdev+bounces-283972-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 19:41:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B3FFE4C2049
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 19:41:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0092E302331A
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 17:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CDE43E51D9;
	Mon,  4 May 2026 17:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oY5yEO2Y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A373E4C85
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 17:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777916469; cv=none; b=Qr+EF01ijdP135bEDyoUmKrC9iXCCv7FUmI6S8/xeDXbf7Ea75/ilyPPpyxv7HBrddN/gIUR4dqueX6v44CnbtnOnqMJ7azLMVYMpA3RDJIC8gXyJWx9lUWkQyrugNgJrzLLNjZ9ilVpsa6XrwNxCo57OjSSNZiMZSusV3mRLj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777916469; c=relaxed/simple;
	bh=ufkONH4lXdgrenYZU9xGx8aA3dUY2Vs/P/4JdsvRg+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fc0LfMrITdBaWul/f88qlX5AbPpU/6LoiKqvxgEAQSJpyipuoajrAVt1tahfQsuU6kOhlfniOyCPTQynx7QmWvhXvnTywWVGZyCLSpzvt/tna/tM5I4pBt2uSCXMmFrzUP/NX9F2C+9fdvNev6Kxdw+4gMaYHmQ0RRIXb5uuH5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oY5yEO2Y; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-7bd5c582c6cso40987187b3.1
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 10:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777916466; x=1778521266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZVl8pNWWJ1FZhRJZlr6BIN+M7SkdqpWm1WnyYftGcVM=;
        b=oY5yEO2Y1r8qJyJLft9tVECCiJ80oT56tXpDR9Vo2R9JHQT9vwrKeXwUWr56Rn1Ts1
         eLNqvAgQ4BKegWdOQhToOCpEs9VTZ7He75XUlPjIvb6T8/AA+COF1zjBOtbAGlXq3nx/
         OHD+En8gedA4Dnil8uiFK5htXOWOr6jI34UzLpvDU9I4C6FF1TGSG+AB12K59pEVLT1L
         10hPWjjk6uW9MRdfmAsdivmDlQHEf2O/gOaNIuPU80r8xQvCHzXxvCrXthIwE+jwaAke
         UegToVbmXD31VTE/vebP71+K2frD6DOZ1EkkowROcprOTgA3RthCNmzXlYW/CVIR1fwP
         CBAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777916466; x=1778521266;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZVl8pNWWJ1FZhRJZlr6BIN+M7SkdqpWm1WnyYftGcVM=;
        b=kWgBuJJuphHyS/eWMKZrm5pcVwK186pfNrQh5p2ZWNKakpLG1anr4O9XQrw7IBJ4Hs
         ILMKR8us/zAT+pDxLyMcz7E3/25bgueqZdYJHX1jD11u6w59zwK51Agz50yZxBjQXogA
         Gzh7/HKnHpOdyAyyHrSjBFWWh6EZfYlNpU7aK+7vkQYmsvimCfVNJNkblcZOe0mFQtox
         0BkTcYtkDM2B0uTDC327jeHxmYrBED8cNO5+k618/vFI0A/bfaoUkOAreQwbbQyGop2u
         C8ivS+Gb5L6CY9D3ow1Y/q9ZH8knU5E5umR3RtUllg31vsSbgtlBxZ8Z3e0zghF5zzRJ
         BIHA==
X-Gm-Message-State: AOJu0YyX3DAkMhngp1BiT0953LorcunJv/Z7HRCUUhSvT/tCoCnM1pF0
	6wLAE26W6aPcirb4zKlHjr8TDCJg09MNcoSKZWiCIdZVBXUKkSkoq1I8HGlpnw==
X-Gm-Gg: AeBDieux3pu8gHdSe8PNQI9IGyAuS3Ss64682sookHdMwCl5OsB033LC6a2orGhQzMF
	rqSguke3wLU1zgMUGN3oCrM3M75M9AtwDXfwBzpmcyN5uBhIyoEp7L2qqKFiug8roRob2iirxB8
	/sOqL/VxmtkBFk5wsqtVPJ5vdf/mOLqN2EwUa3I5or0wXoM/K1q7Ew6aTM17dqr2fX6l2yiRSGb
	/QGk3mzn+5OgZ4ByP8o/bwz/wD6IuL4nBEPx7OZN9Se4Tpz/RS/R5zUAkqYRYv/JDNJAadn0BRv
	mQwPDelFuFZYRtrfp7yd1rJo3y5Dg4LMxEAW1Q75ciEnXvHUA6eaipWNygXfruWgj84GsKuzuJP
	9705lR/U1QjH2kWWkPfndOKjsYBFH0t6lb7iIGBUZqJaHElNSpMMC56MYlRTZTroZphOObUTH8b
	2ltH+dJPZEZdE2aZRlpfenlfem6EQODeuKM8mvzOKpawsY2oAp3gYoPG65iG0Sz4u+wt/PSn1M8
	dkoVodfNC/vUU5mUhsQMcsxVZSRdRTcTrEVOzbHh3++bp0T
X-Received: by 2002:a05:690c:a01c:b0:7b8:bc4e:ac3 with SMTP id 00721157ae682-7bd77104b4emr103087397b3.26.1777916466466;
        Mon, 04 May 2026 10:41:06 -0700 (PDT)
Received: from willemb.c.googlers.com.com (172.235.85.34.bc.googleusercontent.com. [34.85.235.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd6685d0cbsm51551767b3.35.2026.05.04.10.41.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 10:41:06 -0700 (PDT)
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
Subject: [PATCH net-next v7 2/3] selftests: net: py: add tc utility
Date: Mon,  4 May 2026 13:38:33 -0400
Message-ID: <20260504174056.565319-3-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
In-Reply-To: <20260504174056.565319-1-willemdebruijn.kernel@gmail.com>
References: <20260504174056.565319-1-willemdebruijn.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B3FFE4C2049
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283972-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lib.py:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

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
index b68d4607114d..be9408a77168 100644
--- a/tools/testing/selftests/net/lib/py/utils.py
+++ b/tools/testing/selftests/net/lib/py/utils.py
@@ -239,7 +239,10 @@ class defer:
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
@@ -257,6 +260,13 @@ def ip(args, json=None, ns=None, host=None):
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


