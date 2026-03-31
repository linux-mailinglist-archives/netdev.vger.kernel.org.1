Return-Path: <netdev+bounces-273455-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uPJwG/5Fy2nSFAYAu9opvQ
	(envelope-from <netdev+bounces-273455-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 05:56:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D5691363C69
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 05:56:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 154C93011CBF
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 03:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF6C2C11E4;
	Tue, 31 Mar 2026 03:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A53RacYy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A511EF39E
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 03:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774929403; cv=none; b=P/gw2F1bKnLe0pycnWv/WcHklpn5JXKuh5bYVG+HiRx/IjtSN9XCHW8sfWqArfb9X687+GgvQ4MLNa26cbVS+jU4ZYCN9Hgo9wvkvfGE99UzZF212Y1Ix7bKOFajAWjJHqvRE0bZb/zoVadH10N4bhHbbzN7Ard0a/g6EdqBzsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774929403; c=relaxed/simple;
	bh=lO90n7TQ7viTYcHE5z6RbYwdo3N9dITEVnLpSdhoKiI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E1y7UR53OYpJoC8gLVObBlkWEhxWAhGCuHytc/MO5tHByEi9D4wP8oZzbr2y0RqX5r/TVtCNBrUpk8XGiMRwjkg207+j9Ll+D6NaRGH2BtBLLW6VY/wy2Nbus5uZ6pZMSP14kercQ72lIOT7/FoeoHj1DCwKEnqaXwwTRxMUJDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A53RacYy; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2aaf43014d0so34812465ad.2
        for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 20:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774929401; x=1775534201; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1XBvzRLrpjXV3/hRXV2JjUvNJhrfkyfV/lSyUFxhz4k=;
        b=A53RacYyqQMLjwmsXTyje9tNh40CWXf7jKR6mP15ezMKmdE2OOg3X1Ky9gK8YoeUHE
         pyAQZlQKRstDD81opJlNcheDLO/XBczULvjaG0+bnF+tGXe3+xvc+tgJcMoO5+FG0Elh
         G3i0rqS7c1T7FaZ1Nm9icRJISVN9UFo5FfTtF34RR41AZ5R/huhO1mKJXi1rbo1TtNUG
         k43EcEjWGsj7jM/+s6mNWz7WOT5WiRPkQ6j7Wbeu1ZA7+FoUZmYuQBUC7yz3qYlM0dDo
         aQRhGW2Qz6isA4PIc2r5lBJdsv3skzs4r/CVG3jkmYy83JaObPImGCsFnKZp93+P8P4M
         vUuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774929401; x=1775534201;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1XBvzRLrpjXV3/hRXV2JjUvNJhrfkyfV/lSyUFxhz4k=;
        b=G1jN2Y8P6b2L2fnNncMGfkRB/TtutGBs9iNmtlyzIXkg8ZTwG4UtXnbthtevQCtiTJ
         TWEn4lDrU7dhyeaxO/Xlh/e8i9gAPpoSaJf6eYyI5Jnk+j0tI/BmZUAjtCVo+CjK0gKa
         DPEfjQdS8k040KVMw1i9QQPOWyniKzHNP1yc8hS32LaD/LWg5d04NlatZUcfzawsuJYn
         ez6ghZ4xjbbQvcsD0yJYj81Y/6UoBHibJxHxbOg0MSSKObFWcwWa0PhPK7HP9Hy7ry0p
         1DKTIDVKpmTI5x24SYtQnKrL3Vc/dKr1nlEx/0tk/YW50Wen5Sej+o364tK8sMCO4fGr
         TOpQ==
X-Gm-Message-State: AOJu0YzlvGMckW44HmpWBueMV/8f/JpdZMqn0VNoDVd7vr3ejG2KiTtc
	XRqU1Vp7go03WPwtf4JJkXVufDuU2nHM7kwtamb+bd9mBZVPedBn1P40
X-Gm-Gg: ATEYQzzHjne/tW6lL5gH7hRTkqQJxgwBPjAgbryX4nVvbbaiLmDCurrzZU7rFoo8tt6
	InFDk5flnQXQi3cyO+Mrnes8f2kyvxYVVsNHK1PHMyyeRRwIuVeLSo0cgM9oha2tEcvpPELPnM3
	Kp8JbNfFCwaICej5axRSmxn/VFNJf72b0IrRgNzF5cXE9Z43ODsjZIrBKJLugToCAb76EtkZgvS
	3OTewGGpeAVU9H6R0yy3JD4SULZ18LxXsljq9bt/emTy1EaKf9yVl9noXJiTk7lq+HkVRxzReXy
	rDpjE2G9I8+t9VsAJrYwBYyw/pV5/4WBQgisXNuGvoGX13NIbCKxiVSygk6c9zttVkWZYK6R8Ff
	+SC3fXLne9FvnCzAisuvwDTr2B8p0SB4D6t5AG0uVd/tIr25Q6Bsu/lXSVJdTw0ixe9qWgd1X25
	Nx6K2VfAb2zP3X4fMGDfZARZRJ6RSGVgs9iAEn9eA9EsehCbDq7HXsDlXdyWiHOO58WDbK3ro03
	RWt2/6mUwNjJEuj12t8vJJkhjZQN4ljooxa16RWkgZZWJOnlFc=
X-Received: by 2002:a17:902:fc4b:b0:2aa:d67b:ef96 with SMTP id d9443c01a7336-2b0cdcaa72dmr158027155ad.31.1774929401348;
        Mon, 30 Mar 2026 20:56:41 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([240e:34c:5765:500:c92f:4f4e:9953:45b7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b24266e487sm94680625ad.24.2026.03.30.20.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 20:56:40 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
Date: Tue, 31 Mar 2026 11:56:11 +0800
Subject: [PATCH net-next 1/4] tools: ynl: ethtool: use doit instead of
 dumpit for per-device GET
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260331-b4-ynl_ethtool-v1-1-dda2a9b55df8@gmail.com>
References: <20260331-b4-ynl_ethtool-v1-0-dda2a9b55df8@gmail.com>
In-Reply-To: <20260331-b4-ynl_ethtool-v1-0-dda2a9b55df8@gmail.com>
To: Donald Hunter <donald.hunter@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Hangbin Liu <liuhangbin@gmail.com>
X-Mailer: b4 0.14.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-273455-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,davemloft.net,google.com,redhat.com,lunn.ch];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liuhangbin@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D5691363C69
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Rename the local helper doit() to do_set() and dumpit() to do_get() to
better reflect their purpose.

Convert do_get() to use ynl.do() with an explicit device header instead
of ynl.dump() followed by client-side filtering. This is more efficient
as the kernel only processes and returns data for the requested device,
rather than dumping all devices across the netns.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 tools/net/ynl/pyynl/ethtool.py | 68 ++++++++++++++++++++----------------------
 1 file changed, 33 insertions(+), 35 deletions(-)

diff --git a/tools/net/ynl/pyynl/ethtool.py b/tools/net/ynl/pyynl/ethtool.py
index f1a2a2a89985..8bf234d594b3 100755
--- a/tools/net/ynl/pyynl/ethtool.py
+++ b/tools/net/ynl/pyynl/ethtool.py
@@ -84,9 +84,9 @@ def print_speed(name, value):
     speed = [ k for k, v in value.items() if v and speed_re.match(k) ]
     print(f'{name}: {" ".join(speed)}')
 
-def doit(ynl, args, op_name):
+def do_set(ynl, args, op_name):
     """
-    Prepare request header, parse arguments and doit.
+    Prepare request header, parse arguments and do a set operation.
     """
     req = {
         'header': {
@@ -97,26 +97,24 @@ def doit(ynl, args, op_name):
     args_to_req(ynl, op_name, args.args, req)
     ynl.do(op_name, req)
 
-def dumpit(ynl, args, op_name, extra=None):
+def do_get(ynl, args, op_name, extra=None):
     """
-    Prepare request header, parse arguments and dumpit (filtering out the
-    devices we're not interested in).
+    Prepare request header and get info for a specific device using doit.
     """
     extra = extra or {}
-    reply = ynl.dump(op_name, { 'header': {} } | extra)
+    req = {'header': {'dev-name': args.device}}
+    req['header'].update(extra.pop('header', {}))
+    req.update(extra)
+
+    reply = ynl.do(op_name, req)
     if not reply:
         return {}
 
-    for msg in reply:
-        if msg['header']['dev-name'] == args.device:
-            if args.json:
-                pprint.PrettyPrinter().pprint(msg)
-                sys.exit(0)
-            msg.pop('header', None)
-            return msg
-
-    print(f"Not supported for device {args.device}")
-    sys.exit(1)
+    if args.json:
+        pprint.PrettyPrinter().pprint(reply)
+        sys.exit(0)
+    reply.pop('header', None)
+    return reply
 
 def bits_to_dict(attr):
     """
@@ -181,15 +179,15 @@ def main():
         return
 
     if args.set_eee:
-        doit(ynl, args, 'eee-set')
+        do_set(ynl, args, 'eee-set')
         return
 
     if args.set_pause:
-        doit(ynl, args, 'pause-set')
+        do_set(ynl, args, 'pause-set')
         return
 
     if args.set_coalesce:
-        doit(ynl, args, 'coalesce-set')
+        do_set(ynl, args, 'coalesce-set')
         return
 
     if args.set_features:
@@ -198,20 +196,20 @@ def main():
         return
 
     if args.set_channels:
-        doit(ynl, args, 'channels-set')
+        do_set(ynl, args, 'channels-set')
         return
 
     if args.set_ring:
-        doit(ynl, args, 'rings-set')
+        do_set(ynl, args, 'rings-set')
         return
 
     if args.show_priv_flags:
-        flags = bits_to_dict(dumpit(ynl, args, 'privflags-get')['flags'])
+        flags = bits_to_dict(do_get(ynl, args, 'privflags-get')['flags'])
         print_field(flags)
         return
 
     if args.show_eee:
-        eee = dumpit(ynl, args, 'eee-get')
+        eee = do_get(ynl, args, 'eee-get')
         ours = bits_to_dict(eee['modes-ours'])
         peer = bits_to_dict(eee['modes-peer'])
 
@@ -232,18 +230,18 @@ def main():
         return
 
     if args.show_pause:
-        print_field(dumpit(ynl, args, 'pause-get'),
+        print_field(do_get(ynl, args, 'pause-get'),
                 ('autoneg', 'Autonegotiate', 'bool'),
                 ('rx', 'RX', 'bool'),
                 ('tx', 'TX', 'bool'))
         return
 
     if args.show_coalesce:
-        print_field(dumpit(ynl, args, 'coalesce-get'))
+        print_field(do_get(ynl, args, 'coalesce-get'))
         return
 
     if args.show_features:
-        reply = dumpit(ynl, args, 'features-get')
+        reply = do_get(ynl, args, 'features-get')
         available = bits_to_dict(reply['hw'])
         requested = bits_to_dict(reply['wanted']).keys()
         active = bits_to_dict(reply['active']).keys()
@@ -270,7 +268,7 @@ def main():
         return
 
     if args.show_channels:
-        reply = dumpit(ynl, args, 'channels-get')
+        reply = do_get(ynl, args, 'channels-get')
         print(f'Channel parameters for {args.device}:')
 
         print('Pre-set maximums:')
@@ -290,7 +288,7 @@ def main():
         return
 
     if args.show_ring:
-        reply = dumpit(ynl, args, 'channels-get')
+        reply = do_get(ynl, args, 'channels-get')
 
         print(f'Ring parameters for {args.device}:')
 
@@ -319,7 +317,7 @@ def main():
         print('NIC statistics:')
 
         # TODO: pass id?
-        strset = dumpit(ynl, args, 'strset-get')
+        strset = do_get(ynl, args, 'strset-get')
         pprint.PrettyPrinter().pprint(strset)
 
         req = {
@@ -338,7 +336,7 @@ def main():
           },
         }
 
-        rsp = dumpit(ynl, args, 'stats-get', req)
+        rsp = do_get(ynl, args, 'stats-get', req)
         pprint.PrettyPrinter().pprint(rsp)
         return
 
@@ -349,7 +347,7 @@ def main():
           },
         }
 
-        tsinfo = dumpit(ynl, args, 'tsinfo-get', req)
+        tsinfo = do_get(ynl, args, 'tsinfo-get', req)
 
         print(f'Time stamping parameters for {args.device}:')
 
@@ -377,7 +375,7 @@ def main():
         return
 
     print(f'Settings for {args.device}:')
-    linkmodes = dumpit(ynl, args, 'linkmodes-get')
+    linkmodes = do_get(ynl, args, 'linkmodes-get')
     ours = bits_to_dict(linkmodes['ours'])
 
     supported_ports = ('TP',  'AUI', 'BNC', 'MII', 'FIBRE', 'Backplane')
@@ -425,7 +423,7 @@ def main():
             5: 'Directly Attached Copper',
             0xef: 'None',
     }
-    linkinfo = dumpit(ynl, args, 'linkinfo-get')
+    linkinfo = do_get(ynl, args, 'linkinfo-get')
     print(f'Port: {ports.get(linkinfo["port"], "Other")}')
 
     print_field(linkinfo, ('phyaddr', 'PHYAD'))
@@ -447,11 +445,11 @@ def main():
         mdix = mdix_ctrl.get(linkinfo['tp-mdix'], 'Unknown (auto)')
     print(f'MDI-X: {mdix}')
 
-    debug = dumpit(ynl, args, 'debug-get')
+    debug = do_get(ynl, args, 'debug-get')
     msgmask = bits_to_dict(debug.get("msgmask", [])).keys()
     print(f'Current message level: {" ".join(msgmask)}')
 
-    linkstate = dumpit(ynl, args, 'linkstate-get')
+    linkstate = do_get(ynl, args, 'linkstate-get')
     detected_states = {
             0: 'no',
             1: 'yes',

-- 
Git-155)


