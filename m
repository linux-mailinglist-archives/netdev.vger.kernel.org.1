Return-Path: <netdev+bounces-257685-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MOLHAvGThmnuOwQAu9opvQ
	(envelope-from <netdev+bounces-257685-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 02:22:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF8A104760
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 02:22:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 40E2330097C7
	for <lists+netdev@lfdr.de>; Sat,  7 Feb 2026 01:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E65292749ED;
	Sat,  7 Feb 2026 01:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ophAAmrN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BE8265CBE;
	Sat,  7 Feb 2026 01:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770427314; cv=none; b=scAlnb/eJlJr0zSJIWN1auXP9JpNruaNwOidt5xn+f6ILpO/iqVnifDnILWj+a8jUxFScMe2Y4M18b/wCcCNxLIYmnoGz7g4jgFDJJbG76YCfb0pPSa8ZD+Y3RsZJxHQKDrz1mHKrpG8sUzK8PNHofLeuwUWaI1LXIzvrvL8nCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770427314; c=relaxed/simple;
	bh=1ploFQFSW4xM1HWjDkKu9Op/F4aJ2wf4SFMmu1yJtAo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ecc33KU4cPPv9jyl7Gw6B/Vmm5AabmBIvrkzCNCO+xo6BPrx131z1KnSBMBgm7t/r/FIGC5+pQPEyuy6jHoDx2cgBh9dyyIaJY/2gOeYQBTEtiM1f+YdM7XcQbdxOEf/q3rEa7YtrQddTeXEAcNuZLGYk/F3VZEy4cPSrQTMPHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ophAAmrN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1C44C116C6;
	Sat,  7 Feb 2026 01:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770427314;
	bh=1ploFQFSW4xM1HWjDkKu9Op/F4aJ2wf4SFMmu1yJtAo=;
	h=From:To:Cc:Subject:Date:From;
	b=ophAAmrNjpi2SFK1IBmdcjhkOUxXiBzNKMHDqZniz5jZY37ZpM2Zx75+oG2c44Bw/
	 iWS7FMXikPhpfspSPvvzKF+ogywNlaxdT8J1tkXMAGzb/JTa/D5shLpsC1xc4YcIlE
	 Y6C2FboSwh1heVR4KFhqoViriwGpboXKdhN43ebz3K4rx3iwVDOsiQ7y238+qf5EcG
	 sdxbmgf+CuoXFDixiW+oNwRjDudYHTUGnuyEQpNqakvbQvfkG0nvwKF99nR71+e8iY
	 3wyG9xHitfgXK3KoQp5IRFGeCVH6iRFdilWct9rRYcqBYjPeYR2uUgl0A8+fxoD0tu
	 z5+Pfr+DfHPsg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	danieller@nvidia.com,
	petrm@nvidia.com
Subject: [PATCH net-next] selftests: drv-net: port_split: convert to ksft format and mark disruptive
Date: Fri,  6 Feb 2026 17:21:51 -0800
Message-ID: <20260207012151.3972723-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257685-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lib.py:url,args.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,dev_port.name:url]
X-Rspamd-Queue-Id: 5BF8A104760
X-Rspamd-Action: no action

The devlink port split test is included in the HW tests,
but it does not obey our KSFT_DISRUPTIVE marking.
If someone tries to run driver tests over SSH on a device
that supports port splitting the outcome will be loss of
connectivity.

Convert the test to conform to our "driver test environment".
Mark it as disruptive.

This is completely untested, I'd appreciate if someone with
the right setup could give this a go (and probably fix up
the bugs I introduced).

CC: danieller@nvidia.com
CC: petrm@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 .../drivers/net/hw/devlink_port_split.py      | 243 ++++++------------
 1 file changed, 77 insertions(+), 166 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/devlink_port_split.py b/tools/testing/selftests/drivers/net/hw/devlink_port_split.py
index 2d84c7a0be6b..c7b38f5e94fd 100755
--- a/tools/testing/selftests/drivers/net/hw/devlink_port_split.py
+++ b/tools/testing/selftests/drivers/net/hw/devlink_port_split.py
@@ -1,75 +1,48 @@
 #!/usr/bin/env python3
 # SPDX-License-Identifier: GPL-2.0
 
-from subprocess import PIPE, Popen
-import json
-import time
-import argparse
+"""
+Test port split configuration using devlink-port lanes attribute.
+The test is skipped in case the attribute is not available.
+
+First, check that all the ports with 1 lane fail to split.
+Second, check that all the ports with more than 1 lane can be split
+to all valid configurations (e.g., split to 2, split to 4 etc.)
+"""
+
 import collections
-import sys
+import json
+import os
 
-#
-# Test port split configuration using devlink-port lanes attribute.
-# The test is skipped in case the attribute is not available.
-#
-# First, check that all the ports with 1 lane fail to split.
-# Second, check that all the ports with more than 1 lane can be split
-# to all valid configurations (e.g., split to 2, split to 4 etc.)
-#
+from lib.py import ksft_run, ksft_exit, ksft_pr
+from lib.py import ksft_eq, ksft_disruptive
+from lib.py import NetDrvEnv
+from lib.py import KsftSkipEx
+from lib.py import cmd
 
 
-# Kselftest framework requirement - SKIP code is 4
-KSFT_SKIP=4
 Port = collections.namedtuple('Port', 'bus_info name')
 
 
-def run_command(cmd, should_fail=False):
+def get_devlink_ports(dev):
     """
-    Run a command in subprocess.
-    Return: Tuple of (stdout, stderr).
+    Get a list of physical devlink ports.
+    Return: Array of tuples (bus_info, name).
     """
 
-    p = Popen(cmd, stdout=PIPE, stderr=PIPE, shell=True)
-    stdout, stderr = p.communicate()
-    stdout, stderr = stdout.decode(), stderr.decode()
+    arr = []
 
-    if stderr != "" and not should_fail:
-        print("Error sending command: %s" % cmd)
-        print(stdout)
-        print(stderr)
-    return stdout, stderr
+    result = cmd("devlink -j port show")
+    ports = json.loads(result.stdout)['port']
 
+    validate_devlink_output(ports, 'flavour')
 
-class devlink_ports(object):
-    """
-    Class that holds information on the devlink ports, required to the tests;
-    if_names: A list of interfaces in the devlink ports.
-    """
+    for port in ports:
+        if dev in port:
+            if ports[port]['flavour'] == 'physical':
+                arr.append(Port(bus_info=port, name=ports[port]['netdev']))
 
-    def get_if_names(dev):
-        """
-        Get a list of physical devlink ports.
-        Return: Array of tuples (bus_info/port, if_name).
-        """
-
-        arr = []
-
-        cmd = "devlink -j port show"
-        stdout, stderr = run_command(cmd)
-        assert stderr == ""
-        ports = json.loads(stdout)['port']
-
-        validate_devlink_output(ports, 'flavour')
-
-        for port in ports:
-            if dev in port:
-                if ports[port]['flavour'] == 'physical':
-                    arr.append(Port(bus_info=port, name=ports[port]['netdev']))
-
-        return arr
-
-    def __init__(self, dev):
-        self.if_names = devlink_ports.get_if_names(dev)
+    return arr
 
 
 def get_max_lanes(port):
@@ -78,10 +51,8 @@ Port = collections.namedtuple('Port', 'bus_info name')
     Return: number of lanes, e.g. 1, 2, 4 and 8.
     """
 
-    cmd = "devlink -j port show %s" % port
-    stdout, stderr = run_command(cmd)
-    assert stderr == ""
-    values = list(json.loads(stdout)['port'].values())[0]
+    result = cmd(f"devlink -j port show {port}")
+    values = list(json.loads(result.stdout)['port'].values())[0]
 
     if 'lanes' in values:
         lanes = values['lanes']
@@ -96,47 +67,12 @@ Port = collections.namedtuple('Port', 'bus_info name')
     Return: split ability, true or false.
     """
 
-    cmd = "devlink -j port show %s" % port.name
-    stdout, stderr = run_command(cmd)
-    assert stderr == ""
-    values = list(json.loads(stdout)['port'].values())[0]
+    result = cmd(f"devlink -j port show {port.name}")
+    values = list(json.loads(result.stdout)['port'].values())[0]
 
     return values['splittable']
 
 
-def split(k, port, should_fail=False):
-    """
-    Split $port into $k ports.
-    If should_fail == True, the split should fail. Otherwise, should pass.
-    Return: Array of sub ports after splitting.
-            If the $port wasn't split, the array will be empty.
-    """
-
-    cmd = "devlink port split %s count %s" % (port.bus_info, k)
-    stdout, stderr = run_command(cmd, should_fail=should_fail)
-
-    if should_fail:
-        if not test(stderr != "", "%s is unsplittable" % port.name):
-            print("split an unsplittable port %s" % port.name)
-            return create_split_group(port, k)
-    else:
-        if stderr == "":
-            return create_split_group(port, k)
-        print("didn't split a splittable port %s" % port.name)
-
-    return []
-
-
-def unsplit(port):
-    """
-    Unsplit $port.
-    """
-
-    cmd = "devlink port unsplit %s" % port
-    stdout, stderr = run_command(cmd)
-    test(stderr == "", "Unsplit port %s" % port)
-
-
 def exists(port, dev):
     """
     Check if $port exists in the devlink ports.
@@ -144,7 +80,7 @@ Port = collections.namedtuple('Port', 'bus_info name')
     """
 
     return any(dev_port.name == port
-               for dev_port in devlink_ports.get_if_names(dev))
+               for dev_port in get_devlink_ports(dev))
 
 
 def exists_and_lanes(ports, lanes, dev):
@@ -157,29 +93,15 @@ Port = collections.namedtuple('Port', 'bus_info name')
     for port in ports:
         max_lanes = get_max_lanes(port)
         if not exists(port, dev):
-            print("port %s doesn't exist in devlink ports" % port)
+            ksft_pr(f"port {port} doesn't exist in devlink ports")
             return False
         if max_lanes != lanes:
-            print("port %s has %d lanes, but %s were expected"
-                  % (port, lanes, max_lanes))
+            ksft_pr(f"port {port} has {max_lanes} lanes, "
+                    f"but {lanes} were expected")
             return False
     return True
 
 
-def test(cond, msg):
-    """
-    Check $cond and print a message accordingly.
-    Return: True is pass, False otherwise.
-    """
-
-    if cond:
-        print("TEST: %-60s [ OK ]" % msg)
-    else:
-        print("TEST: %-60s [FAIL]" % msg)
-
-    return cond
-
-
 def create_split_group(port, k):
     """
     Create the split group for $port.
@@ -194,11 +116,11 @@ Port = collections.namedtuple('Port', 'bus_info name')
     Test that splitting of unsplittable port fails.
     """
 
-    # split to max
-    new_split_group = split(k, port, should_fail=True)
-
-    if new_split_group != []:
-        unsplit(port.bus_info)
+    result = cmd(f"devlink port split {port.bus_info} count {k}", fail=False)
+    if result.ret == 0:
+        ksft_pr(f"split an unsplittable port {port.name}")
+        cmd(f"devlink port unsplit {port.bus_info}")
+    ksft_eq(result.ret != 0, True, f"{port.name} is unsplittable")
 
 
 def split_splittable_port(port, k, lanes, dev):
@@ -206,20 +128,22 @@ Port = collections.namedtuple('Port', 'bus_info name')
     Test that splitting of splittable port passes correctly.
     """
 
-    new_split_group = split(k, port)
+    result = cmd(f"devlink port split {port.bus_info} count {k}", fail=False)
+
+    if result.ret != 0:
+        ksft_pr(f"didn't split a splittable port {port.name}")
+        return
 
     # Once the split command ends, it takes some time to the sub ifaces'
     # to get their names. Use udevadm to continue only when all current udev
     # events are handled.
-    cmd = "udevadm settle"
-    stdout, stderr = run_command(cmd)
-    assert stderr == ""
+    cmd("udevadm settle")
 
-    if new_split_group != []:
-        test(exists_and_lanes(new_split_group, lanes/k, dev),
-             "split port %s into %s" % (port.name, k))
+    new_split_group = create_split_group(port, k)
+    ksft_eq(exists_and_lanes(new_split_group, lanes / k, dev), True,
+            f"split port {port.name} into {k}")
 
-    unsplit(port.bus_info)
+    cmd(f"devlink port unsplit {port.bus_info}")
 
 
 def validate_devlink_output(devlink_data, target_property=None):
@@ -231,7 +155,7 @@ Port = collections.namedtuple('Port', 'bus_info name')
     skip_reason = None
     if any(devlink_data.values()):
         if target_property:
-            skip_reason = "{} not found in devlink output, test skipped".format(target_property)
+            skip_reason = f"{target_property} not found in devlink output, test skipped"
             for key in devlink_data:
                 if target_property in devlink_data[key]:
                     skip_reason = None
@@ -239,44 +163,22 @@ Port = collections.namedtuple('Port', 'bus_info name')
         skip_reason = 'devlink output is empty, test skipped'
 
     if skip_reason:
-        print(skip_reason)
-        sys.exit(KSFT_SKIP)
+        raise KsftSkipEx(skip_reason)
 
 
-def make_parser():
-    parser = argparse.ArgumentParser(description='A test for port splitting.')
-    parser.add_argument('--dev',
-                        help='The devlink handle of the device under test. ' +
-                             'The default is the first registered devlink ' +
-                             'handle.')
+@ksft_disruptive
+def test_port_split(cfg):
+    """Test port split configuration using devlink-port lanes attribute."""
+    dev = f"pci/{cfg.pci}"
 
-    return parser
+    result = cmd(f"devlink dev show {dev}", fail=False)
+    if result.ret != 0:
+        raise KsftSkipEx(f"devlink device {dev} can not be found")
 
-
-def main(cmdline=None):
-    parser = make_parser()
-    args = parser.parse_args(cmdline)
-
-    dev = args.dev
-    if not dev:
-        cmd = "devlink -j dev show"
-        stdout, stderr = run_command(cmd)
-        assert stderr == ""
-
-        validate_devlink_output(json.loads(stdout))
-        devs = json.loads(stdout)['dev']
-        dev = list(devs.keys())[0]
-
-    cmd = "devlink dev show %s" % dev
-    stdout, stderr = run_command(cmd)
-    if stderr != "":
-        print("devlink device %s can not be found" % dev)
-        sys.exit(1)
-
-    ports = devlink_ports(dev)
+    ports = get_devlink_ports(dev)
 
     found_max_lanes = False
-    for port in ports.if_names:
+    for port in ports:
         max_lanes = get_max_lanes(port.name)
 
         # If max lanes is 0, do not test port splitting at all
@@ -285,15 +187,15 @@ Port = collections.namedtuple('Port', 'bus_info name')
 
         # If 1 lane, shouldn't be able to split
         elif max_lanes == 1:
-            test(not get_split_ability(port),
-                 "%s should not be able to split" % port.name)
+            ksft_eq(get_split_ability(port), False,
+                    f"{port.name} should not be able to split")
             split_unsplittable_port(port, max_lanes)
 
         # Else, splitting should pass and all the split ports should exist.
         else:
             lane = max_lanes
-            test(get_split_ability(port),
-                 "%s should be able to split" % port.name)
+            ksft_eq(get_split_ability(port), True,
+                    f"{port.name} should be able to split")
             while lane > 1:
                 split_splittable_port(port, lane, max_lanes, dev)
 
@@ -301,8 +203,17 @@ Port = collections.namedtuple('Port', 'bus_info name')
         found_max_lanes = True
 
     if not found_max_lanes:
-        print(f"Test not started, no port of device {dev} reports max_lanes")
-        sys.exit(KSFT_SKIP)
+        raise KsftSkipEx(f"No port of device {dev} reports max_lanes")
+
+
+def main() -> None:
+    """Ksft boiler plate main"""
+    with NetDrvEnv(__file__, nsim_test=False) as cfg:
+        cfg.pci = os.path.basename(
+            os.path.realpath(f"/sys/class/net/{cfg.ifname}/device")
+        )
+        ksft_run([test_port_split], args=(cfg,))
+    ksft_exit()
 
 
 if __name__ == "__main__":
-- 
2.53.0


