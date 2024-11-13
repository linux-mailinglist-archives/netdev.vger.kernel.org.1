Return-Path: <netdev+bounces-144340-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B129C6B3A
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 10:09:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 770461F25384
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 09:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 596CB1C07CD;
	Wed, 13 Nov 2024 09:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jz2LbDCT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA881BF7FC
	for <netdev@vger.kernel.org>; Wed, 13 Nov 2024 09:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731488933; cv=none; b=VITBemBNKV7WqSJmmOAsTqicefIj5BDYUg12xsHs9dE+J6YeSt2lbIMv0eWgMucnzazTSVz3gvuey34OU2e2pZYmIDwBCFrANzvbjtnKLy1Fe0cid+ngW76wcasp/EWGlty+oODB6k4nyAXeE6k9x47z12rkgBOo/Er/qBmWqGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731488933; c=relaxed/simple;
	bh=AZf/SeA63j7+197rv/oOnG3fexErUtbu+FNorD35+AA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lfos1M63pyWHhpXFR7NH9UhDSa5RPSrlWvkDrHXFVQ5P6BI32zJziP07E/2g6rzwdDxuWWUHBFmaq/xTM2Y5Wfr6tfdwZ23vAuq/u5+PmHW2SmiUAmi4HDofuHo4viGNKwsmk/KSQZEfcBotn5e+wmBsGwt3RAz59LSBCGD5uIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jz2LbDCT; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4316cce103dso82873415e9.3
        for <netdev@vger.kernel.org>; Wed, 13 Nov 2024 01:08:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731488929; x=1732093729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D/um5CkwAwtjvBAu0QymM8fXSTMcjh9CRsND1rA49GU=;
        b=jz2LbDCTBvX3ZE8eKw5b01zm9Tef3aPCg3raIYwl087UFivAgh0jaMQTLkRuFLPAZI
         S+bXMXxc9OPOb6eIznwAORMSfpr8xuUvfblawY/NcDeDxRdQPZ0W4wBYESK3xxPJFogf
         b35htRYP4NPeXzvILptalllqaJOn5niJ7bFwMfOgdyGtUQub4uoansSWkXwPsjoZSaln
         TuursQEisn1YnJZL8FI5B7QTcB8Q7uAvX5ztKkfA1FMxbeAPkg2eq7f4XS3A5enXZlVU
         twYwV+AkEpD5Ag71H+GTF9SUbbifCOfEDb6+R4NWHQpp3y4QZW0qM7MgkG2i4oWRjQvj
         jUiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731488929; x=1732093729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D/um5CkwAwtjvBAu0QymM8fXSTMcjh9CRsND1rA49GU=;
        b=NfISsRql5PJL4JJ/BWhfFHxqawxlomrvNKp+OVLz/WNShK5svrNjyexgACfXmPPlxw
         sAAGp4JkfMqja5JlNHjgkcDBUduvNhFFPcJjN4balJdLyLpMNPfJV+HuTVhKL5tkd5/j
         S7CaGe0S62euKihgY0rWSR6S5+CZRadbIY4QwOlUN9RuAIAn+uCYj0cErKMn+3la5H26
         AOrSSHSfvNlCtaLk61yVqA07Mh/qbBFB7YJY4svrPvz+igKUAAVgZRid+Y6alRMUqIHT
         7VlSnniqOjAQmgzKaaq8o9xw8OwWkeIZbCNkAdc2awWGJ1+eQmxpoRcniJRNO0CAZCXW
         0/PA==
X-Gm-Message-State: AOJu0Yy64F7M6ejHpralAEOgj+GTydXt0B/FcCKwCeXm5IrDw97L8KO7
	rukire6Baf050IpHZ+6bjGh9MivCDYoSnHjH4BaVCdL/Z0FQeIsftzY0K4zs
X-Google-Smtp-Source: AGHT+IFaFQJZ2xPf0Kgaa8fwLqXRsTiIN+L96muAImE99NQthZIjCtT+NRhngkFwairMCKLb4Vxc+w==
X-Received: by 2002:a05:600c:1396:b0:431:5c3d:1700 with SMTP id 5b1f17b1804b1-432b7518e11mr195489625e9.21.1731488929079;
        Wed, 13 Nov 2024 01:08:49 -0800 (PST)
Received: from imac.lan ([2a02:8010:60a0:0:c1e8:dddd:ac2:ca40])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432d5503c63sm16939165e9.26.2024.11.13.01.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 01:08:48 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Xiao Liang <shaw.leon@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>
Cc: donald.hunter@redhat.com,
	Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH net-next v3 2/2] tools/net/ynl: add async notification handling
Date: Wed, 13 Nov 2024 09:08:43 +0000
Message-ID: <20241113090843.72917-3-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241113090843.72917-1-donald.hunter@gmail.com>
References: <20241113090843.72917-1-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The notification handling in ynl is currently very simple, using sleep()
to wait a period of time and then handling all the buffered messages in
a single batch.

This patch adds async notification handling so that messages can be
processed as they are received. This makes it possible to use ynl as a
library that supplies notifications in a timely manner.

- Add poll_ntf() to be a generator that yields 1 notification at a
  time and blocks until a notification is available.
- Add a --duration parameter to the CLI, with --sleep as an alias.

./tools/net/ynl/cli.py \
    --spec <SPEC> --subscribe <TOPIC> [ --duration <SECS> ]

The cli will report any notifications for duration seconds and then
exit. If duration is not specified, then it will poll forever, until
interrupted.

Here is an example python snippet that shows how to use ynl as a library
for receiving notifications:

    ynl = YnlFamily(f"{dir}/rt_route.yaml")
    ynl.ntf_subscribe('rtnlgrp-ipv4-route')

    for event in ynl.poll_ntf():
        handle(event)

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 tools/net/ynl/cli.py     | 16 +++++++++-------
 tools/net/ynl/lib/ynl.py | 28 +++++++++++++++++++++++++---
 2 files changed, 34 insertions(+), 10 deletions(-)

diff --git a/tools/net/ynl/cli.py b/tools/net/ynl/cli.py
index b8481f401376..0601fcc53601 100755
--- a/tools/net/ynl/cli.py
+++ b/tools/net/ynl/cli.py
@@ -4,7 +4,6 @@
 import argparse
 import json
 import pprint
-import time
 
 from lib import YnlFamily, Netlink, NlError
 
@@ -43,7 +42,10 @@ def main():
     group.add_argument('--list-ops', action='store_true')
     group.add_argument('--list-msgs', action='store_true')
 
-    parser.add_argument('--sleep', dest='sleep', type=int)
+    parser.add_argument('--duration', dest='duration', type=int,
+                        help='when subscribed, watch for DURATION seconds')
+    parser.add_argument('--sleep', dest='duration', type=int,
+                        help='alias for duration')
     parser.add_argument('--subscribe', dest='ntf', type=str)
     parser.add_argument('--replace', dest='flags', action='append_const',
                         const=Netlink.NLM_F_REPLACE)
@@ -80,9 +82,6 @@ def main():
     if args.ntf:
         ynl.ntf_subscribe(args.ntf)
 
-    if args.sleep:
-        time.sleep(args.sleep)
-
     if args.list_ops:
         for op_name, op in ynl.ops.items():
             print(op_name, " [", ", ".join(op.modes), "]")
@@ -106,8 +105,11 @@ def main():
         exit(1)
 
     if args.ntf:
-        ynl.check_ntf()
-        output(ynl.async_msg_queue)
+        try:
+            for msg in ynl.poll_ntf(duration=args.duration):
+                output(msg)
+        except KeyboardInterrupt:
+            pass
 
 
 if __name__ == "__main__":
diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
index c22c22bf2cb7..01ec01a90e76 100644
--- a/tools/net/ynl/lib/ynl.py
+++ b/tools/net/ynl/lib/ynl.py
@@ -12,6 +12,9 @@ import sys
 import yaml
 import ipaddress
 import uuid
+import queue
+import selectors
+import time
 
 from .nlspec import SpecFamily
 
@@ -489,7 +492,7 @@ class YnlFamily(SpecFamily):
         self.sock.setsockopt(Netlink.SOL_NETLINK, Netlink.NETLINK_GET_STRICT_CHK, 1)
 
         self.async_msg_ids = set()
-        self.async_msg_queue = []
+        self.async_msg_queue = queue.Queue()
 
         for msg in self.msgs.values():
             if msg.is_async:
@@ -903,7 +906,7 @@ class YnlFamily(SpecFamily):
 
         msg['name'] = op['name']
         msg['msg'] = attrs
-        self.async_msg_queue.append(msg)
+        self.async_msg_queue.put(msg)
 
     def check_ntf(self):
         while True:
@@ -925,11 +928,30 @@ class YnlFamily(SpecFamily):
 
                 decoded = self.nlproto.decode(self, nl_msg, None)
                 if decoded.cmd() not in self.async_msg_ids:
-                    print("Unexpected msg id done while checking for ntf", decoded)
+                    print("Unexpected msg id while checking for ntf", decoded)
                     continue
 
                 self.handle_ntf(decoded)
 
+    def poll_ntf(self, duration=None):
+        start_time = time.time()
+        selector = selectors.DefaultSelector()
+        selector.register(self.sock, selectors.EVENT_READ)
+
+        while True:
+            try:
+                yield self.async_msg_queue.get_nowait()
+            except queue.Empty:
+                if duration is not None:
+                    timeout = start_time + duration - time.time()
+                    if timeout <= 0:
+                        return
+                else:
+                    timeout = None
+                events = selector.select(timeout)
+                if events:
+                    self.check_ntf()
+
     def operation_do_attributes(self, name):
       """
       For a given operation name, find and return a supported
-- 
2.47.0


