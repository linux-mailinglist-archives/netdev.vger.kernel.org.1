Return-Path: <netdev+bounces-275845-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iKkQDvxv1GkruAcAu9opvQ
	(envelope-from <netdev+bounces-275845-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 04:46:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C53643A9391
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 04:46:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 751D8303F448
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 02:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 978C3373BE7;
	Tue,  7 Apr 2026 02:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XWDGUDll"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B46372EDF
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 02:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775529934; cv=none; b=RuZVatAvIJm8dlY24cCT6B70R3UfVTaoBTshy53qv5GZmGIMhItw+zun1tMZA2CkukJYeqpX+n/zzl8Z+hahAKkLTiqzMxeTo4OJymhHxWQFMqXbMN/8cjVbVr1moywpW1dlHnb1Jo1fXMD1NHNkR8VEY+E5NEP3Xe89OmPUJbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775529934; c=relaxed/simple;
	bh=2yY0YJWzFPzZvdGLlxAzyCCRCwa/GGM5y5gT2HuLzRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NcxW9detPP0EcJmfrDcUg3G+RimXGNCrqqtvZFTkx5zSEZ6p8egMv3KnJee62fWFa/7WQ98+gW3sk2fxKpSSeRhAMr7uGBJfdfiKJh1//isvgw8aWb+s4ymoVw4PZPEhU2Pc2ihT7nPLIx6hz6kLKN7j+zf3zUOON7lvDvlCPfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XWDGUDll; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775529932;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZB3tUtofrZMfh6izGqGZETNtfjj/IEd8MET151h1j3w=;
	b=XWDGUDllo6RfrrBiNqo1KtsncUwFxVfW/vYdFcRAiTcIe092AVqVfnvMWXegV29Av/9tTu
	1APHQoWkUYPCXfjyLdUmBRc2ABAv3+9VzQ0QkQ9QOiJtEKLG56uU/dZndcuhpazp2LLWN3
	WwAadftySd7TEhPPspiz7F+imRu0DM0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-222-lw89iQP0OOumc6P8M4UICQ-1; Mon,
 06 Apr 2026 22:45:29 -0400
X-MC-Unique: lw89iQP0OOumc6P8M4UICQ-1
X-Mimecast-MFC-AGG-ID: lw89iQP0OOumc6P8M4UICQ_1775529927
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9174B18005B2;
	Tue,  7 Apr 2026 02:45:27 +0000 (UTC)
Received: from xudu-thinkpadx1carbongen9.nay.com (unknown [10.72.116.131])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B8660300019F;
	Tue,  7 Apr 2026 02:45:23 +0000 (UTC)
From: Xu Du <xudu@redhat.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC net-next 2/4] selftests: drv-net: tso: add helpers for double tunneling GSO
Date: Tue,  7 Apr 2026 10:45:09 +0800
Message-ID: <b65f95793e03c1cb3ed3af4e1b2bee89fcf7e648.1775527362.git.xudu@redhat.com>
In-Reply-To: <cover.1775527362.git.xudu@redhat.com>
References: <cover.1775527362.git.xudu@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xudu@redhat.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-275845-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_FIVE(0.00)[6];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C53643A9391
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add helper functions to support double tunneling GSO testing. Since certain
tunnel-specific parameters (e.g., gro-hint) are not yet supported by the
standard ip-link tool, this patch adds a new helper function utilizing
the ynl-cli to handle these extended netlink attributes.

As the YNL Python module cannot be invoked across different devices or
environments directly in its current form, the helper abstracts the
YNL CLI calls to ensure proper configuration of the tunneling device
features.

Signed-off-by: Xu Du <xudu@redhat.com>
---
 .../drivers/net/hw/lib/py/__init__.py         |  4 ++--
 .../selftests/drivers/net/lib/py/__init__.py  |  4 ++--
 .../testing/selftests/net/lib/py/__init__.py  |  4 ++--
 tools/testing/selftests/net/lib/py/utils.py   | 19 +++++++++++++++++--
 4 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py b/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
index df4da5078c48..34a06e1afcb5 100644
--- a/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
+++ b/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
@@ -24,7 +24,7 @@ try:
     from net.lib.py import CmdExitFailure
     from net.lib.py import bkg, cmd, bpftool, bpftrace, defer, ethtool, \
         fd_read_timeout, ip, rand_port, rand_ports, wait_port_listen, \
-        wait_file, tool
+        wait_file, tool, ynlcli
     from net.lib.py import bpf_map_set, bpf_map_dump, bpf_prog_map_ids
     from net.lib.py import KsftSkipEx, KsftFailEx, KsftXfailEx
     from net.lib.py import ksft_disruptive, ksft_exit, ksft_pr, ksft_run, \
@@ -40,7 +40,7 @@ try:
                "CmdExitFailure",
                "bkg", "cmd", "bpftool", "bpftrace", "defer", "ethtool",
                "fd_read_timeout", "ip", "rand_port", "rand_ports",
-               "wait_port_listen", "wait_file", "tool",
+               "wait_port_listen", "wait_file", "tool", "ynlcli",
                "bpf_map_set", "bpf_map_dump", "bpf_prog_map_ids",
                "KsftSkipEx", "KsftFailEx", "KsftXfailEx",
                "ksft_disruptive", "ksft_exit", "ksft_pr", "ksft_run",
diff --git a/tools/testing/selftests/drivers/net/lib/py/__init__.py b/tools/testing/selftests/drivers/net/lib/py/__init__.py
index 2b5ec0505672..a9eb1a57fcc4 100644
--- a/tools/testing/selftests/drivers/net/lib/py/__init__.py
+++ b/tools/testing/selftests/drivers/net/lib/py/__init__.py
@@ -22,7 +22,7 @@ try:
     from net.lib.py import EthtoolFamily, NetdevFamily, NetshaperFamily, \
         NlError, RtnlFamily, DevlinkFamily, PSPFamily, Netlink
     from net.lib.py import CmdExitFailure
-    from net.lib.py import bkg, cmd, bpftool, bpftrace, defer, ethtool, \
+    from net.lib.py import bkg, cmd, bpftool, bpftrace, defer, ethtool, ynlcli, \
         fd_read_timeout, ip, rand_port, rand_ports, wait_port_listen, wait_file
     from net.lib.py import bpf_map_set, bpf_map_dump, bpf_prog_map_ids
     from net.lib.py import KsftSkipEx, KsftFailEx, KsftXfailEx
@@ -36,7 +36,7 @@ try:
                "NlError", "RtnlFamily", "DevlinkFamily", "PSPFamily", "Netlink",
                "CmdExitFailure",
                "bkg", "cmd", "bpftool", "bpftrace", "defer", "ethtool",
-               "fd_read_timeout", "ip", "rand_port", "rand_ports",
+               "fd_read_timeout", "ip", "rand_port", "rand_ports", "ynlcli",
                "wait_port_listen", "wait_file",
                "bpf_map_set", "bpf_map_dump", "bpf_prog_map_ids",
                "KsftSkipEx", "KsftFailEx", "KsftXfailEx",
diff --git a/tools/testing/selftests/net/lib/py/__init__.py b/tools/testing/selftests/net/lib/py/__init__.py
index 7c81d86a7e97..a3337666a856 100644
--- a/tools/testing/selftests/net/lib/py/__init__.py
+++ b/tools/testing/selftests/net/lib/py/__init__.py
@@ -14,7 +14,7 @@ from .netns import NetNS, NetNSEnter
 from .nsim import NetdevSim, NetdevSimDev
 from .utils import CmdExitFailure, fd_read_timeout, cmd, bkg, defer, \
     bpftool, ip, ethtool, bpftrace, rand_port, rand_ports, wait_port_listen, \
-    wait_file, tool
+    wait_file, tool, ynlcli
 from .bpf import bpf_map_set, bpf_map_dump, bpf_prog_map_ids
 from .ynl import NlError, NlctrlFamily, YnlFamily, \
     EthtoolFamily, NetdevFamily, RtnlFamily, RtnlAddrFamily
@@ -29,7 +29,7 @@ __all__ = ["KSRC",
            "NetNS", "NetNSEnter",
            "CmdExitFailure", "fd_read_timeout", "cmd", "bkg", "defer",
            "bpftool", "ip", "ethtool", "bpftrace", "rand_port", "rand_ports",
-           "wait_port_listen", "wait_file", "tool",
+           "wait_port_listen", "wait_file", "tool", "ynlcli",
            "bpf_map_set", "bpf_map_dump", "bpf_prog_map_ids",
            "NetdevSim", "NetdevSimDev",
            "NetshaperFamily", "DevlinkFamily", "PSPFamily", "NlError",
diff --git a/tools/testing/selftests/net/lib/py/utils.py b/tools/testing/selftests/net/lib/py/utils.py
index 6c44a3d2bbf7..a14a4b5dd592 100644
--- a/tools/testing/selftests/net/lib/py/utils.py
+++ b/tools/testing/selftests/net/lib/py/utils.py
@@ -8,6 +8,8 @@ import socket
 import subprocess
 import time
 
+from .consts import KSRC, KSFT_DIR
+
 
 class CmdInitFailure(Exception):
     """ Command failed to start. Only raised by bkg(). """
@@ -217,12 +219,12 @@ class defer:
         self.exec_only()
 
 
-def tool(name, args, json=None, ns=None, host=None):
+def tool(name, args, json=None, ns=None, host=None, shell=None):
     cmd_str = name + ' '
     if json:
         cmd_str += '--json '
     cmd_str += args
-    cmd_obj = cmd(cmd_str, ns=ns, host=host)
+    cmd_obj = cmd(cmd_str, ns=ns, host=host, shell=shell)
     if json:
         return _json.loads(cmd_obj.stdout)
     return cmd_obj
@@ -242,6 +244,19 @@ def ethtool(args, json=None, ns=None, host=None):
     return tool('ethtool', args, json=json, ns=ns, host=host)
 
 
+def ynlcli(family, args, json=None, ns=None, host=None):
+    if (KSFT_DIR / "kselftest-list.txt").exists():
+        cli = KSFT_DIR / "net/lib/ynl/pyynl/cli.py"
+        spec = KSFT_DIR / f"net/lib/specs/{family}.yaml"
+    else:
+        cli = KSRC / "tools/net/ynl/pyynl/cli.py"
+        spec = KSRC / f"Documentation/netlink/specs/{family}.yaml"
+    if not cli.exists():
+        raise FileNotFoundError(f"cli not found at {cli}")
+    args = f"--spec {spec} --no-schema {args}"
+    return tool(cli.as_posix(), args, json=json, ns=ns, host=host, shell=True)
+
+
 def bpftrace(expr, json=None, ns=None, host=None, timeout=None):
     """
     Run bpftrace and return map data (if json=True).
-- 
2.53.0


