Return-Path: <netdev+bounces-144060-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE989C584A
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 13:51:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21D27B288F6
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 11:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF9421948D;
	Tue, 12 Nov 2024 11:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T1olZ8tA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30224218D93
	for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 11:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731410260; cv=none; b=RAWpGzR9Nxea5ffFeo4YikI71hCg+KnQrvMMm1RvlGYrVWp7CJS+uhORm/uZ4vBZBDPh6RJKFtg7nou5mEeUVCFrRDRb6sCYXLmkadyhhK3cql0AzlRWmdRafix7WeW7FQG9QDSc1eYUrv4DOh+ITTowYAWuTNxZJCmtMTnH6vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731410260; c=relaxed/simple;
	bh=Gxojs+r3yLJvy+VKhHr7QoFeI3xt1LpaF00PFbC6RVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HtVITeymN0d23o4WjWlqQHAPpV/D96wgxXhoNy5Ho/uIdKwmaqprKKO/YvJT/onO5yoY/RGKyvQIJ3yns2DYniuufHfeIYk/mgAm8UsqOt8JrSVZlUG/xK9EThHjIaHIab0PfVXWNMILMenNuKxRoAry+l4SI1KlQQsfcSDFvxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T1olZ8tA; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-539f4d8ef84so6951214e87.0
        for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 03:17:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731410256; x=1732015056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KQVfeZc6NJ075HA3ZdT+0D/cjgvXW3jWBY5YdxUCC+w=;
        b=T1olZ8tA78lso4qY2bKROdCeK0YGYL1qg8eozLwJxnI0XmhSpdx8xw0V4IpYcoDGCA
         LnTpdQo2MfTlcsRJyvH/IUYDLpC4GgqOEj2dt0F5CSpX1qzdPLMMsbACE3DThvNxyFAj
         At2S47CzO8/2uy5VZvmK+Dd0NfB6CTUHOXl6iybQft/2bhpB7yC1dUJH8xaJa3Gtc6lu
         4Z1PZaXpetGv/ipfDXrlCk7SFPbrVuVFjRJlL7/+yW7HodaBI9/ijr1u9NhQbQDO5ZLL
         r4sOpjDTE4ScA4Zs48zj0sjsDXO6P8oIJX4cM0U0w2n2rfN1VVK5Z+E2h3fgzW+jrFMh
         uuXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731410256; x=1732015056;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KQVfeZc6NJ075HA3ZdT+0D/cjgvXW3jWBY5YdxUCC+w=;
        b=m+FLMZAHdBjz6WrCDbJARLoAKH+FMLfBux9oTptmM4HT+Xr8uUXIsiWDGKEETuzdTL
         SeWeIta+Hs0tdnI0EXRpA9IPb/gcA/otgsGQAP3HjXITK8WyQXhL75Tt/1ar8DbSKm38
         85WdSd60yTyDjVOi2ItfyrjLC8JTLMLWcNSFXnW9JlNFt4tBkc0JI6Hlv+VL7JXgi6YK
         l5NIg/ozuGTaEQYOfyyxtg36UPZPIfUQpgff2+5CqXCqxz84ByWYy2cLWoA//NREv5XE
         i52MZiUigw1IstN5cJCNmz+E4wAzkaVmIXiNJIPTyQf0m2mPOmKcA66BZXeVrUHLWXwe
         6aFw==
X-Gm-Message-State: AOJu0YzCXVm2JeSOUMbTYD+aFy8+SWatkC/UUZMhqZm4nO6+CQWL8PNU
	8s/t3kCn6o51SpONTExBhaRzYh9vFp+q4kqZjBXyMSxYeX5OjL+Ndl9SluXU
X-Google-Smtp-Source: AGHT+IEjGpKgmreHst5YJ5zx59jBB4wzD7My11iaMb6THS3IqFmmUrLyi04LhrGq05XowPBuD7lrHQ==
X-Received: by 2002:a05:6512:104f:b0:539:f36c:dbac with SMTP id 2adb3069b0e04-53d86228009mr7501022e87.4.1731410255502;
        Tue, 12 Nov 2024 03:17:35 -0800 (PST)
Received: from imac.lan ([2a02:8010:60a0:0:a1ef:92f5:9114:b131])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432b054b3fesm203543685e9.17.2024.11.12.03.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 03:17:34 -0800 (PST)
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
Subject: [PATCH net-next v2 2/2] tools/net/ynl: add async notification handling
Date: Tue, 12 Nov 2024 11:17:27 +0000
Message-ID: <20241112111727.91575-3-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241112111727.91575-1-donald.hunter@gmail.com>
References: <20241112111727.91575-1-donald.hunter@gmail.com>
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
index c22c22bf2cb7..ffb1c4263d09 100644
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
+        endtime = time.time() + duration if duration is not None else None
+        selector = selectors.DefaultSelector()
+        selector.register(self.sock, selectors.EVENT_READ)
+
+        while True:
+            try:
+                yield self.async_msg_queue.get_nowait()
+            except queue.Empty:
+                if endtime is not None:
+                    interval = endtime - time.time()
+                    if interval <= 0:
+                        return
+                else:
+                    interval = None
+                events = selector.select(interval)
+                if events:
+                    self.check_ntf()
+
     def operation_do_attributes(self, name):
       """
       For a given operation name, find and return a supported
-- 
2.47.0


